Return-Path: <cgroups+bounces-15936-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLtjBOB9BWrjXgIAu9opvQ
	(envelope-from <cgroups+bounces-15936-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:46:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876F53EEF3
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0312E300C000
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852333C553A;
	Thu, 14 May 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LnuxCmOE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE23B5E15
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744792; cv=none; b=dlQhZkk1ju+96cUbkqgH0kTg95kB1J5hQ/HFKIM8DJvy5riQFpyimHl6hCJK+eDQQ1pv/+4BWSlL9s0zD8V+cr/J0WXM9YhCR1e+abiuPIgBiHdj/VK9mLcRFlgCgVU+THpgcx6mu/wv4240VCfgMU0x1CICWs9GrZb3zLnZA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744792; c=relaxed/simple;
	bh=QTXfmFdDXFBYEfG6I6dRnP123e7jkN4kr88HIs+Au0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvT0fEw32fgZTuHdGv8BtZjiOwb4FJopp27YWogTPIO3lO+vpoHss4m/M5svYwjdk2om5JlCB2KdLbJDZKjkC/Inwn+qEQPxcp90Axte/P5gOo/tr9pt0gSe5rgDP96dgp6K75Ho4pLhGxioVNgf4zYYmdu50x0VK3WZOVMHRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LnuxCmOE; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778744786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BXh7Wq3QIg5RrVVGGpiWPGFI8Di4Dx49OSkadeSPsk=;
	b=LnuxCmOE/Gt9rOs6iQDfu++nrJdD3Dr7snau9TxwVon6wjjgXBsx51tlvO4SmGP6EL18mF
	UfdVt2E/i4rSLYRU1nZWUUFNi7Qc81c236yHMNGcbcyDu4gUdcTv30xImxIisvC0R9zWkW
	Qx+0qbUp/x29Tjx6uP8IyFf1sgCBAfA=
Date: Thu, 14 May 2026 15:46:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
To: Shakeel Butt <shakeel.butt@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, David Carlier
 <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, David Hildenbrand <david@kernel.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 Imran Khan <imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Lance Yang <lance.yang@linux.dev>, Liam Howlett <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>, Nhat Pham <nphamcs@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <202605121641.b6a60cb0-lkp@intel.com> <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev> <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <agSJ4ulNDZ17ah8H@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8876F53EEF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15936-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,linux.dev,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action


On 5/13/26 10:27 PM, Shakeel Butt wrote:
> On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
>> On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
>>>
>>>
>>> On 5/13/26 12:03 AM, Shakeel Butt wrote:
>>>> On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
>>>>>
>>>>>
>>>>> commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> This is most probably due to shuffling of struct mem_cgroup and struct
>>>> mem_cgroup_per_node members.
>>>
>>> Another possibility is that after objcg was split into per-node, the
>>> slab accounting fast path is still designed assuming only one current
>>> objcg per CPU:
>>>
>>> struct obj_stock_pcp {
>>>      struct obj_cgroup *cached_objcg;
>>> };
>>>
>>> So it's may cause the following thrashing:
>>>
>>>   CPU stock cached = memcg/node0 objcg
>>>   free object tagged = memcg/node1 objcg
>>>   => __refill_obj_stock --> objcg mismatch
>>>       => drain_obj_stock()
>>>       => cache switches to node1 objcg
>>>
>>>   next local allocation tagged = node0 objcg
>>>   => mismatch again
>>>       => drain_obj_stock()
>>
>> Actually I think this is the issue, we have ping pong threads running on
>> different nodes where though theu are in same cgroup but their current->obcg is
>> for local node and thus this ping pong is thrashing the per-cpu objcg stock.
>>
>> The easier fix would be to compare objcg->memcg instead of just objcg during
>> draining and caching. In addition we can add support for multiple objcg per-cpu
>> stock caching.
> 
> Something like the following:
> 
>  From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Wed, 13 May 2026 07:24:55 -0700
> Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
>   shares memcg
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>   mm/memcontrol.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d978e18b9b2d..01ed7a8e18ac 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>   			       unsigned int nr_bytes,
>   			       bool allow_uncharge)
>   {
> +	struct obj_cgroup *cached;
>   	unsigned int nr_pages = 0;
>   
>   	if (!stock) {
> @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>   		goto out;
>   	}
>   
> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> +	cached = READ_ONCE(stock->cached_objcg);
> +	if (cached != objcg &&
> +	    (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
>   		drain_obj_stock(stock);
>   		obj_cgroup_get(objcg);
>   		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)

This change looks like it should be able to fix the ping-pong issue, but
I stiil haven't reproduced the performance regression locally. I'll
continue testing it.

Hi kernel-test-robot, could you help check if the patch above fixes the
issue on your end?

Thanks,
Qi



