Return-Path: <cgroups+bounces-15305-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKKeCPRh32lhSQAAu9opvQ
	(envelope-from <cgroups+bounces-15305-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:01:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 657674030D1
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01890308C81A
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250133DED1;
	Wed, 15 Apr 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyqdXb60"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C932FE056;
	Wed, 15 Apr 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246621; cv=none; b=dG5i/8+58nFlHPFY3k4s/SOWBSIuGYIClS22Q6DwluPJiS8d5gbCPmIplO7PIiT0DnuTtLUDhmQYFEHWsL4NyY1j2mTcCGo1ClGxwLZzianvRiaKdXGwR/Wospm+fgC2puxM0GN85/B8Ujabm/FClm6cUMRL3/lskfLiyU68Lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246621; c=relaxed/simple;
	bh=5v3NaKOyq0xR+0NyWKlmWNXyOfS+BdswnuUB2X7PI5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaCCoh8oNGd/vbU1+Nmw5h4z9KqS+QBxYaRt1a1EqYUC3omTw06+fKR7Q1Dw+qxbv+O6XkKrsNAkzD/wIxGIdX9NI08iPH5USm2pKw1DCn0VTLUPlA2E+8J5DT5LRBXyFFvpXTfp2kA28wza7LDQxOsw50Vwrbl265QCvCQtoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyqdXb60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A888C2BCB5;
	Wed, 15 Apr 2026 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776246621;
	bh=5v3NaKOyq0xR+0NyWKlmWNXyOfS+BdswnuUB2X7PI5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lyqdXb60mQcaPWflD0sQps49MwrzK8gYqfbazHP62hJFPirG3OsDdjhyo095R1pwK
	 LTtglU7XDOsOTqtvy0E0VfkUaDHm53o/uVvoxuDsGM3eer3VAe4zf2JKjtMlPtX/Au
	 W0KuxG6XkEJkbI1HIHdriHbCuppQssFK6BjvS1He5B+thtFMfXJ39tI50x7X7JzRgI
	 BxYbbCt2jul9oZeoSlI1NU/vkbJ9D1PdyV2ftEoW9TnxMSx9m/iAUf/sYCAupqbDsG
	 KRySGcb6ChDFWpVB/glCmi6yWftef9o/6RIlWacPPGIEhGY+L2f5XUSyM/jB+pkfj8
	 3QQFXd1sRkxqg==
Message-ID: <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
Date: Wed, 15 Apr 2026 11:49:59 +0200
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
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-15305-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 657674030D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 19:05, Gregory Price wrote:
> On Mon, Apr 13, 2026 at 03:11:12PM +0200, David Hildenbrand (Arm) wrote:
>>> Normally cloud-hypervisor VMs with virtio-net can't be subject to KSM
>>> because the entire boot region gets marked shared.  
>>
>> What exactly do you mean with "mark shared". Do you mean, that "shared
>> memory" is used in the hypervisor for all boot memory?
>>
> 
> Sorry, meant MAP_SHARED.  But yes, in some setups the hypervisor simply
> makes a memfd with the entire main memory region MAP_SHARED.
> 
> This is because the virtio-net device / network stack does GFP_KERNEL
> allocations and then pins them on the host to allow zero-copy - so all
> of ZONE_NORMAL is a valid target.
> 
> (At least that's my best understanding of the entire setup).

I think with vhost-kernel virtio-net just supports MAP_PRIVATE, KSM and
all of that.

The problem is vhost-user, where the other process needs to access all
of VM's memory. That's not only a problem for virtio-net, but also
virtio-fs and all the other stuff that uses vhost-user.

One idea discussed in the past was to let vhost-user access selected
guest memory through QEMU, so there would be no need to even map all of
guest memory into the other processes.

That in turn would stop requiring MAP_SHARED for most guest RAM, only
focusing it on some key parts. Not sure what happened with that idea.

A related series proposed some  MEM_READ/WRITE backend requests [1]

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.html


Something else people were discussing in the past was to physically
limit the area where virtio queues could be placed.

> 
>>
>> You mean, in the VM, memory usable by virtio-net can only be consumed
>> from a dedicated physical memory region, and that region would be a
>> separate node?
>>
> 
> Correct - it does requires teaching the network stack numa awareness.
> 
> I was surprised by how little code this required, though I can't be
> 100% sure of its correctness since networking isn't my normal space.

One problem might be that VMs with NUMA disabled or reconfigured would
just break. So you cannot run arbitrary guests in there. That was also
one of the problems of "physically limit the area where virtio queues
could be placed", if you have to be prepared to run arbitrary OSes in
your VM (Windows says hi).

> 
> Alternatively you could imagine this as a real device bringing its own
> dedicated networking memory for network buffers, and then telling the
> network start "Hey, prefer this node over normal kernel allocations".
> 
> What I'd been hacking on was cobbled together with memfd + SRAT bits to
> bring up a private node statically and then have the device claim it -
> but this is just a proof of concept.  A proper implementation would be
> extending virtio-net to report a dedicated EFI_RESERVED region.
> 
>>>
>>> I see you saw below that one of the extensions is removing the nodes
>>> from the fallback list.  That is part one, but it's insufficient to
>>> prevent complete leakage (someone might iterate over the nodes-possible
>>> list and try migrating memory).
>>
>> Which code would do that?
>>
> 
> There are many callers of for_each_node() throughout the system.
> 
> but one discrete example:
> 
> int alloc_shrinker_info(struct mem_cgroup *memcg)
> {
> ... snip ...
>   for_each_node(nid) {
>     struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
>                                                GFP_KERNEL, nid);
> ... snip ..
> }
> 
> If you disallow fallbacks in this scenario, this allocation always fails.
> 
> This partially answers your question about slub fallback allocations,
> there are slab allocations like this that depend on fallbacks (more
> below on this explicitly).

But that's a different "fallback" problem, no?

You want allocations that target the "special node" to fallback to
*other* nodes, but not other allocations to fallback to *this special* node.

> 
>>> Basically the only isolation mechanism we have today is ZONE_DEVICE.
>>>
>>> Either via mbind and friends, or even just the driver itself managing it
>>> directly via alloc_pages_node() and exposing some userland interface.
>>
>> Would mbind() work here? I thought mbind() would not suddenly give
>> access to some ZONE_DEVICE memory.
>>
> 
> Sorry these were orthogonal thoughts.
> 
> 1) We don't have such a mechanism. ZONE_DEVICE's preferred mechanism is
>    setting up explicit migrations via migrate_device.c

Makes sense.

> 
> 2) mbind / alloc_pages_node would only work for private nodes.
> 
>    Extending ZONE_DEVICE to enable mbind() would be an extreme lift,
>    as the kernel makes a lot of assumptions about folio->lru.
> 
>    This is why i went the node route in the first place.


