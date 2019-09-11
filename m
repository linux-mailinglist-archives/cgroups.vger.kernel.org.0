Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD5AFE38
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2019 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfIKOAA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Sep 2019 10:00:00 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:41183 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbfIKOAA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Sep 2019 10:00:00 -0400
Received: (qmail 18897 invoked from network); 11 Sep 2019 15:59:56 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Wed, 11 Sep 2019 15:59:56 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
 <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
 <20190910132418.GC2063@dhcp22.suse.cz>
 <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
 <5f960e74-1f44-9a0a-58a6-dcb64aa71612@profihost.ag>
Message-ID: <289fbe71-0472-520f-64e2-b6d07ced5436@profihost.ag>
Date:   Wed, 11 Sep 2019 15:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5f960e74-1f44-9a0a-58a6-dcb64aa71612@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

HI,

i've now tried v5.2.14 but that one died with - i don't know which
version to try... now

2019-09-11 15:41:09     ------------[ cut here ]------------
2019-09-11 15:41:09     kernel BUG at mm/page-writeback.c:2655!
2019-09-11 15:41:09     invalid opcode: 0000 [#1] SMP PTI
2019-09-11 15:41:09     CPU: 4 PID: 466 Comm: kworker/u24:6 Not tainted
5.2.14 #1
2019-09-11 15:41:09     Hardware name: Supermicro Super Server/X10SRi-F,
BIOS 1.0b 04/21/2015
2019-09-11 15:41:09     Workqueue: btrfs-delalloc btrfs_delalloc_helper
[btrfs]
2019-09-11 15:41:09     RIP: 0010:clear_page_dirty_for_io+0xfc/0x210
2019-09-11 15:41:09     Code: 01 48 0f 44 d3 f0 48 0f ba 32 03 b8 00 00
00 00 72 1a 4d 85 e4 0f 85 b4 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41
5e 41 5f c3 <0f> 0b 9c 41 5f fa 48 8b 03 48 8b 53 38 48 c1 e8 36 48 85
d2 48 8b
2019-09-11 15:41:09     RSP: 0018:ffffbd4b8d2f3c18 EFLAGS: 00010246
2019-09-11 15:41:09     RAX: 001000000004205c RBX: ffffe660525b3140 RCX:
0000000000000000
2019-09-11 15:41:09     RDX: 0000000000000000 RSI: 0000000000000006 RDI:
ffffe660525b3140
2019-09-11 15:41:09     RBP: ffff9ad639868818 R08: 0000000000000001 R09:
000000000002de18
2019-09-11 15:41:09     R10: 0000000000000002 R11: ffff9ade7ffd6000 R12:
0000000000000000
2019-09-11 15:41:09     R13: 0000000000000001 R14: 0000000000000000 R15:
ffffbd4b8d2f3d08
2019-09-11 15:41:09     FS: 0000000000000000(0000)
GS:ffff9ade3f900000(0000) knlGS:0000000000000000
2019-09-11 15:41:09     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-09-11 15:41:09     CR2: 000055fa10d2bf70 CR3: 00000005a420a002 CR4:
00000000001606e0
2019-09-11 15:41:09     Call Trace:
2019-09-11 15:41:09     __process_pages_contig+0x270/0x360 [btrfs]
2019-09-11 15:41:09     submit_compressed_extents+0x39d/0x460 [btrfs]
2019-09-11 15:41:09     normal_work_helper+0x20f/0x320
[btrfs]process_one_work+0x18b/0x380worker_thread+0x4f/0x3a0
2019-09-11 15:41:09     ? rescuer_thread+0x330/0x330kthread+0xf8/0x130
2019-09-11 15:41:09     ?
kthread_create_worker_on_cpu+0x70/0x70ret_from_fork+0x35/0x40
2019-09-11 15:41:09     Modules linked in: netconsole xt_tcpudp xt_owner
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_multiport
ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter fuse
ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
x86_pkg_temp_thermal coretemp kvm_intel ast kvm ttm drm_kms_helper
irqbypass crc32_pclmul drm fb_sys_fops syscopyarea lpc_ich sysfillrect
ghash_clmulni_intel sysimgblt mfd_core sg wmi ipmi_si ipmi_devintf
ipmi_msghandler button ip_tables x_tables btrfs zstd_decompress
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor usbhid raid6_pq raid1 raid0 multipath linear
md_mod sd_mod xhci_pci ehci_pci igb xhci_hcd ehci_hcd i2c_algo_bit
i2c_i801 ahci ptp i2c_core usbcore libahci usb_common pps_core megaraid_sas
2019-09-11 15:41:09     ---[ end trace d9a3f99c047dc8bf ]---
2019-09-11 15:41:10     RIP: 0010:clear_page_dirty_for_io+0xfc/0x210
2019-09-11 15:41:10     Code: 01 48 0f 44 d3 f0 48 0f ba 32 03 b8 00 00
00 00 72 1a 4d 85 e4 0f 85 b4 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41
5e 41 5f c3 <0f> 0b 9c 41 5f fa 48 8b 03 48 8b 53 38 48 c1 e8 36 48 85
d2 48 8b
2019-09-11 15:41:10     RSP: 0018:ffffbd4b8d2f3c18 EFLAGS: 00010246
2019-09-11 15:41:10     RAX: 001000000004205c RBX: ffffe660525b3140 RCX:
0000000000000000
2019-09-11 15:41:10     RDX: 0000000000000000 RSI: 0000000000000006 RDI:
ffffe660525b3140
2019-09-11 15:41:10     RBP: ffff9ad639868818 R08: 0000000000000001 R09:
000000000002de18
2019-09-11 15:41:10     R10: 0000000000000002 R11: ffff9ade7ffd6000 R12:
0000000000000000
2019-09-11 15:41:10     R13: 0000000000000001 R14: 0000000000000000 R15:
ffffbd4b8d2f3d08
2019-09-11 15:41:10     FS: 0000000000000000(0000)
GS:ffff9ade3f900000(0000) knlGS:0000000000000000
2019-09-11 15:41:10     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-09-11 15:41:10     CR2: 000055fa10d2bf70 CR3: 00000005a420a002 CR4:
00000000001606e0
2019-09-11 15:41:10     Kernel panic - not syncing: Fatal exception
2019-09-11 15:41:10     Kernel Offset: 0x1a000000 from
0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
2019-09-11 15:41:10     Rebooting in 20 seconds..
2019-09-11 15:41:29     ACPI MEMORY or I/O RESET_REG.

Stefan
Am 11.09.19 um 08:24 schrieb Stefan Priebe - Profihost AG:
> Hi Michal,
> 
> Am 11.09.19 um 08:12 schrieb Stefan Priebe - Profihost AG:
>> Hi Michal,
>> Am 10.09.19 um 15:24 schrieb Michal Hocko:
>>> On Tue 10-09-19 15:14:45, Stefan Priebe - Profihost AG wrote:
>>>> Am 10.09.19 um 15:05 schrieb Stefan Priebe - Profihost AG:
>>>>>
>>>>> Am 10.09.19 um 14:57 schrieb Michal Hocko:
>>>>>> On Tue 10-09-19 14:45:37, Stefan Priebe - Profihost AG wrote:
>>>>>>> Hello Michal,
>>>>>>>
>>>>>>> ok this might take a long time. Attached you'll find a graph from a
>>>>>>> fresh boot what happens over time (here 17 August to 30 August). Memory
>>>>>>> Usage decreases as well as cache but slowly and only over time and days.
>>>>>>>
>>>>>>> So it might take 2-3 weeks running Kernel 5.3 to see what happens.
>>>>>>
>>>>>> No problem. Just make sure to collect the requested data from the time
>>>>>> you see the actual problem. Btw. you try my very dumb scriplets to get
>>>>>> an idea of how much memory gets reclaimed due to THP.
>>>>>
>>>>> You mean your sed and sort on top of the trace file? No i did not with
>>>>> the current 5.3 kernel do you think it will show anything interesting?
>>>>> Which line shows me how much memory gets reclaimed due to THP?
>>>
>>> Please re-read http://lkml.kernel.org/r/20190910082919.GL2063@dhcp22.suse.cz
>>> Each command has a commented output. If you see nunmber of reclaimed
>>> pages to be large for GFP_TRANSHUGE then you are seeing a similar
>>> problem.
>>>
>>>> Is something like a kernel memory leak possible? Or wouldn't this end up
>>>> in having a lot of free memory which doesn't seem usable.
>>>
>>> I would be really surprised if this was the case.
>>>
>>>> I also wonder why a reclaim takes place when there is enough memory.
>>>
>>> This is not clear yet and it might be a bug that has been fixed since
>>> 4.18. That's why we need to see whether the same is pattern is happening
>>> with 5.3 as well.
> 
> but except from the btrfs problem the memory consumption looks far
> better than before.
> 
> Running 4.19.X:
> after about 12h cache starts to drop from 30G to 24G
> 
> Running 5.3-rc8:
> after about 24h cache is still constant at nearly 30G
> 
> Greets,
> Stefan
> 
