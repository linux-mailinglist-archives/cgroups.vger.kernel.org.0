Return-Path: <cgroups+bounces-3303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D01914AF3
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0863A1F24EEA
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70613D523;
	Mon, 24 Jun 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXwCuWIO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928B1E4A9
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233206; cv=none; b=YdYsj/oOeGi0ajHFO2pqulZhtnZ+0Y0ubcmrM0PDm3UgrK77dnhNWkUmtfFWnuOG5INSkQSWZDY3Eut7S4a+VZ6b9zNUb7DHMRafig7tOoAPEruMrHsxDpKWlYCwJZg3hiOweYGNtRqGjW2+Zn/q6q65QiBLwAGDJ35p7eJzPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233206; c=relaxed/simple;
	bh=0V2TJHY9gX4GyB5yEeOFhrJl8da0tP8XJhTsVv56rHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZVvSQI01MQL6tf8wPuoPLZ8PsZLyUkWAPNH3d/3S30DRGS9QkzWC84W3IRDkrTpyml60hlKvcBfxOq+NuNSnH5Z4aSSLNYu1LKu6KMdJeVubOFjHktxDZzkSL26x2v69K1jxJpetU7dGj6fqbB/bra/5FupNKFECrki4BK2FY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXwCuWIO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so8550250a12.0
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719233203; x=1719838003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok/L+qsaLydWCAvp7RmGLtdoqWXMsaAGOBxzFb7HiAY=;
        b=LXwCuWIOIgnoIvNhyglAK/nMEAQM3RfBFoTfSD/iwGqP5BtkXMT6V8ka+uaRrU5I9o
         +1exHQ5ENsbF0tKBLb2r5HMIHTFJQwww/mH9tylmvlrAy6nr8WCJ2aX63GTG7YVVW2GM
         vptS81C2wzTsMIj8hw50okMqqAzNuSI1u07cSH8l0X2+ggXYo0ZdO/a+eqCrGMQSoU3l
         Vx7oQ1dDtXI8fAawZuCdhs9zSa/LUajm/EuSt1cFTA0/KKT1nutduAiGmm0xecZjuYAZ
         PSA26d0x0N3pKsdkN5llE/uIm9lxKHjc0j/fxxjpqnEqEmHGYk1zpLjJYg9t/RF/GWVY
         fljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233203; x=1719838003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok/L+qsaLydWCAvp7RmGLtdoqWXMsaAGOBxzFb7HiAY=;
        b=iN4lXTn1LQ38Nmj+qj9HJSKirusCcHOzpby5FrbA1y5uRlTmJacE2MQhJVWzJY9Mnm
         PTrg8XoLrfQcaueFgwIw2yXnZHhJUSdyaIbBmO0c+mjohPFF1UrQYbkTILV0cJFV525m
         2ohsb+c6ph8Up4MJNWyV/ObdvMv6QiqaYoR6ywMCM2MgVKlvLttbOWtE557T0S+xMNXw
         I76F7BNv6xucUBpGq1yvhxWsU17iBNVQE5czJVmgPD7NdFuR3vUdFNWA208TH6edOQyv
         oYRhlzSjyogxJWJRNAd6RawQmsWztl8MH7ZyF4XeGJb5F3pFf7lrzXNRXIWHKi/etoIo
         B2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUFlzH7xiHA2fbTQEvwnuAaPsUma2J4EIAcjoUQkO10t+iesWZ97smuscgdziSXYdc6xj/WqpmuRmlFhC9Zt93dvbNevdmtQg==
X-Gm-Message-State: AOJu0Yx0uu7Jd9Fw2f33sw0uxi/+nwOtsHmfIEvEUePkCB40sphuMXHE
	VfcN81k4O4hNhLTvbmbw2NlMaB4VPgiLLz8l0cErTaC7o+2iE8n4TxWgJDsRNiZ8FeZhakB4COQ
	BUNmBkuv4rg8L1CL1uG5UZIdd0dksqopOhx9f
X-Google-Smtp-Source: AGHT+IHuyeA4mdFUDWcWZKcP0BDWsHVxB+XqBMp+KhF/Y8CrEqvVvO6dlvDLHOe5mhsSuFkDFseTix+/TpNAlSbOzEo=
X-Received: by 2002:a17:906:bf48:b0:a72:5d7f:dd4a with SMTP id
 a640c23a62f3a-a725d7fdddemr116449566b.25.1719233202070; Mon, 24 Jun 2024
 05:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
