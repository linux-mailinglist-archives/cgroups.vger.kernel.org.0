Return-Path: <cgroups+bounces-8550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE7ADC5D7
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55833B41FA
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4528FAA7;
	Tue, 17 Jun 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bJHatH6K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C09290BB0
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151403; cv=none; b=rPFC1H637Z2cCZIl9rdyu4ycmAUk1QgGA602GfOvRDKGoL6qEFjD95bhVuwOdKS7ZshJF1RO3wi6mPxjFZcwjLsyYVcpjVOxGOS53oEw47xdCMdWH5VluPxBsc4kNjAT77XzgmQ6QDrcYZd5sxScKpxko1kJWEmhx1DRXFBTJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151403; c=relaxed/simple;
	bh=SbUEmpe1x/KDdkBvhZZwtqR/s19GNk9RimJ8AtX2/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9+xFCZY6ipCBYs/AmfqofbBE6+hTpSM8SaGUMJmUIruSXCRjBRsQcd5sL9a+gg1RVfdBojDfyRHALr0yWn60nE38NFZhnrZBjXNxPhVjCFO38wV8NeNz0XLfwI5gOgeQpa9JXWw58hT6f5c6rPWYYGf/QL3NjM7KQOR/ybBn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bJHatH6K; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-451d54214adso41976285e9.3
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750151398; x=1750756198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m03ULlqTBh5ip3ACLtNfjcuhxMeJ/I44+ysGjfA7Yjg=;
        b=bJHatH6KVB65xE+LmDvS9+q5LpDSyxg6T+n8QYPpTYEet4e/X6BGOvqL9Zku+ciIzY
         uNWtH1wjqnKDk5oBQcxbZ07q5JgZiZ16sY65Vci7c4GBVRyNacJmNmqhiI6vVk/o6kXS
         XfFWOBJ7Zv3hH4XktxhXiSmXbFwatO4VsFBOikUv0djJ3P3uYu9HDYFO9guOmF8CZw1v
         xZ/V8wGXPGHqqQswvF0c/mAtgZD6ZTGaqZSCEHT2z/5xha3uiMbHkEZ3/CvwQt8YS7bM
         T5pxSGW97bedLqi1YEvxTwkkXbk420ngLakJK1UVnInZktntdTp7VXPve2jX2mepvI0V
         ovXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151398; x=1750756198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m03ULlqTBh5ip3ACLtNfjcuhxMeJ/I44+ysGjfA7Yjg=;
        b=VNmwzG30eoDz32ybDN079Cu6IcBn8ZW0CL3b3RIp/3nCBRmNAjnIxllBYgqiky0Ekk
         pNjBJJ27JmuQNRHqehblPgBgtqhHnsxW29PQb6lvWlIQuXeKbF8q1lqOXmFcEmHAQ3KX
         cSaVl5lLld9OZqC0Ww/o1hSN3ifEJeHCczvuCxWgzeOgtAhPGdfmA3DFfNJMIaSsATj6
         U7zkMDVTUY1jpUkw+Cj64w9noP0FkiquLrhDCWhvzIFrrD8l3eNAnz7vLd85SXxIIzfz
         p4Gf64a3ntHbw1hnL5DGwF96dtsrMbIGmmPAnLqJTJQ1iVuEn25qNKX7YDFh3qyPVrqy
         6yOg==
X-Forwarded-Encrypted: i=1; AJvYcCVICGByq9WDmLc9NIxR0nMV/DgfJsW+KPOpQTFvwZn1jt/c/xr6bxy9scmiWV9kEqtD9Cn0Np9A@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMqocDLFKn7O2bK1B935eOXbMEQjxGT0lcoLCTXGPV0ir1LbA
	XyroTvbW6I/XTjS8uAqCzSwvTkdvIEIg9N3XKM7Notf9EVa9/piZQ/bwAHR+xDDnsqByCfGbu1B
	sMFHQHqGz+w==
X-Gm-Gg: ASbGncsDKMLgzFftzYoZH9woc1vluLdcbz8NFG2GZQAUdrfUqSUxd7Z4Zp42nKM/pX6
	RjPfsuDE1oj2QofdpUcwGsglDCGAdWqWPyX9jsYD6BtMFiTzYtxceT6hao+LqykCuBTdcqfG+Az
	1LZMwxDRv0hjVr0dcjAcKYlznEu1SZ7qlpfAX/F6SFAfAI3Isl4FVfZh4NAnmDV25UktfR8/9Ic
	/04BwWPk+zK8nnpQYKH9AcUSGvT6LN0X5kQ0QemMT5/eGsEHrAiNxOrw1P2EE8jYSXs78p/Ahm2
	w7GXN8UrO2TSGlZG8n/HU6ZWIYSPU9FbJS980+6/l67iNIjYg7U/MI8vWSLVuoSR
X-Google-Smtp-Source: AGHT+IEtvWiZAY3q0rj1YYcPsFPLkQk85vDnx2s8CIMUYx7Nnhck3pE18FbpEQaWNOb4ReIalTQDxQ==
X-Received: by 2002:a05:600c:3ac6:b0:442:e9eb:cb9e with SMTP id 5b1f17b1804b1-4533cab856fmr103086585e9.26.1750151397488;
        Tue, 17 Jun 2025 02:09:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d7fsm13550328f8f.18.2025.06.17.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:09:56 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:09:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cgroup: add lock guard support for css_set_lock
 and rcu
Message-ID: <ufzmhgkxfs2mms2a7rm3ikefpjq3kcae72nhdzepfilggteqvl@cbtfuy3nmxtm>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
 <20250606161841.44354-3-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qgi6q3q5bzeiu6h"
Content-Disposition: inline
In-Reply-To: <20250606161841.44354-3-jemmywong512@gmail.com>


--3qgi6q3q5bzeiu6h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] cgroup: add lock guard support for css_set_lock
 and rcu
MIME-Version: 1.0

I'd separate css_set_lock and RCU here, they're very different species.

