Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE558106
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfF0K63 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 06:58:29 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:40314 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfF0K63 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 Jun 2019 06:58:29 -0400
X-Greylist: delayed 2237 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 06:58:28 EDT
Received: from localhost (unknown [111.202.192.3])
        by email1 (Coremail) with SMTP id AQBjCgDHUWOJmBRdKbQaAA--.41508S2;
        Thu, 27 Jun 2019 18:21:02 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] cgroup: provide a macro helper to iterate a cgroup's ancestors
Date:   Thu, 27 Jun 2019 18:19:01 +0800
Message-Id: <20190627101901.26714-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgDHUWOJmBRdKbQaAA--.41508S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Kw17uF1fuF1fJFW5Jrb_yoW5KF15pF
        4kAa43t3yakr1UtrWvq34qvFnagw4Fqw1UGw48tw1Syr43Jwn0qr1DCFy3WFyjyFZ2kFW3
        Xr4Yy34jkw40yF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUboKZJUUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use for_each_ancestor macro to iterate a cgroup's ancestors for clarity.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 include/linux/cgroup.h  | 11 +++++++++++
 kernel/cgroup/cgroup.c  |  7 +++----
 kernel/cgroup/freezer.c |  2 +-
 kernel/cgroup/rstat.c   |  4 ++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0297f930a56e..00b0a16bbc30 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -298,6 +298,17 @@ void css_task_iter_end(struct css_task_iter *it);
 			;						\
 		else
 
+/**
+ * for_each_ancestor - iterate a cgroup's ancestors
+ * @tcgrp: the loop cursor
+ * @cgrp: cgroup whose ancestors to iterate
+ *
+ * Iterate ancestors of @cgrp.
+ */
+#define for_each_ancestor(tcgrp, cgrp)					\
+	for ((tcgrp) = cgroup_parent((cgrp)); (tcgrp);			\
+		(tcgrp) = cgroup_parent((tcgrp)))
+
 /*
  * Inline functions.
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bf9dbffd46b1..32fa09679209 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -404,7 +404,7 @@ static bool cgroup_is_valid_domain(struct cgroup *cgrp)
 		return false;
 
 	/* but the ancestors can't be unless mixable */
-	while ((cgrp = cgroup_parent(cgrp))) {
+	for_each_ancestor(cgrp, cgrp) {
 		if (!cgroup_is_mixable(cgrp) && cgroup_is_thread_root(cgrp))
 			return false;
 		if (cgroup_is_threaded(cgrp))
@@ -4987,8 +4987,7 @@ static void css_release_work_fn(struct work_struct *work)
 			cgroup_rstat_flush(cgrp);
 
 		spin_lock_irq(&css_set_lock);
-		for (tcgrp = cgroup_parent(cgrp); tcgrp;
-		     tcgrp = cgroup_parent(tcgrp))
+		for_each_ancestor(tcgrp, cgrp)
 			tcgrp->nr_dying_descendants--;
 		spin_unlock_irq(&css_set_lock);
 
@@ -5518,7 +5517,7 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 		parent->nr_threaded_children--;
 
 	spin_lock_irq(&css_set_lock);
-	for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
+	for_each_ancestor(tcgrp, cgrp) {
 		tcgrp->nr_descendants--;
 		tcgrp->nr_dying_descendants++;
 		/*
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf010680678..4dfc2f04a82d 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -21,7 +21,7 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 	 *
 	 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
 	 */
-	while ((cgrp = cgroup_parent(cgrp))) {
+	for_each_ancestor(cgrp, cgrp) {
 		if (frozen) {
 			cgrp->freezer.nr_frozen_descendants += desc;
 			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ca19b4c8acf5..58d352e0d76a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -49,8 +49,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	raw_spin_lock_irqsave(cpu_lock, flags);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
-	for (parent = cgroup_parent(cgrp); parent;
-	     cgrp = parent, parent = cgroup_parent(cgrp)) {
+	for_each_ancestor(parent, cgrp) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
 
@@ -63,6 +62,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 		rstatc->updated_next = prstatc->updated_children;
 		prstatc->updated_children = cgrp;
+		cgrp = parent;
 	}
 
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
-- 
2.19.1

