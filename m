Return-Path: <cgroups+bounces-2703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634E8B1E28
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685CA1C21D0A
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100784D3E;
	Thu, 25 Apr 2024 09:36:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43584D0D;
	Thu, 25 Apr 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037817; cv=none; b=KbF/795+4rbD1EK+8ou/pRrmTd5D/02menh8eE1niyswSAnJS4NFEFKV/QlpPGMEGBBtmYWGbHiS6icxab3Ety8+WP/jeOitmLfOiWiw050ch9T4llhaN7zcMb0f2OVLFH2UYvhaCWmG+fR75AfB1UPzPLSkt4iPE8Y2D6XYw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037817; c=relaxed/simple;
	bh=3pcvK761P/K013DEjR4SL5qt0B7VaKS/V6j9YjhSotg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oh2EcoBlmKsDDBJDZxAgH9jhnweKrt1xHqfVnAOEirU/x76+DNCXvV+fh4pUZRnK+0es1taxoswTXdehRlKTQGsQjrLTba6vBcX2ENINWAREeeaDpm1S5NWGja1NDrrEjDspsXDPFVVaqxlD8jRGIi9L4Nl1kbCcebitKOwb6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQ9dX4nXQzXlPP;
	Thu, 25 Apr 2024 17:33:20 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D879180A9F;
	Thu, 25 Apr 2024 17:36:51 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 17:36:51 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Remove outdated comment in sched_partition_write()
Date: Thu, 25 Apr 2024 09:30:16 +0000
Message-ID: <20240425093016.1068567-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

The comment here is outdated and can cause confusion, from the code
perspective, there’s also no need for new comment, so just remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f5443c039619..a10e4bd0c0c1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3774,9 +3774,6 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
 	buf = strstrip(buf);
 
-	/*
-	 * Convert "root" to ENABLED, and convert "member" to DISABLED.
-	 */
 	if (!strcmp(buf, "root"))
 		val = PRS_ROOT;
 	else if (!strcmp(buf, "member"))
-- 
2.34.1