On Sat, Jun 07, 2025 at 12:18:40AM +0800, Jemmy Wong <jemmywong512@gmail.co=
m> wrote:
> Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
>=20
> ---
>  kernel/cgroup/cgroup-v1.c |  29 +-
>  kernel/cgroup/cgroup.c    | 580 ++++++++++++++++++--------------------
>  kernel/cgroup/cpuset-v1.c |  16 +-
>  kernel/cgroup/debug.c     | 185 ++++++------
>  kernel/cgroup/freezer.c   |  28 +-
>  kernel/cgroup/namespace.c |   8 +-
>  6 files changed, 401 insertions(+), 445 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index f4658eda4445..fcc2d474b470 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -70,9 +70,9 @@ int cgroup_attach_task_all(struct task_struct *from, st=
ruct task_struct *tsk)
>  	for_each_root(root) {
>  		struct cgroup *from_cgrp;
> =20
> -		spin_lock_irq(&css_set_lock);
> -		from_cgrp =3D task_cgroup_from_root(from, root);
> -		spin_unlock_irq(&css_set_lock);
> +		scoped_guard(spinlock_irq, &css_set_lock) {
> +			from_cgrp =3D task_cgroup_from_root(from, root);
> +		}
> =20
>  		retval =3D cgroup_attach_task(from_cgrp, tsk, false);
>  		if (retval)
> @@ -117,10 +117,10 @@ int cgroup_transfer_tasks(struct cgroup *to, struct=
 cgroup *from)
>  	cgroup_attach_lock(true);
> =20
>  	/* all tasks in @from are being moved, all csets are source */
> -	spin_lock_irq(&css_set_lock);
> -	list_for_each_entry(link, &from->cset_links, cset_link)
> -		cgroup_migrate_add_src(link->cset, to, &mgctx);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry(link, &from->cset_links, cset_link)
> +			cgroup_migrate_add_src(link->cset, to, &mgctx);
> +	}
> =20
>  	ret =3D cgroup_migrate_prepare_dst(&mgctx);
>  	if (ret)
> @@ -728,13 +728,12 @@ int cgroupstats_build(struct cgroupstats *stats, st=
ruct dentry *dentry)
>  	 * @kn->priv's validity.  For this and css_tryget_online_from_dir(),
>  	 * @kn->priv is RCU safe.  Let's do the RCU dancing.
>  	 */
> -	rcu_read_lock();
> -	cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> -	if (!cgrp || !cgroup_tryget(cgrp)) {
> -		rcu_read_unlock();
> -		return -ENOENT;
> +	scoped_guard(rcu) {
> +		cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> +		if (!cgrp || !cgroup_tryget(cgrp)) {
> +			return -ENOENT;
> +		}

As this became a single statement, braces are unnecessary.

>  	}
> -	rcu_read_unlock();
> =20
>  	css_task_iter_start(&cgrp->self, 0, &it);
>  	while ((tsk =3D css_task_iter_next(&it))) {
> @@ -1294,7 +1293,7 @@ struct cgroup *task_get_cgroup1(struct task_struct =
*tsk, int hierarchy_id)
>  	struct cgroup_root *root;
>  	unsigned long flags;
> =20
> -	rcu_read_lock();
> +	guard(rcu)();
>  	for_each_root(root) {
>  		/* cgroup1 only*/
>  		if (root =3D=3D &cgrp_dfl_root)
> @@ -1308,7 +1307,7 @@ struct cgroup *task_get_cgroup1(struct task_struct =
*tsk, int hierarchy_id)
>  		spin_unlock_irqrestore(&css_set_lock, flags);
>  		break;
>  	}
> -	rcu_read_unlock();
> +
>  	return cgrp;
>  }
> =20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 54f80afe4f65..46b677a066d1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -631,13 +631,8 @@ int __cgroup_task_count(const struct cgroup *cgrp)
>   */
>  int cgroup_task_count(const struct cgroup *cgrp)
>  {
> -	int count;
> -
> -	spin_lock_irq(&css_set_lock);
> -	count =3D __cgroup_task_count(cgrp);
> -	spin_unlock_irq(&css_set_lock);
> -
> -	return count;
> +	guard(spinlock_irq)(&css_set_lock);
> +	return __cgroup_task_count(cgrp);
>  }
> =20
>  static struct cgroup *kn_priv(struct kernfs_node *kn)
> @@ -1202,11 +1197,11 @@ static struct css_set *find_css_set(struct css_se=
t *old_cset,
> =20
>  	/* First see if we already have a cgroup group that matches
>  	 * the desired set */
> -	spin_lock_irq(&css_set_lock);
> -	cset =3D find_existing_css_set(old_cset, cgrp, template);
> -	if (cset)
> -		get_css_set(cset);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		cset =3D find_existing_css_set(old_cset, cgrp, template);
> +		if (cset)
> +			get_css_set(cset);
> +	}

Here it could work to add a guard() into find_existing_css_set()
instead.

> =20
>  	if (cset)
>  		return cset;
> @@ -1238,34 +1233,33 @@ static struct css_set *find_css_set(struct css_se=
t *old_cset,
>  	 * find_existing_css_set() */
>  	memcpy(cset->subsys, template, sizeof(cset->subsys));
> =20
> -	spin_lock_irq(&css_set_lock);
> -	/* Add reference counts and links from the new css_set. */
> -	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
> -		struct cgroup *c =3D link->cgrp;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		/* Add reference counts and links from the new css_set. */
> +		list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
> +			struct cgroup *c =3D link->cgrp;
> =20
> -		if (c->root =3D=3D cgrp->root)
> -			c =3D cgrp;
> -		link_css_set(&tmp_links, cset, c);
> -	}
> +			if (c->root =3D=3D cgrp->root)
> +				c =3D cgrp;
> +			link_css_set(&tmp_links, cset, c);
> +		}
> =20
> -	BUG_ON(!list_empty(&tmp_links));
> +		BUG_ON(!list_empty(&tmp_links));
> =20
> -	css_set_count++;
> +		css_set_count++;
> =20
> -	/* Add @cset to the hash table */
> -	key =3D css_set_hash(cset->subsys);
> -	hash_add(css_set_table, &cset->hlist, key);
> +		/* Add @cset to the hash table */
> +		key =3D css_set_hash(cset->subsys);
> +		hash_add(css_set_table, &cset->hlist, key);
> =20
> -	for_each_subsys(ss, ssid) {
> -		struct cgroup_subsys_state *css =3D cset->subsys[ssid];
> +		for_each_subsys(ss, ssid) {
> +			struct cgroup_subsys_state *css =3D cset->subsys[ssid];
> =20
> -		list_add_tail(&cset->e_cset_node[ssid],
> -			      &css->cgroup->e_csets[ssid]);
> -		css_get(css);
> +			list_add_tail(&cset->e_cset_node[ssid],
> +				&css->cgroup->e_csets[ssid]);
> +			css_get(css);
> +		}
>  	}
> =20
> -	spin_unlock_irq(&css_set_lock);
> -
>  	/*
>  	 * If @cset should be threaded, look up the matching dom_cset and
>  	 * link them up.  We first fully initialize @cset then look for the
> @@ -1281,11 +1275,11 @@ static struct css_set *find_css_set(struct css_se=
t *old_cset,
>  			return NULL;
>  		}
> =20
> -		spin_lock_irq(&css_set_lock);
> -		cset->dom_cset =3D dcset;
> -		list_add_tail(&cset->threaded_csets_node,
> -			      &dcset->threaded_csets);
> -		spin_unlock_irq(&css_set_lock);
> +		scoped_guard(spinlock_irq, &css_set_lock) {
> +			cset->dom_cset =3D dcset;
> +			list_add_tail(&cset->threaded_csets_node,
> +				&dcset->threaded_csets);
> +		}
>  	}

I admit this part of find_css_set() is less nice after rework :-/

> =20
>  	return cset;
> @@ -1362,16 +1356,14 @@ static void cgroup_destroy_root(struct cgroup_roo=
t *root)
>  	 * Release all the links from cset_links to this hierarchy's
>  	 * root cgroup
>  	 */
> -	spin_lock_irq(&css_set_lock);
> -
> -	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
> -		list_del(&link->cset_link);
> -		list_del(&link->cgrp_link);
> -		kfree(link);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link)=
 {
> +			list_del(&link->cset_link);
> +			list_del(&link->cgrp_link);
> +			kfree(link);
> +		}
>  	}
> =20
> -	spin_unlock_irq(&css_set_lock);
> -
>  	WARN_ON_ONCE(list_empty(&root->root_list));
>  	list_del_rcu(&root->root_list);
>  	cgroup_root_count--;
> @@ -1437,13 +1429,10 @@ current_cgns_cgroup_from_root(struct cgroup_root =
*root)
> =20
>  	lockdep_assert_held(&css_set_lock);
> =20
> -	rcu_read_lock();
> -
> -	cset =3D current->nsproxy->cgroup_ns->root_cset;
> -	res =3D __cset_cgroup_from_root(cset, root);
> -
> -	rcu_read_unlock();
> -
> +	scoped_guard(rcu) {
> +		cset =3D current->nsproxy->cgroup_ns->root_cset;
> +		res =3D __cset_cgroup_from_root(cset, root);
> +	}
>  	/*
>  	 * The namespace_sem is held by current, so the root cgroup can't
>  	 * be umounted. Therefore, we can ensure that the res is non-NULL.
> @@ -1867,25 +1856,25 @@ int rebind_subsystems(struct cgroup_root *dst_roo=
t, u16 ss_mask)
>  		rcu_assign_pointer(dcgrp->subsys[ssid], css);
>  		ss->root =3D dst_root;
> =20
> -		spin_lock_irq(&css_set_lock);
> -		css->cgroup =3D dcgrp;
> -		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
> -		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
> -					 e_cset_node[ss->id]) {
> -			list_move_tail(&cset->e_cset_node[ss->id],
> -				       &dcgrp->e_csets[ss->id]);
> -			/*
> -			 * all css_sets of scgrp together in same order to dcgrp,
> -			 * patch in-flight iterators to preserve correct iteration.
> -			 * since the iterator is always advanced right away and
> -			 * finished when it->cset_pos meets it->cset_head, so only
> -			 * update it->cset_head is enough here.
> -			 */
> -			list_for_each_entry(it, &cset->task_iters, iters_node)
> -				if (it->cset_head =3D=3D &scgrp->e_csets[ss->id])
> -					it->cset_head =3D &dcgrp->e_csets[ss->id];
> +		scoped_guard(spinlock_irq, &css_set_lock) {
> +			css->cgroup =3D dcgrp;
> +			WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
> +			list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
> +						e_cset_node[ss->id]) {
> +				list_move_tail(&cset->e_cset_node[ss->id],
> +					&dcgrp->e_csets[ss->id]);
> +				/*
> +				 * all css_sets of scgrp together in same order to dcgrp,
> +				 * patch in-flight iterators to preserve correct iteration.
> +				 * since the iterator is always advanced right away and
> +				 * finished when it->cset_pos meets it->cset_head, so only
> +				 * update it->cset_head is enough here.
> +				 */
> +				list_for_each_entry(it, &cset->task_iters, iters_node)
> +					if (it->cset_head =3D=3D &scgrp->e_csets[ss->id])
> +						it->cset_head =3D &dcgrp->e_csets[ss->id];
> +			}
>  		}
> -		spin_unlock_irq(&css_set_lock);
> =20
>  		/* default hierarchy doesn't enable controllers by default */
>  		dst_root->subsys_mask |=3D 1 << ssid;
> @@ -1921,10 +1910,10 @@ int cgroup_show_path(struct seq_file *sf, struct =
kernfs_node *kf_node,
>  	if (!buf)
>  		return -ENOMEM;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	ns_cgroup =3D current_cgns_cgroup_from_root(kf_cgroot);
> -	len =3D kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		ns_cgroup =3D current_cgns_cgroup_from_root(kf_cgroot);
> +		len =3D kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
> +	}
> =20
>  	if (len =3D=3D -E2BIG)
>  		len =3D -ERANGE;
> @@ -2175,13 +2164,13 @@ int cgroup_setup_root(struct cgroup_root *root, u=
16 ss_mask)
>  	 * Link the root cgroup in this hierarchy into all the css_set
>  	 * objects.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> -	hash_for_each(css_set_table, i, cset, hlist) {
> -		link_css_set(&tmp_links, cset, root_cgrp);
> -		if (css_set_populated(cset))
> -			cgroup_update_populated(root_cgrp, true);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		hash_for_each(css_set_table, i, cset, hlist) {
> +			link_css_set(&tmp_links, cset, root_cgrp);
> +			if (css_set_populated(cset))
> +				cgroup_update_populated(root_cgrp, true);
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	BUG_ON(!list_empty(&root_cgrp->self.children));
>  	BUG_ON(atomic_read(&root->nr_cgrps) !=3D 1);
> @@ -2225,11 +2214,8 @@ int cgroup_do_get_tree(struct fs_context *fc)
>  		struct cgroup *cgrp;
> =20
>  		scoped_guard(cgroup_mutex) {
> -			spin_lock_irq(&css_set_lock);
> -
> +			guard(spinlock_irq)(&css_set_lock);
>  			cgrp =3D cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
> -
> -			spin_unlock_irq(&css_set_lock);
>  		}
> =20
>  		nsdentry =3D kernfs_node_dentry(cgrp->kn, sb);
> @@ -2438,16 +2424,10 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, ch=
ar *buf, size_t buflen,
>  int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
>  		   struct cgroup_namespace *ns)
>  {
> -	int ret;
> -
>  	guard(cgroup_mutex)();
> -	spin_lock_irq(&css_set_lock);
> -
> -	ret =3D cgroup_path_ns_locked(cgrp, buf, buflen, ns);
> -
> -	spin_unlock_irq(&css_set_lock);
> +	guard(spinlock_irq)(&css_set_lock);
> =20
> -	return ret;
> +	return cgroup_path_ns_locked(cgrp, buf, buflen, ns);
>  }
>  EXPORT_SYMBOL_GPL(cgroup_path_ns);

This is an example of good condensation.

> =20
> @@ -2629,27 +2609,27 @@ static int cgroup_migrate_execute(struct cgroup_m=
gctx *mgctx)
>  	 * the new cgroup.  There are no failure cases after here, so this
>  	 * is the commit point.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> -	list_for_each_entry(cset, &tset->src_csets, mg_node) {
> -		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
> -			struct css_set *from_cset =3D task_css_set(task);
> -			struct css_set *to_cset =3D cset->mg_dst_cset;
> -
> -			get_css_set(to_cset);
> -			to_cset->nr_tasks++;
> -			css_set_move_task(task, from_cset, to_cset, true);
> -			from_cset->nr_tasks--;
> -			/*
> -			 * If the source or destination cgroup is frozen,
> -			 * the task might require to change its state.
> -			 */
> -			cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
> -						    to_cset->dfl_cgrp);
> -			put_css_set_locked(from_cset);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry(cset, &tset->src_csets, mg_node) {
> +			list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
> +				struct css_set *from_cset =3D task_css_set(task);
> +				struct css_set *to_cset =3D cset->mg_dst_cset;
> +
> +				get_css_set(to_cset);
> +				to_cset->nr_tasks++;
> +				css_set_move_task(task, from_cset, to_cset, true);
> +				from_cset->nr_tasks--;
> +				/*
> +				 * If the source or destination cgroup is frozen,
> +				 * the task might require to change its state.
> +				 */
> +				cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
> +							to_cset->dfl_cgrp);
> +				put_css_set_locked(from_cset);
> =20
> +			}
>  		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	/*
>  	 * Migration is committed, all target tasks are now on dst_csets.
> @@ -2682,13 +2662,13 @@ static int cgroup_migrate_execute(struct cgroup_m=
gctx *mgctx)
>  		} while_each_subsys_mask();
>  	}
>  out_release_tset:
> -	spin_lock_irq(&css_set_lock);
> -	list_splice_init(&tset->dst_csets, &tset->src_csets);
> -	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
> -		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
> -		list_del_init(&cset->mg_node);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_splice_init(&tset->dst_csets, &tset->src_csets);
> +		list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
> +			list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
> +			list_del_init(&cset->mg_node);
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	/*
>  	 * Re-initialize the cgroup_taskset structure in case it is reused
> @@ -2746,7 +2726,7 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgc=
tx)
> =20
>  	lockdep_assert_held(&cgroup_mutex);
> =20
> -	spin_lock_irq(&css_set_lock);
> +	guard(spinlock_irq)(&css_set_lock);
> =20
>  	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
>  				 mg_src_preload_node) {
> @@ -2765,8 +2745,6 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgc=
tx)
>  		list_del_init(&cset->mg_dst_preload_node);
>  		put_css_set_locked(cset);
>  	}
> -
> -	spin_unlock_irq(&css_set_lock);
>  }
> =20
>  /**
> @@ -2909,14 +2887,14 @@ int cgroup_migrate(struct task_struct *leader, bo=
ol threadgroup,
>  	 * section to prevent tasks from being freed while taking the snapshot.
>  	 * spin_lock_irq() implies RCU critical section here.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> -	task =3D leader;
> -	do {
> -		cgroup_migrate_add_task(task, mgctx);
> -		if (!threadgroup)
> -			break;
> -	} while_each_thread(leader, task);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		task =3D leader;
> +		do {
> +			cgroup_migrate_add_task(task, mgctx);
> +			if (!threadgroup)
> +				break;
> +		} while_each_thread(leader, task);
> +	}
> =20
>  	return cgroup_migrate_execute(mgctx);
>  }
> @@ -2937,16 +2915,15 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, s=
truct task_struct *leader,
>  	int ret =3D 0;
> =20
>  	/* look up all src csets */
> -	spin_lock_irq(&css_set_lock);
> -	rcu_read_lock();
> -	task =3D leader;
> -	do {
> -		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
> -		if (!threadgroup)
> -			break;
> -	} while_each_thread(leader, task);
> -	rcu_read_unlock();
> -	spin_unlock_irq(&css_set_lock);

