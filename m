Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D56B5FDA
	for <lists+cgroups@lfdr.de>; Sat, 11 Mar 2023 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCKSwA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Mar 2023 13:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCKSv5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 11 Mar 2023 13:51:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875F911CC
        for <cgroups@vger.kernel.org>; Sat, 11 Mar 2023 10:51:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso8319459wmb.0
        for <cgroups@vger.kernel.org>; Sat, 11 Mar 2023 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678560714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TpXwoEx5AlyR5GZdAmslzpMD8vQRifjw8ocaQpaF/4=;
        b=CW+OPwvwyfTxNY/pcQrP+cGAwnYEd5jEHqDHl2YlkltlMd4287g2yayTiVNq9JxDbC
         i1MUNa1WhPIuZLxy1lMoyWF4dAKpktLPOkJcnSlkJlW7ZjDsepnv6h316oNEoUNSa0ZE
         Xu1iE6B4txsHxHgTOHKTGHhPBmbEI5s/WepxUwnyXo99NPURvmmSReZZpuZWhOnQPDLq
         a8v/cvpgeADqoOAj/fsRZMl2P3sijEAKAUvZbvdxLEAVo4oKSYqwagYl53+A79SjrMRs
         v0tKjSe4V04Gs8umC8RTjW9kzzGugmKbluFKLutxh9+GjklJTl6wIScs2qL5QpNEYReN
         990g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678560714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TpXwoEx5AlyR5GZdAmslzpMD8vQRifjw8ocaQpaF/4=;
        b=gKjWCJZg0erJTnmPKleaSHS1CaNaIg66RPebfnNPnZyCxyq6RkGc/oYI//n1SAuv1m
         O+XHTTT8jXUBWCIe3DyJoiBtzyvHZcLQ4S7eXQPB96T9RRlAh++XKPtypWLeTR2nWJEC
         irHkUslUDTqfXc8YPhWJ2GW2Aa6uQvGPO6Q5nqHnAK0i8F4JOuYLc+E2Y21qnHGuD8hO
         SZ6+VL8atwSqS9TEWnDjVVBi6PF93+PDeHhXDNYwpCtDbr/KOiGjNini84H5DJajAkfh
         4lvbN15dqbiXXdFpqFQoc3ILrPc1Cuue+dxNhyKFb/urDIQwoo1nvfd469Q+OeIWBLCv
         0HEQ==
X-Gm-Message-State: AO0yUKWDmT2MjL+ICI6WQAeDxtxVpbvYiYMQrGvv93X6hSJApjZkk70d
        egB3LILzbTxltUwuL9v2vAedKw==
X-Google-Smtp-Source: AK7set8yUMTGjoymhZewkcVaJZBW8GivSl5j31juA7t62MCP0KWDNLGxV9n2zf0BJZnRtTmcgxAi5Q==
X-Received: by 2002:a05:600c:511f:b0:3eb:3998:36fa with SMTP id o31-20020a05600c511f00b003eb399836famr6249077wms.29.1678560713763;
        Sat, 11 Mar 2023 10:51:53 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b002ce991d3b14sm2946839wri.52.2023.03.11.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:51:53 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:51:50 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Hao Luo <haoluo@google.com>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <20230311185150.stvtcbdkoofgn3wd@airbuntu>
References: <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
 <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
 <ZAmCzJQZl7j/m2oN@localhost.localdomain>
 <CA+khW7iAeTALH5b6upHXs1RotFBohVeZCcAp5H+r-=L05kqnww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+khW7iAeTALH5b6upHXs1RotFBohVeZCcAp5H+r-=L05kqnww@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/09/23 14:23, Hao Luo wrote:
