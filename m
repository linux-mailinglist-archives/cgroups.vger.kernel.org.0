Return-Path: <cgroups+bounces-6190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A28A13AE4
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A98F16238A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F522A815;
	Thu, 16 Jan 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Du3x0vOS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3io+5iO1"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936622A4F8;
	Thu, 16 Jan 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034071; cv=none; b=djV5boQOUQY7U45Nzlg6cWjp7dGNYMhkdm5Tpylyqehbwo/pYecIWbflT0Y6HlEM32e6Mm7VSYcAW069hNabTsNJsZZaWeO6reFK0ngAHtFRPiUJBhe6qbm18AWsePHzF4pHIxA3rPjh64sJHhSGXMZGdvUd7eXHDh1/HqcZLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034071; c=relaxed/simple;
	bh=l/T7plXcpP29FZHHQhGzHXy0hE1U0hsX/x8BdPdh9nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOByO2D8oTJNJ4Tw3rUO5QEi/W0e+tkABuOfOSZ1kb5qGo/eJm1mVpOTGKWBRkrhJoMhYC3A3b9raid0DC6lUwYNL3ls1dd6GOnhAs6V84+RKlCO9xqsNN6FjV8j4EcexM9boNLo5kGUynO3ZmR+OCidlyGNswWwecwpn+59CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Du3x0vOS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3io+5iO1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 14:27:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737034067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SPLrFf0Ec4DFWxn/0haSGnGI89OQsFLS9E1NJndjpM=;
	b=Du3x0vOSCMrMwYYCpMYP8A1E9nfJ/fwDidcFuMF3ur9PmY38hMnIoC57OYlCbd+M5JcvMS
	SQiKNc4w1F0rcHIX5EAxiBY1x0jmbgWisIu6Ib8IGiwpyWBZ5IQ9TkNseQdSGWYHyT8fOB
	leoqCMkGBfRUOI8JzsqkJ+lPMKW90XsbEHcPvW/7XLUz25kI2nMQ4GQgwBfn7D7GfKK5Mo
	97C6KKXT/fHzaSrkk2SDgLjdqfZ9GGJPMWARNA7YwS5VwuhMEJft6BSQBQtcY8eHGMGNV2
	ETZna9nA1wKx+bXztkSJXWxzG1OrfFSgPrhlJQSiS+4iRT7UReS/nOn00QSvKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737034067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SPLrFf0Ec4DFWxn/0haSGnGI89OQsFLS9E1NJndjpM=;
	b=3io+5iO1FnUP5yA01lYgknZnxjCJsJvAkd8Zp82t7KQ7RuqLiwPRATwAicUh3k8GddoOi3
	RbWtcxLDMd9NdiBQ==
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
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <20250116132745.dU941oor@linutronix.de>
References: <20241121175250.EJbI7VMb@linutronix.de>
 <Z0-Eg0B09JQUZG2N@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0-Eg0B09JQUZG2N@slm.duckdns.org>

On 2024-12-03 12:21:55 [-1000], Tejun Heo wrote:
> Hello, sorry about the delay.
Hi,

> Generally looks good to me but I have some rcu deref accessor related
> comments.

no worries, I also fell behind.

> On Thu, Nov 21, 2024 at 06:52:50PM +0100, Sebastian Andrzej Siewior wrote:
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> ...
> > @@ -1312,6 +1314,11 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> >  		ret = -EINVAL;
> >  		goto out_region;
> >  	}
> > +	kn_name = kstrdup(rdt_kn_get_name(rdtgrp->kn), GFP_KERNEL);
> 
> Shouldn't this be freed somewhere?

There is
         char *kn_name __free(kfree) = NULL;

at the top. This will kfree(kn_name) once it is out of scope (on return
from rdtgroup_pseudo_lock_create()).

> > +	if (!kn_name) {
> > +		ret = -ENOMEM;
> > +		goto out_cstates;
> > +	}
> >  
> >  	plr->thread_done = 0;
> >  
> ...
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> ...
> > @@ -533,7 +543,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
> >  {
> >  	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
> >  
> > -	kfree_const(kn->name);
> > +	/* If the whole node goes away, the name can't be used outside */
> > +	kfree_const(rcu_dereference_check(kn->name, true));
> 
> rcu_access_pointer()?
oh, thanks.

> > @@ -557,16 +568,18 @@ void kernfs_put(struct kernfs_node *kn)
> >  	if (!kn || !atomic_dec_and_test(&kn->count))
> >  		return;
> >  	root = kernfs_root(kn);
> > +	guard(rcu)();
> >   repeat:
> >  	/*
> >  	 * Moving/renaming is always done while holding reference.
> >  	 * kn->parent won't change beneath us.
> >  	 */
> > -	parent = kn->parent;
> > +	parent = rcu_dereference(kn->parent);
> 
> I wonder whether it'd be better to encode the reference count rule (ie. add
> the condition kn->count == 0 to deref_check) in the kn->parent deref
> accessor. This function doesn't need RCU read lock and holding it makes it
> more confusing.

