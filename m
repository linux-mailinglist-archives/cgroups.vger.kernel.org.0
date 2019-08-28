Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA9A0D41
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfH1WGX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43449 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfH1WGW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so1360042qtp.10;
        Wed, 28 Aug 2019 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJvU7rmwIge55OnvUhbefmrBEQ8Ym4OUDfM2nXYs6sA=;
        b=SUgVVk64RTHaoNIAgijUQpv5HFB6s5wym3N8KbvF1Kc7aCU6csB6QYObFfyzY8vUbh
         ztdsAAzEtjIkTyPPRC+AbKzmE+Nj2jr+KTv0+dcdEZaUYlwfYB2psX7HCXapsFsT8+xO
         yRvCZHXiYqCghYOsRiWYTdo272wq51qBwE1O/jYvO/2yIq9VCLaXQ/0BYIURYI5QZAup
         5uYMv2EtMN8INwx9dZNqqMCeYILSznb+vCd3ejsyK/aTforkB7PbaBlQLYLLD+46p6nA
         akh+AIfRpdVylk+QNtbhTvYkAnZ2eWZxN9ECBdY4tWEQeGu6CwFgXSnh8madvm70Nhix
         NdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hJvU7rmwIge55OnvUhbefmrBEQ8Ym4OUDfM2nXYs6sA=;
        b=XtDAv7QgR+LKs6hFy45kzXeRsFejJ/FxqACPF9gUUKLXJ28P3Bu+x5oJMk0g/sfRCG
         l9GjdjMPJHF9c2vgzX4GDWwE59JZaDdHeWIZh2F+m/XYupimBgYPHywdtIshT5WJWRPJ
         bgRU8MGwe73ZZK8+z+TnsJHWlh64ka6ffourn7rQfmnim4rg6+mGqA+pDpuqEbTPHzSH
         JzJYnznOar7bLYXnetHPTtmIwrpMj7zctOhlpeFKA0+JmVeP2901Re5MBW5MA3JMAx7A
         zrvX3d3Lhn+pkMvnVnl8Gli0EF66ESWwE36tu39f5XxLuoFfM2fqkj7/QcIpfIi7IjEi
         d0lA==
X-Gm-Message-State: APjAAAVGrR/TTZ28xhmCWy896+tF1A6FOqny7YEeoL/L52fVIcNf+g91
        DkuGBjT6WjFRurlPqMeDSgvVHRtp
X-Google-Smtp-Source: APXvYqxa/K7gZv6PsgzXX3UTvABDLpDMm2GDIyW1SzL1E0NepgWD4mZBk8MUMhDkyL/oavJ0AJJN6w==
X-Received: by 2002:ac8:4456:: with SMTP id m22mr6617252qtn.326.1567029980929;
        Wed, 28 Aug 2019 15:06:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id g24sm338594qtc.38.2019.08.28.15.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:20 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] blk-mq: add optional request->alloc_time_ns
Date:   Wed, 28 Aug 2019 15:05:57 -0700
Message-Id: <20190828220600.2527417-8-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are currently two start time timestamps - start_time_ns and
io_start_time_ns.  The former marks the request allocation and and the
second issue-to-device time.  The planned io.weight controller needs
to measure the total time bios take to execute after it leaves rq_qos
including the time spent waiting for request to become available,
which can easily dominate on saturated devices.

This patch adds request->alloc_time_ns which records when the request
allocation attempt started.  As it isn't used for the usual stats,
make it optional behind CONFIG_BLK_RQ_ALLOC_TIME and
QUEUE_FLAG_RQ_ALLOC_TIME so that it can be compiled out when there are
no users and it's active only on queues which need it even when
compiled in.

v2: s/pre_start_time/alloc_time/ and add CONFIG_BLK_RQ_ALLOC_TIME
    gating as suggested by Jens.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/Kconfig          |  3 +++
 block/blk-mq.c         | 13 +++++++++++--
 include/linux/blkdev.h | 13 ++++++++++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 8b5f8e560eb4..1b62ad6d0e12 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,6 +26,9 @@ menuconfig BLOCK
 
 if BLOCK
 
+config BLK_RQ_ALLOC_TIME
+	bool
+
 config BLK_SCSI_REQUEST
 	bool
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6620a30752e..b622029b19ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -291,7 +291,7 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, unsigned int op)
+		unsigned int tag, unsigned int op, u64 alloc_time_ns)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
@@ -325,6 +325,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+	rq->alloc_time_ns = alloc_time_ns;
+#endif
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
 	else
@@ -356,8 +359,14 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct request *rq;
 	unsigned int tag;
 	bool clear_ctx_on_error = false;
+	u64 alloc_time_ns = 0;
 
 	blk_queue_enter_live(q);
+
+	/* alloc_time includes depth and tag waits */
+	if (blk_queue_rq_alloc_time(q))
+		alloc_time_ns = ktime_get_ns();
+
 	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
@@ -393,7 +402,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		return NULL;
 	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags);
+	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags, alloc_time_ns);
 	if (!op_is_flush(data->cmd_flags)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ac790178787..d0ad21e4771b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -194,7 +194,11 @@ struct request {
 
 	struct gendisk *rq_disk;
 	struct hd_struct *part;
-	/* Time that I/O was submitted to the kernel. */
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+	/* Time that the first bio started allocating this request. */
+	u64 alloc_time_ns;
+#endif
+	/* Time that this request was allocated for this IO. */
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
@@ -609,6 +613,7 @@ struct request_queue {
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
+#define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -637,6 +642,12 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+#define blk_queue_rq_alloc_time(q)	\
+	test_bit(QUEUE_FLAG_RQ_ALLOC_TIME, &(q)->queue_flags)
+#else
+#define blk_queue_rq_alloc_time(q)	false
+#endif
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.17.1

