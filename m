Return-Path: <cgroups+bounces-7074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7794AA61081
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214AE1741EF
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6E1FE444;
	Fri, 14 Mar 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJHImAf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XrDfQ8Ms"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C828635A;
	Fri, 14 Mar 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953488; cv=none; b=D3u/IJNU2S/J4flTte33sZY8AJVQW1lxdFsWmd5j1u7+pMMmG1WCPnF0wgQzb+ZpQ2K4/73v8RBbkgzz+7ioY+fXQPTo/b4zzoFZXidzXaybSLNLI64+TNCIzbW6vGks0Jw5R6F3Gc0yPrtzqLQhlabUEfDGzthd2lqCT1ODNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953488; c=relaxed/simple;
	bh=alG2VBcqxu4/KeTppLaYTCBjh974VZnVLlGEUyVJ34s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7zcJqQBwZ01Y7U40ec+ajtZHL1XJFQbXktU17LseKJbhTXqdWmFaKTPrOCX1QUZvN3fub7KSynzjnh+nAZUZ//k1b1XNcQXNx9UoGt9lXrdMxUX8sXdVi+d+IPksW8UXmjc/ZZPugjTz5/Dg12M4lNKDxU9G6XHq9rpaPWF5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJHImAf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XrDfQ8Ms; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:58:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741953484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uewKNoT8JWDI3vksDZ1lfM+BZl6yGTaXxxJLZKOzx0=;
	b=GJHImAf3Y7UB1RzvBxLOtqJc4jRh/h+gxXQP7hVvQ/uY/ozVfmBAfaT5PfjDbUEAMAEzQf
	bVUsG69XNEjcbVktmfv5cUUhbUXkOV1kn+I4LergArsjOqTRm7Z0L2FpJdi8y6AhZMLAbU
	zu9OzdHZShuCHv+RwE7UXK/SIfi8IC3f2a+ZT0zMZfv2mMT53i8AsWG64l8Mh9cvHeCK0i
	zhb9MIRl9kbT/AVN58rnwvDktH164Oajfi6GVfdriyNWMh8xGFV75Da5ypk6GadFo5nvpc
	WpCx8iKXJp8hOJ1Fw+l+i8b207JoNIKHeK2ihdkh9rwZPkf0YCcC6M7y/z7ASQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741953484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uewKNoT8JWDI3vksDZ1lfM+BZl6yGTaXxxJLZKOzx0=;
	b=XrDfQ8MsdqFP7ajJekANqTpOTS7uitbjh6jCB/v6tJ8WB2HHfVYXFwxVhWlu66lnTyqneO
	nIYvnaaaA+Xkn7Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Message-ID: <20250314115802.DESa-C1z@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-11-shakeel.butt@linux.dev>
 <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>

On 2025-03-14 11:54:34 [+0100], Vlastimil Babka wrote:
> On 3/14/25 07:15, Shakeel Butt wrote:
> > Let's switch all memcg_stock locks acquire and release places to not
> > disable and enable irqs. There are two still functions (i.e.
> > mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
> > update the stats on non-RT kernels. For now add a simple wrapper for
> > that functionality.
>=20
> BTW, which part of __mod_objcg_mlstate() really needs disabled irqs and n=
ot
> just preemption? I see it does rcu_read_lock() anyway, which disables
> preemption. Then in __mod_memcg_lruvec_state() we do some __this_cpu_add()
> updates. I think these also are fine with just disabled preemption as they
> are atomic vs irqs (but don't need LOCK prefix to be atomic vs other cpus
> updates).

__this_cpu_add() is not safe if also used in interrupt context. Some
architectures (not x86) implemented as read, add, write.
this_cpu_add()() does the same but disables interrupts during the
operation.
So __this_cpu_add() should not be used if interrupts are not disabled
and a modification can happen from interrupt context.

> Is it just memcg_rstat_updated() which does READ_ONCE/WRITE_ONCE? Could we
> perhaps just change it to operations where disabled preemption is enough?
>=20
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
=E2=80=A6
> > @@ -2757,6 +2745,28 @@ static void replace_stock_objcg(struct memcg_sto=
ck_pcp *stock,
> >  	WRITE_ONCE(stock->cached_objcg, objcg);
> >  }
> > =20
> > +static unsigned long rt_lock(void)
> > +{

No, we don't name it rt_lock(). We have local_lock() for this exact
reason. And migrate_disable() does not protect vs re-enter of the
function on the CPU while local_irq_save() does.

> > +#ifdef CONFIG_PREEMPT_RT
> > +	migrate_disable();
> > +	return 0;
> > +#else
> > +	unsigned long flags =3D 0;
> > +
> > +	local_irq_save(flags);
> > +	return flags;
> > +#endif
> > +}
> > +
> > +static void rt_unlock(unsigned long flags)
> > +{
> > +#ifdef CONFIG_PREEMPT_RT
> > +	migrate_enable();
> > +#else
> > +	local_irq_restore(flags);
> > +#endif
> > +}
> > +
> >  static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_da=
ta *pgdat,
> >  		     enum node_stat_item idx, int nr)
> >  {

Sebastian

