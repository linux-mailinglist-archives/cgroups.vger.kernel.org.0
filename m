Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFE19935C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgCaK1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 06:27:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39993 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgCaK1q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 06:27:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so1948472wmf.5
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2020 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O4fIR3uoc5tVQMLd54nQw5z05MiLWlZQFph3hoh5hlM=;
        b=BNREeNvNYwgfnw6nTJqmTLlP6Ea59Qm5Qn9DlWzIViFO3TYt8sSdmxxdNLK1HWoYhr
         EEVgwsusv7KukwJhgMKIXZfFxJYtQO3HNis6RMwQx5eaUw24hmzKLlSi5i340BJIvyUw
         3UO6IGaAHT9Wthrglu4j6CEdAPPSSY3E/4aIGksvtJAwRjWuZxmDfMI5XcjYMsFhlGBG
         U3K4rtw1sC7/dokiyiCS22py0flzcgUHorFO8UoxUKRbEBSkajxJWP4kV4EqxZxmiqjb
         uxhGvDruvvKjg5dixW/8hWDYchtK+krYB9BkZSOyRmpjIazTKIyehYAarmvrj3XVJf2+
         mw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O4fIR3uoc5tVQMLd54nQw5z05MiLWlZQFph3hoh5hlM=;
        b=gYu0ny06QIEcd2bJw5OQcLBGwu5xwvh3qv0wULwWIxTVP1ec9V5V+t9xZw4FEG5wey
         Ht2zH07rWhXZPxHSLA1b3U++i7KaSle3F2jHT2EUgnM1dblm/HDXGmrOIio8wiUtauyH
         0Vv//oSGsSIliUOG+UsJ7lrY6EoZ2+pwnf8R1kSrc4KDca7QuH1nlxmqLiBG/GLhdPjb
         s3elUEikB2GQBfh342r1c0qv0DnQ4FLLM4oUQBcSGijMA7JY+4WVz9xRIFcVwbO/70YS
         4sAM6OQeUK/DrLznwW1B210hA1icO/E7teMGlqllGYtDNXevSldTJrQwzi/bpDM7ZQlL
         xqgQ==
X-Gm-Message-State: ANhLgQ1oHVwbB3Lbg4h3SZGnhCU6IQWboAEx4wiuOkSWyI483SNmFJSJ
        /bk7rV8zNmr46mDgd4Q4xGXHkg==
X-Google-Smtp-Source: ADFU+vuT8ZO2RI6CGCdp6V7ksxQiTdvtGPwc5+AD46tpl705hKR8Q0bVvOvO3nAs4slrRNYfPEPmPA==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr2599467wmi.112.1585650463503;
        Tue, 31 Mar 2020 03:27:43 -0700 (PDT)
Received: from [192.168.0.102] ([84.33.138.35])
        by smtp.gmail.com with ESMTPSA id k204sm3405860wma.17.2020.03.31.03.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 03:27:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
