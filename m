Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D86B3079
	for <lists+cgroups@lfdr.de>; Thu,  9 Mar 2023 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCIWXe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Mar 2023 17:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCIWXb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Mar 2023 17:23:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06981B543
        for <cgroups@vger.kernel.org>; Thu,  9 Mar 2023 14:23:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z11so2490174pfh.4
        for <cgroups@vger.kernel.org>; Thu, 09 Mar 2023 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678400607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cm9PSO1JyCkQzBopJoCsOr4/df3+glZZBwRsECQGzM=;
        b=Mmq+Azlu82kBhgwsaMc2f7h/soeBwXgtSdYsLGzqsYaknPUs5z+a+/MMKSZ4tNfFRV
         c2sfQE+adhJy4UwyltkiYBLXJCHh8lny1ntY0DS5edR9BCaLyL0fWJN+mrwZFtxkGdfy
         SrjUbfP7+OcmtNEipJX3HOI8mbzyoRYggj1FvhKtQFeV6vZI/r0kPSeN68/770pL/7nR
         y8V+6dZ7EPRmvZOdc8kFmjaQBhT/R11fS2H9bQPx1QffFGgWUh3TDSqwBQY1ImMuq8ao
         UShO3VYpYZoFYq1WSy9WEvo/IFqazFyRNDXYo+dhgzxrwQI9jrVXIo+AjJpG4jWLW3eB
         Dqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678400607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cm9PSO1JyCkQzBopJoCsOr4/df3+glZZBwRsECQGzM=;
        b=432mM4HATe2KfiTRHTEHOovKmz9EZEU11ktYe2A/7L11Yis8KGaKO6IyxwBJYqdt6d
         xAIPc+sWVbnjxKU5GL5NAJNbH78B4yYQFcXjxv2c1/ERSbvwa+zk+yWc8nQ1DZG9ylhf
         ZpvFr+9OX/hBlbLGS++hoBRcehY19+eCVzbezVV4h/KIhTEiZ93PWBlJZxuAfjhPus71
         wR49CdT76/TH4y8zknuNCoXQgDFNTR1NWxjXlN0a/PBYxeiALMakOOag5tcc6EptfGyJ
         mLzXTb/n4/jEmULKxGKv10ZIRIWs9RfLwzseQTQkFBxQfGF9dMsLtJ4vqnWxVkuGluAw
         fCxA==
X-Gm-Message-State: AO0yUKUnXvyLhLnpAGjXobzWC0jip1IxkK/UEI5PJEiMwIWeaRYDuf59
        IBMHEbhl7v99LmE74Cb1ELB5h/MJOCwepa45/jRsYA==
X-Google-Smtp-Source: AK7set+ut3cssxf2NRzMYdJgMnw0k7jnQVbkcPU4WuELZyqoXyN0HmOApAHWUxpQz5b4pY8U6hfXPKFqvjfd6SwNieQ=
X-Received: by 2002:a63:7349:0:b0:503:20b2:483c with SMTP id
 d9-20020a637349000000b0050320b2483cmr8074010pgn.2.1678400607091; Thu, 09 Mar
 2023 14:23:27 -0800 (PST)
MIME-Version: 1.0
References: <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com> <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com> <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain> <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain> <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain> <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
 <ZAmCzJQZl7j/m2oN@localhost.localdomain>
In-Reply-To: <ZAmCzJQZl7j/m2oN@localhost.localdomain>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 9 Mar 2023 14:23:15 -0800
Message-ID: <CA+khW7iAeTALH5b6upHXs1RotFBohVeZCcAp5H+r-=L05kqnww@mail.gmail.com>
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 8, 2023 at 10:55=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> On 08/03/23 10:01, Hao Luo wrote:
> > On Wed, Mar 8, 2023 at 2:20=E2=80=AFAM Juri Lelli <juri.lelli@redhat.co=
m> wrote:
> > >
> > > On 01/03/23 17:03, Qais Yousef wrote:
> > > > On 03/01/23 15:26, Juri Lelli wrote:
> > <...>
> > > > > BTW, do you have a repro script of some sort handy I might play w=
ith?
> > > >
> > > > Sorry no. You'll just need to suspend to ram. I had a simple patch =
to measure
> > > > the time around the call and trace_printk'ed the result.
> > > >
> > > > I was working on a android phone which just suspends to ram if you =
turn the
> > > > screen off and disconnect the usb.
> > >
> > > Looks like I could come up with the following
> > >
> > > https://github.com/jlelli/linux.git deadline/rework-cpusets
> > > https://github.com/jlelli/linux/tree/deadline/rework-cpusets
> > >
> > > which I don't think it's at a point that I feel comfortable to propos=
e
> > > as an RFC (not even sure if it actually makes sense), but it survived=
 my
> > > very light testing.
> > >
> > > Could you please take a look and, if it makes some sense in theory, g=
ive
> > > it a try on your end?
> > >
> >
> > Hi Juri,
> >
> > Thanks for coming up with the RFC. I can test your changes in the
> > server environment. I observed the same issue on my side and I can
> > reproduce.
> >
> > I sync'ed up with Qais offline earlier yesterday, and was preparing a
> > couple of patches that optimize the cpuset.cpus writes. Tracking dl
> > tasks in cpusets is one of them. But I am happy to take your patches
> > and do the testing. Note that I won't be able to test the dl part of
> > the patch, only the latency impact on rebuild_root_domains(), as we
> > don't have dl tasks in our system.
> >
> > The other patch is fixing cpuset_rwsem. I see you switched it back to
> > mutex. I did observe performance issues with cpuset_rwsem. Basically,
> > using percpu_rwsem generates very very long latency tails for writers,
> > but mutex doesn't. After some debugging, I found it was because
> > percpu_rwsem requires every writer to call a synchronize_rcu() for
> > acquiring the lock. So in my patches, I disabled the fastpath of
> > readers for cpuset_rwsem. This has been done before[1]. But mutex also
> > worked.
> >
> > Anyway, I'm happy to test your patches and ack once they are sent out.
>
> Do you strictly need a proper RFC or could you please test the above for
> now? If you could please do the latter, and if tests look ok, I could
> then put together proper changelogs etc. and propose an RFC (it would
> save me some time not to do that if the above doesn't work, apologies
> for not going the proper route from the start). Guess this question
> applies to Qais as well. Hummm, or maybe you are actually saying that
> you are indeed going to test them already, just wanted to make sure
> then. :)

Juri, I ported your patches to a 5.10 kernel, because my workload can
only run on 5.10. But unfortunately the kernel crashed at
cpuset_can_attach(). I'll put a few comments in your github branch.

Hao



Hao
