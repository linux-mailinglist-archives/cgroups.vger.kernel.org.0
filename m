Return-Path: <cgroups+bounces-6372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D1A21DD1
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AAE1656C3
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A855887;
	Wed, 29 Jan 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEmSaoDC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eIRzKsjk"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2060B661;
	Wed, 29 Jan 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156996; cv=none; b=cRyvCAU0l2WqQXcz/nCYJAfrFtStWBjjLE0QUjpxDh+nTQZblUWi6/3I2PiRGETeZ+tA4mBG4eKulXwU6hqWuCuzncT6aON/E2fdStF8wBwgdvS0UV+Rwr5Pr50urRztPfVAhPhYR39Z7INtALEwCsscDmKxusnIfT/7dCH8llQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156996; c=relaxed/simple;
	bh=bRIMuwrtVhRe8irgXuqFELvBWvUL04xuIn7QM+L7aL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYbVsZLIqcMI1tUdsnWwP75IRyMKztFTQRHdAQaQkTNn3X+Goy1pQ7NuT6BO6v/l7x10JGDHMIzaFPcDGSujiVk6kEzv2xBbw+IVGOzEoqS3U5SchIQMbkeBsGI8dDV+szmfWQVB/So2QERP9/KUbdZ1V3msJVb0lQAUrpSJQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEmSaoDC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eIRzKsjk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 14:23:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738156992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oE2+DmKr0YQ/UIre6pMeuSvQZMoSevLgolsCS9WRPDE=;
	b=UEmSaoDCNmhED36aNcJEPMvVjYrbdmogq2La1wrSm+1pqmrbxgH+PQYf0NAwXj17yVcpEq
	BkjkeoxwquPw6eSOlkUSWJf29xaxbZ0xl2fvlhxe375qdEywtB+3XHwLkGGo7ljtnPZJ9R
	zUWWxu2LrEP1bAI6iqcJF0dNXBR9iDE82X+HUGE5OxxHqqjxjeDt53oWk0BeKdPrpXcY/D
	XCRoJdnwgYYalLI0MErdNISXPNEJ96jD+6r1V61vXox3Ngu9UAJFs4Y0qgCn2Uhlnw4hcw
	b+lmk7b4+7DrjAKyz7H3lx/yZZM7snaFHz0fWJi1Se6d9N83/5TkEc45M8QtdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738156992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oE2+DmKr0YQ/UIre6pMeuSvQZMoSevLgolsCS9WRPDE=;
	b=eIRzKsjkUz1uB8TabGd1oVLOwuGhEQv2QlIbUcExHyV3VZLCx70v8DZWD6alVM4lMCepBx
	ZOzIwE7LhvJWQmBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v5 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <20250129132311.rQM6LtB2@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-6-bigeasy@linutronix.de>
 <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>

On 2025-01-28 10:31:47 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> Mostly look great to me. Left mostly minor comments.
> 
> On Tue, Jan 28, 2025 at 09:42:25AM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -947,10 +947,20 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
> >  	return 0;
> >  }
> >  
> > +static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
> > +{
> 
> nit: Rename rdt_kn_parent_priv() to be consistent with other accessors?

Oh, indeed.

> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 5a1fea414996e..16d268345e3b7 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -64,9 +64,9 @@ static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
> >  {
> >  	size_t depth = 0;
> >  
> > -	while (to->parent && to != from) {
> > +	while (rcu_dereference(to->__parent) && to != from) {
> 
> Why not use kernfs_parent() here and other places?

Because it is from within RCU section and the other checks are not
required. If you prefer this instead, I sure can update it.

> > @@ -226,6 +227,7 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
> >  	unsigned long flags;
> >  	int ret;
> >  
> > +	guard(rcu)();
> 
> Doesn't irqsave imply rcu?

hmm. It kind of does based on the current implementation but it is not
obvious. We had RCU-sched and RCU which got merged. From then on, the
(implied) preempt-off part of IRQSAVE should imply RCU (section).
It is good to be obvious about RCU.
Also, rcu_dereference() will complain about missing RCU annotation. On
PREEMPT_RT rcu_dereference_sched() will complain because irqsave (in
this case) will not disable interrupts.

> > @@ -558,11 +567,7 @@ void kernfs_put(struct kernfs_node *kn)
> >  		return;
> >  	root = kernfs_root(kn);
> >   repeat:
> > -	/*
> > -	 * Moving/renaming is always done while holding reference.
> > -	 * kn->parent won't change beneath us.
> > -	 */
> > -	parent = kn->parent;
> > +	parent = kernfs_parent(kn);
> 
> Not a strong opinion but I'd keep the comment. Reader can go read the
> definition of kernfs_parent() but no harm in explaining the subtlety where
> it's used.

Okay. will bring it back.

> > @@ -1376,7 +1388,7 @@ static void kernfs_activate_one(struct kernfs_node *kn)
> >  	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
> >  		return;
> >  
> > -	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
> > +	WARN_ON_ONCE(kernfs_parent(kn) && RB_EMPTY_NODE(&kn->rb));
> 
> Minor but this one can be rcu_access_pointer() too.
ok.

> > @@ -1794,7 +1813,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
> >  {
> >  	if (pos) {
> >  		int valid = kernfs_active(pos) &&
> > -			pos->parent == parent && hash == pos->hash;
> > +			kernfs_parent(pos) == parent && hash == pos->hash;
> 
> Ditto with rcu_access_pointer(). Using kernfs_parent() here is fine too but
> it's a bit messy to mix the two for similar cases. Let's stick to either
> rcu_access_pointer() or kernfs_parent().

I make both (kernfs_activate_one() and kernfs_dir_pos) use
rcu_access_pointer() then.

> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index b42ee6547cdc1..c43bee18b79f7 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -64,11 +66,14 @@ struct kernfs_root {
> >   *
> >   * Return: the kernfs_root @kn belongs to.
> >   */
> > -static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
> > +static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
> >  {
> > +	const struct kernfs_node *knp;
> >  	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
> > -	if (kn->parent)
> > -		kn = kn->parent;
> > +	guard(rcu)();
> > +	knp = rcu_dereference(kn->__parent);
> > +	if (knp)
> > +		kn = knp;
> >  	return kn->dir.root;
> >  }
> 
> This isn't a new problem but the addition of the rcu guard makes it stick
> out more: What keeps the returned root safe to dereference?

As far as I understand it kernfs_root is around as long as the
filesystem itself is around which means at least one node needs to stay.
If you have a pointer to a kernfs_node you should own a reference.
The RCU section is only needed to ensure that the (current) __parent is
not replaced and then deallocated before the caller had a chance to
obtain the root pointer.

> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index d9061bd55436b..214aa378936cd 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -633,9 +633,22 @@ int cgroup_task_count(const struct cgroup *cgrp)
> >  	return count;
> >  }
> >  
> > +static struct cgroup *kn_get_priv(struct kernfs_node *kn)
> > +{
> > +	struct kernfs_node *parent;
> > +	/*
> > +	 * The parent can not be replaced due to KERNFS_ROOT_INVARIANT_PARENT.
> > +	 * Therefore it is always safe to dereference this pointer outside of a
> > +	 * RCU section.
> > +	 */
> > +	parent = rcu_dereference_check(kn->__parent,
> > +				       kernfs_root_flags(kn) & KERNFS_ROOT_INVARIANT_PARENT);
> > +	return parent->priv;
> > +}
> 
> kn_priv()?

Oh, yes.

> Thanks.

Sebastian

