Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A89A593033
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiHONrc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHONrZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 09:47:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965271EEDB
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 06:47:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l4so9109814wrm.13
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Yns/Jpj95x/nJs+G87dScDOGDHWXu34AZre/Qatzji0=;
        b=tdkveuBu6uaMJub+24M/znCUtI3DkObWNMw10VbS9Nd/vD8SzGgbPG38IsiEeqbxkx
         v3WNuqJmqbWiuztrkUQHhrrykz3j04t5AbBbAmOGwR+3iZvGnZ4qj2wNYwDjhclPm/T3
         yvvFwFHnbcx8SJ/4lIJK5+zhKaAZ7kT5LZ9QMswh7fdUtMlqTcauTcQFCgMCtGuXTM4x
         hVhdsLvc0FSKpmTELK5Lxtu8mlm9ksa21N4HDWXQigzhdAqmuClT7WHe9WGXfrXKHuyv
         xrTii1J3G3ZdH/w0tZWGUHSoyEaJphj3Z4dTmw/yLRw4bbftBtoucTKx8M6591O16k3h
         QpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Yns/Jpj95x/nJs+G87dScDOGDHWXu34AZre/Qatzji0=;
        b=mCQ4qPTvtcqPptIPeBddcuAbRftW0FoYfc+JZIokgLCOqeZtSKG0p2osOwxPpKMLav
         kmkweMQ4+Fcfzm7H76O26Oi5x85lLp5euejaSXDCxrl6/+W3WmmyHZ3ZRP4v7eZfMvgg
         dquImULyw/0g3ymI5eTET8rw+S3C8pCy2rMEosU81ZqVtRmyjDGOo4pvyVL08Xvw9nKf
         l6A5PnY22Zwm6R8XB7cMDdbBkxogkJoqZC4/bmcOFOWtTJo/2q+V5BibamZY96AzfcPC
         NwSL4giqpx5iPyNhvXTCRkfZi1aN0AUNrzPWiJxrsiXz4IC/MGl6E8jC1D3qjDOpCbIv
         uqyQ==
X-Gm-Message-State: ACgBeo0pJipHSrswh4Dye3PkKlr7UWjeeH+F9KbZlx4C1s6MJCXU5xrn
        fIViJMNwlQZUVGPxzQtPMpmGBT68hGFC5gAt/moUfQ==
X-Google-Smtp-Source: AA6agR4DOqHCZB04YdslrHQLwV2PFDkZOo7chPxQ87lDW+6PmW4Um6uzPKlV2MDf8WQMBUTWzl1zVobDEFlakYPOxpI=
X-Received: by 2002:a5d:4b03:0:b0:220:6b87:8f0f with SMTP id
 v3-20020a5d4b03000000b002206b878f0fmr8949012wrq.534.1660571242998; Mon, 15
 Aug 2022 06:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com> <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com>
In-Reply-To: <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 06:46:46 -0700
Message-ID: <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     "Li,Liguang" <liliguang@baidu.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
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

On Mon, Aug 15, 2022 at 4:48 AM Li,Liguang <liliguang@baidu.com> wrote:
>
>
> > =E5=9C=A8 2022/8/15 =E4=B8=8B=E5=8D=884:10=EF=BC=8C=E2=80=9CYosry Ahmed=
=E2=80=9D<yosryahmed@google.com> =E5=86=99=E5=85=A5:
> >
> > On Sun, Aug 14, 2022 at 7:52 PM Li,Liguang <liliguang@baidu.com> wrote:
> > >
> > > =E5=9C=A8 2022/8/13 =E4=B8=8A=E5=8D=888:44=EF=BC=8C=E2=80=9CYosry Ahm=
ed=E2=80=9D<yosryahmed@google.com> =E5=86=99=E5=85=A5:
> > >
> > > > On Fri, Aug 12, 2022 at 2:56 PM Shakeel Butt <shakeelb@google.com> =
wrote:
> > > > >
> > > > > +Andrew & linux-mm
> > > > >
> > > > > On Thu, Aug 11, 2022 at 5:12 PM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> > > > > >
> > > > > > On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> > > > > > > From: Li Liguang <liliguang@baidu.com>
> > > > > > >
> > > > > > > Kswapd will reclaim memory when memory pressure is high, the
> > > > > > > annonymous memory will be compressed and stored in the zpool
> > > > > > > if zswap is enabled. The memcg_kmem_bypass() in
> > > > > > > get_obj_cgroup_from_page() will bypass the kernel thread and
> > > > > > > cause the compressed memory not charged to its memory cgroup.
> > > > > > >
> > > > > > > Remove the memcg_kmem_bypass() and properly charge compressed
> > > > > > > memory to its corresponding memory cgroup.
> > > > > > >
> > > > > > > Signed-off-by: Li Liguang <liliguang@baidu.com>
> > > > > > > ---
> > > > > > >  mm/memcontrol.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > > index b69979c9ced5..6a95ea7c5ee7 100644
> > > > > > > --- a/mm/memcontrol.c
> > > > > > > +++ b/mm/memcontrol.c
> > > > > > > @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_=
page(struct page *page)
> > > > > > >  {
> > > > > > >       struct obj_cgroup *objcg;
> > > > > > >
> > > > > > > -     if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> > > > > > > +     if (!memcg_kmem_enabled())
> > > >
> > > >
> > > > Won't the memcg_kmem_enabled() check also cause a problem in that s=
ame
> > > > scenario (e.g. if CONFIG_MEMCG_KMEM=3Dn)? or am I missing something
> > > > here?
> > > >
> > >
> > > Please notes that the return value is a pointer to obj_cgroup, not me=
mcg.
> > > If CONFIG_MEMCG_KMEM=3Dn or memcg kmem charge is disabled, the NULL n=
eed
> > > to be returned.
> > >
> >
> > Right. I am not implying that the check should be removed, or that
> > this is something this patch should address for that matter.
> >
> > I just realized while looking at this patch that because we are using
> > objcg in zswap charging, it is dependent on memcg kmem charging. I am
> > not sure I understand if such dependency is needed? IIUC swapped out
> > pages hold references to the memcg they are charged to anyway, so why
> > do we need to use objcgs in charging zswap? I feel like I am missing
> > something.
> >
>
> The compressed size of swapped out pages is nearly a quarter of its RAM,
> and a page in the zswap can store multiple compressed swapped out
> pages. So objcg is used here.
>
> Please check this post for more information.
> https://lore.kernel.org/lkml/20220510152847.230957-1-hannes@cmpxchg.org/T=
/#mbd0254ffd377bf843ac50850bf0a6d41505a925a

Yeah I understand this much, what I don't understand is why we charge
the zswap memory through objcg (thus tying it to memcg kmem charging)
rather than directly through memcg.

>
> > > > >
> > > > > > >               return NULL;
> > > > > > >
> > > > > > >       if (PageMemcgKmem(page)) {
> > > > > > > --
> > > > > > > 2.32.0 (Apple Git-132)
> > > > > > >
> > > > > >
> > > > > > Hi Li!
> > > > > >
> > > > > > The fix looks good to me! As we get objcg pointer from a page a=
nd not from
> > > > > > the current task, memcg_kmem_bypass() doesn't makes much sense.
> > > > > >
> > > > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > >
> > > > > > Probably, we need to add
> > > > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > > >
> > > > > > Thank you!
> > > > >
> > > > > You can add:
> > > > >
> > > > > Acked-by: Shakeel Butt <shakeelb@google.com>
> > > > >
> > >
>
