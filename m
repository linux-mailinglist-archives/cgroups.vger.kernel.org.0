Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58065978BD
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiHQVKq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 17:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242385AbiHQVKk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 17:10:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152D9F743;
        Wed, 17 Aug 2022 14:10:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q19so13071881pfg.8;
        Wed, 17 Aug 2022 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jubgmtu9ZCV2QamN97BJw9SKo7GeHiKN8FVBsuK4MpI=;
        b=ht0aNzrRUImTnu8m1fHSTGs+ufFWe/8x7bzHLosVnh7BI1beTfMKcxipuQ0yK5aeis
         9slQDNzhO5mKIxJGUa2m6YRI87WzGWk37jrmGvTQhUY/oPtIPce3BMRowls9MzMKTwUB
         bkE2Da0iUdGcVkeONg7sUqORvzcdE5CZOZAWlY4Cx2EN0f5FkB5lNy5OAuwZvhcDaZRt
         KvHtVJDhe/ZpIpdLnaFfelO8+TiwhFpYyu6B63i+hB/qUo4iPV5H5ZGcvDqbGRHsZDJ8
         fOT4hjPork4yl/xLMWag47Aynp0q/xot6f/Zvd+/f2Wv5yX6E6LbpcalrtAphtGsuB5S
         Inxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jubgmtu9ZCV2QamN97BJw9SKo7GeHiKN8FVBsuK4MpI=;
        b=upwPGVX8fSXC+XLWhbRk0wvi2l5JPEJzHPH63U7uEFgt42tQxFdfIxYaWKP6qrj3pW
         4sBQU4SHq5ffBYzMh8V6BpAeoQ8zoK3LziUltFgejWvgtrxOoVLSQvYNCzz/su6k84Il
         8xFov3XkaCguvHFEZmgvNFupAOUP40NcAdgq/f7I6ZMLz5lpIIb0Jm+aZqkmZErDO7Pg
         moIZHY9Upv087s7JeNTdqSo/EHz5ytiU2cgS6DalEiju5IqZ6tLmnWZj5E+/4x53kSwv
         q2vzQ52+FJP4D8nYmgOmy5eTKgVgWYWCVFn1yjHprH4qK16uPeRpSXB+OD/PnPo0NZJk
         Nc9g==
X-Gm-Message-State: ACgBeo3aft046BJE+4IyBJ7ipHCQZkfW/3T6Fg/YyBNDHB0FGM6L7IBf
        imXBA+3biUaM+rQZD5txuGEOLU7LDL0/frrMIv8=
X-Google-Smtp-Source: AA6agR7OHj9u+NNZWCSUmy9mZH1jQdHUoh0nYfg4H0rqmb+tvXKvWXUpgTNlfNERRBskRQ4BtwiN4ZxYDsQ648A7/lE=
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id
 bt19-20020a056a00439300b0052f3603e62fmr13087pfb.23.1660770638491; Wed, 17 Aug
 2022 14:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com> <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
 <CAHbLzkrSU3ZHRiZAxy9Jju3-3ZFpDmE4uMx81c+yPWN28_j+tw@mail.gmail.com> <CALvZod6558Ub52uvyGq02474noskMGf-jqeCEyoLqY0s4brQQw@mail.gmail.com>
In-Reply-To: <CALvZod6558Ub52uvyGq02474noskMGf-jqeCEyoLqY0s4brQQw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 17 Aug 2022 14:10:26 -0700
Message-ID: <CAHbLzkqpC+kwAmVNw+w+YejS8fowEhseizc+E2PzChAYy3HBAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 16, 2022 at 7:05 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Aug 16, 2022 at 7:01 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 3:06 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Tue, Aug 16, 2022 at 11:58 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > Workingset refault stats are important and usefule metrics to measure
> > > > how well reclaimer and swapping work and how healthy the services are,
> > > > but they are just available for cgroup v2.  There are still plenty users
> > > > with cgroup v1, export the stats for cgroup v1.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > > I do understand the development of cgroup v1 is actually stalled and
> > > > the community is reluctant to accept new features for v1.  However
> > > > the workingset refault stats are really quite useful and exporting
> > > > two new stats, which have been supported by v2, seems ok IMHO.  So
> > > > hopefully this patch could be considered.  Thanks.
> > > >
> > >
> > > Is just workingset refault good enough for your use-case? What about
> > > the other workingset stats? I don't have a strong opinion against
> > > adding these to v1 and I think these specific stats should be fine.
> >
> > The workingset refault is good enough for our usercase, but I don't
> > mind adding all the workingset_* stats if nobody has objection.
>
> For now let's just start with what your use-case needs. If in future
> there is a need we can add other workingset_* stats as well.

Sure, works for me.

>
> >
> > > (There is subtlety in exposing objcg based stats (i.e. reparenting) in
> > > v1 due to non-hierarchical stats in v1. I remember Yosry and Muchun
> > > were looking into that.)
> >
> > The workingset_* stats should have nothing to do with obj based stats IIUC.
>
> Yeah, that was just FYI for anyone in future who wants to export such
> stat in v1.

Thanks, Shakeel. If it looks good to me, would you please ack the patch?
