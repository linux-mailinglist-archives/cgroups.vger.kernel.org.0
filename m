Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56976338B27
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhCLLJW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhCLLJE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6315C061574;
        Fri, 12 Mar 2021 03:09:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x7so1616714pfi.7;
        Fri, 12 Mar 2021 03:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3QEWlUrFLMLaUGl8wHuUk98pwVzXJV4Z6adAvQh0quw=;
        b=AGOaWhDWZN5OxUpAk5V5Je2FjeTyxmmJlwyPNZzcQmCQ+g/rNzmGRA5ryZ1FcaImaO
         jqKkyKDssGkwA3qgyEp4KuNPs4zMC4GInA4VFAlsduFYqPgdxhU9J+tQemyGyTnmT6wN
         XAHdNUtd8/4ReAlRmlcv8q5kQEwJgkJZakU3RNBvTyIu6DVkU13lj6L1Mq0vJyx+MLhk
         qKSmRn52WJ0F12fAviPFMVW7yiDDq0ovLTmUcGvswcGNbaR4daC7yoGG98tgwLtrylEl
         IQ2TNM1RUug/vlh4k9Qoc5dZcyMo8M7VQBVByQcN0SX3C0vpECt3udTKKTHx473mSmdq
         Qkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3QEWlUrFLMLaUGl8wHuUk98pwVzXJV4Z6adAvQh0quw=;
        b=kTybwVO14i55cRmz/EjNFbjUghecjCy9Tf6A+CeG+GPyP227hjnYv7pg8ML01lOh8e
         1eybl3iFFv1nAQlVQY1I/qiAtKa60Ebz3tZD3A2Eomd6Vab8WYQJV0Xfv3FLu5ydbzpt
         3rGGb5qMe9Bfr/MHL/tznbLd9cTmC+XzaU/foXFxhQl2aAhpy9m7crZ3Z1tC2YN3KlPP
         WlO91SuluccttFX8FCYpitWdn0vLL1gzaTRyy4n3yXFB/sz8eAvUpeNsALrP6Et0VDg9
         h7jMPUkRlB8Oy/ZyFWg5wZ+YM6UWSgtCES1t/Jj9f+1VYR3/KLOcdB2bzE9Ai95c5410
         O04w==
X-Gm-Message-State: AOAM530pgwOZjHRgs1OacHebcLmECX92NK4FATMQyFp0joSkaxuzZ5CB
        yn+Ql55ajfasCQUISi9fdC0=
X-Google-Smtp-Source: ABdhPJyAmFhCeKa9Bdvj9G+/TcYVgqEkq97gru3z2frPInR/4yI5Pq+gxKrqp0bYgnUUO+du+awdvQ==
X-Received: by 2002:a63:2262:: with SMTP id t34mr11509579pgm.303.1615547344417;
        Fri, 12 Mar 2021 03:09:04 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:03 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/11] bfq: optimse IO injection for CLASS_RT
Date:   Fri, 12 Mar 2021 19:08:41 +0800
Message-Id: <ab86856f91a4734adf9cbf4212adfe2252ddbc57.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

CLASS_RT is more sensitive to latency, and IO injection
will increase the CLASS_RT latency. For this reason,
consider prohibiting the injection of async queue for
CLASS_RT, and only the waker queue and other active
queues belonging to CLASS_RT are allowed to inject. In
this way, for CLASS_RT, both the advantages of inject
and IO latency can be maintained.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8af73473c45c..a5f13589df79 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1965,6 +1965,9 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
 		return;
 
+	if (bfq_class_rt(bfqq) && !bfq_class_rt(bfqd->last_completed_rq_bfqq))
+		return;
+
 	if (bfqd->last_completed_rq_bfqq !=
 	    bfqq->tentative_waker_bfqq) {
 		/*
@@ -4391,6 +4394,9 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 			else
 				limit = in_serv_bfqq->inject_limit;
 
+			if (bfq_class_rt(in_serv_bfqq) && !bfq_class_rt(bfqq))
+				continue;
+
 			if (bfqd->rq_in_driver < limit) {
 				bfqd->rqs_injected = true;
 				return bfqq;
@@ -4565,7 +4571,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * may not be minimized, because the waker queue may
 		 * happen to be served only after other queues.
 		 */
-		if (async_bfqq &&
+		if (async_bfqq && !bfq_class_rt(bfqq) &&
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
-- 
2.30.0

