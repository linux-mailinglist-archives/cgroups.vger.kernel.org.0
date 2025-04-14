Return-Path: <cgroups+bounces-7511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5664A88184
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C4F3AE84E
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34F2C374D;
	Mon, 14 Apr 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0ijxEke"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB027C869
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636566; cv=none; b=KUrRTi3El8rKt8Ad5tKd5R3pcHvnYgua5E/6nWZi2aENksyK0a61LktCj2aGchepDwf32ziOB/aOYmq39wQNK9Mmez6A2tHgtx103iRCfWP5XKxngeruc/r3n9XGGKJIgVwr+yBo60G81h2xnqcr3xXKuyQghr+z4Z++lyO+VoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636566; c=relaxed/simple;
	bh=lxd1ChqF718weWD+hNXDxRZqp4DmKNuj/omQ+yf+A9I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ao3p62jWvsc9iFZSvOsUmCAdK4CUNAxGO3afr03HtmMmNviDDHwhckcDuYXluNKylQ9aNHVBzpI/N+98yFX12yeDB8az8fvctKA6dO5VH1vNxlkPVM0/rpq3T05MnHYSHO5NQikvw6dlG4QkO027OGoEiV0cE9mfFjztTuCijPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0ijxEke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744636562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRlj2XiJciKq03l66vQT5GTuJKT9oCmFfbWUfZiluAk=;
	b=F0ijxEkeX2SkVd/3qst8spYRLRnF8fxS77P6NKFx0G5OllcemNgQEOgHu1vdli4z5mpmdV
	6zeip2PAG2gW4YGsT1HeMKGYd13tYCCNk2d/atiHOLDrUhsPx1211uVddjhL1CyrQiLGjg
	/LJwDDOnVuuk0382+3tAi8jVqzEJg0w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Rk6OHMYWNtOx9qXQzLGMgg-1; Mon, 14 Apr 2025 09:16:01 -0400
X-MC-Unique: Rk6OHMYWNtOx9qXQzLGMgg-1
X-Mimecast-MFC-AGG-ID: Rk6OHMYWNtOx9qXQzLGMgg_1744636561
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so40598265ab.3
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 06:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744636561; x=1745241361;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRlj2XiJciKq03l66vQT5GTuJKT9oCmFfbWUfZiluAk=;
        b=WJrarmVFbdoUalclOqoJ0al0ubf/OJ2vVlGNZ1loZPP/V5nK1ak0j1Q7PcckLNtI7t
         DjTEgwUmFZyuWqmRr6KcVd0vQx69fi0UmBx/6nOg/EDuUGQzu84bxwqiI1KW7WYNaBnY
         ScvY34tSF+83eMDxqK2TYuBpfXywUmCiFwOVBI31nZyXt3TCcF328zBPO5s67DYZQ0/f
         QADsqrWWEtq2L/UXl4BLG3xguLdBA3+/SdRxyHx43XA1ndscSMQ6NwBTQHI7ZlxtR0Rf
         hmvk/K6TbjncDZZNp1vPPiRCy5nMRTPiMTpWpYa2LLpuAScFIhhVdYRPrB3EbyCb0PuE
         +jPA==
X-Forwarded-Encrypted: i=1; AJvYcCU/GSry06vo7cJybuTh7xnIQWUbok9SQF49xR1kZuCZRUzLHKV0cvBdBPPPtj7tqTgQq1bZEZaS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9meLoJLKPQPcnsucGz9YVKYg3YHYpHPQsxHd7+L5ZPqKf3sQ
	M7/sVikMuNPgdAcK+QjlIDtjx6PyykGVW4n+0xx1j2ZeLRuq1QzzlhkgCQjai4ozwjMk6Mk8zOo
	zx4+fXs3PK4abnORopm3SdMwltf5umFrs8wOjbyZZEhfDXns+qWfkvpo=
