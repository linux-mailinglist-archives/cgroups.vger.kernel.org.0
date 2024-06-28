Return-Path: <cgroups+bounces-3442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EB91B869
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD251F22F59
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD813C83C;
	Fri, 28 Jun 2024 07:31:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CD14373F;
	Fri, 28 Jun 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559912; cv=none; b=VWDl/E6XT5nFb6hDdIq0R5gyFfUnoYXjNlMlnvF0W64HlKM9E2cNO2s6zGkgS7wNnlLXJmN5uZNW8cuZVKm6APEtFTekWAELyja54E9xObpFvFTRxHfPo7MzkBo1v2TZcUDDhKpHbC1XYj6Gge4dDRBXgT/AF0j+9yLzJDACfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559912; c=relaxed/simple;
	bh=W8hIukQv0ev9fNxEyLp2AafwZ6u5tbSJgL++dWX7JPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPMsUUv6SLZuWBPbQn2Dm86ZPfvBdiwcdZHmMxHQsbkMZV1wAYAnqQl+PcQ+Fv57x7C4AwHv+2CguDt4r1VHv5VKDxDdT8qkmOPHJNc5OMsAmfLazrW4vGu/HZ0YanSfUG15ZpMR6y9ABxteH4+ux6iQqbh/dJULDjKIaGnxf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4W9Rsv3S7Lz1xt4G;
	Fri, 28 Jun 2024 15:30:11 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id D2DCE1A016C;
	Fri, 28 Jun 2024 15:31:41 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:31:41 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm: memcg: adjust the warning when seq_buf overflows
Date: Fri, 28 Jun 2024 07:23:33 +0000
Message-ID: <20240628072333.2496527-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Currently it uses WARN_ON_ONCE() if seq_buf overflows when user reads
memory.stat, the only advantage of WARN_ON_ONCE is that the splat is
so verbose that it gets noticed. And also it panics the system if
panic_on_warn is enabled. It seems like the warning is just an over
reaction and a simple pr_warn should just achieve the similar effect.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c251bbe35f4b..8e5590ac43d7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1484,7 +1484,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		memcg_stat_format(memcg, s);
 	else
 		memcg1_stat_format(memcg, s);
-	WARN_ON_ONCE(seq_buf_has_overflowed(s));
+	if (seq_buf_has_overflowed(s))
+		pr_warn("%s: Warning, stat buffer overflow, please report\n", __func__);
 }
 
 /**
-- 
2.34.1


