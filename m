Return-Path: <cgroups+bounces-15532-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFkZH86I8GloUgEAu9opvQ
	(envelope-from <cgroups+bounces-15532-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:15:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3C482688
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2218E3088B83
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522073E0C62;
	Tue, 28 Apr 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3NzFuBF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82982BF006;
	Tue, 28 Apr 2026 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370565; cv=none; b=u3Nfwst7iCfkEb+oouOOozyIPYyzJdNK536Abj5KE1cy7z62xvYeReYNeZfREBRg8AobkAHVs++97/YwCk/wk9ZOYGQgASkJ7P3VY3CTkstRvN5X1WYQGbxGSjya16fpza1MnZavUW9XBfT5Arvk5lLvwAB+Y8lKoqb8yiGsM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370565; c=relaxed/simple;
	bh=O/fX+/fwObLkLagIKKIXphtPD052eF9ODtQPNirPNA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+PxEPGGitg36Sa10lQwlirXYIFJ/Qdb4JMg6/WRvhg5XuTelQ/O+Edk8xtBImQ7Oe/GhGmMiHPQmhCAejrJilkWvvdjhfzpdhRxp4II+XPlMbDWj2vu5OKdDohXjezINglITDsf4hUOQU3KnAHdUmSrNJhVUKIf/rcaXmgI5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3NzFuBF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370564; x=1808906564;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O/fX+/fwObLkLagIKKIXphtPD052eF9ODtQPNirPNA4=;
  b=J3NzFuBFmoMRylGkOoE1IAEqHqat0UYT2HrAbFLvcizR20w2vrxq7F/s
   5vuAsHbaYJXIjYrij1MUQ0XyCyMzbjjKGnjbs0CM1SeiL+c0Pfu9nRSXC
   5FRS6Ah1acGbwyMr2KsuxcBdoPPU0gqrimOUtWGuGTBJnYDAo7vogMexy
   w1c2WwoPe6dYdZ7fZhKWMgrnZf1EvyTshi03e6tp5shLlKkEdTRUIrDYD
   4N/EDsNoTsShOgX0CkI8bbeda+FBHCSdLaMlpMeRSH/gXEZNkUOyMqnN9
   Yt/fXsMhxkPCMrMljfCY55bWSxlk5zk4e11O6dYWkA6OEYixkC1madlMu
   Q==;
X-CSE-ConnectionGUID: f/GRv2y4QsibS2dhw9iSgg==
X-CSE-MsgGUID: mmHgvJnJT0y9pjHlTx3pAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89654107"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89654107"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:02:40 -0700
X-CSE-ConnectionGUID: 0QLQBZ8kQU2MR6y1L+2CLQ==
X-CSE-MsgGUID: zz6QLTN/RV2NA1bgXxOy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="257222117"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.33]) ([10.245.245.33])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:02:36 -0700
Message-ID: <5d36326b1b9c009cd544fe5ca195ae484dbbc915.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter	 <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 12:02:31 +0200
In-Reply-To: <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
	 <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
	 <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
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
X-Rspamd-Queue-Id: CEA3C482688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-15532-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]

On Tue, 2026-04-28 at 11:50 +0200, Maarten Lankhorst wrote:
>=20
>=20
> Den 2026-04-28 kl. 09:31, skrev Thomas Hellstr=C3=B6m:
> > Register the VRAM manager with the dmem cgroup reclaim
> > infrastructure
> > so that lowering dmem.max below current VRAM usage triggers TTM
> > eviction rather than failing with -EBUSY.
> >=20
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 19 ++++++++++++-------
> > =C2=A01 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > index 5fd0d5506a7e..1bdcb3fee901 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > @@ -303,13 +303,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device
> > *xe, struct xe_ttm_vram_mgr *mgr,
> > =C2=A0	struct ttm_resource_manager *man =3D &mgr->manager;
> > =C2=A0	int err;
> > =C2=A0
> > -	if (mem_type !=3D XE_PL_STOLEN) {
> > -		const char *name =3D mem_type =3D=3D XE_PL_VRAM0 ?
> > "vram0" : "vram1";
> > -		man->cg =3D drmm_cgroup_register_region(&xe->drm,
> > name, size);
> > -		if (IS_ERR(man->cg))
> > -			return PTR_ERR(man->cg);
> > -	}
> > -
> > =C2=A0	man->func =3D &xe_ttm_vram_mgr_func;
> > =C2=A0	mgr->mem_type =3D mem_type;
> > =C2=A0	mutex_init(&mgr->lock);
> > @@ -318,6 +311,18 @@ int __xe_ttm_vram_mgr_init(struct xe_device
> > *xe, struct xe_ttm_vram_mgr *mgr,
> > =C2=A0	mgr->visible_avail =3D io_size;
> > =C2=A0
> > =C2=A0	ttm_resource_manager_init(man, &xe->ttm, size);
> > +
> > +	if (mem_type !=3D XE_PL_STOLEN) {
> > +		const char *name =3D mem_type =3D=3D XE_PL_VRAM0 ?
> > "vram0" : "vram1";
> > +		struct dmem_cgroup_region *cg =3D
> > +			drmm_cgroup_register_region(&xe->drm,
> > name, size);
> > +
> > +		if (IS_ERR(cg))
> > +			return PTR_ERR(cg);
> > +
> > +		ttm_resource_manager_set_dmem_region(man, cg);
> > +	}
> > +
> > =C2=A0	err =3D gpu_buddy_init(&mgr->mm, man->size,
> > default_page_size);
> > =C2=A0	if (err)
> > =C2=A0		return err;
>=20
> This patch will conflict with=20
> https://patchwork.freedesktop.org/series/164694/=C2=A0which removes
> stolen support, can we merge that patch first while we wait for AMD
> acks?

Sure, np.

>=20
> Do I need an ack to get the series through drm-misc?

Which series? The stolen support or this cgroup series?

Thanks,
Thomas


>=20
> Kind regards,
> ~Maarten Lankhorst

