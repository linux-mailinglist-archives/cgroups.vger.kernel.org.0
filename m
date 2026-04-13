Return-Path: <cgroups+bounces-15268-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGrAG5jr3GkZYQkAu9opvQ
	(envelope-from <cgroups+bounces-15268-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 15:11:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63C3EC6C3
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86B6C30128D7
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668393CB2EC;
	Mon, 13 Apr 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTu3k7kU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F093CAE93;
	Mon, 13 Apr 2026 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085893; cv=none; b=TGlO/Glc8vCCoZvF7EQsUAmBtacqEN1mkpZJLACS48D4tWkzMt6pQmaCFYX/INkQfKlvkOPdyp8t+DDd2UG0Y/IrAh++lp04aoFlj4BpHGUcgbiTyKhkte+NItHb7VlaKMAO0fuhx8tZnbGr5jaMoMFf/Cc3sviiocFZ3YFf2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085893; c=relaxed/simple;
	bh=7MGZ9oe6YDDqQrwWtten4a0WNnW38UoJ0Vjub40l4lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKzeM0bMfqHIKzjknnVF9VK8A7ouST3OGsXhITdWJO+wapnUWdY88t8MxC3lYfaOuGhUjfcwM3HzdssFUAyu4SYE+35xhPhzOAT+wq99HhBddVJjGsyR+2Qb3BQ0v3YY8/5W+rE7lDvsKspHOTotfDWZZBWOU/WmT139wiUJQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTu3k7kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDABFC2BCAF;
	Mon, 13 Apr 2026 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776085892;
	bh=7MGZ9oe6YDDqQrwWtten4a0WNnW38UoJ0Vjub40l4lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lTu3k7kUc6eRNilLbXFu6HVFqchTI6w0PEnkTKQp8BZO9kLYETy7ixH/8wRcT/DF6
	 LqcFLI8Ke6xPXINS4EiO/iR/gFK9WYIxj5hbnunJRAummOY+Yk7MARZAQvzy4B0fLj
	 dU3pnHG1JISr5QjlsiESGw6cZQ0FRg9Jg0gnT9CFsWJSSNn5UL8PgnSUWv08Q+HyrS
	 WXQwiAjaYq47MkyNplgE0EljEPiktkbyPawHW2AD619JXNyIooGaJ+x+dd7+H5iyc5
	 lA/oMjIS77Rxy3PZj5T2R9Qp16+SHhHTnP3pcGNgsQ/tQT8AixvwNaSV8oOTFrzkKz
	 rRCZZz82E/cwA==
Message-ID: <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
Date: Mon, 13 Apr 2026 15:11:12 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15268-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ED63C3EC6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 16:09, Gregory Price wrote:
> On Tue, Mar 17, 2026 at 02:25:29PM +0100, David Hildenbrand (Arm) wrote:
>> On 2/22/26 09:48, Gregory Price wrote:
>>> Topic type: MM
>>
>> Hi Gregory,
>>
>> stumbling over this again, some questions whereby I'll just ignore the
>> compressed RAM bits for now and focus on use cases where promotion etc
>> are not relevant :)
> 
> A more concrete example up your alley:
> 
> I've since been playing with a virtio-net private node.
> 
> Normally cloud-hypervisor VMs with virtio-net can't be subject to KSM
> because the entire boot region gets marked shared.  

What exactly do you mean with "mark shared". Do you mean, that "shared
memory" is used in the hypervisor for all boot memory?

> If virtio-net has
> its own private node / region separate from the boot region, the boot
> region is now free to be subject to KSM.

You mean, in the VM, memory usable by virtio-net can only be consumed
from a dedicated physical memory region, and that region would be a
separate node?

> 
> I may have that up as an example sometime before LSF, but i need to
> clean up some networking stack hacks i've made to make it work.
> 
>>>
>>> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
>>> explicit holes in that isolation to do useful things we couldn't do
>>> before without re-implementing entire portions of mm/ in a driver.
>>
>> Just to clarify: we don't currently have any mechanism to expose, say,
>> SPM/PMEM/whatsoever to the buddy allocator through the dax/kmem driver
>> and *not* have random allocations end up on it, correct?
>>
>> Assume we online the memory to ZONE_MOVABLE, still other (fallback)
>> allocations might end up on that memory.
>>
> 
> Correct, when you hotplug memory into a node, it's a free for all.
> Fallbacks are going to happen.

