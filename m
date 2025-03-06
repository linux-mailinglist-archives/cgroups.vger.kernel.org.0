Return-Path: <cgroups+bounces-6852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD268A53F98
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 02:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD80169698
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8243487BF;
	Thu,  6 Mar 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD92kohh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CE21345
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223229; cv=none; b=q4CjOJqSLSjummPcI1zbcB+VX4QW4lRgx9HrUCZC05kulm6Ue6F63EL9r9Lmuiz4lr33JcNCnEeYzI+pC9w34/ZJqaQMJ3oj6RjAiNADhDrgR1uuofY7nkooOde2vmCZUuVfXc6mo5HZ+Kb0y+zvU6LrBkOn4wTaO+i3Qa6vM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223229; c=relaxed/simple;
	bh=iCQZxIBdPrxPn4gXgH4lDZhrCU25Av2VX5KK9qsRBOI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=axsADH/ih3I//epx/GOqJH2e3x9SGi3G2UYEnOTukR/hEGvj4Fzx+Lnsb6a3CgBFoYBel9smOZ8GmGuvzFpEoLMvlrtBlrJEj13BQspEHopXiQtTypedZTCgqucLODOARt2Y703/71a2gKse1hlXnhOTGd5O/16mviOHzwlAYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD92kohh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239c066347so970765ad.2
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741223227; x=1741828027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3g5tO8cV38QyN61/JAPGKrpC1UagZdhR6CAA1Vj0Ft4=;
        b=UD92kohhCklYUMEyf46cytmgdhs6yY4xu+pFPplF+PxUW/E7JdN0h5YrEoSkR0wsF+
         9oKN5LXQ7y6P07jNQvHGJJmewwWa1dkkFdrEp/j36Cy6hvJ7vkBoQWrus7u50PH/TxlF
         LkAjtiYC2wzILyQBFv6LC50X1hBWlPMBUiJtWV6fONuNU/CNgqw81reGdi5pxk0TP4OY
         xHAPJk4xG+EZfh1dw0XJpWh282i4YkY/hCOyWCVp/7hEMiI9NR9e8TVDLJgmHg6l7oJT
         DtmermO/We6mQ11q2tIRbb0P83i6AVcjRw19RlzWKmp5PATJ3JaaR+mPpzzsm0W/hdSb
         bhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223227; x=1741828027;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g5tO8cV38QyN61/JAPGKrpC1UagZdhR6CAA1Vj0Ft4=;
        b=RIwEHoRTRgeJ5YtFvqpWdXJkFDRPueEKCo1ZgZJXQdv85AWKhjj48jwaYI4VDagOWo
         olTgxdbmQjusX6HsrUNmIy7coqKUPqYgZ8/PLI/F8+xpmFc1y+KR7D+fv1fs3YOcb9tL
         VwJjgpr9mJ/FKO/lB+6WIDLFDTbyOycPy9IQwmvmYIoWr6VGA0ZwR/SzhcxY1YxRZ4GC
         ZcUSjI2WJgzptqx5fEXWC5rV53p49Ys6hyhFi6qrHBFIkAaSpJMsE8A2eaCIFauSd/Hn
         hMSuJXmA7O+/kHvJf4Xzbx4GyIWOPM81pS/Am1o6smWGdA8gJLj1BJ6FkbDM6tlE3oeV
         ghIw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNNKitB1YIgoNnY7Q3ckEu64iFjx9VryeGjlH8CwyQqORaqX1UPXwR01dwlyDvlEQ03aty91U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01xMU2Qdo0OenDRqU42VfJMqHp5CnV09ax44HsDdd12faLS++
	vpSfWg2MoWbVEJODvuJkTC15FgiRdaQii3t3n96TpWDR1L4d8LXN
