Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80A8070D
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfHCPvy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Aug 2019 11:51:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64865 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfHCPvy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Aug 2019 11:51:54 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x73Fppdx031874;
        Sun, 4 Aug 2019 00:51:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Sun, 04 Aug 2019 00:51:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x73Fphh5031830
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 4 Aug 2019 00:51:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
To:     Masoud Sharbiani <msharbiani@apple.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
 <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
 <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
Date:   Sun, 4 Aug 2019 00:51:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Masoud, will you try this patch?

By the way, is /sys/fs/cgroup/memory/leaker/memory.usage_in_bytes remains non-zero
despite /sys/fs/cgroup/memory/leaker/tasks became empty due to memcg OOM killer expected?
Deleting big-data-file.bin after memcg OOM killer reduces some, but still remains
non-zero.

----------------------------------------
From 2f92c70f390f42185c6e2abb8dda98b1b7d02fa9 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 4 Aug 2019 00:41:30 +0900
Subject: [PATCH] memcg, oom: don't require __GFP_FS when invoking memcg OOM killer

Masoud Sharbiani noticed that commit 29ef680ae7c21110 ("memcg, oom: move
out_of_memory back to the charge path") broke memcg OOM called from
__xfs_filemap_fault() path. It turned out that try_chage() is retrying
forever without making forward progress because mem_cgroup_oom(GFP_NOFS)
cannot invoke the OOM killer due to commit 3da88fb3bacfaa33 ("mm, oom:
move GFP_NOFS check to out_of_memory"). Regarding memcg OOM, we need to
bypass GFP_NOFS check in order to guarantee forward progress.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Masoud Sharbiani <msharbiani@apple.com>
Bisected-by: Masoud Sharbiani <msharbiani@apple.com>
Fixes: 29ef680ae7c21110 ("memcg, oom: move out_of_memory back to the charge path")
---
 mm/oom_kill.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a..26804ab 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1068,9 +1068,10 @@ bool out_of_memory(struct oom_control *oc)
 	 * The OOM killer does not compensate for IO-less reclaim.
 	 * pagefault_out_of_memory lost its gfp context so we have to
 	 * make sure exclude 0 mask - all other users should have at least
-	 * ___GFP_DIRECT_RECLAIM to get here.
+	 * ___GFP_DIRECT_RECLAIM to get here. But mem_cgroup_oom() has to
+	 * invoke the OOM killer even if it is a GFP_NOFS allocation.
 	 */
-	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
+	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
 		return true;
 
 	/*
-- 
1.8.3.1


