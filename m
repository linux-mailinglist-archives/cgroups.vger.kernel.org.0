Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3C685E61
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 05:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBAEYJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 23:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAEYH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 23:24:07 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279C38641;
        Tue, 31 Jan 2023 20:24:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P681q2G67z4f3jJF;
        Wed,  1 Feb 2023 12:23:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBf6dljLNYlCw--.26190S4;
        Wed, 01 Feb 2023 12:24:01 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Date:   Wed,  1 Feb 2023 12:52:27 +0800
Message-Id: <20230201045227.2203123-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBf6dljLNYlCw--.26190S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1ftF4UWrW3Zw1ruFW3Jrb_yoWfJrWfpF
        4fArZxCF9YqF1xtrnrXa18Xryrtw4fAw4UJF43GFWF9w1jvw1vgw10yrn7XFyfArWDXrZ8
        JrZ8JrWUuF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Since commit a78418e6a04c ("block: Always initialize bio IO priority on
submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
blkcg_set_ioprio(), so there will be no way to promote the io-priority
of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
greater than or equals to IOPRIO_CLASS_RT.

It seems possible to call blkcg_set_ioprio() first then try to
initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
for bio in which bi_ioprio is already initialized (e.g., direct-io), so
introduce a new ioprio policy to promote the iopriority of bio to
IOPRIO_CLASS_RT if the ioprio is not already RT.

To distinguish between the demotion policy and the promotion policy,
use a bit in upper 16-bits of the policy to accomplish that and handle
the bit accordingly in blkcg_set_ioprio().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 38 ++++++----
 block/blk-ioprio.c                      | 94 +++++++++++++++++--------
 2 files changed, 92 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..e0b9f73ef62a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2038,17 +2038,27 @@ that attribute:
 	Change the I/O priority class of all requests into IDLE, the lowest
 	I/O priority class.
 
+  promote-to-rt
+	For requests that have I/O priority class BE or that have I/O priority
+        class IDLE, change it into RT. Do not modify the I/O priority class
+        of requests that have priority class RT.
+
 The following numerical values are associated with the I/O priority policies:
 
-+-------------+---+
-| no-change   | 0 |
-+-------------+---+
-| none-to-rt  | 1 |
-+-------------+---+
-| rt-to-be    | 2 |
-+-------------+---+
-| all-to-idle | 3 |
-+-------------+---+
+
++---------------+---------+-----+
+| policy        | inst    | num |
++---------------+---------+-----+
+| no-change     | demote  | 0   |
++---------------+---------+-----+
+| none-to-rt    | demote  | 1   |
++---------------+---------+-----+
+| rt-to-be      | demote  | 2   |
++---------------+---------+-----+
+| idle          | demote  | 3   |
++---------------+---------+-----+
+| promote-to-rt | promote | 1   |
++---------------+---------+-----+
 
 The numerical value that corresponds to each I/O priority class is as follows:
 
@@ -2064,9 +2074,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
 
 The algorithm to set the I/O priority class for a request is as follows:
 
-- Translate the I/O priority class policy into a number.
-- Change the request I/O priority class into the maximum of the I/O priority
-  class policy number and the numerical I/O priority class.
+-- Translate the I/O priority class policy into an instruction and a number
+-- If the instruction is demotion, change the request I/O priority class
+-  into the maximum of the I/O priority class policy number and the numerical
+-  I/O priority class.
+-- If the instruction is promotion, change the request I/O priority class
+-  into the minimum of the I/O priority class policy number and the numerical
+-  I/O priority class.
 
 PID
 ---
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8bb6b8eba4ce..0d400bee9c72 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -20,6 +20,13 @@
 #include "blk-ioprio.h"
 #include "blk-rq-qos.h"
 
+/*
+ * Upper 16-bits are reserved for special flags.
+ *
+ * @IOPRIO_POL_PROMOTION: Promote bi_ioprio instead of demote it.
+ */
+#define IOPRIO_POL_PROMOTION (1U << 17)
+
 /**
  * enum prio_policy - I/O priority class policy.
  * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
@@ -27,21 +34,30 @@
  * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
  *		IOPRIO_CLASS_BE.
  * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
- *
+ * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
+ * 		IOPRIO_CLASS_RT.
  * See also <linux/ioprio.h>.
  */
 enum prio_policy {
-	POLICY_NO_CHANGE	= 0,
-	POLICY_NONE_TO_RT	= 1,
-	POLICY_RESTRICT_TO_BE	= 2,
-	POLICY_ALL_TO_IDLE	= 3,
+	POLICY_NO_CHANGE	= IOPRIO_CLASS_NONE,
+	POLICY_NONE_TO_RT	= IOPRIO_CLASS_RT,
+	POLICY_RESTRICT_TO_BE	= IOPRIO_CLASS_BE,
+	POLICY_ALL_TO_IDLE	= IOPRIO_CLASS_IDLE,
+	POLICY_PROMOTE_TO_RT	= IOPRIO_CLASS_RT | IOPRIO_POL_PROMOTION,
+};
+
+struct ioprio_policy_tuple {
+	const char *name;
+	enum prio_policy policy;
 };
 
-static const char *policy_name[] = {
-	[POLICY_NO_CHANGE]	= "no-change",
-	[POLICY_NONE_TO_RT]	= "none-to-rt",
-	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
-	[POLICY_ALL_TO_IDLE]	= "idle",
+/* ioprio_alloc_cpd() needs POLICY_NO_CHANGE to be the first policy */
+static const struct ioprio_policy_tuple ioprio_policies[] = {
+	{ "no-change",		POLICY_NO_CHANGE },
+	{ "none-to-rt",		POLICY_NONE_TO_RT },
+	{ "restrict-to-be",	POLICY_RESTRICT_TO_BE },
+	{ "idle",		POLICY_ALL_TO_IDLE },
+	{ "promote-to-rt",	POLICY_PROMOTE_TO_RT }
 };
 
 static struct blkcg_policy ioprio_policy;
@@ -57,11 +73,11 @@ struct ioprio_blkg {
 /**
  * struct ioprio_blkcg - Per cgroup data.
  * @cpd: blkcg_policy_data structure.
- * @prio_policy: One of the IOPRIO_CLASS_* values. See also <linux/ioprio.h>.
+ * @ioprio: Policy name and definition.
  */
 struct ioprio_blkcg {
 	struct blkcg_policy_data cpd;
-	enum prio_policy	 prio_policy;
+	const struct ioprio_policy_tuple *ioprio;
 };
 
 static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
@@ -95,23 +111,35 @@ static int ioprio_show_prio_policy(struct seq_file *sf, void *v)
 {
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(seq_css(sf));
 
-	seq_printf(sf, "%s\n", policy_name[blkcg->prio_policy]);
+	seq_printf(sf, "%s\n", blkcg->ioprio->name);
 	return 0;
 }
 
+static const struct ioprio_policy_tuple *ioprio_match_policy(const char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ioprio_policies); i++) {
+		if (sysfs_streq(ioprio_policies[i].name, buf))
+			return &ioprio_policies[i];
+	}
+
+	return NULL;
+}
+
 static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 				      size_t nbytes, loff_t off)
 {
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(of_css(of));
-	int ret;
+	const struct ioprio_policy_tuple *ioprio;
 
 	if (off != 0)
 		return -EIO;
 	/* kernfs_fop_write_iter() terminates 'buf' with '\0'. */
-	ret = sysfs_match_string(policy_name, buf);
-	if (ret < 0)
-		return ret;
-	blkcg->prio_policy = ret;
+	ioprio = ioprio_match_policy(buf);
+	if (!ioprio)
+		return -EINVAL;
+	blkcg->ioprio = ioprio;
 	return nbytes;
 }
 
