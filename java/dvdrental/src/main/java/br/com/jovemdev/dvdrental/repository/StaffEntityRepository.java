package br.com.jovemdev.dvdrental.repository;

import br.com.jovemdev.dvdrental.entity.StaffEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffEntityRepository extends JpaRepository<StaffEntity, Long>, StaffEntityRepositoryCustom {
    List<StaffEntity> findByFirstName(String name);

    @Query(value = "SELECT * FROM staff WHERE first_name ilike '%' || ?1 || '%'", nativeQuery = true)
    List<StaffEntity> buscaPeloPrimeiroNome(String name);

    @Query(value = "SELECT s FROM StaffEntity s WHERE lower(s.firstName) like concat('%', lower(?1), '%')")
    List<StaffEntity> buscaPeloPrimeiroNomeJPQL(String name);
}
