Return-Path: <cgroups+bounces-7959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC1AA4F95
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CFB16A09C
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5C16DC28;
	Wed, 30 Apr 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmqBvlf+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623A78F39
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025408; cv=none; b=MBLdYBHNN7DC+zM6IkOws6d7+y+9rZUx0utV5oRRwCdIUivxzI1jOmt6pf2w5eZ8/F/3QEyMl0mNWBByzqLriakbrPIpirBqraz9mkr0jvA4x99VhOw2xtmEnVzfF6Ac3Sh/f/VoePTz6PAtDbmL+YoL4eWMEkltXepEC+9Gq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025408; c=relaxed/simple;
	bh=muQT55T9kWGWE8UK/cAEHnLmF1tVLjQwPxFANaeIuLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCBg5BGQah65DZM8Cs9EDRPtw+6tPjJo9iU9fwXM2uAsaOfslO9euHYh64zaQuNYbmp73p0WYeqJpf7uxilD9tZO/RLqpcsefQuN1UBR6DgVtIEfSHoM3SwJ93kS5uRkOhyozqSqpN0C45v7CmwL8y/BDn8+iLU1Cf/o+XolQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmqBvlf+; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 08:03:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746025394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtTmY7VNaauY8JAzhPRIMcx1YGjVMzAwEwdhfk28sUs=;
	b=GmqBvlf+HvX3DHUEbaCHIs70ES6Y2F6pCwBPy9hYlXb9hB3Fj9XDAHWU+5l1He2vbKgK8M
	21I10XnRsDe5ngHVPySdB8LcM8UvAn0AEnFBjHAW53NF8dHltqooKnIcfGV0nm4SLSQwAp
	azE0DTPZY+CQsQv3ZV2CiyLtKXKHeT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/4] memcg: separate local_trylock for memcg and obj
Message-ID: <s636pqlp5tfg6p2vt3argmqyysx5d72jtwjpekk5nj7yerbolf@vco5fbwicubb>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-3-shakeel.butt@linux.dev>
 <a9977cb2-3dce-4be1-81a3-23e760082922@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9977cb2-3dce-4be1-81a3-23e760082922@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 01:42:47PM +0200, Vlastimil Babka wrote:
> On 4/30/25 01:04, Shakeel Butt wrote:
> > The per-cpu stock_lock protects cached memcg and cached objcg and their
> > respective fields. However there is no dependency between these fields
> > and it is better to have fine grained separate locks for cached memcg
> > and cached objcg. This decoupling of locks allows us to make the memcg
> > charge cache and objcg charge cache to be nmi safe independently.
> > 
> > At the moment, memcg charge cache is already nmi safe and this
> > decoupling will allow to make memcg charge cache work without disabling
> > irqs.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 52 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> > @@ -1883,19 +1885,22 @@ static void drain_local_stock(struct work_struct *dummy)
> >  	struct memcg_stock_pcp *stock;
> >  	unsigned long flags;
> >  
> > -	/*
> > -	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
> > -	 * drain_stock races is that we always operate on local CPU stock
> > -	 * here with IRQ disabled
> > -	 */
> > -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +	if (WARN_ONCE(!in_task(), "drain in non-task context"))
> > +		return;
> >  
> > +	preempt_disable();
> >  	stock = this_cpu_ptr(&memcg_stock);
> > +
> > +	local_lock_irqsave(&memcg_stock.obj_lock, flags);
> >  	drain_obj_stock(stock);
> > +	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
> > +
> > +	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
> >  	drain_stock_fully(stock);
> > -	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> > +	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
> >  
> > -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > +	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> > +	preempt_enable();
> 
> This usage of preempt_disable() looks rather weird and makes RT unhappy as
> the local lock is a mutex, so it gives you this:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/spinlock_rt.c:48
> 
> I know the next patch removes it again but for bisectability purposes it
> should be avoided. Instead of preempt_disable() we can extend the local lock
> scope here?
> 

Indeed and thanks for the suggestion, will fix in v2.

