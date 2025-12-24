Return-Path: <cgroups+bounces-12670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B87CDC73E
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA15430E8C63
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA234D386;
	Wed, 24 Dec 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgxbtN3s"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A334CFB9;
	Wed, 24 Dec 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584077; cv=none; b=kDhQLBZTz5vFTVZ9Fnt19BF2Vsc1UtleRBEZQ+8bR0BwvbfEHihHIHsOO5xslesDXiufsfiT90izF8H1NH5r2x4iW6l3jjoDtPgXNy2o/jtv5xTWRT71T+CtC2Cqr3f5J/H1mbMhIfAcXg4wTkxYU2Y+/5vZuqRFSb9FhAuKWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584077; c=relaxed/simple;
	bh=7qYWxx++pmNusXv4R4xraAF3RRpFsEpkHULEuTSFVcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCldc2PoZ7u4ZNhnUvhxkQwzSwafY759wbwvluFrB4C7860Zq8S/IRPoaZDH5P7VFDJmRUnAjyKYBzCQq/bWq9e3aT+rK4HRNuT7F0nX8qxUtCV2+Nb8rYnufPw9490XAPtoWlCi5hYednqbZo7Hz2u1YORkQ0LxZhkXgYn+vLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgxbtN3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AEBC4CEFB;
	Wed, 24 Dec 2025 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584077;
	bh=7qYWxx++pmNusXv4R4xraAF3RRpFsEpkHULEuTSFVcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgxbtN3soXaxGFkGtshSu3sETLrMlJFD82nO5TFfcJacIWGOhTQ+w/m2OIPUEg+UW
	 4vaHTNU/AHwz35/L1PwlH7RI0b8PfrOENgvkxhbQhmccOctFo2687Gxa50vDt3IYxs
	 TSc1vvtuYQJDTSgciv+ciBzZN0J+Knv4pd4wzToU7bEH0waPbjiGwWOAa+c/P7+hSP
	 86lHadjQNahgmqghysF5Pun9Py8RA7sa3q+EyENqKTxmf/U6WsMedSDmeG1QX8mOuf
	 sLC1gtYyWkDeMw0bZ/X9P/C//04luZOy4qKLKr16jz8Ub80z71p0n2XXxQlGnrzEzC
	 faPNoWuE0m1HQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
Subject: [PATCH 17/33] PCI: Flush PCI probe workqueue on cpuset isolated partition change
Date: Wed, 24 Dec 2025 14:45:04 +0100
Message-ID: <20251224134520.33231-18-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251224134520.33231-1-frederic@kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask is now modifiable at runtime. In
order to synchronize against PCI probe works and make sure that no
asynchronous probing is still pending or executing on a newly isolated
CPU, the housekeeping subsystem must flush the PCI probe works.

However the PCI probe works can't be flushed easily since they are
queued to the main per-CPU workqueue pool.

Solve this with creating a PCI probe-specific pool and provide and use
the appropriate flushing API.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++++-
 include/linux/pci.h      |  3 +++
 kernel/sched/isolation.c |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 786d6ce40999..d87f781e5ce9 100644
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
@@ -1762,6 +1773,10 @@ static int __init pci_driver_init(void)
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
index 864775651c6f..f14f467e50de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1206,6 +1206,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
+void pci_probe_flush_workqueue(void);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
@@ -2079,6 +2080,8 @@ static inline int pci_has_flag(int flag) { return 0; }
 _PCI_NOP_ALL(read, *)
 _PCI_NOP_ALL(write,)
 
+static inline void pci_probe_flush_workqueue(void) { }
+
 static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     unsigned int device,
 					     struct pci_dev *from)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 8aac3c9f7c7f..7dbe037ea8df 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include <linux/sched/isolation.h>
+#include <linux/pci.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -145,6 +146,7 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
 
 	synchronize_rcu();
 
+	pci_probe_flush_workqueue();
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 
-- 
2.51.1


