Return-Path: <cgroups+bounces-4869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424D9773B6
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 23:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3CC284A69
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF411C1AB7;
	Thu, 12 Sep 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJO/eulG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80E2C80
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177320; cv=none; b=Gwg/sQOH25eGH3T0e5cf1xjWpy/dCEHv4NxWLdV5JjnNouRHo9RGpdZZEN3JijmSA9PxtegUKoH75cMRBTMIjOvTQNgjmTdQq8OxX1glUASJUf6eMWvHcJyzYFJJTNBU6aDUyNq5trp9Fd1isbXRkzaOR/JNHdezjZWAhQd8Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177320; c=relaxed/simple;
	bh=JjlQyr/wFuy8m01BED9HSVzcdWYDkMr/xLmVMQEdMVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLpz4+wuYd92Zy2WidJeCTFS5rioie/t9W3OQANFzOi7FXQd1xWDvdLRfWMzg/3aBt72Pl+zvSe6FoA5kOqrxwQOfDiH1vyI4P2D2QtRsXhQjukbjavsGbaClM3Ru9+xhC2XtCkNQt68pv3fsNGm718PXhCSDva70j2+A3ss1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJO/eulG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so220140166b.1
        for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726177317; x=1726782117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTZv2DvHUPeuuWtbWXNvhL20hGAkO1mn69EjhOlUabk=;
        b=fJO/eulGTXRNCq6+dkY7Zxm/cOkpVxT7uuRACLf3ZeTXAENyfZui0fyWnvgYboqSb/
         CvGEIETynInprvz1yCi10GTp1C6LZVPaVSJSUFBsEF70+pi4cvo60Iboz3/Nw/2qeqJC
         3useTi91ZF8yn/NshUpbF5MiFpBdvfUWTF9W0jJdUnZfm2AAr9c+vD+zLSdTsiRTsIhK
         mC1NRYh3XmX+8VtSBHc3hlFzP5aqgOiPayPNIim9L9dNPdYhyvRUObPBPibGTu7xqf0T
         6BTMI7QAzkWcoB5p73iQDSMWapzWfm/zej4yAA/ep0zJspw6cfntvEem/AICXs3pRJWX
         cBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177317; x=1726782117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTZv2DvHUPeuuWtbWXNvhL20hGAkO1mn69EjhOlUabk=;
        b=SftHWHglK/KWcC3eH1D8VCGxZ+VRezWO9fPHqAiigjqJtsT5K14DHSCsQHeWAHIgN8
         VwnraGGTLEL1WmoPCpH1WCwC1aoPvtJkuRDSPfitVyKeu118u9th2O33Z+xSN+mXvsVT
         MElP4pCeOqZahoQ/xhkSyJzD7BjppcUSYWjRlRKRne4nUa98zUX64Ydedc/Mx125EhN+
         E1hpIje8A9nhsOwpW6BD2zIV60UKq985/Zaefb7pITJLeQZa+67JeUJbO6VYMpBod6zu
         ghlIkKC55DFwJuRsyzD7Odz89HAbpEdiIjKeWO9vBL4F5vgHfj5XTLsL8UvKM3FQ+6ZQ
         aTxA==
X-Forwarded-Encrypted: i=1; AJvYcCWSUxfbKvPTo5QLPuB0vrLIPY/1trp5qYmM7W07DRIzPGIKAguJ/PcUxZua3KcZazrbRC+bkcs0@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHDqvFS/W9hcYXT62vljjbsrpRXJ8TS+IKmdue9yT4zbkI+RN
	Eq7oYT+MRsq7ZXqQVyO4HPsdPonkFqYs+3HvBfWAKy1iF+In3a2rHgTUclLUJMULFM705+izUDk
	0m/4B9SsXwo8z9mnjGIMoDsmrLlRU2fo1BwsYxSrJr8dabKWw9ug+