Right, and I agree that having a mechanism to prevent that is reasonable.

> 
> I see you saw below that one of the extensions is removing the nodes
> from the fallback list.  That is part one, but it's insufficient to
> prevent complete leakage (someone might iterate over the nodes-possible
> list and try migrating memory).

Which code would do that?

> 
>> How would we currently handle something like that? (do we have drivers
>> for that? I'd assume that drivers would only migrate some user memory to
>> ZONE_DEVICE memory.)
>>
>> Assuming we don't have such a mechanism, I assume that part of your
>> proposal would be very interesting: online the memory to a
>> "special"/"restricted" (you call it private) NUMA node, whereby all
>> memory of that NUMA node will only be consumable through
>> mbind() and friends.
>>
> 
> Basically the only isolation mechanism we have today is ZONE_DEVICE.
> 
> Either via mbind and friends, or even just the driver itself managing it
> directly via alloc_pages_node() and exposing some userland interface.

Would mbind() work here? I thought mbind() would not suddenly give
access to some ZONE_DEVICE memory.

> 
> You can imagine a network driver providing an ioctl for a shared buffer
> or a driver exposing a mmap'able file descriptor as the trivial case.

Right.

> 
>> Any other allocations (including automatic page migration etc) would not
>> end up on that memory.
> 
> One of the complications of exposing this memory via mbind is that
> mempolicy.c has a lot of migration mechanics, just to name two:
> 
>   - migrate on mbind
>   - cpuset rebinds
> 
> So for a completely solution you need to support migration if you
> support mempolicy.  But with the callbacks, you can control how/when
> migration occurs.
> 
> tl;dr: many of mm/'s services are actually predicated on migration
> support, so you have to manage that somehow.

Agreed.

> 
>>
>> Thinking of some "terribly slow" or "terribly fast" memory that we don't
>> want to involve in automatic memory tiering, being able to just let
>> selected workloads consume that memory sounds very helpful.
>>
>>
>> (wondering if there could be some way allocations might get migrated out
>> of the node, for example, during memory offlining etc, which might also
>> not be desirable)
>>
> 
> in the NP_OPS_MIGRATION patch, this gets covered.

Right, but I am not sure if NP_OPS_MIGRATION is really the right
approach for that. Have to think about that.


> 
> I'm not sure the NP_OPS_* pattern is what we actually want, it's just
> what i came up with to make it clear what's being enabled.
> 
> Basically without NP_OPS_MIGRATION, this memory is completely
> non-migratable.  The driver managing it therefore needs to control the
> lifetime, and if hotplug is requested - kill anyone using it (which by
> definition should not the kernel) and either release the pages or take
> them so they can be released while hotplug is spinning.
> 
>> I am not sure if __GFP_PRIVATE etc is really required for that. But some
>> mechanism to make that work seems extremely helpful.
>>
>> Because ...
>>
>>> /* And now I can use mempolicy with my memory */
>>> buf = mmap(...);
>>> mbind(buf, len, mode, private_node, ...);
>>> buf[0] = 0xdeadbeef;  /* Faults onto private node */
>>
>> ... just being able to consume that memory through mbind() and having
>> guarantees sounds extremely helpful.
>>
> 
> Yes! :]
> 
>>>
>>>   - Filter allocation requests on __GFP_PRIVATE
>>>     	numa_zone_allowed() excludes them otherwise. 
>>
>> I think we discussed that in the past, but why can't we find a way that
>> only people requesting __GFP_THISNODE could allocate that memory, for
>> example? I guess we'd have to remove it from all "default NUMA bitmaps"
>> somehow.
>>
> 
> I experimented with this.  There were two concerns:
> 
> 1) as you note, removing it from the default bitmaps, which is actually
>    hard.  You can't remove it from the possible-node bitmap, so that
>    just seemed non-tractable.

What about making people use a different set of bitmaps here? Quite some
work, but maybe that's the right direction given that we'll now treat
some nodes differently.

> 
> 2) __GFP_THISNODE actually means (among other things) "don't fallback".
>    And, in fact, there are some hotplug-time allocations that occur in
>    SLAB (pglist_data) that target the private node that *must* fallback
>    to successfully allocate for successful kernel operation.