Date:   Tue, 31 Mar 2020 12:29:05 +0200
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CD57B83-F067-4918-878C-BAC413C6A2B3@linaro.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 31 mar 2020, alle ore 08:17, Weiping Zhang =
<zwp10758@gmail.com> ha scritto:
>=20
>>> On the driver implementation, the number of module parameters being
>>> added here is problematic. We already have 2 special classes of =
queues,
>>> and defining this at the module level is considered too coarse when
>>> the system has different devices on opposite ends of the capability
>>> spectrum. For example, users want polled queues for the fast =
devices,
>>> and none for the slower tier. We just don't have a good mechanism to
>>> define per-controller resources, and more queue classes will make =
this
>>> problem worse.
>>>=20
>> We can add a new "string" module parameter, which contains a model =
number,
>> in most cases, the save product with a common prefix model number, so
>> in this way
>> nvme can distinguish the different performance devices(hign or low =
end).
>> Before create io queue, nvme driver can get the device's Model =
number(40 Bytes),
>> then nvme driver can compare device's model number with module =
parameter, to
>> decide how many io queues for each disk;
>>=20
>> /* if model_number is MODEL_ANY, these parameters will be applied to
>> all nvme devices. */
>> char dev_io_queues[1024] =3D "model_number=3DMODEL_ANY,
>> poll=3D0,read=3D0,wrr_low=3D0,wrr_medium=3D0,wrr_high=3D0,wrr_urgent=3D=
0";
>> /* these paramters only affect nvme disk whose model number is "XXX" =
*/
>> char dev_io_queues[1024] =3D "model_number=3DXXX,
>> poll=3D1,read=3D2,wrr_low=3D3,wrr_medium=3D4,wrr_high=3D5,wrr_urgent=3D=
0;";
>>=20
>> struct dev_io_queues {
>>        char model_number[40];
>>        unsigned int poll;
>>        unsgined int read;
>>        unsigned int wrr_low;
>>        unsigned int wrr_medium;
>>        unsigned int wrr_high;
>>        unsigned int wrr_urgent;
>> };
>>=20
>> We can use these two variable to store io queue configurations:
>>=20
>> /* default values for the all disk, except whose model number is not
>> in io_queues_cfg */
>> struct dev_io_queues io_queues_def =3D {};
>>=20
>> /* user defined values for a specific model number */
>> struct dev_io_queues io_queues_cfg =3D {};
>>=20
>> If we need multiple configurations( > 2), we can also extend
>> dev_io_queues to support it.
>>=20
>=20
> Hi Maintainers,
>=20
> If we add patch to support these queue count at controller level,
> instead moudle level,
> shall we add WRR ?
>=20
> Recently I do some cgroup io weight testing,
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
> I think a proper io weight policy
> should consider high weight cgroup's iops, latency and also take whole
> disk's throughput
> into account, that is to say, the policy should do more carfully trade
> off between cgroup's
> IO performance and whole disk's throughput. I know one policy cannot
> do all things perfectly,
> but from the test result nvme-wrr can work well.
>=20
> =46rom the following test result, nvme-wrr work well for both cgroup's
> latency, iops, and whole
> disk's throughput.
>=20
> Notes:
> blk-iocost: only set qos.model, not set percentage latency.
> nvme-wrr: set weight by:
>    h=3D64;m=3D32;l=3D8;ab=3D0; nvme set-feature /dev/nvme1n1 -f 1 -v =
$(printf
> "0x%x\n" $(($ab<<0|$l<<8|$m<<16|$h<<24)))
>    echo "$major:$minor high" > /sys/fs/cgroup/test1/io.wrr
>    echo "$major:$minor low" > /sys/fs/cgroup/test2/io.wrr
>=20
>=20
> Randread vs Randread:
> cgroup.test1.weight : cgroup.test2.weight =3D 8 : 1
> high weight cgroup test1: randread, fio: numjobs=3D8, iodepth=3D32, =
bs=3D4K
> low  weight cgroup test2: randread, fio: numjobs=3D8, iodepth=3D32, =
bs=3D4K
>=20
> test case         bw         iops       rd_avg_lat   wr_avg_lat
> rd_p99_lat   wr_p99_lat
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> bfq_test1         767226     191806     1333.30      0.00
> 536.00       0.00
> bfq_test2         94607      23651      10816.06     0.00
> 610.00       0.00
> iocost_test1      1457718    364429     701.76       0.00
> 1630.00      0.00
> iocost_test2      1466337    366584     697.62       0.00
> 1613.00      0.00
> none_test1        1456585    364146     702.22       0.00
> 1646.00      0.00
> none_test2        1463090    365772     699.12       0.00
> 1613.00      0.00
> wrr_test1         2635391    658847     387.94       0.00
> 1236.00      0.00
> wrr_test2         365428     91357      2801.00      0.00
> 5537.00      0.00
>=20
> =
https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#215-summary-f=
io-output
>=20
>=20

Glad to see that BFQ meets weights.  Sad to see how it is suffering in
terms of IOPS on your system.

Good job with your scheduler!

However, as for I/O control, the hard-to-control cases are not the
ones with constantly-full deep queues.  BFQ complexity stems from the
need to control also the tough cases.  An example is sync I/O with
I/O depth one against async I/O.  On the other hand, those use cases
may not be of interest for your scheduler.

Thanks,
Paolo

> Randread vs Seq Write:
> cgroup.test1.weight : cgroup.test2.weight =3D 8 : 1
> high weight cgroup test1: randread, fio: numjobs=3D8, iodepth=3D32, =
bs=3D4K
> low  weight cgroup test2: seq write, fio: numjobs=3D1, iodepth=3D32, =
bs=3D256K
>=20
> test case      bw         iops       rd_avg_lat   wr_avg_lat
> rd_p99_lat   wr_p99_lat
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> bfq_test1      814327     203581     1256.19      0.00         593.00  =
     0.00
> bfq_test2      104758     409        0.00         78196.32     0.00
>     1052770.00
> iocost_test1   270467     67616      3784.02      0.00         9371.00 =
     0.00
> iocost_test2   1541575    6021       0.00         5313.02      0.00
>     6848.00
> none_test1     271708     67927      3767.01      0.00         9502.00 =
     0.00
> none_test2     1541951    6023       0.00         5311.50      0.00
>     6848.00
> wrr_test1      775005     193751     1320.17      0.00         4112.00 =
     0.00
> wrr_test2      1198319    4680       0.00         6835.30      0.00
>     8847.00
>=20
>=20
> =
https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test#225-summary-f=
io-output
>=20
> Thanks
> Weiping

