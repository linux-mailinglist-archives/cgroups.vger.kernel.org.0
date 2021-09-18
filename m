Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989241028F
	for <lists+cgroups@lfdr.de>; Sat, 18 Sep 2021 03:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhIRBUl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIRBUk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 21:20:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1DC061574;
        Fri, 17 Sep 2021 18:19:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u18so11309462pgf.0;
        Fri, 17 Sep 2021 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zyJvMDxoHAwCNjMlc0L2z6IcTBSzl1epSdqJhT+EKUA=;
        b=QhnXKrJbOO4zesM9YlaaYQ/sqQel7Z+oBxBZ2yp9Fqbv6gyLGpecz3bAVayyihvEiE
         rautM/r6vn2xUpBZ13Y4qZx/h3gFFMOrx03UE4jIC0dHmBm4ooUbtQVZuxrKco/Gf7Do
         mkfRyO2EJRDCb1NFSo4vLqSQw3N1SbF8leWzYzmychtf3uGHbbKqgjYcmnDQvGwiqxP6
         lGftKAe/GeZkjPXl7lcLnKtf/iyo94JYmi43R9joFwd7l85CONKVHdZ25i3HQicAoXoB
         kwPPzzrZgkw/z8zANMamqIUUiyYAXXPAQ7MK5By/I9l9wPtEMYdbJL8zdU/S4TQpDTMH
         31lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zyJvMDxoHAwCNjMlc0L2z6IcTBSzl1epSdqJhT+EKUA=;
        b=7QIo15/88DIVPVwDMa7xmIemxNUgKTqb7ZhwIyz91rat9f26oEf8ho3Ni5OH/s1WLc
         YqWOT09hk1aJGWFWZqKu4jINv+zNE2UhMU2NJNZoxBVZ4kzcsx+ntx/o5i2L6pQWECK2
         Ta/JunQrVci8/GVzKFaLGykP5m/OmFnB7VTQUmALtpGoalZkcGMPWr659wuwUgJUNISd
         fqwhvJcmyVeuwtrbDv4J9bPmogonzdjXh7ex1h8NMAkujMp+oR+ANjdDFwOoK00kRK0N
         EDRMBteU7aHhsAiVuiyQN8dQ/3qWlSOdExPYpjpWG8dQr1dGYGAMRpWTWVYgdiPJvirh
         ziYw==
X-Gm-Message-State: AOAM5337SZj7WZELelGYOCGTBJ4IVWNIhQxkADSMwu0lW6Myw4661rNQ
        Iil9WJ1kgd6I8f6mEtSSmadaGNHVJqPJsw==
X-Google-Smtp-Source: ABdhPJxczip+vNbFI2q+OxE87t9KMyH64KNT1qb3fARwZlJBHusUPg5tM6tm9Kz8wrrcRh1IPKOYBA==
X-Received: by 2002:a63:5663:: with SMTP id g35mr12409627pgm.368.1631927956983;
        Fri, 17 Sep 2021 18:19:16 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([162.219.34.244])
        by smtp.gmail.com with ESMTPSA id b85sm7432505pfb.0.2021.09.17.18.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 18:19:16 -0700 (PDT)
Subject: Re: Memcached with cfs quota 400% performance boost after bind to 4
 cpus
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9f907d99-1cdb-37db-49ae-8e31c7ea8fe7@gmail.com>
Message-ID: <a5404b12-b1f1-db87-2836-7974a6878cb3@gmail.com>
Date:   Sat, 18 Sep 2021 09:19:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9f907d99-1cdb-37db-49ae-8e31c7ea8fe7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Peter

The hardware information is as following

