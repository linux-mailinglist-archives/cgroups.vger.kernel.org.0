Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2B72F87
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2019 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfGXNHi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Jul 2019 09:07:38 -0400
Received: from app2.whu.edu.cn ([202.114.64.89]:54154 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbfGXNHi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Jul 2019 09:07:38 -0400
Received: from localhost (unknown [111.202.192.5])
        by email2 (Coremail) with SMTP id AgBjCgB3RvQSWDhdeBK6AA--.10748S2;
        Wed, 24 Jul 2019 21:07:30 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] cgroup: remove early strstrip in cgroup_threads_write
Date:   Wed, 24 Jul 2019 21:05:26 +0800
Message-Id: <20190724130526.20671-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AgBjCgB3RvQSWDhdeBK6AA--.10748S2
X-Coremail-Antispam: 1UD129KBjvdXoWrGr1UKF47ZrWfGw13tryrZwb_yoWxWFb_Z3
        y2qryqgryxAw1Dt34qqws5JFWkKw45XF1v9wnFyFW7JF1DtFs8AF1fXr15ArZxuan3tryD
        u3sxWF97tr4DWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU2D73UUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_procs_write_start() will process leading and
trailing whitespace when necessary.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..49f2b133cf67 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4796,8 +4796,6 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	struct task_struct *task;
 	ssize_t ret;
 
-	buf = strstrip(buf);
-
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
-- 
2.19.1

