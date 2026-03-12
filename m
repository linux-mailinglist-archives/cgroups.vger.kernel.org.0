Return-Path: <cgroups+bounces-14789-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOd6NWfpsmljQwAAu9opvQ
	(envelope-from <cgroups+bounces-14789-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 17:27:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4400275911
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 397FB309EF06
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A33CE4AA;
	Thu, 12 Mar 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="foV+uUBl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE253F7A8F
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332062; cv=none; b=hM+4n6etoBLyhnlyT+nI2vPTKUPvkDRFvA5TJnzVo+QZ9E3XCQCrRVgfhtAWHBUXbrARRN1q0bwiBqDuuINfbFDn92TZdkp2HODpq0W90HrNZMRI5uaAR+r9DJhHLQGpRviI14EyOZMBMH4snTaMaNzU8QzTXQGD/hPPFyNYzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332062; c=relaxed/simple;
	bh=N242Oa9HbfjsGekgxcB30/llk72j44THFCUkPd6F8NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IapmlZoAzG+TWabvYzhYLJt2jTtqUKN6ayC6yGK74Ro6dlVnMGw7PapGaBHIFfJFvkctsWRKDPqpPu42Cmvq7mc1QzFzeGpqFRVLXG9RSKJWWAWy94hYfiqVfqgj2GkUdk68x15XPfLJTJqbLq5aYb7mkdQ28Ph/El9gl/uSZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=foV+uUBl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773332047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9kpSbMrF1j0QA2GDOXqTycEozhSapelcYr5ulLYWk=;
	b=foV+uUBlJDuw7ebXJrD2UQy+HMDbOyN1uiGoY/VhPevytnn5dXWRnRSayiOqBIlKU0menO
	48Tcq8P4hlTuSKLvFiNOlHu7YIe1SaoY4Q6TeSKOWGkYQrSs/j2yy1QuQu9eswLlXmMmf0
	tev69CksT9lwmShZNQ3xpJHFGmHYk4Y=
Date: Thu, 12 Mar 2026 09:13:49 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@suse.com
Cc: apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
 cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
 gourry@gourry.net, jasowang@redhat.com, hannes@cmpxchg.org,
 joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	TAGGED_FROM(0.00)[bounces-14789-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D4400275911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
> On 3/7/26 05:55, JP Kobryn (Meta) wrote:
>> When investigating pressure on a NUMA node, there is no straightforward way
>> to determine which policies are driving allocations to it.
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters track allocations to nodes and also whether the allocations were
>> intentional or fallbacks.
>>
>> The new stats follow the existing numa hit/miss/foreign style and have the
>> following meanings:
>>
>>    hit
>>      - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>>      - for other policies, allocation succeeded on intended node
>>      - counted on the node of the allocation
>>    miss
>>      - allocation intended for other node, but happened on this one
>>      - counted on other node
>>    foreign
>>      - allocation intended on this node, but happened on other node
>>      - counted on this node
>>
>> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
>> in /proc/vmstat.
>>
>> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
> 
> I think I've been on of the folks on previous versions arguing against the
> many counters, and one of the arguments was it they can't tell the full
> story anyway (compared to e.g. tracing), but I don't think adding even more
> counters is the right solution. Seems like a number of other people
> responding to the thread are providing similar feedback.
> 
> For example I'm still not sure how it would help me if I knew the
> hits/misses were due to a preferred vs preferred_many policy, or interleave
> vs weithed interleave?
> 

How about I change from per-policy hit/miss/foreign triplets to a single
aggregated policy triplet (i.e. just 3 new counters which account for
all policies)? They would follow the same hit/miss/foreign semantics
already proposed (visible in quoted text above). This would still
provide the otherwise missing signal of whether policy-driven
allocations to a node are intentional or fallback.

Note that I am also planning on moving the stats off of the memcg so the
3 new counters will be global per-node in response to similar feedback.

