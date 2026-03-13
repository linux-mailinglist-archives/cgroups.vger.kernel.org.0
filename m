Return-Path: <cgroups+bounces-14794-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM7rAbubs2l1YwAAu9opvQ
	(envelope-from <cgroups+bounces-14794-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 06:08:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400527D564
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 06:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D789030517EE
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 05:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3229A312;
	Fri, 13 Mar 2026 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K9+yRy1m"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB91482E8;
	Fri, 13 Mar 2026 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378487; cv=none; b=AzOsSoBB1rbb614yau2VM6IZn2/dPLEdipaWtbyDKPmG9kkqcuMvhgHx2kafldQSopcFQrENTyX69grg6KxaUkuyKLXBgBQvDUUJUg1hbr3meAzMEkJBILXib1EkUbhHYwDKiJ4wV/b2WJ9r/DjHrPobRYcvE9TqgPsZBARaJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378487; c=relaxed/simple;
	bh=973I4MvM6diQkbCEVFTHHCxVl0F1i7DrNqJaYcqqqFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fd0ObqESUpTnGKd0oseTtEgGTGV+r7zfaJdjqUF7WIRw0LYEHoQQ5SrsJKTZZHetU8JaVhaDEGvC00e7WcYnzmipTSn5Cw4+ZMIIUz7ixMQiiqAzxIyYFyJZ6kk/uwkS7eTLfP/g5gWLhDrB1qp8A09O77cmz4nGSWglmS5S12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K9+yRy1m; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773378475; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=T2fdojMM54qSgNsuFhPwacfFSNjW/hMMNErtovdaSec=;
	b=K9+yRy1maHL6dE99fG6FnmFTzHdPeR/Y2U5+rMAnH4ssIC2H0Y9pCjP5Q0tjqYR8eRmHzQIRbNXmbGWmA9z7fnpP/UDXYUg2a6pfR25aO1iHP5ymkh9cqxtxLxjSJqrNmF/+KnQXj3VaW9Ub+UtPRX2xYfXY08jHFkBsAKQA9Mo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0X-r.uEE_1773378471;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X-r.uEE_1773378471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 13:07:53 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,  linux-mm@kvack.org,
  akpm@linux-foundation.org,  mhocko@suse.com,  apopple@nvidia.com,
  axelrasmussen@google.com,  byungchul@sk.com,  cgroups@vger.kernel.org,
  david@kernel.org,  eperezma@redhat.com,  gourry@gourry.net,
  jasowang@redhat.com,  hannes@cmpxchg.org,  joshua.hahnjy@gmail.com,
  Liam.Howlett@oracle.com,  linux-kernel@vger.kernel.org,
  lorenzo.stoakes@oracle.com,  matthew.brost@intel.com,  mst@redhat.com,
  rppt@kernel.org,  muchun.song@linux.dev,  zhengqi.arch@bytedance.com,
  rakie.kim@sk.com,  roman.gushchin@linux.dev,  shakeel.butt@linux.dev,
  surenb@google.com,  virtualization@lists.linux.dev,  weixugc@google.com,
  xuanzhuo@linux.alibaba.com,  yuanchu@google.com,  ziy@nvidia.com,
  kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
In-Reply-To: <343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev> (JP Kobryn's
	message of "Thu, 12 Mar 2026 09:13:49 -0700")
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
	<3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
	<343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
Date: Fri, 13 Mar 2026 13:07:50 +0800
Message-ID: <874imkpba1.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14794-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ying.huang@linux.alibaba.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,suse.com,nvidia.com,google.com,sk.com,vger.kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 6400527D564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:

> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>> On 3/7/26 05:55, JP Kobryn (Meta) wrote:
>>> When investigating pressure on a NUMA node, there is no straightforward way
>>> to determine which policies are driving allocations to it.
>>>
>>> Add per-policy page allocation counters as new node stat items. These
>>> counters track allocations to nodes and also whether the allocations were
>>> intentional or fallbacks.
>>>
>>> The new stats follow the existing numa hit/miss/foreign style and have the
>>> following meanings:
>>>
>>>    hit
>>>      - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>>>      - for other policies, allocation succeeded on intended node
>>>      - counted on the node of the allocation
>>>    miss
>>>      - allocation intended for other node, but happened on this one
>>>      - counted on other node
>>>    foreign
>>>      - allocation intended on this node, but happened on other node
>>>      - counted on this node
>>>
>>> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
>>> in /proc/vmstat.
>>>
>>> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
>> I think I've been on of the folks on previous versions arguing
>> against the
>> many counters, and one of the arguments was it they can't tell the full
>> story anyway (compared to e.g. tracing), but I don't think adding even more
>> counters is the right solution. Seems like a number of other people
>> responding to the thread are providing similar feedback.
>> For example I'm still not sure how it would help me if I knew the
>> hits/misses were due to a preferred vs preferred_many policy, or interleave
>> vs weithed interleave?
>> 
>
> How about I change from per-policy hit/miss/foreign triplets to a single
> aggregated policy triplet (i.e. just 3 new counters which account for
> all policies)? They would follow the same hit/miss/foreign semantics
> already proposed (visible in quoted text above). This would still
> provide the otherwise missing signal of whether policy-driven
> allocations to a node are intentional or fallback.
>
> Note that I am also planning on moving the stats off of the memcg so the
> 3 new counters will be global per-node in response to similar feedback.

Emm, what's the difference between these newly added counters and the
existing numa_hit/miss/foreign counters?

---
Best Regards,
Huang, Ying