Can you point me at the code?

> 
> So separating PRIVATE from THISNODE and allowing some use of fallback
> mechanics resolves some problems here.
> 
> I think #2 is a solvable problem, but #1 i don't think can be addressed.
> I need to investigate the slab interactions a little more.

I'll also have to think about this some more.

> 
>>>   - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
>>>     no struct page metadata limitations.
>>
>> Good.
> 
> Note: I've actually since explored merging this with pgmap, and
> rebranding it as node-scope pgmap.
> 
> In that sense, you could think of this as NODE_DEVICE instead of
> NODE_PRIVATE - but maybe I'm inviting too much baggage :]

:)

NODE_DEVICE sounds interesting though.

> 
>>>
>>> Re-use of ZONE_DEVICE Hooks
>>> ===
>>
>> I think all of that might not be required for the simplistic use case I
>> mentioned above (fast/slow memory only to be consumed by selected user
>> space that opts in through mbind() and friends).
>>
>> Or are there other use cases for these callbacks
>>
> 
> Many `folio_is_zone_device()` hooks result in the operations being
> a no-op / failing.  We need all those same hooks.
> 
> Some hooks I added - such as migration hooks, are combined with the
> zone_device hooks via i helper to demonstrate the pattern is the same
> when the memory is opted into migration.
> 
> I do not think all of these hooks are required, I would think of this
> more as an exploration of the whole space, and then we can throw what
> does not have an active use case.
> 
> For the compressed ram component I've been designing, the needs are:
> 
> - Migration
> - Reclaim
> - Demotion
> - Write Protect (maybe, possibly optional)
> 
> But you could argue another user might want the same device to have:
> - Migration
> - Mempolicy
> 
> Where they manage things from userland, rather than via reclaim.
> 
> The flexibility is kind of the point :]

Yeah, but it would be interesting which minimal support we would need to
just let some special memory be managed by the kernel, allowing mbind()
users to use it, but not have any other fallback allocations end up on it.

Something very basic, on which we could build additional functionality.

> 
>> [...]
>>>
>>>
>>> Flag-gated behavior (NP_OPS_*) controls:
>>> ===
>>>
>>> We use OPS flags to denote what mm/ services we want to allow on our
>>> private node.   I've plumbed these through so far:
>>>
>>>   NP_OPS_MIGRATION       - Node supports migration
>>>   NP_OPS_MEMPOLICY       - Node supports mempolicy actions
>>>   NP_OPS_DEMOTION        - Node appears in demotion target lists
>>>   NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
>>>   NP_OPS_RECLAIM         - Node supports reclaim
>>>   NP_OPS_NUMA_BALANCING  - Node supports numa balancing
>>>   NP_OPS_COMPACTION      - Node supports compaction
>>>   NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
>>>   NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
>>>                            as normal system ram storage, so it should
>>> 			   be considered in OOM pressure calculations.
>>
>> I have to think about all that, and whether that would be required as a
>> first step. I'd assume in a simplistic use case mentioned above we might
>> only forbid the memory to be used as a fallback for any oom etc.
>>
>> Whether reclaim (e.g., swapout) makes sense is a good question.
>>
> 
> I would simply state: "That depends on the memory device"

Let's keep it very simple: just some memory that you mbind(), and you
only want the mbind() user to make use of that memory.

What would be the minimal set of hooks to guarantee that.

For example, I assume compaction could just be supported for such
memory? Similarly, longterm-pinning.

For some of the other hooks it's rather unclear how they would affect
the very simple mbind() rule. What is the effect of demotion or NUMA
balancing?

I'm afraid we're making things too complicated here or it might be the
wrong abstraction, if i cannot even figure out how to make the simplest
use case work.

Maybe I'm wrong :)

> 
> Which is kind of the point.  The ability to isolate and poke holes in
> that isolation explictly, while using the same mm/ code, creates a new
> design space we haven't had before.
> 
> ---
> 
> I think it would be fair to say all of these would not be required for
> an MVP interface, and should require a use case to merge.  But the code
> is here because I wanted to explore just how far it can go.

That's absolutely fair. :)

-- 
Cheers,

David

