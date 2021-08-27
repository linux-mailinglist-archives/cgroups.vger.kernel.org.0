Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4463F9D49
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhH0RJ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhH0RJ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 13:09:58 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC6C061757
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 10:09:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g8so7679601ilc.5
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOCQPSAXEBI18L8GLJfeEJCDZQiWKeHIWKJBdyqkyqo=;
        b=bmlb2tCkX487OfI8Ekc5/Q1GwX7To/VXB9ALS8vkjTegZTuEpC09J2fUFHPPArl/Zi
         6AKOwo5BQL4BwstsEGfj6iiJRWUe327XXdnq2Tn2OzkrUZ15dVJerHPMKg2qy5TwquKD
         VfVWRYlnQybeAXMkbcdu2cfbOUYeBpXNf6UUGd7eJwUPk2Kt4w5otxc2HzobwgCr+9X1
         TzldE1Km9uGPYd+8yk4RLGAeK6B1SEv24EWZiuoBgbuiXCP5+bYZGSoUWOpWNZ92Qum/
         Mh35m5BkKgpG3wXVw2o8MAKzxvqk2KFsPTJB7SZeKGHbj1h/Fe86/riB+FBSP9NFS3vW
         DgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOCQPSAXEBI18L8GLJfeEJCDZQiWKeHIWKJBdyqkyqo=;
        b=HARXf0jrMIT9RCDk9P3fKp0natJbj/K415A13dwwtCRPUrJAhFd1P1hFIGLq2+GasI
         zCN3d8I9G58NngWsGyjyVQo98DRq1rIxKpfHVUf7NMLE+ZhrGSYdc/H1qFhtyVG9H+tv
         OhcvKB23wAlYZOo9ggCY2aqSONdyScMSakoJxG4dp+4I3L1D9LQ8WMp8+oB7ZVzVZIAh
         BA0C39SDpMMCC48AX4v+Dy13cFWXaA7EOFNvgV6Zdpb09Bp5+NpXLaCY/NPrgp8NwiYH
         X2Dx5HxokrAQBIWfn96AJjyFH1vFj8UYH2r5lGQbnZkLpPTpN/mWQGBpyAYsmpEjUZT/
         mThQ==
X-Gm-Message-State: AOAM531Lmtt/yNfzhKfSfH2RLwP1+CXZrq7NHs3WhBn5KCxzbT53wSpD
        FAU69HL7V9PQpRkDcfBvhgVuuy6Py1RB2w==
X-Google-Smtp-Source: ABdhPJyIGPEi1f8SvJ+Ae6SJpGuTYbi47PC9jRgznesbgw3uauqczBAtJJ8dcEH0hbC9D7cwYTXlkA==
X-Received: by 2002:a92:d304:: with SMTP id x4mr7438435ila.82.1630084148492;
        Fri, 27 Aug 2021 10:09:08 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z26sm3683164iol.6.2021.08.27.10.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:09:08 -0700 (PDT)
Subject: Re: [PATCH for-5.15 v2] io_uring: consider cgroup setting when
 binding sqpoll cpu
To:     Hao Xu <haoxu@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, cgroups@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210827141315.235974-1-haoxu@linux.alibaba.com>
 <0988b0dc-232f-80cd-c984-2364c0dee69f@kernel.dk>
 <592ba01a-a128-f781-d920-2b480f91c451@linux.alibaba.com>
 <d413acfe-333a-9b7d-aba8-6e99db376fd6@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9028a8de-a290-a955-1eac-43bec6e8702d@kernel.dk>
Date:   Fri, 27 Aug 2021 11:09:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d413acfe-333a-9b7d-aba8-6e99db376fd6@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/27/21 11:03 AM, Hao Xu wrote:
> 在 2021/8/28 上午12:57, Hao Xu 写道:
>> 在 2021/8/27 下午10:18, Jens Axboe 写道:
>>> On 8/27/21 8:13 AM, Hao Xu wrote:
>>>> Since sqthread is userspace like thread now, it should respect cgroup
>>>> setting, thus we should consider current allowed cpuset when doing
>>>> cpu binding for sqthread.
>>>
>>> In general, this looks way better than v1. Just a few minor comments
>>> below.
>>>
>>>> @@ -7000,6 +7001,16 @@ static bool io_sqd_handle_event(struct 
>>>> io_sq_data *sqd)
>>>>       return did_sig || test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
>>>>   }
>>>> +static int io_sq_bind_cpu(int cpu)
>>>> +{
>>>> +    if (!test_cpu_in_current_cpuset(cpu))
>>>> +        pr_warn("sqthread %d: bound cpu not allowed\n", current->pid);
>>>> +    else
>>>> +        set_cpus_allowed_ptr(current, cpumask_of(cpu));
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> This should not be triggerable, unless the set changes between creation
>>> and the thread being created. Hence maybe the warn is fine. I'd probably
>>> prefer terminating the thread at that point, which would result in an
>>> -EOWNERDEAD return when someone attempts to wake the thread.
>>>
>>> Which is probably OK, as we really should not hit this path.
>> Actually I think cpuset change offen happen in container environment(
>> at leaset in my practice), eg. by resource monitor and balancer. So I
>> did this check to make sure we are still maintain sq_cpu logic at that
>> time as possible as we can. Though the problem is still there during
>> sqthread running time(the cpuset can change at anytime, which changes
>> the cpumask of sqthread)
> And because the cpumask of sqthread may be changed by the cgroup cpuset
> change at any time, so here I just print a warnning rather than
> terminating sqthread due to this 'normal thing'..

Do we even want the warning then? If it's an expected thing, seems very
annoying to warn about it.

-- 
Jens Axboe

