Return-Path: <cgroups+bounces-7078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD577A6150C
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8852A188B595
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500A2040B4;
	Fri, 14 Mar 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLXHOc3X"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354420408D
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966409; cv=none; b=XFtmFDbtoozGOeB6UZYVM0DER5bqICYGola+rqYxbSiKzQf7mNeIIe5ZB+R2JEiDerS/gdajI9qttiHRMYfBRC6PJObsRY2xDLfGfrfHhXvZvXTOpE8hkitmRzulrfECj1bu/AkQXggWpdawcOGFADAQQPydM5U6kjs7kddjsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966409; c=relaxed/simple;
	bh=gfV5KRqfy23+YgcjBRsQElBecHIn+MHo3Eq47qJf7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NftoINdSOm+IsWiKMWvcfqyFwi4CJUQYS3343XXsVQ9CuOegiE4VwPJkZi39Vn9ZNpjLX0TBiI9IeRHeuHDJw20YtDoSlSxUFPuGPXuBudVv1S6e3K1gbR9iyTWrWuneH2DQwgFvv/SIXQfn57BGrwMEPk0/HObKcgnPGWy+knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLXHOc3X; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741966405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQZ1hRUiUX1Uv5De+AMk390tcCYkein0nUGbYfp2WQ8=;
	b=jLXHOc3XIQYh9KwNdMlyCf7igSJ0+ADyoqyy2+froIq3W+bd9up4RHC4gixK2/KleUBjfC
	+fDfEoKQNkRidYjQbC83Jp7Co8HS6aW22UwX1MeTJCCN46QMqLmOG/aUpO24oFO2YucoYQ
	zrWHVqQGmyL0prKATIFtExNZqr6NJXE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 09/10] memcg: trylock stock for objcg
Message-ID: <lr7pg6kxj2rggwaj6pwoca63uvdbqhiphs4hhva4f2pjsfqnwb@7a3ackqh2l66>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-10-shakeel.butt@linux.dev>
 <20250314114700.TiLB4FH0@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314114700.TiLB4FH0@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:47:00PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-13 23:15:10 [-0700], Shakeel Butt wrote:
> > To make objcg stock functions work without disabling irq, we need to
> > convert those function to use localtry_trylock_irqsave() instead of
> > localtry_lock_irqsave(). This patch for now just does the conversion and
> > later patch will eliminate the irq disabling code.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c803d2f5e322..ba5d004049d3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2764,7 +2764,11 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> >  	unsigned long flags;
> >  	int *bytes;
> >  
> > -	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> 
> Don't you need to change the of memcg_stock.stock_lock? Didn't we
> introduce an explicit different type for this trylock feature?
> 

Yes, Alexei has already changed the type of this exact lock at [1].

[1] https://lore.kernel.org/r/20250222024427.30294-5-alexei.starovoitov@gmail.com

