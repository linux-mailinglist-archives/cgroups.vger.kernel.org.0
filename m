Return-Path: <cgroups+bounces-3720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36749334B9
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 02:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EA51C22246
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CF63C;
	Wed, 17 Jul 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjfmfg5Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87D803
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176270; cv=none; b=ZAkORrTNmmK7Su5d7vlzKHRYCRLwtYehvjN6a5xo98v9DjZaYUej2icxe4/fSQ8yKO9bJfC4YL4gI/PLx0U7JdyuZiRnSwJXn4EAxHhDBhCHCc8woEH7Twn6F1EHWBffW5obIMxA8/3GrRb05Qd5s6Dh9Sr3m1DEEA6YnPPDZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176270; c=relaxed/simple;
	bh=roY1kwT1A22ce35XOeyObRFLMNgrsAqhIDUb5xqmNTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpzfJ7kV4jtrwom9o9PLFGOiK4alW/+Mr8iUcSjibnzsI1pDp8eU42VY3U02eAxzoqkFkugyBp6ZR2ZT1rs1661bPbj7zy4DS1I+oeFQeQSRIhOBFFYIu53qb85d2VDnlo5BVB8iZzF5Nd2e4FUsrv1IkT2hygdVEFezItuKQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjfmfg5Z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so6411186e87.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721176267; x=1721781067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4bwsrtlDHHMtKZGxfkYdtqrb5XDD2o5DixhixOo4gU=;
        b=vjfmfg5Zj5/uY298jlrOR16GwzVOBe2vH66Fgb26M1//C/AVHCc9HRcfwMTSiQbTrz
         T69Nr6YRQlBMAHCe9G9rxXoKtmujMArR28VZfB1KCPFUwQtRVDk5YjrKk0u4WxiYchPZ
         wEi9+nRZ0Sq81hadSUMiLLbKIcyhU/9485TXaB5wGGCogODJi84qgq6iodQ6b7Zumxhb
         rdkDFCo2t5w8d1oZnJmf+zZdc4iM8rZ5t/vxgTB9Pqh5z0dYJmGymhIymmIjHsV2fOQB
         2YZVIOpbKxBJpZSKJrj/OAGCglwa9wbnSXWpp0rGHDPrRi6WwH7b5F7q9NFJaORXuxgL
         L2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721176267; x=1721781067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4bwsrtlDHHMtKZGxfkYdtqrb5XDD2o5DixhixOo4gU=;
        b=oD1ukQ8T1Zs+2sY4XhZljtOMbke5/9U3f/59afI50XwHtYZfiPMUv4MJK+zV7BLfvH
         MYkHWHrfVfI5CiDA+Cb1uFn5s/AEp6NbDt0OBmfMs/TxTalFiZdEqFFT2Tl82K/Qf2CO
         kxHN6zM3dBPjy0DovaEXqyhTSSrH87UdLK1Nzx/8K2xKkoL7xSsI5Mo79NenJWeXUoVs
         3SWqoUcvMkzLHw2gSa8vTCrIrlMyfx1FzM9jGPKd3dQlHzgixMn6VPGDvtI0Ymcd0X09
         RgMob6Q5k38HPQxZe0/Qln0zl8C7xaga7jHAvq/mr/aBknX4UZIqifjXKXRYOQXPPV00
         gKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWa1NzNMnEU5we2fwt9oaOhdh4OZPGZu877v+xz+Pk6gIVdD7NcLuv80RUMmaQOc1cUltWpsWhFBrKp9qT2PrXBTC9uVez9Aw==
X-Gm-Message-State: AOJu0Yy9GdkvPX9M7M4xknY7vvRV5vpEVefGi8KI9MjVvPCnAIybkjuF
	7/TclanBLIXctGA4SxMl8QaUsJC0R9ZdVgl1YsWg6KcXk2SMfEP/T6vBQg9vQBtrR7ufmOPvgZw
	ypJOySkkdPveLUX196dol2O1OI1nS1AWFZQhvAlKg3sS2PP4l2A==
X-Google-Smtp-Source: AGHT+IFJm5p6IKAa3mU6ONozlPoYypzzzR92UyGaQvJEkEpub9FMJBzxYpvlKVYAVIcUsZf+eJzDbzuq8bxIvG1ImYk=
X-Received: by 2002:a05:6512:3a81:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52ee5445f73mr52423e87.58.1721176265812; Tue, 16 Jul 2024
 17:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
