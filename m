Return-Path: <cgroups+bounces-14007-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGKVEugYlmkSaAIAu9opvQ
	(envelope-from <cgroups+bounces-14007-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 20:54:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1B1593E4
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 20:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24293025933
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7D347BC6;
	Wed, 18 Feb 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V/H6/jAe"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A629E114
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444403; cv=none; b=ePdOM/Q/CgNBSwqBpqAYjxFsRGIQGVVeIWxZV3Jl40FkHTJ4txqvgsFJEX4Hams0QiYuTMCvI2XFioL6J6U24AgCv3DBTi5zHkt8nPsNFptQffuufs4V6A03pthA73RDcq6mf1Iys4bhsLnCD6MPg/KPBGVkuFGrJlEpcakvsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444403; c=relaxed/simple;
	bh=G60IxpbYhanmXgFlCPIUDQdnvr93vQ+OEcTO0tgAS/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MlHDExkYIpwvvBZIeMmiVLqnGibcu21/N50V3gThS7DhF4DyN5OoEGoIt6drJZpKFa5oQ0HoVaz+Gx2rOMYs7Oa5kAtftXl0Bw1ID1HQ7vKyNE06lZ+T0XZwoMaYtl/jbMM/W63Jr9q2byiSb2XJ2BZwHInYFDFMbCHxYhGWbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V/H6/jAe; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2397f4cd-367b-421c-b4f0-9c023f6cd546@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771444398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdnOU1vGQA1zKpk8kTMZsw9c7ygfqJl1OhsRupZBpf4=;
	b=V/H6/jAeNBwT5tg4U5BLn/eRMm0dPifz25S3hPq141ITU5c0PWXjdPTF9DGOYil3JLG5j+
	Zg9OGti2fviCFqs+oDIJ0JIwa/ctAUUTxVZyVwbNDChuLvtnfkczZH1sVIHbZIdXvkl8y9
	O45YbBEP+0PZLGANix+9dkY2yESN61w=
Date: Wed, 18 Feb 2026 11:53:09 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: move pgscan and pgsteal to node stats
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 mst@redhat.com, mhocko@suse.com, vbabka@suse.cz
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260218032941.225439-1-jp.kobryn@linux.dev>
 <10434f89-fe2a-4cfc-9b29-1cd2ed2bbb7e@kernel.org>
 <fbcd6770-f555-443c-b5f2-fe5e73722118@linux.dev>
Content-Language: en-US
In-Reply-To: <fbcd6770-f555-443c-b5f2-fe5e73722118@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14007-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 9FA1B1593E4
X-Rspamd-Action: no action

On 2/18/26 10:02 AM, JP Kobryn (Meta) wrote:
> On 2/18/26 12:54 AM, Vlastimil Babka (SUSE) wrote:
>> On 2/18/26 04:29, JP Kobryn (Meta) wrote:
>>> From: JP Kobryn <jp.kobryn@linux.dev>
>>>
>>> There are situations where reclaim kicks in on a system with free 
>>> memory.
>>> One possible cause is a NUMA imbalance scenario where one or more 
>>> nodes are
>>> under pressure. It would help if we could easily identify such nodes.
>>>
>>> Move the pgscan and pgsteal counters from vm_event_item to 
>>> node_stat_item
>>> to provide per-node reclaim visibility. With these counters as node 
>>> stats,
>>> the values are now displayed in the per-node section of /proc/zoneinfo,
>>> which allows for quick identification of the affected nodes.
>>>
>>> /proc/vmstat continues to report the same counters, aggregated across 
>>> all
>>> nodes. But the ordering of these items within the readout changes as 
>>> they
>>> move from the vm events section to the node stats section.
>>>
>>> Memcg accounting of these counters is preserved. The relocated counters
>>> remain visible in memory.stat alongside the existing aggregate pgscan 
>>> and
>>> pgsteal counters.
>>>
>>> However, this change affects how the global counters are accumulated.
>>> Previously, the global event count update was gated on ! 
>>> cgroup_reclaim(),
>>> excluding memcg-based reclaim from /proc/vmstat. Now that
>>> mod_lruvec_state() is being used to update the counters, the global
>>> counters will include all reclaim. This is consistent with how pgdemote
>>> counters are already tracked.
>>
>> Hm so that leaves PGREFILL (scanned in the active list) the odd one out,
>> right? Not being per-node and gated on !cgroup_reclaim() for global 
>> stats.
>> Should we change it too for full consistency?
> 
> I'm fine with adding coverage for the active list side as well. For
> completeness, I could also include PGDEACTIVATE.

Actually, I see PGDEACTIVATE is not gated so I'll leave that one out.
I'll send v3 and include PGREFILL.

