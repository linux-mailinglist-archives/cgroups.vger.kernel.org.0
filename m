Return-Path: <cgroups+bounces-13341-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLRRC+KzcGndZAAAu9opvQ
	(envelope-from <cgroups+bounces-13341-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 12:09:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C332F55BB0
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 12:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8FB9666B27
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F63D4101;
	Wed, 21 Jan 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mole5ZUK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614830649A
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993296; cv=none; b=LFGR5tdBhFBnqWfiG+J4VqfZqA7l2OdykJ/VFcdNE95aZk9MKW7CQmhj5Nf00G5TBe9oBJq9rSlU6EQEHCmdlJLnFBnW0oGD7wzvpmNQP65GQXt1K3+JYqCG4hUgAxYCap8RL/RL1cf5nUFl79UjcOhBTDItnyDdTBRyVXZiLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993296; c=relaxed/simple;
	bh=UYMFeRA5e2jiXq5s5D+mfLF+QqV1/IGYsIGxLrOcx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DStkkZ10+hgx8aJpeYCFktO4GzEXGc35oiSg1MJZnqjPNRslayivSzFjs5fsq8zbkKzwz3clQuawlCs0I2dyuDMIqkt0coykNkxnL9e/WxLrjixTq04oy0wmMbnoapKsRj3Itrx912ztdUO+l8I5/1AF1ygAvd3bTr5a6sBREYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mole5ZUK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so4979295e9.0
        for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768993292; x=1769598092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9MPR18xXbh+aN6G960hpkot86ajrlLIEHVB46z26ps=;
        b=Mole5ZUKBo4M5H9bbp/1rGjtuKSgcl9BozAbom1UQZpQ6lJt8U2CiRAY/Fxeinjlz2
         O9mScxli9zdFm9KNPfim9gFHN/ALTWV1GoUMsFNVXdy/Wg+AC/Jo3Z0Yer+o+j1yBtEy
         Umfzf+I9NpidiKDuJekMLpCIZ6pheRIRTMn8Bicg7MVhd1mHVGqNpLrTye7GugV85vTk
         p69MB/29AbcXcYzLel2Xa0qS9LrRt8inVtG3xvYc1pavy5zW4IqOq3VNaVkIonm+PI5n
         OrE+4mGXH5Y8zCrab5XZFXxwFOyMZ8t9luV9Hrd7Oa+ue3472EWr4lIPUTVgiwg7RF8c
         BfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993292; x=1769598092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9MPR18xXbh+aN6G960hpkot86ajrlLIEHVB46z26ps=;
        b=qoKCYyw+LBtfRL3A0fHopr5EeU2z7t2sMp8wen/YnijwrrcvZbv//9X6YubO14P87q
         bztWPFv2GjE/ss2tn0vh/SyvlUwqJP4s/+Gmysuk8+6WZFpitmFepLIJa3hcwzl3QkDJ
         AawZBJWxKvvfr7wkYgFMpmWQQDvNewvdcyqJBX4YlkBA9R8KC6OmLSR34L3DJYvKRQCq
         kUkyUokDhgiZ2e0wjvMKNSw2bAlZM5/xMokzR/VzYpK2KeGNd2Is7JEu+iohkG9xZs0T
         PaFi8eXLVdCGZEDID3vxN5+IecquDwmWgKAN29bEkMuk4UDniJBWcdPCTSr1rxnEGHhc
         vNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX31mVDvJ4Te4sFvTtEvp9fRkXLrHv1i5Rb6FJBqo/9pZHc/n62y9CnTM36f5KUKo/JBRj/9w/R@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIp5W4HBU0Lb6TdmCFZd3TJj04CNAuxn0LIQsi9ICxyxN+ghI
	GcP9rRUmZuxpvNXsXjj8HNQMW6mH3CCnlZa5Lqotl8Ety+jcuDSw2g1GfWrf5Aw+UwRqoLgF6qI
	ciNpD
X-Gm-Gg: AZuq6aIlGpvTzgPN0ZLUqm0yNEkL1nc+mx0F9SXU8/rAyXFo7wuuzyglnUhqcHY4buj
	7bK8hHoNO4kLhDB+xr/Vrk55Zv0UThRYvcKyD3yypGzoqLG/VdalB33R+tustL0m3Fm9K4o0oX5
	VwxZVHRM7bbvrqp6c3euh6LLadicumReuC7GCF6CV8pZcU5dqv7Qcxbb08FU1eDsFjbbpj4sES9
	9cYg5pZVs+i7VZMj0OyEIXiymb3htEDY4uWWNlHJxs+hrtvAmnmEa/himciXxbOIcBITg+mfqOu
	eK57lM30D/L+W0MLrU7ny7cCIz7BbrC1MDuo9n+6pF5omi9EN+cD7/ZzoILB1Tukmtvmp2fMPgs
	Jds05PMetK0r794QUAq43B4Mq683odAA9sbca0owQ2d+N4z/+Sx6h932NZSBkxxipMKNyPyiWWr
	sO0M9Q1kXWc0iz2LOJ6N3fXKakyC3Mlc6bsjUzaSEfpQ==
X-Received: by 2002:a05:600c:6812:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4801e5301fcmr260506985e9.4.1768993291488;
        Wed, 21 Jan 2026 03:01:31 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042bffa0bsm18429455e9.4.2026.01.21.03.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:01:30 -0800 (PST)
Date: Wed, 21 Jan 2026 12:01:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <vqh6n6s2rlyvtxikpnrdlx2gesigl4ruyk5h6c5d27zy4l5u5f@kaemv4uuje2c>
References: <20260120170859.1467868-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5cl3l52hqpvy6s4"
Content-Disposition: inline
In-Reply-To: <20260120170859.1467868-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13341-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:dkim]
X-Rspamd-Queue-Id: C332F55BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--q5cl3l52hqpvy6s4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

