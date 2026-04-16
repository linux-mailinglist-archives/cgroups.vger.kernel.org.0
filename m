Return-Path: <cgroups+bounces-15320-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FoIJ4Y64Gn2dgAAu9opvQ
	(envelope-from <cgroups+bounces-15320-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 03:25:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7E40971A
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FF13057D7A
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541591FBEA6;
	Thu, 16 Apr 2026 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rh8mmNfw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF71F5834
	for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302705; cv=none; b=hZwjz6opzXs0idu7b4Y4oFI+5cj4IQNzkadEk7i5nYokLx9UXF5HLFHeNSP3Zyza8VKsNmAObIxhWO03ed4/Pyim+g8Ul8XCyO3Odl9Dhnna8GiD+3avj9dMRIvb0XHEOAEPAtgRPaMqulm9ZtLQwLRfAF4/G6if88dGtLqvF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302705; c=relaxed/simple;
	bh=Fp1CWQFZhoQan9vy0Uw+XPprLq5wH18fTjKWUBYQg18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb6AA/nzOFUEBySA/aiSWFeG+z457PjwuAiDpudczG0N6A5vk6fPUUeoBNaw6R/l2dwyGi6/9+3kLcGRROgqr0LgyGn8eoLKymPS9BRyNXpjH7uKuUE3/Z1ohO6mrMyyT8xB9nY6/QyuK9Fl5SODhFFUft/FL5CZA9GkkCxgvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rh8mmNfw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d880e6fbbso2000091cf.0
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776302702; x=1776907502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0GVcI8Mcl8O7u/nlxfa5xhicBajYIQOeBkH2STJXfY=;
        b=Rh8mmNfwNmVC7LDtFVtV6tGl0KJDGXyvkyp3IgM12BVmL8xinNHXHP+iqbka0LbMhd
         TtWLEWLNxOkIhOoll4IOY4PdbzlqJmVQsO3qP7IL32YmeGGzgmGgNFDeiaU4BFItjXDb
         yRCO09FxW9nh4Y8xJMzzIYqGAvA/9kYQY7NZ/Gws2T0P7aBwOQjkLI7zMKYXVF+IHH7A
         CMKLFxr9flu2JlHdUcqVMQpzN6Kz9SSBMfPOP+FzLNtzxfvoGsCkz43bFw3SoKRqESaO
         zmB+vTOlepZytLt2h7ifvEf4rZrCe4+e22FDSuju28VbAty9H01gSQL2fLJ6STPUAELp
         EOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776302702; x=1776907502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0GVcI8Mcl8O7u/nlxfa5xhicBajYIQOeBkH2STJXfY=;
        b=r6Pnxf1uIyxOCKrjtxN6v4a7m1432Qy5Zx3grV+HXbdGM1cOqoEJlHKDe/knyHYYA3
         scl6CWRmLCIpxDSywyTzVZeYngqrdi6FwF1mKS/7ZyV2rY3meZ6kpdWg9S0TQGx2GQbe
         1QgYw5dvet/GNGO2LA4UXZoarIL+Mud7vepQyAMuWO1uCUWi1xeMt/CanDiCd2qDOf4T
         gj4nQb16KvL/0GNoOc+CueCZ5yzZDlSDMelmBfFLju1hARLS7BjrC2+rK3LZjZBpbcXj
         wFYN87imumg5gFG1HIZ6PuIjze6cJyWyZEDe9OesyZbPZfWnZkZ5vjdLmfBBTNJkuF/b
         BBDg==
X-Forwarded-Encrypted: i=1; AFNElJ/dh/pmeA7J5VMz6pghcDFE4OL/C5WpQ62K9FCcrgtFwIw64pYs2+Z9lJXq0c0Zad5ZRqX2aAdl@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP1NYd4Y6BSFtP8ltojjK2/m2r+g59dmHYE4zdqMwkCRdvPN9
	SbGcvFMDUpti42PtqpxtaKa28IVoE1mgcbFqwFb/0qaT5KCMu1HIUnCQHyXIZRZyvRI=
X-Gm-Gg: AeBDievG7/16cF0DUqGtoZT83L1Qf0HQ4ygAkVbxulNzO4AEPAUZyY+r5ApLc1Hcjj/
	0y0CKZ4rcj4sMjNE8NzCC/UAOXLFMDnH4tSJcCf2TnFMHZtvdsVLM8u6qvgoQYsq3lZ56MoGWa/
	yOIufT+xtwWLdz1cVPMa56CQJbGnWQHdX6EZwv3zInOXF2lr34W7CwuvL874+M7sPbrZ7LvxnzO
	5BPx0pwdu5I2mxZJQuTKaGjLY+LCiEyijxuNNF16t7z0JcvjeQL7eKvNK39XRIddn35EXfG2RaY
	LUwJEu1ssTH5X4eu/lQjt9QHWYWTIeeU7xGVLO42r2w+OkW2OWWQU7/J4zJivJhXnuljDNnURd8
	fqSVPETA6SXbg07+aqbt8Nkku6Ge4Sev4ffVLaIMpA/wBaSx/u4diyKJxuKpMS7SKOLlGX4GmJZ
	1v2prEO0q1EK6MdQaXiogz9fuzoNVp2RtkWNp2nNDY4FkQp6o5oG9oNHc1lVqPtCvM8UIw8cIVt
	hEMxYIwBPalCpa7BUy361c=
X-Received: by 2002:a05:622a:d1c:b0:509:1b5c:fe25 with SMTP id d75a77b69052e-50e24b8e774mr23717671cf.23.1776302702216;
        Wed, 15 Apr 2026 18:25:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-28-184-130.washdc.fios.verizon.net. [108.28.184.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1adbcf10sm24957831cf.10.2026.04.15.18.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 18:25:00 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:24:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Frank van der Linden <fvdl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aeA6aNDpQ-U5UJCs@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15320-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EB7E40971A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
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
> merge them, but it didn't work out).

I have made this observation as well.  ZONEs in particular are a bit
odd because they're somehow simultaneously too broad and too narrow in
terms of what they control and what they're used for.

1GB ZONE_MOVABLE HugeTLBFS Pages is an example weird carve-out, because
the memory is in ZONE_MOVABLE to help make 1GB allocations more
reliable, but 1GB movable pages were removed from the kernel because
they're not easily migrated (and therefore may block hot-unplug).

(Thankfully they're back now, so VMs can live on this memory :P)

So you have competing requirements, which suggests zone is the wrong
abstraction at some level - but it's what we've got.

> There's also memory with clashing
> properties inhabiting the same data structure: LRUs. Having strictly
> movable memory on the same LRU as unmovable memory is a mismatch. It
> leads to the well known problem of reclaim done in the name of an
> unmovable allocation attempt can be entirely pointless in the face of
> large amounts of ZONE_MOVABLE or MIGRATE_CMA memory: the anon LRU will
> be chock full of movable-only pages. Reclaiming them is useless for
> your allocation, and skipping them leads to locking up the system
> because you're holding on to the LRU lock a long time.
>

This is an interesting observation that should be solvable.

For example - i'm pretty sure mlock'd pages are on an unevictable LRU
for exactly this reason (to just skip scanning them during reclaim).

Which is a different pain point I have - since they're still migratable,
they could be demoted to make room for local hot pages.

> So, looking at having some properties set at the node level makes
> sense to me even in the non-device case. But perhaps that is out of
> scope for the initial discussion.
> 
> One use case that seems like a good match for private nodes is guest
> memory. Guest memory is special enough to want to allocate / maintain
> it separately, which is acknowledged by the introduction of
> guest_memfd.
> 
> I'm interested in enabling guest_memfd allocation from private nodes.
> I've been playing around with setting aside memory at boot, and
> assigning it to private nodes (one private node per physical NUMA
> node), and making it available to guest_memfd only. There are issues
> to be solved there, but the private node abstraction seems to fit
> well, and provides for useful hooks to manage guest memory.
> 

I have wondered about this use case, but I haven't really played with
guest_memfd to know what the implications are here, so it's nice to hear
someone is looking at this.  It will be nice to hear your input on where
the abstraction could be better.

> Some properties that I'm interested in for this use case:
> 
> 1) is the memory in the direct map or not? Should that be configurable
> for a private node? I know there are patches right now to remove
> memory from the direct map for guest_memfd, but what if there was a
> private node whose memory is not in the direct map by default?

Presuming a page was not in the direct map and it was in the buddy
(strong assumption here), there's a handful of things that would
straight up break:

  - init_on_alloc (post_alloc_hook) / __GFP_ZERO (clear_highpage)
  - init_on_free (free_pages_prepare)
  - kernel_poison_pages (accesses the page contents)
  - CONFIG_DEBUG_PAGEALLOC

But... these things seem eminently skippable based on a node attribute.

I think this could be done, but there is added concern about spewing
an ever increasing numbers of hooks throughout mm/ as the number of
attributes increase.

But in this case I think the contract would require that an NP_OPS_NOMAP
would have to be mutually exclusive with all other node attributes (too
many places that touch the mapping, it would be too fragile).

There's a few catches here though

  1) you lose the ability to zero out the page after allocation, so
     whatever is in the memory already is going into the guest.

     That seems problematic for a variety of reasons.

     I guess you can use kmap_local_page?
     But then why not just unmap after allocation?

     If never mapping is a hard requirement, if that memory lives on
     a device with a sanitize function, you maybe could massage kernel
     free-page-reporting to offload the zeroing without having the
     kernel map it - as long as you can take a delay after free before
     the page becomes available again.

  2) the current mempolicy guest_memfd patches would not apply because
     I can't see how OPS_MEMPOLICY & OPS_NOMAP co-exist.  A user program
     could call mbind(nomap_node) on a random VMA - and there would be
     kernel OOPS everywhere.

     That would just mean pre-setting the node backing for all
     guest_memfd VMAs, rather than using mbind().

