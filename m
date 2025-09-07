Return-Path: <cgroups+bounces-9777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7894B47CAF
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889B23C09AA
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469582877F7;
	Sun,  7 Sep 2025 17:51:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DA274B35
	for <cgroups@vger.kernel.org>; Sun,  7 Sep 2025 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757267495; cv=none; b=m+Mkz9KHGeBL9IO0A5rDShRo8Jp84YvCbvU8IIf8DXFvM9PIvABYmxnPB0JdXOdfnLgtlQkj3kVxvjzG7vc/0juc70Y1jPuAw5Ip68vZxreMyoCeQvhlX1rmhDov9oOMTh+XILGjuXv5+nQsVP7KTr2kQUp1bt2zXbXojHtJSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757267495; c=relaxed/simple;
	bh=xngdN5sSs4YgaMwMqMgWb9r9Eyg9kbqt2cRhGJLNrw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+R4uvRHXmRNxvOSq3k4Mw/ziFwxkOfz1V+mthRqSw4t4CByfhMoxCuDyw39DzeqFePrzlopo7pDBZchvqfaY850HHAf3RBNG61Vf3TrFiu5cT4D65InGJu7EShaBwXMJL5sijAWBErligex166qyWzqmmd38fvmsLdLK5it+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 8 Sep 2025 02:51:24 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 8 Sep 2025 02:51:24 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aL3GHJJ6+elPD7OP@yjaykim-PowerEdge-T330>
References: <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
 <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
 <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330>
 <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
 <CAF8kJuNW2kmxKYRE9t8WvSOad9JkLYt0WSAcFOQ9r9=2=XGc9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNW2kmxKYRE9t8WvSOad9JkLYt0WSAcFOQ9r9=2=XGc9Q@mail.gmail.com>

> On Fri, Sep 5, 2025 at 4:45 PM Chris Li <chrisl@kernel.org> wrote:
> > >   - Mask computation: precompute at interface write-time vs runtime
> > >     recomputation. (TBD; preference?)
> >
> > Let's start with runtime. We can have a runtime and cached with
> > generation numbers on the toplevel. Any change will reset the top
> > level general number then the next lookup will drop the cache value
> > and re-evaluate.
>
> Scratch that cache value idea. I found the run time evaluation can be
> very simple and elegant.
> Each memcg just needs to store the tier onoff value for the local
> swap.tiers operation. Also a mask to indicate which of those tiers
> present.
> e.g. bits 0-1: default, on bit 0 and off bit 1
>        bits 2-3: zswap, on bit 2 and off bit3
>        bits 4-6: first custom tier
>        ...
>
> The evaluation of the current tier "memcg" to the parent with the
> default tier shortcut can be:
>
>         onoff = memcg->tiers_onoff;
>         mask = memcg->tiers_mask;
>
>         for (p = memcg->parent; p && !has_default(onoff); p = p->parent) {
>                 merge = mask | p->tiers_mask;
>                 new = merge ^ mask;
>                 onoff |= p->tiers_onoff & new;
>                 mask = merge;
>         }
>         if (onoff & DEFAULT_OFF) {
>                 // default off, look for the on tiers to turn on
>         } else {
>                 // default on, look for the off tiers to turn off
>         }
>
> It is an all bit operation that does not need caching at all. This can
> take advantage of the short cut of the default tier. If the default
> tier overwrite exists, no need to search the parent further.
>
> Chris
>

Hi Chris,

Thanks a lot for the clear code and explanation.

I’ll proceed with the runtime evaluation approach you suggested.  
I was initially leaning toward precomputing at write-time since (1) 
cgroup depth is might be deep, and (2) swap I/O paths are far more frequent than config
writes. Is your preference for runtime for implementation simpleness?
(Any other reasons I don't know?)

Thanks again

Best Regards
Youngjun Park