X-Gm-Gg: ASbGncunYVP/T4GRBKvYOPN0bW10BoKzic/CBFjRMs2Z0QM4iDennh6Fehmib0TGDon
	+uJsU1Il/hHrdHz6eEL9VFbEasoYgcDbXQjsTe51cTR9wqTLMZs/VY8WejXxnfAsJlJ7v3lepos
	3FIqVzBXhFU3fVJ0zXlikWjWCGSdZ85U1g8IgyDloP5AuWC/LxdP0WPkGP0Evv4sCXUryNw91be
	HOQ39OWxHF0n+rcg9Ch0AnJ/GSVTMe0MpI4b5zAqsHTrWbiDB0MviZEwd0AlVKAO6zO8hJPSRNZ
	kZ8GxWOVrMhsJcBI6kZazIyOOPNoNdUhlp1MqfHJKAvxk/LFzYsP443q8s7xBPdk/8njdzmyVG4
	lOg==
X-Google-Smtp-Source: AGHT+IFI3/1Oy3hjhmvUKD4jzNMztsCiCuoTh6rFklQOBtUj+YMyniy9SIBkPT7jFyfc+tQ+hssUMA==
X-Received: by 2002:a17:903:1c1:b0:224:93e:b5d7 with SMTP id d9443c01a7336-224093eb6afmr20756695ad.34.1741223227296;
        Wed, 05 Mar 2025 17:07:07 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:86f4:5731:1f28:6513? ([2620:10d:c090:500::5:58db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f700sm543275ad.144.2025.03.05.17.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 17:07:06 -0800 (PST)
Message-ID: <c1899b5a-94a8-4198-be0a-5d2b69afd488@gmail.com>
Date: Wed, 5 Mar 2025 17:07:04 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <ee4zdir4nikgzh2zdyfqic7b5lapsuimoeal7p26xsanitzwqo@rrjfhevoywpz>
Content-Language: en-US
In-Reply-To: <ee4zdir4nikgzh2zdyfqic7b5lapsuimoeal7p26xsanitzwqo@rrjfhevoywpz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 7:19 AM, Michal Koutný wrote:
> Hello JP.
> 
> On Thu, Feb 27, 2025 at 01:55:39PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
>> From: JP Kobryn <inwardvessel@gmail.com>
>>
>> The current design of rstat takes the approach that if one subsystem is
>> to be flushed, all other subsystems with pending updates should also be
>> flushed. It seems that over time, the stat-keeping of some subsystems
>> has grown in size to the extent that they are noticeably slowing down
>> others. This has been most observable in situations where the memory
>> controller is enabled. One big area where the issue comes up is system
>> telemetry, where programs periodically sample cpu stats. It would be a
>> benefit for programs like this if the overhead of having to flush memory
>> stats (and others) could be eliminated. It would save cpu cycles for
>> existing cpu-based telemetry programs and improve scalability in terms
>> of sampling frequency and volume of hosts.
>   
>> This series changes the approach of "flush all subsystems" to "flush
>> only the requested subsystem".
> ...
> 
>> before:
>> sizeof(struct cgroup_rstat_cpu) =~ 176 bytes /* can vary based on config */
>>
>> nr_cgroups * sizeof(struct cgroup_rstat_cpu)
>> nr_cgroups * 176 bytes
>>
>> after:
> ...
>> nr_cgroups * (176 + 16 * 2)
>> nr_cgroups * 208 bytes
>   
> ~ 32B/cgroup/cpu

Thanks. I'll make this clear in the cover letter next rev.

> 
>> With regard to validation, there is a measurable benefit when reading
>> stats with this series. A test program was made to loop 1M times while
>> reading all four of the files cgroup.stat, cpu.stat, io.stat,
>> memory.stat of a given parent cgroup each iteration. This test program
>> has been run in the experiments that follow.
> 
> Thanks for looking into this and running experiments on the behavior of
> split rstat trees.

And thank you for reviewing along with the good questions.

> 
>> The first experiment consisted of a parent cgroup with memory.swap.max=0
>> and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created
>> and within each child cgroup a process was spawned to frequently update
>> the memory cgroup stats by creating and then reading a file of size 1T
>> (encouraging reclaim). The test program was run alongside these 26 tasks
>> in parallel. The results showed a benefit in both time elapsed and perf
>> data of the test program.
>>
>> time before:
>> real    0m44.612s
>> user    0m0.567s
>> sys     0m43.887s
>>
>> perf before:
>> 27.02% mem_cgroup_css_rstat_flush
>>   6.35% __blkcg_rstat_flush
>>   0.06% cgroup_base_stat_cputime_show
>>
>> time after:
>> real    0m27.125s
>> user    0m0.544s
>> sys     0m26.491s
> 
> So this shows that flushing rstat trees one by one (as the test program
> reads *.stat) is quicker than flushing all at once (+idle reads of
> *.stat).
> Interesting, I'd not bet on that at first but that is convincing to
> favor the separate trees approach.
> 
>> perf after:mem_cgroup_css_rstat_flush
>> 6.03% mem_cgroup_css_rstat_flush
>> 0.37% blkcg_print_stat
>> 0.11% cgroup_base_stat_cputime_show
> 
> I'd understand why the series reduces time spent in
> mem_cgroup_flush_stats() but what does the lower proportion of
> mem_cgroup_css_rstat_flush() show?

When the entry point for flushing is reading the file memory.stat, 
memory_stat_show() is called which leads to __mem_cgroup_flush_stats(). 
In this function, there is an early return when (!force && !needs_flush) 
is true. This opportunity to "skip" a flush is not reached when another 
subsystem has initiated the flush and entry point for flushing memory is 
css->css_rstat_flush().

To verify above, I made use of a tracepoint previously added [0] to get 
info info on the number of memcg flushes performed vs skipped. In a 
comparison between reading only the memory.stat file vs reading 
{memory,io,cpu}.stat files under the same test, the flush count 
increased by about the same value the skip count decreased.

Reading memory.stat
non-forced flushes: 5781
flushes skipped: 995826

Reading {memory,io.cpu}.stat
non-forced flushes: 12047
flushes skipped: 990857

If the flushes were not skipped, I think we would see similar proportion 
of mem_cgroup_css_rstat_flush() when reading memory.stat.

[0] 
https://lore.kernel.org/all/20241029021106.25587-1-inwardvessel@gmail.com/

> 
> 
>> Another experiment was setup on the same host using a parent cgroup with
>> two child cgroups. The same swap and memory max were used as the
>> previous experiment. In the two child cgroups, kernel builds were done
>> in parallel, each using "-j 20". The perf comparison of the test program
>> was very similar to the values in the previous experiment. The time
>> comparison is shown below.
>>
>> before:
>> real    1m2.077s
>> user    0m0.784s
>> sys     1m0.895s
> 
> This is 1M loops of stats reading program like before? I.e. if this
> should be analogous to 0m44.612s above why isn't it same? (I'm thinking
> of more frequent updates in the latter test.)

Yes. One notable difference on this test is there are more threads in 
the workload (40 vs 26) which are doing the updates.

> 
>> after:
>> real    0m32.216s
>> user    0m0.709s
>> sys     0m31.256s
> 
> What was impact on the kernel build workloads (cgroup_rstat_updated)?

You can now find some workload timing results further down. If you're 
asking specifically about time spent in cgroup_rstat_updated(), perf 
reports show fractional values on both sides.

> 
> (Perhaps the saved 30s of CPU work (if potentially moved from readers to
> writers) would be spread too thin in all of two 20-parallel kernel
> builds, right?)

Are you suggesting a workload with fewer threads?

> 
> ...
>> For the final experiment, perf events were recorded during a kernel
>> build with the same host and cgroup setup. The builds took place in the
>> child node. Control and experimental sides both showed similar in cycles
>> spent on cgroup_rstat_updated() and appeard insignificant compared among
>> the events recorded with the workload.
> 
> What's the change between control vs experiment? Runnning in root cg vs
> nested? Or running without *.stat readers vs with them against the
> kernel build?
> (This clarification would likely answer my question above.)
> 

workload control with no readers:
real    6m54.818s
user    117m3.122s
sys     5m4.996s

workload experiment with no readers:
real    6m54.862s
user    117m12.812s
sys     5m0.943s

workload control with constant readers {memory,io,cpu,cgroup}.stat:
real    6m59.468s
user    118m26.981s
sys     5m20.163s

workload experiment with constant readers {memory,io,cpu,cgroup}.stat:
real    6m57.031s
user    118m13.833s
sys     5m3.454s

These tests were done in a child (nested) cgroup. Were you also asking 
for a root vs nested experiment or were you just needing clarification 
on the test details?

> 
> Michal


