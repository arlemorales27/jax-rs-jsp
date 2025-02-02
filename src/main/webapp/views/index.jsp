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
    <title>Gestión de Usuarios</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-center mb-8">Sistema de Gestión de Usuarios</h1>

    <div class="max-w-md mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl">
        <div class="p-8">
            <div class="flex flex-col space-y-4">
                <a href="${pageContext.request.contextPath}/views/listar.jsp"
                   class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 text-center">
                    Ver Usuarios
                </a>

                <a href="${pageContext.request.contextPath}/views/crear.jsp"
                   class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 text-center">
                    Crear Usuario
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
