Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED03D6729
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhGZSVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 14:21:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:55374 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhGZSUx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Jul 2021 14:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Ccnjp3FPBm3dwMYx93pYsjJGsGokrnefzYE+aVs2CiQ=; b=Vq1L9YM4JDzl1lIxp9s
        5JWpkJUeE1caHCsV1AboRg34E9mPN7kK0/xDrU33UMV+kgSYAOdnvuoF0TAcZhqRUlja901L4sSke
        DrtK50SoaiZzxLRpOwTkTm9WmAvYRVCXAK5RYxFCi7a4C/4fLddqeDI4meNr/dnELdzXVzqt3hE=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m85qq-005JWD-Ec; Mon, 26 Jul 2021 22:01:20 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v6 12/16] memcg: enable accounting of ipc resources
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Yutian Yang <nglaive@gmail.com>, linux-kernel@vger.kernel.org
References: <9bf9d9bd-03b1-2adb-17b4-5d59a86a9394@virtuozzo.com>
 <cover.1627321321.git.vvs@virtuozzo.com>
Message-ID: <f486ea26-0baa-c1d5-2f75-a23bd1ca1274@virtuozzo.com>
Date:   Mon, 26 Jul 2021 22:01:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627321321.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When user creates IPC objects it forces kernel to allocate memory for
these long-living objects.

It makes sense to account them to restrict the host's memory consumption
from inside the memcg-limited container.

This patch enables accounting for IPC shared memory segments, messages
semaphores and semaphore's undo lists.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 ipc/msg.c | 2 +-
 ipc/sem.c | 9 +++++----
 ipc/shm.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 6810276..a0d0577 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kmalloc(sizeof(*msq), GFP_KERNEL);
+	msq = kmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 971e75d..1a8b9f0 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -514,7 +514,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 	if (nsems > (INT_MAX - sizeof(*sma)) / sizeof(sma->sems[0]))
 		return NULL;
 
-	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL);
+	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1855,7 +1855,7 @@ static inline int get_undo_list(struct sem_undo_list **undo_listp)
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
-		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL);
+		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL_ACCOUNT);
 		if (undo_list == NULL)
 			return -ENOMEM;
 		spin_lock_init(&undo_list->lock);
@@ -1941,7 +1941,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 
 	/* step 2: allocate new undo structure */
 	new = kvzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
-		       GFP_KERNEL);
+		       GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
@@ -2005,7 +2005,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	if (nsops > ns->sc_semopm)
 		return -E2BIG;
 	if (nsops > SEMOPM_FAST) {
-		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
+		sops = kvmalloc_array(nsops, sizeof(*sops),
+				      GFP_KERNEL_ACCOUNT);
 		if (sops == NULL)
 			return -ENOMEM;
 	}
diff --git a/ipc/shm.c b/ipc/shm.c
index 748933e..ab749be 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			ns->shm_tot + numpages > ns->shm_ctlall)
 		return -ENOSPC;
 
-	shp = kmalloc(sizeof(*shp), GFP_KERNEL);
+	shp = kmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!shp))
 		return -ENOMEM;
 
-- 
1.8.3.1

