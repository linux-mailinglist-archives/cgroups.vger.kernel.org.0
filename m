Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49D7EDB3
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfHBHkw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 03:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732277AbfHBHkw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 03:40:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDBA5AD88;
        Fri,  2 Aug 2019 07:40:49 +0000 (UTC)
Date:   Fri, 2 Aug 2019 09:40:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Masoud Sharbiani <msharbiani@apple.com>
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190802074047.GQ11627@dhcp22.suse.cz>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 01-08-19 11:04:14, Masoud Sharbiani wrote:
> Hey folks,
> I’ve come across an issue that affects most of 4.19, 4.20 and 5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
> It was introduced by
> 
> 29ef680 memcg, oom: move out_of_memory back to the charge path 

This commit shouldn't really change the OOM behavior for your particular
test case. It would have changed MAP_POPULATE behavior but your usage is
triggering the standard page fault path. The only difference with
29ef680 is that the OOM killer is invoked during the charge path rather
than on the way out of the page fault.

Anyway, I tried to run your test case in a loop and leaker always ends
up being killed as expected with 5.2. See the below oom report. There
must be something else going on. How much swap do you have on your
system?

[337533.314245] leaker invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[337533.314250] CPU: 3 PID: 23793 Comm: leaker Not tainted 5.2.0-rc7 #54
[337533.314251] Hardware name: Dell Inc. Latitude E7470/0T6HHJ, BIOS 1.5.3 04/18/2016
[337533.314252] Call Trace:
[337533.314258]  dump_stack+0x67/0x8e
[337533.314262]  dump_header+0x51/0x2e9
[337533.314265]  ? preempt_count_sub+0xc6/0xd2
[337533.314267]  ? _raw_spin_unlock_irqrestore+0x2c/0x3e
[337533.314269]  oom_kill_process+0x90/0x11d
[337533.314271]  out_of_memory+0x25c/0x26f
[337533.314273]  mem_cgroup_out_of_memory+0x8a/0xa6
[337533.314276]  try_charge+0x1d0/0x782
[337533.314278]  ? preempt_count_sub+0xc6/0xd2
[337533.314280]  mem_cgroup_try_charge+0x1a1/0x207
[337533.314282]  __add_to_page_cache_locked+0xf9/0x2dd
[337533.314285]  ? memcg_drain_all_list_lrus+0x125/0x125
[337533.314286]  add_to_page_cache_lru+0x3c/0x96
[337533.314288]  pagecache_get_page.part.7+0x1d6/0x240
[337533.314290]  filemap_fault+0x267/0x54a
[337533.314292]  ext4_filemap_fault+0x2d/0x41
[337533.314294]  ? ext4_page_mkwrite+0x3cd/0x3cd
[337533.314296]  __do_fault+0x47/0xa7
[337533.314297]  __handle_mm_fault+0xaaa/0xf9d
[337533.314300]  handle_mm_fault+0x174/0x1c3
[337533.314303]  __do_page_fault+0x309/0x412
[337533.314305]  do_page_fault+0x10b/0x131
[337533.314307]  ? page_fault+0x8/0x30
[337533.314309]  page_fault+0x1e/0x30
[337533.314311] RIP: 0033:0x55a806ef8503
[337533.314313] Code: 48 89 c6 48 8d 3d 28 0c 00 00 b8 00 00 00 00 e8 73 fb ff ff c7 45 ec 00 00 00 00 eb 36 8b 45 ec 48 63 d0 48 8b 45 c8 48 01 d0 <0f> b6 00 0f be c0 01 45 e4 8b 45 ec 25 ff 0f 00 00 85 c0 75 10 8b
[337533.314314] RSP: 002b:00007ffcf6734730 EFLAGS: 00010206
[337533.314316] RAX: 00007f2228f74000 RBX: 0000000000000000 RCX: 0000000000000000
[337533.314317] RDX: 0000000000487000 RSI: 000055a806efc260 RDI: 0000000000000000
[337533.314318] RBP: 00007ffcf6735780 R08: 0000000000000000 R09: 00007ffcf67345fc
[337533.314319] R10: 0000000000000000 R11: 0000000000000246 R12: 000055a806ef8120
[337533.314320] R13: 00007ffcf6735860 R14: 0000000000000000 R15: 0000000000000000
[337533.314322] memory: usage 524288kB, limit 524288kB, failcnt 1240247
[337533.314323] memory+swap: usage 2592556kB, limit 9007199254740988kB, failcnt 0
[337533.314324] kmem: usage 7260kB, limit 9007199254740988kB, failcnt 0
[337533.314325] Memory cgroup stats for /leaker: cache:80KB rss:516948KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:2068268KB inactive_anon:258520KB active_anon:258412KB inactive_file:32KB active_file:12KB unevictable:0KB
[337533.314332] Tasks state (memory values in pages):
[337533.314333] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[337533.314404] [  23777]     0 23777      596      400    36864        4             0 sh
[337533.314407] [  23793]     0 23793   655928   126942  5226496   519670             0 leaker
[337533.314408] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),oom_memcg=/leaker,task_memcg=/leaker,task=leaker,pid=23793,uid=0
[337533.314412] Memory cgroup out of memory: Killed process 23793 (leaker) total-vm:2623712kB, anon-rss:506500kB, file-rss:1268kB, shmem-rss:0kB
[337533.418036] oom_reaper: reaped process 23793 (leaker), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
-- 
Michal Hocko
SUSE Labs
