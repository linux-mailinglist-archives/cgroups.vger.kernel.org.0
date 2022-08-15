Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D34592C23
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiHOIKX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbiHOIKU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 04:10:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928661088
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 01:10:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so8169558wrp.10
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=UXNM9HpRKZc66kR7zelY8x/zndxrxmNha66YxU3qtPc=;
        b=HgjrYu9Ms3eypWjq/uv0CK2T8YVJeposAbZ1IwbjU4jY+R8poQcGV0ddfRrZOC8NGQ
         eRGTe1SP9qtwZI9At+ZgEWbPmudx2v58us50dUsELpdaQvB4e3IDNCztr5o8bwNdfUd+
         BASN7TyrzoCEJlXAxryGgJH1nlVx4si98pWb3wHT8iiPKfnE4YWLFZIuFtwtif6B3+uH
         uLCzYtVj7rSJEeNajV3lBJxcI7YlwgP3ZMjj8YwxaV4EXC1o5VbFl9ZTiV+eSGEbNTz+
         mPCAE5uYRW2689bIuLQIeY9+WFZsIcG4uV+ytOWcOZzmxsG/5elxgdQ3a8L2NaMCIj5r
         t0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=UXNM9HpRKZc66kR7zelY8x/zndxrxmNha66YxU3qtPc=;
        b=QbLl0Ol0TEROxTNeYubYOCHaGCH5Q5KKCpMLabexRuey332D1Ek+X0yN16ThMkzTCA
         hcULVG82HtLkFioEztxuScPMCtITuffHbjVVXUKs1ItUx7XkMzL0d/k0sQjp+nlDBeuy
         xbmuMwVdiqirQ32cO/3kLa//tp1el43MpOj1qLULUc+PMjbFh4FDJ73sAD2fhgcdyfVy
         dUjjQyN9aFtbrtA+mXGGjymU2qhkKMR86GKEe0GSSvaEa9j1PVAKutpI40dTI3ooUfDo
         9Ll88KNIN+q7qL5klHyysx7o1gYLsCz0bHUJLixgSvq49jxVghqXbohbBJxtIpxfjdWu
         AqOQ==
X-Gm-Message-State: ACgBeo3qObBOR2Yd9rQsCz3LJOOOM2Nz/TWosUU3rpfm/9K1ty5lJ7/Z
        2UgeJOic/usk+Hcmn3Iyao8/ArHpyZnApG5sMvOXgg==
X-Google-Smtp-Source: AA6agR75XzwspIAzxR97S5bkC6Wtf3pm+Zn88E5GvyFzwWah7FlnIzTkWkIUtqlnhF5ZLLn8FMhliNaqyR0OiwXos94=
X-Received: by 2002:a05:6000:1188:b0:220:6c20:fbf6 with SMTP id
 g8-20020a056000118800b002206c20fbf6mr8217962wrx.372.1660551016743; Mon, 15
 Aug 2022 01:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com> <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
In-Reply-To: <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 01:09:40 -0700
Message-ID: <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
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

On Sun, Aug 14, 2022 at 7:52 PM Li,Liguang <liliguang@baidu.com> wrote:
>
> =E5=9C=A8 2022/8/13 =E4=B8=8A=E5=8D=888:44=EF=BC=8C=E2=80=9CYosry Ahmed=
=E2=80=9D<yosryahmed@google.com> =E5=86=99=E5=85=A5:
>
> > On Fri, Aug 12, 2022 at 2:56 PM Shakeel Butt <shakeelb@google.com> wrot=
e:
> > >
> > > +Andrew & linux-mm
> > >
> > > On Thu, Aug 11, 2022 at 5:12 PM Roman Gushchin <roman.gushchin@linux.=
dev> wrote:
> > > >
> > > > On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> > > > > From: Li Liguang <liliguang@baidu.com>
> > > > >
> > > > > Kswapd will reclaim memory when memory pressure is high, the
> > > > > annonymous memory will be compressed and stored in the zpool
> > > > > if zswap is enabled. The memcg_kmem_bypass() in
> > > > > get_obj_cgroup_from_page() will bypass the kernel thread and
> > > > > cause the compressed memory not charged to its memory cgroup.
> > > > >
> > > > > Remove the memcg_kmem_bypass() and properly charge compressed
> > > > > memory to its corresponding memory cgroup.
> > > > >
> > > > > Signed-off-by: Li Liguang <liliguang@baidu.com>
> > > > > ---
> > > > >  mm/memcontrol.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index b69979c9ced5..6a95ea7c5ee7 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_page=
(struct page *page)
> > > > >  {
> > > > >       struct obj_cgroup *objcg;
> > > > >
> > > > > -     if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> > > > > +     if (!memcg_kmem_enabled())
> >
> >
> > Won't the memcg_kmem_enabled() check also cause a problem in that same
> > scenario (e.g. if CONFIG_MEMCG_KMEM=3Dn)? or am I missing something
> > here?
> >
>
> Please notes that the return value is a pointer to obj_cgroup, not memcg.
> If CONFIG_MEMCG_KMEM=3Dn or memcg kmem charge is disabled, the NULL need
> to be returned.
>

Right. I am not implying that the check should be removed, or that
this is something this patch should address for that matter.

I just realized while looking at this patch that because we are using
objcg in zswap charging, it is dependent on memcg kmem charging. I am
not sure I understand if such dependency is needed? IIUC swapped out
pages hold references to the memcg they are charged to anyway, so why
do we need to use objcgs in charging zswap? I feel like I am missing
something.

> > >
> > > > >               return NULL;
> > > > >
> > > > >       if (PageMemcgKmem(page)) {
> > > > > --
> > > > > 2.32.0 (Apple Git-132)
> > > > >
> > > >
> > > > Hi Li!
> > > >
> > > > The fix looks good to me! As we get objcg pointer from a page and n=
ot from
> > > > the current task, memcg_kmem_bypass() doesn't makes much sense.
> > > >
> > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > >
> > > > Probably, we need to add
> > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > >
> > > > Thank you!
> > >
> > > You can add:
> > >
> > > Acked-by: Shakeel Butt <shakeelb@google.com>
> > >
>
