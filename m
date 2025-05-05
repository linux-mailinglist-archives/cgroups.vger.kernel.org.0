Return-Path: <cgroups+bounces-8023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD6AAA36C
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 01:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CECE1A85884
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB728982E;
	Mon,  5 May 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V033UrVp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04865289824;
	Mon,  5 May 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483836; cv=none; b=qL0++5yjV8WlOyCDrqHpVkii3NPoBtrnjxJiuk8MtG4oCPnX90NrP03sKpUYzFUfxA0Ru7fMA7f9fKcgXb9Y/vCraVJlUiyEGuZpLNGYUotDMMESPd0+KqR4XUu9xU/gby98HiKfc6qlBPwkOcRKIHjs7h6pN8O0+FjfgmJELIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483836; c=relaxed/simple;
	bh=XmWMk+Ba2iArw1ezQbXZlXhYZ6G1tQ/+fL2d+R370Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4+/F3wy3mfm66qeLPY/Gi7tWEAapN+fTaK5ca0Rr37wUlvgfcJ09IP7Sm4BnaTODqF3ZsbtjBEUQt9qADvF9/6KF13D7zgFJwljeloPu9p16HryJxwl/SimEOQ4KgzsXqdjPvtLcIw7QegosrGHp+NWHGls8lzdKWxFH0oqE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V033UrVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62044C4CEEE;
	Mon,  5 May 2025 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483835;
	bh=XmWMk+Ba2iArw1ezQbXZlXhYZ6G1tQ/+fL2d+R370Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V033UrVpSWFvTs9smvV34RNMMYLB7XjTPxDxgvryFRc+BvWdKrwpGt9Ucd4QcE6yQ
	 axb503jRRy+WwvkCYC3Xu5by0kRCa/7SXuk1GW7znrBf230WWaBtEsih6Mz/wLooZ1
	 12iKiO+vm3Bz0opW/9rRSWWzxR6/uaV4txyAW0sKONGZEu0yHlM7E2CkgGVfxso7Tb
	 /VDhpIqnZk/BPYTnb4DUJXDpnPlRkHTf5ZVwgedHYj97YdDdMWL5xsyVQF/0d1XU1R
	 yq0kOZwo6bELU0YYyXlgjMh7+BQBaTsupyh2remWWqk0pKGNYqFlryvOhWRI3bM23J
	 YGUCkqAslbqmg==
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
Subject: [PATCH AUTOSEL 6.14 243/642] blk-throttle: don't take carryover for prioritized processing of metadata
Date: Mon,  5 May 2025 18:07:39 -0400
Message-Id: <20250505221419.2672473-243-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index a52f0d6b40ad4..762fbbd388c87 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1623,13 +1623,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
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
@@ -1666,10 +1659,12 @@ bool __blk_throtl_bio(struct bio *bio)
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


