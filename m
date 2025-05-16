Return-Path: <cgroups+bounces-8247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC2ABA474
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2BA4A4505
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2122A1E4;
	Fri, 16 May 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iceI0Pdc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46E27FB18
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425871; cv=none; b=Rhk9JJrbAw4kivyk3k6p9Hk9ydBLcEwN6Z2OXwql1VnsFybNYzPE0CFX2wW/8m45YkOEX2LBVYg60xJpcPBHvLDQ34mLUcFRuXR8Ym/P3bayADcJNyCj7L+OTVOF3sexK2kFNg0LEo38lpnMDGeBmOreFVeSJEAh8vtS7Mz2o+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425871; c=relaxed/simple;
	bh=1A5TuP9mYvyiGCG2HjMa0D5eQXWztuXGtC+VP8uf/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUx43Q4Vd7oDXLa5PQDnXXvtEubMFLSpmR9PZxXWZLgv8rNsv5ZKQakH55ZPAPNcvTxeVfQNRKdcPFBkVwOoLlfBxJoGwrjU3tNadHFHFhnV5OE2HsFj3RF7iqi2FnpFjwnGSjYTBo0Sq60nr/ZwcXPeyInbnp71ok7TM6aitSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iceI0Pdc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8c2e87757so4273786d6.2
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747425868; x=1748030668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WVNeAvgjN69jytbH8Oyi2JZGwt4O3Tx5zhyeq1d3A8=;
        b=iceI0PdcIHmflCxpnokhRr8/HepoQYePMOlVVYWaEQ+ECIS+xpMZeiu0DxXkuEGgnv
         xpKoxi2kGA9CBVLx5PfXkFXGGH1n1dCqFv+oJLBeCUEMrC7dBbBOXFgW1c7cL165tBGe
         p5OIRHDBtACdHNQB55Vba7AkylAEVKcpbWUxQW80FAfBVaq9IY8wJgl5Hc3E8TiBk9M8
         LgMHtzpPUMLbXaTi3xBrm8ksiq7YyHlBTdrodDvl6fffre6fNYdAKkkFDacRsrcyz5oM
         pKhW1I0CUVBiTUYwvtvSD4sx4Rr9shXGQo5VSMgdjnlIbv43Syq7xmdqvt7n3irotHWH
         9tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425868; x=1748030668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WVNeAvgjN69jytbH8Oyi2JZGwt4O3Tx5zhyeq1d3A8=;
        b=Ed4GrKjSeYcxCsohw9ovDaLimktkR4U35a5KpFL+ljdzaerOlEy9EKSmajgg+2HFPL
         of3agri8RdX1XcwA3wQkt+nHkpkarZqpaIJU3MwxpZXmTCCUBKHyVTKbvZ44/oY8kWRz
         wSlpr5tLvjlHGaqHtEhO5WgpkJhBsg1l2Ab2dmre7NrHSek6002GHEIYEa6xHd2Cy0nv
         g9p0HMozZ/kuyfBqYDV1DOpGNzv63vEmefjVazt2hcP0P4xxFXsYj6pNWH3mQul1ZTeq
         /cf0Rat8uvEEa/K7FFcBDICgVVQqRbXDuSuxofPJUSazYruaCDqX/2kxIlMktufj5WLM
         sp8A==
X-Forwarded-Encrypted: i=1; AJvYcCWjXw7ijUivqfDI3OOHPhaGNbx84kf8o64Qs7pYG9KtJMRMzNeq2VS6x5nZ8f/+oCfwUaFeSQL0@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFMzSj0X47tJGBTCNwNbDe9p+4A8AICv2L0YAC8GcLITA8FzD
	egMDRwrm+TpJ2AlKbyQJYN/xSouiFZEkewrkdhcT7V9uI+5WTM2FAZ+gADnjh36klgQ=
X-Gm-Gg: ASbGncu3Q5TBiNpvsr+LS8g3FNcpUFVguHSUcPNAL2oc2XHH1NLUt5YweCcOpuGfnkW
	MyBmTAJ4vK62YaDu4YOWq1fzh2PBv67V74EAIxgw+msrqFXeX4tRNT3HvdX5EFv7x6hUOuEPHYl
	vs0oEkQYhE75myeIc6Gou/gJSGDPjOuO0QUY/XrmU5xquElHZDjYCaqxnFE7WgIjh7FoWwDzwZj
	90JMkTC6ajLt1937iZ4zvjtbPLkX3cgQro7/ei6vbYbFFHFzbLGrJ2tOF8gt8O8TmajzUSA7eXZ
	HHXLkZl1sH6d33jKR519C6oaM+5cUPkoVFP0077qIwOQZ4LJzigGwhfxlPK3
X-Google-Smtp-Source: AGHT+IHoSbYUjRY2GvaB1qQU1qbRqS+cGcuO/bhESiyT5BI93s8Li1RydfrUi/T/LchFh37Q3LKbyg==
X-Received: by 2002:a05:6214:2341:b0:6f2:b7cd:7cac with SMTP id 6a1803df08f44-6f8b08aad53mr80048916d6.31.1747425867618;
        Fri, 16 May 2025 13:04:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08af48fsm16087966d6.47.2025.05.16.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:04:26 -0700 (PDT)
Date: Fri, 16 May 2025 16:04:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250516200423.GE720744@cmpxchg.org>
References: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
 <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
 <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com>
 <20250516164150.GD720744@cmpxchg.org>
 <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com>

