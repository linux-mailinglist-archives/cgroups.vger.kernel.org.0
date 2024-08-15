Return-Path: <cgroups+bounces-4290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363C9526E6
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417581F22FCD
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C9EBE;
	Thu, 15 Aug 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z7Mg+sLr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C684A35
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681792; cv=none; b=Og5nP84R3NFFDhgjso9hARQ9t1jPougJCY895vp9cAO4T2y32oniEb8ui3d5KbqGI79PbPs2Un84QhSou4XMvS1aFdWnuEHN0MMQKB3+Uk4U/u8jKvkIH+/p5eZqfJGDWUhOy+Z/Vl/FSoENUi3r6WHmv4nlFOi+/rHfGapZY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681792; c=relaxed/simple;
	bh=gBJaYQ+1uidw92N74XWV/vTxJmHX9Uu0lKmBJbrx0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWpR4vnOrbGzjCukSZVL7FJsYQlP5VVJ49c/QD8tJ3sZgawPV8dKzhNsxvKkdbkcVCERyjtZvGYq+2YNiKHKFLxYlyH7bxjXvjj8vSubQ64l5f+NSxGHXv0dnl1ueZWF8ATfbkS3+dWKki/Xh0eh6Tt8yuqhDjCk7yrJ57dtyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z7Mg+sLr; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 17:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723681785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkR6+p3tEblVu2HdOj0+q8t6472WPtUOGkMk/DjcCdk=;
	b=Z7Mg+sLr2hIxf+kue6IUr+8WClBd01MOVSZ2Slyk9GrUKax7LOgLiynYcwOMBb7pfvy4Gu
	AROQ9PCRqNXXLJrqD+7YOHfDJlpl7ISauQcMOQSVPkKW4abkSOfjcd9ASpyCp8eIjdEtCS
	P70o6Jlbs+xpoCxNbhwoNW+h2ZI4Fe0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
Message-ID: <gqarnsvvanhk3yet472w2ihv2hwriviv3jpu4fpb24nfkd2f2e@cfh4ugd7xqk5>
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
 <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org>
 <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
 <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
 <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7>
 <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 04:48:42PM GMT, Yosry Ahmed wrote:
> On Wed, Aug 14, 2024 at 4:42 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Aug 14, 2024 at 04:03:13PM GMT, Nhat Pham wrote:
> > > On Wed, Aug 14, 2024 at 9:32 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > >
> > > > Ccing Nhat
> > > >
> > > > On Wed, Aug 14, 2024 at 02:57:38PM GMT, Jesper Dangaard Brouer wrote:
> > > > > I suspect the next whac-a-mole will be the rstat flush for the slab code
> > > > > that kswapd also activates via shrink_slab, that via
> > > > > shrinker->count_objects() invoke count_shadow_nodes().
> > > > >
> > > >
> > > > Actually count_shadow_nodes() is already using ratelimited version.
> > > > However zswap_shrinker_count() is still using the sync version. Nhat is
> > > > modifying this code at the moment and we can ask if we really need most
> > > > accurate values for MEMCG_ZSWAP_B and MEMCG_ZSWAPPED for the zswap
> > > > writeback heuristic.
> > >
> > > You are referring to this, correct:
> > >
> > > mem_cgroup_flush_stats(memcg);
> > > nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> > > nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > >
> > > It's already a bit less-than-accurate - as you pointed out in another
> > > discussion, it takes into account the objects and sizes of the entire
> > > subtree, rather than just the ones charged to the current (memcg,
> > > node) combo. Feel free to optimize this away!
> > >
> > > In fact, I should probably replace this with another (atomic?) counter
> > > in zswap_lruvec_state struct, which tracks the post-compression size.
> > > That way, we'll have a better estimate of the compression factor -
> > > total post-compression size /  (length of LRU * page size), and
> > > perhaps avoid the whole stat flushing path altogether...
> > >
> >
> > That sounds like much better solution than relying on rstat for accurate
> > stats.
> 
> We can also use such atomic counters in obj_cgroup_may_zswap() and
> eliminate the rstat flush there as well. Same for zswap_current_read()
> probably.
> 
> Most in-kernel flushers really only need a few stats, so I am
> wondering if it's better to incrementally move these ones outside of
> the rstat framework and completely eliminate in-kernel flushers. For
> instance, MGLRU does not require the flush that reclaim does as
> Shakeel pointed out.
> 
> This will solve so many scalability problems that all of us have
> observed at some point or another and tried to optimize. I believe
> using rstat for userspace reads was the original intention anyway.

I like this direction and I think zswap would be a good first target.

