Return-Path: <cgroups+bounces-10731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86DBD9AE8
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65BBE4E1B36
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FCF3161B8;
	Tue, 14 Oct 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RnVJgjVA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDE31619B
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448005; cv=none; b=nTCri/WMIGG71S0YowE53aNWyAh+kUF7a8RFeyg8Jp85Vg02J7JA/Ym/n6macZ2sTX97a3Pj4f9+xYQU/h4636Xt1m4x4ly88v17pt8Jta/946EkIu4WSd8PCz5mSPgHMf3OrKv3K7u02TZFpDEr3hTotxKesaAOUUUanRTnWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448005; c=relaxed/simple;
	bh=Wim9o18MKObwnzJcT2quzHlf2IzqkHTysWZ4YPTqIKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5QLdXMJZLosbXGhDTj6u/fciDs3WUltGRLdhpgvM79UUdZl1lE987+8Y57434r4oXk8BJdV5xowvAnoQpNtM5vRK8zLcFSfgAb3YaFyILDw9AICJKtmdi4cBq5MyjKY7v06XN/ylM+HSlrlhrTaJbNZtUbRBnT2UMROG1LXjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RnVJgjVA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8507df5e-0170-4316-b732-9ebb11bab4e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760447991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JE+Kn2HjCSTg/qS1EjXYbWfpt2UDhrJQ2s6zULpht+4=;
	b=RnVJgjVA3Fn7aQ0zhP00Tom2evqdyeKrpAcE/pTudMQPYc9RoBK4RHqzpY37mrC+w67AXk
	rn+BogiWQxs/UF4rw+OzxNCZa7SxN+d61b1bH2QzsoenKDMi+MPeBe+LucJomb0095Mh3A
	PY2NfGRNCUii2yRKYTml87SztdkZ9Ns=
Date: Tue, 14 Oct 2025 21:18:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slab: Introduce __SECOND_OBJEXT_FLAG for objext_flags
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20251014093124.300012-1-hao.ge@linux.dev>
 <aO4loolcE5u2gSM0@hyeyoo> <b48a0656-3c68-494a-8e90-54247888bccf@suse.cz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <b48a0656-3c68-494a-8e90-54247888bccf@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2025/10/14 20:49, Vlastimil Babka wrote:
> On 10/14/25 12:27, Harry Yoo wrote:
>> On Tue, Oct 14, 2025 at 05:31:24PM +0800, Hao Ge wrote:
>>> From: Hao Ge <gehao@kylinos.cn>
>>>
>>> We should not reuse the first bit for OBJEXTS_ALLOC_FAIL.
>>> This is because the following scenarios may be encountered:
>>>
>>> Under heavy system load, certain sequences of events can trigger the
>> Hi Hao, thanks for catching it!
>>
>> It's late at night and my brain is tired so I may be missing something,
>> but let me leave comment anyway...
>>
>>> VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio) check:
>> Should we check (folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
>> (folio->memcg_data & MEMCG_DATA_OBJEXTS) instead then?
> Yes, we already went that direction, but seems we need to expand to more
> places due to 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL"):
>
> https://lore.kernel.org/all/20250915200918.3855580-2-surenb@google.com/
>> Not clearing a valid folio->memcg_data is considered an error, but freeing a
>> folio that is marked OBJEXTS_ALLOC_FAIL isn't.
>>
>>> 1. High system pressure may cause objext allocation failure for a slab.
>>> 2. When objext allocation fails, slab->obj_exts is set to
>>>     OBJEXTS_ALLOC_FAIL (value 1).
>>> 3. Later, this slab may enter the release process.
>>> 4. During release of the associated folio, the existing
>>>     VM_BUG_ON_FOLIO check validates folio->memcg_data.
>>>     If the MEMCG_DATA_OBJEXTS bit is unexpectedly
>>>     set here, the bug check gets triggered.
>>>
>>> We have obtained the following logs:
>>> [ 7108.343437] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0002deb97600 pfn:0x31eb96
>>> [ 7108.343482] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> [ 7108.343500] memcg:1
>>> [ 7108.343507] flags: 0x17ffff800000040(head|node=0|zone=2|lastcpupid=0xfffff)
>>> [ 7108.343523] raw: 017ffff800000040 ffff0000c000cac0 dead000000000100 0000000000000000
>>> [ 7108.343528] raw: ffff0002deb97600 0000000000240000 00000000ffffffff 0000000000000001
>>> [ 7108.343534] head: 017ffff800000040 ffff0000c000cac0 dead000000000100 0000000000000000
>>> [ 7108.343539] head: ffff0002deb97600 0000000000240000 00000000ffffffff 0000000000000001
>>> [ 7108.343562] head: 017ffff800000001 fffffdffcb7ae581 00000000ffffffff 00000000ffffffff
>>> [ 7108.343569] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
>>> [ 7108.343574] page dumped because: VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS)
>>> [ 7108.343601] ------------[ cut here ]------------
>>> [ 7108.343607] kernel BUG at ./include/linux/memcontrol.h:537!
>>> [ 7108.343617] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>>> [ 7108.345751] Modules linked in: squashfs isofs vhost_vsock vhost_net vmw_vsock_virtio_transport_common vfio_iommu_type1 vhost vfio vsock vhost_iotlb iommufd tap binfmt_misc nfsv3 nfs_acl nfs lockd grace netfs tls rds dns_resolver tun brd overlay ntfs3 exfat btrfs blake2b_generic xor xor_neon raid6_pq loop sctp ip6_udp_tunnel udp_tunnel nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables rfkill ip_set sunrpc vfat fat joydev sg sch_fq_codel nfnetlink virtio_gpu drm_client_lib virtio_dma_buf drm_shmem_helper sr_mod drm_kms_helper cdrom drm ghash_ce virtio_net virtio_scsi backlight virtio_console virtio_blk net_failover failover virtio_mmio dm_mirror dm_region_hash dm_log dm_multipath dm_mod fuse i2c_dev virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring autofs4 aes_neon_bs aes_ce_blk [last unloaded: hwpoison_inject]
>>> [ 7108.355662] CPU: 7 UID: 0 PID: 4470 Comm: kylin-process-m Kdump: loaded Not tainted 6.18.0-rc1-dirty #54 PREEMPT(voluntary)
>>> [ 7108.356864] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>> [ 7108.357621] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [ 7108.358981] pc : __free_frozen_pages+0xf18/0x18e8
>>> [ 7108.359834] lr : __free_frozen_pages+0xf18/0x18e8
>>> [ 7108.360379] sp : ffff8000a2bb7580
>>> [ 7108.360786] x29: ffff8000a2bb7580 x28: fffffdffcb7ae580 x27: fffffdffcb7ae580
>>> [ 7108.362013] x26: fffffdffcb7ae588 x25: 1fffffbff96f5cb1 x24: 1fffffbff96f5cb0
>>> [ 7108.362804] x23: ffff8000839d6ba0 x22: ffff8000839d6000 x21: 0000000000000000
>>> [ 7108.363596] x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
>>> [ 7108.364393] x17: 445f47434d454d20 x16: 2620617461645f67 x15: 636d656d3e2d6f69
>>> [ 7108.365498] x14: 6c6f66284f494c4f x13: 0000000000000001 x12: ffff600063fece93
>>> [ 7108.366317] x11: 1fffe00063fece92 x10: ffff600063fece92 x9 : dfff800000000000
>>> [ 7108.367610] x8 : 00009fff9c01316e x7 : ffff00031ff67493 x6 : 0000000000000001
>>> [ 7108.368455] x5 : ffff00031ff67490 x4 : ffff600063fece93 x3 : 0000000000000000
>>> [ 7108.369276] x2 : 0000000000000000 x1 : ffff000103fe5d40 x0 : 000000000000004c
>>> [ 7108.370140] Call trace:
>>> [ 7108.370463]  __free_frozen_pages+0xf18/0x18e8 (P)
>>> [ 7108.371011]  free_frozen_pages+0x1c/0x30
>>> [ 7108.372040]  __free_slab+0xd0/0x250
>>> [ 7108.372471]  free_slab+0x38/0x118
>>> [ 7108.372882]  free_to_partial_list+0x1d4/0x340
>>> [ 7108.373813]  __slab_free+0x24c/0x348
>>> [ 7108.374253]  ___cache_free+0xf0/0x110
>>> [ 7108.374699]  qlist_free_all+0x78/0x130
>>> [ 7108.375156]  kasan_quarantine_reduce+0x114/0x148
>>> [ 7108.375695]  __kasan_slab_alloc+0x7c/0xb0
>>> [ 7108.376668]  kmem_cache_alloc_noprof+0x164/0x5c8
>>> [ 7108.377206]  __alloc_object+0x44/0x1f8
>>> [ 7108.377659]  __create_object+0x34/0xc8
>>> [ 7108.378196]  kmemleak_alloc+0xb8/0xd8
>>> [ 7108.378644]  kmem_cache_alloc_noprof+0x368/0x5c8
>>> [ 7108.379224]  getname_flags.part.0+0xa4/0x610
>>> [ 7108.379733]  getname_flags+0x80/0xd8
>>> [ 7108.380169]  do_sys_openat2+0xb4/0x178
>>> [ 7108.380921]  __arm64_sys_openat+0x134/0x1d0
>>> [ 7108.381952]  invoke_syscall+0xd4/0x258
>>> [ 7108.382408]  el0_svc_common.constprop.0+0xb4/0x240
>>> [ 7108.382965]  do_el0_svc+0x48/0x68
>>> [ 7108.383375]  el0_svc+0x40/0xe0
>>> [ 7108.383757]  el0t_64_sync_handler+0xa0/0xe8
>>> [ 7108.384465]  el0t_64_sync+0x1ac/0x1b0
>>> [ 7108.385284] Code: 91398021 aa1b03e0 91138021 97fd35e3 (d4210000)
>>> [ 7108.386553] SMP: stopping secondary CPUs
>>> [ 7108.389714] Starting crashdump kernel...
>>> [ 7108.390190] Bye!
>>>
>>> So, introduce __SECOND_OBJEXT_FLAG for objext_flags, adjust
>>> the corresponding order accordingly, and ensure that OBJEXTS_ALLOC_FAIL
>>> is no longer reused.
>>>
>>> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>> Hmm using a new bit was suggested at that time, but that would
>> require bumping up the alignment when allocating slabobj_ext array?
>> (see alloc_slab_obj_exts())

