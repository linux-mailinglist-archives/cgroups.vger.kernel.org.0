Return-Path: <cgroups+bounces-4848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C699E975857
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D51BB2972A
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14A1B141B;
	Wed, 11 Sep 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="U283/qOH"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA631AED22
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071817; cv=none; b=eUyfRXcTMaSd7RZbYkVOpA9m0HGx62DUr3c51ox73CtDJ78Xjx9mA2pvaKnG7URtGlddAHqk4FseOp+8eUcNRFGcDhlgDogqGHdyoULNxnikqlweYK8yKNf+06M4L+z4HNc2VuaHDQUlnl4kICB+KYrRzyOzX8rdYuTZ98ZrScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071817; c=relaxed/simple;
	bh=y+lt7r74UJXmUaDLzhkQeYyRS6DuNdsUXj1h0SDurT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoC3HoMdtnLWn84FAQZ3bJ8Xp5W4krt+UUNWZtnm7e3u3kY6EmI9JlAgAHwl1Vify4U1v3ANQTnwaCjRyNpP3KaVK7eKu8P5vzx1Q23/yF/OcDu/Oxjvt5q6zwdVNHAgAUZ+Id8cjqd1Ft1sjoLTzzr2F/LuMpYllgBvgaapd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=U283/qOH; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024091116232789beb8ccf33ca7e543
        for <cgroups@vger.kernel.org>;
        Wed, 11 Sep 2024 18:23:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ukk2ZxcuU4qD+efg80mQqUmpuA7cmcAn4YLMH6OPZfM=;
 b=U283/qOHpLJJvulEwssviMg53NEd6JVnVDoNfKg0OA/I7rbmoMmEhWEO5HRyJ3f7CzpG3/
 +6VGlIY3P0l0rXFlj1/VUV8+Gvb+AhlVjIwvF3jRW1bPMafqtVY6jTPDI3v43DhOf5TrDR3l
 2Wz7ydz0YWDYO6bJ2JQE3NHUEnuH8enRUbspW/knI6Qr/hRbvqnobrcFFrNS4fn2tq9WaebS
 uolU1Khx9WDBqSijPvPN6yBwnBZGTWJAON5Mfz0+TT0/GlG+WYNDVuLVbAc5SO+gwx8G8S9N
 v1L1yWT92W53LFkom8NdApe8GNEhJOnILhFl6Q00sfytLAVUDNy8XB4A==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: stable@vger.kernel.org,
	asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 6.1 1/2] io_uring/io-wq: do not allow pinning outside of cpuset
Date: Wed, 11 Sep 2024 18:23:15 +0200
Message-Id: <20240911162316.516725-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240911162316.516725-1-felix.moessbauer@siemens.com>
References: <20240911162316.516725-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

commit 0997aa5497c714edbb349ca366d28bd550ba3408 upstream.

The io worker threads are userland threads that just never exit to the
userland. By that, they are also assigned to a cgroup (the group of the
creating task).

When changing the affinity of the io_wq thread via syscall, we must only
allow cpumasks within the limits defined by the cpuset controller of the
cgroup (if enabled).

Fixes: da64d6db3bd3 ("io_uring: One wqe per wq")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 139cd49b2c27..c74bcc8d2f06 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/rculist_nulls.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/task_work.h>
 #include <linux/audit.h>
 #include <uapi/linux/io_uring.h>
@@ -1362,22 +1363,34 @@ static int io_wq_cpu_offline(unsigned int cpu, struct hlist_node *node)
 
 int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 {
+	cpumask_var_t allowed_mask;
+	int ret = 0;
 	int i;
 
 	if (!tctx || !tctx->io_wq)
 		return -EINVAL;
 
+	if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+		return -ENOMEM;
+	cpuset_cpus_allowed(tctx->io_wq->task, allowed_mask);
+
 	rcu_read_lock();
 	for_each_node(i) {
 		struct io_wqe *wqe = tctx->io_wq->wqes[i];
-
-		if (mask)
-			cpumask_copy(wqe->cpu_mask, mask);
-		else
-			cpumask_copy(wqe->cpu_mask, cpumask_of_node(i));
+		if (mask) {
+			if (cpumask_subset(mask, allowed_mask))
+				cpumask_copy(wqe->cpu_mask, mask);
+			else
+				ret = -EINVAL;
+		} else {
+			if (!cpumask_and(wqe->cpu_mask, cpumask_of_node(i), allowed_mask))
+				cpumask_copy(wqe->cpu_mask, allowed_mask);
+		}
 	}
 	rcu_read_unlock();
-	return 0;
+
+	free_cpumask_var(allowed_mask);
+	return ret;
 }
 
 /*
-- 
2.39.2


