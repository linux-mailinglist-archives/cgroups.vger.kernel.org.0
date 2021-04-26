Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C536B175
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhDZKTD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 06:19:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:39834 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhDZKTC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 06:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=nREANoRbtawbykcWnTWer/HrY0mwvKlgG2/7PjUlgwk=; b=Oum5pEMzGrsiSDza6ZQ
        7JTwCmjOgZp0rQeK/7W1bmcTNGFpsAJDQhYa5JAc8V/mdviSrK8xYbysFhTmSLoovi95xIs8Kc7Dd
        pn4wisWsBXl5yqsQOiRa29OfzszY2MgJy+MuDXwLq0+4pvR+yMXIPY7LGbEv9dLvaXODoglD3eE=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1layJi-001LYD-Rw; Mon, 26 Apr 2021 13:18:14 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/2] ipc: use kmalloc for msg_queue and shmid_kernel
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
Message-ID: <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
Date:   Mon, 26 Apr 2021 13:18:14 +0300
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

msg_queue and shmid_kernel are quite small objects, no need to use
kvmalloc for them.
Previously these objects was allocated via ipc_alloc/ipc_rcu_alloc(),
common function for several ipc objects. It had kvmalloc call inside().
Later, this function went away and was finally replaced by direct
kvmalloc call, and now we can use more suitable kmalloc/kfree for them.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 ipc/msg.c | 6 +++---
 ipc/shm.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 87898cb..79c6625 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -130,7 +130,7 @@ static void msg_rcu_free(struct rcu_head *head)
 	struct msg_queue *msq = container_of(p, struct msg_queue, q_perm);
 
 	security_msg_queue_free(&msq->q_perm);
-	kvfree(msq);
+	kfree(msq);
 }
 
 /**
@@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
+	msq = kmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
@@ -157,7 +157,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	msq->q_perm.security = NULL;
 	retval = security_msg_queue_alloc(&msq->q_perm);
 	if (retval) {
-		kvfree(msq);
+		kfree(msq);
 		return retval;
 	}
 
diff --git a/ipc/shm.c b/ipc/shm.c
index 7632d72..85da060 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -222,7 +222,7 @@ static void shm_rcu_free(struct rcu_head *head)
 	struct shmid_kernel *shp = container_of(ptr, struct shmid_kernel,
 							shm_perm);
 	security_shm_free(&shp->shm_perm);
-	kvfree(shp);
+	kfree(shp);
 }
 
 static inline void shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *s)
@@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			ns->shm_tot + numpages > ns->shm_ctlall)
 		return -ENOSPC;
 
-	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
+	shp = kmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!shp))
 		return -ENOMEM;
 
@@ -630,7 +630,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(&shp->shm_perm);
 	if (error) {
-		kvfree(shp);
+		kfree(shp);
 		return error;
 	}
 
-- 
1.8.3.1

