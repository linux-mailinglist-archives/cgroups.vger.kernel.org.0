Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF55916F1
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 23:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiHLV43 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHLV42 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 17:56:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AEC98C94
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 14:56:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ha11so2137384pjb.2
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o2hp/mCYv88Mu5Svxez+bwRchvdFYkFYWfUz+bymVnc=;
        b=q1jKUnyVZ9vO4CNzKCvW4vPDrvisSyGyG/aj2uv3JTpY33zTgaWK4E20HV+lY9mCRW
         NAQfFUw/KuEcyS66BsOz17ZF45PP3LT9pkwMDyCAQUvMFTOxZ21/n6yfZ90uGfu3lwDB
         Z5zVIcCxdviScscBaVZGTwL8svQwie4johmolE7J6EJcwLeQBarQM4aM6sUiR/DelNuu
         bHEwrLxWqs9KOD/3WF1o59D7PyuzMsPWE6RCFtCofmK7NBHMRlQwmiZBo8Lgr5syF5gu
         gPd3ia9znghXyZh726OwhHTlQ1ItRFVZ7GLkXtsfn/K9oo5jjtEYPZ8gJxmMIvDK60nN
         e2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o2hp/mCYv88Mu5Svxez+bwRchvdFYkFYWfUz+bymVnc=;
        b=ibJgghaAwOazBK+OlXEf5SGskrYtLzybFWXn58ir1l87oHh89oIfaHCNd58wr2bMYt
         pPiJwmnsUDhOeUTOMDYmJSZbvZjdt32tBmoD+vk35hYYf+Edb+fU8dlOSveziE6Tr6mE
         CyLtIjYdtuEFu/Idd37Ghe0F5XrPMsz89h1RMVUO8XMWRVpwmUl6QjoA4lhuOCBAhllj
         uzyVvdBrC2PY5Cm3dYtAWTS0/qV04Cwr9EX8439K8fKqr5Yq8iuL/TbuHCc4sRqjgsB6
         n8btiLfcyxBP4u5NApsFueYfw1LFh5oQKVP1GjmMgzWu5vtvrfDfHH1cEvExpqM24TcR
         bO3A==
X-Gm-Message-State: ACgBeo2PLpXYsfhkVQ0ywIFNmWZ0lpDdhOjP4bI43q+NFC8hX71HlJtl
        Q4fgRtAyitk3+y4lWAAX7POOyso1tNy5Rvsu9NuOF602VlU=
X-Google-Smtp-Source: AA6agR7CaCJ5Vsb+sflEr2xgVLmweZ/8QQk5Z3RU9GdOB8/kb7LUVTxvnXAI5HxPZ3P+TQoRrjRqN+hPLJuBzp1N8D4=
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id
 g3-20020a170902868300b0017131147678mr5936618plo.172.1660341387154; Fri, 12
 Aug 2022 14:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
In-Reply-To: <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Aug 2022 14:56:16 -0700
Message-ID: <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     liliguang <liliguang@baidu.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        songmuchun@bytedance.com, Roman Gushchin <roman.gushchin@linux.dev>
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

+Andrew & linux-mm

On Thu, Aug 11, 2022 at 5:12 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> > From: Li Liguang <liliguang@baidu.com>
> >
> > Kswapd will reclaim memory when memory pressure is high, the
> > annonymous memory will be compressed and stored in the zpool
> > if zswap is enabled. The memcg_kmem_bypass() in
> > get_obj_cgroup_from_page() will bypass the kernel thread and
> > cause the compressed memory not charged to its memory cgroup.
> >
> > Remove the memcg_kmem_bypass() and properly charge compressed
> > memory to its corresponding memory cgroup.
> >
> > Signed-off-by: Li Liguang <liliguang@baidu.com>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index b69979c9ced5..6a95ea7c5ee7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
> >  {
> >       struct obj_cgroup *objcg;
> >
> > -     if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> > +     if (!memcg_kmem_enabled())
> >               return NULL;
> >
> >       if (PageMemcgKmem(page)) {
> > --
> > 2.32.0 (Apple Git-132)
> >
>
> Hi Li!
>
> The fix looks good to me! As we get objcg pointer from a page and not from
> the current task, memcg_kmem_bypass() doesn't makes much sense.
>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Probably, we need to add
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
>
> Thank you!

You can add:

Acked-by: Shakeel Butt <shakeelb@google.com>
