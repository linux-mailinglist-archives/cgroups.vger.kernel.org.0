Return-Path: <cgroups+bounces-5748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4C9E2F84
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 00:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32BEB2F9AC
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77641FC7DB;
	Tue,  3 Dec 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIUn74jP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97D1EF0B6;
	Tue,  3 Dec 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264517; cv=none; b=RKHD/TggjRP7RUAp+504R9Wry/XSOaBpaSxE851S7dakrXhJXZX34x4IiCvLz5ho1uS0CF4bWDC1RDzpEHTtLQIpjdiL6/3rO/2w/m3/n+uYYHYRQ/J2ZJQ6rgkgFnX3A9zxI31aJWiRQASmphZU9M32HZGC7vaA1y/S3ZceJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264517; c=relaxed/simple;
	bh=XC87OSbfu1RXvj2aeaUOX48QbWy9oml2/qRKOSs6whU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLwZwtMPw9C8LBqBNN1APa/SPTg7yGsMRK9jAvwUttPVfEeGVvoXpv7rIdwKXv4THVZ18aYsD8E3PXyBSYCRGg8Z5kGJLOWwK8DSELjM5E1UbY2EOQEnrmfAg8IRl1nzfjPql+6GyVm/QnIqtDWIiHxJAhaahEj6nU8IA1k91VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIUn74jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F88C4CEDC;
	Tue,  3 Dec 2024 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733264517;
	bh=XC87OSbfu1RXvj2aeaUOX48QbWy9oml2/qRKOSs6whU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIUn74jP5JRUJ1+lbOrYIcIvYljZ6zFIOyUNFRlYzLcUbwtI3i8OwB4ACFbm3y0Kf
	 Amh5p2ns05rgLBrHcSowj861GKntgqKrnEwICnMEAujKNq65fzFQrq9LMiHepyFb/r
	 QpbANyeimU9ZDiVVkLNCytNZT5rqjkYgtkKGOgjh+bfiE0/UDcpGpJ6ZmxVdJhCQ95
	 pMlpViE7hYm4aJAlp2iy4cGcrIl37ayThuvb834RkR/5r+NT1T0qo1wNN8NifujDWX
	 SdpWCoH2ZFv1+ecVj/6TK3qLq7dEiuTZp4SjUsE8R52+uWiM5AWg1w/fulb6Ks/pAL
	 Dk+dRMLa7aOiw==
Date: Tue, 3 Dec 2024 12:21:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
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
Message-ID: <Z0-Eg0B09JQUZG2N@slm.duckdns.org>
References: <20241121175250.EJbI7VMb@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121175250.EJbI7VMb@linutronix.de>

Hello, sorry about the delay.

Generally looks good to me but I have some rcu deref accessor related
comments.

On Thu, Nov 21, 2024 at 06:52:50PM +0100, Sebastian Andrzej Siewior wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
...
> @@ -1312,6 +1314,11 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>  		ret = -EINVAL;
>  		goto out_region;
>  	}
> +	kn_name = kstrdup(rdt_kn_get_name(rdtgrp->kn), GFP_KERNEL);

Shouldn't this be freed somewhere?

> +	if (!kn_name) {
> +		ret = -ENOMEM;
> +		goto out_cstates;
> +	}
>  
>  	plr->thread_done = 0;
>  
...
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
...
> @@ -533,7 +543,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
>  {
>  	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
>  
> -	kfree_const(kn->name);
> +	/* If the whole node goes away, the name can't be used outside */
> +	kfree_const(rcu_dereference_check(kn->name, true));

rcu_access_pointer()?

> @@ -557,16 +568,18 @@ void kernfs_put(struct kernfs_node *kn)
>  	if (!kn || !atomic_dec_and_test(&kn->count))
>  		return;
>  	root = kernfs_root(kn);
> +	guard(rcu)();
>   repeat:
>  	/*
>  	 * Moving/renaming is always done while holding reference.
>  	 * kn->parent won't change beneath us.
>  	 */
> -	parent = kn->parent;
> +	parent = rcu_dereference(kn->parent);

I wonder whether it'd be better to encode the reference count rule (ie. add
the condition kn->count == 0 to deref_check) in the kn->parent deref
accessor. This function doesn't need RCU read lock and holding it makes it
more confusing.

> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 8502ef68459b9..05f7b30283150 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -911,9 +911,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	/* kick fsnotify */
>  
>  	down_read(&root->kernfs_supers_rwsem);
> +	down_read(&root->kernfs_rwsem);

Why is this addition necessary? Hmm... was the code previously broken w.r.t.
renaming? Can this be RCU?

> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 1358c21837f1a..db71faba3bb53 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -145,8 +145,10 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
>  static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
>  {
>  	struct kernfs_node *kn = kernfs_dentry_node(child);
> +	struct kernfs_root *root = kernfs_root(kn);
>  
> -	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
> +	guard(rwsem_read)(&root->kernfs_rwsem);
> +	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_rcu_get_parent(kn)));

Ditto.

> @@ -186,10 +188,10 @@ static struct kernfs_node *find_next_ancestor(struct kernfs_node *child,
>  		return NULL;
>  	}
>  
> -	while (child->parent != parent) {
> -		if (!child->parent)
> +	while (kernfs_rcu_get_parent(child) != parent) {
> +		child = kernfs_rcu_get_parent(child);
> +		if (!child)

I think kernfs_rcu_get_parent() name is a bit confusing given that it allows
derefing without RCU if the rwsem is locked. Maybe just kernfs_get_parent()
or kernfs_parent()?

> @@ -216,6 +219,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
>  	if (!kn->parent)
>  		return dentry;
>  
> +	root = kernfs_root(kn);
> +	guard(rwsem_read)(&root->kernfs_rwsem);

Here too, it's a bit confusing that it's adding new locking. Was the code
broken before? If so, it'd be clearer if the fixes were in their own patch.

> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index d1995e2d6c943..e9bfe3e80809d 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -19,13 +19,19 @@
>  
>  #include "sysfs.h"
>  
> +static struct kobject *sysfs_file_kobj(struct kernfs_node *kn)
> +{
> +	guard(rcu)();
> +	return rcu_dereference(kn->parent)->priv;
> +}

I wonder whether it'd be better to rename kn->parent to something like
kn->__parent (or maybe some other suffix) to clarify that the field is not
to be deref'ed directly and kernfs_parent() helper is made available to the
users. That way, users can benefit from the additional conditions in
rcu_dereference_check().

> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index e28d5f0d20ed0..202e329759b12 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -844,7 +844,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
>  
>  	if (kernfs_type(kn) != KERNFS_DIR)
>  		return -ENOTDIR;
> -	if (kn->parent != new_parent)
> +	if (rcu_dereference_check(kn->parent, true) != new_parent)
>  		return -EIO;

This isn't being derefed, rcu_access_pointer()?

>  	/*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 044c7ba1cc482..d11d05a53783c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -633,9 +633,15 @@ int cgroup_task_count(const struct cgroup *cgrp)
>  	return count;
>  }
>  
> +static struct cgroup *cg_get_parent_priv(struct kernfs_node *kn)
> +{
> +	/* The parent can not be changed */
> +	return rcu_dereference_check(kn->parent, true)->priv;
> +}

e.g. Here, it'd be a lot better if kernfs provided helper can be used so
that deref condition check can be preserved.

Thanks.

-- 
tejun

