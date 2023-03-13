Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2762A6B7DD1
	for <lists+cgroups@lfdr.de>; Mon, 13 Mar 2023 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCMQjb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Mar 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCMQjH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Mar 2023 12:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF011EB2
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678725487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78igvgOk38uDPKDzMiKif9HvbOkagL1dDGYolpUI3FE=;
        b=XL2TGEhzANpTqAQQx977FE4ClAJq95MxWhUoFDxKXLe0JNEYTIgFBqDmETfc3gHbt5RoYq
        292bFudNsu653XBb5kOkb6EOwk3Dcf7zcv0LaW5dCDy/y4dY+fzUauV2XB+xcTyDDy2dDz
        7vPQzL7tzOr+Kn7TaxQPDqFbKe0s+ns=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-VMKVRqPYMuqIXKMsei4AOg-1; Mon, 13 Mar 2023 12:38:05 -0400
X-MC-Unique: VMKVRqPYMuqIXKMsei4AOg-1
Received: by mail-qv1-f70.google.com with SMTP id d27-20020a0caa1b000000b00572765a687cso7297051qvb.19
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 09:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78igvgOk38uDPKDzMiKif9HvbOkagL1dDGYolpUI3FE=;
        b=xZheo1V8VyE96ZeLJeGy/92KGejMUI7qg4a5SAWusN/T8Ou7kvLMF3st76XjHll9s2
         VGwfFrSFtSFhMee4DWyxpQR/TVv8/+AZq0tQGcifFNW4rPeUQaqbYKqQuKzDU34g6J7u
         TVE0Eha+P15C/lWdvPVrpxuLAOKzG3sDbvOzbQBsvOhLqTLzOBxjdIW+6P+mVir5VYVU
         mmAGYrHKKUrFNXuWFFtqXxtZAAsW4hxnTpBa82y8I0SyVbw0NREtMfWEG4eeNTvGuw/I
         vGxE8lp0L4Um0KKdJY6eAxe4s9QcmsmpqWk0y4L+3/I7YyN1VmWGrV8Mcojo7AP81Uzg
         0VTQ==
X-Gm-Message-State: AO0yUKU3dtLMgj3oxTxP5tbExzarc/hl6fV+UkV6/oNgOATSZoV5S7ZV
        /xDMIQbkxL+Hl1TRJaWZXOtGrsO6j6T62LR1dIKrMGij3b7DvxngbmqonfgG1tlsXWYOwhz0goF
        oLSR56THeHRx/aLdNaA==
X-Received: by 2002:a05:622a:24a:b0:3bf:d00e:9908 with SMTP id c10-20020a05622a024a00b003bfd00e9908mr63989588qtx.44.1678725485152;
        Mon, 13 Mar 2023 09:38:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set9VJ2Dyt1o3ORTCoZCC+0TvSho4td2XplM1YX/gdaLeHFmXpjWvJXdAErLgTsskCJtyIRRl7g==
X-Received: by 2002:a05:622a:24a:b0:3bf:d00e:9908 with SMTP id c10-20020a05622a024a00b003bfd00e9908mr63989534qtx.44.1678725484782;
        Mon, 13 Mar 2023 09:38:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b003bfc0cca1b7sm131557qtp.49.2023.03.13.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:38:04 -0700 (PDT)
Date:   Mon, 13 Mar 2023 16:37:59 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Hao Luo <haoluo@google.com>,
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
Message-ID: <ZA9RZ3VvGXKp+1L6@localhost.localdomain>
References: <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
 <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
 <ZAmCzJQZl7j/m2oN@localhost.localdomain>
 <CA+khW7iAeTALH5b6upHXs1RotFBohVeZCcAp5H+r-=L05kqnww@mail.gmail.com>
 <20230311185150.stvtcbdkoofgn3wd@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311185150.stvtcbdkoofgn3wd@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/03/23 18:51, Qais Yousef wrote:
