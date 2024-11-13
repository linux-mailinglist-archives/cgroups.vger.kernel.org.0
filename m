Return-Path: <cgroups+bounces-5524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798649C6A1D
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F96284F43
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FE189F36;
	Wed, 13 Nov 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MrTdHZOT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMWd9kZr"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4D189BA9;
	Wed, 13 Nov 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483736; cv=none; b=SM2ai21rmKyupQg4Qpeseictprkp0mpoS44OW+y5ekw36Kl44zYTIb8ctnYrskvW5ZczW075TWoRL/keedJJT6sLYlVT0V2yfeIpminDTVp/SmgjLA9gpuUZn0Xd5cbWyOptDJko5q/S3uV1ExeUWd46B+EtZSRYWh4bgGpnc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483736; c=relaxed/simple;
	bh=ma4wONWvouC+vxfRc+J6/pDb0lSowyLWhkuynaKssU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfLqQBOXDmg266sh7e+tGQj6cV9lqUqm76pze+HV7z7I/SPMw/y5GLqddzpZe2sYRo6HN2nP6NM24oIGD8ztLjKcqr3iLYFJ7g8cpi4PAjP31NovDrErgDMOYx7xD6ikI4CT8KiZlTn5h33Q2imotH2Crrwe0MAdxkA68wZIa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MrTdHZOT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMWd9kZr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 08:42:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731483732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTj/9ZUYWeBiclfz3d3AfplQIm3LCpEopprUsZwwNQw=;
	b=MrTdHZOTSZOnHXmnBBOSmHCsTe3xoi1gLgWQUEZqkhy+1I87eLHAaKBc7z/Y62YAcJNEHT
	YHY4v9TGStmSQpGfWchhIrqGhUQhm7sGZZZ1kkCVa1vxKtn7t/wmOvfb5ZvnAeLGYAvN9N
	+5EXaElqnHVEaWCtiY0YbUzDzVge2EBLkUg1S4c9a9CUUvFbYywezF937iybCEfznd2xqI
	MIpZuDtwySp6x3+VBWf4o2b9MkXgzgnNCfAH0E59+dxYyhb8jmPqELyr+MMdz3XZVl/Cja
	QnpVQjXP7UFfMGLELBDU8tKKrCyqsGvrmvRNnE/hjYgwU2CB9XiysU6jzapI3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731483732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTj/9ZUYWeBiclfz3d3AfplQIm3LCpEopprUsZwwNQw=;
	b=RMWd9kZr3AFNjFtioeK3GhaySGej6FJAALQXJ6ZgOH9+au5/TC+O+YQrQbTVBZCjPCkfGD
	H6fD1oD9xHIngzAg==
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
	tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] kernfs: Make it possible to use RCU for
 kernfs_node::name lookup.
Message-ID: <20241113074210.rlH2mJiD@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-2-bigeasy@linutronix.de>
 <ZzOj2z4g7nzWnCBb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzOj2z4g7nzWnCBb@slm.duckdns.org>

On 2024-11-12 08:52:11 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> On Tue, Nov 12, 2024 at 04:52:38PM +0100, Sebastian Andrzej Siewior wrote:
> ...
> > KERNFS_ROOT_SAME_PARENT is added to signal that the parent never
> 
> Maybe KERNFS_ROOT_INVARIANT_PARENT captures it better?

Sure.

> ...
> > @@ -195,13 +191,47 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
> >   */
> >  int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
> >  {
> > +	struct kernfs_root *root;
> >  
> > +	guard(read_lock_irqsave)(&kernfs_rename_lock);
> > +	if (kn) {
> > +		root = kernfs_root(kn);
> > +		if (WARN_ON_ONCE(root->flags & KERNFS_ROOT_SAME_PARENT))
> > +			kn = NULL;
> 
> Hmm... does kn need to be set to NULL here?

actually no, because read_lock() implies RCU protection.

> > +	}
> > +
> > +	if (!kn)
> > +		return strscpy(buf, "(null)", buflen);
> > +
> > +	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
> ...
> > +int kernfs_name_rcu(struct kernfs_node *kn, char *buf, size_t buflen)
> > +{
> > +	struct kernfs_root *root;
> > +
> > +	if (kn) {
> > +		root = kernfs_root(kn);
> > +		if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_SAME_PARENT)))
> > +			kn = NULL;
> 
> Ah, I suppose it's to keep things symmetric. That's fine.
> 
> > +	}
> > +	if (!kn)
> > +		return strscpy(buf, "(null)", buflen);
> > +
> > +	guard(rcu)();
> 
> Also, why are guards in different locations? Even when !SAME_PARENT, kn's
> can't jump across roots, so guard there can also be in the same location as
> this one?

I tried to limit the scope but it can be symmetrical.

> ...
> > @@ -200,7 +205,10 @@ struct kernfs_node {
> >  	 * parent directly.
> >  	 */
> >  	struct kernfs_node	*parent;
> > -	const char		*name;
> > +	union {
> > +		const char		__rcu *name_rcu;
> > +		const char		*name;
> > +	};
> 
> Wouldn't it be simpler if ->name is always __rcu and !SAME_PARENT just
> requires further protection on the read side?

Let me try that again.

> Thanks.
> 

Sebastian

