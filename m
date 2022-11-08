Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A0622022
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 00:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKHXKi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 18:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiKHXKb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 18:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C90205F7
        for <cgroups@vger.kernel.org>; Tue,  8 Nov 2022 15:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667948972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slTemHQCcB3hkLvb1RiLXsoYjitssgvv6xxcDrshU7o=;
        b=GLgqSWpz1nFxIdGWuxAS0oaUmv4afttlqnHIP+SKm724yeyQxiYjke5dGgGBOmo6HK/UkK
        CAHWzvH3upvxOQCRUsSiwQnB4hVQb/M6nEDrtBgvNei3dqgktTm6c+RrLqVrFeJ1DrtQy2
        gUDDnJeaCTVlNj4jTVdbgWzMf7ymQOU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-yu3dRZcVOtmhj9TmiIrG2w-1; Tue, 08 Nov 2022 18:09:31 -0500
X-MC-Unique: yu3dRZcVOtmhj9TmiIrG2w-1
Received: by mail-qk1-f199.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso14275558qkb.13
        for <cgroups@vger.kernel.org>; Tue, 08 Nov 2022 15:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slTemHQCcB3hkLvb1RiLXsoYjitssgvv6xxcDrshU7o=;
        b=4g6GrXy4Vzr43eyFev2PhNJYdxvnGsLhtLT7Pd4XHPnl5PQqJbbh1zr4c7nBPgX446
         VDsykNSkN5X1Qo4K8RleAfWJ2cTo23XZ4DsM90hG1TJCeQADtgvfU1dx+tgKoW7I1MuW
         E9QpW+hd0rOvoApnWwedqGxOTPWLR4wjZ61CkiBNYSm+GbJZiG+3AphyrYRsOIO7/4/K
         1LSbM9MOdaBPa02wg572VOt8TDN+2c+7v3NJn8hO1f05GxGqPeIMJmXmWEtCBPChi8Cv
         9N10EotmYoXuru32yqv5UgDPplLxmZIlRaZSF9arQtqaVtk/tGMvlzYGkJ+DjI+/9CGB
         8pvw==
X-Gm-Message-State: ACrzQf0Qnr7e8uYyWwxhTAtLoaeW66qAuQ3T6TcNu5xy5r/uA+/kIySF
        jzkc2xOKAiE7/ixYYIrkha8v5WsUmF7YgXr9ZcopGLJO5cxBtguf8EocyODnS0IFTuFY+E5/3St
        VXmOdkzVHyD7R7IPyTw==
X-Received: by 2002:a0c:cb0f:0:b0:4bb:6099:68c2 with SMTP id o15-20020a0ccb0f000000b004bb609968c2mr53287867qvk.131.1667948970682;
        Tue, 08 Nov 2022 15:09:30 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6ac0haSlPxTGVuFjAdem5E3oO8nZEIzcZh70nKeHtu80aFA0S1jxX9ip2s47AXxzFtbR4Y4Q==
X-Received: by 2002:a0c:cb0f:0:b0:4bb:6099:68c2 with SMTP id o15-20020a0ccb0f000000b004bb609968c2mr53287852qvk.131.1667948970386;
        Tue, 08 Nov 2022 15:09:30 -0800 (PST)
Received: from ?IPv6:2804:1b3:a802:4b05:8a1d:4f87:5d1a:2c54? ([2804:1b3:a802:4b05:8a1d:4f87:5d1a:2c54])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b006ec62032d3dsm10597420qkp.30.2022.11.08.15.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 15:09:29 -0800 (PST)
Message-ID: <4a4a6c73f3776d65f70f7ca92eb26fc90ed3d51a.camel@redhat.com>
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Date:   Tue, 08 Nov 2022 20:09:25 -0300
In-Reply-To: <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
         <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
         <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
         <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
         <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
         <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
         <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
         <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2022-11-07 at 09:10 +0100, Michal Hocko wrote:
> On Fri 04-11-22 22:45:58, Leonardo Br=C3=A1s wrote:
> > On Fri, 2022-11-04 at 09:41 +0100, Michal Hocko wrote:
> > > On Thu 03-11-22 13:53:41, Leonardo Br=C3=A1s wrote:
> > > > On Thu, 2022-11-03 at 16:31 +0100, Michal Hocko wrote:
> > > > > On Thu 03-11-22 11:59:20, Leonardo Br=C3=A1s wrote:
> > > [...]
> > > > > > I understand there will be a locking cost being paid in the iso=
lated CPUs when:
> > > > > > a) The isolated CPU is requesting the stock drain,
> > > > > > b) When the isolated CPUs do a syscall and end up using the pro=
tected structure
> > > > > > the first time after a remote drain.
> > > > >=20
> > > > > And anytime the charging path (consume_stock resp. refill_stock)
> > > > > contends with the remote draining which is out of control of the =
RT
> > > > > task. It is true that the RT kernel will turn that spin lock into=
 a
> > > > > sleeping RT lock and that could help with potential priority inve=
rsions
> > > > > but still quite costly thing I would expect.
> > > > >=20
> > > > > > Both (a) and (b) should happen during a syscall, and IIUC the a=
 rt workload
