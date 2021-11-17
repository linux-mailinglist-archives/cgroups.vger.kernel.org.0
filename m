Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7735F453D68
	for <lists+cgroups@lfdr.de>; Wed, 17 Nov 2021 02:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhKQBHC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Nov 2021 20:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKQBHC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Nov 2021 20:07:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E195CC061570;
        Tue, 16 Nov 2021 17:04:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g18so1027756pfk.5;
        Tue, 16 Nov 2021 17:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLz5baL/tForuA6NLmg8XFMsVJ3OJ6G5avfxPN9wfAY=;
        b=CkHizIwo5OxrH6SXMtbFaBo3rxwHUxfjaYQqiQXz2DG4k37ZPaiTMLniKDmBOEYATR
         m3NFrhQCYldaZCZRLdM++qdG+mkLTik41OH67xg1jaWt3Gz8jH2zkJqAXcUoLuPpJNwr
         a7+Iq2UkHkQAANfQ5gvMuaCvpIPB5LbL0b51sVBNMdnBDjbIoEB0ujCNjNhF/FCTBoLq
         aSQ+OS81elts5Tre9UNFtGkR9+gcmDWlcMaVmFd9EYWtsodEyX740N7WRAOPsrRcx/BV
         f+Jr0PYJwF3Z3NzFAWp1mwRjsMB0/ei2In+9mI79i3swOtidWcCeWFU4eyERo0mJHkWe
         dSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLz5baL/tForuA6NLmg8XFMsVJ3OJ6G5avfxPN9wfAY=;
        b=u+lapJqTswyUZ2HDPNHSsQkmBRm8hErbNs3aeSmEdTaxwmhyRlRJ72BOdtbTM6d8xZ
         7CG9h6ePFPeTNSWduFeymBs4DlUVeReRq4fkx4xKnCkEyKAmpTDF1Uono3+ndID2aORN
         lumSc8ChGMVAhtByFkEJs5FTtQAiPyJdqvEmwDIjaoXdRT3N7kFdRExOu39lfkH2ezZE
         tTqALoHcKkeNQXQnMpEzZC0T8OG8CVhcJsO9s+4Xl/lYWdLnBb3d6VlSUSqVdxWNpX9o
         U4VYXTfMuwLkyvc6VV8mVUxD6In2nqloEg685GFnHmraEF4DtiuYUlMUUVYXGmE0Q8jY
         a1qw==
X-Gm-Message-State: AOAM533agdw1T3LS9G5VMuLVV9vBNsc0Oupnl9IIuJuPqTtzL7jUIz8j
        1FySHglMtU/LURiUbSWzsK5TeIQUtWk=
X-Google-Smtp-Source: ABdhPJxjCw37K4wG9Bj2g5qb8rvxH1zYGXCDFKGyeao3JLec2qMsk8dqqvU+XtDp1LRq+E9ueWczxQ==
X-Received: by 2002:a63:920b:: with SMTP id o11mr2455453pgd.314.1637111044472;
        Tue, 16 Nov 2021 17:04:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b15sm19638050pfv.48.2021.11.16.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:04:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     tj@kernel.org
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] block: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 01:03:58 +0000
Message-Id: <20211117010358.158313-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. If the divisor is unsigned long, using
div64_ul can avoid truncation to 32-bit.

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
+		div64_ul(bps, elapsed_time);
 		if (bps >= tg->bps[READ][LIMIT_LOW])
 			tg->last_low_overflow_time[READ] = now;
 	}
-- 
2.25.1

