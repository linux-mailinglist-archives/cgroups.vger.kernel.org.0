Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC11455C16
	for <lists+cgroups@lfdr.de>; Thu, 18 Nov 2021 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhKRNF1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Nov 2021 08:05:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14952 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhKRNDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Nov 2021 08:03:36 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hw0G84bWNzZd8Y;
        Thu, 18 Nov 2021 20:58:08 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 21:00:33 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 21:00:32 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Date:   Thu, 18 Nov 2021 21:15:51 +0800
Message-ID: <20211118131551.810931-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

1.In current process, all bio will set the BIO_THROTTLED flag
after __blk_throtl_bio().

2.If bio needs to be throttled, it will start the timer and
stop submit bio directly. Bio will submit in blk_throtl_dispatch_work_fn()
when the timer expires. But in the current process, if bio is throttled.
The BIO_THROTTLED will be set to bio after timer start. If the bio
has been completed, it may cause use-after-free.

Fix this by move BIO_THROTTLED set before timer set.

Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e68a9a2..ddfbff4465d5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2149,6 +2149,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
+	bio_set_flag(bio, BIO_THROTTLED);
 
 	/*
 	 * Update @tg's dispatch time and force schedule dispatch if @tg
@@ -2163,7 +2164,6 @@ bool __blk_throtl_bio(struct bio *bio)
 
 out_unlock:
 	spin_unlock_irq(&q->queue_lock);
-	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
-- 
2.22.0

