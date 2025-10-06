Return-Path: <cgroups+bounces-10570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BBBBF320
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846D8189BBED
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B442DAFDE;
	Mon,  6 Oct 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ8fwaM8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FF25EFBF
	for <cgroups@vger.kernel.org>; Mon,  6 Oct 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782792; cv=none; b=s0TD4nm2ajd56s7i/0S+XMsFC8WnQFFdBd4SGi9AEcjild6M6Ig0V+WINMGac1HKC2/U26gM/HIJTe5/ko2GdkRw24SJ7UCpLkyoazcW0fUkLPRCaNojRwbI5BFNRcUxvrqJisGClNqy8YbJpGaZjjK3tmgbr0R5S5IDwsLEhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782792; c=relaxed/simple;
	bh=htMAYDLDpp4f3g3S9y2VdKjyj7MTOVFS9ubsd0Tq4l4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QLa2GYmkFUKQTvz/klNxyzWkil6E41V04P46vZzXktrpM/ltkgQC+els3/xYmidH9gXtcjmYZyuD4suM7TsG21lYyso/f+84vtPF4bOl2ITQUsLllPihKkOwthhZT8KlpRNJMjM57LyU4/z5y/iZkP6uVn7vyTvwQmZdJEe5E6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ8fwaM8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554c8fso52942095ad.2
        for <cgroups@vger.kernel.org>; Mon, 06 Oct 2025 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759782789; x=1760387589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTuvAWVj1xNY2RCe1+5+6DP2geal1bbUoeJ33CVd4DU=;
        b=mJ8fwaM8bVTN2OyuMmZuTQHd9x3wbNQn3m+uJz5jyFyeeT4ykOgoN6Og0lY4qUf2uj
         2RIQTAe84GiSIRNhvHnrO26LDHEXs9qdmY1FvDCv7CijrgmztT46oDKwfsljk2yaZHVN
         Y9NkQXmcPXpA0Jewptm0S6uTgpW48aNM9rEVjKeIJkstR/bjaYDd9iT3Lj0vAv8miazF
         L/OlH5VjOWpnF7vh6JAx4DFi+YYPaB9jh10fIWgROdtRNnIDL8fuFy31XeFgYJo4iFmb
         O/MlVfDABBWIWHm9nhM1pfp1Gp82bAqSP5Feh94tdlkZWZAdgnqWwA2yiK3HVITQbTgl
         wlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782789; x=1760387589;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTuvAWVj1xNY2RCe1+5+6DP2geal1bbUoeJ33CVd4DU=;
        b=CNOq2gmc9Hjm8WKOaaiVLGXYVODiJgd6sJqCgZ2Wzw2t9yekZSjCihbZcQsLIl/LVW
         nNsmZnxcsrfheqaOnqBz8AJLZAKEmx0tayFxXs4N8P5shDTAP5h9cWCmIyKuoSwrWbyT
         kd1/XEcvjTk920bvHBmQh88BrviusgoybHOEESqM2rnMI/Lk8F6Ca0YGVN340akaY8J+
         mMRSduXv6SxoxmjLXERY8UHLVdKVy3o0SouNdUuWBeJ/SZiNzzGXARchL4HVlUnA1vGi
         B/53Gw0IY7LJGrods23xH9TlKufEKwQDR9ROSi0yIsrTdTNyO5MEuvIc93P1s9/5+FA+
         ne7g==
X-Forwarded-Encrypted: i=1; AJvYcCXvFsM4SDFxHDlxLgwXwY/uSpeqYZ/mTWXoiPr3MZzgAtH04z1+l3PRAptQv+ZL5hL6HS51H12m@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvJkXKLbD/kBdfCVPZz/2N2KseGda0WrevbLPtEd8ab+7OY2c
	cPslx4Ty2FoSLXB9pLAA5FMXoUoowqlFOYWjrsWNhnRKbXobKHBav1nS
X-Gm-Gg: ASbGncuhEcNDCuEEUZ5OOvkw+lSB6t3u0Y13rZxtvlFht7WUFaIKBPq5VdrbsVMxcjK
	D4pvzTaQ60cbtdgvUROEuP5NAKfFbh6jqkX9NKMGaSnWKtIMMIuDrzojcX+RqwHd5Fa1o2E70nK
	6IU5ndJMN8vZxkFKYLuqq7HqGtCu7JWipm7EA6WU9g+LpiRnzyq+4vHGYZc4X5pHNdMPBUpSvKh
	WwhyDjpPSe1a2v5dbPgrz9c4XSuqWk/9uwg6ZPrpoLs8DB+ruMDOyQaWmRVuYHjXbXrFbeQH6C+
	I5EV6bW6BpQq74P/sgdNEU5RfIXiVgCtbov0je8ItFUz06d3HYIkkbsxpfM9E/Xx/7/S+FXX8U2
	LEAjcyO8HrQo0RgLDpYSdNy8gfAmGPCzeyboRbVXUqBYs0Nx4OedwO/0SeYZ4N72OvS42HFqH3C
	H7TGv8
