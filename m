Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6243A33CD
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 21:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFJTSa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhFJTS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 15:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623352592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liO0eMHLLQxFJzTbME5X4nacHbq/D6xkCgBqqSco7f0=;
        b=UKN+VJFnPT1Qyo3v1npa3BNUZAI5MynuwJj6j1bhiY7PgYNDadnJiKxiSqCfqlg+CR+/Dc
        +a2PtBDDqQNbbPd+VasXaEE0uJ7hI2W9T773WubC+23Di5HiXGq+fjZj3RznfOg8b2brr1
        U58N3WY9z3khNJP/ah9cLwXYoHprR48=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-X7-NJbUIP7exltYS5gRicw-1; Thu, 10 Jun 2021 15:16:31 -0400
X-MC-Unique: X7-NJbUIP7exltYS5gRicw-1
Received: by mail-qk1-f199.google.com with SMTP id a193-20020a3766ca0000b02903a9be00d619so19927986qkc.12
        for <cgroups@vger.kernel.org>; Thu, 10 Jun 2021 12:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=liO0eMHLLQxFJzTbME5X4nacHbq/D6xkCgBqqSco7f0=;
        b=PitLmuaR6YAC5CbkaRD4lYC+Jh+AP6LxUPq5dR7sZOv81ADE/pIMPevOFe0PumupHG
         NLG2FzTvCBwwF0Uu6xnbbQFoF63HvJ+8F+eHHn0Q20YNi3St0RjbktqjpFAS/J4XJyg5
         NyzuWw+EzDWsxgOzEpFY9RWB+kER+2JvvzsLnsMsLUa0/Z5aYBW8vEudkySX1YGWnoec
         SLAbewUxod2BV0h61CL/jSeI+UIlG/yYZPnuSvV6ffN4S+vfptXArDy1vmRlk8Gp1Ae6
         HQqoLoQLVMabAiY42jCGYz/FxRQvs0rs0DkKi06OpC7msZxdC9oUKZSTCtifWN07hvr5
         YmIw==
X-Gm-Message-State: AOAM533J7Q95uFWKMC32wouhYntcEyAmw3llMedeV7gK7vrJdgJ1p4D+
        doAPoLKIqN+l0OsdhRbOYbrxy3xTxf/7t3DaHU7m8LYN/ZEuGuEIk2hkkZHa/1CeZvdG8cQu0bb
        kJZDFn4tqN2obnqsOcQ==
X-Received: by 2002:a37:5507:: with SMTP id j7mr104028qkb.309.1623352591110;
        Thu, 10 Jun 2021 12:16:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAuBlSzvmN6H5oSpFj7wzJ2WHLurIlPNKFIgsipjYWbH5Grt8CtLeVfMxQOG6UnUOcx7CMDw==
X-Received: by 2002:a37:5507:: with SMTP id j7mr104009qkb.309.1623352590931;
        Thu, 10 Jun 2021 12:16:30 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 7sm2906484qkb.86.2021.06.10.12.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:16:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no
 load balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
 <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
Message-ID: <820aff72-fce2-ac2f-88e6-787249e04308@redhat.com>
Date:   Thu, 10 Jun 2021 15:16:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/10/21 2:50 PM, Peter Zijlstra wrote:
> On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
>> Cpuset v1 uses the sched_load_balance control file to determine if load
>> balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>> as its use may require disabling load balancing at cgroup root.
>>
>> For workloads that require very low latency like DPDK, the latency
>> jitters caused by periodic load balancing may exceed the desired
>> latency limit.
>>
>> When cpuset v2 is in use, the only way to avoid this latency cost is to
>> use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
>> the kernel boot, however, there is no way to add or remove CPUs from
>> this isolated set. For workloads that are more dynamic in nature, that
>> means users have to provision enough CPUs for the worst case situation
>> resulting in excess idle CPUs.
>>
>> To address this issue for cpuset v2, a new cpuset.cpus.partition type
>> "root-nolb" is added which allows the creation of a cpuset partition with
>> no load balancing. This will allow system administrators to dynamically
>> adjust the size of the no load balancing partition to the current need
>> of the workload without rebooting the system.
> I'm confused, why do you need this? Just create a parition for each cpu.
>
 From a management point of view, it is more cumbersome to do one cpu 
per partition. I have suggested this idea of 1 cpu per partition to the 
container developers, but they don't seem to like it.

Cheers,
Longman

