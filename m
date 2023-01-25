Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5867AB22
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAYHpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 02:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjAYHpM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 02:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259B3D0BA
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkeMwblj9hneaBAEGr4WY7HayLEL2jAXC1+f00C91Gc=;
        b=ecETXQha7bGH2bR2B1N0BH8X1pQUXfLZ4I8+4UaPB33qDQsHmssB0pul9kyW1idN8dnSSK
        6DPqAA9X7zf0BqvwgrIOHHWHn8IXbebSkh0nVMrCUejl5UJFFa/f5IeoOkRMPyje9qkpiO
        xxUtIsB0edwvRtVrZQhzNi1SVZImVB4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-PTxXu5QzO8awMsiGmhh0DA-1; Wed, 25 Jan 2023 02:44:23 -0500
X-MC-Unique: PTxXu5QzO8awMsiGmhh0DA-1
Received: by mail-oi1-f200.google.com with SMTP id w131-20020aca6289000000b003686285a4a8so5506772oib.7
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkeMwblj9hneaBAEGr4WY7HayLEL2jAXC1+f00C91Gc=;
        b=3Jn5V4iRf/vvL3IJPHsBi6GVOOgf/XgWloHok3DCzg/CHiPKKuSdGiCXhsrw0eTlPR
         3tvRBkrNNEE9/5BrIuscjOlChsU0J+qb4CGp7Q+EFIuipMFnkp7rrLB/TP+p/nFcCZ1g
         JJS/qU8/IFSvK/UY52VM1ZTzJU/10cZWN5aBYyllOGYe50Bn1GuutRx7dTRPULXMwObI
         1PKj7M4+i0aa8IP+msGMhtX5Y25+CaqcMMFM/tU0VxGwYo1/Ud1RaeJvlkcP8rZPz1rE
         niwcJTdAyF8e4E7AhQeKN+bkwYZlADLmVqP+oEr3GgzahGW8DTN6fe4/hPNGHWEad2Ij
         aMxA==
X-Gm-Message-State: AFqh2kp1+a5paSPma/3qfrgakFcr+UAGpaiDor3mSp5O5lJY/5/PswM8
        iuVp7OS+QO2UV1u4+ZVbVDpbKNZGnTP7aOJyayvcYy9/eLNz3B2Tp0Zxo2KfboFV1gtsvOyH0Qb
        OJfTceDglEItDxuQ4rA==
X-Received: by 2002:a05:6870:4288:b0:15e:e50c:1813 with SMTP id y8-20020a056870428800b0015ee50c1813mr17604051oah.55.1674632662619;
        Tue, 24 Jan 2023 23:44:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsmOOC0na3goHYTCuYUR80h3zsrixqTPIdufe5WuJ2AFLGjawvqUoIdakZTwJYrZcPAxvXVeg==
X-Received: by 2002:a05:6870:4288:b0:15e:e50c:1813 with SMTP id y8-20020a056870428800b0015ee50c1813mr17604031oah.55.1674632662379;
        Tue, 24 Jan 2023 23:44:22 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:14fa:9361:c141:6c70:c877? ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id p9-20020a4ad449000000b004fb2935d0e7sm1574351oos.36.2023.01.24.23.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:44:21 -0800 (PST)
Message-ID: <958969c204e1041dead005d1c801cf3c54ab86f1.camel@redhat.com>
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
Date:   Wed, 25 Jan 2023 04:44:12 -0300
In-Reply-To: <Y2tfSAgt/lBVcdvf@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
         <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
         <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
         <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
         <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
         <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
         <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
         <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
         <4a4a6c73f3776d65f70f7ca92eb26fc90ed3d51a.camel@redhat.com>
         <Y2tfSAgt/lBVcdvf@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
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

On Wed, 2022-11-09 at 09:05 +0100, Michal Hocko wrote:
> On Tue 08-11-22 20:09:25, Leonardo Br=C3=A1s wrote:
> [...]
> > > Yes, with a notable difference that with your spin lock option there =
is
> > > still a chance that the remote draining could influence the isolated =
CPU
> > > workload throug that said spinlock. If there is no pcp cache for that
> > > cpu being used then there is no potential interaction at all.
> >=20
> > I see.=20
> > But the slow path is slow for some reason, right?
> > Does not it make use of any locks also? So on normal operation there co=
uld be a
> > potentially larger impact than a spinlock, even though there would be n=
o
> > scheduled draining.
>=20
> Well, for the regular (try_charge) path that is essentially page_counter_=
try_charge
> which boils down to atomic_long_add_return of the memcg counter + all
> parents up the hierarchy and high memory limit evaluation (essentially 2
> atomic_reads for the memcg + all parents up the hierchy). That is not
> whole of a lot - especially when the memcg hierarchy is not very deep.
>=20
> Per cpu batch amortizes those per hierarchy updates as well as atomic
> operations + cache lines bouncing on updates.
>=20
> On the other hand spinlock would do the unconditional atomic updates as
> well and even much more on CONFIG_RT. A plus is that the update will be
> mostly local so cache line bouncing shouldn't be terrible. Unless
> somebody heavily triggers pcp cache draining but this shouldn't be all
> that common (e.g. when a memcg triggers its limit.
>=20
> All that being said, I am still not convinced that the pcp cache bypass
> for isolated CPUs would make a dramatic difference. Especially in the
> context of workloads that tend to run on isolated CPUs and rarely enter
> kernel.
> =20
> > > It is true true that appart from user
> > > space memory which can be under full control of the userspace there a=
re
> > > kernel allocations which can be done on behalf of the process and tho=
se
> > > could be charged to memcg as well. So I can imagine the pcp cache cou=
ld
> > > be populated even if the process is not faulting anything in during R=
T
> > > sensitive phase.
> >=20
> > Humm, I think I will apply the change and do a comparative testing with
> > upstream. This should bring good comparison results.
>=20
> That would be certainly appreciated!
>  (
> > > > On the other hand, compared to how it works now now, this should be=
 a more
> > > > controllable way of introducing latency than a scheduled cache drai=
n.
> > > >=20
> > > > Your suggestion on no-stocks/caches in isolated CPUs would be great=
 for
> > > > predictability, but I am almost sure the cost in overall performanc=
e would not
> > > > be fine.
> > >=20
> > > It is hard to estimate the overhead without measuring that. Do you th=
ink
> > > you can give it a try? If the performance is not really acceptable
> > > (which I would be really surprised) then we can think of a more compl=
ex
> > > solution.
> >=20
> > Sure, I can try that.
> > Do you suggest any specific workload that happens to stress the percpu =
cache
> > usage, with usual drains and so? Maybe I will also try with synthetic w=
orloads
> > also.
>=20
> I really think you want to test it on the isolcpu aware workload.
> Artificial benchmark are not all that useful in this context.

Hello Michael,
I just sent a v2 for this patchset with a lot of changes.
https://lore.kernel.org/lkml/20230125073502.743446-1-leobras@redhat.com/

I have tried to gather some data on the performance numbers as suggested, b=
ut I
got carried away and the cover letter ended up too big. I hope it's not too=
 much
trouble.

Best regards,
Leo



