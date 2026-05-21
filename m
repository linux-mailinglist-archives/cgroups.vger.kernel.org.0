Return-Path: <cgroups+bounces-16158-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CihAS0OD2qSEgYAu9opvQ
	(envelope-from <cgroups+bounces-16158-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:52:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C35A6656
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1228305D5E0
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD043D6462;
	Thu, 21 May 2026 13:00:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527D3D522C;
	Thu, 21 May 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368448; cv=none; b=YUZKeqfSHLQo5brYISlUTwG5Qbv/jFYml15dCViKeDDyjmS+0kth+fEjpDsG4qMQErkDVl+tpVeNCMBSNi8Wx3myvdoffKeuknTyffCBlcLsYZdmCnm6n10lp89XbaDbslsxRgpin0re8xQrSGLV7MKRPFb9lM2YosgbHDZckCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368448; c=relaxed/simple;
	bh=vtEWoNZnQ4TwzCqmNYmNdFpgnvHRcq8uJ2zXSX1kEPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsNDBeVVI8gn3hspJOMl6KIjB/oV6i53ujP2QuBXJWHI9HM7C/c9Iy3j0tu7YUgw3HCM0ZTaBvHRVXXUu181Mfmpj33PL6tuWDOnwz+mdUYb6ox6XZdmV7ZSXWG6KdwtCriMuxFazKrSlPGnE7apnK2Xm2+Do9ANULqxxZ5WFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2207A3EC4E;
	Thu, 21 May 2026 13:00:32 +0000 (UTC)
Message-ID: <f942b897-4fc4-4f3f-a1e2-c0d90c99c5e6@ghiti.fr>
Date: Thu, 21 May 2026 15:00:31 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] per-memcg-per-node kmem accounting
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Vlastimil Babka <vbabka@kernel.org>,
 Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, Wei Xu <weixugc@google.com>,
 Yuanchu Xie <yuanchu@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <20260521034604.4126295-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20260521034604.4126295-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFmsEyfNc68qrqRIOts4zs413bzwTXVyXR1l7lXbRsVt6n4nUhPDqj1pajky4uCr+YZ1zTEH+7veoCTLY+HNEX3lmo1mb8YffUJVTrBlLzbGqFHBXRpEs+bq3p61Zv4nTUxoWCa35x9Ta0eUlH5bBKjc3luGFOKaL0BgT3W3PyuRCBQjurKDhrMgPh6m1cdbh1YbVRvwO5OdT+mFeqF+Tg/TTmQaqKvkeitSksmpWzB01IIIlg8v+EvGL+8+9sCBhARvpS9yBVGKIEnh7bB19GKR2gAGYC2fVjjISGpZHO/6bP89RRpdlOUaMuTs7AMLo4e6Q02XSPUPidz41t0YXaYIY/4FBCiVhAH15wU3hcGrmRYYTbhTCy5sPGHVRYhp5F1pLJI9pBzoHMFpU2lE9459XKbb0znW1LJ5Mbu6wQANRBPrbbBJ7L2mMddJAj0EDZqzHj2E0he2bd5oNmDcIU3zx4ZYU6F8/fTYVu83ID2a/Tq15TicNGnDUR1UbVnn5GH6B1MWvgni6LEKHnOxDuC/CnE+rX9Xv2+rrF8cUhET4h8hK/stGBaJKtuW8TaHNhQ1lOr+/gPVKGDBiyCJrfEcqZlPiwu5UPPWnIONpfnkbefjYuoEsiWSlWD3J8sHW5mGQBIl4u97E10Z/AhykQqwBe1d/pe0GE3F6ZbZZrJZA
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16158-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ghiti.fr:mid,ghiti.fr:email]
X-Rspamd-Queue-Id: 7B9C35A6656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 05:46, Joshua Hahn wrote:
> On Wed, 20 May 2026 10:39:59 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> Hi Joshua,
>>
>> On 5/18/26 16:57, Joshua Hahn wrote:
>>> On Mon, 11 May 2026 22:20:35 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>
>>>> This series pursues the work initiated by Joshua [1]. We need kernel
>>>> memory to be accounted on a per-node basis in order to be able to
>>>> know the memcg and physical memory association.
>>>>     
>>>> This series takes advantage of the recent introduction of per-node
>>>> obj_cgroup [2] and makes those obj_cgroup tied to their numa node.
>>>>     
>>>> The bulk of the series is percpu per-node accounting: percpu
>>>> "precharges" the memcg before we know the actual location of the pages
>>>> it uses, so charging and accounting had to be split. All other kmem
>>>> users (slab, zswap, __memcg_kmem_charge_page) are straightforward
>>>> conversions (zswap support is limited in this series because Joshua
>>>> is working on it in parallel [3]).
>>>>    
>>>> Thanks Joshua for your early feedbacks!
>>> Hello Alex,
>>>
>>> Thank you for your work!
>>>
>>> Overall I think the direction makes sense to me. Pre-overcharging makes sense to
>>> me as an approach, we would much rather overaccount than underaccount and
>>> later have to breach limits.
>>>
>>> I do have some concerns on performance, though. Namely, I think there are
>>> some expensive operations that I think would benefit from some performane
>>> benchmarking with this patch added (maybe some simple microbenchmarks that
>>> demonstrates kernel allocation overhead could be useful).
>>>
>>>   From what I can tell, there is some additional performance overhead that has
>>> to do with iterating over num_possible_cpus() x pages_per_alloc, which
>>> doesn't seem trivial to me.
>> Indeed, let me microbenchmark the overhead on a large system.
> Hi Alex,
>
> That sounds great with me : -) Looking forward to the numbers!
>
>>> Another concern that I see is the stock credit system. Maybe we could be
>>> bypassing the stock check leading to more time spent doing the atomic
>>> operations.
>> I'm not following on this one, which atomic operations do you see that
>> could be bypassed?
> So in my initial scan of the patch 7 I had a concern that if we have a nested
> stock system (obj_cgroup stock and local credit "stock"), then we could
> incur more work if these are out of sync; do extra work in the stock refill
> path in obj_cgroup_precharge, and then do extra work on top in the loop
> within the pcpu_memcg_post_alloc_hook (obj_cgroup_account_kmem does the
> charging atomically I think).
>
> So what I mean is, I'm not sure what the "size" is typically for
> pcpu_memcg_post_alloc_hook. But it might be a worthwhile optimization to
> do precharge all the pages, then for each cpu iterate over the pages to
> figure out how many pages are used per nid (doing just math, not actually
> doing the atomic adds), and then outside both of these loops just iterate
> over every nid_objcg once to perform the atomic operation.
>
> Maybe this is needed or not (depending on how big "size" typically is
> and whether we go from doing O(1000) atomic adds --> O(10) or some
> big reduction, but I just wanted to toss it out there as something that
> could potentially be expensive.


I get it, I'll trace the microbenchmarks to see what happens there, 
thanks for the suggestion.

Thanks again,

Alex


>>> obj_stock caches a single obj_cgroup, which means that if we split the objcg
>>> to be per-node (in patch 6), then the obj_stock basically gets invalidated
>>> every operation since we iterate over more objcgs (even though we are in
>>> the same logical objcg). Maybe I'm missing something?
>>
>> The objcg split comes from commit 01b9da291c49 ("mm: memcontrol: convert
>> objcg to be per-memcg per-node type") and the problem you describe is
>> exactly what Shakeel is trying to fix [1].
> Whoops O_o I completely missed that one. Sorry for flagging it again!
>
>> But I remember trying a microbenchmark and noticed a +5% regression (on
>> top of the 67% then...), I'll rebase this series on top of Shakeel's and
>> re-run.
> Sounds like a great idea! Thanks again Alex, have a great day! : -)
> Joshua

