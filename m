Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1936B173
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhDZKSx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 06:18:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:39788 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhDZKSx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 06:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=T0+LqvdgHd7x+YycdlcPm1T661YqsM0zUWN47J/hkmc=; b=V2sCQr//YE4MCNzJ8Vj
        hfSArDKNlnFmUYt6BHEsr5RZ0cd7uFq/AqdcdFNvGrSPpNxWRaeJWrWU6USF9Kw/0e4SPnqUez9K6
        JxJlQfCVAsU/UM9LMT4wQ262qNalMDfhbMyNsCUuHHQbkh+e1AHCrgFbbi1DHrnhSaRC/O9UIXI=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1layJd-001LY6-E6; Mon, 26 Apr 2021 13:18:09 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/2] ipc sem: use kvmalloc for sem_undo allocation
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
Message-ID: <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
Date:   Mon, 26 Apr 2021 13:18:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
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

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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

