Return-Path: <cgroups+bounces-8157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B051AB4D63
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BFA17D103
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894491F1524;
	Tue, 13 May 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="tDm5V4Sp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E11F151D
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122904; cv=none; b=guMwniIFJwtQX3mD0Nl9RRga44meVV4pTfxuIzBalV7aZptw3LMy8tzWDbkPid34lMQzTCJ9tQiUZzA3WsKreoyn10Xl/AYlnkdiuulgg8UKj4UFJe9vHo8IMksEH54O4sk1uTKAj2kBv6TmPOyK8iKwYcBIcS7vyXhCM7dfQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122904; c=relaxed/simple;
	bh=aIQDWby2Q3zAkmKNBvw9NqpmEtYzPXnxL7Iull/2kYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfJqGlC+rbSQphNCo0+t/AMNw/Q6o4zfFy2urJbtkHtmPfyO12zcKc0ck7VGcJkU/JmdgWVArV4Qryb3j77r6dLzma1+SUPclR39yglvDqrron1jk1BpquGQWVUSVCYssI67iW2ivCdY3zlg818y5Yk1QhWaPPXKJofzmHINEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=tDm5V4Sp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30c3a038acfso5657417a91.3
        for <cgroups@vger.kernel.org>; Tue, 13 May 2025 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747122901; x=1747727701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jEONSQrb0GplIyO9WcUqAzqgpFTdN8SbHvG20l01KM=;
        b=tDm5V4Spj0ecFpgR6lsO2S4RMIavwxgznkR/y6HOfQ0MWmM2rma9QswUylkCCf0d3Y
         ni43fdYU5jH4NYLlcmmM8nxfHEn1xr+Spez19kLSWbaoQMKI9r16HRRIj/sd8VBIJUFQ
         mRx0SN9do8zlQ5edmy9pcLd3udD1Cshx8jleXCzVvziRNOq84NX+4/fQXmbt1Zs0wxkQ
         XwW++KT4NGTs01X4NgHERLQv7z0sR1+UwwZYTkUt9mjmOl52xo+B7d0TQCP+rBrWmfEA
         ffwMv4WnSdllAqUXLvdhljGTbD+R7jU6wI+j31fIe1Rgj8zwjukWIbSmLs9yR5M5PKin
         So4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122901; x=1747727701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jEONSQrb0GplIyO9WcUqAzqgpFTdN8SbHvG20l01KM=;
        b=Zz/j6MBLkRzRiYks7PKR0inB6HQDS0fZwC922yJ/K0/3lZkSjxXXrD9bXbncIZG8CS
         Ke67XaWc8Y0HV79Nw8GdhqnYgM2eCaQRoReJzkLFu8Wg6P3TfWyTH0d0eDAA85p1Iu+e
         YqXqwY9sBkcpcSI7ompogzfduIlgbT8tkk4o2eYrh7J/mWT+wOoTdZlyd0EVUY4YCOI2
         JSxBQPtswtpD87Utea/OUH5g68lJu1aMtVaQNHxUhh400I96aCrKB65BPDZQSL7GhxLL
         deJS7jewEiI0idXn1Jw1tNqSpmMegWIVT31ilsRNejYl3ZL4YBsI2WSlNduYjZHrPumy
         rvnw==
X-Forwarded-Encrypted: i=1; AJvYcCXe57v98OT80PmpC3jY4Ae11KyrzfnDX4NzWrYUGJ1II7NPgN0+qKrr5b8ecBppOkEqMRw3/LGw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9l+77hHbRqLm+m6RpjKJYofJUrMOQrftc4mRjpGWbiqdKYB+B
	JlPV9XO7ZvNndzorsVGR//lSUpzPZfGYRi6Haqfw26e47QyU9pkZBrzGV8XrgNR2U3lpgS2nyRZ
	FIG8=
X-Gm-Gg: ASbGncu+HVSobdTGlKwmc7epCLwg9n4yUumXez3Yt3xxNVprm1IfmnotPrnymQlzTlV
	IKQ6mh1gI721zfJG+cYZX+UWhvKdysosI84VneUbMAXfkaXZzHlliRpjjaNTbf97P1DdKBCV/6r
	VRmuoqg2mpLQaBwWX7SM/zv7K/SGBJx+wXjHMNBAo57txtyHEWvPeomZSeb4HFM8xoHIhleRuEZ
	hKhphLxWKgproC23Lbhz+D/9hZyn/bMLesoVmM6OZOe6RxKrGZpce/0ekBtIM523lJau2zEq3TP
	qd7mM+hz3EM9tmKDdvhyubaFIMNHMMsq9CG9U+Elscw1PXG7Uw==
X-Google-Smtp-Source: AGHT+IGdFP2tYLyRgTqkad6ApDG307wXzvKgMWWW5GFY5O81R4K4l6nukBTkVX3+OVGWDNaY4wb8pw==
X-Received: by 2002:ad4:5d64:0:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6f6e4828156mr335049666d6.38.1747122890791;
        Tue, 13 May 2025 00:54:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e39e0b8bsm64653936d6.20.2025.05.13.00.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:54:50 -0700 (PDT)
Date: Tue, 13 May 2025 03:54:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
	christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250513075446.GA623911@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>

