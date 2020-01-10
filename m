Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C28136847
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 08:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgAJH1r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 02:27:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbgAJH1r (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 Jan 2020 02:27:47 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E7DB746A150E3193FEE7;
        Fri, 10 Jan 2020 15:27:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:27:36 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] cgroup: fix function name in comment
Date:   Fri, 10 Jan 2020 15:23:20 +0800
Message-ID: <20200110072320.85605-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Function name cgroup_rstat_cpu_pop_upated() in comment should be
cgroup_rstat_cpu_pop_updated().

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/cgroup/rstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b48b22d..6f87352 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -33,7 +33,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		return;
 
 	/*
-	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
+	 * Paired with the one in cgroup_rstat_cpu_pop_updated().  Either we
 	 * see NULL updated_next or they see our updated stat.
 	 */
 	smp_mb();
-- 
2.7.4

