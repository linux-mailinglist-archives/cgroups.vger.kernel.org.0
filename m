Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD967DE06
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjA0G4k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 01:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0G4j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 01:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67321737
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 22:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674802548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDdEzZIJpaMrus45LhANj9u0TRucPAk/LF4N1hRhX9Q=;
        b=Ek6bNeGb0rbdnCflSSVmTSezMoT3n60chl1bkI21cGP8fYsXhx0h/QcVgTrsLCFq8i5LVu
        zl9XTPugNIPewlwPikQHXvxWP08Xtl5U9bAaQwrQoZV0UGUKrCIqMfxZaBKnXfTNJ7NWNH
        UG/UZeU5QzmUWtrU78vFomE9s3ClS90=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-FnVdqb06P3-_G6zNgOgQSg-1; Fri, 27 Jan 2023 01:55:47 -0500
X-MC-Unique: FnVdqb06P3-_G6zNgOgQSg-1
Received: by mail-ot1-f69.google.com with SMTP id c9-20020a9d6849000000b006869603817fso1937180oto.5
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 22:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDdEzZIJpaMrus45LhANj9u0TRucPAk/LF4N1hRhX9Q=;
        b=c8yA21vc25+60oIsaBHDFJaOn8tOgzXw+1qVqt1+pvamRAeFE1jW4oAvo2nhqKgWAL
         MvYti6kc/dYJqKClhzSqdlwi1V+5r15faBuQrXmtC4u+SA7JklwHOghqeC61uYSS3EKz
         HR9OjVXgDGfi2mdjR/uQVoRHCqRRIOjtVWeW/g33xo2eYALL3VicpvxleJqqX8Uohib3
         KBBxMwubB63a74S+OVa/Dso2RV+Bc31y+RW90JeUchPspVM2UAGYUAJCQrAMmUzLESti
         aei6ZlM4mTUnqQkoXnNuRoa16kWYSzxb7IEMFQD18NkA7YUYERdeRhAdbS/X5KGnipdm
         NL6Q==
X-Gm-Message-State: AFqh2krlKq9bZR2Us5IX6Gmb1iKIH3AlmbSUS6HBFGr+CBXjw0p20+hq
        soBwNx84xsoZiGGOlbZ2Jfl8px9SCPNUbCX/A3HUdDl8tb/T/QYoVES0yomMMOKQfy519bFkGGC
        RuLze4JyWKDqZOK68GQ==
X-Received: by 2002:a05:6830:1bdb:b0:686:56e2:2e41 with SMTP id v27-20020a0568301bdb00b0068656e22e41mr16544499ota.38.1674802545988;
        Thu, 26 Jan 2023 22:55:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvfswXh7DppF1VeSoZqsSmPMJugeFI1r9Oj3sddFZy7IuwLtSHny7FBVdKerPF7Mn9vk6qEzw==
X-Received: by 2002:a05:6830:1bdb:b0:686:56e2:2e41 with SMTP id v27-20020a0568301bdb00b0068656e22e41mr16544488ota.38.1674802545731;
        Thu, 26 Jan 2023 22:55:45 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0568081a8b00b0035a2f3e423esm1294570oib.32.2023.01.26.22.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 22:55:45 -0800 (PST)
Message-ID: <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jan 2023 03:55:39 -0300
In-Reply-To: <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
         <Y9LDAZmApLeffrT8@tpad> <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
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

