Return-Path: <cgroups+bounces-14914-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA4wI4kSvGnbrwIAu9opvQ
	(envelope-from <cgroups+bounces-14914-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 16:13:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE32CD7F1
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85B403008D25
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27A28726E;
	Thu, 19 Mar 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C0vpH9SW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0802D63E5
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932994; cv=none; b=Dr/H2T2e8My+YRq3etcZZZ0/MaHrb4YzH1dyaiJQxY3nlryiZgq0hutKrYaeWASkqhSeJJgHFaR+gQIMYOFtRaZ8R5/6qgtvOQbcNrcuFyGlf2TWcHVzVieF3JZDK11pmBExLcnpodLLsKLPbwEyJOhyTVIBTE7NnIzzcJWSZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932994; c=relaxed/simple;
	bh=w8KECUgZU784nrWzd9pPxP9fep5qk5sRDHZVbyBswlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVZR920/apassDAEMIGzjjxynsO2S6b+jK29t3fJzm9hnCm7iCZsFu5XLZAnhsHZuO68dmlbRUmhZvRqDG/rCsH61n9MoiOi9gJDwFUNIY7BcmCb4KYvX2186oNxkrqfyHarl8Tj+aawtlimwoeMwtKD4+kEFvG+3e94O39WT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C0vpH9SW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c9f6b78ca4so142769585a.0
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773932992; x=1774537792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fU4+lilPbMb3EqzTb9SzQ9ED33oth0C4b6/QPTs5sDk=;
        b=C0vpH9SWmg5mkRuxx2OAekhkBqFlLanK4Nd7TSYqcgTGuQP/sMD4LM2fTlQeb0OQ9Z
         FVi2G/wIfj0c0mSvqQaHHcJvBoA86gX8moWmnp/uDfgcKsV0mDlednBv646JMGvm6rlM
         ouwMyUbHspaqnmrkmHtMy8HxLxAv6sKUJYYXj4Ra4XL1MZZzcohL6hYd1Ym3CYFueBYN
         UgLico9fpfA3E7okO2q5kil682LZkhpbOKPFLCo4nD1N1bN4uZoQ81puEv+yjHMWvgYH
         Lfv6MFloaUUE7bmyWv/hjRrNk0NiCmCuHL3MfZKPCF6iFD3iJGgWlR1rkQqra+VINZoh
         0z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932992; x=1774537792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU4+lilPbMb3EqzTb9SzQ9ED33oth0C4b6/QPTs5sDk=;
        b=bKVQJkGysDeGevYTnpaimOkGRB90k+qmjHYaBcL5qZcfGtKsT7zwCGeaaUtlyPci4i
         gne/KS/wDlLPHcukjccg6LgLSOgUD07QVdem+mDupKpDBnerpCbrIImaLSAFL2LKViHS
         WafLhJ86ewjhuo/2E1DAxNvXCjsYGOb2ieLGRVzQvhFJlTjHR70t3lYM1vhH6UF7LufZ
         1eXcfz/2K6OkpHcWr0dk5/JqRnfN+LAk7uVhhlVHGcym1wREYNaAh4epjqOZVbVoYzLT
         zFtDj3Os3shMb87V8P6lAVNZkzj87o3JfKJIc9ZvoP3X/nugAn1aAI6wXVbCcCyAOfwS
         984Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZzU5au0qs+1UJgLJ1qGEr3GpX1SzGdYftCt+De1yunnVr3Ts2U7flH8VA94mnfRxf/z+SC4m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjtl3PR2V7IT8EWO5vRytfcnFmMdbISnvgIRgpH80EINWBeDuQ
	ZRgtCDBNmPeGw+V+gre+CMDxBtzf1JxKWZ6DPASrQIu7b5NJ41jG5ZebEXamyfWdDLw=
X-Gm-Gg: ATEYQzwP9jgvtCZVFYPJoqc8pp+WgYq93JuJUXnyUnh+y0FmBFwSrhjj7OxG7e4RoGV
	0c5N098Rt/o+OhtGovkcPc0g3EGkFtnGYHKBYjYUJ3v/wXg4zkQfa40fS4izWEtpQn7i/hTnphS
	aLAuOePSVHi+pQalZAYS7g4ceBibyyg899F4TDM8HHizPql45lqyvQbhI/SeqGfmCfMDw6ZkEPR
	c7VPgwmGAgEYtYPhtBeAqGXAh6f+kURTqKtAPTudORrJXX0Q7jUsbc2Y7HHYzGbBfRtfA1JtocV
	MxjITKPi8PLCtslrwQ6BPQ0zuFFYNOD15Hn22+uzoCxI3SsI+nTU3SkZ7wLOdq1FqLcqbvYajQU
	SVTdkhEQWSqDqGXUmS/yMAu4p12qk7GWdKvRFN9Xp7p9jlITqdaN2BMvZALEeSIKOWd7F4lqnHk
	b0nSm0EyfONWYaTUFyzA+dFNZLZwIPjSaxYrR1XyWotcojqjSz/sjxQwfOiY5lpXEojEd2IyaiS
	A8t3WF0zA==
X-Received: by 2002:a05:620a:4050:b0:8cd:af31:b421 with SMTP id af79cd13be357-8cfad2c5236mr1047066785a.34.1773932991754;
        Thu, 19 Mar 2026 08:09:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad1b1154sm524775785a.35.2026.03.19.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:09:51 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:09:47 -0400
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
Message-ID: <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-14914-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.958];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FBE32CD7F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 02:25:29PM +0100, David Hildenbrand (Arm) wrote:
> On 2/22/26 09:48, Gregory Price wrote:
> > Topic type: MM
> 
> Hi Gregory,
> 
> stumbling over this again, some questions whereby I'll just ignore the
> compressed RAM bits for now and focus on use cases where promotion etc
> are not relevant :)