> On 03/09/23 14:23, Hao Luo wrote:
> > On Wed, Mar 8, 2023 at 10:55 PM Juri Lelli <juri.lelli@redhat.com> wrote:
> > >
> > > On 08/03/23 10:01, Hao Luo wrote:
> > > > On Wed, Mar 8, 2023 at 2:20 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > > > >
> > > > > On 01/03/23 17:03, Qais Yousef wrote:
> > > > > > On 03/01/23 15:26, Juri Lelli wrote:
> > > > <...>
> > > > > > > BTW, do you have a repro script of some sort handy I might play with?
> > > > > >
> > > > > > Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
> > > > > > the time around the call and trace_printk'ed the result.
> > > > > >
> > > > > > I was working on a android phone which just suspends to ram if you turn the
> > > > > > screen off and disconnect the usb.
> > > > >
> > > > > Looks like I could come up with the following
> > > > >
> > > > > https://github.com/jlelli/linux.git deadline/rework-cpusets
> > > > > https://github.com/jlelli/linux/tree/deadline/rework-cpusets
> > > > >
> > > > > which I don't think it's at a point that I feel comfortable to propose
> > > > > as an RFC (not even sure if it actually makes sense), but it survived my
> > > > > very light testing.
> > > > >
> > > > > Could you please take a look and, if it makes some sense in theory, give
> > > > > it a try on your end?
> > > > >
> > > >
> > > > Hi Juri,
> > > >
> > > > Thanks for coming up with the RFC. I can test your changes in the
> > > > server environment. I observed the same issue on my side and I can
> > > > reproduce.
> > > >
> > > > I sync'ed up with Qais offline earlier yesterday, and was preparing a
> > > > couple of patches that optimize the cpuset.cpus writes. Tracking dl
> > > > tasks in cpusets is one of them. But I am happy to take your patches
> > > > and do the testing. Note that I won't be able to test the dl part of
> > > > the patch, only the latency impact on rebuild_root_domains(), as we
> > > > don't have dl tasks in our system.
> > > >
> > > > The other patch is fixing cpuset_rwsem. I see you switched it back to
> > > > mutex. I did observe performance issues with cpuset_rwsem. Basically,
> > > > using percpu_rwsem generates very very long latency tails for writers,
> > > > but mutex doesn't. After some debugging, I found it was because
> > > > percpu_rwsem requires every writer to call a synchronize_rcu() for
> > > > acquiring the lock. So in my patches, I disabled the fastpath of
> > > > readers for cpuset_rwsem. This has been done before[1]. But mutex also
> > > > worked.
> > > >
> > > > Anyway, I'm happy to test your patches and ack once they are sent out.
> > >
> > > Do you strictly need a proper RFC or could you please test the above for
> > > now? If you could please do the latter, and if tests look ok, I could
> > > then put together proper changelogs etc. and propose an RFC (it would
> > > save me some time not to do that if the above doesn't work, apologies
> > > for not going the proper route from the start). Guess this question
> > > applies to Qais as well. Hummm, or maybe you are actually saying that
> > > you are indeed going to test them already, just wanted to make sure
> > > then. :)
> > 
> > Juri, I ported your patches to a 5.10 kernel, because my workload can
> > only run on 5.10. But unfortunately the kernel crashed at
> > cpuset_can_attach(). I'll put a few comments in your github branch.
> 
> Yeah I am working on 5.10 too (this will need to be backported to 5.10 and 5.15
> ultimately) and had the same crash because task is NULL.
> 
> Fixed it this way which I think what you intended to do Juri? It moves the
> check for dl_task(task) inside cgroup_taskset_for_each() loop.
> 
> 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> 	index 83a8943467fb..06d6bb68d86b 100644
> 	--- a/kernel/cgroup/cpuset.c
> 	+++ b/kernel/cgroup/cpuset.c
> 	@@ -2495,11 +2495,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> 			ret = security_task_setscheduler(task);
> 			if (ret)
> 				goto out_unlock;
> 	-       }
> 	 
> 	-       if (dl_task(task)) {
> 	-               cs->deadline_tasks++;
> 	-               cpuset_attach_old_cs->deadline_tasks--;
> 	+               if (dl_task(task)) {
> 	+                       cs->deadline_tasks++;
> 	+                       cpuset_attach_old_cs->deadline_tasks--;
> 	+               }
> 		}
> 	 
> 		/*

Duh, indeed.

> Like Hao I don't have any deadline tasks in the system. With the fix above
> I don't notice the delay on suspend resume using your patches.

OK, cool.

> If you want any debug; please feel free to add them into your branch so I can
> run with that and give you the log.

Will need to find time to run some tests with DEADLINE tasks, yeah.
Maybe Dietmar, since you reported as well the issue above with your
testing, you could help with testing DEADLINE?

Thanks,
Juri

