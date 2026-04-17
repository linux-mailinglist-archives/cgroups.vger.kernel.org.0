Return-Path: <cgroups+bounces-15346-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HeaFnNI4mlh4AAAu9opvQ
	(envelope-from <cgroups+bounces-15346-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 16:49:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EE41C383
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3201130297A5
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C73B8BCF;
	Fri, 17 Apr 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LFMvbAhk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D473B9D89
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437159; cv=none; b=HQQx9Ojl2eyY947PdazEDdyyaQcxviDevztpAZZpHolVVwCxjUT2iYLtt5XJj9UNoof2AJlLdCER1NBmUAn2iXPuz+Lb37NqfbyYQwe9HbKkbpHGAB7fuU+Ct8XT+PK52BDyjwo+xlIBjJELVAoL3DoH477x0z1zyyXA4LvCAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437159; c=relaxed/simple;
	bh=UNrb3fspU9BdkXegwdmwqukr2NvwEt0LLiivOVSbqvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpID1MRWqeC5AyRGgJ/6ia7z6L52+bD/N+84BCESa6BLUlQtmP8M+Os2gOcpS8+X8l0uoKy1HBnd32pbLBck3FVbrhoUSMzyWq/k0+6E4MFZX/4KrPI8lawJ4ird33PaixFzeH0K4VlxpobuadlCzTZgqkaw8JC/Ye4lz9uKckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LFMvbAhk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50335b926c2so6219961cf.2
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776437157; x=1777041957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jkzv2KvncmaDlTxMf9kep+UrjgSD3pdlFDgixpHVA0=;
        b=LFMvbAhkQucFdmfedNUtfb8qvWQ7VnK58a7nArceqK/1C0On7wFdqMfppjGPDfSbwD
         eP7ceaWSbGp9tVxj2KyC1OGt+0zLfdWYlCgsuXs7Wgnd4TMWQ8Z+wKxA9HcJrmI52UCE
         ofesP6jeG7tpRSCfFKz3WcpZddvAUa4m9CIAClDKphsbxYpqCD/Z4jDNW1NXKU/O0Tnc
         FpIWR1ACgc9tXR9vvtXTyA/PM1Hx3LsbNA4lNFX+MRjh+hWDIuij3leDSSrcjCz5cak2
         +L1162DjOMNIUdXbuzKYHJiEylXL3t+ULpyxhanC7CmyibQ3f0/LQQybUZ2GFxL3mMZz
         hTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776437157; x=1777041957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Jkzv2KvncmaDlTxMf9kep+UrjgSD3pdlFDgixpHVA0=;
        b=eyvm6/ehHqnuV6LYLsOD99yD8rd9JP6OsA0QZ4P+MlZAh6Nlf+kdeQZpH3goS1oeGa
         Ma5q55u3lB4wkwRLIKVCgnyJunqJ5Fn7g/hRFNAzBo4V9bZ0v++fqYvhG/B0o0dt/b0P
         UIUu2e5ZYpLx41uPvCwMRdFhWRkq6R4VmDr65rUAuRV2dhx5xaEUd9+rCU83Nu6h1x+B
         b8V9Wbzi9GfJc9B7u/6nnJjKRt0FCFKG+DCH+IkR6hmQrFhQ/PnBjDh1wN/N7OSsPL13
         rvB21y7f259ttoFpa18wDtSj7Q9AxEUJgeFHgI5C9lVbVuhPW6/j9skAV/RdGKlwvpJX
         m47w==
X-Forwarded-Encrypted: i=1; AFNElJ9130EY0PcxuTLXTpogHCtMDvIknaVGJjFcFCqMZjIt9NS3b0x/kYd3VDOGN2+4rTWzknfyqcwU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Kn9fL8r8hOg7V8AH7LTzLAP3H93TKx0x41+QINcOa/d8gp9i
	vd7XTjmiv2DNZhB4+WEMSvz33ADuYvJ1SFCU4J8IX4pvP+gMKkdOXl4hQ8SCMJGyOuE=
X-Gm-Gg: AeBDietOSpZNsY8HgI6CKIOomlF8OQnolsmlWTliIKHZza3hleoER1DPbN96M7N5h+a
	C/EtuQfG+riiq5tgNzT4NTZFGzSamoAp14JE8ga5sO4EaAqXlHsVWVjy5he7K/9QhdIRyclupuu
	Q3yZrvGJ75sww60TZVjjIIdNrT7v+BOI7liz37rpBhOSBCtzJDCPYZgX88wRAjivnmUeD52BPCG
	FCR30TiqeUsWAj7yNIbrVBOUpEKsV9984zdHFh2v7sAerIwQmkfyi8/ed84bHwzAYguEHRUy9up
	2CmYrnIXEqpT/AixjoMPo/6uRUajgjjqyu2Q35v7wG8Bhpz86avc9exTi2zsPreipRrBGiyGovZ
	pva42Yl8ctBJ7Mdry/7UofhF+hr3UqD9ACobqT8xVE7Wu7U9OOFySNItYEKk5+5VzgDwB6L8PTc
	ltek3y0oXcrEeEFtpu5KgeZTCToYMOkDLgpcTLB9F0+KRYSZsqPoDt6rP5tXVY1fgI9oEoZ0ca+
	Dyl3lYR6PTgPxgIHBzM
X-Received: by 2002:a05:622a:15d3:b0:50d:b1fc:c7cf with SMTP id d75a77b69052e-50e36ebc865mr44534921cf.39.1776437156692;
        Fri, 17 Apr 2026 07:45:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ffe6fsm13613881cf.16.2026.04.17.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:45:55 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:45:45 -0400
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
Message-ID: <aeJHmSpGYBafAgWC@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15346-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE5EE41C383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 11:37:36AM +0200, David Hildenbrand (Arm) wrote:
> > 
> > I'm not married to __GFP_PRIVATE, but it has been reliable for me.
> 
> Yes, we should carefully describe which semantics we want to achieve, to
> then figure out how we could achieve them.
>

Yeah, __GFP_THISNODE does seem similar enough at first look - but its
semantic is actually backwards from the problem we're trying to solve.

__GFP_THISNODE says:  Don't fall back   (restrict access)
__GFP_PRIVATE says:   Enable Allocation (allow access)

But I think there is merit in asking the question whether the problem
is a GFP flag or the current node iterations thoughout the system.

My concern is essentially some driver doing something like:

   for node in possible_nodes:
       alloc_pages_node(..., node, __GFP_THISNODE);

Which, while silly looking, its not hard to imagine such a pattern
accidentally creeping into code in a less obvious form.

I'll take some time to chew on it - maybe the answer is private nodes
should not be in the default node iteration macros either.

I had briefly considered this, but had moved on when I figured out
removing these nodes from the fallback lists.

> >> Again, I am not sure about compaction and khugepaged. All we want to
> >> guarantee is that our memory does not leave the private node.
> >>
> >> That doesn't require any __GFP_PRIVATE magic, just en-lighting these
> >> subsystems that private nodes must use __GFP_THISNODE and must not leak
> >> to other nodes.
> > 
> > This is where specific use-cases matter.
> > 
> > In the compressed memory example - the device doesn't care about memory
> > leaving - but it cares about memory arriving and *and being modified*.
> > (more on this in your next question)
> 
> Right, but naive me would say that that's a memory allocation problem,
> right?
> 

Allocation is only 1 part of the problem - the second is modification.

Putting aside that I don't think this memory should be mempolicy
enabled for the moment - the problem is best described in code:

    /* We have a 512MB compressed memory region */
    buf = malloc(1GB);
    mbind(buf, compressed_node); 

    /* Nothing is faulted yet - our first chance to catch OOM */
    memset(buf, 0x42, 1GB);  /* Allocation - compressed nicely */

    /* Pages are now faulted and have R/W PTEs */
    memcpy(buf, uncompressible, 1GB); 

    /* There is a bear chasing you now, run fast. */


There is nothing an operating system can do to slow down the writer in
this scenario - the memory is faulted and mapped R/W in the page tables.

Another way to think about this is that modification is basically a
"Re-allocation" on the device with the CPU and OS removed from the loop.

So you need both allocation control (private node, dmeotion only) and
modification control (PTE write-protection) to make this reliable.

> khugepaged() wants to allocate a 2M page to collapse. Goes to the buddy
> to allocate it.
> 
> Buddy has to say no if the device cannot support it.
> 
> So there are free pages but we just don't want to hand them out.
>

On the allocation side - I think we can borrow from kernel free page
reporting and/or ballooning to control this aspect.

But on the khugepaged observation... hmm

If we regularly scanned the compressed node, we could soft-protect them
similar to the way numa balancing sets prot_none.

Combined with the node being demotion-only, this might be sufficient
unless you're riding the line pretty hard.

If a write-protect node attribute is a bridge too far, this might be
the best we can do.

Hmmmm. As usual, you have given me something very interesting to chew on
- thank you David.

> > 
> > tl;dr: informative mechanism - but it probably should be dropped,
> > it makes no sense (it's device memory, pinnings mean nothing?).
> 
> What I was thinking: We still have different zone options for this memory.
> 
> Expose memory to ZONE_MOVABLE -> no longterm pinning allowed.
> 
> Expose memory to ZONE_NORMAL -> longterm pinning allowed.
>

Yeah I have this in my pile of notes somewhere and it just fell out of
my context window.

This is actually a nice example of how isolation is better dealt with at
the node level, while ZONE suddenly becomes just another attribute bit.

In my response to Alistair, I pointed out that zones almost become
meaningless on a private node (almost).

If you have a private node in ZONE_NORMAL, and your services are in full
control of how the allocations occur and what code touches them - you
can still (in theory) guarantee the unpluggability of that memory with
proper startup/teardown of the service.

So what's the use in ZONE_MOVABLE existing for a private node? :]

> > 
> > Yeah i'm trying to avoid it, and the answer may actually just exist in
> > the task-death and VMA cleanup path rather than the folio-free path.
> > 
> > From what i've seen of accelerator drivers that implement this, when you
> > inform the driver of a memory region with a task, the driver should have
> > a mechanism to take references on that VMA (or something like this) - so
> > that when the task dies the driver has a way to be notified of the VMA
> > being cleaned up.
> > 
> > This probably exists - I just haven't gotten there yet.
> 
> That sounds reasonable. Alternatively, maybe the buddy can just inform
> the driver about pages getting freed?
>
> Again, just a another random thought. But if these nodes are already
> special-private, then why not enlighten the buddy in some way.
> 
> That also aligns with my "buddy rejects to hand out free pages if the
> device says no" case.
> 
> Something to thinker about.
> 

The only thing i'll push back on here is this implies an ops callback
in the buddy (on free, at least - alloc could be a bitcheck on pgdat).

But yes, the current RFC has a free_folio() callback just like
zone_device.  The problem starts to become obvious when you let
other parts of mm/ touch those pages.

There are at least 3 or 4 different paths back into the buddy that
would need to be instrumented this way.

Some of them are called in NMI contexts.

The questions about "What is safe" start piling up very quick, and they
are hard to answer definitively.  I think we should at make strong attempt
to avoid such things entirely if possible.

~Gregory

