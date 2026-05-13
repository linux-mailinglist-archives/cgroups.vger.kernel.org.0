Return-Path: <cgroups+bounces-15878-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hy7IrMwBGo9FQIAu9opvQ
	(envelope-from <cgroups+bounces-15878-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:05:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6071A52F4DA
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B3283026F0D
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892C379C21;
	Wed, 13 May 2026 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4NStl2j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFF379C3D
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659498; cv=none; b=loWP4TihJIL0fzBh2zExfynk/T2jt02Ft0mfBHYMpvSdiy5C2pPxrn1Ni9bixiiaUScRMpqL60ZXJg05kFgUC+1YTYW5yd67q4CUzZz6f0ruV5TRMIKhzxy/AoORMBLzuJv5VBCNkuzR2iL+fc1lDwt732e+fVqaO0wXCoafDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659498; c=relaxed/simple;
	bh=syLqyXWh8onmszP6ITzEgIzgnnVbMA0gxWTg9tqsQps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKXD3eg3TSk5rIA3y1W0ExZQEGhhBFFlEyCvo4RRlZOmCfy6fdC5G3JQLlz12CJYGVXCdSRkPHUku+EhWk7NL7cn/spKQ6NmQZrZ1Tq/FLkuGiA7ey85BKEhZzr+UikW6I+wAspRpZ7df7yIa1XXaPzMCZdezKbJ2ZceRns5c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4NStl2j; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3680540a6efso2337822a91.2
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659495; x=1779264295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1dxIimePE2VOkjQz2/ma0Z1DDa/BQxq5kyPGrdKr+k=;
        b=h4NStl2jxSMK6+B1o4jurkW9rqCadgbuX83hXb6eM/WCAOemBuWouBhdi2Y1NfOtRT
         laQa/HXLVmkX5teleljn+oiFsFuFDls5WDsTYYR+rZA0WW24yts5cH7l8CnK4wQA3hcg
         m3zqGWJN9ZmuyqBcqu6tt0qCjwyXdpK9+JJvGTDjt1ejiF1MqbVmF1p8vtcjOPO5TX9K
         cUoLc993FGcDyivx9zuyk1Ej2EsEbP3og31nl/W6RXqJ8fc6WzCXy8rLN3NgRPSqE1G4
         vyi5HZPrSnI02amtWqrN6QA02CriUyOBCdQcMLpDduO8YBgWg+aEZaQ9GSRFYXkKMg4x
         X/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659495; x=1779264295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1dxIimePE2VOkjQz2/ma0Z1DDa/BQxq5kyPGrdKr+k=;
        b=FpxORgXIeMbmVJ4uruefO1NXbrhpLYhR9CkQsOJyMHpXKGWi/rMx+vFHTxFZBN0I3J
         YKy4IYsZQRWZMAVv7jU2D0eI4lRRtP7Upn8RyAwfcxQlwoAeql23ShHC22eMRyKyzRds
         T9eMCuPN52dm+N7Aab8k5I+gU+coIfm48MQJu1PhhZGfFUAbqcTS6g1+bhCb2O2pvoji
         XYxH/9xONqGdX8QqbudlvNWjjiqFWCWWTfzoTOAkpUzvgzj/mOkQGGcVBe6TQuXfqVEC
         60ffF22+tC1HggNSRnWR4gkm5+YbD8Ir3v1XmCcFjF0M04sUNdAYxVaNlQe3W95/muhG
         CTfw==
X-Forwarded-Encrypted: i=1; AFNElJ8oBAjM+Xa7UISklSssgKWO+wGD0x6ZRu1otVIK/OtM5QFGnLD/n5HSJXn7kPTDS77rXPJKiS1q@vger.kernel.org
X-Gm-Message-State: AOJu0YzUC4RpARw45IzkFRPeVddVxDppt2xxEXHsAQ73y5rarcwbp7r9
	Ol8gD/oSodrxuGxkgT9EbxRBpk7yraXOu3uMsLBPmO0c60SRpSKujhCD
X-Gm-Gg: Acq92OFULQeCRdNqTkMM6biSwmKBQEJHRB2w9Fkabi51UMpGInWgl1bkZMpFdo2M21f
	MpjasoPGp/K7Mw90qL9pNqbEoAjG3VJRdKCXa1QIG3ejZw+7sDsATlMK1vll4P8UorYW5jwgsnn
	dNhWSWSbw5bTTtpoYdSiwlrk7yhUlbIikzuL7DZ7uFOBx/4SkOX4zhBCtq4Iva8XPURViDFUkNe
	xQLdhp+Nn4VFfQK8FARrwyVWlj0xeuP/aXToCx72c8MClmq1fRWKXf7IrPlCClT5kJyHRyfBgPE
	ZEayAKw5UAbGz2uhoyMxsOttIUEz53i8l7G1tjPGlXGv3EIapy5qEIvHlvrhTz88etXDc7ygG8p
	FpIG+75CDeqWQAPgZHmVlRJrBj/fkRqDh3v4uSWeoJ8UapLmtUEbLPUPoyzYPQXW/CmW7lMMwiP
	21PJHI3yatvrwt9U+tyUh8s4TgJAg5Iij46BiTscOD6Uc=
X-Received: by 2002:a17:90b:3f8c:b0:368:ed92:6f5 with SMTP id 98e67ed59e1d1-368f77f6980mr1854188a91.4.1778659494907;
        Wed, 13 May 2026 01:04:54 -0700 (PDT)
Received: from [10.125.192.65] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede2d545sm2895850a91.6.2026.05.13.01.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 01:04:53 -0700 (PDT)
Message-ID: <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
Date: Wed, 13 May 2026 16:04:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>, Alexandre Ghiti <alex@ghiti.fr>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com>
 <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
 <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com>
 <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6071A52F4DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15878-lists,cgroups=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[cmu.edu:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[lixiang.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,cmu.edu:url]
X-Rspamd-Action: no action



On 2026/5/12 23:47, Nhat Pham wrote:
> On Tue, May 12, 2026 at 2:32 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>>
>>
>> On 2026/5/12 03:57, Yosry Ahmed wrote:
>>> On Mon, May 11, 2026 at 12:49 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>>>
>>>> On Mon, May 11, 2026 at 3:52 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>>>
>>>>> From: Hao Jia <jiahao1@lixiang.com>
>>>>>
>>>>> Zswap currently writes back pages to backing swap devices reactively,
>>>>> triggered either by memory pressure via the shrinker or by the pool
>>>>> reaching its size limit. This reactive approach offers no precise
>>>>> control over when writeback happens, which can disturb latency-sensitive
>>>>> workloads, and it cannot direct writeback at a specific memory cgroup.
>>>>> However, there are scenarios where users might want to proactively
>>>>> write back cold pages from zswap to the backing swap device, for
>>>>> example, to free up memory for other applications or to prepare for
>>>>> upcoming memory-intensive workloads.
>>>>>
>>>>> Therefore, implement a proactive writeback mechanism for zswap by
>>>>> adding a new cgroup interface file memory.zswap.proactive_writeback
>>>>> within the memory controller.
>>>>
>>
>> Thanks Nhat, Yosry — let me address both comments together.
>>
>>>>
>>>> We already have memory.reclaim, no? Would that not work to create
>>>> headroom generally for your use case? Is there a reason why we are
>>>> treating zswap memory as special here?
>>>
>>
>> Apologies for the lack of detailed explanation in the patch description,
>> which led to the confusion.
>>
>> While we are already utilizing memory.reclaim, it does not fully address
>> our requirements.
>>
>> Our deployment runs a userspace proactive reclaimer that drives
>> memory.reclaim based on the system's runtime state (memory/CPU/IO
>> pressure, refault rate, ...) and workload-specific
>> policy. That first stage compresses cold anon pages into zswap. Entries
>> that then remain in zswap past a policy-defined age threshold are
>> considered "twice cold", and the reclaimer wants
>> to write them back to the backing swap device at a moment of its own
>> choosing, to further reclaim the DRAM still held by the compressed data.
>>
>> This is the "second-level offloading" pattern described in Meta's TMO
>> paper [1]. zswap proactive writeback is what this series introduces to
>> address that second-level offloading stage.
>>
>> [1] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf
> 
> Yeah that's what we've been trying to work on as well :) We are
> working on a couple of improvements to the mechanism side of this path
> (cc Alex) - hopefully it will help your use case too!
> 
> Anyway, back to my original inquiry: I understand your use case. It's
> pretty similar to our goal. What I'm not getting is why is
> memory.reclaim (which you already use) not sufficient for zswap ->
> disk swap offloading too?
> 
> Zswap objects are organized into LRU and exposed to the shrinker
> interface. Echo-ing to memory.reclaim should also offload some zswap
> entries, correct? Are there still cold zswap entries that escape this,
> somehow?
> 

