Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2270EB65
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEXCiO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjEXCiM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 22:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D0E6
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684895846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7efy8ggOY6sESWoSThIrMDxn343AAutiYwYWesVcCYU=;
        b=g/H8IQZQXrdrvHiRD7uP9znaH9wZCaIX2tEWTK/XWxdRpoXiMJyK+a1hDqeSKce9Xi8Oys
        nBEy4BjUKTBAmddiwzF0fRbmqPYiTbuzzADkYuAdWe0JpRMuGkouS+afEUnyjIfbfVgIEg
        5cNdwCjOP1c7gS3A5G8R7UP9mafBjt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-nTKsjYuLOkuX3Yf8ITjjdg-1; Tue, 23 May 2023 22:37:23 -0400
X-MC-Unique: nTKsjYuLOkuX3Yf8ITjjdg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A577A101A53A;
        Wed, 24 May 2023 02:37:22 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1E5492B00;
        Wed, 24 May 2023 02:37:14 +0000 (UTC)
Date:   Wed, 24 May 2023 10:37:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
        ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

On Tue, May 23, 2023 at 07:06:38PM -0700, Yosry Ahmed wrote:
> Hi Ming,
> 
> On Tue, May 23, 2023 at 6:21 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > As noted by Michal, the blkg_iostat_set's in the lockless list
> > hold reference to blkg's to protect against their removal. Those
> > blkg's hold reference to blkcg. When a cgroup is being destroyed,
> > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > is called when the blkcg reference count reaches 0. This circular
> > dependency will prevent blkcg and some blkgs from being freed after
> > they are made offline.
> 
> I am not at all familiar with blkcg, but does calling
> cgroup_rstat_flush() in offline_css() fix the problem?

Except for offline, this list needs to be flushed after the associated disk
is deleted.

> or can items be
> added to the lockless list(s) after the blkcg is offlined?

Yeah.

percpu_ref_*get(&blkg->refcnt) still can succeed after the percpu refcnt
is killed in blkg_destroy() which is called from both offline css and
removing disk.

> 
> >
> > It is less a problem if the cgroup to be destroyed also has other
> > controllers like memory that will call cgroup_rstat_flush() which will
> > clean up the reference count. If block is the only controller that uses
> > rstat, these offline blkcg and blkgs may never be freed leaking more
> > and more memory over time.
> >
> > To prevent this potential memory leak:
> >
> > - a new cgroup_rstat_css_cpu_flush() function is added to flush stats for
> > a given css and cpu. This new function will be called in __blkg_release().
> >
> > - don't grab bio->bi_blkg when adding the stats into blkcg's per-cpu
> > stat list, and this kind of handling is the most fragile part of
> > original patch
> >
> > Based on Waiman's patch:
> >
> > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> >
> > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: cgroups@vger.kernel.org
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: mkoutny@suse.com
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-cgroup.c     | 15 +++++++++++++--
> >  include/linux/cgroup.h |  1 +
> >  kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
> >  3 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 0ce64dd73cfe..5437b6af3955 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -163,10 +163,23 @@ static void blkg_free(struct blkcg_gq *blkg)
> >  static void __blkg_release(struct rcu_head *rcu)
> >  {
> >         struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
> > +       struct blkcg *blkcg = blkg->blkcg;
> > +       int cpu;
> >
> >  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
> >         WARN_ON(!bio_list_empty(&blkg->async_bios));
> >  #endif
> > +       /*
> > +        * Flush all the non-empty percpu lockless lists before releasing
> > +        * us. Meantime no new bio can refer to this blkg any more given
> > +        * the refcnt is killed.
> > +        */
> > +       for_each_possible_cpu(cpu) {
> > +               struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> > +
> > +               if (!llist_empty(lhead))
> > +                       cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> > +       }
> >
> >         /* release the blkcg and parent blkg refs this blkg has been holding */
> >         css_put(&blkg->blkcg->css);
> > @@ -991,7 +1004,6 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> >                 if (parent && parent->parent)
> >                         blkcg_iostat_update(parent, &blkg->iostat.cur,
> >                                             &blkg->iostat.last);
> > -               percpu_ref_put(&blkg->refcnt);
> >         }
> >
> >  out:
> > @@ -2075,7 +2087,6 @@ void blk_cgroup_bio_start(struct bio *bio)
> >
> >                 llist_add(&bis->lnode, lhead);
> >                 WRITE_ONCE(bis->lqueued, true);
> > -               percpu_ref_get(&bis->blkg->refcnt);
> >         }
> >
> >         u64_stats_update_end_irqrestore(&bis->sync, flags);
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index 885f5395fcd0..97d4764d8e6a 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -695,6 +695,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
> >  void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
> >  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
> >  void cgroup_rstat_flush_release(void);
> > +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu);
> >
> >  /*
> >   * Basic resource stats.
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index 9c4c55228567..96e7a4e6da72 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -281,6 +281,24 @@ void cgroup_rstat_flush_release(void)
> >         spin_unlock_irq(&cgroup_rstat_lock);
> >  }
> >
> > +/**
> > + * cgroup_rstat_css_cpu_flush - flush stats for the given css and cpu
> > + * @css: target css to be flush
> > + * @cpu: the cpu that holds the stats to be flush
> > + *
> > + * A lightweight rstat flush operation for a given css and cpu.
> > + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
> > + * isn't used.
> 
> (Adding linux-mm and memcg maintainers)
> +Linux-MM +Michal Hocko +Shakeel Butt +Johannes Weiner +Roman Gushchin
> +Muchun Song
> 
> I don't think flushing the stats without holding cgroup_rstat_lock is
> safe for memcg stats flushing. mem_cgroup_css_rstat_flush() modifies
> some non-percpu data (e.g. memcg->vmstats->state,
> memcg->vmstats->state_pending).
> 
> Perhaps have this be a separate callback than css_rstat_flush() (e.g.
> css_rstat_flush_cpu() or something), so that it's clear what
> subsystems support this? In this case, only blkcg would implement this
> callback.

Also I guess cgroup_rstat_flush() can be used here too.

BTW, cgroup_rstat_flush() is annotated as might_sleep(), however it won't
sleep actually, so can this might_sleep() be removed?

> 
> > + */
> > +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu)
> > +{
> > +       raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> > +
> > +       raw_spin_lock_irq(cpu_lock);
> > +       css->ss->css_rstat_flush(css, cpu);
> 
> I think we need to check that css_rstat_flush() (or a new callback) is
> implemented before calling it here.

Good catch!



Thanks,
Ming

