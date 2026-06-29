Return-Path: <cgroups+bounces-17372-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtcWC4t3Qmqm7wkAu9opvQ
	(envelope-from <cgroups+bounces-17372-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:47:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C86DB7ED
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 15:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17372-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17372-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECFCB30535B7
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A0218821;
	Mon, 29 Jun 2026 13:38:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E61C3BFC;
	Mon, 29 Jun 2026 13:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740334; cv=none; b=XXHhLfm4L0vnoaNRlwKefY0ysa66ZTk0sGMOG2H9gxBZfeW8rsIebPjyl1XsBOAIMs6mS/n2/lJefaOaZDC9/pHpQDzFmF1LaumGtXtcXfQP1meN8QX12ulBx9XWhVylGO/QKGy4fME2uXq4l15OYcsivjkFi1MKQGnJQm61n2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740334; c=relaxed/simple;
	bh=w7mz0Zyk/IfaGIq3tHTh6Htm5+VoeDZlV5y334Y11NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cth/IO3GR2f6ohlPmeVSnPhqBdsi0Ye2n56+Vv017nhORREJRUUSicYQqm7w1dHvWrGnbF+Xn04l+j8ggLIceoLaPxbUz9dBqS8OxawyyTdbPy90f5R98nXMtWYS2F9dRxPVCrPRGdToOdS0KzLj5kKZ4+DKB6kZB4o7Xo2sl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BA233ECCB;
	Mon, 29 Jun 2026 13:38:34 +0000 (UTC)
Message-ID: <044c3a58-7ed0-46f2-88ca-462691fd0b68@ghiti.fr>
Date: Mon, 29 Jun 2026 15:38:31 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] mm: zswap: per-node kmem accounting for
 zswap/zsmalloc
To: Nhat Pham <nphamcs@gmail.com>, Usama Arif <usama.arif@linux.dev>
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
 Muchun Song <muchun.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>
References: <20260626102358.1603618-10-alex@ghiti.fr>
 <20260626143244.3382853-1-usama.arif@linux.dev>
 <CAKEwX=OKsjtStcuvhQ3WCGYoTJHT6eagBq1mZqX+DdbLm_BFLQ@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAKEwX=OKsjtStcuvhQ3WCGYoTJHT6eagBq1mZqX+DdbLm_BFLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: dmFkZTGMiVzjl8fx6fcDqBZVHRMjBBRqSm59eFdRBEQwbWWmTTZIXhW7nwTt2Grss4O1/Qzt4P/mKF6Gmw6s2N/Oar1KMbL2zQ/CA5Ng7g5/MJ+YoUJ9kLBXFq3omlAoEvf0fLGmz9tA2OED/bPsg1UDXGt9hMqz5EQarroAvd4wxiBQgAAraj+7XjgGWBq9kulJb4GE/r3esPtWnpz4nKIUVPtTMnHjfQM2cFy7RsZ3cU+lLuDrsRpMSkC/2J2VEz0KKxeKxQfaacyWFxf8xFIG13dHpLvT5Qy+0Tn661uwcMfZro0h4Crr29Kw6eoshS718JKnanm88t2zuMK3rAW2qixNKjiI/FS7zmzBPO/u/jQ3iK8hCDgnqc4V9ZuWd4uVZGN176v3P0MekE6f2aqcNIQJCWiBkeQxtTDaJO1SAL/EYMWWFxWS5F0peBBQXSrAq4Hb1ApNcvqz5RCsigu7WmKQwqBJEr7tS+sUlij7QdXU6IXSFaTyfKKYLxH0n+vSHrkmuRI/kC0N7a9UvlFdW4E2Ua1+n1mp4ekbDbJZPlN8OgyWMyjQvtKmyw8DdlfxvJ7bFujw8r5IIdrEz8opOKtVTBYDaFfbdMFMclTuwur+TiWMIPAg6/RDuMBTF0dDIeqNdu10UbKMeFvXh6D26HtA/XD6Z8Y1EwUi3F2eR8MVyw
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:usama.arif@linux.dev,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[ghiti.fr];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17372-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE2C86DB7ED

Hi Nhat,

On 6/26/26 20:36, Nhat Pham wrote:
> On Fri, Jun 26, 2026 at 7:32 AM Usama Arif <usama.arif@linux.dev> wrote:
>> On Fri, 26 Jun 2026 12:20:58 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>>> Update zswap and zsmalloc to use per-node obj_cgroup for kmem
>>> accounting, attributing compressed page charges to the correct
>>> NUMA node.
>>>
>>> But actually, this is incomplete because it does not correctly account
>>> for entries that straddle pages, those pages being possibly on 2 different
>>> nodes.
>>>
>>> This will be correctly handled by Joshua in a different series [1].
>>>
>>> Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/ [1]
>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>> ---
>>>   include/linux/zsmalloc.h |  2 ++
>>>   mm/zsmalloc.c            | 11 +++++++++++
>>>   mm/zswap.c               | 19 ++++++++++++++++++-
>>>   3 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
>>> index 478410c880b1..30427f3fe232 100644
>>> --- a/include/linux/zsmalloc.h
>>> +++ b/include/linux/zsmalloc.h
>>> @@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
>>>   void zs_obj_write(struct zs_pool *pool, unsigned long handle,
>>>                  void *handle_mem, size_t mem_len);
>>>
>>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
>>> +
>>>   extern const struct movable_operations zsmalloc_mops;
>>>
>>>   #endif
>>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>>> index 83f5820c45f9..17f7403ebe77 100644
>>> --- a/mm/zsmalloc.c
>>> +++ b/mm/zsmalloc.c
>>> @@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned long obj)
>>>        mod_zspage_inuse(zspage, -1);
>>>   }
>>>
>>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
>>> +{
>>> +     unsigned long obj;
>>> +     struct zpdesc *zpdesc;
>>> +
>>> +     obj = handle_to_obj(handle);
>>> +     obj_to_zpdesc(obj, &zpdesc);
>>> +     return page_to_nid(zpdesc_page(zpdesc));
>>> +}
>>> +EXPORT_SYMBOL(zs_handle_to_nid);
>> Does this need the same locking as the other handle-to-zspage paths?
>> zs_free() takes pool->lock before handle_to_obj() because zspage migration can
>> update or move the object behind the handle. This helper does the same decode
>> without the lock, so zswap's uncharge path can race migration and charge or
>> uncharge the wrong node, or observe transient zspage state.
>>
> Can we just charge it to the page's node for now? Once Joshua's patch
> series is in, we can correctly charge the node owning the data :)


Even if this patch accounting is incorrect, it is close to reality, 
using the original page's node would give results that are really off no?


>
> FWIW, this is how these zswap entries are organized in the LRU too -
> following to the OG page's node.


Oh, we should do something about that right? Because the compressed data 
is not necessarily on the original page's node.

Thanks,

Alex


