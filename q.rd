<?xml version="1.0" encoding="iso-8859-1"?>
<resource schema="alma_fits">
	<meta name="title">ChiVO Data Provider for ALMA FITS</meta>
	<meta name="creationDate">2017-06-05T18:01:00Z</meta>
	<meta name="description" format="plain">
		The resource contains the recommendations and requirements for ALMA FITS products of the Inter-ARC ALMA Science Archive Working Group (ASAWG) with the view to including a metadataset that is complete and easily accessible by the ChiVO Data Provider (CDP). 
	</meta>
	<meta name="copyright">MIT License.</meta>
	<meta name="creator.name">ChiVO Team</meta>
	<meta name="subject">Millimiter/submillimiter Astronomy</meta>
	<meta name="facility">ALMA OSF</meta>

	<table id="alma_fits" onDisk="True" adql="True" >	

		<!--FORM SCP-->
		<mixin>
			//scs#q3cindex
		</mixin>

		<!--FORM SIAP-->
		<mixin
			calibLevel="3"
			collectionName="'ALMA FITS'"
			dec="s_dec"
			ra="s_ra"
			oUCD="'phot.flux.density.sb'"
			facilityName="'ALMA'"
			instrumentName="'ALMA'"	>
			//obscore#publishSIAP
		</mixin>
		<mixin>
			//siap#pgs
		</mixin>

		<!--DESCRIPTION-->
		<meta name="description">
		The resource contains the recommendations and requirements for ALMA FITS products of the Inter-ARC ALMA Science Archive Working Group (ASAWG) with the view to including a metadataset that is complete and easily accessible by the ChiVO Data Provider (CDP) and ALMA Archives. 
		</meta>

		<!--COLUMNS-->

		<column name="target_name" type="text"
		description="Name for source observed."
		tablehead="Target Name"
		ucd="meta.target_name;meta.main"
		verbLevel="10">
		</column>

		<column name="file_name" type="text"
		description="Name of the file FITS."
		tablehead="Name File"
		ucd="meta.file_name;meta.main"
		verbLevel="10">
		</column>

		<column name="access_url" type="text"
			tablehead="URL Download."
			displayHint="type=url"
			ucd="meta.ref.url;meta.file" 
			verbLevel="1" 
			description="URL of the data file."/>

		<column name="naxis" type="real"
		description="Number of axes in the associated data array."
		tablehead="NAXIS"
		ucd="meta.naxis;meta.main"
		verbLevel="10">
		</column>

		<column name="naxisn" type="text"
		description="Number of elements along axis n of a data array (n = 1-NAXIS). ASA data must have four NAXIS terms."
		tablehead="NAXISn"
		ucd="meta.naxisn;meta.main"
		verbLevel="10">
		</column>

		<column name="date_obs" type="text"
		description="Observation start time."
		tablehead="DATE-OBS"
		ucd="meta.date_obs;meta.main"
		verbLevel="10">
		</column>

		<column name="s_ra" type="real"
		ucd="pos.eq.ra;meta.main"
		tablehead="RA"
		description="The Right Ascension coordinate of image center, in the system specified in EQUINOX and RADESYS."
		verbLevel="10"/>

		<column name="s_dec" type="real"
		ucd="pos.eq.dec;meta.main"
		tablehead="DEC"
		description="The Declination coordinate of image center, in the in the system specified in EQUINOX and RADESYS."
		verbLevel="10"/>

		<column name="specsys" type="text"
		ucd="pos.eq.specsys;meta.main"
		tablehead="SPECSYS"
		description="Reference frame for freq axis."
		verbLevel="10"/>

		<column name="radesys" type="text"
		ucd="pos.eq.radesys;meta.main"
		tablehead="RADESYS"
		description="Name of the reference frame of equatorial or ecliptic coordinates."
		verbLevel="10"/>

		<column name="restfrq" type="real"
		ucd="pos.eq.restfrq;meta.main"
		tablehead="RESTFRQ"
		description="Contingent on the type of measurements being made: 
		For transition line measurements: the rest frequency of the of the spectral feature of interest in Hz.  
		For continuum measurements: the centre of the band of the spectral window. "
		verbLevel="10"/>

		<column name="obsgeo_x" type="real"
		description="X−coordinate in cartesian geocentric terrestrial reference frame, specifying the location the observation took place at time given in MJD-AVG. "
		tablehead="OBSGEO-X"
		ucd="meta.obsgeoX;meta.main"
		verbLevel="15">
		</column>

		<column name="obsgeo_y" type="real"
		description="Y−coordinate in cartesian geocentric terrestrial reference frame, specifying the location the observation took place at time given in MJD-AVG. "
		tablehead="OBSGEO-Y"
		ucd="meta.obsgeoY;meta.main"
		verbLevel="15">
		</column>

		<column name="obsgeo_z" type="real"
		description="Z−coordinate in cartesian geocentric terrestrial reference frame, specifying the location the observation took place at time given in MJD-AVG."
		tablehead="OBSGEO-Z"
		ucd="meta.obsgeoZ;meta.main"
		verbLevel="15">
		</column>

		<column name="mous" type="text"
		description="Member observing unit set status uid."
		tablehead="MOUS"
		ucd="meta.mous;meta.main"
		verbLevel="15">
		</column>

		<column name="gous" type="text"
		description="Group observing unit set status uid."
		tablehead="GOUS"
		ucd="meta.gous;meta.main"
		verbLevel="15">
		</column>

		<column name="lonpole" type="real"
		description="Longitude in the coordinate system of celestial system’s north pole. "
		tablehead="LONPOLE"
		ucd="meta.lonpole;meta.main"
		verbLevel="15">
		</column>

		<column name="latpole" type="real"
		description="Latitude in the coordinate system of celestial system’s north pole."
		tablehead="LATPOLE"
		ucd="meta.latpole;meta.main"
		verbLevel="15">
		</column>

		<column name="instrument_name" type="text"
		description="The receiver band used for the image observations."
		tablehead="INSTRUME"
		ucd="meta.instrument_name;meta.main"
		verbLevel="15">
		</column>



	</table>


