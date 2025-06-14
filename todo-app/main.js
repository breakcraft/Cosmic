'use strict';
document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('todo-form');
    const input = document.getElementById('todo-input');
    const list = document.getElementById('todo-list');
    const filters = document.querySelectorAll('.filters button');
    const clearBtn = document.getElementById('clear-completed');

    let todos = JSON.parse(localStorage.getItem('todos') || '[]');
    let currentFilter = 'all';

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
                const del = document.createElement('button');
                del.textContent = '✖';
                del.onclick = () => {
                    todos.splice(idx, 1);
                    save();
                    render();
                };
                li.appendChild(span);
                li.appendChild(del);
                list.appendChild(li);
            });
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

    filters.forEach(btn => {
        btn.addEventListener('click', () => {
            filters.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentFilter = btn.dataset.filter;
            render();
        });
    });

    clearBtn.addEventListener('click', () => {
        todos = todos.filter(t => !t.done);
        save();
        render();
    });

    render();
});
