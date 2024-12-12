Return-Path: <cgroups+bounces-5872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42359EFCE5
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 21:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9540B286E97
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4071917D6;
	Thu, 12 Dec 2024 20:00:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C118732A;
	Thu, 12 Dec 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033656; cv=none; b=VqVgvLQljxGWlfZOjPVMb7Ie4Hsu08f5y38AQ0kqsJQ2kLfmk6rRerHfd7VING8vXmzTAyzUm/+AHhjkaxV3eF+gBZUVzDtQlZCLlG3BbYMILHwAKJYNUvDdHyyzwcl7+pQNjPFmQUUkQ4RXtkByiAyFCNnCZgDZqh8VbW0nMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033656; c=relaxed/simple;
	bh=C6FWikZm72Ancdbls6hbPHy08YLRfdVq4svvr1jLri8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WILMFxGDO8ImnvguArpf6jA9DwZVWIkDnrwdUDy/Nhpvg9mROxz/VCOsAjrTlQLviVTncEFi6aaVmUElvjl2qUPFRK08vWbf1JUNnjxFYaXX3QSPWVyZtsGXv+NjrKGQC6XZZT3jG/UeuiQvPxEmOdY//s9mh4GuxOfVfkQReZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLpLv-000000000vW-3YTZ;
	Thu, 12 Dec 2024 15:00:03 -0500
Date: Thu, 12 Dec 2024 15:00:03 -0500
From: Rik van Riel <riel@surriel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 hakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to
 swap
Message-ID: <20241212150003.1a0ed845@fangorn>
In-Reply-To: <Z1ssHQYI-Wyc1adP@google.com>
References: <20241212115754.38f798b3@fangorn>
	<Z1ssHQYI-Wyc1adP@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: riel@surriel.com

On Thu, 12 Dec 2024 18:31:57 +0000
Roman Gushchin <roman.gushchin@linux.dev> wrote:

> Is it about a single task or groups of tasks or the entire cgroup?
> If former, why it's a problem? A tight memcg limit can slow things down
> in general and I don't see why we should treat the exit() path differentl=
y.
>=20
I think the exit path does need to be treated a little differently,
since this exit may be the only way such a cgroup can free up memory.

> If it's about the entire cgroup and we have essentially a deadlock,
> I feel like we need to look into the oom reaper side.

You mean something like the below?

I have not tested it yet, because we don't have any stuck
cgroups right now among the workloads that I'm monitoring.

---8<---

=46rom c0e545fd45bd3ee24cd79b3d3e9b375e968ef460 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Thu, 12 Dec 2024 14:50:49 -0500
Subject: [PATCH] memcg,oom: speed up reclaim for exiting tasks

When a memcg reaches its memory limit, and reclaim becomes unavailable
or slow for some reason, for example only zswap is available, but zswap
writeback is disabled, it can take a long time for tasks to exit, and
for the cgroup to get back to normal (or cleaned up).

Speed up memcg reclaim for exiting tasks by limiting how much work
reclaim does, and by invoking the OOM reaper if reclaim does not
free up enough memory to allow the task to make progress.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/oom.h |  8 ++++++++
 mm/memcontrol.c     | 11 +++++++++++
 mm/oom_kill.c       |  6 +-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..b2d9cf936664 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -111,4 +111,12 @@ extern void oom_killer_enable(void);
=20
 extern struct task_struct *find_lock_task_mm(struct task_struct *p);
=20
+#ifdef CONFIG_MMU
+extern void queue_oom_reaper(struct task_struct *tsk);
+#else
+static intern void queue_oom_reaper(struct task_struct *tsk)
+{
+}
+#endif
+
 #endif /* _INCLUDE_LINUX_OOM_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..21f42758d430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2231,6 +2231,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t =
gfp_mask,
 	if (!gfpflags_allow_blocking(gfp_mask))
 		goto nomem;
=20
+	if (unlikely(current->flags & PF_EXITING))
+		gfp_mask |=3D __GFP_NORETRY;
+
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
 	raised_max_event =3D true;
=20
@@ -2284,6 +2287,14 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t=
 gfp_mask,
 		goto retry;
 	}
 nomem:
+	/*
+	 * We ran out of memory while inside exit. Maybe the OOM
+	 * reaper can help reduce cgroup memory use and get things
+	 * moving again?
+	 */
+	if (unlikely(current->flags & PF_EXITING))
+		queue_oom_reaper(current);
+
 	/*
 	 * Memcg doesn't have a dedicated reserve for atomic
 	 * allocations. But like the global atomic pool, we need to
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1c485beb0b93..8d5278e45c63 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -686,7 +686,7 @@ static void wake_oom_reaper(struct timer_list *timer)
  * before the exit path is able to wake the futex waiters.
  */
 #define OOM_REAPER_DELAY (2*HZ)
-static void queue_oom_reaper(struct task_struct *tsk)
+void queue_oom_reaper(struct task_struct *tsk)
 {
 	/* mm is already queued? */
 	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
@@ -735,10 +735,6 @@ static int __init oom_init(void)
 	return 0;
 }
 subsys_initcall(oom_init)
-#else
-static inline void queue_oom_reaper(struct task_struct *tsk)
-{
-}
 #endif /* CONFIG_MMU */
=20
 /**
--=20
2.47.0


