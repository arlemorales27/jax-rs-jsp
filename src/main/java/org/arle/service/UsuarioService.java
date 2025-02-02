package org.arle.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.arle.model.Usuario;
import org.arle.repository.UsuarioRepository;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class UsuarioService {

    @Inject
    private UsuarioRepository repository;

    public List<Usuario> findAll() {
        return repository.findAll();
    }

    public Optional<Usuario> findById(Long id) {
        return repository.findById(id);
    }

    public Usuario save(Usuario usuario) {
        return repository.save(usuario);
    }

    public boolean update(Usuario usuario) {
        return repository.update(usuario);
    }

    public boolean delete(Long id) {
        return repository.delete(id);
    }
}
