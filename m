Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDDF70EB79
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 04:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjEXCoE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbjEXCoD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 22:44:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8EE6
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 19:44:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f7377c86aso58429966b.1
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684896239; x=1687488239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDFmGd7gRLIyIyQ94Db9al5d+TsERu2E8WF1J8USfBI=;
        b=KmUGnXLB6gEP77qIOVlPQeghHtKBGpH3Ef2X2IQo3Edwq8bNA+ml+h9uUIm7XqmPyr
         etHLOHHHJWKLIym/XRC7aUMcLYcTl2FPkpONf9VghCFR+MTiF6tfv5zQrf3kObGoexDv
         suioINXnpng1xZ15B9PB7xcVIhWyNAlVfES3UVd7dHI6i6nQvBFSthhC9dh0nsoBRDAm
         4/HK6xpRTrXUzyv3Qqjsl42a+goqFMxm68TiUJNjgFR4om+yfX0KxehlCKMzrOXvpjDb
         mgV/HrGJ15rRkmt1vU+wXJgq339CYF7Eg0TMo7kfsvQChM4LuQyEb3DScoTQLYlB6ZA/
         pZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684896239; x=1687488239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDFmGd7gRLIyIyQ94Db9al5d+TsERu2E8WF1J8USfBI=;
        b=QJm1kTxH3C7PYQXHcyzyXnMgvt94ScGgD2ZMKRe/MKtOLZgOevs+X160e4FbRwdUzc
         kIXRvtKSYlYwV9kg73WWNsbpbw+LPm13hQ3tRLCgRRCYDVb/rbhghvYSYU8LglevYIiv
         9gOEqac6Lv3/y2MYI8lEpKWXt6AoKkYNlkptHgQQzEQon7FVV/vwl5vxs0FYyc99tcQP
         Ra5CNggdbglwdezbbAVlMjj0VapEChttON21J9XbQifj4NHwEtFjkYLEFoVuSauH13s3
         gYjk9V0ubBZu91surJs8Dc/7wZ94wsYHKEteYM6J678V3kbGZffStkgC+l14cJIqBShd
         EZkg==
X-Gm-Message-State: AC+VfDy50h24fpv9yW3mmX7aAdanMC8J+u4w2LrVhMljuGsLrWuhRY0n
        SUVLnzDU3pumyEmysv24Bvw3MNBMKpdkxPf4HoJntg==
X-Google-Smtp-Source: ACHHUZ5yR3inzXdaLk0gDYliyDDAk95PNx9VjPM2tSyIvoBTv3A0EKiNh1kMJukUuOpKLX4O163Atlyq4UxPQwNYkzM=
X-Received: by 2002:a17:907:7faa:b0:973:7576:bed3 with SMTP id
 qk42-20020a1709077faa00b009737576bed3mr1693165ejc.47.1684896239150; Tue, 23
 May 2023 19:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230524011935.719659-1-ming.lei@redhat.com> <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
In-Reply-To: <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 23 May 2023 19:43:22 -0700
Message-ID: <CAJD7tkbuGZJ_g8eLFbk2+G1_LRVdNwr5Tw2Y6AaMxofJWjdTWw@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 23, 2023 at 7:37=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hi Yosry,
>
> On Tue, May 23, 2023 at 07:06:38PM -0700, Yosry Ahmed wrote:
> > Hi Ming,
> >
> > On Tue, May 23, 2023 at 6:21=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > As noted by Michal, the blkg_iostat_set's in the lockless list
> > > hold reference to blkg's to protect against their removal. Those
> > > blkg's hold reference to blkcg. When a cgroup is being destroyed,
> > > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > > is called when the blkcg reference count reaches 0. This circular
> > > dependency will prevent blkcg and some blkgs from being freed after
> > > they are made offline.
> >
> > I am not at all familiar with blkcg, but does calling
> > cgroup_rstat_flush() in offline_css() fix the problem?
>
> Except for offline, this list needs to be flushed after the associated di=
sk
> is deleted.
>
> > or can items be
> > added to the lockless list(s) after the blkcg is offlined?
>
> Yeah.
>
> percpu_ref_*get(&blkg->refcnt) still can succeed after the percpu refcnt
> is killed in blkg_destroy() which is called from both offline css and
> removing disk.

I see.

>
> >
> > >
> > > It is less a problem if the cgroup to be destroyed also has other
> > > controllers like memory that will call cgroup_rstat_flush() which wil=
l
> > > clean up the reference count. If block is the only controller that us=
es
> > > rstat, these offline blkcg and blkgs may never be freed leaking more
> > > and more memory over time.
> > >
> > > To prevent this potential memory leak:
> > >
> > > - a new cgroup_rstat_css_cpu_flush() function is added to flush stats=
 for
