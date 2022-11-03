Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EC618053
	for <lists+cgroups@lfdr.de>; Thu,  3 Nov 2022 16:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKCPAf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Nov 2022 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKCPAe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Nov 2022 11:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4D1929F
        for <cgroups@vger.kernel.org>; Thu,  3 Nov 2022 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667487572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQYuzqixH+Fy3EOo9WqVlwQ+6mailyHi9cBj8lDCjt4=;
        b=QWXjwreUXeOk9e8BPxOmHlK2SSUow9UeI5+N1BoWWFh3m+fOO4TQmhmDf+Bg0nI63TwZ9D
        s5kvkY4/HvJv+wjj1JS55yKyfRkdb5NOveayBl4gTLyFFzXQrh5IoQ3uWRwi/bwH8S5px+
        jbjcZVfYUQ5u5mm6LygRxRHWmt+T/bg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-rlxI7n7dOte5Jk9HpN7ZyA-1; Thu, 03 Nov 2022 10:59:29 -0400
X-MC-Unique: rlxI7n7dOte5Jk9HpN7ZyA-1
Received: by mail-oi1-f197.google.com with SMTP id j8-20020a056808118800b00354b7e75b46so1015159oil.16
        for <cgroups@vger.kernel.org>; Thu, 03 Nov 2022 07:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQYuzqixH+Fy3EOo9WqVlwQ+6mailyHi9cBj8lDCjt4=;
        b=PtWIOjk7opJ4LJt2yLSKMya/a3Dl1C4bjuInOW30HChiwr+ALO5emLKUb97QZEvKjM
         ZOFw8WFuQvdyu1Vh6ru1yO9XVaD059mW9UwvQrbmQJbi2QcfT43WI4Z3YF/DrSFXnYpk
         F9YtM1z9uSpMMZXcXXWa7usVa4g/2xcnO0bz/Sp5it+fVwVNPie1+KXBioZF40vauxAR
         uex0wZcXduN0+yO1LYvg6rXTmk8aYKr3SNHw5NGNrC5DupsxxOYoQUXTU9uBy44z5JxP
         8s53zJvAQT3bbUoSSPJwUet+NapAwFtcAKu16kG4/tXjHpl8pGOAreFQnItnppgrlEBe
         sPKw==
X-Gm-Message-State: ACrzQf0+hCKqqJu+HS0TE/EKwkyTmui3KyEPin77nm1l+sDSKCvMahqd
        dITQT9r8g1jVyH2JvQjQIPyxwCV+iblmnGg0+FcAs8qOFtsA1NQKtxlV7vDb1hDNyD91lXEB7dt
        TAVXp578ESQmVYB87BQ==
X-Received: by 2002:a05:6870:4946:b0:13d:8222:31f5 with SMTP id fl6-20020a056870494600b0013d822231f5mr3525552oab.278.1667487568755;
        Thu, 03 Nov 2022 07:59:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sVtgV4DYzQ4+9TyYmw27dPqoOuIIT3SXdI/vy6sUQmuqFt76MTAbupMt94T4wFxScGdYuFQ==
X-Received: by 2002:a05:6870:4946:b0:13d:8222:31f5 with SMTP id fl6-20020a056870494600b0013d822231f5mr3525527oab.278.1667487568453;
        Thu, 03 Nov 2022 07:59:28 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:1099:7cb2:3a49:6197:5307? ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id cm3-20020a056830650300b006618586b850sm410907otb.46.2022.11.03.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:59:27 -0700 (PDT)
Message-ID: <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
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
Date:   Thu, 03 Nov 2022 11:59:20 -0300
In-Reply-To: <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
         <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2022-11-02 at 09:53 +0100, Michal Hocko wrote:
