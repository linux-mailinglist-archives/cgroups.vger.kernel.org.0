Return-Path: <cgroups+bounces-16299-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IId0NO5mFWqVUwcAu9opvQ
	(envelope-from <cgroups+bounces-16299-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:25:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECE5D33E1
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5C81302F4CB
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A53CE0A1;
	Tue, 26 May 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWm4i+KN"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023C3D648C;
	Tue, 26 May 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787479; cv=none; b=jLSOyUwWt7oQLBgBu/K7VnsASXuibskhoq2Z0uxlgjDZG4FWN1/UWFebpNRmj6pz68ufvVRyQPhhoL24OmSVdou/rT62L3O9XMUZ4mFluDeEpXgC4VZcSrYFBuwBy2Qk60eFm8pBkFlCgY/m284V5X3A0aOYR9chJQbdgBklSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787479; c=relaxed/simple;
	bh=UxK94y3fWJzZjnLNI4RnnCb0k4ycYwtk98jPwkRyCi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIy2SopJJBLoTGxuUKvVG4jfiNlQxagRwKj6jIzgiVFnQr0G+Ptvjtptzdr46qFCPCpSZ1XThNoeN8WwJnWpFtRcSyX9a+pGnbH0J2jgPqncIr4CJK0n7AzkGvdokR2BPxyz3tCES2i0Lpmjm271x2uDoQW8Hx1KtwOtfclmXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWm4i+KN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779787477; x=1811323477;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UxK94y3fWJzZjnLNI4RnnCb0k4ycYwtk98jPwkRyCi0=;
  b=TWm4i+KNLG2ShG40rck1kFyA/afERwuJvtqsWlB7gpk5xYxfwdkNAyHL
   9ZdYaz5XSv8Vz83eanDAZ0AdPJqxEf8+GLOn9V8CdlAlHgbl2MdTQYS3B
   I+9MF/S9BuLpFudre9ZF7YA0Fh0tR/qksjybgGoAy/Zsi8vc8wCwMcuQq
   85DpAaQAvY2GniK7YOOOMmh3Jl8UNQGioBaalwXIh4EZKDYkKv8e5fvYF
   T/8UERiAwjE4Cd6sZPSw0QrijIKuiTD4XGWTYDQpH6ZUFifxrzX7uVaUg
   WKQTfDKlxHPTIFec46M5d3Fuws4wIBu9tefvnTEZnoFcW6wvvy6CusInj
   w==;
X-CSE-ConnectionGUID: 2iX0O5NwTjWtdLLh/+blag==
X-CSE-MsgGUID: C0ZdWb/fSJ6PmOIv+iySBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80710492"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80710492"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:24:36 -0700
X-CSE-ConnectionGUID: slU2VGj9TbGua5O+IiR8Gw==
X-CSE-MsgGUID: uKFXlOePQ0ypZtjRo5w26Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="245900357"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.115]) ([10.245.244.115])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:24:32 -0700
Message-ID: <b797a2aaa1bcef239a2eba449043dd278b9fa51a.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/5] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
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
Date: Tue, 26 May 2026 11:24:29 +0200
In-Reply-To: <9fe89d8e-9c32-4b03-ac2c-a634f5d4de0c@linux.intel.com>
References: <20260512082406.44470-1-thomas.hellstrom@linux.intel.com>
	 <20260512082406.44470-3-thomas.hellstrom@linux.intel.com>
	 <9fe89d8e-9c32-4b03-ac2c-a634f5d4de0c@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-16299-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4CECE5D33E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Maarten,

Thanks for reviewing.

