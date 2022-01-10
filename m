Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B71489A18
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiAJNhX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 08:37:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17335 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiAJNgu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 08:36:50 -0500
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JXZb13BFbz9s86;
        Mon, 10 Jan 2022 21:35:41 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 21:36:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 21:36:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mkoutny@suse.com>, <paulmck@kernel.org>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v6 1/2] blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller
Date:   Mon, 10 Jan 2022 21:47:57 +0800
Message-ID: <20220110134758.2233758-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110134758.2233758-1-yukuai3@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prepare to reintroduce tg_drain_bios(), which will iterate until
throtl_rb_first() return NULL.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e68a9a2..fdd57878e862 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -502,7 +502,6 @@ throtl_rb_first(struct throtl_service_queue *parent_sq)
 	struct rb_node *n;
 
 	n = rb_first_cached(&parent_sq->pending_tree);
-	WARN_ON_ONCE(!n);
 	if (!n)
 		return NULL;
 	return rb_entry_tg(n);
@@ -521,7 +520,7 @@ static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
 	struct throtl_grp *tg;
 
 	tg = throtl_rb_first(parent_sq);
-	if (!tg)
+	if (WARN_ON_ONCE(!tg))
 		return;
 
 	parent_sq->first_pending_disptime = tg->disptime;
@@ -1090,7 +1089,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 			break;
 
 		tg = throtl_rb_first(parent_sq);
-		if (!tg)
+		if (WARN_ON_ONCE(!tg))
 			break;
 
 		if (time_before(jiffies, tg->disptime))
-- 
2.31.1

