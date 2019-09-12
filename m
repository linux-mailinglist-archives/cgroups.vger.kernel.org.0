Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14FB0D8E
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2019 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfILLGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Sep 2019 07:06:15 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:45895 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730923AbfILLGP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Sep 2019 07:06:15 -0400
Received: (qmail 16287 invoked from network); 12 Sep 2019 13:06:09 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 12 Sep 2019 13:06:09 +0200
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
 <289fbe71-0472-520f-64e2-b6d07ced5436@profihost.ag>
 <dc062161-7828-0d27-6347-8dd0e118d4a9@profihost.ag>
Message-ID: <ca4e724b-37f7-9dcf-44f1-d84bb020493d@profihost.ag>
Date:   Thu, 12 Sep 2019 13:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc062161-7828-0d27-6347-8dd0e118d4a9@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry very short after that even more traces show up:

So currently it seems we can't test with 5.3-rc8 or 5.2.14 - what's next?


watchdog: BUG: soft lockup - CPU#7 stuck for 23s! [authscanclient:812]
Modules linked in: btrfs dm_mod netconsole xt_tcpudp xt_owner
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
xt_multiport ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter
ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
x86_pkg_temp_thermal coretemp kvm_intel ast ttm kvm drm_kms_helper
irqbypass drm crc32_pclmul fb_sys_fops lpc_ich ipmi_si syscopyarea
sysfillrect ipmi_devintf mfd_core ghash_clmulni_intel wmi sysimgblt sg
ipmi_msghandler button ip_tables x_tables zstd_decompress zstd_compress
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor usbhid raid6_pq raid1 raid0 multipath linear md_mod
xhci_pci sd_mod ehci_pci xhci_hcd ehci_hcd igb i2c_i801 i2c_algo_bit
ahci usbcore ptp libahci i2c_core usb_common pps_core megaraid_sas [last
unloaded: btrfs]
CPU: 7 PID: 812 Comm: authscanclient Tainted: G        W         5.2.14 #1
watchdog: BUG: soft lockup - CPU#11 stuck for 23s! [authscanclient:813]
Hardware name: Supermicro Super Server/X10SRi-F, BIOS 1.0b 04/21/2015
Modules linked in: btrfs dm_mod netconsole xt_tcpudp xt_owner
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
xt_multiport ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter
ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
x86_pkg_temp_thermal coretemp kvm_intel ast ttm kvm drm_kms_helper
irqbypass drm crc32_pclmul fb_sys_fops lpc_ich ipmi_si syscopyarea
sysfillrect ipmi_devintf mfd_core ghash_clmulni_intel wmi sysimgblt sg
ipmi_msghandler button ip_tables x_tables zstd_decompress zstd_compress
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor usbhid raid6_pq raid1 raid0 multipath linear md_mod
xhci_pci sd_mod ehci_pci xhci_hcd ehci_hcd igb i2c_i801 i2c_algo_bit
ahci usbcore ptp libahci i2c_core usb_common pps_core megaraid_sas [last
unloaded: btrfs]
RIP: 0010:find_next_bit+0x1c/0x60
CPU: 11 PID: 813 Comm: authscanclient Tainted: G        W         5.2.14 #1
Code: 8d 04 0a c3 f3 c3 0f 1f 84 00 00 00 00 00 48 39 d6 48 89 f0 48 89
d1 76 4e 48 89 d6 48 c7 c2 ff ff ff ff 48 c1 ee 06 48 d3 e2 <48> 83 e1
c0 48 23 14 f7 75 24 48 83 c1 40 48 39 c8 77 0b eb 2a 48
Hardware name: Supermicro Super Server/X10SRi-F, BIOS 1.0b 04/21/2015
RIP: 0010:cpumask_next+0x12/0x20
RSP: 0000:ffffbea7c770b608 EFLAGS: 00000287 ORIG_RAX: ffffffffffffff13
Code: 48 01 f8 80 38 22 75 97 eb d4 90 90 90 90 90 90 90 90 90 90 90 90
90 90 48 89 f0 8b 35 4b 82 b6 00 8d 57 01 48 89 c7 48 63 d2 <e8> d9 33
c6 ff f3 c3 0f 1f 80 00 00 00 00 55 53 89 f3 8b 35 2a 82
RAX: 000000000000000c RBX: 0000000000000004 RCX: 0000000000000002
RDX: fffffffffffffffc RSI: 0000000000000000 RDI: ffffffffbe3e5e40
RSP: 0000:ffffbea7c727f620 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RBP: ffff96f9edc8cc00 R08: 0000000000000000 R09: ffff96eac78049b8
R10: ffffbea7c770b750 R11: ffffffffbe2bd8d8 R12: 0000000000000010
RAX: ffffffffbe3e5e40 RBX: ffff96f9edc8cc00 RCX: 0000000000000007
RDX: 0000000000000008 RSI: 000000000000000c RDI: ffffffffbe3e5e40
R13: ffffffffbe3e5e40 R14: 0000000000000002 R15: ffffffffffffffa0
FS:  00007f3ab8edd700(0000) GS:ffff96f9ff9c0000(0000) knlGS:0000000000000000
RBP: ffffffffbe3e5e40 R08: ffff96eac7804920 R09: ffff96eac78049b8
R10: 0000000000000000 R11: ffffffffbe2bd8d8 R12: 0000000000000018
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3abbf66f20 CR3: 0000000fe60a6001 CR4: 00000000001606e0
R13: 0000000000000003 R14: 0000000000008e4b R15: fffffffffffffff6
FS:  00007f3aabfff700(0000) GS:ffff96f9ffac0000(0000) knlGS:0000000000000000
Call Trace:
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3abbf66fd0 CR3: 0000000fe60a6004 CR4: 00000000001606e0
 cpumask_next+0x17/0x20
