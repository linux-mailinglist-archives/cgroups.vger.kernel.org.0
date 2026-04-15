Return-Path: <cgroups+bounces-15316-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAUUFy2s32mOXgAAu9opvQ
	(envelope-from <cgroups+bounces-15316-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 17:18:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1807405CA0
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A272E300DF7D
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D821FF2A;
	Wed, 15 Apr 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Indn20+N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A73BB9EB
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266279; cv=none; b=uay4aaEHWaObIXDNr5UrtHbnsUbV3tkBS28lZsNtCx+nhGKigFCOdux8RecoT6T3vfW+b7LombehGO2Uk8+V1HxJ6f+oDpwbovDmVlRx0QPl0wx5XIYRTDvbiNZnUWmvPQmsPemEbdxB2269hCRTy4ecMrR53lMUvSU6ibPRX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266279; c=relaxed/simple;
	bh=uXC0m6A4XXgR4T+Bi/9ek7eOATVzudkV/e23KeHP81s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrfagSD7fRzlcqu8q36+nfDcSAfGNbP/2BM/LCNTqX7aiaevIRNJabKjRGsk3Dg0psW0G6Xr+5K6IECBc7wEamGAU8TmJPr/cGd50GWLyP0oudBWbdkyCNsvPgGqwCHH94RkEHdWL1sZ0iSmVQrYM0GoecO6wN1DuYC6viL8Vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Indn20+N; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d6d5e45c43so832054485a.3
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776266277; x=1776871077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dowXUfQQOnu7UlbiaKZmPHb5cgghiRsZLFzOWNbiThQ=;
        b=Indn20+NP4ix2jcgkf3SSA5a7LlGoArUrrcm8zf7J1bi/Trd2NU8/BSZ85mOvTK2O5
         vzYQMZzWXYaLTRA+rcax2H5MiZGvW8iFAH5spEBLL4g/Q1S1d149eaTlUfgv3cam8DhX
         UluXJRg4/7PfFCLzkeRV4xa4cq0IQwqNtO9DiUp3JOXDrBfIMz4uthw1m2UWv5laXdMu
         tArMvpo0mZ3/xl2cJLPw0/ra+2RKQYNG+x8dBPvxTAy7vFCasYTvjbIAFDFehETZzYtl
         not1/sICdOF9lo+UWNtoAbZE1SZDaaVAJxIIAPCrgbHUXepVr/2UzTUHQpBKHqhLAZGB
         yVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266277; x=1776871077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dowXUfQQOnu7UlbiaKZmPHb5cgghiRsZLFzOWNbiThQ=;
        b=DJ+qrMks5d+5h7D8+dLdR8lWYim+TWhy5E190YAs9M9pCov8DfdMiNFkna5x+NhgwF
         lHig3jFDy4AAD7AqCZLbwLcaB3+0a3nbutLHWvbIW7gGokhWQw9CznO10iMWYaMkADsk
         6IZsP05huq2fAS/+kjNJ7VG+DHb5+TNVv64VI/jrxwmhuJDKCjIMLJ2daXSa1IyG87Id
         As/EUddLudTTxdyy8X43bKEBPkRypxUQ7ybNdBZv82g0IrLUCzHrtB9I4s/Lwgzifi4E
         sKVGIw83lvS3C3wMiSZDDc7GW2a7OMhLE6jHALdaVCL9C7/9SspW5FW5w6suXCrVwyLP
         737g==
X-Forwarded-Encrypted: i=1; AFNElJ8JcrVWxa0JMydix6u0jVvq5Wm4EIHRtEFZKXq3eS7NWSTC6Y+B5gFz3kl8+3UA+bILde4AZ157@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZRLiXJb7JNHTP4UxnlRfVonKx9vxFrKS2/GhclRPqugJi4jd
	Zg+OLVrI2h78etbQtjAlPVTck/BVTAHAUBsJva4Dmf2WeyiHefrcRbI7uWQqvZNaplU=
X-Gm-Gg: AeBDietkkcTGCp+xH7vggEaBlItvm5NkHUMWwWWidWhb8GSFrjJpLk4HOuIin+kKovC
	dedJAvI57re4kp1XAAyc8+lmgCgwGvEwB1ZK3/yPJ8XBSXfYvHVYfRyXl2Gfh+z3BSKKzCFAQ9/
	rd+EZ8cZpRWTzlEe3jZhCsIbqB2jTPGCOZK1IY9sv6IGaN0OkOFDUv/nFI9OpvNOfrNmpjnzR8x
	aTyybee0JXgs0XG2qNuW4C7eNbw4BB+2ttf1hUedUFChZTrBZ2Vz2Bqkzrjidzo6mwraU1PloH5
	Z9QOWhBjxKjenREOlY30XuVhgzXRjpWBv7p4RTNAO6aP641SWYad3e2ek3ydkk/DqlomaE4CeyS
	nq9ayR/oQA6PQew276XMXAEVW87eCXwh6SUhIkCCERcVux1KWj59WbEzQ4zcz2XAfeCRnzbNGgy
	phgR8TpNzfCLma8c/XX9BPjkzZ71cBVTDMdhZTZvZdjYWa+dGy
X-Received: by 2002:a05:620a:450e:b0:8ca:2e36:18b0 with SMTP id af79cd13be357-8ddcf1b8f1amr3209217385a.39.1776266276487;
        Wed, 15 Apr 2026 08:17:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea03:4042:f7e3:e9e9:9e22:5a8e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f243a20csm136694985a.23.2026.04.15.08.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:17:55 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:17:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15316-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nongnu.org:url,gourry.net:dkim]
