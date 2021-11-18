Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEE45537F
	for <lists+cgroups@lfdr.de>; Thu, 18 Nov 2021 04:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhKRDoT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Nov 2021 22:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbhKRDoS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Nov 2021 22:44:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A583C061570;
        Wed, 17 Nov 2021 19:41:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so4034830pls.10;
        Wed, 17 Nov 2021 19:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzliISo7V8uUVqku+DWJNIL5TjLAAP7mfcGc98fW6A0=;
        b=RPSIL/Dm0fYurjsad/c0q8w5buiL0J62pQPw+GejaPg7nomIQasr4+DbviD0RltvFY
         azOgTDjzXW6oQ06DjBq+cJU5zj1kd0W7jgbSMNPyRJuqnSJoLZWrKJP0i0aXP/sHY4gH
         Zw7g+8FO+V/MARbljaiuJS7mhBYhrvBL/2nyp1m5TzPtbAlz2lnlwDxnmBA4Kfdj7Cc6
         y4xSeP8y/1cpndIpFgDjyY6TSLV5t9XKKOr3W/Xz/pid+2n6aAiovEbhV0H7/yoFe1vU
         rzhm7iPiFGfA6Sr1OPnZ4C4WCbbDxZ+Iu0sQEjAD6x9w7kczgRNMQET7LjHbErEIGfVV
         zgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzliISo7V8uUVqku+DWJNIL5TjLAAP7mfcGc98fW6A0=;
        b=l02tGGH855JkcmTc/+rMAI1qr662gqJzN75Ug7eka7gBujikhCoSeRx1avdcYaYJ08
         dqkq/p37j9i8HpYkf3K51its0Dj+d4l63BLRyAXuO+ciCBe0gyTHvRRhSHTaBSm1zhsx
         0bMrVaoVaFk1b5B5u44fztdRTVgUhJwqbuLWsLgILZvvsRVRHAGyNbayenxAEqz9uSf2
         tgyg7gmrACIMG16G/xgLKyXYcFSsTpSpulk1tMT3wLhObEodfLBJ9du+u0UzOnc7ZDeD
         eoY7DyzRqbMrj5G2LRfDlZuem9SEknuPVSKCstR+B3OsapzUgFC1ernj5X1v1U8u440D
         zVRA==
X-Gm-Message-State: AOAM531BZw9dza5jHTlrPie9rw0YyWK9vTEllNbyQPsDs+8frbuAzyKy
        RbKiFxYUr85BcktM9xY3Qbs=
X-Google-Smtp-Source: ABdhPJy9TQybZWK/kNvGl1VugQZiEdLnZvydRYvv3w0lvYfQPUawBw5dU10xyrtof6mY62ywTJAZZw==
X-Received: by 2002:a17:902:684b:b0:143:84c4:6561 with SMTP id f11-20020a170902684b00b0014384c46561mr62115063pln.33.1637206879054;
        Wed, 17 Nov 2021 19:41:19 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p21sm1114152pfh.43.2021.11.17.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 19:41:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     tj@kernel.org
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, cgel.zte@gmail.com, deng.changcheng@zte.com.cn
Subject: [PATCH v2] block: Use div64_ul instead of do_div
Date:   Thu, 18 Nov 2021 03:40:33 +0000
Message-Id: <20211118034033.163550-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117010358.158313-1-deng.changcheng@zte.com.cn>
References: <20211117010358.158313-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e68a9a2..2db635d66617 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1903,7 +1903,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 
 	if (tg->bps[READ][LIMIT_LOW]) {
 		bps = tg->last_bytes_disp[READ] * HZ;
-		do_div(bps, elapsed_time);
+		bps = div64_ul(bps, elapsed_time);
 		if (bps >= tg->bps[READ][LIMIT_LOW])
 			tg->last_low_overflow_time[READ] = now;
 	}
-- 
2.25.1

