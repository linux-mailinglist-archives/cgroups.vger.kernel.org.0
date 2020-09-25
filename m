Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1462783A5
	for <lists+cgroups@lfdr.de>; Fri, 25 Sep 2020 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYJL0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Sep 2020 05:11:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34967 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgIYJL0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Sep 2020 05:11:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UA1.jhS_1601025084;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UA1.jhS_1601025084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Sep 2020 17:11:24 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] cgroup: remove redundant kernfs_activate in cgroup_setup_root()
Date:   Fri, 25 Sep 2020 17:11:10 +0800
Message-Id: <20200925091110.17189-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This step is already done in rebind_subsystems().

Not necessary to do it again.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..809b13588124 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2006,7 +2006,6 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	BUG_ON(!list_empty(&root_cgrp->self.children));
 	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
 
-	kernfs_activate(root_cgrp->kn);
 	ret = 0;
 	goto out;
 
-- 
2.20.1 (Apple Git-117)

