Return-Path: <cgroups+bounces-4544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818D9630CC
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 21:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019891F21AB8
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3011ABEA4;
	Wed, 28 Aug 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RQzxnD0r"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB251AB522
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872481; cv=none; b=MQL7Gx695plXbNxIDTTQihA0jHOB/iL32690nBtz13IV3d6s4HsbZGp1HP/E1mbfmUN6OoppUlO4fboGXH5tpOKshRuZWsxQGTZPpmY0TA1Lzy85JCR8cowbboeCBlyLY01Abir+xOzkPGH/f+zP70kV+wM9O/kQw6DmU7UwrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872481; c=relaxed/simple;
	bh=QEa3xcVWuBnPZMg7VkJxZ9EV8CjqQRcUGFDZDB9+AQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8svlz6uq81A7E96p5OKgd1YT8nzzaOsfWdrLRHh3e98fuN7f2UaUoho1QrcXz1APw5strkG8oh00hUpK1zXMa4bAbZWHGJpL1zvOCU1N5GDsvCRPDWmXGzxS0m6e5SIPK/a2rRNBP3kAHYTu1WS3TeHIUdqIM4at1jDTpD29wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RQzxnD0r; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 12:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724872478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpXQCd3cHPTc7+LnUSfvlOIjwY7yTBbxtN2+2WagTe8=;
	b=RQzxnD0rb7twgkRCrNnll66J54fVZJ/zkE8FG8tk6sw1QrFo+IihvKWDjlADxsInTIF+x+
	pz2MmMCUOBTlwuY6bU+BtcedaZx35+WTF5tVuWxMih8mtqK8NEAOffRMyh5ErahNz6Ajet
	CGO3G6oZMU+7J/7M554Vcg5deIgtHHQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 05:34:24PM GMT, Yosry Ahmed wrote:
> On Tue, Aug 27, 2024 at 4:52 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > +
> > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > +
> > +static __fastpath_inline
> > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > +{
> > +       struct slabobj_ext *slab_exts;
> > +       struct kmem_cache *s;
> > +       struct folio *folio;
> > +       struct slab *slab;
> > +       unsigned long off;
> > +
> > +       folio = virt_to_folio(p);
> > +       if (!folio_test_slab(folio)) {
> > +               return __memcg_kmem_charge_page(folio_page(folio, 0), flags,
> > +                                               folio_order(folio)) == 0;
> 
> Will this charge the folio again if it was already charged? It seems
> like we avoid this for already charged slab objects below but not
> here.
> 

Thanks for catchig this. It's an easy fix and will do in v3.

> > +       }
> > +
> > +       slab = folio_slab(folio);
> > +       s = slab->slab_cache;
> > +
> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> > +       if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
> > +               return true;
> 
> Would it be clearer to check if the slab cache is one of
> kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing the
> address of the slab cache with the addresses of
> kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refer
> to your reply to Roman to understand why this works.
> 

Do you mean looping over kmalloc_caches[KMALLOC_NORMAL] and comparing
the given slab cache address? Nah man why do long loop of pointer
comparisons when we can simply check the flag of the given kmem cache.
Also this array will increase with the recent proposed random kmalloc
caches.

Thanks,
Shakeel

