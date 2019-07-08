Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B408561F36
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2019 15:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGHNDp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jul 2019 09:03:45 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:59412 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbfGHNDp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 8 Jul 2019 09:03:45 -0400
Received: from localhost (unknown [111.202.192.5])
        by email1 (Coremail) with SMTP id AQBjCgBHKToiPyNdsrRhAA--.45504S2;
        Mon, 08 Jul 2019 21:03:35 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] cgroup: simplify code for cgroup_subtree_control_write()
Date:   Mon,  8 Jul 2019 21:01:32 +0800
Message-Id: <20190708130132.5582-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgBHKToiPyNdsrRhAA--.45504S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8AF4UGF4rWFWkCw13CFg_yoW8GFyUp3
        ZxGryft3y5ZF95WF17ta40gFyfGw4xX347Ka98Ww1fXw1akr1qqr1fZr1rXFy7ZF97Cw1a
        yFs8AFn5Kr48trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjnjjDUUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Process "enable" and "disable" earlier to simplify code.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 kernel/cgroup/cgroup.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bf9dbffd46b1..e49b8bde5c99 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3269,23 +3269,21 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 
+	enable &= ~(cgrp->subtree_control);
+	disable &= cgrp->subtree_control;
+
+	if (!enable && !disable) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	for_each_subsys(ss, ssid) {
 		if (enable & (1 << ssid)) {
-			if (cgrp->subtree_control & (1 << ssid)) {
-				enable &= ~(1 << ssid);
-				continue;
-			}
-
 			if (!(cgroup_control(cgrp) & (1 << ssid))) {
 				ret = -ENOENT;
 				goto out_unlock;
 			}
 		} else if (disable & (1 << ssid)) {
-			if (!(cgrp->subtree_control & (1 << ssid))) {
-				disable &= ~(1 << ssid);
-				continue;
-			}
-
 			/* a child has it enabled? */
 			cgroup_for_each_live_child(child, cgrp) {
 				if (child->subtree_control & (1 << ssid)) {
@@ -3296,11 +3294,6 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 		}
 	}
 
-	if (!enable && !disable) {
-		ret = 0;
-		goto out_unlock;
-	}
-
 	ret = cgroup_vet_subtree_control_enable(cgrp, enable);
 	if (ret)
 		goto out_unlock;
-- 
2.19.1

