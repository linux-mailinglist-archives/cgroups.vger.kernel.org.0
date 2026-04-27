Return-Path: <cgroups+bounces-15517-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G+AFiHj72kHHQEAu9opvQ
	(envelope-from <cgroups+bounces-15517-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 00:28:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E490547B719
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 00:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0198E3019CB2
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 22:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1418346AFD;
	Mon, 27 Apr 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P/zKgAuS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0732366072
	for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328892; cv=none; b=tlhy7exiFHxxod2nmUXF0N5xjg/eITzBgHyRzrCWjqSU+9dXss7QUKugUERbnXoAu195KD7c74BDCXU6+9mRjbNh7ItwFlLEQNsRxIFGIvMfJFytvGkD7GoNWGjN3/g5jsVYVdDZe1pIfNAiuKb5hS1g5ver+mE83Eq5+0Qz1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328892; c=relaxed/simple;
	bh=OWUivCv4zEIft7NtrxbKIzy+5mPXal2rztDt74M075w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg/Lthnw9rjxmK6WOi7RX75jS9bhcCIZuGqWGY/rD+5b+D2eOShGZHWilmwJCe7eWdMkavw7qQuZeXj/L607ctR9lh7jreA2XHvsheaQTPg9AyYq0dpDG+aPpTBH4VWhJnxKfGnp9A03GtG2wY8b72QUh2ZvxbCAG1UrUUloUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P/zKgAuS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ad135063so97870445e9.0
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777328889; x=1777933689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9hfpEncvlzWZw9qEgc5pnCnun8WUnWYl5bmHD7iYIU=;
        b=P/zKgAuSLzLPSH789XAOwV+rhQrJmoWPiMm0nHbuVnH4U0baGk44DJkGTfRAlhQITb
         F1kfFZ1Y9XRfzgAOCEmFOi50HyphqmijoTnYZaAWgvP4bMEH1mGHdoJf18VArbZ7sqhb
         QO3sVqvUj+qu3K5jHJ/FW11MR+9R65VIoxVpzgBsZz3HOktQqtwZVazL2LrFqwOi5yBs
         yY1gyjpVc/RU7JZsoR3g/c4UevytCygkCjvJnsz+suv2rsefA7oWNXAfLh6vLoTh+FVo
         lu9b/S78ovpMilPOrEb8Psbg6pNznBG/UEgF3pw7M/Rm2hCZyojPU7EBIpPYGhUc+j4K
         Ibpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328889; x=1777933689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9hfpEncvlzWZw9qEgc5pnCnun8WUnWYl5bmHD7iYIU=;
        b=imaukV17bxcv1ifpaCN1S6oomjFhpFzJcRPsZRbs4b3yNqahL1b2NW+eTfyJ4DwlFk
         6CQadaKnJV2LngIe1/cQxLs2hHYMI+GbZdLd3jj2g5BlkNyaLTQ/BeOvkJcf/WqNVxdD
         5L99Ttlz4lId/oQfMowdT9cbGuoBCMVaA4qKn3sf8GVXl08mTrtwhAbCBL9AypHKDk4o
         PGGyjR4eutCaHCabn2CkEDxAMQlLD+PWT0QTGoNs0pik6FCSl9CG9LalnTx8lD1T4muy
         HnqTaDI0HHe/Ai65o+TAkDHE9WRk6OmLbChqeuNhvaMqebMVpSXN88r7AgO0912Eclfa
         MYIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q9CUcywrhQ4NIj39CzGlz3A6HounXu57YjVZxhe+DtitjpnfZjp7ceyfv6EO008Uh8UF5gRHD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UXZ7jnEcrhlAbyp2Xk7paD/HsWqXdjbqYr5cCp+JD+SmpTlA
	9kcN0ntPy9FRBJfNHuJPSwYj+vDhNyawalMKH3It19YoiWk+6egJWWcETrKjgp8O8e4=
X-Gm-Gg: AeBDietcR+weVbyQZ1AjmgsbKmIxU+jak7niQMwGGBQddZxLsNTQd7YOwhejXXiu7kz
	vcfF9tThrNjqTikwjZ46mZPimeX9t0jFnyDX6wOSHcVx32sUO036tVrvmjky7VijnIsakWhoCr7
	nZOoVTp1//JXaRYu27QzuyHv5ziuzRsF60llaJfh2zcXeyG7zqbQoS6Po49uZ6n8laiPR9wiEnX
	5fQzq25omYglQPEz7h3muXIWk7vyH+Op3JvoxFUbuUEWIOiDXSRl/rKXCS8hodkJXPyPfE1MrnE
	FhtIfU7UKvI1wGECn4jUHLa1cDoOwMcHhJ23yPgH4ejC3drqEOM98nM7X+cugi7h2An71WwZHMt
	tz41plU8WozN3AYOnp6+xAunkrTrCp7bhCVfsSpklY2q94l6uMNu56hPc9qwpK3JdCb+mobqLSQ
	VS0vlPGMxl33LL7UnAqJ/A24tct1L30W/3XbLKRos=
X-Received: by 2002:a05:600c:46c5:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48a77b22e28mr7190105e9.26.1777328888562;
        Mon, 27 Apr 2026 15:28:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2a00:23c8:67a7:3101::e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77afabcdsm15735785e9.8.2026.04.27.15.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 15:28:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:28:04 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
X-Rspamd-Queue-Id: E490547B719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15517-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 06:02:57PM +0530, Arun George wrote:
> 
> Appreciate the work as we also chase the same problem statement.
> A few queries please.
> 
> I see the current support relies on read-only mappings which might
> limit the performance. Any particular workload you are targeting with
> this (which can tolerate this latency)?
>
> Any deployments you think of where the goal is a capacity expansion
> with a compromise in performance?
>

Primary use cases for us are any workload that benefits from zswap -
which is many, many (many, many [many, many]) workloads.

That said, performance is quite irrelevant if you cannot guarantee
correctness.

In a scenario where a multi-threaded CPU can write many many GB/s to
a compressed device - I can't see a scenario where completely
uncontended writes to such a device can provide reliability.

I suppose you could increase the latency of a writable cacheline from
Xns to NXns - but you've only slowed the bear down.  Meanwhile, running
away from said bear includes trying to migrate stuff off the device...
presumably to swap - so your migration process has to have higher
throughput than whatever writes are coming in from the CPU.

Meanwhile - the system is clearly already pressured, and is likely to
continue demoting new data to the compressed tier.

So you end up, at best, in a footrace hoping the bear loses interest,
or at worst in a fight hoping to dodge its claws (generating poison on
some write that fails).

> On the device side, are you targeting beyond compressed RAM like
> devices such as memory with NAND etc.?
> 

For private nodes - I have been collecting use cases, but I haven't seen
a NAND proposal.  Unless someone is willing to demonstrate such a device
actually working without causing bus-lockup issues, most believe the
error-recovery overhead for NAND is too expensive to service cacheline
fetches.

> The TL;DR talked about mmap/mbind way of user space allocation from
> the private node. But the allocation is controlled by GFP flag
> N_MEMORY_PRIVATE. Does the user space path of allocation set this
> flag along the way?
> 

No.  Userspace does mbind() and it works - if the device's driver (or
service) has opted that node into allowing mempolicy syscalls.