Call Trace:
 lruvec_lru_size+0x5c/0x110
 count_shadow_nodes+0xac/0x220
 shrink_node_memcg+0xd7/0x7d0
 do_shrink_slab+0x55/0x2d0
 ? shrink_slab+0x2a3/0x2b0
 shrink_slab+0x219/0x2b0
 ? shrink_node+0xe0/0x4b0
 shrink_node+0xf6/0x4b0
 shrink_node+0xe0/0x4b0
 do_try_to_free_pages+0xeb/0x380
 do_try_to_free_pages+0xeb/0x380
 try_to_free_mem_cgroup_pages+0xe6/0x1e0
 try_to_free_mem_cgroup_pages+0xe6/0x1e0
 try_charge+0x295/0x780
 try_charge+0x295/0x780
 ? shrink_slab+0x2a3/0x2b0
 ? mem_cgroup_commit_charge+0x79/0x4a0
 mem_cgroup_try_charge+0xc2/0x190
 mem_cgroup_try_charge+0xc2/0x190
 __add_to_page_cache_locked+0x282/0x330
 __add_to_page_cache_locked+0x282/0x330
 ? count_shadow_nodes+0x220/0x220
 ? count_shadow_nodes+0x220/0x220
 add_to_page_cache_lru+0x4a/0xc0
 add_to_page_cache_lru+0x4a/0xc0
 iomap_readpages_actor+0x103/0x220
 iomap_readpages_actor+0x103/0x220
 ? iomap_write_begin.constprop.45+0x370/0x370
 ? iomap_write_begin.constprop.45+0x370/0x370
 iomap_apply+0xba/0x150
 ? iomap_write_begin.constprop.45+0x370/0x370
 iomap_apply+0xba/0x150
 iomap_readpages+0xaa/0x1a0
 ? iomap_write_begin.constprop.45+0x370/0x370
 ? iomap_write_begin.constprop.45+0x370/0x370
 iomap_readpages+0xaa/0x1a0
 ? iomap_write_begin.constprop.45+0x370/0x370
 read_pages+0x71/0x1a0
 read_pages+0x71/0x1a0
 ? 0xffffffffbd000000
 ? __do_page_cache_readahead+0x1cc/0x1e0
 ? __do_page_cache_readahead+0x1a8/0x1e0
 __do_page_cache_readahead+0x1cc/0x1e0
 __do_page_cache_readahead+0x1a8/0x1e0
 filemap_fault+0x6fc/0x960
 filemap_fault+0x6fc/0x960
 ? __mod_lruvec_state+0x3f/0xe0
 ? schedule+0x39/0xa0
 ? page_add_file_rmap+0xd1/0x160
 ? __mod_lruvec_state+0x3f/0xe0
 ? alloc_set_pte+0x4f8/0x5c0
 __xfs_filemap_fault.constprop.13+0x49/0x120
 ? page_add_file_rmap+0xd1/0x160
 __do_fault+0x3c/0x110
 ? alloc_set_pte+0x4f8/0x5c0
 __handle_mm_fault+0xa7c/0xfb0
 __xfs_filemap_fault.constprop.13+0x49/0x120
 handle_mm_fault+0xd0/0x1d0
 __do_fault+0x3c/0x110
 __do_page_fault+0x253/0x470
 __handle_mm_fault+0xa7c/0xfb0
 do_page_fault+0x2c/0x106
 handle_mm_fault+0xd0/0x1d0
 ? page_fault+0x8/0x30
 __do_page_fault+0x253/0x470
 page_fault+0x1e/0x30
 do_page_fault+0x2c/0x106
