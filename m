Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27868CD61
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 04:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBGDTc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 22:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBGDT2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 22:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A80360AB
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 19:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675739888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIxTMZmbsJ4n4h+wodJFJ7AH4L9sE2etRukeWGfprOQ=;
        b=eANDvVka1kzOtB2QmbX+LinmbIlao9B/6l1R7qr5DYuNkPP5NcCHal3ixbiFxYHqQPHUjP
        lpHjTENepvTF1XjUbCwRYdyWiVnxpzpfgfss/AEiYeS586W+hN/nOymAFS8ude9b8RUq2Y
        QjaDgif+t9OFCU9p+Vr2KitiBUw/Jhk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-KtCm9zegMuKVPGYiHOUCEA-1; Mon, 06 Feb 2023 22:18:07 -0500
X-MC-Unique: KtCm9zegMuKVPGYiHOUCEA-1
Received: by mail-oo1-f72.google.com with SMTP id k3-20020a4a4a03000000b0051a3df506b5so3525834oob.9
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 19:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIxTMZmbsJ4n4h+wodJFJ7AH4L9sE2etRukeWGfprOQ=;
        b=nHXgvAluuiqS1PRueGtbsV/rZC4mmC8rQ0CkA4x1fF/PhV4h4o5L5ncWogHYayQjfo
         uw2xOXpTaOP9aMN9qwBZCqCd12uMegU2LDtTSJ65jeOMq3OnNUkKbyttHxeE+bd/eoZP
         A54whkLRN/gKePeBHorpkcrxxhjX9Noi2hLsiijg4BWdQaGOcRbhPMZrpTf90XgHderJ
         ZQkZz7fmly6vP9UoH0vwpEmpuUSrEA85cW3JVGaGofqmpuI8lMNOsCDRcs/MUBXeE5VJ
         6CTew5GdsEdfziA8cxSczFSi8vEZkgPnrLbwZkAJ5gYOA9Oira3Ql91gI8d8Hc7Vl0W7
         i3Pg==
X-Gm-Message-State: AO0yUKUafjoMeEBg2X2peUG1i1On5aOG/NLwzeVpqL3vcwadhKaZvsKy
        +Ld8FMZZ+Gnd16nSw/ZjQhk85VTCRhDk4zR2j13a1FglaFyx1ruNvxyKvKt/EInFmr2yd0dDToC
        FyNDkw/tD2H7PhX1OFg==
X-Received: by 2002:aca:2809:0:b0:37a:2bf0:5025 with SMTP id 9-20020aca2809000000b0037a2bf05025mr5460891oix.19.1675739886843;
        Mon, 06 Feb 2023 19:18:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+7VS3H2qMxD1XHEeHGgHZ74B+TJyfGc4ZI4Mp5kB81qQes42VlFPDf7PJJ4nRSKOza3aEOWw==
X-Received: by 2002:aca:2809:0:b0:37a:2bf0:5025 with SMTP id 9-20020aca2809000000b0037a2bf05025mr5460883oix.19.1675739886546;
        Mon, 06 Feb 2023 19:18:06 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:9aa9:fdcb:7dec:9680:8417? ([2804:1b3:a800:9aa9:fdcb:7dec:9680:8417])
        by smtp.gmail.com with ESMTPSA id z12-20020a54458c000000b003790759c310sm5040893oib.15.2023.02.06.19.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:18:05 -0800 (PST)
Message-ID: <4b232f47e038ab6fcaa0114f73c28d4bf8799f84.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Feb 2023 00:18:01 -0300
In-Reply-To: <Y+AIOQy0HdVXCw8m@P9FQF9L96D>
References: <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
         <Y9LDAZmApLeffrT8@tpad> <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
         <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
         <Y9j9BnMwfm4TJks7@tpad> <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
         <28e08669302ad1e7a41bdf8b9988de6a352b5fe1.camel@redhat.com>
         <Y+AIOQy0HdVXCw8m@P9FQF9L96D>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
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

On Sun, 2023-02-05 at 11:49 -0800, Roman Gushchin wrote:
> Hi Leonardo!

Hello Roman,
Thanks a lot for replying!

