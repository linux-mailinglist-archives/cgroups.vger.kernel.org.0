Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816F63489A1
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCYG6T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCYG6N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FBC06174A;
        Wed, 24 Mar 2021 23:58:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so515176pjg.5;
        Wed, 24 Mar 2021 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=U2Ib5ddOEuKBopBvgjIJBWoMeTG4fDxN3eIx8DhyDG0=;
        b=te9NBf+emxKWBuf7IJoeMpDO6KZYXEcL9VBzWGRMDUAbr/9GThJYF8oDn0LtaQjFlh
         X/4Hu5GtC2OgZVNMaOCOIIiRdILv+sAybk9aqi/C/cyU10oULWf4FBtNcla+hnbhDhAF
         DahdKd4VTsFjIoNo1TLAGFPsF493k6SseDengj3eeJam+Ibi6ZDht6aSmDkmcNoV8bvm
         6zveANN7YmTEirYyRgSV4zKcOyo9yWwcXJbLuKKf3p2SUwV2Ja3wX7h0Uv8qGfZDbytB
         fZTbj4tBwhRrlG+WokxAEtMbLHjJLbbJA6k841sKw2TtNQ2l9357WOJkKx0VgmsN85rI
         mKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=U2Ib5ddOEuKBopBvgjIJBWoMeTG4fDxN3eIx8DhyDG0=;
        b=ejEPpAOEdd29ql/bThKTbzPN9UtQ/WlTdV3f20v0hqbP+Cp5Hsk8dc5xCtYmSsl300
         tgefZZHcEwMPKW0ePv0D4mdg99816gqa6jfuG1167Zsm/CV6fKWhQ0vpMfm6M2EN0D1W
         TuYJm6mvwhdyQ6d36JW2N1Nw073eJtxnrGcpqZitgYd+/m281tG14EratMGSnxauBRD8
         PLDgtnNj+/ZfN/ZnDWToOqbOanwuxO3SK+ZF6bxyVMUG+P+76laSHO2AMGy2zO3vvdOD
         WdaWqXC40g70KLbBUGX20nybMcaAELOfORJrQbF5WeMt4HLaWoROBb9EQX6ddmeMlmO1
         Y+6A==
X-Gm-Message-State: AOAM533girqBFUm3FHmkRON1d7qZ7Ir7+jsdvHqS/dZyQDSDV5cjTqdP
        C+dRds9hxZvtIuXitLXAQBg=
X-Google-Smtp-Source: ABdhPJyVM2kF6l0JNKIU6En/XyKlAW+fJbqs96G9qFivDsddRi3ubEv44/Mv+myr8HThk5O8wSt7cA==
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr7585627pjh.19.1616655493466;
        Wed, 24 Mar 2021 23:58:13 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:13 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/14] bfq: introduce better_fairness for container scene
Date:   Thu, 25 Mar 2021 14:57:51 +0800
Message-Id: <9d9566d30702268e1f270f0cf7e8b08444c127a6.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In the container scenario, in addition to throughput, we
also pay attention to Qos. In order to better support this
scenario, we introduce the better_fairness mode here. In
this mode, we expect to control the Qos of each group
according to its priority better. Only add configuration
interface here

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 22 ++++++++++++++++++++++
 block/bfq-iosched.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ee8c457..e7bc5e2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6745,6 +6745,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 SHOW_FUNCTION(bfq_max_budget_show, bfqd->bfq_user_max_budget, 0);
 SHOW_FUNCTION(bfq_timeout_sync_show, bfqd->bfq_timeout, 1);
 SHOW_FUNCTION(bfq_strict_guarantees_show, bfqd->strict_guarantees, 0);
+SHOW_FUNCTION(bfq_better_fairness_show, bfqd->better_fairness, 0);
 SHOW_FUNCTION(bfq_low_latency_show, bfqd->low_latency, 0);
 #undef SHOW_FUNCTION
 
@@ -6886,6 +6887,26 @@ static ssize_t bfq_strict_guarantees_store(struct elevator_queue *e,
 	return count;
 }
 
+static ssize_t bfq_better_fairness_store(struct elevator_queue *e,
+				     const char *page, size_t count)
+{
+	struct bfq_data *bfqd = e->elevator_data;
+	unsigned long __data;
+	int ret;
+
+	ret = bfq_var_store(&__data, (page));
+	if (ret)
+		return ret;
+
+	if (__data > 1)
+		__data = 1;
+	if (__data == 0 && bfqd->better_fairness != 0)
+		bfq_end_wr(bfqd);
+	bfqd->better_fairness = __data;
+
+	return count;
+}
+
 static ssize_t bfq_low_latency_store(struct elevator_queue *e,
 				     const char *page, size_t count)
 {
@@ -6919,6 +6940,7 @@ static ssize_t bfq_low_latency_store(struct elevator_queue *e,
 	BFQ_ATTR(max_budget),
 	BFQ_ATTR(timeout_sync),
 	BFQ_ATTR(strict_guarantees),
+	BFQ_ATTR(better_fairness),
 	BFQ_ATTR(low_latency),
 	__ATTR_NULL
 };
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f9ed1da..674de8b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -672,6 +672,16 @@ struct bfq_data {
 	bool strict_guarantees;
 
 	/*
+	 * If there is no prio preemption, we force the device to
+	 * idle to ensure Qos. IO inject also has some additional
+	 * restrictions. The inject/merge queue should come from the
+	 * same class in the same group. Doing so will reduce the
+	 * throughput of the system, but it can better guarantee
+	 * the Qos of each group and real-time tasks.
+	 */
+	bool better_fairness;
+
+	/*
 	 * Last time at which a queue entered the current burst of
 	 * queues being activated shortly after each other; for more
 	 * details about this and the following parameters related to
-- 
1.8.3.1