> On Wed, Mar 8, 2023 at 10:55 PM Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > On 08/03/23 10:01, Hao Luo wrote:
> > > On Wed, Mar 8, 2023 at 2:20 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > > >
> > > > On 01/03/23 17:03, Qais Yousef wrote:
> > > > > On 03/01/23 15:26, Juri Lelli wrote:
> > > <...>
> > > > > > BTW, do you have a repro script of some sort handy I might play with?
> > > > >
> > > > > Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
> > > > > the time around the call and trace_printk'ed the result.
> > > > >
> > > > > I was working on a android phone which just suspends to ram if you turn the
> > > > > screen off and disconnect the usb.
> > > >
> > > > Looks like I could come up with the following
> > > >
> > > > https://github.com/jlelli/linux.git deadline/rework-cpusets
> > > > https://github.com/jlelli/linux/tree/deadline/rework-cpusets
> > > >
> > > > which I don't think it's at a point that I feel comfortable to propose
> > > > as an RFC (not even sure if it actually makes sense), but it survived my
> > > > very light testing.
> > > >
> > > > Could you please take a look and, if it makes some sense in theory, give
> > > > it a try on your end?
> > > >
> > >
> > > Hi Juri,
> > >
> > > Thanks for coming up with the RFC. I can test your changes in the
> > > server environment. I observed the same issue on my side and I can
> > > reproduce.
> > >
> > > I sync'ed up with Qais offline earlier yesterday, and was preparing a
> > > couple of patches that optimize the cpuset.cpus writes. Tracking dl
> > > tasks in cpusets is one of them. But I am happy to take your patches
> > > and do the testing. Note that I won't be able to test the dl part of
> > > the patch, only the latency impact on rebuild_root_domains(), as we
> > > don't have dl tasks in our system.
> > >
> > > The other patch is fixing cpuset_rwsem. I see you switched it back to
> > > mutex. I did observe performance issues with cpuset_rwsem. Basically,
> > > using percpu_rwsem generates very very long latency tails for writers,
> > > but mutex doesn't. After some debugging, I found it was because
> > > percpu_rwsem requires every writer to call a synchronize_rcu() for
> > > acquiring the lock. So in my patches, I disabled the fastpath of
> > > readers for cpuset_rwsem. This has been done before[1]. But mutex also
> > > worked.
> > >
> > > Anyway, I'm happy to test your patches and ack once they are sent out.
> >
> > Do you strictly need a proper RFC or could you please test the above for
> > now? If you could please do the latter, and if tests look ok, I could
> > then put together proper changelogs etc. and propose an RFC (it would
> > save me some time not to do that if the above doesn't work, apologies
> > for not going the proper route from the start). Guess this question
> > applies to Qais as well. Hummm, or maybe you are actually saying that
> > you are indeed going to test them already, just wanted to make sure
> > then. :)
> 
> Juri, I ported your patches to a 5.10 kernel, because my workload can
> only run on 5.10. But unfortunately the kernel crashed at
> cpuset_can_attach(). I'll put a few comments in your github branch.

Yeah I am working on 5.10 too (this will need to be backported to 5.10 and 5.15
ultimately) and had the same crash because task is NULL.

Fixed it this way which I think what you intended to do Juri? It moves the
check for dl_task(task) inside cgroup_taskset_for_each() loop.

	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
	index 83a8943467fb..06d6bb68d86b 100644
	--- a/kernel/cgroup/cpuset.c
	+++ b/kernel/cgroup/cpuset.c
	@@ -2495,11 +2495,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
			ret = security_task_setscheduler(task);
			if (ret)
				goto out_unlock;
	-       }
	 
	-       if (dl_task(task)) {
	-               cs->deadline_tasks++;
	-               cpuset_attach_old_cs->deadline_tasks--;
	+               if (dl_task(task)) {
	+                       cs->deadline_tasks++;
	+                       cpuset_attach_old_cs->deadline_tasks--;
	+               }
		}
	 
		/*

Like Hao I don't have any deadline tasks in the system. With the fix above
I don't notice the delay on suspend resume using your patches.

If you want any debug; please feel free to add them into your branch so I can
run with that and give you the log.


Thanks!

--
Qais Yousef
