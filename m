Return-Path: <cgroups+bounces-8219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BAFAB8BEB
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B641640B6
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8E21ABB1;
	Thu, 15 May 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZhPfb4jy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDA1DED5B
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325345; cv=none; b=XEC00MYq4pscG6rQxs7abnp6VEeH4NuVOws7jdHMaHX8zouIBNWEsyCTYTRyJa/u7NqYAjEE1oLc96SiAqnlq5Xy2imR9XfafVkeRZbLMY+MFpcJh27cWekt6rhuHPucx5DdpJQFA/h96KI8g0z4f3Cn0nq5iqFmKBbT6yRZFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325345; c=relaxed/simple;
	bh=VsfRUJAJTN0GNV3d8yHQsCAhEmD10n5+rkos2EETYCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkycaLmorl5VYWiX5hNgSANusTJt56/d4zGPyQ4gda0qjJ2OyV2YkjLODSfL3iLCOOfVk1MWEtsaDBHvbeWokwhcnbW+d67X0b14RwEDwoIpflyVqRbX6iQOfmJ61nLFFEhzD9NNb5FX2urW35BV5vcN5K0uQD2h083rCvrgm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZhPfb4jy; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-605f7d3215cso697539eaf.0
        for <cgroups@vger.kernel.org>; Thu, 15 May 2025 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747325342; x=1747930142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91NKOSTv5YT/1qhPptldg9b2q5Yv92CmJPsNir2fXYw=;
        b=ZhPfb4jyG3qvrBY+OUcgzRUG1firIp12orZZy/C5v7NQUUGKuguRKtu5Q0GB2a701y
         hDGCDs1XIZ+Tkr5C/Cs1Kv6vE+AF2adG504ccSN6NMd4TV13wDG7A8XWFpuNRzga377g
         zMEfIHJiaA9Zq9oBUonbcBB3NvGJY0bhTv8moI9ydDnhyOiA+qH/seTxhqjFF/lbK6qs
         uoEGUAebyH5lScwpvS5pU8JDHcEwM5V3d3yvphU8nMnYR+r3lwv6+lUpRprk2Zj7FW0E
         3dUF2oXvrecsD6GZm3l/6L5NKnkByfQ9e2oCS9S6NwskbCRGfIjPl/HYURFiBDmmEjow
         Ob9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747325342; x=1747930142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91NKOSTv5YT/1qhPptldg9b2q5Yv92CmJPsNir2fXYw=;
        b=VCiJPrEuXG389uO2ps0MZ9lDNg/Pr/JR3yELaT5zxfRoT0XU3RGmwqo+ziYrmotU+c
         8KkkhVyVF0CGfhCe0KYC3c+b6R4XaVJOu2POJPhpj9z5OBKjYJPUQC6j25WMGfqE07B2
         Vnw4fqM/gS6nOuViTVvEDsWbR5X2FiV5IdkfkJDPNhDXthHVqGjlXaikEP/T23joUhHB
         Vq9gxGmaiLErb6l7UtD7yRC6pz0XeMy9fgvB6PurHy3XolbE2HHLPcRK3p8Xf4inbzI4
         h3kddypVMPmsdRrJON41U2jowwRnKH5NYSEYWT0NzrecwBKR6qZ3dvjZxjM6HhQfPjX/
         7Izg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1VpOnBkBaEBBpeL4Og23Y1nFD65KAJqMuBe4vki4zulzUBh/FZJZMrFtF99i/sSNiFQ3Sjdn@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrEDYXwBbyXuyzCRuJ0/ayTYfOVzUkAbJiljNikfVR9Zqv5qt
	MXpce338rL6xc9Inw5089/OjCCnrAI5U38Cj5980ZhY1XnkAO9H+cQ5phtNTdBOz6aqzq3rwxov
	smzY=
X-Gm-Gg: ASbGnctTHfeYlK9svgEOPP1Kg6cURiWYLPwkREYLK4JQVqHrnQlD+Er2/8lI2+P+Fi/
	hNDT6eMBXoSTBF1T4ur61+3K7S5JhoEAjfUYsXkbwO7vYORyY+3O3zGCcXSdmuAqf5phXdiggGK
	4GnrVAcISuPN6kCJ5WusKR+NY/EMt6sKzfV07mLJPbQbc98S7vLdKnIyrmzhCEacBUtO9nNy//9
	4nF6J14iB3agon5s6VmWbfSoJvNF6yRmmPInVHu8CXiNKRurIJFLR+mrJjnlUIHBR+BRoiPDTvj
	7wvMiVh0tX9hzYH+j71TLV5zNzhGQ4Bqd1S6N0re/uxnw2SHyg==
