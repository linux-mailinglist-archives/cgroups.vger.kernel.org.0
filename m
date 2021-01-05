Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6A2EB188
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhAERiu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAERit (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 12:38:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54817C061574;
        Tue,  5 Jan 2021 09:38:09 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f26so68087qka.0;
        Tue, 05 Jan 2021 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bOiN/zd9h/CaIEMnPVzsFlx2JDr/hQqa7NqLbxPttmg=;
        b=A6Yuo3om6XcBhTEO/4ecawxwdtaAZUgoobIbMueTX0iyKN5I3/eZSh8b2H/H9cDex2
         DNgxYkpPOWU6ZWJyxvtFUYQYV25ZSDCFg4ocuHiarOztqojoRL1GML2sjQp4H95hu3Pe
         JKCFNqc0/UEQHIAEIeopDEVKMj93Viv8k5GQV24uR80o2JheusvN5HxBJkIH5gyu7Un6
         4vGn1EADmSXg+xHSlCuFCWDK9RiNFdrbVkB8oGgwyGKWMBQCaJ6EQRs2cpUK3NEmAv4i
         GnVoLS83odSpWLkHzklUVWxOTzE2p8AJFt4IkDWuatBTYKVfIwIkuRwTeBD/gNG2UXo6
         LuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=bOiN/zd9h/CaIEMnPVzsFlx2JDr/hQqa7NqLbxPttmg=;
        b=JhfciZ0Tm1U5OHLcb9KAB2b1eyWr5yhrSbWlmqZa8oTZ0e5pXu6L1wAHD2yQlMZUMd
         x7NPTmk104huhsLQEY0AwK9vrcOGkM5uQGN24p8n/3jIhO5Pr+H/9x3euIcM15FHwMuw
         S8JS/Nh1GXbAl9zS7IUvl3ongY2ClA1UT7qRAEiDy7649IYFdnGMru5xtbUrHAUCYEoS
         dGBjVJ/O1VyvRBe8ZiTeAOPY3yCLpjBf2WlzPtaX3ppZr6z6Xn6GXJ5jeIu9jKuRypV7
         4h2PiUdQII+Nls1qYxIBjK+jXoHK18Eb2S2vN50IrS7ykZCBy98vuz+iKZOKBgWKYgiH
         gbBg==
X-Gm-Message-State: AOAM532AevaWbPTUrKjMhNXdH4KtN6qna3CoYAceM5G2D4GflcmidXz2
        JT68mdgjMZLitvT2O+jb6DY=
X-Google-Smtp-Source: ABdhPJxZbLW5+IqyTbJnmEYdb0Rs+IQXH6gYL3AtynWZc0f8HuPaG/1JNjiasYeCf8JWMsrsXHGU4Q==
X-Received: by 2002:a05:620a:1398:: with SMTP id k24mr574456qki.109.1609868288305;
        Tue, 05 Jan 2021 09:38:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ce7b])
        by smtp.gmail.com with ESMTPSA id x3sm264757qtd.56.2021.01.05.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:38:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Jan 2021 12:37:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org, bsd@fb.com,
        kernel-team@fb.com
Subject: blk-iocost: fix NULL iocg deref from racing against initialization
Message-ID: <X/Sj014x+U8ubiFT@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When initializing iocost for a queue, its rqos should be registered before
the blkcg policy is activated to allow policy data initiailization to lookup
the associated ioc. This unfortunately means that the rqos methods can be
called on bios before iocgs are attached to all existing blkgs.

While the race is theoretically possible on ioc_rqos_throttle(), it mostly
happened in ioc_rqos_merge() due to the difference in how they lookup ioc.
The former determines it from the passed in @rqos and then bails before
dereferencing iocg if the looked up ioc is disabled, which most likely is
the case if initialization is still in progress. The latter looked up ioc by
dereferencing the possibly NULL iocg making it a lot more prone to actually
triggering the bug.

* Make ioc_rqos_merge() use the same method as ioc_rqos_throttle() to look
  up ioc for consistency.

* Make ioc_rqos_throttle() and ioc_rqos_merge() test for NULL iocg before
  dereferencing it.

* Explain the danger of NULL iocgs in blk_iocost_init().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jonathan Lemon <bsd@fb.com>
Cc: stable@vger.kernel.org # v5.4+
---
 block/blk-iocost.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ac6078a349394..98d656bdb42b7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2551,8 +2551,8 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	bool use_debt, ioc_locked;
 	unsigned long flags;
 
-	/* bypass IOs if disabled or for root cgroup */
-	if (!ioc->enabled || !iocg->level)
+	/* bypass IOs if disabled, still initializing, or for root cgroup */
+	if (!ioc->enabled || !iocg || !iocg->level)
 		return;
 
 	/* calculate the absolute vtime cost */
@@ -2679,14 +2679,14 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 			   struct bio *bio)
 {
 	struct ioc_gq *iocg = blkg_to_iocg(bio->bi_blkg);
-	struct ioc *ioc = iocg->ioc;
+	struct ioc *ioc = rqos_to_ioc(rqos);
 	sector_t bio_end = bio_end_sector(bio);
 	struct ioc_now now;
 	u64 vtime, abs_cost, cost;
 	unsigned long flags;
 
-	/* bypass if disabled or for root cgroup */
-	if (!ioc->enabled || !iocg->level)
+	/* bypass if disabled, still initializing, or for root cgroup */
+	if (!ioc->enabled || !iocg || !iocg->level)
 		return;
 
 	abs_cost = calc_vtime_cost(bio, iocg, true);
@@ -2863,6 +2863,12 @@ static int blk_iocost_init(struct request_queue *q)
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	/*
+	 * rqos must be added before activation to allow iocg_pd_init() to
+	 * lookup the ioc from q. This means that the rqos methods may get
+	 * called before policy activation completion, can't assume that the
+	 * target bio has an iocg associated and need to test for NULL iocg.
+	 */
 	rq_qos_add(q, rqos);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
 	if (ret) {
