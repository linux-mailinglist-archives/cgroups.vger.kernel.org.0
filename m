Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79E65FB6F3
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJKPZX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJKPYx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 11:24:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2093.outbound.protection.outlook.com [40.92.99.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CEA18E1D;
        Tue, 11 Oct 2022 08:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbku6TSDl7X34hGgPogPUFImUwyFvBG9MdOLA7NbuFIBZPalKbwYydP3RuHdjnRZuE+ZdENw/5ezN/cy/q5XLeeBJVq1SojZU8WIAsrvoRCgKrbXfOSORZir5iGtjI2YvFlgA5QOb1MlVjOP6eZlEssffAtdBuYbfjFS39EaQdFuPRkHI9JEvGMFTX9tgrJvlDDO8/IEE/b/YMLAugLw6K7vaqF/7EMdmWzYq0rpAULYdavq4SlipvwmkLzDf3PayruZpgd5iswMT/d2j+GYNw90xtYIUVIN2dS7yJHYX1zZJRaIC9Ucob8qVWWXNvwOeXddGJH1lMSwUpueerSNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbcrVk0ED9SXOg7VP3kEUS/OTui3qy3ZuXxjnkU6Yxg=;
 b=M8YHAbOW6iHEw6jXtwxD0rFlgaOPlj3i3p4/2Q70TZ/z2xDi43m0HlcqGht6UjrxhOn4/sJeDQhnLwfBxDsR1R6YxzHmYF5dQQpWQGmaYNbCwht1Bn2YDTOaPbYdDsZAKZTk0Gtojnrx6IsngBTkFpzKjdSfA/M504DX9Dunn2LrrQ01svEFaKEMnE5suRrnBp0A5krWrjnNVCnQSiEnl/qUDwkU/+XkJVXByt3CHEnoZP+6lWqHVxq8EWs3BeqdY12xmPmAUDkDhQ44nWa7j9+LR7InLB2/apDAJs8IwMWVNdvUSXHHbwU9nkSrX6/aCxfluHydmfvq3Y4Sg84PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbcrVk0ED9SXOg7VP3kEUS/OTui3qy3ZuXxjnkU6Yxg=;
 b=HV23m9anfunJO0q1ZiQQgUJtdFY5aLPINhpy1UbB51E2x+O1bDM/Wg+UD/BieCWe4pPEsdoQljXr3PxC7f27pEru+oFcQF/I5ogrvOq88e8fDAE9dMiZ50TMbos//jDqF/NQrN2zvdHz72CnuVnG9Rj1q0XCr4fQ0HwYSDgdsG6laURuU66pzxArAGk5MBZPZzgQAhnrs68wcIW8kzp7tVzYKlHc0SiU7X2eisZh7xYygsg7uqvpKQL+yQacPYkmC8io6US/P3Dn1Nwt5bFCYx2nMmwUVRH4he4FVpC/7R8rpOCVPvekD/m13eKO3BG7q6lLlJiTUh6YuUJ9rl46EA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB1855.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:53:21 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:53:21 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk, tj@kernel.org, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH 1/2] block: Add helper for queue_flags bit test
Date:   Tue, 11 Oct 2022 22:52:45 +0800
Message-ID: <TYCP286MB232392B1D23662DE81B0D2D5CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011145246.8656-1-set_pte_at@outlook.com>
References: <20221011145246.8656-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bxZ853wNgM4oyIu9uExyIWSnbQNQzNpZ]
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221011145246.8656-2-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: acce436d-9c76-46ad-27fa-08daab98570c
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGluUOiRWeVrPQcQDBojfOWWe+ipGp20sCIEtQn1HeHJdxJitM/gsZsEEkX01AofDJ4auc0z8J7savsK6BCc0w/rL7UuZYT+FPcL0PnY2lLk2N8v7Q90zFZsUU0js80KSa7Poq1o4Bshn1b/ND7zBPctHfqPPzZ2v1HwuOEuD2cyLy531TsMku40QEN/0JGnv5wzMky+kO2QDepbC2vhQudrPrJXphJCz0EsoQVBgNQxo87qkIBFk5aqh8rMTOBRGfvxWp3w2NfLz4WXXaO2D+r2C+ThL9UYJLL9VyEETEdKo8rdmI0yKFsKkkxOYdBXg+3nB097dP1kZhkstPFO8Op90uE0tUp+1XWooFmO5qB/ac0YFdYW2GLLQn1hrFo4KeMAD46+4zqWceX+TMgj0pSMwoUy5Xhffh5aRlgAr35JsPL4ngBE15Xk8vqzK/2GH6QV42T/e1qUxXjBmoTfYAYkwOa+a+czJvRWFpT+CNP5+ldwofOQyrv5o0bR01lNwcTOxVQqx7EaHsao//Z3bX4GNIhxbhufmxdOrUWTcIXNdaZExqJ5rKCu43+g3yehGSqkxDcjnRTOjroP03EV7SmZHfBMgucEPW6HqA4IRLfI3bZqyH2Oez8I0wdJ2Z/UEDukYdeONxljz+qdJHbOswwdQfMeCKrObVb8rn89ZpaInsg5AejtbPdxR2kyYRXSJmUr0+VskhYvu8WcjB/dpEuw6sRNaMEYXac1QYhmvNFF/vRtkyZuGbGp+
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyBFZvrB4aq2GS/i5ey8KkY/wwaUQhpTEiFFNymEobBe2iijI4iz/Ksiyn1LZZ2ap6P/RCowIV5kE5X/c6m6FUH/ixCncuxfUizKY7ui1JiJh+IlA3pW2NfQ7ujKjqfTqd5N576hKEuYUD81n3m6omR0QJlYZMkxc2rX0SoDMU76VnT+rwtd71agcnL2isTey1/yXfAAcfxMVYXLa0/B2ea4h8FwmiyBrqXeouO1lrFjjKxX/oJlWFR5Z0KsBfy6IxgQRN/OSggbNVaDjsPO+xge1Mj3ZsEwZBzOGzwOaB3LHkD2nVAetqvq1CwaUd3h60MmCQ7uswd0kQiLBNnjgyua/CKOLz6SCwf+Ni+/FxH2y/sWDd/rm2GnaZ6h/Px6AOZqwI6fyoLzesjSlGqTBTtUxgMjckqP9qZg3r/uut2D5MKX/ICyGPGcJETLS3zKj0uIMqv78MeuzeUpH3KQjyTKlvsxOMPvqJvZtTBX+DAGzRQ7qS+zWjBaau2kTfpK4LBJHZRkLG1uMUp9iIoBWx8laXyxDiYPYvzcDGqU1KU0zXgcq2KOt3xRcaRN04OyMozZ4mRbjJNw3eEr0XMSjWLrM52H7uqQWOcaqJBx3TAzdor7B6th8qxQ+Jj1o3euT3blrStPhpvNtyCp+2kXUNVtbewJ+WfhDvMjNKJxiAmq1qegBAjq745DmSymAj6/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zP8jqQ5bw7jh1+qhCI8tacSR3Q/69a4F78RZE91GbqYAhrlPDjhhz8CBV7+?=
 =?us-ascii?Q?xiGHeMdy2Po5vRrTJe3+iPfI/1rLuBZpfYHMpM0a4kobw0GlbsiAqpR8CeCZ?=
 =?us-ascii?Q?gow085U3ydm3LPGpk5fvHczpeDzpeD/26SEmjZej/JNIKPTWAXi7Rc67tZk0?=
 =?us-ascii?Q?PmWNbPa87pNKuRkAIVw0Jy9YFc97aVkX362DfNrBdEws7saVB3r80YePiirA?=
 =?us-ascii?Q?ljN+1fJz/uybBsEy1emPPdHuN2mAw0cjqYrZ4NntSnT2HWswTDPL8JAfGaSV?=
 =?us-ascii?Q?QwYJuU8FkUuMoPZTmlDxkRj9pHCOqgrf0WFH18VOMr0nLk8tA2Iw4PtTTxPE?=
 =?us-ascii?Q?I3BznZlroafRisjK5F7S8wOi0ky88V192m21/QXBjrfoKfZ1fOZpiutlQMh3?=
 =?us-ascii?Q?4/JhvKkbJki8IBMMZU6jp1tHEoLwUT+qzQwX1HuIncTPnsR6WjnP9mmEmces?=
 =?us-ascii?Q?szxLqNbcD71O3duNvriydmWYaBvS+R0m1GDQxuagfQOITXa9RZ4w5ycR6ncI?=
 =?us-ascii?Q?7e4YmpQWGJ2nyC5lPru6dlqqSdfPFCMxDo50ERlNClDiOGgajtuAP++BHEGI?=
 =?us-ascii?Q?kohol8hdhyffwJVFMXLkQH8LhEQOEyGKMcxy7QZmruB/NNq71KRWErmU4ssF?=
 =?us-ascii?Q?RWiC1KXDfEVkWHTjmgHNf++NLRqhNd2LUdvAro0TJyq4KlzvTSMZL1qEQnEg?=
 =?us-ascii?Q?stB5QLHxmivpqFZydnVY1SY1MKN7yY+/MEeY6booCLgUS17cVCm+pfZqDPpa?=
 =?us-ascii?Q?1WcfblMVL7uM6ijRwcXDv9laZFH9SMoFdjolIbZj5QfVjkVDeRNqW0sVKHVS?=
 =?us-ascii?Q?3qjcFIsNdSdoU/MbPVNnVE1NsMdGmRrK7WLo48yqqiRGkOQLumIvUp6mwq/b?=
 =?us-ascii?Q?Rz53pxjQd4z9P3vJKriMzvSTWdx021T2cfLj6pSwJ2zS7fCIZLx0sriIgrh0?=
 =?us-ascii?Q?vqMxnvcjX/EzBWNUadjNt2wjJbq8c+rnESBtC8BTxx/xpV+V/zMEVU1EsT7J?=
 =?us-ascii?Q?GS1AojZPhk7ciC82kpSYBSnZ7YyneoULH4u5713z/uB3O5XtATBla/mhCNgM?=
 =?us-ascii?Q?R4ujKJy5dMY00z0r+MzCYUoYNR59iOYGZfaOjSeBNDlc67p0cCfDtLZtYPoE?=
 =?us-ascii?Q?UF5R+u43u7VcIdFibXzNoJnQhGVCS+S+loNERT3iB49UJVDoiZJgut7l8G+D?=
 =?us-ascii?Q?iButb3AaR/0sCKAM2BV/dkSnr/C5Zuru7ZCBf/Sgx5gs63j71LyquXiMsI6i?=
 =?us-ascii?Q?kZTv637hCU2WZmOv5qPLtirTIju4vISazE3ddjUXUQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acce436d-9c76-46ad-27fa-08daab98570c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:53:21.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