You are saying that we don't need RCU here because if we drop the last
reference then nobody can rename the node anymore and so parent can't
change. That sounds right.
What about using rcu_dereference_protected() instead? Using
rcu_dereference(x, !atomic_read(&kn->count)) looks odd given that we
established that the counter is 0. Therefore I would suggest
rcu_access_pointer() but the reference drop might qualify as "locked".

> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index 8502ef68459b9..05f7b30283150 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -911,9 +911,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
> >  	/* kick fsnotify */
> >  
> >  	down_read(&root->kernfs_supers_rwsem);
> > +	down_read(&root->kernfs_rwsem);
> 
> Why is this addition necessary? Hmm... was the code previously broken w.r.t.
> renaming? Can this be RCU?

I *think* it was broken unless you unsure somehow that this can't be
invoked on nodes which can be renamed.
The ensures that the later obtained kn_name does not freed after a
rename.
This can not be RCU because ilookup() has wait_on_inode() (might sleep).

> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index 1358c21837f1a..db71faba3bb53 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -145,8 +145,10 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
> >  static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
> >  {
> >  	struct kernfs_node *kn = kernfs_dentry_node(child);
> > +	struct kernfs_root *root = kernfs_root(kn);
> >  
> > -	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
> > +	guard(rwsem_read)(&root->kernfs_rwsem);
> > +	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_rcu_get_parent(kn)));
> 
> Ditto.

kernfs_rcu_get_parent() gets you name from the kn. Can you ensure that
it won't go away during a rename? If so, I would add the matching
comment then.
There is d_obtain_alias() -> __d_obtain_alias() -> d_alloc_anon() which
makes not possible to use RCU.

> > @@ -186,10 +188,10 @@ static struct kernfs_node *find_next_ancestor(struct kernfs_node *child,
> >  		return NULL;
> >  	}
> >  
> > -	while (child->parent != parent) {
> > -		if (!child->parent)
> > +	while (kernfs_rcu_get_parent(child) != parent) {
> > +		child = kernfs_rcu_get_parent(child);
> > +		if (!child)
> 
> I think kernfs_rcu_get_parent() name is a bit confusing given that it allows
> derefing without RCU if the rwsem is locked. Maybe just kernfs_get_parent()
> or kernfs_parent()?

kernfs_get_parent() exists, switching to kernfs_parent() then.

> > @@ -216,6 +219,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
> >  	if (!kn->parent)
> >  		return dentry;
> >  
> > +	root = kernfs_root(kn);
> > +	guard(rwsem_read)(&root->kernfs_rwsem);
> 
> Here too, it's a bit confusing that it's adding new locking. Was the code
> broken before? If so, it'd be clearer if the fixes were in their own patch.

It dereferences name (later in lookup_positive_unlocked()). I don't see
how it is safe against a rename without the lock.

If you agree that all three are bugs, that existed before, then I will
extract it out of this patch.

> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index d1995e2d6c943..e9bfe3e80809d 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -19,13 +19,19 @@
> >  
> >  #include "sysfs.h"
> >  
> > +static struct kobject *sysfs_file_kobj(struct kernfs_node *kn)
> > +{
> > +	guard(rcu)();
> > +	return rcu_dereference(kn->parent)->priv;
> > +}
> 
> I wonder whether it'd be better to rename kn->parent to something like
> kn->__parent (or maybe some other suffix) to clarify that the field is not
> to be deref'ed directly and kernfs_parent() helper is made available to the
> users. That way, users can benefit from the additional conditions in
> rcu_dereference_check().

sparse should yell at people if they deference directly. I have no
problem to rename it to __parent if you say so.

> > diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> > index e28d5f0d20ed0..202e329759b12 100644
> > --- a/kernel/cgroup/cgroup-v1.c
> > +++ b/kernel/cgroup/cgroup-v1.c
> > @@ -844,7 +844,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
> >  
> >  	if (kernfs_type(kn) != KERNFS_DIR)
> >  		return -ENOTDIR;
> > -	if (kn->parent != new_parent)
> > +	if (rcu_dereference_check(kn->parent, true) != new_parent)
> >  		return -EIO;
> 
> This isn't being derefed, rcu_access_pointer()?

Ok.

> >  	/*
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 044c7ba1cc482..d11d05a53783c 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -633,9 +633,15 @@ int cgroup_task_count(const struct cgroup *cgrp)
> >  	return count;
> >  }
> >  
> > +static struct cgroup *cg_get_parent_priv(struct kernfs_node *kn)
> > +{
> > +	/* The parent can not be changed */
> > +	return rcu_dereference_check(kn->parent, true)->priv;
> > +}
> 
> e.g. Here, it'd be a lot better if kernfs provided helper can be used so
> that deref condition check can be preserved.

Something like
| static struct cgroup *cg_get_parent_priv(struct kernfs_node *kn)
| {
|       return rcu_dereference_check(kn->parent, kn->flags & KERNFS_ROOT_INVARIANT_PARENT)->priv;
| }

then?

> Thanks.

Sebastian

