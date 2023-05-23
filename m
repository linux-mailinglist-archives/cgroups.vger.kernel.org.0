Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3170DB55
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjEWLQc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjEWLQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 07:16:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CAFE;
        Tue, 23 May 2023 04:16:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QQWwH0M82z4f41Sw;
        Tue, 23 May 2023 19:16:15 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.58])
        by APP1 (Coremail) with SMTP id cCh0CgBXrRd_oGxkxWnRJQ--.15544S4;
        Tue, 23 May 2023 19:16:16 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiujianfeng@huaweicloud.com
Subject: [PATCH -next] cgroup: Remove out-of-date comment in cgroup_migrate()
Date:   Tue, 23 May 2023 19:14:56 +0800
Message-Id: <20230523111456.146053-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cCh0CgBXrRd_oGxkxWnRJQ--.15544S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1kZF48Aw1fCw17uw1rWFg_yoWfZrb_tw
        4jq340qryfAw13tr1Sqws3XFZ2grs5Cryvgw15tay7JFyUtFn5Xrs7tF13JrZ8AFs2kr1D
        ur9xWa97trnFgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
        AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSLv
        NUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Commit 674b745e22b3 ("cgroup: remove rcu_read_lock()/rcu_read_unlock()
in critical section of spin_lock_irq()") has removed the rcu_read_lock,
which makes the comment out-of-date, so remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d8ba2c67910d..415d51c713ad 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2871,11 +2871,6 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 {
 	struct task_struct *task;
 
-	/*
-	 * Prevent freeing of tasks while we take a snapshot. Tasks that are
-	 * already PF_EXITING could be freed from underneath us unless we
-	 * take an rcu_read_lock.
-	 */
 	spin_lock_irq(&css_set_lock);
 	task = leader;
 	do {
-- 
2.17.1

