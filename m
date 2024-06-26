Return-Path: <cgroups+bounces-3376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4323917CEF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B3D1C222B5
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415916EB40;
	Wed, 26 Jun 2024 09:50:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4016DC0F;
	Wed, 26 Jun 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395443; cv=none; b=mW5uTJ8OgHEilnP226UFku4ld/IPb9hBrXqY4IyvGkLIwxvS3gyUrz1jYsHIrvCXqndUDWPeXvsVBFxv89YYyUCNlyHbQDeFMJVJ0pwmrWYei8PdEeb3aHrDNIktJ/4Z9u3Dkjzla41nmHqCucXgfibZxUz4gwnOvuSIF1d3l/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395443; c=relaxed/simple;
	bh=6ODZGI61b1WJDcimhYjCBP/Mw49nF+azQMXjE7SdsdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmXKurlVHiLPt+PpBX6D7i4qPF6hrwuhUctnufkFWiJs4NpSgRhu5t8Gf+M+vMJWlhomzzdkGYkYavCy4HlV3taUbfjcw5fB7RJL3HqDaW6LxO4BFaF4nh/rDiMp3pD57CV2qPjtaVp7F5ExY0o5+df4rZ9hpPiafDO7DieiX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W8H4l6t1KznXgs;
	Wed, 26 Jun 2024 17:50:31 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 22048180086;
	Wed, 26 Jun 2024 17:50:38 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 17:50:37 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm: memcg: remove redundant seq_buf_has_overflowed()
Date: Wed, 26 Jun 2024 09:42:32 +0000
Message-ID: <20240626094232.2432891-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Both the end of memory_stat_format() and memcg_stat_format() will call
WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
is the only caller of memcg_stat_format(), when memcg is on the default
hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
the reduntant one.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 974bd160838c..776d22bc66a2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1846,9 +1846,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
-
-	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
 static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
-- 
2.34.1


