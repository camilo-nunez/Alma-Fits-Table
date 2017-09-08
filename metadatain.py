#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
from os.path import join
import psycopg2
from gavo.grammars.customgrammar import CustomRowIterator

query="""SELECT distinct
coordinate_information.obsra AS s_ra,
coordinate_information.obsdec AS s_dec,
coordinate_information.specsys AS specsys,
coordinate_information.restfrq AS restfrq,
coordinate_information.radesys AS radesys,
fits_files_main.name_file AS name_file,
pipeline_archive_request_information.object_i AS target_name,
pipeline_archive_request_information.group_i AS gous,
pipeline_archive_request_information.member AS mous,
primary_hdu.naxis AS naxis,
primary_hdu.naxisn AS naxisn,
telescope_data_asquisition_information.telescop AS facility_name,
telescope_data_asquisition_information.instrume AS instrument_name,
telescope_data_asquisition_information.obsgeo_x AS obsgeo_x,
telescope_data_asquisition_information.obsgeo_y AS obsgeo_y,
telescope_data_asquisition_information.obsgeo_z AS obsgeo_z,
telescope_data_asquisition_information.lonpole AS lonpole,
telescope_data_asquisition_information.latpole AS latpole,
time_information.date_obs AS date_obs

FROM fits_files_main
INNER JOIN coordinate_information
ON fits_files_main.coordinate_information_id_forean=coordinate_information.id_coordinate_information
INNER JOIN image_beam_properties
ON fits_files_main.image_beam_properties_id_forean=image_beam_properties.id_image_beam_properties
INNER JOIN pipeline_archive_request_information
ON fits_files_main.pipeline_archive_request_information_id_forean=pipeline_archive_request_information.idpipeline_archive_request_information
INNER JOIN primary_hdu
ON fits_files_main.primary_hdu_id_forean=primary_hdu.id_fits_primary_hdu
INNER JOIN proposal_pi_information
ON fits_files_main.proposal_pi_information_id_forean=proposal_pi_information.id_proposal_pi_information
INNER JOIN telescope_data_asquisition_information
ON fits_files_main.telescope_data_asquisition_information_id_forean=telescope_data_asquisition_information.id_telescope_data_asquisition_information
INNER JOIN time_information
ON fits_files_main.time_information_id_forean=time_information.id_time_information
"""



class RowIterator(CustomRowIterator):

	def _iterRows(self):
		db_config = {'host': '*', 'user': '*', 'password': '*', 'dbname': '*'}
		conn = psycopg2.connect(**db_config)
		cursor = conn.cursor()
		cursor.execute(query)
		rows = cursor.fetchall()
		url="http://provider.chivo.cl/confirm?mous=%s"

		for result in rows:
			s_ra,s_dec,specsys,restfrq,radesys,name_file,target_name,gous,mous,naxis,naxisn,facility_name,instrument_name,obsgeo_x,obsgeo_y,obsgeo_z,lonpole,latpole,date_obs =result
			rec={
			's_ra':s_ra,
			's_dec':s_dec,
			'specsys':specsys,
			'restfrq':restfrq,
			'radesys':radesys,
			'name_file':name_file,
			'target_name':target_name,
			'gous':gous,
			'mous':mous,
			'naxis':naxis,
			'naxisn':naxisn,
			'facility_name':facility_name,
			'instrument_name':instrument_name,
			'obsgeo_x':obsgeo_x,
			'obsgeo_y':obsgeo_y,
			'obsgeo_z':obsgeo_z,
			'lonpole':lonpole,
			'latpole':latpole,
			'date_obs':date_obs,
			'access_url':url%(mous),
			}
			yield rec
