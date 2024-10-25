Return-Path: <cgroups+bounces-5263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B49B0A81
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7DB2814BF
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9A218B481;
	Fri, 25 Oct 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OibmbrpQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1721A4BF
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875901; cv=none; b=SXZe6vDJU0as7gpjhY9KMG+XW5/hoslNvGkV7LiOi4eLEnU8uOk1c8+gq9gK92ivsusu663C59OVCtJBiW6xgUVyhOjpORQ/HnyuVkszX4Os6aiQjdOdDxBPygLjSmOXdM+kLbsP9yT1I2Vnyx1g57sCPMuuMugNQITnLwXbR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875901; c=relaxed/simple;
	bh=Zrid5xK9Al0RpaRoSKbk6NeowpixJK/OaLjx8E1J4AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyGXZPW52iwRu27dj09jF5gC+vYpPGeu+mxdgMvHH7bdVmc/6UW7dIOL9JD/WNSKtajmenBmgjKwmdZcQob1P1/ZthX4FYoCu+rKK8uErGDsmGt1MKQnD+wHYMGnyihI8ltf4wfenhOLEGBI54atf7Sw6C8VAVuZWhBLZAdJqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OibmbrpQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caea61132so17546625ad.2
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729875899; x=1730480699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRFIYl8E2jrWC1NtQtQF7GfyGiCK2124bLm5Fb0yKXA=;
        b=OibmbrpQC6p8VukU0snCmsaYkRfW16n4idhN0NR4oNof1CiI455BdFjjpytFtnd7Me
         QF2Zi03ifeCUmfakyf5YFtpHQYa70V5JVTagddETnFPHSPm6OPT4W6nb61VItDh/dK8V
         bwoklrhecZ/xjBJBy5flM+6Rvm3ljQiLq5q/hz1UuA8hOi9p+uO9OI4fBvQX3ehG8+Nj
         IByRsPrkHOeIJbJqPyBgk+2nRWcSnug4BlqKKQ6FMIENX0vduOz1QjPy/CeeuYjw8eEm
         nGcRBdmp6cefVXa2MKocoQJHxgWKWP4ytnzsIbynWZT4QtDhcQ+d/gHkGzr13ZpzWkwS
         42GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875899; x=1730480699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRFIYl8E2jrWC1NtQtQF7GfyGiCK2124bLm5Fb0yKXA=;
        b=uthRjpWbd4oW81wdzd9yOTwpt2tfYyBOJb2HXz8eyODFeF6SuQgQtF6/sPcsN17TMA
         jiRe9zu6Zmf87+lckgVPTNy7oP6RXX1z5v2UUNbP9+BTpgLlXrtGFq/e7KRr6B+UM6e+
         q+MrqUowF7MSTunAyLRYn3YFihyBU6d1BqAGY64VDLERT93k+A0J0A3ToS/A+Q2WrRW5
         lIl/9hsoiIl6W5Hj98izHiMHxJ+P8KmJMq/tByC48oUuyH4t/ZJ4lHeY7wYfFYbbSqM8
         +E8ETvZtLzU06tDFgo3K0f9DzmabtJRwEKM75ydkI8J5Zbp2erzmB0wQykpzwMhSwkcx
         kw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Nu6g/LUxbwrumpELNJMM6N2e82J5DiY/wSlDv7tN7h0+kVPI+99qWAx9DDAevYLAzmoq3x6P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+SC2gYAdXtjWg5mZoyFwjkIOqmVA8o6RZimHjYAk05b7T8oO
	Emz8hbrkCG7XNX/BIrQAsa+qFScw/a9qblQY12tfT+30vedOmj7I
X-Google-Smtp-Source: AGHT+IHzABdwO/ZAD7FHZkScyCXJXwKdC98MiRTqd1AzNXRXRklkzQ32SGxcKJ5BhQ8dh9IjbW30AA==
X-Received: by 2002:a17:902:e54a:b0:20c:8907:902 with SMTP id d9443c01a7336-20fa9eb5a9bmr133739405ad.49.1729875899377;
        Fri, 25 Oct 2024 10:04:59 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044932sm11370515ad.253.2024.10.25.10.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:04:58 -0700 (PDT)
Message-ID: <3da0f38a-51f1-43fa-a625-6bb1fe992920@gmail.com>
Date: Fri, 25 Oct 2024 10:04:57 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
To: Yosry Ahmed <yosryahmed@google.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, rostedt@goodmis.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20241025002511.129899-1-inwardvessel@gmail.com>
 <20241025002511.129899-3-inwardvessel@gmail.com>
 <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
 <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
 <CAJD7tkZyttpQk7AYftikVtA6O7w2Wmo9Eu_EwEsusOtNKFnSQA@mail.gmail.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CAJD7tkZyttpQk7AYftikVtA6O7w2Wmo9Eu_EwEsusOtNKFnSQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/25/24 12:40 AM, Yosry Ahmed wrote:
> On Thu, Oct 24, 2024 at 6:16 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> On Thu, Oct 24, 2024 at 05:57:25PM GMT, Yosry Ahmed wrote:
>>> On Thu, Oct 24, 2024 at 5:26 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>>> Make use of the flush tracepoint within memcontrol.
>>>>
>>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>> Is the intention to use tools like bpftrace to analyze where we flush
>>> the most? In this case, why can't we just attach to the fentry of
>>> do_flush_stats() and use the stack trace to find the path?
>>>
>>> We can also attach to mem_cgroup_flush_stats(), and the difference in
>>> counts between the two will be the number of skipped flushes.
>>>
>> All these functions can get inlined and then we can not really attach
>> easily. We can somehow find the offset in the inlined places and try to
>> use kprobe but it is prohibitive when have to do for multiple kernels
>> built with fdo/bolt.
>>
>> Please note that tracepoints are not really API, so we can remove them
>> in future if we see no usage for them.
> That's fair, but can we just add two tracepoints? This seems enough to
> collect necessary data, and prevent proliferation of tracepoints and
> the addition of the enum.
>
> I am thinking one in mem_cgroup_flush_stats() and one in
> do_flush_stats(), e.g. trace_mem_cgroup_flush_stats() and
> trace_do_flush_stats(). Although the name of the latter is too
> generic, maybe we should rename the function first to add mem_cgroup_*
> or memcg_*.
>
> WDYT?

Hmmm, I think if we did that we wouldn't get accurate info on when the 
flush was skipped. Comparing the number of hits between 
mem_cgroup_flush_stats() and do_flush_stats() to determine the number of 
skips doesn't seem reliable because of the places where do_flush_stats() 
is called outside of mem_cgroup_flush_stats(). There would be situations 
where a skip occurs, but meanwhile each call to do_flush_stats() outside 
of mem_cgroup_flush_stats() would effectively subtract that skip, making 
it appear that a skip did not occur.

Maybe as a middle ground we could remove the trace calls for the zswap 
and periodic cases, since no skips can occur there. We could then just 
leave one trace call in mem_cgroup_flush_stats() and instead of an enum 
we can pass a bool saying skipped or not. Something like this:

mem_cgroup_flush_stats()

{

     bool needs_flush = memcg_vmstats_needs_flush(...);

     trace_memcg_flush_stats(memcg, needs_flush);

     if (needs_flush)

         do_flush_stats(...);

}


Yosry/Shakeel, do you have any thoughts on whether we should keep the 
trace calls for obj_cgroup_may_zswap() and periodic workqueue cases?


