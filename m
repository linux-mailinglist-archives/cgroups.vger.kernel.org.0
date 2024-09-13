Return-Path: <cgroups+bounces-4875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E9978117
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920791C227F3
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08671DB93A;
	Fri, 13 Sep 2024 13:25:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09881DA62B;
	Fri, 13 Sep 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233939; cv=none; b=d2r6H5eJW3kug5SezqrgsB6uEkJ57DcOMwJRtykhvS2E1o91GyN1ZRLhXh2caRZc1zhKkRTjNnLSoo3E6vOOE/hFKpwC7134pFxZNK2y8mXAwbU6++vuh/BOD0HAnuhAfWd8SP0PsQzjdQ/kbv+96jV+sIrDoSB0YQXsnVRh3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233939; c=relaxed/simple;
	bh=VFN9R0auFtHfIEJzSpEEh6qLV1o1M/nq69Fch1WZ5wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcmOAIS1q8STogpedgsi4WAK1XPfaCDEA7BtrlLo+TAdPQo/clXBZpZolP/+CeQFxKtmGBgiFPKMPyS9Djd3Nh/QmJGPy5fQIHkE8oi9D8vgIJHEuvsEobK35Eqaf2HvE2kpVTph6x54JT/0S5eWlupN9BCezbk7HNyvgXXHHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X4w412nbqzmV6L;
	Fri, 13 Sep 2024 21:23:29 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BF6F1401F0;
	Fri, 13 Sep 2024 21:25:34 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 13 Sep
 2024 21:25:33 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
Date: Fri, 13 Sep 2024 13:17:20 +0000
Message-ID: <20240913131720.1762188-4-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913131720.1762188-1-chenridong@huawei.com>
References: <20240913131720.1762188-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

WQ_MAX_ACTIVE is currently set to 512, which was established approximately
15 yeas ago. However, with the significant increase in machine sizes and
capabilities, the previous limit of 256 concurrent tasks is no longer
sufficient. Therefore, we propose to increase WQ_MAX_ACTIVE to 2048.
and WQ_DFL_ACTIVE is 1024 now.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/core-api/workqueue.rst | 4 ++--
 include/linux/workqueue.h            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 338b25e86f8c..b66b55d35c9c 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -245,8 +245,8 @@ CPU which can be assigned to the work items of a wq. For example, with
 at the same time per CPU. This is always a per-CPU attribute, even for
 unbound workqueues.
 
-The maximum limit for ``@max_active`` is 512 and the default value used
-when 0 is specified is 256. These values are chosen sufficiently high
+The maximum limit for ``@max_active`` is 2048 and the default value used
+when 0 is specified is 1024. These values are chosen sufficiently high
 such that they are not the limiting factor while providing protection in
 runaway cases.
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 59c2695e12e7..b0dc957c3e56 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,7 +412,7 @@ enum wq_flags {
 };
 
 enum wq_consts {
-	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
+	WQ_MAX_ACTIVE		= 2048,	  /* I like 2048, better ideas? */
 	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
 
-- 
2.34.1


