Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3985224D7
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 21:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiEJTef (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 15:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiEJTee (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 15:34:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED9170F1B;
        Tue, 10 May 2022 12:34:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i17so17644392pla.10;
        Tue, 10 May 2022 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQthYIwGazUHXvJP4lOeiwCuBM9QlZF5ToR+SlrapXg=;
        b=WKDEchBVC4Mp134gTUdZstuBf95M4RJvGSkZViPHvH1YSJM33gQRVZWZL9HZNWW223
         Qgy84a9u4AjEUm9YrMVUW9UNx0E2sQYgIN0MYN+gOf1caJZneovM75xCXkgevzWeAsSs
         fM6pqvNvNTmffmbhpx9GcAic/N3JOAqSHe9kcVUGE4Hq0Zaxgnv8Fjt1Naee4CaKnfjj
         RCinT3zwa59llD67qILIX1cl1IPfp6fk0aGqq7nXOd/ahyrQ90DNGCjyCv6aprfqu2uC
         vgmyE+UAa2PzfG4jdNqQlPInnL6EHMiLb94OdoFMMrvQT9Bx1Ici0tfDSEEqtb0cASaT
         F32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQthYIwGazUHXvJP4lOeiwCuBM9QlZF5ToR+SlrapXg=;
        b=Z3LBxwjPm1DgHRvRAJEDrtaGv1FFpRZJW3EkLwV07SNsCD3QRQqgSLe31zPorEFDsU
         F84TwMZtDu6GlmgI7JvQtkc0iMAKQuPyjDwdkv4OlMYP9qwj7xH5pywgw7HzJOnWFPyr
         4rsXo7MNhHL4+D3xQh6X59Ams8fNTG6TDtHGTvMJCS67NYj8EtIMKCucgCD7x7plHgj+
         lvWKGQdHvYTUfj2NPSuoLLjQ+HBBNtdS5so4vND9V04zCchpFC8eK/yAQxurUMuVAzlD
         F9T44OYRgCEGXWd2s0ZIduft2v5LJXfQCfTUj0GctkqWvkWPbGMY7mxKIMb/jVCnjm5W
         7F5A==
X-Gm-Message-State: AOAM533t00+8j/HtBPDG/qPgkbqyGnNIu4jBmWsmozA9R4lglPAboDSG
        vTJHlm0HQctAOtJnvY5JaW5v2+QMge93v9IzTjQ=
X-Google-Smtp-Source: ABdhPJxUFMq+haarYgwZ66z+ncVF/vfNC4KlopREAV3XXY82SC6n/r928x8vXvUee+OfLRX/rpcr31r0SvO93QHc4MI=
X-Received: by 2002:a17:902:d552:b0:15e:e759:cd38 with SMTP id
 z18-20020a170902d55200b0015ee759cd38mr22134697plf.87.1652211272813; Tue, 10
 May 2022 12:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220505033814.103256-1-xu.xin16@zte.com.cn> <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com> <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com> <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
In-Reply-To: <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 May 2022 12:34:20 -0700
Message-ID: <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
To:     CGEL <cgel.zte@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Yang Yang <yang.yang29@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 9, 2022 at 6:43 PM CGEL <cgel.zte@gmail.com> wrote:
>
> On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > [...]
> > > > > If there are many containers to run on one host, and some of them have high
> > > > > performance requirements, administrator could turn on thp for them:
> > > > > # docker run -it --thp-enabled=always
> > > > > Then all the processes in those containers will always use thp.
> > > > > While other containers turn off thp by:
> > > > > # docker run -it --thp-enabled=never
> > > >
> > > > I do not know. The THP config space is already too confusing and complex
> > > > and this just adds on top. E.g. is the behavior of the knob
> > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > child says always? How does the per-application configuration aligns
> > > > with all that (e.g. memcg policy madivise but application says never via
> > > > prctl while still uses some madvised - e.g. via library).
> > > >
> > >
> > > The cgroup THP behavior is align to host and totally independent just likes
> > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > user to understand or control.
> >
> > All controls in cgroup v2 should be hierarchical. This is really
> > required for a proper delegation semantic.
> >
>
> Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> Some distributions like Ubuntu is still using cgroup v1.

Other than enable flag, how would you handle the defrag flag
hierarchically? It is much more complicated.

>
> > > If memcg policy madivise but application says never, just like host, the result
> > > is no THP for that application.
> > >
> > > > > By doing this we could promote important containers's performance with less
> > > > > footprint of thp.
> > > >
> > > > Do we really want to provide something like THP based QoS? To me it
> > > > sounds like a bad idea and if the justification is "it might be useful"
> > > > then I would say no. So you really need to come with a very good usecase
> > > > to promote this further.
> > >
> > > At least on some 5G(communication technology) machine, it's useful to provide
> > > THP based QoS. Those 5G machine use micro-service software architecture, in
> > > other words one service application runs in one container.
> >
> > I am not really sure I understand. If this is one application per
> > container (cgroup) then why do you really need per-group setting?
> > Does the application is a set of different processes which are only very
> > loosely tight?
> >
> For micro-service architecture, the application in one container is not a
> set of loosely tight processes, it's aim at provide one certain service,
> so different containers means different service, and different service
> has different QoS demand.
>
> The reason why we need per-group(per-container) setting is because most
> container are managed by compose software, the compose software provide
> UI to decide how to run a container(likes setting swappiness value). For
> example the docker compose:
> https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command
>
> To make it clearer, I try to make a summary for why container needs this patch:
>     1.one machine can run different containers;
>     2.for some scenario, container runs only one service inside(can be only one
> application);
>     3.different containers provide different services, different services have
> different QoS demands;
>     4.THP has big influence on QoS. It's fast for memory access, but eat more
> memory;

I have been involved in this kind of topic discussion offline a couple
of times. But TBH I don't see how you could achieve QoS by this flag.
THP allocation is *NOT* guaranteed. And the overhead may be quite
high. It depends on how fragmented the system is.

>     5.containers usually managed by compose software, which treats container as
> base management unit;
>     6.this patch provide cgroup THP controller, which can be a method to adjust
> container memory QoS.
>
> > > Container becomes
> > > the suitable management unit but not the whole host. And some performance
> > > sensitive containers desiderate THP to provide low latency communication.
> > > But if we use THP with 'always', it will consume more memory(on our machine
> > > that is about 10% of total memory). And unnecessary huge pages will increase
> > > memory pressure, add latency for minor pages faults, and add overhead when
> > > splitting huge pages or coalescing normal sized pages into huge pages.
> >
> > It is still not really clear to me how do you achieve that the whole
> > workload in the said container has the same THP requirements.
> > --
> > Michal Hocko
> > SUSE Labs