As I look at it now, the RCU lock seems pointless here.
That'd deserve a separate patch (independent of this guard series).

> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		guard(rcu)();
> +		task =3D leader;
> +		do {
> +			cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
> +			if (!threadgroup)
> +				break;
> +		} while_each_thread(leader, task);
> +	}
> =20
>  	/* prepare dst csets and commit */
>  	ret =3D cgroup_migrate_prepare_dst(&mgctx);
> @@ -3088,23 +3065,23 @@ static int cgroup_update_dfl_csses(struct cgroup =
*cgrp)
>  	lockdep_assert_held(&cgroup_mutex);
> =20
>  	/* look up all csses currently attached to @cgrp's subtree */
> -	spin_lock_irq(&css_set_lock);
> -	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
> -		struct cgrp_cset_link *link;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
> +			struct cgrp_cset_link *link;
> =20
> -		/*
> -		 * As cgroup_update_dfl_csses() is only called by
> -		 * cgroup_apply_control(). The csses associated with the
> -		 * given cgrp will not be affected by changes made to
> -		 * its subtree_control file. We can skip them.
> -		 */
> -		if (dsct =3D=3D cgrp)
> -			continue;
> +			/*
> +			 * As cgroup_update_dfl_csses() is only called by
> +			 * cgroup_apply_control(). The csses associated with the
> +			 * given cgrp will not be affected by changes made to
> +			 * its subtree_control file. We can skip them.
> +			 */
> +			if (dsct =3D=3D cgrp)
> +				continue;
> =20
> -		list_for_each_entry(link, &dsct->cset_links, cset_link)
> -			cgroup_migrate_add_src(link->cset, dsct, &mgctx);
> +			list_for_each_entry(link, &dsct->cset_links, cset_link)
> +				cgroup_migrate_add_src(link->cset, dsct, &mgctx);
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	/*
>  	 * We need to write-lock threadgroup_rwsem while migrating tasks.
> @@ -3120,16 +3097,16 @@ static int cgroup_update_dfl_csses(struct cgroup =
*cgrp)
>  	if (ret)
>  		goto out_finish;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
> -			    mg_src_preload_node) {
> -		struct task_struct *task, *ntask;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
> +				mg_src_preload_node) {
> +			struct task_struct *task, *ntask;
> =20
> -		/* all tasks in src_csets need to be migrated */
> -		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
> -			cgroup_migrate_add_task(task, &mgctx);
> +			/* all tasks in src_csets need to be migrated */
> +			list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
> +				cgroup_migrate_add_task(task, &mgctx);
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	ret =3D cgroup_migrate_execute(&mgctx);
>  out_finish:
> @@ -3734,7 +3711,8 @@ static int cgroup_stat_show(struct seq_file *seq, v=
oid *v)
>  	 * Without proper lock protection, racing is possible. So the
>  	 * numbers may not be consistent when that happens.
>  	 */
> -	rcu_read_lock();
> +	guard(rcu)();
> +
>  	for (ssid =3D 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
>  		dying_cnt[ssid] =3D -1;
>  		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> @@ -3753,7 +3731,6 @@ static int cgroup_stat_show(struct seq_file *seq, v=
oid *v)
>  			seq_printf(seq, "nr_dying_subsys_%s %d\n",
>  				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
>  	}
> -	rcu_read_unlock();
>  	return 0;
>  }
> =20
> @@ -3771,11 +3748,10 @@ static struct cgroup_subsys_state *cgroup_tryget_=
css(struct cgroup *cgrp,
>  {
>  	struct cgroup_subsys_state *css;
> =20
> -	rcu_read_lock();
> +	guard(rcu)();
>  	css =3D cgroup_css(cgrp, ss);
>  	if (css && !css_tryget_online(css))
>  		css =3D NULL;
> -	rcu_read_unlock();
> =20
>  	return css;
>  }
> @@ -4056,9 +4032,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
> =20
>  	lockdep_assert_held(&cgroup_mutex);
> =20
> -	spin_lock_irq(&css_set_lock);
> -	cgrp->kill_seq++;
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		cgrp->kill_seq++;
> +	}
> =20
>  	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_TH=
READED, &it);
>  	while ((task =3D css_task_iter_next(&it))) {
> @@ -4187,9 +4163,9 @@ static ssize_t cgroup_file_write(struct kernfs_open=
_file *of, char *buf,
>  	 * doesn't need to be pinned.  The RCU locking is not necessary
>  	 * either.  It's just for the convenience of using cgroup_css().
>  	 */
> -	rcu_read_lock();
> -	css =3D cgroup_css(cgrp, cft->ss);
> -	rcu_read_unlock();
> +	scoped_guard(rcu) {
> +		css =3D cgroup_css(cgrp, cft->ss);
> +	}
> =20
>  	if (cft->write_u64) {
>  		unsigned long long v;
> @@ -4815,14 +4791,14 @@ bool css_has_online_children(struct cgroup_subsys=
_state *css)
>  	struct cgroup_subsys_state *child;
>  	bool ret =3D false;
> =20
> -	rcu_read_lock();
> +	guard(rcu)();
>  	css_for_each_child(child, css) {
>  		if (child->flags & CSS_ONLINE) {
>  			ret =3D true;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
> +
>  	return ret;
>  }
> =20
> @@ -5247,9 +5223,9 @@ static ssize_t __cgroup_procs_write(struct kernfs_o=
pen_file *of, char *buf,
>  		goto out_unlock;
> =20
>  	/* find the source cgroup */
> -	spin_lock_irq(&css_set_lock);
> -	src_cgrp =3D task_cgroup_from_root(task, &cgrp_dfl_root);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		src_cgrp =3D task_cgroup_from_root(task, &cgrp_dfl_root);
> +	}
> =20
>  	/*
>  	 * Process and thread migrations follow same delegation rule. Check
> @@ -5531,11 +5507,11 @@ static inline void css_release_work_fn_locked(str=
uct work_struct *work)
> =20
>  		css_rstat_flush(&cgrp->self);
> =20
> -		spin_lock_irq(&css_set_lock);
> -		for (tcgrp =3D cgroup_parent(cgrp); tcgrp;
> -		     tcgrp =3D cgroup_parent(tcgrp))
> -			tcgrp->nr_dying_descendants--;
> -		spin_unlock_irq(&css_set_lock);
> +		scoped_guard(spinlock_irq, &css_set_lock) {
> +			for (tcgrp =3D cgroup_parent(cgrp); tcgrp;
> +				tcgrp =3D cgroup_parent(tcgrp))
> +					tcgrp->nr_dying_descendants--;
> +		}
> =20
>  		/*
>  		 * There are two control paths which try to determine
> @@ -5790,20 +5766,20 @@ static struct cgroup *cgroup_create(struct cgroup=
 *parent, const char *name,
>  		goto out_psi_free;
> =20
>  	/* allocation complete, commit to creation */
> -	spin_lock_irq(&css_set_lock);
> -	for (i =3D 0; i < level; i++) {
> -		tcgrp =3D cgrp->ancestors[i];
> -		tcgrp->nr_descendants++;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		for (i =3D 0; i < level; i++) {
> +			tcgrp =3D cgrp->ancestors[i];
> +			tcgrp->nr_descendants++;
> =20
> -		/*
> -		 * If the new cgroup is frozen, all ancestor cgroups get a new
> -		 * frozen descendant, but their state can't change because of
> -		 * this.
> -		 */
> -		if (cgrp->freezer.e_freeze)
> -			tcgrp->freezer.nr_frozen_descendants++;
> +			/*
> +			 * If the new cgroup is frozen, all ancestor cgroups get a new
> +			 * frozen descendant, but their state can't change because of
> +			 * this.
> +			 */
> +			if (cgrp->freezer.e_freeze)
> +				tcgrp->freezer.nr_frozen_descendants++;
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.child=
ren);
>  	atomic_inc(&root->nr_cgrps);
> @@ -6047,10 +6023,10 @@ static int cgroup_destroy_locked(struct cgroup *c=
grp)
>  	 */
>  	cgrp->self.flags &=3D ~CSS_ONLINE;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	list_for_each_entry(link, &cgrp->cset_links, cset_link)
> -		link->cset->dead =3D true;
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry(link, &cgrp->cset_links, cset_link)
> +			link->cset->dead =3D true;
> +	}
> =20
>  	/* initiate massacre of all css's */
>  	for_each_css(css, ssid, cgrp)
> @@ -6063,18 +6039,18 @@ static int cgroup_destroy_locked(struct cgroup *c=
grp)
>  	if (cgroup_is_threaded(cgrp))
>  		parent->nr_threaded_children--;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	for (tcgrp =3D parent; tcgrp; tcgrp =3D cgroup_parent(tcgrp)) {
> -		tcgrp->nr_descendants--;
> -		tcgrp->nr_dying_descendants++;
> -		/*
> -		 * If the dying cgroup is frozen, decrease frozen descendants
> -		 * counters of ancestor cgroups.
> -		 */
> -		if (test_bit(CGRP_FROZEN, &cgrp->flags))
> -			tcgrp->freezer.nr_frozen_descendants--;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		for (tcgrp =3D parent; tcgrp; tcgrp =3D cgroup_parent(tcgrp)) {
> +			tcgrp->nr_descendants--;
> +			tcgrp->nr_dying_descendants++;
> +			/*
> +			 * If the dying cgroup is frozen, decrease frozen descendants
> +			 * counters of ancestor cgroups.
> +			 */
> +			if (test_bit(CGRP_FROZEN, &cgrp->flags))
> +				tcgrp->freezer.nr_frozen_descendants--;
> +		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	cgroup1_check_for_release(parent);
> =20
> @@ -6356,13 +6332,12 @@ struct cgroup *cgroup_get_from_id(u64 id)
>  		return ERR_PTR(-ENOENT);
>  	}
> =20
> -	rcu_read_lock();
> -
> -	cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> -	if (cgrp && !cgroup_tryget(cgrp))
> -		cgrp =3D NULL;
> +	scoped_guard(rcu) {
> +		cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> +		if (cgrp && !cgroup_tryget(cgrp))
> +			cgrp =3D NULL;
> +	}
> =20
> -	rcu_read_unlock();
>  	kernfs_put(kn);
> =20
>  	if (!cgrp)
> @@ -6539,14 +6514,14 @@ static int cgroup_css_set_fork(struct kernel_clon=
e_args *kargs)
> =20
>  	cgroup_threadgroup_change_begin(current);
> =20
> -	spin_lock_irq(&css_set_lock);
> -	cset =3D task_css_set(current);
> -	get_css_set(cset);
> -	if (kargs->cgrp)
> -		kargs->kill_seq =3D kargs->cgrp->kill_seq;
> -	else
> -		kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		cset =3D task_css_set(current);
> +		get_css_set(cset);
> +		if (kargs->cgrp)
> +			kargs->kill_seq =3D kargs->cgrp->kill_seq;
> +		else
> +			kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> +	}
> =20
>  	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
>  		kargs->cset =3D cset;
> @@ -6736,56 +6711,53 @@ void cgroup_post_fork(struct task_struct *child,
>  	cset =3D kargs->cset;
>  	kargs->cset =3D NULL;
> =20
> -	spin_lock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		/* init tasks are special, only link regular threads */
> +		if (likely(child->pid)) {
> +			if (kargs->cgrp) {
> +				cgrp_flags =3D kargs->cgrp->flags;
> +				cgrp_kill_seq =3D kargs->cgrp->kill_seq;
> +			} else {
> +				cgrp_flags =3D cset->dfl_cgrp->flags;
> +				cgrp_kill_seq =3D cset->dfl_cgrp->kill_seq;
> +			}
> =20
> -	/* init tasks are special, only link regular threads */
> -	if (likely(child->pid)) {
> -		if (kargs->cgrp) {
> -			cgrp_flags =3D kargs->cgrp->flags;
> -			cgrp_kill_seq =3D kargs->cgrp->kill_seq;
> +			WARN_ON_ONCE(!list_empty(&child->cg_list));
> +			cset->nr_tasks++;
> +			css_set_move_task(child, NULL, cset, false);
>  		} else {
> -			cgrp_flags =3D cset->dfl_cgrp->flags;
> -			cgrp_kill_seq =3D cset->dfl_cgrp->kill_seq;
> +			put_css_set(cset);
> +			cset =3D NULL;
>  		}
> =20
> -		WARN_ON_ONCE(!list_empty(&child->cg_list));
> -		cset->nr_tasks++;
> -		css_set_move_task(child, NULL, cset, false);
> -	} else {
> -		put_css_set(cset);
> -		cset =3D NULL;
> -	}
> -
> -	if (!(child->flags & PF_KTHREAD)) {
> -		if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
> -			/*
> -			 * If the cgroup has to be frozen, the new task has
> -			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> -			 * get the task into the frozen state.
> -			 */
> -			spin_lock(&child->sighand->siglock);
> -			WARN_ON_ONCE(child->frozen);
> -			child->jobctl |=3D JOBCTL_TRAP_FREEZE;
> -			spin_unlock(&child->sighand->siglock);
> +		if (!(child->flags & PF_KTHREAD)) {
> +			if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
> +				/*
> +				 * If the cgroup has to be frozen, the new task has
> +				 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> +				 * get the task into the frozen state.
> +				 */
> +				spin_lock(&child->sighand->siglock);
> +				WARN_ON_ONCE(child->frozen);
> +				child->jobctl |=3D JOBCTL_TRAP_FREEZE;
> +				spin_unlock(&child->sighand->siglock);
> +
> +				/*
> +				 * Calling cgroup_update_frozen() isn't required here,
> +				 * because it will be called anyway a bit later from
> +				 * do_freezer_trap(). So we avoid cgroup's transient
> +				 * switch from the frozen state and back.
> +				 */
> +			}
> =20
>  			/*
> -			 * Calling cgroup_update_frozen() isn't required here,
> -			 * because it will be called anyway a bit later from
> -			 * do_freezer_trap(). So we avoid cgroup's transient
> -			 * switch from the frozen state and back.
> +			 * If the cgroup is to be killed notice it now and take the
> +			 * child down right after we finished preparing it for
> +			 * userspace.
>  			 */
> +			kill =3D kargs->kill_seq !=3D cgrp_kill_seq;
>  		}
> -
> -		/*
> -		 * If the cgroup is to be killed notice it now and take the
> -		 * child down right after we finished preparing it for
> -		 * userspace.
> -		 */
> -		kill =3D kargs->kill_seq !=3D cgrp_kill_seq;
>  	}
> -
> -	spin_unlock_irq(&css_set_lock);
> -
>  	/*
>  	 * Call ss->fork().  This must happen after @child is linked on
>  	 * css_set; otherwise, @child might change state between ->fork()
> @@ -6824,25 +6796,23 @@ void cgroup_exit(struct task_struct *tsk)
>  	struct css_set *cset;
>  	int i;
> =20
> -	spin_lock_irq(&css_set_lock);
> -
> -	WARN_ON_ONCE(list_empty(&tsk->cg_list));
> -	cset =3D task_css_set(tsk);
> -	css_set_move_task(tsk, cset, NULL, false);
> -	cset->nr_tasks--;
> -	/* matches the signal->live check in css_task_iter_advance() */
> -	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
> -		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> -
> -	if (dl_task(tsk))
> -		dec_dl_tasks_cs(tsk);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		WARN_ON_ONCE(list_empty(&tsk->cg_list));
> +		cset =3D task_css_set(tsk);
> +		css_set_move_task(tsk, cset, NULL, false);
> +		cset->nr_tasks--;
> +		/* matches the signal->live check in css_task_iter_advance() */
> +		if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
> +			list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> =20
> -	WARN_ON_ONCE(cgroup_task_frozen(tsk));
> -	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
> -		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
> -		cgroup_update_frozen(task_dfl_cgroup(tsk));
> +		if (dl_task(tsk))
> +			dec_dl_tasks_cs(tsk);
> =20
> -	spin_unlock_irq(&css_set_lock);
> +		WARN_ON_ONCE(cgroup_task_frozen(tsk));
> +		if (unlikely(!(tsk->flags & PF_KTHREAD) &&
> +			test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
> +			cgroup_update_frozen(task_dfl_cgroup(tsk));
> +	}
> =20
>  	/* see cgroup_post_fork() for details */
>  	do_each_subsys_mask(ss, i, have_exit_callback) {
> @@ -6860,10 +6830,9 @@ void cgroup_release(struct task_struct *task)
>  	} while_each_subsys_mask();
> =20
>  	if (!list_empty(&task->cg_list)) {
> -		spin_lock_irq(&css_set_lock);
> +		guard(spinlock_irq)(&css_set_lock);
>  		css_set_skip_task_iters(task_css_set(task), task);
>  		list_del_init(&task->cg_list);
> -		spin_unlock_irq(&css_set_lock);
>  	}
>  }
> =20
> @@ -6944,7 +6913,7 @@ struct cgroup_subsys_state *css_tryget_online_from_=
dir(struct dentry *dentry,
>  	    !kn || kernfs_type(kn) !=3D KERNFS_DIR)
>  		return ERR_PTR(-EBADF);
> =20
> -	rcu_read_lock();
> +	guard(rcu)();
> =20
>  	/*
>  	 * This path doesn't originate from kernfs and @kn could already
> @@ -6958,7 +6927,6 @@ struct cgroup_subsys_state *css_tryget_online_from_=
dir(struct dentry *dentry,
>  	if (!css || !css_tryget_online(css))
>  		css =3D ERR_PTR(-ENOENT);
> =20
> -	rcu_read_unlock();
>  	return css;
>  }
> =20
> @@ -7001,13 +6969,11 @@ struct cgroup *cgroup_get_from_path(const char *p=
ath)
>  		goto out_kernfs;
>  	}
> =20
> -	rcu_read_lock();
> -
> -	cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> -	if (!cgrp || !cgroup_tryget(cgrp))
> -		cgrp =3D ERR_PTR(-ENOENT);
> -
> -	rcu_read_unlock();
> +	scoped_guard(rcu) {
> +		cgrp =3D rcu_dereference(*(void __rcu __force **)&kn->priv);
> +		if (!cgrp || !cgroup_tryget(cgrp))
> +			cgrp =3D ERR_PTR(-ENOENT);
> +	}
> =20
>  out_kernfs:
>  	kernfs_put(kn);
> @@ -7106,28 +7072,28 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skc=
d)
>  {
>  	struct cgroup *cgroup;
> =20
> -	rcu_read_lock();
> -	/* Don't associate the sock with unrelated interrupted task's cgroup. */
> -	if (in_interrupt()) {
> -		cgroup =3D &cgrp_dfl_root.cgrp;
> -		cgroup_get(cgroup);
> -		goto out;
> -	}
> +	scoped_guard(rcu) {

Here could be unscoped guard()(rcu)?

> +		/* Don't associate the sock with unrelated interrupted task's cgroup. =
*/
> +		if (in_interrupt()) {
> +			cgroup =3D &cgrp_dfl_root.cgrp;
> +			cgroup_get(cgroup);
> +			break;
> +		}
> =20
> -	while (true) {
> -		struct css_set *cset;
> +		while (true) {
> +			struct css_set *cset;
> =20
> -		cset =3D task_css_set(current);
> -		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
> -			cgroup =3D cset->dfl_cgrp;
> -			break;
> +			cset =3D task_css_set(current);
> +			if (likely(cgroup_tryget(cset->dfl_cgrp))) {
> +				cgroup =3D cset->dfl_cgrp;
> +				break;
> +			}
> +			cpu_relax();
>  		}
> -		cpu_relax();
> +
> +		skcd->cgroup =3D cgroup;
> +		cgroup_bpf_get(cgroup);
>  	}
> -out:
> -	skcd->cgroup =3D cgroup;
> -	cgroup_bpf_get(cgroup);
> -	rcu_read_unlock();
>  }
> =20
>  void cgroup_sk_clone(struct sock_cgroup_data *skcd)
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index b69a7db67090..114a63432d23 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -140,9 +140,8 @@ int cpuset_memory_pressure_enabled __read_mostly;
> =20
>  void __cpuset_memory_pressure_bump(void)
>  {
> -	rcu_read_lock();
> +	guard(rcu)();
>  	fmeter_markevent(&task_cs(current)->fmeter);
> -	rcu_read_unlock();
>  }
> =20
>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
> @@ -393,13 +392,12 @@ int proc_cpuset_show(struct seq_file *m, struct pid=
_namespace *ns,
>  	if (!buf)
>  		goto out;
> =20
> -	rcu_read_lock();
> -	spin_lock_irq(&css_set_lock);
> -	css =3D task_css(tsk, cpuset_cgrp_id);
> -	retval =3D cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> -				       current->nsproxy->cgroup_ns);
> -	spin_unlock_irq(&css_set_lock);
> -	rcu_read_unlock();
> +	scoped_guard(rcu) {
> +		guard(spinlock_irq)(&css_set_lock);
> +		css =3D task_css(tsk, cpuset_cgrp_id);
> +		retval =3D cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +					current->nsproxy->cgroup_ns);
> +	}
> =20
>  	if (retval =3D=3D -E2BIG)
>  		retval =3D -ENAMETOOLONG;
> diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
> index 80aa3f027ac3..2f04db56c8ac 100644
> --- a/kernel/cgroup/debug.c
> +++ b/kernel/cgroup/debug.c
> @@ -48,27 +48,26 @@ static int current_css_set_read(struct seq_file *seq,=
 void *v)
>  	if (!cgroup_kn_lock_live(of->kn, false))
>  		return -ENODEV;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	rcu_read_lock();
> -	cset =3D task_css_set(current);
> -	refcnt =3D refcount_read(&cset->refcount);
> -	seq_printf(seq, "css_set %pK %d", cset, refcnt);
> -	if (refcnt > cset->nr_tasks)
> -		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
> -	seq_puts(seq, "\n");
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		guard(rcu)();
> +		cset =3D task_css_set(current);
> +		refcnt =3D refcount_read(&cset->refcount);
> +		seq_printf(seq, "css_set %pK %d", cset, refcnt);
> +		if (refcnt > cset->nr_tasks)
> +			seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
> +		seq_puts(seq, "\n");
> =20
> -	/*
> -	 * Print the css'es stored in the current css_set.
> -	 */
> -	for_each_subsys(ss, i) {
> -		css =3D cset->subsys[ss->id];
> -		if (!css)
> -			continue;
> -		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
> -			  css, css->id);
> +		/*
> +		* Print the css'es stored in the current css_set.
> +		*/
> +		for_each_subsys(ss, i) {
> +			css =3D cset->subsys[ss->id];
> +			if (!css)
> +				continue;
> +			seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
> +				css, css->id);
> +		}
>  	}
> -	rcu_read_unlock();
> -	spin_unlock_irq(&css_set_lock);
>  	cgroup_kn_unlock(of->kn);
>  	return 0;
>  }
> @@ -76,12 +75,8 @@ static int current_css_set_read(struct seq_file *seq, =
void *v)
>  static u64 current_css_set_refcount_read(struct cgroup_subsys_state *css,
>  					 struct cftype *cft)
>  {
> -	u64 count;
> -
> -	rcu_read_lock();
> -	count =3D refcount_read(&task_css_set(current)->refcount);
> -	rcu_read_unlock();
> -	return count;
> +	guard(rcu)();
> +	return refcount_read(&task_css_set(current)->refcount);
>  }
> =20
>  static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
> @@ -94,18 +89,17 @@ static int current_css_set_cg_links_read(struct seq_f=
ile *seq, void *v)
>  	if (!name_buf)
>  		return -ENOMEM;
> =20
> -	spin_lock_irq(&css_set_lock);
> -	rcu_read_lock();
> -	cset =3D task_css_set(current);
> -	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
> -		struct cgroup *c =3D link->cgrp;
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		guard(rcu)();
> +		cset =3D task_css_set(current);
> +		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
> +			struct cgroup *c =3D link->cgrp;
> =20
> -		cgroup_name(c, name_buf, NAME_MAX + 1);
> -		seq_printf(seq, "Root %d group %s\n",
> -			   c->root->hierarchy_id, name_buf);
> +			cgroup_name(c, name_buf, NAME_MAX + 1);
> +			seq_printf(seq, "Root %d group %s\n",
> +				c->root->hierarchy_id, name_buf);
> +		}
>  	}
> -	rcu_read_unlock();
> -	spin_unlock_irq(&css_set_lock);
>  	kfree(name_buf);
>  	return 0;
>  }
> @@ -117,74 +111,73 @@ static int cgroup_css_links_read(struct seq_file *s=
eq, void *v)
>  	struct cgrp_cset_link *link;
>  	int dead_cnt =3D 0, extra_refs =3D 0, threaded_csets =3D 0;
> =20
> -	spin_lock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
> +			struct css_set *cset =3D link->cset;
> +			struct task_struct *task;
> +			int count =3D 0;
> +			int refcnt =3D refcount_read(&cset->refcount);
> +
> +			/*
> +			 * Print out the proc_cset and threaded_cset relationship
> +			 * and highlight difference between refcount and task_count.
> +			 */
> +			seq_printf(seq, "css_set %pK", cset);
> +			if (rcu_dereference_protected(cset->dom_cset, 1) !=3D cset) {
> +				threaded_csets++;
> +				seq_printf(seq, "=3D>%pK", cset->dom_cset);
> +			}
> +			if (!list_empty(&cset->threaded_csets)) {
> +				struct css_set *tcset;
> +				int idx =3D 0;
> +
> +				list_for_each_entry(tcset, &cset->threaded_csets,
> +						threaded_csets_node) {
> +					seq_puts(seq, idx ? "," : "<=3D");
> +					seq_printf(seq, "%pK", tcset);
> +					idx++;
> +				}
> +			} else {
> +				seq_printf(seq, " %d", refcnt);
> +				if (refcnt - cset->nr_tasks > 0) {
> +					int extra =3D refcnt - cset->nr_tasks;
> +
> +					seq_printf(seq, " +%d", extra);
> +					/*
> +					 * Take out the one additional reference in
> +					 * init_css_set.
> +					 */
> +					if (cset =3D=3D &init_css_set)
> +						extra--;
> +					extra_refs +=3D extra;
> +				}
> +			}
> +			seq_puts(seq, "\n");
> =20
> -	list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
> -		struct css_set *cset =3D link->cset;
> -		struct task_struct *task;
> -		int count =3D 0;
> -		int refcnt =3D refcount_read(&cset->refcount);
> +			list_for_each_entry(task, &cset->tasks, cg_list) {
> +				if (count++ <=3D MAX_TASKS_SHOWN_PER_CSS)
> +					seq_printf(seq, "  task %d\n",
> +						task_pid_vnr(task));
> +			}
> =20
> -		/*
> -		 * Print out the proc_cset and threaded_cset relationship
> -		 * and highlight difference between refcount and task_count.
> -		 */
> -		seq_printf(seq, "css_set %pK", cset);
> -		if (rcu_dereference_protected(cset->dom_cset, 1) !=3D cset) {
> -			threaded_csets++;
> -			seq_printf(seq, "=3D>%pK", cset->dom_cset);
> -		}
> -		if (!list_empty(&cset->threaded_csets)) {
> -			struct css_set *tcset;
> -			int idx =3D 0;
> -
> -			list_for_each_entry(tcset, &cset->threaded_csets,
> -					    threaded_csets_node) {
> -				seq_puts(seq, idx ? "," : "<=3D");
> -				seq_printf(seq, "%pK", tcset);
> -				idx++;
> +			list_for_each_entry(task, &cset->mg_tasks, cg_list) {
> +				if (count++ <=3D MAX_TASKS_SHOWN_PER_CSS)
> +					seq_printf(seq, "  task %d\n",
> +						task_pid_vnr(task));
>  			}
> -		} else {
> -			seq_printf(seq, " %d", refcnt);
> -			if (refcnt - cset->nr_tasks > 0) {
> -				int extra =3D refcnt - cset->nr_tasks;
> -
> -				seq_printf(seq, " +%d", extra);
> -				/*
> -				 * Take out the one additional reference in
> -				 * init_css_set.
> -				 */
> -				if (cset =3D=3D &init_css_set)
> -					extra--;
> -				extra_refs +=3D extra;
> +			/* show # of overflowed tasks */
> +			if (count > MAX_TASKS_SHOWN_PER_CSS)
> +				seq_printf(seq, "  ... (%d)\n",
> +					count - MAX_TASKS_SHOWN_PER_CSS);
> +
> +			if (cset->dead) {
> +				seq_puts(seq, "    [dead]\n");
> +				dead_cnt++;
>  			}
> -		}
> -		seq_puts(seq, "\n");
> -
> -		list_for_each_entry(task, &cset->tasks, cg_list) {
> -			if (count++ <=3D MAX_TASKS_SHOWN_PER_CSS)
> -				seq_printf(seq, "  task %d\n",
> -					   task_pid_vnr(task));
> -		}
> =20
> -		list_for_each_entry(task, &cset->mg_tasks, cg_list) {
> -			if (count++ <=3D MAX_TASKS_SHOWN_PER_CSS)
> -				seq_printf(seq, "  task %d\n",
> -					   task_pid_vnr(task));
> +			WARN_ON(count !=3D cset->nr_tasks);
>  		}
> -		/* show # of overflowed tasks */
> -		if (count > MAX_TASKS_SHOWN_PER_CSS)
> -			seq_printf(seq, "  ... (%d)\n",
> -				   count - MAX_TASKS_SHOWN_PER_CSS);
> -
> -		if (cset->dead) {
> -			seq_puts(seq, "    [dead]\n");
> -			dead_cnt++;
> -		}
> -
> -		WARN_ON(count !=3D cset->nr_tasks);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> =20
>  	if (!dead_cnt && !extra_refs && !threaded_csets)
>  		return 0;
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index bf1690a167dd..01134b3af176 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -108,12 +108,12 @@ void cgroup_enter_frozen(void)
>  	if (current->frozen)
>  		return;
> =20
> -	spin_lock_irq(&css_set_lock);
> +	guard(spinlock_irq)(&css_set_lock);
> +
>  	current->frozen =3D true;
>  	cgrp =3D task_dfl_cgroup(current);
>  	cgroup_inc_frozen_cnt(cgrp);
>  	cgroup_update_frozen(cgrp);
> -	spin_unlock_irq(&css_set_lock);
>  }
> =20
>  /*
> @@ -129,7 +129,8 @@ void cgroup_leave_frozen(bool always_leave)
>  {
>  	struct cgroup *cgrp;
> =20
> -	spin_lock_irq(&css_set_lock);
> +	guard(spinlock_irq)(&css_set_lock);
> +
>  	cgrp =3D task_dfl_cgroup(current);
>  	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
>  		cgroup_dec_frozen_cnt(cgrp);
> @@ -142,7 +143,6 @@ void cgroup_leave_frozen(bool always_leave)
>  		set_thread_flag(TIF_SIGPENDING);
>  		spin_unlock(&current->sighand->siglock);
>  	}
> -	spin_unlock_irq(&css_set_lock);
>  }
> =20
>  /*
> @@ -178,12 +178,12 @@ static void cgroup_do_freeze(struct cgroup *cgrp, b=
ool freeze)
> =20
>  	lockdep_assert_held(&cgroup_mutex);
> =20
> -	spin_lock_irq(&css_set_lock);
> -	if (freeze)
> -		set_bit(CGRP_FREEZE, &cgrp->flags);
> -	else
> -		clear_bit(CGRP_FREEZE, &cgrp->flags);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		if (freeze)
> +			set_bit(CGRP_FREEZE, &cgrp->flags);
> +		else
> +			clear_bit(CGRP_FREEZE, &cgrp->flags);
> +	}
> =20
>  	if (freeze)
>  		TRACE_CGROUP_PATH(freeze, cgrp);
> @@ -206,10 +206,10 @@ static void cgroup_do_freeze(struct cgroup *cgrp, b=
ool freeze)
>  	 * Cgroup state should be revisited here to cover empty leaf cgroups
>  	 * and cgroups which descendants are already in the desired state.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> -	if (cgrp->nr_descendants =3D=3D cgrp->freezer.nr_frozen_descendants)
> -		cgroup_update_frozen(cgrp);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		if (cgrp->nr_descendants =3D=3D cgrp->freezer.nr_frozen_descendants)
> +			cgroup_update_frozen(cgrp);
> +	}
>  }
> =20
>  /*
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 144a464e45c6..3e2454a106aa 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -71,10 +71,10 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long=
 flags,
>  		return ERR_PTR(-ENOSPC);
> =20
>  	/* It is not safe to take cgroup_mutex here */
> -	spin_lock_irq(&css_set_lock);
> -	cset =3D task_css_set(current);
> -	get_css_set(cset);
> -	spin_unlock_irq(&css_set_lock);
> +	scoped_guard(spinlock_irq, &css_set_lock) {
> +		cset =3D task_css_set(current);
> +		get_css_set(cset);
> +	}
> =20
>  	new_ns =3D alloc_cgroup_ns();
>  	if (IS_ERR(new_ns)) {
> --=20
> 2.43.0
>=20

--3qgi6q3q5bzeiu6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFEw4AAKCRB+PQLnlNv4
CH8nAP4vrW9LVqRGPLjxeflfosDs3U+kG5XbKaVH4v0e+uDaHwEA8b+6B7fs/DZ1
7RohhuiIx/t/l/cCFTEYhIcTHKtnPgo=
=pnS9
-----END PGP SIGNATURE-----

--3qgi6q3q5bzeiu6h--

