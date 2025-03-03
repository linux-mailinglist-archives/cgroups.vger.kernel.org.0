Return-Path: <cgroups+bounces-6794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2723A4CC7A
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 21:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8FD18893CB
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88323237A;
	Mon,  3 Mar 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6WBQzx1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47421D8DEE
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032567; cv=none; b=QCH3sERZ8Hi7g+xL8nVXAkKG7bMCcbCXw/W7LPyZGeZOoU/eGFs5QS/N978Q+DnU4qA2y/IERvyMJlogilXt76vxlW5oy3w7AvHj6/EwELF+/bGagTjy0KgEMv0vAOPv0TG+ZWO/7ZddUduGxjZx/F9Nvjs6+4jqX/VUFBbQHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032567; c=relaxed/simple;
	bh=H/dm5sdPo5U2LvaLcZAFrqdzul9+hFk29UuKrEk/Vlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2Jzz9fyvUBUdOUuyltGC01sd5++WeVdty5tVTJiCwZu9ejZxD2h598AotB+R33tGeWNoAaUqDTNgRdbN3Fyqv4/ZlOYXj1yoWtHl++ws67cXEnXThN/YTdwQnEr8sxrUtccMKjfj/PCBvOTR7R113axX1yqcu2ZSM/B281sKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6WBQzx1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 12:09:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741032558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Th9D+rd8bSzLJID5iKQjkuUJMxydBwVvwzo4lZVXc4=;
	b=u6WBQzx1+XAEpc82Y/8kgGbNvs5bmHB3gzyZKj0gB5BwH+1SD5+hRkTv4tyFB1FkDCTRan
	xEn1e2ivvTnLP6Fknb35MLYfHBJPJKtWO/o/zcmmfV+FXzAy8YdXK3x57BQ6Js+oUmXBne
	g2/LYLijxSz2g7Gmju363Z6TitGpLHk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	inwardvessel <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <4u2evk2hcg4ynas4jom6hk45vcwgysjxlodhun3gmgbyld7krd@g66fne6mzt6y>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
 <Z8YH_FjMQSvDOe1f@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8YH_FjMQSvDOe1f@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 07:50:20PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 10:40:45AM -0800, Shakeel Butt wrote:
> > On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed wrote:
> > > On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
> > > > On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
> > > > > From: JP Kobryn <inwardvessel@gmail.com>
> > > > ...
> > > > > +static inline bool is_base_css(struct cgroup_subsys_state *css)
> > > > > +{
> > > > > +	return css->ss == NULL;
> > > > > +}
> > > > 
> > > > Similar predicate is also used in cgroup.c (various cgroup vs subsys
> > > > lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
> > > > unified, i.e. open code the predicate here or use the helper in both
> > > > cases (css_is_cgroup() or similar).
> > > > 
> > > > >  void __init cgroup_rstat_boot(void)
> > > > >  {
> > > > > -	int cpu;
> > > > > +	struct cgroup_subsys *ss;
> > > > > +	int cpu, ssid;
> > > > >  
> > > > > -	for_each_possible_cpu(cpu)
> > > > > -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > > > > +	for_each_subsys(ss, ssid) {
> > > > > +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> > > > > +	}
> > > > 
> > > > Hm, with this loop I realize it may be worth putting this lock into
> > > > struct cgroup_subsys_state and initializing them in
> > > > cgroup_init_subsys() to keep all per-subsys data in one pack.
> > > 
> > > I thought about this, but this would have unnecessary memory overhead as
> > > we only need one lock per-subsystem. So having a lock in every single
> > > css is wasteful.
> > > 
> > > Maybe we can put the lock in struct cgroup_subsys? Then we can still
> > > initialize them in cgroup_init_subsys().
> > > 
> > 
> > Actually one of things I was thinking about if we can just not have
> > per-subsystem lock at all. At the moment, it is protecting
> > rstat_flush_next field (today in cgroup and JP's series it is in css).
> > What if we make it a per-cpu then we don't need the per-subsystem lock
> > all? Let me know if I missed something which is being protected by this
> > lock.
> 
> I think it protects more than that. I remember locking into this before,
> and the thing I remember is that stats themselves. Looking at
> mem_cgroup_stat_aggregate(), we aggregate the stats into the per-cgroup
> counters non-atomically. This is only protected by the rstat lock
> (currently global, per-subsystem with the series) AFAICT.
> 
> Not sure if only the memory subsystem has this dependency or if others
> do as well. I remember looking into switching these counters to atomics
> to remove the global lock, but it performed worse IIRC.
> 
> I remember also looking into partioning the lock into a per-cgroup (or
> per-css now?) lock, and only holding locks of the parent and child
> cgroups as we flush each cgroup. I don't remember if I actually
> implemented this, but it introduces complexity.
> 
> Perhaps we can defer the locking into the subsystem, if only the memory
> controller requires it. In this case mem_cgroup_css_rstat_flush() (or
> mem_cgroup_stat_aggregate()) can hold a memcg-specific spinlock only
> while aggregating the stats.
> 
> There could be other things protected by the lock, but that's what I
> remember.

Thanks for reminding me. It does not seem straight forward or simple.
Lower priority then.

