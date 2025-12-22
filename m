Return-Path: <cgroups+bounces-12560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB5CD48FE
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A87C5300479D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D62FC881;
	Mon, 22 Dec 2025 02:35:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7233993;
	Mon, 22 Dec 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766370950; cv=none; b=LFSfYcFD57uWBQ3wE8GnMGevO6OjvHp3iLQ3AjUUQz+TtWrjah4J8AEsH0+pr95DC1usWBId781D0yMxBinV81KEyZABM2nn+X7ZmJEvFEG7ccThwMy0evdE7YjfVLStitgciojXZUeKOvN/9EK2N7pc7mAHcbDomwj4flDg2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766370950; c=relaxed/simple;
	bh=rpRMluFEzh3WKDzl8E+KYRGlISf8k3WDwqtCx4jyGnw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jikguzp5NVsvWNG8/GsXMYd9rIIl31fR6naNjcLaYBui2dkV0z0ChidlK8T+MY3hoAKuMwIveLTtaWFPw65qURdWvFk1LSrRNal0ndcT2NkPWjFNZjBYQIrrSdj9kTS6h4zW6YesaAGMixucoUv3cA7niDbq9jueeyVsQn6G+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dZMFZ6SXVzB7ncN;
	Mon, 22 Dec 2025 10:16:18 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 22 Dec 2025 10:19:45 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
	<yukuai@fnnas.com>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH] block: fix aux stat accumulation destination
Date: Mon, 22 Dec 2025 10:19:36 +0800
Message-ID: <20251222021937.1280-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)

Route bfqg_stats_add_aux() time accumulation into the destination
stats object instead of the source, aligning with other stat fields.

Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..6a75fe1c7a5c 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -380,7 +380,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
 	blkg_rwstat_add_aux(&to->merged, &from->merged);
 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
 	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	bfq_stat_add_aux(&from->time, &from->time);
+	bfq_stat_add_aux(&to->time, &from->time);
 	bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
 	bfq_stat_add_aux(&to->avg_queue_size_samples,
 			  &from->avg_queue_size_samples);
-- 
2.43.0


