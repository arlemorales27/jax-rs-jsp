package org.arle.resource;

import jakarta.ws.rs.core.Response;
import org.arle.model.Usuario;
import org.arle.service.UsuarioService;
import org.jboss.resteasy.core.ResteasyDeploymentImpl;
import org.jboss.resteasy.spi.ResteasyDeployment;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class UsuarioResourceTest {

    private static ResteasyDeployment deployment;
    private UsuarioService usuarioService;
    private UsuarioResource usuarioResource;
    private Usuario usuario;

    @BeforeAll
    static void setUpClass() {
        deployment = new ResteasyDeploymentImpl();
        deployment.start();
    }

    @BeforeEach
    void setUp() {
        usuarioService = Mockito.mock(UsuarioService.class);
        usuarioResource = new UsuarioResource();
        usuarioResource.setService(usuarioService);

        usuario = new Usuario();
        usuario.setId(1L);
        usuario.setNombre("Test User");
        usuario.setEmail("test@test.com");
        usuario.setTelefono("123456789");
    }

    @Test
    @DisplayName("GET /usuarios - Debería retornar lista de usuarios")
    void getAllUsers_ShouldReturnUsersList() {
        // Arrange
        when(usuarioService.findAll()).thenReturn(Arrays.asList(usuario));

        // Act
        Response response = usuarioResource.getAll();

        // Assert
        assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
        assertNotNull(response.getEntity());
        verify(usuarioService).findAll();
    }

    @Test
    @DisplayName("GET /usuarios/{id} - Debería retornar usuario cuando existe")
    void getById_ShouldReturnUser_WhenUserExists() {
        // Arrange
        when(usuarioService.findById(1L)).thenReturn(Optional.of(usuario));

        // Act
        Response response = usuarioResource.getById(1L);

        // Assert
        assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
        assertEquals(usuario, response.getEntity());
        verify(usuarioService).findById(1L);
    }

    @Test
    @DisplayName("GET /usuarios/{id} - Debería retornar 404 cuando no existe")
    void getById_ShouldReturn404_WhenUserDoesNotExist() {
        // Arrange
        when(usuarioService.findById(999L)).thenReturn(Optional.empty());

        // Act
        Response response = usuarioResource.getById(999L);

        // Assert
        assertEquals(Response.Status.NOT_FOUND.getStatusCode(), response.getStatus());
        verify(usuarioService).findById(999L);
    }

    @Test
    @DisplayName("POST /usuarios - Debería crear nuevo usuario")
    void createUser_ShouldCreateNewUser() {
        // Arrange
        Usuario newUser = new Usuario();
        newUser.setNombre("New User");
        when(usuarioService.save(any(Usuario.class))).thenReturn(usuario);

        // Act
        Response response = usuarioResource.create(newUser);

        // Assert
        assertEquals(Response.Status.CREATED.getStatusCode(), response.getStatus());
        assertNotNull(response.getEntity());
        verify(usuarioService).save(any(Usuario.class));
    }

    @Test
    @DisplayName("PUT /usuarios/{id} - Debería actualizar usuario existente")
    void updateUser_ShouldUpdateExistingUser() {
        // Arrange
        when(usuarioService.update(any(Usuario.class))).thenReturn(true);

        // Act
        Response response = usuarioResource.update(1L, usuario);

        // Assert
        assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
        assertEquals(usuario, response.getEntity());
        verify(usuarioService).update(any(Usuario.class));
    }

    @Test
    @DisplayName("PUT /usuarios/{id} - Debería retornar 404 al actualizar usuario no existente")
    void updateUser_ShouldReturn404_WhenUserDoesNotExist() {
        // Arrange
        when(usuarioService.update(any(Usuario.class))).thenReturn(false);

        // Act
        Response response = usuarioResource.update(999L, usuario);

        // Assert
        assertEquals(Response.Status.NOT_FOUND.getStatusCode(), response.getStatus());
        verify(usuarioService).update(any(Usuario.class));
    }

    @Test
    @DisplayName("DELETE /usuarios/{id} - Debería eliminar usuario existente")
    void deleteUser_ShouldDeleteExistingUser() {
        // Arrange
        when(usuarioService.delete(1L)).thenReturn(true);

        // Act
        Response response = usuarioResource.delete(1L);

        // Assert
        assertEquals(Response.Status.NO_CONTENT.getStatusCode(), response.getStatus());
        verify(usuarioService).delete(1L);
    }

    @Test
    @DisplayName("DELETE /usuarios/{id} - Debería retornar 404 al eliminar usuario no existente")
    void deleteUser_ShouldReturn404_WhenUserDoesNotExist() {
        // Arrange
        when(usuarioService.delete(999L)).thenReturn(false);

        // Act
        Response response = usuarioResource.delete(999L);

        // Assert
        assertEquals(Response.Status.NOT_FOUND.getStatusCode(), response.getStatus());
        verify(usuarioService).delete(999L);
    }
}