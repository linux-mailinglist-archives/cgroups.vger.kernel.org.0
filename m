Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2236D288
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhD1Gxl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:53:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:48396 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232966AbhD1Gxl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=clYxEAeg8V51msYVaFChl655dJYlYrRZ5Da6o/xDwKA=; b=M6z6aLy3UQXWOO2lJEk
        qk2Gdsfo4IoAP/BziRrXBxF2MtxZArYOiOuIgqbD6Ac54Ukl8x44BxRL5QxIqMQzTj/lbMmVgQwwD
        CwZoYRDbfJ2CKGyfSNFC27xBaYr9wvX4Bvum+bVQMRRSgsoc13OcRS/XAJBMennRICQd7cmhtcs=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbe47-001Vjd-Pk; Wed, 28 Apr 2021 09:52:55 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v4 08/16] memcg: enable accounting of ipc resources
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Message-ID: <5c91f976-4a35-6de3-01c3-baa880220bea@virtuozzo.com>
Date:   Wed, 28 Apr 2021 09:52:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
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
 ipc/msg.c |  2 +-
 ipc/sem.c | 10 ++++++----
 ipc/shm.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index acd1bc7..87898cb 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
+	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a8..52a6599 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -511,7 +511,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 	if (nsems > (INT_MAX - sizeof(*sma)) / sizeof(sma->sems[0]))
 		return NULL;
 
-	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL);
+	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1850,7 +1850,7 @@ static inline int get_undo_list(struct sem_undo_list **undo_listp)
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
-		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL);
+		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL_ACCOUNT);
 		if (undo_list == NULL)
 			return -ENOMEM;
 		spin_lock_init(&undo_list->lock);
@@ -1935,7 +1935,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
+		      GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
@@ -1999,7 +2000,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
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
index febd88d..7632d72 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			ns->shm_tot + numpages > ns->shm_ctlall)
 		return -ENOSPC;
 
-	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
+	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!shp))
 		return -ENOMEM;
 
-- 
1.8.3.1