On Tue, 2026-05-26 at 10:27 +0200, Maarten Lankhorst wrote:
> Hello,
>=20
> Den 2026-05-12 kl. 10:24, skrev Thomas Hellstr=C3=B6m:
> > Add an optional reclaim callback to struct dmem_cgroup_region. When
> > dmem.max is set below the current usage of a cgroup pool, the new
> > limit
> > is applied immediately (so that concurrent allocations are
> > throttled
> > while reclaim is in progress) and then the driver is asked to evict
> > memory to bring usage back below the limit.
> >=20
> > Reclaim is attempted up to a bounded number of times. No error is
> > returned to userspace if usage remains above the limit after
> > reclaim,
> > and a pending signal will abort the reclaim loop early. This
> > matches
> > the behavior of memory.max in the memory cgroup controller.
> >=20
> > Also honor O_NONBLOCK so that if that flag is set during the
> > max value write, no reclaim is initiated. The idea is to avoid
> > charging the reclaim cost to the writer of the max value.
> >=20
> > v2:
> > - Write max before reclaim is attempted (Maarten)
> > - Let signals abort the reclaim without error (Maarten)
> > - If a new max value is written with the O_NONBLOCK flag,
> > =C2=A0 reclaim is not attempted (Maarten)
> > - Extract region from the pool parameter rather than
> > =C2=A0 passing it explicitly to set_resource_xxx().
> > v3:
> > - Use an rwsem to protect reclaim callback registration and
> > =C2=A0 region unregister against concurrent reclaim invocations,
> > =C2=A0 ensuring reclaim_priv is visible when the callback is
> > =C2=A0 invoked. (Sashiko-bot)
> >=20
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0include/linux/cgroup_dmem.h |=C2=A0 24 ++++++++
> > =C2=A0kernel/cgroup/dmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
106
> > +++++++++++++++++++++++++++++++++---
> > =C2=A02 files changed, 121 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/linux/cgroup_dmem.h
> > b/include/linux/cgroup_dmem.h
> > index dd4869f1d736..c3bce21cbe80 100644
> > --- a/include/linux/cgroup_dmem.h
> > +++ b/include/linux/cgroup_dmem.h
> > @@ -14,6 +14,21 @@ struct dmem_cgroup_pool_state;
> > =C2=A0/* Opaque definition of a cgroup region, used internally */
> > =C2=A0struct dmem_cgroup_region;
> > =C2=A0
> > +/**
> > + * typedef dmem_cgroup_reclaim_fn_t - Reclaim callback for a dmem
> > cgroup region.
> > + * @pool: The cgroup pool that needs memory reclaimed.
> > + * @target_bytes: Minimum number of bytes the driver should
> > attempt to free.
> > + * @priv: Private data registered with
> > dmem_cgroup_region_set_reclaim().
> > + *
> > + * Called by the dmem cgroup controller when dmem.max is set below
> > the current
> > + * usage of @pool. The driver should evict at least @target_bytes
> > of memory
> > + * from @pool. May be called multiple times if usage remains above
> > the limit.
> > + *
> > + * Return: 0 if progress was made, negative error code otherwise.
> > + */
> > +typedef int (*dmem_cgroup_reclaim_fn_t)(struct
> > dmem_cgroup_pool_state *pool,
> > +					u64 target_bytes, void
> > *priv);
> > +
> > =C2=A0#if IS_ENABLED(CONFIG_CGROUP_DMEM)
> > =C2=A0struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size,
> > const char *name_fmt, ...) __printf(2,3);
> > =C2=A0void dmem_cgroup_unregister_region(struct dmem_cgroup_region
> > *region);
> > @@ -26,6 +41,9 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ignore_low, bool
> > *ret_hit_low);
> > =C2=A0
> > =C2=A0void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
> > *pool);
> > +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
> > *region,
> > +				=C2=A0=C2=A0=C2=A0 dmem_cgroup_reclaim_fn_t
> > reclaim,
> > +				=C2=A0=C2=A0=C2=A0 void *priv);
> > =C2=A0#else
> > =C2=A0static inline __printf(2,3) struct dmem_cgroup_region *
> > =C2=A0dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> > @@ -62,5 +80,11 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0static inline void dmem_cgroup_pool_state_put(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0{ }
> > =C2=A0
> > +static inline void
> > +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmem_cgroup_reclaim_fn_t recla=
im,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv)
> > +{ }
> > +
> > =C2=A0#endif
> > =C2=A0#endif	/* _CGROUP_DMEM_H */
> > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > index 1ab1fb47f271..5fd5a1634d21 100644
> > --- a/kernel/cgroup/dmem.c
> > +++ b/kernel/cgroup/dmem.c
> > @@ -51,6 +51,20 @@ struct dmem_cgroup_region {
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
> > +	dmem_cgroup_reclaim_fn_t reclaim;
> > +
> > +	/** @reclaim_priv: Private data passed to @reclaim. */
> > +	void *reclaim_priv;
> > +
> > +	/** @unregister_sem: Protect @reclaim while it is running.
> > */
> > +	struct rw_semaphore unregister_sem;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct dmemcg_state {
> > @@ -145,21 +159,58 @@ static void free_cg_pool(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void
> > -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
> > bool nonblock)
> > =C2=A0{
> > =C2=A0	page_counter_set_min(&pool->cnt, val);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void
> > -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
> > bool nonblock)
> > =C2=A0{
> > =C2=A0	page_counter_set_low(&pool->cnt, val);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void
> > -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
> > bool nonblock)
> > =C2=A0{
> > -	page_counter_set_max(&pool->cnt, val);
> > +	struct dmem_cgroup_region *region =3D pool->region;
> > +
> > +	/*
> > +	 * Always update the limit, even if usage currently
> > exceeds it.
> > +	 * Concurrent allocations will be throttled against the
> > new limit
> > +	 * while reclaim is in progress.
> > +	 */
> > +	xchg(&pool->cnt.max, (unsigned long)val);
> > +
> > +	if (nonblock || !READ_ONCE(region->reclaim))
> > +		return;
> > +
> > +	for (int retries =3D 5; retries > 0; retries--) {
> Where does 5 come from? This code should retry until no longer above
> limit, otherwise you'll get some hard to debug issues.

The memcg controller uses MAX_RECLAIM_RETRIES, although if that fails,
it will invoke the OOM killer, although if the reclaim callback makes
progress, it will not consume a retry. Perhaps we should adopt the same
behaviour except the OOM killer, at least for now. Note that if a
signal is pending, the reclaim attempt is abandoned both here and in
memcg.


>=20
> > +		u64 usage =3D page_counter_read(&pool->cnt);
> > +		int ret;
> > +
> > +		if (usage <=3D val)
> > +			break;
> > +
> > +		if (signal_pending(current))
> > +			break;
> > +
> > +		/* Block unregister until the reclaim callback
> > completes. */
> > +		if (down_read_interruptible(&region-
> > >unregister_sem))
> > +			break;
> > +
> > +		if (!region->reclaim) {
> > +			up_read(&region->unregister_sem);
> > +			break;
> > +		}
> > +
> > +		ret =3D region->reclaim(pool, usage - val, region-
> > >reclaim_priv);
> > +		up_read(&region->unregister_sem);
> > +		if (ret)
> > +			break;
> > +
> > +		cond_resched();
> > +	}
> > =C2=A0}
> > =C2=A0
> > =C2=A0static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
> > @@ -184,9 +235,9 @@ static u64 get_resource_current(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0
> > =C2=A0static void reset_all_resource_limits(struct
> > dmem_cgroup_pool_state *rpool)
> > =C2=A0{
> > -	set_resource_min(rpool, 0);
> > -	set_resource_low(rpool, 0);
> > -	set_resource_max(rpool, PAGE_COUNTER_MAX);
> > +	set_resource_min(rpool, 0, false);
> > +	set_resource_low(rpool, 0, false);
> > +	set_resource_max(rpool, PAGE_COUNTER_MAX, false);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void dmemcs_offline(struct cgroup_subsys_state *css)
> > @@ -491,6 +542,12 @@ void dmem_cgroup_unregister_region(struct
> > dmem_cgroup_region *region)
> > =C2=A0	region->unregistered =3D true;
> > =C2=A0	spin_unlock(&dmemcg_lock);
> > =C2=A0
> > +	/* Ensure all reclaim() callbacks have finished. */
> > +	down_write(&region->unregister_sem);
> > +	/* Pairs with READ_ONCE() in set_resource_max() */
> > +	WRITE_ONCE(region->reclaim, NULL);
> > +	up_write(&region->unregister_sem);
> > +
> > =C2=A0	kref_put(&region->ref, dmemcg_free_region);
> > =C2=A0}
> I've thought about it some more, Can we do the same as dma-buf init?
>=20
> DEFINE_DMEMCG_REGION_INFO(info);
> info.size =3D size.
> info.ops =3D &drm_ttm_dmem_region_ops;
> info.region_priv =3D ttm_region;
> info.device_priv =3D drm_dev;
>=20
> dmem_region =3D dmem_cgroup_register_region(&info);
>=20
> This way we don't need to have a typedef for function pointers,
> no need for READ_ONCE() and/or additional locking, which was only
> added because it wasn't set at init.
>=20
> If we can push the responsibility for serialization against unload
> to the driver, we should also be able to use drm_dev_enter/exit here
> for the reclaim loop?
>=20
> Something like below:
>=20
> if (!ops->device_begin(device_priv, &cookie))
> 	return 0; // Device gone
>=20
> while (true) {
> 	ops->reclaim(region_priv, ...);
> }
>=20
> ops->device_end(device_priv, cookie);
>=20
> Although we will additionally need to ensure that the region holds a
> refcount on
> reclaim_priv until dmemcg_free_region is called, otherwise this
> breaks.
>=20
> So 4 ops needed:
> - device_begin
> - reclaim
> - device_end
> - free (called after region refcount drops to 0, called immediately
> on !CONFIG_DMEMCG, drops device refcount)
>=20
> Relatedly, I believe perhaps we should also convert from drmm managed
> to devm managed,
> as all memory is already freed after the device is physically
> detached.
>=20
> Hopefully this solves all lifetime issues, and this design allows for
> additional callbacks into the device or region later on if needed.

Let me take a look at this.
/Thomas


>=20
> Kind regards,
> ~Maarten Lankhorst
>=20
> > =C2=A0EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
> > @@ -530,6 +587,7 @@ struct dmem_cgroup_region
> > *dmem_cgroup_register_region(u64 size, const char *fmt
> > =C2=A0	INIT_LIST_HEAD(&ret->pools);
> > =C2=A0	ret->name =3D region_name;
> > =C2=A0	ret->size =3D size;
> > +	init_rwsem(&ret->unregister_sem);
> > =C2=A0	kref_init(&ret->ref);
> > =C2=A0
> > =C2=A0	spin_lock(&dmemcg_lock);
> > @@ -568,6 +626,34 @@ void dmem_cgroup_pool_state_put(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
> > =C2=A0
> > +/**
> > + * dmem_cgroup_region_set_reclaim() - Register a reclaim callback
> > on a region.
> > + * @region: The region to register the callback for.
> > + * @reclaim: Callback to invoke when dmem.max is set below current
> > usage.
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Called =
with the pool that needs reclaiming and the
> > number of
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes t=
o free. Returns 0 on progress, negative on
> > failure.
> > + * @priv: Opaque pointer passed back to @reclaim.
> > + *
> > + * When dmem.max is lowered below the current usage of a cgroup
> > pool, the
> > + * dmem controller will call @reclaim with a target number of
> > bytes to free.
> > + * After @reclaim returns the controller retries setting the
> > limit; if usage
> > + * is still too high it calls @reclaim again, up to a bounded
> > retry count.
> > + */
> > +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
> > *region,
> > +				=C2=A0=C2=A0=C2=A0 dmem_cgroup_reclaim_fn_t
> > reclaim,
> > +				=C2=A0=C2=A0=C2=A0 void *priv)
> > +{
> > +	if (!region)
> > +		return;
> > +
> > +	down_write(&region->unregister_sem);
> > +	region->reclaim_priv =3D priv;
> > +	/* Pairs with READ_ONCE() in set_resource_max() */
> > +	WRITE_ONCE(region->reclaim, reclaim);
> > +	up_write(&region->unregister_sem);
> > +}
> > +EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
> > +
> > =C2=A0static struct dmem_cgroup_pool_state *
> > =C2=A0get_cg_pool_unlocked(struct dmemcg_state *cg, struct
> > dmem_cgroup_region *region)
> > =C2=A0{
> > @@ -725,9 +811,10 @@ static int dmemcg_parse_limit(char *options,
> > u64 *new_limit)
> > =C2=A0
> > =C2=A0static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
> > =C2=A0				 char *buf, size_t nbytes, loff_t
> > off,
> > -				 void (*apply)(struct
> > dmem_cgroup_pool_state *, u64))
> > +				 void (*apply)(struct
> > dmem_cgroup_pool_state *, u64, bool))
> > =C2=A0{
> > =C2=A0	struct dmemcg_state *dmemcs =3D css_to_dmemcs(of_css(of));
> > +	bool nonblock =3D of->file->f_flags & O_NONBLOCK;
> > =C2=A0	int err =3D 0;
> > =C2=A0
> > =C2=A0	while (buf && !err) {
> > @@ -772,7 +859,8 @@ static ssize_t dmemcg_limit_write(struct
> > kernfs_open_file *of,
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		/* And commit */
> > -		apply(pool, new_limit);
> > +		apply(pool, new_limit, nonblock);
> > +
> > =C2=A0		dmemcg_pool_put(pool);
> > =C2=A0
> > =C2=A0out_put:

