CREATE TABLE "c5_flat_ssd" (
	"drppipe" INTEGER NULL DEFAULT NULL,
	"dappipe" INTEGER NULL DEFAULT NULL,
	"plate" INTEGER NULL DEFAULT NULL,
	"mangaid" TEXT NULL DEFAULT NULL,
	"name" TEXT NULL DEFAULT NULL,
	"plateifu" TEXT NULL DEFAULT NULL,
	"nsa_pk" INTEGER NULL DEFAULT NULL,
	"pk" BIGINT NULL DEFAULT NULL,
	"file_pk" INTEGER NULL DEFAULT NULL,
	"spaxel_index" INTEGER NULL DEFAULT NULL,
	"binid_pk" INTEGER NULL DEFAULT NULL,
	"spx_skycoo_on_sky_x" REAL NULL DEFAULT NULL,
	"spx_skycoo_on_sky_y" REAL NULL DEFAULT NULL,
	"spx_ellcoo_elliptical_radius" REAL NULL DEFAULT NULL,
	"spx_ellcoo_elliptical_azimuth" REAL NULL DEFAULT NULL,
	"spx_mflux" REAL NULL DEFAULT NULL,
	"spx_mflux_ivar" DOUBLE PRECISION NULL DEFAULT NULL,
	"spx_snr" REAL NULL DEFAULT NULL,
	"binid" INTEGER NULL DEFAULT NULL,
	"bin_lwskycoo_lum_weighted_on_sky_x" REAL NULL DEFAULT NULL,
	"bin_lwskycoo_lum_weighted_on_sky_y" REAL NULL DEFAULT NULL,
	"bin_lwellcoo_lum_weighted_elliptical_radius" REAL NULL DEFAULT NULL,
	"bin_lwellcoo_lum_weighted_elliptical_azimuth" REAL NULL DEFAULT NULL,
	"bin_area" REAL NULL DEFAULT NULL,
	"bin_farea" REAL NULL DEFAULT NULL,
	"bin_mflux" REAL NULL DEFAULT NULL,
	"bin_mflux_ivar" DOUBLE PRECISION NULL DEFAULT NULL,
	"bin_mflux_mask" INTEGER NULL DEFAULT NULL,
	"bin_snr" REAL NULL DEFAULT NULL,
	"stellar_vel" REAL NULL DEFAULT NULL,
	"stellar_vel_ivar" DOUBLE PRECISION NULL DEFAULT NULL,
	"stellar_vel_mask" INTEGER NULL DEFAULT NULL,
	"stellar_sigma" REAL NULL DEFAULT NULL,
	"stellar_sigma_ivar" DOUBLE PRECISION NULL DEFAULT NULL,
	"stellar_sigma_mask" INTEGER NULL DEFAULT NULL,
	"stellar_sigmacorr" REAL NULL DEFAULT NULL,
	"stellar_cont_fresid_68th_percentile" REAL NULL DEFAULT NULL,
	"stellar_cont_fresid_99th_percentile" REAL NULL DEFAULT NULL,
	"stellar_cont_rchi2" REAL NULL DEFAULT NULL,
	"emline_sflux_oiid_3728" REAL NULL DEFAULT NULL,
	"emline_sflux_hb_4862" REAL NULL DEFAULT NULL,
	"emline_sflux_oiii_4960" REAL NULL DEFAULT NULL,
	"emline_sflux_oiii_5008" REAL NULL DEFAULT NULL,
	"emline_sflux_oi_6302" REAL NULL DEFAULT NULL,
	"emline_sflux_oi_6365" REAL NULL DEFAULT NULL,
	"emline_sflux_nii_6549" REAL NULL DEFAULT NULL,
	"emline_sflux_ha_6564" REAL NULL DEFAULT NULL,
	"emline_sflux_nii_6585" REAL NULL DEFAULT NULL,
	"emline_sflux_sii_6718" REAL NULL DEFAULT NULL,
	"emline_sflux_sii_6732" REAL NULL DEFAULT NULL,
	"emline_sflux_oii_3727" REAL NULL DEFAULT NULL,
	"emline_sflux_oii_3729" REAL NULL DEFAULT NULL,
	"emline_sflux_heps_3971" REAL NULL DEFAULT NULL,
	"emline_sflux_hdel_4102" REAL NULL DEFAULT NULL,
	"emline_sflux_hgam_4341" REAL NULL DEFAULT NULL,
	"emline_sflux_heii_4687" REAL NULL DEFAULT NULL,
	"emline_sflux_hei_5877" REAL NULL DEFAULT NULL,
	"emline_sflux_siii_8831" REAL NULL DEFAULT NULL,
	"emline_sflux_siii_9071" REAL NULL DEFAULT NULL,
	"emline_sflux_siii_9533" REAL NULL DEFAULT NULL,
	"emline_sflux_ivar_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_ivar_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sflux_mask_oiid_3728" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_hb_4862" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oiii_4960" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oiii_5008" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oi_6302" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oi_6365" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_nii_6549" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_ha_6564" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_nii_6585" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_sii_6718" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_sii_6732" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oii_3727" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_oii_3729" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_heps_3971" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_hdel_4102" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_hgam_4341" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_heii_4687" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_hei_5877" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_siii_8831" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_siii_9071" INTEGER NULL DEFAULT NULL,
	"emline_sflux_mask_siii_9533" INTEGER NULL DEFAULT NULL,
	"emline_sew_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_ivar_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_sew_mask_oiid_3728" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_hb_4862" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oiii_4960" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oiii_5008" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oi_6302" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oi_6365" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_nii_6549" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_ha_6564" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_nii_6585" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_sii_6718" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_sii_6732" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oii_3727" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_oii_3729" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_heps_3971" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_hdel_4102" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_hgam_4341" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_heii_4687" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_hei_5877" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_siii_8831" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_siii_9071" INTEGER NULL DEFAULT NULL,
	"emline_sew_mask_siii_9533" INTEGER NULL DEFAULT NULL,
	"emline_gflux_oiid_3728" REAL NULL DEFAULT NULL,
	"emline_gflux_hb_4862" REAL NULL DEFAULT NULL,
	"emline_gflux_oiii_4960" REAL NULL DEFAULT NULL,
	"emline_gflux_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_oi_6302" REAL NULL DEFAULT NULL,
	"emline_gflux_oi_6365" REAL NULL DEFAULT NULL,
	"emline_gflux_nii_6549" REAL NULL DEFAULT NULL,
	"emline_gflux_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_sii_6718" REAL NULL DEFAULT NULL,
	"emline_gflux_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_oii_3729" REAL NULL DEFAULT NULL,
	"emline_gflux_heps_3971" REAL NULL DEFAULT NULL,
	"emline_gflux_hdel_4102" REAL NULL DEFAULT NULL,
	"emline_gflux_hgam_4341" REAL NULL DEFAULT NULL,
	"emline_gflux_heii_4687" REAL NULL DEFAULT NULL,
	"emline_gflux_hei_5877" REAL NULL DEFAULT NULL,
	"emline_gflux_siii_8831" REAL NULL DEFAULT NULL,
	"emline_gflux_siii_9071" REAL NULL DEFAULT NULL,
	"emline_gflux_siii_9533" REAL NULL DEFAULT NULL,
	"emline_gflux_ivar_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_ivar_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gflux_mask_oiid_3728" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_hb_4862" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oiii_4960" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oiii_5008" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oi_6302" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oi_6365" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_nii_6549" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_ha_6564" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_nii_6585" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_sii_6718" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_sii_6732" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oii_3727" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_oii_3729" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_heps_3971" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_hdel_4102" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_hgam_4341" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_heii_4687" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_hei_5877" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_siii_8831" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_siii_9071" INTEGER NULL DEFAULT NULL,
	"emline_gflux_mask_siii_9533" INTEGER NULL DEFAULT NULL,
	"emline_gvel_oiid_3728" REAL NULL DEFAULT NULL,
	"emline_gvel_hb_4862" REAL NULL DEFAULT NULL,
	"emline_gvel_oiii_4960" REAL NULL DEFAULT NULL,
	"emline_gvel_oiii_5008" REAL NULL DEFAULT NULL,
	"emline_gvel_oi_6302" REAL NULL DEFAULT NULL,
	"emline_gvel_oi_6365" REAL NULL DEFAULT NULL,
	"emline_gvel_nii_6549" REAL NULL DEFAULT NULL,
	"emline_gvel_ha_6564" REAL NULL DEFAULT NULL,
	"emline_gvel_nii_6585" REAL NULL DEFAULT NULL,
	"emline_gvel_sii_6718" REAL NULL DEFAULT NULL,
	"emline_gvel_sii_6732" REAL NULL DEFAULT NULL,
	"emline_gvel_oii_3727" REAL NULL DEFAULT NULL,
	"emline_gvel_oii_3729" REAL NULL DEFAULT NULL,
	"emline_gvel_heps_3971" REAL NULL DEFAULT NULL,
	"emline_gvel_hdel_4102" REAL NULL DEFAULT NULL,
	"emline_gvel_hgam_4341" REAL NULL DEFAULT NULL,
	"emline_gvel_heii_4687" REAL NULL DEFAULT NULL,
	"emline_gvel_hei_5877" REAL NULL DEFAULT NULL,
	"emline_gvel_siii_8831" REAL NULL DEFAULT NULL,
	"emline_gvel_siii_9071" REAL NULL DEFAULT NULL,
	"emline_gvel_siii_9533" REAL NULL DEFAULT NULL,
	"emline_gvel_ivar_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_ivar_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gvel_mask_oiid_3728" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_hb_4862" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oiii_4960" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oiii_5008" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oi_6302" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oi_6365" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_nii_6549" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_ha_6564" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_nii_6585" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_sii_6718" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_sii_6732" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oii_3727" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_oii_3729" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_heps_3971" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_hdel_4102" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_hgam_4341" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_heii_4687" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_hei_5877" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_siii_8831" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_siii_9071" INTEGER NULL DEFAULT NULL,
	"emline_gvel_mask_siii_9533" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_oiid_3728" REAL NULL DEFAULT NULL,
	"emline_gsigma_hb_4862" REAL NULL DEFAULT NULL,
	"emline_gsigma_oiii_4960" REAL NULL DEFAULT NULL,
	"emline_gsigma_oiii_5008" REAL NULL DEFAULT NULL,
	"emline_gsigma_oi_6302" REAL NULL DEFAULT NULL,
	"emline_gsigma_oi_6365" REAL NULL DEFAULT NULL,
	"emline_gsigma_nii_6549" REAL NULL DEFAULT NULL,
	"emline_gsigma_ha_6564" REAL NULL DEFAULT NULL,
	"emline_gsigma_nii_6585" REAL NULL DEFAULT NULL,
	"emline_gsigma_sii_6718" REAL NULL DEFAULT NULL,
	"emline_gsigma_sii_6732" REAL NULL DEFAULT NULL,
	"emline_gsigma_oii_3727" REAL NULL DEFAULT NULL,
	"emline_gsigma_oii_3729" REAL NULL DEFAULT NULL,
	"emline_gsigma_heps_3971" REAL NULL DEFAULT NULL,
	"emline_gsigma_hdel_4102" REAL NULL DEFAULT NULL,
	"emline_gsigma_hgam_4341" REAL NULL DEFAULT NULL,
	"emline_gsigma_heii_4687" REAL NULL DEFAULT NULL,
	"emline_gsigma_hei_5877" REAL NULL DEFAULT NULL,
	"emline_gsigma_siii_8831" REAL NULL DEFAULT NULL,
	"emline_gsigma_siii_9071" REAL NULL DEFAULT NULL,
	"emline_gsigma_siii_9533" REAL NULL DEFAULT NULL,
	"emline_gsigma_ivar_oiid_3728" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_hb_4862" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oiii_4960" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oiii_5008" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oi_6302" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oi_6365" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_nii_6549" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_ha_6564" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_nii_6585" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_sii_6718" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_sii_6732" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oii_3727" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_oii_3729" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_heps_3971" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_hdel_4102" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_hgam_4341" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_heii_4687" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_hei_5877" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_siii_8831" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_siii_9071" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_ivar_siii_9533" DOUBLE PRECISION NULL DEFAULT NULL,
	"emline_gsigma_mask_oiid_3728" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_hb_4862" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oiii_4960" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oiii_5008" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oi_6302" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oi_6365" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_nii_6549" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_ha_6564" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_nii_6585" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_sii_6718" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_sii_6732" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oii_3727" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_oii_3729" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_heps_3971" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_hdel_4102" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_hgam_4341" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_heii_4687" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_hei_5877" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_siii_8831" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_siii_9071" INTEGER NULL DEFAULT NULL,
	"emline_gsigma_mask_siii_9533" INTEGER NULL DEFAULT NULL,
	"emline_instsigma_oiid_3728" REAL NULL DEFAULT NULL,
	"emline_instsigma_hb_4862" REAL NULL DEFAULT NULL,
	"emline_instsigma_oiii_4960" REAL NULL DEFAULT NULL,
	"emline_instsigma_oiii_5008" REAL NULL DEFAULT NULL,
	"emline_instsigma_oi_6302" REAL NULL DEFAULT NULL,
	"emline_instsigma_oi_6365" REAL NULL DEFAULT NULL,
	"emline_instsigma_nii_6549" REAL NULL DEFAULT NULL,
	"emline_instsigma_ha_6564" REAL NULL DEFAULT NULL,
	"emline_instsigma_nii_6585" REAL NULL DEFAULT NULL,
	"emline_instsigma_sii_6718" REAL NULL DEFAULT NULL,
	"emline_instsigma_sii_6732" REAL NULL DEFAULT NULL,
	"emline_instsigma_oii_3727" REAL NULL DEFAULT NULL,
	"emline_instsigma_oii_3729" REAL NULL DEFAULT NULL,
	"emline_instsigma_heps_3971" REAL NULL DEFAULT NULL,
	"emline_instsigma_hdel_4102" REAL NULL DEFAULT NULL,
	"emline_instsigma_hgam_4341" REAL NULL DEFAULT NULL,
	"emline_instsigma_heii_4687" REAL NULL DEFAULT NULL,
	"emline_instsigma_hei_5877" REAL NULL DEFAULT NULL,
	"emline_instsigma_siii_8831" REAL NULL DEFAULT NULL,
	"emline_instsigma_siii_9071" REAL NULL DEFAULT NULL,
	"emline_instsigma_siii_9533" REAL NULL DEFAULT NULL,
	"specindex_d4000" REAL NULL DEFAULT NULL,
	"specindex_dn4000" REAL NULL DEFAULT NULL,
	"specindex_ivar_d4000" DOUBLE PRECISION NULL DEFAULT NULL,
	"specindex_ivar_dn4000" DOUBLE PRECISION NULL DEFAULT NULL,
	"specindex_mask_d4000" INTEGER NULL DEFAULT NULL,
	"specindex_mask_dn4000" INTEGER NULL DEFAULT NULL,
	"specindex_corr_d4000" REAL NULL DEFAULT NULL,
	"specindex_corr_dn4000" REAL NULL DEFAULT NULL,
	"x" INTEGER NULL DEFAULT NULL,
	"y" INTEGER NULL DEFAULT NULL,
	INDEX "" ("file_pk"),
	INDEX "" ("specindex_d4000"),
	INDEX "" ("binid"),
	INDEX "" ("emline_gflux_ha_6564"),
	INDEX "" ("emline_gflux_hb_4862"),
	INDEX "" ("emline_gflux_nii_6585"),
	INDEX "" ("emline_gflux_oiid_3728"),
	INDEX "" ("emline_gflux_oiii_5008"),
	INDEX "" ("emline_gflux_sii_6718"),
	INDEX "" ("spaxel_index"),
	INDEX "" ("stellar_vel")
)
;
COMMENT ON COLUMN "c5_flat_ssd"."drppipe" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."dappipe" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."plate" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."mangaid" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."name" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."plateifu" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."nsa_pk" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."pk" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."file_pk" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spaxel_index" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."binid_pk" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_skycoo_on_sky_x" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_skycoo_on_sky_y" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_ellcoo_elliptical_radius" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_ellcoo_elliptical_azimuth" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_mflux" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_mflux_ivar" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."spx_snr" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."binid" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_lwskycoo_lum_weighted_on_sky_x" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_lwskycoo_lum_weighted_on_sky_y" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_lwellcoo_lum_weighted_elliptical_radius" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_lwellcoo_lum_weighted_elliptical_azimuth" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_area" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_farea" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_mflux" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_mflux_ivar" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_mflux_mask" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."bin_snr" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_vel" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_vel_ivar" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_vel_mask" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_sigma" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_sigma_ivar" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_sigma_mask" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_sigmacorr" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_cont_fresid_68th_percentile" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_cont_fresid_99th_percentile" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."stellar_cont_rchi2" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_ivar_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sflux_mask_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_ivar_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_sew_mask_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_ivar_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gflux_mask_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_ivar_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gvel_mask_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_ivar_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_gsigma_mask_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oiid_3728" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_hb_4862" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oiii_4960" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oiii_5008" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oi_6302" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oi_6365" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_nii_6549" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_ha_6564" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_nii_6585" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_sii_6718" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_sii_6732" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oii_3727" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_oii_3729" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_heps_3971" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_hdel_4102" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_hgam_4341" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_heii_4687" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_hei_5877" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_siii_8831" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_siii_9071" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."emline_instsigma_siii_9533" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_d4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_dn4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_ivar_d4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_ivar_dn4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_mask_d4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_mask_dn4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_corr_d4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."specindex_corr_dn4000" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."x" IS E'';
COMMENT ON COLUMN "c5_flat_ssd"."y" IS E'';
