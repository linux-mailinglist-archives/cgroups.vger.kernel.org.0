Return-Path: <cgroups+bounces-10682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E266BD6223
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED7D18A64E2
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B330BB91;
	Mon, 13 Oct 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmNLj/57"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FE2FE59F;
	Mon, 13 Oct 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387637; cv=none; b=kUUBIIuS/Spx6s87BvpCN93GbFWWxEcJ3ej+/gJ5emxS5RF3Kc4Tclw/lEo+KhElzc7nIdtvK+XbIolU2rQ4pp9XUsqBfLMyhOWXPl/8CTMc+WUs315JnkKnQ5b2thDqF8gjc38u4lSpdKw7PXov8lz6h4ZXR97mBohVvy0j+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387637; c=relaxed/simple;
	bh=9w9KiM/XU5k7xFjzwkTNeoZAiAzOP0fQ9W37e2QyvME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF0nCvZt6JdkOcrZn0rDHg0Ub4pvCBfuCyijxC22cuTsNnw5pmDgGm6Ob+crfWXjGcBUSX2u9eTpWHKMqMH2EllyCa3/l8eNF/j9BPPzIwY39v9Q3zkiemDHKsQ/h3sR9X4W0sKZ0PgCJ+5P0eVm2hoJfisjkBSNi+7E6tEGfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmNLj/57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A27C4CEF8;
	Mon, 13 Oct 2025 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387637;
	bh=9w9KiM/XU5k7xFjzwkTNeoZAiAzOP0fQ9W37e2QyvME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmNLj/575P8R9C/Tos8QKO8qINbfYPqKweF8y9NhDYbJaZ+5jadfKFAc+rLxgfUup
	 dUukeeCFad56TOrldk6Pyv5FB7Yib5oAFO6Oh+GpsoH5YTMif3zLX9QI3nrys+9Qxu
	 YI6y7FSDOQhvhl/BwxSZQGkjCvTwSoxUK9shUsKldgjOfh/6u/XmAYh/vLJa/pm+ad
	 +M/kiyWLN2KLfgpcqgBOzNf6g2Jz30nfxJo6oZKx2ju0jpStVAdF+RHNcTBckgDvg/
	 NJOw2T6qEqqICHSulF65mxm17kqfi/WfNxN+jo8ytmR8ZcpKkI/8i0v1+N8PdJ3EVO
	 Z/RzqZx4g8l7Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 15/33] sched/isolation: Flush vmstat workqueues on cpuset isolated partition change
Date: Mon, 13 Oct 2025 22:31:28 +0200
Message-ID: <20251013203146.10162-16-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime.
In order to synchronize against vmstat workqueue to make sure
that no asynchronous vmstat work is still pending or executing on a
newly made isolated CPU, the housekeeping susbsystem must flush the
vmstat workqueues.

This involves flushing the whole mm_percpu_wq workqueue, shared with
LRU drain, introducing here a welcome side effect.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/vmstat.h   | 2 ++
 kernel/sched/isolation.c | 1 +
 kernel/sched/sched.h     | 1 +
 mm/vmstat.c              | 5 +++++
 4 files changed, 9 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index c287998908bf..a81aa5635b47 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -303,6 +303,7 @@ int calculate_pressure_threshold(struct zone *zone);
 int calculate_normal_threshold(struct zone *zone);
 void set_pgdat_percpu_threshold(pg_data_t *pgdat,
 				int (*calculate_pressure)(struct zone *));
+void vmstat_flush_workqueue(void);
 #else /* CONFIG_SMP */
 
 /*
@@ -403,6 +404,7 @@ static inline void __dec_node_page_state(struct page *page,
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
 static inline void quiet_vmstat(void) { }
+static inline void vmstat_flush_workqueue(void) { }
 
 static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_zonestat *pzstats) { }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9ec365dea921..5cd3d98a2663 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -145,6 +145,7 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 	synchronize_rcu();
 
 	mem_cgroup_flush_workqueue();
+	vmstat_flush_workqueue();
 
 	kfree(old);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8bfc0b4b133f..84525885a3de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -68,6 +68,7 @@
 #include <linux/types.h>
 #include <linux/u64_stats_sync_api.h>
 #include <linux/uaccess.h>
+#include <linux/vmstat.h>
 #include <linux/wait_api.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7afb2981501f..506d3ca2e47f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2115,6 +2115,11 @@ static void vmstat_shepherd(struct work_struct *w);
 
 static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
 
+void vmstat_flush_workqueue(void)
+{
+	flush_workqueue(mm_percpu_wq);
+}
+
 static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
-- 
2.51.0