On Thu, 2023-01-26 at 20:13 +0100, Michal Hocko wrote:
> On Thu 26-01-23 15:14:25, Marcelo Tosatti wrote:
> > On Thu, Jan 26, 2023 at 08:45:36AM +0100, Michal Hocko wrote:
> > > On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
> > > [...]
> > > > Remote draining reduces interruptions whether CPU=20
> > > > is marked as isolated or not:
> > > >=20
> > > > - Allows isolated CPUs from benefiting of pcp caching.
> > > > - Removes the interruption to non isolated CPUs. See for example=
=20
> > > >=20
> > > > https://lkml.org/lkml/2022/6/13/2769
> > >=20
> > > This is talking about page allocato per cpu caches, right? In this pa=
tch
> > > we are talking about memcg pcp caches. Are you sure the same applies
> > > here?
> >=20
> > Both can stall the users of the drain operation.
>=20
> Yes. But it is important to consider who those users are. We are
> draining when
> 	- we are charging and the limit is hit so that memory reclaim
> 	  has to be triggered.
> 	- hard, high limits are set and require memory reclaim.
> 	- force_empty - full memory reclaim for a memcg
> 	- memcg offlining - cgroup removel - quite a heavy operation as
> 	  well.
> all those could be really costly kernel operations and they affect
> isolated cpu only if the same memcg is used by both isolated and non-isol=
ated
> cpus. In other words those costly operations would have to be triggered
> from non-isolated cpus and those are to be expected to be stalled. It is
> the side effect of the local cpu draining that is scheduled that affects
> the isolated cpu as well.
>=20
> Is that more clear?

I think so, please help me check:

IIUC, we can approach this by dividing the problem in two working modes:
1 - Normal, meaning no drain_all_stock() running.
2 - Draining, grouping together pre-OOM and userspace 'config' : changing,
destroying, reconfiguring a memcg.

For (1), we will have (ideally) only local cpu working on the percpu struct=
.
This mode will not have any kind of contention, because each CPU will hold =
it's
own spinlock only.=20

For (2), we will have a lot of drain_all_stock() running. This will mean a =
lot
of schedule_work_on() running (on upstream) or possibly causing contention,=
 i.e.
local cpus having to wait for a lock to get their cache, on the patch propo=
sal.

Ok, given the above is correct:

# Some arguments point that (1) becomes slower with this patch.

This is partially true: while test 2.2 pointed that local cpu functions run=
ning
time had became slower by a few cycles, test 2.4 points that the userspace
perception of it was that the syscalls and pagefaulting actually became fas=
ter:

During some debugging tests before getting the performance on test 2.4, I
noticed that the 'syscall + write' test would call all those functions that
became slower on test 2.2. Those functions were called multiple millions of
times during a single test, and still the patched version performance test
returned faster for test 2.4 than upstream version. Maybe the functions bec=
ame
slower, but overall the usage of them in the usual context became faster.

Is not that a small improvement?

# Regarding (2), I notice that we fear contention=20

While this seems to be the harder part of the discussion, I think we have e=
nough
data to deal with it.=20

In which case contention would be a big problem here?=C2=A0
IIUC it would be when a lot of drain_all_stock() get running because the me=
mory
limit is getting near.=C2=A0I mean, having the user to create / modify a me=
mcg
multiple times a second for a while is not something that is expected, IMHO=
.

Now, if I assumed correctly and the case where contention could be a proble=
m is
on a memcg with high memory pressure, then we have the argument that Marcel=
o
Tosatti brought to the discussion[P1]: using spinlocks on percpu caches for=
 page
allocation brought better results than local_locks + schedule_work_on().

I mean, while contention would cause the cpu to wait for a while before get=
ting
the lock for allocating a page from cache, something similar would happen w=
ith
schedule_work_on(), which would force the current task to wait while the
draining happens locally.=C2=A0

What I am able to see is that, for each drain_all_stock(), for each cpu get=
ting
drained we have the option to (a) (sometimes) wait for a lock to be freed, =
or
(b) wait for a whole context switch to happen.
And IIUC, (b) is much slower than (a) on average, and this is what causes t=
he
improved performance seen in [P1].

(I mean, waiting while drain_local_stock() runs in the local CPU vs waiting=
 for
it to run on the remote CPU may not be that different, since the cacheline =
is
already writen to by the remote cpu on Upstream)

Also according to test 2.2, for the patched version, drain_local_stock() ha=
ve
gotten faster (much faster for 128 cpus), even though it does all the drain=
ing
instead of just scheduling it on the other cpus.=C2=A0
I mean, summing that to the brief nature of local cpu functions, we may not=
 hit
contention as much as we are expected.

##

Sorry for the long text.
I may be missing some point, please let me know if that's the case.

Thanks a lot for reviewing!
Leo

[P1]: https://lkml.org/lkml/2022/6/13/2769

