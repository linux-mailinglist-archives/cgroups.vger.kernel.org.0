Return-Path: <cgroups+bounces-8311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076FAC0532
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF267B7617
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC4E221D8F;
	Thu, 22 May 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHBP+UfA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE001A841C
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897408; cv=none; b=MsnG4tzC5nHUcdPd7J32anTH5EtJelZtXW8OVhFjmh6rByrCUuSgQb43k5WsUV8NrDfJXAMaI2xdl8OHr/iw6MZGhSsXMicA2U9432K0UuIbRyL3ip7EnbVSqB1ZtWzTD+NCo1fmBWu7oMj+dV7F//4PAIn80u4l7bLR0YGdEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897408; c=relaxed/simple;
	bh=QASu0n7wbgfaqjcnh7zTxVQmk98xCzaXsu33gQpTePg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTwFu02OWkjPq3PGNT1rheshuBbcCNzwXVzggQkuI1rHtdp41XOnXvq4+Eho7nElS1ChSevZkg3xCjVKIIp4PamyPm7NI+XYAULdFQsmG9xW3Asl1uPIC2wWZho7uJ11eV8mEWiUBcCy8j5Z2kAbnZ0LNF5SBv+DIbDgBeAyy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHBP+UfA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso11394774a12.1
        for <cgroups@vger.kernel.org>; Thu, 22 May 2025 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747897405; x=1748502205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QASu0n7wbgfaqjcnh7zTxVQmk98xCzaXsu33gQpTePg=;
        b=YHBP+UfAao7uw2hjTRVcJ+JAEG9TW1+yInpxU+s/p0BtZBdtdO60oGDVMb5+nydCXy
         2GTP+VSSYyO/orXHotaW6oXh788pA+PGnn36Jjchzb3Nya78lkPstAb2tCqHr/dBdkyW
         eukkVTU7mINvp0ZsYF3bSPRnMIIBJWYfXMEY95pKRS7Su2oWiPUTiOxsa8sa7vfWywgC
         byn3WENIEssLyaQ6lj/BSrhphoKzEZ4sGUEQWN/+KW3GBtr9pQwXpjIXZQ5zNKIaRdq4
         cbG6ZMiF1QuEmH1mD5+xS+iyhqUKh9LEfgsyj2v+LFUBDDh6yXa7xk1+hIG8xsbxE0Ek
         nrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747897405; x=1748502205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QASu0n7wbgfaqjcnh7zTxVQmk98xCzaXsu33gQpTePg=;
        b=aBWuDIESWIfHCLegWuGhdT/3oI/igspps8M4sdWmkayFEZ/sPk8Ya4qmpKqLemIdSw
         t/gfU5lI0VkITwr0XzeXiP+c67xfuDVegq8ZsKuXGIjjMoT8tO8UtKr958VCxmtX4Vlv
         E2R7anHS6kCTrmIR8R5px5cwySgn7UPK93jSjG3mx1+ZvjtV/8pGJ5N+/Uts/0nhSbVr
         q5YcIZdjLLHTitkq5OSj6g2Z9k+F/OmXfpH/3mdVk/UrOE7WF8BkUgXynbz2Rlw5YluI
         8FoRheKfP2ZP1EsUYeR5/ZeeNTjGSkpyb/a49tZiayAVkK1cspu/FjHGVZb4w5lO3sVV
         tQZw==
X-Forwarded-Encrypted: i=1; AJvYcCVpa/VzFynRxFcmeaKKCv5uN/ggRaep/nk1REUluaRWjkptjg50MKnmKixKEopn4AVaza8GIeyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eUSB6CHTv6scvbdK2Bw8p6UjSX1UTbs1mxEqoxA7P91EPetz
	FRI8i1kPG5FlvBFnIEJAS4LXeyBlotvcq/pHXBT9v1R8peW6z1gvorUR/0xdPTRtpmCMHLrvGJ+
	trxNDOlebiJ9OgWYrn0R5LLd2i1fSLXU=
X-Gm-Gg: ASbGncusWBWSewWIWwtcfPzZEpJnIvuBo6ojmMk13HW6ffzpa9Nkd6iBany5hPUUK2A
	mEjHQpDeiELOn9inafmnxR+LsobjUw3WOnhx6BtFhVzX5ei4owGMLX04rGi8u3Iduc8EQuthf+i
	Ml++d+xU41/6v71/lP2e9QeM0+uzLuR48=
X-Google-Smtp-Source: AGHT+IGOqrSFnE61mkfV9ZVoYVqabTtnpohyYE6OV2be+ISriSKd2LqnnymMWj+mOfrDsjsGp8ZNCKBm0grKHEbHuRM=
X-Received: by 2002:a17:907:7e87:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-ad52d42bf0cmr2329462766b.7.1747897404339; Thu, 22 May 2025
 00:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org> <CAPM=9tw+DE5-q2o6Di2POEPcXq2kgE4DXbn_uoN+LAXYKMp06g@mail.gmail.com>
 <20250521144312.GE773385@cmpxchg.org>
In-Reply-To: <20250521144312.GE773385@cmpxchg.org>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 22 May 2025 17:03:12 +1000
X-Gm-Features: AX0GCFvXFWotGY0gxOq3H1gGVQsCFG1oE3R-IrlQ6g1awmYaBT_6hd_z90A3vuk
Message-ID: <CAPM=9tzMc18JzG3MD8hDY1hRDFEsBCHzKSNH_EqyZ-NYqMsBzw@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 00:43, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, May 21, 2025 at 12:23:58PM +1000, Dave Airlie wrote:
> > >
> > > So in the GPU case, you'd charge on allocation, free objects into a
> > > cgroup-specific pool, and shrink using a cgroup-specific LRU
> > > list. Freed objects can be reused by this cgroup, but nobody else.
> > > They're reclaimed through memory pressure inside the cgroup, not due
> > > to the action of others. And all allocated memory is accounted for.
> > >
> > > I have to admit I'm pretty clueless about the gpu driver internals and
> > > can't really judge how feasible this is. But from a cgroup POV, if you
> > > want proper memory isolation between groups, it seems to me that's the
> > > direction you'd have to take this in.
> >
> > I've been digging into this a bit today, to try and work out what
> > various paths forward might look like and run into a few impedance
> > mismatches.
> >
> > 1. TTM doesn't pool objects, it pools pages. TTM objects are varied in
> > size, we don't need to keep any sort of special allocator that we
> > would need if we cached sized objects (size buckets etc). list_lru
> > doesn't work on pages, if we were pooling the ttm objects I can see
> > being able to enable list_lru. But I'm seeing increased complexity for
> > no major return, but I might dig a bit more into whether caching
> > objects might help.
> >
> > 2. list_lru isn't suitable for pages, AFAICS we have to stick the page
> > into another object to store it in the list_lru, which would mean we'd
> > be allocating yet another wrapper object. Currently TTM uses the page
> > LRU pointer to add it to the shrinker_list, which is simple and low
> > overhead.
>
> Why wouldn't you be able to use the page LRU list_head with list_lru?
>
> list_lru_add(&ttm_pool_lru, &page->lru, page_to_nid(page), page_memcg(page));

I for some reason got it into my head that list_lru objects weren't
list_head, not sure why, guess I shall spend next week exploring this
possibility.

Dave.

