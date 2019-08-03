Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C363803FA
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 04:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbfHCCgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 22:36:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52304 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390442AbfHCCgu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 22:36:50 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x732aiRI033406;
        Sat, 3 Aug 2019 11:36:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 03 Aug 2019 11:36:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x732aeeh033387
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 3 Aug 2019 11:36:44 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
Date:   Sat, 3 Aug 2019 11:36:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Well, while mem_cgroup_oom() is actually called, due to hitting

        /*
         * The OOM killer does not compensate for IO-less reclaim.
         * pagefault_out_of_memory lost its gfp context so we have to
         * make sure exclude 0 mask - all other users should have at least
         * ___GFP_DIRECT_RECLAIM to get here.
         */
        if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
                return true;

path inside out_of_memory(), OOM_SUCCESS is returned and retrying without
making forward progress...

----------------------------------------
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2447,6 +2447,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
         */
        oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
                       get_order(nr_pages * PAGE_SIZE));
+       printk("mem_cgroup_oom(%pGg)=%u\n", &gfp_mask, oom_status);
+       dump_stack();
        switch (oom_status) {
        case OOM_SUCCESS:
                nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
----------------------------------------

----------------------------------------
[   55.208578][ T2798] mem_cgroup_oom(GFP_NOFS)=0
[   55.210424][ T2798] CPU: 3 PID: 2798 Comm: leaker Not tainted 5.3.0-rc2+ #637
[   55.212985][ T2798] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   55.217260][ T2798] Call Trace:
[   55.218597][ T2798]  dump_stack+0x67/0x95
[   55.220200][ T2798]  try_charge+0x4ca/0x6d0
[   55.221843][ T2798]  ? get_mem_cgroup_from_mm+0x1ff/0x2c0
[   55.223855][ T2798]  mem_cgroup_try_charge+0x88/0x2d0
[   55.225723][ T2798]  __add_to_page_cache_locked+0x27e/0x4c0
[   55.227784][ T2798]  ? scan_shadow_nodes+0x30/0x30
[   55.229577][ T2798]  add_to_page_cache_lru+0x72/0x180
[   55.231467][ T2798]  iomap_readpages_actor+0xeb/0x1e0
[   55.233376][ T2798]  ? iomap_migrate_page+0x120/0x120
[   55.235382][ T2798]  iomap_apply+0xaf/0x150
[   55.237049][ T2798]  iomap_readpages+0x9f/0x160
[   55.239061][ T2798]  ? iomap_migrate_page+0x120/0x120
[   55.241013][ T2798]  xfs_vm_readpages+0x54/0x130 [xfs]
[   55.242960][ T2798]  read_pages+0x63/0x160
[   55.244613][ T2798]  __do_page_cache_readahead+0x1cd/0x200
[   55.246699][ T2798]  ondemand_readahead+0x201/0x4d0
[   55.248562][ T2798]  page_cache_async_readahead+0x16e/0x2e0
[   55.250740][ T2798]  ? page_cache_async_readahead+0xa5/0x2e0
[   55.252881][ T2798]  filemap_fault+0x3f3/0xc20
[   55.254813][ T2798]  ? xfs_ilock+0x1de/0x2c0 [xfs]
[   55.256858][ T2798]  ? __xfs_filemap_fault+0x7f/0x270 [xfs]
[   55.259118][ T2798]  ? down_read_nested+0x98/0x170
[   55.261123][ T2798]  ? xfs_ilock+0x1de/0x2c0 [xfs]
[   55.263146][ T2798]  __xfs_filemap_fault+0x92/0x270 [xfs]
[   55.265210][ T2798]  xfs_filemap_fault+0x27/0x30 [xfs]
[   55.267164][ T2798]  __do_fault+0x33/0xd0
[   55.268784][ T2798]  do_fault+0x3be/0x5c0
[   55.270390][ T2798]  __handle_mm_fault+0x462/0xc00
[   55.272251][ T2798]  handle_mm_fault+0x17c/0x380
[   55.274055][ T2798]  ? handle_mm_fault+0x46/0x380
[   55.275877][ T2798]  __do_page_fault+0x24a/0x4c0
[   55.277676][ T2798]  do_page_fault+0x27/0x1b0
[   55.279399][ T2798]  page_fault+0x34/0x40
[   55.281053][ T2798] RIP: 0033:0x4009f0
[   55.282564][ T2798] Code: 03 00 00 00 e8 71 fd ff ff 48 83 f8 ff 49 89 c6 74 74 48 89 c6 bf c0 0c 40 00 31 c0 e8 69 fd ff ff 45 85 ff 7e 21 31 c9 66 90 <41> 0f be 14 0e 01 d3 f7 c1 ff 0f 00 00 75 05 41 c6 04 0e 2a 48 83
[   55.289631][ T2798] RSP: 002b:00007fff1804ec00 EFLAGS: 00010206
[   55.291835][ T2798] RAX: 000000000000001b RBX: 0000000000000000 RCX: 0000000001a1a000
[   55.294745][ T2798] RDX: 0000000000000000 RSI: 000000007fffffe5 RDI: 0000000000000000
[   55.297500][ T2798] RBP: 000000000000000c R08: 0000000000000000 R09: 00007f4e7392320d
[   55.300225][ T2798] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000000186a0
[   55.303047][ T2798] R13: 0000000000000003 R14: 00007f4e530d6000 R15: 0000000002800000
----------------------------------------


