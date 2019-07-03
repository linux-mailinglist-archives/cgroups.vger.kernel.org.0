Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088EE5DBA5
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2019 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGCCQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 22:16:59 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net ([162.243.164.74]:60134
        "HELO zg8tmtyylji0my4xnjqunzqa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728112AbfGCCQ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Jul 2019 22:16:58 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 22:16:57 EDT
Received: from localhost (unknown [111.202.192.3])
        by email1 (Coremail) with SMTP id AQBjCgDXpmB2Dhxd6PNCAA--.52124S2;
        Wed, 03 Jul 2019 10:10:18 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] cgroup: minor tweak for logic to get cgroup css
Date:   Wed,  3 Jul 2019 10:07:49 +0800
Message-Id: <20190703020749.22988-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgDXpmB2Dhxd6PNCAA--.52124S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry8CF1ftr1UuFWxArykGrg_yoWxCrb_Aw
        1Iva12gry8Aw1jkr4qgws5XFWkKF4YgF1vvr4UtFy7JFyUtFs8t34fJF15JFsxuFn3XryD
        JrW3WrykGrn7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4U
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUgVyxUUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We could only handle the case that css exists
and css_try_get_online() fails.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bf9dbffd46b1..a988d77f6c6d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -488,7 +488,7 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
 
 	rcu_read_lock();
 	css = cgroup_css(cgrp, ss);
-	if (!css || !css_tryget_online(css))
+	if (css && !css_tryget_online(css))
 		css = NULL;
 	rcu_read_unlock();
 
-- 
2.19.1

