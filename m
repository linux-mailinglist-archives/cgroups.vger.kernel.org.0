Return-Path: <cgroups+bounces-5136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0A99FF08
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD642B21B8D
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9C14D43D;
	Wed, 16 Oct 2024 02:47:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE4433CB;
	Wed, 16 Oct 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046839; cv=none; b=QEjs54xaiLoTEVurp4O//KMG1G6/FcbS+X7gdMZJ3Qo5B0wkNGxMRJDZN4PChMjtq4C6oRyTiY4tVVJS7KwZB6/O3ce1XqG0krX9Rvmlby+duhQYUp2jpO9YMPJMcmdChp7kp3rDbHC5LIsslhKhFejjnCkZzBGdxZa1pt0bstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046839; c=relaxed/simple;
	bh=5vhbPHK3Lf0vVi0FNmnj/Mq/QQhJ12Fqy9P86uNPUiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mXJS9yOpvaPZjWad+xqem4bMQevJhR2fplq+TaUxW8sURfPp8f8T1q0U2PnzTr4G0fP//X9fdMQx6ckXTjf60s+nMAWG6M6hyWHRRzRT6aZfM+SIsXIhkQdhqiEWYd0ir44hlnDUr5ui3ojQQ2JsNYSeJrCDXVIPDZBPRwmDeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 49G2lCuv090236;
	Wed, 16 Oct 2024 10:47:12 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49G2jGh1081782;
	Wed, 16 Oct 2024 10:45:16 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XSwLB5Yyhz2PVftg;
	Wed, 16 Oct 2024 10:45:06 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 16 Oct 2024 10:45:13 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>, <xiuhong.wang.cn@gmail.com>
Subject: [PATCH V2] Revert "blk-throttle: Fix IO hang for a corner case"
Date: Wed, 16 Oct 2024 10:45:08 +0800
Message-ID: <20241016024508.3340330-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49G2jGh1081782

This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.

The main purpose of this patch is cleanup.
The throtl_adjusted_limit function was removed after
commit bf20ab538c81 ("blk-throttle: remove
CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
able to scale after setting bps or iops to 1 will not occur.
So revert this commit that bps/iops can be set to 1.

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
V1 -> V2: Updated description to clarify this is mostly a cleanup
---
 block/blk-throttle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c4192e12efa..443d1f47c2ce 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1485,13 +1485,13 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -EINVAL;
-		if (!strcmp(tok, "rbps") && val > 1)
+		if (!strcmp(tok, "rbps"))
 			v[0] = val;
-		else if (!strcmp(tok, "wbps") && val > 1)
+		else if (!strcmp(tok, "wbps"))
 			v[1] = val;
-		else if (!strcmp(tok, "riops") && val > 1)
+		else if (!strcmp(tok, "riops"))
 			v[2] = min_t(u64, val, UINT_MAX);
-		else if (!strcmp(tok, "wiops") && val > 1)
+		else if (!strcmp(tok, "wiops"))
 			v[3] = min_t(u64, val, UINT_MAX);
 		else
 			goto out_finish;
-- 
2.25.1