Agreed.

> 
>>>
>>> in the NP_OPS_MIGRATION patch, this gets covered.
>>
>> Right, but I am not sure if NP_OPS_MIGRATION is really the right
>> approach for that. Have to think about that.
>>
> 
> So, OPS is a bit misleading, but it's the closest i came to some
> existing pattern.  OPS does not necessarily need to imply callbacks.
> 
> I've been trying to minimize the patch set and I'm starting to think
> the MVP may actually be able to do away with the private_ops structure
> for a basic migration+mempolicy example by simply teaching some services
> (migrate.c, mempolicy.c) how/when to inject __GFP_PRIVATE.
> 
> the mempolicy.c patch already does this, but not migrate.c - i haven't
> figured out the right pattern for that yet.

I assume you will be as LSF/MM? Would be good to discuss some of that in
person.

> 
>>> 1) as you note, removing it from the default bitmaps, which is actually
>>>    hard.  You can't remove it from the possible-node bitmap, so that
>>>    just seemed non-tractable.
>>
>> What about making people use a different set of bitmaps here? Quite some
>> work, but maybe that's the right direction given that we'll now treat
>> some nodes differently.
>>
> 
> It's an option, although it is fragile.  That means having to police all
> future users of possible-nodes and for_each_node and etc.
> 
> I've been err'ing on the side of "not fragile", but i'm open to rework.
> 
>>>
>>> 2) __GFP_THISNODE actually means (among other things) "don't fallback".
>>>    And, in fact, there are some hotplug-time allocations that occur in
>>>    SLAB (pglist_data) that target the private node that *must* fallback
>>>    to successfully allocate for successful kernel operation.
>>
>>
>> Can you point me at the code?
>>
> 
> There is actually a comment in slub.c that addresses this directly:
> 
> static int slab_mem_going_online_callback(int nid)
> {
> ... snip ...
> 	/*
> 	 * XXX: kmem_cache_alloc_node will fallback to other nodes
> 	 *      since memory is not yet available from the node that
> 	 *      is brought up.
> 	 */
> 	n = kmem_cache_alloc(kmem_cache_node, GFP_KERNEL);
> ... snip ...
> }
> 
> Slab basically acknowledges the behavior is required on existing nodes
> and just falls back immediately for the "going online" path.
> 
> Other specific calls in the hotplug path:
> 
>   mm/sparse.c:           kzalloc_node(size, GFP_KERNEL, nid)
>   mm/sparse-vmemmap.c:   alloc_pages_node(nid, GFP_KERNEL|...)
>   mm/slub.c:             kmalloc_node(sizeof(*barn), GFP_KERNEL, nid)
> 
> There are quite a number of callers to kmem_cache_alloc_node() that
> would have to be individually audited.
> 
> And some non-slab interfaces examples as well:
> 	alloc_shrinker_info
> 	alloc_node_nr_active
> 
> I've been looking at this for a while, but I'm starting to think trying
> to touch all this surface area is simply too fragile compared to just
> letting normal memory be a fallback for private nodes and adding:
> 
>       __GFP_PRIVATE   - unlock's private node, but allow fallback
> #define GFP_PRIVATE   (__GFP_PRIVATE | __GFP_THISNODE) - only this node
> 
> __GFP_PRIVATE vs GFP_PRIVATE then is just a matter of use case.
> 
> For mbind() it probably makes sense we'd use GFP_PRIVATE - either it
> succeeds or it OOMs.

