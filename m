Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24A045186
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFNB46 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44454 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfFNB4x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so294098plr.11;
        Thu, 13 Jun 2019 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+KdFgJZvhBrFGCV8+TCH6qm9KzyCmoisOVOsrQ/edE=;
        b=oFY/FvPPz+fvxLrOVIiXPYJ4mo0/NNdQYAYUukXGVzvMV+xkzEXQmJpR1ZTX6HtUAe
         HzJ+ehvOts/wpqr59T4Vcwbzr90A/Awnasu0Z2XGSsz/KrfWccFoe074ZAYpO31ugvup
         rbGle+M/or88E0BqNgHlMHgII9Gv8uEjKPRxxSJeU1HkBRzb+BZQRUJwmn1M9DtdEUHL
         c8b5qLgEZpgNrSkCD9GYsgRh5MIkoggcHYwKtQDWAVVauisx3PsN+uBOJ6zc6PMlsMRr
         0apBiygMMG6ka23rAaa1tp+iZiP4msrsbHf2+bjoJ2EBrullebRR/2nHPmUAASgD0+9H
         7JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1+KdFgJZvhBrFGCV8+TCH6qm9KzyCmoisOVOsrQ/edE=;
        b=RdZph5ofGMQcUmV9OQUo4CyIqyYe/8Nbkg/guN2OmcQ8Bxo8dTHfkVjVcKZGBY2Rcj
         Mu+srnqilCwr3k9317PUGEkrVG4qFb+YVNVmCoK5SJwaW6TB/aMm+qxgKlL38PTE/mtQ
         G5euKH/K5Ung6AP5m5ZsNLikoZHRlZX7iYzPRpBzYIjOPPpMP4aqB5KA7UszVA1Ezf5t
         iZ0fqpudaV8OUwOfU0VGNdD3eJsihejJJsNIl1Uapf7VW68ViY2kBoQmIX0t1ivniRFu
         mhOyAms69SCgSiv4H3WlNcrAAVAmoBKllk4jh22X7D59NDuLPlmEip6JQqx1NMSbRKv4
         rZzg==
X-Gm-Message-State: APjAAAUn23wSxxcg9Ej0xMb7rpN7hZCX1TEVRTD9eLMuV1vGLTX5KxzG
        +MfKVbDu6JVIBl0iTBuqe8w=
X-Google-Smtp-Source: APXvYqy2VnaH3y8lJWFYxUYiIgzOZWjaKcrIqDGj55DLpYm4ODCk9zu9y8IA7FVV5NPrTr5bYTTIVQ==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr93193517plc.166.1560477412593;
        Thu, 13 Jun 2019 18:56:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id g9sm931540pgs.78.2019.06.13.18.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:52 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] blk-mq: add optional request->pre_start_time_ns
Date:   Thu, 13 Jun 2019 18:56:17 -0700
Message-Id: <20190614015620.1587672-8-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
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

This patch adds request->pre_start_time_ns which records when the
request allocation attempt started.  As it isn't used for the usual
stats, make it optional behind QUEUE_FLAG_REC_PRESTART.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-mq.c         | 11 +++++++++--
 include/linux/blkdev.h |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..25ce27434c63 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -291,7 +291,7 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, unsigned int op)
+		unsigned int tag, unsigned int op, u64 pre_start_time_ns)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
@@ -325,6 +325,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
+	rq->pre_start_time_ns = pre_start_time_ns;
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
 	else
@@ -356,8 +357,14 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct request *rq;
 	unsigned int tag;
 	bool put_ctx_on_error = false;
+	u64 pre_start_time_ns = 0;
 
 	blk_queue_enter_live(q);
+
+	/* pre_start_time includes depth and tag waits */
+	if (blk_queue_rec_prestart(q))
+		pre_start_time_ns = ktime_get_ns();
+
 	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
@@ -395,7 +402,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		return NULL;
 	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags);
+	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags, pre_start_time_ns);
 	if (!op_is_flush(data->cmd_flags)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..ff72eb940d4c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -194,7 +194,9 @@ struct request {
 
 	struct gendisk *rq_disk;
 	struct hd_struct *part;
-	/* Time that I/O was submitted to the kernel. */
+	/* Time that the first bio started allocating this request. */
+	u64 pre_start_time_ns;
+	/* Time that this request was allocated for this IO. */
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
@@ -606,6 +608,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_REC_PRESTART	26	/* record pre_start_time_ns */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -632,6 +635,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
+#define blk_queue_rec_prestart(q)	\
+	test_bit(QUEUE_FLAG_REC_PRESTART, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.17.1

