Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCD82FB1
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfHFK0Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 06:26:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58025 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbfHFK0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Aug 2019 06:26:24 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x76AQMpo059597;
        Tue, 6 Aug 2019 19:26:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 06 Aug 2019 19:26:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x76AQGdn059550
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 6 Aug 2019 19:26:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masoud Sharbiani <msharbiani@apple.com>,
        Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
 <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
 <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
 <20190805084228.GB7597@dhcp22.suse.cz>
 <7e3c0399-c091-59cd-dbe6-ff53c7c8adc9@i-love.sakura.ne.jp>
 <20190805114434.GK7597@dhcp22.suse.cz>
 <0b817204-29f4-adfb-9b78-4fec5fa8f680@i-love.sakura.ne.jp>
 <20190805142622.GR7597@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <56d98a71-b77e-0ad7-91ad-62633929c736@i-love.sakura.ne.jp>
Date:   Tue, 6 Aug 2019 19:26:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805142622.GR7597@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2019/08/05 23:26, Michal Hocko wrote:
> On Mon 05-08-19 23:00:12, Tetsuo Handa wrote:
>> On 2019/08/05 20:44, Michal Hocko wrote:
>>>> Allowing forced charge due to being unable to invoke memcg OOM killer
>>>> will lead to global OOM situation, and just returning -ENOMEM will not
>>>> solve memcg OOM situation.
>>>
>>> Returning -ENOMEM would effectivelly lead to triggering the oom killer
>>> from the page fault bail out path. So effectively get us back to before
>>> 29ef680ae7c21110. But it is true that this is riskier from the
>>> observability POV when a) the OOM path wouldn't point to the culprit and
>>> b) it would leak ENOMEM from g-u-p path.
>>>
>>
>> Excuse me? But according to my experiment, below code showed flood of
>> "Returning -ENOMEM" message instead of invoking the OOM killer.
>> I didn't find it gets us back to before 29ef680ae7c21110...
> 
> You would need to declare OOM_ASYNC to return ENOMEM properly from the
> charge (which is effectivelly a revert of 29ef680ae7c21110 for NOFS
> allocations). Something like the following
> 

OK. We need to set current->memcg_* before declaring something other than
OOM_SUCCESS and OOM_FAILED... Well, it seems that returning -ENOMEM after
setting current->memcg_* works as expected. What's wrong with your approach?


--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1843,6 +1843,15 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		return OOM_SKIPPED;
 
