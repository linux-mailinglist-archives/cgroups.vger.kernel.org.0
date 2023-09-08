Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9373F798291
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 08:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbjIHGpp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Sep 2023 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbjIHGpn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Sep 2023 02:45:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58A1BDD;
        Thu,  7 Sep 2023 23:45:37 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rhmnx5sZhz4xFD;
        Fri,  8 Sep 2023 16:45:25 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rhmnx1wnCz4xF9;
        Fri,  8 Sep 2023 16:45:25 +1000 (AEST)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        liushixin2@huawei.com
Cc:     open list <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: Kernel crash during ltp(min_free_kbytes) test run
 (zone_reclaimable_pages)
In-Reply-To: <F00144DE-2A3F-4463-8203-45E0D57E313E@linux.ibm.com>
References: <F00144DE-2A3F-4463-8203-45E0D57E313E@linux.ibm.com>
Date:   Fri, 08 Sep 2023 16:45:19 +1000
Message-ID: <878r9hcge8.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sachin Sant <sachinp@linux.ibm.com> writes:
> While running LTP tests (specifically min_free_kbytes) on a Power server
> booted with 6.5.0-next-20230906 following crash was encountered.
>
> [ 3952.404936] __vm_enough_memory: pid: 440285, comm: min_free_kbytes, not enough memory for the allocation
> [ 3956.895519] __vm_enough_memory: pid: 440286, comm: min_free_kbytes, not enough memory for the allocation
> [ 3961.296168] __vm_enough_memory: pid: 440287, comm: min_free_kbytes, not enough memory for the allocation
> [ 3982.202651] Kernel attempted to read user page (28) - exploit attempt? (uid: 0)
> [ 3982.202669] BUG: Kernel NULL pointer dereference on read at 0x00000028
> [ 3982.202674] Faulting instruction address: 0xc000000000469660
> [ 3982.202679] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 3982.202682] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
> [ 3982.202688] Modules linked in: nfsv3 nfs_acl nfs lockd grace fscache netfs brd overlay exfat vfat fat btrfs blake2b_generic xor raid6_pq zstd_compress xfs loop sctp ip6_udp_tunnel udp_tunnel dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding rfkill tls ip_set nf_tables libcrc32c nfnetlink sunrpc pseries_rng vmx_crypto ext4 mbcache jbd2 sd_mod t10_pi crc64_rocksoft crc64 sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: init_module(O)]
> [ 3982.202756] CPU: 18 PID: 440288 Comm: min_free_kbytes Tainted: G O 6.5.0-next-20230906 #1
> [ 3982.202762] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1030.20 (NH1030_058) hv:phyp pSeries
> [ 3982.202767] NIP: c000000000469660 LR: c0000000004694a8 CTR: 0000000000000000
> [ 3982.202771] REGS: c00000001d6af410 TRAP: 0300 Tainted: G O (6.5.0-next-20230906)
> [ 3982.202776] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24402444 XER: 00000000
> [ 3982.202787] CFAR: c0000000004694fc DAR: 0000000000000028 DSISR: 40000000 IRQMASK: 0 
> [ 3982.202787] GPR00: c0000000004696b8 c00000001d6af6b0 c000000001451100 0000000000000080 
> [ 3982.202787] GPR04: 0000000000000080 0000000000000081 0000000000000020 0000000000000000 
> [ 3982.202787] GPR08: 0000000000000080 00000000000048d9 0000000000000000 00000000000014de 
> [ 3982.202787] GPR12: 0000000000008000 c0000013ffab5300 c000000002f27238 c000000002c9d4d8 
> [ 3982.202787] GPR16: 0000000000000000 0000000000000000 c000000006924d40 c000000002d174f8 
> [ 3982.202787] GPR20: c000000002d17500 0000000000000002 60000000000000e0 00000000000008c0 
> [ 3982.202787] GPR24: 0000000000000000 0000000000000000 0000000000000000 c000000002c9a7e8 
> [ 3982.202787] GPR28: c000000002c9be10 c0000013ff1d1500 0000000000000488 0000000000000950 
> [ 3982.202839] NIP [c000000000469660] zone_reclaimable_pages+0x2a0/0x2c0
> [ 3982.202847] LR [c0000000004694a8] zone_reclaimable_pages+0xe8/0x2c0
> [ 3982.202852] Call Trace:
> [ 3982.202854] [c00000001d6af6b0] [5deadbeef0000122] 0x5deadbeef0000122 (unreliable)
> [ 3982.202861] [c00000001d6af710] [c0000000004696b8] allow_direct_reclaim.part.72+0x38/0x190
> [ 3982.202867] [c00000001d6af760] [c000000000469990] throttle_direct_reclaim+0x180/0x400
> [ 3982.202873] [c00000001d6af7e0] [c00000000046de88] try_to_free_pages+0xd8/0x2a0
> [ 3982.202879] [c00000001d6af8a0] [c0000000004e7370] __alloc_pages_slowpath.constprop.92+0x490/0x1000
> [ 3982.202886] [c00000001d6afa50] [c0000000004e822c] __alloc_pages+0x34c/0x3d0
> [ 3982.202893] [c00000001d6afad0] [c0000000004e8ce4] __folio_alloc+0x34/0x90
> [ 3982.202898] [c00000001d6afb00] [c00000000051ba50] vma_alloc_folio+0xe0/0x460
> [ 3982.202905] [c00000001d6afbc0] [c0000000004af108] do_pte_missing+0x2a8/0xca0
> [ 3982.202912] [c00000001d6afc10] [c0000000004b3590] __handle_mm_fault+0x3f0/0x1060
> [ 3982.202917] [c00000001d6afd20] [c0000000004b43c4] handle_mm_fault+0x1c4/0x330
> [ 3982.202923] [c00000001d6afd70] [c000000000092a14] ___do_page_fault+0x2d4/0xaa0
> [ 3982.202930] [c00000001d6afe20] [c0000000000934d0] do_page_fault+0xa0/0x2a0
> [ 3982.202936] [c00000001d6afe50] [c000000000008be0] data_access_common_virt+0x210/0x220
> [ 3982.202943] --- interrupt: 300 at 0x7fffb3cc6360
> [ 3982.202946] NIP: 00007fffb3cc6360 LR: 0000000010005644 CTR: 0000000000001200
> [ 3982.202950] REGS: c00000001d6afe80 TRAP: 0300 Tainted: G O (6.5.0-next-20230906)
> [ 3982.202955] MSR: 800000000200d033 <SF,VEC,EE,PR,ME,IR,DR,RI,LE> CR: 44002444 XER: 00000000
> [ 3982.202966] CFAR: 00007fffb3cc6384 DAR: 00007fea3bc70000 DSISR: 42000000 IRQMASK: 0 
> [ 3982.202966] GPR00: 0000000000002000 00007fffd0497ae0 0000000010057f00 00007fea3bc00000 
> [ 3982.202966] GPR04: 0000000000000001 0000000000100000 00007fea3bc70000 0000000000000000 
> [ 3982.202966] GPR08: 1000000000000000 00007fea3bc00000 0000000000000000 0000000000000000 
> [ 3982.202966] GPR12: 00007fffb3cc62a0 00007fffb410b080 0000000000000000 0000000000000000 
> [ 3982.202966] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 3982.202966] GPR20: 000000001002c260 000000001002c208 cccccccccccccccd a3d70a3d70a3d70b 
> [ 3982.202966] GPR24: 000000001002c2d0 000000001002c238 00007fffb3e01888 000000001002c260 
> [ 3982.202966] GPR28: 0000000000000000 000000001002c1f0 000000001002c218 0000000000000000 
> [ 3982.203016] NIP [00007fffb3cc6360] 0x7fffb3cc6360
> [ 3982.203020] LR [0000000010005644] 0x10005644
> [ 3982.203023] --- interrupt: 300
> [ 3982.203026] Code: eb21ffc8 eb81ffe0 eba1ffe8 ebc1fff0 7fffd214 eb41ffd0 7c0803a6 7fe3fb78 ebe1fff8 4e800020 60000000 60000000 <a12a0028> 3900ffff 7909782c b12a0028 
> [ 3982.203044] ---[ end trace 0000000000000000 ]---
> [ 3982.299095] pstore: backend (nvram) writing error (-1)
> [ 3982.299105] 
> [ 3983.299108] Kernel panic - not syncing: Fatal exception
> [ 3983.564309] Rebooting in 10 seconds..
>
> Git bisect point to the following patch
>
> commit 92039ae85e8d018e82b9ba2597ca22e9851447fe
>     mm: vmscan: try to reclaim swapcache pages if no swap space

Looks to be a direct NULL pointer deref, because
can_reclaim_anon_pages() is passed sc = NULL:


unsigned long zone_reclaimable_pages(struct zone *zone)
{
	unsigned long nr;

	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
                                                            ^^^^

static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
					  int nid,
					  struct scan_control *sc)
{
	if (memcg == NULL) {
		/*
		 * For non-memcg reclaim, is there
		 * space in any swap device?
		 */
		if (get_nr_swap_pages() > 0)
			return true;
		/* Is there any swapcache pages to reclaim? */
		if (total_swapcache_pages() > 0) {
			sc->swapcache_only = 1;

sc is NULL -> oops.

cheers
