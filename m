Return-Path: <cgroups+bounces-13478-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFC0BAnMeGmNtQEAu9opvQ
	(envelope-from <cgroups+bounces-13478-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 15:30:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB295B6F
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CEEE3017398
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA23587A4;
	Tue, 27 Jan 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaLKTfhc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4813AF2
	for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524229; cv=pass; b=F2Cj7mBOJU1Wd+LeR9iz5cbzuy0lNmagW9iUcpDthQ1zsxHKeTpohU5HR8hT8zwX3WY6txJ0x7gqQi15/uOfXWS68i7fWQfUtDnAVwvFBhnAxhjCs0ELAr4Zm0nEu8VlPdhn73Cn51gwHHCywOisB9uSyQOruoNJcfG5fUGsUHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524229; c=relaxed/simple;
	bh=drN/88L4Y2ayTN9cVf333csgtdhmXP6n4jwO0oEf/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spKgVyTZE6R1RTtVFbnWn1TFleASk/sGSdqdD1v4gxP87DKivnIhF88kF8950g0fJBblIg9SvzztO/sXITOaw/rFxX2ArwH6AujAkKpnyfiqhsBOh2yiGa/r2NnXlCC8i1DL303ZdWl6lThq05TMrvP55NEcjcMlr9ZHuJBQgT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaLKTfhc; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so9787615a12.1
        for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 06:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524227; cv=none;
        d=google.com; s=arc-20240605;
        b=TUQPKGslxEzUoSmeQaDy8LLvmvx9aDDG3yGDvbz4XXtCh8w8tnuK+OqolPu88sGGFh
         H6cpzvRNyLi1rD80sI+e0uibMk9Rh0/h3ZyDlqTNZsWwpz76Xvg4iimalM8QnsQGj50A
         bhSPFFi/AQZP4FND+hdnG0cQrKK8bmffxrlcr3dtkIOuRX/NxSWQNC7UwD0jgUe1OYhP
         y9Rg1QsIrEJsLTVcfBJFeBDC8+rpzXCrywLT4xe9mMfD2FH6k03n6qFMgqxHj0WNiDvW
         nBKX+ABiQL4TmUUmYWeOGo+n83eLqLj9/hitpuKvFjm5+vRyr1KXy5goMY92HOkwZww2
         aXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KEAokdWr9RDQgC+gcUbhj0aMVUaiTwzlfcGRBWIsVNQ=;
        fh=EoBpd1JCsvxWDQrUXWdFYQXOxqc+UI5Nwa3XGI8B6Mg=;
        b=btwwoZm7T9PEh7yyUYMZVWNfFQp0AizUghCigZCe6efAjFvDeDrv33TzuCswqjZSym
         2Qp5IoEWAa/Ld9XVzblbmsBXAuNpJsxlYYLIvqaVNQqMUUW/H0bQ7LxqJTMIyJ0+4OPU
         QI3XGhHztExHLYOFUkUAn8545sKPxAbh8joWn7vvYKituOphekqkncA1hRDUXD72QsMU
         FKgOqBN/1ssKtSCCk2XQvgJHLKVFnluoyVM6AAMPXYg60bEXY8VDacvIOXswVXGXeRcY
         0N+VRaXLWvlCXuz9+tuIxZ+UwsoTeeiKkWzD99EjmU5UdQnzUpGEb9KSvpMuT7V6GUBb
         B4Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769524227; x=1770129027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEAokdWr9RDQgC+gcUbhj0aMVUaiTwzlfcGRBWIsVNQ=;
        b=UaLKTfhc324MM/1u0vjYp8tbZBGRPj0zhQb+FPZA6V4TwEgi4PW7bO3bqeygdviyhk
         kLSHTKqkpJXyn6iikX/1VwYFn1i5u3NoKGbqXTofAYElbwAItk5Fmwn4s/3iyGWU1jF5
         SN383CJAprVnMjRYD98PdvfDVB/FGVnxcfViEbOOcmObhvrYTMNKpzlAD1DXtbz9SiAZ
         x7Z/90qlWwjAH/8YxwyvdByHelKlnpAnjrch5aShAOoNIrXJUqjI8wGPrZK8L0xfBFR0
         hLeWns2EkIbYBfiK1sv4jbYTZTwwTjaGeBXY2NWe/I7uQPm2I1U+1aorQ1Os+7xx1k1y
         7uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524227; x=1770129027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEAokdWr9RDQgC+gcUbhj0aMVUaiTwzlfcGRBWIsVNQ=;
        b=TEOr9I3C/dXVoppKo4CLEQr5zsJP8STG6CAMkaApgqJLxoZRcpyKD8StSKZL3NrEas
         jq+nkMCoUM8kf4BunHDMV58gXjhXxaieIzz+9OWLRcbHSOyyv1JnHU63CT1/Zxep6Qu8
         +UJ98QwsaiYwdtLZy2NNTyrj/QN40zdP829XZXBZ84FxBfIK6ClVLtlT3mFfBf5H+dWw
         FWXcYhyjzyDKtAj0ZZSDosl15WjVe/NZPsfyueyYIi5xWmG3yPJx5lGtVy89iHouJHhG
         I17VmaqKgXfKLXYWFr6ioHGPpRfI1wCnadivorCoaZL2TIZOVXEAFzptqLFyBocr+Sm6
         x8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmhzEaKyRXaibTlBnIxMkqMLmjNn/Jo1BqeXMq654B/P6FEIp43D51pZkLizE8g9+UR52U2Vsc@vger.kernel.org
X-Gm-Message-State: AOJu0YwwujjIuLuC5Gd603y9S1PxHocoFBW4veAoTFIP2kV2Uy3PszRE
	M3lkXRUKPLg7M50mpwCC9dedMbqNjTWCj0hJrkPJReSFEVfgeduCT33gh9f7sjpbLqnrql2He5a
	hm0dIlGt9dLgDpOrWljrnhUciNYfk2pQ=
X-Gm-Gg: AZuq6aIKc63tzRHY6mypKzJr0Ue62UYDdTv+LOxV47FmeIQ1MuQlluNsZL4HLTlB6N9
	tXuSZW3YaFHPPD5MpALFnf4PYTf0KlDSDBKYx8ySq3Qznrbhw7HHuKVu/Ub6lF327W2tLjE6jzU
	RgtknXlCe83ssUFszTm62s3UvfbC5dDeC3ss7M4oYUXLyGMghFuDzp9KC11/HtFU4N9UY9tWkHt
	xyvcy5SZskEh8lsECXwetM6kFUSJICYziV1ilTGGUZeIFTO3Gtcd5P5/cghSZN3STPv5a6Q8o1i
	2srHLZRXMZJFKVmha3jvEG0REAI=
X-Received: by 2002:a05:6402:3581:b0:658:177a:27d with SMTP id
 4fb4d7f45d1cf-658a602e964mr1337777a12.12.1769524226510; Tue, 27 Jan 2026
 06:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122112951.1854124-1-mjguzik@gmail.com>
In-Reply-To: <20260122112951.1854124-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 27 Jan 2026 15:30:14 +0100
X-Gm-Features: AZwV_Qh42hMUHB-fsjdjCVBienP5O3mqXmbhGynjBVNAUCCljF1E9EVCEBRO34U
Message-ID: <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13478-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FFB295B6F
X-Rspamd-Action: no action

ping? I need cgroups out of the way for further scalability work in fork+ e=
xit

On Thu, Jan 22, 2026 at 12:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> In the stock kernel the css_set_lock is taken three times during thread
> life cycle, turning it into the primary bottleneck in fork-heavy
> workloads.
>
> The acquire in perparation for clone can be avoided with a sequence
> counter, which in turn pushes the lock down.
>
> Accounts only for 6% speed up when creating threads in parallel on 20
> cores as most of the contention shifts to pidmap_lock.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> v2:
> - change comment about clone_seq
> - raw_write_seqcount* -> write_seqcount
> - just loop on failed seq check
> - don't bump it on task exit
>
>  kernel/cgroup/cgroup-internal.h | 11 +++++--
>  kernel/cgroup/cgroup.c          | 54 +++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-inter=
nal.h
> index 22051b4f1ccb..04a3aadcbc7f 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -194,6 +194,9 @@ static inline bool notify_on_release(const struct cgr=
oup *cgrp)
>         return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
>  }
>
> +/*
> + * refcounted get/put for css_set objects
> + */
>  void put_css_set_locked(struct css_set *cset);
>
>  static inline void put_css_set(struct css_set *cset)
> @@ -213,14 +216,16 @@ static inline void put_css_set(struct css_set *cset=
)
>         spin_unlock_irqrestore(&css_set_lock, flags);
>  }
>
> -/*
> - * refcounted get/put for css_set objects
> - */
>  static inline void get_css_set(struct css_set *cset)
>  {
>         refcount_inc(&cset->refcount);
>  }
>
> +static inline bool get_css_set_not_zero(struct css_set *cset)
> +{
> +       return refcount_inc_not_zero(&cset->refcount);
> +}
> +
>  bool cgroup_ssid_enabled(int ssid);
>  bool cgroup_on_dfl(const struct cgroup *cgrp);
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 94788bd1fdf0..0053582b9b56 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -87,7 +87,14 @@
>   * cgroup.h can use them for lockdep annotations.
>   */
>  DEFINE_MUTEX(cgroup_mutex);
> -DEFINE_SPINLOCK(css_set_lock);
> +__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
> +
> +/*
> + * css_set_for_clone_seq synchronizes access to task_struct::cgroup
> + * and cgroup::kill_seq used on clone path
> + */
> +static __cacheline_aligned seqcount_spinlock_t css_set_for_clone_seq =3D
> +       SEQCNT_SPINLOCK_ZERO(css_set_for_clone_seq, &css_set_lock);
>
>  #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
>  EXPORT_SYMBOL_GPL(cgroup_mutex);
> @@ -907,6 +914,7 @@ static void css_set_skip_task_iters(struct css_set *c=
set,
>   * @from_cset: css_set @task currently belongs to (may be NULL)
>   * @to_cset: new css_set @task is being moved to (may be NULL)
>   * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
> + * @skip_clone_seq: don't bump css_set_for_clone_seq
>   *
>   * Move @task from @from_cset to @to_cset.  If @task didn't belong to an=
y
>   * css_set, @from_cset can be NULL.  If @task is being disassociated
> @@ -918,13 +926,16 @@ static void css_set_skip_task_iters(struct css_set =
*cset,
>   */
>  static void css_set_move_task(struct task_struct *task,
>                               struct css_set *from_cset, struct css_set *=
to_cset,
> -                             bool use_mg_tasks)
> +                             bool use_mg_tasks, bool skip_clone_seq)
>  {
>         lockdep_assert_held(&css_set_lock);
>
>         if (to_cset && !css_set_populated(to_cset))
>                 css_set_update_populated(to_cset, true);
>
> +       if (!skip_clone_seq)
> +               write_seqcount_begin(&css_set_for_clone_seq);
> +
>         if (from_cset) {
>                 WARN_ON_ONCE(list_empty(&task->cg_list));
>
> @@ -949,6 +960,9 @@ static void css_set_move_task(struct task_struct *tas=
k,
>                 list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg=
_tasks :
>                                                              &to_cset->ta=
sks);
>         }
> +
> +       if (!skip_clone_seq)
> +               write_seqcount_end(&css_set_for_clone_seq);
>  }
>
>  /*
> @@ -2723,7 +2737,7 @@ static int cgroup_migrate_execute(struct cgroup_mgc=
tx *mgctx)
>
>                         get_css_set(to_cset);
>                         to_cset->nr_tasks++;
> -                       css_set_move_task(task, from_cset, to_cset, true)=
;
> +                       css_set_move_task(task, from_cset, to_cset, true,=
 false);
>                         from_cset->nr_tasks--;
>                         /*
>                          * If the source or destination cgroup is frozen,
> @@ -4183,7 +4197,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
>         lockdep_assert_held(&cgroup_mutex);
>
>         spin_lock_irq(&css_set_lock);
> +       write_seqcount_begin(&css_set_for_clone_seq);
>         cgrp->kill_seq++;
> +       write_seqcount_end(&css_set_for_clone_seq);
>         spin_unlock_irq(&css_set_lock);
>
>         css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_I=
TER_THREADED, &it);
> @@ -6696,14 +6712,26 @@ static int cgroup_css_set_fork(struct kernel_clon=
e_args *kargs)
>
>         cgroup_threadgroup_change_begin(current);
>
> -       spin_lock_irq(&css_set_lock);
> -       cset =3D task_css_set(current);
> -       get_css_set(cset);
> -       if (kargs->cgrp)
> -               kargs->kill_seq =3D kargs->cgrp->kill_seq;
> -       else
> -               kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> -       spin_unlock_irq(&css_set_lock);
> +       for (;;) {
> +               unsigned seq =3D raw_read_seqcount_begin(&css_set_for_clo=
ne_seq);
> +               bool got_ref =3D false;
> +               rcu_read_lock();
> +               cset =3D task_css_set(current);
> +               if (kargs->cgrp)
> +                       kargs->kill_seq =3D kargs->cgrp->kill_seq;
> +               else
> +                       kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> +               if (get_css_set_not_zero(cset))
> +                       got_ref =3D true;
> +               rcu_read_unlock();
> +               if (unlikely(!got_ref || read_seqcount_retry(&css_set_for=
_clone_seq, seq))) {
> +                       if (got_ref)
> +                               put_css_set(cset);
> +                       cpu_relax();
> +                       continue;
> +               }
> +               break;
> +       }
>
>         if (!(kargs->flags & CLONE_INTO_CGROUP)) {
>                 kargs->cset =3D cset;
> @@ -6907,7 +6935,7 @@ void cgroup_post_fork(struct task_struct *child,
>
>                 WARN_ON_ONCE(!list_empty(&child->cg_list));
>                 cset->nr_tasks++;
> -               css_set_move_task(child, NULL, cset, false);
> +               css_set_move_task(child, NULL, cset, false, true);
>         } else {
>                 put_css_set(cset);
>                 cset =3D NULL;
> @@ -6995,7 +7023,7 @@ static void do_cgroup_task_dead(struct task_struct =
*tsk)
>
>         WARN_ON_ONCE(list_empty(&tsk->cg_list));
>         cset =3D task_css_set(tsk);
> -       css_set_move_task(tsk, cset, NULL, false);
> +       css_set_move_task(tsk, cset, NULL, false, true);
>         cset->nr_tasks--;
>         /* matches the signal->live check in css_task_iter_advance() */
>         if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
> --
> 2.48.1
>

