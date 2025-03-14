Return-Path: <cgroups+bounces-7079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E466A61569
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E429D3B1D12
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAF201113;
	Fri, 14 Mar 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYsDYedX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F202994
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967762; cv=none; b=tWuZ4X0EqMWgHKpr/ao0bnaIXDRJJPDBJtwsgzBLt4lb9q0zyPsG6y+5CntjAsdXiQtiU8YijYP2T3ghbvlCgMPXHlElyIentKm5lFAl0RrGSXcZ7KDFHCoaAIqXtwuEwVOOeuGaCWoIago2Recr9My3idp7fVtcEE5CzQhESJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967762; c=relaxed/simple;
	bh=zJKdUaepvKQjz1Gi8JCnJmHUgSX8/2RO3BJTXjTYnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7+GdzvYVZylman50sDFPe8GqLXFgJJ2favhiyVebrXLgcABAlD/IPzt9Z+X9JFU+lEtzh6b0yA93Vz0hbDPQYEICdSfSr+4rwgSaqEb8YK7LxJEszyv/knx0Eu4BwoETPKckn3AMg/3uGXDws6XB9ccIkfWWEhJyiHYJimLbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYsDYedX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:55:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741967758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/90O0V+OacosFxzAPbv1bKZqaK+9Vyy7YEsU/KBtck=;
	b=SYsDYedXLXq+vuA8ZPxhgob8cxepEESL3mycHq3vy/1mlX0dGbJSeLeGQCv8jAQU9eisUY
	HJEK1V3hF/0J/NpGdOOaHTKJ3UONKP8cjEh7ozwN2hsqAPHQOaoE0sCTK6CEsjJ2cFHrfu
	ztoumi4fcxvM5sxwkuUCNwn2umxAdmE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Message-ID: <2c62mvfo4726x3ci3sze7u55encoycbbzbaatzslkbhur2dkvd@wlli7wrcjlik>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-11-shakeel.butt@linux.dev>
 <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>
 <20250314115802.DESa-C1z@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314115802.DESa-C1z@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:58:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 11:54:34 [+0100], Vlastimil Babka wrote:
> > On 3/14/25 07:15, Shakeel Butt wrote:
> > > Let's switch all memcg_stock locks acquire and release places to not
> > > disable and enable irqs. There are two still functions (i.e.
> > > mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
> > > update the stats on non-RT kernels. For now add a simple wrapper for
> > > that functionality.
> > 
> > BTW, which part of __mod_objcg_mlstate() really needs disabled irqs and not
> > just preemption? I see it does rcu_read_lock() anyway, which disables
> > preemption. Then in __mod_memcg_lruvec_state() we do some __this_cpu_add()
> > updates. I think these also are fine with just disabled preemption as they
> > are atomic vs irqs (but don't need LOCK prefix to be atomic vs other cpus
> > updates).
> 
> __this_cpu_add() is not safe if also used in interrupt context. Some
> architectures (not x86) implemented as read, add, write.
> this_cpu_add()() does the same but disables interrupts during the
> operation.
> So __this_cpu_add() should not be used if interrupts are not disabled
> and a modification can happen from interrupt context.

So, if I use this_cpu_add() instead of __this_cpu_add() in
__mod_memcg_state(), __mod_memcg_lruvec_state(), __count_memcg_events()
then I can call these functions without disabling interrupts. Also
this_cpu_add() does not disable interrupts for x86 and arm64, correct?
For x86 and arm64, can I assume that the cost of this_cpu_add() is the
same as __this_cpu_add()?

> 
> > Is it just memcg_rstat_updated() which does READ_ONCE/WRITE_ONCE? Could we
> > perhaps just change it to operations where disabled preemption is enough?

Yes, I will look into it.

> > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> …
> > > @@ -2757,6 +2745,28 @@ static void replace_stock_objcg(struct memcg_stock_pcp *stock,
> > >  	WRITE_ONCE(stock->cached_objcg, objcg);
> > >  }
> > >  
> > > +static unsigned long rt_lock(void)
> > > +{
> 
> No, we don't name it rt_lock(). We have local_lock() for this exact
> reason. And migrate_disable() does not protect vs re-enter of the
> function on the CPU while local_irq_save() does.

Thanks for clarification. Here do nothing for RT kernel and disable
interrupts for non-RT kernels. (Let'e see how the other conversation
goes, maybe we can remove the interrupt disabling requirement)

