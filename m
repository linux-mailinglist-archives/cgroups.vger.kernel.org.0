Return-Path: <cgroups+bounces-7768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD0DA99B5C
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5026F1B83520
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E781F1534;
	Wed, 23 Apr 2025 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RswZ3qZu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396A2701BE
	for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446641; cv=none; b=nNQluM1TdfpoPUu60Wai7w9c6ciwa7t4z3lZnZ3QiScPZkJqhQuAsASMrUtMTg9wPD7lYiwQ1/ASjYkLBhRC1umGPaJEMgBx8gMEV8/agoIz5pbOV8Tv4zk99/gGLi9xyg1vCbVXvdBanj3EnBleMolo9f60Aaw+Wbt6fe3QgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446641; c=relaxed/simple;
	bh=vcYM3cGRIV8ga2z6h0eXe3QtkdwpdnrsYFMU/4WLeog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFyl3WExjI5Q3jVJIj5I/UCrcY0G66x/Z0bUDyRTTq/ETQAzcNGR+HrzJNgI30KXqF1qdiRMfZw9VCkMEsL/+tv2RDzrKvLrcv9X2j6p4vNRqcBZnXneZMg2Lx3qAXEx79QgUyGuxvwcBKBYDQATHC1naSe0Ogj1y340fr++N8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RswZ3qZu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 15:16:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745446625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0Pugca4uCw8q3SU8l12BS7UQCUB0ByIynMRUd5StOU=;
	b=RswZ3qZubhaGXoBHAYXa6YrNySCpNwcOXqbp5gTNYF0OU+2jqfcWS0YtXQLS0dsldUPu7A
	7JMFUnvbgAqR1gkJK1wgITJqNxDU/z3lAyOYg/IxNcuUYL8qSWCFvi7Np82V8FL6TOrbrM
	bR6zTCcS+EAfqwhnSYyhnbdOR3CNxRY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Eric Dumazet <edumazet@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <ha4sqstdknwvvubs2g33r3itrabepz2jwlr3ksrbjdlgjnbuel@appekpf6ffud>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <20250422181022.308116c1@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422181022.308116c1@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Jakub,

On Tue, Apr 22, 2025 at 06:10:22PM -0700, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 11:02:29 -0700 Shakeel Butt wrote:
> >  static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  {
> >  	struct memcg_stock_pcp *stock;
> > -	unsigned int stock_pages;
> > +	struct mem_cgroup *cached;
> > +	uint8_t stock_pages;
> 
> Is it okay to use uintX_t now?
> 
> >  	unsigned long flags;
> > +	bool evict = true;
> > +	int i;
> >  
> >  	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
> >  
> > -	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> > +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> >  		/*
> > -		 * In case of unlikely failure to lock percpu stock_lock
> > -		 * uncharge memcg directly.
> > +		 * In case of larger than batch refill or unlikely failure to
> > +		 * lock the percpu stock_lock, uncharge memcg directly.
> >  		 */
> 
> We're bypassing the cache for > CHARGE_BATCH because the u8 math 
> may overflow? Could be useful to refocus the comment on the 'why'
> 

We actually never put more than MEMCG_CHARGE_BATCH in the cache and thus
we can use u8 as type here. Though we may increase the batch size in
future, so I should put a BUILD_BUG_ON somewhere here.

> >  		memcg_uncharge(memcg, nr_pages);
> >  		return;
> >  	}
> 
> nits notwithstanding:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks a lot for the review.

