Return-Path: <cgroups+bounces-15937-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJFdAFaEBWqJXwIAu9opvQ
	(envelope-from <cgroups+bounces-15937-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 10:14:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24E53F242
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 272D6304C624
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D33D8108;
	Thu, 14 May 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijtfEVDS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08613B47FA
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746398; cv=none; b=icSi66acffxmU0oomT3M4g/70Q33tzwslQ9oI0dxBYLSb+utnU3CNCwMyje3DYsW535bizhbMiyCuPQwp5nPq41R8MVpbT10KSlrePV7r8x5aZmLp3y+8X+qMpX5qQEZ1W/eu6kBueyD7rHrolqrGu+9LKyuNhYqGiwUL2K3K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746398; c=relaxed/simple;
	bh=NcPxqFXtdJSzLFs+u6XpxtuRnOT77nJVdPY9bb2XxnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JACJ+laM/+zqlI5UsE5zZDZ2qFF/gYS/Nh2IY/nmHLHqLEmDbIUQT3Sy6SfSC56R5+II5Igo7zlJkBX9SaFrCHPgyWhVDjx4gHtWwGyUdKN6RSTipkvHqqMy9lGp1+XbBdSDWSjClJCKn/tn3nYklAVoijgpvYd3o7nA8m/KQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijtfEVDS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83659d38e38so3393010b3a.1
        for <cgroups@vger.kernel.org>; Thu, 14 May 2026 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746396; x=1779351196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0M2iptptb250Psp+ZWNGxv8OhRpj/x6t+2FKnbK4Kg=;
        b=ijtfEVDSeR+8p98ogDKwIpLL/wzJTcZrBnnkFwrrocc9hSKAhqmGfj7ICSbwVZirYk
         yfq2cte9rYV1b0dFWbWUiH4MRnO7dmSWX+lzqiaAuczCd20EuJhBphYE9QxAgeO3EDzO
         HV9yEy+HCJY+hXQYxgCGW/PPWcyy+JP3gnVAhTMFfL2Mzy2hYOFRfu/4WzfsMs53of71
         uHibkJ67yACYGZ2o5KkFDygFCut01io2NGJ+o0A4P11t/tdRUMi0efDK2ywQUqNIe37l
         3/cLaKsZ0o2ea0xK6ZWmIivFu0bYMKBrb5MArycaU8mAhKbGNtjsw7/uYJEYNXMpOjzY
         bSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746396; x=1779351196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0M2iptptb250Psp+ZWNGxv8OhRpj/x6t+2FKnbK4Kg=;
        b=puCBDu1lMmZwmCrkxJmRM3wxaMThOW3msji1ibm/R2PX9O02pa3JiFifMX27JwwPc9
         FVemOxgIWGiDI8nROaAIuSib/TRA1puznuAuHmSLvvD3znWbmC9f0U2LDaI1tAaKqhxB
         crwqzL01RJNMl9lHQsyIBBvqFOCXaZ8CRGDSFEExvAiNEMnjY8rPw3n6kzqIrz0J4UW3
         nXZ17hegEha+xZtZ3LHssEOQ+8S2oZL8k31Ka8ZXXgdra/pCaI4ZqOvyqdwX8UqiYGzW
         yKJEyRjiKG6qjPX2K/8zMoOen0zi+1eHbz2D7W62tFBzwDyZ+BmgOh0Iugv7yhawCdf+
         Z7hg==
X-Forwarded-Encrypted: i=1; AFNElJ/8tTVYb9nXylh6KbLVl2Q8+0YLPcCjyeHWNeaDpRliBv99n1IbzM+zTN4yymLCcBAUUwNQfIKF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WY1CTZFGr/pWcCEhUIKkSJ1/em0Jq+TAkgYammLEkDDz0pPd
	jsflqVjrpzwdtECeRmHXWTGd/2LpoyOWGod7tTU+ns6hAw52aUQX4T1d
X-Gm-Gg: Acq92OHa/GOCpCaRUwfQhSJdCWSMwq3xRO8HqjlSizWoIIt7gs5SMDAiMNh98WF1FEt
	60d9f43a6oglCgTccS1UQxzA7yWkPiYazvyDYSVzCBDGwYVQySP6jHNvcCJ51wvMfS46+ZdLpb+
	XnnOeupFhcVF/CmOUETqFXt1t+QDFvmeAQ62uhzofo+qnINekG/CtkA5q0bIq74oj251bhQBXqM
	khVzsjeGjSy3/jGxWVIgZKPCqW9WInvCYjo+5j3v+p8I42Jyc6dzbxEdsdQDsH5favRgX1aT7bx
	UipznsesNx7GKiC4cpWGsa174zswvjODD8+vt4m1J53+ndUOlhlXD5IdRQqemyg0g1aJq5GYH3L
	otk1Q0nNJwXAp7DL8NriC8ng9flianOmkghkOFXr4h2YB/u0jLOR4mXxdAnxrYO+GEQGRO/bAR7
	512i1Lp0kJGHS/vUdKBEpj25QrIBjdyAv1g3o4PQ2cVA8=
X-Received: by 2002:a05:6a00:4ac8:b0:83a:7565:3505 with SMTP id d2e1a72fcca58-83f03e95beemr7192464b3a.8.1778746395930;
        Thu, 14 May 2026 01:13:15 -0700 (PDT)
Received: from [10.125.192.65] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cd19sm1845320b3a.54.2026.05.14.01.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:13:14 -0700 (PDT)
Message-ID: <8fa07929-ed41-b716-c888-0368f883a020@gmail.com>
Date: Thu, 14 May 2026 16:13:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>,
 hannes@cmpxchg.org, mhocko@kernel.org, tj@kernel.org
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com>
 <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
 <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com>
 <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
 <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
 <CAO9r8zPvgB-MG2ufmdn4HoS+QEPBAehU9u7fQmYs+47NF-C9aw@mail.gmail.com>
 <CAKEwX=OY_nws-vf3VgnD54G205TK2YjkoAwRCyB9jvW=Oz3PpQ@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=OY_nws-vf3VgnD54G205TK2YjkoAwRCyB9jvW=Oz3PpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D24E53F242
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15937-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,cmpxchg.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/14 04:53, Nhat Pham wrote:
> On Wed, May 13, 2026 at 11:55 AM Yosry Ahmed <yosry@kernel.org> wrote:
>>
>>>> Zswap objects are organized into LRU and exposed to the shrinker
>>>> interface. Echo-ing to memory.reclaim should also offload some zswap
>>>> entries, correct? Are there still cold zswap entries that escape this,
>>>> somehow?
>>>>
>>>
>>> Yes, the memory.reclaim path does drive some zswap writeback, but
>>> it is not enough for our case.
>>>
>>> 1. For a memcg that has reached steady state (a common case being
>>> when memory.current is below the policy target), the userspace
>>> reclaimer may not invoke memory.reclaim on it for a long time,
>>> and so no second-level offloading happens through
>>> memory.reclaim. In this state we want
>>> memory.zswap.proactive_writeback to write back entries that
>>> have sat in zswap past an age threshold, to further reclaim
>>> the DRAM still held by the compressed data.
>>>
>>> 2. Even when memory.reclaim is running, the fraction of zswap
>>> residency that ends up reaching the backing swap device is
>>> still very small for many of our workloads, and the userspace
>>> reclaimer has no way to participate in or control the
>>> granularity of zswap writeback. So in our deployment we prefer
>>> to leave the zswap shrinker disabled, decouple LRU -> zswap
>>> from zswap -> swap, and use a dedicated proactive-writeback
>>> interface that lifts the writeback policy into userspace where
>>> it can evolve independently of the kernel.
>>
>> To be honest I see the point of proactively reclaiming compressed
>> memory in zswap. If you use memory.reclaim, you are also reclaiming
>> hotter memory in the process, and you are not necessarily getting as
>> much writeback as you want. The memory in zswap is a more conservative
>> choice for proactive reclaim because it's memory that's guaranteed to
>> be cold(ish) and not being accessed.
>>
>> That being said, the interface is not great any way you cut it :/
>>
>> I don't like the 'memory.zswap.proactive_writeback' name, maybe we can
>> stay consistent by doing 'memory.zswap.reclaim', but that just as
>> easily reads as "reclaim using zswap". Maybe
>> 'memory.zswap.do_writeback' or something, idk.
>>
>> I also don't like having two proactive reclaim interfaces, so a voice
>> in my head wants to tie this into 'memory.reclaim' somehow, but that
>> includes adding a pretty specific argument (e.g. 'memory.reclaim
>> zswap_writeback_only=1'.
>>
>> I don't like any of these options, and we also need to consider what
>> the memcg maintainers think. I see the use case of proactive writeback
>> but I am struggling to come up with a clean interface.
>>
>> I also think we should take the 'age' aspect out of the conversation
>> for now, it can be a separate discussion. Well, unless we decide to
>> tie it to memory.reclaim. If memory.reclaim broadly supports age-based
>> reclaim then zswap writeback can be a natural part of that without
>> requiring a specific interface.
> 
> Yeah perhaps extending memory.reclaim is best... Sort of analogous to
> the way we have swappiness to balance file v.s anon....


Thanks for the suggestions, Yosry and Nhat.

My only concern is that if we eventually need to add more parameters to 
zswap_writeback (such as age or others) in the future, would it make the 
parameter parsing and the functionality of memory.reclaim overly complex?

As you mentioned, if the memcg maintainers have no objections, I will 
attempt to implement it in v2.

How about something like this?
echo "100M zswap_writeback_only" > memory.reclaim

Thanks,
Hao