Hi.

On Tue, Jan 20, 2026 at 06:08:59PM +0100, Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> In the stock kernel the css_set_lock is taken three times during thread
> life cycle, turning it into the primary bottleneck in fork-heavy
> workloads.
>=20
> The acquire in perparation for clone can be avoided with a sequence
> counter, which in turn pushes the lock down.

I think this can work in principle. Thanks for digging into that.
I'd like to clarify a few details though so that the reasoning behind
the change is complete.

> Accounts only for 6% speed up when creating threads in parallel on 20
> cores as most of the contention shifts to pidmap_lock (from about 740k
> ops/s to 790k ops/s).

BTW what code/benchmark do you use to measure this?

>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> I don't really care for cgroups, I merely need the thing out of the way
> for fork. If someone wants to handle this differently, I'm not going to
> argue as long as the bottleneck is taken care of.
>=20
> On the stock kernel pidmap_lock is still the biggest problem, but
> there is a patch to fix it:
> https://lore.kernel.org/linux-fsdevel/CAGudoHFuhbkJ+8iA92LYPmphBboJB7sxxC=
2L7A8OtBXA22UXzA@mail.gmail.com/T/#m832ac70f5e8f5ea14e69ca78459578d687efdd9f
>=20
> .. afterwards it is cgroups and the commit message was written
> pretending it already landed.
>=20
> with the patch below contention is back on pidmap_lock
>=20
>  kernel/cgroup/cgroup-internal.h | 11 ++++--
>  kernel/cgroup/cgroup.c          | 60 ++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 16 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-inter=
nal.h
> index 22051b4f1ccb..04a3aadcbc7f 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -194,6 +194,9 @@ static inline bool notify_on_release(const struct cgr=
oup *cgrp)
>  	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
>  }
> =20
> +/*
> + * refcounted get/put for css_set objects
> + */
>  void put_css_set_locked(struct css_set *cset);
> =20
>  static inline void put_css_set(struct css_set *cset)
> @@ -213,14 +216,16 @@ static inline void put_css_set(struct css_set *cset)
>  	spin_unlock_irqrestore(&css_set_lock, flags);
>  }
> =20
> -/*
> - * refcounted get/put for css_set objects
> - */
>  static inline void get_css_set(struct css_set *cset)
>  {
>  	refcount_inc(&cset->refcount);
>  }
> =20
> +static inline bool get_css_set_not_zero(struct css_set *cset)
> +{
> +	return refcount_inc_not_zero(&cset->refcount);
> +}
> +
>  bool cgroup_ssid_enabled(int ssid);
>  bool cgroup_on_dfl(const struct cgroup *cgrp);
> =20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 94788bd1fdf0..16d2a8d204e8 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -87,7 +87,12 @@
>   * cgroup.h can use them for lockdep annotations.
>   */
>  DEFINE_MUTEX(cgroup_mutex);
> -DEFINE_SPINLOCK(css_set_lock);
> +__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
> +/*
> + * css_set_for_clone_seq is used to allow lockless operation in cgroup_c=
ss_set_fork()
> + */
> +static __cacheline_aligned seqcount_spinlock_t css_set_for_clone_seq =3D
> +	SEQCNT_SPINLOCK_ZERO(css_set_for_clone_seq, &css_set_lock);

