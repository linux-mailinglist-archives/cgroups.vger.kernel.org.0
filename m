Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD370EEB3
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 08:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbjEXG4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 02:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbjEXG4V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 02:56:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39BE71;
        Tue, 23 May 2023 23:55:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QR25B1jLzz4f3kpy;
        Wed, 24 May 2023 14:55:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.58])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7PvtG1k22hiKA--.7544S4;
        Wed, 24 May 2023 14:55:43 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next v2] cgroup: Update out-of-date comment in cgroup_migrate()
Date:   Wed, 24 May 2023 14:54:31 +0800
Message-Id: <20230524065431.145434-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: gCh0CgCnD7PvtG1k22hiKA--.7544S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr43Cr1rWry3Jr1rtw43Wrg_yoW8Jry3pr
        ykJ345K345u3Wqvw1UCas29ryfC3yFgF47t39xXwsayr13Jw1YgFy0ka13Zr1YvF4IkF47
        tFWYva9YkFyqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr
        1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 674b745e22b3 ("cgroup: remove rcu_read_lock()/rcu_read_unlock()
in critical section of spin_lock_irq()") has removed the rcu_read_lock,
which makes the comment out-of-date, so update it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
v2: don't remove the comment, just update it.
---
 kernel/cgroup/cgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d8ba2c67910d..f10cef511ffa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2872,9 +2872,11 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 	struct task_struct *task;
 
 	/*
-	 * Prevent freeing of tasks while we take a snapshot. Tasks that are
-	 * already PF_EXITING could be freed from underneath us unless we
-	 * take an rcu_read_lock.
+	 * We should take an rcu_read_lock to prevent freeing of tasks while
+	 * taking a snapshot, because tasks that are already PF_EXITING could
+	 * be freed when traversing all threads of leader. However rcu_read_lock
+	 * which disable preempt is implied by the spin_lock_irq, so no explicit
+	 * rcu call here.
 	 */
 	spin_lock_irq(&css_set_lock);
 	task = leader;
-- 
2.17.1

