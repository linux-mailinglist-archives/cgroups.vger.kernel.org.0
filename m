Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79976FEE1
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfGVLlt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 07:41:49 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:44356 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728312AbfGVLlt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Jul 2019 07:41:49 -0400
Received: from localhost (unknown [111.202.192.5])
        by email1 (Coremail) with SMTP id AQBjCgCXeTr2oDVdC7OvAA--.37111S2;
        Mon, 22 Jul 2019 19:41:42 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] cgroup: remove redundant assignment in while loop of cgroup_calc_subtree_ss_mask()
Date:   Mon, 22 Jul 2019 19:39:23 +0800
Message-Id: <20190722113923.16914-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgCXeTr2oDVdC7OvAA--.37111S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryxWFWDArWfKF1DZF48Crg_yoWkJrb_X3
        W8Jr1q9rWxA34YyrsFvFsYvay0g3y5Wr1v9w1qgFWDXFyUJrW5J3Z3tF15Xr43uFs5trZr
        tr93JFn3JF4qqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU3-BNUUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

new_ss_mask is always not less than cur_ss_mask.
We don not need to update it with cur_ss_mask's value.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 kernel/cgroup/cgroup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 300b0c416341..2b8c39dabd26 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1520,7 +1520,7 @@ static umode_t cgroup_file_mode(const struct cftype *cft)
  */
 static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
 {
-	u16 cur_ss_mask = subtree_control;
+	u16 cur_ss_mask = subtree_control, new_ss_mask;
 	struct cgroup_subsys *ss;
 	int ssid;
 
@@ -1528,9 +1528,8 @@ static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
 
 	cur_ss_mask |= cgrp_dfl_implicit_ss_mask;
 
+	new_ss_mask = cur_ss_mask;
 	while (true) {
-		u16 new_ss_mask = cur_ss_mask;
-
 		do_each_subsys_mask(ss, ssid, cur_ss_mask) {
 			new_ss_mask |= ss->depends_on;
 		} while_each_subsys_mask();
-- 
2.19.1

