Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130B7D193D
	for <lists+cgroups@lfdr.de>; Sat, 21 Oct 2023 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJTWh5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWh5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 18:37:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C0D73
        for <cgroups@vger.kernel.org>; Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso963059a12.1
        for <cgroups@vger.kernel.org>; Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697841470; x=1698446270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp7b71HPUhZRYWiCA2ecvkahN2T6L1Zohh0DcisfMqo=;
        b=mpghkfyzOutQ8CeN0RTsOB/0AWJ4MqMMREcBV150vT/rU4NoA0CTQBI09Id5QZgKu6
         zsDGGBYpFyLGzg/FOj8u29B6DTgrQLkbAV7OQJmfl29HFC57Ux4CvgUWCFQvQMNMXN04
         gBLuVmp0DsoLj8I6TEB4/RGOu0MfMJ9eNFUnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697841470; x=1698446270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp7b71HPUhZRYWiCA2ecvkahN2T6L1Zohh0DcisfMqo=;
        b=JwP0zcMWqC4fod5uGT6g9iO+t8L0QDZ6lUl+WLQl2iZFOUUTcDBqLCYMEoiMjjrbgX
         eO/8osTy+gu04G9deesvNnNKH1U86FNG+Pl7NucFML2clreljc0qIDR7mTkjv8HcCwM0
         VKrJlB9KNoLzLvTR5g6wc4BCxujmiUaAeRzgXD+vg+HA1zwHaBsD6PZdtyR0cKyql2fk
         PnCDjyAtz5/PCKfFcKHrfL/u/+f7jf+IHPSlXSN3Wz2RN1vJPcAvJTRo33BllZp5FHmB
         7I/nZAxk/KQznxoZvUIJWpzA9ufqDdF2ZvgozPZ838ABmrFZefyCwyTF52LDlcLp+ZSV
         uTVw==
X-Gm-Message-State: AOJu0YwAE8fyf2IiATLloKHuPqp9/zd/hSTfQ8lhuv813kswYAfC8H59
        72YjXw25SLz1qmEI/m4Y2GQtEA==
X-Google-Smtp-Source: AGHT+IFTI62df7sLkxercIq20RisYKYexu5tSVNibXFRfdyyl/NCUMISJDc3unFPOyM3yu6AVX3h4w==
X-Received: by 2002:a17:903:610:b0:1c4:387a:3259 with SMTP id kg16-20020a170903061000b001c4387a3259mr3542740plb.46.1697841470337;
        Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2a3:200:8e83:71b3:7861:9c5])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001bbd1562e75sm2013392plg.55.2023.10.20.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:37:50 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, linan122@huawei.com,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] blk-throttle: check for overflow in calculate_bytes_allowed
Date:   Fri, 20 Oct 2023 15:36:17 -0700
Message-ID: <20231020223617.2739774-1-khazhy@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Inexact, we may reject some not-overflowing values incorrectly, but
they'll be on the order of exabytes allowed anyways.

This fixes divide error crash on x86 if bps_limit is not configured or
is set too high in the rare case that jiffy_elapsed is greater than HZ.

Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()")
Fixes: 8d6bbaada2e0 ("blk-throttle: prevent overflow while calculating wait time")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38a881cf97d0..13e4377a8b28 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -723,6 +723,12 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+	/*
+	 * Can result be wider than 64 bits?
+	 * We check against 62, not 64, due to ilog2 truncation.
+	 */
+	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+		return U64_MAX;
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
-- 
2.42.0.655.g421f12c284-goog

