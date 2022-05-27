Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71975357D4
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 04:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiE0Cjp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiE0Cjo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 22:39:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A4D6E52AB;
        Thu, 26 May 2022 19:39:42 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxOeTjOZBismwDAA--.11649S2;
        Fri, 27 May 2022 10:39:38 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] cgroup: wait for css offline when rmdir
Date:   Fri, 27 May 2022 10:39:18 +0800
Message-Id: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9BxOeTjOZBismwDAA--.11649S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrKr47CrW3JFW8WF4fAFb_yoW8XFyrpF
        1qka43tw4fKF47G3yft340qFWSga1kX3W7t3yft3WFyF17Ar17Xr1xuryUXr10yFs7Cr43
        Jr1FvF12kF1UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

when remove a cgroup dir, make sure all the csses associated which
the cgroup are all offlined,so that we will be sure that the resources
allocated by the csses are all freed when rmdir exit successfully.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 kernel/cgroup/cgroup.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e..12d3a14 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3020,6 +3020,31 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 	}
 }
 
+/* wait all cgrp's csses become offlined */
+void cgroup_wait_css_offline(struct cgroup *cgrp)
+{
+	struct cgroup_subsys *ss;
+	int ssid;
+
+	lockdep_assert_held(&cgroup_mutex);
+	for_each_subsys(ss, ssid) {
+		struct cgroup_subsys_state *css = cgroup_css(cgrp, ss);
+		DEFINE_WAIT(wait);
+
+		if (!css || !percpu_ref_is_dying(&css->refcnt))
+			continue;
+
+		prepare_to_wait(&cgrp->offline_waitq, &wait,
+				TASK_UNINTERRUPTIBLE);
+
+		mutex_unlock(&cgroup_mutex);
+		schedule();
+		finish_wait(&cgrp->offline_waitq, &wait);
+
+		mutex_lock(&cgroup_mutex);
+	}
+}
+
 /**
  * cgroup_save_control - save control masks and dom_cgrp of a subtree
  * @cgrp: root of the target subtree
@@ -5724,6 +5749,7 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!ret)
 		TRACE_CGROUP_PATH(rmdir, cgrp);
 
+	cgroup_wait_css_offline(cgrp);
 	cgroup_kn_unlock(kn);
 	return ret;
 }
-- 
1.8.3.1

