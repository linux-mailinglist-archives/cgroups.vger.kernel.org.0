Return-Path: <cgroups+bounces-8078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12660AAEE6A
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 00:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2818B1BC7BF6
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8A26B2D6;
	Wed,  7 May 2025 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/h0msqo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEF253B4A
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655445; cv=none; b=lyL4oSYMXLHEbik1NDN/A26Zs1qVo16pDKkiK4yTVAY8XE9cRZ6XcFvCwcPwLu6y5pDGJUmUVxt2bpKbv73Rc7CcqJQHmkQx8sgiNNVozXcNVvsrCKF2+uC3kA763qTv735kXUinRIaBuCdfVhjO2Sadgts1GsI8lUShG+E+LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655445; c=relaxed/simple;
	bh=Lb7bkXBSvzcM1h6VIKpZXSJSWY2RvghKR7Hds+w2dZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgMParSwZ4aEG5uvplZn29W/WAdSm7+vX9k/A2uCJTqU40l+SdwNjXEeflxmz0zxdmN4COYmt1apaJXeFyZCRveXVqw/dRSF3gv78AQNXvmxaTSHgzzJcHWrYp4TBI7DAq1nElPgj6Xny7DAV3SaqNl3j6i9O7tbiRGi0cgOSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/h0msqo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac29fd22163so53323666b.3
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746655441; x=1747260241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb7bkXBSvzcM1h6VIKpZXSJSWY2RvghKR7Hds+w2dZA=;
        b=V/h0msqo7RbNKZ21ajtG3GKhNfePgrNHZNqz11nQnD9+4Zx27BWt+E4/+cAaaE4D/3
         8J5v62lQnv2p+q4DmknaFlayxH0opNY0Ip3aMmwyBBWtT7H8k3FYVuc8tuO+KHiWZF1F
         0CuPIM+8kgolVWnuH6r2lAJn4vvWTkPBpo/Zuh8Ok5+qokr426HQqOwx50l96QWrbTr7
         RR0N9XuF8TTQYGVeBb5dPfvfilUZFg6NcxwCBHQ0y+vtRj9ZpP2vKgDenU4W6du9uexF
         6r6k3hS8G8XgtEwL3EnNeAhXF25yPm8y5ieKun3vLSCpzBQsAROPA4YuQxpRwbP032X6
         4ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655441; x=1747260241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lb7bkXBSvzcM1h6VIKpZXSJSWY2RvghKR7Hds+w2dZA=;
        b=JLqssE8hfpnjmGg4wRkImlByRoW1rJhJoVWeIrm6zExBKnRrha2AIsr1qtVLRg3UUs
         97fsooAt6pniS0xe5LgfG7cpfo1m1N0X6+i+fa5BBzSEBv/FCQOb6nGbNPsOSpdYTC2/
         BrphREnZyMxpVb64lG3KOM8AWn559ChMVEDIsqtTX1gt7bAkp2dp84Kpe/MRxiuPU/Py
         ve6Yanzitsl62kn4q7YMd5kkUhGZXzVwGlYDm9B1d308g5QsCxc8OY3FFI1/dAtlPyyv
         OPklkXOdkXftUqe6lv/dG07mIb5P1uu5A99gFfPIecwyfko6U1anyy30G+pTtxfukhbd
         gf8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkaoXFM1Ozi7i9InIYTymwhokel3dYLliN+s32Gdl0R43iYIp6fXkK1EUPA1+IStjOBgIVv1+a@vger.kernel.org
X-Gm-Message-State: AOJu0YynVrJngWuV4bEIjcHdeNAl/pX0da98V2+zk4/f/Mbx79A8158d
	HUBq4Wq1vsWmqZtm246fuM2SoImSWMND4jHCP2dSQdbUCDJR29V2+A2rdS8MzrK7qE7+1qG0yCi
	750ITqXr4YRNLQyfZlV2pSFtSB/s=
