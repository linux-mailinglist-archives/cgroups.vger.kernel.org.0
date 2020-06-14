Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34321F8634
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2020 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFNC27 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Jun 2020 22:28:59 -0400
Received: from m12-16.163.com ([220.181.12.16]:52391 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFNC27 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 13 Jun 2020 22:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R2b6w
        Jp/Gu3jW9BF0+d6Dg/51CAAqjCiWDo1SliDiWA=; b=NRrOvDxTUB4AvIdiCo2Vw
        WLW6zJBowDWDOya8eb6S6BLRqku4qH6P5hOc/IZ4POav5Z6eyUzpppDC5BOFs+bS
        f7uRI0jtsvwe6ML8rAFmPxUy7ZQOALv7irQFO6FQj929RoN351ai1NZqItdKqzYM
        6p3P56+zW5pCTeMZ/yxguU=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp12 (Coremail) with SMTP id EMCowADHshZdi+Ve7N19IA--.22765S2;
        Sun, 14 Jun 2020 10:28:45 +0800 (CST)
From:   zzuedu2000@163.com
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, songmuchun@bytedance.com,
        buddy.zhang@aliyun.com, Wei Fenghai <zzuedu2000@163.com>
Subject: [PATCH] cgroup: Refactor two assignments in css_task_iter_next_css_set()
Date:   Sun, 14 Jun 2020 10:28:33 +0800
Message-Id: <20200614022833.2641-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHshZdi+Ve7N19IA--.22765S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fAF1Dur4xKryUtw1rXrb_yoWxZwc_A3
        4rXw1xKrySyw1qyrZ5Zws3Xa97Ka1rKrWv9r17KrW7AF1DJrs8JwnxKF1DJrsru3Z3Cr98
        ur9akF95KF4DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE75rDUUUUU==
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbivxdDQlWBqVkS5gABs4
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Wei Fenghai <zzuedu2000@163.com>

Combine two assignments for the variable ‘l’ into one statement.

Signed-off-by: Wei Fenghai <zzuedu2000@163.com>
---
 kernel/cgroup/cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1ea181a58465..c3e6db6e44d8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4352,8 +4352,7 @@ static struct css_set *css_task_iter_next_css_set(struct css_task_iter *it)
 	}
 
 	/* find the next cset */
-	l = it->cset_pos;
-	l = l->next;
+	l = it->cset_pos->next;
 	if (l == it->cset_head) {
 		it->cset_pos = NULL;
 		return NULL;
-- 
2.17.1


