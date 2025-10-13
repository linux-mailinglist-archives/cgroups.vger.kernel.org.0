Return-Path: <cgroups+bounces-10683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BABD622C
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281F3188C26D
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04D30B522;
	Mon, 13 Oct 2025 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoVNEAS3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F82EA743;
	Mon, 13 Oct 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387646; cv=none; b=HYD6VjbgxzkPIw4t2g0sPpCFx3vlSXGx+VwxXNrZq76yynwZHXsS2OxekcY0BFw9+ZlXdvzJHGK/dUwr4VcwQ1jH83/r1MycTmOZZ5XxeMARxoLwrvsHnUbqkW+As0Gwk8HnBBW7dUniy2K51WaE3oMm0Ynm1L6P8YvKZ5bhRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387646; c=relaxed/simple;
	bh=o4l8LMgsNHHUM0/Jh25qtae1vINpxJpXhs+PkYrtNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nql+wVwXCuUHjCcc80GmmwJvJUBP/4fSVepqrEw+lYRjawW9hemx0j5X89/RRFMDmtJ4Z9mjO5Yxs/wTBop3tV+bMGPqkZDsZyFhnzRSMjhrTlyY6VQQdtYUQl0K/yWLr68YbJUt5WCgoLYoqRMkmPTTm5TMJDWGCVctDpPH6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoVNEAS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5955C4CEE7;
	Mon, 13 Oct 2025 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387644;
	bh=o4l8LMgsNHHUM0/Jh25qtae1vINpxJpXhs+PkYrtNTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoVNEAS36xD6hmGovDKl25N4XYXfuPH2mDvvfnGysV1HjcwGw8klL7ELr4gHa81GU
	 5r3u1sWGdjELbWd/dSeEHPlmW4+wuJ2Xs4UNSPWB8nTwmCVQaUJtXrgDz/nB0freXe
	 3tpJriXdtKqbtfZxu7/80lv84G7u7HAI/nuyfaZkxi80aS8Jn8PJ+gVwnJ3m3HmF8C
	 a6caYiVSvhke0XynsLWLdBi13Ff5LnBt6d6uWQPq3Qm6SXeBj1zvodrY1RXWAsliv9
	 oji1ZvDSMzmdYgwWlFmdnniAxIBWP4O0FhcoWE7F5am7FqRTXpqti2+Oo6hCrtF592
	 x+z4QIWYfrLHQ==
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
Subject: [PATCH 16/33] PCI: Flush PCI probe workqueue on cpuset isolated partition change
Date: Mon, 13 Oct 2025 22:31:29 +0200
Message-ID: <20251013203146.10162-17-frederic@kernel.org>
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

The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
order to synchronize against PCI probe works and make sure that no
asynchronous probing is still pending or executing on a newly made
isolated CPU, the housekeeping susbsystem must flush the PCI probe
works.

However the PCI probe works can't be flushed easily since they are
queued to the main per-CPU workqueue pool.

Solve this with creating a PCI probe specific pool and provide and use
the appropriate flushing API.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++++-
 include/linux/pci.h      |  3 +++
 kernel/sched/isolation.c |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7b74d22b20f7..ac86aaec8bcf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -337,6 +337,8 @@ static int local_pci_probe(struct drv_dev_and_id *ddi)
 	return 0;
 }
 
+static struct workqueue_struct *pci_probe_wq;
+
 struct pci_probe_arg {
 	struct drv_dev_and_id *ddi;
 	struct work_struct work;
@@ -407,7 +409,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		cpu = cpumask_any_and(cpumask_of_node(node),
 				      wq_domain_mask);
 		if (cpu < nr_cpu_ids) {
-			schedule_work_on(cpu, &arg.work);
+			struct workqueue_struct *wq = pci_probe_wq;
+
+			if (WARN_ON_ONCE(!wq))
+				wq = system_percpu_wq;
+			queue_work_on(cpu, wq, &arg.work);
 			rcu_read_unlock();
 			flush_work(&arg.work);
 			error = arg.ret;
@@ -425,6 +431,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	return error;
 }
 
+void pci_probe_flush_workqueue(void)
+{
+	flush_workqueue(pci_probe_wq);
+}
+
 /**
  * __pci_device_probe - check if a driver wants to claim a specific PCI device
  * @drv: driver to call to check if it wants the PCI device
@@ -1760,6 +1771,10 @@ static int __init pci_driver_init(void)
 {
 	int ret;
 
+	pci_probe_wq = alloc_workqueue("sync_wq", WQ_PERCPU, 0);
+	if (!pci_probe_wq)
+		return -ENOMEM;
+
 	ret = bus_register(&pci_bus_type);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..3281c235b895 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1175,6 +1175,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
+void pci_probe_flush_workqueue(void);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
@@ -2037,6 +2038,8 @@ static inline int pci_has_flag(int flag) { return 0; }
 _PCI_NOP_ALL(read, *)
 _PCI_NOP_ALL(write,)
 
+static inline void pci_probe_flush_workqueue(void) { }
+
 static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     unsigned int device,
 					     struct pci_dev *from)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5cd3d98a2663..b1eea5440484 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include <linux/sched/isolation.h>
+#include <linux/pci.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -144,6 +145,7 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 
 	synchronize_rcu();
 
+	pci_probe_flush_workqueue();
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 
-- 
2.51.0