X-Gm-Gg: ASbGncvPKb1xJHb5U9IxzscDHqQkAv8ZDn2YVhiBSJbTIqy9KBheoK/MgCYmwLuBzcx
	AlZoBqeoSBe6zKm+inbjeLTVsdyw7szBodgVZkH3twplv3HMBdZ8LWABZJcOJaaqRw4kMxveI5c
	+RG+dVKsaHgkFj6IGdiGzZ
X-Google-Smtp-Source: AGHT+IEVp2JYGLCucPaa7MeFKn3S9Fs5YDGYy4r7+I8/OUDzWVnDumfRwKk2uWXlfISjMjrO4FmEIraRpRWqNWGMntc=
X-Received: by 2002:a17:907:96a7:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-ad1fe6f68b4mr80059766b.27.1746655441255; Wed, 07 May 2025
 15:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <20250507175238.GB276050@cmpxchg.org>
In-Reply-To: <20250507175238.GB276050@cmpxchg.org>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 8 May 2025 08:03:49 +1000
X-Gm-Features: ATxdqUE-XkPYYvmPDC9K5gmdD4QxNGDNDEIeMqq3wTVXbK9hqMOAxkGEOLg_JiA
Message-ID: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 03:52, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Dave,
>
> On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> > Hey all,
> >
> > This is my second attempt at adding the initial simple memcg/ttm
> > integration.
> >
> > This varies from the first attempt in two major ways:
> >
> > 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> > for pool memory, and directly hitting the GPU statistic, Waiman
> > suggested I just do what the network socket stuff did, which looks
> > simpler. So this adds two new memcg apis that wrap accounting.
> > The pages no longer get assigned the memcg, it's owned by the
> > larger BO object which makes more sense.
>
> Unfortunately, this was bad advice :(
>
> Naked-charging like this is quite awkward from the memcg side. It
> requires consumer-specific charge paths in the memcg code, adds stat
> counters that are memcg-only with no system-wide equivalent, and it's
> difficult for the memcg maintainers to keep track of the link between
> what's in the counter and the actual physical memory that is supposed
> to be tracked.
>
> The network and a few others like it are rather begrudging exceptions
> because they do not have a suitable page context or otherwise didn't
> fit the charging scheme. They're not good examples to follow if it can
> at all be avoided.

I unfortunately feel GPU might fit in this category as well, we aren't
allocating pages in the traditional manner, so we have a number of
problems with doing it at the page level.

I think the biggest barrier to doing page level tracking is with the
page pools we have to keep. When we need CPU uncached pages, we
allocate a bunch of pages and do the work to fix their cpu mappings to
be uncached, this work is costly, so when we no longer need the
uncached pages in an object, we return them to a pool rather than to
the central allocator. We then use a shrinker to empty the pool and
undo the cpu mapping change. We also do equivalent pools for dma able
and 32-bit dma able pages if they are used.

This means that if userspace allocates a large uncached object, and we
account it to the current memcg with __GFP_ACCOUNT, then when it gets
handed back to the pool we have to remove it from the memcg
accounting. This was where I used the memcg kmem charge/uncharges,
uncharge on adding to pool and charge on reuse. However kmem seems
like the wrong place to charge, but it's where the initial
__GFP_ACCOUNT will put those pages. This is why the suggestions to use
the network solution worked better for me, I can do all the work
outside the pool code at a slightly higher level (the same level where
we charge/uncharge dmem), and I don't have to worry about handling the
different pool types etc. We also don't need page->memcg to be set for
these pages I don't think as all pages are part of a large object and
the object is what gets swapped or freed, not parts of it.

>
> __GFP_ACCOUNT and an enum node_stat_item is the much preferred way. I
> have no objections to exports if you need to charge and account memory
> from a module.

Now maybe it makes sense to add a node_stat_item for this as well as
the GPU memcg accounting so we can have it accounted in both places,
right now mm has no insight statistics wise into this memory at all,
other than it being pages allocated.

Dave.