In-Reply-To: <172070450139.2992819.13210624094367257881.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 17:30:27 -0700
Message-ID: <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 6:28=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> Avoid lock contention on the global cgroup rstat lock caused by kswapd
> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> call inlined in shrink_node, which takes the rstat lock.
>
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> we noted severe lock contention on the rstat lock. This contention
> causes 12 CPUs to waste cycles spinning every time kswapd runs.
> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> due to spinning on the rstat lock.
>
> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
> causing all kswapdN threads to wake up simultaneously. The kswapd thread
> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously. Leveragin=
g
> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
>
> To avoid this kind of thundering herd problem, kernel previously had a
> "stats_flush_ongoing" concept, but this was removed as part of commit
> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
> reintroduce and generalized the concept to apply to all users of cgroup
> rstat, not just memcg.
>
> If there is an ongoing rstat flush, and current cgroup is a descendant,
> then it is unnecessary to do the flush. For callers to still see updated
> stats, wait for ongoing flusher to complete before returning, but add
> timeout as stats are already inaccurate given updaters keeps running.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks for working on this, Jesper! I love the data you collected here!

I think the commit subject and message should be changed to better
describe the patch. This is a patch that exclusively modifies cgroup
code, yet the subject is about kswapd. This change affects all users
of rstat flushing.

I think a better subject would be:
"cgroup/rstat: avoid flushing if there is an ongoing overlapping
flush" or similar.

The commit message should first describe the cgroup change, and then
use kswapd as a brief example/illustration of how the problem
manifests in practice. You should also include a brief summary of the
numbers you collected from prod.

> ---
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
>  kernel/cgroup/rstat.c       |   95 +++++++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 85 insertions(+), 12 deletions(-)
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
> index fb8b49437573..fe2a81a310bb 100644
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
> +                                      bool check_contention)
>         __acquires(&cgroup_rstat_lock)
>  {
> -       bool contended;
> +       bool locked =3D false;
>
> -       contended =3D !spin_trylock_irq(&cgroup_rstat_lock);
> -       if (contended) {
> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, cont=
ended);
> +       if (check_contention)
> +               locked =3D __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> +
> +       if (!locked) {
>                 spin_lock_irq(&cgroup_rstat_lock);
> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, check_conten=
tion);
>         }
> -       trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>  }

I will let Tejun and others weigh in about what tracepoints we should
have going forward and how they should be structured (which also
includes patch 2). I see the tremendous value they have to collect
data from prod, but I do not see similar existing tracepoints, and I
am not sure if the branching here could have an effect when the
tracepoints are off.

>
>  static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in=
_loop)
> @@ -299,6 +316,53 @@ static inline void __cgroup_rstat_unlock(struct cgro=
up *cgrp, int cpu_in_loop)
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> +#define MAX_WAIT       msecs_to_jiffies(100)
> +/* Trylock helper that also checks for on ongoing flusher */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +       struct cgroup *ongoing;
> +       bool locked;
> +
> +       /* Check if ongoing flusher is already taking care of this, if

nit: I think commonly the comment would start on a new line after /*.

> +        * we are a descendant skip work, but wait for ongoing flusher
> +        * to complete work.
> +        */
> +retry:
> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
> +               wait_for_completion_interruptible_timeout(
> +                       &ongoing->flush_done, MAX_WAIT);
> +               /* TODO: Add tracepoint here */
> +               return false;
> +       }
> +
> +       locked =3D __cgroup_rstat_trylock(cgrp, -1);
> +       if (!locked) {
> +               /* Contended: Handle loosing race for ongoing flusher */

nit: losing

> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
> +                       goto retry;
> +
> +               __cgroup_rstat_lock(cgrp, -1, false);
> +       }
> +       /* Obtained lock, record this cgrp as the ongoing flusher */

Do we want a comment here to explain why there could be an existing
ongoing flusher (i.e. due to multiple ongoing flushers)? I think it's
not super obvious.

> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (!ongoing) {
> +               reinit_completion(&cgrp->flush_done);
> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
> +       }
> +       return true; /* locked */

Would it be better to explain the return value of the function in the
comment above it?

> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +       /* Detect if we are the ongoing flusher */

I think this is a bit obvious.

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
> @@ -328,7 +392,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
>                         __cgroup_rstat_unlock(cgrp, cpu);
>                         if (!cond_resched())
>                                 cpu_relax();
> -                       __cgroup_rstat_lock(cgrp, cpu);
> +                       __cgroup_rstat_lock(cgrp, cpu, true);
>                 }
>         }
>  }
> @@ -350,9 +414,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *c=
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
> @@ -368,8 +434,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>         __acquires(&cgroup_rstat_lock)
>  {
>         might_sleep();
> -       __cgroup_rstat_lock(cgrp, -1);
> -       cgroup_rstat_flush_locked(cgrp);
> +
> +       if (cgroup_rstat_trylock_flusher(cgrp))
> +               cgroup_rstat_flush_locked(cgrp);
> +       else
> +               __cgroup_rstat_lock(cgrp, -1, false);
>  }
>
>  /**
> @@ -379,7 +448,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  void cgroup_rstat_flush_release(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock)
>  {
> -       __cgroup_rstat_unlock(cgrp, -1);
> +       cgroup_rstat_unlock_flusher(cgrp);
>  }
>
>  int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -401,6 +470,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
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

