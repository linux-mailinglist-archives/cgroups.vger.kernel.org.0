Return-Path: <cgroups+bounces-5284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF69B19CE
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93072282103
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD057346F;
	Sat, 26 Oct 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SRKocXbf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7196538A
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729960480; cv=none; b=KuhqTU1rRTIKVHvo0BLBv+tkyOCNubo8kzJhnfaXFIKEe4Sau/0rWmUkj6szFElgaiDuO2qHuBXi4TIzd5DrUIjmDw4bNo2dBw//BPX6ehHQbAbLvIdSvk+KlXzFcvHEDJB1DyE04sNTlS3iV6o3Pf/M7204ngZjE7o8O6zSfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729960480; c=relaxed/simple;
	bh=eZQHydjNriddbYwGJaDKKi5TlcDRY13x/cG+K/B3Pxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRQ4PizSsG7CIZvEi670QZE7JsviBb8Xvqsdei1Fl9m7QUK+nEyZEDoHgar2mg8sv3ZD6MMcJqFUf3cxT4VvMlpqjh2WxbCvcX5DiJK1Geqv7rrZaurAYGFGLIYNf16o9SyvRo0otZlAKF8rmOhDzsygTFlesGXCeFLB/6lV7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SRKocXbf; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Oct 2024 09:34:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729960475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50P3RRi/Vt/x16kQ+Mvu0X762+eb4K/hBPgfDeXncVo=;
	b=SRKocXbfW2ndhlrelgmu5W66KdmLm4YKPConO1qHCCHuP/ZHwVCz/8D+YO0r5b8MtkYtI6
	LsrD4cu6o0/2pExH0zKcN6TPn2Ll1pB8lXNtYYyKKPD/xXqKfrli45wyKuDqBuzwnT1dTw
	BVsWv5MlUBLvB+E0s/BcoK8QANQNQ1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: workingset: remove folio_memcg_rcu usage
Message-ID: <vnycobvb5cdfwwvhmz4ncbcfx4fefktzlvcfuxr6lmtzqc5hoo@ekl6vnwy6737>
References: <20241026071145.3287517-1-shakeel.butt@linux.dev>
 <CAOUHufYjLWJ6WgHjmRrBTNLFyFSaMG8tSV4JExqMTKADnd=sDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYjLWJ6WgHjmRrBTNLFyFSaMG8tSV4JExqMTKADnd=sDg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 26, 2024 at 09:37:00AM GMT, Yu Zhao wrote:
> On Sat, Oct 26, 2024 at 1:12 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The function workingset_activation() is called from
> > folio_mark_accessed() with the guarantee that the given folio can not be
> > freed under us in workingset_activation(). In addition, the association
> > of the folio and its memcg can not be broken here because charge
> > migration is no more. There is no need to use folio_memcg_rcu. Simply
> > use folio_memcg_charged() because that is what this function cares
> > about.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> > ---
> >
> > Andrew, please put this patch after the charge migration deprecation
> > series.
> >
> >  include/linux/memcontrol.h | 35 -----------------------------------
> >  mm/workingset.c            | 10 ++--------
> >  2 files changed, 2 insertions(+), 43 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 932534291ca2..89a1e9f10e1b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -443,35 +443,6 @@ static inline bool folio_memcg_charged(struct folio *folio)
> >         return __folio_memcg(folio) != NULL;
> >  }
> >
> > -/**
> > - * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
> > - * @folio: Pointer to the folio.
> > - *
> > - * This function assumes that the folio is known to have a
> > - * proper memory cgroup pointer. It's not safe to call this function
> > - * against some type of folios, e.g. slab folios or ex-slab folios.
> > - *
> > - * Return: A pointer to the memory cgroup associated with the folio,
> > - * or NULL.
> > - */
> > -static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
> > -{
> > -       unsigned long memcg_data = READ_ONCE(folio->memcg_data);
> > -
> > -       VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> > -
> > -       if (memcg_data & MEMCG_DATA_KMEM) {
> > -               struct obj_cgroup *objcg;
> > -
> > -               objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
> > -               return obj_cgroup_memcg(objcg);
> > -       }
> > -
> > -       WARN_ON_ONCE(!rcu_read_lock_held());
> > -
> > -       return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
> > -}
> > -
> >  /*
> >   * folio_memcg_check - Get the memory cgroup associated with a folio.
> >   * @folio: Pointer to the folio.
> > @@ -1084,12 +1055,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
> >         return NULL;
> >  }
> >
> > -static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
> > -{
> > -       WARN_ON_ONCE(!rcu_read_lock_held());
> > -       return NULL;
> > -}
> > -
> >  static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
> >  {
> >         return NULL;
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 4b58ef535a17..c47aa482fad5 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -591,9 +591,6 @@ void workingset_refault(struct folio *folio, void *shadow)
> >   */
> >  void workingset_activation(struct folio *folio)
> >  {
> > -       struct mem_cgroup *memcg;
> > -
> > -       rcu_read_lock();
> >         /*
> >          * Filter non-memcg pages here, e.g. unmap can call
> >          * mark_page_accessed() on VDSO pages.
> > @@ -601,12 +598,9 @@ void workingset_activation(struct folio *folio)
> >          * XXX: See workingset_refault() - this should return
> >          * root_mem_cgroup even for !CONFIG_MEMCG.
> 
> The "XXX" part of the comments doesn't apply anymore.
> 
> >          */
> > -       memcg = folio_memcg_rcu(folio);
> > -       if (!mem_cgroup_disabled() && !memcg)
> > -               goto out;
> > +       if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
> > +               return;
> >         workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
> 
>  if (mem_cgroup_disabled() || folio_memcg_charged(folio))
>     workingset_age_nonresident()
> 
> We still want to call workingset_age_nonresident() when memcg is
> disabled. (We just want to "Filter non-memcg pages here" when memcg is
> enabled, as the comment above says, which I assume still applies?)
> 

Yes, you are right. Let me send the v2 with the fix.

