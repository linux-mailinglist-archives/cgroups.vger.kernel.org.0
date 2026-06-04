Return-Path: <cgroups+bounces-16632-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j8ItKdPbIGo78gAAu9opvQ
	(envelope-from <cgroups+bounces-16632-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 03:58:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A536A63C50D
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 03:58:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="pCiEp/ih";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16632-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16632-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8789300C7F2
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 01:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1512C028F;
	Thu,  4 Jun 2026 01:58:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC78221FBD
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 01:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538317; cv=none; b=QyLJ2L5H7MaIeB1urIXj7Eez8Rpim4GgbbXxb/ifyUceOA6/jEXLPLro2EsEvzCKuF3Pzx5c0LuXx6caNoEmSr/2u/Ycs9qlYKJ8skcs0+o8KuBY7dyePiXFKfUbyCaAX93hdWZYY3eAvJ9QTfriidug3IST6G4w3PVe9FI7tRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538317; c=relaxed/simple;
	bh=wa9XYeHbb9kwdRQLnbUpXOx6qjjsAERqKKJ1t4nbqNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9WjWhtG5S6PuxTG0Ol1MeQ7PUvQXujOe1O6kjsszIqOpvhIXzkSPqxQacoBAL6eH3wQ53/3IhpBSSLQEhd5FEfmN+c8EldcTbiG5Nd/dCr3/S/5G0vfJsDbdb7ktitbo4i6FTE9eaUjxQpRarKENBo5AUiGFJTfpHutxrS8SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCiEp/ih; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso138994a91.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780538315; x=1781143115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnlelyjEPA4eQLtR+vH42NF5EXOCOjHQA+g+i9GlLcA=;
        b=pCiEp/ihFO9m59VVAbWFw4j47u2kCoav3FV7ntp4XBV+x9Zi8w2L7aDHp926PemqlX
         BS7bBE4d4Q/9G7SO8nXi/w7SMtgBn5lIDVr3CAA/jk5B9ri4imN5wuIQSBIgueTDns/l
         5AhjKLVCFjbOtXQwuqWKWpTQDD7Gv37SuiSiXtmxHMy5aVyXoRcIrBzmOIBudcdcwQOj
         xmwsi1HWr4KsRhClFsABbRBU2vphLUjCo/3p++AOB7tHTN0jJbbUnb21NWook4xDoVfG
         Y61CQziUjh0BcqIHqh0ASa+aLy0nCHgVhiwhRcotCiW66NgmtXZkkUgNSj9l7udBwgPj
         P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538315; x=1781143115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnlelyjEPA4eQLtR+vH42NF5EXOCOjHQA+g+i9GlLcA=;
        b=O16B1bg7xn53sPY3Vm0mU6sdMjAUYx0F4A9QK/s9BEyDhsn0qCfrYH2PuYVp5ZXNzK
         EeLkTygvw5hVFA1mviqfq5v3j3pMQtVpbkV0rSXp9sSavGr+875/avyQF0KjYaWH+sXx
         iG9LnlDSMZMOUMQjB91z/M0dYDpb2szVipN95sOBgrQxT5D5O90R7t7SBAWvyFTAnVwG
         nfiB15eknxnKRwjGKRV2Q8+gNCrWmciZ3EF16yjm4VRAWN1g/j+u1OM+HryrhuvQl9Ub
         egqNeKPA8zv0oWO+o/aD5ZuO/zMXDsWXWACd26F5ilgK2trrFo+q77oC5DtPtvoxZAlr
         Ysxg==
X-Forwarded-Encrypted: i=1; AFNElJ829z9X9x9tbQ9K2VnzWoiomoHFaXMWeIaO04KRvtrd03IjAXmaLKBvRpUk1pgi2+prfAYUZ7qw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fBhKqsAMmnoNaOsA5rcfJM5FUrOwKBo34vQJNvB5O7pYWEdc
	X4XmD+YBDsZMT4BPbsvF1M5f5+BKW/5AhnTgSkoyxIvyrAHQHm0Le95u
X-Gm-Gg: Acq92OFXx0rO87f9SRozJzKCr/CNcTNAamLbMr7u9qaDeMEKeYi9+Qcq9JCFdM72Lrc
	CoJDbmPBkC6ptaKm+f35o56yP5IQ92bo5QVTqMZ835s6psFk3jnLV3lIBP4q29AN+6B5Mpb9o9X
	Q2Tcu3DPsly+c5OIkrimW+39n56o/TbzmBr7oGF3qoXgxKRJjyvYpeA78SrFa33TbtlfQT/Jdqd
	jrzSIQpicbUzDs/+H5b6VHxlg4WKgWavzVv/H2xdGr/XfnnMLOdy9+ciutLga9+uY0YIEoyjdme
	BeBTD7VeYVDYDzEDjaFMIItkQW/oMwb+FehdbcjzF/t23/pKW3gCxE7o/ABz7UseiTIcMQvFnkn
	BW9pAEkEn2p3euFoiNce0yCY8cQNuNr0RVwU8AmptB1tH2Z6QSSTL3BtNo0XGTdgb2RwFhyM0B+
	KTnZUutQBysyRS47nwDEXAQxsP6AK9kGiBtzlEw/wSGEz/hYEmGAnTBw==
X-Received: by 2002:a17:90b:224e:b0:36d:f28b:72e2 with SMTP id 98e67ed59e1d1-36e32a4281dmr5807810a91.8.1780538315484;
        Wed, 03 Jun 2026 18:58:35 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8064sm1082124a91.12.2026.06.03.18.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:58:35 -0700 (PDT)
Message-ID: <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
Date: Thu, 4 Jun 2026 09:58:21 +0800
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
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
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
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <aiBpibRNi0BcM1Zu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16632-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A536A63C50D



On 2026/6/4 01:53, Yosry Ahmed wrote:
> On Wed, Jun 03, 2026 at 11:02:54AM +0800, Hao Jia wrote:
>>
>>
>> On 2026/6/3 07:19, Yosry Ahmed wrote:
>>>>>>>> Proactive writeback also wants a similar per-memcg cursor that is
>>>>>>>> scoped to the specified memcg, so that repeated invocations against
>>>>>>>> the same memcg make forward progress across its descendant memcgs
>>>>>>>> instead of restarting from the first child memcg each time.
>>>>>>>
>>>>>>> Is this a problem in practice?
>>>>>>>
>>>>>>> Is the concern the overhead of scanning memcgs repeatedly, or lack of
>>>>>>> fairness? I wonder if we should just do writeback in batches from all
>>>>>>> memcgs, similar to how reclaim does it, then evaluate at the end if we
>>>>>>> need to start over?
>>>>>>>
>>>>>>
>>>>>> Not using a per-cgroup cursor will cause issues for "repeated small-budget
>>>>>> calls" cases. For example, repeatedly triggering a 2MB writeback might
>>>>>> result in only writing back pages from the first few child memcgs every
>>>>>> time. In the worst-case scenario (where the writeback amount is less than
>>>>>> WB_BATCH), it might only ever write back from the first child memcg.
>>>>>
>>>>> Right, so a fairness concern?
>>>>>
>>>>> I wonder if we should just reclaim a batch from each memcg, then check
>>>>> if we reached the goal, otherwise start over. If the batch size is small
>>>>> enough that should work?
>>>>
>>>> Even with a small batch size, for small writeback requests triggered by
>>>> user-space (e.g., 2MB, which is batch size * N), it might still repeatedly
>>>> write back from only the first N child memcgs.
>>>
>>> Yes, I understand, I am asking if this is a problem in practice. For
>>> this to be a problem we'd need to trigger small writeback requests and
>>> have many memcgs.
>>>
>>>> This could cause the user-space agent to prematurely give up on zswap
>>>> writeback.
>>>
>>> Why? The kernel should not return before trying to writeback from all
>>> memcgs. If we scan the first N child memcgs and did not writeback
>>> enough, we should keep going, right?
>>>
>>
>> Yes, this issue is not caused by the kernel, but rather by our user-space
>> agent itself.
>>
>> For instance, suppose a parent memcg has two children, memcg1 and memcg2,
>> each with 200MB of zswap (100MB inactive). Triggering proactive writeback on
>> the parent memcg will exhaust memcg1's inactive zswap pages. After that,
>> even though memcg2 still has plenty of inactive zswap pages, it will
>> continue to write back memcg1's active zswap pages. Writing back active
>> zswap pages causes the user-space agent to prematurely abort the writeback
>> because it detects that certain memcg metrics have exceeded predefined
>> thresholds.
> 
> This will only happen if the reclaim size is smaller than the batch
> size, right? Otherwise the kernel should reclaim more or less equally
> from both memcgs?
> 

I gave it some thought. Not using a cursor could lead to unfairness 
issues with certain writeback sizes:

  - If the writeback size is an odd multiple of WB_BATCH (e.g., 
triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the 
writeback ratio might end up being 2:1.
  - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is 
triggered, it might repeatedly write back from only the first 2 child 
cgroups.

Although setting a smaller WB_BATCH might mitigate this unfairness, it 
could hurt writeback efficiency. Let's just use per-memcg cursors to 
completely fix these corner cases.

Thanks,
Hao

>> Of course, real-world scenarios are much more complex, and this kind of case
>> is extremely rare in our environment.
>>
>> That being said, your suggestion of using the global lock for the per-memcg
>> cursors makes the writeback fairer and would resolve these corner cases.
> 
> Right, but I'd rather not do per-memcg cursors at all if we can avoid
> it. Will using batches help make reclaim fair over all memcgs without a
> cursor?
> 
> We can always add the cursor later if needed.

