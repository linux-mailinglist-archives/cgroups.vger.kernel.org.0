Return-Path: <cgroups+bounces-16729-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bPALHIm7JmrPbwIAu9opvQ
	(envelope-from <cgroups+bounces-16729-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:54:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D817765658B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TDEEEbcw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16729-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16729-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 037B33028474
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365C284682;
	Mon,  8 Jun 2026 12:50:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D127B50F
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:50:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923031; cv=none; b=ATjkdfLpSzOt8NTclP3eUEbXOfpskXXv9r1pgahiq/j1otDtLvImMsHR4bAM9B1Tv2VDXanxVpu7juQj024BwoTxfT8IgwR4QfWSxH24vxoO9XfDpHrYkdor70UjY0zcTdkVEa/ZLIJK6+hO1JbJHyVXSKipXnvOvutt7snUCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923031; c=relaxed/simple;
	bh=TG6r/3Lp+ODfq+/oUWl3Qo2qwI2yFx1wavbyGgxzkRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYh9OZGhAmVVhLhI617yCsnK/8HqF0DTENwbvsO1HFi/8amcZrjyZflNuicCrmNNWC7pX8GmTmWQbvXMH6v5RgLvKjIaK4cRVYvt3NMLK1fuohAYtVhp+qC2FXrrDyFBMM4/F6PRZ+zZ4/EFwFY51cv6MaILOWF9ekNd95KZDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDEEEbcw; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so4298125a91.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780923030; x=1781527830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiIdK82JBJK4ZmshrTXuh1DETm09pI5fnq4TS+v0gOw=;
        b=TDEEEbcw5RoeiTZWI0FoBMax+eR8C2tcdBXsoC+PVkb2kta9/b0PKb+Cryf5bxVHk9
         EXPPksQj/YtwtXgbDHTY3JQOJ2Nv6FluWu5JO5iPqok0/j/Ha3g8Kwnio4Qkf6wqdZoH
         F3Z+eqfxbLHS9xrmNQ6pM1dy8aSKtU4csj1lrP29ZHYowwpqmQnYnMYH0G2stf+oH2Ub
         RZ2uPCmsfX6MKtKxwBmj9eFS7ESqVI5Jk6eldnDE1yu+/W+Tkwv1nCqTl7Zsoa0yq9pQ
         6L0dacSQlLRGULqGdfFEKRBg9atT7bR5DArD2+zguLh+IVU9a01pvi+daWLHuCxHX+vp
         io7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923030; x=1781527830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiIdK82JBJK4ZmshrTXuh1DETm09pI5fnq4TS+v0gOw=;
        b=mH47B74PweULIJo/1dueSAdX/yoMrxWVJE/aUoHoc5GdTsAqm/eCchSpuRYctwifRa
         KDG2V3HNlox+RxontiP1A2oR9nbyUaiXTDfDyX72W8OyGmHCdZo4rWIw0fqQzR78Qw5Q
         9Iwix4v3oRYX6UlD59r85eL7dQxd7SzZ3Q1nPviiAZAZe/1I7C3CZRgBRlzCg1Od8BxJ
         a0Cqt1NTkXC/AuU5syDtHaTVyef5dJNdRlnPsBI8H7MSsLpnP/52w8TRVj+LqCzttCWb
         suTjqT/RzRQlkpTRxREov6D0On6Ay6Yu+rR3Z3WTFh5jQdgE4oqBtDonBIwnYnQEdPTW
         mrKw==
X-Forwarded-Encrypted: i=1; AFNElJ9BJXqyiQzcb64rmY2YV9WXG3fKYydOwBsrP26O9gudjRxf1vydFhEq/1K1zz3BXgOdjN8dNXyP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvPseTIUTPzDhYDGdsQULqqSSLOSsae/NrD1+DXHEn6utN0Py
	0tiIv5FNaf7i0nqKNI0wglmzaxMIbL+PYVd6oZE4rQgmSGquJP8I05Pn
X-Gm-Gg: Acq92OHHr15ZL+RDpWfnBqeYui1OcPk1s+CJ1z3heZhQW2rGvRhu7oP6dj1iIEgR9R/
	A3HdAqhXVxoaue2Ocqi0G2uA62kNVeJUA+hFaqhCQLm8qOgar0xQBHRJX7hElLlkMqO+8a4knz8
	Ml2E0ylK3k5zDTJ+cJA9FLEjibIqkemjsbcCXcEJdPYL25U6ybE0k4fDml6pNgwNj7zPh8f9bWM
	EglaxQvB/mXF+lzxYtjZhiqbGnWo2A8rGy+2/pSdHKcvfTidX9e6N2KUClIRJSR16PUjmFl/aJ6
	PQdn9xBo8SLkcZhD2WF3iBPo5MeW5UrgmTAIr7xPM4bpq+M/xAP+Zwv47iu1AZIs2ZpiN47+T90
	eIvFyIZRUwnAROG1tOjS8/vRqvVWi4JHvPMX2BJzDFwkKOOZH5wmtFQBSR8rRYgpY6A3KxxINRa
	WqmOLRR/EzjzZihL/s8n5MKyHjPcfZmgbnGwQCND4ut6VZXcN2MT2v0w==
X-Received: by 2002:a17:90b:5345:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-370ebff342fmr15636109a91.0.1780923029551;
        Mon, 08 Jun 2026 05:50:29 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1663981basm179520225ad.67.2026.06.08.05.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:50:29 -0700 (PDT)
Message-ID: <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
Date: Mon, 8 Jun 2026 20:50:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
 <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
 <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
 <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16729-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D817765658B



On 2026/6/5 01:23, Nhat Pham wrote:
> On Thu, Jun 4, 2026 at 6:06 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>>
>>
>> On 2026/6/4 13:34, Yosry Ahmed wrote:
>>>>>> For instance, suppose a parent memcg has two children, memcg1 and memcg2,
>>>>>> each with 200MB of zswap (100MB inactive). Triggering proactive writeback on
>>>>>> the parent memcg will exhaust memcg1's inactive zswap pages. After that,
>>>>>> even though memcg2 still has plenty of inactive zswap pages, it will
>>>>>> continue to write back memcg1's active zswap pages. Writing back active
>>>>>> zswap pages causes the user-space agent to prematurely abort the writeback
>>>>>> because it detects that certain memcg metrics have exceeded predefined
>>>>>> thresholds.
>>>>>
>>>>> This will only happen if the reclaim size is smaller than the batch
>>>>> size, right? Otherwise the kernel should reclaim more or less equally
>>>>> from both memcgs?
>>>>>
>>>>
>>>> I gave it some thought. Not using a cursor could lead to unfairness
>>>> issues with certain writeback sizes:
>>>>
>>>>     - If the writeback size is an odd multiple of WB_BATCH (e.g.,
>>>> triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the
>>>> writeback ratio might end up being 2:1.
>>>>     - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is
>>>> triggered, it might repeatedly write back from only the first 2 child
>>>> cgroups.
>>>>
>>>> Although setting a smaller WB_BATCH might mitigate this unfairness, it
>>>> could hurt writeback efficiency. Let's just use per-memcg cursors to
>>>> completely fix these corner cases.
>>>
>>> Exactly, the batch size should be small enough that any unfairness is
>>> not a problem. I would honestly just do batching without a per-memcg
>>> cursor, unless we have numbers to prove that the efficiency is
>>> affected when we use a small batch size. Let's only introduce
>>> complexity when needed please.
> 
> I'm impartial towards the complexity of per-memcg cursor. I don't
> think it's that big of a deal, but only if it's warranted.
> 
> Hao, if you're convinced that doing small batch is not efficient,
> could you run some experiments to show the improvement bigger batchign
> and fairness? Maybe implement a small batch, no-memcg cursor first.
> Then implement a patch on top of it to add per-memcg cursor, and show
> how much performance win we can get from that patch on top of the
> patch series?
> 

Thanks for the suggestion!

I ran some tests and found that neither the per-memcg cursor nor 
different batch sizes have a significant impact on proactive writeback 
performance. However, exactly as we suspected, without the per-memcg 
cursor, the writeback distribution among child memcgs is highly unfair.

Test Setup:

   zswap config: 18G capacity, LZ4 compression.
   cgroup hierarchy: 1 parent test memcg with 10 child memcgs.
   Allocation: Allocated 1600MB of anonymous pages in each child memcg. 
To ensure compressibility, the first half of each page was filled with 
random data and the second half with zeros.
   Force to zswap: Ran echo "1600M" > memory.reclaim on each child memcg 
to squeeze all their memory into zswap.
   Trigger writeback: Ran echo "<size> zswap_writeback_only" > 
memory.reclaim on the parent cgroup 200 times, with a 2-second interval 
between each run.
   Metric: Monitored the zswpwb_proactive metric in memory.stat to 
observe the writeback volume.
   **Note**: The size here refers to the uncompressed memory size. Also, 
since the second-chance algorithm would cause many writebacks to fall 
short of the target size, I **bypassed** it during these tests to avoid 
interference.

Without cursor (size: 1M, batch: 32)
   child        wb_pages        wb_MB     share%
   child0           6368        24.88      12.50
   child1           6368        24.88      12.50
   child2           6368        24.88      12.50
   child3           6368        24.88      12.50
   child4           6368        24.88      12.50
   child5           6368        24.88      12.50
   child6           6368        24.88      12.50
   child7           6368        24.88      12.50
   child8              0         0.00       0.00
   child9              0         0.00       0.00
Without cursor (size: 1M, batch: 128)
   child        wb_pages        wb_MB     share%
   child0          25472        99.50      50.00
   child1          25472        99.50      50.00
   child2              0         0.00       0.00
   child3              0         0.00       0.00
   child4              0         0.00       0.00
   child5              0         0.00       0.00
   child6              0         0.00       0.00
   child7              0         0.00       0.00
   child8              0         0.00       0.00
   child9              0         0.00       0.00
Without cursor (size: 6M, batch: 128)
   child        wb_pages        wb_MB     share%
   child0          51200       200.00      16.67
   child1          51200       200.00      16.67
   child2          25600       100.00       8.33
   child3          25600       100.00       8.33
   child4          25600       100.00       8.33
   child5          25600       100.00       8.33
   child6          25600       100.00       8.33
   child7          25600       100.00       8.33
   child8          25600       100.00       8.33
   child9          25600       100.00       8.33


With cursor (size: 1M, batch: 32)
   child        wb_pages        wb_MB     share%
   child0           5120        20.00      10.00
   child1           5120        20.00      10.00
   child2           5120        20.00      10.00
   child3           5120        20.00      10.00
   child4           5120        20.00      10.00
   child5           5120        20.00      10.00
   child6           5120        20.00      10.00
   child7           5120        20.00      10.00
   child8           5120        20.00      10.00
   child9           5120        20.00      10.00
With cursor (size: 1M, batch: 128)
   child        wb_pages        wb_MB     share%
   child0           5120        20.00      10.00
   child1           5120        20.00      10.00
   child2           5120        20.00      10.00
   child3           5120        20.00      10.00
   child4           5120        20.00      10.00
   child5           5120        20.00      10.00
   child6           5120        20.00      10.00
   child7           5120        20.00      10.00
   child8           5120        20.00      10.00
   child9           5120        20.00      10.00

Thakns,
Hao

