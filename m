Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEE48E748
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 10:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiANJS5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 04:18:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17347 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiANJS4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 04:18:56 -0500
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZwgX5M9xz9sBr;
        Fri, 14 Jan 2022 17:17:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 14 Jan 2022 17:18:54 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 14 Jan
 2022 17:18:53 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next] blk-throttle: enable io throttle for root in cgroup v2
Date:   Fri, 14 Jan 2022 17:30:00 +0800
Message-ID: <20220114093000.3323470-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RFC patch: https://lkml.org/lkml/2021/9/9/1432

There is a proformance problem in our environment:

A host can provide a remote device to difierent client. If one client is
under high io pressure, other clients might be affected.

Limit the overall iops/bps(io.max) from the client can fix the problem,
however, config files do not exist in root cgroup currently, which makes
it impossible.

This patch enables io throttle for root cgroup:
 - enable "io.max" and "io.low" in root
 - don't skip root group in tg_iops_limit() and tg_bps_limit()
 - don't skip root group in tg_conf_updated()

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..ac25bfbbfe7f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -156,9 +156,6 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	uint64_t ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return U64_MAX;
-
 	td = tg->td;
 	ret = tg->bps[rw][td->limit_index];
 	if (ret == 0 && td->limit_index == LIMIT_LOW) {
@@ -186,9 +183,6 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	unsigned int ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return UINT_MAX;
-
 	td = tg->td;
 	ret = tg->iops[rw][td->limit_index];
 	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
@@ -1284,9 +1278,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		struct throtl_grp *parent_tg;
 
 		tg_update_has_rules(this_tg);
-		/* ignore root/second level */
-		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent ||
-		    !blkg->parent->parent)
+		/* ignore root level */
+		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent)
 			continue;
 		parent_tg = blkg_to_tg(blkg->parent);
 		/*
@@ -1625,7 +1618,6 @@ static struct cftype throtl_files[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	{
 		.name = "low",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
 		.write = tg_set_limit,
 		.private = LIMIT_LOW,
@@ -1633,7 +1625,6 @@ static struct cftype throtl_files[] = {
 #endif
 	{
 		.name = "max",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
 		.write = tg_set_limit,
 		.private = LIMIT_MAX,
-- 
2.31.1

