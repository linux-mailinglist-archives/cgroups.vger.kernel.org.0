Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC16161EB
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiKBLoU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBLoQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F10286D6;
        Wed,  2 Nov 2022 04:44:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y4so16335508plb.2;
        Wed, 02 Nov 2022 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr/6LyMOPEwxJWN/wHZi4iuPELnrmgBJGmSjXSuSoPo=;
        b=aA8awJ74lgAvHubnmrEfljUkZTWxL9nKaIQG6X23rQv3SwxY0cPT5ZVsr77SFLHIl7
         PvqY5kn7vI4fwVcxp5/moG8HQ6MlpYSp7u8CB62Yp8vkMKcEx6wKehhTpOHrUUuTtAWL
         KqtJwpozyk4g6mqZkargiKK7jqbgSnIEkdbHBD0gnKC99Yylc7eiFYu1uBde7w27ZneI
         nnQTIrpzCJTtP8gDKEppoet7dWZSIcK83cZ+x8Op2/RVKFdTAzFabF1hP7z9GKKKCb/a
         YSGziNerbAA0giKC4LgwV9yph0ScKgNh0uB8/qV0vckktyRgnckFbTFNt1I7D/9BgnQV
         Q3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr/6LyMOPEwxJWN/wHZi4iuPELnrmgBJGmSjXSuSoPo=;
        b=dBfQuhsfw7xIdcmt5q0G28u5lUj3ViqDHjfQi7pD5XBwixXuY+NQEGx+L+lqrIxtSf
         jq9iCCSXfngesj7UwTuljeDDV4YRWy34Qdp7Q4QB5QLAaEu+S81RPjFBDDwYBr6b7IoN
         UG2GeVpZvh3LiUsfbcX0o6mE9GiC882Kd1RSIW+oGeEf0/Yv52KCRocQ/3CFoU3QccUd
         iGvahj0aZvSfGAvDyfSMEecuauOnF3ialmLYqrkNFlXjmmTWsXVU9LhIQsvmcSSDUPmB
         LL7kvBntIHPMoJ0pLwdLxqZL2wwNaEutjwr7yQl2JfX9BVMtN+s4y5wiqDBoATCsLdeL
         wyYQ==
X-Gm-Message-State: ACrzQf3D5A1Fw8JG7vzc90v+ECpxM6CFMXeW57BUxuzw4SbyvNHePfM+
        emKyfCIe7pny3U0dLVnXf4c=
X-Google-Smtp-Source: AMsMyM5eypjgDOyTLx4f20GKAATRVw3+5TAXvMP1JaBhRMd9g9ZBdQ1cqJKBlTGVBEfXYGd35g5X4A==
X-Received: by 2002:a17:902:6906:b0:186:d8d7:1d1e with SMTP id j6-20020a170902690600b00186d8d71d1emr23991188plk.30.1667389455171;
        Wed, 02 Nov 2022 04:44:15 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:14 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 1/5] block, bfq: remove unnecessary meta_pending count
Date:   Wed,  2 Nov 2022 19:43:50 +0800
Message-Id: <20221102114354.162-2-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102114354.162-1-Yuwei.Guan@zeekrlife.com>
References: <20221102114354.162-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The meta_pending is counted only, but no one use it,
so remove it.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 7 -------
 block/bfq-iosched.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..74b87694105f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2448,10 +2448,6 @@ static void bfq_remove_request(struct request_queue *q,
 		if (unlikely(!bfqd->nonrot_with_queueing))
 			bfq_pos_tree_add_move(bfqd, bfqq);
 	}
-
-	if (rq->cmd_flags & REQ_META)
-		bfqq->meta_pending--;
-
 }
 
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
@@ -5975,9 +5971,6 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			    struct request *rq)
 {
-	if (rq->cmd_flags & REQ_META)
-		bfqq->meta_pending++;
-
 	bfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);
 
 	if (bfqq == bfqd->in_service_queue && bfq_bfqq_wait_request(bfqq)) {
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 71f721670ab6..3de849e97e4e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -268,8 +268,6 @@ struct bfq_queue {
 	struct request *next_rq;
 	/* number of sync and async requests queued */
 	int queued[2];
-	/* number of pending metadata requests */
-	int meta_pending;
 	/* fifo list of requests in sort_list */
 	struct list_head fifo;
 
-- 
2.34.1

