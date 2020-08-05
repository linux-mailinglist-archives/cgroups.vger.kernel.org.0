Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D796823CD98
	for <lists+cgroups@lfdr.de>; Wed,  5 Aug 2020 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgHERjf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 13:39:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728916AbgHERed (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Aug 2020 13:34:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4663146D141309B3CA39;
        Wed,  5 Aug 2020 21:37:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 5 Aug 2020
 21:37:08 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] block-throttle: set q->td to NULL if blkcg_activate_policy failed
Date:   Wed, 5 Aug 2020 21:37:20 +0800
Message-ID: <20200805133720.1008782-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Otherwise q->td will point to the released memory, although there is
no access to q->td in the following process, still recommend to do this.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 block/blk-throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fee3325edf27..05b87516eee9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2399,6 +2399,7 @@ int blk_throtl_init(struct request_queue *q)
 		free_percpu(td->latency_buckets[READ]);
 		free_percpu(td->latency_buckets[WRITE]);
 		kfree(td);
+		q->td = NULL;
 	}
 	return ret;
 }
--
2.25.4