RIP: 0033:0x7f3abbf66f20
 ? page_fault+0x8/0x30
Code: 68 38 00 00 00 e9 60 fc ff ff ff 25 da 72 20 00 68 39 00 00 00 e9
50 fc ff ff ff 25 d2 72 20 00 68 3a 00 00 00 e9 40 fc ff ff <ff> 25 ca
72 20 00 68 3b 00 00 00 e9 30 fc ff ff ff 25 c2 72 20 00
 page_fault+0x1e/0x30
RSP: 002b:00007f3ab8edcb58 EFLAGS: 00010246
RIP: 0033:0x7f3abbf66fd0
RAX: 0000000000000001 RBX: 000055f087797ae0 RCX: 0000000000000010
RDX: 000000002090000c RSI: 0000000000000050 RDI: 000055f087797ae0
Code: 68 43 00 00 00 e9 b0 fb ff ff ff 25 82 72 20 00 68 44 00 00 00 e9
a0 fb ff ff ff 25 7a 72 20 00 68 45 00 00 00 e9 90 fb ff ff <ff> 25 72
72 20 00 68 46 00 00 00 e9 80 fb ff ff ff 25 6a 72 20 00
RBP: 000055f0873a69d0 R08: 0000000000000602 R09: 000055f0876daee0
R10: 000055f087034980 R11: 00000000e24313e9 R12: 000055f08779e558
RSP: 002b:00007f3aabffea68 EFLAGS: 00010287
R13: 000055f08779e558 R14: 000055f0873a69d0 R15: 000055f08779e550
RAX: 000055f087b75190 RBX: 00007f3abc16e2c0 RCX: 0000000000000012
RDX: 0000000000000002 RSI: 00007f3abc16e2c0 RDI: 00007f3abc16e2c0
RBP: 000055f08777a9f0 R08: 000000000000000f R09: 0000000000000003
R10: 000000000000000b R11: 0000000000000000 R12: 000055f08777a9f0
R13: 000055f085e5b5b8 R14: 000055f087b79240 R15: 0000000000000000
igb 0000:05:00.1 eth1: Reset adapter
igb 0000:05:00.1 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex,
Flow Control: None
watchdog: BUG: soft lockup - CPU#7 stuck for 23s! [authscanclient:812]
Modules linked in: btrfs dm_mod netconsole xt_tcpudp xt_owner
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
xt_multiport ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter
ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
x86_pkg_temp_thermal coretemp kvm_intel ast ttm kvm drm_kms_helper
irqbypass drm crc32_pclmul fb_sys_fops lpc_ich ipmi_si syscopyarea
sysfillrect ipmi_devintf mfd_core ghash_clmulni_intel wmi sysimgblt sg
ipmi_msghandler button ip_tables x_tables zstd_decompress zstd_compress
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor usbhid raid6_pq raid1 raid0 multipath linear md_mod
xhci_pci sd_mod ehci_pci xhci_hcd ehci_hcd igb i2c_i801 i2c_algo_bit
ahci usbcore ptp libahci i2c_core usb_common pps_core megaraid_sas [last
unloaded: btrfs]
CPU: 7 PID: 812 Comm: authscanclient Tainted: G        W    L    5.2.14 #1
watchdog: BUG: soft lockup - CPU#11 stuck for 23s! [authscanclient:813]
Hardware name: Supermicro Super Server/X10SRi-F, BIOS 1.0b 04/21/2015
Modules linked in: btrfs dm_mod netconsole xt_tcpudp xt_owner
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
xt_multiport ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter
ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
x86_pkg_temp_thermal coretemp kvm_intel ast ttm kvm drm_kms_helper
irqbypass drm crc32_pclmul fb_sys_fops lpc_ich ipmi_si syscopyarea
sysfillrect ipmi_devintf mfd_core ghash_clmulni_intel wmi sysimgblt sg
ipmi_msghandler button ip_tables x_tables zstd_decompress zstd_compress
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor usbhid raid6_pq raid1 raid0 multipath linear md_mod
xhci_pci sd_mod ehci_pci xhci_hcd ehci_hcd igb i2c_i801 i2c_algo_bit
ahci usbcore ptp libahci i2c_core usb_common pps_core megaraid_sas [last
unloaded: btrfs]
RIP: 0010:cpumask_next+0x0/0x20
CPU: 11 PID: 813 Comm: authscanclient Tainted: G        W    L    5.2.14 #1
Code: 83 c7 01 e9 24 ff ff ff 48 83 c0 01 48 89 02 44 89 d0 48 01 f8 80
38 22 75 97 eb d4 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <48> 89 f0
8b 35 4b 82 b6 00 8d 57 01 48 89 c7 48 63 d2 e8 d9 33 c6
Hardware name: Supermicro Super Server/X10SRi-F, BIOS 1.0b 04/21/2015
RIP: 0010:cpumask_next+0x12/0x20
RSP: 0000:ffffbea7c770b610 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff13
Code: 48 01 f8 80 38 22 75 97 eb d4 90 90 90 90 90 90 90 90 90 90 90 90
90 90 48 89 f0 8b 35 4b 82 b6 00 8d 57 01 48 89 c7 48 63 d2 <e8> d9 33
c6 ff f3 c3 0f 1f 80 00 00 00 00 55 53 89 f3 8b 35 2a 82
RAX: 0000000000000002 RBX: 0000000000000004 RCX: ffff96f9ff880000
RDX: 000047adbfe07c58 RSI: ffffffffbe3e5e40 RDI: 0000000000000002
RSP: 0000:ffffbea7c727f620 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RBP: ffff96f9edc8cc00 R08: 0000000000000000 R09: ffff96eac78049b8
R10: ffffbea7c770b750 R11: ffffffffbe2bd8d8 R12: 0000000000000018
RAX: ffffffffbe3e5e40 RBX: ffff96f9edc8cc00 RCX: 0000000000000009
RDX: 000000000000000a RSI: 000000000000000c RDI: ffffffffbe3e5e40
R13: ffffffffbe3e5e40 R14: 0000000000000003 R15: ffffffffffffffc1
FS:  00007f3ab8edd700(0000) GS:ffff96f9ff9c0000(0000) knlGS:0000000000000000
RBP: ffffffffbe3e5e40 R08: ffff96eac7804920 R09: ffff96eac78049b8
R10: 0000000000000000 R11: ffffffffbe2bd8d8 R12: 0000000000000020
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3abbf66f20 CR3: 0000000fe60a6001 CR4: 00000000001606e0
R13: 0000000000000004 R14: 0000000000008e4b R15: 0000000000000000
FS:  00007f3aabfff700(0000) GS:ffff96f9ffac0000(0000) knlGS:0000000000000000
Call Trace:
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3abbf66fd0 CR3: 0000000fe60a6004 CR4: 00000000001606e0
 lruvec_lru_size+0x5c/0x110