X-Google-Smtp-Source: AGHT+IE/MvX+CuLujIbF0sgN/kXRntG3wFGfdpL/t6ZHiDkab3quyg+ufA6rxyIuFBes0xT9d3Is4A==
X-Received: by 2002:a17:903:1b43:b0:267:a8d0:7ab3 with SMTP id d9443c01a7336-28e9a693f40mr159740215ad.61.1759782789065;
        Mon, 06 Oct 2025 13:33:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6b87:8abb:5d27:d3d8? ([2620:10d:c090:500::6:c573])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc00esm140825475ad.117.2025.10.06.13.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:33:08 -0700 (PDT)
Message-ID: <82c392dc-e750-43d9-9394-1df00a366ae0@gmail.com>
Date: Mon, 6 Oct 2025 13:33:07 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH] memcg: introduce kfuncs for fetching memcg stats
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20251001045456.313750-1-inwardvessel@gmail.com>
 <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 3:25 PM, Alexei Starovoitov wrote:
> On Tue, Sep 30, 2025 at 9:57 PM JP Kobryn <inwardvessel@gmail.com> wrote:
[..]
>>
>> There is a significant perf benefit when using this approach. In terms of
>> elapsed time, the kfuncs allow a bpf cgroup iterator program to outperform
>> the traditional file reading method, saving almost 80% of the time spent in
>> kernel.
>>
>> control: elapsed time
>> real    0m14.421s
>> user    0m0.183s
>> sys     0m14.184s
>>
>> experiment: elapsed time
>> real    0m3.250s
>> user    0m0.225s
>> sys     0m2.916s
> 
> Nice, but github repo somewhere doesn't guarantee that
> the work is equivalent.
> Please add it as a selftest/bpf instead.
> Like was done in commit
> https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
> to demonstrate equivalence of 'cat /proc' vs iterator approach.

Sure, I'll relocate the test code there.

[..]
>> ---
>>   mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8dd7fbed5a94..aa8cbf883d71 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>>   }
>>   #endif
>>
>> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
>> +{
>> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
>> +}
>> +
>> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return;
>> +
>> +       mem_cgroup_flush_stats(memcg);
>> +}
> 
> css_rstat_flush() is sleepable, so this kfunc must be sleepable too.
> Not sure about the rest.

Good catch. I'll add the sleepable flag where it's needed.

> 
>> +
>> +__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
>> +               enum node_stat_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_page_state_output(memcg, item);
>> +}
>> +
>> +__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
>> +               enum memcg_stat_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_page_state_output(memcg, item);
>> +}
>> +
>> +__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
>> +               enum vm_event_item item)
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return 0;
>> +
>> +       return memcg_events(memcg, item);
>> +}
>> +
>> +BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
>> +BTF_ID_FLAGS(func, memcg_flush_stats)
>> +BTF_ID_FLAGS(func, memcg_node_stat_fetch)
>> +BTF_ID_FLAGS(func, memcg_stat_fetch)
>> +BTF_ID_FLAGS(func, memcg_vm_event_fetch)
>> +BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
> 
> At least one of them must be sleepable and the rest probably too?
> All of them must be KF_TRUSTED_ARGS too.

Thanks, I'll include the trusted args flag. As to which are sleepable,
only memcg_flush_stats can block.

> 
>> +
>> +static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
>> +       .owner          = THIS_MODULE,
>> +       .set            = &bpf_memcontrol_kfunc_ids,
>> +};
>> +
>> +static int __init bpf_memcontrol_kfunc_init(void)
>> +{
>> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
>> +                                        &bpf_memcontrol_kfunc_set);
>> +}
> 
> Why tracing only?

Hmmm, initially I didn't think about use cases outside of the cgroup
iterator programs. After discussing with teammates though, some other
potential use cases could be within sched_ext or (future) bpf-oom. I'm
thinking I'll go with the "UNSPEC" type in v2.

