Return-Path: <cgroups+bounces-15012-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMY4CkwSwmmOZQQAu9opvQ
	(envelope-from <cgroups+bounces-15012-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:25:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04199302032
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C0C13039335
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04860242D60;
	Tue, 24 Mar 2026 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VCisPo8C"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444123E25B
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326343; cv=none; b=uya8ZTaIdptCsIl00Mp920divsiWsFEiRZOsfMWz2UFDp/y0RgBB/G1qSOn0hve5mVqkfxOHVsIWqHoKLM8j3bBpSXX6dCjt4yc0132cWEdCTkO58Lvpp5M0pRH8iYXuurp3ucZiJTvGk5LYNKMYdpH/WsIH7KpGB3ZruafNuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326343; c=relaxed/simple;
	bh=YjMp53OKfadWj+kNw02JjPxJqovKUYQQe19iaJSbxKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh0VVEzeb987ck+K5XqrHo2AYJxHS1g57c0D285ZBWUkYxexKq8dCwtoo5t+myOvqQlqaS4e99nT8O1GCRRqB2ywlizNV5DQHA2dacqM4SLmyRFHA2aDG5Jtxpv2VeKKYVyWE+o3kGWTNqllAenz1dpy41fvWGqEFOniDxl/wQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VCisPo8C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <138d9363-ab0c-4f5c-bedc-b326f5aaee91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774326339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFm4rq63hk/RC8ec4idA1Wj6bRsPq9bmm+kOdtLr6mE=;
	b=VCisPo8Co7n3knIGM0A0ZVk9KeDhkyF3dYJNyIngSsxp5cgCjpBS2vBIAqIineGlMW265t
	Uq314LeejaqmyZiE6GvJye2uYRmVqRhgEWRLaTivnDDhugIdiI4luxhrqq66i5SUKZiMwj
	nIUZDYgdo3d05U+icbURkSf2M1LGkwo=
Date: Tue, 24 Mar 2026 12:25:16 +0800
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
 cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
 <acDxaEgnqPI-Z4be@hyeyoo> <2d39ea5e-fd69-4acf-8518-a504f5f7a838@linux.dev>
 <acExNWaaKdhrBH-J@hyeyoo> <c913ce46-bc83-4d36-b1b0-a51b12e515e9@linux.dev>
 <acINdWKdH_b5LdhH@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <acINdWKdH_b5LdhH@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15012-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 04199302032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 12:05 PM, Harry Yoo (Oracle) wrote:
> On Tue, Mar 24, 2026 at 10:54:48AM +0800, Qi Zheng wrote:
>> On 3/23/26 8:25 PM, Harry Yoo (Oracle) wrote:
>>> On Mon, Mar 23, 2026 at 05:47:27PM +0800, Qi Zheng wrote:
>>>> On 3/23/26 3:53 PM, Harry Yoo (Oracle) wrote:
>>>>> On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng wrote:
>>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>>> index 23b70bd80ddc9..b0519a16f5684 100644
>>>>>> --- a/mm/memcontrol.c
>>>>>> +++ b/mm/memcontrol.c
>>>>>> @@ -473,6 +501,30 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>>>>>     	return x;
>>>>>>     }
>>>>>> +#ifdef CONFIG_MEMCG_V1
>>>>>> +static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
>>>>>> +				     enum node_stat_item idx, int val);
>>>>>> +
>>>>>> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>>>>>> +				       struct mem_cgroup *parent, int idx)
>>>>>> +{
>>>>>> +	int nid;
>>>>>> +
>>>>>> +	for_each_node(nid) {
>>>>>> +		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>>>>>> +		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
>>>>>> +		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
>>>>>> +		struct mem_cgroup_per_node *child_pn, *parent_pn;
>>>>>> +
>>>>>> +		child_pn = container_of(child_lruvec, struct mem_cgroup_per_node, lruvec);
>>>>>> +		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
>>>>>> +
>>>>>> +		__mod_memcg_lruvec_state(child_pn, idx, -value);
>>>>>> +		__mod_memcg_lruvec_state(parent_pn, idx, value);
>>>>>
>>>>> We should probably change the type of `@val` from int to val to avoid
>>>>> losing non hierarchical stats during reparenting?
>>>>
>>>> The parameter and return value of memcg_state_val_in_pages() are both
>>>> of type int, so perhaps we need a cleanup patch to do this?
>>>
>>> Yes!
>>>
>>> and @val in memcg_rstat_updated() too, I think.
>>
>> Right.
>>
>>>
>>>> I will send a cleanup patchset to do this, which includes the following:
>>>>
>>>> https://lore.kernel.org/all/5e178b4e-a9e0-44dc-a18d-8c014365ee2f@linux.dev/
>>>
>>> Thanks!
>>>
>>> Should that ideally be applied before this patchset?
>>
>> This would conflict with the current patchset.
> 
> Right.
> 
>> The v6 has been in mm-unstable for some time
> 
> Right.
> 
>> so I prefer to add a cleanup patchset to
>> avoid interfering with the merge of this patchset.
> 
> but it's a little bit more than a cleanup, no?
> 
> I'd say without the followup, this patchset introduces a very subtle
> (likely nobody would notice) functional regression visible on memcgs
> with billions of pages.

Right.

> 
>> Otherwise, sending v7 might be more appropriate.
>   
> I think it should be sent either as v7 or as part of v7.1-rcX.
> (Whichever way Andrew prefers)

OK, In any case I will first send out the cleanup/fix patchset for
everyone to review.

Thanks,
Qi

> 


