Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89006C6DD6
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjCWQjJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCWQir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 12:38:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBE3A850
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 09:37:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so89361968ede.8
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679589415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI1OjhppbjxP5gm//hDBy+RdPuj4ToAxdCG6kel4DWE=;
        b=A+p59gcSMpaGuinyKCOkPl7rgUJJ70UmgDqUkVTD3B9rgQ7uHV6j0HDtHmK2b6R8J+
         2/W1xAnGe9EtNhtO3J4UWlZYNadlYe/pQgiFRbc72HImcZJAX4zF33moW/GMZWhD5z2r
         9tIEbrowrjIaYTkv6X9H/wnQxjsoPpkwT4hqIqavlmqQ6bRyNCx8YthG45c3lvwquAjs
         2MQdXNkp0JfThOZdK+pUJdSsddDI72vGYhy7ZNth5151+8iycOuvjTfc1vGbgovDUghT
         XGmNOxuIyQvAxdyTwpxdf/mtm1jm2UDm0hbpIGDh2ACT1/fVvTSV9URC48IavjDL6qaO
         +aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI1OjhppbjxP5gm//hDBy+RdPuj4ToAxdCG6kel4DWE=;
        b=T6DhnfYCgajiqjeW5gY9cUP6VXmO+ulWTYQI6/7FeYPrrz2RtLlDZtpk5BCREGvlap
         MWx5FaXEFj8fxKyW8OF2KunhHx4RgxyJSfIDhdLghcShDI24HbelBe6k1t0k8f11pi9m
         KqDgF2Wovkq+8Djq4lk0cKSwGyhhXnOxSRjvvTHwg3wK4Kz6C2VAgbrVKqljSMldSSDG
         8xSO9qKquBoRPKsTdrQSAnV1HSaOiIamiiGvgwGd50v69oxzzc8N/MEDYyNEtQ+F5Inw
         Ez5rVVxIVwFyz9dIJO2dIVjafKBgodrfd2MKAfc6y+C3Z5SFzek3vIIHCyy4LIeaFKja
         fbgQ==
X-Gm-Message-State: AO0yUKXH1cwxBTUgoWRtPvP4JaBO1bwOvAjPRK2hinNuzUayNBv64yFX
        5SF2FvYR4zSo8S/VazS6uso8eS0v+xLzGUqdNjgiUQ==
X-Google-Smtp-Source: AK7set/zgDFAhT/AM8a6Iyv/UQT+nfT7sT7yCYOdcZTocVNNSH5tLAORJonWRVtQoR3BIHOfcuMdY9wtMzm3fWoaxJM=
X-Received: by 2002:a17:906:bccd:b0:8b1:28f6:8ab3 with SMTP id
 lw13-20020a170906bccd00b008b128f68ab3mr5657477ejb.15.1679589415489; Thu, 23
 Mar 2023 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com> <CALvZod7saq910u4JxnuY4C7EwiK5vgNF=-Bv+236RprUOQdkjw@mail.gmail.com>
In-Reply-To: <CALvZod7saq910u4JxnuY4C7EwiK5vgNF=-Bv+236RprUOQdkjw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:36:19 -0700
Message-ID: <CAJD7tkb8oHoK5RW96tEXjY9iyJpMXfGAvnFw1rG-5Sr+Mpubdg@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 9:29=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Mar 23, 2023 at 9:18=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Mar 23, 2023 at 9:10=E2=80=AFAM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 8:46=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed=
@google.com> wrote:
> > > > > > >
> > > > > > [...]
> > > > > > > > >
> > > > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > > > >
> > > > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_=
usage(). I
> > > > > > > > > added the protection against flushing in an interrupt con=
text for
> > > > > > > > > future callers as well, as it may cause a deadlock if we =
don't disable
> > > > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > > > >
> > > > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usag=
e() is only
> > > > > > > > > > done for root memcg. Why is mem_cgroup_threshold() inte=
rested in root
> > > > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_th=
reshold() ?
> > > > > > > > >
> > > > > > > > > I am not sure, but the code looks like event notification=
s may be set
> > > > > > > > > up on root memcg, which is why we need to check threshold=
s.
> > > > > > > >
> > > > > > > > This is something we should deprecate as root memcg's usage=
 is ill defined.
> > > > > > >
> > > > > > > Right, but I think this would be orthogonal to this patch ser=
ies.
> > > > > > >
> > > > > >
> > > > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling=
 lock
> > > > > > without either breaking a link between mem_cgroup_threshold and
> > > > > > cgroup_rstat_lock or make mem_cgroup_threshold work without dis=
abling
> > > > > > irqs.
> > > > > >
> > > > > > So, this patch can not be applied before either of those two ta=
sks are
> > > > > > done (and we may find more such scenarios).
> > > > >
> > > > >
> > > > > Could you elaborate why?
> > > > >
> > > > > My understanding is that with an in_task() check to make sure we =
only
> > > > > acquire cgroup_rstat_lock from non-irq context it should be fine =
to
> > > > > acquire cgroup_rstat_lock without disabling interrupts.
> > > >
> > > > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be ta=
ken
> > > > with irq disabled while other code paths will take cgroup_rstat_loc=
k
> > > > with irq enabled. This is a potential deadlock hazard unless
> > > > cgroup_rstat_lock is always taken with irq disabled.
> > >
> > > Oh you are making sure it is not taken in the irq context through
> > > should_skip_flush(). Hmm seems like a hack. Normally it is recommende=
d
> > > to actually remove all such users instead of silently
> > > ignoring/bypassing the functionality.
> >
> > It is a workaround, we simply accept to read stale stats in irq
> > context instead of the expensive flush operation.
> >
> > >
> > > So, how about removing mem_cgroup_flush_stats() from
> > > mem_cgroup_usage(). It will break the known chain which is taking
> > > cgroup_rstat_lock with irq disabled and you can add
> > > WARN_ON_ONCE(!in_task()).
> >
> > This changes the behavior in a more obvious way because:
> > 1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
> > path is also exercised in a lot of paths outside irq context, this
> > will change the behavior for any event thresholds on the root memcg.
> > With proposed skipped flushing in irq context we only change the
> > behavior in a small subset of cases.
> >
> > I think we can skip flushing in irq context for now, and separately
> > deprecate threshold events for the root memcg. When that is done we
> > can come back and remove should_skip_flush() and add a VM_BUG_ON or
> > WARN_ON_ONCE instead. WDYT?
> >
> > 2. mem_cgroup_usage() is also used when reading usage from userspace.
> > This should be an easy workaround though.
>
> This is a cgroup v1 behavior and to me it is totally reasonable to get
> the 2 second stale root's usage. Even if you want to skip flushing in
> irq, do that in the memcg code and keep VM_BUG_ON/WARN_ON_ONCE in the
> rstat core code. This way we will know if other subsystems are doing
> the same or not.

We can do that. Basically in mem_cgroup_usage() have:

/* Some useful comment */
if (in_task())
    mem_cgroup_flush_stats();

and in cgroup_rstat_flush() have:
WARN_ON_ONCE(!in_task());

I am assuming VM_BUG_ON is not used outside mm code.

The only thing that worries me is that if there is another unlikely
path somewhere that flushes stats in irq context we may run into a
deadlock. I am a little bit nervous about not skipping flushing if
!in_task() in cgroup_rstat_flush().
