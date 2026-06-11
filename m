Return-Path: <cgroups+bounces-16876-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XVaNBMkPK2oz2AMAu9opvQ
	(envelope-from <cgroups+bounces-16876-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 21:43:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C5674D33
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 21:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KO5G2tCE;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16876-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16876-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2DCE3137AC8
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9ED37F8B3;
	Thu, 11 Jun 2026 19:41:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074036CE1E;
	Thu, 11 Jun 2026 19:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206901; cv=none; b=XVAynPn1X6rx7sDhNNlPkVEyVZNjnaEmKzWEQnZRNL02LmonDoDbn2qoet6SfWsOYbuAkbY/h3Hgvr0YW8MfIa+VNkK4bz0R+6slbvLqPmgMlWakrC6q+pUlb/AysybXDor1NDleXRB8eaVUviDq3PRRCcTq7q8R5conrqJGa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206901; c=relaxed/simple;
	bh=XGA8XvGhar3Z1r6Oh+DGdi0DMjCB5+1+8ldPsokTHIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLUkubp1JfPsPLQBd4O8RcdZ2oT1j7axa6J9UW+98UsubXwskd7W7psEkOVd+SIrXfdN7Kl/JLkxKkG/LZZesbnD/3iRLzmHFPvVLYs6WTxCjmxnbomBZqJyZiNs1hgJBICdVOh5qk6QpunKFisqbQH+bTbwxFpW7/4YRSRaPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KO5G2tCE; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781206897; x=1812742897;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XGA8XvGhar3Z1r6Oh+DGdi0DMjCB5+1+8ldPsokTHIE=;
  b=KO5G2tCE96w4Na6uToqh1+gUtdxWoPHX1fjFG2wThAnn/9swpN4kweCI
   XoSCSJX3hT7irJ14MZGZuD272QLlADhJnzDd1lJ/O3/FRo++DT2cqj4ir
   jSBl+aTzAyxuhk+KRvwaizMMoi059H8KnLX+aCVHEyqE655W+K2YRNLym
   f7M5Sp/qGy7uD8yhST7KAM1VZuw5WAfHpBwqCEPXSuRL1rM+Ih35Yl6ji
   MCh3WOOvpx7dOlArcF8XKn1Qg5+NAin/V9J1++73uzidfcw3PcdsGvIIE
   CRrOD4Iy/CgW0plUaSJw2P/HvGvK3h3HDkBlwKp0u24m7oHhIeeyA+inA
   w==;
X-CSE-ConnectionGUID: y5bBTs6QQfegVI1DH+9I+w==
X-CSE-MsgGUID: E60/WcdxSPyrM6v6iL1/rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93520571"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93520571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:41:36 -0700
X-CSE-ConnectionGUID: vvwdwSeZRd228JgWLwt3IQ==
X-CSE-MsgGUID: NS0KcAVJTj2pqMYozOfh6Q==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.169]) ([10.245.244.169])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:41:31 -0700
Message-ID: <c4dec5fa460cdbeb3706410c6fb3375ab36012ab.camel@linux.intel.com>
Subject: Re: [PATCH v6 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie	 <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 21:41:28 +0200
In-Reply-To: <20260611173301.17473-7-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
	 <20260611173301.17473-7-thomas.hellstrom@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16876-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 704C5674D33

On Thu, 2026-06-11 at 19:33 +0200, Thomas Hellstr=C3=B6m wrote:
> Register the VRAM manager with the dmem cgroup reclaim infrastructure
> so that lowering dmem.max below current VRAM usage triggers TTM
> eviction rather than failing with -EBUSY.
>=20
> Guard place->flags in amdgpu_ttm_bo_eviction_valuable() against NULL,
> as the TTM reclaim path passes a NULL place in cgroup drain mode.
>=20
> v3:
> - Rebased on fix for uninitialized list and buddy allocator on the
> =C2=A0 drmm_cgroup_register_region() error path.
>=20
> v5:
> - Rebased on the introduction of struct dmem_cgroup_init.
> - Clear the reclaim callback in amdgpu_vram_mgr_fini() to prevent
> =C2=A0 use-after-free if cgroup reclaim is triggered after driver unbind
> =C2=A0 while userspace holds an open DRM file descriptor. (Sashiko-bot)
> - Switch from drmm_cgroup_register_region() to the raw
> =C2=A0 dmem_cgroup_register_region() and store the region in
> =C2=A0 amdgpu_vram_mgr.cg_region. Call dmem_cgroup_unregister_region()
> =C2=A0 in amdgpu_vram_mgr_fini() after ttm_resource_manager_evict_all()
> =C2=A0 to drain in-flight reclaim callbacks, and clear man->cg afterwards=
.
> =C2=A0 This is required because amdgpu's vram manager fini is called
> =C2=A0 explicitly during driver unbind, which may precede the DRM device
> =C2=A0 release and thus precede any drmm-based cleanup. (Sashiko-bot)
>=20
> v6:
> - Fix mgr->cg_region never being assigned, so
> =C2=A0 dmem_cgroup_unregister_region() in fini silently no-ops on NULL
> =C2=A0 and leaks the region. (Sashiko-bot)
> - Reorder fini to call set_used(false) and evict_all() before
> =C2=A0 dmem_cgroup_unregister_region(), so ttm_resource_free() can
> =C2=A0 uncharge via man->cg during eviction; clear man->cg after
> =C2=A0 unregister. (Sashiko-bot)
>=20
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 31 ++++++++++++++++-=
-
> --
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |=C2=A0 2 ++
> =C2=A03 files changed, 28 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2740de94e93c..8cbcd33f51a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1488,7 +1488,7 @@ static bool
> amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
> =C2=A0	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
> =C2=A0				DMA_RESV_USAGE_BOOKKEEP, f) {
> =C2=A0		if (amdkfd_fence_check_mm(f, current->mm) &&
> -		=C2=A0=C2=A0=C2=A0 !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
> +		=C2=A0=C2=A0=C2=A0 !(place && (place->flags &
> TTM_PL_FLAG_CONTIGUOUS)))
> =C2=A0			return false;
> =C2=A0	}
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 08f05c3aed1d..2250bab0970d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -906,6 +906,10 @@ static const struct ttm_resource_manager_func
> amdgpu_vram_mgr_func =3D {
> =C2=A0	.debug	=3D amdgpu_vram_mgr_debug
> =C2=A0};
> =C2=A0
> +static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops =3D {
> +	.reclaim =3D ttm_resource_manager_dmem_reclaim,
> +};

