CREATE foreign TABLE mangadapdb.flat_cstore_ssd(
	drppipe int4 NULL,
	dappipe int4 NULL,
	plate int4 NULL,
	mangaid text NULL,
	"name" text NULL,
	plateifu text NULL,
	nsa_pk int4 NULL,
	pk int8 NOT NULL,
	file_pk int4 NULL,
	spaxel_index int4 NULL,
	binid_pk int4 NULL,
	spx_skycoo_on_sky_x float4 NULL,
	spx_skycoo_on_sky_y float4 NULL,
	spx_ellcoo_elliptical_radius float4 NULL,
	spx_ellcoo_elliptical_azimuth float4 NULL,
	spx_mflux float4 NULL,
	spx_mflux_ivar float8 NULL,
	spx_snr float4 NULL,
	binid int4 NULL,
	bin_lwskycoo_lum_weighted_on_sky_x float4 NULL,
	bin_lwskycoo_lum_weighted_on_sky_y float4 NULL,
	bin_lwellcoo_lum_weighted_elliptical_radius float4 NULL,
	bin_lwellcoo_lum_weighted_elliptical_azimuth float4 NULL,
	bin_area float4 NULL,
	bin_farea float4 NULL,
	bin_mflux float4 NULL,
	bin_mflux_ivar float8 NULL,
	bin_mflux_mask int4 NULL,
	bin_snr float4 NULL,
	stellar_vel float4 NULL,
	stellar_vel_ivar float8 NULL,
	stellar_vel_mask int4 NULL,
	stellar_sigma float4 NULL,
	stellar_sigma_ivar float8 NULL,
	stellar_sigma_mask int4 NULL,
	stellar_sigmacorr float4 NULL,
	stellar_cont_fresid_68th_percentile float4 NULL,
	stellar_cont_fresid_99th_percentile float4 NULL,
	stellar_cont_rchi2 float4 NULL,
	emline_sflux_oiid_3728 float4 NULL,
	emline_sflux_hb_4862 float4 NULL,
	emline_sflux_oiii_4960 float4 NULL,
	emline_sflux_oiii_5008 float4 NULL,
	emline_sflux_oi_6302 float4 NULL,
	emline_sflux_oi_6365 float4 NULL,
	emline_sflux_nii_6549 float4 NULL,
	emline_sflux_ha_6564 float4 NULL,
	emline_sflux_nii_6585 float4 NULL,
	emline_sflux_sii_6718 float4 NULL,
	emline_sflux_sii_6732 float4 NULL,
	emline_sflux_oii_3727 float4 NULL,
	emline_sflux_oii_3729 float4 NULL,
	emline_sflux_heps_3971 float4 NULL,
	emline_sflux_hdel_4102 float4 NULL,
	emline_sflux_hgam_4341 float4 NULL,
	emline_sflux_heii_4687 float4 NULL,
	emline_sflux_hei_5877 float4 NULL,
	emline_sflux_siii_8831 float4 NULL,
	emline_sflux_siii_9071 float4 NULL,
	emline_sflux_siii_9533 float4 NULL,
	emline_sflux_ivar_oiid_3728 float8 NULL,
	emline_sflux_ivar_hb_4862 float8 NULL,
	emline_sflux_ivar_oiii_4960 float8 NULL,
	emline_sflux_ivar_oiii_5008 float8 NULL,
	emline_sflux_ivar_oi_6302 float8 NULL,
	emline_sflux_ivar_oi_6365 float8 NULL,
	emline_sflux_ivar_nii_6549 float8 NULL,
	emline_sflux_ivar_ha_6564 float8 NULL,
	emline_sflux_ivar_nii_6585 float8 NULL,
	emline_sflux_ivar_sii_6718 float8 NULL,
	emline_sflux_ivar_sii_6732 float8 NULL,
	emline_sflux_ivar_oii_3727 float8 NULL,
	emline_sflux_ivar_oii_3729 float8 NULL,
	emline_sflux_ivar_heps_3971 float8 NULL,
	emline_sflux_ivar_hdel_4102 float8 NULL,
	emline_sflux_ivar_hgam_4341 float8 NULL,
	emline_sflux_ivar_heii_4687 float8 NULL,
	emline_sflux_ivar_hei_5877 float8 NULL,
	emline_sflux_ivar_siii_8831 float8 NULL,
	emline_sflux_ivar_siii_9071 float8 NULL,
	emline_sflux_ivar_siii_9533 float8 NULL,
	emline_sflux_mask_oiid_3728 int4 NULL,
	emline_sflux_mask_hb_4862 int4 NULL,
	emline_sflux_mask_oiii_4960 int4 NULL,
	emline_sflux_mask_oiii_5008 int4 NULL,
	emline_sflux_mask_oi_6302 int4 NULL,
	emline_sflux_mask_oi_6365 int4 NULL,
	emline_sflux_mask_nii_6549 int4 NULL,
	emline_sflux_mask_ha_6564 int4 NULL,
	emline_sflux_mask_nii_6585 int4 NULL,
	emline_sflux_mask_sii_6718 int4 NULL,
	emline_sflux_mask_sii_6732 int4 NULL,
	emline_sflux_mask_oii_3727 int4 NULL,
	emline_sflux_mask_oii_3729 int4 NULL,
	emline_sflux_mask_heps_3971 int4 NULL,
	emline_sflux_mask_hdel_4102 int4 NULL,
	emline_sflux_mask_hgam_4341 int4 NULL,
	emline_sflux_mask_heii_4687 int4 NULL,
	emline_sflux_mask_hei_5877 int4 NULL,
	emline_sflux_mask_siii_8831 int4 NULL,
	emline_sflux_mask_siii_9071 int4 NULL,
	emline_sflux_mask_siii_9533 int4 NULL,
	emline_sew_oiid_3728 float8 NULL,
	emline_sew_hb_4862 float8 NULL,
	emline_sew_oiii_4960 float8 NULL,
	emline_sew_oiii_5008 float8 NULL,
	emline_sew_oi_6302 float8 NULL,
	emline_sew_oi_6365 float8 NULL,
	emline_sew_nii_6549 float8 NULL,
	emline_sew_ha_6564 float8 NULL,
	emline_sew_nii_6585 float8 NULL,
	emline_sew_sii_6718 float8 NULL,
	emline_sew_sii_6732 float8 NULL,
	emline_sew_oii_3727 float8 NULL,
	emline_sew_oii_3729 float8 NULL,
	emline_sew_heps_3971 float8 NULL,
	emline_sew_hdel_4102 float8 NULL,
	emline_sew_hgam_4341 float8 NULL,
	emline_sew_heii_4687 float8 NULL,
	emline_sew_hei_5877 float8 NULL,
	emline_sew_siii_8831 float8 NULL,
	emline_sew_siii_9071 float8 NULL,
	emline_sew_siii_9533 float8 NULL,
	emline_sew_ivar_oiid_3728 float8 NULL,
	emline_sew_ivar_hb_4862 float8 NULL,
	emline_sew_ivar_oiii_4960 float8 NULL,
	emline_sew_ivar_oiii_5008 float8 NULL,
	emline_sew_ivar_oi_6302 float8 NULL,
	emline_sew_ivar_oi_6365 float8 NULL,
	emline_sew_ivar_nii_6549 float8 NULL,
	emline_sew_ivar_ha_6564 float8 NULL,
	emline_sew_ivar_nii_6585 float8 NULL,
	emline_sew_ivar_sii_6718 float8 NULL,
	emline_sew_ivar_sii_6732 float8 NULL,
	emline_sew_ivar_oii_3727 float8 NULL,
	emline_sew_ivar_oii_3729 float8 NULL,
	emline_sew_ivar_heps_3971 float8 NULL,
	emline_sew_ivar_hdel_4102 float8 NULL,
	emline_sew_ivar_hgam_4341 float8 NULL,
	emline_sew_ivar_heii_4687 float8 NULL,
	emline_sew_ivar_hei_5877 float8 NULL,
	emline_sew_ivar_siii_8831 float8 NULL,
	emline_sew_ivar_siii_9071 float8 NULL,
	emline_sew_ivar_siii_9533 float8 NULL,
	emline_sew_mask_oiid_3728 int4 NULL,
	emline_sew_mask_hb_4862 int4 NULL,
	emline_sew_mask_oiii_4960 int4 NULL,
	emline_sew_mask_oiii_5008 int4 NULL,
	emline_sew_mask_oi_6302 int4 NULL,
	emline_sew_mask_oi_6365 int4 NULL,
	emline_sew_mask_nii_6549 int4 NULL,
	emline_sew_mask_ha_6564 int4 NULL,
	emline_sew_mask_nii_6585 int4 NULL,
	emline_sew_mask_sii_6718 int4 NULL,
	emline_sew_mask_sii_6732 int4 NULL,
	emline_sew_mask_oii_3727 int4 NULL,
	emline_sew_mask_oii_3729 int4 NULL,
	emline_sew_mask_heps_3971 int4 NULL,
	emline_sew_mask_hdel_4102 int4 NULL,
	emline_sew_mask_hgam_4341 int4 NULL,
	emline_sew_mask_heii_4687 int4 NULL,
	emline_sew_mask_hei_5877 int4 NULL,
	emline_sew_mask_siii_8831 int4 NULL,
	emline_sew_mask_siii_9071 int4 NULL,
	emline_sew_mask_siii_9533 int4 NULL,
	emline_gflux_oiid_3728 float4 NULL,
	emline_gflux_hb_4862 float4 NULL,
	emline_gflux_oiii_4960 float4 NULL,
	emline_gflux_oiii_5008 float8 NULL,
	emline_gflux_oi_6302 float4 NULL,
	emline_gflux_oi_6365 float4 NULL,
	emline_gflux_nii_6549 float4 NULL,
	emline_gflux_ha_6564 float8 NULL,
	emline_gflux_nii_6585 float8 NULL,
	emline_gflux_sii_6718 float4 NULL,
	emline_gflux_sii_6732 float8 NULL,
	emline_gflux_oii_3727 float8 NULL,
	emline_gflux_oii_3729 float4 NULL,
	emline_gflux_heps_3971 float4 NULL,
	emline_gflux_hdel_4102 float4 NULL,
	emline_gflux_hgam_4341 float4 NULL,
	emline_gflux_heii_4687 float4 NULL,
	emline_gflux_hei_5877 float4 NULL,
	emline_gflux_siii_8831 float4 NULL,
	emline_gflux_siii_9071 float4 NULL,
	emline_gflux_siii_9533 float4 NULL,
	emline_gflux_ivar_oiid_3728 float8 NULL,
	emline_gflux_ivar_hb_4862 float8 NULL,
	emline_gflux_ivar_oiii_4960 float8 NULL,
	emline_gflux_ivar_oiii_5008 float8 NULL,
	emline_gflux_ivar_oi_6302 float8 NULL,
	emline_gflux_ivar_oi_6365 float8 NULL,
	emline_gflux_ivar_nii_6549 float8 NULL,
	emline_gflux_ivar_ha_6564 float8 NULL,
	emline_gflux_ivar_nii_6585 float8 NULL,
	emline_gflux_ivar_sii_6718 float8 NULL,
	emline_gflux_ivar_sii_6732 float8 NULL,
	emline_gflux_ivar_oii_3727 float8 NULL,
	emline_gflux_ivar_oii_3729 float8 NULL,
	emline_gflux_ivar_heps_3971 float8 NULL,
	emline_gflux_ivar_hdel_4102 float8 NULL,
	emline_gflux_ivar_hgam_4341 float8 NULL,
	emline_gflux_ivar_heii_4687 float8 NULL,
	emline_gflux_ivar_hei_5877 float8 NULL,
	emline_gflux_ivar_siii_8831 float8 NULL,
	emline_gflux_ivar_siii_9071 float8 NULL,
	emline_gflux_ivar_siii_9533 float8 NULL,
	emline_gflux_mask_oiid_3728 int4 NULL,
	emline_gflux_mask_hb_4862 int4 NULL,
	emline_gflux_mask_oiii_4960 int4 NULL,
	emline_gflux_mask_oiii_5008 int4 NULL,
	emline_gflux_mask_oi_6302 int4 NULL,
	emline_gflux_mask_oi_6365 int4 NULL,
	emline_gflux_mask_nii_6549 int4 NULL,
	emline_gflux_mask_ha_6564 int4 NULL,
	emline_gflux_mask_nii_6585 int4 NULL,
	emline_gflux_mask_sii_6718 int4 NULL,
	emline_gflux_mask_sii_6732 int4 NULL,
	emline_gflux_mask_oii_3727 int4 NULL,
	emline_gflux_mask_oii_3729 int4 NULL,
	emline_gflux_mask_heps_3971 int4 NULL,
	emline_gflux_mask_hdel_4102 int4 NULL,
	emline_gflux_mask_hgam_4341 int4 NULL,
	emline_gflux_mask_heii_4687 int4 NULL,
	emline_gflux_mask_hei_5877 int4 NULL,
	emline_gflux_mask_siii_8831 int4 NULL,
	emline_gflux_mask_siii_9071 int4 NULL,
	emline_gflux_mask_siii_9533 int4 NULL,
	emline_gvel_oiid_3728 float4 NULL,
	emline_gvel_hb_4862 float4 NULL,
	emline_gvel_oiii_4960 float4 NULL,
	emline_gvel_oiii_5008 float4 NULL,
	emline_gvel_oi_6302 float4 NULL,
	emline_gvel_oi_6365 float4 NULL,
	emline_gvel_nii_6549 float4 NULL,
	emline_gvel_ha_6564 float4 NULL,
	emline_gvel_nii_6585 float4 NULL,
	emline_gvel_sii_6718 float4 NULL,
	emline_gvel_sii_6732 float4 NULL,
	emline_gvel_oii_3727 float4 NULL,
	emline_gvel_oii_3729 float4 NULL,
	emline_gvel_heps_3971 float4 NULL,
	emline_gvel_hdel_4102 float4 NULL,
	emline_gvel_hgam_4341 float4 NULL,
	emline_gvel_heii_4687 float4 NULL,
	emline_gvel_hei_5877 float4 NULL,
	emline_gvel_siii_8831 float4 NULL,
	emline_gvel_siii_9071 float4 NULL,
	emline_gvel_siii_9533 float4 NULL,
	emline_gvel_ivar_oiid_3728 float8 NULL,
	emline_gvel_ivar_hb_4862 float8 NULL,
	emline_gvel_ivar_oiii_4960 float8 NULL,
	emline_gvel_ivar_oiii_5008 float8 NULL,
	emline_gvel_ivar_oi_6302 float8 NULL,
	emline_gvel_ivar_oi_6365 float8 NULL,
	emline_gvel_ivar_nii_6549 float8 NULL,
	emline_gvel_ivar_ha_6564 float8 NULL,
	emline_gvel_ivar_nii_6585 float8 NULL,
	emline_gvel_ivar_sii_6718 float8 NULL,
	emline_gvel_ivar_sii_6732 float8 NULL,
	emline_gvel_ivar_oii_3727 float8 NULL,
	emline_gvel_ivar_oii_3729 float8 NULL,
	emline_gvel_ivar_heps_3971 float8 NULL,
	emline_gvel_ivar_hdel_4102 float8 NULL,
	emline_gvel_ivar_hgam_4341 float8 NULL,
	emline_gvel_ivar_heii_4687 float8 NULL,
	emline_gvel_ivar_hei_5877 float8 NULL,
	emline_gvel_ivar_siii_8831 float8 NULL,
	emline_gvel_ivar_siii_9071 float8 NULL,
	emline_gvel_ivar_siii_9533 float8 NULL,
	emline_gvel_mask_oiid_3728 int4 NULL,
	emline_gvel_mask_hb_4862 int4 NULL,
	emline_gvel_mask_oiii_4960 int4 NULL,
	emline_gvel_mask_oiii_5008 int4 NULL,
	emline_gvel_mask_oi_6302 int4 NULL,
	emline_gvel_mask_oi_6365 int4 NULL,
	emline_gvel_mask_nii_6549 int4 NULL,
	emline_gvel_mask_ha_6564 int4 NULL,
	emline_gvel_mask_nii_6585 int4 NULL,
	emline_gvel_mask_sii_6718 int4 NULL,
	emline_gvel_mask_sii_6732 int4 NULL,
	emline_gvel_mask_oii_3727 int4 NULL,
	emline_gvel_mask_oii_3729 int4 NULL,
	emline_gvel_mask_heps_3971 int4 NULL,
	emline_gvel_mask_hdel_4102 int4 NULL,
	emline_gvel_mask_hgam_4341 int4 NULL,
	emline_gvel_mask_heii_4687 int4 NULL,
	emline_gvel_mask_hei_5877 int4 NULL,
	emline_gvel_mask_siii_8831 int4 NULL,
	emline_gvel_mask_siii_9071 int4 NULL,
	emline_gvel_mask_siii_9533 int4 NULL,
	emline_gsigma_oiid_3728 float4 NULL,
	emline_gsigma_hb_4862 float4 NULL,
	emline_gsigma_oiii_4960 float4 NULL,
	emline_gsigma_oiii_5008 float4 NULL,
	emline_gsigma_oi_6302 float4 NULL,
	emline_gsigma_oi_6365 float4 NULL,
	emline_gsigma_nii_6549 float4 NULL,
	emline_gsigma_ha_6564 float4 NULL,
	emline_gsigma_nii_6585 float4 NULL,
	emline_gsigma_sii_6718 float4 NULL,
	emline_gsigma_sii_6732 float4 NULL,
	emline_gsigma_oii_3727 float4 NULL,
	emline_gsigma_oii_3729 float4 NULL,
	emline_gsigma_heps_3971 float4 NULL,
	emline_gsigma_hdel_4102 float4 NULL,
	emline_gsigma_hgam_4341 float4 NULL,
	emline_gsigma_heii_4687 float4 NULL,
	emline_gsigma_hei_5877 float4 NULL,
	emline_gsigma_siii_8831 float4 NULL,
	emline_gsigma_siii_9071 float4 NULL,
	emline_gsigma_siii_9533 float4 NULL,
	emline_gsigma_ivar_oiid_3728 float8 NULL,
	emline_gsigma_ivar_hb_4862 float8 NULL,
	emline_gsigma_ivar_oiii_4960 float8 NULL,
	emline_gsigma_ivar_oiii_5008 float8 NULL,
	emline_gsigma_ivar_oi_6302 float8 NULL,
	emline_gsigma_ivar_oi_6365 float8 NULL,
	emline_gsigma_ivar_nii_6549 float8 NULL,
	emline_gsigma_ivar_ha_6564 float8 NULL,
	emline_gsigma_ivar_nii_6585 float8 NULL,
	emline_gsigma_ivar_sii_6718 float8 NULL,
	emline_gsigma_ivar_sii_6732 float8 NULL,
	emline_gsigma_ivar_oii_3727 float8 NULL,
	emline_gsigma_ivar_oii_3729 float8 NULL,
	emline_gsigma_ivar_heps_3971 float8 NULL,
	emline_gsigma_ivar_hdel_4102 float8 NULL,
	emline_gsigma_ivar_hgam_4341 float8 NULL,
	emline_gsigma_ivar_heii_4687 float8 NULL,
	emline_gsigma_ivar_hei_5877 float8 NULL,
	emline_gsigma_ivar_siii_8831 float8 NULL,
	emline_gsigma_ivar_siii_9071 float8 NULL,
	emline_gsigma_ivar_siii_9533 float8 NULL,
	emline_gsigma_mask_oiid_3728 int4 NULL,
	emline_gsigma_mask_hb_4862 int4 NULL,
	emline_gsigma_mask_oiii_4960 int4 NULL,
	emline_gsigma_mask_oiii_5008 int4 NULL,
	emline_gsigma_mask_oi_6302 int4 NULL,
	emline_gsigma_mask_oi_6365 int4 NULL,
	emline_gsigma_mask_nii_6549 int4 NULL,
	emline_gsigma_mask_ha_6564 int4 NULL,
	emline_gsigma_mask_nii_6585 int4 NULL,
	emline_gsigma_mask_sii_6718 int4 NULL,
	emline_gsigma_mask_sii_6732 int4 NULL,
	emline_gsigma_mask_oii_3727 int4 NULL,
	emline_gsigma_mask_oii_3729 int4 NULL,
	emline_gsigma_mask_heps_3971 int4 NULL,
	emline_gsigma_mask_hdel_4102 int4 NULL,
	emline_gsigma_mask_hgam_4341 int4 NULL,
	emline_gsigma_mask_heii_4687 int4 NULL,
	emline_gsigma_mask_hei_5877 int4 NULL,
	emline_gsigma_mask_siii_8831 int4 NULL,
	emline_gsigma_mask_siii_9071 int4 NULL,
	emline_gsigma_mask_siii_9533 int4 NULL,
	emline_instsigma_oiid_3728 float4 NULL,
	emline_instsigma_hb_4862 float4 NULL,
	emline_instsigma_oiii_4960 float4 NULL,
	emline_instsigma_oiii_5008 float4 NULL,
	emline_instsigma_oi_6302 float4 NULL,
	emline_instsigma_oi_6365 float4 NULL,
	emline_instsigma_nii_6549 float4 NULL,
	emline_instsigma_ha_6564 float4 NULL,
	emline_instsigma_nii_6585 float4 NULL,
	emline_instsigma_sii_6718 float4 NULL,
	emline_instsigma_sii_6732 float4 NULL,
	emline_instsigma_oii_3727 float4 NULL,
	emline_instsigma_oii_3729 float4 NULL,
	emline_instsigma_heps_3971 float4 NULL,
	emline_instsigma_hdel_4102 float4 NULL,
	emline_instsigma_hgam_4341 float4 NULL,
	emline_instsigma_heii_4687 float4 NULL,
	emline_instsigma_hei_5877 float4 NULL,
	emline_instsigma_siii_8831 float4 NULL,
	emline_instsigma_siii_9071 float4 NULL,
	emline_instsigma_siii_9533 float4 NULL,
	specindex_d4000 float4 NULL,
	specindex_dn4000 float4 NULL,
	specindex_ivar_d4000 float8 NULL,
	specindex_ivar_dn4000 float8 NULL,
	specindex_mask_d4000 int4 NULL,
	specindex_mask_dn4000 int4 NULL,
	specindex_corr_d4000 float4 NULL,
	specindex_corr_dn4000 float4 NULL,
	x int4 NULL,
	y int4 NULL
)
     server cstore_server
     options(filename '/ssd/postgres_db/manga/flat_ssd_cstore.cstore', compression 'pglz');
     
     
     insert into mangadapdb.flat_cstore_ssd
     select * from mangadapdb.flat_ssd;
     
     analyze mangadapdb.flat_cstore_ssd;