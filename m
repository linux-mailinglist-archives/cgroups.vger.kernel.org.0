Return-Path: <cgroups+bounces-17472-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tkzHE/y2R2rWdwAAu9opvQ
	(envelope-from <cgroups+bounces-17472-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:19:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142EE702C88
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WzjPc3x6;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17472-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17472-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CC673022968
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B223D45C8;
	Fri,  3 Jul 2026 13:11:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DA3D522F;
	Fri,  3 Jul 2026 13:11:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084274; cv=none; b=KE3GALKkZJon5kffjrP76Buu0a0H5aVDYAN0+2HUnMvPP6my2Ke2NNkEgRW7aUCu+AMEnC2SuOczSspMfduzVzcKovdrsgAflKBl9bIhVGWiFQiqMPMAxY9X2T3OnltnPJDVr8gP5LPlGU8r3Z7a8hKoIXb+ayUopMZo/7ug6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084274; c=relaxed/simple;
	bh=Xu8EYnocXkw9ykOGNuGA2OOtRFcNnzkugR791sAp83E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjkDVFVQndL5b5B1nKTzlXgTNP9NfSqSMq86YY+DI19lk9Nffhj9ajbFensgHZPEUk+33wQuFfFxBgsPGnHRD3mwuK2rtJ4rh8+ADxLJdh8iJqIecCThjD1FOwidgsDbKVeROe9O/0ZSr4hsMdpQ6jZ54s3Bn4LiIimnSpgcU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzjPc3x6; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084272; x=1814620272;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Xu8EYnocXkw9ykOGNuGA2OOtRFcNnzkugR791sAp83E=;
  b=WzjPc3x6i8oESGBR+4Sc+DjA3U3nwzUKfDN4ljZtUsEfPOMNQPndDcru
   BtlA7FRzXtv+EEue78JLxVKO6agwShptmFfGDZwiNpqkQEFI6rxBJsLca
   WbwUyBYCKCwGNB93DyCMfiHaUpIzT6EPajfJqeeRfF+4Ngo0umt9G7nWS
   4v+aFqFroSchIRsqfjEdYmDWCiMs74ZkYurzpS6ssMduZhEWIKnkTJWas
   H530gfP/bSQbT6hUQ7zwS8jWLsrKTq8gv1Fa3qLdSH2D2aqKtn4qIBwcP
   sGQ7JxpOIrgFEZeLUBZ3F5AAwluAkzL8VkA/j89yoDDVdIf2OuwbV+mqf
   Q==;
X-CSE-ConnectionGUID: IGuwcIpcS0CQLXKIPcYxJw==
X-CSE-MsgGUID: hG0c06xqTGq8RfhrRuMiSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84028519"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84028519"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:11:11 -0700
X-CSE-ConnectionGUID: e8FeLx5dSgKO/yHFp/+lug==
X-CSE-MsgGUID: l+f6gr/RSDWg7+8CNdy+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="248664380"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.146]) ([10.245.245.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:11:06 -0700
Message-ID: <92e3c9210c4038969b24c7b0f3df0a998587ff4c.camel@linux.intel.com>
Subject: Re: [PATCH v7 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	intel-xe@lists.freedesktop.org, "Paneer Selvam, Arunpravin"
	 <Arunpravin.PaneerSelvam@amd.com>
Cc: Sashiko-bot <sashiko-bot@kernel.org>, Friedrich Vock
 <friedrich.vock@gmx.de>,  Maarten Lankhorst	 <dev@lankhorst.se>, Tejun Heo
 <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,  Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 	stable@vger.kernel.org, Natalie Vock
 <natalie.vock@gmx.de>, Johannes Weiner	 <hannes@cmpxchg.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Simona Vetter	 <simona@ffwll.ch>, David Airlie
 <airlied@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org
Date: Fri, 03 Jul 2026 15:11:03 +0200
In-Reply-To: <9eae1a5c-d2ef-4d75-a581-58299ca37a1f@amd.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
	 <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
	 <9eae1a5c-d2ef-4d75-a581-58299ca37a1f@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17472-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:intel-xe@lists.freedesktop.org,m:Arunpravin.PaneerSelvam@amd.com,m:sashiko-bot@kernel.org,m:friedrich.vock@gmx.de,m:dev@lankhorst.se,m:tj@kernel.org,m:mripard@kernel.org,m:alexander.deucher@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:cascardo@igalia.com,m:rodrigo.vivi@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,lankhorst.se,amd.com,lists.freedesktop.org,vger.kernel.org,cmpxchg.org,suse.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 142EE702C88

On Fri, 2026-07-03 at 15:08 +0200, Christian K=C3=B6nig wrote:
> Arun please take a look at this.
>=20
> Thanks,
> Christian.

FWIW Sashiko claims there is yet another pre-existing bug WRT ordering
here, but since the fix wasn't needed for the rest of the series, I
focused on this one.

Thanks,
Thomas


>=20
> On 7/3/26 15:05, Thomas Hellstr=C3=B6m wrote:
> > drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
> > gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the
> > function
> > returns early and bypasses those initializations.
> >=20
> > Since adev->mman.initialized is set to true before
> > amdgpu_vram_mgr_init()
> > is called, a failure triggers amdgpu_ttm_fini(), which calls
> > amdgpu_vram_mgr_fini(), which then:
> >=20
> > =C2=A0- Calls list_for_each_entry_safe() on reservations_pending and
> > =C2=A0=C2=A0 reserved_pages, whose list_head::next pointers are zero-
> > initialized
> > =C2=A0=C2=A0 (NULL). The loop does not recognize them as empty and
> > dereferences NULL.
> >=20
> > =C2=A0- Calls gpu_buddy_fini(), which iterates free_trees[]
> > unconditionally
> > =C2=A0=C2=A0 via for_each_free_tree(). Since mm->free_trees is NULL
> > =C2=A0=C2=A0 (never allocated), this dereferences NULL.
> >=20
> > Both result in a kernel panic on the module load error path.
> >=20
> > Fix by moving drmm_cgroup_register_region() to after the list and
> > buddy
> > allocator are fully initialized, so the teardown path is safe to
> > run.
> >=20
> > Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> > Closes:
> > https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@=
linux.intel.com?part=3D4
> > Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in
> > TTM")
> > Cc: Friedrich Vock <friedrich.vock@gmx.de>
> > Cc: Maarten Lankhorst <dev@lankhorst.se>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 2a241a5b12c4..ac3f71d77140 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device
> > *adev)
> > =C2=A0	struct ttm_resource_manager *man =3D &mgr->manager;
> > =C2=A0	int err;
> > =C2=A0
> > -	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev),
> > "vram", adev->gmc.real_vram_size);
> > -	if (IS_ERR(man->cg))
> > -		return PTR_ERR(man->cg);
> > =C2=A0	ttm_resource_manager_init(man, &adev->mman.bdev,
> > =C2=A0				=C2=A0 adev->gmc.real_vram_size);
> > =C2=A0
> > @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device
> > *adev)
> > =C2=A0	if (err)
> > =C2=A0		return err;
> > =C2=A0
> > +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev),
> > "vram", adev->gmc.real_vram_size);
> > +	if (IS_ERR(man->cg))
> > +		return PTR_ERR(man->cg);
> > +
> > =C2=A0	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM,
> > &mgr->manager);
> > =C2=A0	ttm_resource_manager_set_used(man, true);
> > =C2=A0	return 0;