In-Reply-To: <171923011608.1500238.3591002573732683639.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 05:46:05 -0700
Message-ID: <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:55=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
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
> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
> empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
> kswapdN threads to wake up simultaneously. The kswapd thread invokes
> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously.
> Leveraging this detail: balance_pgdat() have NULL value in
> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
> root_mem_cgroup.
>
> To resolve the kswapd issue, we generalized the "stats_flush_ongoing"
> concept to apply to all users of cgroup rstat, not just memcg. This
> concept was originally reverted in commit 7d7ef0a4686a ("mm: memcg:
> restore subtree stats flushing"). If there is an ongoing rstat flush,
> limited to the root cgroup, the flush is skipped. This is effective as
> kswapd operates on the root tree, sufficiently mitigating the thundering
> herd problem.
>
> This lowers contention on the global rstat lock, although limited to the
> root cgroup. Flushing cgroup subtree's can still lead to lock contention.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519=
.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252=
.stgit@firesoul/
>
>  include/linux/cgroup.h |    5 +++++
>  kernel/cgroup/rstat.c  |   25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..ad41cca5c3b6 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -499,6 +499,11 @@ static inline struct cgroup *cgroup_parent(struct cg=
roup *cgrp)
>         return NULL;
>  }
>
> +static inline bool cgroup_is_root(struct cgroup *cgrp)
> +{
> +       return cgroup_parent(cgrp) =3D=3D NULL;
> +}
> +
>  /**
>   * cgroup_is_descendant - test ancestry
>   * @cgrp: the cgroup to be tested
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..2591840b6dc1 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -11,6 +11,7 @@
>
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static atomic_t root_rstat_flush_ongoing =3D ATOMIC_INIT(0);
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>
> @@ -350,8 +351,25 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *c=
grp)
>  {
>         might_sleep();
>
> +       /*
> +        * This avoids thundering herd problem on global rstat lock. When=
 an
> +        * ongoing flush of the entire tree is in progress, then skip flu=
sh.
> +        */
> +       if (atomic_read(&root_rstat_flush_ongoing))
> +               return;
> +
> +       /* Grab right to be ongoing flusher, return if loosing race */
> +       if (cgroup_is_root(cgrp) &&
> +           atomic_xchg(&root_rstat_flush_ongoing, 1))
> +               return;
> +

I am assuming this supersedes your other patch titled "[PATCH RFC]
cgroup/rstat: avoid thundering herd problem on root cgrp", so I will
only respond here.

I have two comments:
- There is no reason why this should be limited to the root cgroup. We
can keep track of the cgroup being flushed, and use
cgroup_is_descendant() to find out if the cgroup we want to flush is a
descendant of it. We can use a pointer and cmpxchg primitives instead
of the atomic here IIUC.

- More importantly, I am not a fan of skipping the flush if there is
an ongoing one. For all we know, the ongoing flush could have just
started and the stats have not been flushed yet. This is another
example of non deterministic behavior that could be difficult to
debug.

I tried a similar approach before where we sleep and wait for the
ongoing flush to complete instead, without contending on the lock,
using completions [1]. Although that patch has a lot of complexity, I
think just using completions to wait for the ongoing flush may be the
right way to go, assuming it also helps with the problem you are
facing.

[1]https://lore.kernel.org/lkml/20230913073846.1528938-4-yosryahmed@google.=
com/

>         __cgroup_rstat_lock(cgrp, -1);
> +
>         cgroup_rstat_flush_locked(cgrp);
> +
> +       if (cgroup_is_root(cgrp))
> +               atomic_set(&root_rstat_flush_ongoing, 0);
> +
>         __cgroup_rstat_unlock(cgrp, -1);
>  }
>
> @@ -362,13 +380,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *=
cgrp)
>   * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
>   * paired with cgroup_rstat_flush_release().
>   *
> + * Current invariant, not called with root cgrp.
> + *
>   * This function may block.
>   */
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>         __acquires(&cgroup_rstat_lock)
>  {
>         might_sleep();
> +
>         __cgroup_rstat_lock(cgrp, -1);
> +
> +       if (atomic_read(&root_rstat_flush_ongoing))
> +               return;
> +
>         cgroup_rstat_flush_locked(cgrp);
>  }
>
>
>

