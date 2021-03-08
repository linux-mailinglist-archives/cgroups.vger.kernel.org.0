Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3E9330CF8
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCHMAm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhCHMAh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09FC06174A;
        Mon,  8 Mar 2021 04:00:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so2845314pjc.2;
        Mon, 08 Mar 2021 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MsMrEc4lTH47pfPngVwGfQNjeTIkU6svvwLN8Qg8P28=;
        b=mUhvT0FPrBG4HiXW7y9J5WZyUFm+kOkubtMISyASrxvxjTNSoam06f4EeFpOTS9Wuu
         thpfbVouSfVT7cXTmuRE0ohBa+/AQ9VhaFZOlbfshF66qKj3i/jrFp+7PmvcXJTYmWMH
         Oq0ZYBzYVY1mLPzsORhJjSK+oXkkGmW1g9lLklufsnikuAli+fxEkJopncvjQS5IQswZ
         nviudM05sIkbc5fpXP1pyW6CIgEfa8C2NDWAtX9Wh9JBwl+9SpRfaWAPVhT1gIfrWqqn
         EPlA51MNz2CDinh4BlhkmljgFeXQQan01LmYCGkmcL8xscJQxoRNLfPAzXVfKUv7KcaA
         3Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MsMrEc4lTH47pfPngVwGfQNjeTIkU6svvwLN8Qg8P28=;
        b=D776WW47KlHN/Oyxp5WtgIHBAupImub25sxm8la8cJCpiqC0vYlOB0o1oKP39yF3rb
         0TBHSmNu9huOQqvTPfgRrIC2vM39BWq8KjtMNNslsjmOZO+lP8ADCpDOh3YTlunMoaL1
         3V6ix5gjbJxPcawCYr6lA6Zrmr/55RGZoCvLJmRtZDbL3ONKvub213lCPaUp2yU/rhzS
         GWeQjbcV3g9KZy+QIBiU3S7eDdRK1BuJY7/IcemmA8XzHmSvYBQ8juGSGd2wK83lm99F
         Q1vwXrIy6SUc8phl9BkOac/NCUPR93Ust8jLDi0UyLIFnnkOfWMJUTBGPwo4x+crr6Vk
         /E+Q==
X-Gm-Message-State: AOAM530v4Zq1aqv2mMdRV3b3vbQhDo2+/cuAXddBBoYKqRFcrB4HUtJK
        2wgeyvu1gzGoZL6hTPBwIKU=
X-Google-Smtp-Source: ABdhPJxvsaf5aIPY3hQ7qCbFu6yAlYxbnCazDOJ0goZnSwJtQXW1GFOHDr8iU/9EgYJ4dp7vAiZMvA==
X-Received: by 2002:a17:90a:598e:: with SMTP id l14mr23872714pji.187.1615204836865;
        Mon, 08 Mar 2021 04:00:36 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:36 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] bfq: optimize the calculation of bfq_weight_to_ioprio()
Date:   Mon,  8 Mar 2021 20:00:21 +0800
Message-Id: <cbd1e689ca0010c3d437f22c904f10b123e6b1f4.1615203034.git.brookxu@tencent.com>
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

The value range of ioprio is [0, 7], but the result of
bfq_weight_to_ioprio() may exceed this range, so simple
optimization is required.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-wf2q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 850a8e2f0bda..1d565daf516f 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -536,8 +536,9 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+	int ioprio = IOPRIO_BE_NR  - weight / BFQ_WEIGHT_CONVERSION_COEFF;
+
+	return ioprio < 0 ? 0 : min_t(int, ioprio, IOPRIO_BE_NR - 1);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
2.30.0

