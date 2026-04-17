Return-Path: <cgroups+bounces-15343-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGucCSQD4mna0QAAu9opvQ
	(envelope-from <cgroups+bounces-15343-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 11:53:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B83419A03
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 11:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D933221234
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C423B8BC7;
	Fri, 17 Apr 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9ShCoZ6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5C3AE6EB;
	Fri, 17 Apr 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418796; cv=none; b=Zp9nbsNbiWR1bLGBynp54HiPs18bwueoaZvJCSTe26JwIXpRcHV/4kz281UcLpeBHMxIZlOmwEiKOCnUOl9d3rIIOST4Lb4PnkW/fnLg+BYnr8rHUXhfJZWTIZ61zypwgHgGKrqUb2lc9oboYap5/MZ/L4b+1iC82vQeVXNOJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418796; c=relaxed/simple;
	bh=ZlBEZsBcLmBVD873um0dOpJ+0/Uzp3232ROvFxfCaWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puUaQMHrQAGxLHjVpxEiSVrWt8mEoWjX4SRAEY6qmnm79McTIThJMnRqLZppRcNeKb9O+YENHPb8AnQPxIupW87SvtNVx8pbfvBus5FHvhdp49qIGnVv5T+KekUpnubXFyFPU/tWXVa/EtmLoIdxVHj4HMf9YVgX3qHro7TxlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9ShCoZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542ABC2BCB3;
	Fri, 17 Apr 2026 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776418796;
	bh=ZlBEZsBcLmBVD873um0dOpJ+0/Uzp3232ROvFxfCaWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e9ShCoZ6JNibZsrNsC//t2gDqjYgg5hm2N0x84g9LxqyQw/rZ9JR3wvPtoh44ZML7
	 8uvsSO8uGWh23k6ycBNnml5MfkL0jBKuO9kObHmWs0cYJERFdAqhjLCT4z511c1gkq
	 E+N39tRFMvW0R7eInWo7PN5O05f1e8aA3FXBHj3tXz5yYBn3dXoAchOpIqZ+fjD9Is
	 Nybu+WOxx+O9VFdjOmceuvJIZ2NcHCaHEbq9/gEHW2dK5MZ6kFvxtevLIsE0aJVu/a
	 4z7t7TM1J8E9rRTH56g3mF8IJdt8pmIrkOdRPt6sTAGg/+52N0GoaKwlX0HVQqP+Mz
	 zORBWgjCVWQ6g==
Message-ID: <3d077c4c-6abe-47f6-a4df-3e853fbcc551@kernel.org>
Date: Fri, 17 Apr 2026 11:39:33 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Frank van der Linden <fvdl@google.com>, Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 muchun.song@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 jannh@google.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 pfalcato@suse.de, rientjes@google.com, shakeel.butt@linux.dev,
 riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org,
 roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 zhengqi.arch@bytedance.com, terry.bowman@amd.com
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-15343-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email]
X-Rspamd-Queue-Id: 93B83419A03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 21:47, Frank van der Linden wrote:
> On Wed, Apr 15, 2026 at 8:18 AM Gregory Price <gourry@gourry.net> wrote:
>>
>> On Wed, Apr 15, 2026 at 11:49:59AM +0200, David Hildenbrand (Arm) wrote:
>>
>> As a preface - the current RFC was informed by ZONE_DEVICE patterns.
>>
>> I think that was useful as a way to find existing friction points - but
>> ultimately wrong for this new interface.
>>
>> I don't thinks an ops struct here is the right design, and I think there
>> are only a few patterns that actually make sense for device memory using
>> nodes this way.
>>
>> So there's going to be a *major* contraction in the complexity of this
>> patch series (hopefully I'll have something next week), and much of what
>> you point out below is already in-flight.
>>
>>>
>> ... snip ...
>>>
>>> A related series proposed some  MEM_READ/WRITE backend requests [1]
>>>
>>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.html
>>>
>>
>> Oh interesting, thank you for the reference here.
>>
>>>
>>> Something else people were discussing in the past was to physically
>>> limit the area where virtio queues could be placed.
>>>
>>
>> That is functionally what I did - the idea was pretty simple, just have
>> a separate memfd/node dedicated for the queues:
>>
>> guest_memory = memfd(MAP_PRIVATE)
>> net_memory = memfd(MAP_SHARED)
>>
>> And boom, you get what you want.
>>
>> So yeah "It works" - but there's likely other ways to do this too, and
>> as you note re: compatibility, i'm not sure virtio actually wants this,
>> but it's a nice proof-of-concept for a network device on the host that
>> carries its own memory.
>>
>> I'll try post my hack as an example with the next RFC version, as I
>> think it's informative.
>>
>>>
>>> But that's a different "fallback" problem, no?
>>>
>>> You want allocations that target the "special node" to fallback to
>>> *other* nodes, but not other allocations to fallback to *this special* node.
>>>
>> ... snip - slight reordering to put thoughts together ...
>>>
>>> Needs a second thought regarding fallback logic I raised above.
>>>
>>> What I think would have to be audited is the usage of __GFP_THISNODE by
>>> kernel allocations, where we would not actually want to allocate from
>>> this private node.
>>>
>>
>> This is fair, and I a re-visit is absolutely warranted.
>>
>> Re-examining the quick audit from my last response suggests - I should
>> never have seen leakage in those cases, but the fallbacks are needed.
>>
>> So yes, this all requires a second look (and a third, and a ninth).
>>
>> I'm not married to __GFP_PRIVATE, but it has been reliable for me.
>>
>>> Maybe we could just outright refuse *any* non-user (movable) allocations
>>> that target the node, even with __GFP_THISNODE.
>>>
>>> Because, why would we want kernel allocations to even end up on a
>>> private node that is supposed to only be consumed by user space? Or
>>> which use cases are there where we would want to place kernel
>>> allocations on there?
>>>
>>
>> As a start, maybe? But as a permanent invariant?  I would wonder whether
>> the decision here would lock us into a design.
>>
>> But then - this is all kernel internal, so i think it would be feasible
>> to change this out from under users without backward compatibility pain.
>>
>> So far I have done my best to avoid changing any userland interfaces in
>> a way that would fundamentally change the contracts.  If anything
>> private-node other than just the node's `has_memory_private` attribute
>> leaks into userland, someone messed up.
>>
>> So... I think that's reasonable.
>>
>>>
>>> I assume you will be as LSF/MM? Would be good to discuss some of that in
>>> person.
>>>
>>
>> Yes, looking forward to it :]
>>
>>
>>>
>>>
>>> Again, I am not sure about compaction and khugepaged. All we want to
>>> guarantee is that our memory does not leave the private node.
>>>
>>> That doesn't require any __GFP_PRIVATE magic, just en-lighting these
>>> subsystems that private nodes must use __GFP_THISNODE and must not leak
>>> to other nodes.
>>
>> This is where specific use-cases matter.
>>
>> In the compressed memory example - the device doesn't care about memory
>> leaving - but it cares about memory arriving and *and being modified*.
>> (more on this in your next question)
>>
>> So i'm not convinced *all possible devices* would always want to support
>> move_pages(), mbind(), and set_mempolicy().
>>
>> But, I do want to give this serious thought, and I agree the absolute
>> minimal patch set could just be the fallback control mechanism and
>> mm/ component filters/audit on __GFP_*.
>>
>>
>>>
>>> I'm missing why these are even opt-in. What's the problem with allowing
>>> mbind and mempolicy to use these nodes in some of your drivers?
>>>
>>
>> First:
>>
>> In my latest working branch these two flags have been folded into just
>> _OPS_MEMPOLICY and any other migration interaction is just handled by
>> filtering with the GFP flag.
>>
>>
>> on always allowing mbind and mempolicy vs opt-in
>> ---
>>
>> A proper compressed memory solution should not allow mbind/mempolicy.
>>
>> Compressed memory is different from normal memory - as the kernel can
>> percieves free memory (many unused struct page in the buddy) when the
>> device knows there's none left (the physical capacity is actually full).
>>
>> Any form of write to a compressed memory device is essentially a
>> dangerous condition (OOMs = poison, not oom_kill()).
>>
>> So you need two controls:  Allocation and (userland) Write protection
>> I implemented via:
>>     - Demotion-only (allocations only happen in reclaim path)
>>     - Write-protecting the entire node
>>
>> (I fully accept that a write-protection extension here might be a bridge
>>  to far, but please stick with me for the sake of exploration).
>>
>>
>> There's a serious argument to limit these devices to using an mbind
>> pattern, but I wanted to make a full-on attempt to integrate this device
>> into the demotion path as a transparent tier (kinda like zswap).
>>
>> I could not square write-protection with mempolicy, so i had to make
>> them both optional and mutually exclusive.
>>
>> If you limit the device to mbind interactions, you do limit what can
>> crash - but this forces userland software to be less portable by design:
>>
>>   - am i running on a system where this device is present?
>>   - is that device exposing its memory on a node?
>>   - which node?
>>   - what memory can i put on that node? (can you prevent a process from
>>     putting libc on that node?)
>>   - how much compression ratio is left on the device?
>>   - can i safety write to this virtual address?
>>   - should i write-protect compressed VMAs? Can i handle those faults?
>>   - many more
>>
>> That sounds a lot like re-implementing a bunch of mm/ in userland, and
>> that's exactly where we were at with DAX.  We know this pattern failed.
>>
>> I'm trying to very much avoid repeating these mistakes, and so I'm very
>> much trying to find a good path forward here that results in transparent
>> usage of this memory.
>>
>>
>>> I also have some questions about longterm pinnings, but that's better
>>> discussed in person :)
>>>
>>
>> The longterm pin extention came from auditing existing zone_device
>> filters.
>>
>> tl;dr: informative mechanism - but it probably should be dropped,
>> it makes no sense (it's device memory, pinnings mean nothing?).
>>
>>
>>>
>>> Right, that's rather invasive.
>>>
>>
>> Yeah i'm trying to avoid it, and the answer may actually just exist in
>> the task-death and VMA cleanup path rather than the folio-free path.
>>
>> From what i've seen of accelerator drivers that implement this, when you
>> inform the driver of a memory region with a task, the driver should have
>> a mechanism to take references on that VMA (or something like this) - so
>> that when the task dies the driver has a way to be notified of the VMA
>> being cleaned up.
>>
>> This probably exists - I just haven't gotten there yet.
>>
>> ~Gregory
> 
> This has been a really great discussion. I just wanted to add a few
> points that I think I have mentioned in other forums, but not here.
> 
> In essence, this is a discussion about memory properties and the level
> at which they should be dealt with. Right now there are basically 3
> levels: pageblocks, zones and nodes. While these levels exist for good
> reasons, they also sometimes lead to issues. There's duplication of
> functionality. MIGRATE_CMA and ZONE_MOVABLE both implement the same
> basic property, but at different levels (attempts have been made to
> merge them, but it didn't work out). There's also memory with clashing
> properties inhabiting the same data structure: LRUs. Having strictly
> movable memory on the same LRU as unmovable memory is a mismatch. It
> leads to the well known problem of reclaim done in the name of an
> unmovable allocation attempt can be entirely pointless in the face of
> large amounts of ZONE_MOVABLE or MIGRATE_CMA memory: the anon LRU will
> be chock full of movable-only pages. Reclaiming them is useless for
> your allocation, and skipping them leads to locking up the system
> because you're holding on to the LRU lock a long time.
> 
> So, looking at having some properties set at the node level makes
> sense to me even in the non-device case. But perhaps that is out of
> scope for the initial discussion.
> 
> One use case that seems like a good match for private nodes is guest
> memory. Guest memory is special enough to want to allocate / maintain
> it separately, which is acknowledged by the introduction of
> guest_memfd.

Yes. There is now an interface to configure mbind() for guest_memfd. So
with that and some tweaks, maybe that ... would just work, if we get the
mbind() interaction right?

-- 
Cheers,

David