On 2021/9/17 8:35 下午, Wang Jianchao wrote:
> Hi list
> 
> I have a test environment with following,> A memcached (memcached -d -m 50000 -u root -p 12301 -c 1000000 -t 16) in cpu cgroup with following config,
> cpu.cfs_quota_us = 400000
> cpu.cfs_period_us = 100000
Model name:            Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz
Stepping:              7
CPU MHz:               2800.033
CPU max MHz:           3900.0000
CPU min MHz:           1000.0000
BogoMIPS:              4600.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              22528K
NUMA node0 CPU(s):     0-15,32-47
NUMA node1 CPU(s):     16-31,48-63
> 
> And a mutilate loop (mutilate -s x.x.x.x:12301 -T 40 -c 20 -t 60 -W 5 -q 1000000) running on another host
> w/o any cgroup config,
Model name:            Intel(R) Xeon(R) Gold 5218R CPU @ 2.10GHz
Stepping:              7
CPU MHz:               2900.155
CPU max MHz:           4000.0000
CPU min MHz:           800.0000
BogoMIPS:              4200.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              28160K
NUMA node0 CPU(s):     0-19,40-59
NUMA node1 CPU(s):     20-39,60-79

The memory on both machine is bigger than 100G and most of them is free.

> 
> When bind memcached to  0-15 with cpuset, 
> ==========================================
> mutilate showed,
> #type       avg     std     min     5th    10th    90th    95th    99th
> read     1275.8  6358.9    49.8   378.2   418.5   767.2   841.4 53998.5
> update      0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0
> op_q        1.0     0.0     1.0     1.0     1.0     1.1     1.1     1.1
> 
> Total QPS = 626566.2 (37594133 / 60.0s)
> 
> Misses = 0 (0.0%)
> Skipped TXs = 0 (0.0%)
> 
> RX 9288150851 bytes :  147.6 MB/s
> TX 1353390552 bytes :   21.5 MB/s
> 
> And perf on memcached showed,
>    635,602,955,852      cycles                                                        (30.07%)
>    479,554,401,177      instructions              #    0.75  insn per cycle           (40.02%)
>     12,585,059,799      L1-dcache-load-misses     #    9.31% of all L1-dcache hits    (50.07%)
>    135,140,424,785      L1-dcache-loads                                               (49.96%)
>     76,849,156,759      L1-dcache-stores                                              (50.02%)
>     45,700,267,543      L1-icache-load-misses                                         (49.97%)
>        495,149,862      LLC-load-misses           #   24.96% of all LL-cache hits     (39.95%)
>      1,984,134,589      LLC-loads                                                     (39.97%)
>        327,130,920      LLC-store-misses                                              (20.06%)
>      1,397,111,117      LLC-stores                                                    (20.06%)
> 
> 
> When bind memcached to 0-3 with cpuset,
> ========================================
> mutilate showed,
> #type       avg     std     min     5th    10th    90th    95th    99th
> read      934.7  3669.3    41.1   112.8   129.5   385.3  3321.9 21923.7
> update      0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0
> op_q        1.0     0.0     1.0     1.0     1.0     1.1     1.1     1.1
> 
> Total QPS = 852885.6 (51173140 / 60.0s)
> 
> Misses = 0 (0.0%)
> Skipped TXs = 0 (0.0%)
> 
> RX 12642165580 bytes :  200.9 MB/s
> TX 1842259932 bytes :   29.3 MB/s
> 
> And perf on memcached showed,
> 
>    621,311,916,151      cycles                                                        (30.01%)
>    599,835,965,997      instructions              #    0.97  insn per cycle           (40.02%)
>     12,585,889,988      L1-dcache-load-misses     #    7.59% of all L1-dcache hits    (50.00%)
>    165,750,518,361      L1-dcache-loads                                               (50.01%)
>     93,588,611,989      L1-dcache-stores                                              (50.00%)
>     44,445,213,037      L1-icache-load-misses                                         (50.01%)
>        568,410,466      LLC-load-misses           #   26.91% of all LL-cache hits     (40.03%)
>      2,112,218,392      LLC-loads                                                     (40.00%)
>        261,202,604      LLC-store-misses                                              (19.97%)
>      1,484,886,714      LLC-stores 
> 
> 
> We can see the IPC raised from 0.75 to 0.97, this should be the reason of the performance boost.
> What does cause the IPC boost ?
> 
> Thanks a million for any help
> Jianchao
> 
