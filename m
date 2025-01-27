Return-Path: <cgroups+bounces-6340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA50A1DA81
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBAB1885DB0
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026215573F;
	Mon, 27 Jan 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ctjkyIb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcv8AqdX"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4314E2E8;
	Mon, 27 Jan 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995148; cv=none; b=fZE7EcxXo/j+kYiAjtb9qpQZ0uFm1t4nCtzl7I5ltQ/blStuURZkm7iXHOStjdOEWSoavn06FOnl9wbA+q2lIGYjl9QybuvZf7H1SUij5jMtFbhk3zr4epVoesNgq8OAQWEWemzSVf3T5cOnLc7fTKhn9hdiA76qsLHNsWDWPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995148; c=relaxed/simple;
	bh=mzqo05rYvoEo1lJ65On9CTGCcKFh2sluwnvSHtV49tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YITUaXT3m01u+O7l9NbIWmHhkHGJHXQc6Ml/FI+ZAKtIMaTxbOOlu7tRnQJ30ZO0jNc0meMSZHYHbDmwSvOWyO0haDdz1dF3W/kxgN/WXXx3mzDjszxp9X/sQJFag2092Y4w2R18IoO0Ezuq87YrAzwr15q1BSSmyYg4wkNhPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ctjkyIb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcv8AqdX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 17:25:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737995144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wpSo8hqCFxJTR+xjyinyE+mnUEOgspTWkiDvOxmEh8=;
	b=3ctjkyIbZWbqfRcVIM4hxOJ2d9FPx/IS1ETgqHYtwQd1S00VEgkXaWOl7xv1uw5AsUTXkz
	2cpdeQPBKgDt0Ax0GUzCvVbwj3nDXyrXFTi0CUcFVy3I2Qj8bioaMjEEhVk4pbUIkFOlAJ
	sG4jNq2pGrPpE5rl+Fd0wsZhzILoOBgMfYmP/TpaLiP3UbFHPHmwf9UAa+BoKMcyQQnV/h
	4wCy+G0Gn2BLO7EoKrHwF+kbuF89Bd86tMTQBJ/Rv9ffodwkfnPLsLUC0l9f5P/QcHKCwE
	QWnUd7I5hlFoFbSwsash3eYkpZitEuAHunSzh1DvXMdisgIrMQLOu2ckMZVrNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737995144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wpSo8hqCFxJTR+xjyinyE+mnUEOgspTWkiDvOxmEh8=;
	b=zcv8AqdXjDVTjTclmoZjTs7d04Hd/2Hx2t66l5oxT+/kUesLHjsbAL6l8uEWFffbZnoXbA
	oIH1CE1omDmpw9DQ==
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
Subject: Re: [PATCH v4 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <20250127162543.Vr347xPN@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-6-bigeasy@linutronix.de>
 <Z5Qjq73QhbaJyTjV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5Qjq73QhbaJyTjV@slm.duckdns.org>

On 2025-01-24 13:35:07 [-1000], Tejun Heo wrote:
> On Fri, Jan 24, 2025 at 06:46:13PM +0100, Sebastian Andrzej Siewior wrote:
> ...
> > +static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
> > +{
> > +	guard(rcu)();
> > +	return rcu_dereference(kn->__parent)->priv;
> > +}
> ...
> > @@ -2429,12 +2435,13 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
> >  		 * resource. "info" and its subdirectories don't
> >  		 * have rdtgroup structures, so return NULL here.
> >  		 */
> > -		if (kn == kn_info || kn->parent == kn_info)
> > +		if (kn == kn_info ||
> > +		    rcu_dereference_check(kn->__parent, true) == kn_info)
> 
> Why is this safe? What's protecting ->__parent?

rcu_access_pointer() is what I was looking for. The __parent pointer is
not dereferenced only compared. 

> ...
> > @@ -3773,6 +3780,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
> >  		ret = -EPERM;
> >  		goto out;
> >  	}
> > +	parent_kn = rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex));
> 
> Can you please encapsulate the rule in a helper? e.g.
> 
>   static rdt_kn_parent(struct kernfs_node *kn)
>   {
>           return rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex) + /* whatever other conditions that make accesses safe */);
>   }
> 
> and then you can use that everywhere e.g.:
> 
>   static void *rdt_get_kn_parent_priv(struct krenfs_node *kn)
>   {
>           guard(rcu)();
>           return rdt_kn_parent(kn)->priv;
>   }
> 
> This way, the rule to access kn->__parent is documented and enforced in a
> single place. If the access rules can't be described like this, open coding
> exceptions is fine but some documentation would be great.