Maybe a better comment:
	css_set_for_clone_seq synchronizes access to task_struct::cgroup
	or cgroup::kill_seq used on clone path

BTW why the __cacheline_aligned? Have you observed cacheline contention
with that cgroup_mutex or anything else?

> =20
>  #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
>  EXPORT_SYMBOL_GPL(cgroup_mutex);
> @@ -907,6 +912,7 @@ static void css_set_skip_task_iters(struct css_set *c=
set,
>   * @from_cset: css_set @task currently belongs to (may be NULL)
>   * @to_cset: new css_set @task is being moved to (may be NULL)
>   * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
> + * @is_clone: indicator whether @task is amids clone
>   *
>   * Move @task from @from_cset to @to_cset.  If @task didn't belong to any
>   * css_set, @from_cset can be NULL.  If @task is being disassociated
> @@ -918,13 +924,16 @@ static void css_set_skip_task_iters(struct css_set =
*cset,
>   */
>  static void css_set_move_task(struct task_struct *task,
>  			      struct css_set *from_cset, struct css_set *to_cset,
> -			      bool use_mg_tasks)
> +			      bool use_mg_tasks, bool is_clone)

I think the is_clone arg could be dropped. The harm from incrementing
write_seq from other places should be negligible. But it could be
optimized by just looking at to_cset (not being NULL) as that's the
migration that'd invalidate clone's value.


>  {
>  	lockdep_assert_held(&css_set_lock);
> =20
>  	if (to_cset && !css_set_populated(to_cset))
>  		css_set_update_populated(to_cset, true);
> =20
> +	if (!is_clone)
> +		raw_write_seqcount_begin(&css_set_for_clone_seq);

BTW What is the reason to use raw_ flavor of the seqcount functions?
(I think it's good to have lockdep covering our backs.)

> +
>  	if (from_cset) {
>  		WARN_ON_ONCE(list_empty(&task->cg_list));
> =20
> @@ -949,6 +958,9 @@ static void css_set_move_task(struct task_struct *tas=
k,
>  		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
>  							     &to_cset->tasks);
>  	}
> +
> +	if (!is_clone)
> +		raw_write_seqcount_end(&css_set_for_clone_seq);
>  }
> =20
>  /*
> @@ -2723,7 +2735,7 @@ static int cgroup_migrate_execute(struct cgroup_mgc=
tx *mgctx)
> =20
>  			get_css_set(to_cset);
>  			to_cset->nr_tasks++;
> -			css_set_move_task(task, from_cset, to_cset, true);
> +			css_set_move_task(task, from_cset, to_cset, true, false);

I'm afraid this should be also do the write locking.
(To synchronize migration and forking.) But it's alternate formulation
of the to_cset guard above.

>  			from_cset->nr_tasks--;
>  			/*
>  			 * If the source or destination cgroup is frozen,
> @@ -4183,7 +4195,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
>  	lockdep_assert_held(&cgroup_mutex);
> =20
>  	spin_lock_irq(&css_set_lock);
> +	raw_write_seqcount_begin(&css_set_for_clone_seq);
>  	cgrp->kill_seq++;
> +	raw_write_seqcount_end(&css_set_for_clone_seq);
>  	spin_unlock_irq(&css_set_lock);
> =20
>  	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_TH=
READED, &it);
> @@ -6690,20 +6704,40 @@ static int cgroup_css_set_fork(struct kernel_clon=
e_args *kargs)
>  	struct cgroup *dst_cgrp =3D NULL;
>  	struct css_set *cset;
>  	struct super_block *sb;
> +	bool need_lock;
> =20
>  	if (kargs->flags & CLONE_INTO_CGROUP)
>  		cgroup_lock();
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
> +	need_lock =3D true;
> +	scoped_guard(rcu) {
> +		unsigned seq =3D raw_read_seqcount_begin(&css_set_for_clone_seq);
> +		cset =3D task_css_set(current);
> +		if (unlikely(!cset || !get_css_set_not_zero(cset)))
> +			break;
> +		if (kargs->cgrp)
> +			kargs->kill_seq =3D kargs->cgrp->kill_seq;
> +		else
> +			kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> +		if (read_seqcount_retry(&css_set_for_clone_seq, seq)) {
> +			put_css_set(cset);
> +			break;
> +		}
> +		need_lock =3D false;

I see that this construction of using the read_seqcount_retry() only
once and then falling back to spinlock is quite uncommon.
Assuming the relevant writers are properly enclosed within seqcount,
would there be a reason to do this double approach instead of "spin"
inside the seqcount's read section? (As usual with seqcount reader
sides.)


> +	}
> +
> +	if (unlikely(need_lock)) {
> +		spin_lock_irq(&css_set_lock);
> +		cset =3D task_css_set(current);
> +		get_css_set(cset);
> +		if (kargs->cgrp)
> +			kargs->kill_seq =3D kargs->cgrp->kill_seq;
> +		else
> +			kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> +		spin_unlock_irq(&css_set_lock);
> +	}
> =20
>  	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
>  		kargs->cset =3D cset;
> @@ -6907,7 +6941,7 @@ void cgroup_post_fork(struct task_struct *child,
> =20
>  		WARN_ON_ONCE(!list_empty(&child->cg_list));
>  		cset->nr_tasks++;
> -		css_set_move_task(child, NULL, cset, false);
> +		css_set_move_task(child, NULL, cset, false, true);
>  	} else {
>  		put_css_set(cset);
>  		cset =3D NULL;
> @@ -6995,7 +7029,7 @@ static void do_cgroup_task_dead(struct task_struct =
*tsk)
> =20
>  	WARN_ON_ONCE(list_empty(&tsk->cg_list));
>  	cset =3D task_css_set(tsk);
> -	css_set_move_task(tsk, cset, NULL, false);
> +	css_set_move_task(tsk, cset, NULL, false, false);
>  	cset->nr_tasks--;
>  	/* matches the signal->live check in css_task_iter_advance() */
>  	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
> --=20
> 2.48.1
>=20

--q5cl3l52hqpvy6s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXCyBBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjUmwD8Cj6sv+KQfc5K1a2OrDYd
BfUVsmvU/BmHyJ+G99JrdwUA/i8vcOgaTjsM9Y6Ranmwb6FhlROfTb6PjldufwFE
t3AF
=oWtt
-----END PGP SIGNATURE-----

--q5cl3l52hqpvy6s4--

