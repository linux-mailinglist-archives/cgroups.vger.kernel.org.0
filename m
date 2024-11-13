Return-Path: <cgroups+bounces-5526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588F9C6EFA
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E0B30D3C
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7A200B9E;
	Wed, 13 Nov 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjNfjjK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBPoP5ZA"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DE2003CC;
	Wed, 13 Nov 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499632; cv=none; b=rgoKMtRjckkAdOE66c0AhnXpk6iPO7i0oDVNR5dgTQAUL1omLxyaVeJxlwZuEdbrBmbvF//p8m6UR9PVRjXHNWS3sj9JrnP2ktX1vZf6Qx7unwPjRC2wX30OugtcId1ab3wsfPcBlTEJivgOZvEw18SOhLdeKon+i6VmZxkYLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499632; c=relaxed/simple;
	bh=Q/IreS/W/Tve3q46cZOB9KqlOfPc7fe17oqubQX0Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur3cDAV0QyvGMscvE2m9LP+b0FnTaH63sahCN85WsAgSfhWdAodSA9/aJOpb+GkBdPDg1IWeTMctwF8+Y4mOdpippUdk+c7sZ3JYtTA3lzBraxPmO0V78piKNo5/EYVy0YER7RS0eHj6KMZkqVcXxvzWhKZqlNDSDH+qxTAqtyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjNfjjK/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBPoP5ZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 13:07:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731499628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TCNt2Vac4NiFcRmr526QozckSKV5lxGdR7fjTzGh7Y=;
	b=gjNfjjK/xAvIgETR/0MlVrXkkBl2FM1/E4LEZR0TY4L/uINftKQpThsLtbKIkrhm5WZvdc
	0f+MGRLDEaR4SuC9P/w0tM6UN8gvzwcEIr+bPfu3WjEDI+N++2lKqw9r23Cqn5vUwB2+L7
	wTLKjylDhhxz9C8bTeXPB7JK4eQRIdOCzTWPyy3xMMEf5wczG4nLM420sQp4o0ZAmxRJs9
	HwpHnxsRQ+eqerk9zV88ZzFE+6WAEDkvVqwPj2P4h4TYlkn/BqFIg+rUzPbj7WBaOELRPg
	/fDLuJ8kwi+8Bh5y7sGuTC+Kc5u7Sq1JCuQRmaGuFA2zfhvfOdSspnFPGAUxsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731499628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TCNt2Vac4NiFcRmr526QozckSKV5lxGdR7fjTzGh7Y=;
	b=QBPoP5ZA2qoGDEI/Uwe3mmqC51QeKC/sst18J2gjT0tNBE4kcvlRaHclzahRmPhnpwGdLC
	uj6utfYzYkJR4zCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface
 for name lookups
Message-ID: <20241113120706.rotCvUqt@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-3-bigeasy@linutronix.de>
 <ZzOlhANLYxFaIix2@slm.duckdns.org>
 <20241113074331.B48iqBgp@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113074331.B48iqBgp@linutronix.de>

On 2024-11-13 08:43:32 [+0100], To Tejun Heo wrote:
> On 2024-11-12 08:59:16 [-1000], Tejun Heo wrote:
> > Hello,
> 
> Hi,
> 
> > On Tue, Nov 12, 2024 at 04:52:39PM +0100, Sebastian Andrzej Siewior wrote:
> > ...
> > >  /**
> > > - * pr_cont_kernfs_name - pr_cont name of a kernfs_node
> > > + * pr_cont_kernfs_name_rcu - pr_cont name of a kernfs_node
> > >   * @kn: kernfs_node of interest
> > >   *
> > > - * This function can be called from any context.
> > > + * This function can be called from any context. The root node must be with
> > > + * KERNFS_ROOT_SAME_PARENT.
> > >   */
> > > -void pr_cont_kernfs_name(struct kernfs_node *kn)
> > > +void pr_cont_kernfs_name_rcu(struct kernfs_node *kn)
> > 
> > Having to split the interface all the way up isn't great. While there are
> > also downsides, I wonder whether a better approach here is just making the
> > backend function (kernfs_path_from_node()) automatically use RCU locking if
> > the flag is set rather than propagating the difference by splitting the
> > interface. The distinction doesn't mean anything to most users after all.
> 
> Indeed.

Now I see what the problems are. If we merge both into one, then I get
this:
| int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
| {
|         struct kernfs_root *root;
|         bool rcu_lookup;
|
|         if (!kn)
|                 return strscpy(buf, "(null)", buflen);
|
|         root = kernfs_root(kn);

This is the tricky part. For KERNFS_ROOT_INVARIANT_PARENT I don't worry
that the parent goes away and I need it to get a reference to the
kernfs_root node. For the !KERNFS_ROOT_INVARIANT_PARENT I need the lock
for kernfs_root() so I put the guard/ lock at the top.

I think that is why you suggested the two functions (or this is what I
understood). Looking at the remaining bits:

|         rcu_lookup = root->flags & KERNFS_ROOT_INVARIANT_PARENT;
|         if (rcu_lookup) {
|                 guard(rcu)();
|                 return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
|         }
|         guard(read_lock_irqsave)(&kernfs_rename_lock);
|         return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
| }

This could collapse into the RCU version because read_lock_irqsave()
implies RCU protection. And since ->name is always RCU assigned/
deallocated I don't really need the lock here, RCU would be enough.
Except for the parent. The kn->parent does not matter here (it should be
always be != NULL if assigned), the problematic part is kernfs_root()
which checks the parent for the root node.

To make this simple I could avoid kernfs_root lookup and just have:
| int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
| {       
|         if (!kn)
|                 return strscpy(buf, "(null)", buflen);
|         
|         guard(rcu)();
|         return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
| }                             

That is the easy part. kernfs_path_from_node() is different as it
requires the parent pointer. In order to distinguish the RCU from the
non-RCU version I need kernfs_root for the flag and depending on it, the
lock so the parent does not go away.

Would it work to add the pointer to kernfs_root into kernfs_node? This
would shrink kernfs_elem_dir by a pointer but the union would remain the
same size due to kernfs_elem_attr so the struct would grow.

> > Thanks.

Sebastian

