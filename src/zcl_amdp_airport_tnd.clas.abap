CLASS zcl_amdp_airport_tnd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_airport,
             "   client type abap.clnt,
             airport_id TYPE /dmo/airport_id,
             name       TYPE /dmo/airport_name,
             city       TYPE /dmo/city,
             country    TYPE land1,
           END OF ty_airport,
           ty_airport_t TYPE TABLE OF ty_airport.


    CLASS-METHODS get_flights FOR TABLE FUNCTION ztf_airports_tnd.

    CLASS-METHODS get_airport AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      IMPORTING VALUE(iv_country) TYPE /dmo/airport_id
      EXPORTING VALUE(et_results) TYPE ty_airport_t.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_amdp_airport_tnd IMPLEMENTATION.
  METHOD get_flights BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                                 OPTIONS READ-ONLY
                                 USING /dmo/airport.

    RETURN select a.client,
                  a.airport_id,
                  a.name,
                  a.city,
                  a.country
             from "/DMO/AIRPORT" as a
             where --a.client = pClient
               --and
               a.city = :pCity
             Order By airport_id Desc;

  ENDMETHOD.


  METHOD get_airport BY DATABASE PROCEDURE FOR HDB
                     LANGUAGE SQLSCRIPT
                     OPTIONS READ-ONLY
                     USING /dmo/airport.

    et_results = select top 10
                 airport.airport_id,
                 airport.name,
                 airport.city,
                 airport.country
                 from "/DMO/AIRPORT" as airport
         where airport.country = iv_country;



  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    zcl_amdp_airport_tnd=>get_airport(
      EXPORTING
        iv_country = 'US'
      IMPORTING
        et_results = DATA(et_results) ).


    out->write( et_results ).

  ENDMETHOD.

ENDCLASS.
