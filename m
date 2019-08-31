Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D28A42EF
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2019 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHaGyE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 31 Aug 2019 02:54:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46888 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfHaGyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 31 Aug 2019 02:54:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id q7so150491qkn.13;
        Fri, 30 Aug 2019 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/2mwcPUTcbtLsuJfl9HdCLC71499RQ0gH2tE2WJO4Y=;
        b=WXQ1Wb9lgZHGuXMFm6qa1Qq+G2R95XN4q/7bxmPZr02Z6YyOqWuKHRWmwZZYInoKeI
         6hX5bwD6unf0QEKT72HA4OLkiPYWvXKAsKq+b+bVDFrwPWsq/YPXu5f756SEMS3AY9QS
         nVO8dLQa/HO4gLmsTcFYuxAb6kdcYxzpS5coRRIhiKztYU4NBI87PBWVxdGWzYiUV3u1
         rX3BUQdCoM8k262+FojhdjQH3qTOU6sUsk+mTg0dAK+SWDMOHzZvSuJQR5rtUfCEkrsN
         KBb9ZjZ6HRksjPqfyzUhPIe1OAf9NI/tCNE0bWr8BKoslHFjA3YoszFX+txXSrDjca3a
         +aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/2mwcPUTcbtLsuJfl9HdCLC71499RQ0gH2tE2WJO4Y=;
        b=GI3+5Nsx0YByNOhN1GZB39A3ziaWD/jPBEirJKTE6tPI4jITi2NQVIDiiXr/IuyVa6
         ofTvHJG8XbFcPt6HJPs1CSyb6GpDTXo8dkJJp29ppfqe+x7ARGvQaIUUIWRwq19Y4+yJ
         aRUUPRoy6ZhgfRYufLWC8NzdaOfmhyL+q6mtAzUssa8Iig0ZEkbQLSX9wIlpwih1NIfm
         N0nL9IoOfpN9QNDkB0qMda+/mt3A7jTgTyirxuLU8EIwV98YygqpWgs5mdwwSH02ufEU
         jKiYrYX4xd2h97/X2F74DsyFcstHjJF31O06U1nHpHht2qEPS/uEmkEdv/IzwuuFLGQc
         ECug==
X-Gm-Message-State: APjAAAWN1YlZpPcY7/bmRa0i+AcWL/yZRo4WObH+QqRsdWnbv1rt1J7t
        bfmsPOPe7Ts71zyNqTj8ekA=
X-Google-Smtp-Source: APXvYqw48p2/EXTIHioZWwHoXLdZE2DAGomJJaQjpRPwIu97f9MVwCJjNDn8lmGnUL1auWJs0w1M2A==
X-Received: by 2002:ae9:e413:: with SMTP id q19mr18929219qkc.227.1567234442714;
        Fri, 30 Aug 2019 23:54:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ca48])
        by smtp.gmail.com with ESMTPSA id e17sm4171096qkn.61.2019.08.30.23.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 23:54:01 -0700 (PDT)
Date:   Fri, 30 Aug 2019 23:53:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Paolo.

On Thu, Aug 22, 2019 at 10:58:22AM +0200, Paolo Valente wrote:
> Ok, I tried with the parameters reported for a SATA SSD:
> 
> rpct=95.00 rlat=10000 wpct=95.00 wlat=20000 min=50.00 max=400.00

Sorry, I should have explained it with a lot more details.

There are two things - the cost model and qos params.  The default SSD
cost model parameters are derived by averaging a number of mainstream
SSD parameters.  As a ballpark, this can be good enough because while
the overall performance varied quite a bit from one ssd to another,
the relative cost of different types of IOs wasn't drastically
different.

However, this means that the performance baseline can easily be way
off from 100% depending on the specific device in use.  In the above,
you're specifying min/max which limits how far the controller is
allowed to adjust the overall cost estimation.  50% and 400% are
numbers which may make sense if the cost model parameter is expected
to fall somewhere around 100% - ie. if the parameters are for that
specific device.

In your script, you're using default model params but limiting vrate
range.  It's likely that your device is significantly slower than what
the default parameters are expecting.  However, because min vrate is
limited to 50%, it doesn't throttle below 50% of the estimated cost,
so if the device is significantly slower than that, nothing gets
controlled.

> and with a simpler configuration [1]: one target doing random reads

And without QoS latency targets, the controller is purely going by
queue depth depletion which works fine for many usual workloads such
as larger reads and writes but isn't likely to serve low-concurrency
latency-sensitive IOs well.

