<%--
  Created by IntelliJ IDEA.
  User: ArleMorales
  Date: 1/02/25
  Time: 10:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Usuarios</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        .table-cell {
            padding: 8px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<div class="container mx-auto p-4">
    <div class="flex justify-between items-center mb-4">
        <h1 class="text-2xl">Lista de Usuarios</h1>
        <a href="${pageContext.request.contextPath}/views/crear.jsp"
           class="bg-green-500 text-white px-4 py-2 rounded">
            Nuevo Usuario
        </a>
    </div>

    <table id="usuariosTable" class="w-full border-collapse border">
        <thead>
        <tr>
            <th class="table-cell">ID</th>
            <th class="table-cell">NOMBRE</th>
            <th class="table-cell">EMAIL</th>
            <th class="table-cell">TELÉFONO</th>
            <th class="table-cell">ACCIONES</th>
        </tr>
        </thead>
        <tbody id="usuariosTableBody"></tbody>
    </table>
</div>

<script>
    // Función para renderizar un usuario
    function renderizarUsuario(usuario) {
        const row = document.createElement('tr');

        // Crear celdas individuales
        const idCell = document.createElement('td');
        idCell.className = 'table-cell';
        idCell.textContent = usuario.id;
        row.appendChild(idCell);

        const nombreCell = document.createElement('td');
        nombreCell.className = 'table-cell';
        nombreCell.textContent = usuario.nombre;
        row.appendChild(nombreCell);

        const emailCell = document.createElement('td');
        emailCell.className = 'table-cell';
        emailCell.textContent = usuario.email;
        row.appendChild(emailCell);

        const telefonoCell = document.createElement('td');
        telefonoCell.className = 'table-cell';
        telefonoCell.textContent = usuario.telefono;
        row.appendChild(telefonoCell);

        const accionesCell = document.createElement('td');
        accionesCell.className = 'table-cell';

        // Botón Editar
        const editarBtn = document.createElement('button');
        editarBtn.textContent = 'Editar';
        editarBtn.className = 'bg-blue-500 text-white px-2 py-1 rounded mr-2';
        editarBtn.addEventListener('click', () => editarUsuario(usuario.id));

        // Botón Eliminar
        const eliminarBtn = document.createElement('button');
        eliminarBtn.textContent = 'Eliminar';
        eliminarBtn.className = 'bg-red-500 text-white px-2 py-1 rounded';
        eliminarBtn.addEventListener('click', () => eliminarUsuario(usuario.id));

        accionesCell.appendChild(editarBtn);
        accionesCell.appendChild(eliminarBtn);
        row.appendChild(accionesCell);

        return row;
    }

    // Función para cargar usuarios
    function cargarUsuarios() {
        const tbody = document.getElementById('usuariosTableBody');
        tbody.innerHTML = ''; // Limpiar tabla

        axios.get('${pageContext.request.contextPath}/api/usuarios')
            .then(response => {
                if (Array.isArray(response.data)) {
                    response.data.forEach(usuario => {
                        try {
                            const fila = renderizarUsuario(usuario);
                            tbody.appendChild(fila);
                        } catch (error) {
                            console.error('Error al renderizar usuario:', usuario, error);
                        }
                    });
                } else {
                    console.error('La respuesta no es un array:', response.data);
                }
            })
            .catch(error => {
                console.error('Error al cargar usuarios:', error);
                tbody.innerHTML = `
                        <tr>
                            <td colspan="5" class="table-cell text-red-500 text-center">
                                Error al cargar los usuarios: ${error.message}
                            </td>
                        </tr>
                    `;
            });
    }

    // Función para editar usuario
    function editarUsuario(id) {
        window.location.href = '${pageContext.request.contextPath}/views/editar.jsp?id=' + id;
    }

    // Función para eliminar usuario
    function eliminarUsuario(id) {
        if (confirm('¿Está seguro de eliminar este usuario?')) {
            axios.delete('${pageContext.request.contextPath}/api/usuarios/' + id)
                .then(() => {
                    alert('Usuario eliminado correctamente');
                    cargarUsuarios(); // Recargar la lista
                })
                .catch(error => {
                    console.error('Error al eliminar:', error);
                    alert('Error al eliminar el usuario');
                });
        }
    }

    // Cargar usuarios cuando la página esté lista
    document.addEventListener('DOMContentLoaded', cargarUsuarios);
</script>
</body>
</html>