queue_flags is a flag mask representing all possible attributes
of request queue, just like flags of struct page. In analog to
implementation of PageFoo(), it's possible to abstract helpers
denoting whether or not certain attribute is set for a request
queue (actually there are some of them implemented already).

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 block/blk-core.c       |  7 +++----
 block/blk-mq-tag.c     |  8 ++++----
 block/blk-mq.c         |  8 +++-----
 block/blk-mq.h         |  2 +-
 block/blk-settings.c   |  2 +-
 block/blk-sysfs.c      | 12 ++++++------
 block/blk-timeout.c    |  2 +-
 block/blk-wbt.c        |  2 +-
 include/linux/blkdev.h | 19 ++++++++++++++-----
 9 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4bfc0d504b2d..032556de327b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -731,7 +731,7 @@ void submit_bio_noacct(struct bio *bio)
 	 * support don't have to worry about them.
 	 */
 	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+		!blk_queue_wb_cached(q)) {
 		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
 		if (!bio_sectors(bio)) {
 			status = BLK_STS_OK;
@@ -739,7 +739,7 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_queue_poll(q))
 		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
@@ -846,8 +846,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
 	int ret = 0;
 
-	if (cookie == BLK_QC_T_NONE ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (cookie == BLK_QC_T_NONE || !blk_queue_poll(q))
 		return 0;
 
 	/*
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31..0157bb3fcd91 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -44,13 +44,13 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE,
+				     &q->queue_flags))
 			return;
-		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
 	} else {
-		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		if (test_and_set_bit(BLK_MQ_S_TAG_ACTIVE,
+				     &hctx->state))
 			return;
-		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
 	users = atomic_inc_return(&hctx->tags->active_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9dd3ec42613f..6016fdea518f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1042,8 +1042,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 {
 	int cpu = raw_smp_processor_id();
 
-	if (!IS_ENABLED(CONFIG_SMP) ||
-	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
+	if (!IS_ENABLED(CONFIG_SMP) || !blk_queue_same_comp(rq->q))
 		return false;
 	/*
 	 * With force threaded interrupts enabled, raising softirq from an SMP
@@ -1055,8 +1054,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 		return false;
 
 	/* same CPU or cache domain?  Complete locally */
-	if (cpu == rq->mq_ctx->cpu ||
-	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
+	if (cpu == rq->mq_ctx->cpu || !(blk_queue_same_force(rq->q) &&
 	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
 		return false;
 
@@ -1142,7 +1140,7 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(rq);
 
-	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
+	if (blk_queue_stats(q)) {
 		rq->io_start_time_ns = ktime_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0b2870839cdd..0cc94937c00c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -355,7 +355,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		if (!blk_queue_hctx_active(q))
 			return true;
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..525eddb114ba 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -832,7 +832,7 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);
 
-	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+	wbt_set_write_cache(q, blk_queue_wb_cached(q));
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..a87b16fcbcd5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -365,8 +365,8 @@ static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_rq_affinity_show(struct request_queue *q, char *page)
 {
-	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags);
-	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags);
+	bool set = blk_queue_same_comp(q);
+	bool force = blk_queue_same_force(q);
 
 	return queue_var_show(set << force, page);
 }
@@ -432,13 +432,13 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
+	return queue_var_show(blk_queue_poll(q), page);
 }
 
 static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 				size_t count)
 {
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_queue_poll(q))
 		return -EINVAL;
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n");
@@ -519,7 +519,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_wc_show(struct request_queue *q, char *page)
 {
-	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (blk_queue_wb_cached(q))
 		return sprintf(page, "write back\n");
 
 	return sprintf(page, "write through\n");
@@ -549,7 +549,7 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_fua_show(struct request_queue *q, char *page)
 {
-	return sprintf(page, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+	return sprintf(page, "%u\n", blk_queue_fua(q));
 }
 
 static ssize_t queue_dax_show(struct request_queue *q, char *page)
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de0417fc1..d1f7bb5a4930 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -40,7 +40,7 @@ ssize_t part_timeout_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct gendisk *disk = dev_to_disk(dev);
-	int set = test_bit(QUEUE_FLAG_FAIL_IO, &disk->queue->queue_flags);
+	int set = blk_queue_fail_io(disk->queue);
 
 	return sprintf(buf, "%d\n", set != 0);
 }
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 246467926253..92c03db7eb6d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -846,7 +846,7 @@ int wbt_init(struct request_queue *q)
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
 	wbt_queue_depth_changed(&rwb->rqos);
-	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+	wbt_set_write_cache(q, blk_queue_wb_cached(q));
 
 	/*
 	 * Assign rwb and add the stats callback.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 49373d002631..57f4b9cd0ea7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -620,6 +620,16 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
+#define blk_queue_wb_cached(q) test_bit(QUEUE_FLAG_WC, &(q)->queue_flags)
+#define blk_queue_poll(q) test_bit(QUEUE_FLAG_POLL, &(q)->queue_flags)
+#define blk_queue_fua(q) test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
+#define blk_queue_same_comp(q) test_bit(QUEUE_FLAG_SAME_COMP, &(q)->queue_flags)
+#define blk_queue_same_force(q) test_bit(QUEUE_FLAG_SAME_FORCE, &(q)->queue_flags)
+#define blk_queue_fail_io(q) test_bit(QUEUE_FLAG_FAIL_IO, &(q)->queue_flags)
+#define blk_queue_stats(q) test_bit(QUEUE_FLAG_STATS, &(q)->queue_flags)
+#define blk_queue_hctx_active(q) test_bit(QUEUE_FLAG_HCTX_ACTIVE, &(q)->queue_flags)
+#define blk_queue_nowait(q) test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
 
@@ -1265,23 +1275,22 @@ static inline bool bdev_nonrot(struct block_device *bdev)
 
 static inline bool bdev_stable_writes(struct block_device *bdev)
 {
-	return test_bit(QUEUE_FLAG_STABLE_WRITES,
-			&bdev_get_queue(bdev)->queue_flags);
+	return blk_queue_stable_writes(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_write_cache(struct block_device *bdev)
 {
-	return test_bit(QUEUE_FLAG_WC, &bdev_get_queue(bdev)->queue_flags);
+	return blk_queue_wb_cached(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_fua(struct block_device *bdev)
 {
-	return test_bit(QUEUE_FLAG_FUA, &bdev_get_queue(bdev)->queue_flags);
+	return blk_queue_fua(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_nowait(struct block_device *bdev)
 {
-	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
+	return blk_queue_nowait(bdev_get_queue(bdev));
 }
 
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
-- 
2.25.1

