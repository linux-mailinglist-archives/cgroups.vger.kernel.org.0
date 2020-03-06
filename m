Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA517B361
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2020 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFBCH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 20:02:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgCFBCH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 20:02:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id j20so137086pll.6;
        Thu, 05 Mar 2020 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=s9ClMJP59BvOKqZ7+ZwFacTL/134BXRc25KCFEP50vM=;
        b=hHE1MjCrbopahUEUJA0MBev6uuhPh04ezUqS+U9gs3v87CSPHNRvHUe5y3vhIY+Veu
         8k7OvdtHYOlJ+GHoMP159fFubVq2enhZE/YDm6qkE9wOXaTkhb3nVS1LYJ98f/7nPrOo
         9OMR7ttude+Ee+jkioPNLEPhxOJLJbB6KoBH5+t7b4zrze2CNFX0/LNev4uorgaMS8Ry
         ECyF2h90/wVp89pkoI7s9k+LLfcsxRCrV7P6/+HvefPgS1vIWuWZahAzStzGg8QkG97h
         gkNdJOhz7EulOLcJbb6Lx/pC0klUfwTPn4Y71gJ9j6qI2eA4kBGVDDnhzfnxYuRpH17B
         lE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=s9ClMJP59BvOKqZ7+ZwFacTL/134BXRc25KCFEP50vM=;
        b=Au0NGjnnCnS0sC7h/sUHrH/qRqL3kVi48njaZN0+5WTfGgt328vfjtzt+a2yyRqQ5Z
         9Ig7RUlRchiEMG481usWMqEUdPpBXU7/L2bxOXrHBPtSBTP8sZDuhPfiP1dG2nwywnpJ
         n+jEROr3SaqAqDC3BfXUVWozanDrq21taFgmHV4MVw0XlCvvh0hpvN9AGxC6aMMqIEvt
         XjDYGvZMQCDnSu3a1FsoY6cq9wbYhWzO/DNc9UjaoBwF2L97ZzL7YHJtSPUUBShMw81H
         wN7QhubdkrfNadWlDaEeKhQ++pew8E24ttRhRuwvMPw5NsNj0pMeJypNAldK3GjXdVBy
         /g+A==
X-Gm-Message-State: ANhLgQ02IfU39ntPRoR8SoQAHaU64/ySWMCd8QsK1r9a9x98dDMEnmcK
        Tk1j/3SwWyOnliSRtnHEKRoh5kG5
X-Google-Smtp-Source: ADFU+vvzwQsR40z/L2TzcX4QBzVxBy8GBfX7YMwdGTKA0r38HwP+MhMQ7Kyo8hS7hBNuBxtPmvvEBQ==
X-Received: by 2002:a17:90a:630b:: with SMTP id e11mr858912pjj.53.1583456523712;
        Thu, 05 Mar 2020 17:02:03 -0800 (PST)
Received: from [10.80.50.61] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id y7sm21215094pfq.15.2020.03.05.17.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 17:02:03 -0800 (PST)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCHv2] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <077a6f67-aefa-4591-efec-f2f3af2b0b02@gmail.com>
Date:   Fri, 6 Mar 2020 09:02:02 +0800
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

From: Chunguang Xu <brookxu@tencent.com>

An eventfd monitors multiple memory thresholds of the cgroup, closes them,
the kernel deletes all events related to this eventfd. Before all events
are deleted, another eventfd monitors the memory threshold of this cgroup,
leading to a crash:

[  135.675108] BUG: kernel NULL pointer dereference, address: 0000000000000004
[  135.675350] #PF: supervisor write access in kernel mode
[  135.675579] #PF: error_code(0x0002) - not-present page
[  135.675816] PGD 800000033058e067 P4D 800000033058e067 PUD 3355ce067 PMD 0
[  135.676080] Oops: 0002 [#1] SMP PTI
[  135.676332] CPU: 2 PID: 14012 Comm: kworker/2:6 Kdump: loaded Not tainted 5.6.0-rc4 #3
[  135.676610] Hardware name: LENOVO 20AWS01K00/20AWS01K00, BIOS GLET70WW (2.24 ) 05/21/2014
[  135.676909] Workqueue: events memcg_event_remove
[  135.677192] RIP: 0010:__mem_cgroup_usage_unregister_event+0xb3/0x190
[  135.677825] RSP: 0018:ffffb47e01c4fe18 EFLAGS: 00010202
[  135.678186] RAX: 0000000000000001 RBX: ffff8bb223a8a000 RCX: 0000000000000001
[  135.678548] RDX: 0000000000000001 RSI: ffff8bb22fb83540 RDI: 0000000000000001
[  135.678912] RBP: ffffb47e01c4fe48 R08: 0000000000000000 R09: 0000000000000010
[  135.679287] R10: 000000000000000c R11: 071c71c71c71c71c R12: ffff8bb226aba880
[  135.679670] R13: ffff8bb223a8a480 R14: 0000000000000000 R15: 0000000000000000
[  135.680066] FS:  0000000000000000(0000) GS:ffff8bb242680000(0000) knlGS:0000000000000000
[  135.680475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.680894] CR2: 0000000000000004 CR3: 000000032c29c003 CR4: 00000000001606e0
[  135.681325] Call Trace:
[  135.681763]  memcg_event_remove+0x32/0x90
[  135.682209]  process_one_work+0x172/0x380
[  135.682657]  worker_thread+0x49/0x3f0
[  135.683111]  kthread+0xf8/0x130
[  135.683570]  ? max_active_store+0x80/0x80
[  135.684034]  ? kthread_bind+0x10/0x10
[  135.684506]  ret_from_fork+0x35/0x40
[  135.689733] CR2: 0000000000000004

We can reproduce this problem in the following ways:
 
1. We create a new cgroup subdirectory and a new eventfd, and then we
   monitor multiple memory thresholds of the cgroup through this eventfd.
2. closing this eventfd, and __mem_cgroup_usage_unregister_event () will be
   called multiple times to delete all events related to this eventfd.

The first time __mem_cgroup_usage_unregister_event() is called, the kernel
will clear all items related to this eventfd in thresholds-> primary.Since
there is currently only one eventfd, thresholds-> primary becomes empty,
so the kernel will set thresholds-> primary and hresholds-> spare to NULL.
If at this time, the user creates a new eventfd and monitor the memory
threshold of this cgroup, kernel will re-initialize thresholds-> primary.
Then when __mem_cgroup_usage_unregister_event () is called for the second
time, because thresholds-> primary is not empty, the system will access
thresholds-> spare, but thresholds-> spare is NULL, which will trigger a
crash.

In general, the longer it takes to delete all events related to this
eventfd, the easier it is to trigger this problem.

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

