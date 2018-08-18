#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'wikidata/area'

query = 'SELECT DISTINCT ?item WHERE { ?item wdt:P31/wdt:P279* wd:Q17202187 }'

ids = EveryPolitician::Wikidata.sparql(query)
raise 'No ids' if ids.empty?

data = Wikidata::Areas.new(ids: ids).data

ScraperWiki.sqliteexecute('DELETE FROM data') rescue nil
ScraperWiki.save_sqlite(%i(id), data)