Needs a second thought regarding fallback logic I raised above.

What I think would have to be audited is the usage of __GFP_THISNODE by
kernel allocations, where we would not actually want to allocate from
this private node.

Maybe we could just outright refuse *any* non-user (movable) allocations
that target the node, even with __GFP_THISNODE.

Because, why would we want kernel allocations to even end up on a
private node that is supposed to only be consumed by user space? Or
which use cases are there where we would want to place kernel
allocations on there?

Needs a second thought, hoping we can discuss that in person.

> 
>>> The flexibility is kind of the point :]
>>
>> Yeah, but it would be interesting which minimal support we would need to
>> just let some special memory be managed by the kernel, allowing mbind()
>> users to use it, but not have any other fallback allocations end up on it.
>>
>> Something very basic, on which we could build additional functionality.
>>
> 
> I actually have a simplistic CXL driver that does exactly this:
> https://github.com/gourryinverse/linux/blob/072ecf7cbebd9871e76c0b52fd99aa1321405a59/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c#L65
> 

Great.

> We have to support migration because mbind can migrate on bind if the
> VMA already has memory - but all this means is the migrate interfaces
> are live - not that the kernel actually uses them.
> 
> so mbind requires (OPS_MIGRATE | OPS_MEMPOLICY)
> 
> All these flags say is:
>    - move_pages() syscalls can accept these nodes
>    - migrate_pages() function calls can accept these nodes
>    - mempolicy.c nodemasks allow the nodes (should restrict to mbind)
>    - vma's with these nodes now inject __GFP_PRIVATE on fault
> 
> All other services (reclaim, compaction, khugepaged, etc) do not scan
> these nodes and do not know about __GFP_PRIVATE, so they never see
> private node folios and can't allocate from the node.
> 
> In this example, all migrate_to() really does is inject __GFP_THISNODE,
> but I've been thinking about whether we can just do this in migrate.c
> and leave implementing the .ops to a user that requires is.
> 
> But otherwise "it just works".
> 
> One note here though - OOM conditions and allocation failures are not
> intuitive, especially when THP/non-order-0 allocations are involved.
> 
> But that might just mean this minimal setup should only allow order-0
> allocations - which is fiiiiiiiiiiiiiine :P.


Again, I am not sure about compaction and khugepaged. All we want to
guarantee is that our memory does not leave the private node.

That doesn't require any __GFP_PRIVATE magic, just en-lighting these
subsuystems that private nodes must use __GFP_THISNODE and must not leak
to other nodes.