> On Tue 01-11-22 23:02:40, Leonardo Bras wrote:
> > Patch #1 expands housekeep=C3=ADng_any_cpu() so we can find housekeepin=
g cpus
> > closer (NUMA) to any desired CPU, instead of only the current CPU.
> >=20
> > ### Performance argument that motivated the change:
> > There could be an argument of why would that be needed, since the curre=
nt
> > CPU is probably acessing the current cacheline, and so having a CPU clo=
ser
> > to the current one is always the best choice since the cache invalidati=
on
> > will take less time. OTOH, there could be cases like this which uses
> > perCPU variables, and we can have up to 3 different CPUs touching the
> > cacheline:
> >=20
> > C1 - Isolated CPU: The perCPU data 'belongs' to this one
> > C2 - Scheduling CPU: Schedule some work to be done elsewhere, current c=
pu
> > C3 - Housekeeping CPU: This one will do the work
> >=20
> > Most of the times the cacheline is touched, it should be by C1. Some ti=
mes
> > a C2 will schedule work to run on C3, since C1 is isolated.
> >=20
> > If C1 and C2 are in different NUMA nodes, we could have C3 either in
> > C2 NUMA node (housekeeping_any_cpu()) or in C1 NUMA node=20
> > (housekeeping_any_cpu_from(C1).=20
> >=20
> > If C3 is in C2 NUMA node, there will be a faster invalidation when C3
> > tries to get cacheline exclusivity, and then a slower invalidation when
> > this happens in C1, when it's working in its data.
> >=20
> > If C3 is in C1 NUMA node, there will be a slower invalidation when C3
> > tries to get cacheline exclusivity, and then a faster invalidation when
> > this happens in C1.
> >=20
> > The thing is: it should be better to wait less when doing kernel work
> > on an isolated CPU, even at the cost of some housekeeping CPU waiting
> > a few more cycles.
> > ###
> >=20
> > Patch #2 changes the locking strategy of memcg_stock_pcp->stock_lock fr=
om
> > local_lock to spinlocks, so it can be later used to do remote percpu
> > cache draining on patch #3. Most performance concerns should be pointed
> > in the commit log.
> >=20
> > Patch #3 implements the remote per-CPU cache drain, making use of both=
=20
> > patches #2 and #3. Performance-wise, in non-isolated scenarios, it shou=
ld
> > introduce an extra function call and a single test to check if the CPU =
is
> > isolated.=20
> >=20
> > On scenarios with isolation enabled on boot, it will also introduce an
> > extra test to check in the cpumask if the CPU is isolated. If it is,
> > there will also be an extra read of the cpumask to look for a
> > housekeeping CPU.
>=20

Hello Michael, thanks for reviewing!

> This is a rather deep dive in the cache line usage but the most
> important thing is really missing. Why do we want this change? From the
> context it seems that this is an actual fix for isolcpu=3D setup when
> remote (aka non isolated activity) interferes with isolated cpus by
> scheduling pcp charge caches on those cpus.
>=20
> Is this understanding correct?

That's correct! The idea is to avoid scheduling work to isolated CPUs.

> If yes, how big of a problem that is?

The use case I have been following requires both isolcpus=3D and PREEMPT_RT=
, since
the isolated CPUs will be running a real-time workload. In this scenario,
getting any work done instead of the real-time workload may cause the syste=
m to
miss a deadline, which can be bad.=20

>  If you want a remote draining then
> you need some sort of locking (currently we rely on local lock). How
> come this locking is not going to cause a different form of disturbance?

If I did everything right, most of the extra work should be done either in =
non-
isolated (housekeeping) CPUs, or during a syscall. I mean, the pcp charge c=
aches
will be happening on a housekeeping CPU, and the locking cost should be pai=
d
there as we want to avoid doing that in the isolated CPUs.=20

I understand there will be a locking cost being paid in the isolated CPUs w=
hen:
a) The isolated CPU is requesting the stock drain,
b) When the isolated CPUs do a syscall and end up using the protected struc=
ture
the first time after a remote drain.

Both (a) and (b) should happen during a syscall, and IIUC the a rt workload
should not expect the syscalls to be have a predictable time, so it should =
be
fine.

Thanks for helping me explain the case!
Best regards,
Leo

