Return-Path: <cgroups+bounces-5270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED839B0D3F
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 20:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E821F2456D
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40C214408;
	Fri, 25 Oct 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+oj8v2U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F901200B9E
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880819; cv=none; b=qRRlS9T0lD62HE54NCjUmiwDNMmlXDrwM7tyOhRFPLUlAkVhAwVO21YoWN99rao7VtHerEvSAjABSqtF9Mc2Lvh4RGu8ZA88LVGLwBbw9YEyNS6w8zVKiZt2K2Gea82wP5uqID/BdrlXIvpKTLah1h2XAKp75xteoGpzibLGdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880819; c=relaxed/simple;
	bh=oGiJgwKNZEemabz9gkGlamlZ643K7gAtnY4aTJTTeHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFp9zIQlIr5a6Blfk21zkUvHxkzBo3wN8TbfGMpQ7uUzg54Iy6ajLPN85vka+PZj3ryPskicenQ/Kzt3msyuAXcNhypYN/J0isuFwADYDlWrXfaaiU2axyJTP/ADsuFRRM8GoMHDYyWPp5TzTnRJH4gHyp9cYtzVSotHXDpD3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+oj8v2U; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so1790874a91.1
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729880816; x=1730485616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql2NdbXSkfYGipdoKTi487hWlak8rqljNeSnzCYiOXo=;
        b=D+oj8v2U0E5KADQnpU8tLqPJe8zK8bblvpzs+bqiWBzTYulDF7E7XSdh0x9g+4rMHD
         EpUUHBRZpErV7Wgli+FQz5OIUHKz3Z8RU3jX1gPQHFloYG4G8WvlctmBchr9fGa3oejS
         uPKsb40CE2Plv4MgoXgVWh/iwdZ6Mf24kd40tOKQMeJIMMgtwEM0h6ebLR6/aU4J7V0I
         H6e8yfmnfPm0LRyVVG4NVnHea7sR9hLMOU4/NHE1PZYi0tZyRMwBoEONRIAeTa+DA66/
         /4I6wsUIkBIk8a3MaVUH3Q8gQn8BCadLfrdooY3gbRF5rpYxZULgbfOH8RaFITpS/RK+
         90bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880816; x=1730485616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ql2NdbXSkfYGipdoKTi487hWlak8rqljNeSnzCYiOXo=;
        b=npJZND6e2V63TrCgWj2bHhaaI9OxXB3uUPo8ZcTWE0HXUGtQFGJ99R/AkHxZO4ucPP
         LVzxH2RGjJkNtv6kftil8GCZtypY6g6E57leo/orHDnpr0UTDNCnXTKkLttnN66qIE5q
         f4CZ21I7Cnxpec9HuKvH9ctNVP6r4/ARQ84E+jcZU1QRUrXQ5tjyPxO9Yj6OUuIo53S/
         Zc8XHkNiTnQKvGz7A9eYDbZYc1YQq1ke9SvO0X8Xfw60IyMyo2seqUi0DA3PsT+Lueq8
         BogSJcCpxcadjtmWB8IWRLMRoCi1P+i7Y4HESMsxmTaXhoylrSIO8Ahes3rGzvJqLXLJ
         PaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUlmnw4XgWfLYgia6nSgyUQlwhByLq+mthcy5PogcpK+XB9DsDUN4weCuAaQdB2rpaEsvhDZKM@vger.kernel.org
X-Gm-Message-State: AOJu0YzbElu8uO0pVZAFIuB2FnAwDsJoukjPrsXFdmC8DoAfXseIKk7D
	/aXxe+qo/Ta4Kej4LccTiRKgXwC/j3D0MzCyEA0gxokWG7RItJWxKTBUMDkl
X-Google-Smtp-Source: AGHT+IGdR8TauvJA45i/zjGNl+kwwL0J3f5JdBGSaQPwA75prD8dLqXC+NHSwV4EUnVAkKXgwdFsBA==
X-Received: by 2002:a17:90a:ca83:b0:2e2:e769:dffe with SMTP id 98e67ed59e1d1-2e8f11ac9b4mr318810a91.30.1729880816403;
        Fri, 25 Oct 2024 11:26:56 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572cadsm1812413a91.14.2024.10.25.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:26:55 -0700 (PDT)
Message-ID: <8c44b4d3-0083-42b6-8006-adcfaee04e19@gmail.com>
Date: Fri, 25 Oct 2024 11:26:54 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 akpm@linux-foundation.org, rostedt@goodmis.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org
References: <20241025002511.129899-1-inwardvessel@gmail.com>
 <20241025002511.129899-3-inwardvessel@gmail.com>
 <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
 <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
 <CAJD7tkZyttpQk7AYftikVtA6O7w2Wmo9Eu_EwEsusOtNKFnSQA@mail.gmail.com>
 <3da0f38a-51f1-43fa-a625-6bb1fe992920@gmail.com>
 <CAJD7tkZ=YB66T4-j-qKxzYktiKqmfufg_eTjHo_6W7eQjqSXmg@mail.gmail.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CAJD7tkZ=YB66T4-j-qKxzYktiKqmfufg_eTjHo_6W7eQjqSXmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/25/24 10:53 AM, Yosry Ahmed wrote:
