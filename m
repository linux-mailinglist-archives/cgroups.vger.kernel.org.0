Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC06C6D31
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 17:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCWQSN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCWQSM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 12:18:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E701BF3
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 09:18:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so89178099edc.3
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679588290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxwPj9zc4wVERdaRm3UD6tbyjSI8uDBIlR3KTexXHNg=;
        b=XhO6nZVp3cJ6GYNnQ2ZPBd/bevteGrZU/HIt7rhk+LHiYXbwkTEIAA/Gm2lDHIMikg
         gfoYKiDCpNo8lnfMBlGGsI0PLQz5CrW36qepgWsG7uExChYhRpji3UqRtZum7cH/vdbZ
         nMqTsTLwMkfU7eqB6QIAZhzjzcr6MfIBsV9+Mh7lY8ajGfGMxL7VuLMDYbs0rNlH1Lgf
         iV6mh1620CTOr/soDFy1jiw2Cv+8sGb2vRKHlFpQOFPw708c41xBPfnbqLdjoqoACMXl
         o1UnaPMAjjFpYJ904SCgAI0gxQMgUnTxaQY+oMY7qneZ4HxyRULhAJKXlDXAWNrPcPJl
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxwPj9zc4wVERdaRm3UD6tbyjSI8uDBIlR3KTexXHNg=;
        b=LghvYVpymrslI8gVdFNiS9b12TDVlDodyBWKCiohJLxRIz4nTEIYctRLQNO69iV+uF
         eg7gcigeT2/ALo39d2BYyuBvzlZYdKJaYg/vl36+/uzpX6wS1anLP7vNZ1NZtemJebKm
         GxSCGlhWVssbplMFo+45oFVB6rOsDAdfbyKtJetWrSnEicPCBVBJb89isDFy4XpvPvtD
         mK4cjmwffDwBFp8q8wojbp67i45gK/FN+b4RegD4pDKNTgymMJmCnv3otxVyNEBHf7Ei
         1wVI41nCZhOhP9GhpoJPOC4noO72IWYOyCg3LaMfVWaxbouo8jJfigDG38inPbMdhAUR
         Q4UA==
X-Gm-Message-State: AO0yUKVvJ9lCDqMkGG50BFjKR9t6/r201aZynHpVR62RtL/WNXYDNtTz
        NZulxl1gddJmgqVWJ4ewJWeJ41e8o7FVke6sU5pXbg==
X-Google-Smtp-Source: AK7set/F5NNXvDsHcjBnswex17zee4ALhFHj/vmjoRRqfjUnNDh8XIbYrOkU+1HM87gBHlOIW8+AR+spBXumt/uarsQ=
X-Received: by 2002:a50:9b55:0:b0:4fc:473d:3308 with SMTP id
 a21-20020a509b55000000b004fc473d3308mr3392273edj.8.1679588289734; Thu, 23 Mar
 2023 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com> <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
In-Reply-To: <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:17:33 -0700
Message-ID: <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 9:10=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Mar 23, 2023 at 8:46=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > [...]
> > > > > > >
> > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > >
> > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usag=
e(). I
> > > > > > > added the protection against flushing in an interrupt context=
 for
> > > > > > > future callers as well, as it may cause a deadlock if we don'=
t disable
> > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > >
> > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() =
is only
> > > > > > > > done for root memcg. Why is mem_cgroup_threshold() interest=
ed in root
> > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_thresh=
old() ?
> > > > > > >
> > > > > > > I am not sure, but the code looks like event notifications ma=
y be set
> > > > > > > up on root memcg, which is why we need to check thresholds.
> > > > > >
> > > > > > This is something we should deprecate as root memcg's usage is =
ill defined.
> > > > >
> > > > > Right, but I think this would be orthogonal to this patch series.
> > > > >
> > > >
> > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling loc=
k
> > > > without either breaking a link between mem_cgroup_threshold and
> > > > cgroup_rstat_lock or make mem_cgroup_threshold work without disabli=
ng
> > > > irqs.
> > > >
> > > > So, this patch can not be applied before either of those two tasks =
are
> > > > done (and we may find more such scenarios).
> > >
> > >
> > > Could you elaborate why?
> > >
> > > My understanding is that with an in_task() check to make sure we only
> > > acquire cgroup_rstat_lock from non-irq context it should be fine to
> > > acquire cgroup_rstat_lock without disabling interrupts.
> >
> > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be taken
> > with irq disabled while other code paths will take cgroup_rstat_lock
> > with irq enabled. This is a potential deadlock hazard unless
> > cgroup_rstat_lock is always taken with irq disabled.
>
> Oh you are making sure it is not taken in the irq context through
> should_skip_flush(). Hmm seems like a hack. Normally it is recommended
> to actually remove all such users instead of silently
> ignoring/bypassing the functionality.

It is a workaround, we simply accept to read stale stats in irq
context instead of the expensive flush operation.

>
> So, how about removing mem_cgroup_flush_stats() from
> mem_cgroup_usage(). It will break the known chain which is taking
> cgroup_rstat_lock with irq disabled and you can add
> WARN_ON_ONCE(!in_task()).

This changes the behavior in a more obvious way because:
1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
path is also exercised in a lot of paths outside irq context, this
will change the behavior for any event thresholds on the root memcg.
With proposed skipped flushing in irq context we only change the
behavior in a small subset of cases.

I think we can skip flushing in irq context for now, and separately
deprecate threshold events for the root memcg. When that is done we
can come back and remove should_skip_flush() and add a VM_BUG_ON or
WARN_ON_ONCE instead. WDYT?

2. mem_cgroup_usage() is also used when reading usage from userspace.
This should be an easy workaround though.
