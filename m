Return-Path: <cgroups+bounces-4284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB295264A
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 01:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5705AB21240
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08714A609;
	Wed, 14 Aug 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UUWPIp72"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3E13C820
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723678961; cv=none; b=j2OCZE2VXe+BaeKp5T50fvaKiRNEJXzpIzLvaBIlToa2hKz5Ai9g3Fyw/W/1UmSdgHJLc4M2InYM4wAHRFxBCC2v18hr0daQYjC9Ivk7t6ZcseOJ9G10k2b6+46E+0BEdZ5H6ZmjG+W06T9HR7Wcga6rugZtkHR9U2qNdIRALUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723678961; c=relaxed/simple;
	bh=lR4FffDeSePt0AVj0hB+l38MewoPYskiDBb2i6DJw2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8inT1NhpzicC9WHrtFCuo3YENnpF+PErQpSOVQ3RS62l0XFUJw75SQYj7Lx3IH0q4En3dyTB53pY5GfYLtA535nSQHswkFfwsfoZc1XE614Ny8e6u/yS/MagUtyffqS5IBGetrR3IkQAfQMVrx+5YebzLULMHtRiW7wckoK1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UUWPIp72; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 16:42:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723678957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=powCy6WP/JGwsZWWQApUZ1BP4yfZE6Dxn7LVxtqo9Gg=;
	b=UUWPIp72abgqNrtwuevubD420Lr2wsihLdU+wC1Q3kouZEfNgYs9JCg4l3JTBFkKu5abjp
	jAyjwR0qFEs6JIQtCvGugDwsfnXOKtQdIheb1IGRieo4GMblOQVlx/5XfNdajZiKrHd0VW
	/24nBr5bCdyz6ZSYvASgEp9SGjUB01c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
Message-ID: <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7>
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
 <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org>
 <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
 <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 04:03:13PM GMT, Nhat Pham wrote:
> On Wed, Aug 14, 2024 at 9:32 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> >
> > Ccing Nhat
> >
> > On Wed, Aug 14, 2024 at 02:57:38PM GMT, Jesper Dangaard Brouer wrote:
> > > I suspect the next whac-a-mole will be the rstat flush for the slab code
> > > that kswapd also activates via shrink_slab, that via
> > > shrinker->count_objects() invoke count_shadow_nodes().
> > >
> >
> > Actually count_shadow_nodes() is already using ratelimited version.
> > However zswap_shrinker_count() is still using the sync version. Nhat is
> > modifying this code at the moment and we can ask if we really need most
> > accurate values for MEMCG_ZSWAP_B and MEMCG_ZSWAPPED for the zswap
> > writeback heuristic.
> 
> You are referring to this, correct:
> 
> mem_cgroup_flush_stats(memcg);
> nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
> 
> It's already a bit less-than-accurate - as you pointed out in another
> discussion, it takes into account the objects and sizes of the entire
> subtree, rather than just the ones charged to the current (memcg,
> node) combo. Feel free to optimize this away!
> 
> In fact, I should probably replace this with another (atomic?) counter
> in zswap_lruvec_state struct, which tracks the post-compression size.
> That way, we'll have a better estimate of the compression factor -
> total post-compression size /  (length of LRU * page size), and
> perhaps avoid the whole stat flushing path altogether...
> 

That sounds like much better solution than relying on rstat for accurate
stats.