X-Google-Smtp-Source: AGHT+IFJ6L/EjAQhvjUs3LCLWwrLAXw7wzIe3wRS5fwMYlDRY4tVJbtr+7tjdNlnrYIEmTliMOCPryTOB0VfVwINmm4=
X-Received: by 2002:a17:907:f168:b0:a8f:f799:e7db with SMTP id
 a640c23a62f3a-a9029438211mr405542366b.16.1726177315834; Thu, 12 Sep 2024
 14:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172616070094.2055617.17676042522679701515.stgit@firesoul>
In-Reply-To: <172616070094.2055617.17676042522679701515.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Sep 2024 14:41:18 -0700
Message-ID: <CAJD7tkZyKHRHJue1NaNqTMo5Ue2BvZfW_GXetMb+M+OkiCoj8g@mail.gmail.com>
Subject: Re: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:07=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
> This patch reintroduces and generalizes the "stats_flush_ongoing" concept
> to avoid redundant flushes if there is an ongoing flush at cgroup root
> level, addressing production lock contention issues on the global cgroup
> rstat lock.
>
> In this revision userspace readers will wait for the ongoing flusher to
> complete before returning, to avoid reading out-dated stats just before
> they get updated. Generally in-kernel users will attempt to skip the
> flush in-order to get out of the lock contention state. Some in-kernel
> users of the cgroup_rstat_flush() API depend on waiting for the flush to
> complete before continuing. This patch introduce the call
> cgroup_rstat_flush_relaxed() with a wait_for_flush option to satisfy both
> use-cases.
>
> At Cloudflare, we observed significant performance degradation due to
> lock contention on the rstat lock, primarily caused by kswapd. The
> specific mem_cgroup_flush_stats() call inlined in shrink_node, which
> takes the rstat lock, is particularly problematic.
>
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, w=
e
> noted severe lock contention on the rstat lock, causing 12 CPUs to waste
> cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedst=
at)
> for kthreads revealed that we are burning an average of 20,000 CPU cores
> fleet-wide on kswapd, primarily due to spinning on the rstat lock.
>
> Here's a brief overview of the issue:
> - __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN thre=
ads
>   to wake up simultaneously.
> - The kswapd thread invokes shrink_node (via balance_pgdat), triggering t=
he
>   cgroup rstat flush operation as part of its work.
> - balance_pgdat() has a NULL value in target_mem_cgroup, causing
>   mem_cgroup_flush_stats() to flush with root_mem_cgroup.
>
> The kernel previously addressed this with a "stats_flush_ongoing" concept=
,
> which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree sta=
ts
> flushing"). This patch reintroduces and generalizes the concept to apply =
to
> all users of cgroup rstat, not just memcg.
>
> It have been a general theme to replace mem_cgroup_flush_stats() with
> mem_cgroup_flush_stats_ratelimited every time we see a new case of this
> issue. This will hide the contention issue until something starves the
> kthread that does the periodic 2 second flush (for 2 periods). In
> production we are seeing kthreads getting starved longer than 20 seconds.
> This often happens in connection with OOM killer. This recreates the
> kswapd lock contention situation at a very unfortunate point in time.
> Thus, it makes sense to have this ongoing flusher lock contention
> protection in place.
>
> In this patch only a root cgroup can become the ongoing flusher, as this =
solves
> the production issue. Letting other levels becoming ongoing flusher cause=
 root
> cgroup to contend on the lock again.
>
> This change significantly reduces lock contention, especially in
> environments with multiple NUMA nodes, thereby improving overall system
> performance.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---

To reiterate my response on v10, I prefer that this problem is handled
at the reclaim flushing site. This started as a nice simple and
generic approach, but ended up being complex and tailored to handle
the reclaim flushing case.

I do have some comments on the current implementation nonetheless.

