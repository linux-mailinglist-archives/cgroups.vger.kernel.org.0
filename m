Return-Path: <cgroups+bounces-14766-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NVaJUKnsWn4EAAAu9opvQ
	(envelope-from <cgroups+bounces-14766-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 18:32:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E82680CF
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 184543039694
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1033E025D;
	Wed, 11 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="usFHXj3w"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA122F388
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250334; cv=none; b=aMIT5a94Uj3HOjHF/PqahH3fugoYvkYTB/Yg2SVTw5tkJl38pf79XldrN355cKjrS7dphIaqIgRO+x+IXUijklCyMcqGmauH3FuxP/+7FKrJUTCs00MFUVHHChSZ+ggR34ob3zX/DziqTlX38sKxO5YduvXB/IpCxPtU/EfUBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250334; c=relaxed/simple;
	bh=eMXALHP7X2YfG/Fchz9hrRxbckSdspy+ZVInY/xaFuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp/IbbY7nMFeZgyhc9R1TnE3gpHHAI8IevGzcH1HWBm5z9WB1vufSUlltVLYDzKfJRbK5Szzg/dwCMijTuPFOnypse6QI2EYXXn5wXGZFJs44qYNMIl2h6rFEXzVPKL+S31yH9PVXAiDJUPjAUpoE+k0JZGxBTiDucK5yAr39cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=usFHXj3w; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a26df89c-5504-445d-a639-ffd2d12efaf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773250318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyM17D46yinvuYWaZAzccGihacHtVbtTSHoTyuFgaKc=;
	b=usFHXj3w2AqXsJ1LOeGv31v5R1ETaH6/W/uYTGsa7F+xPjIgKyARdhZOrkYilhGHFs7aLY
	FM5REEnhV2QC9XKTI0PNHZnhd3aPQ9YOxkViH3/x/z/lZQarLQkOIxJBcumL6qqwh4i9bR
	tOTWYERaHxlalspfyH7cH1wJ2iLp7iY=
Date: Wed, 11 Mar 2026 10:31:48 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <87seabu8np.fsf@DESKTOP-5N7EMDA>
 <977dc43d-622c-411d-99a6-4204fa26c21e@linux.dev>
 <87cy1boyzd.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <87cy1boyzd.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14766-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E7E82680CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 7:56 PM, Huang, Ying wrote:
> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
> 
>> On 3/7/26 4:27 AM, Huang, Ying wrote:
>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>>
>>>> When investigating pressure on a NUMA node, there is no straightforward way
>>>> to determine which policies are driving allocations to it.
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters track allocations to nodes and also whether the allocations were
>>>> intentional or fallbacks.
>>>>
>>>> The new stats follow the existing numa hit/miss/foreign style and have the
>>>> following meanings:
>>>>
>>>>     hit
>>>>       - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>>>>       - for other policies, allocation succeeded on intended node
>>>>       - counted on the node of the allocation
>>>>     miss
>>>>       - allocation intended for other node, but happened on this one
>>>>       - counted on other node
>>>>     foreign
>>>>       - allocation intended on this node, but happened on other node
>>>>       - counted on this node
>>>>
>>>> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
>>>> in /proc/vmstat.
>>> IMHO, it may be better to describe your workflow as an example to
>>> use
>>> the newly added statistics.  That can describe why we need them.  For
>>> example, what you have described in
>>> https://lore.kernel.org/linux-mm/9ae80317-f005-474c-9da1-95462138f3c6@gmail.com/
>>>
>>>> 1) Pressure/OOMs reported while system-wide memory is free.
>>>> 2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
>>>> down node(s) under pressure. They become available in
>>>> /sys/devices/system/node/nodeN/vmstat.
>>>> 3) Check per-policy allocation counters (this patch) on that node to
>>>> find what policy was driving it. Same readout at nodeN/vmstat.
>>>> 4) Now use /proc/*/numa_maps to identify tasks using the policy.
>>>
>>
>> Good call. I'll add a workflow adapted for the current approach in
>> the next revision. I included it in another response in this thread, but
>> I'll repeat here because it will make it easier to answer your question
>> below.
>>
>> 1) Pressure/OOMs reported while system-wide memory is free.
>> 2) Check /proc/zoneinfo or per-node stats in .../nodeN/vmstat to narrow
>>     down node(s) under pressure.
>> 3) Check per-policy hit/miss/foreign counters (added by this patch) on
>>     node(s) to see what policy is driving allocations there (intentional
>>     vs fallback).
>> 4) Use /proc/*/numa_maps to identify tasks using the policy.
>>
>>> One question.  If we have to search /proc/*/numa_maps, why can't we
>>> find all necessary information via /proc/*/numa_maps?  For example,
>>> which VMA uses the most pages on the node?  Which policy is used in the
>>> VMA? ...
>>>
>>
>> There's a gap in the flow of information if we go straight from a node
>> in question to numa_maps. Without step 3 above, we can't distinguish
>> whether pages landed there intentionally, as a fallback, or were
>> migrated sometime after the allocation. These new counters track the
>> results of allocations at the time they happen, preserving that
>> information regardless of what may happen later on.
> 
> Sorry for late reply.
> 
> IMHO, step 3) doesn't add much to the flow.  It only counts allocation,
> not migration, freeing, etc.

This logic would undermine other existing stats.

> I'm afraid that it may be misleading.  For
> example, if a lot of pages have been allocated with a mempolicy, then
> these pages are freed.  /proc/*/numa_maps are more useful stats for the
> goal.

numa_maps only show live snapshots with no attribution. Even if we
tracked them over time, there's no way to determine if the allocations
exist as a result of a policy decision.

> To get all necessary information, I think that more thorough
> tracing is necessary.

Tracking other sources of pages on a node (migration, etc) is
beyond the goal of this patch.

