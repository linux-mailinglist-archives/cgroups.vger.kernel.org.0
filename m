Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADD45FDE1
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354341AbhK0KEP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:15 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28181 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353795AbhK0KCN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:13 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J1Rq346b6z8vg2;
        Sat, 27 Nov 2021 17:57:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:58:49 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:58:48 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@infradead.org>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/4] blk-throtl: don't warn in tg_drain_bios()
Date:   Sat, 27 Nov 2021 18:10:57 +0800
Message-ID: <20211127101059.477405-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211127101059.477405-1-yukuai3@huawei.com>
References: <20211127101059.477405-1-yukuai3@huawei.com>
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

tg_drain_bios() will iterate until throtl_rb_first() return NULL,
don't warn in such situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 230e300c5856..25822c88bea1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -497,12 +497,13 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 }
 
 static struct throtl_grp *
-throtl_rb_first(struct throtl_service_queue *parent_sq)
+throtl_rb_first(struct throtl_service_queue *parent_sq, bool warn)
 {
 	struct rb_node *n;
 
 	n = rb_first_cached(&parent_sq->pending_tree);
-	WARN_ON_ONCE(!n);
+	if (warn)
+		WARN_ON_ONCE(!n);
 	if (!n)
 		return NULL;
 	return rb_entry_tg(n);
@@ -520,7 +521,7 @@ static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
 {
 	struct throtl_grp *tg;
 
-	tg = throtl_rb_first(parent_sq);
+	tg = throtl_rb_first(parent_sq, true);
 	if (!tg)
 		return;
 
@@ -1089,7 +1090,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		if (!parent_sq->nr_pending)
 			break;
 
-		tg = throtl_rb_first(parent_sq);
+		tg = throtl_rb_first(parent_sq, true);
 		if (!tg)
 			break;
 
@@ -2266,7 +2267,7 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
 {
 	struct throtl_grp *tg;
 
-	while ((tg = throtl_rb_first(parent_sq))) {
+	while ((tg = throtl_rb_first(parent_sq, false))) {
 		struct throtl_service_queue *sq = &tg->service_queue;
 		struct bio *bio;
 
-- 
2.31.1

