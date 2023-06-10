Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEC72AAAC
	for <lists+cgroups@lfdr.de>; Sat, 10 Jun 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjFJJ16 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Jun 2023 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJ15 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Jun 2023 05:27:57 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE8A8;
        Sat, 10 Jun 2023 02:27:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdXft5LCdz4f3prQ;
        Sat, 10 Jun 2023 17:27:50 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.58])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKsWQoRkyQ97LQ--.26470S4;
        Sat, 10 Jun 2023 17:27:51 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuigaosheng1@huawei.com
Subject: [PATCH v2] cgroup: Do not corrupt task iteration when rebinding subsystem
Date:   Sat, 10 Jun 2023 17:26:43 +0800
Message-Id: <20230610092643.139007-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKsWQoRkyQ97LQ--.26470S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DWr4DXF1rZw4ruFyfZwb_yoWrury8pF
        15urW3Ar4kuw4jgw4Sy34293yFgayrWw4UKrWxJ3yayrnxAry2qF1Ikw1UuFyIyFZrGrnx
        KF4Y9r1Y9w1DtaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r12
        6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r
        1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UR6wZUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

We found a refcount UAF bug as follows:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 342 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x148
Workqueue: events cpuset_hotplug_workfn
Call trace:
 refcount_warn_saturate+0xa0/0x148
 __refcount_add.constprop.0+0x5c/0x80
 css_task_iter_advance_css_set+0xd8/0x210
 css_task_iter_advance+0xa8/0x120
 css_task_iter_next+0x94/0x158
 update_tasks_root_domain+0x58/0x98
 rebuild_root_domains+0xa0/0x1b0
 rebuild_sched_domains_locked+0x144/0x188
 cpuset_hotplug_workfn+0x138/0x5a0
 process_one_work+0x1e8/0x448
 worker_thread+0x228/0x3e0
 kthread+0xe0/0xf0
 ret_from_fork+0x10/0x20

then a kernel panic will be triggered as below:

Unable to handle kernel paging request at virtual address 00000000c0000010
Call trace:
 cgroup_apply_control_disable+0xa4/0x16c
 rebind_subsystems+0x224/0x590
 cgroup_destroy_root+0x64/0x2e0
 css_free_rwork_fn+0x198/0x2a0
 process_one_work+0x1d4/0x4bc
 worker_thread+0x158/0x410
 kthread+0x108/0x13c
 ret_from_fork+0x10/0x18

The race that cause this bug can be shown as below:

(hotplug cpu)                | (umount cpuset)
mutex_lock(&cpuset_mutex)    | mutex_lock(&cgroup_mutex)
cpuset_hotplug_workfn        |
 rebuild_root_domains        |  rebind_subsystems
  update_tasks_root_domain   |   spin_lock_irq(&css_set_lock)
   css_task_iter_start       |    list_move_tail(&cset->e_cset_node[ss->id]
   while(css_task_iter_next) |                  &dcgrp->e_csets[ss->id]);
   css_task_iter_end         |   spin_unlock_irq(&css_set_lock)
mutex_unlock(&cpuset_mutex)  | mutex_unlock(&cgroup_mutex)

Inside css_task_iter_start/next/end, css_set_lock is hold and then
released, so when iterating task(left side), the css_set may be moved to
another list(right side), then it->cset_head points to the old list head
and it->cset_pos->next points to the head node of new list, which can't
be used as struct css_set.

To fix this issue, switch from all css_sets to only scgrp's css_sets to
patch in-flight iterators to preserve correct iteration, and then
update it->cset_head as well.

Reported-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Link: https://www.spinics.net/lists/cgroups/msg37935.html
Suggested-by: Michal Koutný <mkoutny@suse.com>
Link: https://lore.kernel.org/all/20230526114139.70274-1-xiujianfeng@huaweicloud.com/
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
v2: switch to solution suggested by Michal Koutný
---
 kernel/cgroup/cgroup.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..eaeba38d963d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1798,7 +1798,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1842,7 +1842,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1860,9 +1861,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		if (ss->css_rstat_flush) {
-- 
2.17.1

