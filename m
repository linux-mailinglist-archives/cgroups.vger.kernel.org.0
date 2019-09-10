Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D65AEF55
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436709AbfIJQP3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 12:15:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40317 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436575AbfIJQP3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Sep 2019 12:15:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so21426927qtq.7;
        Tue, 10 Sep 2019 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BzSkrvowps0g0N5g6HScYMxe8xO2mx5UwGqeLTuW+Hk=;
        b=ParuHlsgLMt+EXk5iwj5kllgfVd78Xqi8XxmT53ucKqxnnfE9HO1f70TItdD4QTprD
         NSI2+nSSvd0DYFCBc/MYuP/0c21UzIXD3t0PjcjjuelpRvBobkcN3+HCpgtP2rWKgIUJ
         +gy6rh9Tp0ZCS6BiO7coXzGiUQIE+Rg/GI+WbVE5Nx9gDt6fKH30h7tddn6FTpqTfoyp
         WbVyAMGGuFpwjE6MtE+FCUW0R4lw8vsBpG4FJAIdTV9YmqRudzlnzSX5XLtaAdJGWfbI
         E/gWUk5lSZgExw+x22kpQ2NEsvbI0H4SfrVZySWh+0M1No6viAjzSv711nFqxfPcoAiI
         bHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BzSkrvowps0g0N5g6HScYMxe8xO2mx5UwGqeLTuW+Hk=;
        b=M38Nayzu2e6KcXBQR00BJzGTyMfEucIAXATM2T5ylHOuGD3nDHq7ryHBK3tAcbDA12
         lOlQfsQwCblAupd/ix4xZFwQo7RuFYWLu52P0E5SIAp4OQPaqDI7iGrMdG96ibKLhqJk
         rnNxuhAxvdW8x2k8oGpuFn9/UW3AtMwfgHojUmo39dJKDuVQV39Bi4p8owjgpUMQHv4Q
         usLvDWKRp3hWnnFpMAYw1wLkokqjhqKjpIyVWJHzhGK5C5H7QOwMJf7bZXRui7TO2Zdu
         LQ6zZrtqlmJzhTY9BAlRHQTtuns23A7rj9Fs8OWzngSd5uO2K6XIsF+v5xjQU3H3Oog1
         GLdg==
X-Gm-Message-State: APjAAAUST1zLEOtpJ3Jg3cDmMGdVS/WKvGApzArIpMZqSj6vRXOtlc/5
        jFNNJd95eUfv883ayGoau77JTZwTziA=
X-Google-Smtp-Source: APXvYqz+fRhZSzqN0CIOHMhPrk/SeU7rcytoTB+/zfQXi6mmIdIDRH2vqSMTY0gjwRxRcjtRFKpq6Q==
X-Received: by 2002:ac8:43c8:: with SMTP id w8mr29145969qtn.322.1568132127861;
        Tue, 10 Sep 2019 09:15:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f049])
        by smtp.gmail.com with ESMTPSA id z200sm8663032qkb.5.2019.09.10.09.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:15:27 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:15:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Dave Jones <davej@codemonkey.org.uk>
Subject: [block/for-next] iocost: Fix incorrect operation order during iocg
 free
Message-ID: <20190910161525.GT2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ioc_pd_free() first cancels the hrtimers and then deactivates the
iocg.  However, the iocg timer can run inbetween and reschedule the
hrtimers which will end up running after the iocg is freed leading to
crashes like the following.

  general protection fault: 0000 [#1] SMP
  ...
  RIP: 0010:iocg_kick_delay+0xbe/0x1b0
  RSP: 0018:ffffc90003598ea0 EFLAGS: 00010046
  RAX: 1cee00fd69512b54 RBX: ffff8881bba48400 RCX: 00000000000003e8
  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881bba48400
  RBP: 0000000000004e20 R08: 0000000000000002 R09: 00000000000003e8
  R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003598ef0
  R13: 00979f3810ad461f R14: ffff8881bba4b400 R15: 25439f950d26e1d1
  FS:  0000000000000000(0000) GS:ffff88885f800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f64328c7e40 CR3: 0000000002409005 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <IRQ>
   iocg_delay_timer_fn+0x3d/0x60
   __hrtimer_run_queues+0xfe/0x270
   hrtimer_interrupt+0xf4/0x210
   smp_apic_timer_interrupt+0x5e/0x120
   apic_timer_interrupt+0xf/0x20
   </IRQ>

Fix it by canceling hrtimers after deactivating the iocg.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
---
 block/blk-iocost.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2aae8ec391ef..7af350293c2f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1957,15 +1957,15 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 	struct ioc *ioc = iocg->ioc;
 
 	if (ioc) {
-		hrtimer_cancel(&iocg->waitq_timer);
-		hrtimer_cancel(&iocg->delay_timer);
-
 		spin_lock(&ioc->lock);
 		if (!list_empty(&iocg->active_list)) {
 			propagate_active_weight(iocg, 0, 0);
 			list_del_init(&iocg->active_list);
 		}
 		spin_unlock(&ioc->lock);
+
+		hrtimer_cancel(&iocg->waitq_timer);
+		hrtimer_cancel(&iocg->delay_timer);
 	}
 	kfree(iocg);
 }
