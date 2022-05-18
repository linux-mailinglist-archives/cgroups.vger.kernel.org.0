Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3C52B36C
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiERHOU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiERHOT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 03:14:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7CC108AB8;
        Wed, 18 May 2022 00:14:11 -0700 (PDT)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L34320FdzzhZ90;
        Wed, 18 May 2022 15:13:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 15:14:09 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 15:14:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 2/2] blk-throttle: fix io hung due to configuration updates
Date:   Wed, 18 May 2022 15:27:51 +0800
Message-ID: <20220518072751.1188163-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220518072751.1188163-1-yukuai3@huawei.com>
References: <20220518072751.1188163-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

If new configuration is submitted while a bio is throttled, then new
waiting time is recaculated regardless that the bio might aready wait
for some time:

tg_conf_updated
 throtl_start_new_slice
  tg_update_disptime
  throtl_schedule_next_dispatch

Then io hung can be triggered by always submmiting new configuration
before the throttled bio is dispatched.

Fix the problem by respecting the time that throttled bio aready waited.
In order to do that, instead of start new slice in tg_conf_updated(),
just update 'bytes_disp' and 'io_disp' based on the new configuration.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 64 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6f69859eae23..1c3dfd3d3d9a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1271,7 +1271,42 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void tg_conf_updated(struct throtl_grp *tg, bool global)
+static u64 throtl_update_bytes_disp(u64 dispatched, u64 new_limit,
+				    u64 old_limit)
+{
+	if (new_limit == old_limit)
+		return dispatched;
+
+	if (new_limit == U64_MAX)
+		return 0;
+
+	return dispatched * new_limit / old_limit;
+}
+
+static u32 throtl_update_io_disp(u32 dispatched, u32 new_limit, u32 old_limit)
+{
+	if (new_limit == old_limit)
+		return dispatched;
+
+	if (new_limit == UINT_MAX)
+		return 0;
+
+	return dispatched * new_limit / old_limit;
+}
+
+static void throtl_update_slice(struct throtl_grp *tg, u64 *old_limits)
+{
+	tg->bytes_disp[READ] = throtl_update_bytes_disp(tg->bytes_disp[READ],
+			tg_bps_limit(tg, READ), old_limits[0]);
+	tg->bytes_disp[WRITE] = throtl_update_bytes_disp(tg->bytes_disp[WRITE],
+			tg_bps_limit(tg, WRITE), old_limits[1]);
+	tg->io_disp[READ] = throtl_update_io_disp(tg->io_disp[READ],
+			tg_iops_limit(tg, READ), (u32)old_limits[2]);
+	tg->io_disp[WRITE] = throtl_update_io_disp(tg->io_disp[WRITE],
+			tg_iops_limit(tg, WRITE), (u32)old_limits[3]);
+}
+
+static void tg_conf_updated(struct throtl_grp *tg, u64 *old_limits, bool global)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 	struct cgroup_subsys_state *pos_css;
@@ -1310,16 +1345,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 				parent_tg->latency_target);
 	}
 
-	/*
-	 * We're already holding queue_lock and know @tg is valid.  Let's
-	 * apply the new config directly.
-	 *
-	 * Restart the slices for both READ and WRITES. It might happen
-	 * that a group's limit are dropped suddenly and we don't want to
-	 * account recently dispatched IO with new low rate.
-	 */
-	throtl_start_new_slice(tg, READ);
-	throtl_start_new_slice(tg, WRITE);
+	throtl_update_slice(tg, old_limits);
 
 	if (tg->flags & THROTL_TG_PENDING) {
 		tg_update_disptime(tg);
@@ -1327,6 +1353,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	}
 }
 
+static void tg_get_limits(struct throtl_grp *tg, u64 *limits)
+{
+	limits[0] = tg_bps_limit(tg, READ);
+	limits[1] = tg_bps_limit(tg, WRITE);
+	limits[2] = tg_iops_limit(tg, READ);
+	limits[3] = tg_iops_limit(tg, WRITE);
+}
+
 static ssize_t tg_set_conf(struct kernfs_open_file *of,
 			   char *buf, size_t nbytes, loff_t off, bool is_u64)
 {
@@ -1335,6 +1369,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	int ret;
 	u64 v;
+	u64 old_limits[4];
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
 	if (ret)
@@ -1347,13 +1382,14 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 		v = U64_MAX;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_get_limits(tg, old_limits);
 
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
 	else
 		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
 
-	tg_conf_updated(tg, false);
+	tg_conf_updated(tg, old_limits, false);
 	ret = 0;
 out_finish:
 	blkg_conf_finish(&ctx);
@@ -1523,6 +1559,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct blkg_conf_ctx ctx;
 	struct throtl_grp *tg;
 	u64 v[4];
+	u64 old_limits[4];
 	unsigned long idle_time;
 	unsigned long latency_time;
 	int ret;
@@ -1533,6 +1570,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		return ret;
 
 	tg = blkg_to_tg(ctx.blkg);
+	tg_get_limits(tg, old_limits);
 
 	v[0] = tg->bps_conf[READ][index];
 	v[1] = tg->bps_conf[WRITE][index];
@@ -1624,7 +1662,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			tg->td->limit_index = LIMIT_LOW;
 	} else
 		tg->td->limit_index = LIMIT_MAX;
-	tg_conf_updated(tg, index == LIMIT_LOW &&
+	tg_conf_updated(tg, old_limits, index == LIMIT_LOW &&
 		tg->td->limit_valid[LIMIT_LOW]);
 	ret = 0;
 out_finish:
-- 
2.31.1

