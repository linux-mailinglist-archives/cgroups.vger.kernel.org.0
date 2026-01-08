Return-Path: <cgroups+bounces-13001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765BD0679F
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC3B3024125
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E532E72F;
	Thu,  8 Jan 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S8lNzgxB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7122D47EF
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912642; cv=none; b=O3qqDudLOCdSS5f/QzwpSw6PHtNn1NeWz63Ea5GWeF9bfXmBqdJSLqlhe713xqHc2fkC3tceXgGulnIAVMyb3flfeP6mnnRpbx7jEfw5VvOLdENHnGRdfLu4JCE9bX7RtHRdnQ3YYJHQpL1Vb3CfiAvuiTYkvUS/Kary5WhE8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912642; c=relaxed/simple;
	bh=ZOD+3sEuARst8J/6jQKUAN+c3CEyZm47JpYqTHAT2i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2nifVnR1QHpMlI/1A75kgtsSeDrMjhxBbF1/qTUJDbgIQRGE69Rps9y1iAS0ElPI0IO1gKXSrHye1nj3677Bu7LW84jySkCeV1ltYDpw/ZFoJDwy3FbtBuboc1GXPTWaH0nGD6T7RaDtksTRy+9Kcu8vLZHPdp58CFT528YO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S8lNzgxB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767912638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiutodSCryP8xE+zUXAHFxoi+kF4AieFcdf6dqFfuM0=;
	b=S8lNzgxBrs+O14O5zBi0n1LeqQ3o6mRMOpQFXNjmjrDuPUR8o4Lk2u2r/b5XeYJL28srVA
	Wjh00dH7rAOs2GUKLeyMUYQ2OiscoskiSuC6vnxlcBwg2GpQOyBjqpof4YlXaZutHTDQML
	uVVRZuzVbru4j/zUIx76MVtaUTssF04=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jianyue Wu <wujianyue000@gmail.com>,  jianyuew@nvidia.com,
  hannes@cmpxchg.org,  mhocko@kernel.org,  shakeel.butt@linux.dev,
  muchun.song@linux.dev,  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optimize stat output for 11% sys time reduce
In-Reply-To: <20260108111027.172f19a9a86667e8e0142042@linux-foundation.org>
	(Andrew Morton's message of "Thu, 8 Jan 2026 11:10:27 -0800")
References: <20260108093741.212333-1-jianyuew@nvidia.com>
	<20260108111027.172f19a9a86667e8e0142042@linux-foundation.org>
Date: Thu, 08 Jan 2026 22:49:55 +0000
Message-ID: <7ia45x9bhg8c.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu,  8 Jan 2026 17:37:29 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:
>
>> From: Jianyue Wu <wujianyue000@gmail.com>
>> 
>> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
>> printf parsing in memcg stats output.
>> 
>> Key changes:
>> - Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
>> - Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
>> - Update __memory_events_show(), swap_events_show(),
>>   memory_stat_format(), memory_numa_stat_show(), and related helpers
>> 
>> Performance:
>> - 1M reads of memory.stat+memory.numa_stat
>> - Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
>> - After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)
>> 
>> Tests:
>> - Script:
>>   for ((i=1; i<=1000000; i++)); do
>>       : > /dev/null < /sys/fs/cgroup/memory.stat
>>       : > /dev/null < /sys/fs/cgroup/memory.numa_stat
>>   done
>> 
>
> I suspect there are workloads which read these files frequently.
>
> I'd be interested in learning "how frequently".  Perhaps
> ascii-through-sysfs simply isn't an appropriate API for this data?

We just got a bpf interface for this data merged, exactly to speed
things up: commit 99430ab8b804 ("mm: introduce BPF kfuncs to access
memcg statistics and events") in bpf-next.

