Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D330CEC
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCHMAk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCHMA1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889CC06174A;
        Mon,  8 Mar 2021 04:00:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t9so2885917pjl.5;
        Mon, 08 Mar 2021 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dJz1mJNUFCu8/5ZpciRC6YOn6iNHDwCBUMOb6meMbWM=;
        b=VCBfFCHPdKB3UhuPOgg2Yl0CKxU24aFecGuDgxFYy0jOzvUcnjdNfbcmGVRaXyDYsa
         bAiaaKxzyJlYvUy/tR1Ko00yth8vjfUTKC5UJRAuxpY3MDubB9tSrc1aJQH0RzlGSkoS
         qbKgJC8o2DnY2wUjKr8IYnXKMvmho0+bDYbqmTbvMwjIgrKrsGc8RiqDSlS54oFkNHmo
         K66njTNaHiGJn5X6kOMvbwlEJjN+GaR5wMqXS2IuW2bmHcy1RPfWh8ZDXGCkIJ6aqRCO
         k/xN3/wy5TdmCEnQTD48QngEyGv+7eeUTE80tgBcGb1HqUS7mqlEntr3zL4n1JLzo7OG
         xYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dJz1mJNUFCu8/5ZpciRC6YOn6iNHDwCBUMOb6meMbWM=;
        b=e0FkIWDIuHG/G3G7FVsEzWmalMzW9SquNamyuAKtJ5eGomKc9qqWDe2bX7DHTGiE8j
         7Jj7s1UgiOp9E+N2MpQRGe3cY3Kb2N2K6CS+8zRh1phBxtT52oUbFZu1JLN8bUgPGgic
         JLf4RR0Q1+NjAt7ZwJcTxaW/f5akkAPEQnDc83ohlm4QrHuL//uVUJz5vCrpcJU91QiE
         jO/iljfQ0NmS8HHM+9Uo2/XL3T6GvxyVJYXGIEpa4BPuJwONChKMSxVPGSvrc/C4nq5+
         xkbl8XuMTIbnMnU2+rmzI1Z2F77K92mtjT8t0x3+PpfGTNziVi+AfFgJ/cZq4AIuDSNX
         P6cg==
X-Gm-Message-State: AOAM5334iKSkCZEvJRXnKN71vOepMh4hSk24M89/U03fempeckaSvGxH
        NQW/AmyxG89pKYVwbk7twXc=
X-Google-Smtp-Source: ABdhPJxPN7/CFgtm7rYrSzTZHeTeVbLsiGlR4ss5CSQPbKO6qHbUMhjSo1wAejjzzJFgwqoEu5fvJA==
X-Received: by 2002:a17:90a:ae0a:: with SMTP id t10mr23982088pjq.169.1615204827488;
        Mon, 08 Mar 2021 04:00:27 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:27 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] bfq: limit the IO depth of idle_class to 1
Date:   Mon,  8 Mar 2021 20:00:15 +0800
Message-Id: <c23ff2bafdf20b3f18debfa1021e59a87aba1a11.1615203034.git.brookxu@tencent.com>
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

The IO depth of idle_class is limited to 1, so that it can
avoid introducing a larger tail latency under a device with
a larger IO depth. Although limiting the IO depth may reduce
the performance of idle_class, it is generally not a big
problem, because idle_class usually does not have strict
performance requirements.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ec482e6641ff..ea9d7f6f4e3d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4808,6 +4808,17 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	if (!bfqq)
 		goto exit;
 
+	/*
+	 * Here, the IO depth of idle_class is limited to 1, so that it
+	 * can avoid introducing a larger tail latency under a device
+	 * with a larger IO depth. Although limiting the IO depth may
+	 * reduce the performance of idle_class, it is generally not a
+	 * big problem, because idle_class usually does not have strict
+	 * performance requirements.
+	 */
+	if (bfq_class_idle(bfqq) && bfqq->dispatched)
+		goto exit;
+
 	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
 
 	if (rq) {
-- 
2.30.0

