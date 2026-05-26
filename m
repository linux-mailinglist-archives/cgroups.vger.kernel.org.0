Return-Path: <cgroups+bounces-16312-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC6GJnqMFWrUWQcAu9opvQ
	(envelope-from <cgroups+bounces-16312-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:05:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD385D544D
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC02F302BE0C
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F413F58EB;
	Tue, 26 May 2026 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEFHCoRr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677403F5BC7
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796608; cv=none; b=H6GRi9DIhlsjtT2eBOp6N4nboQIAfrIkBFeZfktbAurHjiWybahg35WJI7rO1tRT4iEk7oMO96+mo1ZrWlEGZja7/9dZwo7uqcySyPnNDaIJU3yNNZvwmo14+gdpxP7rT5t+bjhVv2X2RJkZvJ5i4yUOJpHxFXEhqbeGTOJwLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796608; c=relaxed/simple;
	bh=eQi4btdZRSOuUIsDh49YQq6zAAIvQJ0rVwcZD0zz4UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1+TNkpmVO3mGwmZQj7cttMc68903C00GBrH4MFcNfrdH+S98zeLHUChWsML3nVEtFgbyyuxxX9OjG/lX2eT0JbeCOOXWRAMJQoeAkTcV+2DrTy2/c+hbT9KPa9wVgihu8RMvegPXWcPq5g5LWnbc/VE2HZpYPFw6TndYWU3wL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEFHCoRr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2be1dd4af34so92859835ad.1
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796598; x=1780401398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8JaNo1vOaK+r4fFp4lVpergJl5Sjg03Po9hQ9chJkg=;
        b=QEFHCoRrxb75lszLe6FGdI+DIY1HMwWo1yYsEBPLadVyPe3tZM1fta0mHlfWPbgcjc
         kPRdHrPY/OvFc+KEBUz+Xlb0VONFMaUAYdGWmRXwoIVvyz8l4laKKq66I69pgwP+9O/A
         vd6xzjUj7oY+CNKe7k41mpGmvbqnovK+skRjM0EE6h0tAviITZG6d4DIQWwx/OZSeVdE
         Xgb6I3GUMltQsHT8GLISGa6OaJegbv1lyrJp/iu+qR3xX8QSDii4wrpHfljE8V7tIi55
         X9IOScqogGu8vk/em+dO0pDjOnKCJR/HL4lv73MOwNgOdejCowvN90lp5klMnisZVrvC
         EKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796598; x=1780401398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8JaNo1vOaK+r4fFp4lVpergJl5Sjg03Po9hQ9chJkg=;
        b=ZiyLh3bWiFtBWbDbyCfKGkjWQy24ks6WC5CMshyQ6dQA0YUjpRTzlL/jEatdxOWs1W
         1yPxovHz++uL92DOdm1JHhEDbK2ViLnzWdfVFs2Vqwa4iinh9lgti9bwFMvKpYgEpDQe
         xElcleT+nCP2YF4/0z2LuruMLgIqaXfnTMIH1q6+MRoYqWo4utGfNoclEx5oZK9P53QM
         DxKtwHKLwjt4FRHLH69SxTgBJVz/80/4IPB9Hw9/mIHX9Yaj2a0NMXivZC48cl22SNbE
         xtDjfno2aTYpFgdT1pbXVmIQBhkHiUKBiZU74l5ftoeso0Utj2QmaLjPlKJ0+BBgGdfH
         +NBw==
X-Forwarded-Encrypted: i=1; AFNElJ/L+mKoCqKcdpV9bkmBdZOsXyyB7xliMHwdkbtq1GpW/gNsZvLp3w2JxHEW3oxrrk3IvvdIUI4g@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVyIpUB+X2LmAoRQDbeux9fvuezvmYC8RYT7ojMO1ruFpjehf
	LknJ3e77cIDYUCUq7ibosxN4yq5/5cZ9xHHNBBY6L+T25TvRr6HefFji
X-Gm-Gg: Acq92OHgHMKAs+g6GDgjzj3Q1MemYz2B28U0tIh3qhdcwYyq4cEYqqJmK7YaZ9a2PlZ
	3VokduPA5onWOm/EBpwyiVKAb/3/Kv28u28fdxqbv6D0iLPFQPD8rucXSHjf7sSRtmcyU7VMsdU
	wD/d/4iUNtaF3LWVbmQqY2l1rr4kU6cHRghNMqfKg9kRCNL/V3Do3BVQu0Wwm9vMSYpdNo76GrD
	zDREhEggZ9paNXRidlodzeaThGEKcrg5ftkqPHb6w1hKOek8t96XHm2ItwLG66VRdVWTGxDd9m8
	PwZgbEnXXKm8noRoqctVjbOf304DKXppJFR1u2wcz4dyM4ZX/7DfQDpYtkJyNiRq6Sluwv1Z9im
	yfFOUGXGN6igHrn05m5DUz5Un9yMqH1KEAmd/iw6yX4JA0rgjE9aB07Mxigh/zcZaFJgtME2kXd
	cXLvgw7Aj87Hj7YCFS/aKziMBgULMyTdFICgklzxVEscFctaOn8K7S1Tg=
X-Received: by 2002:a17:903:350d:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2beb065aa18mr205863945ad.34.1779796598367;
        Tue, 26 May 2026 04:56:38 -0700 (PDT)
Received: from [10.125.192.130] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2cd6sm126864375ad.52.2026.05.26.04.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:56:37 -0700 (PDT)
Message-ID: <9b2ac88c-a67f-2512-d898-3dadd50ec03e@gmail.com>
Date: Tue, 26 May 2026 19:56:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/4] mm/zswap: Implement per-cgroup proactive writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
 <20260525122424.3b2818f06832d9d55da8d69b@linux-foundation.org>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20260525122424.3b2818f06832d9d55da8d69b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16312-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1DD385D544D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/26 03:24, Andrew Morton wrote:
> On Mon, 25 May 2026 20:22:38 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
> 
>> Zswap currently writes back pages to backing swap reactively, triggered
>> either by the shrinker or by the pool reaching its size limit. Although
>> proactive memory reclaim can automatically write back a portion of zswap
>> pages via the shrinker, it cannot explicitly control the amount of
>> writeback for a specific memory cgroup. Moreover, proactive memory reclaim
>> may not always be triggered during a steady state.
>>
>> In certain scenarios, it is desirable to trigger writeback in advance to
>> free up memory. For example, users may want to prepare for an upcoming
>> memory-intensive workload by flushing cold memory to the backing storage
>> when the system is relatively idle.
>>
>> This patch series introduces a "zswap_writeback_only" key to memory.reclaim
>> cgroup interface, allowing users to proactively write back cold compressed
>> pages from zswap to the backing swap device. When specified, this key
>> bypasses standard memory reclaim and exclusively performs proactive zswap
>> writeback up to the requested budget. If omitted, the default reclaim
>> behavior remains unchanged.
> 
> Thanks.  AI review found a few things to complain about, one of them
> described as "preexisting".
> 

Thanks Andrew.  I have replied to the AI's review comments in a separate 
email and posted v3.
https://lore.kernel.org/all/20260526114601.67041-1-jiahao.kernel@gmail.com

Thanks,
Hao

