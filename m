Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38638685E8B
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBAEhI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 23:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBAEhH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 23:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EAC37F09
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675226176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BiFkmS3tbcnlONUhHqfYNt9fP+0R9mL8avFHp+lRK9A=;
        b=XgDQnVCGEkYDVQImU6H2RSj8pObDA0n/0iXiC0ZgLdguIFcoxIXv7sJ4z7z+edqAhO0Obs
        Tdx0UPvOByIjekyXau6PbNbYOK9ra91OA8pENziHKpcUKGMvtAAhSBuCmseXdoORJUg0BE
        LhdTo+zwspLEG2m96Mn7oy/hmo6ZuUM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-1l9_DXMPM-6JEH_EvIVr6w-1; Tue, 31 Jan 2023 23:36:14 -0500
X-MC-Unique: 1l9_DXMPM-6JEH_EvIVr6w-1
Received: by mail-ot1-f72.google.com with SMTP id x14-20020a9d6d8e000000b0068bd4aa4439so3256509otp.20
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 20:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiFkmS3tbcnlONUhHqfYNt9fP+0R9mL8avFHp+lRK9A=;
        b=Ol8JiKD8dBx5pZ7YZmIl+sBr9bdDbR0Y++DBTkZ6BeXYzW9qTsIsPxS4V3tYzg+Y5J
         Ni8rUHNjj/mnyLxCDMby//NLGSTA3Bsfru0DgHKz0oe9TaZQElIwVs5VpDrD83SlMese
         CBHVlliOcxMoVUcYytyNrECGxhGngW6043zR2tHbOoy4+ZR3q1WMFRi/uXqTvVBdtrGs
         +VwjoD9fp4M/N0sIYzcWanHEY+jc/0l0Bszd6SaEISFBuyNqNOP6UwBpm/SMsJiSGLzQ
         2ox9JopGpw4fdg1sDzkaAGjHEo6XbIRQ8LkK+rHX/InNP8RqTeewm1wNnml3lUkURxQt
         ZZmg==
X-Gm-Message-State: AO0yUKUCEvCpGMHODr/D1rqH6oesKKhGr6AhpvV+u5NBNcmVcgE7Oz9/
        gpNr6nGL+sBymZwedD/ZLJkoc8Vr6Drcg4aPR43AmIPuQolCcyz58Ss/6nnwEZAWP66a/RwmVZ7
        UZgxcx+4R4SVmrUk2+Q==
X-Received: by 2002:a05:6871:721:b0:152:4c46:fa6c with SMTP id f33-20020a056871072100b001524c46fa6cmr348957oap.17.1675226173529;
        Tue, 31 Jan 2023 20:36:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9I+XbBlHDkMe6JZXfDndS488Wpi+CAx0Lsc2GvEYuE/fTytkaATmKQj00gyUrFyQU54ZtHcQ==
X-Received: by 2002:a05:6871:721:b0:152:4c46:fa6c with SMTP id f33-20020a056871072100b001524c46fa6cmr348944oap.17.1675226173240;
        Tue, 31 Jan 2023 20:36:13 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id fz16-20020a056870ed9000b00160323101efsm7400841oab.42.2023.01.31.20.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 20:36:12 -0800 (PST)
Message-ID: <5ba79c4feb829ed75cfd98cf5c8042dcb2ddea91.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Feb 2023 01:36:07 -0300
In-Reply-To: <Y9j9BnMwfm4TJks7@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
         <Y9LDAZmApLeffrT8@tpad> <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
         <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
         <Y9j9BnMwfm4TJks7@tpad>
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

On Tue, 2023-01-31 at 08:35 -0300, Marcelo Tosatti wrote:
> On Fri, Jan 27, 2023 at 03:55:39AM -0300, Leonardo Br=C3=A1s wrote:
> > On Thu, 2023-01-26 at 20:13 +0100, Michal Hocko wrote:
> > > On Thu 26-01-23 15:14:25, Marcelo Tosatti wrote:
> > > > On Thu, Jan 26, 2023 at 08:45:36AM +0100, Michal Hocko wrote:
> > > > > On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
> > > > > [...]
> > > > > > Remote draining reduces interruptions whether CPU=20
> > > > > > is marked as isolated or not:
> > > > > >=20
> > > > > > - Allows isolated CPUs from benefiting of pcp caching.
> > > > > > - Removes the interruption to non isolated CPUs. See for exampl=
e=20
> > > > > >=20
> > > > > > https://lkml.org/lkml/2022/6/13/2769
> > > > >=20
> > > > > This is talking about page allocato per cpu caches, right? In thi=
s patch
> > > > > we are talking about memcg pcp caches. Are you sure the same appl=
ies
> > > > > here?
> > > >=20
> > > > Both can stall the users of the drain operation.
> > >=20
> > > Yes. But it is important to consider who those users are. We are
> > > draining when
> > > 	- we are charging and the limit is hit so that memory reclaim
> > > 	  has to be triggered.
> > > 	- hard, high limits are set and require memory reclaim.
> > > 	- force_empty - full memory reclaim for a memcg
> > > 	- memcg offlining - cgroup removel - quite a heavy operation as
> > > 	  well.
> > > all those could be really costly kernel operations and they affect
> > > isolated cpu only if the same memcg is used by both isolated and non-=
isolated
> > > cpus. In other words those costly operations would have to be trigger=
ed
> > > from non-isolated cpus and those are to be expected to be stalled. It=
 is
