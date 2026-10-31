@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Table Functions - Airports'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_tf_airport_tnd
  with parameters
    pCity : /dmo/city
  as select from /dmo/customer                              as Customer
    inner join   ztf_airports_tnd(pCity: $parameters.pCity) as Airports on Airports.city = Customer.city
{
  key Airports.airport_id,
      Airports.name,
      Airports.city,
      Customer.first_name,
      Airports.country
}
