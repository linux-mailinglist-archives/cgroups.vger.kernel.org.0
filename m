Return-Path: <cgroups+bounces-6513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85EA31C89
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 04:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510A3A6A69
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 03:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27581D7998;
	Wed, 12 Feb 2025 03:08:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3CC148;
	Wed, 12 Feb 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329680; cv=none; b=o108MTNVVFD10PQjgSkZMBuL6jScGae+AtOq6YRTM+KBQ+qzBsJJEeI6C7wW1sFQdSOcsghQLut37WMStV/01AkAMTj0E5l8D7E8n0ge/dUPeWrCPZyrrjE3NztcSQqV0KDwZAxoc8/GKrmTqxpz3+mH6jkW6GvNCXXEOGB2wFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329680; c=relaxed/simple;
	bh=jaIYd7cshqR/G5ETbAdsuBDEMdOgq06VwWSRJQs5sBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZXNTphVwl8lc7JzxTfEOvr7MYUFOkg0BfXlnS3wuMot1h2JYq7B7fghI1usMyq8HiNU34zLnCASj1SZmYQ5Qo3FoydJ3dIVHKK8ExVh/TM5KkDc7YmRxTarGPW5fd4zR28mzALGWbtciOPn3+hj94BQU31Rq9TVP/+PiOSTmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yt3CF69hCz4f3jqb;
	Wed, 12 Feb 2025 11:07:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E0AF01A0BD9;
	Wed, 12 Feb 2025 11:07:53 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgDXKcSBEKxnbyc1Dg--.7428S2;
	Wed, 12 Feb 2025 11:07:53 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	mkoutny@suse.com,
	paulmck@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
Date: Wed, 12 Feb 2025 02:57:07 +0000
Message-Id: <20250212025707.67009-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXKcSBEKxnbyc1Dg--.7428S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy8Kry3Ww48GryrJw1fWFg_yoW8XF48pa
	98ua4UK398J3Z8ZF47Aa4IvF17J395ZFW8JF9rK34FvwsxtFn2yrWIyr1aqryrAFWS9a4Y
	vFs8Kr1xJrWavw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Unlike memcg OOM, which is relatively common, global OOM events are rare
and typically indicate that the entire system is under severe memory
pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
process") added the touch_softlockup_watchdog in the global OOM handler to
suppess the soft lockup issues. However, while this change can suppress
soft lockup warnings, it does not address RCU stalls, which can still be
detected and may cause unnecessary disturbances. Simply remove the
modification from the global OOM handler.

Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/oom_kill.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..2d8b27604ef8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,7 +44,6 @@
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
 #include <linux/cred.h>
-#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -431,15 +430,10 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
-		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p) {
-			/* Avoid potential softlockup warning */
-			if ((++i & 1023) == 0)
-				touch_softlockup_watchdog();
+		for_each_process(p)
 			dump_task(p, oc);
-		}
 		rcu_read_unlock();
 	}
 }
-- 
2.34.1


