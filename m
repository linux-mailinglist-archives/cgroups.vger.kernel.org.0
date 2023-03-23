Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2197E6C701D
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCWSTd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjCWSTb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 14:19:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAB1B9
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 11:19:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g19so2488443qts.9
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679595566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4UdIOBBpU5M34Q+dnxHktyTShJiu1SyYtXU+zhX+XRQ=;
        b=iSci0p8JFRPXqHPEil3M1UZ/AptTFLyiH4nOONlx8jlszjb2lxcuRkMBw7UZXMYuIb
         9VHiSPLwsHCGWKxBshnY3dxP8I+VjQfUKrOS8QxSItXdSt2WijBjz2KEim5klCxbUPhR
         gr9geE8sgGsa6YxvHsaCLYHtCOhtZ6Cj5uxcAZqUHM/Oo9TpSV6LTpCjwajd0gTTy2/o
         iGV78mzHEJs46abGoP8FjHVkdxrPvpdUU0X6sI4iRzWXH+1PxvpLLlNb42LXVJdJuGZu
         4FeSqA110YAy7/7r+UTZpX1+gN+1sKQK2Ig4sSlYBcZ1rci0KNN0Hu5Nnn+hpheYoXSX
         jdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679595566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UdIOBBpU5M34Q+dnxHktyTShJiu1SyYtXU+zhX+XRQ=;
        b=UucA7TYr6BzafcYd0aFHenk8mUBWNF5e21b4EYIIWsx34E93gfhUfKM97MZCN434Qf
         iUILbN+RoWeImIu4aasDOBAqefv4HMXcDhAGvfxauH4ep73QIk10YTInR+8jiHGXP9Ch
         CkI9yhurHy+TvhClPiM36qhnXXVBfU473VPZtCiaGMzahBplTEjCFZRWrzl9tDs3TE6H
         7FSY2zPxIXxBiagYaMW0r1Yg3N0pS05QiUnMQz4x21aGdywHKTsBDMd1iInvxBa7cKHI
         aO0bOzkfM4A1iUvH2OIdWmuZw0ocTnAfxX5DX6PhHuo841rh5gU02pCzDa+iEoHvvlUh
         BJGA==
X-Gm-Message-State: AO0yUKV6p3XeXN70vi050mjfOFFRB8d+nXvcmREHru/tYqjx+A+z9scn
        +PsJUs92VV1LojUJPnfvHxhKLw==
X-Google-Smtp-Source: AK7set9X6TOXaFdht8hm7kOrpFUZVVpedAsVNDkKxUnVmus8Zt4lWACuNapirPGhMz9HPMD31ZR6Hw==
X-Received: by 2002:a05:622a:15d2:b0:3e3:8502:fbcb with SMTP id d18-20020a05622a15d200b003e38502fbcbmr394669qty.40.1679595566584;
        Thu, 23 Mar 2023 11:19:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id f16-20020ac86ed0000000b003e390b48958sm1837405qtv.55.2023.03.23.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:19:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:19:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Message-ID: <20230323181925.GA742010@cmpxchg.org>
References: <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
 <20230323173343.GF739026@cmpxchg.org>
 <CAJD7tkb_Zpp4PqFNBJ3__7t5eiYwuqaZc=08B1g=S_tMF+wgSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb_Zpp4PqFNBJ3__7t5eiYwuqaZc=08B1g=S_tMF+wgSQ@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 11:09:30AM -0700, Yosry Ahmed wrote:
> On Thu, Mar 23, 2023 at 10:33 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 23, 2023 at 09:17:33AM -0700, Yosry Ahmed wrote:
> > > On Thu, Mar 23, 2023 at 9:10 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 8:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 8:43 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 23, 2023 at 8:40 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 23, 2023 at 6:36 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > > >
> > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > > > > >
> > > > > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> > > > > > > > > > added the protection against flushing in an interrupt context for
> > > > > > > > > > future callers as well, as it may cause a deadlock if we don't disable
> > > > > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > > > > >
> > > > > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> > > > > > > > > > > done for root memcg. Why is mem_cgroup_threshold() interested in root
> > > > > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
> > > > > > > > > >
> > > > > > > > > > I am not sure, but the code looks like event notifications may be set
> > > > > > > > > > up on root memcg, which is why we need to check thresholds.
> > > > > > > > >
> > > > > > > > > This is something we should deprecate as root memcg's usage is ill defined.
> > > > > > > >
> > > > > > > > Right, but I think this would be orthogonal to this patch series.
> > > > > > > >
> > > > > > >
> > > > > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling lock
> > > > > > > without either breaking a link between mem_cgroup_threshold and
> > > > > > > cgroup_rstat_lock or make mem_cgroup_threshold work without disabling
> > > > > > > irqs.
> > > > > > >
> > > > > > > So, this patch can not be applied before either of those two tasks are
> > > > > > > done (and we may find more such scenarios).
> > > > > >
> > > > > >
> > > > > > Could you elaborate why?
> > > > > >
> > > > > > My understanding is that with an in_task() check to make sure we only
> > > > > > acquire cgroup_rstat_lock from non-irq context it should be fine to
> > > > > > acquire cgroup_rstat_lock without disabling interrupts.
> > > > >
> > > > > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be taken
> > > > > with irq disabled while other code paths will take cgroup_rstat_lock
> > > > > with irq enabled. This is a potential deadlock hazard unless
> > > > > cgroup_rstat_lock is always taken with irq disabled.
> > > >
> > > > Oh you are making sure it is not taken in the irq context through
> > > > should_skip_flush(). Hmm seems like a hack. Normally it is recommended
> > > > to actually remove all such users instead of silently
> > > > ignoring/bypassing the functionality.
> >
> > +1
> >
> > It shouldn't silently skip the requested operation, rather it
> > shouldn't be requested from an incompatible context.
> >
> > > > So, how about removing mem_cgroup_flush_stats() from
> > > > mem_cgroup_usage(). It will break the known chain which is taking
> > > > cgroup_rstat_lock with irq disabled and you can add
> > > > WARN_ON_ONCE(!in_task()).
> > >
> > > This changes the behavior in a more obvious way because:
> > > 1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
> > > path is also exercised in a lot of paths outside irq context, this
> > > will change the behavior for any event thresholds on the root memcg.
> > > With proposed skipped flushing in irq context we only change the
> > > behavior in a small subset of cases.
> >
> > Can you do
> >
> >         /* Note: stale usage data when called from irq context!! */
> >         if (in_task())
> >                 mem_cgroup_flush_stats()
> >
> > directly in the callsite? Maybe even include the whole callchain in
> > the comment that's currently broken and needs fixing/removing.
> 
> Yeah, we can do that in mem_cgroup_usage(), which is the only context
> that I am aware of that may flush from irq context. We can also add
> WARN_ON_ONCE(!in_task()) in the rstat core flushing code to catch any
> other code paths that we are not aware of -- which may result in a
> deadlock, but hopefully if there is a violation it will be caught soon
> enough.

That sounds good to me, thanks!