X-Rspamd-Queue-Id: E1807405CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:49:59AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 19:05, Gregory Price wrote:

As a preface - the current RFC was informed by ZONE_DEVICE patterns.

I think that was useful as a way to find existing friction points - but
ultimately wrong for this new interface.

I don't thinks an ops struct here is the right design, and I think there
are only a few patterns that actually make sense for device memory using
nodes this way.

So there's going to be a *major* contraction in the complexity of this
patch series (hopefully I'll have something next week), and much of what
you point out below is already in-flight.

> > On Mon, Apr 13, 2026 at 03:11:12PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > This is because the virtio-net device / network stack does GFP_KERNEL
> > allocations and then pins them on the host to allow zero-copy - so all
> > of ZONE_NORMAL is a valid target.
> > 
> > (At least that's my best understanding of the entire setup).
> 
... snip ...
> 
> A related series proposed some  MEM_READ/WRITE backend requests [1]
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.html
> 

Oh interesting, thank you for the reference here.

> 
> Something else people were discussing in the past was to physically
> limit the area where virtio queues could be placed.
>

That is functionally what I did - the idea was pretty simple, just have
a separate memfd/node dedicated for the queues:

guest_memory = memfd(MAP_PRIVATE)
net_memory = memfd(MAP_SHARED)

And boom, you get what you want.

So yeah "It works" - but there's likely other ways to do this too, and
as you note re: compatibility, i'm not sure virtio actually wants this,
but it's a nice proof-of-concept for a network device on the host that
carries its own memory.

I'll try post my hack as an example with the next RFC version, as I
think it's informative.

> > 
> > This partially answers your question about slub fallback allocations,
> > there are slab allocations like this that depend on fallbacks (more
> > below on this explicitly).
> 
> But that's a different "fallback" problem, no?
> 
> You want allocations that target the "special node" to fallback to
> *other* nodes, but not other allocations to fallback to *this special* node.
>
... snip - slight reordering to put thoughts together ...
> > 
> > __GFP_PRIVATE vs GFP_PRIVATE then is just a matter of use case.
> > 
> > For mbind() it probably makes sense we'd use GFP_PRIVATE - either it
> > succeeds or it OOMs.
> 
> Needs a second thought regarding fallback logic I raised above.
> 
> What I think would have to be audited is the usage of __GFP_THISNODE by
> kernel allocations, where we would not actually want to allocate from
> this private node.
> 

This is fair, and I a re-visit is absolutely warranted.

Re-examining the quick audit from my last response suggests - I should
never have seen leakage in those cases, but the fallbacks are needed.

So yes, this all requires a second look (and a third, and a ninth).

I'm not married to __GFP_PRIVATE, but it has been reliable for me.

> Maybe we could just outright refuse *any* non-user (movable) allocations
> that target the node, even with __GFP_THISNODE.
> 
> Because, why would we want kernel allocations to even end up on a
> private node that is supposed to only be consumed by user space? Or
> which use cases are there where we would want to place kernel
> allocations on there?
> 

As a start, maybe? But as a permanent invariant?  I would wonder whether
the decision here would lock us into a design.

But then - this is all kernel internal, so i think it would be feasible
to change this out from under users without backward compatibility pain.

So far I have done my best to avoid changing any userland interfaces in
a way that would fundamentally change the contracts.  If anything
private-node other than just the node's `has_memory_private` attribute
leaks into userland, someone messed up.

So... I think that's reasonable.

> 
> I assume you will be as LSF/MM? Would be good to discuss some of that in
> person.
>

Yes, looking forward to it :]


> > One note here though - OOM conditions and allocation failures are not
> > intuitive, especially when THP/non-order-0 allocations are involved.
> > 
> > But that might just mean this minimal setup should only allow order-0
> > allocations - which is fiiiiiiiiiiiiiine :P.
> 
> 
> Again, I am not sure about compaction and khugepaged. All we want to
> guarantee is that our memory does not leave the private node.
> 
> That doesn't require any __GFP_PRIVATE magic, just en-lighting these
> subsystems that private nodes must use __GFP_THISNODE and must not leak
> to other nodes.

This is where specific use-cases matter.

In the compressed memory example - the device doesn't care about memory
leaving - but it cares about memory arriving and *and being modified*.
(more on this in your next question)

So i'm not convinced *all possible devices* would always want to support
move_pages(), mbind(), and set_mempolicy().

But, I do want to give this serious thought, and I agree the absolute
minimal patch set could just be the fallback control mechanism and 
mm/ component filters/audit on __GFP_*.


> > If you want the mbind contract to stay intact:
> > 
> >    NP_OPS_MIGRATION (mbind can generate migrations)
> >    NP_OPS_MEMPOLICY (this just tells mempolicy.c to allow the node)
> 
> I'm missing why these are even opt-in. What's the problem with allowing
> mbind and mempolicy to use these nodes in some of your drivers?
> 

First:

In my latest working branch these two flags have been folded into just
_OPS_MEMPOLICY and any other migration interaction is just handled by
filtering with the GFP flag. 


on always allowing mbind and mempolicy vs opt-in
---

A proper compressed memory solution should not allow mbind/mempolicy.

Compressed memory is different from normal memory - as the kernel can
percieves free memory (many unused struct page in the buddy) when the
device knows there's none left (the physical capacity is actually full).

Any form of write to a compressed memory device is essentially a
dangerous condition (OOMs = poison, not oom_kill()).

So you need two controls:  Allocation and (userland) Write protection
I implemented via:
    - Demotion-only (allocations only happen in reclaim path)
    - Write-protecting the entire node

(I fully accept that a write-protection extension here might be a bridge
 to far, but please stick with me for the sake of exploration).


There's a serious argument to limit these devices to using an mbind
pattern, but I wanted to make a full-on attempt to integrate this device
into the demotion path as a transparent tier (kinda like zswap).

I could not square write-protection with mempolicy, so i had to make
them both optional and mutually exclusive.

If you limit the device to mbind interactions, you do limit what can
crash - but this forces userland software to be less portable by design:

  - am i running on a system where this device is present?
  - is that device exposing its memory on a node?
  - which node?
  - what memory can i put on that node? (can you prevent a process from
    putting libc on that node?)
  - how much compression ratio is left on the device?
  - can i safety write to this virtual address?
  - should i write-protect compressed VMAs? Can i handle those faults?
  - many more

That sounds a lot like re-implementing a bunch of mm/ in userland, and
that's exactly where we were at with DAX.  We know this pattern failed.

I'm trying to very much avoid repeating these mistakes, and so I'm very
much trying to find a good path forward here that results in transparent
usage of this memory.


> I also have some questions about longterm pinnings, but that's better
> discussed in person :)
>

The longterm pin extention came from auditing existing zone_device
filters.  

tl;dr: informative mechanism - but it probably should be dropped,
it makes no sense (it's device memory, pinnings mean nothing?).


> > 
> > The task dies and frees the pages back to the buddy - the question is
> > whether the 4-5 free_folio paths (put_folio, put_unref_folios, etc) can
> > all eat an ops.free_folio() callback to inform the driver the memory has
> > been freed.
> 
> Right, that's rather invasive.
> 

Yeah i'm trying to avoid it, and the answer may actually just exist in
the task-death and VMA cleanup path rather than the folio-free path.

From what i've seen of accelerator drivers that implement this, when you
inform the driver of a memory region with a task, the driver should have
a mechanism to take references on that VMA (or something like this) - so
that when the task dies the driver has a way to be notified of the VMA
being cleaned up.

This probably exists - I just haven't gotten there yet.

~Gregory

