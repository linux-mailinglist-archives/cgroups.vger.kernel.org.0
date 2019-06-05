Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7635E02
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfFENiB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:38:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFENh6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:37:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DTRP0119591;
        Wed, 5 Jun 2019 13:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Ww3UO2Y64LsDIspP9nYZfcD+xc5topDBTlHYu02FoZk=;
 b=JTf9y2n/Sjoe4pCzMh/uy2QTChLH80qdYMT4tF5HvvdqnddEB6F4E7F4ln19olEOst+P
 s1d70dD4bMVQKxP4Wu+TyCMvlVbnlNw1Av/XCyGAad3Kwj35hUXdccR6qBwRPSim9lCU
 7Rb092NiSatD4WL50ijDmD/UXKm3bjtZxCByZFaqV88vG2iSAbuTpL79Hr6kx3DNUG60
 AllDwHwTDfclIdN9dy8zeJbbxLGmOLYPfZcfR/ES2Mtuqu9X1mGhxP5+Spi6RjmpSb8q
 nMtE1DTLPDzZD13aqefL2bhadYVaee21oqJeziL5s7NwKS9ai+fBjUFarxilJfvPWhIH gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sugstjn48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DZsGf069290;
        Wed, 5 Jun 2019 13:37:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2swnghw2j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55Db4vD022901;
        Wed, 5 Jun 2019 13:37:04 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:37:04 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     hannes@cmpxchg.org, jiangshanlai@gmail.com, lizefan@huawei.com,
        tj@kernel.org
Cc:     bsd@redhat.com, dan.j.williams@intel.com,
        daniel.m.jordan@oracle.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC v2 3/5] workqueue, memcontrol: make memcg throttle workqueue workers
Date:   Wed,  5 Jun 2019 09:36:48 -0400
Message-Id: <20190605133650.28545-4-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050087
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Attaching a worker to a css_set isn't enough for all controllers to
throttle it.  In particular, the memory controller currently bypasses
accounting for kernel threads.

Support memcg accounting for cgroup-aware workqueue workers so that
they're appropriately throttled.

Another, probably better way to do this is to have kernel threads, or
even specifically cgroup-aware workqueue workers, call
memalloc_use_memcg and memalloc_unuse_memcg during cgroup migration
(memcg attach callback maybe).

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/workqueue.c          | 26 ++++++++++++++++++++++++++
 kernel/workqueue_internal.h |  5 +++++
 mm/memcontrol.c             | 26 ++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 89b90899bc09..c8cc69e296c0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,8 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/cgroup.h>
+#include <linux/memcontrol.h>
+#include <linux/sched/mm.h>
 
 #include "workqueue_internal.h"
 
@@ -1829,6 +1831,28 @@ static inline bool worker_in_child_cgroup(struct worker *worker)
 	return (worker->flags & WORKER_CGROUP) && cgroup_parent(worker->cgroup);
 }
 
+/* XXX Put this in the memory controller's attach callback. */
+#ifdef CONFIG_MEMCG
+static void worker_unuse_memcg(struct worker *worker)
+{
+	if (worker->task->active_memcg) {
+		struct mem_cgroup *memcg = worker->task->active_memcg;
+
+		memalloc_unuse_memcg();
+		css_put(&memcg->css);
+	}
+}
+
+static void worker_use_memcg(struct worker *worker)
+{
+	struct mem_cgroup *memcg;
+
+	worker_unuse_memcg(worker);
+	memcg = mem_cgroup_from_css(task_get_css(worker->task, memory_cgrp_id));
+	memalloc_use_memcg(memcg);
+}
+#endif /* CONFIG_MEMCG */
+
 static void attach_worker_to_dfl_root(struct worker *worker)
 {
 	int ret;
@@ -1841,6 +1865,7 @@ static void attach_worker_to_dfl_root(struct worker *worker)
 		rcu_read_lock();
 		worker->cgroup = task_dfl_cgroup(worker->task);
 		rcu_read_unlock();
+		worker_unuse_memcg(worker);
 	} else {
 		/*
 		 * TODO Modify the cgroup migration path to guarantee that a
@@ -1880,6 +1905,7 @@ static void attach_worker_to_cgroup(struct worker *worker,
 
 	if (cgroup_attach_kthread(cgroup) == 0) {
 		worker->cgroup = cgroup;
+		worker_use_memcg(worker);
 	} else {
 		/*
 		 * Attach failed, so attach to the default root so the
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 3ad5861258ca..f254b93edc2c 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -79,6 +79,11 @@ work_func_t wq_worker_last_func(struct task_struct *task);
 
 #ifdef CONFIG_CGROUPS
 
+#ifndef CONFIG_MEMCG
+static inline void worker_use_memcg(struct worker *worker) {}
+static inline void worker_unuse_memcg(struct worker *worker) {}
+#endif /* CONFIG_MEMCG */
+
 /*
  * A barrier work running in a cgroup-aware worker pool needs to specify a
  * cgroup.  For simplicity, WQ_BARRIER_CGROUP makes the worker stay in its
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 81a0d3914ec9..1a80931b124a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2513,9 +2513,31 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 
 static inline bool memcg_kmem_bypass(void)
 {
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+	if (in_interrupt())
 		return true;
-	return false;
+
+	if (unlikely(current->flags & PF_WQ_WORKER)) {
+		struct cgroup *parent;
+
+		/*
+		 * memcg should throttle cgroup-aware workers.  Infer the
+		 * worker is cgroup-aware by its presence in a non-root cgroup.
+		 *
+		 * This test won't detect a cgroup-aware worker attached to the
+		 * default root, but in that case memcg doesn't need to
+		 * throttle it anyway.
+		 *
+		 * XXX One alternative to this awkward block is adding a
+		 * cgroup-aware-worker bit to task_struct.
+		 */
+		rcu_read_lock();
+		parent = cgroup_parent(task_dfl_cgroup(current));
+		rcu_read_unlock();
+
+		return !parent;
+	}
+
+	return !current->mm || (current->flags & PF_KTHREAD);
 }
 
 /**
-- 
2.21.0

