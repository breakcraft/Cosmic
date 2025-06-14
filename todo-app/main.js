'use strict';
document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('todo-form');
    const input = document.getElementById('todo-input');
    const list = document.getElementById('todo-list');
    const filters = document.querySelectorAll('.filters button');
    const clearBtn = document.getElementById('clear-completed');
    const clearAllBtn = document.getElementById('clear-all');
    const counter = document.getElementById('todo-count');

    let todos = JSON.parse(localStorage.getItem('todos') || '[]');
    let currentFilter = localStorage.getItem('filter') || 'all';

    const save = () => {
        localStorage.setItem('todos', JSON.stringify(todos));
    };

    const render = () => {
        list.innerHTML = '';
        todos
            .filter(t => currentFilter === 'all' || (currentFilter === 'active' && !t.done) || (currentFilter === 'completed' && t.done))
            .forEach((t, idx) => {
                const li = document.createElement('li');
                if (t.done) li.classList.add('completed');
                const span = document.createElement('span');
                span.textContent = t.text;
                span.onclick = () => {
                    todos[idx].done = !todos[idx].done;
                    save();
                    render();
                };
                const edit = document.createElement('button');
                edit.textContent = '✎';
                edit.onclick = () => {
                    li.classList.add('editing');
                    const newText = prompt('Edit task', todos[idx].text);
                    li.classList.remove('editing');
                    if (newText !== null && newText.trim() !== '') {
                        todos[idx].text = newText.trim();
                        save();
                        render();
                    }
                };
                const del = document.createElement('button');
                del.textContent = '✖';
                del.onclick = () => {
                    todos.splice(idx, 1);
                    save();
                    render();
                };
                li.appendChild(span);
                li.appendChild(edit);
                li.appendChild(del);
                list.appendChild(li);
            });
        const remaining = todos.filter(t => !t.done).length;
        const percent = todos.length === 0 ? 0 : Math.round((todos.length - remaining) / todos.length * 100);
        counter.textContent = `${remaining} item${remaining === 1 ? '' : 's'} left (${percent}% done)`;
    };

    form.addEventListener('submit', e => {
        e.preventDefault();
        const text = input.value.trim();
        if (text) {
            todos.push({ text, done: false });
            input.value = '';
            save();
            render();
        }
    });

    input.addEventListener('keydown', e => {
        if (e.key === 'Enter') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        } else if (e.key === 'Escape') {
            input.value = '';
        }
    });

    filters.forEach(btn => {
        if (btn.dataset.filter === currentFilter) {
            btn.classList.add('active');
        }
        btn.addEventListener('click', () => {
            filters.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentFilter = btn.dataset.filter;
            localStorage.setItem('filter', currentFilter);
            render();
        });
    });

    clearBtn.addEventListener('click', () => {
        todos = todos.filter(t => !t.done);
        save();
        render();
    });

    clearAllBtn.addEventListener('click', () => {
        todos = [];
        save();
        render();
    });
    render();
});