>=20
> > Yes, but we are exchanging an "always schedule_work_on()", which is a k=
ind of
> > contention, for a "sometimes we hit spinlock contention".
> >=20
> > For the spinlock proposal, on the local cpu side, the *worst case* cont=
ention
> > is:
> > 1 - wait the spin_unlock() for a complete <percpu cache drain process>,
> > 2 - wait a cache hit for local per-cpu cacheline=C2=A0
> >=20
> > What is current implemented (schedule_work_on() approach), for the loca=
l
> > cpu=C2=A0side there is *always* this contention:
> > 1 - wait for a context switch,
> > 2 - wait a cache hit from it's local per-cpu cacheline,
> > 3 - wait a complete <percpu cache drain process>,=C2=A0
> > 4 - then for a new context switch to the current thread.
>=20
> I think both Michal and me are thinking of a more generic case in which t=
he cpu
> is not exclusively consumed by 1 special process, so that the draining wo=
rk can
> be executed during an idle time. In this case the work is basically free.

Oh, it makes sense.
But in such scenarios, wouldn't the same happens to spinlocks?

I mean, most of the contention with spinlocks only happens if the remote cp=
u is
trying to drain the cache while the local cpu happens to be draining/chargi=
ng,
which is quite rare due to how fast the local cpu operations are.

Also, if the cpu has some idle time, using a little more on a possible spin=
lock
contention should not be a problem. Right?

>=20
> And the introduction of a spin_lock() on the hot path is what we're are c=
oncerned
> about. I agree, that on some hardware platforms it won't be that expensiv=
e,=C2=A0
>=20

IIRC most hardware platforms with multicore supported by the kernel should =
have
the same behavior, since it's better to rely on cache coherence than lockin=
g the
memory bus.

For instance, the other popular architectures supported by Linux use the LR=
/SC
strategy for atomic operations (tested on ARM, POWER, RISCV) and IIRC the
LoadReserve slow part waits for the cacheline exclusivity, which is already
already exclusive in this perCPU structure.


> but in general not having any spinlocks is so much better.

I agree that spinlocks may bring contention, which is not ideal in many cas=
es.
In this case, though, it may not be a big issue, due to very rare remote ac=
cess
in the structure, for the usual case (non-pre-OOMCG)

>=20
> >=20
> > So moving from schedule_work_on() to spinlocks will save 2 context swit=
ches per
> > cpu every time drain_all_stock() is called.
> >=20
> > On the remote cpu side, my tests point that doing the remote draining i=
s faster
> > than scheduling a local draining, so it's also a gain.
> >=20
> > Also, IIUC the possible contention in the spinlock approach happens onl=
y on
> > page-faulting and syscalls, versus the schedule_work_on() approach that=
 can
> > interrupt user workload at any time.=C2=A0
> >=20
> > In fact, not interrupting the user workload in isolated cpus is just a =
bonus of
> > using spinlocks.
>=20
> I believe it significantly depends on the preemption model: you're right =
regarding
> fully preemptive kernels, but with voluntary/none preemption it's exactly=
 opposite:
> the draining work will be executed at some point later (probably with 0 c=
ost),

So, in case of voluntary/none preemption with some free cpu time.=20

> while the remote access from another cpu will potentially cause delays on=
 the
> spin lock as well as a need to refill the stock.

But if there is some free CPU time, what is the issue of some (potential) d=
elays
due to spinlock contention?

I am probably missing the whole picture, but when I think of performance
improvement, I think on doing more with the same cputime. If we can use fre=
e
cputime to do stuff later, it's only fair to also use it in case of content=
ion,
right?

I know there are some cases that may need to be more previsible (mostly RT)=
, but
when I think of memory allocation, I don't expect it to always take the sam=
e
time (as there are caches, pre-OOM, and so)

Also, as previously discussed, in case of a busy cpu, the spinlock approach=
 will
probably allow more work to be done.

>=20
> Overall I'd expect a noticeable performance regression from an introducti=
on of
> spin locks and remote draining. Maybe not on all platforms, but at least =
on some.
> That's my main concern.
>=20

I see.=20
For the platform I have tested (x86) I noticed better overall performance o=
n
spinlocks than upstream solution. For other popular platforms, I have brief=
ly
read some documentation on locking/atomicity and I think we may keep the
performance gains.

But to be sure, I could retake the tests on other platforms, such as ARM, P=
OWER,
RISCV, and so. Or even perform extra suggested tests.

With that info, would you feel less concerned about a possible change in me=
mcg
pcp cache locking scheme?


>  And I don't think the problem we're aiming to solve here
> justifies this potential regression.
>=20

To be strict, the isolated cpu scheduling problem is already fixed by the
housekeeping patch (with some limitations).=C2=A0

At this point, I am trying to bring focus to a (possible) performance
improvement on the memcg pcp cache locking system.


> Thanks!
>=20

Thank you for helping me better understand your arguments and concerns.
I really appreciate it!

Best regards,
Leo

