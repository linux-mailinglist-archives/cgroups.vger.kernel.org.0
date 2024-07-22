Return-Path: <cgroups+bounces-3843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2809392EF
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55F2281A9C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E716EB41;
	Mon, 22 Jul 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGfoKzZH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656416DC36
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667821; cv=none; b=YR1doqYxqwnLaOYhIy9xE9fC6UJ+ORDS8RMPkogfxkGl9N1X3xjkc/7vTH+A5incKEn9wPVQHdzMTpZjlviLZBwDYRSDUN9i+HMJCvyZNc2PtlDDGPtS3Kg2nW672VZVsLl2ADtzcHFfErSh6mQZlzvxInG92JVLsj14069+q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667821; c=relaxed/simple;
	bh=pWvy3JdRnH+if4qTEyaxFaAvLZujA23cuF5I0FRU138=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US+lBr33hhQpNyOT6V6ONRNajfGCBzY5DISNSnpJ9LjkSdlAlPCZ0mB49w68uA3cvGCmHhLYmwS1wfcsrfBI6pkHNKk8H4MyBYKJr9bh2xigcgjablvO1+oIbztBFNSv6tpU38ur0o3taJQCrxHJvivIAVpVtzxZ23LxHQK8L7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGfoKzZH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a79f9a72a99so987163466b.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721667818; x=1722272618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbfWvp9bRUygXfQ1AuZRcm8ZUwrv50CWtS6Lj5Lx694=;
        b=jGfoKzZHtYZ1QavPjohF/7T1+YpIAz2fl9BDabmv9Wj1FWngNKGzq9mkPOT856ndzR
         FgzxMh0MMIoASYlvp6VUKWjuURTB1eGHfFORhvFbXm0k2H0l5WPrSpc5EIOazgAJOJos
         wbj4wtLiYufpXHwme14paC3HRANdoRHy0yPclTDI+McitoHiHtcSg6n5+yYToWWZxSZu
         ueqvIU1u2QEDOMExd/y2/E7FZUs19hu+Cq2XDok/b1QEhSbIV35lGLlD2AfQX5/vQQe3
         1zy7pWMPVJL843sehps7AJ6sA//9FQfcHPmHSxKIsDdxdRitdXrjjBhX5/mijAAGo9xK
         2F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667818; x=1722272618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbfWvp9bRUygXfQ1AuZRcm8ZUwrv50CWtS6Lj5Lx694=;
        b=R8NCiMIGOrEAx3NgE24yPru7emoqDnh98hArDLoHjeb6lRrV2fVKGGDabFFi2vT300
         87RF4to3U6UQs9nNVyAsJ7vz8fRA2xQyzjkrUB9dCrLP0eHANHoKk/vu06WSPWhhxTcn
         fKRu6cACZbc73Wn30OQJyNo77nAY16f1M2Dnytw/V/6VOLmoaV2YFYV0aXPg518u9dz4
         oP/g6U08Z3RPS3A+LtNK3zvvCj6ChowUJmz+BwdphylCjOwoEqEPaflACg0+YNTDCxwW
         thnhTfNRIwz6ZpWbCNieHPIj7txutdwu8ffhnHq2h7QqPodgXW+aEbBIPKqUQLEUtJS7
         QJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdP+R0ATl9C3CArRxTIutYMIirkGJ7SC/aDGBCDO/tVIFacUTUqJKLwMxsrYYdqHRoN1rfGOWVHkHQ0QQo56wW/fszBGjSmw==
X-Gm-Message-State: AOJu0YwGY62MEk5TKpp1htqx27CEv+CC3rP76zgQU1mwXeFUuSaLbMZ9
	hxNbtp1GpmRX9sITScK0Iy80yVsx9r79zUqLh2089VCaXHKZB5zNbRNAD6HGFOTHM+iQ90YrREz
	r4qZgkeba99U8j9wIDZbsPHO3rGJN4WlQNb5n
X-Google-Smtp-Source: AGHT+IGaTaf10DT2IV1A6F1EsqODUWScWS2k60cFwJziHr6WMeA2nifgXlfXDp/clvtOP/Q5CMJl4saLOwNag32jDI8=
X-Received: by 2002:a17:907:20f7:b0:a72:83ad:f087 with SMTP id
 a640c23a62f3a-a7a0f10fd08mr1447688566b.10.1721667817340; Mon, 22 Jul 2024
 10:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
