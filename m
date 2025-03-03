Return-Path: <cgroups+bounces-6787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA370A4CAFD
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38DF17577D
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB522DFAD;
	Mon,  3 Mar 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WLWcPu2N"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0822DFA0
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026609; cv=none; b=HjIdWYnA6zZn8LK5/CN33ticmr0T+X24njDnXV/Eue7nqDUc4SgS2/AyYt2cPIziWM0QCxySMCIPF20L4iVl99bFtxrXJerNg1XhUQePmYsH56+BKrC9zwf9RoPdeQgrbrZKv5QQvFcTGUCrH2naGaF9p6cGV/MOeU5dufB/TSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026609; c=relaxed/simple;
	bh=VoHpqV1IBTv1C8Eg5DsGL95/84KzSWDodzmTXwpMjn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsPM6K+u2/JgLkB1kkmhy16B1pNyYBVNbTvi3P4h/fvkeK1ImhPE0C98XPZzrtgyO6FJBj4MJMa0EW2c4Uon52WNaT9LOmnw7aUwQjsNukMKwHEIUHiiegZpJkqfxqoNcZ/DqBJVJ6dn4/9DbYHAQH6jfsJoZX+VBibvv6gkjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WLWcPu2N; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 18:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741026603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYe/ysoXPqob+w5PBERcOUKELy+j85iPqEHh+yndyrU=;
	b=WLWcPu2N4Ygl/oFh4nOsmorI3MtdySSTP5StfdE2ANLNfYS29bfXKIg68hhrkBkgNEUKEj
	a8dmKXQxudIQbPlm+I2gzXJXMJZ6SjrftZkOhCTdBXUK0RdoHEWa4i5XLu2+4Sm0pIxP7o
	aj57ygZ/QKnwSnJW9Q+GHH+qNxD8jp4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: inwardvessel <inwardvessel@gmail.com>, tj@kernel.org,
	shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <Z8X1IfzdjbKEg5OM@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
> On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
> > From: JP Kobryn <inwardvessel@gmail.com>
> ...
> > +static inline bool is_base_css(struct cgroup_subsys_state *css)
> > +{
> > +	return css->ss == NULL;
> > +}
> 
> Similar predicate is also used in cgroup.c (various cgroup vs subsys
> lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
> unified, i.e. open code the predicate here or use the helper in both
> cases (css_is_cgroup() or similar).
> 
> >  void __init cgroup_rstat_boot(void)
> >  {
> > -	int cpu;
> > +	struct cgroup_subsys *ss;
> > +	int cpu, ssid;
> >  
> > -	for_each_possible_cpu(cpu)
> > -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > +	for_each_subsys(ss, ssid) {
> > +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> > +	}
> 
> Hm, with this loop I realize it may be worth putting this lock into
> struct cgroup_subsys_state and initializing them in
> cgroup_init_subsys() to keep all per-subsys data in one pack.

I thought about this, but this would have unnecessary memory overhead as
we only need one lock per-subsystem. So having a lock in every single
css is wasteful.

Maybe we can put the lock in struct cgroup_subsys? Then we can still
initialize them in cgroup_init_subsys().

> 
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
> > +
> > +		for_each_subsys(ss, ssid) {
> > +			raw_spin_lock_init(
> > +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
> > +		}
> 
> Similar here, and keep cgroup_rstat_boot() for the base locks only.

I think it will be confusing to have cgroup_rstat_boot() only initialize
some of the locks.

I think if we initialize the subsys locks in cgroup_init_subsys(), then
we should open code initializing the base locks in cgroup_init(), and
remove cgroup_rstat_boot().

Alternatively, we can make cgroup_rstat_boot() take in a subsys and
initialize its lock. If we pass NULL, then it initialize the base locks.
In this case we can call cgroup_rstat_boot() for each subsystem that has
an rstat callback in cgroup_init() (or cgroup_init_subsys()), and then
once for the base locks.

WDYT?

