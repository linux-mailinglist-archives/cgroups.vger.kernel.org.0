Return-Path: <cgroups+bounces-16464-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHS0MgECGmqQ0ggAu9opvQ
	(envelope-from <cgroups+bounces-16464-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:15:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B7608CDE
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2820B3029E60
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C57421F04;
	Fri, 29 May 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mt5q4yEc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D73DD50D
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089266; cv=none; b=qH0fbc4vjVLh0dzRZkXuV2Gpnn8PGF8wE2a9wTEgUF/cqhpr3ulTMe2Pvtj35AMeswC/pEiGdBIDL+Jzf7+qtx8E/N2ER5l/VxMjHm+4xC+qx2Pbg3xiR0y3cn4BTEGvjgHVHTlEm8zATwCiY+TiuQB4wFqMiHKo1kG3YomSDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089266; c=relaxed/simple;
	bh=IXJ/fW4v6YEmX7UdLSm5aasq+tpsSacfX7N/jI01lJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSwVrJVd1jtDnhjndEY7c8YfFeQwDDMjw+/IkWkQRfOcDmRHrmhebjExopq0CUY3pQw2Lh6uXF2LUBn7UPw6Hkkyiqve4bXxYbQ0LYXWNBEzo3j8VvsX3I5ZPUD8VZbm8y3pWroP/qD4WF11wQcMltycoOe12JzhvSyPosq4Lfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mt5q4yEc; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea3c6ed3-5d15-436e-9fa7-2e2d8ce26147@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780089261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAkmbr+OI++HT8zsiLOhQzkwD5SiBfLNC0Gds70M4nY=;
	b=mt5q4yEcPHtz7/eDy+xc2Vjji6Z2FAwQXP1TLiEVesrvtL99oHtEKHzUHGuh93A/yi91eS
	YiVAZ+d6XuV9IeDDAc8/WJcRRvbDJT2CXoEY6xjhgPrH6nop2Z4llc2X2YzMfoP4lkt2un
	yJWDRmhyF54o2f5pR5xBWcZG/dijcZA=
Date: Fri, 29 May 2026 14:14:11 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size resource
 tracking
To: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, cgroups@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260529090733.2242822-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16464-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 5F2B7608CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 2:07 AM, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Currently the RDMA cgroup only tracks two aggregate counters:
> hca_handle and hca_object.  The real scarce resource in multi-tenant
> deployments is pinned memory: how much physical memory gets registered
> through MRs.  The existing hca_object counter is too coarse to capture
> this.
> 
> This series adds a single new resource type:
> 
>    - mr_mem  - Cumulative MR memory size in bytes
> 
> The per-object-type counters (qp, mr) from RFC v1 have been removed
> per review feedback [1]: modern NICs pool objects from the same memory
> pool so the distinction between QP count and MR count is not
> meaningful for resource limiting.  hca_object remains sufficient for
> coarse object accounting.
> 
> After this series, an administrator can set limits like:
> 
>      echo "mlx5_0 mr_mem=1073741824" > rdma.max
> 

Hi,

Thanks for the patchset! Introducing `mr_mem` to track and limit pinned
memory size is a very practical enhancement for multi-tenant deployments.

I have a question regarding how this new resource type interacts with
Fast Registration (FRWR / FRMR), which is widely used in production
environments (e.g., NVMe-oF, iSER) to achieve high performance.

As we know, FRWR decouples the MR object allocation (`ib_alloc_mr`) from
the actual memory page mapping (`ib_map_mr_sg`). The creation of FRWR
Memory Regions is often managed via a pre-allocated page pool.

Could you clarify how `mr_mem` accounts for FRWR in the following scenarios?

1. Accounting Granularity: Does `mr_mem` charge the maximum capacity of
    the FRWR object at its allocation time (`ib_alloc_mr`), or does it
    dynamically track the actual mapped bytes during the fast-reg data 
path? If it's the former, it represents a "static maximum budget" per 
pool, which seems more practical for performance.

2. Kernel-space vs Userspace: FRWR pools are frequently allocated by
    kernel-space drivers (like NVMe-oF target/host). If these kernel
    threads are not bound to a specific user cgroup, will their FRWR
    allocations end up in the root cgroup, potentially bypassing the
    per-tenant limits?

Don't you think it would be beneficial to explicitly document or 
consider the FRWR pattern in the design section, given its prevalence in
real-world storage and networking workloads?

Thanks,
Zhu Yanjun

> Design
> ~~~~~~
> 
> mr_mem is not page-level ownership tracking; it is object-based
> accounting tied to the MR lifetime:
> 
>    - charged at MR registration time
>    - uncharged at MR destruction time
>    - the charge is pinned to the cgroup that created the MR for the
>      entire lifetime of the MR object
> 
> This model intentionally defines accounting semantics around MR
> object lifetime rather than page ownership:
> 
> 1. fork(): fork() does not duplicate MR objects.  Even though the
>     child inherits the uverbs fd and can access the parent's ucontext,
>     the MR remains a single kernel object.  The charge is tied to the
>     MR object, not to the number of processes that can reach it, so
>     no splitting or re-accounting is needed.
> 
> 2. Cgroup migration: mr_mem follows the same semantics as the existing
>     hca_object; charge at creation time against the invoking task's
>     cgroup, uncharge at destruction time.  The RDMA cgroup does not
>     implement can_attach/attach callbacks today, so charges do not
>     migrate with the task.  This is a known limitation that applies
>     equally to hca_handle and hca_object.  mr_mem does not introduce
>     any new complication here.
> 
> 3. Overlap with memory cgroup: mr_mem does not count process memory
>     usage; it represents a per-device DMA registration budget: the
>     amount of memory this cgroup may register through a given HCA.
>     This is a different dimension from what memory cgroup tracks.  An
>     administrator might set mr_mem limits differently per device, which
>     memory cgroup cannot express.
> 
>     In particular, mr_mem tracks the registered memory range associated
>     with the MR rather than exact dynamically pinned pages (e.g. for
>     ODP MRs).  This is a stable, policy-oriented approximation of
>     registration footprint, not an attempt at precise physical page
>     accounting.
> 
> Tao Cui (3):
>    cgroup/rdma: extend charge/uncharge API with s64 amount parameter
>    cgroup/rdma: add MR memory size resource tracking
>    cgroup/rdma: update cgroup resource list for MR_MEM
> 
>   Documentation/admin-guide/cgroup-v2.rst       |  21 ++--
>   drivers/infiniband/core/cgroup.c              |  10 +-
>   drivers/infiniband/core/core_priv.h           |  12 +-
>   drivers/infiniband/core/rdma_core.c           |  20 +++-
>   drivers/infiniband/core/uverbs_cmd.c          |  61 +++++++++-
>   drivers/infiniband/core/uverbs_std_types_mr.c |  37 ++++++
>   include/linux/cgroup_rdma.h                   |   8 +-
>   include/rdma/ib_verbs.h                       |   1 +
>   kernel/cgroup/rdma.c                          | 108 +++++++++++++-----
>   9 files changed, 219 insertions(+), 59 deletions(-)
> 
> ---
> Changes from RFC v1:
> 
>    - Removed RDMACG_RESOURCE_QP and RDMACG_RESOURCE_MR per-type
>      counters following review feedback from Jason Gunthorpe [1].
>    - Retained only RDMACG_RESOURCE_MR_MEM as the sole new resource.
>    - Added detailed semantic notes to the commit messages addressing
>      fork(), cgroup migration, and overlap with memory cgroup [2].
>    - Renamed patches to reflect the narrower scope.
> 
> [1] https://lore.kernel.org/all/20260525134314.GI7702@ziepe.ca/
> [2] https://lore.kernel.org/all/20260528075537.2170697-1-cuitao@kylinos.cn/