Call Trace:
 shrink_node_memcg+0xd7/0x7d0
 count_shadow_nodes+0xac/0x220
 ? shrink_slab+0x2a3/0x2b0
 do_shrink_slab+0x55/0x2d0
 ? shrink_node+0xe0/0x4b0
 shrink_slab+0x219/0x2b0
 shrink_node+0xe0/0x4b0

Stefan

Am 12.09.19 um 12:53 schrieb Stefan Priebe - Profihost AG:
> Hello Michal,
> 
> now the kernel (5.2.14) was locked / deadlocked with:
> ---------------
> 019-09-12 12:41:47     ------------[ cut here ]------------
> 2019-09-12 12:41:47     NETDEV WATCHDOG: eth0 (igb): transmit queue 2
> timed out
> 2019-09-12 12:41:47     WARNING: CPU: 2 PID: 0 at
> net/sched/sch_generic.c:443 dev_watchdog+0x254/0x260
> 2019-09-12 12:41:47     Modules linked in: btrfs dm_mod netconsole
> xt_tcpudp xt_owner xt_conntrack nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 fuse xt_multiport ipt_REJECT nf_reject_ipv4 xt_set
> iptable_filter bpfilter ip_set_hash_net ip_set nfnetlink 8021q garp
> bonding sb_edac x86_pkg_temp_thermal coretemp kvm_intel ast ttm kvm
> drm_kms_helper irqbypass drm crc32_pclmul fb_sys_fops lpc_ich ipmi_si
> syscopyarea sysfillrect ipmi_devintf mfd_core ghash_clmulni_intel wmi
> sysimgblt sg ipmi_msghandler button ip_tables x_tables zstd_decompress
> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx xor usbhid raid6_pq raid1 raid0 multipath linear
> md_mod xhci_pci sd_mod ehci_pci xhci_hcd ehci_hcd igb i2c_i801
> i2c_algo_bit ahci usbcore ptp libahci i2c_core usb_common pps_core
> megaraid_sas [last unloaded: btrfs]
> 2019-09-12 12:41:47     CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.2.14 #1
> 2019-09-12 12:41:47     Hardware name: Supermicro Super Server/X10SRi-F,
> BIOS 1.0b 04/21/2015
> 2019-09-12 12:41:47     RIP: 0010:dev_watchdog+0x254/0x260
> 2019-09-12 12:41:47     Code: 48 85 c0 75 e4 eb 9d 4c 89 ef c6 05 a6 09
> c8 00 01 e8 b0 53 fb ff 89 d9 48 89 c2 4c 89 ee 48 c7 c7 10 d6 0c be e8
> ac ca 98 ff <0f> 0b e9 7c ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 41 57
> 41 56 49
> 2019-09-12 12:41:47     RSP: 0018:ffffbea7c63a0e68 EFLAGS: 00010282
> 2019-09-12 12:41:47     RAX: 0000000000000000 RBX: 0000000000000002 RCX:
> 0000000000000006
> 2019-09-12 12:41:47     RDX: 0000000000000007 RSI: 0000000000000086 RDI:
> ffff96f9ff896540
> 2019-09-12 12:41:47     RBP: ffff96f9fc18041c R08: 0000000000000001 R09:
> 000000000000046f
> 2019-09-12 12:41:47     R10: ffff96f9ff89a630 R11: 0000000000000000 R12:
> ffff96f9f9e16940
> 2019-09-12 12:41:47     R13: ffff96f9fc180000 R14: ffff96f9fc180440 R15:
> 0000000000000008
> 2019-09-12 12:41:47     FS: 0000000000000000(0000)
> GS:ffff96f9ff880000(0000) knlGS:0000000000000000
> 2019-09-12 12:41:47     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2019-09-12 12:41:47     CR2: 00007fbb2c4e2000 CR3: 0000000c0d20a004 CR4:
> 00000000001606e0
> 2019-09-12 12:41:47     Call Trace:<IRQ>
> 2019-09-12 12:41:47     ?
> pfifo_fast_reset+0x110/0x110call_timer_fn+0x2d/0x140run_timer_softirq+0x1e2/0x440
> 2019-09-12 12:41:47     ? timerqueue_add+0x54/0x80
> 2019-09-12 12:41:48     ?
> enqueue_hrtimer+0x3a/0x90__do_softirq+0x10c/0x2d4irq_exit+0xdd/0xf0smp_apic_timer_interrupt+0x74/0x130apic_timer_interrupt+0xf/0x20</IRQ>
> 2019-09-12 12:41:48     RIP: 0010:cpuidle_enter_state+0xbd/0x410
> 2019-09-12 12:41:48     Code: 24 0f 1f 44 00 00 31 ff e8 b0 67 a5 ff 80
> 7c 24 13 00 74 12 9c 58 f6 c4 02 0f 85 2c 03 00 00 31 ff e8 a7 b9 aa ff
> fb 45 85 ed <0f> 88 e0 02 00 00 4c 8b 04 24 4c 2b 44 24 08 48 ba cf f7
> 53 e3 a5
> 2019-09-12 12:41:48     RSP: 0018:ffffbea7c62f7e60 EFLAGS: 00000202
> ORIG_RAX: ffffffffffffff13
> 2019-09-12 12:41:48     RAX: ffff96f9ff8a9840 RBX: ffffffffbe3271a0 RCX:
> 000000000000001f
> 2019-09-12 12:41:48     RDX: 000044a065c471eb RSI: 0000000024925419 RDI:
> 0000000000000000
> 2019-09-12 12:41:48     RBP: ffffdea7bfa80f00 R08: 0000000000000002 R09:
> 00000000000290c0
> 2019-09-12 12:41:48     R10: 00000000ffffffff R11: 0000000000000f05 R12:
> 0000000000000004
> 2019-09-12 12:41:48     R13: 0000000000000004 R14: 0000000000000004 R15:
> ffffffffbe3271a0cpuidle_enter+0x29/0x40do_idle+0x1d5/0x220cpu_startup_entry+0x19/0x20start_secondary+0x16b/0x1b0secondary_startup_64+0xa4/0xb0
> 2019-09-12 12:41:48     ---[ end trace 3241d99856ac4582 ]---
> 2019-09-12 12:41:48     igb 0000:05:00.0 eth0: Reset adapter
> -------------------------------
> 
> Stefan
> Am 11.09.19 um 15:59 schrieb Stefan Priebe - Profihost AG:
>> HI,
>>
>> i've now tried v5.2.14 but that one died with - i don't know which
>> version to try... now
>>
>> 2019-09-11 15:41:09     ------------[ cut here ]------------
>> 2019-09-11 15:41:09     kernel BUG at mm/page-writeback.c:2655!
>> 2019-09-11 15:41:09     invalid opcode: 0000 [#1] SMP PTI
>> 2019-09-11 15:41:09     CPU: 4 PID: 466 Comm: kworker/u24:6 Not tainted
>> 5.2.14 #1
>> 2019-09-11 15:41:09     Hardware name: Supermicro Super Server/X10SRi-F,
>> BIOS 1.0b 04/21/2015
>> 2019-09-11 15:41:09     Workqueue: btrfs-delalloc btrfs_delalloc_helper
>> [btrfs]
>> 2019-09-11 15:41:09     RIP: 0010:clear_page_dirty_for_io+0xfc/0x210
>> 2019-09-11 15:41:09     Code: 01 48 0f 44 d3 f0 48 0f ba 32 03 b8 00 00
>> 00 00 72 1a 4d 85 e4 0f 85 b4 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41
>> 5e 41 5f c3 <0f> 0b 9c 41 5f fa 48 8b 03 48 8b 53 38 48 c1 e8 36 48 85
>> d2 48 8b
>> 2019-09-11 15:41:09     RSP: 0018:ffffbd4b8d2f3c18 EFLAGS: 00010246
>> 2019-09-11 15:41:09     RAX: 001000000004205c RBX: ffffe660525b3140 RCX:
>> 0000000000000000
>> 2019-09-11 15:41:09     RDX: 0000000000000000 RSI: 0000000000000006 RDI:
>> ffffe660525b3140
>> 2019-09-11 15:41:09     RBP: ffff9ad639868818 R08: 0000000000000001 R09:
>> 000000000002de18
>> 2019-09-11 15:41:09     R10: 0000000000000002 R11: ffff9ade7ffd6000 R12:
>> 0000000000000000
>> 2019-09-11 15:41:09     R13: 0000000000000001 R14: 0000000000000000 R15:
>> ffffbd4b8d2f3d08
>> 2019-09-11 15:41:09     FS: 0000000000000000(0000)
>> GS:ffff9ade3f900000(0000) knlGS:0000000000000000
>> 2019-09-11 15:41:09     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 2019-09-11 15:41:09     CR2: 000055fa10d2bf70 CR3: 00000005a420a002 CR4:
>> 00000000001606e0
>> 2019-09-11 15:41:09     Call Trace:
>> 2019-09-11 15:41:09     __process_pages_contig+0x270/0x360 [btrfs]
>> 2019-09-11 15:41:09     submit_compressed_extents+0x39d/0x460 [btrfs]
>> 2019-09-11 15:41:09     normal_work_helper+0x20f/0x320
>> [btrfs]process_one_work+0x18b/0x380worker_thread+0x4f/0x3a0
>> 2019-09-11 15:41:09     ? rescuer_thread+0x330/0x330kthread+0xf8/0x130
>> 2019-09-11 15:41:09     ?
>> kthread_create_worker_on_cpu+0x70/0x70ret_from_fork+0x35/0x40
>> 2019-09-11 15:41:09     Modules linked in: netconsole xt_tcpudp xt_owner
>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_multiport
>> ipt_REJECT nf_reject_ipv4 xt_set iptable_filter bpfilter fuse
>> ip_set_hash_net ip_set nfnetlink 8021q garp bonding sb_edac
>> x86_pkg_temp_thermal coretemp kvm_intel ast kvm ttm drm_kms_helper
>> irqbypass crc32_pclmul drm fb_sys_fops syscopyarea lpc_ich sysfillrect
>> ghash_clmulni_intel sysimgblt mfd_core sg wmi ipmi_si ipmi_devintf
>> ipmi_msghandler button ip_tables x_tables btrfs zstd_decompress
>> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
>> async_xor async_tx xor usbhid raid6_pq raid1 raid0 multipath linear
>> md_mod sd_mod xhci_pci ehci_pci igb xhci_hcd ehci_hcd i2c_algo_bit
>> i2c_i801 ahci ptp i2c_core usbcore libahci usb_common pps_core megaraid_sas
>> 2019-09-11 15:41:09     ---[ end trace d9a3f99c047dc8bf ]---
>> 2019-09-11 15:41:10     RIP: 0010:clear_page_dirty_for_io+0xfc/0x210
>> 2019-09-11 15:41:10     Code: 01 48 0f 44 d3 f0 48 0f ba 32 03 b8 00 00
>> 00 00 72 1a 4d 85 e4 0f 85 b4 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41
>> 5e 41 5f c3 <0f> 0b 9c 41 5f fa 48 8b 03 48 8b 53 38 48 c1 e8 36 48 85
>> d2 48 8b
>> 2019-09-11 15:41:10     RSP: 0018:ffffbd4b8d2f3c18 EFLAGS: 00010246
>> 2019-09-11 15:41:10     RAX: 001000000004205c RBX: ffffe660525b3140 RCX:
>> 0000000000000000
>> 2019-09-11 15:41:10     RDX: 0000000000000000 RSI: 0000000000000006 RDI:
>> ffffe660525b3140
>> 2019-09-11 15:41:10     RBP: ffff9ad639868818 R08: 0000000000000001 R09:
>> 000000000002de18
>> 2019-09-11 15:41:10     R10: 0000000000000002 R11: ffff9ade7ffd6000 R12:
>> 0000000000000000
>> 2019-09-11 15:41:10     R13: 0000000000000001 R14: 0000000000000000 R15:
>> ffffbd4b8d2f3d08
>> 2019-09-11 15:41:10     FS: 0000000000000000(0000)
>> GS:ffff9ade3f900000(0000) knlGS:0000000000000000
>> 2019-09-11 15:41:10     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 2019-09-11 15:41:10     CR2: 000055fa10d2bf70 CR3: 00000005a420a002 CR4:
>> 00000000001606e0
>> 2019-09-11 15:41:10     Kernel panic - not syncing: Fatal exception
>> 2019-09-11 15:41:10     Kernel Offset: 0x1a000000 from
>> 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> 2019-09-11 15:41:10     Rebooting in 20 seconds..
>> 2019-09-11 15:41:29     ACPI MEMORY or I/O RESET_REG.
>>
>> Stefan
>> Am 11.09.19 um 08:24 schrieb Stefan Priebe - Profihost AG:
>>> Hi Michal,
>>>
>>> Am 11.09.19 um 08:12 schrieb Stefan Priebe - Profihost AG:
>>>> Hi Michal,
>>>> Am 10.09.19 um 15:24 schrieb Michal Hocko:
>>>>> On Tue 10-09-19 15:14:45, Stefan Priebe - Profihost AG wrote:
>>>>>> Am 10.09.19 um 15:05 schrieb Stefan Priebe - Profihost AG:
>>>>>>>
>>>>>>> Am 10.09.19 um 14:57 schrieb Michal Hocko:
>>>>>>>> On Tue 10-09-19 14:45:37, Stefan Priebe - Profihost AG wrote:
>>>>>>>>> Hello Michal,
>>>>>>>>>
>>>>>>>>> ok this might take a long time. Attached you'll find a graph from a
>>>>>>>>> fresh boot what happens over time (here 17 August to 30 August). Memory
>>>>>>>>> Usage decreases as well as cache but slowly and only over time and days.
>>>>>>>>>
>>>>>>>>> So it might take 2-3 weeks running Kernel 5.3 to see what happens.
>>>>>>>>
>>>>>>>> No problem. Just make sure to collect the requested data from the time
>>>>>>>> you see the actual problem. Btw. you try my very dumb scriplets to get
>>>>>>>> an idea of how much memory gets reclaimed due to THP.
>>>>>>>
>>>>>>> You mean your sed and sort on top of the trace file? No i did not with
>>>>>>> the current 5.3 kernel do you think it will show anything interesting?
>>>>>>> Which line shows me how much memory gets reclaimed due to THP?
>>>>>
>>>>> Please re-read http://lkml.kernel.org/r/20190910082919.GL2063@dhcp22.suse.cz
>>>>> Each command has a commented output. If you see nunmber of reclaimed
>>>>> pages to be large for GFP_TRANSHUGE then you are seeing a similar
>>>>> problem.
>>>>>
>>>>>> Is something like a kernel memory leak possible? Or wouldn't this end up
>>>>>> in having a lot of free memory which doesn't seem usable.
>>>>>
>>>>> I would be really surprised if this was the case.
>>>>>
>>>>>> I also wonder why a reclaim takes place when there is enough memory.
>>>>>
>>>>> This is not clear yet and it might be a bug that has been fixed since
>>>>> 4.18. That's why we need to see whether the same is pattern is happening
>>>>> with 5.3 as well.
>>>
>>> but except from the btrfs problem the memory consumption looks far
>>> better than before.
>>>
>>> Running 4.19.X:
>>> after about 12h cache starts to drop from 30G to 24G
>>>
>>> Running 5.3-rc8:
>>> after about 24h cache is still constant at nearly 30G
>>>
>>> Greets,
>>> Stefan
>>>