X-Gm-Gg: ASbGncsF6iJHuT8/E+kve6jyBkt6Ns9ClPBXEANYKCebKWEuEAEOy5kUAEdRd2MNdqi
	7Io4xQwPWIzC3lIcblEFrbSDXgrdNJwqixsp5Mo1BJVFyr3/OSoMd/o7ls2Vi90rzaYGr6TxHfi
	ih7l4SibnXxxfsqC6m70FXgNe+9D0FxUFwwXPZYTtu3R2jVebGH8lVJmTEBUj56x8mP+3nC/qMf
	KwX+EeZKkYfT4MNcbQM7694JSIpnWQSKLfjHngM2Wt8mKlRRJHW6ItM6/pLzGAwekYlqYp/lsUY
	hyXSEUcJMhlSbSz2UySTN2exawyZd4Y00PdbIe1wU0b2W9V8AeIpKB70mg==
X-Received: by 2002:a05:6e02:3e03:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d7ec0e19e8mr104215065ab.0.1744636560582;
        Mon, 14 Apr 2025 06:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgHhxXQS+UkS433TZApZsN2X07PGZoXRirGDSpfOpQyLI61v16Ezptx5B12okrDFUSAgvBg==
X-Received: by 2002:a05:6e02:3e03:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d7ec0e19e8mr104214525ab.0.1744636560045;
        Mon, 14 Apr 2025 06:16:00 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc5826f5sm27429815ab.49.2025.04.14.06.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 06:15:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
Date: Mon, 14 Apr 2025 09:15:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
Content-Language: en-US
In-Reply-To: <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/25 8:42 AM, Michal Koutný wrote:
> On Sun, Apr 13, 2025 at 10:12:48PM -0400, Waiman Long <longman@redhat.com> wrote:
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0. Again it may have a
>>     non-zero low event count if memory reclaim happens. This is probably
>>     not a result expected by the users and it is really doubtful that
>>     users will check an empty cgroup with no task in it and expecting
>>     some non-zero event counts.
> I think you want to distinguish "no tasks" vs "no usage" in this
> paragraph.

Good point. Will update it if I need to send a new version.


>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5963,6 +5963,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   
>>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>>   
>> +		/* Skip memcg with no usage */
>> +		if (!mem_cgroup_usage(memcg, false))
>> +			continue;
>> +
>>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
> As I think more about this -- the idea expressed by the diff makes
> sense. But is it really a change?
> For non-root memcgs, they'll be skipped because 0 >= 0 (in
> mem_cgroup_below_min()) and root memcg would hardly be skipped.

I did see some low event in the no usage case because of the ">=" 
comparison used in mem_cgroup_below_min(). I originally planning to 
guard against the elow == 0 case but Johannes advised against it.


>
>
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long goal);
>>    *
>>    * Then it checks actual memory usages and expects that:
>>    * A/B    memory.current ~= 50M
>> - * A/B/C  memory.current ~= 29M
>> - * A/B/D  memory.current ~= 21M
>> - * A/B/E  memory.current ~= 0
>> - * A/B/F  memory.current  = 0
>> + * A/B/C  memory.current ~= 29M [memory.events:low > 0]
>> + * A/B/D  memory.current ~= 21M [memory.events:low > 0]
>> + * A/B/E  memory.current ~= 0   [memory.events:low == 0 if !memory_recursiveprot, > 0 otherwise]
> Please note the subtlety in my suggestion -- I want the test with
> memory_recursiveprot _not_ to check events count at all. Because:
> 	a) it forces single interpretation of low events wrt effective
> 	   low limit
> 	b) effective low limit should still be 0 in E in this testcase
> 	   (there should be no unclaimed protection of C and D).

Yes, low event count for E is 0 in the !memory_recursiveprot case, but 
C/D still have low events and setting no_low_events_index to -1 will 
fail the test and it is not the same as not checking low event counts at 
all.

Cheers,
Longman


