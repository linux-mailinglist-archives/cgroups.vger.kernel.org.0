Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9B179FA2
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 06:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgCEFwJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 00:52:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38418 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEFwJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 00:52:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id p7so2143489pli.5;
        Wed, 04 Mar 2020 21:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=SisVA29ZZ+iYS0B5FHPcjyy/cPyELdtrqL00il0/JQ8=;
        b=ZpWm51A7161vwjGinGar0DK+Zecrv/137UuDH5zRsfv2j6ma3zIKsgdU+JN4iT/DX1
         q8DXg71KYOXG74KGdN3okP5FIDLsj+MlrWmx14hkNqqvdh2vJ18o3RiFQwIyISkaIFI9
         aVdGMXqTw9CHwINBb1DXRpF2pgWFJXcrX1FRE/oxZABFwF8qSRE1emPlMgomlHMWv1T7
         KwR1UOSic9zJbRPUwj1y2Fq7sHN21EnbrQuAEFrlRHFHoifLXsu4QKpMTikvtcZYUsIB
         hvxDlewapDE0eGCxtLHGi1nv6qu7pbPbdsgzAPZAM2Y+Lzwpbxq4eQT8S1Tyf6AuZ/hd
         l9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=SisVA29ZZ+iYS0B5FHPcjyy/cPyELdtrqL00il0/JQ8=;
        b=BvXDR10uwhK3Z+x16kY96OSVxSomDSt1R1hjPR0qJhdBZCVu5yJmykb1wNdEqlmjQZ
         tyBRdq40CAjb/2soe82IxM2ugwPi3OVQ+dxALhm1MaodneGCWB9QQxlTLmeJcbFdPZ15
         Sd9eGYyM071sd+z1Onkxvsw9hVoezzgwUiB8mzk8Z1I8ITmuJlMeDwY/TRZ+Ui7eYXsn
         9M7gH6Lv6NRdiS/hCLF/p+WpB2YxQuDCkzmkONmcSZJinfbtoX8jyTKwwZiG9lm0pUac
         L3fHTJaVthD0yJtDcq4T0mBR3/l1MR02fjZbK8+cgsWfVGOGSwrXOkf3gslEP0+0866F
         TRwA==
X-Gm-Message-State: ANhLgQ3wlyDZs20n9PrkgEIPdnM3WrhjCHp3cOVdNSsh6Kw+mjPWhDRZ
        3VOVnXUkgFbKqilv3KL49cEijOio
X-Google-Smtp-Source: ADFU+vvlmFmMfy/ZWFxXhdwU5P0eyew/9TRN7ekjG4lT7djNidPqreFgPU80Vau58LWf7huSEdywyQ==
X-Received: by 2002:a17:90a:2085:: with SMTP id f5mr6797016pjg.101.1583387527260;
        Wed, 04 Mar 2020 21:52:07 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id y16sm30057318pfn.177.2020.03.04.21.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 21:52:06 -0800 (PST)
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <5ee35fe7-2a90-ae71-9100-3f2833cbf252@gmail.com>
Date:   Thu, 5 Mar 2020 13:52:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One eventfd monitors multiple memory thresholds of cgroup, closing it, the
system will delete related events. Before all events are deleted, another
eventfd monitors the cgroup's memory threshold.

As a result, thresholds->primary[] is not empty, but thresholds->sparse[]
is NULL, __mem_cgroup_usage_unregister_event() leading to a crash:

[  138.925809] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[  138.926817] IP: [<ffffffff8116c9b7>] mem_cgroup_usage_unregister_event+0xd7/0x1f0
[  138.927701] PGD 73bce067 PUD 76ff3067 PMD 0
[  138.928384] Oops: 0002 [#1] SMP
[  138.935218] CPU: 1 PID: 14 Comm: kworker/1:0 Not tainted 3.10.107-1-tlinux2-0047 #1
[  138.936076] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  138.936988] Workqueue: events cgroup_event_remove
[  138.937581] task: ffff88007c07e440 ti: ffff88007c090000 task.ti: ffff88007c090000
[  138.938485] RIP: 0010:[<ffffffff8116c9b7>]  [<ffffffff8116c9b7>] mem_cgroup_usage_unregister_event+0xd7/0x1f0
[  138.940116] RSP: 0018:ffff88007c093dc0  EFLAGS: 00010202
[  138.941056] RAX: 0000000000000001 RBX: ffff880073b3e1a8 RCX: 0000000000000001
[  138.942095] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff880074519900
[  138.943129] RBP: ffff88007c093df0 R08: 0000000000000001 R09: 0000000000000000
[  138.946057] R10: 000000000000b95b R11: 0000000000000001 R12: ffff880076cc0480
[  138.947805] R13: ffff880073b3e1d0 R14: 0000000000000000 R15: 0000000000000000
[  138.948903] FS:  0000000000000000(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
[  138.952264] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  138.953123] CR2: 0000000000000004 CR3: 00000000753b3000 CR4: 00000000000406e0
[  138.954110] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  138.963245] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  138.964088] Stack:
[  138.964456]  0000000000000246 ffff880076d6df68 ffff8800751b4c00 ffff880076d6df00
[  138.965650]  0000000000000040 ffff880076d6df68 ffff88007c093e18 ffffffff810b17ba
[  138.966803]  ffff88007d04cf80 ffff88007fd115c0 ffff88007fd15600 ffff88007c093e60
[  138.968179] Call Trace:
[  138.968592]  [<ffffffff810b17ba>] cgroup_event_remove+0x3a/0x80
[  138.969321]  [<ffffffff81066387>] process_one_work+0x177/0x450
[  138.970051]  [<ffffffff8106721b>] worker_thread+0x11b/0x390
[  138.970741]  [<ffffffff81067100>] ? manage_workers.isra.26+0x290/0x290
[  138.971612]  [<ffffffff8106dacf>] kthread+0xcf/0xe0
[  138.972340]  [<ffffffff8106da00>] ? insert_kthread_work+0x40/0x40
[  138.973142]  [<ffffffff81aad9f8>] ret_from_fork+0x58/0x90
[  138.973843]  [<ffffffff8106da00>] ? insert_kthread_work+0x40/0x40

The solution is to check whether the thresholds associated with the eventfd
has been cleared when deleting the event. If so, we do nothing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 mm/memcontrol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776c..4575a58 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4027,7 +4027,7 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
     struct mem_cgroup_thresholds *thresholds;
     struct mem_cgroup_threshold_ary *new;
     unsigned long usage;
-    int i, j, size;
+    int i, j, size, entries;
 
     mutex_lock(&memcg->thresholds_lock);
 
@@ -4047,12 +4047,18 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
     __mem_cgroup_threshold(memcg, type == _MEMSWAP);
 
     /* Calculate new number of threshold */
-    size = 0;
+    size = entries = 0;
     for (i = 0; i < thresholds->primary->size; i++) {
         if (thresholds->primary->entries[i].eventfd != eventfd)
             size++;
+        else
+            entries++;
     }
 
+    /* If items related to eventfd have been cleared, nothing to do */
+    if (!entries)
+        goto unlock;
+
     new = thresholds->spare;
 
     /* Set thresholds array to NULL if we don't have thresholds */
-- 
1.8.3.1