> and only four interferers doing sequential reads, with all the
> processes (groups) having the same weight.
> 
> But there seemed to be little or no control on I/O, because the target
> got only 1.84 MB/s, against 1.15 MB/s without any control.
> 
> So I tried with rlat=1000 and rlat=100.

And this won't do anything as all rlat/wlat does is regulating how the
overall vrate should be adjusted and it's being min'd at 50%.

> Control did improve, with same results for both values of rlat.  The
> problem is that these results still seem rather bad, both in terms of
> throughput guaranteed to the target and in terms of total throughput.
> Here are results compared with BFQ (throughputs measured in MB/s):
> 
>                            io.weight            BFQ
> target's throughput        3.415                6.224        
> total throughput           159.14               321.375

So, what should have been configured is something like

$ echo '8:0 enable=1 rpct=95 rlat=10000 wpct=95 wlat=20000' > /sys/fs/cgroup/io.cost.qos

which just says "target 10ms p(95) read latency and 20ms p(95) write
latency" without putting any restrictions on vrate range.

With that, I got the following on Micron_1100_MTFDDAV256TBN which is a
pretty old 256GB SATA drive.

  Aggregated throughput:
	   min         max         avg     std_dev     conf99%
	266.73      275.71      271.38     4.05144     45.7635
  Interfered total throughput:
	   min         max         avg     std_dev
	 9.608      13.008      10.941    0.664938

During the run, iocost-monitor.py looked like the following.

  sda RUN  per=40ms cur_per=2074.351:v1008.844 busy= +0 vrate= 59.85% params=ssd_dfl(CQ)
			    active    weight      hweight% inflt% del_ms usages%
  InterfererGroup0             *   100/  100  22.94/ 20.00   0.00  0*000 023:023:023
  InterfererGroup1             *   100/  100  22.94/ 20.00   0.00  0*000 023:023:023
  InterfererGroup2             *   100/  100  22.94/ 20.00   0.00  0*000 025:023:021
  InterfererGroup3             *   100/  100  22.94/ 20.00   0.00  0*000 023:023:023
  interfered                   *    36/  100   8.26/ 20.00   0.42  0*000 003:004:004

Note that interfered is reported to only use 3-4% of the disk capacity
while configured to consume 20%.  This is because with single
concurrency 4k randread job, its ability to consume IO capacity is
limited by the completion latency.

10ms is pretty generous (ie. more work-conserving) target for SSDs.
Let's say we're willing to tighten it to trade off total work for
tighter latency.

$ echo '8:0 enable=1 rpct=95 rlat=2500 wpct=95 wlat=5000' > /sys/fs/cgroup/io.cost.qos

  Aggregated throughput:
	   min         max         avg     std_dev     conf99%
	147.06      172.18     154.608      11.783     133.096
  Interfered total throughput:
	   min         max         avg     std_dev
	17.992       19.32      18.698    0.313105

and the monitoring output

  sda RUN  per=10ms cur_per=2927.152:v1556.138 busy= -2 vrate= 34.74% params=ssd_dfl(CQ)
			    active    weight      hweight% inflt% del_ms usages%
  InterfererGroup0             *   100/  100  20.00/ 20.00 386.11  0*000 070:020:020
  InterfererGroup1             *   100/  100  20.00/ 20.00 386.11  0*000 070:020:020
  InterfererGroup2             *   100/  100  20.00/ 20.00 386.11  0*000 070:020:020
  InterfererGroup3             *   100/  100  20.00/ 20.00   0.00  0*000 020:020:020
  interfered                   *   100/  100  20.00/ 20.00   1.21  0*000 010:014:017

The followings happened.

* The vrate is now hovering way lower.  The device is now doing less
  total work to acheive tighter completion latencies.

* The overall throughput dropped but interfered's utilization is now
  significantly higher along with its bandwidth from lower completion
  latencies.

For reference:

[Disabled]

  Aggregated throughput:
	   min         max         avg     std_dev     conf99%
	493.98      511.37     502.808     9.52773     107.621
  Interfered total throughput:
	   min         max         avg     std_dev
	 0.056       0.304       0.107   0.0691052

[Enabled, no QoS config]

  Aggregated throughput:
	   min         max         avg     std_dev     conf99%
	429.07      449.59     437.597     8.64952     97.7015
  Interfered total throughput:
	   min         max         avg     std_dev
	 0.456        3.12        1.08    0.774318

Thanks.

-- 
tejun