A more concrete example up your alley:

I've since been playing with a virtio-net private node.

Normally cloud-hypervisor VMs with virtio-net can't be subject to KSM
because the entire boot region gets marked shared.  If virtio-net has
its own private node / region separate from the boot region, the boot
region is now free to be subject to KSM.

I may have that up as an example sometime before LSF, but i need to
clean up some networking stack hacks i've made to make it work.

> > 
> > N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> > explicit holes in that isolation to do useful things we couldn't do
> > before without re-implementing entire portions of mm/ in a driver.
> 
> Just to clarify: we don't currently have any mechanism to expose, say,
> SPM/PMEM/whatsoever to the buddy allocator through the dax/kmem driver
> and *not* have random allocations end up on it, correct?
>
> Assume we online the memory to ZONE_MOVABLE, still other (fallback)
> allocations might end up on that memory.
> 

Correct, when you hotplug memory into a node, it's a free for all.
Fallbacks are going to happen.

I see you saw below that one of the extensions is removing the nodes
from the fallback list.  That is part one, but it's insufficient to
prevent complete leakage (someone might iterate over the nodes-possible
list and try migrating memory).

> How would we currently handle something like that? (do we have drivers
> for that? I'd assume that drivers would only migrate some user memory to
> ZONE_DEVICE memory.)
> 
> Assuming we don't have such a mechanism, I assume that part of your
> proposal would be very interesting: online the memory to a
> "special"/"restricted" (you call it private) NUMA node, whereby all
> memory of that NUMA node will only be consumable through
> mbind() and friends.
> 

Basically the only isolation mechanism we have today is ZONE_DEVICE.

Either via mbind and friends, or even just the driver itself managing it
directly via alloc_pages_node() and exposing some userland interface.

You can imagine a network driver providing an ioctl for a shared buffer
or a driver exposing a mmap'able file descriptor as the trivial case.

> Any other allocations (including automatic page migration etc) would not
> end up on that memory.

One of the complications of exposing this memory via mbind is that
mempolicy.c has a lot of migration mechanics, just to name two:

  - migrate on mbind
  - cpuset rebinds

So for a completely solution you need to support migration if you
support mempolicy.  But with the callbacks, you can control how/when
migration occurs.

tl;dr: many of mm/'s services are actually predicated on migration
support, so you have to manage that somehow.

> 
> Thinking of some "terribly slow" or "terribly fast" memory that we don't
> want to involve in automatic memory tiering, being able to just let
> selected workloads consume that memory sounds very helpful.
> 
> 
> (wondering if there could be some way allocations might get migrated out
> of the node, for example, during memory offlining etc, which might also
> not be desirable)
> 

in the NP_OPS_MIGRATION patch, this gets covered.

I'm not sure the NP_OPS_* pattern is what we actually want, it's just
what i came up with to make it clear what's being enabled.

Basically without NP_OPS_MIGRATION, this memory is completely
non-migratable.  The driver managing it therefore needs to control the
lifetime, and if hotplug is requested - kill anyone using it (which by
definition should not the kernel) and either release the pages or take
them so they can be released while hotplug is spinning.