The kernel injects the __GFP_PRIVATE for the relevant VMA in the vma
fault path if that VMA has a nodemask with a valid private node.

> And I believe the bear-proof cage might work in the normal scenarios,
> but may not work for all.

If it can't work for all workloads, then it's likely not general purpose
enough to find core kernel support and should seek to use the existing
interfaces (DAX and friends).

> We might not be able to rely on the control
> path (backpressure) fully. The control path could go slow, slower and
> even die as well. Should the device respond with something like
> 'bus error' if the host tries to write when it is not capable of
> taking any more writes?
> 

You need two controls over compressed RAM for it to be reliable:

  - Allocation control (acquiring new struct page to write to)
  - Write-control (preventing new writes to compressed pages)

Private nodes provide the allocation control.

A read-only mapping, and guarantee that only memory that can reach
the device is userland memory - is the only way to control the cpu
writes from the OS perspective.

(Bonus: page cache can't live here, because buffered I/O bypasses
 this by using direct writes from the kernel).

Slowing the bus down just puts you in competition with swap, and bus
error is basically equivalent to poison being reported at write time.

That's basically the whole story.

Loosening the write-protection can be seen as trading optimization
for risk - where the risk is hitting poison in userland-only memory.

In the next version of the RFC i'll demonstrate cram.c as a new swap
backend that allows for read-only mappings to be soft-faulted in,
migration on write, isolation to ANON memory, and some optional 
settings that allow a device or administrator a "writable budget" 
which allows some number of pages to be made writable without migration.

~Gregory

