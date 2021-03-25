Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D003489A9
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCYG6s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCYG6Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CABAC06174A;
        Wed, 24 Mar 2021 23:58:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so2313761pjc.2;
        Wed, 24 Mar 2021 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JuEIKTyHIE6982Ro7ODwPRKbvkHbUMFr2p3n7zNL9q0=;
        b=tXTbr0x/J8iMTNXhIN/eItlxYhN0ex4ZfyKs5H2Ae3cPdXD1LL6rXlNsg7pJg7tcin
         SlFq7ogSnGJWQIEtXORUp1g3HuUV4CxNAvLucGkYZhqUSRSWzUlJ44XbSGWdXQNSYuBH
         76St25IXwzMTnLNDtoV9QtSTbaKb4gqbCTaKsx3FmOO89cwOdTWo6x7mXsxvrSv3FdPg
         RpryhaiGBlL/D0O6a1mS1Jq2cJlm+mqmwng1xTrO2/IlG/gLi8CGKXVzTN0QvZU8q5IY
         6z2piJav06VPmjssz3Bxoz6GJsV4FlTV2kTKnQSGX/rTMq57n6Qrrnu4mZ239oo5LSYv
         YrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JuEIKTyHIE6982Ro7ODwPRKbvkHbUMFr2p3n7zNL9q0=;
        b=IIkTGWy3JN0A9oAeh/nOb5QxKeoZqpWYK5jL1JBen7Jv2DjNtKDvqo8mipCoK/tP1H
         dCXaOgS7K0O7jq5kqhDxEcNXqK+eqzQpSp6iyG7u1mAViRjqE37Ag07nuQAfDCtIHFJ/
         hJcrjf7ykkSilYpw0yU6icbrRGWfVIWYbVfEmohiR4i30DCJSecz4gu+Au58c95KxJUW
         iVj2LXpsmM7sX0hpACzCZg1hOdKlMlKevkzP0jU+71X3eJ7LBuSh/fHffld2w3+5cLqz
         bvPFcvYSRvcKng9U84bwm2EWDy5ZlLZUPe2l1sLg9jz+y0OsD/fV0at/EQFjbzVNoGwZ
         JFdA==
X-Gm-Message-State: AOAM531E74x0S4oAaEfY6LmoHOlIOLGrEMTTrVZbbpekkxTUym+kdqRi
        4iclHTwWrLyxQoMSmRwGFn0=
X-Google-Smtp-Source: ABdhPJwsendGaguFkI9Rmi01gdnLDO5/vNHFTlc6ctIBIqK+rxI6eBbDGp403c1MfYz8PLoWzjpy0w==
X-Received: by 2002:a17:90b:188:: with SMTP id t8mr7217284pjs.169.1616655495234;
        Wed, 24 Mar 2021 23:58:15 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:14 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] bfq: introduce prio_expire flag for bfq_queue
Date:   Thu, 25 Mar 2021 14:57:52 +0800
Message-Id: <31127a6ea5fd65c63e2327d1a4820d948d5a222e.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When in_service_queue needs to be preempted by task with
a higher priority, we will mark it with prio_expire flag,
and then expire it on the IO dispatch path. Here add
prio_expire flag only.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e7bc5e2..6e19b5a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -153,6 +153,7 @@
 BFQ_BFQQ_FNS(wait_request);
 BFQ_BFQQ_FNS(non_blocking_wait_rq);
 BFQ_BFQQ_FNS(fifo_expire);
+BFQ_BFQQ_FNS(prio_expire);
 BFQ_BFQQ_FNS(has_short_ttime);
 BFQ_BFQQ_FNS(sync);
 BFQ_BFQQ_FNS(IO_bound);
@@ -2986,6 +2987,7 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 {
 	if (bfqq) {
 		bfq_clear_bfqq_fifo_expire(bfqq);
+		bfq_clear_bfqq_prio_expire(bfqq);
 
 		bfqd->budgets_assigned = (bfqd->budgets_assigned * 7 + 256) / 8;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 674de8b..8af5ac0 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -777,6 +777,7 @@ enum bfqq_state_flags {
 				     * without idling the device
 				     */
 	BFQQF_fifo_expire,	/* FIFO checked in this slice */
+	BFQQF_prio_expire,	/* should expire for higher prio queue*/
 	BFQQF_has_short_ttime,	/* queue has a short think time */
 	BFQQF_sync,		/* synchronous queue */
 	BFQQF_IO_bound,		/*
@@ -806,6 +807,7 @@ enum bfqq_state_flags {
 BFQ_BFQQ_FNS(wait_request);
 BFQ_BFQQ_FNS(non_blocking_wait_rq);
 BFQ_BFQQ_FNS(fifo_expire);
+BFQ_BFQQ_FNS(prio_expire);
 BFQ_BFQQ_FNS(has_short_ttime);
 BFQ_BFQQ_FNS(sync);
 BFQ_BFQQ_FNS(IO_bound);
-- 
1.8.3.1