Okay.

> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 5a1fea414996e..8e92928c6bca6 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -56,7 +56,7 @@ static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
> >  	if (!kn)
> >  		return strscpy(buf, "(null)", buflen);
> >  
> > -	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
> > +	return strscpy(buf, rcu_access_pointer(kn->__parent) ? kn->name : "/", buflen);
> 
> rcu_access_pointer() is for when only the pointer value is used without
> dereferencing it. Here, the poiner is being dereferenced.

Is it? It checks if the pointer NULL and if so "/" is used otherwise
"kn->name". The __parent pointer itself is not dereferenced. 

> > @@ -295,7 +296,7 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
> >  	unsigned long flags;
> >  
> >  	read_lock_irqsave(&kernfs_rename_lock, flags);
> > -	parent = kn->parent;
> > +	parent = rcu_dereference_check(kn->__parent, lockdep_is_held(&kernfs_rename_lock));
> 
> Ditto, it'd be better to encapsulate the access rules in a helper so that
> these aren't open coded differently in different places.
> 
> ...
> > @@ -562,7 +570,7 @@ void kernfs_put(struct kernfs_node *kn)
> >  	 * Moving/renaming is always done while holding reference.
> >  	 * kn->parent won't change beneath us.
> >  	 */
> > -	parent = kn->parent;
> > +	parent = rcu_dereference_check(kn->__parent, !atomic_read(&kn->count));
> 
> And this rule can be encoded in the same accessor function so that the rules
> can be documented and enforced from (if possible) a single place.
> 
> > @@ -1760,8 +1777,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
> >  	/* rename_lock protects ->parent and ->name accessors */
> >  	write_lock_irq(&kernfs_rename_lock);
> >  
> > -	old_parent = kn->parent;
> > -	kn->parent = new_parent;
> > +	old_parent = rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));
> 
> Another rule here.
> 
> > +static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *kn)
> > +{
> > +	return rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));
> > +}
> 
> AFAICS, all rules can be put into this helper, no?

This would work. kernfs_parent() is the "general purpose" access. It is
used in most places (the kernfs_rename_ns() usage is moved to
kernfs_parent() in the following patch, ended here open coded during the
split, fixed now).

The "!atomic_read(&kn->count)" rule is a special case used only in
kernfs_put() after the counter went to 0 and should not be used (used as
in be valid) anywhere else. This is special because is going away and
__parent can not be renamed/ replaced at this point. One user in total.

The "lockdep_is_held(&kernfs_rename_lock)" rule is only used in
kernfs_get_parent(). One user in total.

Adding these two cases to kernfs_parent() will bloat the code a
little in the debug case (where the check is expanded). Also it will
require to make kernfs_rename_lock global so it be accessed outside of
dir.c.
All in all I don't think it is worth it. If you however prefer it that
way, I sure can update it.

> ...
> > +static struct cgroup *kn_get_priv(struct kernfs_node *kn)
> > +{
> > +	return rcu_dereference_check(kn->__parent, kn->flags & KERNFS_ROOT_INVARIANT_PARENT)->priv;
> > +}
> 
> The flag is a root flag but being tested against a node flags field.

Right you are. I've seen this flag set and that the root node's flags
were ORed into the child node but I can't find where this does happen.
It does not. I must have seen KERNFS_ACTIVATED then.

> Thanks.

Sebastian