Something like (cribbing from the memfd code with absolutely no
context, so there's a pile of assumptions being made here)

  struct kvm_create_guest_memfd {
        __u64 size;
        __u64 flags;
        __s32 numa_node;  /* Set at creation */
        __u32 pad;
        __u64 reserved[5];
  };

  #define GUEST_MEMFD_FLAG_NUMA_NODE    (1ULL << 2)

  if (gmem->flags & GUEST_MEMFD_FLAG_NUMA_NODE)
      folio = __folio_alloc(gfp | __GFP_PRIVATE, order,
                            gmem->numa_node, NULL);
  else
      /* existing mempolicy / default path */
      folio = __filemap_get_folio_mpol(...);

Which may even be preferable to the recently upstreamed pattern.

> 2) Default page size. devdax, a ZONE_DEVICE user, allows for memory
> setup on hotplug that initializes things with HVO-ed large pages.
> Could the page size be a property of the node? That would make it easy
> to hand out larger pages to guests.  Of course, if you use anything
> but 4k, the argument of 'we can use the general buddy allocator' goes
> out the window, unless it's made to deal with a per-node base page
> size.
> 

Per-node page sizes are probably a bridge too far, that's seems like
a change that would echo through most of the buddy infrastructure, not
just a few hooks to prevent certain interactions.

However, I also don't think this is a requirement.

I know there is some work to try to raise the max page order to allow
THP to support 1GB huge pages - if max size is a concern, there's hope.

On fragmentation though...

If the consumer of a private node only ever allocates a specific order
(order-9) - the buddy never fragments smaller than that (it maybe
spends time coalescing for no value, but it'll never fragment smaller).

So is the concern here that you want to guarantee a minimum page size
to deal with the fragmentation problem on normal general-purpose nodes,
or do you want to guarantee a minimum page size because you can't limit
the allocations to be of a base order?

i.e.: is limiting guest_memfd allocations on a private node to a single
order (or a minimum order? 2MB?) a feasible option?  (Pretend i know
very little about the guest_memfd specific memory management code).

~Gregory

