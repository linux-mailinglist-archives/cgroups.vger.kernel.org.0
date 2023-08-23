Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496BC785C1F
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjHWP37 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjHWP36 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 11:29:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258DCE6
        for <cgroups@vger.kernel.org>; Wed, 23 Aug 2023 08:29:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99df431d4bfso750236766b.1
        for <cgroups@vger.kernel.org>; Wed, 23 Aug 2023 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692804595; x=1693409395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri9cgA1PiCU6du3dgZZGBozLYOkCK1hmpsIStPWqOXw=;
        b=4iVGNXXiBWOb9z6ygfEgopQKgtjz/ArlqeOIHwCCa/5HrFRqcdkbL/B0k4sFHBO1k4
         Eg1bl7/uU37OwC7NsikD+jNiX9ImSC6a/lYPt8cooDBXForLZnqPxR/cYv4nWicYXfke
         A3r/tvU9OZ3Q9XPQLgWMi/OV2FCvfrfWL1nz+l42yojLn7TATXXxvZIeO4U6KWgdao41
         Lo+wjmL5LNqoWRr44aX9H57Lihc2x3PKwGSMAD616I37GXzf54uBCUK2ac/wZ2S47XDk
         pY90bs1cRDWtt1y7RWKZ0WClLg37X7BnHlRXwYd274I4jnLCaiakgMeL4SnMcxnxgQUl
         M/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804595; x=1693409395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri9cgA1PiCU6du3dgZZGBozLYOkCK1hmpsIStPWqOXw=;
        b=MFHldZfI3p5ncRpsc7wR1+lSXhE4LTSFdJF9RxbJDuKOV5avP8aZWlxTPdueV8IaoP
         X0CMGLgpPdgKpmQ2p1Xb42aXgPQ41Jl5FnDV1Xo6eHGoqxobp+NotpJh+DUrltytlznI
         dsMZpYwqUc04uEjIge5vabiNKCDf8SkSn81EeOIsGvb8rrQXZTkzjhSLJtWAwWY1o9YD
         AF3+fMQhb3sYZ9EB6uyUq0/+X74nMnOd19dnGnPlhvUulSaBXnYJWIYj72q/ZLRgtyVs
         jUOH0FkLaRLq6cyjqB6D9HJnhinogMMyWZ2MVmpkp3NVnIN4jdqufzpeDa8woYh43QHe
         IkGg==
X-Gm-Message-State: AOJu0YxrWVz9mz67IxCAF+QXqruyB9uA/lVTToC4JkheVkM1twId3amS
        KDSlJlxH4H3dxO7WoGMh0ISsHS+J8Eg1FpBCVOUPyA==
X-Google-Smtp-Source: AGHT+IEZaQ6xoK+wL+FTFe5ZpmCpytg9fJm9EC7fze3OpW4v6X0QBX3ZGnlc8r2H85GNS4dvw3oYg++1Ab++LcjnmOs=
X-Received: by 2002:a17:906:530e:b0:999:37ff:be94 with SMTP id
 h14-20020a170906530e00b0099937ffbe94mr11243713ejo.71.1692804595358; Wed, 23
 Aug 2023 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
 <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com> <ZOYFydIp3q8BNrEa@dhcp22.suse.cz>
In-Reply-To: <ZOYFydIp3q8BNrEa@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Aug 2023 08:29:19 -0700
Message-ID: <CAJD7tkYivogrRtAx8a+EPfjRqQNgoOZFZyG8rC91E_hW6pdTEw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 23, 2023 at 6:12=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 23-08-23 10:00:58, Liu Shixin wrote:
> >
> >
> > On 2023/8/23 0:35, Yosry Ahmed wrote:
> > > On Mon, Aug 21, 2023 at 6:54=E2=80=AFPM Liu Shixin <liushixin2@huawei=
.com> wrote:
> > >> When spaces of swap devices are exhausted, only file pages can be re=
claimed.
> > >> But there are still some swapcache pages in anon lru list. This can =
lead
> > >> to a premature out-of-memory.
> > >>
> > >> This problem can be fixed by checking number of swapcache pages in
> > >> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat tha=
t can
> > >> be used directly. For memcg v1, use total_swapcache_pages() instead,=
 which
> > >> may not accurate but can solve the problem.
> > > Interesting find. I wonder if we really don't have any handling of
> > > this situation.
> > I have alreadly test this problem and can confirm that it is a real pro=
blem.
> > With 9MB swap space and 10MB mem_cgroup limit=EF=BC=8Cwhen allocate 15M=
B memory,
> > there is a probability that OOM occurs.
>
> Could you be more specific about the test and the oom report?

I actually couldn't reproduce it using 9MB of zram and a cgroup with a
10MB limit trying to allocate 15MB of tmpfs, no matter how many
repetitions I do.

>
> --
> Michal Hocko
> SUSE Labs
