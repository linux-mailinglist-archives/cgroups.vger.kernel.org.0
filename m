Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82881A5AB9
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfIBPp5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 11:45:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIBPp5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 11:45:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so14530936wrn.1
        for <cgroups@vger.kernel.org>; Mon, 02 Sep 2019 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ak7gQgF0UHrkUynnsioDr3mzYUdWJD0ctnoqh3gfIQ=;
        b=hIm1KQYXQeqt/GfD9plstc4ikvKMX8f3NBW2yjHLA7OSSc7kHltkucWob8iIA1RbsK
         YT0V1iewk0zqDpmPBsgm3Ql8jQHO7qLQp3XV3laMGpjqe0dNxRL+qs8YaljXjbOPW2cr
         71xCRtcPgXUvHYHVZOzoC2esg8B3jBwzB3QUUuDIB/ZBSEuSwbXzp5g5Hcf+jkJ79Ul6
         UP1U0wvSF4EAd60NAO5NhMtuPspuJ+htcKVaGfyP/N+A0aV92/L0/jBojama1jyQf+TM
         x64WMCFyjRQjqpeAQBOYxHtwMlSsfR15yVl62ldcwlblNbYy5+RKQtEs6OoSl3xS7mpm
         n/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ak7gQgF0UHrkUynnsioDr3mzYUdWJD0ctnoqh3gfIQ=;
        b=g4x4TRnIO8CTmT2EiMxzJBHHzGorEj4yxNYauxckndcvig4NwF+2g0AIgi0iFsrdd9
         Okc4CL3FdGKT7fIAp19YLSzRcO/vEsTlIK0UiS5fv21/RNm5iEjgxLAtA2K0rnlGe3iO
         Ws9fe7LLSrwbUuv9gQHokvgrJEgL+raB957hNWAauzaXrwz9nOclJwWdHNpTawb/gm0/
         rRKN8UmqiOPv2xG65LrB/+6s6Do0cd4hpGag5jLUedPcAD6BQJz7haymHrdXO7ItRjBf
         6dePA6MGMAT9vKH7Xu/HJhJFJ1D8phRl43zQpVDmQKbDz4AwqFQViQWutCGd0R5ocARF
         s9rQ==
X-Gm-Message-State: APjAAAX8/ukDMVbueXLm3EG6PQmlmro7kmVnC0eKvIgryNpGahuXNHiv
        SAGsVuw380FGGGkdfok0P2Mgrw==
X-Google-Smtp-Source: APXvYqxqYj9JiHMwLcSEZKTM69zOLXi0nObWKeOAkfwoI5lJlLYxEmRsEo7Dxd+4T0By69FBQrNDvg==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr37364536wrj.168.1567439153879;
        Mon, 02 Sep 2019 08:45:53 -0700 (PDT)
Received: from [192.168.0.101] (88-147-40-76.dyn.eolo.it. [88.147.40.76])
        by smtp.gmail.com with ESMTPSA id r65sm27843639wmr.9.2019.09.02.08.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 08:45:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
Date:   Mon, 2 Sep 2019 17:45:50 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 31 ago 2019, alle ore 08:53, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20

Hi Tejun,

> On Thu, Aug 22, 2019 at 10:58:22AM +0200, Paolo Valente wrote:
>> Ok, I tried with the parameters reported for a SATA SSD:
>>=20
>> rpct=3D95.00 rlat=3D10000 wpct=3D95.00 wlat=3D20000 min=3D50.00 =
max=3D400.00
>=20
> Sorry, I should have explained it with a lot more details.
>=20
> There are two things - the cost model and qos params.  The default SSD
> cost model parameters are derived by averaging a number of mainstream
> SSD parameters.  As a ballpark, this can be good enough because while
> the overall performance varied quite a bit from one ssd to another,
> the relative cost of different types of IOs wasn't drastically
> different.
>=20
> However, this means that the performance baseline can easily be way
> off from 100% depending on the specific device in use.  In the above,
> you're specifying min/max which limits how far the controller is
> allowed to adjust the overall cost estimation.  50% and 400% are
> numbers which may make sense if the cost model parameter is expected
> to fall somewhere around 100% - ie. if the parameters are for that
> specific device.
>=20
> In your script, you're using default model params but limiting vrate
> range.  It's likely that your device is significantly slower than what
> the default parameters are expecting.  However, because min vrate is
> limited to 50%, it doesn't throttle below 50% of the estimated cost,
> so if the device is significantly slower than that, nothing gets
> controlled.
>=20

Thanks for this extra explanations.  It is a little bit difficult for
me to understand how the min/max teaks for exactly, but you did give
me the general idea.

>> and with a simpler configuration [1]: one target doing random reads
>=20
> And without QoS latency targets, the controller is purely going by
> queue depth depletion which works fine for many usual workloads such
> as larger reads and writes but isn't likely to serve low-concurrency
> latency-sensitive IOs well.
>=20
>> and only four interferers doing sequential reads, with all the
>> processes (groups) having the same weight.
>>=20
>> But there seemed to be little or no control on I/O, because the =
target
>> got only 1.84 MB/s, against 1.15 MB/s without any control.
>>=20
>> So I tried with rlat=3D1000 and rlat=3D100.
>=20
> And this won't do anything as all rlat/wlat does is regulating how the
> overall vrate should be adjusted and it's being min'd at 50%.
>=20
>> Control did improve, with same results for both values of rlat.  The
>> problem is that these results still seem rather bad, both in terms of
>> throughput guaranteed to the target and in terms of total throughput.
>> Here are results compared with BFQ (throughputs measured in MB/s):
>>=20
>>                           io.weight            BFQ
>> target's throughput        3.415                6.224       =20
>> total throughput           159.14               321.375
>=20
> So, what should have been configured is something like
>=20
> $ echo '8:0 enable=3D1 rpct=3D95 rlat=3D10000 wpct=3D95 wlat=3D20000' =
> /sys/fs/cgroup/io.cost.qos
>=20

