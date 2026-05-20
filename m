Return-Path: <cgroups+bounces-16120-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIITEMJ3DWokxwUAu9opvQ
	(envelope-from <cgroups+bounces-16120-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 10:58:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62C58A472
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C450C32DDA97
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1FD3B9DAB;
	Wed, 20 May 2026 08:40:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB703B0AF3;
	Wed, 20 May 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266419; cv=none; b=l1CRvUbkL/UvOD1dCe7myjBK6cDcqRPC9PVZKxcWwUGxQCiVbmJUaG3kaR1Os3YMVV1ZLbAu62AP63mWiuALgU/mlbDe88/Hm+XMqZgSl9kfGpkL/sSV/9FwllVRhqxCfgfkDgJ5dAynIYYG2Qvs1XZwOHszZUXGSj5teiSJoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266419; c=relaxed/simple;
	bh=EilAPoeqML1iQcSZdjE9cVPGE+5RyEhrcN0DHWonRFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgOdhNOpVsVNOU6Q6epOK54H0GilebJUQ2qm0KjS52Ts6RWqPtN9CElfbPyW+b6cSUtSl+HsZNHL4fgZX/myPJfqYbgNiP1U4toNSZXah6p7cYdduN2r80OmW4uMnlgNs81Sqmr5arlKlicOEmT1JjMErSxh5OJ/swexicDRNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B0D83EBC7;
	Wed, 20 May 2026 08:40:03 +0000 (UTC)
Message-ID: <7e28d0c9-80f2-420b-87c4-55e571071059@ghiti.fr>
Date: Wed, 20 May 2026 10:39:59 +0200
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
References: <20260518145732.349196-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20260518145732.349196-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTEDCWN8I9KCg3ODolESpoO8C0U+cgp1vdclwRT2FiWCsJP7mQ/S9Bk8bA5NqEjt69Syv/4OrmyY/GmF7OFXH1yz8GGHmlYmDFs4jgE1XBqREjezj8hlgKNMnNs72ohK6EA2GZ2E5RPntNL87/W0nt5zBFG0+xw7QqNfkdAwc4tT7jRdEcCPGnB1uMvnnsOx84TrsZM7hZkPrJoN1JUdrQoRFBx6DyR8vzq+aLH4NeF1zVnrJhBoblpOLBNdvQXsYvqnvirnSFLqmUQvg1lDnoos7/pwu6cvE9D82wj7zvtmBNEMiJTu2MTmAO0J41ksYyF5yPOhx/97qhbUHAPbsTUDRXIfJvFjwzjr0fCXWdzPzwW4vSN17Jsmqu3qtcVYRaEWMyx2JgoEjbSTzqQxzO08jmV9FjF5OJIc8KuQsxBR3/Nwx7PHE80/GsqTip2bvGdUvn/CMsMYFFXuIidw8KtNtlvOGqdASvgLB3/awxO5Zg7QQ+Pl5KkFYrCV/IPtO5g9zEuNlVn97nCp2j6nI2HoUrOnDmGeS9jWlWYSkPrk7ZtfM9xnBh8f9vVwbCtef9A3C9rVvrmMSglqMCPphLm+ssH9O+IBcsjLXWIRSfKLIvUqUmhQtqyHEjIvMMF/qZRPdmcKDGynf5t4YXC6xpDmLg6useSeWmxvWB+nJJxEnw
X-GND-State: clean
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16120-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 8B62C58A472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joshua,

On 5/18/26 16:57, Joshua Hahn wrote:
> On Mon, 11 May 2026 22:20:35 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> This series pursues the work initiated by Joshua [1]. We need kernel
>> memory to be accounted on a per-node basis in order to be able to
>> know the memcg and physical memory association.
>>    
>> This series takes advantage of the recent introduction of per-node
>> obj_cgroup [2] and makes those obj_cgroup tied to their numa node.
>>    
>> The bulk of the series is percpu per-node accounting: percpu
>> "precharges" the memcg before we know the actual location of the pages
>> it uses, so charging and accounting had to be split. All other kmem
>> users (slab, zswap, __memcg_kmem_charge_page) are straightforward
>> conversions (zswap support is limited in this series because Joshua
>> is working on it in parallel [3]).
>>   
>> Thanks Joshua for your early feedbacks!
> Hello Alex,
>
> Thank you for your work!
>
> Overall I think the direction makes sense to me. Pre-overcharging makes sense to
> me as an approach, we would much rather overaccount than underaccount and
> later have to breach limits.
>
> I do have some concerns on performance, though. Namely, I think there are
> some expensive operations that I think would benefit from some performane
> benchmarking with this patch added (maybe some simple microbenchmarks that
> demonstrates kernel allocation overhead could be useful).
>
>  From what I can tell, there is some additional performance overhead that has
> to do with iterating over num_possible_cpus() x pages_per_alloc, which
> doesn't seem trivial to me.


Indeed, let me microbenchmark the overhead on a large system.


>
> Another concern that I see is the stock credit system. Maybe we could be
> bypassing the stock check leading to more time spent doing the atomic
> operations.


I'm not following on this one, which atomic operations do you see that 
could be bypassed?


>
> obj_stock caches a single obj_cgroup, which means that if we split the objcg
> to be per-node (in patch 6), then the obj_stock basically gets invalidated
> every operation since we iterate over more objcgs (even though we are in
> the same logical objcg). Maybe I'm missing something?


The objcg split comes from commit 01b9da291c49 ("mm: memcontrol: convert 
objcg to be per-memcg per-node type") and the problem you describe is 
exactly what Shakeel is trying to fix [1].

But I remember trying a microbenchmark and noticed a +5% regression (on 
top of the 67% then...), I'll rebase this series on top of Shakeel's and 
re-run.

[1] 
https://lore.kernel.org/linux-mm/20260520053123.2709959-1-shakeel.butt@linux.dev/T/#m127d4969b105c046a2a21e3c79c963771007583d


>
> I haven't taken a deep look at the implementation details but just wanted to
> raise some high level items that I noticed. Of course, all of these concerns
> are just theoretical, if you can show that the performance delta is not
> noticable then all of my concerns don't matter.
>
> I also want to talk more about the local credit system but let's first see
> what the numbers are first.
>
> Thanks again, Alex. And I really like patch 2 because it is a solution to
> a problem that I ran into in my percpu tracking series that I couldn't think
> of before! Thank you for solving my problem too : -)


Great then, thanks :)

