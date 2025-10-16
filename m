Return-Path: <cgroups+bounces-10832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8BFBE5C0F
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 01:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6705425F4
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B72DF6E3;
	Thu, 16 Oct 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F81fm32C"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C11917F1
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655682; cv=none; b=D1tmBJ477gu0YCwHB2x3iyWl0/8VnYdCBhRi4xntbLLKVtvsM4WKE4y6EIE3U8ZETBDL0FFrTXR1Bnc1R91SadUdNEDSMEeF+Ac2eZJrkvqGISCErq7PMmCo/bOXz9p9dhsWmo75U81cACh7HcuoyK5qL7KdPO7/rd7BJ0scSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655682; c=relaxed/simple;
	bh=w4f2ytD54mzA08kI5uCBJGg0Y29BYgb/Cc4Yp7o1XjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDqe5Qhw1bWyLVFuOw+v3XWEZmllxH9LhHeBNo+TbmDnDZrK/pqo/rcvwFTGFZfz+8t6wyytoE5Vs33jSqEm+9C2n2wjN1NHadSZEAVvKINSSObOZ4RKr/6d5mNv2f/baapq9P67s1aUT4QErtUk7gfTEKC3HbLD/mzGNqruti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F81fm32C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760655667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lnf0SlVNBa1MHaoQqJyDwakLfgUyXqJdGj6LGOIvyI=;
	b=F81fm32Cy9ymkg8hRJwfUSBZlIddtx0rrYIvKNcMyGg30wqq+TDhJUAppy/zpkfR7sFmUK
	BzJxiPuQqKecd1ogb3moIZcub+cle2Sxur8YuNi1pZq//SzlgI1qC6Sn5lbVo6FSMWjAnW
	y/NyoB4mkR2VXNeGoRNPM9pqofHXBpU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  andrii@kernel.org,
  ast@kernel.org,  mkoutny@suse.com,  yosryahmed@google.com,
  hannes@cmpxchg.org,  tj@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  linux-mm@kvack.org,  bpf@vger.kernel.org,  kernel-team@meta.com,
  mhocko@kernel.org,  muchun.song@linux.dev
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
In-Reply-To: <2fa573e6-bd9a-46b9-a2a6-bfb233d0389a@gmail.com> (JP Kobryn's
	message of "Thu, 16 Oct 2025 13:26:44 -0700")
References: <20251015190813.80163-1-inwardvessel@gmail.com>
	<uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
	<e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com>
	<87wm4v7isj.fsf@linux.dev>
	<2fa573e6-bd9a-46b9-a2a6-bfb233d0389a@gmail.com>
Date: Thu, 16 Oct 2025 16:00:58 -0700
Message-ID: <87frbimoyd.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

JP Kobryn <inwardvessel@gmail.com> writes:

> On 10/15/25 6:10 PM, Roman Gushchin wrote:
>> JP Kobryn <inwardvessel@gmail.com> writes:
>> 
>>> On 10/15/25 1:46 PM, Shakeel Butt wrote:
>>>> Cc memcg maintainers.
>>>> On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
>>>>> When reading cgroup memory.stat files there is significant kernel overhead
>>>>> in the formatting and encoding of numeric data into a string buffer. Beyond
>>>>> that, the given user mode program must decode this data and possibly
>>>>> perform filtering to obtain the desired stats. This process can be
>>>>> expensive for programs that periodically sample this data over a large
>>>>> enough fleet.
>>>>>
>>>>> As an alternative to reading memory.stat, introduce new kfuncs that allow
>>>>> fetching specific memcg stats from within cgroup iterator based bpf
>>>>> programs. This approach allows for numeric values to be transferred
>>>>> directly from the kernel to user mode via the mapped memory of the bpf
>>>>> program's elf data section. Reading stats this way effectively eliminates
>>>>> the numeric conversion work needed to be performed in both kernel and user
>>>>> mode. It also eliminates the need for filtering in a user mode program.
>>>>> i.e. where reading memory.stat returns all stats, this new approach allows
>>>>> returning only select stats.
>> It seems like I've most of these functions implemented as part of
>> bpfoom: https://lkml.org/lkml/2025/8/18/1403
>> So I definitely find them useful. Would be nice to merge our
>> efforts.
>
> Sounds great. I see in your series that you allow the kfuncs to accept
> integers as item numbers. Would my approach of using typed enums work
> for you? I wanted to take advantage of libbpf core so that the bpf
> program could gracefully handle cases where a given enumerator is not
> present in a given kernel version. I made use of this in the
> selftests.

Good point, I'm going to change it in the next version, which I'm about
to send out: tomorrow or early next week.

> I'm planning on sending out a v3 so let me know if you would like to see
> any alterations that would align with bpfoom.

I kinda prefer my version regarding taking a memcg argument instead of cgroup
and also regarding naming. I also think it's safer to expose the
rate-limited version of stats flushing function. But I do lack the
node-level statistics (which I don't need)

If it's ok with you, maybe you can rebase your patches on top of my v2
and I can include your patches in the series?

Thanks!

