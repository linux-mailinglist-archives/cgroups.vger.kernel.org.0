Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5A3438C2
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 06:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVFoe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 01:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVFo2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Mar 2021 01:44:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C21C061574;
        Sun, 21 Mar 2021 22:44:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ay2so5953696plb.3;
        Sun, 21 Mar 2021 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3wC49uIyVrfJgyWVynqmzHUtHk/JAsouFEaf2/Gji4=;
        b=L/FRQ36YeHcU9e7rpbofKUpXk2+gOqwjfat1hy2OCA7a/0Jkhl+L+K9ilPvV4kj52Q
         JzeZ2GYnsEni0nt3RtFm9zJwaWyQM1aI5xKsua5Zxifhc6rNu6R2PuDNTzKASn0q5/zf
         GBp5aeu379kfNpWz/sFWIoCUnUh7WmOSkTj3ogfUQtlIkYVkMvS50WgLqiza1pYVS3W2
         yf5Rwp/9DyZ03NliL4rFYI7NXG8PBrklN+d+NpuSMq+UkqX2oYmmwHj0JZ+KlkI3KGCI
         Gqls5dCwSpur/uMXiNTM97WdH5mM1ZtGxJxWmiLxUoJeTnosxJRbFb0RA8kJ4XA6Qgl4
         594Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3wC49uIyVrfJgyWVynqmzHUtHk/JAsouFEaf2/Gji4=;
        b=EgJM7p339ujwtIrDeqnGvtyWYvM0EMADgyDG54V9Q7XWEAUpVVF5SXDq/26xAJWMco
         9wM9G0poClLvnNjf3iMhqx7bgdqiMXxByZXoxMQvFBzEAjGyUGYCI76eGcHpgqqzIbYi
         KTtId7fGIcegngFabXaP1f0irH22PzQZdNjcbabycgcZceM2bvewsouAft/0Gn7WedvQ
         OuthXdN35Qw+1N7upm9kzLpV1WEAfkoY0+dxEC5G6EqZpILDuEiPKOgnkWmNSAlQYWEZ
         NTle/IJxiBlLFY/gpDMQFdpgmJfM6n1WvS+eXI3Eloq7h/aTU+w49CqSoVlbkhqTVAYC
         JPoA==
X-Gm-Message-State: AOAM530omsRC3uWN7hoxS5fHxEVokuP+xY16/HbNJk/TS/lXJcO+unhQ
        cQsJLKQk+aPC7pVCYc6T0/FOtc33qrw=
X-Google-Smtp-Source: ABdhPJzAvFQBTkW7+6ZxpeOwnyaVKBeDJlVeVZZFVl//I/KD/WVNeag7Xn3Yj3+ymIvG9pD96ed3Tw==
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr11495416pjn.147.1616391866983;
        Sun, 21 Mar 2021 22:44:26 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id w203sm12163646pfc.188.2021.03.21.22.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 22:44:26 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/11] bfq: introduce bfq.ioprio for cgroup
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615517202.git.brookxu@tencent.com>
 <F64D5CC8-E650-4AE6-8452-7FA0C1976271@linaro.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <d240e781-09d4-9831-482e-d2f628e9c463@gmail.com>
Date:   Mon, 22 Mar 2021 13:44:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <F64D5CC8-E650-4AE6-8452-7FA0C1976271@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Paolo Valente wrote on 2021/3/21 19:04:
> 
> 
>> Il giorno 12 mar 2021, alle ore 12:08, brookxu <brookxu.cn@gmail.com> ha scritto:
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
> 
> Hi Chunguang,
> 
>> Tasks in the production environment can be roughly divided into
>> three categories: emergency tasks, ordinary tasks and offline
>> tasks. Emergency tasks need to be scheduled in real time, such
>> as system agents. Offline tasks do not need to guarantee QoS,
>> but can improve system resource utilization during system idle
>> periods, such as background tasks. The above requirements need
>> to achieve IO preemption. At present, we can use weights to
>> simulate IO preemption, but since weights are more of a shared
>> concept, they cannot be simulated well. For example, the weights
>> of emergency tasks and ordinary tasks cannot be determined well,
>> offline tasks (with the same weight) actually occupy different
>> resources on disks with different performance, and the tail
>> latency caused by offline tasks cannot be well controlled. Using
>> ioprio's concept of preemption, we can solve the above problems
>> very well. Since ioprio will eventually be converted to weight,
>> using ioprio alone can also achieve weight isolation within the
>> same class. But we can still use bfq.weight to control resource,
>> achieving better IO Qos control.
>>
>> However, currently the class of bfq_group is always be class, and
>> the ioprio class of the task can only be reflected in a single
>> cgroup. We cannot guarantee that real-time tasks in a cgroup are
>> scheduled in time. Therefore, we introduce bfq.ioprio, which
>> allows us to configure ioprio class for cgroup. In this way, we
>> can ensure that the real-time tasks of a cgroup can be scheduled
>> in time. Similarly, the processing of offline task groups can
>> also be simpler.
>>
> 
> I find this contribution very interesting.  Anyway, given the
> relevance of such a contribution, I'd like to hear from relevant
> people (Jens, Tejun, ...?), before revising individual patches.
> 
> Yet I already have a general question.  How does this mechanism comply
> with per-process ioprios and ioprio classes?  For example, what
> happens if a process belongs to BE-class group according to your
> mechanism, but to a RT class according to its ioprio?  Does the
> pre-group class dominate the per-process class?  Is all clean and
> predictable?
Hi Paolo, thanks for your precious time. This is a good question. Now
the pre-group class dominate the per-process class. But thinking about
it in depth now, there seems to be a problem in the container scene,
because the tasks inside the container may have different ioprio class
and ioprio. Maybe Bfq.ioprio should only affects the scheduling of the
group? which can be better compatible with the actual production
environment.