Alex


>
> Have a great day!
> Joshua
>     
>> [1] https://lore.kernel.org/linux-mm/20260404033844.1892595-1-joshua.hahnjy@gmail.com/
>> [2] https://lore.kernel.org/linux-mm/56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com/
>> [3] https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/
>>
>> Alexandre Ghiti (8):
>>    mm: memcontrol: propagate NMI slab stats to memcg vmstats
>>    mm: percpu: charge obj_exts allocation with __GFP_ACCOUNT
>>    mm: percpu: Split memcg charging and kmem accounting
>>    mm: memcontrol: track MEMCG_KMEM per NUMA node
>>    mm: memcontrol: per-node kmem accounting for page charges
>>    mm: slab: per-node kmem accounting for slab
>>    mm: percpu: per-node kmem accounting using local credit
>>    mm: zswap: per-node kmem accounting for zswap/zsmalloc
>>
>>   include/linux/memcontrol.h |  27 +++++--
>>   include/linux/mmzone.h     |   1 +
>>   include/linux/zsmalloc.h   |   2 +
>>   mm/memcontrol.c            | 150 ++++++++++++++++++++++++++++---------
>>   mm/percpu-internal.h       |  16 +---
>>   mm/percpu.c                |  90 ++++++++++++++++++++--
>>   mm/vmstat.c                |   1 +
>>   mm/zsmalloc.c              |  11 +++
>>   mm/zswap.c                 |   9 ++-
>>   9 files changed, 242 insertions(+), 65 deletions(-)
>>
>> -- 
>> 2.54.0
>>
>>

