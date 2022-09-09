Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732DC5B3DC4
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIIROx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Sep 2022 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIIROu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Sep 2022 13:14:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF43632ABE
        for <cgroups@vger.kernel.org>; Fri,  9 Sep 2022 10:14:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so2228452pjf.2
        for <cgroups@vger.kernel.org>; Fri, 09 Sep 2022 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=YEKmBV4DSzD2JzeAdPDODbMxDTccaOdJer2Iy9wMS0Y=;
        b=KLtgJv7vnGcaTzYuJKcaPa8SvcX/RhNHCSwGuaj4IxlzcD/vIVBFio3ImKjzb/N58H
         cAGtKDcLeIJ3xxrnwtHxjnFvWHoH2mZCthaFL3jmWfciibNLiFYWrzxT5pYp/hLEduTS
         uxgqJNnfnC3nD8h2/vfLu90tEtccsyTcif0rhGug4TKEbT/jh0MV2XwBQJBNDqGo/rGw
         HBU5H+cDuBLQV30w68xQK5yjGJBXxR0lsg4X63gyCuM37CnQvYQBoYjnm1pMvb44aEQ1
         HGlwzLWYuouZ4QeoCZXhr9Sn7kmwC2feqcLF+o9HC8netoigO7OWALeUIHKWsMtQ8KtZ
         kNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YEKmBV4DSzD2JzeAdPDODbMxDTccaOdJer2Iy9wMS0Y=;
        b=5YLQlYy7HnkZd1f52DzJZ78YUwk8TLNWUAHI/YwUW8KFfSxD9YrvLYiAxC6qz+Q0jg
         yhrjM6IrMocrD7JOOdcKBnW8GomD6kZjFd7VXtLRTn84Xo2rzicDJgOc6GWv2hV8duts
         JQgU2dG63rJ3DXvfKOMGxERjTBsgLqKeCOG9Qxa/wB9eFaluHYRE7rzDgzB+Vzl3zG5o
         P87o13Jjhby/LEGqaHf84xtxhiQekzXW+lgjoQaV1UeyemBTDQs62br8h0IaeBqA6N+J
         m2WoDCn1gbtqCJkkoDyQ16h0Hg53KC+qR9VHJsL9hKQbTyTCcqE8zF805yJwdX77Xs+l
         qtkw==
X-Gm-Message-State: ACgBeo08SzY4TPXTS+oD+O3puBgfgtPzEAqjUNgkDfMKG6cQZB3roftO
        SGB819qRPQ5+SRF70Na4bpAS7h1ttajX7X9+awVnaQ==
X-Google-Smtp-Source: AA6agR5jylr5OQENt0kT516KW7ewiTtqcbXKe3dDVusp1bWOS1xBVMVmefziS2+mJmseLymBSou+GE2+RtyoHhmyXWI=
X-Received: by 2002:a17:90b:388e:b0:1fb:62c1:9cb7 with SMTP id
 mu14-20020a17090b388e00b001fb62c19cb7mr10342720pjb.207.1662743687147; Fri, 09
 Sep 2022 10:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com> <20220907043537.3457014-4-shakeelb@google.com>
 <YxqHZtOx2+LUYZth@blackbook>
In-Reply-To: <YxqHZtOx2+LUYZth@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Sep 2022 10:14:35 -0700
Message-ID: <CALvZod5XGH6MzMhqQfLPtD4zXdSNk_EptGN17Gmp-N8HM8Fjkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Sep 8, 2022 at 5:23 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Wed, Sep 07, 2022 at 04:35:37AM +0000, Shakeel Butt <shakeelb@google.c=
om> wrote:
> >  /* Subset of vm_event_item to report for memcg event stats */
> >  static const unsigned int memcg_vm_event_stat[] =3D {
> > +     PGPGIN,
> > +     PGPGOUT,
> >       PGSCAN_KSWAPD,
> >       PGSCAN_DIRECT,
> >       PGSTEAL_KSWAPD,
>
> What about adding a dummy entry at the beginning like:
>
>  static const unsigned int memcg_vm_event_stat[] =3D {
> +       NR_VM_EVENT_ITEMS,
> +       PGPGIN,
> +       PGPGOUT,
>         PGSCAN_KSWAPD,
>         PGSCAN_DIRECT,
>
>
> > @@ -692,14 +694,30 @@ static const unsigned int memcg_vm_event_stat[] =
=3D {
> >  #endif
> >  };
> >
> > +#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
> > +static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
> > +
> > +static void init_memcg_events(void)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < NR_MEMCG_EVENTS; ++i)
> > +             mem_cgroup_events_index[memcg_vm_event_stat[i]] =3D i + 1=
;
>
> Start such loops from i =3D 1, save i to the table.
>
> > +}
> > +
> > +static inline int memcg_events_index(enum vm_event_item idx)
> > +{
> > +     return mem_cgroup_events_index[idx] - 1;
> > +}
>
> And the there'd be no need for the reverse transforms -1.
>
> I.e. it might be just a negligible micro-optimization but since the
> event updates are on some fast (albeit longer) paths, it may be worth
> sacrificing one of the saved 8Bs in favor of no arithmetics.
>
> What do you think about this?
>
> >  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
> >  {
> > -     return READ_ONCE(memcg->vmstats->events[event]);
> > +     int index =3D memcg_events_index(event);
> > +
> > +     if (index < 0)
> > +             return 0;
>
> As a bonus these undefined maps could use the zero at the dummy location
> without branch (slow paths though).
>
>
> > @@ -5477,7 +5511,7 @@ static void mem_cgroup_css_rstat_flush(struct cgr=
oup_subsys_state *css, int cpu)
> >                       parent->vmstats->state_pending[i] +=3D delta;
> >       }
> >
> > -     for (i =3D 0; i < NR_VM_EVENT_ITEMS; i++) {
> > +     for (i =3D 0; i < NR_MEMCG_EVENTS; i++) {
>
> I applaud this part :-)
>
>

Hi Michal,

Thanks for taking a look. Let me get back to you on this later. I am
at the moment rearranging struct mem_cgroup for better packing and
will be running some benchmarks. Later I will see if your suggestion
has any performance benefit or just more readable code then I will
follow up.

Shakeel
