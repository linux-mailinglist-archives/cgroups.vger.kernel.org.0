Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4892C405869
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244375AbhIIOBF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 10:01:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15400 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354430AbhIIN7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 09:59:32 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H50qH03yczQslG;
        Thu,  9 Sep 2021 21:54:19 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 21:58:20 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 9 Sep
 2021 21:58:20 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup v2
Date:   Thu, 9 Sep 2021 22:08:15 +0800
Message-ID: <20210909140815.2600858-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We want to limit the overall iops/bps of the device in cgroup v2,
however "io.max" or "io.min" do not exist in root cgroup currently,
which makes it impossible.

This patch enables io throttle for root cgroup:
 - enable "io.max" and "io.min" in root
 - don't skip root group in tg_iops_limit() and tg_bps_limit()
 - don't skip root group in tg_conf_updated()

I'm not sure why this feature is disabled in the first place, is
there any problem or design constraint?

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 55c49015e533..fffe072de538 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -302,9 +302,6 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	uint64_t ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return U64_MAX;
-
 	td = tg->td;
 	ret = tg->bps[rw][td->limit_index];
 	if (ret == 0 && td->limit_index == LIMIT_LOW) {
@@ -332,9 +329,6 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	struct throtl_data *td;
 	unsigned int ret;
 
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
-		return UINT_MAX;
-
 	td = tg->td;
 	ret = tg->iops[rw][td->limit_index];
 	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
@@ -1430,9 +1424,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
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
@@ -1771,7 +1764,6 @@ static struct cftype throtl_files[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	{
 		.name = "low",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
 		.write = tg_set_limit,
 		.private = LIMIT_LOW,
@@ -1779,7 +1771,6 @@ static struct cftype throtl_files[] = {
 #endif
 	{
 		.name = "max",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
 		.write = tg_set_limit,
 		.private = LIMIT_MAX,
-- 
2.31.1

