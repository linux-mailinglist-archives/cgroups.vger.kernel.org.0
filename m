Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA940F7C7
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbhIQMhE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 08:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbhIQMhE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 08:37:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93DC061574;
        Fri, 17 Sep 2021 05:35:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n18so9475748pgm.12;
        Fri, 17 Sep 2021 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FQwsk9IkT0pkz1OAyTjWRN8LUZCcAJQlWnRYcpAJ/2Q=;
        b=Sx/8TbZu6minR3UE7ZYVFXTcIGWZUEpJK6hYotKjO+I8XS7A1yMD49OlB/Q5HA9p0A
         OR7JhxxZ2tjLlQb7P3zdiTor4NgjpZlyNI9pZxJOFZ7W2Cty13tkZjRaqWq2DMn9fxyu
         MQ4oJ9s3SpkoHeFwYpQRjXqT7JLkp8iJertAQtRIbMDt6GJBxxNRWdZU6q08XGQ1cL1c
         PMSQn0n014I4xKq7RpqUKyNzdKJbHRxC9zoLK2C7rS0i+n+wVwMZOnydT7cqFpJryeZW
         VXf6DJO6WaJtMb7baT6Kd/hDxhK7CiMkwn0LhgO4IsQlIP1u6Lj2Cd6fCeZEyA6jWgHE
         u6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FQwsk9IkT0pkz1OAyTjWRN8LUZCcAJQlWnRYcpAJ/2Q=;
        b=kccfYsrK1K/x2+ZT00WudYilmE7k7qBBhNsgZ2PV5svtd2KvMzvyYUMRuh+GEjx2jW
         Y2jztNP7zNYSeITTNqZvXtywhyYWNGT+fCh7bO8DcIgiWOavKpFX2+AQI4jz7cyJJuoQ
         eJSJ5FgHLB2irQl3+zWaUckEz3UzTYKj89/4m5IQOJTHGLnkJdxG8isVdValzC5hCBze
         pvBg24v8GA/2+cgcqMwviiac74T4r+wPCIYKJjwbIxeqqXIbn4uAoChtHENYTJglkQ6d
         1EpyrbhVppd2z973P1ElazYWk7l5Ex/NFSfD/zffH7en9v9wSSVxjPHauCTFA58LLxqp
         65Rw==
X-Gm-Message-State: AOAM531L/gc5E4+ZX3UDcigmGhCRD3TP1owsuCya91zepVNwqa+Br/Hk
        oo4TMgyIIabkZvRgQi5l3a2svqrhoZM=
X-Google-Smtp-Source: ABdhPJxCH73iJYKo0T3q5XrhKiIVmn4fy25vZqxIlIajJWs0YHCtuUmv+z96HBvtqL0XuUuIjj+EWQ==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr9745652pga.230.1631882142005;
        Fri, 17 Sep 2021 05:35:42 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.86.159.245])
        by smtp.gmail.com with ESMTPSA id j6sm6293403pgq.0.2021.09.17.05.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:35:41 -0700 (PDT)
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: Memcached with cfs quota 400% performance boost after bind to 4 cpus
Message-ID: <9f907d99-1cdb-37db-49ae-8e31c7ea8fe7@gmail.com>
Date:   Fri, 17 Sep 2021 20:35:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi list

I have a test environment with following,
A memcached (memcached -d -m 50000 -u root -p 12301 -c 1000000 -t 16) in cpu cgroup with following config,
cpu.cfs_quota_us = 400000
cpu.cfs_period_us = 100000

And a mutilate loop (mutilate -s x.x.x.x:12301 -T 40 -c 20 -t 60 -W 5 -q 1000000) running on another host
w/o any cgroup config,

When bind memcached to  0-15 with cpuset, 
==========================================
mutilate showed,
#type       avg     std     min     5th    10th    90th    95th    99th
read     1275.8  6358.9    49.8   378.2   418.5   767.2   841.4 53998.5
update      0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0
op_q        1.0     0.0     1.0     1.0     1.0     1.1     1.1     1.1

Total QPS = 626566.2 (37594133 / 60.0s)

Misses = 0 (0.0%)
Skipped TXs = 0 (0.0%)

RX 9288150851 bytes :  147.6 MB/s
TX 1353390552 bytes :   21.5 MB/s

And perf on memcached showed,
   635,602,955,852      cycles                                                        (30.07%)
   479,554,401,177      instructions              #    0.75  insn per cycle           (40.02%)
    12,585,059,799      L1-dcache-load-misses     #    9.31% of all L1-dcache hits    (50.07%)
   135,140,424,785      L1-dcache-loads                                               (49.96%)
    76,849,156,759      L1-dcache-stores                                              (50.02%)
    45,700,267,543      L1-icache-load-misses                                         (49.97%)
       495,149,862      LLC-load-misses           #   24.96% of all LL-cache hits     (39.95%)
     1,984,134,589      LLC-loads                                                     (39.97%)
       327,130,920      LLC-store-misses                                              (20.06%)
     1,397,111,117      LLC-stores                                                    (20.06%)


When bind memcached to 0-3 with cpuset,
========================================
mutilate showed,
#type       avg     std     min     5th    10th    90th    95th    99th
read      934.7  3669.3    41.1   112.8   129.5   385.3  3321.9 21923.7
update      0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0
op_q        1.0     0.0     1.0     1.0     1.0     1.1     1.1     1.1

Total QPS = 852885.6 (51173140 / 60.0s)

Misses = 0 (0.0%)
Skipped TXs = 0 (0.0%)

RX 12642165580 bytes :  200.9 MB/s
TX 1842259932 bytes :   29.3 MB/s

And perf on memcached showed,

   621,311,916,151      cycles                                                        (30.01%)
   599,835,965,997      instructions              #    0.97  insn per cycle           (40.02%)
    12,585,889,988      L1-dcache-load-misses     #    7.59% of all L1-dcache hits    (50.00%)
   165,750,518,361      L1-dcache-loads                                               (50.01%)
    93,588,611,989      L1-dcache-stores                                              (50.00%)
    44,445,213,037      L1-icache-load-misses                                         (50.01%)
       568,410,466      LLC-load-misses           #   26.91% of all LL-cache hits     (40.03%)
     2,112,218,392      LLC-loads                                                     (40.00%)
       261,202,604      LLC-store-misses                                              (19.97%)
     1,484,886,714      LLC-stores 


We can see the IPC raised from 0.75 to 0.97, this should be the reason of the performance boost.
What does cause the IPC boost ?

Thanks a million for any help
Jianchao