> On Fri, Oct 25, 2024 at 10:05 AM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
>> On 10/25/24 12:40 AM, Yosry Ahmed wrote:
>>> On Thu, Oct 24, 2024 at 6:16 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>> On Thu, Oct 24, 2024 at 05:57:25PM GMT, Yosry Ahmed wrote:
>>>>> On Thu, Oct 24, 2024 at 5:26 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>>>>> Make use of the flush tracepoint within memcontrol.
>>>>>>
>>>>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>>>> Is the intention to use tools like bpftrace to analyze where we flush
>>>>> the most? In this case, why can't we just attach to the fentry of
>>>>> do_flush_stats() and use the stack trace to find the path?
>>>>>
>>>>> We can also attach to mem_cgroup_flush_stats(), and the difference in
>>>>> counts between the two will be the number of skipped flushes.
>>>>>
>>>> All these functions can get inlined and then we can not really attach
>>>> easily. We can somehow find the offset in the inlined places and try to
>>>> use kprobe but it is prohibitive when have to do for multiple kernels
>>>> built with fdo/bolt.
>>>>
>>>> Please note that tracepoints are not really API, so we can remove them
>>>> in future if we see no usage for them.
>>> That's fair, but can we just add two tracepoints? This seems enough to
>>> collect necessary data, and prevent proliferation of tracepoints and
>>> the addition of the enum.
>>>
>>> I am thinking one in mem_cgroup_flush_stats() and one in
>>> do_flush_stats(), e.g. trace_mem_cgroup_flush_stats() and
>>> trace_do_flush_stats(). Although the name of the latter is too
>>> generic, maybe we should rename the function first to add mem_cgroup_*
>>> or memcg_*.
>>>
>>> WDYT?
>> Hmmm, I think if we did that we wouldn't get accurate info on when the
>> flush was skipped. Comparing the number of hits between
>> mem_cgroup_flush_stats() and do_flush_stats() to determine the number of
>> skips doesn't seem reliable because of the places where do_flush_stats()
>> is called outside of mem_cgroup_flush_stats(). There would be situations
>> where a skip occurs, but meanwhile each call to do_flush_stats() outside
>> of mem_cgroup_flush_stats() would effectively subtract that skip, making
>> it appear that a skip did not occur.
> You're underestimating the power of BPF, my friend :) We can count the
> number of flushes in task local storages, in which case we can get a
> very accurate representation because the counters are per-task, so we
> know exactly when we skipped, but..
Interesting. Thanks for explaining.
>
>> Maybe as a middle ground we could remove the trace calls for the zswap
>> and periodic cases, since no skips can occur there. We could then just
>> leave one trace call in mem_cgroup_flush_stats() and instead of an enum
>> we can pass a bool saying skipped or not. Something like this:
>>
>> mem_cgroup_flush_stats()
>>
>> {
>>
>>       bool needs_flush = memcg_vmstats_needs_flush(...);
>>
>>       trace_memcg_flush_stats(memcg, needs_flush);
>>
>>       if (needs_flush)
>>
>>           do_flush_stats(...);
>>
>> }
>>
>>
>> Yosry/Shakeel, do you have any thoughts on whether we should keep the
>> trace calls for obj_cgroup_may_zswap() and periodic workqueue cases?
> ..with that being said, I do like having a single tracepoint. I think
> with some refactoring we can end up with a single tracepoint and more
> data. We can even capture the cases where we force a flush but we
> don't really need to flush. We can even add vmstats->stats_updates to
> the tracepoint to know exactly how many updates we have when we flush.
>
> What about the following:
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7845c64a2c570..be0e7f52ad11a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -584,8 +584,14 @@ static inline void memcg_rstat_updated(struct
> mem_cgroup *memcg, int val)
>          }
>   }
>
> -static void do_flush_stats(struct mem_cgroup *memcg)
> +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
>   {
> +       bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats);
> +
> +       trace_memcg_flush_stats(memcg, needs_flush, force, ...);
> +       if (!force && !needs_flush)
> +               return;
> +
>          if (mem_cgroup_is_root(memcg))
>                  WRITE_ONCE(flush_last_time, jiffies_64);
>
> @@ -609,8 +615,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>          if (!memcg)
>                  memcg = root_mem_cgroup;
>
> -       if (memcg_vmstats_needs_flush(memcg->vmstats))
> -               do_flush_stats(memcg);
> +       __mem_cgroup_flush_stats(memcg, false);
>   }
>
>   void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> @@ -626,7 +631,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
>           * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
>           * in latency-sensitive paths is as cheap as possible.
>           */
> -       do_flush_stats(root_mem_cgroup);
> +       __mem_cgroup_flush_stats(root_mem_cgroup, true);
>          queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
>   }
>
> @@ -5272,11 +5277,8 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>                          break;
>                  }
>
> -               /*
> -                * mem_cgroup_flush_stats() ignores small changes. Use
> -                * do_flush_stats() directly to get accurate stats for charging.
> -                */
> -               do_flush_stats(memcg);
> +               /* Force a flush to get accurate stats for charging */
> +               __mem_cgroup_flush_stats(memcg, true);
>                  pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
>                  if (pages < max)
>                          continue;
I like the additional info. I'll incorporate this into v2.

