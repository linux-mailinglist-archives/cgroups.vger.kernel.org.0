Return-Path: <cgroups+bounces-3928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2293F3A5
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB040B23543
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0414535C;
	Mon, 29 Jul 2024 11:07:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA145330;
	Mon, 29 Jul 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251259; cv=none; b=pjRNJKlclkQNkBVcpMZeualECALgX/twXrAmGftUnkcL9zV52egKzlqBuIAKn2ouyxFAbgneovbdJiPgYXLkb061qfzMwAy0/sPcPzeykEeuU+uWnoBFFgfump5kW7Ii+VvgtwFyxdD/UbVdGgNNMXQqC+FGjT9HL614QxnwlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251259; c=relaxed/simple;
	bh=IlzjjbKuscioRgN75zrYa65Sy7nNdLJ7VKwCkRuRfTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BzuyswMwAEIgj9sHHkpN84phNma2w+PCsmr35Dy/m+OCXV1uB214riLoJbBiqAJXYZ95cTL1USZ1R8OwpcWVxcpuKT86HeHgnT+F9+3sIg0OPTgTlZPnE9yVGHf+KmxIpeGY/Zww4xtHDeOq/hkrfoIU3aozCaeblkaZgp2kpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WXbD85qLJz4f3jcn;
	Mon, 29 Jul 2024 19:07:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 96CD21A0568;
	Mon, 29 Jul 2024 19:07:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP2 (Coremail) with SMTP id Syh0CgAXAcD0d6dmKGe9AA--.7666S2;
	Mon, 29 Jul 2024 19:07:33 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH -next] cgroup/pids: Avoid spurious event notification
Date: Mon, 29 Jul 2024 10:58:24 +0000
Message-Id: <20240729105824.3665753-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXAcD0d6dmKGe9AA--.7666S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryDWr48JF4xXF4xuFW5GFg_yoW8uw1Dp3
	ZxAFyrKrZ5J3Z09wn5J3srZFyfWa93WrZ8CF4rJ34ftw42kr1YganFkF1UZr1UZFy7u3sF
	qF4Yvay5J34j9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Currently when a process in a group forks and fails due to it's
parent's max restriction, all the cgroups from 'pids_forking' to root
will generate event notifications but only the cgroups from
'pids_over_limit' to root will increase the counter of PIDCG_MAX.

Consider this scenario: there are 4 groups A, B, C,and D, the
relationships are as follows, and user is watching on C.pids.events.

root->A->B->C->D

When a process in D forks and fails due to B.max restriction, the
user will get a spurious event notification because when he wakes up
and reads C.pids.events, he will find that the content has not changed.

To address this issue, only the cgroups from 'pids_over_limit' to root
will have their PIDCG_MAX counter increased and event notifications
generated.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/pids.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index f5cb0ec45b9d..1c8c9f76ff0e 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -244,7 +244,6 @@ static void pids_event(struct pids_cgroup *pids_forking,
 		       struct pids_cgroup *pids_over_limit)
 {
 	struct pids_cgroup *p = pids_forking;
-	bool limit = false;
 
 	/* Only log the first time limit is hit. */
 	if (atomic64_inc_return(&p->events_local[PIDCG_FORKFAIL]) == 1) {
@@ -257,15 +256,11 @@ static void pids_event(struct pids_cgroup *pids_forking,
 	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
 		return;
 
-	for (; parent_pids(p); p = parent_pids(p)) {
-		if (p == pids_over_limit) {
-			limit = true;
-			atomic64_inc(&p->events_local[PIDCG_MAX]);
-			cgroup_file_notify(&p->events_local_file);
-		}
-		if (limit)
-			atomic64_inc(&p->events[PIDCG_MAX]);
+	atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
+	cgroup_file_notify(&pids_over_limit->events_local_file);
 
+	for (p = pids_over_limit; parent_pids(p); p = parent_pids(p)) {
+		atomic64_inc(&p->events[PIDCG_MAX]);
 		cgroup_file_notify(&p->events_file);
 	}
 }
-- 
2.34.1