Probably might want to block reclaim after device unbind, just like xe.
I'll look at that for v7.

> +
> =C2=A0/**
> =C2=A0 * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
> =C2=A0 *
> @@ -917,6 +921,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device
> *adev)
> =C2=A0{
> =C2=A0	struct amdgpu_vram_mgr *mgr =3D &adev->mman.vram_mgr;
> =C2=A0	struct ttm_resource_manager *man =3D &mgr->manager;
> +	struct dmem_cgroup_region *cg;
> =C2=A0	int err;
> =C2=A0
> =C2=A0	ttm_resource_manager_init(man, &adev->mman.bdev,
> @@ -933,12 +938,16 @@ int amdgpu_vram_mgr_init(struct amdgpu_device
> *adev)
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> -	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev),
> "vram",
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(struct
> dmem_cgroup_init){
> -						.size =3D adev-
> >gmc.real_vram_size,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 });
> -	if (IS_ERR(man->cg))
> -		return PTR_ERR(man->cg);
> +	cg =3D dmem_cgroup_register_region(&(struct dmem_cgroup_init){
> +					=C2=A0=C2=A0=C2=A0=C2=A0 .size =3D adev-
> >gmc.real_vram_size,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D
> &amdgpu_vram_mgr_dmem_ops,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 .reclaim_priv =3D man,
> +					 }, "vram");
> +	if (IS_ERR(cg))
> +		return PTR_ERR(cg);
> +
> +	mgr->cg_region =3D cg;
> +	ttm_resource_manager_set_dmem_region(man, cg);
> =C2=A0
> =C2=A0	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr-
> >manager);
> =C2=A0	ttm_resource_manager_set_used(man, true);
> @@ -966,6 +975,16 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device
> *adev)
> =C2=A0	if (ret)
> =C2=A0		return;
> =C2=A0
> +	/*
> +	 * Drain any in-flight dmem cgroup reclaim callbacks and
> remove the
> +	 * region from the global list.=C2=A0 This must happen after
> evict_all()
> +	 * so that ttm_resource_free() can still uncharge via man-
> >cg while
> +	 * BOs are being evicted.
> +	 */
> +	dmem_cgroup_unregister_region(mgr->cg_region);
> +	mgr->cg_region =3D NULL;
> +	man->cg =3D NULL;
> +
> =C2=A0	mutex_lock(&mgr->lock);
> =C2=A0	list_for_each_entry_safe(rsv, temp, &mgr-
> >reservations_pending, blocks)
> =C2=A0		kfree(rsv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index 429a21a2e9b2..07103cddb335 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -36,6 +36,8 @@ struct amdgpu_vram_mgr {
> =C2=A0	atomic64_t vis_usage;
> =C2=A0	u64 default_page_size;
> =C2=A0	struct list_head allocated_vres_list;
> +	/** @cg_region: dmem cgroup region for VRAM; unregistered in
> fini. */
> +	struct dmem_cgroup_region *cg_region;
> =C2=A0};
> =C2=A0
> =C2=A0struct amdgpu_vres_task {

