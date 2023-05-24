Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC070EB19
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 04:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjEXCHS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEXCHR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 22:07:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEA13E
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 19:07:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f588bc322so47114766b.1
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 19:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684894034; x=1687486034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5dfPBvx6aG61cOeQLMS4GIwmjHbkXMXy0MM0cC9oLc=;
        b=SPBe4uEiMI2jCR4eHyxy57SIWXSCKmjMRhgWthenPoHjHzpBejlAiDsDQd7XBehg9G
         2D8suTsf58iU+5W1sQ8+9rWD8jnOtEI202+Cbur5SoY3b9v2rJVWLr6fLJmi6vQeCroy
         Bh7aWdzGwI4tJmXQUSlF1ZZeZIXXqXFZJ4JVpuGAw3gW2JBDvvUSPY2AW/bQ2XgBJM7x
         k6e7mBeqcXmpYuEqB4F5KmaED/uPuu3uQU3bv2WzHzkuB0PL625tsWPYqD0ZQzgs+Km/
         3XTXX0bLWUdrJzxpaMNKlOxVltJuQyufcaO+ZgBwP0geilnrGkFY0fsjhLlY1oNoxto8
         SKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684894034; x=1687486034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5dfPBvx6aG61cOeQLMS4GIwmjHbkXMXy0MM0cC9oLc=;
        b=D7hIS83EWt/LVStHt0f5zihkXOFe6KWWmCbLlv3+OacViuuqm+azuiIPgk3AvUcUkD
         SaH52h5YoL0a4vYxw/HPkp5+ZmrUBSNqmslY5jGJpGVBHwGeW2sQG40luJmT5oU1KKQN
         4r+nykCI2gICWn+l4z68Uf/qWFKWM1fPTNdXqtptDxb32v3KPEH15CKXE9qVd+rKiBOT
         k9389nQ8MCranMHkwMu875HWDuhvg7PXhfQgCQvz6S1TY1NNQnKWKT6CFC6ATujYM3So
         d+228rzXPRlOUYjxOCX49PypG5HOeyNSZtbROMRxlGdN9QEs5hByYKWwJThU47NA2TGa
         Jxww==
X-Gm-Message-State: AC+VfDx7wtUzf5GNYGkcJ2fnMSkK0CDOODNVpEgMNdKbbH65xoU2xBWd
        /YZNowYiP1VwmQ7tWDar/P4ZZQKHiiymvAAPFKaIyg==
X-Google-Smtp-Source: ACHHUZ5Otych3q6h2UGWE4sOweDTcCjyfpqtgf2uKuIfsUHXcTvByotJN9SHYFyKqkzusZtmjvRIBCszRVALwzIYMis=
X-Received: by 2002:a17:907:75fb:b0:968:c38f:5481 with SMTP id
 jz27-20020a17090775fb00b00968c38f5481mr14112330ejc.51.1684894034316; Tue, 23
 May 2023 19:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230524011935.719659-1-ming.lei@redhat.com>
In-Reply-To: <20230524011935.719659-1-ming.lei@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 23 May 2023 19:06:38 -0700
Message-ID: <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
To:     Ming Lei <ming.lei@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Ming,

On Tue, May 23, 2023 at 6:21=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> As noted by Michal, the blkg_iostat_set's in the lockless list
> hold reference to blkg's to protect against their removal. Those
> blkg's hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which
> is called when the blkcg reference count reaches 0. This circular
> dependency will prevent blkcg and some blkgs from being freed after
> they are made offline.

I am not at all familiar with blkcg, but does calling
cgroup_rstat_flush() in offline_css() fix the problem? or can items be
added to the lockless list(s) after the blkcg is offlined?

