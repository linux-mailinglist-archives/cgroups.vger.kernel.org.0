Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237B13C85A4
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhGNN50 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 09:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNN5Z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B84A613D1;
        Wed, 14 Jul 2021 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270873;
        bh=hwa9dZbwQb6e2uewfwoomlLnro+e6qpIwA8eeMY71nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdFGzMH5oquC8WgqwTxb2xAa21B/AY2Q2QiVRrxuA65Ag1vzw2uvXbsV+GSyv8cQn
         CA2SLYGD7WLt9fADtnbS9SMCMrqqszAmMHNQnR+df1QJ04Kb63Ox/+wzq34PP37FK8
         Mx5TloljxZAqEzPAYzp1xiE3EnVngQFm/AwdxcoRiGgNm46eeRr0xRg4dTcDIHml2b
         AsUwELbPxfL3hlKGXr4d/B/5nEsNOQfS5PrsiB/KUBsaf2GpsqxOLQGWD175OjdD4+
         fnLrOjLkcnAoRdNksf37PLxD8Ix+WhQsqi8/aNDVFv0QmOC2djU97Nio1FvNIq92H8
         ULW5vsPmB+T3Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: [RFC PATCH 2/6] workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Wed, 14 Jul 2021 15:54:16 +0200
Message-Id: <20210714135420.69624-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
References: <20210714135420.69624-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare for HK_FLAG_DOMAIN to move to its own cpumask.
This will allow to modify the set passed through "isolcpus=" kernel boot
parameter on runtime.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..d29c5b61a333 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5938,13 +5938,13 @@ static void __init wq_numa_init(void)
 void __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
-	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	int i, cpu;
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
+	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_WQ));
+	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-- 
2.25.1

