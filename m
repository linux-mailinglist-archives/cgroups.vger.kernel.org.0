Return-Path: <cgroups+bounces-2864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7B8C4097
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F3B2275F
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883114F9C9;
	Mon, 13 May 2024 12:19:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158DF14AD02;
	Mon, 13 May 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602759; cv=none; b=Dw4L2E4FBoUZ7lmn99uK++3DQSbg2/2piWsrcYI7a8ytkv3W6N/ca5WBsyZBRVOCQBQVCgii2yuxdTQqkXeDB2r77t2mToIs1AA5n8UgTiYNe5Ob2rg7itiAqxtrfHwD77lDP7Yaej/O532XzQLu54FdmYfVkKa6WQRU9lc5AYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602759; c=relaxed/simple;
	bh=kGwJDyXDTrdeGxyVauCIhfgu5eE81vJ3XmNmSQWsYaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGZPQkva7ugm4ec6pNucbz+GWh1/3tQXSgZpHkns6/S/Kyle+hwoET3ofAHuumgTPh8NDdBsb4v6V86f9v5uKbo4zRw/FKJLHKH5Y8xh2xPv0sbhga6M0XPm5ZFax39rst2Nbwm6HDEu7nOwpnDDgvKY5JOJdn0MuxoFCMCNIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdJSL6SFTz4f3n6D;
	Mon, 13 May 2024 20:18:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 00A3D1A01D2;
	Mon, 13 May 2024 20:19:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g46BUJm8iY0Mg--.57325S5;
	Mon, 13 May 2024 20:19:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 1/2] blk-throttle: factor out a helper to get throtl_slice from tg
Date: Mon, 13 May 2024 20:08:47 +0800
Message-Id: <20240513120848.2828797-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
References: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g46BUJm8iY0Mg--.57325S5
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1DuFyfJF48Cr45XF4Utwb_yoW7XryxpF
	WfAa1jqw45Jas7KFW5uwn0yay0kws7JryUJw13Xr4rCF13t3W8JFyDZryUAa4UAas7ua1S
	y3Wqv345KF42yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, prepare to use bigger slice in the case
that iops limit is quite low in the next patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 80aaca18bfb0..69f1bb91ea78 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -489,6 +489,11 @@ static bool throtl_schedule_next_dispatch(struct throtl_service_queue *sq,
 	return false;
 }
 
+static unsigned int tg_throtl_slice(struct throtl_grp *tg, int rw)
+{
+	return tg->td->throtl_slice;
+}
+
 static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 		bool rw, unsigned long start)
 {
@@ -506,7 +511,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	if (time_after(start, tg->slice_start[rw]))
 		tg->slice_start[rw] = start;
 
-	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	tg->slice_end[rw] = jiffies + tg_throtl_slice(tg, rw);
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice with credit start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -519,7 +524,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
-	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	tg->slice_end[rw] = jiffies + tg_throtl_slice(tg, rw);
 	if (clear_carryover) {
 		tg->carryover_bytes[rw] = 0;
 		tg->carryover_ios[rw] = 0;
@@ -534,7 +539,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
 static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 					unsigned long jiffy_end)
 {
-	tg->slice_end[rw] = roundup(jiffy_end, tg->td->throtl_slice);
+	tg->slice_end[rw] = roundup(jiffy_end, tg_throtl_slice(tg, rw));
 }
 
 static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
@@ -594,6 +599,7 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
+	unsigned int slice;
 	unsigned long time_elapsed;
 	long long bytes_trim;
 	int io_trim;
@@ -616,10 +622,10 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * is bad because it does not allow new slice to start.
 	 */
 
-	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
+	slice = tg_throtl_slice(tg, rw);
+	throtl_set_slice_end(tg, rw, jiffies + slice);
 
-	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
-				 tg->td->throtl_slice);
+	time_elapsed = rounddown(jiffies - tg->slice_start[rw], slice);
 	if (!time_elapsed)
 		return;
 
@@ -647,7 +653,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%lld io=%d start=%lu end=%lu jiffies=%lu",
-		   rw == READ ? 'R' : 'W', time_elapsed / tg->td->throtl_slice,
+		   rw == READ ? 'R' : 'W', time_elapsed / slice,
 		   bytes_trim, io_trim, tg->slice_start[rw], tg->slice_end[rw],
 		   jiffies);
 }
@@ -701,7 +707,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg_throtl_slice(tg, rw));
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
 		     tg->carryover_ios[rw];
 	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
@@ -730,9 +736,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = tg->td->throtl_slice;
+		jiffy_elapsed_rnd = tg_throtl_slice(tg, rw);
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg_throtl_slice(tg, rw));
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
 			tg->carryover_bytes[rw];
 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
@@ -792,10 +798,10 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
 		throtl_start_new_slice(tg, rw, true);
 	else {
-		if (time_before(tg->slice_end[rw],
-		    jiffies + tg->td->throtl_slice))
-			throtl_extend_slice(tg, rw,
-				jiffies + tg->td->throtl_slice);
+		unsigned int slice = tg_throtl_slice(tg, rw);
+
+		if (time_before(tg->slice_end[rw], jiffies + slice))
+			throtl_extend_slice(tg, rw, jiffies + slice);
 	}
 
 	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
-- 
2.39.2


