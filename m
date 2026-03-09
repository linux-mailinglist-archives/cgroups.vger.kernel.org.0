Return-Path: <cgroups+bounces-14707-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ls7tAa9IrmkKBwIAu9opvQ
	(envelope-from <cgroups+bounces-14707-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 05:12:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF92339D7
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 05:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 548BC3015721
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0C261B8D;
	Mon,  9 Mar 2026 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ieW0DHeZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6017993
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029546; cv=none; b=E0jVJCiWqLkn/lTi4icbu6ZGscNZn5CnS+fbuHs6EK3RGIyy14a78Mk7ikHBGpQmxvTwxOEwRW6bsl0iy6F79c1HyWweTJCXrWeATbOkdDbHipWHzz2bdcJpheDSWd9W+EOfAzGHcOvYZXu0vQgRU53IitNfp/lgSKkr2O1AX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029546; c=relaxed/simple;
	bh=Je4Stp6boi44mOQhFSCkCsvqqlxHprSomsqS+nsOZyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trUGQ3i0viUD/Sk8ct2iDdE6SI7djGnN5YyUVhxXOXqr1CIdU+wqhOrXltiM31TpsXLmZUt0esacpunXmXmZmhnoXns+8we3Gz8XoR4O1cdbPXUiM5Bydw8HP6kLRoaGJb1yLev4tzXb4pG5lQ3/6h6JjdZHWmVfNoyFJdqoAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieW0DHeZ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0829a4f6-f885-4727-b9bb-b274fd444b5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773029533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+We0UTCfei8hJDh4dOY5+VilrUyV36V3uZTQdBlRfg=;
	b=ieW0DHeZxDFVY9pCFQ77R7jbAOeRtZSOCy3S74dqwXfxr6WmNfhFbhv92YTa39I40TYVK9
	TfzDax1iWH4zLO74kWRVKpvQgJ/mWwbzO7RB57vZkDSrgm/MuYHALYPZ7xuJ4dbpm59ABK
	Ab7q6dvbWfsONJI36NxztfUOmivs8Zk=
Date: Sun, 8 Mar 2026 21:11:59 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: Gregory Price <gourry@gourry.net>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, jasowang@redhat.com, hannes@cmpxchg.org,
 joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <87seabu8np.fsf@DESKTOP-5N7EMDA> <aa3MBp0JhUN6zE8i@gourry-fedora-PF4VCD3F>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <aa3MBp0JhUN6zE8i@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C9CF92339D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14707-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On 3/8/26 12:20 PM, Gregory Price wrote:
> On Sat, Mar 07, 2026 at 08:27:22PM +0800, Huang, Ying wrote:
>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>
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
>>
>> IMHO, it may be better to describe your workflow as an example to use
>> the newly added statistics.  That can describe why we need them.  For
>> example, what you have described in
>>
>> https://lore.kernel.org/linux-mm/9ae80317-f005-474c-9da1-95462138f3c6@gmail.com/
>>
>>> 1) Pressure/OOMs reported while system-wide memory is free.
>>> 2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
>>> down node(s) under pressure. They become available in
>>> /sys/devices/system/node/nodeN/vmstat.
>>> 3) Check per-policy allocation counters (this patch) on that node to
>>> find what policy was driving it. Same readout at nodeN/vmstat.
>>> 4) Now use /proc/*/numa_maps to identify tasks using the policy.
>>
>> One question.  If we have to search /proc/*/numa_maps, why can't we
>> find all necessary information via /proc/*/numa_maps?  For example,
>> which VMA uses the most pages on the node?  Which policy is used in the
>> VMA? ...
>>
> 
> I am a little confused by this too - consider:
> 
> 7f85dca86000 interleave=0,1 file=[...] mapped=14 mapmax=5 N0=3 N1=10 ...
> 
> Is n0=3 and N1=10 because we did those allocations according to the
> policy but got fallbacks, or is it that way because we did 7/7 and
> then things got migrated due to pressure?

That ambiguity should be resolved with this patch.

> 
> Do these counters let you capture that, or does it just make the numbers
> even more meaningless?

You would be able to look at the new counters and see that the
allocations were distributed evenly at the time of allocation. If an
imbalance is observed afterward we would know that it was due to
migration.

> 
> The page allocator will happily fallback to other nodes - even when a
> mempolicy is present - because mempolicy is more of a suggestion rather
> than a rule (unlike cpusets).  So I'd like to understand how these
> counters are intended to be used a little better.

That was the motivation for v2. In the previous rev, there was debate on
the lack of accounting for the fallback cases. So in this patch we
account for the fallbacks by making use of miss/foreign. In terms of how
the counters are intended to be used, the workflow would resemble:

1) Pressure/OOMs reported while system-wide memory is free.
2) Check /proc/zoneinfo or per-node stats in .../nodeN/vmstat to narrow
    down node(s) under pressure.
3) Check per-policy hit/miss/foreign counters (added by this patch) on
    node(s) to see what policy is driving allocations there (intentional
    vs fallback).
4) Use /proc/*/numa_maps to identify tasks using the policy.

