Return-Path: <cgroups+bounces-10796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6197BE117D
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 02:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993FE4E3DAD
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473C686359;
	Thu, 16 Oct 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgXQaa+Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDB1C69D
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574113; cv=none; b=eTAStCbSWBq4kSxrSABzLqL6xe2ocrloFt2kYp/49bkP03aNx2VNw/D5I+a9MFwVBhqfF2xR3m8HSlWK67kuBcTAg1N0lEC0HHVVpEMKrBMyv/qjDwp49n43o16Juw8Dq7qVOBnqq1asqpTeiGFKNOR/BOgnCD/dmNsJPMxWsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574113; c=relaxed/simple;
	bh=/N0dcrQj5SraVazDLw0BzRk4oHH4JebIn/XXG7nzvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1X06azvkPijEPhEmBnOi6ZecRGkyN8fcyfg1SffU9FuUYrCQJaX2oOC0/q5HJXrxgcn7BemgUT+RCBiovc+N0147KQ4kkID5opo8LYtrkmgdRllzpo3U8yGjGsWz3D/ERnwQBBeerrwIEug7GXc5UmubHjscPrYZ5oqFUsltrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgXQaa+Y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7841da939deso166647b3a.2
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760574111; x=1761178911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+uYbmyg7U3B88BGBaRnrEy2BORWFbRru8RT/OdSqk4=;
        b=JgXQaa+YZLECs9YCT9kbgPUMyZ23Sbmw1IEbxU/u7SQor+8QVMgN/4kiiM5SzVD7J8
         OTkzAmVvKUkoX7wN29DZXM9vmFc7ykJjVKMBKhldcuCRIT0lJy45Lw8Sta51Ya+i80kQ
         70R3Z7bN2TZ+vCdnIwhMmLaT9YlDQVVN3sX0x+6OrSQCpAIaz+gCznrNHA3b5Dt3wX2h
         KRdX2HkjV6fely7yMTQgxyJpm/+rgb3BYV3yrnkZOp34oxqQ6tyoARmiEYlzeCBoEM/r
         NLM8xl2LH6q1aBZBT4hNZkidzuyn5OTyHf0Iv9c1v4xUkIPCmjc/wZCtKMReX2YTaFBI
         oA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760574111; x=1761178911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+uYbmyg7U3B88BGBaRnrEy2BORWFbRru8RT/OdSqk4=;
        b=rpleuY4huj4ZuKjwJo85shn7rVpqYM0Y4e3E0ZGxasCYpUX71XV2fu3tMKqwVhR9iS
         zlkURWLrYm3XAfWXAcEmnHhqbjJ2Ood3TzYA2Pi1eU7zDjl9IyAYfVKR7fM9p/6P/bg4
         FUuwEMzgEUn7ZoM6HsSBOyxwHRPlvHspO8gbgq/am9VODwqkK4fzKewSv94t+ur6wwMG
         iq7ysVTZP1MxxIJNwRvZ5Md2pvcbd/t+9dLXHOCjNxdPCNmf5qZ1xAAA8QnAfjSJ0/GT
         qxIom2lnurfVTQuiIof9cU/4e9E04m6IEd6doON47A7mMRpkYS2WTtyvfpJU87IMImTO
         hKtg==
X-Forwarded-Encrypted: i=1; AJvYcCU8nC6ZPpZyXVJOj2EuAKSJEJIzizrwX1TtHNOhQqElB6FJ+/mg89pFb4yPaKaxKI6osjFGUuQJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NZMFIrhJEcTLUp1yw0bfVFOuF4gTp1EhtEgEXt+7tTR5cvtJ
	odsmXnp4k6Q0ckbxH5cVkT4ThQKM/A7nY+Cd2uQPbPYBQC9U6fSZ7ASP
X-Gm-Gg: ASbGnctd9je44nKsc5vkBtTdDZJwNA6NQuDg+xteQn4+loyky3j8lz9mfvWFKbdgvU5
	07jqbNAIz+WZKhHoArC7LfqchZ3XJW6XORuFbhQHgLjLTIp5UPlA3ZMlsFdc4QIsoHRSF450bmZ
	KG747N4xuQBq0s2RIdTx8CA6Ba6LV4PGSGpxVFeHLMGc+S80q8xdazwmaEJf8wY2iL5Z7y2bC0F
	rhbGVvKFWAOnmmjM1eTiLIuzKI3BEipCrFhBoZm7S/Kq7CyQAe7B9AmNL3//rE9wpyzxT/xfePt
	JjSW5je02NWq99YJ+lnVCWeK2Zy8zqJqjfhMwA9253GvxveBM5gAUBAJOAlm6k1U04aPm0k5fFv
	fu8nO3aB/fd+JEwqHA/fzfHkzVu6VE61hxWyh/rHplwMD85cn2oKEBwqTqiUay2EydEb0ai4/8j
	FJmYW6akGwzsUpCJvhmiicoVBVWXPtp2gt
X-Google-Smtp-Source: AGHT+IFJoepWNlU4+NBSNDZxjoH+m9KoM5DtxMqbC0OMbJN+YNUJKDrPJWuArAGQancBO2mZtAQxFg==
X-Received: by 2002:a05:6a00:4b01:b0:77f:1550:f3c9 with SMTP id d2e1a72fcca58-793859f34b3mr38869276b3a.12.1760574110523;
        Wed, 15 Oct 2025 17:21:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:b813:d910:1b7:5928? ([2620:10d:c090:500::4:c263])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm20056806b3a.40.2025.10.15.17.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 17:21:49 -0700 (PDT)