> I am not sure if __GFP_PRIVATE etc is really required for that. But some
> mechanism to make that work seems extremely helpful.
> 
> Because ...
> 
> > /* And now I can use mempolicy with my memory */
> > buf = mmap(...);
> > mbind(buf, len, mode, private_node, ...);
> > buf[0] = 0xdeadbeef;  /* Faults onto private node */
> 
> ... just being able to consume that memory through mbind() and having
> guarantees sounds extremely helpful.
> 

Yes! :]

> > 
> >   - Filter allocation requests on __GFP_PRIVATE
> >     	numa_zone_allowed() excludes them otherwise. 
> 
> I think we discussed that in the past, but why can't we find a way that
> only people requesting __GFP_THISNODE could allocate that memory, for
> example? I guess we'd have to remove it from all "default NUMA bitmaps"
> somehow.
>

I experimented with this.  There were two concerns:

1) as you note, removing it from the default bitmaps, which is actually
   hard.  You can't remove it from the possible-node bitmap, so that
   just seemed non-tractable.

2) __GFP_THISNODE actually means (among other things) "don't fallback".
   And, in fact, there are some hotplug-time allocations that occur in
   SLAB (pglist_data) that target the private node that *must* fallback
   to successfully allocate for successful kernel operation.

So separating PRIVATE from THISNODE and allowing some use of fallback
mechanics resolves some problems here.

I think #2 is a solvable problem, but #1 i don't think can be addressed.
I need to investigate the slab interactions a little more.

> >   - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
> >     no struct page metadata limitations.
> 
> Good.

Note: I've actually since explored merging this with pgmap, and
rebranding it as node-scope pgmap.

In that sense, you could think of this as NODE_DEVICE instead of
NODE_PRIVATE - but maybe I'm inviting too much baggage :]

> > 
> > Re-use of ZONE_DEVICE Hooks
> > ===
> 
> I think all of that might not be required for the simplistic use case I
> mentioned above (fast/slow memory only to be consumed by selected user
> space that opts in through mbind() and friends).
> 
> Or are there other use cases for these callbacks
> 

Many `folio_is_zone_device()` hooks result in the operations being
a no-op / failing.  We need all those same hooks.

Some hooks I added - such as migration hooks, are combined with the
zone_device hooks via i helper to demonstrate the pattern is the same
when the memory is opted into migration.

I do not think all of these hooks are required, I would think of this
more as an exploration of the whole space, and then we can throw what
does not have an active use case.

For the compressed ram component I've been designing, the needs are:

- Migration
- Reclaim
- Demotion
- Write Protect (maybe, possibly optional)

But you could argue another user might want the same device to have:
- Migration
- Mempolicy

Where they manage things from userland, rather than via reclaim.

The flexibility is kind of the point :]

> [...]
> > 
> > 
> > Flag-gated behavior (NP_OPS_*) controls:
> > ===
> > 
> > We use OPS flags to denote what mm/ services we want to allow on our
> > private node.   I've plumbed these through so far:
> > 
> >   NP_OPS_MIGRATION       - Node supports migration
> >   NP_OPS_MEMPOLICY       - Node supports mempolicy actions
> >   NP_OPS_DEMOTION        - Node appears in demotion target lists
> >   NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
> >   NP_OPS_RECLAIM         - Node supports reclaim
> >   NP_OPS_NUMA_BALANCING  - Node supports numa balancing
> >   NP_OPS_COMPACTION      - Node supports compaction
> >   NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
> >   NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
> >                            as normal system ram storage, so it should
> > 			   be considered in OOM pressure calculations.
> 
> I have to think about all that, and whether that would be required as a
> first step. I'd assume in a simplistic use case mentioned above we might
> only forbid the memory to be used as a fallback for any oom etc.
> 
> Whether reclaim (e.g., swapout) makes sense is a good question.
> 

I would simply state: "That depends on the memory device"

Which is kind of the point.  The ability to isolate and poke holes in
that isolation explictly, while using the same mm/ code, creates a new
design space we haven't had before.

---

I think it would be fair to say all of these would not be required for
an MVP interface, and should require a use case to merge.  But the code
is here because I wanted to explore just how far it can go.

In fact, I believe I have gotten to the point where I could add:

  NP_OPS_FALLBACK_NODE  - re-add the node to the fallback list
                          do not require __GFP_PRIVATE for allocation

Which would require all of the other bits to be turned on.

The result of this is essentially a numa node with otherwise normal
memory, but for which a driver gets callbacks on certain operations
(migration, free, etc).  That ALSO seems useful.

It's... an interesting result of the whole exploration.

~Gregory

