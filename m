Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00626C8EE
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIPTAP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 15:00:15 -0400
Received: from mail1.windriver.com ([147.11.146.13]:49178 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgIPTAL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 15:00:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08GBNieV017215
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 16 Sep 2020 04:23:45 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 04:23:44 -0700
From:   <yanfei.xu@windriver.com>
To:     <lizefan@huawei.com>, <tj@kernel.org>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuset: Move node_isset() outside of the rcu_read region
Date:   Wed, 16 Sep 2020 19:23:42 +0800
Message-ID: <20200916112342.25790-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

It's no need to keep node_isset still in rcu_read region, just move
it outside of the rcu_read region.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 642415b8c3c9..51d51ed97deb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3443,9 +3443,9 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
 
 	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
-	allowed = node_isset(node, cs->mems_allowed);
 	rcu_read_unlock();
 
+	allowed = node_isset(node, cs->mems_allowed);
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
-- 
2.18.2