> v11:
>  - Address Yosry request to wait-for-flush for userspace readers
>
> V10: https://lore.kernel.org/all/172547884995.206112.808619042206173396.s=
tgit@firesoul/
>
>  block/blk-cgroup.c         |    2 -
>  include/linux/cgroup.h     |    1
>  include/linux/memcontrol.h |    1
>  kernel/cgroup/rstat.c      |  133 ++++++++++++++++++++++++++++++++++++++=
++++--
>  mm/memcontrol.c            |   40 +++++++++----
>  mm/vmscan.c                |    2 -
>  mm/zswap.c                 |    2 -
>  7 files changed, 157 insertions(+), 24 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 37e6cc91d576..058393e7665a 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1200,7 +1200,7 @@ static int blkcg_print_stat(struct seq_file *sf, vo=
id *v)
>         if (!seq_css(sf)->parent)
>                 blkcg_fill_root_iostats();
>         else
> -               cgroup_rstat_flush(blkcg->css.cgroup);
> +               cgroup_rstat_flush_relaxed(blkcg->css.cgroup, true);
>
>         rcu_read_lock();
>         hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..ff65bc100ca5 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -691,6 +691,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cp=
u);
>  void cgroup_rstat_flush(struct cgroup *cgrp);
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
>  void cgroup_rstat_flush_release(struct cgroup *cgrp);
> +int cgroup_rstat_flush_relaxed(struct cgroup *cgrp, bool wait_for_flush)=
;

We now have 4 different flavors of rstat flushing:

1. cgroup_rstat_flush() -> normal flush: lock, flush, unlock
2. cgroup_rstat_flush_hold() -> same, but keep the lock held
3. cgroup_rstat_flush_relaxed(wait_for_flush=3Dtrue) -> if someone is
already flushing us, wait, otherwise normal
4. cgroup_rstat_flush_relaxed(wait_for_flush=3Dfalse) -> if someone is
already flushing us, wait, otherwise normal

Why do we need the third one? Can't we just keep using (1) for now for
userspace readers?

>
>  /*
>   * Basic resource stats.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..7e24c5e1327f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1026,6 +1026,7 @@ unsigned long lruvec_page_state_local(struct lruvec=
 *lruvec,
>                                       enum node_stat_item idx);
>
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
> +void mem_cgroup_flush_stats_relaxed(struct mem_cgroup *memcg);
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
>
>  void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index a06b45272411..80a4b949138f 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -11,6 +11,9 @@
>
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static struct cgroup *cgrp_rstat_ongoing_flusher =3D NULL;
> +static struct task_struct *cgrp_rstat_ongoing_flusher_ID =3D NULL;

rstat_ongoing_flush_cgrp and rstat_ongoing_flush_task are probably
clearer names.

> +static DEFINE_MUTEX(cgrp_rstat_ongoing_flusher_serialize);
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>
> @@ -299,6 +302,68 @@ static inline void __cgroup_rstat_unlock(struct cgro=
up *cgrp, int cpu_in_loop)
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> +static inline bool cgroup_is_root(struct cgroup *cgrp)
> +{
> +       return cgroup_parent(cgrp) =3D=3D NULL;
> +}
> +
> +/**
> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flu=
sher
> + * @cgrp: target cgroup
> + * @strict: always lock and ignore/skip ongoing flusher checks
> + *
> + * Function return value follow trylock semantics. Returning true when l=
ock is
> + * obtained. Returning false when not locked and it detected flushing ca=
n be
> + * skipped as another ongoing flusher is taking care of the flush.
> + *
> + * For callers that depend on flush completing before returning a strict=
 option
> + * is provided.
> + */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool stric=
t)
> +{
> +       struct cgroup *ongoing;
> +
> +       if (strict)
> +               goto lock;

Might as well just have a cgroup_rstat_lock_flusher() function instead
of the boolean parameter, which is also consistent with the
lock/trylock semantics you are following.

> +
> +       /*
> +        * Check if ongoing flusher is already taking care of this.  Desc=
endant
> +        * check is necessary due to cgroup v1 supporting multiple root's=
.
> +        */
> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))

The ongoing flusher may be going away, so cgroup_is_descendant() may
be a UAF as I pointed out a few times. I actually think even taking a
ref here may not work as it may be a flush from cgroup_rstat_exit().

