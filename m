Return-Path: <cgroups+bounces-14003-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF8fM7z+lWkDYAIAu9opvQ
	(envelope-from <cgroups+bounces-14003-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:02:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BD1587AC
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CD1C301626A
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72134343D8A;
	Wed, 18 Feb 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pIrisjkg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC2327C07
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437752; cv=none; b=krPWovh0W00FTquSXThjKEI5I4wUm+0Hmrgv54dlI7BYmLweVkLKFrLPlBIcGOHk8FI0N6G+I6/P+PG6HMNUV5Ahyqt+Fg36TchqeQoiIq61aNGUkizkEE/TErHBGGBZbOjGRa1rqymyrBmLp6YVkA7LTTC2Q6M8VkJXUAgxzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437752; c=relaxed/simple;
	bh=MpPgHuBmwTC47RFlVTXxlEK3TC+OVeEmSrRINnoCdIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAllmhJfu0APC8WR2F+grUZ51mq0dUyHmLne67h+hO7/MgjQM+0oxfDUO0P3P92dwGIM9YJYiE1WfwKXJzl+Wk+jmLb1jmt4LJefQusQ2ZaCC/Uj1yLLdi5GGpc76/dLvReaToXTWulW5Mb4bzqONtm+tL3I38ELFoD8f0gebbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pIrisjkg; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbcd6770-f555-443c-b5f2-fe5e73722118@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771437748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cx1YFMXeXn8Jw1SsA/vK5p52GVwbuIAqyFb1QuBwKqE=;
	b=pIrisjkgRvEhyzm7mm89uxk+UXLZ3lxBEZan3dCK+yy0F568+BiAbZu8NBsKky8pzCkCCT
	uUW9PM9BMQvrw7vEkEVZlCqeTiQ4DXVLb5kwHS4v2KGbO/FRZ97l15af7lOF568zsJcNJd
	ZDigBiY/QGr91OsSfQbgpnzWCW/+E/c=
Date: Wed, 18 Feb 2026 10:02:15 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: move pgscan and pgsteal to node stats
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <10434f89-fe2a-4cfc-9b29-1cd2ed2bbb7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-14003-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 449BD1587AC
X-Rspamd-Action: no action

On 2/18/26 12:54 AM, Vlastimil Babka (SUSE) wrote:
> On 2/18/26 04:29, JP Kobryn (Meta) wrote:
>> From: JP Kobryn <jp.kobryn@linux.dev>
>>
>> There are situations where reclaim kicks in on a system with free memory.
>> One possible cause is a NUMA imbalance scenario where one or more nodes are
>> under pressure. It would help if we could easily identify such nodes.
>>
>> Move the pgscan and pgsteal counters from vm_event_item to node_stat_item
>> to provide per-node reclaim visibility. With these counters as node stats,
>> the values are now displayed in the per-node section of /proc/zoneinfo,
>> which allows for quick identification of the affected nodes.
>>
>> /proc/vmstat continues to report the same counters, aggregated across all
>> nodes. But the ordering of these items within the readout changes as they
>> move from the vm events section to the node stats section.
>>
>> Memcg accounting of these counters is preserved. The relocated counters
>> remain visible in memory.stat alongside the existing aggregate pgscan and
>> pgsteal counters.
>>
>> However, this change affects how the global counters are accumulated.
>> Previously, the global event count update was gated on !cgroup_reclaim(),
>> excluding memcg-based reclaim from /proc/vmstat. Now that
>> mod_lruvec_state() is being used to update the counters, the global
>> counters will include all reclaim. This is consistent with how pgdemote
>> counters are already tracked.
> 
> Hm so that leaves PGREFILL (scanned in the active list) the odd one out,
> right? Not being per-node and gated on !cgroup_reclaim() for global stats.
> Should we change it too for full consistency?

I'm fine with adding coverage for the active list side as well. For
completeness, I could also include PGDEACTIVATE.

