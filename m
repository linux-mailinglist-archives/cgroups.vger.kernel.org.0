Return-Path: <cgroups+bounces-3925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA393E006
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413142823FE
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A30183072;
	Sat, 27 Jul 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="M2biYF7e"
X-Original-To: cgroups@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1824D8BE;
	Sat, 27 Jul 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095920; cv=none; b=kdQezhK7JEnzvrTirWSMazYjNy0m77dUGZmGoMcoQHUt2Zbb4ZvhynokwFPxw5MbTryatFcz0zGl3Dh9ldmyOP2zeJghU3/mPunxgEfJxTg7f6jPnWdPcR0nv/75XIERglUjTBe7qddDHNm2Bg2bDNtA8xnRJsDx5wq2DYrN1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095920; c=relaxed/simple;
	bh=x6IyoTE5dj51FTd2P3xGCQdjOKFeRCEaJwFtXzrxKPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anVCcC5xYdKwamWaBp1aihxBfaRS2i09LnYlQt3MfaTKrLXERj4+4Gx57KguekkubJTqcBzJzlYOEPVCa1iJZsUYYi2wx43bQii64ZumqrZlS+YHdpZtl30EVm09VF44d+GGU/zFwc7UI5KtHvsvHFZKGgQRHHPVWKjO7RlIHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=M2biYF7e; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Okm9crTTIheYvc94kS2QL2iknm5yDgMOAzJHl8OWFpQ=; b=M2biYF7eQbo2TxXJ
	nEVVKzg68hpJ5rdSiXfqspxGi8myyQ7duhNgHFH9UELg9GtdiobY1IAnLPWjluL3+Pm5FeD85OXL0
	YLNtSNlXW5JgN5/PC9LKLiHxxC8yrbzw3zeTefPgyJJAF78HERZdaon3ZKqDmC5fBUkPsmkjqpmVV
	Ljq9tgOuN11qHaNrkYDkL9F2IazJmKESkSM29SM1Z7epj1Rdjd6kdd/v4WM8UtgT8EGLjIoe0xwfT
	F6xHzGhbuqnn3UeZ1Y2hxiceqzXz45e/Gu1RwEauCBhjR1i6vDYhnpMWKoa6g0/YTFd9uofL6i2Wr
	xkjUGWIkH57dYglBLQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sXjoS-00DYij-36;
	Sat, 27 Jul 2024 15:58:28 +0000
From: linux@treblig.org
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] blk-throttle: remove more latency dead-code
Date: Sat, 27 Jul 2024 16:58:24 +0100
Message-ID: <20240727155824.1000042-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The struct 'latency_bucket' and the #define 'request_bucket_index'
are unused since
commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")

and the 'LATENCY_BUCKET_SIZE' #define was only used by the
'request_bucket_index' define.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 block/blk-throttle.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc6140fa3de0..6943ec720f39 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -31,14 +31,6 @@ static struct workqueue_struct *kthrotld_workqueue;
 
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
-/* We measure latency for request size from <= 4k to >= 1M */
-#define LATENCY_BUCKET_SIZE 9
-
-struct latency_bucket {
-	unsigned long total_latency; /* ns / 1024 */
-	int samples;
-};
-
 struct throtl_data
 {
 	/* service tree for active throtl groups */
@@ -116,9 +108,6 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	return tg->iops[rw];
 }
 
-#define request_bucket_index(sectors) \
-	clamp_t(int, order_base_2(sectors) - 3, 0, LATENCY_BUCKET_SIZE - 1)
-
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
-- 
2.45.2