@@ -141,7 +169,7 @@ static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)
 	blkcg = kzalloc(sizeof(*blkcg), gfp);
 	if (!blkcg)
 		return NULL;
-	blkcg->prio_policy = POLICY_NO_CHANGE;
+	blkcg->ioprio = &ioprio_policies[0];
 	return &blkcg->cpd;
 }
 
@@ -186,20 +214,30 @@ void blkcg_set_ioprio(struct bio *bio)
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
 	u16 prio;
 
-	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
+	if (!blkcg || blkcg->ioprio->policy == POLICY_NO_CHANGE)
 		return;
 
+	WARN_ON_ONCE(bio->bi_ioprio == IOPRIO_CLASS_NONE);
+
 	/*
 	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
-	 * correspond to a lower priority. Hence, the max_t() below selects
-	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
-	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
-	 * priority is assigned to the bio.
+	 * correspond to a lower priority.
+	 *
+	 * When IOPRIO_POL_PROMOTION is enabled, the min_t() below selects
+	 * the higher priority of bi_ioprio and the cgroup I/O priority class,
+	 * otherwise the lower priority is selected.
 	 */
-	prio = max_t(u16, bio->bi_ioprio,
-			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
-	if (prio > bio->bi_ioprio)
-		bio->bi_ioprio = prio;
+	if (blkcg->ioprio->policy & IOPRIO_POL_PROMOTION) {
+		prio = min_t(u16, bio->bi_ioprio,
+				IOPRIO_PRIO_VALUE(blkcg->ioprio->policy, 0));
+		if (prio < bio->bi_ioprio)
+			bio->bi_ioprio = prio;
+	} else {
+		prio = max_t(u16, bio->bi_ioprio,
+				IOPRIO_PRIO_VALUE(blkcg->ioprio->policy, 0));
+		if (prio > bio->bi_ioprio)
+			bio->bi_ioprio = prio;
+	}
 }
 
 void blk_ioprio_exit(struct gendisk *disk)
-- 
2.29.2

