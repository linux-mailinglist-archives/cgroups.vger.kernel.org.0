Return-Path: <cgroups+bounces-13361-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LBeXC3H+cWkaaQAAu9opvQ
	(envelope-from <cgroups+bounces-13361-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:39:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE419655D2
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E84086ADFB
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFF3D1CD4;
	Thu, 22 Jan 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTzJ/39Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7383ACF10
	for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077782; cv=pass; b=sE/02KwpTxtOSl9Ef3FSwHNlxRojPHEbQ9MnSgb55kizjQKWuIk3hotxg0LSFOyd01hN0vOlEZqivP3pa7ZWzse2KplXEjIpLmvPw/Fl9oSLwVBdg0RD42L8+XmoWW2Bq0nrB8sJ6vG2oFRuTWBouPNH0QJPrwLekwfotvjoydA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077782; c=relaxed/simple;
	bh=x2SoiQfq2iGYySNFf0PKsn76s1ewvcXjaiH4HAdOrGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiegV/DV1X06F89CtevP/8lP7lTNi2S0V0opj6weKPjpwa0tHWeAnwsCzdCupT/qTw5Zn9PYkbZCfVJzlmKdvMKgS2NFrAA0psoQopGq64nH+6uReCt7DhtYJL5km/7heyU/flV9Y0EoCqb/BOwy6EYkb55tU7y/XEX3i2yqOYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTzJ/39Y; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1001651a12.3
        for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 02:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769077777; cv=none;
        d=google.com; s=arc-20240605;
        b=O8wJCYxyUxuh/AM2gjB7QVD3wCwRHCXQ1DK2IR92tOYhJdonVf05sRMishq2wCKFdb
         ZZYU2svkOQe3SABNOB4fmy1YotnqOr6YKLHIfwhBocqa3av8lOaFT+geTG4jEUp4mXI7
         DQn0IDl2wZIx6Bv18uzbV2Fs9K6Cmwkd/WEOdYGT/3pksPYGAkejftpi6Te/RRAsUSqW
         2eoK8Lz+YpwmRHksgUu8HQ6ueAcDnJeEzLdZMzUiB/HSoyamTUDF+JS+oq2xcllvVvk2
         dCmIMKxupwwNkPzho/09TxhZt1U9ww9Y3ZjHr7ERoIiVU9wbR5ALPZY9xneEC94pcMNy
         EnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lued2b6BzULJArGOL1qy4FK41rw0/cVYaGyv+j5BpRI=;
        fh=OcId9ekRoaqwV+5ftX1+m5r2T7W1fp+ORpMh2adUx5I=;
        b=ec5Dy88qrQKVETJRXL+7QKnGvlTQUcJK+4tLxNB4rKE63NWFW63CP3pWBz/wJHGbP3
         v2zflunSIJzpx0S6D8qXxK4jUVLTCDX2HEJtG8wctQ5uoLYbFFXUUTgc61oi/8tyME46
         NqDtOX0TbFab6r206a9t7ApImm4SGp3fYRhuT4C+W6C3yMin4OzpRuBdYp49XhnNOewf
         fXOWaPpBxkgYna2taE/mQVceTFHX2kCcat8yof+LJjWBZYvf3EmqA903H5CKGuDyuP2J
         AUMfW9nV2KmtaTPJrZj2C9S/Ae1J9zwAQrg1NgbnmSqAXT1Lr2kN3+icw6OBIFgrlVIU
         JrIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769077777; x=1769682577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lued2b6BzULJArGOL1qy4FK41rw0/cVYaGyv+j5BpRI=;
        b=YTzJ/39YWYOxQOVMV9ECBEaT2I6d1v1EzO5tT4wwbcJhR3q6ONE8Vs1iF9U91e/Df9
         mAW8YwiLthQgG5PG/Y/oaxyxB5N0Hc8zMbDmMSzD6RxovUfc1J5GfSXMvYBOo6vdtkZ8
         EUZZxdfifuN37rDCK85Bfr1GV/1O4hS4hDSqEdU9rjiIjsTBSDm4dbcg322hV96P7aaS
         0REhf0CTMfV1gc5KvFhbp5lKSj7V7QgNPOGr++DutpMxyh7kTUmyhJ5TKsSi1PMWvY2c
         yLe5eVZGB8pb/MgoSXGddfwWO3JdwKhQDRS0o8MzIOoDVo//QDcmwOuaOvJMjf0C4IU/
         7YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769077777; x=1769682577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lued2b6BzULJArGOL1qy4FK41rw0/cVYaGyv+j5BpRI=;
        b=ebtBYWsH3TXwbz4CHOlPb+sjdwKTNr5anS42SG5iqa/x2l3q3u+L/mubfK+MDRVsrq
         i7mylYvuaslqt/7X3r+PI2F27YX5G/beC0hzQnZJkPPE/N60Le3gzXG2/bTgpdZGUDs4
         AWGxnCaByM2CVyLN12oQ6t5dTOzp6xMM0tGcYa1WTbFFqoImMQhdTpihTnUAl06tN38U
         mqnv20VQeE3LPcSXPveaV2AtZsHXQWOt+ORUWZ7Vb54NnTQU1jne/bUTgk54/G2gjMPJ
         k4XjfAbh5t/VvywkVHsf4CSOSrYGcsHxGvITfVvMc6G7/Oq0wowUENzjP/6l9jNj0QCo
         ASww==
X-Forwarded-Encrypted: i=1; AJvYcCX9gAZbH5u8CZZEGDPx4vBgymdS97abIBisNewymG8Tl61sbyOGvzXoIeYtWq6ym03Qsr2vz/4p@vger.kernel.org
X-Gm-Message-State: AOJu0YztMwUku5B/3a0Kh8kPIqaTjUOBG3jOcPFhFr8FA/EqmQ9/hrEf
	Br3OMpT6llRtTZkrYOoha3KZC+v25RF/joNZHAbwV9FNzQo/36pnCqfV3QguCyr4AyAyhbN3Iib
	NfN5vVEiUc75kVKShRhqnREuYDjwT+GQ=
X-Gm-Gg: AZuq6aL7PxxCHr31WZYcY/iaRP0/vDJ6vEQo06VQTkg+mG2oJ/tiVFmTum0X2k42bL6
	+JJgMNZmx0QuvE83PVzQAimiOduvLzQstc3bJzNO+0n0KpK5Jr9i/k6tP+LLLrxHOz9Ozpfq16A
	uJDIFJLcCpoxlEN62zrAjmMozz9ZUrPG8tGVfcaDoTlV+pSowQ4GUNWjPYSDxEAgi90mo3ulUkA
	bIIKAqvr70CnZKk97yrhpWCAS8hfyic67vL5kuMK8rCH+xbzHgPfTPJSvRi0DUs8SK4R8IAJ3mu
	nplCfRNIeSA9RFKfRM3OSFQumOo=
X-Received: by 2002:a17:907:1ca6:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b87930373e4mr1839386266b.50.1769077776305; Thu, 22 Jan 2026
 02:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120170859.1467868-1-mjguzik@gmail.com> <vqh6n6s2rlyvtxikpnrdlx2gesigl4ruyk5h6c5d27zy4l5u5f@kaemv4uuje2c>
In-Reply-To: <vqh6n6s2rlyvtxikpnrdlx2gesigl4ruyk5h6c5d27zy4l5u5f@kaemv4uuje2c>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 22 Jan 2026 11:29:24 +0100
X-Gm-Features: AZwV_QhojOvCY7zz-FkPkMtVSlgdJNivfqPz6mYf0dF00Y43VSydS7WuH_Ano30
Message-ID: <CAGudoHEM=LMT7m9twBfwY8yQV3SS2GO5FrN+FzK-SFxM+YiYtw@mail.gmail.com>
Subject: Re: [PATCH] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13361-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: AE419655D2
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 12:01=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hi.
>
> On Tue, Jan 20, 2026 at 06:08:59PM +0100, Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > In the stock kernel the css_set_lock is taken three times during thread
> > life cycle, turning it into the primary bottleneck in fork-heavy
> > workloads.
> >
> > The acquire in perparation for clone can be avoided with a sequence
> > counter, which in turn pushes the lock down.
>
> I think this can work in principle. Thanks for digging into that.
> I'd like to clarify a few details though so that the reasoning behind
> the change is complete.
>
> > Accounts only for 6% speed up when creating threads in parallel on 20
> > cores as most of the contention shifts to pidmap_lock (from about 740k
> > ops/s to 790k ops/s).
>
> BTW what code/benchmark do you use to measure this?
>

see https://lore.kernel.org/linux-mm/20251206131955.780557-1-mjguzik@gmail.=
com/

> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > I don't really care for cgroups, I merely need the thing out of the way
> > for fork. If someone wants to handle this differently, I'm not going to
> > argue as long as the bottleneck is taken care of.
> >
> > On the stock kernel pidmap_lock is still the biggest problem, but
> > there is a patch to fix it:
> > https://lore.kernel.org/linux-fsdevel/CAGudoHFuhbkJ+8iA92LYPmphBboJB7sx=
xC2L7A8OtBXA22UXzA@mail.gmail.com/T/#m832ac70f5e8f5ea14e69ca78459578d687efd=
d9f
> >
> > .. afterwards it is cgroups and the commit message was written
> > pretending it already landed.
> >
> > with the patch below contention is back on pidmap_lock
> >
> >  kernel/cgroup/cgroup-internal.h | 11 ++++--
> >  kernel/cgroup/cgroup.c          | 60 ++++++++++++++++++++++++++-------
> >  2 files changed, 55 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-int=
ernal.h
> > index 22051b4f1ccb..04a3aadcbc7f 100644
> > --- a/kernel/cgroup/cgroup-internal.h
> > +++ b/kernel/cgroup/cgroup-internal.h
> > @@ -194,6 +194,9 @@ static inline bool notify_on_release(const struct c=
group *cgrp)
> >       return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
> >  }
> >
> > +/*
> > + * refcounted get/put for css_set objects
> > + */
> >  void put_css_set_locked(struct css_set *cset);
> >
> >  static inline void put_css_set(struct css_set *cset)
> > @@ -213,14 +216,16 @@ static inline void put_css_set(struct css_set *cs=
et)
> >       spin_unlock_irqrestore(&css_set_lock, flags);
> >  }
> >
> > -/*
> > - * refcounted get/put for css_set objects
> > - */
> >  static inline void get_css_set(struct css_set *cset)
> >  {
> >       refcount_inc(&cset->refcount);
> >  }
> >
> > +static inline bool get_css_set_not_zero(struct css_set *cset)
> > +{
> > +     return refcount_inc_not_zero(&cset->refcount);
> > +}
> > +
> >  bool cgroup_ssid_enabled(int ssid);
> >  bool cgroup_on_dfl(const struct cgroup *cgrp);
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 94788bd1fdf0..16d2a8d204e8 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -87,7 +87,12 @@
> >   * cgroup.h can use them for lockdep annotations.
> >   */
> >  DEFINE_MUTEX(cgroup_mutex);
> > -DEFINE_SPINLOCK(css_set_lock);
> > +__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
> > +/*
> > + * css_set_for_clone_seq is used to allow lockless operation in cgroup=
_css_set_fork()
> > + */
> > +static __cacheline_aligned seqcount_spinlock_t css_set_for_clone_seq =
=3D
> > +     SEQCNT_SPINLOCK_ZERO(css_set_for_clone_seq, &css_set_lock);
>
> Maybe a better comment:
>         css_set_for_clone_seq synchronizes access to task_struct::cgroup
>         or cgroup::kill_seq used on clone path
>

