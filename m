Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3656A5CD0
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfIBTnb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 15:43:31 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:33113 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfIBTnb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 15:43:31 -0400
Received: by mail-wm1-f42.google.com with SMTP id r17so12657015wme.0
        for <cgroups@vger.kernel.org>; Mon, 02 Sep 2019 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sa03S6vEaays6dcwuYI8guBUuYko9RawE4hVY+9UpC8=;
        b=BebKuUrSweQBwv0My872r+2E+xquJKJLkKur8VeFveAtv5Kws3D8yRbfd6llwL7CD+
         vQ6mWe+fX/v0STRDq3y229V4cwZ+SfFd5SH7KRuRRI11maUdXjBJKUeNAOmIfTKz3P6f
         z/3SmnepCCNDB+HR2/PrxovHEDh5LNyfihh8jNjKyd3J78FO1mSLZ5lEmtZ0u6fRwpJO
         vHHThZy3detC2aU7/DQxGxjYIWSUUKDQ3fNXi6qAjt9L8OHURlgvzgF9BTBzYp/KSQ/4
         2m1xKUrsW0eW5atL9/YuiIozolpsv3irV1igpRFbJptV63CD2SXYDYRTmpK8HAB/5fSl
         FwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sa03S6vEaays6dcwuYI8guBUuYko9RawE4hVY+9UpC8=;
        b=k/3AVzmFPRjYVwala5uzBO0ipLGgiJJQ1knj38BEN5XInku2shwaTdmW7F+sCmEEA1
         EqQg1sbhz3PyOnHSd5Gd6J5vqeznY1fnd3vDkTJJPd5prhoyys1u2WWrXYMeKwqHj4qA
         QSV/5J6gaZMUxmAyEnx5waMMcI2V5IN3aEuAMhawFvH+B/hIzQG3xQR8nw565XkZJQYp
         v3Dn8jL5I8EjW8dUnocLpKFVaASwSvm9/G7fydpjpSEmA9yjVixADK80z3teTHe57z4T
         LLS0xBa6l4FcMfgG+G3fM4fRC3YtpK62XRJ/MZmHmy70mazJJVVjnWGQdF5DI/6AOXN1
         xg0w==
X-Gm-Message-State: APjAAAX46RgDP89FDFxhgSoaqwnOrvh7GWcYqkEjToCef6aa0+zGvxYM
        GGA/fpAZYlia7N0BYU0dLohGbg==
X-Google-Smtp-Source: APXvYqyudjJGOzIp0Q7gzh3z6YJmCayZ4onrFg/fn97YusYXGCgpQdPA9pNGV6h1MiuJXj0WAPgr7w==
X-Received: by 2002:a1c:a617:: with SMTP id p23mr18296789wme.166.1567453408094;
        Mon, 02 Sep 2019 12:43:28 -0700 (PDT)
Received: from [192.168.0.101] (88-147-40-76.dyn.eolo.it. [88.147.40.76])
        by smtp.gmail.com with ESMTPSA id v186sm36076972wmb.5.2019.09.02.12.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 12:43:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
Date:   Mon, 2 Sep 2019 21:43:25 +0200
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
Message-Id: <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
 <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 2 set 2019, alle ore 17:56, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Mon, Sep 02, 2019 at 05:45:50PM +0200, Paolo Valente wrote:
>> Thanks for this extra explanations.  It is a little bit difficult for
>> me to understand how the min/max teaks for exactly, but you did give
>> me the general idea.
>=20
> It just limits how far high and low the IO issue rate, measured in
> cost, can go.  ie. if max is at 200%, the controller won't issue more
> than twice of what the cost model says 100% is.
>=20
>> Are these results in line with your expectations?  If they are, then
>> I'd like to extend benchmarks to more mixes of workloads.  Or should =
I
>> try some other QoS configuration first?
>=20
> They aren't.  Can you please include the content of io.cost.qos and
> io.cost.model before each run?  Note that partial writes to subset of
> parameters don't clear other parameters.
>=20

Yep.  I've added the printing of the two parameters in the script, and
I'm pasting the whole output, in case you could get also some other
useful piece of information from it.

$ sudo ./bandwidth-latency.sh -t randread -s none -b weight -n 7 -d 20
Switching to none for sda
echo "8:0 enable=3D1 rpct=3D95 rlat=3D2500 wpct=3D95 wlat=3D5000" > =
/cgroup/io.cost.qos
/cgroup/io.cost.qos 8:0 enable=3D1 ctrl=3Duser rpct=3D95.00 rlat=3D2500 =
wpct=3D95.00 wlat=3D5000 min=3D1.00 max=3D10000.00
/cgroup/io.cost.model 8:0 ctrl=3Dauto model=3Dlinear rbps=3D488636629 =
rseqiops=3D8932 rrandiops=3D8518 wbps=3D427891549 wseqiops=3D28755 =
wrandiops=3D21940
Not changing weight/limits for interferer group 0
Not changing weight/limits for interferer group 1
Not changing weight/limits for interferer group 2
Not changing weight/limits for interferer group 3
Not changing weight/limits for interferer group 4
Not changing weight/limits for interferer group 5
Not changing weight/limits for interferer group 6
Not changing weight/limits for interfered
Starting Interferer group 0
start_fio_jobs InterfererGroup0 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile0
Starting Interferer group 1
start_fio_jobs InterfererGroup1 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile1
Starting Interferer group 2
start_fio_jobs InterfererGroup2 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile2
Starting Interferer group 3
start_fio_jobs InterfererGroup3 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile3
Starting Interferer group 4
start_fio_jobs InterfererGroup4 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile4
Starting Interferer group 5
start_fio_jobs InterfererGroup5 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile5
Starting Interferer group 6
start_fio_jobs InterfererGroup6 0 default read MAX linear 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile6
Linux 5.3.0-rc6+ (paolo-ThinkPad-W520) 	02/09/2019 	_x86_64_	=
(8 CPU)

02/09/2019 21:39:11
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda              66.53         5.22         0.10       1385         27

start_fio_jobs interfered 20 default randread MAX poisson 1 1 0 0 4k =
/home/paolo/local-S/bandwidth-latency/../workfiles/largefile_interfered0
02/09/2019 21:39:14
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda             154.67        20.63         0.05         61          0

02/09/2019 21:39:17
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda             453.00        64.27         0.00        192          0

02/09/2019 21:39:20
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda             675.33        95.99         0.00        287          0

02/09/2019 21:39:23
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            1907.67       348.61         0.00       1045          0

02/09/2019 21:39:26
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2414.67       462.98         0.00       1388          0

02/09/2019 21:39:29
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2429.67       438.71         0.00       1316          0

02/09/2019 21:39:32
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2437.00       475.79         0.00       1427          0

02/09/2019 21:39:35
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2162.33       346.97         0.00       1040          0

Results for one rand reader against 7 seq readers (I/O depth 1), =
weight-none with weights: (default, default)
Aggregated throughput:
         min         max         avg     std_dev     conf99%
       64.27      475.79     319.046     171.233     1011.97
Read throughput:
         min         max         avg     std_dev     conf99%
       64.27      475.79     319.046     171.233     1011.97
Write throughput:
         min         max         avg     std_dev     conf99%
           0           0           0           0           0
Interfered total throughput:
         min         max         avg     std_dev
       1.032       4.455       2.266    0.742696
Interfered per-request total latency:
         min         max         avg     std_dev
        0.11      12.005      1.7545    0.878281

Thanks,
Paolo


> Thanks.
>=20
> --=20
> tejun