Message-ID: <e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com>
Date: Wed, 15 Oct 2025 17:21:46 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, mkoutny@suse.com,
 yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 1:46 PM, Shakeel Butt wrote:
> Cc memcg maintainers.
> 
> On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
>> When reading cgroup memory.stat files there is significant kernel overhead
>> in the formatting and encoding of numeric data into a string buffer. Beyond
>> that, the given user mode program must decode this data and possibly
>> perform filtering to obtain the desired stats. This process can be
>> expensive for programs that periodically sample this data over a large
>> enough fleet.
>>
>> As an alternative to reading memory.stat, introduce new kfuncs that allow
>> fetching specific memcg stats from within cgroup iterator based bpf
>> programs. This approach allows for numeric values to be transferred
>> directly from the kernel to user mode via the mapped memory of the bpf
>> program's elf data section. Reading stats this way effectively eliminates
>> the numeric conversion work needed to be performed in both kernel and user
>> mode. It also eliminates the need for filtering in a user mode program.
>> i.e. where reading memory.stat returns all stats, this new approach allows
>> returning only select stats.
>>
>> An experiment was setup to compare the performance of a program using these
>> new kfuncs vs a program that uses the traditional method of reading
>> memory.stat. On the experimental side, a libbpf based program was written
>> which sets up a link to the bpf program once in advance and then reuses
>> this link to create and read from a bpf iterator program for 1M iterations.
> 
> I am getting a bit confused on the terminology. You mentioned libbpf
> program, bpf program, link. Can you describe each of them? Think of
> explaining this to someone with no bpf background.
> 
> (BTW Yonghong already explained to me these details but I wanted the
> commit message to be self explanatory).

No problem. I'll try to expand on those terms in v3.

> 
>> Meanwhile on the control side, a program was written to open the root
>> memory.stat file
> 
> How much activity was on the system? I imagine none because I don't see
> flushing in the perf profile. This experiment focuses on the
> non-flushing part of the memcg stats which is fine.

Right, at the time there was no custom workload running alongside the
tests.

> 
>> and repeatedly read 1M times from the associated file
>> descriptor (while seeking back to zero before each subsequent read). Note
>> that the program does not bother to decode or filter any data in user mode.
>> The reason for this is because the experimental program completely removes
>> the need for this work.
> 
> Hmm in your experiment is the control program doing the decode and/or
> filter or no? The last sentence in above para is confusing. Yes, the
> experiment program does not need to do the parsing or decoding in
> userspace but the control program needs to do that. If your control
> program is not doing it then you are under-selling your work.

The control does not perform decoding. But it's a good point. Let me add
decoding to the control side in v3.

> 
>>
>> The results showed a significant perf benefit on the experimental side,
>> outperforming the control side by a margin of 80% elapsed time in kernel
>> mode. The kernel overhead of numeric conversion on the control side is
>> eliminated on the experimental side since the values are read directly
>> through mapped memory of the bpf program. The experiment data is shown
>> here:
>>
>> control: elapsed time
>> real    0m13.062s
>> user    0m0.147s
>> sys     0m12.876s
>>
>> experiment: elapsed time
>> real    0m2.717s
>> user    0m0.175s
>> sys     0m2.451s
> 
> These numbers are really awesome.

:)

> 
>>
>> control: perf data
>> 22.23% a.out [kernel.kallsyms] [k] vsnprintf
>> 18.83% a.out [kernel.kallsyms] [k] format_decode
>> 12.05% a.out [kernel.kallsyms] [k] string
>> 11.56% a.out [kernel.kallsyms] [k] number
>>   7.71% a.out [kernel.kallsyms] [k] strlen
>>   4.80% a.out [kernel.kallsyms] [k] memcpy_orig
>>   4.67% a.out [kernel.kallsyms] [k] memory_stat_format
>>   4.63% a.out [kernel.kallsyms] [k] seq_buf_printf
>>   2.22% a.out [kernel.kallsyms] [k] widen_string
>>   1.65% a.out [kernel.kallsyms] [k] put_dec_trunc8
>>   0.95% a.out [kernel.kallsyms] [k] put_dec_full8
>>   0.69% a.out [kernel.kallsyms] [k] put_dec
>>   0.69% a.out [kernel.kallsyms] [k] memcpy
>>
>> experiment: perf data
>> 10.04% memcgstat bpf_prog_.._query [k] bpf_prog_527781c811d5b45c_query
>>   7.85% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
>>   4.03% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
>>   3.47% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
>>   2.58% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
>>   2.58% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
>>   2.32% memcgstat [kernel.kallsyms] [k] kmem_cache_free
>>   2.19% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
>>   2.13% memcgstat [kernel.kallsyms] [k] mutex_lock
>>   2.12% memcgstat [kernel.kallsyms] [k] get_page_from_freelist
>>
>> Aside from the perf gain, the kfunc/bpf approach provides flexibility in
>> how memcg data can be delivered to a user mode program. As seen in the
>> second patch which contains the selftests, it is possible to use a struct
>> with select memory stat fields. But it is completely up to the programmer
>> on how to lay out the data.
> 
> I remember you plan to convert couple of open source program to use this
> new feature. I think below [1] and oomd [2]. Adding that information
> would further make your case strong. cAdvisor[3] is another open source
> tool which can take benefit from this work.

That is accurate, thanks. Will include in v3.

> 
> [1] https://github.com/facebookincubator/below
> [2] https://github.com/facebookincubator/oomd
> [3] https://github.com/google/cadvisor
> 


