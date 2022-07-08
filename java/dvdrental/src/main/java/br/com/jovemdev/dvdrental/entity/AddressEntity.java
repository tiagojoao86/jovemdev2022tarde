package br.com.jovemdev.dvdrental.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@Getter
@Entity
@Table(name = "address")
public class AddressEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "address_seq_generator")
    @SequenceGenerator(name = "address_seq_generator",
            sequenceName = "address_address_id_seq",
            allocationSize = 1)
    @Column(name = "address_id")
    private Long id;

    private String address;
    private String address2;
    private String district;

    @Column(name = "city_id")
    private Long cityId;

    @Column(name = "postal_code")
    private String postalCode;

    private String phone;

    @Column(name = "last_update", insertable = false)
    private LocalDateTime data;

    @JsonIgnore
    @OneToMany(mappedBy = "addressEntity")
    private List<StaffEntity> staffs;


    public AddressEntity(Long id, String address, String address2, String district,
                         Long cityId, String postalCode, String phone,
                         LocalDateTime data) {
        this.id = id;
        this.address = address;
        this.address2 = address2;
        this.district = district;
        this.cityId = cityId;
        this.postalCode = postalCode;
        this.phone = phone;
        this.data = data;
    }
}
