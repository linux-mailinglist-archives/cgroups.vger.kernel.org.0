Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE785421849
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhJDUVl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhJDUVl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 16:21:41 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1BC061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 13:19:51 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y197so21787190iof.11
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LQGXlr8JsxYTcOQMokcqY9RnbuNcOY4TaFS93GsjX5s=;
        b=gBaPYPFr2c8ulT+/+JaIiT+5iPPcLGSJfTfBfJQwCOvCrhUQsImxweBvZ8n0PSx2Ar
         9Hp5BCLgzXUucupqyOZjZuddMIjkxzRYWduE0FxjN1TZHe4f6SvzdXLQnN5xEdw1IY8w
         rFEOyyNFQ+h0uIql+JqmelRn/dI30R5/EUF20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LQGXlr8JsxYTcOQMokcqY9RnbuNcOY4TaFS93GsjX5s=;
        b=1zvfMJHILhFyr1B9pF8FFZmDiUxsPZdSvKqgdJiPuLXKJNdWDbR5BV/W2w8e7NEbvV
         O9TwrxHWbyD09QwhxS5uFz0t4zHAmiISNstzqzQRH42NHrCsoqOoywnuvVn1R7bqaBP7
         rFFo+BYWmDxG3dpd8Q2CrlhhrRjj0wWuOK73OpbeiKtfysqr9f1hlQ77Jkkx2fkOpd1g
         hKVaiSX7o9hoRYTzIf5g0AYrPIeIPLuW4wh+mJf1cozS3Ft8Tb9LdSa0ADeoOnivSMSD
         tqwzYZk2OjMKgxPfnVZd7aqFbY8J4q2Q/hu6hjY5Y5oG65xUPcg6JasW1rPvOxFYtdDM
         6Qfg==
X-Gm-Message-State: AOAM532Qfz1grm2m54AqTskCGam32MYbdqUQxALJvr/OfQ3MET0JX2T2
        WEIrbIsjGN/mBRh4hO2O+Ab3HQ==
X-Google-Smtp-Source: ABdhPJxYQKpknv4hTYke8msZTxTHfBsYuRDBRViJ8kaP6N0/aWjqLf9YfRmen8FVOoVFvS//wotfLg==
X-Received: by 2002:a05:6602:2cd5:: with SMTP id j21mr10878773iow.22.1633378791402;
        Mon, 04 Oct 2021 13:19:51 -0700 (PDT)
Received: from vverma-s2-cbrunner ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id r6sm223184ilm.71.2021.10.04.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:19:51 -0700 (PDT)
From:   Vishal Verma <vverma@digitalocean.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Cc:     Vishal Verma <vverma@digitalocean.com>
Subject: [PATCH] cgroup: cgroup-v1: do not exclude cgrp_dfl_root
Date:   Mon,  4 Oct 2021 20:19:48 +0000
Message-Id: <20211004201948.20293-1-vverma@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Found an issue within cgroup_attach_task_all() fn which seem
to exclude cgrp_dfl_root (cgroupv2) while attaching tasks to
the given cgroup. This was noticed when the system was running
qemu/kvm with kernel vhost helper threads. It appears that the
vhost layer which uses cgroup_attach_task_all() fn to assign the
vhost kthread to the right qemu cgroup works fine with cgroupv1
based configuration but not in cgroupv2. With cgroupv2, the vhost
helper thread ends up just belonging to the root cgroup as is
shown below:

$ stat -fc %T /sys/fs/cgroup/
cgroup2fs
$ sudo pgrep qemu
1916421
$ ps -eL | grep 1916421
1916421 1916421 ?        00:00:01 qemu-system-x86
1916421 1916431 ?        00:00:00 call_rcu
1916421 1916435 ?        00:00:00 IO mon_iothread
1916421 1916436 ?        00:00:34 CPU 0/KVM
1916421 1916439 ?        00:00:00 SPICE Worker
1916421 1916440 ?        00:00:00 vnc_worker
1916433 1916433 ?        00:00:00 vhost-1916421
1916437 1916437 ?        00:00:00 kvm-pit/1916421
$ cat /proc/1916421/cgroup
0::/machine.slice/machine-qemu\x2d18\x2dDroplet\x2d7572850.scope/emulator
$ cat /proc/1916439/cgroup
0::/machine.slice/machine-qemu\x2d18\x2dDroplet\x2d7572850.scope/emulator
$ cat /proc/1916433/cgroup
0::/

From above, it can be seen that the vhost kthread (PID: 1916433)
doesn't seem to belong the qemu cgroup like other qemu PIDs.

After applying this patch:

$ pgrep qemu
1643
$ ps -eL | grep 1643
   1643    1643 ?        00:00:00 qemu-system-x86
   1643    1645 ?        00:00:00 call_rcu
   1643    1648 ?        00:00:00 IO mon_iothread
   1643    1649 ?        00:00:00 CPU 0/KVM
   1643    1652 ?        00:00:00 SPICE Worker
   1643    1653 ?        00:00:00 vnc_worker
   1647    1647 ?        00:00:00 vhost-1643
   1651    1651 ?        00:00:00 kvm-pit/1643
$ cat /proc/1647/cgroup
0::/machine.slice/machine-qemu\x2d18\x2dDroplet\x2d7572850.scope/emulator

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Vishal Verma <vverma@digitalocean.com>
---
 kernel/cgroup/cgroup-v1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 35b920328344..f6cc5f8484dc 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -63,9 +63,6 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
-		if (root == &cgrp_dfl_root)
-			continue;
-
 		spin_lock_irq(&css_set_lock);
 		from_cgrp = task_cgroup_from_root(from, root);
 		spin_unlock_irq(&css_set_lock);
-- 
2.17.1

