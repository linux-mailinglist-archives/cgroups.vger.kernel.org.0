Return-Path: <cgroups+bounces-16504-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAm7K0YiHWq6VwkAu9opvQ
	(envelope-from <cgroups+bounces-16504-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 08:10:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DA619FB5
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFF45300159F
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CB33F8B1;
	Mon,  1 Jun 2026 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dy5jaWEb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C431A680A
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294209; cv=none; b=ng2leO0FfCyBPOxUCrjPegmTVCjyNcyBhNi/BkaJbvsG6No1mszuKXIAS5jt8TawzYG+javcP01WYG4ovDMRIdUSUKeeFt3ytRZhdjwh1c8XrVEAc++uw50hCMV7SSdWYPK4RhmDfWbd6S0mosvoX7LpHk3ot05mIQK+LIRYbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294209; c=relaxed/simple;
	bh=ls4fdxStwJYUDK2GXci/6E3bhKJd6OP6CbBunayZYUQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T/T0uyxJxjU4bS7F4CIn6qlPdtL7Hu1uRyOUzbQBrJSYFOAwDzC8RbO0+r5dH7l3LsTHxBe4r+KFq0YWvMteMY1NXUrvpUfk7dM5PwDuLRz5eW+4ckF7VVBLTzsZ/Y/QZodKqS9DI4Wuoz9d/5iAJMpKeVcNvnkz0EpQbzZPMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dy5jaWEb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64a61f18-5ed2-47e6-b161-d55f5398d494@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780294195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXxnQM+FllcCZGVch5XWEuwCWhNF+HHX9PtM0I/F8zk=;
	b=Dy5jaWEbuB/KL+/W/t7yXppqUvSdhS55z8IBM4wzGKj6xRxfYgbmeXuoN+ECDSh8pUAvVN
	qteJ7ir2HJe/yu4gS5E2X7gI+0Rk9DSwYNS65PRh4Oq1p72o3nJegWSdocRhnlWg9gCcJa
	tsmcgWQUT1H+pAENVHcRkcnJ+A0m3iQ=
Date: Mon, 1 Jun 2026 14:08:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, linux-rdma@vger.kernel.org, cgroups@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size resource
 tracking
To: "yanjun.zhu" <yanjun.zhu@linux.dev>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, leon@kernel.org, jgg@ziepe.ca
References: <20260529090733.2242822-1-cui.tao@linux.dev>
 <ea3c6ed3-5d15-436e-9fa7-2e2d8ce26147@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ea3c6ed3-5d15-436e-9fa7-2e2d8ce26147@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16504-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B74DA619FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yanjun,

Thanks for the thoughtful questions.  FRWR is indeed a widely used
pattern, and the interaction with mr_mem deserves clarification.

> 1. Accounting Granularity: Does mr_mem charge the maximum capacity of
>    the FRWR object at its allocation time (ib_alloc_mr), or does it
>    dynamically track the actual mapped bytes during the fast-reg data
>    path?

In the current proposal, mr_mem is only charged for userspace MR
registrations that go through the uverbs layer (REG_MR, DM_MR,
DMABUF_MR, and the legacy ioctl path).  These are the paths where a
concrete byte length is known at registration time.

FRWR MRs allocated via ib_alloc_mr() are not charged for mr_mem.  The
actual registration footprint associated with an FRWR MR is not known
at allocation time: ib_alloc_mr() only specifies the maximum
scatter-gather capacity of the MR, while the mapped byte range may
change dynamically across successive ib_map_mr_sg() operations.

Supporting FRWR accounting would therefore require a separate
accounting model, since the registration footprint is established
dynamically rather than by a fixed length parameter supplied at MR
creation.  This is outside the scope of the current proposal.

> 2. Kernel-space vs Userspace: FRWR pools are frequently allocated by
>    kernel-space drivers (like NVMe-oF target/host). If these kernel
>    threads are not bound to a specific user cgroup, will their FRWR
>    allocations end up in the root cgroup, potentially bypassing the
>    per-tenant limits?

The RDMA cgroup's resource control is primarily designed for userspace
consumers.  Kernel-space consumers (NVMe-oF target, SRP initiator,
rtrs, iSER, etc.) allocate resources through kernel APIs
(ib_alloc_mr, ib_create_qp, etc.).  These resources do not currently
participate in RDMA cgroup accounting and therefore are not subject to
per-cgroup limits.

Kernel-space FRWR pools are typically managed by the administrator
rather than subject to per-tenant limits.

This behavior is consistent with the current RDMA cgroup model, which
tracks resources associated with userspace RDMA objects.  If accounting
were extended to kernel-allocated FRWR MRs, ownership semantics would
become an open question: simply charging against the current task or
the root cgroup may not accurately represent the tenant that ultimately
benefits from the resource.

> Don't you think it would be beneficial to explicitly document or
> consider the FRWR pattern in the design section, given its prevalence
> in real-world storage and networking workloads?

Agreed.  I will add a note to the cover letter and commit messages
clarifying that mr_mem currently covers only userspace MR registrations
with a known length, and that kernel-space FRWR pools are out of scope
for this initial proposal.  The semantic distinction between
userspace registration-length accounting and kernel-space FRWR
resource management is worth documenting explicitly.

Thanks,
Tao

