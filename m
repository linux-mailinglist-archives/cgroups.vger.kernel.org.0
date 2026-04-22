Return-Path: <cgroups+bounces-15453-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJJiLlyK6Gk6LgIAu9opvQ
	(envelope-from <cgroups+bounces-15453-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 10:44:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259F4439A6
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD1C9300EF77
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C7346A0C;
	Wed, 22 Apr 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXsGc3WR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78252D8DB0;
	Wed, 22 Apr 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847341; cv=none; b=XzjmiyclEiXBzro2L1ELbgMS9k0hJxg10cePX4O6hsCBDazndG9RaUoJ3b+d1eN4MIrYjshtUY3AZ+tRzZ45uwk+X+N0ovyRtjiskiNF5UZYQaR8hzdKYaNaVvV1Kv2o/tSvMCssVBtbPe243P/U1l/dAD5fzYIAdfmaAMDExS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847341; c=relaxed/simple;
	bh=tgT/NiGuGyLMbkWXDtIGFUpu0M7Z2r7OkRxVmJlcCgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVfmju6fBeAVFFlfbZDa7vEvINi4mnktwYN4ihXVNZODHewWs4Y/7epieMwzZ9lZYDDuDjVWBRFQOVU5Q5WOZPLTH3yoZqfvZ3yXlB0td7kyIMOMNLTUDlIA/uG2Gsr1MaXtLNBSDnjxtFyr4PvItrnefcu5RogeNTHHiJwVVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXsGc3WR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847339; x=1808383339;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tgT/NiGuGyLMbkWXDtIGFUpu0M7Z2r7OkRxVmJlcCgE=;
  b=FXsGc3WRxvD2602PJK2QFWWsNEwvhf0qoG1qzJDpn7j9aXbStw4f1wvC
   hmJN0VQyRJzCWJAKoxwiYA0vN1Ae4T0Qpp6zuTdKG2h1COYTP+fHIMfen
   ipIPHPmCed92B/smSr+KKnjIVSlqR4fEhS1rSPOpKM9u87VL1478hlptC
   vqbYoqV997EorYI0nF4/l8iBey+WinYFdgLre5ZHuGQ7awechtEMXXat1
   0qIBNrv8m5/5iBG0jvnIP4l41G6kBAB5sSGSdCBPi9rvS/h5eQxwPbFlo
   GKLf91oHqnR6OvB+GtHo8EqQMUoxiPf8o1M6tqDvt6HCV/CEg1nCdWbZZ
   g==;
X-CSE-ConnectionGUID: TxFVNrZ+RUSe/kkqbU5sUg==
X-CSE-MsgGUID: jSxHDGNbQKSOHP5Kb3NV3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77709167"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77709167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:42:19 -0700
X-CSE-ConnectionGUID: +U/3/pmqSB6F1hgjJ5IJAg==
X-CSE-MsgGUID: Wm3z3MPtR3q2gdxyy2cDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255775796"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.239]) ([10.245.245.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:42:14 -0700
Message-ID: <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
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
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org, Thadeu Lima
 de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 22 Apr 2026 10:42:11 +0200
In-Reply-To: <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
	 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
	 <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org,igalia.com];
	TAGGED_FROM(0.00)[bounces-15453-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 2259F4439A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 10:31 +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> (Adding Thadeu to cc since they've been working on the same issue)
>=20
> Den 2026-03-27 kl. 09:15, skrev Thomas Hellstr=C3=B6m:
> > Add an optional reclaim callback to struct dmem_cgroup_region.=C2=A0
> > When
> > dmem.max is set below current usage, invoke the callback to evict
> > memory
> > and retry setting the limit rather than failing immediately.=C2=A0
> > Signal
> > interruptions propagate back to the write() caller.
> >=20
> > RFC:
> > Due to us updating the max limit _after_ the usage has been
> > sufficiently lowered, this should be prone to failures if there are
> > aggressive allocators running in parallel to the reclaim.
> > So can we somehow enforce the new limit while the eviction is
> > happening?
> >=20
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0include/linux/cgroup_dmem.h | 11 +++++
> > =C2=A0kernel/cgroup/dmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
94
> > +++++++++++++++++++++++++++++++++----
> > =C2=A02 files changed, 96 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/linux/cgroup_dmem.h
> > b/include/linux/cgroup_dmem.h
> > index dd4869f1d736..61520a431740 100644
> > --- a/include/linux/cgroup_dmem.h
> > +++ b/include/linux/cgroup_dmem.h
> > @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ignore_low, bool
> > *ret_hit_low);
> > =C2=A0
> > =C2=A0void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
> > *pool);
> > +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
> > *region,
> > +				=C2=A0=C2=A0=C2=A0 int (*reclaim)(struct
> > dmem_cgroup_pool_state *pool,
> > +						=C2=A0=C2=A0 u64
> > target_bytes, void *priv),
> > +				=C2=A0=C2=A0=C2=A0 void *priv);
> > =C2=A0#else
> > =C2=A0static inline __printf(2,3) struct dmem_cgroup_region *
> > =C2=A0dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> > @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0static inline void dmem_cgroup_pool_state_put(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0{ }
> > =C2=A0
> > +static inline void
> > +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*reclaim)(struct
> > dmem_cgroup_pool_state *pool,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 target_bytes,
> > void *priv),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv)
> > +{ }
> > +
> > =C2=A0#endif
> > =C2=A0#endif	/* _CGROUP_DMEM_H */
> > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > index 3e6d4c0b26a1..f993fb058b74 100644
> > --- a/kernel/cgroup/dmem.c
> > +++ b/kernel/cgroup/dmem.c
> > @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
> > =C2=A0	 * No new pools should be added to the region afterwards.
> > =C2=A0	 */
> > =C2=A0	bool unregistered;
> > +
> > +	/**
> > +	 * @reclaim: Optional callback invoked when dmem.max is
> > set below the
> > +	 * current usage of a pool. The driver should attempt to
> > free at least
> > +	 * @target_bytes from @pool. May be called multiple times
> > if usage
> > +	 * remains above the limit after returning.
> > +	 */
> > +	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64
> > target_bytes,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv);
> > +
> > +	/** @reclaim_priv: Private data passed to @reclaim. */
> > +	void *reclaim_priv;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct dmemcg_state {
> > @@ -145,23 +157,59 @@ static void free_cg_pool(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
> > +		 struct dmem_cgroup_region *region)
> > =C2=A0{
> > =C2=A0	page_counter_set_min(&pool->cnt, val);
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
> > +		 struct dmem_cgroup_region *region)
> > =C2=A0{
> > =C2=A0	page_counter_set_low(&pool->cnt, val);
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
> > +		 struct dmem_cgroup_region *region)
> > =C2=A0{
> > -	return page_counter_set_max(&pool->cnt, val);
> > +	int err =3D page_counter_set_max(&pool->cnt, val);
> > +
> > +	if (err !=3D -EBUSY || !region || !region->reclaim)
> > +		return err;
> > +
> > +	/*
> > +	 * The new max is below current usage.=C2=A0 Ask the driver to
> > evict memory
> > +	 * and retry, up to a bounded number of times.=C2=A0 Signal
> > interruptions are
> > +	 * propagated back to the write() caller; other reclaim
> > failures leave
> > +	 * -EBUSY as the result.
> > +	 */
> > +	for (int retries =3D 5; retries > 0; retries--) {
> > +		u64 usage =3D page_counter_read(&pool->cnt);
> > +		u64 target =3D usage > val ? usage - val : 0;
> > +		int reclaim_err;
> > +
> > +		if (!target) {
> > +			err =3D page_counter_set_max(&pool->cnt,
> > val);
> > +			break;
> > +		}
> > +
> > +		reclaim_err =3D region->reclaim(pool, target,
> > region->reclaim_priv);
> > +		if (reclaim_err) {
> > +			if (reclaim_err =3D=3D -EINTR || reclaim_err
> > =3D=3D -ERESTARTSYS)
> > +				err =3D reclaim_err;
> > +			break;
> > +		}
> > +
> > +		err =3D page_counter_set_max(&pool->cnt, val);
> > +		if (err !=3D -EBUSY)
> > +			break;
> > +	}
> > +
> > +	return err;
> > =C2=A0}
>=20
> I mentioned this in chat but I wanted to mention it on the mailing
> list for others as well,
> can we reproduce the behavior from memory_max_write() in
> mm/memcontrol.c?
>=20
> 1. First set new limit through xchg.
> 2. If O_NONBLOCK is set -> do nothing, next allocation in target
> region will fail and cause reclaim.
> 3. If not set -> reclaim until below new limit or interrupted by a
> signal, return success in all cases here since we set new limit.
>=20
>=20

Yup.

For 3, we also need to consider the case where we fail to reclaim due
to memory being pinned. If it's OK to (usually temporary) have current
usage above max, that would work.

I have that coded up and also add a patch on top to defer reclaim to a
thread if we bail due to signal or O_NONBLOCK. Perhaps we could discuss
whether that's a good or bad idea in that patch.

Will send out when I've updated the IGT tests accordingly.

Thanks,
Thomas



