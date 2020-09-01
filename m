Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A49259EBC
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgIASxY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbgIASxV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A106C061246;
        Tue,  1 Sep 2020 11:53:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so1991228qkd.9;
        Tue, 01 Sep 2020 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a96NqVhWlH/6rbnaJHsSXmoP7NyH4YVeyS7xAuR4Ue8=;
        b=Rl00dssZUwB0VlBF0vtS3UAVh028ZEmyWDony//gcOYbkr1LyexfkGRr2AguBVNakR
         K9Ebkf/f1WXdvNiuOuHTGxQxRLnqr3R8Fm7YHS1XMUOlsM758If3x29KbUASRlcqgw30
         vqtyL+ENveuwJjS5jDfPnVcikKUUEnxCOzWM6HwXiVJ/CZPghydNweK9CflK1x5ZGzrk
         V2fj/o0wnwORTQvSZYBc3FYl5UTbNxX5tZhJvvqbb3rFrh3GCGYCrH9CnrGOi2q5PrwO
         d6ktGCGprgljvf9/VpsSttymMRC1kzi+LXId7l4BQgp7cA1tElxDRWhoJafqSIslJER8
         K1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=a96NqVhWlH/6rbnaJHsSXmoP7NyH4YVeyS7xAuR4Ue8=;
        b=aO+ONcOMMKxR8La9MLubJs5cqAn5tX3bbrL2CLWpJ/36L/ABI4hIoCTJKrAG1PNC4C
         kcHj/UvilOQ4duWZlY00I9D4doI4gWegNmWZrgMdUdlT8sxe4uNe2pCi90n6MnVZXdOj
         EnrIr038IJ41JXab3kVckZ33ewv2ZOmc9H7lH09TvvNyzrmeulDjrAht13KXKgMDz0wa
         uCrN6+OYJ5XNxrbmUNo7I9xHIFImLlrZYLjTYCEfY1Kgo31LM1xaRHmY+A+La+ufJBhN
         DQzN+aeHb93eKbJiFZySK6TN4MnEk71R7yoBsxOB1xG4O3ecewAIPv4Py7yEo5K+OVF8
         EJtg==
X-Gm-Message-State: AOAM533AyeJy4XMpAR0Jwfq0h8Acr5zlr35IvtsCCWOt2KB+yuo5wvVe
        YcbjiEEOioWzg7PSInQf3mY=
X-Google-Smtp-Source: ABdhPJzqAoMxEp76tyJMpXipznNzMrv+5slAYR8k+HgXrrZ63L+r8iQLKkluRa2/I3WVYJuB3DYV7g==
X-Received: by 2002:a37:9a13:: with SMTP id c19mr3186201qke.48.1598986400192;
        Tue, 01 Sep 2020 11:53:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id k3sm2317260qkb.95.2020.09.01.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:19 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/27] blk-iocost: clamp inuse and skip noops in __propagate_weights()
Date:   Tue,  1 Sep 2020 14:52:35 -0400
Message-Id: <20200901185257.645114-6-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__propagate_weights() currently expects the callers to clamp inuse within
[1, active], which is needlessly fragile. The inuse adjustment logic is
going to be revamped, in preparation, let's make __propagate_weights() clamp
inuse on entry.

Also, make it avoid weight updates altogether if neither active or inuse is
changed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 78e6919153d8..8dfe73dde2a8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -897,7 +897,10 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
 
 	lockdep_assert_held(&ioc->lock);
 
-	inuse = min(active, inuse);
+	inuse = clamp_t(u32, inuse, 1, active);
+
+	if (active == iocg->active && inuse == iocg->inuse)
+		return;
 
 	for (lvl = iocg->level - 1; lvl >= 0; lvl--) {
 		struct ioc_gq *parent = iocg->ancestors[lvl];
-- 
2.26.2

