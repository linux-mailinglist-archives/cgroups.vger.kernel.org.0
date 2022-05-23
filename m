Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17D530B3D
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiEWINI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiEWINE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 04:13:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4E5586;
        Mon, 23 May 2022 01:13:01 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L697F59wJzDqNj;
        Mon, 23 May 2022 16:12:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 16:12:59 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 16:12:58 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v4 3/4] blk-throttle: factor out code to calculate ios/bytes_allowed
Date:   Mon, 23 May 2022 16:26:32 +0800
Message-ID: <20220523082633.2324980-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523082633.2324980-1-yukuai3@huawei.com>
References: <20220523082633.2324980-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No functional changes, new apis will be used in later patches to handle
throttled bios while updating config.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 48 +++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7e0c31e920dd..ded0d30ef49e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -754,25 +754,12 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
 }
 
-static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
-				  u32 iops_limit, unsigned long *wait)
+static unsigned int calculate_io_allowed(u32 iops_limit,
+					 unsigned long jiffy_elapsed_rnd)
 {
-	bool rw = bio_data_dir(bio);
 	unsigned int io_allowed;
-	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
-	if (iops_limit == UINT_MAX) {
-		if (wait)
-			*wait = 0;
-		return true;
-	}
-
-	jiffy_elapsed = jiffies - tg->slice_start[rw];
-
-	/* Round up to the next throttle slice, wait time must be nonzero */
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-
 	/*
 	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
 	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
@@ -788,6 +775,33 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	else
 		io_allowed = tmp;
 
+	return io_allowed;
+}
+
+static u64 calculate_bytes_allowed(u64 bps_limit,
+				   unsigned long jiffy_elapsed_rnd)
+{
+	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed_rnd, (u64)HZ);
+}
+
+static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
+				  u32 iops_limit, unsigned long *wait)
+{
+	bool rw = bio_data_dir(bio);
+	unsigned int io_allowed;
+	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
+
+	if (iops_limit == UINT_MAX) {
+		if (wait)
+			*wait = 0;
+		return true;
+	}
+
+	jiffy_elapsed = jiffies - tg->slice_start[rw];
+
+	/* Round up to the next throttle slice, wait time must be nonzero */
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
@@ -824,9 +838,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed_rnd,
-					    (u64)HZ);
-
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
-- 
2.31.1

