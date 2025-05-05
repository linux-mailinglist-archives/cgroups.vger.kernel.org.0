Return-Path: <cgroups+bounces-8027-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C35AAA9FF
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE63A5446
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3135AD90;
	Mon,  5 May 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLFhGxn7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86121364CE1;
	Mon,  5 May 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485164; cv=none; b=WjTdUtHJSTrDEg9IA1IefHAfyDgjfDCqaxV+EID/cgXkpFbDxxOoUd4JsCQj2h6BVHAPND2esO6itqrn7xFXt5wBHcBhau7hhU/VJwFXIMrxOotJedyDyOpV8r7jcZszzWfyyDz15uSLOVUlK/zQinaCEG+NUtgRSp3pGz0JGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485164; c=relaxed/simple;
	bh=8QG2JEc/XDbVunCQ1nHXCEhHcU6dQ7rNYCL/gowOj5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMhf7wNYKxffA1pTb1Cu4DoKURF5k2gmCGo8JNQ52tzvolapavoOjAIlSYFNsDYW8zAPyG724qI5xrcR7ELzCOs5s83+FszTouiJp3UnehYa2Y1gKZsgyOM5Yqfrgvql7uGKC/Cktbv1KyiKOHLeMW8Lk24dIQiJnN5W2RSiJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLFhGxn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB81CC4CEE4;
	Mon,  5 May 2025 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485163;
	bh=8QG2JEc/XDbVunCQ1nHXCEhHcU6dQ7rNYCL/gowOj5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLFhGxn7hRICeORQ+/bG0OJWdnVZwkVom2PHv+aPjJJ79djgbXJhkTFqkDUyAQzXD
	 T6I3e+NZzEgueRMBeMXUFSdMk3/HM3l94LTTd4v2zRLPH/HLJ/sk/UYgagxELzhwCH
	 UA4GBZT+da391oc/ZOYsxop+aS+M9Yg9Db0/ohkhEqGmMm1t7vopdfWoIWvghkColm
	 bjLDnz+37MQFnq9ewZE4NIZdmvwVd3KZDhixBm+WfrVyxvj3hAp9OryuQsLFTBWHSO
	 qDVPeg2HwLAt+w80I1YVdioeKG2+IhBOoXx3WwKUS2EFZSuLcmgeE/k4XCaxUGC3MW
	 U8oyKQuw/JLEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 194/486] blk-throttle: don't take carryover for prioritized processing of metadata
Date: Mon,  5 May 2025 18:34:30 -0400
Message-Id: <20250505223922.2682012-194-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a9fc8868b350cbf4ff730a4ea9651319cc669516 ]

Commit 29390bb5661d ("blk-throttle: support prioritized processing of metadata")
takes bytes/ios carryover for prioritized processing of metadata. Turns out
we can support it by charging it directly without trimming slice, and the
result is same with carryover.

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20250305043123.3938491-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c4192e12efab..6b82fcbd7e774 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1593,13 +1593,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 	return tg_may_dispatch(tg, bio, NULL);
 }
 
-static void tg_dispatch_in_debt(struct throtl_grp *tg, struct bio *bio, bool rw)
-{
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
-		tg->carryover_bytes[rw] -= throtl_bio_data_size(bio);
-	tg->carryover_ios[rw]--;
-}
-
 bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -1636,10 +1629,12 @@ bool __blk_throtl_bio(struct bio *bio)
 			/*
 			 * IOs which may cause priority inversions are
 			 * dispatched directly, even if they're over limit.
-			 * Debts are handled by carryover_bytes/ios while
-			 * calculating wait time.
+			 *
+			 * Charge and dispatch directly, and our throttle
+			 * control algorithm is adaptive, and extra IO bytes
+			 * will be throttled for paying the debt
 			 */
-			tg_dispatch_in_debt(tg, bio, rw);
+			throtl_charge_bio(tg, bio);
 		} else {
 			/* if above limits, break to queue */
 			break;
-- 
2.39.5