+	if (!(mask & __GFP_FS)) {
+		BUG_ON(current->memcg_in_oom);
+		css_get(&memcg->css);
+		current->memcg_in_oom = memcg;
+		current->memcg_oom_gfp_mask = mask;
+		current->memcg_oom_order = order;
+		return OOM_ASYNC;
+	}
+
 	memcg_memory_event(memcg, MEMCG_OOM);

 	/*



[   49.921978][ T6736] leaker invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[   49.925152][ T6736] CPU: 1 PID: 6736 Comm: leaker Kdump: loaded Not tainted 5.3.0-rc3+ #936
[   49.927917][ T6736] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   49.931337][ T6736] Call Trace:
[   49.932673][ T6736]  dump_stack+0x67/0x95
[   49.934438][ T6736]  dump_header+0x4d/0x3e0
[   49.936142][ T6736]  oom_kill_process+0x193/0x220
[   49.940276][ T6736]  out_of_memory+0x105/0x360
[   49.941863][ T6736]  mem_cgroup_out_of_memory+0xb6/0xd0
[   49.943819][ T6736]  try_charge+0xa78/0xa90
[   49.945584][ T6736]  mem_cgroup_try_charge+0x88/0x2f0
[   49.947411][ T6736]  __add_to_page_cache_locked+0x27e/0x4c0
[   49.949441][ T6736]  ? scan_shadow_nodes+0x30/0x30
[   49.951155][ T6736]  add_to_page_cache_lru+0x72/0x180
[   49.952940][ T6736]  pagecache_get_page+0xb6/0x2b0
[   49.954718][ T6736]  filemap_fault+0x613/0xc20
[   49.956407][ T6736]  ? filemap_fault+0x446/0xc20
[   49.958221][ T6736]  ? __xfs_filemap_fault+0x7f/0x290 [xfs]
[   49.960206][ T6736]  ? down_read_nested+0x93/0x170
[   49.962141][ T6736]  ? xfs_ilock+0x1ea/0x2f0 [xfs]
[   49.963925][ T6736]  __xfs_filemap_fault+0x92/0x290 [xfs]
[   49.966089][ T6736]  xfs_filemap_fault+0x27/0x30 [xfs]
[   49.967864][ T6736]  __do_fault+0x33/0xd0
[   49.969467][ T6736]  __handle_mm_fault+0x891/0xbe0
[   49.971222][ T6736]  handle_mm_fault+0x179/0x380
[   49.972902][ T6736]  ? handle_mm_fault+0x46/0x380
[   49.974544][ T6736]  __do_page_fault+0x255/0x4d0
[   49.976283][ T6736]  do_page_fault+0x27/0x1e0
[   49.978012][ T6736]  page_fault+0x34/0x40
[   49.979540][ T6736] RIP: 0033:0x4009f0
[   49.981007][ T6736] Code: 03 00 00 00 e8 71 fd ff ff 48 83 f8 ff 49 89 c6 74 74 48 89 c6 bf c0 0c 40 00 31 c0 e8 69 fd ff ff 45 85 ff 7e 21 31 c9 66 90 <41> 0f be 14 0e 01 d3 f7 c1 ff 0f 00 00 75 05 41 c6 04 0e 2a 48 83
[   49.987171][ T6736] RSP: 002b:00007ffdbe464810 EFLAGS: 00010206
[   49.989302][ T6736] RAX: 000000000000001b RBX: 0000000000000000 RCX: 0000000001d69000
[   49.992130][ T6736] RDX: 0000000000000000 RSI: 000000007fffffe5 RDI: 0000000000000000
[   49.994857][ T6736] RBP: 000000000000000c R08: 0000000000000000 R09: 00007fa1a2ee420d
[   49.997579][ T6736] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000000186a0
[   50.000251][ T6736] R13: 0000000000000003 R14: 00007fa182697000 R15: 0000000002800000
[   50.003734][ T6736] memory: usage 524288kB, limit 524288kB, failcnt 660235
[   50.006452][ T6736] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
[   50.009165][ T6736] kmem: usage 2196kB, limit 9007199254740988kB, failcnt 0
[   50.011886][ T6736] Memory cgroup stats for /leaker:
[   50.011950][ T6736] anon 534147072
[   50.011950][ T6736] file 212992
[   50.011950][ T6736] kernel_stack 36864
[   50.011950][ T6736] slab 933888
[   50.011950][ T6736] sock 0
[   50.011950][ T6736] shmem 0
[   50.011950][ T6736] file_mapped 0
[   50.011950][ T6736] file_dirty 0
[   50.011950][ T6736] file_writeback 0
[   50.011950][ T6736] anon_thp 0
[   50.011950][ T6736] inactive_anon 0
[   50.011950][ T6736] active_anon 534048768
[   50.011950][ T6736] inactive_file 0
[   50.011950][ T6736] active_file 151552
[   50.011950][ T6736] unevictable 0
[   50.011950][ T6736] slab_reclaimable 327680
[   50.011950][ T6736] slab_unreclaimable 606208
[   50.011950][ T6736] pgfault 140250
[   50.011950][ T6736] pgmajfault 693
[   50.011950][ T6736] workingset_refault 169950
[   50.011950][ T6736] workingset_activate 1353
[   50.011950][ T6736] workingset_nodereclaim 0
[   50.011950][ T6736] pgrefill 5848
[   50.011950][ T6736] pgscan 859688
[   50.011950][ T6736] pgsteal 180103
[   50.052086][ T6736] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),oom_memcg=/leaker,task_memcg=/leaker,task=leaker,pid=6736,uid=0
[   50.056749][ T6736] Memory cgroup out of memory: Killed process 6736 (leaker) total-vm:536700kB, anon-rss:521704kB, file-rss:1180kB, shmem-rss:0kB
[   50.167554][   T55] oom_reaper: reaped process 6736 (leaker), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
