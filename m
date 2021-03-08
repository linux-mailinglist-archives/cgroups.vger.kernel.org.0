Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B07330CEE
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCHMAl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCHMAb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7257C06174A;
        Mon,  8 Mar 2021 04:00:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t9so2886015pjl.5;
        Mon, 08 Mar 2021 04:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0CbPEsPvCKQnAIItYoZ2d4psiwcNd/zumwFN0bHqR4g=;
        b=sz52OpNr36wC18BhGHDtq9Xp1P5E9ydmLn+BqWMHO1Qxd/NHVo3XRvVC/pE9A5qnlO
         gNCrKRmsf0fharVMtDvq8h8euj1GgCdbrgOvbURbEnkq3rTP2VkdePbGdMhXuyujXx4m
         wr5UMx+9VQ2aTvDd9ic14NIBzzouODy8z3zdYjnB4zqMK206b9UyP3vCMmkLwgRZyLR1
         BS7VsbAbgM22tSzrasJfS/8tNuirrEkmG9FfCRKsIlCv6Z+p66zVC9Col1NjW64f+Koa
         h7UkpUExfLHuAwqMXvfvgZX11AW88RdCh142kN2LEytpvFJZ3vFxRa8T99vAsNyqqtYC
         6MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0CbPEsPvCKQnAIItYoZ2d4psiwcNd/zumwFN0bHqR4g=;
        b=q4O8ZRU7WLbdtBDqreDWNiNRh2AVZgvBulOEY6a4u5tIuO6eYwkdwYTFmJL3eXdh6Y
         WfeHUz7XvxTXLcKEN1jPLf7qjfJJ9Rh7IZQyCpJyA8LXBiCYus992gWQxewdFaSJqKXU
         SU0aUCnwB2a0DSqvuEOEhKQV+GaA+7CvRp3dZOpr+9desvpOLSiuDY8nqwtkGu5+Evih
         G/Kq/NQSbX27vcbUP+KVGhvww2xMaPGDdTOQZemgPI9GqYOvl56+f05V5t4Qt1ZW6VON
         Php6+EfM3m8X0vVNoyEaZtjIakMmZH9Z1A4IHUYgPsKqaYnduhTczmYigz4CxUArpyOd
         LLXQ==
X-Gm-Message-State: AOAM533qTyx0yPLS8XQP1TfGcSE9eC9oqez+UT247jWRGcRAKXgg3M5v
        8TAwP8NGZ40w9PescyQX0Mc=
X-Google-Smtp-Source: ABdhPJwNtIZ4H2o5eByZpv1GVWIBCScbrS2wMM35eZB7lux2Lm+OJwCv2YvjrxqvqwHB7NpGllnRgA==
X-Received: by 2002:a17:90b:a01:: with SMTP id gg1mr11316565pjb.22.1615204830572;
        Mon, 08 Mar 2021 04:00:30 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:30 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] bfq: expire bfqq if a higher priority class is waiting
Date:   Mon,  8 Mar 2021 20:00:17 +0800
Message-Id: <055c82a8f016a0e918e69ac6700a5839a7f4bfaf.1615203034.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

From: Chunguang Xu <brookxu@tencent.com>

Expire bfqq If a higher priority class is waiting to be served, we
can further guarantee the delay of the higher priority class.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b639cdbb4192..223affaa7c92 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4677,7 +4677,10 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
 	struct request *rq = bfqq->next_rq;
+	struct bfq_sched_data *sd = bfqq->entity.sched_data;
+	struct bfq_service_tree *st = sd->service_tree;
 	unsigned long service_to_charge;
+	int idx;
 
 	service_to_charge = bfq_serv_to_charge(rq, bfqq);
 
@@ -4714,6 +4717,17 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
 		goto return_rq;
 
+	/*
+	 * Expire bfqq, if other queues belong to higher priority
+	 * class are waiting for service.
+	 */
+	for (idx = bfqq->ioprio_class - 2; idx >= 0; idx--) {
+		if (!RB_EMPTY_ROOT(&(st + idx)->active))
+			break;
+	}
+	if (idx < 0)
+		goto return_rq;
+
 	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
 
 return_rq:
-- 
2.30.0

