Return-Path: <cgroups+bounces-16633-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XxaOBUngIGoM8wAAu9opvQ
	(envelope-from <cgroups+bounces-16633-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 04:17:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7863C715
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 04:17:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TZqgqLen;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16633-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16633-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7ACC3035B7E
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2B2DECA8;
	Thu,  4 Jun 2026 02:12:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E732DCF45
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 02:12:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539123; cv=none; b=NB5+nGV0ZskFAzL0O3AwcWHuMbiho5e+W5KB/1c7jjCWisv1SAiqg8hQ4A5MDnX+Mqx7AUXtg8PZ5EXF3DG6QeginE6bvxhs7UUTStUieAWJypU52wOei2vD9zCcgskqDIvhe4+sPAeaKCT/Q0yQb49sqcC7aakwgRiIExKVYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539123; c=relaxed/simple;
	bh=pfu0XBliitmT90qC4mnmnZe/qaWtHxzRCoJUBx1uXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puu/tzKeLI6h5s2IC1rt1MeKPa9/dqBM0/+/PgyMc+jO+LCSlSDADhqkagM8Ynb4v3rbA214qPemubGoSRHFlGFeky0s9fBE8lr7C8LNkSLkvaek/FmFejnFcjN4IeFAdC211hBcptUxOwamsSEp23s8k3virS7t5LxIhjld8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZqgqLen; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso74422a91.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780539122; x=1781143922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SZO2PTw2KcbXgjzwwx+KH4Kf8JNmzc6dqKetjt7KYo=;
        b=TZqgqLenHg40dCHs1JO2CIp+lkzAD6twlAI9eAF4rrMloTmDvy+LiqLg+uC6Tqoq0W
         vEfkLzcLTSGxzzUCBgA93HzJuWDtsYNl6Vv95PHB+wPDh+B/OWlfGgcy1eHNf1izyNnF
         z+V1aMmigesigFzEl58+P3pZk2VMFPt5AXi0HLqpuROyEGDOrMJVaJd3ZGdM3+/DY5Y7
         6WtDzU5UpQY7w3dEwjt/GCFnTjE1+KB7/SoFH9E4KU2Q/VGiGZhJ7NGAPmA8FB14Gc2t
         AiXwvvM8t2pZ37EclkH6PTmLHu1vGymVEY0nXpc/8enm0oTXDUiyCY2ZyUa/y2WpSrAt
         rC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780539122; x=1781143922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SZO2PTw2KcbXgjzwwx+KH4Kf8JNmzc6dqKetjt7KYo=;
        b=Sko/36DcScDIH65jver+njCMSBFcTcDjgGPzjbtMGG2dTZITKtXM1niF8hKGWFggNf
         hj5m3+dG1gjpsCAMMaCkM8dppzbrpyaKoo5s7AqNnaOI07UMu5quIBiA0FsSe60gKvvT
         rUoO9I4eFRxXrLZ4wO07yADvCZ9CRKO6u21MXOy0+OzAMDPv8G53nMSEZ37V6uohAp13
         1XS87WbDxWzoIgKdnAduOTCrLQKTx2F5uQHLUmGIHjokPD2WX13/VvL7GS1LCge0aVyB
         uFUhHiIVOByii3Tx6Zq4gmadtK7WEmOO6nGQ6oLpxOh5nTC8NxKqU1jC5gmHnlAwHwv9
         LXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ84uljCxqtMGQfpmJ6vhpdRV+3uhARkzNlCo0A4amRUqGhOn5+TvUHmrLOj5sbohYeQXLGuApB1@vger.kernel.org
X-Gm-Message-State: AOJu0YxgErzdtG8KXlnYotL1WlNfrIkVMqg5ME79XTZ33nE9Fr24cNmE
	QAynlCeK2UAJXleQXGw6hKvmPed9KXjUbwQmCYd6XsC5C9fVocnbAAnt
X-Gm-Gg: Acq92OEQrqD9waQ7lku7C9+N1lxWsZ8p2llUumrDOkYXjajzedXtNbOu0rIsgLHUeMb
	8Ba9VnI4wGa9/98QhVca0cFnT1xpY40A82AVMUL4jD1slMMuMhLoNcJ8LDliyxM8DBK+tisnfqj
	CCgL4/KM4NtPI660EaACdjDVFzj3tZ8duVp8m7zAlGSVgG+pKXAyeJ12P9nAYuECyO3ME7Wqqts
	OHUrDDB494xbjxCJBxsFzQX3Kl1jmpIRuhDLZh1AC+RJyPiGQEMHh6njRUfurGLGXaYxYHMuiXT
	9SMeF5rS6mbN0TCQ5h9vNXZQdwuJhTdvZR4iGVvfWdHl0RG8sRC0IEYb9aUmEDHjMDgW8SDqH+g
	MQfA6FOJSKYEAa/cah7O8nxU/Z5pmn+cuvLV6+/9VNGZCKYCTBKY+aE88m6JIwrTPxDyM6qGpkV
	MZdfUmckatDRyv7bYAc6Cb99ErB3OOrYvYUi+NDDdzs5+sdsgFnkEiTQ==
X-Received: by 2002:a17:90b:4ac7:b0:36b:93f7:a903 with SMTP id 98e67ed59e1d1-36e30a2adf0mr5186933a91.18.1780539121743;
        Wed, 03 Jun 2026 19:12:01 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f68b03ef6sm1101582a91.0.2026.06.03.19.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 19:12:01 -0700 (PDT)
Message-ID: <6db27a22-cc7a-9a94-db3f-c912fd39aa32@gmail.com>
Date: Thu, 4 Jun 2026 10:11:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
 tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
 <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
 <aho_VtLCmIRsNyvO@google.com>
 <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
 <aiBqzOtEv5iAC_qC@google.com>
 <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:yosry@kernel.org,m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16633-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85C7863C715



On 2026/6/4 02:14, Nhat Pham wrote:
> On Wed, Jun 3, 2026 at 10:58 AM Yosry Ahmed <yosry@kernel.org> wrote:
>>
>> On Wed, Jun 03, 2026 at 07:22:36PM +0800, Hao Jia wrote:
>>>
>>>
>>> On 2026/5/30 09:40, Yosry Ahmed wrote:
>>>> On Fri, May 29, 2026 at 12:58:09PM -0700, Nhat Pham wrote:
>>>>> On Tue, May 26, 2026 at 4:46 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>>>>
>>>>>> From: Hao Jia <jiahao1@lixiang.com>
>>>>>>
>>>>>> Zswap currently writes back pages to backing swap reactively, triggered
>>>>>> either by the shrinker or when the pool reaches its size limit. There is
>>>>>> no mechanism to control the amount of writeback for a specific memory
>>>>>> cgroup. However, users may want to proactively write back zswap pages,
>>>>>> e.g., to free up memory for other applications or to prepare for
>>>>>> memory-intensive workloads.
>>>>>>
>>>>>> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
>>>>>> interface. When specified, this key bypasses standard memory reclaim
>>>>>> and exclusively performs proactive zswap writeback up to the requested
>>>>>> budget. If omitted, the default reclaim behavior remains unchanged.
>>>>>>
>>>>>> Example usage:
>>>>>>     # Write back 100MB of pages from zswap to the backing swap
>>>>>>     echo "100M zswap_writeback_only" > memory.reclaim
>>>>>
>>>>> Hmmm, so this 100MB is the pre-compression size? i.e if this 100 MB
>>>>> compresses to 25 MB, then you're only freeing 25 MB?
>>>>>
>>>>> I'm ok-ish with this, but can you document it?
>>>>
>>>> That's a good point. I think pre-compressed size doesn't make sense to
>>>> be honest. We should care about how much memory we are actually trying
>>>> to save by doing writeback here.
>>>>
>>>> The pre-compressed size is only useful in determining the blast radius,
>>>> how many actual pages are going to have slower page faults now. But
>>>> then, I don't think there's a reasonable way for userspace to decide
>>>> that.
>>>>
>>>> I understand passing in the compressed size is tricky because we need to
>>>> keep track of the size of the compressed pages we end up writing back,
>>>> but it should be doable.
>>>
>>> Agreed. Using pre-compressed size is probably easier to implement. IIRC,
>>> interfaces like ZRAM writeback_limit are also calculated using the
>>> pre-compressed size.
>>>
>>> I'll clarify this in the documentation in the next version.
>>>
>>>>
>>>> If we really want pre-compressed size here, then yes we need to make it
>>>> very clear, and I vote that we use a separate interface in this case
>>>> because memory.reclaim having different meanings for the amount of
>>>> memory written to it is extremely counter-intuitive.
>>>>
>>> Agree. This would indeed break the semantics of memory.reclaim. I will use a
>>> separate interface for proactive writeback in the next version.
>>
>> But doesn't it make more sense to specify the compressed size, which is
>> ultimately the amount of memory you actually want to reclaim.
>>
> 
> I personally prefer compressed size to pre-compressed size. That's
> kinda what user cares about, no?
> 
> One thing we can do is let users prescribe a compressed size, but
> internally, we can multiply that by the average compression ratio.
> That gives us a guesstimate of how many pages we need to reclaim, and
> you can follow the rest of your implementation as is (perhaps with
> short-circuit when we reach the goal with fewer pages reclaimed).

Got it. I will change it to use the compressed size in the next version.

Yosry, Nhat, should we continue using the zswap_writeback_only key to 
trigger proactive writeback?

Thanks,
Hao

