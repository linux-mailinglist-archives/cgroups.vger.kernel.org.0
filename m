Return-Path: <cgroups+bounces-4296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1899528BC
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666D1B24E8D
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A06F2E6;
	Thu, 15 Aug 2024 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0EawjGD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53D57CA7
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698328; cv=none; b=n05eWjbyGGnOysuMPCjT6mz0MeCHw4S5ckdTll41iYr1Pxusb/99jKQ9SM+6VTcta3RfBm+OwCpEsGaKTrZA+INjFYIlBUj4vP94dagxoROoPRraXT36vqvr/TgMJNgyWVQygPbuYc8VyqwpyoKkOkSPfSzTZG/x4LdjBk4I5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698328; c=relaxed/simple;
	bh=YjyNRBfRvsIfxkoS9movRcwOA5hrKhw+ASGSZvMydG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdvA2bYhNpB8zspP8P4aKEG0zFY6UCZ2lSLH1xjFp6Tvbf/1/VWMM5bfRjv74ooMyoAzG8U7DCLXcxJ/0xGbfGt5U9QBPWYaoaOMRKYdLox73OEdR7pJoQf38jTGl660krtNbnxgC+WwB/BiDjBCrsPKXrX8Z9YkmkSwnyDU7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0EawjGD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kd/o0yNhsTl6XgkxdFjWyNP+hd5ZpFtgpy4OdScm7c=;
	b=X0EawjGDGBt0x9QlW3FR9g3CeR2jLvJN8b92rhYl0C8WSp8MKMgYF8pjXvM+UazgUhT92s
	7sLOcrK9t6peoDGdE7HiOQtlxG83UkRbwLpUgeCDl9mkGc0cWuKmJtSd96jllCUoH5ISwe
	0Vf/bgMX7pYM3B6MiFwezeZns1BD21c=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 2/7] memcg: move mem_cgroup_event_ratelimit to v1 code
Date: Wed, 14 Aug 2024 22:04:48 -0700
Message-ID: <20240815050453.1298138-3-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are no callers of mem_cgroup_event_ratelimit() in the v2 code.
Move it to v1 only code and rename it to memcg1_event_ratelimit().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol-v1.c | 32 ++++++++++++++++++++++++++++++--
 mm/memcontrol-v1.h |  2 --
 mm/memcontrol.c    | 28 ----------------------------
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 52aecdae2c28..0ce1807ba468 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1439,6 +1439,34 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
 	}
 }
 
+#define THRESHOLDS_EVENTS_TARGET 128
+#define SOFTLIMIT_EVENTS_TARGET 1024
+
+static bool memcg1_event_ratelimit(struct mem_cgroup *memcg,
+				enum mem_cgroup_events_target target)
+{
+	unsigned long val, next;
+
+	val = __this_cpu_read(memcg->events_percpu->nr_page_events);
+	next = __this_cpu_read(memcg->events_percpu->targets[target]);
+	/* from time_after() in jiffies.h */
+	if ((long)(next - val) < 0) {
+		switch (target) {
+		case MEM_CGROUP_TARGET_THRESH:
+			next = val + THRESHOLDS_EVENTS_TARGET;
+			break;
+		case MEM_CGROUP_TARGET_SOFTLIMIT:
+			next = val + SOFTLIMIT_EVENTS_TARGET;
+			break;
+		default:
+			break;
+		}
+		__this_cpu_write(memcg->events_percpu->targets[target], next);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Check events in order.
  *
@@ -1449,11 +1477,11 @@ void memcg1_check_events(struct mem_cgroup *memcg, int nid)
 		return;
 
 	/* threshold event is triggered in finer grain than soft limit */
-	if (unlikely(mem_cgroup_event_ratelimit(memcg,
+	if (unlikely(memcg1_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
 		bool do_softlimit;
 
-		do_softlimit = mem_cgroup_event_ratelimit(memcg,
+		do_softlimit = memcg1_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 8feccecf8e2a..fb7d439f19de 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -62,8 +62,6 @@ struct memcg1_events_percpu {
 	unsigned long targets[MEM_CGROUP_NTARGETS];
 };
 
-bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
-				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
 void drain_all_stock(struct mem_cgroup *root_memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 66d60bb56f91..7ea511119567 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,9 +95,6 @@ static bool cgroup_memory_nobpf __ro_after_init;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
-#define THRESHOLDS_EVENTS_TARGET 128
-#define SOFTLIMIT_EVENTS_TARGET 1024
-
 static inline bool task_is_dying(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
@@ -864,31 +861,6 @@ void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
 	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_pages);
 }
 
-bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
-				enum mem_cgroup_events_target target)
-{
-	unsigned long val, next;
-
-	val = __this_cpu_read(memcg->events_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->events_percpu->targets[target]);
-	/* from time_after() in jiffies.h */
-	if ((long)(next - val) < 0) {
-		switch (target) {
-		case MEM_CGROUP_TARGET_THRESH:
-			next = val + THRESHOLDS_EVENTS_TARGET;
-			break;
-		case MEM_CGROUP_TARGET_SOFTLIMIT:
-			next = val + SOFTLIMIT_EVENTS_TARGET;
-			break;
-		default:
-			break;
-		}
-		__this_cpu_write(memcg->events_percpu->targets[target], next);
-		return true;
-	}
-	return false;
-}
-
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
-- 
2.43.5


