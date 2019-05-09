Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AC1867F
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEIIEJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 04:04:09 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58148 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfEIIEJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 04:04:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TRFACTi_1557389033;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TRFACTi_1557389033)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 May 2019 16:04:02 +0800
From:   zhangliguang <zhangliguang@linux.alibaba.com>
To:     tj@kernel.org, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] fs/writeback: Attach inode's wb to root if needed
Date:   Thu,  9 May 2019 16:03:53 +0800
Message-Id: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There might have tons of files queued in the writeback, awaiting for
writing back. Unfortunately, the writeback's cgroup has been dead. In
this case, we reassociate the inode with another writeback cgroup, but
we possibly can't because the writeback associated with the dead cgroup
is the only valid one. In this case, the new writeback is allocated,
initialized and associated with the inode. It causes unnecessary high
system load and latency.

This fixes the issue by enforce moving the inode to root cgroup when the
previous binding cgroup becomes dead. With it, no more unnecessary
writebacks are created, populated and the system load decreased by about
6x in the online service we encounted:
    Without the patch: about 30% system load
    With the patch:    about  5% system load

with the patch observes significant perf graph change:

========================================================================
We record the trace with 'perf record cycles:k -g -a'.

The trace without the patch:

+  44.68%	[kernel]  [k] native_queued_spin_lock_slowpath
+   3.38%	[kernel]  [k] memset_erms
+   3.04%	[kernel]  [k] pcpu_alloc_area
+   1.46%	[kernel]  [k] __memmove
+   1.37%	[kernel]  [k] pcpu_alloc

detail information abount native_queued_spin_lock_slowpath:
44.68%       [kernel]  [k] native_queued_spin_lock_slowpath
 - native_queued_spin_lock_slowpath
    - _raw_spin_lock_irqsave
       - 68.80% pcpu_alloc
          - __alloc_percpu_gfp
             - 85.01% __percpu_counter_init
                - 66.75% wb_init
                     wb_get_create
                     inode_switch_wbs
                     wbc_attach_and_unlock_inode
                     __filemap_fdatawrite_range
                   + filemap_write_and_wait_range
                + 33.25% fprop_local_init_percpu
             + 14.99% percpu_ref_init
       + 30.77% free_percpu

system load (by top)
%Cpu(s): 31.9% sy

With the patch:

+   4.45%       [kernel]  [k] native_queued_spin_lock_slowpath
+   3.32%       [kernel]  [k] put_compound_page
+   2.20%       [kernel]  [k] gup_pte_range
+   1.91%       [kernel]  [k] kstat_irqs

system load (by top)
%Cpu(s): 5.4% sy

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 fs/fs-writeback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 36855c1..e7e19d8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -696,6 +696,13 @@ void wbc_detach_inode(struct writeback_control *wbc)
 	inode->i_wb_frn_avg_time = min(avg_time, (unsigned long)U16_MAX);
 	inode->i_wb_frn_history = history;
 
+	/*
+	 * The wb is switched to the root memcg unconditionally. We expect
+	 * the correct wb (best candidate) is picked up in next round.
+	 */
+	if (wb == inode->i_wb && wb_dying(wb) && !(inode->i_state & I_DIRTY_ALL))
+		inode_switch_wbs(inode, root_mem_cgroup->css.id);
+
 	wb_put(wbc->wb);
 	wbc->wb = NULL;
 }
-- 
1.8.3.1