On Fri, May 16, 2025 at 07:42:08PM +0200, Christian König wrote:
> On 5/16/25 18:41, Johannes Weiner wrote:
> >>> Listen, none of this is even remotely new. This isn't the first cache
> >>> we're tracking, and it's not the first consumer that can outlive the
> >>> controlling cgroup.
> >>
> >> Yes, I knew about all of that and I find that extremely questionable
> >> on existing handling as well.
> > 
> > This code handles billions of containers every day, but we'll be sure
> > to consult you on the next redesign.
> 
> Well yes, please do so. I'm working on Linux for around 30 years now and halve of that on device memory management.
> 
> And the subsystems I maintain is used by literally billion Android devices and HPC datacenters
> 
> One of the reasons we don't have a good integration between device memory and cgroups is because specific requirements have been ignored while designing cgroups.
> 
> That cgroups works for a lot of use cases doesn't mean that it does for all of them.
> 
> >> Memory pools which are only used to improve allocation performance
> >> are something the kernel handles transparently and are completely
> >> outside of any cgroup tracking whatsoever.
> > 
> > You're describing a cache. It doesn't matter whether it's caching CPU
> > work, IO work or network packets.
> 
> A cache description doesn't really fit this pool here.
> 
> The memory properties are similar to what GFP_DMA or GFP_DMA32
> provide.
>
> The reasons we haven't moved this into the core memory management is
> because it is completely x86 specific and only used by a rather
> specific group of devices.

I fully understand that. It's about memory properties.

What I think you're also saying is that the best solution would be
that you could ask the core MM for pages with a specific property, and
it would hand you pages that were previously freed with those same
properties. Or, if none such pages are on the freelists, it would grab
free pages with different properties and convert them on the fly.

For all intents and purposes, this free memory would then be trivially
fungible between drm use, non-drm use, and different cgroups - except
for a few CPU cycles when converting but that's *probably* negligible?
And now you could get rid of the "hack" in drm and didn't have to hang
on to special-property pages and implement a shrinker at all.

So far so good.

But that just isn't the implementation of today. And the devil is very
much in the details with this:

Your memory attribute conversions are currently tied to a *shrinker*.

This means the conversion doesn't trivially happen in the allocator,
it happens from *reclaim context*.

Now *your* shrinker is fairly cheap to run, so I do understand when
you're saying in exasperation: We give this memory back if somebody
needs it for other purposes. What *is* the big deal?

The *reclaim context* is the big deal. The problem is *all the other
shrinkers that run at this time as well*. Because you held onto those
pages long enough that they contributed to a bonafide, general memory
shortage situation. And *that* has consequences for other cgroups.

> > What matters is what it takes to recycle those pages for other
> > purposes - especially non-GPU purposes.
> 
> Exactly that, yes. From the TTM pool pages can be given back to the
> core OS at any time. It's just a bunch of extra CPU cycles.
>
> > And more importantly, *what other memory in other cgroups they
> > displace in the meantime*.
> 
> What do you mean with that?
> 
> Other cgroups are not affected by anything the allocating cgroup
> does, except for the extra CPU overhead while giving pages back to
> the core OS, but that is negligible we haven't even optimized this
> code path.

I hope the answer to this question is apparent now.

But to illustrate the problem better, let's consider the following
container setup.

A system has 10G of memory. You run two cgroups on it that each have a
a limit of 5G:

             system (10G)
            /      \
           A (5G)   B (5G)

Let's say A is running some database and is using its full 5G.

B is first doing some buffered IO, instantiating up to 5G worth of
file cache. Since the file cache is cgroup-aware, those pages will go
onto the private LRU list of B. And they will remain there until those
cache pages are fully reclaimed.

B then malloc()s. Because it's at the cgroup limit, it's forced into
cgroup reclaim on its private LRUs, where it recycles some of its old
page cache to satisfy the heap request.

A was not affected by anything that occurred in B.

---

Now let's consider the same starting scenario, but instead B is
interacting with the gpu driver and creates 5G worth of ttm objects.

Once its done with them, you put the pages into the pool and uncharge
the memory from B.

Now B mallocs() again. The cgroup is not maxed out - it's empty in
fact. So no cgroup reclaim happens.

However, at this point, A has 5G allocated, and there are still 5G in
the drm driver. The *system itself* is out of memory now.

So B enters *global* reclaim to find pages for its heap request.

It invokes all the shrinkers and runs reclaim on all cgroups.

In the process, it will claw back some pages from ttm; but it will
*also* reclaim all kinds of caches, maybe even swap stuff, from A!

Now *A* starts faulting due to the pages that were stolen and tries to
allocate. But memory is still full, because B backfilled it with heap.

So now *A* goes into global reclaim as well: it takes some pages from
the ttm pool, some from B, *and some from itself*.

It can take several iterations of this until the ttm pool has been
fully drained, and A has all its memory faulted back in and is running
at full speed again.

In this scenario, A was directly affected, potentially quite severely,
by B's actions.

This is the definition of containment failure.

Consider two aggravating additions to this scenario:

1. While A *could* in theory benefit from the pool pages too, let's
   say it never interacts with the GPU at all. So it's paying the cost
   for something that *only benefits B*.

2. B is malicious. It does the above sequence - interact with ttm, let
   the pool escape its cgroup, then allocate heap - rapidly over and
   over again. It effectively DoSes A.

---

So as long as the pool is implemented as it is today, it should very
much be per cgroup.

Reclaim lifetime means it can displace other memory with reclaim
lifetime.

You cannot assume other cgroups benefit from this memory.

You cannot trust other cgroups to play nice.

