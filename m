Return-Path: <cgroups+bounces-6391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBFA230A0
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 15:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A892F7A266C
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE21E98F3;
	Thu, 30 Jan 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIuXXXze"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD21DDD1
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248757; cv=none; b=ROCTGNa5BIbICMwcyKKo8Yhg5HY1TiYnvMjcp4oaOIFbDKDAFt4pyBOT/YvzZ7KVeukTs62EidRw89cXg8XVCKKRJ2RtfvlLKsR7ZWbDAsu7tfM1bb/jZQclEoF5XiskzZsumucpqQvoZ3uNrXQgaMxexyqgppbAXTlXgf5lw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248757; c=relaxed/simple;
	bh=PCYY8IA+Wsi1N1QvCopsjKMlR20mHZ5esGgVL3/VF9k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XvNgVntuLeBonlSkfO7V3z58AXRRmevlhCihiY7LwhQsnxkWEnlpp0fuddNjv5scCT71uFXi8TBIs15X+xmkNE3nFzsCfq0V9TyOb+9at3d0AlOxtH2ikqh+9lZ3mZpXnUUaMTvYeuIe1xNBIL4/gMs2pDvUniNXIRhBBthxBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIuXXXze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738248755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGz1ZibS2GfwUDvWQSD0jo0W5/+6emzlakirCqtq8vk=;
	b=aIuXXXzeh9NsMvyCglf6jX/t3WFgc9MpgBHOyxwFfdOEvoHgyvtS2fG2iU/FzBdH5NMBkC
	9upXXBmYlBc4GmrqcGYpqSOPqwg04m6GUtD8O0C7fQWd5L/HeArcrO/Q6F/xoYM9BOkeoZ
	Mn1qi+ptvR0HAJsiphd5chU87YbFDNY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-4PHwpMgCMRG9preyAWNYMA-1; Thu, 30 Jan 2025 09:52:33 -0500
X-MC-Unique: 4PHwpMgCMRG9preyAWNYMA-1
X-Mimecast-MFC-AGG-ID: 4PHwpMgCMRG9preyAWNYMA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46791423fc9so17626211cf.2
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 06:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738248753; x=1738853553;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGz1ZibS2GfwUDvWQSD0jo0W5/+6emzlakirCqtq8vk=;
        b=C3Sj8S6pRtGs1ysSS8D2yXGq/u5U454M9oFQ4jCZVccZzUwlZAQP29JdTUsBfg3ZQB
         VFQBfbS6vLLezO43nW/xxkBr5pQLhP2hi8IanWkjLM33cYEpwCJT9KwAonYUv6o014uj
         xF5mOyKo3u1XtrDK0EPultOYjxmdbeBOY+YlbMMDwr7w1WA8WCZ7bmcZHFg0c0+CWBM9
         2rZTgVgsXpjiJbF7Ko2AVWhqmkYhP4WOJCz8VW4Jtypa+kd2c9sfnr/Ef7DLxr0zqAcG
         2P/2USIeamvO4t6Pcl6HxTJEdXhpiTueoTpcrEYgr+yWOAFby42yR+y1OLVDGw9IhBN3
         6RVA==
X-Forwarded-Encrypted: i=1; AJvYcCXEw7mPfqxq5jLFDV4O0ncaIqTamADh9lKrglPQ4SVNiNYD4pETq3F6AJh/gtI2cKfplnWJ9Qjy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkwy7bmt3MLYz+Mp4utN/BcqNJIbu7jNqkR+sXDiQmKkOsLb8O
	/q26hPZHmC/waaznBrFrR1mouXMPACICDgeIiJzCNxfEvJcBjgzOIOChVAfKPzuklioCts7wVbv
	xV35ZJaVzwHO5vkUvG2gQZqbW7sLGiQ6Agfn+GetlXhMIsoc9TwkW1j4=
X-Gm-Gg: ASbGncutD+p5WPlnQOc02ROrZPv1oAsWWPTkwFTM7qWvizyslrwB/BggogyJwe3OPE5
	2eU6sd3rDobS2xOLlw0wW3NH0JEfEY4yB/DGTQjA8T5d5WXNaIrhMf2mm3eRHIHVSDxuVPq10WR
	TsL7WFnkBBjy5+BO0ggoSwXMoDJ0S+s+jLTy5MWFwpURUdqC61kAjpKNUbwE1nk2LohMJ0NKOxJ
	1hkoabI+7spf4LEkitaKwsigGZWiMF2Pt9X+rqUCwgb3BkYnqf3sYTf1PMtjlnV7ix9deE6ob15
	cPUG3SIqFdlYTeklqLmX4KnRHXclP0SGAHXjwWJPcAJoYy7UEk4=
