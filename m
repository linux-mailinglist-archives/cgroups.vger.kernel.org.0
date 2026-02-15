Return-Path: <cgroups+bounces-13961-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dSQSGc51kWnBiwEAu9opvQ
	(envelope-from <cgroups+bounces-13961-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 08:29:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFEF13E397
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6868D300490A
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A787299923;
	Sun, 15 Feb 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZmYS8zv1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DB1862
	for <cgroups@vger.kernel.org>; Sun, 15 Feb 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771140553; cv=none; b=hHjKqklMrNgBCf34QoHtszop6GDtBex3R9zDJeykFEhuuHm9WV8RwMJtjzbl4xxUKP54Y+s1fVZBAZr9q7LB5q36eYvT3qYDGY84aVyn2kAXdenF5qap29MqwKJOABs34l/uRDmMOVtGQVr1aC0HcS1JjQILQCen1NZRqhloHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771140553; c=relaxed/simple;
	bh=ThZ1j9PUQSBL9DjcFKSrkjuGJ1dYOfl0vsw/9gU+gjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqvXHBHrF34iwi8TOAelwus3BAFFSj5AnKkhsFSGoIU3EgZYkkOUQNqgygt+XbWN5aT9VwyQ9foi+ctNDhDFTK0/FkvKJFq/VXwdp3HDlMCRfLchcO+CIvN94Xdf7m4AHVqurC2WRnib23+uHVKPt+DRNUGVu3jyU70cw7Wfo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZmYS8zv1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e178b4e-a9e0-44dc-a18d-8c014365ee2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771140548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaUSkkuQJofxBHkox8rsl9hWWFEkHV2aAas3PKJ8HkM=;
	b=ZmYS8zv1jl3id/SALH3E1caXqMgXG64D/zHcfOV9yALlFnQAAOgXoaMYN8G6BVHTUFM0Wo
	eCCHQTErQDaCeHlva3gg/Q2YRDwD8gj1ezn8i0MKmmJIqIOHiO0bB+9VWqySaMbghh0EDo
	e98G07fXbtM3Un95sSEEVJ4DSdmCX/4=
Date: Sun, 15 Feb 2026 15:28:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 26/31] mm: vmscan: prepare for reparenting MGLRU folios
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <2cea0e0cf208e46dc55f2baef8162bedba2db47e.1770279888.git.zhengqi.arch@bytedance.com>
 <aY2Tem0Fn6dIknXP@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aY2Tem0Fn6dIknXP@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13961-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bytedance.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: BEFEF13E397
X-Rspamd-Action: no action



On 2/12/26 4:46 PM, Harry Yoo wrote:
> On Thu, Feb 05, 2026 at 05:01:45PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to traditional LRU folios, in order to solve the dying memcg
>> problem, we also need to reparenting MGLRU folios to the parent memcg when
>> memcg offline.
>>
>> However, there are the following challenges:
>>
>> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>>     number of generations of the parent and child memcg may be different,
>>     so we cannot simply transfer MGLRU folios in the child memcg to the
>>     parent memcg as we did for traditional LRU folios.
>> 2. The generation information is stored in folio->flags, but we cannot
>>     traverse these folios while holding the lru lock, otherwise it may
>>     cause softlockup.
>> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>>     may be updated, but the folio is not immediately moved to the
>>     corresponding lru list. Therefore, there may be folios of different
>>     generations on an LRU list.
>> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>>     found based on the generation information in folio->flags, and the
>>     corresponding LRU size will be updated. Therefore, we need to update
>>     the lru size correctly during reparenting, otherwise the lru size may
>>     be updated incorrectly in lru_gen_del_folio().
>>
>> Finally, this patch chose a compromise method, which is to splice the lru
>> list in the child memcg to the lru list of the same generation in the
>> parent memcg during reparenting. And in order to ensure that the parent
>> memcg has the same generation, we need to increase the generations in the
>> parent memcg to the MAX_NR_GENS before reparenting.
>>
>> Of course, the same generation has different meanings in the parent and
>> child memcg, this will cause confusion in the hot and cold information of
>> folios. But other than that, this method is simple enough, the lru size
>> is correct, and there is no need to consider some concurrency issues (such
>> as lru_gen_del_folio()).
>>
>> To prepare for the above work, this commit implements the specific
>> functions, which will be used during reparenting.
>>
>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mmzone.h |  16 +++++
>>   mm/vmscan.c            | 154 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 170 insertions(+)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 3e51190a55e4c..0c18b17f0fe2e 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index e2d9ef9a5dedc..8c6f8f0df24b1 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> +void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>> +{
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		struct lruvec *child_lruvec, *parent_lruvec;
>> +		int type, zid;
>> +		struct zone *zone;
>> +		enum lru_list lru;
>> +
>> +		child_lruvec = get_lruvec(memcg, nid);
>> +		parent_lruvec = get_lruvec(parent, nid);
>> +
>> +		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1)
>> +			for (type = 0; type < ANON_AND_FILE; type++)
>> +				__lru_gen_reparent_memcg(child_lruvec, parent_lruvec, zid, type);
>> +
>> +		for_each_lru(lru) {
>> +			for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
>> +				unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
>> +
>> +				mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
> 
> This part looks fine, but I think the nr_pages parameter
> in mem_cgroup_update_lru_size() should be long instead of int.
> Could you please update the type as well?

Make sense, and I think it would be better to do this by sending
a separate patch, will do that and add your Suggested-by.

> 
> Otherwise looks good to me,
> Acked-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> 
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   #endif /* CONFIG_MEMCG */
> 