<data id="import_content">

	<!-- This is very IMPORTANT !!!, because is the path with the scripts -->
  	<sources items="/var/gavo/inputs/alma_fits"/>

  	<!-- We use the external python script stored in the q.rd base directory. -->
	<customGrammar module="metadatain">
			<rowfilter procDef="__system__/products#define">
				<bind key="table">"alma_fits"</bind>
				<bind key="fsize">@filesize</bind>
				<bind key="path">@access_url</bind>
				<bind key="mime">"image/fits"</bind>
				<bind key="accref">"\schema/"+@name_file</bind>
			</rowfilter>
	</customGrammar>

  	<make table="alma_fits">	
			<rowmaker id="build_obscore" idmaps="*">
				<map dest="s_ra">float(@s_ra)</map>
				<map dest="s_dec">float(@s_dec)</map>
				<map dest="mous">@mous</map>
				<map dest="gous">@gous</map>
				<map dest="obsgeo_x">float(@obsgeo_x)</map>
				<map dest="obsgeo_y">float(@obsgeo_y)</map>
				<map dest="obsgeo_z">float(@obsgeo_z)</map>
				<map dest="target_name">@target_name</map>
				<map dest="date_obs">@date_obs</map>
				<map dest="naxis">float(@naxis)</map>
				<map dest="naxisn">@naxisn</map>
				<map dest="file_name">@name_file</map>
				<map dest="specsys">@specsys</map>
				<map dest="radesys">@radesys</map>
				<map dest="restfrq">float(@restfrq)</map>
				<map dest="lonpole">float(@lonpole)</map>
				<map dest="latpole">float(@latpole)</map>
				<map dest="instrument_name">@instrument_name</map>
				<map dest="access_url">@access_url</map>

				<apply name="fakeWCS">
	    			<code>
					result["centerAlpha"],result["centerDelta"] = float(@s_ra), float(@s_dec)
					result["nAxes"] = float(@naxis)
					result["pixelSize"] = [float(v) for v in @naxisn.split(';')]

					result["pixelScale"] = 0.5
					result["wcs_projection"] = None

					result["wcs_refPixel"] = [float(v) for v in @crpixn.split(';')]
					result["wcs_refValues"] = [float(v) for v in @crvaln.split(';')]
					result["wcs_cdmatrix"] = [float(v) for v in  @cdeltn.split(';')]

					result["wcs_equinox"] = 2000
					result["prodtblAccref"] = None
					
					wcsTestDict = {
						"CRVAL1": 0,   "CRVAL2": 0, "CRPIX1": 50,  "CRPIX2": 50,
						"CD1_1": 0.01, "CD1_2": 0, "CD2_1": 0,    "CD2_2": 0.01,
						"NAXIS1": 100, "NAXIS2": 100, "CUNIT1": "deg", "CUNIT2": "deg",
						"CTYPE1": 'RA---TAN-SIP', "CTYPE2": 'DEC--TAN-SIP', "LONPOLE": 180.,
					}
					result["coverage"] = coords.getSpolyFromWCSFields(wcsTestDict)
	    			</code>
  				</apply>
  				

			</rowmaker>
		</make>

	<!--TAP Services-->
    <register services="__system__/tap#run"/>
</data>

	<!--Service Publication-->
	<!--SIAP-->
	<service id="siap-alma-fits" allowed="form,siap.xml">
	    <meta name="shortName">SIAP ALMA FITS</meta>
	    <meta name="title">Sample Image Access for ALMA FITS</meta>
	  	<meta name="sia.type">pointed</meta>
		<meta name="testQuery.pos.ra">0.8</meta>
		<meta name="testQuery.size.ra">0.8</meta>

		<dbCore queriedTable="alma_fits">
		  <condDesc original="//siap#protoInput"/>
		  <condDesc original="//siap#humanInput"/>
		</dbCore>

		<outputTable autoCols="target_name,file_name,s_ra, s_dec,mous,naxis,naxisn,obsgeo_x,obsgeo_y,obsgeo_z,access_url"/>

		<publish render="siap.xml" sets="local,ivo_managed"/>
 		<publish render="form" sets="local"/>
 	</service>

 	<!--SCS-->
	<service id="scs-alma-fits" allowed="form,scs.xml">
  		<meta name="shortName">SCS ALMA FITS</meta>
        <meta name="title">Simple Cone Search for ALMA FITS</meta>
    	<meta name="testQuery.ra">0.01</meta>
		<meta name="testQuery.dec">0.01</meta>

		<dbCore queriedTable="alma_fits">
			<condDesc original="//scs#humanInput"/>
			<condDesc original="//scs#protoInput"/>
    	</dbCore>

    	<outputTable autoCols="target_name,file_name,s_ra, s_dec,mous,naxis,naxisn,obsgeo_x,obsgeo_y,obsgeo_z,access_url"/>
    	
    	<publish render="scs.xml" sets="local,ivo_managed"/>
    	<publish render="form" sets="local"/>
	</service>


</resource>
