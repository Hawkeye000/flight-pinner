class SearchesController < ApplicationController
  autocomplete :airline, :name, full:true
  autocomplete :airport, :iata_faa
end
