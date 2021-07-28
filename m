Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD533D84C0
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhG1AiO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhG1AiN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 20:38:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE9C061757;
        Tue, 27 Jul 2021 17:38:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1712733pji.5;
        Tue, 27 Jul 2021 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=b72Mqy89B2Ts98E37aqCi1/9GXkKJ3If2NuRSfThl+o=;
        b=RxkjKWb6vyuBj8jWOTjy79JqnSnwpNXwKIU1Il9ltbcinklyLudxGTiBHX1qO3LvhE
         euT7itrHJfxo4ciPDcJDRzAxrrPonqCyfjmFuAqTMkvwIUdQwe1sAbTXRF07PdKWqL9e
         84MpOioni1oX/HXPLnOg7JVWLjP9L23W2yYd6Z9dV/iIuttKbOGY1iekWpKRalagZd9W
         fbI8EZJU90Y5DJBy3rufvh33gSVRgACIr4mU0MXP5Yp0FB+Bmj3dyQ6fFsnPmsHLfN2P
         LmjJy+/Ly99xsk1YEIAWnT8BgPT5W7ZNuiNyRyUn9bX/Vae3NeVM3EBwj2w4LHt6X8t1
         UKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=b72Mqy89B2Ts98E37aqCi1/9GXkKJ3If2NuRSfThl+o=;
        b=ioZaI3sdXC7qVtJ66U8YzAYePZ129ougmkHUbVduJ3e3AZKfeOvWY2l3k57959Tfsz
         pvfBtsY1ML5LSHpHiehwVEZaDaQItGaP06kbMXlSGzlywq3Au2qsqNGkO+cxRyWk6sO9
         xayoqnwuTPZygJkgsPxOtXaJVbAOoeFjX5fNcJ8EZCBT1/5RbHUGHHZUfq3Nii1CtQDd
         Vi0XSc6EaTWNoDy/wrSk9azORfVn0bjYY9JQGGRdiMexXOJ/vLLkL7+2fzFUBrjgaIMi
         latJqSkISIG1XQA42EqawZUi9gYTZR+OzmKJerhen+vAeeYPf78qbAhxZFuHcKUHTGLW
         VM6Q==
X-Gm-Message-State: AOAM533uhPnGAPB5ioGiBS6tesU0zgH6U64+G7fHuiVybWfN59KM5LvG
        Wzb/6EmUIHm44E/Rnyn7NjM=
X-Google-Smtp-Source: ABdhPJyKRriKC2wXBJEmKRok3sNxTr7ouELGtQ60qxrAxiS/62k4Hx//aIHdsNxR1ZZW5Z4eAMFIEA==
X-Received: by 2002:a63:510d:: with SMTP id f13mr22759796pgb.308.1627432691794;
        Tue, 27 Jul 2021 17:38:11 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id m19sm5088551pfa.135.2021.07.27.17.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 17:38:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 14:38:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH block/for-5.14-fixes] blk-iocost: fix operation ordering in
 iocg_wake_fn()
Message-ID: <YQCm8flaer2Ek0c+@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From aae4e1b4e26c3c671fc19aed2fb2ee19f7438707 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 27 Jul 2021 14:21:30 -1000

iocg_wake_fn() open-codes wait_queue_entry removal and wakeup because it
wants the wq_entry to be always removed whether it ended up waking the task
or not. finish_wait() tests whether wq_entry needs removal without grabbing
the wait_queue lock and expects the waker to use list_del_init_careful()
after all waking operations are complete, which iocg_wake_fn() didn't do.
The operation order was wrong and the regular list_del_init() was used.

The result is that if a watier wakes up racing the waker, it can free pop
the wq_entry off stack before the waker is still looking at it, which can
lead to a backtrace like the following.

  [7312084.588951] general protection fault, probably for non-canonical address 0x586bf4005b2b88: 0000 [#1] SMP
  ...
  [7312084.647079] RIP: 0010:queued_spin_lock_slowpath+0x171/0x1b0
  ...
  [7312084.858314] Call Trace:
  [7312084.863548]  _raw_spin_lock_irqsave+0x22/0x30
  [7312084.872605]  try_to_wake_up+0x4c/0x4f0
  [7312084.880444]  iocg_wake_fn+0x71/0x80
  [7312084.887763]  __wake_up_common+0x71/0x140
  [7312084.895951]  iocg_kick_waitq+0xe8/0x2b0
  [7312084.903964]  ioc_rqos_throttle+0x275/0x650
  [7312084.922423]  __rq_qos_throttle+0x20/0x30
  [7312084.930608]  blk_mq_make_request+0x120/0x650
  [7312084.939490]  generic_make_request+0xca/0x310
  [7312084.957600]  submit_bio+0x173/0x200
  [7312084.981806]  swap_readpage+0x15c/0x240
  [7312084.989646]  read_swap_cache_async+0x58/0x60
  [7312084.998527]  swap_cluster_readahead+0x201/0x320
  [7312085.023432]  swapin_readahead+0x2df/0x450
  [7312085.040672]  do_swap_page+0x52f/0x820
  [7312085.058259]  handle_mm_fault+0xa16/0x1420
  [7312085.066620]  do_page_fault+0x2c6/0x5c0
  [7312085.074459]  page_fault+0x2f/0x40

Fix it by switching to list_del_init_careful() and putting it at the end.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Rik van Riel <riel@surriel.com>
Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org # v5.4+
---
 block/blk-iocost.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c2d6bc88d3f15..5fac3757e6e05 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1440,16 +1440,17 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 		return -1;
 
 	iocg_commit_bio(ctx->iocg, wait->bio, wait->abs_cost, cost);
+	wait->committed = true;
 
 	/*
 	 * autoremove_wake_function() removes the wait entry only when it
-	 * actually changed the task state.  We want the wait always
-	 * removed.  Remove explicitly and use default_wake_function().
+	 * actually changed the task state. We want the wait always removed.
+	 * Remove explicitly and use default_wake_function(). Note that the
+	 * order of operations is important as finish_wait() tests whether
+	 * @wq_entry is removed without grabbing the lock.
 	 */
-	list_del_init(&wq_entry->entry);
-	wait->committed = true;
-
 	default_wake_function(wq_entry, mode, flags, key);
+	list_del_init_careful(&wq_entry->entry);
 	return 0;
 }
 
-- 
2.32.0

