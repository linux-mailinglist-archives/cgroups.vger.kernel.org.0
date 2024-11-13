Return-Path: <cgroups+bounces-5530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F29C7076
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BF528198B
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AE1DFE35;
	Wed, 13 Nov 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9NWScQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RoD3RD3"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E417DA7F;
	Wed, 13 Nov 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504220; cv=none; b=C/DPhToQ+jK49bncusT3MbPnmXHn0VBUDcuyczuYxWaSFJYBhfokqaQDM67uHIc/f9NP6qhJNZOgCitGqGcxqp4zS8/HrNRYZk83Hh5wdA9xp3OrOCjT/8Y95hCH4gnVky7IZ9ma2SAsBTl8nUWITamMs7ky5pfxHrqxnXNCJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504220; c=relaxed/simple;
	bh=oJ+wYZpfQraGBqNcl6Q7s6PJOt/vw7COqPrbFQl5D74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZe0x9gy5HJ8Vi6SPhssaxPm44zaXqgBoUDGRCSB5q4Fx565+22zCPN0mtS0ROkDC2aDv5NMWgdNE2sgIdlqFma3ps0YCVRajwuAb7I1aUseigMZB/LvvWHyGUohR9nrO2P7glUvu4Xp9HjWlURzX4jxFlZaKVYTsRmAx2UBs0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9NWScQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RoD3RD3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 14:23:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731504215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vq82xxGccfTUf0BQBNGrBV96lp9tQcpfVRLDXa8nGOY=;
	b=G9NWScQ+2uzuncOkgdUm8GAMFMTqObnPB24j2drzxUq/1IqhpYK6PyP+xl7HRo/XPEtNNo
	RpbnXV1LBtblAuQYx5tbzElJR18d7U1KwR6JMQHQO1ZYSLHA4Yh7UEHvSx8px5kqDnpVNb
	4DxfHC21XbPY/nW7jIRfjk0I8M+eJ57C2CLNPY5vEfwjrnbanqIBEtjrkUpMB61kV93unM
	Aec/dF9mNW7T9obn6BAuOInmvh2IFwHhFN/nxQyKrXWmfoHV8AIoTCPy4A+7FYO0zoLAdN
	W3ZaJlKZbxGiXUr80d/3VP9j0BwS69cvAUN9fXmVTgxdDXnNhF+dqulEdCL8hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731504215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vq82xxGccfTUf0BQBNGrBV96lp9tQcpfVRLDXa8nGOY=;
	b=4RoD3RD3M45L+l1WkcikHcDj4wgVDsOKu9HyYHKh9ddcO+hpKMig47m9/95xfwjYwJW3/u
	dhWmZ4qSUF3rc1BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface
 for name lookups
Message-ID: <20241113132333.ayhH2ZH-@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-3-bigeasy@linutronix.de>
 <ZzOlhANLYxFaIix2@slm.duckdns.org>
 <20241113074331.B48iqBgp@linutronix.de>
 <20241113120706.rotCvUqt@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113120706.rotCvUqt@linutronix.de>

- Zefan Li

On 2024-11-13 13:07:08 [+0100], To Tejun Heo wrote:
> On 2024-11-13 08:43:32 [+0100], To Tejun Heo wrote:
> > On 2024-11-12 08:59:16 [-1000], Tejun Heo wrote:
> > > Hello,
> > 
> > Hi,
> > 
> > > On Tue, Nov 12, 2024 at 04:52:39PM +0100, Sebastian Andrzej Siewior wrote:
> > > ...
> > > >  /**
> > > > - * pr_cont_kernfs_name - pr_cont name of a kernfs_node
> > > > + * pr_cont_kernfs_name_rcu - pr_cont name of a kernfs_node
> > > >   * @kn: kernfs_node of interest
> > > >   *
> > > > - * This function can be called from any context.
> > > > + * This function can be called from any context. The root node must be with
> > > > + * KERNFS_ROOT_SAME_PARENT.
> > > >   */
> > > > -void pr_cont_kernfs_name(struct kernfs_node *kn)
> > > > +void pr_cont_kernfs_name_rcu(struct kernfs_node *kn)
> > > 
> > > Having to split the interface all the way up isn't great. While there are
> > > also downsides, I wonder whether a better approach here is just making the
> > > backend function (kernfs_path_from_node()) automatically use RCU locking if
> > > the flag is set rather than propagating the difference by splitting the
> > > interface. The distinction doesn't mean anything to most users after all.
> > 
> > Indeed.
> 
> Now I see what the problems are. If we merge both into one, then I get
> this:
> | int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
> | {
> |         struct kernfs_root *root;
> |         bool rcu_lookup;
> |
> |         if (!kn)
> |                 return strscpy(buf, "(null)", buflen);
> |
> |         root = kernfs_root(kn);
> 
> This is the tricky part. For KERNFS_ROOT_INVARIANT_PARENT I don't worry
> that the parent goes away and I need it to get a reference to the
> kernfs_root node. For the !KERNFS_ROOT_INVARIANT_PARENT I need the lock
> for kernfs_root() so I put the guard/ lock at the top.
> 
> I think that is why you suggested the two functions (or this is what I
> understood). Looking at the remaining bits:
> 
> |         rcu_lookup = root->flags & KERNFS_ROOT_INVARIANT_PARENT;
> |         if (rcu_lookup) {
> |                 guard(rcu)();
> |                 return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
> |         }
> |         guard(read_lock_irqsave)(&kernfs_rename_lock);
> |         return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
> | }
> 
> This could collapse into the RCU version because read_lock_irqsave()
> implies RCU protection. And since ->name is always RCU assigned/
> deallocated I don't really need the lock here, RCU would be enough.
> Except for the parent. The kn->parent does not matter here (it should be
> always be != NULL if assigned), the problematic part is kernfs_root()
> which checks the parent for the root node.
> 
> To make this simple I could avoid kernfs_root lookup and just have:
> | int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
> | {       
> |         if (!kn)
> |                 return strscpy(buf, "(null)", buflen);
> |         
> |         guard(rcu)();
> |         return strscpy(buf, kn->parent ? rcu_dereference(kn->name) : "/", buflen);
> | }                             
> 
> That is the easy part. kernfs_path_from_node() is different as it
> requires the parent pointer. In order to distinguish the RCU from the
> non-RCU version I need kernfs_root for the flag and depending on it, the
> lock so the parent does not go away.
> 
> Would it work to add the pointer to kernfs_root into kernfs_node? This
> would shrink kernfs_elem_dir by a pointer but the union would remain the
> same size due to kernfs_elem_attr so the struct would grow.

The kernfs_node is released via RCU. That means if the RCU read section
starts before kernfs_root() then we should always get a stable pointer,
pointing to the same kernfs_root node since it is always the same one.
Even if the `parent' pointer is replaced. Wouldn't we need __rcu
annotation then for the `parent' pointer then?

> > > Thanks.
> 
Sebastian

