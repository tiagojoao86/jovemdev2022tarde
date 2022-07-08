package br.com.jovemdev.dvdrental.controller;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import br.com.jovemdev.dvdrental.service.StaffEntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/staff")
public class StaffEntityController {

    @Autowired
    private StaffEntityService service;

    @GetMapping("/listar")
    public List<StaffEntity> listar() {
        return service.findAll();
    }

    @GetMapping("{id}")
    public StaffEntity buscarPorId(@PathVariable Long id) {
        return service.findById(id);
    }

    @PostMapping()
    public StaffEntity salvar(@RequestBody StaffEntity staffEntity) {
        return service.save(staffEntity);
    }

    @GetMapping("/name/{name}")
    public List<StaffEntity> findByFirstNameContains(@PathVariable String name) {
        return service.findByFirstNameContains(name);
    }
}
