Return-Path: <cgroups+bounces-14694-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wORLD8sZrGm4kgEAu9opvQ
	(envelope-from <cgroups+bounces-14694-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 13:27:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C522BAE5
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 13:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D852A301C885
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC6351C16;
	Sat,  7 Mar 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CeZZJNPH"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68360288510;
	Sat,  7 Mar 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886468; cv=none; b=Tk5uZZ66WCS/WZW3mENfV2ffatmVAIwN9WptVenFcVGXDIhdhVEGPa9USw3LVDYsbAaHnEOe0CVj+bQsL+5tlBrQh7KsKw4LBq5yhmFgY/g1VFP/G7/naSaVhVoDh+IiaXLSQ4Xf47mYIpyj5xGXf8wmy5Zorpo1zcWTYBAewX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886468; c=relaxed/simple;
	bh=/hGqB74SP6fgsK9J5oz7krqGHOt/5jXg+qBC/QUehbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A12ox0XDuLJf64Y6J9cxefILrCssTGAN/+mSnu3vwj56gD3ylpY7aIIslsHxym2CqtkJAN9M0U8ymad+ZoUEAY+ZVg+c5is2U8p1Fn4uzRGTw3UTmHbGqEV9R/KIBRTnkHI9oVPuL8v1Inm4IoDvMUXU6nku74vfMYKJ5Loq374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CeZZJNPH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772886455; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Uz9X7T/t4Rpp9g+PKOPXwQF1hZ1s/CH2mdGFNaauaUM=;
	b=CeZZJNPHLf0609zJZkm8mteifF7Uto+aey3mbvm2Pw/NL2yRtyTFCpMQRVyHSSIDheQW3UheH+I8brTSYaN09ZZIOnLrJY6TYofmeglTKe1wUHVS/aNi2l7mKiJdNkFAgY9IPKRWGa066ZGVpQNCXpS7pBYbi3SqoT4+sF7XJmQ=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X-Pja1z_1772886444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Mar 2026 20:27:33 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  mhocko@suse.com,
  vbabka@suse.cz,  apopple@nvidia.com,  axelrasmussen@google.com,
  byungchul@sk.com,  cgroups@vger.kernel.org,  david@kernel.org,
  eperezma@redhat.com,  gourry@gourry.net,  jasowang@redhat.com,
  hannes@cmpxchg.org,  joshua.hahnjy@gmail.com,  Liam.Howlett@oracle.com,
  linux-kernel@vger.kernel.org,  lorenzo.stoakes@oracle.com,
  matthew.brost@intel.com,  mst@redhat.com,  rppt@kernel.org,
  muchun.song@linux.dev,  zhengqi.arch@bytedance.com,  rakie.kim@sk.com,
  roman.gushchin@linux.dev,  shakeel.butt@linux.dev,  surenb@google.com,
  virtualization@lists.linux.dev,  weixugc@google.com,
  xuanzhuo@linux.alibaba.com,  yuanchu@google.com,  ziy@nvidia.com,
  kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
In-Reply-To: <20260307045520.247998-1-jp.kobryn@linux.dev> (JP Kobryn's
	message of "Fri, 6 Mar 2026 20:55:20 -0800")
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
Date: Sat, 07 Mar 2026 20:27:22 +0800
Message-ID: <87seabu8np.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Rspamd-Queue-Id: 959C522BAE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14694-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ying.huang@linux.alibaba.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

"JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:

> When investigating pressure on a NUMA node, there is no straightforward way
> to determine which policies are driving allocations to it.
>
> Add per-policy page allocation counters as new node stat items. These
> counters track allocations to nodes and also whether the allocations were
> intentional or fallbacks.
>
> The new stats follow the existing numa hit/miss/foreign style and have the
> following meanings:
>
>   hit
>     - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>     - for other policies, allocation succeeded on intended node
>     - counted on the node of the allocation
>   miss
>     - allocation intended for other node, but happened on this one
>     - counted on other node
>   foreign
>     - allocation intended on this node, but happened on other node
>     - counted on this node
>
> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
> in /proc/vmstat.

IMHO, it may be better to describe your workflow as an example to use
the newly added statistics.  That can describe why we need them.  For
example, what you have described in

https://lore.kernel.org/linux-mm/9ae80317-f005-474c-9da1-95462138f3c6@gmail.com/

> 1) Pressure/OOMs reported while system-wide memory is free.
> 2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
> down node(s) under pressure. They become available in
> /sys/devices/system/node/nodeN/vmstat.
> 3) Check per-policy allocation counters (this patch) on that node to
> find what policy was driving it. Same readout at nodeN/vmstat.
> 4) Now use /proc/*/numa_maps to identify tasks using the policy.

One question.  If we have to search /proc/*/numa_maps, why can't we
find all necessary information via /proc/*/numa_maps?  For example,
which VMA uses the most pages on the node?  Which policy is used in the
VMA? ...

---
Best Regards,
Huang, Ying

[snip]

