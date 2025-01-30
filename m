Return-Path: <cgroups+bounces-6395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E48A2326C
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402E13A5B5B
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A01EE7C4;
	Thu, 30 Jan 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V399itxs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D82770C
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256859; cv=none; b=QYxzEl7I+pQeVUs553mQqqu2P8eCwhSR97pSV7OR6cY3V1IRK91iP85+VlQu3hTBLqfKAmZDyi2EuZVMW2P2Gzwc9Bv8gAkpG8OxOfA5uWnaqYpLl0MtRhiTHN2xwi9WPi0lHSV93IQyl1j9bDSVa+gW4k88jAcJsDtGoXSh4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256859; c=relaxed/simple;
	bh=Se6rdfyXF9Uvn3rmO7oCGY6t7gZsY2JFIiP8oFXH5/k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k9oZWK/seYOli6Bleoehdv6BKN7qD0eKvhzoqstoZ+VtLFckdmLJmzoLtjx7yEkr0Nu7KeTDNGFPAaXK0p+xA/Hy6oyPXLDsJDjshzvT+nE6gzAhdPvjFdk0BVUm01f7wN6pZOQN/+oFmhlaPt72WuZpaupPXzQZyl1FFcbQ0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V399itxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738256856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0kKJ1G6ZjljaFWbHC2zuPfe2Sm4wdicJSq0zfASmEg=;
	b=V399itxsweLbRsXkh41HbGMCx/dexB/tZLTKb/dIP7eCkpJO2p+yeRKdXlzbCW/fyYsP3h
	zLalizvgkpR7xpwu9oDzJ8ftEYCkr+9Lu24dkeL3bL7t+r4m9P52h22lW+virjAyI6eZ1o
	JabrjSCTdg+fsO7Rqve7dMWn+WD5We8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-wH4nBpR1PTuQNVlNUNNZuw-1; Thu, 30 Jan 2025 12:07:35 -0500
X-MC-Unique: wH4nBpR1PTuQNVlNUNNZuw-1
X-Mimecast-MFC-AGG-ID: wH4nBpR1PTuQNVlNUNNZuw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46909701869so20350761cf.0
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 09:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738256854; x=1738861654;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0kKJ1G6ZjljaFWbHC2zuPfe2Sm4wdicJSq0zfASmEg=;
        b=tnsRlrt2zPXrNqZTpgc86/g0mEanWnMMqBeXPKJwbyD21hNrDS2gwqn2/gE7vId4o0
         ScoC2n1SJfk9kYfu5hJ2lQ1tEzUKkFpCOdba6EbH203NA//JnTj0KUAEWczMD1GMp5gu
         95HnDttsmQsjRtXkm9KBVQUOvMx/Eexc6nR6cX8m26AV+RXMxUEA/p49QDXWSdjEakco
         EgX59fGFRa2a4bKQwgPhp7lun+b2adhYExp8yWDGeRkH4Qhx4ocLyLGLkkW55b02tSyS
         13we0zWeYHMEo06oYHz1ZdMRzLkY6wS6mF4G1GGIyQZzkKH46v6Dp/oqkX8gzfNf6bop
         qmYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUX+tdS55OEI3sSpeaKOJ+hDdFa9ZaJK2RKjHww4U30s8etRoH7NV/N9pVqH2vQCWlz8FyeFYz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CIQS2Wh5JK4nlmAejYBTCZInsfCNaY571uBy9xkzyL6DpBM/
	PNfJyupFYBB5PkBvnKaVn8JoG0C9/Qo/emG3vhGl1ztmCOlITCTVt1RvlW7CQxUazQnt6DuOocW
	96HlfwdvDYZp9kQa1b6whWB7lrBtksFBWJg30H5qAqul3WtuOhZCUTVs=
X-Gm-Gg: ASbGncvA9NnhbrLHHN/sZeBViGcvZcH10b+XkMCM017AHdd2kCa4wjd96dfp2oLpErN
	SGOkXpmtQ0AEyvI+mYJJ0yfttYUkn+h1uuSPi5eX9/sE7SSTsNVIs5T2T3sNmg4uuZtmUUr9xo3
	w3Li4usqKT1nsT2AgCHNroUFj4XEYEEXQEQi49EIjWk86fyu7Fs3Kx+uX3o14nemcgUhmeiz3h/
	Ui4JvAE1HvscQ770CA4Pz3ZjupnvL19dGbqx+Mtom0UMpxonGncKJg/EeMg9RgA0GHzwLT5NRow
	JmDwAENp31OcJAYnUGv2L/EuZf6k25Fq1BGzko2rKRuWOW4NJkI=
X-Received: by 2002:a05:622a:199c:b0:467:5f17:94d with SMTP id d75a77b69052e-46fd0c03bfcmr133200171cf.52.1738256853799;
        Thu, 30 Jan 2025 09:07:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZoq1XD68jE07xNm/4TeJ099xQ48miPov6sXEUGROQlV7OEIV2eqoSMcfINVON3Hybe9Q/fw==
X-Received: by 2002:a05:622a:199c:b0:467:5f17:94d with SMTP id d75a77b69052e-46fd0c03bfcmr133199731cf.52.1738256853411;
        Thu, 30 Jan 2025 09:07:33 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0e2d7asm8648331cf.34.2025.01.30.09.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:07:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <baf1f9bf-4226-47f5-b795-c8862fd0554f@redhat.com>
