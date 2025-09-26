Return-Path: <cgroups+bounces-10465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63289BA2986
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 177634E157A
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD027F75F;
	Fri, 26 Sep 2025 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UDIG2jBL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDE27F003
	for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869875; cv=none; b=dv9J6t8eFsbJfV+jJLyfDrczkOVc29BC4dTtTU/MZh46dB+2OS4rKegYlWdVXVKQwjAUu7VgpUQRmR9xxmbAUFbIr657dIUOtHcdhUrQ/sLKxlN2e2FY+7emNdn+u7bXf5QE1UGBIGilJ5ydCBzpaN/a5Wt2r7A30IABCMfCFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869875; c=relaxed/simple;
	bh=YgymePRKA7a+5Gycw6dzc3Ehm1gp8bc3lnVl3WW1LzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDG7QwoaMh+9675ZzNj3xmAm83l1RPZAvKZhrYuLlKbpushXEaQLpUjZtBJ7R3CQ3INSUr0IiOTiVkUdW5Pitt/fd59NbHn9rClOKqqJUYxlxtGn2zcbE6cNsf4Q2Z+7eNVGRyqVoWe3+mhn0qka46Ei0lgpPGmXhTXo+Og0tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UDIG2jBL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b55640a2e33so1451976a12.2
        for <cgroups@vger.kernel.org>; Thu, 25 Sep 2025 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758869873; x=1759474673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vx1itF2fTgxMCrrImdJeroS3R9ZKO1BJn3DX+Hel84=;
        b=UDIG2jBLNC5IWX7ZlFEoTTyFqrtkm0iblohSdKFYLR2xXCigN3VFO4YG5WP+Yvz0Ld
         ArnxrpjPICdOtVf569UJpIrdC/n6Y7jX51iedDOYZ5tueypZRxeZtXWFT5go8poZX63U
         vciUNg38FvKOKVpVqc2IIDcKD+REJnMJkJZHCIDcIXBeyU3LZW2XlVkukwdilPfJly6+
         S238xtVRDoKjhGtEFKUJngwhwoUW2dKZ4rfyErigQ9qwEWRigT4kXic/PA/psHa/Tgc3
         OOj4bwKIao4xbFENoaIXpvqC97GqLPH9MX8+unZNLC2qwnvX+hZntM+8pEww6JxKfN+E
         6USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869873; x=1759474673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vx1itF2fTgxMCrrImdJeroS3R9ZKO1BJn3DX+Hel84=;
        b=hkY4/zACcJfEz6C8hfN+9E5wcart2oDRl/wOOlEQ8Iu8LUziaH5xHc5pVIlQBqXX7X
         oaUI81N0IzzNnl6ci20oSNteCbSKutNQENJ1dNEofpVwyZhtnUZRp42pa4CVDY//Egez
         7aMbgAP7W3l5KWJeyEQRxOIV983lVMeLF0eLMMDLzS2fFyxxww43bJ64iJ2oip3vNzJz
         FsvPzUAI048SrCVODaU6W2v3IquttiWvPEV9HK9GRcXNmvbEV8h75tDrIKC25hwQ3PHJ
         VD4t6hnjYIsX4glkbaG9nvB3QSEpwKO2FVF9XTaLErPhL4YADYF1Ox6+LLP+RFUs/4PK
         cNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfR8Mbz5OWU04Mbcs0FFPL1UQ4x2usHXjHUahn9T90OanXobXkDkTjGW1P0ljl2+LUMox/VjIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+5KbvxCAy0yXXfBl5HEq3Af3EV6hBN1vjAiEpKB3GsI/ijS0
	2ETw27xzYc/rFnMzkxhPrAgVzrAxNGRGFiUWBu9EJTrGt36eXZX0K2WHbyehDq5N9eo=
