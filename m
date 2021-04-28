Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940C936D345
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhD1HgF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 03:36:05 -0400
Received: from relay.sw.ru ([185.231.240.75]:46054 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhD1HgD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 03:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Eq3YkHGrWHoEc1JLGJOu91L/CKO4jfb0ldrg7T9H29U=; b=GXT/0ycvBaenexct6A/
        9qeKqyR/n2KKbiLtRCVPDsNIHlopmwc132hAQp7Fm2cq8uFCgQdDtrCg+OwtqKWNYLckIXiZf0nnU
        2uLYxRw9j0jKZamEGAV9zyVYbqOE9Y0cwgpo5Krb5DvaajQImCXUZOvBxOBM40Ow8C+e14WqzAE=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbej6-001VrL-D5; Wed, 28 Apr 2021 10:35:16 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 1/2] ipc sem: use kvmalloc for sem_undo allocation
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <ebc3ac79-3190-520d-81ce-22ad194986ec@virtuozzo.com>
Message-ID: <a6354fd9-2d55-2e63-dd4d-fa7dc1d11134@virtuozzo.com>
Date:   Wed, 28 Apr 2021 10:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ebc3ac79-3190-520d-81ce-22ad194986ec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

size of sem_undo can exceed one page and with the maximum possible
nsems = 32000 it can grow up to 64Kb. Let's switch its allocation
to kvmalloc to avoid user-triggered disruptive actions like OOM killer
in case of high-order memory shortage.

User triggerable high order allocations are quite a problem on heavily
fragmented systems. They can be a DoS vector.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 ipc/sem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 52a6599..93088d6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1152,7 +1152,7 @@ static void freeary(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 		un->semid = -1;
 		list_del_rcu(&un->list_proc);
 		spin_unlock(&un->ulp->lock);
-		kfree_rcu(un, rcu);
+		kvfree_rcu(un, rcu);
 	}
 
 	/* Wake up all pending processes and let them fail with EIDRM. */
@@ -1935,7 +1935,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
+	new = kvzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
 		      GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
@@ -1948,7 +1948,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	if (!ipc_valid_object(&sma->sem_perm)) {
 		sem_unlock(sma, -1);
 		rcu_read_unlock();
-		kfree(new);
+		kvfree(new);
 		un = ERR_PTR(-EIDRM);
 		goto out;
 	}
@@ -1959,7 +1959,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	 */
 	un = lookup_undo(ulp, semid);
 	if (un) {
-		kfree(new);
+		kvfree(new);
 		goto success;
 	}
 	/* step 5: initialize & link new undo structure */
@@ -2420,7 +2420,7 @@ void exit_sem(struct task_struct *tsk)
 		rcu_read_unlock();
 		wake_up_q(&wake_q);
 
-		kfree_rcu(un, rcu);
+		kvfree_rcu(un, rcu);
 	}
 	kfree(ulp);
 }
-- 
1.8.3.1