> > > the side effect of the local cpu draining that is scheduled that affe=
cts
> > > the isolated cpu as well.
> > >=20
> > > Is that more clear?
> >=20
> > I think so, please help me check:

Michal, Roman: Could you please review my argumentation below, so I can
understand what exactly is wrong ?

> >=20
> > IIUC, we can approach this by dividing the problem in two working modes=
:
> > 1 - Normal, meaning no drain_all_stock() running.
> > 2 - Draining, grouping together pre-OOM and userspace 'config' : changi=
ng,
> > destroying, reconfiguring a memcg.
> >=20
> > For (1), we will have (ideally) only local cpu working on the percpu st=
ruct.
> > This mode will not have any kind of contention, because each CPU will h=
old it's
> > own spinlock only.=20
> >=20
> > For (2), we will have a lot of drain_all_stock() running. This will mea=
n a lot
> > of schedule_work_on() running (on upstream) or possibly causing content=
ion, i.e.
> > local cpus having to wait for a lock to get their cache, on the patch p=
roposal.
> >=20
> > Ok, given the above is correct:
> >=20
> > # Some arguments point that (1) becomes slower with this patch.
> >=20
> > This is partially true: while test 2.2 pointed that local cpu functions=
 running
> > time had became slower by a few cycles, test 2.4 points that the usersp=
ace
> > perception of it was that the syscalls and pagefaulting actually became=
 faster:
> >=20
> > During some debugging tests before getting the performance on test 2.4,=
 I
> > noticed that the 'syscall + write' test would call all those functions =
that
> > became slower on test 2.2. Those functions were called multiple million=
s of
> > times during a single test, and still the patched version performance t=
est
> > returned faster for test 2.4 than upstream version. Maybe the functions=
 became
> > slower, but overall the usage of them in the usual context became faste=
r.
> >=20
> > Is not that a small improvement?
> >=20
> > # Regarding (2), I notice that we fear contention=20
> >=20
> > While this seems to be the harder part of the discussion, I think we ha=
ve enough
> > data to deal with it.=20
> >=20
> > In which case contention would be a big problem here?=C2=A0
> > IIUC it would be when a lot of drain_all_stock() get running because th=
e memory
> > limit is getting near.=C2=A0I mean, having the user to create / modify =
a memcg
> > multiple times a second for a while is not something that is expected, =
IMHO.
>=20
> Considering that the use of spinlocks with remote draining is the more ge=
neral solution,
> what would be a test-case to demonstrate a contention problem?

IIUC we could try to reproduce a memory tight workload that keeps allocatin=
g /
freeing from different cpus (without hitting OOM).

Michal, Roman: Is that correct? You have any workload like that so we can t=
est?

>=20
> > Now, if I assumed correctly and the case where contention could be a pr=
oblem is
> > on a memcg with high memory pressure, then we have the argument that Ma=
rcelo
> > Tosatti brought to the discussion[P1]: using spinlocks on percpu caches=
 for page
> > allocation brought better results than local_locks + schedule_work_on()=
.
> >=20
> > I mean, while contention would cause the cpu to wait for a while before=
 getting
> > the lock for allocating a page from cache, something similar would happ=
en with
> > schedule_work_on(), which would force the current task to wait while th=
e
> > draining happens locally.=C2=A0
> >=20
> > What I am able to see is that, for each drain_all_stock(), for each cpu=
 getting
> > drained we have the option to (a) (sometimes) wait for a lock to be fre=
ed, or
> > (b) wait for a whole context switch to happen.
> > And IIUC, (b) is much slower than (a) on average, and this is what caus=
es the
> > improved performance seen in [P1].
>=20
> Moreover, there is a delay for the remote CPU to execute a work item=20
> (there could be high priority tasks, IRQ handling on the remote CPU,
> which delays execution of the work item even further).
>=20
> Also, the other point is that the spinlock already exists for
> PREEMPT_RT (which means that any potential contention issue=20
> with the spinlock today is limited to PREEMPT_RT users).
>=20
> So it would be good to point out a specific problematic=20
> testcase/scenario with using the spinlock in this particular case?


Oh, that's a good point, but IIUC spin_lock() replaces local_lock() in memc=
g,
meaning it will always run in the same CPU, and there should only be any
contention if the memcg local cpu functions get preempted by something that
calls a memcg local cpu function.

>=20
> > (I mean, waiting while drain_local_stock() runs in the local CPU vs wai=
ting for
> > it to run on the remote CPU may not be that different, since the cachel=
ine is
> > already writen to by the remote cpu on Upstream)
> >=20
> > Also according to test 2.2, for the patched version, drain_local_stock(=
) have
> > gotten faster (much faster for 128 cpus), even though it does all the d=
raining
> > instead of just scheduling it on the other cpus.=C2=A0
> > I mean, summing that to the brief nature of local cpu functions, we may=
 not hit
> > contention as much as we are expected.
> >=20
> > ##
> >=20
> > Sorry for the long text.
> > I may be missing some point, please let me know if that's the case.
> >=20
> > Thanks a lot for reviewing!
> > Leo
> >=20
> > [P1]: https://lkml.org/lkml/2022/6/13/2769
> >=20
> >=20
>=20

Thanks!
Leo