> 
> -----------------
> 
> For basic examples
> 
> I've implemented 4 examples to consider building on:
> 
>   1) CXL mempolicy driver:
>      https://github.com/gourryinverse/linux/blob/072ecf7cbebd9871e76c0b52fd99aa1321405a59/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c#L65
> 
>      As described above
> 
>   2) Virtio-net / CXL.mem Network Card
>      (Not published yet)
> 
>      This doesn't require any ops at all - the plumbing happens entirely
>      inside the kernel.  I onlined the node with an SRAT hack and no ops
>      structure at all associated with the device (just set node affinity
>      to the pcie_dev and plumbed it through the network stack).
> 
>      A proper implementation would have virtio-net register is own
>      reserved memory region and online it during probe.
>   
>   3) Accelerator
>      (Not published yet)
> 
>      I have converted an open source but out of tree GPU driver which
>      uses NUMA nodes to use private nodes.  This required:
>             NP_OPS_MIGRATION
>             NP_OPS_MEMPOLICY
> 
>      The pattern is very similar to the CXL mempolicy driver, except
>      that the driver had alloc_pages_node() calls that needed to have
>      __GFP_PRIVATE added to ensure allocations landed on the device.
> 
> 
>   4) CXL Compressed RAM driver:
>      https://github.com/gourryinverse/linux/blob/55c06eb6bced58132d9001e318f2958e8ac80614/mm/cram.c#L340
>      needs pretty much everything - it's "normal memory" with access
>      rules, so the driver isn't really in the management lifecycle.
> 
>      In this example - the only way to allocate memory on the node is
>      via demotion.  This allows us to close off the device to new
>      allocations if the hardware reports low memory but the OS percieves
>      the device to still have free memory.
> 
>      Which is a cool example:  The driver just sets up the node with
>      certain attributes and then lets the kernel deal with it.
> 
> 
> I have started compacting the _OPS_* flags related to reclaim into a
> single NP_OPS_RECLAIM flag while testing with this.  Really i've come
> around to thinking many mm/ services need to be taken as a package,
> not fully piecemeal.
> 
> The tl;dr: Once you cede some control over to the kernel, you're
> very close to ceding ALL control, but you still get some control
> over how/when allocations on the node can be made.
> 
> 
> It is important to note that even if we don't expose callbacks, we do
> still need a modicum of node filtering in some places that still use
> for_each_node() (vmscan.c, compaction.c, oom_kill.c, etc).
> 
> These are basically all the places ZONE_DEVICE *implicitly* opts itself
> out of by having managed_pages=0.  We have to make those situations
> explicit - but that doesn't mean we need callbacks.
> 
>>>
>>> I would simply state: "That depends on the memory device"
>>
>> Let's keep it very simple: just some memory that you mbind(), and you
>> only want the mbind() user to make use of that memory.
>>
>> What would be the minimal set of hooks to guarantee that.
>>
> 
> If you want the mbind contract to stay intact:
> 
>    NP_OPS_MIGRATION (mbind can generate migrations)
>    NP_OPS_MEMPOLICY (this just tells mempolicy.c to allow the node)

I'm missing why these are even opt-in. What's the problem with allowing
mbind and mempolicy to use these nodes in some of your drivers?

I also have some questions about longterm pinnings, but that's better
discussed in person :)

> 
> The set of callbacks required should be exactly 0 (assuming we teach
> migrate.c to inject __GFP_PRIVATE like we have mempolicy.c).
> 
> If your device requires some special notification on allocation, free
> or migration to/from you need:
> 
>    ops.free_folio(folio)
>    ops.migrate_to(folios, nid, mode, reason, nr_success)
>    ops.migrate_folio(src_folio, dst_folio)
> 
> The free path is the tricky one to get right.  You can imagine:
> 
>    buf = malloc(...);
>    mbind(buf, private_node);
>    memset(buf, 0x42, ...);
>    ioctl(driver, CHECK_OUT_THIS_DATA, buf); 
>    exit(0);
> 
> The task dies and frees the pages back to the buddy - the question is
> whether the 4-5 free_folio paths (put_folio, put_unref_folios, etc) can
> all eat an ops.free_folio() callback to inform the driver the memory has
> been freed.

Right, that's rather invasive.

-- 
Cheers,

David

