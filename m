Return-Path: <cgroups+bounces-6288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99942A1BF0D
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC833AE20A
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DA1EE7AF;
	Fri, 24 Jan 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5/Sj+wU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC81E1C10;
	Fri, 24 Jan 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737761709; cv=none; b=o1c1Hc8EnZTX2sZdIsojf/gPzHC7KO8VygKrw1/kyNHtyCJvdju+iaXJYEzIhxoyzL8hApg989oOQiU2OabZxiJAiO4mabIIMXRWQL8oM0Vf5p15ESxm6CpeVzJP+ez9oW1PQO0bSIHmsIJjtpwZCPMno1pEuYjs1z1k1GlL7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737761709; c=relaxed/simple;
	bh=3ACkIu0jKYqDK9XRLSxmLdeSFyZYIn3KQ4TgdpDNc/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoSia0LQaN60rjWO9nIMlTAiYdW8N3vL7gNoaCjw+vSulODbghZMNiqAIx+U2QXYY2jptiCHVN9rYzNJM6Se7md+Rwq98OPKdwVVhnR8R6LMeT4Lj/mwC4gQdK2KykI71R2VTIYSUPiDSs0EPvvZGgTboqoSxkCvzJ6CCyxXhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5/Sj+wU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E5DC4CED2;
	Fri, 24 Jan 2025 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737761709;
	bh=3ACkIu0jKYqDK9XRLSxmLdeSFyZYIn3KQ4TgdpDNc/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5/Sj+wUHx4wwcAGxnAIo27CgQAn16IpvtugheSvuRTO3m5i1SPCGHx8PPpiUCKw/
	 KuM9itpgf0SmqAqC2ucG1/p+O7SxVjEkgAjBI5DYlZZgYzEy3OC9edeKO0yp5LgC8Z
	 2lcCMtR2wV/2H5HVRBw+2wfzFHD8Epx3NEhV8JCf+ivYpAWFfaCzZOh50ZMFbmX2AF
	 SGjhwoK3dQoXHD49VEUQS0aVBn7jWuZ41VegckTbrbgnrRlLtUhxnZ7zno2NYuaKyA
	 C54RKFXLf3nRvQtN7E4zOGnPSTZO1rfuupAkSG/MQF7nUo7tcJUKN/+qgOzS2y9F5d
	 s9df0JwvptGUg==
Date: Fri, 24 Jan 2025 13:35:07 -1000
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
	tglx@linutronix.de
Subject: Re: [PATCH v4 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <Z5Qjq73QhbaJyTjV@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-6-bigeasy@linutronix.de>

On Fri, Jan 24, 2025 at 06:46:13PM +0100, Sebastian Andrzej Siewior wrote:
...
> +static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
> +{
> +	guard(rcu)();
> +	return rcu_dereference(kn->__parent)->priv;
> +}
...
> @@ -2429,12 +2435,13 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
>  		 * resource. "info" and its subdirectories don't
>  		 * have rdtgroup structures, so return NULL here.
>  		 */
> -		if (kn == kn_info || kn->parent == kn_info)
> +		if (kn == kn_info ||
> +		    rcu_dereference_check(kn->__parent, true) == kn_info)

Why is this safe? What's protecting ->__parent?

...
> @@ -3773,6 +3780,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  		ret = -EPERM;
>  		goto out;
>  	}
> +	parent_kn = rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex));

Can you please encapsulate the rule in a helper? e.g.

  static rdt_kn_parent(struct kernfs_node *kn)
  {
          return rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex) + /* whatever other conditions that make accesses safe */);
  }

and then you can use that everywhere e.g.:

  static void *rdt_get_kn_parent_priv(struct krenfs_node *kn)
  {
          guard(rcu)();
          return rdt_kn_parent(kn)->priv;
  }

This way, the rule to access kn->__parent is documented and enforced in a
single place. If the access rules can't be described like this, open coding
exceptions is fine but some documentation would be great.

> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5a1fea414996e..8e92928c6bca6 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -56,7 +56,7 @@ static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
>  	if (!kn)
>  		return strscpy(buf, "(null)", buflen);
>  
> -	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
> +	return strscpy(buf, rcu_access_pointer(kn->__parent) ? kn->name : "/", buflen);

rcu_access_pointer() is for when only the pointer value is used without
dereferencing it. Here, the poiner is being dereferenced.

> @@ -295,7 +296,7 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
>  	unsigned long flags;
>  
>  	read_lock_irqsave(&kernfs_rename_lock, flags);
> -	parent = kn->parent;
> +	parent = rcu_dereference_check(kn->__parent, lockdep_is_held(&kernfs_rename_lock));

Ditto, it'd be better to encapsulate the access rules in a helper so that
these aren't open coded differently in different places.

...
> @@ -562,7 +570,7 @@ void kernfs_put(struct kernfs_node *kn)
>  	 * Moving/renaming is always done while holding reference.
>  	 * kn->parent won't change beneath us.
>  	 */
> -	parent = kn->parent;
> +	parent = rcu_dereference_check(kn->__parent, !atomic_read(&kn->count));

And this rule can be encoded in the same accessor function so that the rules
can be documented and enforced from (if possible) a single place.

> @@ -1760,8 +1777,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>  	/* rename_lock protects ->parent and ->name accessors */
>  	write_lock_irq(&kernfs_rename_lock);
>  
> -	old_parent = kn->parent;
> -	kn->parent = new_parent;
> +	old_parent = rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));

Another rule here.

> +static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));
> +}

AFAICS, all rules can be put into this helper, no?

...
> +static struct cgroup *kn_get_priv(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->__parent, kn->flags & KERNFS_ROOT_INVARIANT_PARENT)->priv;
> +}

The flag is a root flag but being tested against a node flags field.

Thanks.

-- 
tejun