X-Gm-Gg: ASbGncsaGT8m5sZdJ6qKxIZNj7GATIkLsCv4cWOxtHgswBRJ/QQY6aHfyd6GOlFHv+G
	/iKw6IooO4KcMih9apY7fTzwOdepXK7gEULWY3QKp9Usls8wzbPNZyywOlIF/HUDnJE7X8GE7e9
	h16eSfA9/nLBZLWkyx7l0FZ9DTYE5sqaZyp51pYxN0+cgmgsTGIW7dNKXcdfpeRSBhpdglzjMA8
	FHRzsFNrPXldPXtK+zSWOO8mcyYEBfaah/o9S0RDNsFCXfBM64lxl7UmQFodJZjf8U8v//MApBL
	ZU2rg3e52fYiM8F9TC+1x3LFo70HH27elBKlxf0vs+OUSwFcmElXKAdUsjjhNVtFtuGsb0nqZ7N
	OGCEqbLmEHFWtHaJIh3njdKZuo9lwqNxLxX14lPkk3tBR6fW8fSMcqu6WPr6aYfjQK+KC
X-Google-Smtp-Source: AGHT+IF5bDf0FkWtdSNimjWM369R4KoAz2kYx41Je3d4j3cldNB8OPUueqbjTUh0a0uZVlv2hvbHNQ==
X-Received: by 2002:a17:902:db02:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-27ed4a91a32mr59676945ad.32.1758869872599;
        Thu, 25 Sep 2025 23:57:52 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27f1c1af2d5sm7102075ad.58.2025.09.25.23.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 23:57:52 -0700 (PDT)
Message-ID: <fc91a0ab-e343-4f7c-8fc3-508ab0644e42@bytedance.com>
Date: Fri, 26 Sep 2025 14:57:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@redhat.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
 <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
 <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
 <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/26/25 6:35 AM, Shakeel Butt wrote:
> On Thu, Sep 25, 2025 at 03:15:26PM -0700, Shakeel Butt wrote:
>> On Thu, Sep 25, 2025 at 03:49:52PM -0400, Zi Yan wrote:
>>> On 25 Sep 2025, at 15:35, David Hildenbrand wrote:
>>>
>>>> On 25.09.25 08:11, Qi Zheng wrote:
>>>>> Hi David,
>>>>
>>>> Hi :)
>>>>
>>>> [...]
>>>>
>>>>>>> +++ b/include/linux/mmzone.h
>>>>>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>>>>>>         spinlock_t split_queue_lock;
>>>>>>>         struct list_head split_queue;
>>>>>>>         unsigned long split_queue_len;
>>>>>>> +    bool is_dying;
>>>>>>
>>>>>> It's a bit weird to query whether the "struct deferred_split" is dying.
>>>>>> Shouldn't this be a memcg property? (and in particular, not exist for
>>>>>
>>>>> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
>>>>> the protection of the split_queue_lock, otherwise the folio may be added
>>>>> back to the deferred_split of child memcg.
>>>>
>>>> Is there no way to reuse the existing mechanisms, and find a way to have the shrinker / queue locking sync against that?
>>>>
>>>> There is also the offline_css() function where we clear CSS_ONLINE. But it happens after calling ss->css_offline(css);
>>>
>>> I see CSS_DYING will be set by kill_css() before offline_css() is called.
>>> Probably the code can check CSS_DYING instead.
>>>
>>>>
>>>> Being able to query "is the memcg going offline" and having a way to sync against that would be probably cleanest.
>>>
>>> So basically, something like:
>>> 1. at folio_split_queue_lock*() time, get folio’s memcg or
>>>     its parent memcg until there is no CSS_DYING set or CSS_ONLINE is set.
>>> 2. return the associated deferred_split_queue.
>>>
>>
>> Yes, css_is_dying() can be used but please note that there is a rcu
>> grace period between setting CSS_DYING and clearing CSS_ONLINE (i.e.
>> reparenting deferred split queue) and during that period the deferred
>> split THPs of the dying memcg will be hidden from shrinkers (which
>> might be fine).

My mistake, now I think using css_is_dying() is safe.

> 
> BTW if this period is not acceptable and we don't want to add is_dying
> to struct deferred_split, we can use something similar to what list_lru
> does in the similar situation i.e. set a special value (LONG_MIN) in its
> nr_items variable. That is make split_queue_len a long and set it to
> LONG_MIN during memcg offlining/reparenting.

I've considered this option, but I am concerned about the risk of
overflow.

So I will try to use css_is_dying() in the next version.

Thanks,
Qi