X-Received: by 2002:ac8:6f17:0:b0:467:53c8:7570 with SMTP id d75a77b69052e-46fd0a1e874mr145317911cf.13.1738248753179;
        Thu, 30 Jan 2025 06:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZtczFOZdXZZrzAnnTtypYwYu2MEl/wAI3+p6VGOBUkFWHhZm0Tir+2iIoGGAmsnU1RVk9pA==
X-Received: by 2002:ac8:6f17:0:b0:467:53c8:7570 with SMTP id d75a77b69052e-46fd0a1e874mr145317521cf.13.1738248752831;
        Thu, 30 Jan 2025 06:52:32 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0c7e5esm7550941cf.24.2025.01.30.06.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 06:52:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <366fd30f-033d-48d6-92b4-ac67c44d0d9b@redhat.com>
Date: Thu, 30 Jan 2025 09:52:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5qLQ1o6cXbcvc0o@google.com>
Content-Language: en-US
In-Reply-To: <Z5qLQ1o6cXbcvc0o@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 3:10 PM, Yosry Ahmed wrote:
> On Wed, Jan 29, 2025 at 02:12:04PM -0500, Waiman Long wrote:
>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>> reclaim over memory.high"), the amount of allocator throttling had
>> increased substantially. As a result, it could be difficult for a
>> misbehaving application that consumes increasing amount of memory from
>> being OOM-killed if memory.high is set. Instead, the application may
>> just be crawling along holding close to the allowed memory.high memory
>> for the current memory cgroup for a very long time especially those
>> that do a lot of memcg charging and uncharging operations.
>>
>> This behavior makes the upstream Kubernetes community hesitate to
>> use memory.high. Instead, they use only memory.max for memory control
>> similar to what is being done for cgroup v1 [1].
>>
>> To allow better control of the amount of throttling and hence the
>> speed that a misbehving task can be OOM killed, a new single-value
>> memory.high.throttle control file is now added. The allowable range
>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>> like before. Any non-zero positive value represents the corresponding
>> power of 2 reduction of throttling and makes OOM kills easier to happen.
>>
>> System administrators can now use this parameter to determine how easy
>> they want OOM kills to happen for applications that tend to consume
>> a lot of memory without the need to run a special userspace memory
>> management tool to monitor memory consumption when memory.high is set.
>>
>> Below are the test results of a simple program showing how different
>> values of memory.high.throttle can affect its run time (in secs) until
>> it gets OOM killed. This test program allocates pages from kernel
>> continuously. There are some run-to-run variations and the results
>> are just one possible set of samples.
>>
>>    # systemd-run -p MemoryHigh=10M -p MemoryMax=20M -p MemorySwapMax=10M \
>> 	--wait -t timeout 300 /tmp/mmap-oom
>>
>>    memory.high.throttle	service runtime
>>    --------------------	---------------
>>              0		    120.521
>>              1		    103.376
>>              2		     85.881
>>              3		     69.698
>>              4		     42.668
>>              5		     45.782
>>              6		     22.179
>>              7		      9.909
>>              8		      5.347
>>              9		      3.100
>>             10		      1.757
>>             11		      1.084
>>             12		      0.919
>>             13		      0.650
>>             14		      0.650
>>             15		      0.655
>>
>> [1] https://docs.google.com/document/d/1mY0MTT34P-Eyv5G1t_Pqs4OWyIH-cg9caRKWmqYlSbI/edit?tab=t.0
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 16 ++++++++--
>>   include/linux/memcontrol.h              |  2 ++
>>   mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
>>   3 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index cb1b4e759b7e..df9410ad8b3b 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1291,8 +1291,20 @@ PAGE_SIZE multiple when read back.
>>   	Going over the high limit never invokes the OOM killer and
>>   	under extreme conditions the limit may be breached. The high
>>   	limit should be used in scenarios where an external process
>> -	monitors the limited cgroup to alleviate heavy reclaim
>> -	pressure.
>> +	monitors the limited cgroup to alleviate heavy reclaim pressure
>> +	unless a high enough value is set in "memory.high.throttle".
>> +
>> +  memory.high.throttle
>> +	A read-write single value file which exists on non-root
>> +	cgroups.  The default is 0.
>> +
>> +	Memory usage throttle control.	This value controls the amount
>> +	of throttling that will be applied when memory consumption
>> +	exceeds the "memory.high" limit.  The larger the value is,
>> +	the smaller the amount of throttling will be and the easier an
>> +	offending application may get OOM killed.
> memory.high is supposed to never invoke the OOM killer (see above). It's
> unclear to me if you are referring to OOM kills from the kernel or
> userspace in the commit message. If the latter, I think it shouldn't be
> in kernel docs.

I am sorry for not being clear. What I meant is that if an application 
is consuming more memory than what can be recovered by memory reclaim, 
it will reach memory.max faster, if set, and get OOM killed. Will 
clarify that in the next version.

Cheers,
Longman