> > > a given css and cpu. This new function will be called in __blkg_relea=
se().
> > >
> > > - don't grab bio->bi_blkg when adding the stats into blkcg's per-cpu
> > > stat list, and this kind of handling is the most fragile part of
> > > original patch
> > >
> > > Based on Waiman's patch:
> > >
> > > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@r=
edhat.com/
> > >
> > > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: cgroups@vger.kernel.org
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: mkoutny@suse.com
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  block/blk-cgroup.c     | 15 +++++++++++++--
> > >  include/linux/cgroup.h |  1 +
> > >  kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
> > >  3 files changed, 32 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > index 0ce64dd73cfe..5437b6af3955 100644
> > > --- a/block/blk-cgroup.c
> > > +++ b/block/blk-cgroup.c
> > > @@ -163,10 +163,23 @@ static void blkg_free(struct blkcg_gq *blkg)
> > >  static void __blkg_release(struct rcu_head *rcu)
> > >  {
> > >         struct blkcg_gq *blkg =3D container_of(rcu, struct blkcg_gq, =
rcu_head);
> > > +       struct blkcg *blkcg =3D blkg->blkcg;
> > > +       int cpu;
> > >
> > >  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
> > >         WARN_ON(!bio_list_empty(&blkg->async_bios));
> > >  #endif
> > > +       /*
> > > +        * Flush all the non-empty percpu lockless lists before relea=
sing
> > > +        * us. Meantime no new bio can refer to this blkg any more gi=
ven
> > > +        * the refcnt is killed.
> > > +        */
> > > +       for_each_possible_cpu(cpu) {
> > > +               struct llist_head *lhead =3D per_cpu_ptr(blkcg->lhead=
, cpu);
> > > +
> > > +               if (!llist_empty(lhead))
> > > +                       cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> > > +       }
> > >
> > >         /* release the blkcg and parent blkg refs this blkg has been =
holding */
> > >         css_put(&blkg->blkcg->css);
> > > @@ -991,7 +1004,6 @@ static void blkcg_rstat_flush(struct cgroup_subs=
ys_state *css, int cpu)
> > >                 if (parent && parent->parent)
> > >                         blkcg_iostat_update(parent, &blkg->iostat.cur=
,
> > >                                             &blkg->iostat.last);
> > > -               percpu_ref_put(&blkg->refcnt);
> > >         }
> > >
> > >  out:
> > > @@ -2075,7 +2087,6 @@ void blk_cgroup_bio_start(struct bio *bio)
> > >
> > >                 llist_add(&bis->lnode, lhead);
> > >                 WRITE_ONCE(bis->lqueued, true);
> > > -               percpu_ref_get(&bis->blkg->refcnt);
> > >         }
> > >
> > >         u64_stats_update_end_irqrestore(&bis->sync, flags);
> > > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > > index 885f5395fcd0..97d4764d8e6a 100644
> > > --- a/include/linux/cgroup.h
> > > +++ b/include/linux/cgroup.h
> > > @@ -695,6 +695,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
> > >  void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
> > >  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
> > >  void cgroup_rstat_flush_release(void);
> > > +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int=
 cpu);
> > >
> > >  /*
> > >   * Basic resource stats.
> > > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > > index 9c4c55228567..96e7a4e6da72 100644
> > > --- a/kernel/cgroup/rstat.c
> > > +++ b/kernel/cgroup/rstat.c
> > > @@ -281,6 +281,24 @@ void cgroup_rstat_flush_release(void)
> > >         spin_unlock_irq(&cgroup_rstat_lock);
> > >  }
> > >
> > > +/**
> > > + * cgroup_rstat_css_cpu_flush - flush stats for the given css and cp=
u
> > > + * @css: target css to be flush
> > > + * @cpu: the cpu that holds the stats to be flush
> > > + *
> > > + * A lightweight rstat flush operation for a given css and cpu.
> > > + * Only the cpu_lock is being held for mutual exclusion, the cgroup_=
rstat_lock
> > > + * isn't used.
> >
> > (Adding linux-mm and memcg maintainers)
> > +Linux-MM +Michal Hocko +Shakeel Butt +Johannes Weiner +Roman Gushchin
> > +Muchun Song
> >
> > I don't think flushing the stats without holding cgroup_rstat_lock is
> > safe for memcg stats flushing. mem_cgroup_css_rstat_flush() modifies
> > some non-percpu data (e.g. memcg->vmstats->state,
> > memcg->vmstats->state_pending).
> >
> > Perhaps have this be a separate callback than css_rstat_flush() (e.g.
> > css_rstat_flush_cpu() or something), so that it's clear what
> > subsystems support this? In this case, only blkcg would implement this
> > callback.
>
> Also I guess cgroup_rstat_flush() can be used here too.

If we don't really care about flushing other subsystems, then yeah
that would be a simpler approach.

>
> BTW, cgroup_rstat_flush() is annotated as might_sleep(), however it won't
> sleep actually, so can this might_sleep() be removed?

It will actually sleep if may_sleep=3Dtrue, and I have a change in
Andrew's MM tree that removes that *_atomic() variant and makes it
always sleepable.

In cgroup_rstat_flush_locked(), if need_resched() or
spin_needbreak(&cgroup_rstat_lock), we release the lock, reschedule,
and then re-acquire it.

>
> >
> > > + */
> > > +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int=
 cpu)
> > > +{
> > > +       raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lo=
ck, cpu);
> > > +
> > > +       raw_spin_lock_irq(cpu_lock);
> > > +       css->ss->css_rstat_flush(css, cpu);
> >
> > I think we need to check that css_rstat_flush() (or a new callback) is
> > implemented before calling it here.
>
> Good catch!
>
>
>
> Thanks,
> Ming
>
