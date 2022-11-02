Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857CC6161EE
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKBLor (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKBLoi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682128E01;
        Wed,  2 Nov 2022 04:44:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 128so16037056pga.1;
        Wed, 02 Nov 2022 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcGv5Q7FeBS6XrUIkFhAj+jX0IyfzopjVBjybBsLOts=;
        b=NIRcuK4gA8z2XwxCgqp9Dx/4mNr7Muhwf3kBaLGGNGk+uTXlEPN4veC+ztIPfZcDpG
         dPce3bE+p52PIK48GF4y5SLT6SZn+6d+4DZWr0NDfyVRVCpSttxyUsnr1Cugrz24zEh5
         ZNu9CBU0pkTqFBoa7OV7kseKNU3xeoIijtz595GAaIIAFqWKGkjRnedDDj67q4YoaKrs
         p6IybNn6dYnYMv7z8y25J6SCMTzqlPt62Ee869kVbfuxQX/WTEeT1SOx3oRxeglKhBDy
         vQkitQenfhlIOV4Xn4qrwOaUKeDYwWQplKnaI+hJXuQW6sj+z1SWNwQDDXomw7mgCldf
         xU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcGv5Q7FeBS6XrUIkFhAj+jX0IyfzopjVBjybBsLOts=;
        b=3j8JLB1Pg8xQ7T9epvUDcopgNwm4RsgnfhPzEMYdZe+P4bMxxJ+u+W5iVUDLPmggn2
         zIA69qj6tqrzo/zSIafpxh5oNoAGW7edk1iGZqjMy1YhYJ83pqF+/K8r4VWAiTTOZG2P
         wWX+F/acS2cKju1pZaLpMI8F9EQb5ydtitTGdHEhaqj5OhTCOcLWP32HlXq27gWQYaTA
         HiIX6HBSZHmCr88GzJ6NAeX+60uPhEGQ6vkIOfvXl+uIQ1t7cBwf8e/bakRgp7VrqC5s
         tzZHHI6/64Dndfw1g2jw47SPrTBCQCzEmCebWG7watJTjMGPCytmFa0MWjlqsaPzlGt+
         /sow==
X-Gm-Message-State: ACrzQf04oKX/HPoLa089K/7vg0dqZSWWyiSGMyJeRVOCuFb6+NihMfwo
        MbYeDL5rtPYoDoQZezaxq/LAPEOBbFu3/FQK
X-Google-Smtp-Source: AMsMyM5O4vlXZIVegdrEV7nsF6V+3nEid7nYAMcHEv2iar9n+VNzQrOtoJjE40XkUwLaO3K87P0AwA==
X-Received: by 2002:a62:32c2:0:b0:56b:2cce:d46a with SMTP id y185-20020a6232c2000000b0056b2cced46amr24448117pfy.36.1667389472415;
        Wed, 02 Nov 2022 04:44:32 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:32 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 5/5] block, bfq: change type for "bfq_large_burst_thresh"
Date:   Wed,  2 Nov 2022 19:43:54 +0800
Message-Id: <20221102114354.162-6-Yuwei.Guan@zeekrlife.com>
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

"int" type is more suitable for "bfq_large_burst_thresh",
so change it from "unsigned long" to "int".

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index b022e5ec0871..df866936380e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -701,7 +701,7 @@ struct bfq_data {
 	/* Maximum burst size above which the current queue-activation
 	 * burst is deemed as 'large'.
 	 */
-	unsigned long bfq_large_burst_thresh;
+	int bfq_large_burst_thresh;
 	/* true if a large queue-activation burst is in progress */
 	bool large_burst;
 	/*
-- 
2.34.1