X-Google-Smtp-Source: AGHT+IGpkpYl6XAu5rX0wJRFiMGQkB9re0fNH5Pwjd+2ZxwedWGAjP2jcG+V3KGtIv5tIrXRqvrUIA==
X-Received: by 2002:a05:620a:1726:b0:7c5:f696:f8e5 with SMTP id af79cd13be357-7cd4672499amr14457785a.14.1747325330931;
        Thu, 15 May 2025 09:08:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467bde34sm2281085a.8.2025.05.15.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 09:08:49 -0700 (PDT)
Date: Thu, 15 May 2025 12:08:42 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250515160842.GA720744@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>

On Thu, May 15, 2025 at 10:55:51AM +0200, Christian König wrote:
> On 5/15/25 05:02, Dave Airlie wrote:
> >> I have to admit I'm pretty clueless about the gpu driver internals and
> >> can't really judge how feasible this is. But from a cgroup POV, if you
> >> want proper memory isolation between groups, it seems to me that's the
> >> direction you'd have to take this in.
> > 
> > Thanks for this insight, I think you have definitely shown me where
> > things need to go here, and I agree that the goal should be to make
> > the pools and the shrinker memcg aware is the proper answer,
> > unfortunately I think we are long way from that at the moment, but
> > I'll need to do a bit more research. I wonder if we can agree on some
> > compromise points in order to move things forward from where they are
> > now.
> > 
> > Right now we have 0 accounting for any system memory allocations done
> > via GPU APIs, never mind the case where we have pools and evictions.
> > 
> > I think I sort of see 3 stages:
> > 1. Land some sort of accounting so you can at least see the active GPU
> > memory usage globally, per-node and per-cgroup - this series mostly
> > covers that, modulo any other feedback I get.
> > 2. Work on making the ttm subsystem cgroup aware and achieve the state
> > where we can shrink inside the cgroup first.
> > 3. Work on what to do with evicted memory for VRAM allocations, and
> > how best to integrate with dmem to possibly allow userspace to define
> > policy for this.
> > 
> >> Ah, no need to worry about it. The name is just a historical memcgism,
> >> from back when we first started charging "kernel" allocations, as
> >> opposed to the conventional, pageable userspace memory. It's no longer
> >> a super meaningful distinction, tbh.
> >>
> >> You can still add a separate counter for GPU memory.
> > 
> > Okay that's interesting, so I guess the only question vs the bespoke
> > ones is whether we use __GFP_ACCOUNT and whether there is benefit in
> > having page->memcg set.
> > 
> >>
> >> I agree this doesn't need to be a goal in itself. It would just be a
> >> side effect of charging through __GFP_ACCOUNT and uncharging inside
> >> __free_pages(). What's more important is that the charge lifetime is
> >> correlated with the actual memory allocation.
> > 
> > How much flexibility to do we have to evolve here, like if we start
> > with where the latest series I posted gets us (maybe with a CONFIG
> > option), then work on memcg aware shrinkers for the pools, then with
> > that in place it might make more sense to account across the complete
> > memory allocation. I think I'm also not sure if passing __GFP_ACCOUNT
> > to the dma allocators is supported, which is also something we need to
> > do, and having the bespoke API allows that to be possible.
> 
> Stop for a second.
> 
> As far as I can see the shrinker for the TTM pool should *not* be
> memcg aware. Background is that pages who enter the pool are
> considered freed by the application.

They're not free from a system POV until they're back in the page
allocator.

> The only reason we have the pool is to speed up allocation of
> uncached and write combined pages as well as work around for
> performance problems of the coherent DMA API.
> 
> The shrinker makes sure that the pages can be given back to the core
> memory management at any given time.

That's work. And it's a direct result of some cgroup having allocated
this memory. Why should somebody else have to clean it up?

The shrinker also doesn't run in isolation. It's invoked in the
broader context of there being a memory shortage, along with all the
other shrinkers in the system, along with file reclaim, and
potentially even swapping.

Why should all of this be externalized to other containers?

For proper memory isolation, the cleanup cost needs to be carried by
the cgroup that is responsible for it in the first place - not some
other container that's just trying to read() a file or malloc().

This memory isn't special. The majority of memcg-tracked memory is
shrinkable/reclaimable. In every single case it stays charged until
the shrink work has been completed, and the pages are handed back to
the allocator.