Yes, the memory.reclaim path does drive some zswap writeback, but
it is not enough for our case.

1. For a memcg that has reached steady state (a common case being
when memory.current is below the policy target), the userspace
reclaimer may not invoke memory.reclaim on it for a long time,
and so no second-level offloading happens through
memory.reclaim. In this state we want
memory.zswap.proactive_writeback to write back entries that
have sat in zswap past an age threshold, to further reclaim
the DRAM still held by the compressed data.

2. Even when memory.reclaim is running, the fraction of zswap
residency that ends up reaching the backing swap device is
still very small for many of our workloads, and the userspace
reclaimer has no way to participate in or control the
granularity of zswap writeback. So in our deployment we prefer
to leave the zswap shrinker disabled, decouple LRU -> zswap
from zswap -> swap, and use a dedicated proactive-writeback
interface that lifts the writeback policy into userspace where
it can evolve independently of the kernel.

Thanks,
Hao

> Furthermore, we already have a way to detect the "twice cold" entries
> you mentioned: the referenced bit. This is analogous to the way we
> treat uncompressed pages.
> 
>>
>>
>>> +1, why do we need to specifically proactively reclaim the compressed memory?
>>>
>>> Also, if we do need to minimize the compressed memory and force higher
>>> writeback rates, we can do so with memory.zswap.max, right?
>>
>> Here are a few reasons why memory.zswap.max is not enough:
>>
>> 1. Writing memory.zswap.max itself does not trigger any writeback
>> immediately. For a memcg that has reached steady state (on which the
>> userspace reclaimer is no longer invoking
>> memory.reclaim), after enough time has passed, the reclaimer has no good
>> way to trigger proactive writeback for second-level offloading by
>> lowering memory.zswap.max, because in steady
>> state nothing drives the zswap_store() -> shrink_memcg() path. The
>> userspace reclaimer still has no control over when proactive writeback
>> happens.
>>
>> 2. memory.zswap.max currently triggers zswap writeback via zswap_store()
>> -> shrink_memcg(), and each over-limit event can write back at most
>> NR_NODES entries. If zswap residency is far
>> above memory.zswap.max, converging to the target size requires at least
>> O(over-limit pages / NR_NODES) zswap_store() events, with no batching —
>> proactive writeback therefore has
>> significant latency.
>>
>> 3. memory.zswap.max is a stateful interface. If the userspace reclaimer
>> crashes for any reason mid-operation, it may leave memory.zswap.max at
>> some set value, putting the application in a
>>    persistently throttled bad state.
>>
>> 4. Once the userspace reclaimer has lowered memory.zswap.max, if the
>> workload is rapidly expanding and triggers memory reclaim via
>> memory.high / kswapd / etc., the actual amount written
>> back can exceed what was intended.
> 
> One more reason: IIRC, when you set memory.zswap.max to a value other
> than 0 max, every zswap store incurs a pretty expensive check
> (obj_cgroup_may_zswap), which does a force flush
> (__mem_cgroup_flush_stats). That was pretty expensive last time some
> of our internal services played with it. So yeah, it's not ideal...
> 
> (if you're using this, might wanna profile this as well).
> 
>>
>> Thanks,
>> Hao