Hi Vlastimil and Harry

Now I understand the alignment you're referring to, and indeed, my 
solution does require bumping up the

alignment when allocating the slabobj_ext array.

And syzbot ci has reported a bug:

https://lore.kernel.org/all/68ee41cb.050a0220.91a22.020b.GAE@google.com/

This is because the data of slabobj_ext has been corrupted.


>> And we can still distinguish two cases where
>>
>> 1) MEMCG_DATA_OBJEXTS is set, but upper bits are not set,
>>     so it should mean obj_exts allocation failed (OBJEXTS_ALLOC_FAIL),
>>     thus do not report error, or
>>
>> 2) MEMCG_DATA_OBJEXTS is set, and upper bits are also set, so someone
>>     did not clear a valid folio->memcg_data before freeing the folio
>>     (report error).
>>
>> without introducing a new bit, right?
> Agreed.

Okay, now I understand what you mean. I will send out the V2 version soon.

Thank you for your guidance.


Thanks

Best Regards

Hao

>
>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>> ---
>>>   include/linux/memcontrol.h | 16 ++++++----------
>>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index 873e510d6f8d..8ea023944fac 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -341,27 +341,23 @@ enum page_memcg_data_flags {
>>>   	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
>>>   };
>>>   
>>> -#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
>>>   #define __FIRST_OBJEXT_FLAG	__NR_MEMCG_DATA_FLAGS
>>> +#define __SECOND_OBJEXT_FLAG    (__FIRST_OBJEXT_FLAG << 1)
>>>   
>>>   #else /* CONFIG_MEMCG */
>>>   
>>> -#define __OBJEXTS_ALLOC_FAIL	(1UL << 0)
>>>   #define __FIRST_OBJEXT_FLAG	(1UL << 0)
>>> +#define __SECOND_OBJEXT_FLAG	(1UL << 0)
>>>   
>>>   #endif /* CONFIG_MEMCG */
>>>   
>>>   enum objext_flags {
>>> -	/*
>>> -	 * Use bit 0 with zero other bits to signal that slabobj_ext vector
>>> -	 * failed to allocate. The same bit 0 with valid upper bits means
>>> -	 * MEMCG_DATA_OBJEXTS.
>>> -	 */
>>> -	OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
>>> +	/* slabobj_ext vector failed to allocate */
>>> +	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
>>>   	/* slabobj_ext vector allocated with kmalloc_nolock() */
>>> -	OBJEXTS_NOSPIN_ALLOC = __FIRST_OBJEXT_FLAG,
>>> +	OBJEXTS_NOSPIN_ALLOC = __SECOND_OBJEXT_FLAG,
>>>   	/* the next bit after the last actual flag */
>>> -	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
>>> +	__NR_OBJEXTS_FLAGS  = (__SECOND_OBJEXT_FLAG << 1),
>>>   };
>>>   
>>>   #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
>>> -- 
>>> 2.25.1
>>>

