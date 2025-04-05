Return-Path: <cgroups+bounces-7371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A11A7CB96
	for <lists+cgroups@lfdr.de>; Sat,  5 Apr 2025 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CFB188FAF8
	for <lists+cgroups@lfdr.de>; Sat,  5 Apr 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCC1A8419;
	Sat,  5 Apr 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzMJ9mSy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B13B5A0
	for <cgroups@vger.kernel.org>; Sat,  5 Apr 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743879132; cv=none; b=Lvhw8iJARCU74Oer6/ch8rtk+h7zh7dBhVY3pZshjPEM4sowA3d8getwvxdb355w61q/tbywAMII/MQjQDbCpIJKRJzfRKegxPRJ+aOtgZ26kjjmGT1xwwheqg2OlUtcwVDXZucJGIUdtZT8ag8iBdONZejoD17JYXPQYp3KkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743879132; c=relaxed/simple;
	bh=yglMeQsz123gDcvxpHoJHPRefkgMmB+L1OHo5trNH0k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PFH2jLbF0Xz+30gGlWEx2NmpJrHn3hxHHt1vANRSiK6dBI+/s+1T/f7v5NlNolZ5O6I9iQ18nfb03vVkRXGBMwKG/DoWH+tZR6xVmDJIJKa3JbhU/qguapugYPt1I6IQs49MIHaxljkzfODeQH9cm6s42xPocUNmnfb721FSyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzMJ9mSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743879129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl94fjucYs05RLWzioyJn3c96IDAkKlAGNSFTZYapG4=;
	b=hzMJ9mSyiKmeo7tvuGNeCwhMasGGU0GoU9B1lqazxfii1G9rY3UGuvhLTqTOMAmbmLVFL6
	vh3BY7DmRdR0M9QcAEEmeT34YOYvGb1qfAPPjb2C6cLBvBxG7wHJIcJvydgvHGA8TRPu1B
	PF6gYTxMSJxuIVmWKA3p5UdU20OfObY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-grx8LHrzMLmb1-zUD9BlEw-1; Sat, 05 Apr 2025 14:52:06 -0400
X-MC-Unique: grx8LHrzMLmb1-zUD9BlEw-1
X-Mimecast-MFC-AGG-ID: grx8LHrzMLmb1-zUD9BlEw_1743879126
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54e9f6e00so684656985a.0
        for <cgroups@vger.kernel.org>; Sat, 05 Apr 2025 11:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743879126; x=1744483926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl94fjucYs05RLWzioyJn3c96IDAkKlAGNSFTZYapG4=;
        b=qIWSlIP4Aeak/SEck9RpPHvH0qz5rnbgUS++EqlwkIScA4khxV1JEvrFk/F+bEYKly
         bLzKNIgLIiBl25e/WELXNICaKCGGnHpS3AZdRce/PzbwlWzTwn1bmf7bbfYsbIkcLhWz
         hTbzVDZ0BjM8Dko/s0LXZkYjDeauksPwRGXUOQ5ab25SUau9WABhYc7mHS6SoqZwQlil
         HjviLx0GxX90gQYCLPrS+MSzMRUB/f6lVCiyTnx0SLBJosiwdO83mxaI8pI0yYXOvOUN
         fcCTYOJmR3DQQqyliZWf61iKslliIPAWyMisKWOXft1lsuIsipzvcoOYFvgp60MZbAd6
         a5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUrNLJIYQj32YviHxndvtaHcvHX99GOSAyp3kJbLYNdmfZRO4AUmUg86Tcea2835vACXCecx0mm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DBigzcmHeFssc7yDe4oChHa06sIbuvGWviJ9VcotXnHGTDG/
	Rk1cswRaRaMNLovTqfnw8an10lhrVAMuH+jqxPwy3u5S50LAsSeXACxCgpIBzZCtGC2fY4GCKhg
	Ra/pkwZRyp4SbQ12KHM93jTtM58s61tP4ioHd3S6UFrAhCVFcKGxfvoI=