One thing we can do is get the root of cgrp (probably
cgrp->root->cgrp?) and compare it to cgrp_rstat_ongoing_flusher
without ever dereferencing it. If the ongoing flusher is in fact the
root of cgrp, this implies a ref on it anyway so we can dereference it
if needed.

That would obviously need a comment to explain it.

> +               return false;
> +
> +       /* Grab right to be ongoing flusher */
> +       if (!ongoing && cgroup_is_root(cgrp)) {
> +               struct cgroup *old;
> +
> +               old =3D cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
> +               if (old) {
> +                       /* Lost race for being ongoing flusher */
> +                       if (cgroup_is_descendant(cgrp, old))
> +                               return false;
> +               }
> +               /* Due to lock yield combined with strict mode record ID =
*/

This needs a more detailed comment.

> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);

This will overwrite the ID if we lost the race but are not a
descendant of the flusher that one the race, right?

> +       }
> +lock:
> +       __cgroup_rstat_lock(cgrp, -1);
> +
> +       return true;
> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +       if (cgrp =3D=3D READ_ONCE(cgrp_rstat_ongoing_flusher) &&
> +           READ_ONCE(cgrp_rstat_ongoing_flusher_ID) =3D=3D current) {
> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, NULL);
> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
> +       }
> +
> +       __cgroup_rstat_unlock(cgrp, -1);
> +}
> +
>  /* see cgroup_rstat_flush() */
>  static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
> @@ -333,6 +398,19 @@ static void cgroup_rstat_flush_locked(struct cgroup =
*cgrp)
>         }
>  }
>
> +static int __cgroup_rstat_flush(struct cgroup *cgrp, bool strict)
> +{
> +       might_sleep();
> +
> +       if (!cgroup_rstat_trylock_flusher(cgrp, strict))
> +               return false;
> +
> +       cgroup_rstat_flush_locked(cgrp);
> +       cgroup_rstat_unlock_flusher(cgrp);
> +
> +       return true;
> +}
> +
>  /**
>   * cgroup_rstat_flush - flush stats in @cgrp's subtree
>   * @cgrp: target cgroup
> @@ -348,11 +426,49 @@ static void cgroup_rstat_flush_locked(struct cgroup=
 *cgrp)
>   */
>  __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>  {
> -       might_sleep();
> +       __cgroup_rstat_flush(cgrp, true);
> +}
>
> -       __cgroup_rstat_lock(cgrp, -1);
> -       cgroup_rstat_flush_locked(cgrp);
> -       __cgroup_rstat_unlock(cgrp, -1);
> +int cgroup_rstat_flush_relaxed(struct cgroup *cgrp, bool wait_for_flush)
> +{
> +       bool flushed =3D __cgroup_rstat_flush(cgrp, false);
> +
> +       if (!flushed && wait_for_flush) {

Isn't the code below essentially open-coding completions in a less
efficient way? Anyway as I mentioned above I don't believe we really
need wait_for_flush for now. I was hoping we can make this work for
both in-kernel and userspace flushers, but I don't think we want to
add it just for userspace flushers.

> +               /*
> +                * Reaching here we know an ongoing flusher is running, t=
hat
> +                * will take care of flushing for us, but for caller to r=
ead
> +                * accurate stats we want to wait for this ongoing flushe=
r.
> +                *
> +                * TODO: When lock becomes mutex and no-yielding this cod=
e can
> +                * be simplifed as we can just sleep on the mutex lock.
> +                */
> +               struct task_struct *id, *cur_id;
> +               u64 timeout;
> +
> +               id =3D READ_ONCE(cgrp_rstat_ongoing_flusher_ID);
> +               timeout =3D jiffies_64 + msecs_to_jiffies(50);
> +
> +               if (!id)
> +                       return false;
> +
> +               cond_resched();
> +               /* We might get lucky and flush already completed */
> +               cur_id =3D READ_ONCE(cgrp_rstat_ongoing_flusher_ID);
> +
> +               /* Due to lock yield, make sure "id" flusher completes */
> +               while (cur_id =3D=3D id && time_before64(jiffies_64, time=
out)) {
> +                       cond_resched();
> +                       /* Use mutex to reduce stress on global lock */
> +                       mutex_lock(&cgrp_rstat_ongoing_flusher_serialize)=
;
> +                       __cgroup_rstat_lock(cgrp, -1);
> +                       /* Get lock with ongoing can happen due to yieldi=
ng */
> +                       cur_id =3D READ_ONCE(cgrp_rstat_ongoing_flusher_I=
D);
> +                       __cgroup_rstat_unlock(cgrp, -1);
> +                       mutex_unlock(&cgrp_rstat_ongoing_flusher_serializ=
e);
> +               }
> +       }
> +
> +       return flushed;
>  }
>
>  /**
> @@ -368,8 +484,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>         __acquires(&cgroup_rstat_lock)
>  {
>         might_sleep();
> -       __cgroup_rstat_lock(cgrp, -1);
> -       cgroup_rstat_flush_locked(cgrp);
> +
> +       if (cgroup_rstat_trylock_flusher(cgrp, false))
> +               cgroup_rstat_flush_locked(cgrp);
> +       else
> +               __cgroup_rstat_lock(cgrp, -1);
>  }
>
>  /**
> @@ -379,7 +498,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  void cgroup_rstat_flush_release(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock)
>  {
> -       __cgroup_rstat_unlock(cgrp, -1);
> +       cgroup_rstat_unlock_flusher(cgrp);
>  }
>
>  int cgroup_rstat_init(struct cgroup *cgrp)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 71fe2a95b8bd..6694f7a859b5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -871,12 +871,26 @@ static inline void memcg_rstat_updated(struct mem_c=
group *memcg, int val)
>         }
>  }
>
> -static void do_flush_stats(struct mem_cgroup *memcg)
> +static void do_flush_stats(struct mem_cgroup *memcg, bool wait_for_flush=
)
>  {
> -       if (mem_cgroup_is_root(memcg))
> -               WRITE_ONCE(flush_last_time, jiffies_64);
> +       bool flushed =3D cgroup_rstat_flush_relaxed(memcg->css.cgroup,
> +                                                 wait_for_flush);
>
> -       cgroup_rstat_flush(memcg->css.cgroup);
> +       if (mem_cgroup_is_root(memcg) && flushed)
> +                   WRITE_ONCE(flush_last_time, jiffies_64);
> +}
> +
> +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg,
> +                                    bool wait_for_flush)
> +{
> +       if (mem_cgroup_disabled())
> +               return;
> +
> +       if (!memcg)
> +               memcg =3D root_mem_cgroup;
> +
> +       if (memcg_vmstats_needs_flush(memcg->vmstats))
> +               do_flush_stats(memcg, wait_for_flush);
>  }
>
>  /*
> @@ -890,21 +904,19 @@ static void do_flush_stats(struct mem_cgroup *memcg=
)
>   */
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
> -       if (mem_cgroup_disabled())
> -               return;
> -
> -       if (!memcg)
> -               memcg =3D root_mem_cgroup;
> +       __mem_cgroup_flush_stats(memcg, true);
> +}
>
> -       if (memcg_vmstats_needs_flush(memcg->vmstats))
> -               do_flush_stats(memcg);
> +void mem_cgroup_flush_stats_relaxed(struct mem_cgroup *memcg)
> +{
> +       __mem_cgroup_flush_stats(memcg, false);
>  }
>
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
>  {
>         /* Only flush if the periodic flusher is one full cycle late */
>         if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH=
_TIME))
> -               mem_cgroup_flush_stats(memcg);
> +               mem_cgroup_flush_stats_relaxed(memcg);

mem_cgroup_flush_stats_ratelimited() now basically says: only flush if
the periodic flusher is late but no one else is flushing, if we end up
pursuing this we probably want to start documenting these variants.