>
> It is less a problem if the cgroup to be destroyed also has other
> controllers like memory that will call cgroup_rstat_flush() which will
> clean up the reference count. If block is the only controller that uses
> rstat, these offline blkcg and blkgs may never be freed leaking more
> and more memory over time.
>
> To prevent this potential memory leak:
>
> - a new cgroup_rstat_css_cpu_flush() function is added to flush stats for
> a given css and cpu. This new function will be called in __blkg_release()=
.
>
> - don't grab bio->bi_blkg when adding the stats into blkcg's per-cpu
> stat list, and this kind of handling is the most fragile part of
> original patch
>
> Based on Waiman's patch:
>
> https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redha=
t.com/
>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Cc: Waiman Long <longman@redhat.com>
> Cc: cgroups@vger.kernel.org
> Cc: Tejun Heo <tj@kernel.org>
> Cc: mkoutny@suse.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-cgroup.c     | 15 +++++++++++++--
>  include/linux/cgroup.h |  1 +
>  kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
>  3 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 0ce64dd73cfe..5437b6af3955 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -163,10 +163,23 @@ static void blkg_free(struct blkcg_gq *blkg)
>  static void __blkg_release(struct rcu_head *rcu)
>  {
>         struct blkcg_gq *blkg =3D container_of(rcu, struct blkcg_gq, rcu_=
head);
> +       struct blkcg *blkcg =3D blkg->blkcg;
> +       int cpu;
>
>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>         WARN_ON(!bio_list_empty(&blkg->async_bios));
>  #endif
> +       /*
> +        * Flush all the non-empty percpu lockless lists before releasing
> +        * us. Meantime no new bio can refer to this blkg any more given
> +        * the refcnt is killed.
> +        */
> +       for_each_possible_cpu(cpu) {
> +               struct llist_head *lhead =3D per_cpu_ptr(blkcg->lhead, cp=
u);
> +
> +               if (!llist_empty(lhead))
> +                       cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> +       }
>
>         /* release the blkcg and parent blkg refs this blkg has been hold=
ing */
>         css_put(&blkg->blkcg->css);
> @@ -991,7 +1004,6 @@ static void blkcg_rstat_flush(struct cgroup_subsys_s=
tate *css, int cpu)
>                 if (parent && parent->parent)
>                         blkcg_iostat_update(parent, &blkg->iostat.cur,
>                                             &blkg->iostat.last);
> -               percpu_ref_put(&blkg->refcnt);
>         }
>
>  out:
> @@ -2075,7 +2087,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>
>                 llist_add(&bis->lnode, lhead);
>                 WRITE_ONCE(bis->lqueued, true);
> -               percpu_ref_get(&bis->blkg->refcnt);
>         }
>
>         u64_stats_update_end_irqrestore(&bis->sync, flags);
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 885f5395fcd0..97d4764d8e6a 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -695,6 +695,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
>  void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
>  void cgroup_rstat_flush_release(void);
> +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu=
);
>
>  /*
>   * Basic resource stats.
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 9c4c55228567..96e7a4e6da72 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -281,6 +281,24 @@ void cgroup_rstat_flush_release(void)
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> +/**
> + * cgroup_rstat_css_cpu_flush - flush stats for the given css and cpu
> + * @css: target css to be flush
> + * @cpu: the cpu that holds the stats to be flush
> + *
> + * A lightweight rstat flush operation for a given css and cpu.
> + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rsta=
t_lock
> + * isn't used.

(Adding linux-mm and memcg maintainers)
+Linux-MM +Michal Hocko +Shakeel Butt +Johannes Weiner +Roman Gushchin
+Muchun Song

I don't think flushing the stats without holding cgroup_rstat_lock is
safe for memcg stats flushing. mem_cgroup_css_rstat_flush() modifies
some non-percpu data (e.g. memcg->vmstats->state,
memcg->vmstats->state_pending).

Perhaps have this be a separate callback than css_rstat_flush() (e.g.
css_rstat_flush_cpu() or something), so that it's clear what
subsystems support this? In this case, only blkcg would implement this
callback.

> + */
> +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu=
)
> +{
> +       raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lock, =
cpu);
> +
> +       raw_spin_lock_irq(cpu_lock);
> +       css->ss->css_rstat_flush(css, cpu);

I think we need to check that css_rstat_flush() (or a new callback) is
implemented before calling it here.


> +       raw_spin_unlock_irq(cpu_lock);
> +}
> +
>  int cgroup_rstat_init(struct cgroup *cgrp)
>  {
>         int cpu;
> --
> 2.40.1
>
