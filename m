Return-Path: <cgroups+bounces-16602-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hjYzHLIQIGp3vQAAu9opvQ
	(envelope-from <cgroups+bounces-16602-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:32:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E06637159
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:32:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HflTiosm;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16602-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16602-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F3C300E246
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246123AA1A7;
	Wed,  3 Jun 2026 11:30:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8538AC75
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 11:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486213; cv=none; b=SfFaZK5B/OS+cTq7tB2emoWw4tZthOg/WB/1HK5mwZt5IGZdlJJY46Mq7cu0B6xEOOshN/Nz9xEDuO6+VYq9QEMEDM3GdDQwcFVUYxvKw2uHherzdTI4o7/VfTvnFSejicc3UVu1x/ykzrF90cys7D127z4s+rzBGf0rukMOyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486213; c=relaxed/simple;
	bh=xOTX+MabhctCMO0AxLM6gpxNigvHpYgWMa7i9UOhHnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI/TypIHSFaG01tGLRKMPKR/36AZKSXvh47rEe58UGuZkZ8fIttH/BnFsy+7/YacRTCoYr/kvRwI4H1TX/PTDEFnGVZATdYaw9k5U6+mlJBbJ7LHnykws2IhoerUg29p8qUIpHIYSSeeuaxJ18hWYOKEkIWbBgGt8mc2w9Jr9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HflTiosm; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so6261484a91.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780486211; x=1781091011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbLgrUUeNFGNskm0gEJ8DV84HGEbh6GoBjogs08lHeE=;
        b=HflTiosmYDes4tYn6xBTvtNMA9IHO7j7HDcC5GlLcw9p08u59BhVroSdNUHxvM+FMU
         u1esqBX1BrZq8bEUKgpKVwTIat6I3AdlOwTkyrwlbF5AluWNAGyrXjjDizqIfDWJTyJk
         4eYKVBsAQ6losAOMrAnQVCJaico1mTsopPAiDMV76utdbI1H8dq9O74nSI8Fd+DrJg8I
         NmFeH7ZQsnc67GIP/iztZo8OVpQaEbr/32/4JgSbINU4tPBOrNsO0hEHPKGDJ+dWRlof
         ZfXWaCJmvNkKuZTmC/MAqjpiF79/TJrD+cDX24mTd1BFlj0odbYgsf7a8rUo/rcP56iF
         EXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780486211; x=1781091011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbLgrUUeNFGNskm0gEJ8DV84HGEbh6GoBjogs08lHeE=;
        b=KHrdWoPkXyOR0aBBdlipXNEWt6MKbuPy7EPUq3Sb8wnkUKmNHcjXcICexsoBZGwEL5
         xkv0EmTJ5dgfH+5E0+UbQq0WxLhrHaI8ym3OO9+PMeQ7zJ63BegLZ3dUmGdy+WIytab+
         ecTjVvYQBmjb0vf1JS/FtQDKKz6/PuFwaAS1OmTV5D6wiAaxhPhyVIboO6/KY1fZH58D
         z6Gj+345n4EUnC/7EHKtJ/HJIeCHXtRoHU4tThSf5/9PdpCLtXcmyWHljJ5rck1CwscR
         lAKYcZTNOVQZ0mEWkbf9cSWt4dxTdTzAdGitifzjdv6XX9jC6lGXf6P9cqQ9fmNM+J+0
         +UVw==
X-Forwarded-Encrypted: i=1; AFNElJ+4XPYQVSQhyLpj847odP13SvkS680kpHtqoIyLo8BjFlb2vsfG77e9THH/0PsX6LdoomlNb2xj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iwTh627l5GTH/Vem6G73mBUOQ4NihAqnddYc0GKeONk+ydfx
	KJ0xEGiMwtPXxcPgt0Y2CxTV9n3VjY5wt+tJx8pTYxluJgGgoAczGNWzq03aVg==
X-Gm-Gg: Acq92OFEuzGpEoTuWKvsRHCrMj3IE7e1EgJ4dDHsgTMw6dFsujvuaM2H+ClEMVvEOv+
	8XZTNgoliUQ8HGyOBNjDpe2Gy4cn+LmJhRWKVfquoRpkx8sV9Naxrv5uLmKhsZu97yg6eB2/WDW
	YzDUzNdIPs0jaPOJjMfMRSUZO/hoW8SimfgAantpfUhbkpIpMAR2F22Rm+gkwpimYXSvVEtOy8K
	20UhidOvtElpmb3C74C/y7yeDq6KaLYCwA6CHZH+YGpWwb5tI3BapE92XcGrQPw4tiLiYg8FeMV
	5QgrwhpHnRwn0DtokwXQjSmG3cKX8g/Kg1SLAcrtreEuWd5MLSR4jcsTtL0Q1gsp+6Xf24/Zozk
	1Ze1YBv6+Ou91WMvZypkld1Ad8d47aFtHDs7L10Fp9wC0112MdV+UukpwCZrMsccyu4HIkuYtWr
	OGoaiHdH4eUuqdMCAKfbSaOdA/ys+RR+7qg20sijZe1+HW3X8ehppzJa28SindX5R3
X-Received: by 2002:a17:90b:2d8d:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-36e32285cf3mr3042276a91.14.1780486210499;
        Wed, 03 Jun 2026 04:30:10 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91820f3sm5910449a91.2.2026.06.03.04.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:30:10 -0700 (PDT)
Message-ID: <e2ddd20e-f092-4559-5d1f-d5c1130d2538@gmail.com>
Date: Wed, 3 Jun 2026 19:29:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/4] mm/zswap: Add per-memcg stat for proactive
 writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-4-jiahao.kernel@gmail.com>
 <CAKEwX=PcFqmsdFqUnpWxrPkoc1B-1w3CEb0ydK3df0qJGG-mnQ@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=PcFqmsdFqUnpWxrPkoc1B-1w3CEb0ydK3df0qJGG-mnQ@mail.gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:yosry@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16602-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7E06637159



On 2026/5/30 04:01, Nhat Pham wrote:
> On Tue, May 26, 2026 at 4:46 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Currently, zswap writeback can be triggered by either the pool limit
>> being hit or by the proactive writeback mechanism. However, the
>> existing 'zswpwb' metric in memory.stat and /proc/vmstat counts all
>> written back pages, making it difficult to distinguish between pages
>> written back due to the pool limit and those written back proactively.
>>
>> Add a new statistic 'zswpwb_proactive' to memory.stat and /proc/vmstat.
>> This counter tracks the number of pages written back due to proactive
>> writeback. This allows users to better monitor and tune the proactive
>> writeback mechanism.
>>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  4 +++
>>   include/linux/vm_event_item.h           |  1 +
>>   mm/memcontrol.c                         |  1 +
>>   mm/vmstat.c                             |  1 +
>>   mm/zswap.c                              | 41 ++++++++++++++++++-------
>>   5 files changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 6564abf0dec5..7d65aef83f7b 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1748,6 +1748,10 @@ The following nested keys are defined.
>>            zswpwb
>>                  Number of pages written from zswap to swap.
>>
>> +         zswpwb_proactive
>> +               Number of pages written from zswap to swap by proactive
>> +               writeback. This is a subset of zswpwb.
>> +
> 
> nit: I think this is specifically the zswap_writeback_only mode right?
> 
> Technically, normal proactive reclaim (memory.reclaim) can also hit zswap :)
> 
> Maybe some clarification here?

Thanks for the review. I will clarify this further in the next version.

Thanks,
Hao

