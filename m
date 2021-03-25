Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9C34899A
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCYG6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYG6K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF98C06174A;
        Wed, 24 Mar 2021 23:58:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j25so1072418pfe.2;
        Wed, 24 Mar 2021 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OJnLYiytqXxdA84x+UwnW3WTrmnnWDql1WAM6O4M83E=;
        b=VV5eQDSz57WBHVe/d36HjTfftb+WCgACha+j2Z14/yKHkQdeMmmDgUXNvw8zKfpN8L
         rhIAuG9VmUUYszENYO3A/nB67emVOE9ZcL3fxI2Z7u6GM6F7fINCFMNxn3+KEApsP1V6
         Vm1x5Ts7BsBTyvyT4+GlOtinMu/OnwzoP0E6RiHsYF+FluUdRN7Lc8z99cbNf1rUw+aY
         hXOFNmrUFb7IlVwEN9INb4ll2P6AcPu58QVfZ1E5lzKKB75cPrl390L2j9BETANhTpBq
         KnAvQHUuKtI5v3cGH+e3Dx4+FmjUqQCTQTiGxzFs5PemHgGvP25cA7Pn0FCP2ADfWt3y
         wlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OJnLYiytqXxdA84x+UwnW3WTrmnnWDql1WAM6O4M83E=;
        b=fN/XNcN4AZX3p591BX8PJOVsGCif6lyS10L2StheuNJfiMBud2yh0OvIINPfrOJ0Hw
         ZNkxdlr6zZIxKHr7xTKoPH+Ks+GdyyhAFqc8C+SLcfy49kwXXw9UXar4LmUZP0t6MfBl
         17eID+phO+jB+U/9/BfmAi8TKe7K6VPiHLSat8a6+dM6UoIORZJ58R2JzYyXbQVtO/ce
         hb398OYDev564r+0HG3KMM1kwjDhpC7a0xsym0Ohq4P4Cwt+oK5n+UHgn8b1BB9ZC9hD
         8B2r6xP0zJzuNNA8Q3yDCjOyJzj/ltMdNQynkOX5e+rGsbL3DWI6em/0RmlK2kn9U33V
         jsEw==
X-Gm-Message-State: AOAM531cNZmzrUFjOl8Le7erKJ4LKki4D+yb62yNlhMzPc7NnEL+nE8C
        Hl4uyfD8+LLvK8r0D1SYVBo=
X-Google-Smtp-Source: ABdhPJwIX6VQzcFDvKpAGEX/fGhgaAsPwSIsGoq1+t3kMiusdgZewhUCgKFDIxA5JIx+e0t9iemRjA==
X-Received: by 2002:a17:902:d30c:b029:e3:f95:6da5 with SMTP id b12-20020a170902d30cb02900e30f956da5mr8258230plc.6.1616655489503;
        Wed, 24 Mar 2021 23:58:09 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:09 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] bfq: limit the IO depth of CLASS_IDLE to 1
Date:   Thu, 25 Mar 2021 14:57:49 +0800
Message-Id: <43daae87ff5fd6ed66e7859b8bc17818f309b9ff.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The IO depth of queues belong to CLASS_IDLE is limited to 1,
so that it can avoid introducing a larger tail latency under
a device with a larger IO depth. Although limiting the IO
depth may reduce the performance of idle_class, it is
generally not a big problem, because idle_class usually does
not have strict performance requirements.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5f7a0cc..8eaf0eb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4831,6 +4831,17 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	if (!bfqq)
 		goto exit;
 
+	/*
+	 * Here, the IO depth of queues belong to CLASS_IDLE is limited
+	 * to 1, so that it can avoid introducing a larger tail latency
+	 * under a device with a larger IO depth. Although limiting the
+	 * IO depth may reduce the performance of idle_class, it is
+	 * generally not a big problem, because idle_class usually
+	 * does not have strict performance requirements.
+	 */
+	if (bfq_class_idle(bfqq) && bfqq->dispatched)
+		goto exit;
+
 	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
 
 	if (rq) {
-- 
1.8.3.1

