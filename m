Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916915917DB
	for <lists+cgroups@lfdr.de>; Sat, 13 Aug 2022 02:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiHMAoa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 20:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiHMAo3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 20:44:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0556101CA
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 17:44:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so2731262wra.11
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 17:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nsBuNh8ySi6ShETxrYCuKi8D+pIFk/T+cDDfDt4bPtw=;
        b=flhpfV8eLQphDY35QUDVJ7szN/37QPBxxglfSV+QSAbZ16HmGEjx4iXgN+A3uyEiy5
         u+TX01e611Jk7krensRzI4SVwdTXzRykr7IwEg4tIDyxtRN/s1P+9E0kz+aaf58Y7Cv8
         mT3IvEYgBb3t7lKpqzhzYpn/C4vsS7C5ZTNUM5zk710sz++5UEVtcFb0AxRGMLa6trcr
         31xVxvDzY0e9/5TJSegj41peN9rpqzrhczVGSc2Io9vwX0TOK3QZhEKyL5YrHWSEzSBH
         6KcFZGfBSt4Hcv5gGqfp4ALrC4XcY4b1KRXRj9b4m8o9ZGOnr2vyeghnnWm4gBvQbEQD
         as2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nsBuNh8ySi6ShETxrYCuKi8D+pIFk/T+cDDfDt4bPtw=;
        b=pLy5AUyYQoD4j2rPiJSvvEJuAepTD+nlmmqoRo4uIiMjZyUokAxG2as+P1AKlHrrQk
         i0ML7ylvz4iyrHuFLd3ySWbMB1mkGzDuDkzzBhD+DTmOBeeYMuglgyzlr32OU1PIHFVA
         xRmBGQkX6Le+M3JSBpcjl1wmFivZkIgOyVV2L1H5Z3EUTVc8flZS7ZB10TD7BtOoeW3V
         tzq68sgvLvYmvRRHMNflLaUOoSrYdOsJQHQuLavzWWic0L/1cjImM0vHMZ8T2EHJ5L9/
         aZosENfNQnumBSLTfobnqHqTFJ5b7NsbahgXZbuWojtL8XILh0OZloYC3Vatmw4SOEW+
         J9Lw==
X-Gm-Message-State: ACgBeo3Ye/VnSZUMiPiBweEbkmV5XipuRI582zUPrnpq7AKdTmkjlWoj
        FWYP06UnxJej26dEx2OnURpAU6KA50VCTCT+44eCvMfa51c=
X-Google-Smtp-Source: AA6agR4Onx/CCa2VmVAMrVd2d+HZLgXRnIWsz7wkClVEYmWvnwDCELyXj1ufb3n1XkP6oJrpe7iz8Fw+v0iMO+gKQ9M=
X-Received: by 2002:adf:d84e:0:b0:21e:bdc0:2847 with SMTP id
 k14-20020adfd84e000000b0021ebdc02847mr3241978wrl.582.1660351465995; Fri, 12
 Aug 2022 17:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
In-Reply-To: <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 12 Aug 2022 17:43:49 -0700
Message-ID: <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     liliguang <liliguang@baidu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Aug 12, 2022 at 2:56 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> +Andrew & linux-mm
>
> On Thu, Aug 11, 2022 at 5:12 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> > > From: Li Liguang <liliguang@baidu.com>
> > >
> > > Kswapd will reclaim memory when memory pressure is high, the
> > > annonymous memory will be compressed and stored in the zpool
> > > if zswap is enabled. The memcg_kmem_bypass() in
> > > get_obj_cgroup_from_page() will bypass the kernel thread and
> > > cause the compressed memory not charged to its memory cgroup.
> > >
> > > Remove the memcg_kmem_bypass() and properly charge compressed
> > > memory to its corresponding memory cgroup.
> > >
> > > Signed-off-by: Li Liguang <liliguang@baidu.com>
> > > ---
> > >  mm/memcontrol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index b69979c9ced5..6a95ea7c5ee7 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
> > >  {
> > >       struct obj_cgroup *objcg;
> > >
> > > -     if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> > > +     if (!memcg_kmem_enabled())


Won't the memcg_kmem_enabled() check also cause a problem in that same
scenario (e.g. if CONFIG_MEMCG_KMEM=n)? or am I missing something
here?

>
> > >               return NULL;
> > >
> > >       if (PageMemcgKmem(page)) {
> > > --
> > > 2.32.0 (Apple Git-132)
> > >
> >
> > Hi Li!
> >
> > The fix looks good to me! As we get objcg pointer from a page and not from
> > the current task, memcg_kmem_bypass() doesn't makes much sense.
> >
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > Probably, we need to add
> > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> >
> > Thank you!
>
> You can add:
>
> Acked-by: Shakeel Butt <shakeelb@google.com>
>
