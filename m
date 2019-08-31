Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38156A42FD
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2019 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfHaHKb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 31 Aug 2019 03:10:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHaHKb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 31 Aug 2019 03:10:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so8974692wrq.9
        for <cgroups@vger.kernel.org>; Sat, 31 Aug 2019 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EeuIZUpqUqc/8WDxEHPupzvlc/p9S4zpotV6I9WmvkM=;
        b=LL4Qpp87Hv1Ygb7kMa7vN1g5ULpRxFtx2+9gTP4usv3GRB/H1j7DDsLMO7w0RKpHYK
         tyJ1vKX7cwFh31KtWfqY5hRkznLkJnVYB0gIoDXScRQufN6SgnC0kqbsX6DUsId1V1M8
         bYoSVak32CLagVCCc3V9tKDMWCiSd+cMk8+YAdkNRfuLUomSgC9cGosCEfV1mPHcLYHy
         eApVtx+3iV6SaFGwF1Lkmq82kmEjbTUNhTfbABwJpakwtU40ebMNs5XUnGl52Sz7VGdy
         zwrAebB4Et4nFQ3QQJyjQK9QMrWbVEjoooyPxSkp+iBiwoH3/+pyERyvIqoMT+1cGWvf
         ni7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EeuIZUpqUqc/8WDxEHPupzvlc/p9S4zpotV6I9WmvkM=;
        b=LUFETnRjQJ3QnxI+6dIkBaulUb/9zY4hsEBEgdFmTGw9U7LAgwBnUzZn279TD0lBpI
         doL4hzh8yyxVP32TKK70KL5dR9TTqU+cvKc8EoA4BIoHveraQ7EBbAJsQINQItW8kucG
         0WD3vE0qIe2BpNwuFjVYUBXdrYuhr9L2CciDhIKUj3mIy05uKTdNrWMMo5UK1+8e3Poj
         n91L07dFHE9S3sYPYCyjmqMjmebyDhI8lQXxfYvXT2vO76UwocKNzKIllrtXKorhfcA2
         3PaDy3FJrmvMi/O7xaK8t2Bde0pb07AWYXLxfkUrLNz72fq0Wj41UcIjSFRV3Qsx2Jr6
         redg==
X-Gm-Message-State: APjAAAU/OXW1y3r4qMAyo1YqXwNMPzL3GPnIW2HfJ2rLCY2rknuT5UXd
        X7WIXFoap26ThMHxCg4/EQd4rQ==
X-Google-Smtp-Source: APXvYqygtefxSoUD28URSJSyYZ9cDSXAHcnghASds+fbcYjGMmQ0ZS/XyZRzUu2m1NkIfT1/W/njGg==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr6109461wrv.316.1567235428344;
        Sat, 31 Aug 2019 00:10:28 -0700 (PDT)
Received: from [192.168.0.100] (84-33-66-69.dyn.eolo.it. [84.33.66.69])
        by smtp.gmail.com with ESMTPSA id s3sm5869910wmj.48.2019.08.31.00.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 00:10:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
Date:   Sat, 31 Aug 2019 09:10:26 +0200
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
Message-Id: <73CA9E04-DD93-47E4-B0FE-0A12EC991DEF@linaro.org>
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

Hi Tejun,
thank you very much for this extra information, I'll try the
configuration you suggest.  In this respect, is this still the branch
to use

=
https://kernel.googlesource.com/pub/scm/linux/kernel/git/tj/cgroup/+/refs/=
heads/review-iocost-v2

also after the issue spotted two days ago [1]?

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/8/29/910

> Il giorno 31 ago 2019, alle ore 08:53, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
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

