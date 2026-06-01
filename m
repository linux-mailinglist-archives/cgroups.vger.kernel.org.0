Return-Path: <cgroups+bounces-16503-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE2jBCobHWoeVwkAu9opvQ
	(envelope-from <cgroups+bounces-16503-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 07:39:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E6619BC8
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 07:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B4E30456BD
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44D32ED40;
	Mon,  1 Jun 2026 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbei0L3O"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9414A8B
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292309; cv=none; b=rBn5+7mWfFh8P6qY8M07vciuKthhSvC9meequdSWyPiyC/44Yis9nUhNvR6E6lW2d25xU7zXLPau4pcERb/P9gBU0vFmDXILROXhLGSTZpSuMRT11147Did6yElHSVfsE7Vgk1PM+t7BfSjFDpNSUHgJ43xGgTceZbJo8I0Tt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292309; c=relaxed/simple;
	bh=qI23LEl4axNSLuioJtZoc++UsEKGW0aZrCiG6UCqwJc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gh4xCLbs8+igp0YEAtN8IxIWsrDrAz7IdhxY6ELzI2fyC8hLHvtsP17ePXKgTzwjhkLnLzLx9IeVdFnwwd4PSUe2AFUNqJg+dcaPV0UQG826wF7QwdSgxSPKCykve+Asmnz2JhKxTJ/G1I8R58NYsiXYAopMB5to7FDUCj2N4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbei0L3O; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48e538b6-0eb3-463d-ae48-5190a5e196a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780292295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmDsyien2gEvQwFgV9S3V/enCFiEeIk8BnIG+9jjR4=;
	b=sbei0L3Oevpf8kwu8y6GcOuXjqFUhk2+LFwGEZqv76NNTKbS2SScGX4eL9klaffOsit9d9
	SM8QMXRcOHC+4Rmolsk210VA8N8ZJfkqVrPKiTave8Lo8H4s2G3FOOxHJMnvl1XoB08YCo
	bEByJXWeNtj48Mxq0eOQmPiL5WEVJuQ=
Date: Mon, 1 Jun 2026 13:37:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, tj@kernel.org, hannes@cmpxchg.org, leon@kernel.org,
 jgg@ziepe.ca, linux-rdma@vger.kernel.org, cgroups@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size resource
 tracking
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
 <ahmG_ualxJT5WU_B@localhost.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ahmG_ualxJT5WU_B@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-16503-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5C9E6619BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

Thanks for the review and for the reference.

> IIUC the pinned memory is regular RAM, i.e. it could be controlled
> with memcg as needed. Or is there "physical" limit of what can be
> assigned to a single device?

You are right that the pages associated with an MR are regular system
RAM. However, MR registration does not allocate new pages; it registers
existing pages that are already charged to the allocating process's
memcg.

For that reason, mr_mem is intended to represent a different resource
dimension: not "how much memory does this cgroup own", but "how much
memory may this cgroup register through a given HCA". In other words:

  * memcg limits memory ownership/consumption
  * mr_mem limits RDMA registration footprint

An administrator may reasonably wish to set different registration
budgets per device (for example, 1G through mlx5_0 and 4G through
mlx5_1) for the same cgroup. memcg has no notion of device-scoped
limits; it only tracks aggregate memory consumption.

This distinction is important because memory ownership and DMA
registration are not necessarily constrained by the same policy. A
tenant may remain within its memcg limit while still consuming a large
portion of a particular HCA's registration capacity. The existing RDMA
controller already provides a per-device resource control framework,
and mr_mem extends that model to cover memory registration footprint.

> Or is there "physical" limit of what can be assigned to a single device?

Yes. Real HCAs have finite resources associated with memory
registration, such as MTT/MPT capacity and related DMA translation
resources. In practice, administrators often need to prevent one tenant
from consuming a disproportionate share of a particular HCA's
registration capacity, even when sufficient system memory remains
available.

It is also worth noting that mr_mem is intentionally not an attempt to
account exact pinned pages. The accounting model is tied to MR object
lifetime and tracks registration footprint rather than dynamic physical
page state. For example, ODP MRs may have only a subset of their pages
pinned at any given time, yet still consume registration resources on
the HCA. This is why the proposal focuses on a stable,
policy-oriented registration budget rather than precise memory
ownership accounting.

> BTW, have a look at [1], it'd be good to converge to similar approach
> (the current proposal allows distinguishing whether charging should
> include or exempt memcg counting).

I've read the related dma-buf accounting work.

My understanding is that those proposals focus on allocations that
create new memory on behalf of a device, which is naturally accounted
through memcg.

RDMA MR registration is different because no new memory is allocated.
The MR object is an in-kernel registration of existing memory that has
already been accounted elsewhere. The resource being limited is
therefore the registration itself rather than the underlying memory
pages.

> Also it seems, that the dmem controller could be a one-stop solution
> for all DMA charges. Please tell me if there are any distinguishing
> factors between RDMA devices' memory and these dmem memory regions.

One distinction is that the current dmem work appears to focus on
memory resources allocated on behalf of a device, whereas mr_mem is
intended to limit host memory registered for DMA through RDMA MRs.
RDMA NICs typically do not have large device-local memory pools;
instead they provide DMA access to host RAM through memory
registration. As a result, the resource being controlled here is not
device memory consumption itself, but the registration footprint
associated with a particular HCA.

Another difference is the accounting model itself. The proposed mr_mem
accounting is tied to MR object lifetime and tracks registration
footprint rather than precise physical page usage.

My understanding is that dmem is currently integrated with the DRM/TTM
subsystem for device-local memory accounting, and there is no existing
RDMA integration today. I have not investigated what would be required
to extend that model to RDMA registration accounting.

That said, I agree that convergence would be desirable if a generic
framework can naturally express per-device DMA registration budgets.
My goal here is not necessarily to require RDMA-specific accounting,
but to address a practical resource-control problem within the existing
RDMA cgroup framework.

Thanks,
Tao

