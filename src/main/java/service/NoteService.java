package service;

import client.Character;
import database.DaoException;
import database.note.NoteDao;
import model.Note;
import net.packet.out.ShowNotesPacket;
import net.server.Server;
import net.server.world.World;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.function.Predicate;

public class NoteService {
    private static final Logger log = LoggerFactory.getLogger(NoteService.class);

    static final int MAX_INBOX_SIZE = 100;

    private final NoteDao noteDao;
    private final Function<String, Integer> characterIdLookup;
    private final Predicate<String> onlineCheck;

    public NoteService(NoteDao noteDao) {
        this(noteDao, client.Character::getIdByName, NoteService::isOnline);
    }

    public NoteService(NoteDao noteDao, Function<String, Integer> characterIdLookup,
                       Predicate<String> onlineCheck) {
        this.noteDao = noteDao;
        this.characterIdLookup = characterIdLookup;
        this.onlineCheck = onlineCheck;
    }

    private static boolean isOnline(String name) {
        for (World world : Server.getInstance().getWorlds()) {
            if (world.getPlayerStorage().getCharacterByName(name) != null) {
                return true;
            }
        }
        return false;
    }

    /**
     * Send normal note from one character to another
     *
     * @return Send success
     */
    public NoteSendResult sendNormal(String message, String senderName, String receiverName) {
        Note normalNote = Note.createNormal(message, senderName, receiverName, Server.getInstance().getCurrentTime());
        return send(normalNote);
    }

    /**
     * Send note which will increase the receiver's fame by one.
     *
     * @return Send success
     */
    public NoteSendResult sendWithFame(String message, String senderName, String receiverName) {
        Note noteWithFame = Note.createGift(message, senderName, receiverName, Server.getInstance().getCurrentTime());
        return send(noteWithFame);
    }

    private NoteSendResult send(Note note) {
        try {
            if (onlineCheck.test(note.to())) {
                return NoteSendResult.PLAYER_ONLINE;
            }

            int id = characterIdLookup.apply(note.to());
            if (id < 0) {
                return NoteSendResult.INVALID_PLAYER_NAME;
            }

            if (noteDao.findAllByTo(note.to()).size() >= MAX_INBOX_SIZE) {
                return NoteSendResult.INBOX_FULL;
            }

            noteDao.save(note);
            return NoteSendResult.SUCCESS;
        } catch (DaoException e) {
            log.error("Failed to send note {}", note, e);
            return NoteSendResult.FAILED;
        }
    }

    /**
     * Show unread notes
     *
     * @param chr Note recipient
     */
    public void show(Character chr) {
        if (chr == null) {
            throw new IllegalArgumentException("Unable to show notes - chr is null");
        }

        List<Note> notes = getNotes(chr.getName());
        if (notes.isEmpty()) {
            return;
        }

        chr.sendPacket(new ShowNotesPacket(notes));
    }

    private List<Note> getNotes(String to) {
        final List<Note> notes;
        try {
            notes = noteDao.findAllByTo(to);
        } catch (DaoException e) {
            log.error("Failed to find notes sent to chr name {}", to, e);
            return Collections.emptyList();
        }

        if (notes == null || notes.isEmpty()) {
            return Collections.emptyList();
        }

        return notes;
    }

    /**
     * Delete a read note
     *
     * @param noteId Id of note to discard
     * @return Discarded note. Empty optional if failed to discard.
     */
    public Optional<Note> delete(int noteId) {
        try {
            return noteDao.delete(noteId);
        } catch (DaoException e) {
            log.error("Failed to discard note with id {}", noteId, e);
            return Optional.empty();
        }
    }

}