> > > > > > should not expect the syscalls to be have a predictable time, s=
o it should be
> > > > > > fine.
> > > > >=20
> > > > > Now I am not sure I understand. If you do not consider charging p=
ath to
> > > > > be RT sensitive then why is this needed in the first place? What =
else
> > > > > would be populating the pcp cache on the isolated cpu? IRQs?
> > > >=20
> > > > I am mostly trying to deal with drain_all_stock() calling schedule_=
work_on() at
> > > > isolated_cpus. Since the scheduled drain_local_stock() will be comp=
eting for cpu
> > > > time with the RT workload, we can have preemption of the RT workloa=
d, which is a
> > > > problem for meeting the deadlines.
> > >=20
> > > Yes, this is understood. But it is not really clear to me why would a=
ny
> > > draining be necessary for such an isolated CPU if no workload other t=
han
> > > the RT (which pressumably doesn't charge any memory?) is running on t=
hat
> > > CPU? Is that the RT task during the initialization phase that leaves
> > > that cache behind or something else?
> >=20
> > (I am new to this part of the code, so please correct me when I miss so=
mething.)
> >=20
> > IIUC,=C2=A0if a process belongs to a control group with memory control,=
 the 'charge'
> > will happen when a memory page starts getting used by it.
>=20
> Yes, very broadly speaking.
>=20
> > So, if we assume a RT load in a isolated CPU will not charge any memory=
, we are
> > assuming it will never be part of a memory-controlled cgroup.
>=20
> If the memory cgroup controler is enabled then each user space process
> is a part of some memcg. If there is no specific memcg assigned then it
> will be a root cgroup and that is skipped during most charges except for
> kmem.

Oh, it makes sense.=20
Thanks for helping me understand that!=20

>=20
> > I mean, can we just assume this?=20
> >=20
> > If I got that right, would not that be considered a limitation? like
> > "If you don't want your workload to be interrupted by perCPU cache drai=
ning,
> > don't put it in a cgroup with memory control".
>=20
> We definitely do not want userspace make any assumptions on internal
> implementation details like caches.

Perfect, that was my expectation.=20

>=20
> > > Sorry for being so focused on this
> > > but I would like to understand on whether this is avoidable by a
> > > different startup scheme or it really needs to be addressed in some w=
ay.
> >=20
> > No worries, I am in fact happy you are giving it this much attention :)
> >=20
> > I also understand this is a considerable change in the locking strategy=
, and
> > avoiding that is the first thing that should be tried.
> >=20
> > >=20
> > > > One way I thought to solve that was introducing a remote drain, whi=
ch would
> > > > require a different strategy for locking, since not all accesses to=
 the pcp
> > > > caches would happen on a local CPU.=20
> > >=20
> > > Yeah, I am not supper happy about additional spin lock TBH. One
> > > potential way to go would be to completely avoid pcp cache for isolat=
ed
> > > CPUs.=C2=A0That would have some performance impact of course but on t=
he other
> > > hand it would give a more predictable behavior for those CPUs which
> > > sounds like a reasonable compromise to me. What do you think?
> >=20
> > You mean not having a perCPU stock, then?=20
> > So consume_stock() for isolated CPUs would always return false, causing
> > try_charge_memcg() always walking the slow path?
>=20
> Exactly.
>=20
> > IIUC, both my proposal and yours would degrade performance only when we=
 use
> > isolated CPUs + memcg. Is that correct?
>=20
> Yes, with a notable difference that with your spin lock option there is
> still a chance that the remote draining could influence the isolated CPU
> workload throug that said spinlock. If there is no pcp cache for that
> cpu being used then there is no potential interaction at all.

I see.=20
But the slow path is slow for some reason, right?
Does not it make use of any locks also? So on normal operation there could =
be a
potentially larger impact than a spinlock, even though there would be no
scheduled draining.

>=20
> > If so, it looks like the impact would be even bigger without perCPU sto=
ck ,
> > compared to introducing a spinlock.
> >=20
> > Unless, we are counting to this case where a remote CPU is draining an =
isolated
> > CPU, and the isolated CPU faults a page, and has to wait for the spinlo=
ck to be
> > released in the remote CPU. Well, this seems possible to happen, but I =
would
> > have to analyze how often would it happen, and how much would it impact=
 the
> > deadlines. I *guess* most of the RT workload's memory pages are pre-fau=
lted
> > before its starts, so it can avoid the faulting latency, but I need to =
confirm
> > that.
>=20
> Yes, that is a general practice and the reason why I was asking how real
> of a problem that is in practice.=C2=A0

I remember this was one common factor on deadlines being missed in the work=
load
analyzed. Need to redo the test to be sure.

> It is true true that appart from user
> space memory which can be under full control of the userspace there are
> kernel allocations which can be done on behalf of the process and those
> could be charged to memcg as well. So I can imagine the pcp cache could
> be populated even if the process is not faulting anything in during RT
> sensitive phase.

Humm, I think I will apply the change and do a comparative testing with
upstream. This should bring good comparison results.

>=20
> > On the other hand, compared to how it works now now, this should be a m=
ore
> > controllable way of introducing latency than a scheduled cache drain.
> >=20
> > Your suggestion on no-stocks/caches in isolated CPUs would be great for
> > predictability, but I am almost sure the cost in overall performance wo=
uld not
> > be fine.
>=20
> It is hard to estimate the overhead without measuring that. Do you think
> you can give it a try? If the performance is not really acceptable
> (which I would be really surprised) then we can think of a more complex
> solution.

Sure, I can try that.
Do you suggest any specific workload that happens to stress the percpu cach=
e
usage, with usual drains and so? Maybe I will also try with synthetic worlo=
ads
also.

>=20
> > With the possibility of prefaulting pages, do you see any scenario that=
 would
> > introduce some undesirable latency in the workload?
>=20
> My primary concern would be spin lock contention which is hard to
> predict with something like remote draining.

It makes sense. I will do some testing and come out with results for that.

Thanks for reviewing!
Leo


