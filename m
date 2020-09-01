Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF50259EBA
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgIAS4L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgIASxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4CC061246;
        Tue,  1 Sep 2020 11:53:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so1731881qtv.12;
        Tue, 01 Sep 2020 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkFoDBzJXtohjGExUSaDt/SZfRBA8OsFvyf57BiJvyg=;
        b=cxg/UxVAB6yQXR3TZQm4h8sbyRVSYu+uhDSfcqkgpdnlD21RHugcINxXFcSRleiXJv
         eASQJsFp8YoQy2bNQEPjflIStjRBqT3xMzOBW+SCvqxeBqAQrYVBmJZbAcLEBn+xgZI/
         Q6vKOOK7PQsxfBPW/sgPXQ3gNtTxzElyrcOyhvQZbRmdhcIJqSKuOoltun0aP4ks/Aa9
         mP/EJrsPFqyNQuKWojEvF5Dlzic6YjUQzAg0apY1Q/bTV/X8Xv91XuKOqqYhrmEiNJId
         1OfDuY2UKMrOf0xGcPrE//vyBzVtl0l3eaIcmVJR21ld44TE7ZAYR+TWA5PTE5FqoyuX
         ziTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kkFoDBzJXtohjGExUSaDt/SZfRBA8OsFvyf57BiJvyg=;
        b=fJjzxBW+wBxW3qqGprZDRiEntaRuaUu0+L91/jIgd+g/Xc9ZW1u4HqmWhqWel8HFbS
         nLECk+tnfk97OGqZZpEem4V/Svfq1SOgoQi3ewcKXDGHCGHS++2C3yMYiB7+eFmZnL0N
         yZjFaHE2IyxW1q5xm9cWKoZAP6sZ9gdGbyz0PJf7mR9l9ESUPIcEtXcdt96TBPpv1xCx
         5Y4idY4Z7qqv5PN3qepUpuFV8bDeiRr4HfPnJZejhQx+kqoV8k4Nnfqey8pCKssQqr5N
         i8ZumX4Ao9KZX/c69lbvvnrFXEchMJ0e06NsiV75NW4yAVTf/Pgg/QFnzCmDfzcnKM9f
         XWkg==
X-Gm-Message-State: AOAM532LfUW4+46ZFIOvY6Nq0D+peExUOYGPR7K3nnZbsw1F3+clqolE
        OvW33FGv5WFG3XKCgvOM5W8=
X-Google-Smtp-Source: ABdhPJw5n8iYV30N3UTNTwNS7Ice6zxRZAH9BImIhKiWWnxXVfQZA19w8DrAhH9ttXLvz7JSIhLtjA==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr3261767qtw.20.1598986415568;
        Tue, 01 Sep 2020 11:53:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id j74sm2679768qke.7.2020.09.01.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:35 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/27] blk-iocost: make ioc_now->now and ioc->period_at 64bit
Date:   Tue,  1 Sep 2020 14:52:40 -0400
Message-Id: <20200901185257.645114-11-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

They are in microseconds and wrap in around 1.2 hours with u32. While
unlikely, confusions from wraparounds are still possible. We aren't saving
anything meaningful by keeping these u32. Let's make them u64.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 00c5a3ad2b5b..dc72cd965837 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -409,7 +409,7 @@ struct ioc {
 	atomic64_t			vtime_rate;
 
 	seqcount_spinlock_t		period_seqcount;
-	u32				period_at;	/* wallclock starttime */
+	u64				period_at;	/* wallclock starttime */
 	u64				period_at_vtime; /* vtime starttime */
 
 	atomic64_t			cur_period;	/* inc'd each period */
@@ -508,7 +508,7 @@ struct ioc_cgrp {
 
 struct ioc_now {
 	u64				now_ns;
-	u32				now;
+	u64				now;
 	u64				vnow;
 	u64				vrate;
 };
-- 
2.26.2

