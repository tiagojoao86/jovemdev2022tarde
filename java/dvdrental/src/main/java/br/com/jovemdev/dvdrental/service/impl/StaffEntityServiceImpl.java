package br.com.jovemdev.dvdrental.service.impl;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import br.com.jovemdev.dvdrental.repository.StaffEntityRepository;
import br.com.jovemdev.dvdrental.service.StaffEntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StaffEntityServiceImpl implements StaffEntityService {

    @Autowired
    private StaffEntityRepository repository;

    @Override
    public StaffEntity findById(Long id) {
        Optional<StaffEntity> opt = repository.findById(id);

        return opt.orElseGet(null);
    }

    @Override
    public List<StaffEntity> findAll() {
        return repository.findAll();
    }

    @Override
    public StaffEntity save(StaffEntity staffEntity) {
        return repository.save(staffEntity);
    }

    @Override
    public List<StaffEntity> findByFirstNameContains(String name) {
        //return repository.findByFirstNameContains(name);
        //return repository.buscaPeloPrimeiroNome(name);
        return repository.buscaPeloPrimeiroNomeJPQL(name);
    }
}
