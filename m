Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE5A129361
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2019 09:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfLWI5G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Dec 2019 03:57:06 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54424 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfLWI5G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Dec 2019 03:57:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TlhKIye_1577091417;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0TlhKIye_1577091417)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Dec 2019 16:57:03 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     cgroups@vger.kernel.org
Cc:     linux-mm@kvack.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Subject: [PATCH] mm, memcg: fix comment error about memory.low usage
Date:   Mon, 23 Dec 2019 16:56:56 +0800
Message-Id: <0505ec19cc077cf32d7175ffea121e2130c64590.1577090923.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memory.current > memory.low, the usage of memory.low should be the
value of memory.low, not 0.

Fix and simplify the equation in comments.

Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74..def95a5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6236,9 +6236,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * elow = min( memory.low, parent->elow * ------------------ ),
  *                                        siblings_low_usage
  *
- *             | memory.current, if memory.current < memory.low
- * low_usage = |
- *	       | 0, otherwise.
+ * low_usage = min( memory.current, memory.low )
  *
  *
  * Such definition of the effective memory.low provides the expected
-- 
1.8.3.1

