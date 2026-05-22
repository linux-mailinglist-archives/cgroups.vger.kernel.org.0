Return-Path: <cgroups+bounces-16201-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +cFUHbUPEGqdTAYAu9opvQ
	(envelope-from <cgroups+bounces-16201-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:11:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50885B0608
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD1F300CE75
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA353A6B83;
	Fri, 22 May 2026 08:11:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C73905E7;
	Fri, 22 May 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437486; cv=none; b=r2aj8wk39gn392BD+Ob7eMAChDdqW4p9usV9FueDKwD+BlqB1KvlNKd8GBbOeaecmXD1I7Cp/9mpxP04wIB8GvALHzoWUX39b4qb1vCa4Lum6vNx5AC7+Zc1dehJTEFFbTknh1EDBOP+SSg7b5dodRlVDSxPVbSREOk6vlFA4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437486; c=relaxed/simple;
	bh=y1A7h3pZjeMor1Dy478r4QvAhkGdYoGFaOzFvjoYTYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4kDKaeDZANBhDQukjjqXchSYQMIAQmoOLDcMhJX7KDvx7o5AtlyApWwgFFTKqQ10U2dMGWyrUGHfDsHeBv5COlI1rOfovZsPjx26Y6SEme8PpjesVwGbo7iyddrFeIjgd/iBi4HexS23+nfhxRCcM7hEHQnVgBjTseAC1EBTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1BE13E83F;
	Fri, 22 May 2026 08:11:16 +0000 (UTC)
Message-ID: <b434907e-2036-4260-bced-1adb8e26c917@ghiti.fr>
Date: Fri, 22 May 2026 10:11:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: percpu: charge obj_exts allocation with
 __GFP_ACCOUNT
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
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ag8-Dfoco9qQho0A@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: dmFkZTE6GZhhZQpoR3ySVQqehkrEDRY8i0Z5642swRsrw/EAKy1P+BYfoIDwg5PvM/uODv1MTjcv/PUmQHg//4/wtR0I0DHMAIxCD9C4pjjX+/cUoycfvUfeO3g1TtQhd4mQrDF7/wh3g6QEHgKwcALdpor4k4RkwCurcTlCbTJdbY6CxOXEZpr2/DgGz1A/zLxKOPuZODZ5W/XW6dboQ72sgLC79gW+LS4oGVymE+F+scl/k/8FHgo+5CzjWCZOivLavhG98YXax6kP7uS5f+rdzWKMk/9blt3gtnls922sF2tsJ3YQ097vPlYq+AkqIkp94audac/hlPzJA+zuKiSuQyTXBi94AwmnVZIP/vfrpMql/1SiOGlQszYxPMheB849X0A5K3fWfyHUJhpMpT3ZuKL/BBYFXdvaG9U7Ab86m67ylvhVBpHmw/rUrEObKaXWopNJztoAoKaQ67WSpVsEBcUNpnG0Kg0bjATIWE3M3AY7SUb4UOdjz67GZ5Lgnv2IxkYiL5lovfFeym/N0uwjmPjFA1tGdBc3KJrOwe25iRBMjmurE6s3rPVNpcz7uTb9fzDBGwlJZVu5BdJza47WAnzQs4iG5zqNSY1/OAK225Etmz3L7mgRDXBeHyKntvffSfeRgiM9l39iWoEW+67a5NhLdPGQnReB3trBtAdiY5EsFg
X-GND-State: clean
X-GND-Score: -100
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16201-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Queue-Id: A50885B0608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shakeel,

On 5/21/26 19:25, Shakeel Butt wrote:
> On Mon, May 11, 2026 at 10:20:37PM +0200, Alexandre Ghiti wrote:
>> This is a preparatory patch for upcoming per-memcg-per-node kmem
>> accounting.
>>
>> pcpu allocations are always fully charged at once using
>> pcpu_obj_full_size(), which returns the size of the pcpu "metadata" +
>> pcpu "payload". But metadata and payload may not be allocated on the
>> same numa node, so charge the metadata independently from the payload.
>>
>> Do this by explicitly passing __GFP_ACCOUNT to the obj_exts allocation
>> and remove its accounting in pcpu_memcg_pre_alloc_hook().
> Will all the entries in obj_exts array be for the same memcg? If not then why we
> are charging the whole array to the one which happen to allocate the array?


Hmm, I overlooked the amount allocated, so that's my mistake: the 
chunk-allocating-memcg will be charged for all the metadata, although 
before the charge was distributed. And according to Claude, the metadata 
would represent 64kB, so not negligible.


>
> Sorry I don't know the details of percpu allocator, so asking some dumb
> questions:
>
> 1. Does the alloc_percpu() (& similar functions) allocate the underlying on a
>     single node or does it allocate memory for each cpu on their local node?
>     For slub, it is on the same node, so the situation is easier to handle.


To me, chunk metadata and actual pages are allocated differently:

- pcpu_alloc_pages() tries to allocate the pages on the cpu local node 
https://elixir.bootlin.com/linux/v7.0.9/source/mm/percpu-vm.c#L95. But 
to me no guarantee it won't fallback to any other node. And I don't 
think that __GFP_THISNODE would be a good idea here.

- pcpu_alloc_chunk() uses kmalloc or vmalloc depending on the size, so 
not attached to specific node, that's why I wanted GFP_ACCOUNT to do the 
job for us in the first place.


>
> 2. On a typical system how much memory is consumed by obj_exts for the percpu
>     allocator chunks? I am wondering if we don't charge it, how much will we
>     loose?


So according to my previous answer, 64kB. I have just noticed that a 
bunch of dynamically allocated chunk fields are not accounted either, 
which again according to Claude represent 2.3kB. I don't have much 
experience in accounting but that's far from negligible right? Which 
amount are we keen to lose to make the code simpler (or for other reasons)?


>
> 3. What would be side effect on assuming that obj_exts is on the same node as
>     the given chunk?


Given the size of obj_exts, overcharging one node while undercharging 
others?

To conclude, you're right, I did not dive deep enough into the metadata 
sizes, I'll fix that.

Thanks,

Alex


