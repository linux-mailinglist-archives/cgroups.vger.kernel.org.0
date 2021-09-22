Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3507414937
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhIVMnN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 08:43:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9903 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhIVMnN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 08:43:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDyVD5hKfz8yjl;
        Wed, 22 Sep 2021 20:37:08 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:41:41 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 22
 Sep 2021 20:41:40 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/4] blk-throtl: don't warn in tg_drain_bios()
Date:   Wed, 22 Sep 2021 20:51:13 +0800
Message-ID: <20210922125115.381752-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922125115.381752-1-yukuai3@huawei.com>
References: <20210922125115.381752-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
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
index 43dee985170b..3892ead7a0b5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -644,12 +644,13 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
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
@@ -667,7 +668,7 @@ static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
 {
 	struct throtl_grp *tg;
 
-	tg = throtl_rb_first(parent_sq);
+	tg = throtl_rb_first(parent_sq, true);
 	if (!tg)
 		return;
 
@@ -1236,7 +1237,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		if (!parent_sq->nr_pending)
 			break;
 
-		tg = throtl_rb_first(parent_sq);
+		tg = throtl_rb_first(parent_sq, true);
 		if (!tg)
 			break;
 
@@ -2421,7 +2422,7 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
 {
 	struct throtl_grp *tg;
 
-	while ((tg = throtl_rb_first(parent_sq))) {
+	while ((tg = throtl_rb_first(parent_sq, false))) {
 		struct throtl_service_queue *sq = &tg->service_queue;
 		struct bio *bio;
 
-- 
2.31.1

