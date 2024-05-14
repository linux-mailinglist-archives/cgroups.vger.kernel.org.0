Return-Path: <cgroups+bounces-2880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7A8C5719
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0556B1F221CF
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804E170883;
	Tue, 14 May 2024 13:18:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3D16F914;
	Tue, 14 May 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692695; cv=none; b=rHXTAG1coYNslmTtAirp84wtLJU9j5juHX6DUBQCotcY93dgQDh/m6dP+hlKBVcTu6KAcRlqpg7eFhexkPEnG5huQ2IzSaQ1qVHVMxCvpuYpG7ZzleA/AgnTtOPV9FJIpBdi5/Bt7JTk4rlgGQYSbg3tHOznKPbOlKMuNP/dJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692695; c=relaxed/simple;
	bh=u3zZKvp/Li0Baa2NbytJvsymp3HNHzVCO1pa5Z3LiJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6EtiINK2tVrAG4WVybavPGeEB1qWHEbAk1p2jrEl9Jf5arA1fi4fImUU9mS5/X6atX9F4uJhrAndR7Keq7GvZsMChzZKm0aJNG454UxfatdahKZgzq3yLz+KkZBbxbWLzeUPMk2LLxF7Tr2MaFC/JGQ+NKV8hvKQr04rq3QiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vdxf438tkzkXWs;
	Tue, 14 May 2024 21:14:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 41EAB18007E;
	Tue, 14 May 2024 21:18:09 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 21:18:09 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] memcg: don't handle event_list for v2 when offlining
Date: Tue, 14 May 2024 13:11:06 +0000
Message-ID: <20240514131106.1326323-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

The event_list for memcg is only valid for v1 and not used for v2,
so it's unnessesary to handle event_list for v2.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d127c9c5fabf..4254f9cd05f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5881,12 +5881,14 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
 	 * directory to avoid race between userspace and kernelspace.
 	 */
-	spin_lock_irq(&memcg->event_list_lock);
-	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
-		list_del_init(&event->list);
-		schedule_work(&event->remove);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		spin_lock_irq(&memcg->event_list_lock);
+		list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
+			list_del_init(&event->list);
+			schedule_work(&event->remove);
+		}
+		spin_unlock_irq(&memcg->event_list_lock);
 	}
-	spin_unlock_irq(&memcg->event_list_lock);
 
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-- 
2.34.1