will patch it in

> BTW why the __cacheline_aligned? Have you observed cacheline contention
> with that cgroup_mutex or anything else?
>

It's future-proofing to avoid false sharing from unrelated changes
down the road. I could perhaps annotate it with __read_mostly instead.

> >
> >  #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
> >  EXPORT_SYMBOL_GPL(cgroup_mutex);
> > @@ -907,6 +912,7 @@ static void css_set_skip_task_iters(struct css_set =
*cset,
> >   * @from_cset: css_set @task currently belongs to (may be NULL)
> >   * @to_cset: new css_set @task is being moved to (may be NULL)
> >   * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
> > + * @is_clone: indicator whether @task is amids clone
> >   *
> >   * Move @task from @from_cset to @to_cset.  If @task didn't belong to =
any
> >   * css_set, @from_cset can be NULL.  If @task is being disassociated
> > @@ -918,13 +924,16 @@ static void css_set_skip_task_iters(struct css_se=
t *cset,
> >   */
> >  static void css_set_move_task(struct task_struct *task,
> >                             struct css_set *from_cset, struct css_set *=
to_cset,
> > -                           bool use_mg_tasks)
> > +                           bool use_mg_tasks, bool is_clone)
>
> I think the is_clone arg could be dropped. The harm from incrementing
> write_seq from other places should be negligible. But it could be
> optimized by just looking at to_cset (not being NULL) as that's the
> migration that'd invalidate clone's value.
>

to_cset is not NULL on clone where the modified task can't be in the
process of forking anyway, meaning there a special case here which
does *not* invalidate the seq

this made me realize that my current patch fails to skip seq change
for the transition the other way -- clearing up cset for a dying
process is also a case where i can't be forking, so there is no need
to invalidate seq

anyhow, the routine is called on every clone and exit and
unconditional writes there very much would be a problem as they
increase bounces with the css lock held

bottom line, the code needs to be able to spot the two special cases
of assigning cset for the first time and clearing it for the last time

>
> >  {
> >       lockdep_assert_held(&css_set_lock);
> >
> >       if (to_cset && !css_set_populated(to_cset))
> >               css_set_update_populated(to_cset, true);
> >
> > +     if (!is_clone)
> > +             raw_write_seqcount_begin(&css_set_for_clone_seq);
>
> BTW What is the reason to use raw_ flavor of the seqcount functions?
> (I think it's good to have lockdep covering our backs.)

i mindlessly copied usage from dcache.c, will patch it

>
> > +
> >       if (from_cset) {
> >               WARN_ON_ONCE(list_empty(&task->cg_list));
> >
> > @@ -949,6 +958,9 @@ static void css_set_move_task(struct task_struct *t=
ask,
> >               list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg=
_tasks :
> >                                                            &to_cset->ta=
sks);
> >       }
> > +
> > +     if (!is_clone)
> > +             raw_write_seqcount_end(&css_set_for_clone_seq);
> >  }
> >
> >  /*
> > @@ -2723,7 +2735,7 @@ static int cgroup_migrate_execute(struct cgroup_m=
gctx *mgctx)
> >
> >                       get_css_set(to_cset);
> >                       to_cset->nr_tasks++;
> > -                     css_set_move_task(task, from_cset, to_cset, true)=
;
> > +                     css_set_move_task(task, from_cset, to_cset, true,=
 false);
>
> I'm afraid this should be also do the write locking.
> (To synchronize migration and forking.) But it's alternate formulation
> of the to_cset guard above.

I don't follow this comment whatsoever. With the patch as is the area
is locked by the css lock and bumps the seq count.

>
> >                       from_cset->nr_tasks--;
> >                       /*
> >                        * If the source or destination cgroup is frozen,
> > @@ -4183,7 +4195,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
> >       lockdep_assert_held(&cgroup_mutex);
> >
> >       spin_lock_irq(&css_set_lock);
> > +     raw_write_seqcount_begin(&css_set_for_clone_seq);
> >       cgrp->kill_seq++;
> > +     raw_write_seqcount_end(&css_set_for_clone_seq);
> >       spin_unlock_irq(&css_set_lock);
> >
> >       css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_I=
TER_THREADED, &it);
> > @@ -6690,20 +6704,40 @@ static int cgroup_css_set_fork(struct kernel_cl=
one_args *kargs)
> >       struct cgroup *dst_cgrp =3D NULL;
> >       struct css_set *cset;
> >       struct super_block *sb;
> > +     bool need_lock;
> >
> >       if (kargs->flags & CLONE_INTO_CGROUP)
> >               cgroup_lock();
> >
> >       cgroup_threadgroup_change_begin(current);
> >
> > -     spin_lock_irq(&css_set_lock);
> > -     cset =3D task_css_set(current);
> > -     get_css_set(cset);
> > -     if (kargs->cgrp)
> > -             kargs->kill_seq =3D kargs->cgrp->kill_seq;
> > -     else
> > -             kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> > -     spin_unlock_irq(&css_set_lock);
> > +     need_lock =3D true;
> > +     scoped_guard(rcu) {
> > +             unsigned seq =3D raw_read_seqcount_begin(&css_set_for_clo=
ne_seq);
> > +             cset =3D task_css_set(current);
> > +             if (unlikely(!cset || !get_css_set_not_zero(cset)))
> > +                     break;
> > +             if (kargs->cgrp)
> > +                     kargs->kill_seq =3D kargs->cgrp->kill_seq;
> > +             else
> > +                     kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> > +             if (read_seqcount_retry(&css_set_for_clone_seq, seq)) {
> > +                     put_css_set(cset);
> > +                     break;
> > +             }
> > +             need_lock =3D false;
>
> I see that this construction of using the read_seqcount_retry() only
> once and then falling back to spinlock is quite uncommon.
> Assuming the relevant writers are properly enclosed within seqcount,
> would there be a reason to do this double approach instead of "spin"
> inside the seqcount's read section? (As usual with seqcount reader
> sides.)
>

Just retrying in a loop does not have forward progress guarantee and
all places which merely loop are buggy on that front at least in
principle.

There is a macro read_seqbegin_or_lock which can be used to dedup the
code though.

But i'm not going to argue, it's probably fine to just loop here.

>
> > +     }
> > +
> > +     if (unlikely(need_lock)) {
> > +             spin_lock_irq(&css_set_lock);
> > +             cset =3D task_css_set(current);
> > +             get_css_set(cset);
> > +             if (kargs->cgrp)
> > +                     kargs->kill_seq =3D kargs->cgrp->kill_seq;
> > +             else
> > +                     kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
> > +             spin_unlock_irq(&css_set_lock);
> > +     }
> >
> >       if (!(kargs->flags & CLONE_INTO_CGROUP)) {
> >               kargs->cset =3D cset;
> > @@ -6907,7 +6941,7 @@ void cgroup_post_fork(struct task_struct *child,
> >
> >               WARN_ON_ONCE(!list_empty(&child->cg_list));
> >               cset->nr_tasks++;
> > -             css_set_move_task(child, NULL, cset, false);
> > +             css_set_move_task(child, NULL, cset, false, true);
> >       } else {
> >               put_css_set(cset);
> >               cset =3D NULL;
> > @@ -6995,7 +7029,7 @@ static void do_cgroup_task_dead(struct task_struc=
t *tsk)
> >
> >       WARN_ON_ONCE(list_empty(&tsk->cg_list));
> >       cset =3D task_css_set(tsk);
> > -     css_set_move_task(tsk, cset, NULL, false);
> > +     css_set_move_task(tsk, cset, NULL, false, false);
> >       cset->nr_tasks--;
> >       /* matches the signal->live check in css_task_iter_advance() */
> >       if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
> > --
> > 2.48.1
> >

