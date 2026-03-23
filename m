Return-Path: <cgroups+bounces-14992-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBgZKwENwWngQAQAu9opvQ
	(envelope-from <cgroups+bounces-14992-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 10:50:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C92EF5D0
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE092303B158
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D719387344;
	Mon, 23 Mar 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwxYaQu1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9A386554
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259284; cv=none; b=UnJO948Tpl/lV+KpVtbU61QkIXBM5oV1odmWaGtg3F/5xUq2bIUn65NBnEoCYW3Aj52aLuk3F7hF3dyeYcKk8NX6jdhXlDDTc09Xyb4wWaIUOYm78r69vw1bXXfz5MMhYNvwTsnfUOruO4bi8cfVAimo9DCknxj/6nr8+efs2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259284; c=relaxed/simple;
	bh=1nIxTQ8RB+SsqjxPcssgtTJZogdHwXUCrsekegajGP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE8sgLbup50INrS7SrYWpDiPc9UpXAgJYJQ+RQ2s4HEb1emxx3FEcTrS/Q5GgMSZFKBGXlPfzl3UxdZhZWPwJKaE9YPSPEJ8xi/zn+LP4k4l7oE3OszIbCFMoE7NkvraCeUDgIYX/7+xdBMRPKEc3KO6KdFnnuV+O644waTzk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwxYaQu1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d39ea5e-fd69-4acf-8518-a504f5f7a838@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774259270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUcyey8JJET54dG1RcxlUPbktgzb/K1oah1AT7wcgO0=;
	b=CwxYaQu1n0VmMyb46AU0irJsJRHETzAAsRr3dEl7G8MuKiYiMDYJxB7bCYjztd8Wlyol9Q
	tvBYS+JsyWstB+h4ToehfXaGvY8XOajahWwp21Dsd6zJj1Oxi8+TUoErpvCTE9LFK/ko7E
	qunY8dUK2nRfmD6DFG1q6p5QnH6u9h4=
Date: Mon, 23 Mar 2026 17:47:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 Yosry Ahmed <yosry@kernel.org>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
 <acDxaEgnqPI-Z4be@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <acDxaEgnqPI-Z4be@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14992-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,bytedance.com:email]
X-Rspamd-Queue-Id: 2A5C92EF5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Harry,

On 3/23/26 3:53 PM, Harry Yoo (Oracle) wrote:
> On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> To resolve the dying memcg issue, we need to reparent LRU folios of child
>> memcg to its parent memcg. This could cause problems for non-hierarchical
>> stats.
>>
>> As Yosry Ahmed pointed out:
>>
>> ```
>> In short, if memory is charged to a dying cgroup at the time of
>> reparenting, when the memory gets uncharged the stats updates will occur
>> at the parent. This will update both hierarchical and non-hierarchical
>> stats of the parent, which would corrupt the parent's non-hierarchical
>> stats (because those counters were never incremented when the memory was
>> charged).
>> ```
>>
>> Now we have the following two types of non-hierarchical stats, and they
>> are only used in CONFIG_MEMCG_V1:
>>
>> a. memcg->vmstats->state_local[i]
>> b. pn->lruvec_stats->state_local[i]
>>
>> To ensure that these non-hierarchical stats work properly, we need to
>> reparent these non-hierarchical stats after reparenting LRU folios. To
>> this end, this commit makes the following preparations:
>>
>> 1. implement reparent_state_local() to reparent non-hierarchical stats
>> 2. make css_killed_work_fn() to be called in rcu work, and implement
>>     get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>>     between mod_memcg_state()/mod_memcg_lruvec_state()
>>     and reparent_state_local()
>>
>> Co-developed-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
>>   kernel/cgroup/cgroup.c |  9 ++--
>>   mm/memcontrol-v1.c     | 16 +++++++
>>   mm/memcontrol-v1.h     |  7 +++
>>   mm/memcontrol.c        | 97 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 125 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 23b70bd80ddc9..b0519a16f5684 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -473,6 +501,30 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>   	return x;
>>   }
>>   
>> +#ifdef CONFIG_MEMCG_V1
>> +static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
>> +				     enum node_stat_item idx, int val);
>> +
>> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>> +				       struct mem_cgroup *parent, int idx)
>> +{
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>> +		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
>> +		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
>> +		struct mem_cgroup_per_node *child_pn, *parent_pn;
>> +
>> +		child_pn = container_of(child_lruvec, struct mem_cgroup_per_node, lruvec);
>> +		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
>> +
>> +		__mod_memcg_lruvec_state(child_pn, idx, -value);
>> +		__mod_memcg_lruvec_state(parent_pn, idx, value);
> 
> We should probably change the type of `@val` from int to val to avoid
> losing non hierarchical stats during reparenting?

The parameter and return value of memcg_state_val_in_pages() are both
of type int, so perhaps we need a cleanup patch to do this?

I will send a cleanup patchset to do this, which includes the following:

https://lore.kernel.org/all/5e178b4e-a9e0-44dc-a18d-8c014365ee2f@linux.dev/

Thanks,
Qi


> 