X-Gm-Gg: ASbGncsI+U88sP6DB/tZPKCcZATi8pB5adk3YOgpsvWZ9Li5+0Zh50lyHRBzRYEiw6Q
	LaXKt6xiYJCUbsSzHcgsIvZ3UbeM5zPiEdaWzyvFm/tFGIAdI7btXKignV7/mY1zz6vNWfnVcOL
	ElvPU/lL1bfkan9OZR1gylDhV33T8lCUIvJPQkw5K63o+y1UPqCS7204Qa2n7ZBNwrGXiFIggFh
	ltjFKj+8smsv7tBjdbYK4bvqorBryodsqZGiqjlNNcNMK/5WNnYaXqgEIT/y77KMx7cmmS1r930
	5vz1/OIxL8nTYvSTmcRW/aY9YOVtyOMwZb6EUlKM85uDPD70fluWx2aHPlJ5kA==
X-Received: by 2002:a05:620a:2891:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c76c98f69dmr1949212185a.13.1743879126143;
        Sat, 05 Apr 2025 11:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQV+pEi+TmbqcIT9YnR48A7CUH0qtIrkXsV397pZvj687wq1qfmiwok5il5SMAFPR0p8RYA==
X-Received: by 2002:a05:620a:2891:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c76c98f69dmr1949210485a.13.1743879125856;
        Sat, 05 Apr 2025 11:52:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e968c1fsm371472485a.52.2025.04.05.11.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 11:52:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6712624c-c798-4ccf-afc1-6dfc9efc4b5e@redhat.com>
Date: Sat, 5 Apr 2025 14:52:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
 <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
 <20250404193802.GA373778@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250404193802.GA373778@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/4/25 3:38 PM, Johannes Weiner wrote:
> On Fri, Apr 04, 2025 at 02:55:35PM -0400, Waiman Long wrote:
>> On 4/4/25 2:13 PM, Johannes Weiner wrote:
>>> * Waiman points out that the weirdness is seeing low events without
>>>     having a low configured. Eh, this isn't really true with recursive
>>>     propagation; you may or may not have an elow depending on parental
>>>     configuration and sibling behavior.
>>>
>> Do you mind if we just don't update the low event count if low isn't
>> set, but leave the rest the same like
> What's the motivation for doing anything beyond the skip-on-!usage?
It is to avoid making further change. I am fine with modifying the test 
to allow low event even when low isn't set.
>> @@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct
>> mem_cgro>
>>    static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
>>                                           struct mem_cgroup *memcg)
>>    {
>> +       unsigned long elow;
>> +
>>           if (mem_cgroup_unprotected(target, memcg))
>>                   return false;
>>
>> -       return READ_ONCE(memcg->memory.elow) >=
>> -               page_counter_read(&memcg->memory);
>> +       elow = READ_ONCE(memcg->memory.elow);
>> +       return elow && (page_counter_read(&memcg->memory) <= elow);
>>    }
>>
>>    static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>>                                           struct mem_cgroup *memcg)
>>    {
>> +       unsigned long emin;
>> +
>>           if (mem_cgroup_unprotected(target, memcg))
>>                   return false;
>>
>> -       return READ_ONCE(memcg->memory.emin) >=
>> -               page_counter_read(&memcg->memory);
>> +       emin = READ_ONCE(memcg->memory.emin);
>> +       return emin && (page_counter_read(&memcg->memory) <= emin);
>>    }
> This still redefines the empty case to mean excess. That's a quirk I
> would have liked to avoid. I don't see why you would need it?
OK, I will drop that.
>
>> @@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat,
>> struct s>
>>                                   sc->memcg_low_skipped = 1;
>>                                   continue;
>>                           }
>> -                       memcg_memory_event(memcg, MEMCG_LOW);
>> +                       if (memcg->memory.low)
>> +                               memcg_memory_event(memcg, MEMCG_LOW);
> That's not right. In setups where protection comes from the parent, no
> breaches would ever be counted.

OK. Will post a v3 to incorporate your suggestion.

Thanks,
Longman


