Return-Path: <cgroups+bounces-16297-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJWRBVhbFWp7UgcAu9opvQ
	(envelope-from <cgroups+bounces-16297-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:35:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911B5D2848
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0503019512
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E083BB673;
	Tue, 26 May 2026 08:35:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E572355F49;
	Tue, 26 May 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784531; cv=none; b=iyVhM41Q6b1gBTecKFX5fFQz3dINTf+X1ZXvicIwd/fagzwS/BZB1zn4e1mhUC1/o4XtG0NSG46hKc1No+sqZP7Ewa2oS6JFTrknHYe/gJozPFykn5a2U1/xGDIpR4R4X0PFYUwrmKDsnzg1AlDfJ5jD+7bVUzw4RR5/ljNP2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784531; c=relaxed/simple;
	bh=lWKjpSlEzTsZHdihsOIjr1vlj8IggiG9amLSGP6rvuU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ia8CUZf9ZHt38SE1SP1fqbPzdNp1tWPmLQ9igRIGiDBet9bcEp2Qjd6BMULXpNw+M5DhOAt3bSfd+GyRZ3b9nbX2ocm3ceY+7jcH1GMPWqQIXfkCB/x0o3yt5Z0jqyiaRns4mgI9F+0k0R3EHBLyHN1Jj1Z/M+sYWEhw+Y9wyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27FBC3EBB8;
	Tue, 26 May 2026 08:35:19 +0000 (UTC)
Message-ID: <f8f08e5a-9801-45ff-9350-c3c88599f19c@ghiti.fr>
Date: Tue, 26 May 2026 10:35:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: percpu: charge obj_exts allocation with
 __GFP_ACCOUNT
From: Alexandre Ghiti <alex@ghiti.fr>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Vlastimil Babka <vbabka@kernel.org>, Yosry Ahmed <yosry@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Chengming Zhou <chengming.zhou@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, Wei Xu <weixugc@google.com>,
 Yuanchu Xie <yuanchu@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260511202136.330358-1-alex@ghiti.fr>
 <20260511202136.330358-3-alex@ghiti.fr> <ag8-Dfoco9qQho0A@linux.dev>
 <b434907e-2036-4260-bced-1adb8e26c917@ghiti.fr>
Content-Language: en-US
In-Reply-To: <b434907e-2036-4260-bced-1adb8e26c917@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTGmR5l3NgefEEZKglBnN+xbss2Eg7C7+y8areTebhSg75VGARYPK55R/h8z5vFFlLxQ+dw7qv2FJH1yCZG1eT0B1VzEgTt/oWrGhWSdbPA1FW0WEBMXpG4nHR2vym1CVm7D+bP5FCLFcomV7E3Gvf/K6yKAn/wFqT3iUtr9forSTflY/FSXK73qUhYeQZp5pHi7+cFZSB4p/je+OScL5Z2JUyUKehjwwjV9ppsRgFDvRZGVk+aIgpRpW1WGvYUbMTDGVt16T1X9EgxSbeL2nIAGn3CANu4iqqbSklKhTHEnlz+GA8OG2vO2I+RWak6IX5w5ogaQravzQrguM4zr2aRTRcmryhskQuotCwDl6/3ePVr4KecI4Au6Fz1m+1XlurH1JmXn0IwHeHcLcH1b7dwlmzR8o2pHsX3MDqNB+PRt/zzP9jmJy3+nDE62LdGrlm8MNU69BKYByNYFy5qsTalUDY1dTCPnk1P7uuuiayYPGj2PII20ytH2BUWGUTlDd1kaAWt0hBX1PXob6aGHe2DEZKS76RMSkPcYcTAeqUXal/s22eltdGs9LKQK3zz6+/aTWM8C20iaCGKZH/Bad1Zfp5EPf8H3V3qLOZ01j0NAtYYN8yIKgbW3j7oaa2kUM3rzCg52nuLECvgIu0Bk9KjvaBUIPiQwwjIyJixgpVljuw
X-GND-State: clean
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16297-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	DMARC_NA(0.00)[ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6911B5D2848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/22/26 10:11, Alexandre Ghiti wrote:
> Hi Shakeel,
>
> On 5/21/26 19:25, Shakeel Butt wrote:
>> On Mon, May 11, 2026 at 10:20:37PM +0200, Alexandre Ghiti wrote:
>>> This is a preparatory patch for upcoming per-memcg-per-node kmem
>>> accounting.
>>>
>>> pcpu allocations are always fully charged at once using
>>> pcpu_obj_full_size(), which returns the size of the pcpu "metadata" +
>>> pcpu "payload". But metadata and payload may not be allocated on the
>>> same numa node, so charge the metadata independently from the payload.
>>>
>>> Do this by explicitly passing __GFP_ACCOUNT to the obj_exts allocation
>>> and remove its accounting in pcpu_memcg_pre_alloc_hook().
>> Will all the entries in obj_exts array be for the same memcg? If not 
>> then why we
>> are charging the whole array to the one which happen to allocate the 
>> array?
>
>
> Hmm, I overlooked the amount allocated, so that's my mistake: the 
> chunk-allocating-memcg will be charged for all the metadata, although 
> before the charge was distributed. And according to Claude, the 
> metadata would represent 64kB, so not negligible.
>

I realize that I did not mention my setup: I have been testing this 
series on a 176 core machine, and the 64KB that Claude gave me was based 
on a 32K unit_size. But actually it's not right. Here is my understanding:

- unit_size is 512K on this machine, which means that each cpu gets a 
region this size every time a new chunk is allocated => 176 * 512 = 88MB 
per chunk

- obj_exts = unit_size / PCPU_MIN_ALLOC_SIZE * sizeof(pcpuobj_ext) = 
512K * 2  = 1MB (obj_exts is one memcg pointer for each 4B)

Let me know what you think, but I don't think that's acceptable, I'm 
looking into another solution.

Thanks

Alex


>
>>
>> Sorry I don't know the details of percpu allocator, so asking some dumb
>> questions:
>>
>> 1. Does the alloc_percpu() (& similar functions) allocate the 
>> underlying on a
>>     single node or does it allocate memory for each cpu on their 
>> local node?
>>     For slub, it is on the same node, so the situation is easier to 
>> handle.
>
>
> To me, chunk metadata and actual pages are allocated differently:
>
> - pcpu_alloc_pages() tries to allocate the pages on the cpu local node 
> https://elixir.bootlin.com/linux/v7.0.9/source/mm/percpu-vm.c#L95. But 
> to me no guarantee it won't fallback to any other node. And I don't 
> think that __GFP_THISNODE would be a good idea here.
>
> - pcpu_alloc_chunk() uses kmalloc or vmalloc depending on the size, so 
> not attached to specific node, that's why I wanted GFP_ACCOUNT to do 
> the job for us in the first place.
>
>
>>
>> 2. On a typical system how much memory is consumed by obj_exts for 
>> the percpu
>>     allocator chunks? I am wondering if we don't charge it, how much 
>> will we
>>     loose?
>
>
> So according to my previous answer, 64kB. I have just noticed that a 
> bunch of dynamically allocated chunk fields are not accounted either, 
> which again according to Claude represent 2.3kB. I don't have much 
> experience in accounting but that's far from negligible right? Which 
> amount are we keen to lose to make the code simpler (or for other 
> reasons)?
>
>
>>
>> 3. What would be side effect on assuming that obj_exts is on the same 
>> node as
>>     the given chunk?
>
>
> Given the size of obj_exts, overcharging one node while undercharging 
> others?
>
> To conclude, you're right, I did not dive deep enough into the 
> metadata sizes, I'll fix that.
>
> Thanks,
>
> Alex
>

