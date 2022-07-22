Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432F157DB52
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGVHdZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jul 2022 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiGVHdY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jul 2022 03:33:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DD932EF6
        for <cgroups@vger.kernel.org>; Fri, 22 Jul 2022 00:33:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c139so3833895pfc.2
        for <cgroups@vger.kernel.org>; Fri, 22 Jul 2022 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aBbLSX1JockKc7+DXzMhzivNTlzRCnKzS9NOsdu1GjE=;
        b=FH5lfoYy5vxWwh++51JNpjlucwlsQS4ixmz+0B3NZkoe7RPCjTMHjThSddtl0swkZl
         9T4ukJZEb1V3D9PIKn1QSBahL4OsSxSyt8Ev8RV4nP+gW5w5H2fIC/DbwpMSiWPA2ABJ
         9FSCGJfesuGhbecSsxNaGU78fp4xK1ZtEG/Np1qnnavUKZQATQlqlnvHMnPQ00jbhhsT
         ZaIaZWJolnaAzbuXrVkj8YgfeHBhH8cSKbNy7isQ8DnR22sFEzBY+JDKCN7FQU7X7pO6
         9kesoGgKTzbUtS+7SlzHe9ECnLkHLRESFh5vhGRoZ0tXFvogf0IDqb82FrSDH0kDDKH0
         +zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aBbLSX1JockKc7+DXzMhzivNTlzRCnKzS9NOsdu1GjE=;
        b=rMWuia1g5sAuMKUvWb45OuJGkRjNJhDoL6uHGoS4wuiuroZAWjeFrDYsUu9g5NGr+t
         rUBCpuiG1DVaJNydm9lvpo0AFiP5dp/HrvkDy09aBcaOZzkw92d2f5XmmLELYBD6uJ+u
         aNMGaOa9n6fmVOfN7apuU+vzYuvZTba5ZbqPf8vYp5+y15LZjjw4u1MVA4lmKX7JTcGo
         VzRMtMIkXyvTjQ9GG7iEZO9nT69/GwKiTo2XYgEbxcrx2W62X9Gf/Ze7VJkubxtmghup
         QvNs0tFRxgPeieL2DG8HQPDwFK92Es2bDqtNci7/HLLmNb5j7bkjEfJ+RrPgQ3LWhmvX
         VHxA==
X-Gm-Message-State: AJIora/CkMab+dMoWXanQUF4PEbfsgDieozMJgQk6sBWpdyfSXoc1bAL
        +3LnVnZwPe6cjlALv/8hOh2Ca6nVKSFD2A==
X-Google-Smtp-Source: AGRyM1tIBYKqs//Fx7yUJnJ9z6HtvRCo591eHv4D/RHr1WN4SAHATgGqm640z6NmQmxJ17TqLF2vKg==
X-Received: by 2002:a65:6a05:0:b0:3db:27cb:9123 with SMTP id m5-20020a656a05000000b003db27cb9123mr2047983pgu.497.1658475202162;
        Fri, 22 Jul 2022 00:33:22 -0700 (PDT)
Received: from [10.255.164.21] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 193-20020a6307ca000000b0041a27e7284bsm2763448pgh.48.2022.07.22.00.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:33:21 -0700 (PDT)
Message-ID: <ab445d4d-70d2-9e6f-dd1d-9e71f00c1796@bytedance.com>
Date:   Fri, 22 Jul 2022 15:33:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>, hannes@cmpxchg.org,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-10-zhouchengming@bytedance.com>
 <65d9f79b-be9b-e21e-0624-5c9f2cc0c0b2@bytedance.com>
 <ce22fa9d-aad0-fc23-d304-14fdd27130f4@bytedance.com>
 <5e5d41e2-5f89-8c52-11e5-0c55c5595a88@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <5e5d41e2-5f89-8c52-11e5-0c55c5595a88@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/7/22 15:14, Abel Wu wrote:
> On 7/22/22 2:13 PM, Chengming Zhou Wrote:
>> On 2022/7/22 11:30, Abel Wu wrote:
>>> Hi Chengming,
>>>
>>> On 7/21/22 12:04 PM, Chengming Zhou Wrote:
>>>> Now PSI already tracked workload pressure stall information for
>>>> CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
>>>> obvious impact on some workload productivity, such as web service
>>>> workload.
>>>>
>>>> When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
>>>> from update_rq_clock_task(), in which we can record that delta
>>>> to CPU curr task's cgroups as PSI_IRQ_FULL status.
>>>
>>> The {soft,}irq affection should be equal to all the runnable tasks
>>> on that cpu, not only rq->curr. Further I think irqstall is per-cpu
>>> rather than per-cgroup.
>>
>> Although IRQ/SOFTIRQ is per-cpu, it's the rq->curr who own the CPU at the time
>> and pay for it, meanwhile other groups would be thought as PSI_CPU_FULL.
> 
> I don't think rq->curr pays for it if you mean consuming quota here.

Yes, it makes rq->curr's groups look more productive than it actually is,
which are clearly different from other groups.

> And it doesn't seem appropriate to let other groups treat it as cpu
> stall because the rq->curr is also the victim rather than the one
> causes stall (so it's different from rq->curr causing memstall and
> observed as cpustall by others).

IMHO, we don't care who causes stall, instead we care about what affects
workload productivity.


> 
>>
>> So I think it's reasonable to account this IRQ/SOFTIRQ delta to rq->curr's groups
>> as PSI_IRQ_FULL pressure stall. And per-cpu IRQ stall can also get from psi_system.
>>
> 