Date: Thu, 30 Jan 2025 12:07:31 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5qLQ1o6cXbcvc0o@google.com>
 <366fd30f-033d-48d6-92b4-ac67c44d0d9b@redhat.com>
 <20250130163904.GB1283@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250130163904.GB1283@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 11:39 AM, Johannes Weiner wrote:
> On Thu, Jan 30, 2025 at 09:52:29AM -0500, Waiman Long wrote:
>> On 1/29/25 3:10 PM, Yosry Ahmed wrote:
>>> On Wed, Jan 29, 2025 at 02:12:04PM -0500, Waiman Long wrote:
>>>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>>>> reclaim over memory.high"), the amount of allocator throttling had
>>>> increased substantially. As a result, it could be difficult for a
>>>> misbehaving application that consumes increasing amount of memory from
>>>> being OOM-killed if memory.high is set. Instead, the application may
>>>> just be crawling along holding close to the allowed memory.high memory
>>>> for the current memory cgroup for a very long time especially those
>>>> that do a lot of memcg charging and uncharging operations.
>>>>
>>>> This behavior makes the upstream Kubernetes community hesitate to
>>>> use memory.high. Instead, they use only memory.max for memory control
>>>> similar to what is being done for cgroup v1 [1].
>>>>
>>>> To allow better control of the amount of throttling and hence the
>>>> speed that a misbehving task can be OOM killed, a new single-value
>>>> memory.high.throttle control file is now added. The allowable range
>>>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>>>> like before. Any non-zero positive value represents the corresponding
>>>> power of 2 reduction of throttling and makes OOM kills easier to happen.
>>>>
>>>> System administrators can now use this parameter to determine how easy
>>>> they want OOM kills to happen for applications that tend to consume
>>>> a lot of memory without the need to run a special userspace memory
>>>> management tool to monitor memory consumption when memory.high is set.
>>>>
>>>> Below are the test results of a simple program showing how different
>>>> values of memory.high.throttle can affect its run time (in secs) until
>>>> it gets OOM killed. This test program allocates pages from kernel
>>>> continuously. There are some run-to-run variations and the results
>>>> are just one possible set of samples.
>>>>
>>>>     # systemd-run -p MemoryHigh=10M -p MemoryMax=20M -p MemorySwapMax=10M \
>>>> 	--wait -t timeout 300 /tmp/mmap-oom
>>>>
>>>>     memory.high.throttle	service runtime
>>>>     --------------------	---------------
>>>>               0		    120.521
>>>>               1		    103.376
>>>>               2		     85.881
>>>>               3		     69.698
>>>>               4		     42.668
>>>>               5		     45.782
>>>>               6		     22.179
>>>>               7		      9.909
>>>>               8		      5.347
>>>>               9		      3.100
>>>>              10		      1.757
>>>>              11		      1.084
>>>>              12		      0.919
>>>>              13		      0.650
>>>>              14		      0.650
>>>>              15		      0.655
>>>>
>>>> [1] https://docs.google.com/document/d/1mY0MTT34P-Eyv5G1t_Pqs4OWyIH-cg9caRKWmqYlSbI/edit?tab=t.0
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    Documentation/admin-guide/cgroup-v2.rst | 16 ++++++++--
>>>>    include/linux/memcontrol.h              |  2 ++
>>>>    mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
>>>>    3 files changed, 57 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>>> index cb1b4e759b7e..df9410ad8b3b 100644
>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>> @@ -1291,8 +1291,20 @@ PAGE_SIZE multiple when read back.
>>>>    	Going over the high limit never invokes the OOM killer and
>>>>    	under extreme conditions the limit may be breached. The high
>>>>    	limit should be used in scenarios where an external process
>>>> -	monitors the limited cgroup to alleviate heavy reclaim
>>>> -	pressure.
>>>> +	monitors the limited cgroup to alleviate heavy reclaim pressure
>>>> +	unless a high enough value is set in "memory.high.throttle".
>>>> +
>>>> +  memory.high.throttle
>>>> +	A read-write single value file which exists on non-root
>>>> +	cgroups.  The default is 0.
>>>> +
>>>> +	Memory usage throttle control.	This value controls the amount
>>>> +	of throttling that will be applied when memory consumption
>>>> +	exceeds the "memory.high" limit.  The larger the value is,
>>>> +	the smaller the amount of throttling will be and the easier an
>>>> +	offending application may get OOM killed.
>>> memory.high is supposed to never invoke the OOM killer (see above). It's
>>> unclear to me if you are referring to OOM kills from the kernel or
>>> userspace in the commit message. If the latter, I think it shouldn't be
>>> in kernel docs.
>> I am sorry for not being clear. What I meant is that if an application
>> is consuming more memory than what can be recovered by memory reclaim,
>> it will reach memory.max faster, if set, and get OOM killed. Will
>> clarify that in the next version.
> You're not really supposed to use max and high in conjunction. One is
> for kernel OOM killing, the other for userspace OOM killing. That's tho
> what the documentation that you edited is trying to explain.
>
> What's the usecase you have in mind?

That is new to me that high and max are not supposed to be used 
together. One problem with v1 is that by the time the limit is reached 
and memory reclaim is not able to recover enough memory in time, the 
task will be OOM killed. I always thought that by setting high to a bit 
below max, say 90%, early memory reclaim will reduce the chance of OOM 
kills. There are certainly others that think like that.

So the use case here is to reduce the chance of OOM kills without 
letting really mishaving tasks from holding up useful memory for too long.

Cheers,
Longman


