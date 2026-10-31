@EndUserText.label: 'Table Functions - Airports'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm:#SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
define table function ztf_airports_tnd
  with parameters   
//    @Environment.systemField: #CLIENT
//    pClient : abap.clnt,
    pCity   : /dmo/city
returns
{
  key client     : abap.clnt;
  key airport_id : /dmo/airport_id;
      name       : /dmo/airport_name;
      city       : /dmo/city;
      country    : land1;
}
implemented by method
  zcl_amdp_airport_tnd=>get_flights;