In-Reply-To: <172139415725.3084888.13770938453137383953.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 10:02:59 -0700
Message-ID: <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 6:06=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> This patch reintroduces and generalizes the "stats_flush_ongoing" concept
> to avoid redundant flushes if there is an ongoing flush, addressing lock
> contention issues on the global cgroup rstat lock.
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
> If there is an ongoing rstat flush and the current cgroup is a descendant=
, a
> new flush is unnecessary. To ensure callers still receive updated stats,
> they wait for the ongoing flush to complete before returning, but with a
> timeout, as stats may already be inaccurate due to continuous updates.
>
> Lock yielding causes complications for ongoing flushers. Therefore, we li=
mit
> which cgroup can become ongoing flusher to top-level, as lock yielding
> allows others to obtain the lock without being the ongoing flusher, leadi=
ng
> to a situation where a cgroup that isn't a descendant obtains the lock vi=
a
> yielding. Thus, we prefer an ongoing flusher with many descendants. If an=
d
> when the lock yielding is removed, such as when changing this to a mutex,
> we can simplify this code.
>
> This change significantly reduces lock contention, especially in
> environments with multiple NUMA nodes, thereby improving overall system
> performance.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V8:
>  - Updated subject+desc based on Yosry's feedback
>  - Explain lock yielding challenges in comments
>  - Limit ongoing flushers to cgrp level 0 and 1
>
> V7: https://lore.kernel.org/all/172070450139.2992819.13210624094367257881=
.stgit@firesoul
> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.=
stgit@firesoul/
> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.=
stgit@firesoul/
> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077=
.stgit@firesoul/
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.=
stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.=
stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519=
.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252=
.stgit@firesoul/
>
>  include/linux/cgroup-defs.h |    2 +
>  kernel/cgroup/rstat.c       |  114 +++++++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 104 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..a33b37514c29 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -548,6 +548,8 @@ struct cgroup {
>  #ifdef CONFIG_BPF_SYSCALL
>         struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>  #endif
> +       /* completion queue for cgrp_rstat_ongoing_flusher */
> +       struct completion flush_done;
>
>         /* All ancestors including self */
>         struct cgroup *ancestors[];
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..eaa138f2da2f 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -2,6 +2,7 @@
>  #include "cgroup-internal.h"
>
>  #include <linux/sched/cputime.h>
> +#include <linux/completion.h>
>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> @@ -11,6 +12,7 @@
>
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static struct cgroup *cgrp_rstat_ongoing_flusher =3D NULL;
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>
> @@ -279,17 +281,32 @@ __bpf_hook_end();
>   * value -1 is used when obtaining the main lock else this is the CPU
>   * number processed last.
>   */
> -static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_l=
oop)
> +static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_i=
n_loop)
> +{
> +       bool locked;
> +
> +       locked =3D spin_trylock_irq(&cgroup_rstat_lock);
> +       if (!locked)
> +               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, true=
);
> +       else
> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, false);
> +
> +       return locked;
> +}
> +
> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_l=
oop,
> +                                      bool already_contended)
>         __acquires(&cgroup_rstat_lock)
>  {
> -       bool contended;
> +       bool locked =3D false;
>
> -       contended =3D !spin_trylock_irq(&cgroup_rstat_lock);
> -       if (contended) {
> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, cont=
ended);
> +       if (already_contended) /* Skip trylock if already contended */
> +               locked =3D __cgroup_rstat_trylock(cgrp, cpu_in_loop);

Should this be the other way around?

> +
> +       if (!locked) {
>                 spin_lock_irq(&cgroup_rstat_lock);
> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, true);
>         }
> -       trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>  }
>
>  static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in=
_loop)
> @@ -299,6 +316,72 @@ static inline void __cgroup_rstat_unlock(struct cgro=
up *cgrp, int cpu_in_loop)
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> +#define MAX_WAIT       msecs_to_jiffies(100)
> +/**
> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flu=
sher
> + * @cgrp: target cgroup
> + *
> + * Function return value follow trylock semantics. Returning true when l=
ock is
> + * obtained. Returning false when not locked and it detected flushing ca=
n be
> + * skipped as another ongoing flusher took care of the flush.
> + */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +       struct cgroup *ongoing;
> +       bool locked;
> +
> +       /*
> +        * Check if ongoing flusher is already taking care of this, if
> +        * we are a descendant skip work, but wait for ongoing flusher
> +        * to complete work.
> +        */
> +retry:
> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {

The discussion about cgrp_rstat_ongoing_flusher possibly going away in
parallel never reached a conclusion AFAICT. Should we use
cgroup_tryget() here to get a ref on 'ongoing' until wait completes?
This shouldn't add much complexity AFAICT.

I think just using RCU here wouldn't be enough as we can flush rstat
after the RCU grace period when a cgroup is being freed.

> +               wait_for_completion_interruptible_timeout(
> +                       &ongoing->flush_done, MAX_WAIT);
> +               /* TODO: Add tracepoint here */
> +               return false;
> +       }
> +
> +       locked =3D __cgroup_rstat_trylock(cgrp, -1);
> +       if (!locked) {
> +               /* Contended: Handle losing race for ongoing flusher */
> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
> +                       goto retry;
> +
> +               __cgroup_rstat_lock(cgrp, -1, true);
> +       }
> +       /*
> +        * Obtained lock, record this cgrp as the ongoing flusher.
> +        * Due to lock yielding, we might obtain lock while another
> +        * ongoing flusher (that isn't a parent) owns ongoing_flusher.
> +        */
> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (!ongoing) {

I think we don't need protection here since we never dereference
'cgrp_rstat_ongoing_flusher', but I think it may be clearer to
directly check it to make this obvious:

if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {

Perhaps we can also explicitly mention in the comment why we do not
need any protection here, but I am not sure how helpful that will be.

> +               /*
> +                * Limit to top-level as lock yielding allows others to o=
btain
> +                * lock without being ongoing_flusher. Leading to cgroup =
that
> +                * isn't descendant to obtain lock via yielding. So, pref=
er
> +                * ongoing_flusher with many descendants.
> +                */
> +               if (cgrp->level < 2) {

This covers roots and top-level cgroups under them, right? Did them
improve the numbers you were observing?

AFAICT, we can remove this restriction completely if/when we use a
mutex and support a single ongoing flusher. If so, let's explicitly
mention this, perhaps:

XXX: Remove this restriction if/when lock yielding is removed

> +                       reinit_completion(&cgrp->flush_done);
> +                       WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
> +               }
> +       }
> +       return true;
> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +       if (cgrp =3D=3D READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
> +               complete_all(&cgrp->flush_done);
> +       }
> +       __cgroup_rstat_unlock(cgrp, -1);
> +}
> +
>  /* see cgroup_rstat_flush() */
>  static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
> @@ -328,7 +411,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
>                         __cgroup_rstat_unlock(cgrp, cpu);
>                         if (!cond_resched())
>                                 cpu_relax();
> -                       __cgroup_rstat_lock(cgrp, cpu);
> +                       __cgroup_rstat_lock(cgrp, cpu, false);
>                 }
>         }
>  }
> @@ -350,9 +433,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *c=
grp)
>  {
>         might_sleep();
>
> -       __cgroup_rstat_lock(cgrp, -1);
> +       if (!cgroup_rstat_trylock_flusher(cgrp))
> +               return;
> +
>         cgroup_rstat_flush_locked(cgrp);
> -       __cgroup_rstat_unlock(cgrp, -1);
> +       cgroup_rstat_unlock_flusher(cgrp);
>  }
>
>  /**
> @@ -368,8 +453,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>         __acquires(&cgroup_rstat_lock)
>  {
>         might_sleep();
> -       __cgroup_rstat_lock(cgrp, -1);
> -       cgroup_rstat_flush_locked(cgrp);
> +
> +       if (cgroup_rstat_trylock_flusher(cgrp))
> +               cgroup_rstat_flush_locked(cgrp);
> +       else
> +               __cgroup_rstat_lock(cgrp, -1, true);
>  }
>
>  /**
> @@ -379,7 +467,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  void cgroup_rstat_flush_release(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock)
>  {
> -       __cgroup_rstat_unlock(cgrp, -1);
> +       cgroup_rstat_unlock_flusher(cgrp);
>  }
>
>  int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -401,6 +489,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>                 u64_stats_init(&rstatc->bsync);
>         }
>
> +       init_completion(&cgrp->flush_done);
> +
>         return 0;
>  }
>
>
>
>

