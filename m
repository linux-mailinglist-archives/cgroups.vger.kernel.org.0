Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71B354DE5
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhDFHcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhDFHcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 03:32:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE6C06174A;
        Tue,  6 Apr 2021 00:31:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k8so9743056pgf.4;
        Tue, 06 Apr 2021 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UwN9w+51+jOvx1hrWNQ1GlpP9ul/HF8UegwwJjkG1m0=;
        b=WS6mCzGZLxylWCXpePONbSRO9ety8hUfT2R0doOOJEF9FU677AIP+XTP2uxbNSVnKd
         vJHQ4n97MW6skxC9xu9OljhFgtrUfG+qV1Bam6cNLV5M23xxx94f2seb3L3EUCDzkuIs
         LHPDJx/t1a6K1meBSSjmGk9VbSiDUBJgN27ncjYKsQO//TkfNA8RVWPyjDjdtc9z9wKP
         p7v5ElVmQiomYGhzeu+wwgYocMAMc3OlwS9EoJNvCRKjsPbrGosaf2Z6OIpfLyONVQ7B
         s6gSJfhNAxwAJshWWFjmOBG4bU6w5a+Q9np3awDjnP7dRAO3FzxdFUkqUm93iIOdUZgs
         P7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwN9w+51+jOvx1hrWNQ1GlpP9ul/HF8UegwwJjkG1m0=;
        b=RehgeDL2q/vB6sKikwZfZICR/9GEqE5Y2mdfaKuaUmxJd4tR0Azbp6nJYkXKTfplAY
         BVTTZRRYl06ijQUntvLLXyqsaIVXQmZ3gCIsdSqSqbzruw60FZXgwwa5kmLaRoqgx6GO
         +Ik88WW6Yk7Z7DIAWQ7NmiXtkQiUOklRcuDbFi/MxgEFXYM4ZtXOkhRjDlnEGGUkSKIw
         /EW51XpMrUY1Bc4/jEI8/nFP0g4kypCTl4qBWcWcuOsfb5IPF4U+xn+rS377w7o3BPlr
         cKYum1m6H1xd3HdIA3tVYp/gVvRO7VV7cvO8Lk2faBbVTG50BhHc3nTihfcDnmOSsFCI
         vS2g==
X-Gm-Message-State: AOAM5305wy3p8T9Wzqyh9dJqRm57IbDS+Hu8SPLPz41IOAXIM2G+9pPb
        nL3yyAe5/Ri4CRl//O66/p/0lasL7c8=
X-Google-Smtp-Source: ABdhPJxQpZGX47R3NEQnduX9lb3gfpFWnHSjbGP1N9aMtiMGOfVIlyjxrPJC4XKCJYMAqsZJN9fPRg==
X-Received: by 2002:a62:cd4d:0:b029:216:8c86:bf5c with SMTP id o74-20020a62cd4d0000b02902168c86bf5cmr25973924pfg.27.1617694314256;
        Tue, 06 Apr 2021 00:31:54 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id x3sm17205116pfn.181.2021.04.06.00.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 00:31:53 -0700 (PDT)
Subject: Re: [PATCH v3 00/14] bfq: introduce bfq.ioprio for cgroup
To:     Tejun Heo <tj@kernel.org>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1616649216.git.brookxu@tencent.com>
 <YGnkuWYKeK7C8/Za@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <72bf47d0-3294-5f9d-7ce2-775e12fd721e@gmail.com>
Date:   Tue, 6 Apr 2021 15:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGnkuWYKeK7C8/Za@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/4/5 0:09:
> Hello,

Hi, tj, thanks for your reply：）

> On Thu, Mar 25, 2021 at 02:57:44PM +0800, brookxu wrote:
>> INTERFACE:
>>
>> The bfq.ioprio interface now is available for cgroup v1 and cgroup
>> v2. Users can configure the ioprio for cgroup through this
>> interface, as shown below:
>>
>> echo "1 2"> blkio.bfq.ioprio
>>
>> The above two values respectively represent the values of ioprio
>> class and ioprio for cgroup.
>>
>> EXPERIMENT:
>>
>> The test process is as follows:
>> # prepare data disk
>> mount /dev/sdb /data1
>>
>> # prepare IO scheduler
>> echo bfq > /sys/block/sdb/queue/scheduler
>> echo 0 > /sys/block/sdb/queue/iosched/low_latency
>> echo 1 > /sys/block/sdb/queue/iosched/better_fairness
>>
>> It is worth noting here that nr_requests limits the number of
>> requests, and it does not perceive priority. If nr_requests is
>> too small, it may cause a serious priority inversion problem.
>> Therefore, we can increase the size of nr_requests based on
>> the actual situation.
>>
>> # create cgroup v1 hierarchy
>> cd /sys/fs/cgroup/blkio
>> mkdir rt be0 be1 be2 idle
>>
>> # prepare cgroup
>> echo "1 0" > rt/blkio.bfq.ioprio
>> echo "2 0" > be0/blkio.bfq.ioprio
>> echo "2 4" > be1/blkio.bfq.ioprio
>> echo "2 7" > be2/blkio.bfq.ioprio
>> echo "3 0" > idle/blkio.bfq.ioprio
> 
> Here are some concerns:
> 
> * The main benefit of bfq compared to cfq at least was that the behavior
>   model was defined in a clearer way. It was possible to describe what the
>   control model was in a way which makes semantic sense. The main problem I
>   see with this proposal is that it's an interface which grew out of the
>   current implementation specifics and I'm having a hard time understanding
>   what the end results should be with different configuration combinations.

In the current scheduling strategy, we consider both the entity's ioprio class
and budget size. But in fact, there are some differences between bfqq and bfqg.
Since the ioprio class of bfqg is fixed to BE, the scheduling of bfqg actually
only considers the budget size. The introduction of ioprio for cgroup should not
destroy or complicate the existing design of bfq. It followed the original design
of bfq and try to make us thinking about the scheduling of entities more simply,
without distinguishing between bfqq and bfqg.

> * While this might work around some scheduling latency issues but I have a
>   hard time imagining it being able to address actual QoS issues. e.g. on a
>   lot of SSDs, without absolute throttling, device side latencies can spike
>   by multiple orders of magnitude and no prioritization on the scheduler
>   side is gonna help once such state is reached. Here, there's no robust
>   mechanisms or measurement/control units defined to address that. In fact,

The latency caused by ssd fireware operation is unpredictable. Here we try to
control Qos under normal conditions, which usually meets most scenarios. In the
container scenario, in addition to the overall IO Qos control of the container,
we also hope to achieve more fine-grained Qos control of the tasks inside the
container, such as ioprio support, suppression of async IO, and so on.

>   the above direction to increase nr_requests limit will make priority
>   inversions on the device and post-elevator side way more likely and
>   severe.

Increasing nr_request is really not a good way. I tried to reserve 10% of tags
for in service group by limit depth, which can better alleviate this problem,
but more tests are needed.
 
> So, maybe it helps with specific scenarios on some hardware, but given the
> ad-hoc nature, I don't think it justifies all the extra interface additions.
> My suggestion would be slimming it down to bare essentials and making the
> user interface part as minimal as possible.

Now the weight of bfqq is jointly determined by ioprio and weight, and both
ioprio and weight will update entity.weight. After the introduction of bfq.ioprio
for cgroup, the processing of bfqg is the same as that of bfqq, and the complexity
is not increased from the perspective of entity. There is no new concept added to
the user side, because the per task ioprio has existed for a long time.

> Thanks.
> 
