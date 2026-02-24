Return-Path: <cgroups+bounces-14202-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLBYEb06nWm8NgQAu9opvQ
	(envelope-from <cgroups+bounces-14202-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 06:44:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1906D1822AA
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 06:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F09930266D4
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 05:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45329E0E5;
	Tue, 24 Feb 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e6L8/GT1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEA29BDB1
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911867; cv=none; b=X8Pxom39VRTZBHhIO4XbRoD3Rbz4dkpfIHJvFcJkzRClM2+NH90482APHS8R7LKsQqoxIS5hPqMcVVsU8DovaLhaM91qH6udaPBKExWl/Fmz4KOyUjrnyVHrrcY3rUjR/lgmKzAyYGFFO+YOZFeDKhmLuSlXrU5qO5hrroJwR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911867; c=relaxed/simple;
	bh=rzK7GNSJ6eLbNqtPeTcBCWdyH8w/WzG0B6zkmRX1j94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcYgFgw915iatiCrGypkS3175vudGlj/NutVhFzwA/AqPtkcQdgQKlb7iCBoYGSj72+A8SWvmae0+BTbQ5+SIynTyUcX66myFGjotpmlATL/6jVvVJxmoF75jVPJXW5v3V8uxSMnjZ3OgIXTnKHBbWQc0E9rHbBT2M/bvJH3AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e6L8/GT1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Feb 2026 21:44:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771911853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDiN5/pgIKNGFEPeeKgrUiwMTxAa7uwUxPs6Mze27+s=;
	b=e6L8/GT1w+S0WHuke+elD6HX1fCEaenrz3zCvyh3NXASLHKqK9yOcMYaviWPPxQ9i3CM5l
	S3uG94ZZqGDNz2MHWTWR/eWKsrNBV6PzHFtCZXDUEKKGD6SKd9YvxkeWJdzfjzqwm2nVnH
	blglS5BubzOu697v/+JyZGkuED/kCIM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 06/15] memcg, swap: reparent the swap entry on swapin
 if swapout cgroup is dead
Message-ID: <aZ0oXHNMe7_3P9OT@linux.dev>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-6-104795d19815@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-swap-table-p4-v1-6-104795d19815@tencent.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14202-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1906D1822AA
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:42:07AM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> As a result this will always charge the swapin folio into the dead
> cgroup's parent cgroup, and ensure folio->swap belongs to folio_memcg.

I directly jump to this patch and the opening statement is confusing. Please
make the commit message self contained.

> This only affects some uncommon behavior if we move the process between
> memcg.
> 
> When a process that previously swapped some memory is moved to another
> cgroup, and the cgroup where the swap occurred is dead, folios for
> swap in of old swap entries will be charged into the new cgroup.
> Combined with the lazy freeing of swap cache, this leads to a strange
> situation where the folio->swap entry belongs to a cgroup that is not
> folio->memcg.

Why is this an issue (i.e. folio->swap's cgroup different from
folio->memcg)?

> 
> Swapin from dead zombie memcg might be rare in practise, cgroups are
> offlined only after the workload in it is gone, which requires zapping
> the page table first, and releases all swap entries. Shmem is
> a bit different, but shmem always has swap count == 1, and force
> releases the swap cache. So, for shmem charging into the new memcg and
> release entry does look more sensible.

Is this behavior same for all types of memory backed by shmem (i.e. MAP_SHARED,
memfd etc)? What about cow anon memory shared between parent and child
processes?

> 
> However, to make things easier to understand for an RFC, let's just
> always charge to the parent cgroup if the leaf cgroup is dead. This may
> not be the best design, but it makes the following work much easier to
> demonstrate.

Please add couple of line on how will it make things easier.


