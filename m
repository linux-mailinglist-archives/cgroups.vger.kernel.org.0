Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C603DB385
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhG3G0x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:26:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50755 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhG3G0w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:26:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhPeZys_1627626406;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhPeZys_1627626406)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 14:26:46 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     baolin.wang@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: Set the correct memcg swappiness restriction
Date:   Fri, 30 Jul 2021 14:26:35 +0800
Message-Id: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit c843966c556d ("mm: allow swappiness that prefers reclaiming
anon over the file workingset") has expended the swappiness value to
make swap to be preferred in some systems. We should also change the
memcg swappiness restriction to allow memcg swap-preferred.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6580c23..988fc94 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4046,7 +4046,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	if (val > 100)
+	if (val > 200)
 		return -EINVAL;
 
 	if (!mem_cgroup_is_root(memcg))
-- 
1.8.3.1

