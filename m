Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B91F999F
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2020 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgFOOHj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jun 2020 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOHh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Jun 2020 10:07:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187EC061A0E
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2020 07:07:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so12642789qtv.3
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2020 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STVn3sZd24uT+6Abwx3hGrjt3KiHGonv7dCNXNNdXc8=;
        b=GCccnrQQ+F14prS1VzHQOSHnlhzYUWa/2xFrs2CsD2SO70HA6PTmJTScI0KFtJeBOc
         qmo/pwzQ42F5oj3P0MQl2aKylMW9BPqXthu5sim3japhSFdTQVi5qd9c3vRqO8284pNE
         anskV2Y91HtgHpNQkW+Qijlori0G/w9Do6FKTQ6CG1epkWn4iisZN7Fs78d7lxRLJp96
         FntORj5A661/Ztro6W9JpfAn5tp63iJV/Q2qAqGBWTfP5sXEzQMKSwCeNcs1na2ncJeE
         qtcb7eewI3tvvRmv9KRr+kWaKsgg0FxTlz3tX7YOi3HxT3sxNbGcceazGEQ2OZBCWuKb
         9Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STVn3sZd24uT+6Abwx3hGrjt3KiHGonv7dCNXNNdXc8=;
        b=n6Er5rQX0NaZSC8m4RzoNm2mUcIsUNPu1pMaUrvA/7fG861PtdXEGpAUfJ0tmn+bB4
         ekW5XHclyfFgwO+5AemQErokPVWj3r8ViBLBe5W9tZPe2PekmNwjBgjDPVGshL5sZCkI
         TkAFI38gE/90BgX8OuprrFKOvTUP4EUNTWNgg7woZ14K9pHdkFu0f+I78MBUMStDGVv7
         8otGEoGU51xEoiWsBm0TcKLzTCqxKpaC4jA1fNy2tMdx1gw1wHdL8mmF7Vtufctga0A3
         oK2604Nd1E9G09VlJqDAdtT09TauDovSby5XeLplMWM8grdtNQJ6gtuMVCzaeVcCCxGZ
         8/MA==
X-Gm-Message-State: AOAM531MNa1uyOUAI2sHDijYh8Cj89V3N8yOCD/ue7yehwCxmdFvaODh
        6POh2jvUGe0uzZDVVG4UYy8KJA==
X-Google-Smtp-Source: ABdhPJxFqBJgLwdN8IHNXFvxCzqBbX4KT88lV6RW+axueoCkAN7sfbOvB2co5bFTrGyLo5vjzmPHvg==
X-Received: by 2002:ac8:6f79:: with SMTP id u25mr16186587qtv.183.1592230056852;
        Mon, 15 Jun 2020 07:07:36 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id p44sm12789120qta.12.2020.06.15.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:07:36 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: handle div0 crash race condition in memory.low
Date:   Mon, 15 Jun 2020 10:06:58 -0400
Message-Id: <20200615140658.601684-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun reports seeing rare div0 crashes in memory.low stress testing:

[37228.504582] RIP: 0010:mem_cgroup_calculate_protection+0xed/0x150
[37228.505059] Code: 0f 46 d1 4c 39 d8 72 57 f6 05 16 d6 42 01 40 74 1f 4c 39 d8 76 1a 4c 39 d1 76 15 4c 29 d1 4c 29 d8 4d 29 d9 31 d2 48 0f af c1 <49> f7 f1 49 01 c2 4c 89 96 38 01 00 00 5d c3 48 0f af c7 31 d2 49
[37228.506254] RSP: 0018:ffffa14e01d6fcd0 EFLAGS: 00010246
[37228.506769] RAX: 000000000243e384 RBX: 0000000000000000 RCX: 0000000000008f4b
[37228.507319] RDX: 0000000000000000 RSI: ffff8b89bee84000 RDI: 0000000000000000
[37228.507869] RBP: ffffa14e01d6fcd0 R08: ffff8b89ca7d40f8 R09: 0000000000000000
[37228.508376] R10: 0000000000000000 R11: 00000000006422f7 R12: 0000000000000000
[37228.508881] R13: ffff8b89d9617000 R14: ffff8b89bee84000 R15: ffffa14e01d6fdb8
[37228.509397] FS:  0000000000000000(0000) GS:ffff8b8a1f1c0000(0000) knlGS:0000000000000000
[37228.509917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37228.510442] CR2: 00007f93b1fc175b CR3: 000000016100a000 CR4: 0000000000340ea0
[37228.511076] Call Trace:
[37228.511561]  shrink_node+0x1e5/0x6c0
[37228.512044]  balance_pgdat+0x32d/0x5f0
[37228.512521]  kswapd+0x1d7/0x3d0
[37228.513346]  ? wait_woken+0x80/0x80
[37228.514170]  kthread+0x11c/0x160
[37228.514983]  ? balance_pgdat+0x5f0/0x5f0
[37228.515797]  ? kthread_park+0x90/0x90
[37228.516593]  ret_from_fork+0x1f/0x30

This happens when parent_usage == siblings_protected. We check that
usage is bigger than protected, which should imply parent_usage being
bigger than siblings_protected. However, we don't read (or even
update) these values atomically, and they can be out of sync as the
memory state changes under us. A bit of fluctuation around the target
protection isn't a big deal, but we need to handle the div0 case.

Check the parent state explicitly to make sure we have a reasonable
positive value for the divisor.

Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
Reported-by: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6ad547d..5de0a9035b5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6360,11 +6360,16 @@ static unsigned long effective_protection(unsigned long usage,
 	 * We're using unprotected memory for the weight so that if
 	 * some cgroups DO claim explicit protection, we don't protect
 	 * the same bytes twice.
+	 *
+	 * Check both usage and parent_usage against the respective
+	 * protected values. One should imply the other, but they
+	 * aren't read atomically - make sure the division is sane.
 	 */
 	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
 		return ep;
-
-	if (parent_effective > siblings_protected && usage > protected) {
+	if (parent_effective > siblings_protected &&
+	    parent_usage > siblings_protected &&
+	    usage > protected) {
 		unsigned long unclaimed;
 
 		unclaimed = parent_effective - siblings_protected;
-- 
2.26.2

