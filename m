Return-Path: <cgroups+bounces-6793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD40A4CC33
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75F318960E3
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BD230BCC;
	Mon,  3 Mar 2025 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSTW6dm0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64E1FFC60
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031431; cv=none; b=N3XcHw1GPxKt6K1zfspBNMaAApkBcqxXIIxFgSPraSVqMpFuwNyHAQvhnglBXKKn+Xe+QpgSptZ0tiPmwHVAu+bltvxs6uKBFWTmsR47/YB9U8ONSylyfHFUumw2dK/PLGo0YmJemvEV/S1imnwqQcJKy/YYARuoAsfGucqxgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031431; c=relaxed/simple;
	bh=ZU0M7Anqfy7Eli52hp/YXmoHUhP0l/20cqtBhGdEmtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbOAnoWPblUuwj4tTP82E5lohnMXfJNeyhbLpuWg89UjNE2YyRpbh0nY7QSmPGYvsHmS7Cgwr2eWbsVdFl+az+39roGGTrhSUSfPKlKnXyhjxI06SuU1bOgQWec+wviQWvyjgA9Se3/sKsYhEGSfSDfM4MpoOUcnYAbaWFLnrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSTW6dm0; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 19:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741031425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3fB94flygGoLPiPIqeiergtpOByBNOlrdyc4hB6M+Y=;
	b=mSTW6dm0PfRZGDt8QUW6jKXrSGRmZeOCERlxq6fbRDZBujkqfDXww33bheGf8317dP02nc
	ek8x2N4xmYP+FYVXAnhGItZAVk3KnqaQf0jfMMZy71/5JNRxIOnP0Soro9+zxoJPI8KBTz
	IVA0IwwnIjNhlNaaVl8KAMw1139J8Xc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	inwardvessel <inwardvessel@gmail.com>, tj@kernel.org,
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <Z8YH_FjMQSvDOe1f@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 10:40:45AM -0800, Shakeel Butt wrote:
> On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed wrote:
> > On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
> > > On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
> > > > From: JP Kobryn <inwardvessel@gmail.com>
> > > ...
> > > > +static inline bool is_base_css(struct cgroup_subsys_state *css)
> > > > +{
> > > > +	return css->ss == NULL;
> > > > +}
> > > 
> > > Similar predicate is also used in cgroup.c (various cgroup vs subsys
> > > lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
> > > unified, i.e. open code the predicate here or use the helper in both
> > > cases (css_is_cgroup() or similar).
> > > 
> > > >  void __init cgroup_rstat_boot(void)
> > > >  {
> > > > -	int cpu;
> > > > +	struct cgroup_subsys *ss;
> > > > +	int cpu, ssid;
> > > >  
> > > > -	for_each_possible_cpu(cpu)
> > > > -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > > > +	for_each_subsys(ss, ssid) {
> > > > +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> > > > +	}
> > > 
> > > Hm, with this loop I realize it may be worth putting this lock into
> > > struct cgroup_subsys_state and initializing them in
> > > cgroup_init_subsys() to keep all per-subsys data in one pack.
> > 
> > I thought about this, but this would have unnecessary memory overhead as
> > we only need one lock per-subsystem. So having a lock in every single
> > css is wasteful.
> > 
> > Maybe we can put the lock in struct cgroup_subsys? Then we can still
> > initialize them in cgroup_init_subsys().
> > 
> 
> Actually one of things I was thinking about if we can just not have
> per-subsystem lock at all. At the moment, it is protecting
> rstat_flush_next field (today in cgroup and JP's series it is in css).
> What if we make it a per-cpu then we don't need the per-subsystem lock
> all? Let me know if I missed something which is being protected by this
> lock.

I think it protects more than that. I remember locking into this before,
and the thing I remember is that stats themselves. Looking at
mem_cgroup_stat_aggregate(), we aggregate the stats into the per-cgroup
counters non-atomically. This is only protected by the rstat lock
(currently global, per-subsystem with the series) AFAICT.

Not sure if only the memory subsystem has this dependency or if others
do as well. I remember looking into switching these counters to atomics
to remove the global lock, but it performed worse IIRC.

I remember also looking into partioning the lock into a per-cgroup (or
per-css now?) lock, and only holding locks of the parent and child
cgroups as we flush each cgroup. I don't remember if I actually
implemented this, but it introduces complexity.

Perhaps we can defer the locking into the subsystem, if only the memory
controller requires it. In this case mem_cgroup_css_rstat_flush() (or
mem_cgroup_stat_aggregate()) can hold a memcg-specific spinlock only
while aggregating the stats.

There could be other things protected by the lock, but that's what I
remember.

