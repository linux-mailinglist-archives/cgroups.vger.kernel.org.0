Return-Path: <cgroups+bounces-6374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C4A22258
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF9A16A1DF
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF11DFD8C;
	Wed, 29 Jan 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmwYE5Co"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B91FC8;
	Wed, 29 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169675; cv=none; b=MN3Q7NHfgIatlYu6IF2zJe1jAXdIVM2DNE4hYClFNys/xA+UEbVh8KVe5J5W5KHczkzrk/faP36+VikpYmQ7IwqbE9ZB/mx9Lqf3wTCRjiWSqCqfbXM754z/erJdzELnRdfyz3LKj9VU1AYDt6/vptxC2duhWUGReBLyqaSOhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169675; c=relaxed/simple;
	bh=5DzyjhEnBZrWrnww8fkud5rAKA3oiEEpfyeYhVYZBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e89jeVg0q+Y1Xtl8wMnwOGMUp0rJrOwAxWJm4y7+37OpsmbwXvdLxE0qXZ1KHlOgb4rb+hqW0etqLuyqZUGJdHpmrQFThFbmZmiD35roRMawzyQbMKTGK/Q4FqaVkd3p8gXQwqc5Bze7zRHujTASaHc4pVFFBybprEtc+gBrhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmwYE5Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F734C4CED1;
	Wed, 29 Jan 2025 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169674;
	bh=5DzyjhEnBZrWrnww8fkud5rAKA3oiEEpfyeYhVYZBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmwYE5Coj37paT0zK/U7QwjRhNIWLjF/U25qeAFwWPDmM+idfnfkDAt/Q46Tjratq
	 GmM2ry0hTp/Selt+yt1lfOFey16RXuQ5fh+CP3CMOzSIhTknNIPYtgS1KXhOHUPOt0
	 DCB7Q/3/eI91m0Uo95TG3deN8V+fcFy18lXA4MWslU+azitUWA2nAHE6eU1+EBs09u
	 0D3OzzfJzCG3mLmeqfeIKRQ8SxBya+UU5zPk2gBBROY8cj3fTkJOuZvbhDPoAeIdUA
	 c6t0gQIf9tFpa71k2GokpYayV+ay4Fk3EU83ys2eij1mSk4iIdSfl5cpA+y+OxOze5
	 +ees8vB/vJ7rg==
Date: Wed, 29 Jan 2025 06:54:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v5 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <Z5pdSZ6akuLnfGMI@slm.duckdns.org>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-6-bigeasy@linutronix.de>
 <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>
 <20250129132311.rQM6LtB2@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129132311.rQM6LtB2@linutronix.de>

Hello,

On Wed, Jan 29, 2025 at 02:23:11PM +0100, Sebastian Andrzej Siewior wrote:
> > > @@ -64,9 +64,9 @@ static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
> > >  {
> > >  	size_t depth = 0;
> > >  
> > > -	while (to->parent && to != from) {
> > > +	while (rcu_dereference(to->__parent) && to != from) {
> > 
> > Why not use kernfs_parent() here and other places?
> 
> Because it is from within RCU section and the other checks are not
> required. If you prefer this instead, I sure can update it.

Hmm... I would have gone with using the same accessor everywhere but am not
sure how strongly I feel about it. I don't think it's useful to worry about
the overhead of the extra lockdep annotations in debug builds. Ignoring that
and just considering code readability, what would you do?

> > > @@ -226,6 +227,7 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
> > >  	unsigned long flags;
> > >  	int ret;
> > >  
> > > +	guard(rcu)();
> > 
> > Doesn't irqsave imply rcu?
> 
> hmm. It kind of does based on the current implementation but it is not
> obvious. We had RCU-sched and RCU which got merged. From then on, the
> (implied) preempt-off part of IRQSAVE should imply RCU (section).
> It is good to be obvious about RCU.

There's that but it can also be confusing to have redundant annotations
especially because redundant things tend to become really inconsistent over
time. After the RCU type merges, ISTR removing annotations that became
redundant in several places.

> Also, rcu_dereference() will complain about missing RCU annotation. On
> PREEMPT_RT rcu_dereference_sched() will complain because irqsave (in
> this case) will not disable interrupts.

You know this a lot better than I do. If it's necessary for RT builds, it's
not redundant.

> > > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > > index b42ee6547cdc1..c43bee18b79f7 100644
> > > --- a/fs/kernfs/kernfs-internal.h
> > > +++ b/fs/kernfs/kernfs-internal.h
> > > @@ -64,11 +66,14 @@ struct kernfs_root {
> > >   *
> > >   * Return: the kernfs_root @kn belongs to.
> > >   */
> > > -static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
> > > +static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
> > >  {
> > > +	const struct kernfs_node *knp;
> > >  	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
> > > -	if (kn->parent)
> > > -		kn = kn->parent;
> > > +	guard(rcu)();
> > > +	knp = rcu_dereference(kn->__parent);
> > > +	if (knp)
> > > +		kn = knp;
> > >  	return kn->dir.root;
> > >  }
> > 
> > This isn't a new problem but the addition of the rcu guard makes it stick
> > out more: What keeps the returned root safe to dereference?
> 
> As far as I understand it kernfs_root is around as long as the
> filesystem itself is around which means at least one node needs to stay.
> If you have a pointer to a kernfs_node you should own a reference.
> The RCU section is only needed to ensure that the (current) __parent is
> not replaced and then deallocated before the caller had a chance to
> obtain the root pointer.

That sounds reasonable to me.

Thanks.

-- 
tejun

