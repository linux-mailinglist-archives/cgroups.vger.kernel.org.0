Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1960C3D8
	for <lists+cgroups@lfdr.de>; Tue, 25 Oct 2022 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJYGey (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Oct 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJYGex (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Oct 2022 02:34:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23611CFDB
        for <cgroups@vger.kernel.org>; Mon, 24 Oct 2022 23:34:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so10082558ejn.3
        for <cgroups@vger.kernel.org>; Mon, 24 Oct 2022 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB6QUffw7MUyfYFBflqjkQA18+gYo2TkZv4lf52ehhI=;
        b=o6MxM0eQ5rIC1kkuN5yBdwj4wborrB0lJOkj0b8dk5ojPaN+PP8sjp8ic3I/voPTpR
         qW9s1fl24u4A2uBQqYiAI/f41m5gSkAknOYHt9MG7lWHRDiaKLTHp0hnLFeWIa/NiGmx
         8Wc40vyPfGO+6Sh6D5/HvvuVwBq4TRpcufXR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pB6QUffw7MUyfYFBflqjkQA18+gYo2TkZv4lf52ehhI=;
        b=a+OjWJhEkXAhfukZ8NNYFhPM22sTHst6SNPbL7GSOyI9nAjPzN7UVmIfRoWDsNQCly
         DqTS/CUUnqwdaz6Q8UzmazlAOe4W+odmvNdiu3dfGwBhpNqzodmEKS2vKc5QUkh33ppS
         l6mHPSCZnFH3CNRV2mdhtbKZvdMsb71DY0emrZlNMAKORiwMrYmeeNtsSi66AK8zopM7
         0gfuOg0fg+aAPM0wdyJ4l2QGwNz8Ke9mv6CkrL0Clgq9WGHxCKyJSDu55xChQ49cjBaw
         3SltlSOXhjtLLc+8c/6E4OGVww8+ZmIH3WJgXOGmxrYKH8VC3odGiJY+kMUvjm6/Ii0R
         0zXw==
X-Gm-Message-State: ACrzQf1dlv/GcbBy2FKNJsGfqKcnyRmY2IXTl1sxuvcdSNU4n3qyAcYK
        jn6iH0hMzLYxUIl8rouqaBsAbBqJtyio
X-Google-Smtp-Source: AMsMyM6Ij9KQKCQ1wwrXB5TGxmXGKgsVNJwmaWQ2MsL/YvW8nLFSPDFBoDXvnq7J2bC+UR06PB/Uwg==
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id wv13-20020a170907080d00b0073d1e3f3d83mr30145053ejb.372.1666679687290;
        Mon, 24 Oct 2022 23:34:47 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id e13-20020a1709067e0d00b00773f3cb67ffsm864965ejr.28.2022.10.24.23.34.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2022 23:34:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail
 occasion
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <82f1e969-742d-d3c3-63ca-961c755b5c35@huaweicloud.com>
Date:   Tue, 25 Oct 2022 08:34:44 +0200
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1E2F76F-2D27-4DCE-9B97-C8011CBE2A9E@unimore.it>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
 <011d479f-644f-0013-40bf-664b62f93bec@huaweicloud.com>
 <A9D22DB6-6481-46BA-9D4C-5A828D19CB61@linaro.org>
 <bcd07062-5a3b-563e-fb2d-2fa8e4c8bba5@huaweicloud.com>
 <82f1e969-742d-d3c3-63ca-961c755b5c35@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 18 ott 2022, alle ore 06:00, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> Hi, Paolo
>=20
> =E5=9C=A8 2022/10/11 17:36, Yu Kuai =E5=86=99=E9=81=93:
>>>>> Your patches seem ok to me now (thanks for you contribution and, =
above all, for your patience). I have only a high-level concern: what do =
you mean when you say that service guarantees are still preserved? What =
test did you run exactly? This point is very important to me. I'd like =
to see some convincing test with differentiated weights. In case you =
don't have other tools for executing such tests quickly, you may want to =
use the bandwidth-latency test in my simple S benchmark suite (for which =
I'm willing to help).
>>>>=20
>>>> Is there any test that you wish me to try?
>>>>=20
>>>> By the way, I think for the case that multiple groups are =
activaced, (
>>>> specifically num_groups_with_pendind_rqs > 1), io path in bfq is =
the
>>>> same with or without this patchset.
>> I just ran the test for one time, result is a liiter inconsistent, do
>> you think it's in the normal fluctuation range?
>=20
> I rerun the manually test for 5 times, here is the average result:
>=20
> without this patchset / with this patchset:
>=20
> | --------------- | ------------- | ------------ | -------------- | =
------------- | -------------- |
> | cg1 weight      | 10            | 20           | 30             | 40 =
         | 50             |
> | cg2 weight      | 90            | 80           | 70             | 60 =
         | 50             |
> | cg1 bw MiB/s    | 21.4 / 21.74  | 42.72 / 46.6 | 63.82 / 61.52  | =
94.74 / 90.92 | 140 / 138.2    |
> | cg2 bw MiB/s    | 197.2 / 197.4 | 182 / 181.2  | 171.2 / 173.44 | =
162 / 156.8   | 138.6 / 137.04 |
> | cg2 bw / cg1 bw | 9.22 / 9.08   | 4.26 / 3.89  | 2.68 / 2.82    | =
1.71 / 1.72   | 0.99 / 0.99    |

Great!  Results are (statistically) the same, with and without your
patchset.  For me your patches are ok.  Thank you very much for this
contribution, and sorry again for my delay.

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo

>=20
>> test script:
>> fio -filename=3D/dev/nullb0 -ioengine=3Dlibaio -ioscheduler=3Dbfq =
-jumjobs=3D1 -iodepth=3D64 -direct=3D1 -bs=3D4k -rw=3Drandread =
-runtime=3D60 -name=3Dtest
>> without this patchset:
>> |                 |      |      |      |      |      |
>> | --------------- | ---- | ---- | ---- | ---- | ---- |
>> | cg1 weight      | 10   | 20   | 30   | 40   | 50   |
>> | cg2 weight      | 90   | 80   | 70   | 60   | 50   |
>> | cg1 bw MiB/s    | 25.8 | 51.0 | 80.1 | 90.5 | 138  |
>> | cg2 bw MiB/s    | 193  | 179  | 162  | 127  | 136  |
>> | cg2 bw / cg1 bw | 7.48 | 3.51 | 2.02 | 1.40 | 0.98 |
>> with this patchset
>> |                 |      |      |      |      |      |
>> | --------------- | ---- | ---- | ---- | ---- | ---- |
>> | cg1 weight      | 10   | 20   | 30   | 40   | 50   |
>> | cg2 weight      | 90   | 80   | 70   | 60   | 50   |
>> | cg1 bw MiB/s    | 21.5 | 43.9 | 62.7 | 87.4 | 136  |
>> | cg2 bw MiB/s    | 195  | 185  | 173  | 138  | 141  |
>> | cg2 bw / cg1 bw | 9.07 | 4.21 | 2.75 | 1.57 | 0.96 |
>>>>=20
>>>=20
>>> The tests cases you mentioned are ok for me (whatever tool or =
personal
>>> code you use to run them).  Just show me your results with and =
without
>>> your patchset applied.
>>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>>> Thanks,
>>>> Kuai
>>>>> Thanks,
>>>>> Paolo
>>>>>> Previous versions:
>>>>>> RFC: =
https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/=20=

>>>>>> v1: =
https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/=20=

>>>>>> v2: =
https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/=20=

>>>>>> v3: =
https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
>>>>>> v4: =
https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/=20=

>>>>>> v5: =
https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/=20=

>>>>>> v6: =
https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/=20=

>>>>>> v7: =
https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/=20=

>>>>>>=20
>>>>>>=20
>>>>>> Yu Kuai (6):
>>>>>>   block, bfq: support to track if bfqq has pending requests
>>>>>>   block, bfq: record how many queues have pending requests
>>>>>>   block, bfq: refactor the counting of =
'num_groups_with_pending_reqs'
>>>>>>   block, bfq: do not idle if only one group is activated
>>>>>>   block, bfq: cleanup bfq_weights_tree add/remove apis
>>>>>>   block, bfq: cleanup __bfq_weights_tree_remove()
>>>>>>=20
>>>>>> block/bfq-cgroup.c  | 10 +++++++
>>>>>> block/bfq-iosched.c | 71 =
+++++++--------------------------------------
>>>>>> block/bfq-iosched.h | 30 +++++++++----------
>>>>>> block/bfq-wf2q.c    | 69 =
++++++++++++++++++++++++++-----------------
>>>>>> 4 files changed, 76 insertions(+), 104 deletions(-)
>>>>>>=20
>>>>>> --=20
>>>>>> 2.31.1
>>>>>>=20
>>>>> .
>>>=20
>>> .
>>>=20
>> .
>=20

