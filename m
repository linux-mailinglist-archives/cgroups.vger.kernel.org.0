Return-Path: <cgroups+bounces-6362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEEEA21324
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227901888161
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BA1DE4DA;
	Tue, 28 Jan 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW7KW1w0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDC4A1A;
	Tue, 28 Jan 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096309; cv=none; b=HuTfZrjxHJxWp671bfhlP2ihJloTrF50wg9cm28ohXxRDfq401NUdH177L7Jh9nEWP7OMDC2blL70KBo4cc9inoGMiOZZvYaXNDvyWDrhrxrY2IoyFCYRov275IwqPgaUGnDi30aA+12/QEVkZml2wunIzSBAPX3PjpbekqzSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096309; c=relaxed/simple;
	bh=FXhX9+eqCUSe5uFQZ9Wni+wyDS0HWjiFlQ4OYm7tQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORsZyAXTbdPJuyp86OvLdr05DW22epbN2R8O4rhQfMJY22056p3qnubd3uVUrzWKbYKfDEPkffLvDpWf3pQuA2fMDROYKtGwJZ+5EId3cXxcj4M59LPJ3UIG4GrH5JGblD82bLP8OlEdkHtI7DnQn8dg63Ap34IvqwyiBGEkXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW7KW1w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B05AC4CED3;
	Tue, 28 Jan 2025 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738096309;
	bh=FXhX9+eqCUSe5uFQZ9Wni+wyDS0HWjiFlQ4OYm7tQGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW7KW1w0zEdUnUs0wQQYzt7aPFOObiR497Tb5hCXnT0nbmbiq80b2yZ/y2+JHHk2Q
	 kVPlbrP+r+jA3tIjK/t96wsTmS+P2lzU1tw3qD7NZq1jwYms1Ejx0RE7y9Vsezxxn1
	 p4KpSHZbFjgVvgOqPTEcPGdPZcAdVI4QkeoFywy5FE2Xu4SFRiRT8PCLAYaje61wkW
	 rNsN2cmEzcTv3b81f0tJ6IqgWWtyvZLP+h+IXFovBJoJw5A+zoYHu+B5SYYJ/idvKu
	 diJUaZtVUUOH9iPpbCGqvBfx7ezxo3RqlbZig2HoIwD7D5y28fJezfYIM/XBF5xjqe
	 +c1QPRVfjKmAg==
Date: Tue, 28 Jan 2025 10:31:47 -1000
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
Message-ID: <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128084226.1499291-6-bigeasy@linutronix.de>

Hello,

Mostly look great to me. Left mostly minor comments.

On Tue, Jan 28, 2025 at 09:42:25AM +0100, Sebastian Andrzej Siewior wrote:
> @@ -947,10 +947,20 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void *rdt_get_kn_parent_priv(struct kernfs_node *kn)
> +{

nit: Rename rdt_kn_parent_priv() to be consistent with other accessors?

> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5a1fea414996e..16d268345e3b7 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -64,9 +64,9 @@ static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
>  {
>  	size_t depth = 0;
>  
> -	while (to->parent && to != from) {
> +	while (rcu_dereference(to->__parent) && to != from) {

Why not use kernfs_parent() here and other places?

> @@ -226,6 +227,7 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
>  	unsigned long flags;
>  	int ret;
>  
> +	guard(rcu)();

Doesn't irqsave imply rcu?

> @@ -558,11 +567,7 @@ void kernfs_put(struct kernfs_node *kn)
>  		return;
>  	root = kernfs_root(kn);
>   repeat:
> -	/*
> -	 * Moving/renaming is always done while holding reference.
> -	 * kn->parent won't change beneath us.
> -	 */
> -	parent = kn->parent;
> +	parent = kernfs_parent(kn);

Not a strong opinion but I'd keep the comment. Reader can go read the
definition of kernfs_parent() but no harm in explaining the subtlety where
it's used.

> @@ -1376,7 +1388,7 @@ static void kernfs_activate_one(struct kernfs_node *kn)
>  	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
>  		return;
>  
> -	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
> +	WARN_ON_ONCE(kernfs_parent(kn) && RB_EMPTY_NODE(&kn->rb));

Minor but this one can be rcu_access_pointer() too.

> @@ -1794,7 +1813,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
>  {
>  	if (pos) {
>  		int valid = kernfs_active(pos) &&
> -			pos->parent == parent && hash == pos->hash;
> +			kernfs_parent(pos) == parent && hash == pos->hash;

Ditto with rcu_access_pointer(). Using kernfs_parent() here is fine too but
it's a bit messy to mix the two for similar cases. Let's stick to either
rcu_access_pointer() or kernfs_parent().

> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index b42ee6547cdc1..c43bee18b79f7 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -64,11 +66,14 @@ struct kernfs_root {
>   *
>   * Return: the kernfs_root @kn belongs to.
>   */
> -static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
> +static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
>  {
> +	const struct kernfs_node *knp;
>  	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
> -	if (kn->parent)
> -		kn = kn->parent;
> +	guard(rcu)();
> +	knp = rcu_dereference(kn->__parent);
> +	if (knp)
> +		kn = knp;
>  	return kn->dir.root;
>  }

This isn't a new problem but the addition of the rcu guard makes it stick
out more: What keeps the returned root safe to dereference?

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index d9061bd55436b..214aa378936cd 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -633,9 +633,22 @@ int cgroup_task_count(const struct cgroup *cgrp)
>  	return count;
>  }
>  
> +static struct cgroup *kn_get_priv(struct kernfs_node *kn)
> +{
> +	struct kernfs_node *parent;
> +	/*
> +	 * The parent can not be replaced due to KERNFS_ROOT_INVARIANT_PARENT.
> +	 * Therefore it is always safe to dereference this pointer outside of a
> +	 * RCU section.
> +	 */
> +	parent = rcu_dereference_check(kn->__parent,
> +				       kernfs_root_flags(kn) & KERNFS_ROOT_INVARIANT_PARENT);
> +	return parent->priv;
> +}

kn_priv()?

Thanks.

-- 
tejun

