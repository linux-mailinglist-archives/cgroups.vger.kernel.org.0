Return-Path: <cgroups+bounces-6754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF31A4A75F
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B475A3B3F74
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3F1BC3F;
	Sat,  1 Mar 2025 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcLZInc9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E163A9
	for <cgroups@vger.kernel.org>; Sat,  1 Mar 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792313; cv=none; b=g/jGM0kNy8eVwyvPvuFezeMY7HbOvSRxwhj6Ynovq2SKNJGcrghlhDSl41N7R0bJHehxi+O5CF6OjudC4sQIyhfkva8pdzfZCCWAV1Staytk5bcUqEH6nA4/a3j6OIg9Tv1/AwcQLRT6MMq9oAOl7fDdp/PCb0/sGKYBKFjcf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792313; c=relaxed/simple;
	bh=I2BDQkPoHA6dHqwdbz2pDfFhM6QSlkv/8OFtVEKyOpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVqUlfkEbREs0SIaO/wvht4B3h6v4F5/NVqtOdqU9LfATeU/GJmm2gwPkzHz1z2mQbC2/0KoSkfjBW5XfsSgOnvQesS85as2xU92WGIVfb1izI224/xQVTgu/IXnIcswarMBGvI+Gf3Q0hqkkNGHnrs26KR0+8iysaR3/+glkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcLZInc9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 1 Mar 2025 01:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740792309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgzekGSfpi4MCbgi0ZXny+52I2B/jcmyprnXdtn4RtA=;
	b=CcLZInc915gBfEHIJBfK+nXL/0F/GPJoqB6X9aF6P4VFp7zLZJSmQB3I2pMbH2kMXhOiIv
	BDY6rEPDvB1xwl9g1/MBH3mFlhAzUkc9n0dcO1/cXZ07b3tTY5V4RIUbxDzf8TpJ+3GNXu
	kSY6YihpLkGAW5gFPO8mwNXzcKEi3kw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <Z8Jh7-lN_qltU7WD@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
 <Z8IIxUdRpqxZyIHO@google.com>
 <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 05:06:23PM -0800, JP Kobryn wrote:
[..] 
> > 
> > >   		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
> > >   		if (ss->css_released)
> > [..]
> > > @@ -6188,6 +6186,9 @@ int __init cgroup_init(void)
> > >   			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
> > >   						   GFP_KERNEL);
> > >   			BUG_ON(css->id < 0);
> > > +
> > > +			if (css->ss && css->ss->css_rstat_flush)
> > > +				BUG_ON(cgroup_rstat_init(css));
> > 
> > Why do we need this call here? We already call cgroup_rstat_init() in
> > cgroup_init_subsys(). IIUC for subsystems with ss->early_init, we will
> > have already called cgroup_init_subsys() in cgroup_init_early().
> > 
> > Did I miss something?
> 
> Hmmm it's a good question. cgroup_rstat_init() is deferred in the same
> way that cgroup_idr_alloc() is. So for ss with early_init == true,
> cgroup_rstat_init() is not called during cgroup_early_init().

Oh I didn't realize that the call here is only when early_init == false.
I think we need a comment to clarify that cgroup_idr_alloc() and
cgroup_rstat_init() are not called in cgroup_init_subsys() when
early_init == true, and hence need to be called in cgroup_init().

Or maybe organize the code in a way to make this more obvious (put them
in a helper with a descriptive name? idk).

> 
> Is it safe to call alloc_percpu() during early boot? If so, the
> deferral can be removed and cgroup_rstat_init() can be called in one
> place.

I don't think so. cgroup_init_early() is called before
setup_per_cpu_areas().

> 
> > 
> > >   		} else {
> > >   			cgroup_init_subsys(ss, false);
> > >   		}
> > [..]
> > > @@ -300,27 +306,25 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> > >   }
> > >   /* see cgroup_rstat_flush() */
> > > -static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
> > > +static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
> > >   	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
> > >   {
> > > +	struct cgroup *cgrp = css->cgroup;
> > >   	int cpu;
> > >   	lockdep_assert_held(&cgroup_rstat_lock);
> > >   	for_each_possible_cpu(cpu) {
> > > -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
> > > +		struct cgroup_subsys_state *pos;
> > > +		pos = cgroup_rstat_updated_list(css, cpu);
> > >   		for (; pos; pos = pos->rstat_flush_next) {
> > > -			struct cgroup_subsys_state *css;
> > > +			if (!pos->ss)
> > > +				cgroup_base_stat_flush(pos->cgroup, cpu);
> > > +			else
> > > +				pos->ss->css_rstat_flush(pos, cpu);
> > > -			cgroup_base_stat_flush(pos, cpu);
> > > -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
> > > -
> > > -			rcu_read_lock();
> > > -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
> > > -						rstat_css_node)
> > > -				css->ss->css_rstat_flush(css, cpu);
> > > -			rcu_read_unlock();
> > > +			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
> > 
> > We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
> > Otherwise we will call BPF rstat flush whenever any subsystem is
> > flushed.
> > 
> > I guess it's because BPF can now pass any subsystem to
> > cgroup_rstat_flush(), and we don't keep track. I think it would be
> > better if we do not allow BPF programs to select a css and always make
> > them flush the self css.
> > 
> > We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
> > in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().
> 
> I'm fine with this if others are in agreement. A similar concept was
> done in v1.

Let's wait for Shakeel to chime in here since he suggested removing this
hook, but I am not sure if he intended to actually do it or not. Better
not to waste effort if this will be gone soon anyway.

> 
> > 
> > But if the plan is to remove the bpf_rstat_flush() call here soon then
> > it's probably not worth the hassle.
> > 
> > Shakeel (and others), WDYT?
> 

