<%--
  Created by IntelliJ IDEA.
  User: ArleMorales
  Date: 1/02/25
  Time: 10:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        .table-cell {
            padding: 8px;
            border: 1px solid #ddd;
        }
        .form-input {
            width: 100%;
            padding: 8px;
            margin: 4px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="container mx-auto p-4">
    <h1 class="text-2xl mb-4">Editar Usuario</h1>
    <div class="max-w-md mx-auto bg-white p-6 rounded shadow-md">
        <form id="editarForm">
            <div class="mb-4">
                <label class="block mb-2">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-input" required>
            </div>

            <div class="mb-4">
                <label class="block mb-2">Email</label>
                <input type="email" id="email" name="email" class="form-input" required>
            </div>

            <div class="mb-4">
                <label class="block mb-2">Teléfono</label>
                <input type="tel" id="telefono" name="telefono" class="form-input" required>
            </div>

            <div class="flex gap-4">
                <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">
                    Actualizar
                </button>
                <a href="listar.jsp" class="bg-gray-500 text-white px-4 py-2 rounded">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    function cargarUsuario() {
        const urlParams = new URLSearchParams(window.location.search);
        const userId = urlParams.get('id');

        // Similar al método de listar, hacemos una petición directa al endpoint
        axios.get('/proyectojax-1.0-SNAPSHOT/api/usuarios/' + userId)
            .then(function(response) {
                const usuario = response.data;
                document.getElementById('nombre').value = usuario.nombre;
                document.getElementById('email').value = usuario.email;
                document.getElementById('telefono').value = usuario.telefono;
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('Error al cargar los datos del usuario');
            });
    }

    document.getElementById('editarForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const urlParams = new URLSearchParams(window.location.search);
        const userId = urlParams.get('id');

        const usuario = {
            id: userId,
            nombre: document.getElementById('nombre').value,
            email: document.getElementById('email').value,
            telefono: document.getElementById('telefono').value
        };

        axios.put('/proyectojax-1.0-SNAPSHOT/api/usuarios/' + userId, usuario)
            .then(function(response) {
                alert('Usuario actualizado con éxito');
                window.location.href = 'listar.jsp';
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('Error al actualizar el usuario');
            });
    });

    // Cargar datos al iniciar
    document.addEventListener('DOMContentLoaded', cargarUsuario);
</script>
</body>
</html>