>> The bfq.ioprio interface now is available for cgroup v1 and cgroup
>> v2. Users can configure the ioprio for cgroup through this interface,
>> as shown below:
>>
>> echo "1 2"> blkio.bfq.ioprio
> 
> Wouldn't it be nicer to have acronyms for classes (RT, BE, IDLE),
> instead of numbers?

As ioprio is a number, so the ioprio class also uses a number form.
But your suggestion is good. If necessary, I will modify it later.

> 
> Thank you very much for this improvement proposal,

More discussions are welcome, Thanks.

> Paolo
> 
>>
>> The above two values respectively represent the values of ioprio
>> class and ioprio for cgroup. The ioprio of tasks within the cgroup
>> is uniformly equal to the ioprio of the cgroup. If the ioprio of
>> the cgroup is disabled, the ioprio of the task remains the same,
>> usually from io_context.
>>
>> When testing, using fio and fio_generate_plots we can clearly see
>> that the IO delay of the task satisfies RT> BE> IDLE. When RT is
>> running, BE and IDLE are guaranteed minimum bandwidth. When used
>> with bfq.weight, we can also isolate the resource within the same
>> class.
>>
>> The test process is as follows:
>> # prepare data disk
>> mount /dev/sdb /data1
>>
>> # create cgroup v1 hierarchy
>> cd /sys/fs/cgroup/blkio
>> mkdir rt be idle
>> echo "1 0" > rt/blkio.bfq.ioprio
>> echo "2 0" > be/blkio.bfq.ioprio
>> echo "3 0" > idle/blkio.bfq.ioprio
>>
>> # run fio test
>> fio fio.ini
>>
>> # generate svg graph
>> fio_generate_plots res
>>
>> The contents of fio.ini are as follows:
>> [global]
>> ioengine=libaio
>> group_reporting=1
>> log_avg_msec=500
>> direct=1
>> time_based=1
>> iodepth=16
>> size=100M
>> rw=write
>> bs=1M
>> [rt]
>> name=rt
>> write_bw_log=rt
>> write_lat_log=rt
>> write_iops_log=rt
>> filename=/data1/rt.bin
>> cgroup=rt
>> runtime=30s
>> nice=-10
>> [be]
>> name=be
>> new_group
>> write_bw_log=be
>> write_lat_log=be
>> write_iops_log=be
>> filename=/data1/be.bin
>> cgroup=be
>> runtime=60s
>> [idle]
>> name=idle
>> new_group
>> write_bw_log=idle
>> write_lat_log=idle
>> write_iops_log=idle
>> filename=/data1/idle.bin
>> cgroup=idle
>> runtime=90s
>>
>> V2:
>> 1. Optmise bfq_select_next_class().
>> 2. Introduce bfq_group [] to track the number of groups for each CLASS.
>> 3. Optimse IO injection, EMQ and Idle mechanism for CLASS_RT.
>>
>> Chunguang Xu (11):
>>  bfq: introduce bfq_entity_to_bfqg helper method
>>  bfq: limit the IO depth of idle_class to 1
>>  bfq: keep the minimun bandwidth for be_class
>>  bfq: expire other class if CLASS_RT is waiting
>>  bfq: optimse IO injection for CLASS_RT
>>  bfq: disallow idle if CLASS_RT waiting for service
>>  bfq: disallow merge CLASS_RT with other class
>>  bfq: introduce bfq.ioprio for cgroup
>>  bfq: convert the type of bfq_group.bfqd to bfq_data*
>>  bfq: remove unnecessary initialization logic
>>  bfq: optimize the calculation of bfq_weight_to_ioprio()
>>
>> block/bfq-cgroup.c  |  99 +++++++++++++++++++++++++++++++----
>> block/bfq-iosched.c |  47 ++++++++++++++---
>> block/bfq-iosched.h |  28 ++++++++--
>> block/bfq-wf2q.c    | 124 +++++++++++++++++++++++++++++++++-----------
>> 4 files changed, 244 insertions(+), 54 deletions(-)
>>
>> -- 
>> 2.30.0
>>
> 
