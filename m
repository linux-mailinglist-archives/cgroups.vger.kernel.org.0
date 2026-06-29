Return-Path: <cgroups+bounces-17371-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hlVDL2N3QmqP7wkAu9opvQ
	(envelope-from <cgroups+bounces-17371-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:47:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2440F6DB7A6
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17371-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17371-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455EB30BFF7B
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84E40B371;
	Mon, 29 Jun 2026 13:14:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D1407CC8;
	Mon, 29 Jun 2026 13:14:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738892; cv=none; b=kJY1JuCzC9druFeHXd8ZEzLiOJn0OMmluf8vivA2sI3L31EFOtRiNJvd3k2CEh2uKLd2RGja6sjWS2QWlKi3df1g5ir8DnvXJ5teoJn/PBXo/q+nV5LX4eno6FvkvFL6pt9Q1s84s1gBZwi7WuZQBUCNpPqy/yyKiMDn2rPXAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738892; c=relaxed/simple;
	bh=LHlcCZVMwNEisvjoNMOiY7KIXdSVtEPk80VgY9DZXHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szDtYtlnDxr3KTGSOuJz44Jkvh02rmWfG3OliS86uI26cQgelZvsqHnALKWVYP49d1DLHEf4MgmqWevbORjlnQgaW+QpevCK1vW29qUDXQbqb3iStaBVeoPrvsO9xFOFRWRLKacC1kHfU5fUpjqgsGWYEvz31o8SugSMZurENYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id 732753ECCF;
	Mon, 29 Jun 2026 13:14:33 +0000 (UTC)
Message-ID: <9a8ba4d7-07ea-4ec5-b158-39fff4796f84@ghiti.fr>
Date: Mon, 29 Jun 2026 15:14:32 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] mm: zswap: per-node kmem accounting for
 zswap/zsmalloc
To: Usama Arif <usama.arif@linux.dev>
Cc: alexandre@ghiti.fr, Andrew Morton <akpm@linux-foundation.org>,
 Barry Song <baohua@kernel.org>, Ben Segall <bsegall@google.com>,
 cgroups@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Kairui Song <kasong@tencent.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Liam R. Howlett" <liam@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>
References: <20260626143244.3382853-1-usama.arif@linux.dev>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20260626143244.3382853-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTEhcHMOV035Brtm/30GMjuKs4O8ybg1XVe8gULLwhvSfXgYn07oxXBha1LOO4SZc0DeEFoS5fudMz+QqvNxWMuclG2EXzgnUz6MG7jBufK2db2Pz9S1hTnddmsNtu5odXAl6oVeXxR0rcmAK9ObOWrBAvZKXBtlSRm6CgtBMv7zkkMWiq4Vl5LYcLRwvqr1hwlPXRHgJJan28sAxeLjBHyHXg5Y9oYM5ugZ6syKYnTpW0m5FDejjro5Bl1B/Iwxsd5K1QTgDOXoES7PR+HogJRw9qbSTO5yzpGl9ivh2imPg2lOJkg8lad0v+A6kMv9HLz9heypCNcF+m1F7CIaTNheBvSX5Phu11J0UYB3e+SsRVPSS+RgoVFp+YIOkUE3xtNV+18SAQfjZbAehErT37gVHxCVGXCJWAogFw+aA5RmcmDHa3B1gPoj/jf9UstzQXYLZi9TzbUE3qOcl76zy1i92277AuB7XDy3wNMymBlozSgOPZWPa7GrQQUySNBup8YcCaMlaTy/yJQZGRFXvL6ta7RDywM6fLR7zKoopQZET+W+lLwSrfjp0iChrCh7ktzBUXcaQ1QvtXU2dpvR26M6Q25eG0FDDh8GHdpE7d2UAbK3biF0HG9p8h9YIzjPXJsZ9SUUQti6L86m32FllNJ6njvWI4SXJCU6CM/pMkcOmQ
X-GND-State: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-17371-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ghiti.fr,linux-foundation.org,kernel.org,google.com,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2440F6DB7A6

Hi Usama,

On 6/26/26 16:32, Usama Arif wrote:
> On Fri, 26 Jun 2026 12:20:58 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> Update zswap and zsmalloc to use per-node obj_cgroup for kmem
>> accounting, attributing compressed page charges to the correct
>> NUMA node.
>>
>> But actually, this is incomplete because it does not correctly account
>> for entries that straddle pages, those pages being possibly on 2 different
>> nodes.
>>
>> This will be correctly handled by Joshua in a different series [1].
>>
>> Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/ [1]
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   include/linux/zsmalloc.h |  2 ++
>>   mm/zsmalloc.c            | 11 +++++++++++
>>   mm/zswap.c               | 19 ++++++++++++++++++-
>>   3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
>> index 478410c880b1..30427f3fe232 100644
>> --- a/include/linux/zsmalloc.h
>> +++ b/include/linux/zsmalloc.h
>> @@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
>>   void zs_obj_write(struct zs_pool *pool, unsigned long handle,
>>   		  void *handle_mem, size_t mem_len);
>>   
>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
>> +
>>   extern const struct movable_operations zsmalloc_mops;
>>   
>>   #endif
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index 83f5820c45f9..17f7403ebe77 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
>> @@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned long obj)
>>   	mod_zspage_inuse(zspage, -1);
>>   }
>>   
>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
>> +{
>> +	unsigned long obj;
>> +	struct zpdesc *zpdesc;
>> +
>> +	obj = handle_to_obj(handle);
>> +	obj_to_zpdesc(obj, &zpdesc);
>> +	return page_to_nid(zpdesc_page(zpdesc));
>> +}
>> +EXPORT_SYMBOL(zs_handle_to_nid);
> Does this need the same locking as the other handle-to-zspage paths?
> zs_free() takes pool->lock before handle_to_obj() because zspage migration can
> update or move the object behind the handle. This helper does the same decode
> without the lock, so zswap's uncharge path can race migration and charge or
> uncharge the wrong node, or observe transient zspage state.


You're totally right, I missed this, thanks!

Thanks,

Alex


>
>
>> +
>>   void zs_free(struct zs_pool *pool, unsigned long handle)
>>   {
>>   	struct zspage *zspage;
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 761cd699e0a3..466c6a3f4ef3 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1438,7 +1438,24 @@ static bool zswap_store_page(struct page *page,
>>   	 */
>>   	zswap_pool_get(pool);
>>   	if (objcg) {
>> -		obj_cgroup_get(objcg);
>> +		struct obj_cgroup *nid_objcg;
>> +		int nid = zs_handle_to_nid(pool->zs_pool, entry->handle);
>> +
>> +		/*
>> +		 * obj_cgroup_nid() returns a borrowed RCU pointer (no
>> +		 * reference), so the returned per-node objcg may be freed
>> +		 * (kfree_rcu) before we use it. Pin it with a tryget inside a
>> +		 * single rcu section; if it is already dying, fall back to the
>> +		 * folio objcg (held by the caller) so the charge still lands on
>> +		 * the right memcg, just without per-node attribution.
>> +		 */
>> +		rcu_read_lock();
>> +		nid_objcg = obj_cgroup_nid(objcg, nid);
>> +		if (nid_objcg && obj_cgroup_tryget(nid_objcg))
>> +			objcg = nid_objcg;
>> +		else
>> +			obj_cgroup_get(objcg);
>> +		rcu_read_unlock();
>>   		obj_cgroup_charge_zswap(objcg, entry->length);
>>   	}
>>   	atomic_long_inc(&zswap_stored_pages);
>> -- 
>> 2.54.0
>>
>>