On Thu, May 08, 2025 at 08:03:49AM +1000, Dave Airlie wrote:
> On Thu, 8 May 2025 at 03:52, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Hello Dave,
> >
> > On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> > > Hey all,
> > >
> > > This is my second attempt at adding the initial simple memcg/ttm
> > > integration.
> > >
> > > This varies from the first attempt in two major ways:
> > >
> > > 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> > > for pool memory, and directly hitting the GPU statistic, Waiman
> > > suggested I just do what the network socket stuff did, which looks
> > > simpler. So this adds two new memcg apis that wrap accounting.
> > > The pages no longer get assigned the memcg, it's owned by the
> > > larger BO object which makes more sense.
> >
> > Unfortunately, this was bad advice :(
> >
> > Naked-charging like this is quite awkward from the memcg side. It
> > requires consumer-specific charge paths in the memcg code, adds stat
> > counters that are memcg-only with no system-wide equivalent, and it's
> > difficult for the memcg maintainers to keep track of the link between
> > what's in the counter and the actual physical memory that is supposed
> > to be tracked.
> >
> > The network and a few others like it are rather begrudging exceptions
> > because they do not have a suitable page context or otherwise didn't
> > fit the charging scheme. They're not good examples to follow if it can
> > at all be avoided.
> 
> I unfortunately feel GPU might fit in this category as well, we aren't
> allocating pages in the traditional manner, so we have a number of
> problems with doing it at the page level.
> 
> I think the biggest barrier to doing page level tracking is with the
> page pools we have to keep. When we need CPU uncached pages, we
> allocate a bunch of pages and do the work to fix their cpu mappings to
> be uncached, this work is costly, so when we no longer need the
> uncached pages in an object, we return them to a pool rather than to
> the central allocator. We then use a shrinker to empty the pool and
> undo the cpu mapping change. We also do equivalent pools for dma able
> and 32-bit dma able pages if they are used.

Thanks for explaining the background, this is quite helpful. And I can
see where you're coming from with this.

But I'm actually not so sure it's a good idea to uncharge upon release
into the pool. Those pages might be unused from a GPU driver POV, but
they're not readily available for, say, a heap fault in another group.

For example, AFAIU a cgroup can allocate all of its memory allowance
in GPU memory, free it back into the pool, then fill the resulting
headroom inside the group with other allocations, like page cache or
heap. This lets a cgroup directly trigger allocations worth up to
twice its memory allowance. Do that on an ongoing basis, and you can
really tie up other containers in the shrinkers picking up after you -
just to get to the memory they've been rightfully assigned.

That's a clear containment problem.

System-wide, if I'm looking at the right code, the pool can be up to
50% of memory. That's a lot of used memory not attributed to any
cgroup, even though each allocation is directly triggered by one.

Container people are no fans of big, unattributed pools like this.
Imagine you start with a certain amount of memory in the system and
have a number of containers you would like to run. How much global
memory headroom do you need to set aside, not assigned to any
particular cgroup, to get a gpu cache that serves all cgroups well?

Caching itself is not an issue. A large part of cgroup-tracked memory
is some kind of cache. But what's usually done is to make the cache
itself per cgroup, and tie the size and the lifetime of entries to the
group's memory allowance. That gets you isolation and control.

E.g. if one cgroup in the system is more important than the others,
you can let it have a bigger cache by increasing its memory
allowance. Whereas if the pool is shared, you have no control over
that - less important groups could consume the cache and negatively
impact hit rates of the important group.

So in the GPU case, you'd charge on allocation, free objects into a
cgroup-specific pool, and shrink using a cgroup-specific LRU
list. Freed objects can be reused by this cgroup, but nobody else.
They're reclaimed through memory pressure inside the cgroup, not due
to the action of others. And all allocated memory is accounted for.

I have to admit I'm pretty clueless about the gpu driver internals and
can't really judge how feasible this is. But from a cgroup POV, if you
want proper memory isolation between groups, it seems to me that's the
direction you'd have to take this in.

> This means that if userspace allocates a large uncached object, and we
> account it to the current memcg with __GFP_ACCOUNT, then when it gets
> handed back to the pool we have to remove it from the memcg
> accounting. This was where I used the memcg kmem charge/uncharges,
> uncharge on adding to pool and charge on reuse. However kmem seems
> like the wrong place to charge, but it's where the initial
> __GFP_ACCOUNT will put those pages.

Ah, no need to worry about it. The name is just a historical memcgism,
from back when we first started charging "kernel" allocations, as
opposed to the conventional, pageable userspace memory. It's no longer
a super meaningful distinction, tbh.

You can still add a separate counter for GPU memory.

> This is why the suggestions to use the network solution worked
> better for me, I can do all the work outside the pool code at a
> slightly higher level (the same level where we charge/uncharge
> dmem), and I don't have to worry about handling the different pool
> types etc. We also don't need page->memcg to be set for these pages
> I don't think as all pages are part of a large object and the object
> is what gets swapped or freed, not parts of it.

I agree this doesn't need to be a goal in itself. It would just be a
side effect of charging through __GFP_ACCOUNT and uncharging inside
__free_pages(). What's more important is that the charge lifetime is
correlated with the actual memory allocation.