Unfortunately, io.cost does not seem to control I/O with this
configuration, as it gives the interfered the same bw as no I/O
control (i.e., none as I/O scheduler and no I/O controller or policy
active):

                          none        io.weight            BFQ
target's throughput       0.8            0.7                 4
total throughput          506            506               344

The test case is still the rand reader against 7 seq readers.

> which just says "target 10ms p(95) read latency and 20ms p(95) write
> latency" without putting any restrictions on vrate range.
>=20
> With that, I got the following on Micron_1100_MTFDDAV256TBN which is a
> pretty old 256GB SATA drive.
>=20
>  Aggregated throughput:
> 	   min         max         avg     std_dev     conf99%
> 	266.73      275.71      271.38     4.05144     45.7635
>  Interfered total throughput:
> 	   min         max         avg     std_dev
> 	 9.608      13.008      10.941    0.664938
>=20
> During the run, iocost-monitor.py looked like the following.
>=20
>  sda RUN  per=3D40ms cur_per=3D2074.351:v1008.844 busy=3D +0 vrate=3D =
59.85% params=3Dssd_dfl(CQ)
> 			    active    weight      hweight% inflt% del_ms =
usages%
>  InterfererGroup0             *   100/  100  22.94/ 20.00   0.00  =
0*000 023:023:023
>  InterfererGroup1             *   100/  100  22.94/ 20.00   0.00  =
0*000 023:023:023
>  InterfererGroup2             *   100/  100  22.94/ 20.00   0.00  =
0*000 025:023:021
>  InterfererGroup3             *   100/  100  22.94/ 20.00   0.00  =
0*000 023:023:023
>  interfered                   *    36/  100   8.26/ 20.00   0.42  =
0*000 003:004:004
>=20
> Note that interfered is reported to only use 3-4% of the disk capacity
> while configured to consume 20%.  This is because with single
> concurrency 4k randread job, its ability to consume IO capacity is
> limited by the completion latency.
>=20
> 10ms is pretty generous (ie. more work-conserving) target for SSDs.
> Let's say we're willing to tighten it to trade off total work for
> tighter latency.
>=20
> $ echo '8:0 enable=3D1 rpct=3D95 rlat=3D2500 wpct=3D95 wlat=3D5000' > =
/sys/fs/cgroup/io.cost.qos
>=20

Now io.weight does control I/O, but throughputs fluctuate a lot
between runs and during each run.  After extending the duration of
each run to 20 seconds, an average run for io.weight and BFQ gives the
following throughputs (same throughputs as above for none):

                          none        io.weight            BFQ
target's throughput       0.8            2.3               3.6
total throughput          506            321               360

For completeness I tried also with rlat=3D1000.  But throughputs dropped
dramatically:

                          none        io.weight            BFQ
target's throughput       0.8            0.2               3.6
total throughput          506            17               360

Are these results in line with your expectations?  If they are, then
I'd like to extend benchmarks to more mixes of workloads.  Or should I
try some other QoS configuration first?

Thanks,
Paolo

>  Aggregated throughput:
> 	   min         max         avg     std_dev     conf99%
> 	147.06      172.18     154.608      11.783     133.096
>  Interfered total throughput:
> 	   min         max         avg     std_dev
> 	17.992       19.32      18.698    0.313105
>=20
> and the monitoring output
>=20
>  sda RUN  per=3D10ms cur_per=3D2927.152:v1556.138 busy=3D -2 vrate=3D =
34.74% params=3Dssd_dfl(CQ)
> 			    active    weight      hweight% inflt% del_ms =
usages%
>  InterfererGroup0             *   100/  100  20.00/ 20.00 386.11  =
0*000 070:020:020
>  InterfererGroup1             *   100/  100  20.00/ 20.00 386.11  =
0*000 070:020:020
>  InterfererGroup2             *   100/  100  20.00/ 20.00 386.11  =
0*000 070:020:020
>  InterfererGroup3             *   100/  100  20.00/ 20.00   0.00  =
0*000 020:020:020
>  interfered                   *   100/  100  20.00/ 20.00   1.21  =
0*000 010:014:017
>=20
> The followings happened.
>=20
> * The vrate is now hovering way lower.  The device is now doing less
>  total work to acheive tighter completion latencies.
>=20
> * The overall throughput dropped but interfered's utilization is now
>  significantly higher along with its bandwidth from lower completion
>  latencies.
>=20
> For reference:
>=20
> [Disabled]
>=20
>  Aggregated throughput:
> 	   min         max         avg     std_dev     conf99%
> 	493.98      511.37     502.808     9.52773     107.621
>  Interfered total throughput:
> 	   min         max         avg     std_dev
> 	 0.056       0.304       0.107   0.0691052
>=20
> [Enabled, no QoS config]
>=20
>  Aggregated throughput:
> 	   min         max         avg     std_dev     conf99%
> 	429.07      449.59     437.597     8.64952     97.7015
>  Interfered total throughput:
> 	   min         max         avg     std_dev
> 	 0.456        3.12        1.08    0.774318
>=20
> Thanks.
>=20
> --=20
> tejun

