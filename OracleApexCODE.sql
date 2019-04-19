DROP TABLE p_priority_listing CASCADE CONSTRAINTS;
DROP TABLE p_repair_request CASCADE CONSTRAINTS;
DROP TABLE p_maintenance_personnel CASCADE CONSTRAINTS;
DROP TABLE p_component_inventory CASCADE CONSTRAINTS;
DROP TABLE p_supplier CASCADE CONSTRAINTS;
DROP TABLE p_star_system CASCADE CONSTRAINTS;
DROP TABLE p_starship_component CASCADE CONSTRAINTS;
DROP TABLE starbase CASCADE CONSTRAINTS;
DROP TABLE p_personnel CASCADE CONSTRAINTS;
DROP TABLE starship CASCADE CONSTRAINTS;
-- create tables
create table p_personnel (
    personnel_id                   number not null constraint p_personnel_personnel_id_pk primary key,
    name                           varchar2(255),
    shipno                         varchar2(4000),
    rank                           varchar2(4000),
    species                        varchar2(4000),
    dob                            varchar2(4000)
)
;

create table p_starship (
    shipno                         number not null constraint p_starship_shipno_pk primary key,
    shipname                       varchar2(255),
    shipclass                      varchar2(4000),
    firstcommission                varchar2(4000),
    maintenance_due                date,
    last_known_location            varchar2(4000)
)
;

create table p_starbase (
    starbasename                   number not null constraint p_starbase_starbasename_pk primary key,
    spatial_coordinate             varchar2(4000),
    quadrant                       varchar2(4000),
    starbase_type                  varchar2(4000)
)
;

create table p_repairrequest (
    repairreq_id                   number not null constraint p_repairrequest_repairreq_i_pk primary key,
    starbasename                   number
                                   constraint p_repairrequest_starbasenam_fk
                                   references p_starbase(starbasename) on delete cascade not null,
    personnel_id                   number
                                   constraint p_repairrequest_personnel_i_fk
                                   references p_personnel(personnel_id) on delete cascade not null,
    shipno                         number
                                   constraint p_repairrequest_shipno_fk
                                   references p_starship(shipno) on delete cascade not null,
    description_of_work_requested  varchar2(4000),
    date_of_request                date
)
;


-- create tables
create table p_maintenance_personnel (
    maintenance_id                 number not null constraint p_maintenance_maintenance_i_pk primary key,
    name                           varchar2(255),
    planet                         varchar2(4000),
    expertise                      varchar2(4000)
)
;

create table p_starship_component (
    componentname                  varchar2(255),
    component_id                   number not null constraint p_starship_comp_component_i_pk primary key,
    priority_id                    number
                                   not null,
    serial                         number,
    date_commissioned              date,
    component_description          varchar2(4000)
)
;

create table p_priority_listing (
    priority_id                    number not null constraint p_priority_list_priority_id_pk primary key,
    status                         varchar2(60),
    repair_request_id              number
                                   constraint p_priority_li_repair_reques_fk
                                   references p_repairrequest(repairreq_id) on delete cascade not null,
    component_id                   number
                                   constraint p_priority_list_component_i_fk
                                   references p_starship_component(component_id) on delete cascade not null,
    maintenance_id                 number
                                   constraint p_priority_li_maintenance_i_fk
                                   references p_maintenance_personnel(maintenance_id) on delete cascade not null,
    starship_componentcomp         varchar2(4000)
)
;



-- create tables
create table p_star_system (
    star_sys_id                    number not null constraint p_star_system_star_sys_id_pk primary key,
    star_name                      varchar2(255),
    quadrant                       varchar2(4000)
)
;

create table p_supplier (
    supplier_id                    number not null constraint p_supplier_supplier_id_pk primary key,
    name                           varchar2(255),
    planet                         varchar2(4000),
    star_sys_id                    number
                                   constraint p_supplier_star_sys_id_fk
                                   references p_star_system(star_sys_id) on delete cascade not null
)
;

create table p_component_inventory (
    inventory_id                   number not null constraint p_component_inv_inventory_i_pk primary key,
    supplier_id                    number
                                   constraint p_component_inv_supplier_id_fk
                                   references p_supplier(supplier_id) on delete cascade not null,
    component_id                   number
                                   constraint p_component_inv_component_i_fk
                                   references p_starship_component(component_id) on delete cascade not null,
    quantity                       varchar2(4000)
)
;
