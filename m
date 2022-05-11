Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589F522985
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiEKCTk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiEKCTj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 22:19:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027E1F68E4;
        Tue, 10 May 2022 19:19:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w17-20020a17090a529100b001db302efed6so767505pjh.4;
        Tue, 10 May 2022 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=iOQsmKhE+QYLxlfOvaiJ7/uZihyRqcydotN8UT2grzk=;
        b=ckn4xqwpqLh1KdI/cP99nep/Gpf0f4YULWG2yE1siFHCa56FOuA/1bRjNSSpaZA4pW
         fAxEH+XM1mGBsAkVwHob3tml3YTmD+xRqUvY64xGIONsysx82gG3NeLMchX35vb3SkCQ
         GGtU9Yoi7+GhmjMXRQrkkofCC4tWRHH0uLBCDNPzb1gYVGlwqY+83xG9Q4BB7zUzxNvg
         Pw0LgbAUpctjdTmtf4v42EGIE9D0vqnBLwaNsi7ndpM67zmubzkz+EosmphbVbYBr2w+
         LgjS1ZRlqf8Yn29EIKiH2vvXuMzQIVuyVzSIeXEeyhrZs4yffXp/+1P45ADC0y0I6OCF
         XhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=iOQsmKhE+QYLxlfOvaiJ7/uZihyRqcydotN8UT2grzk=;
        b=x61eCfTzOgBm/Tq7TG98oPyQt32cnWyo6udU2Lcdv1Wvv69TP9olsKuf8sdZLU8yR7
         9yEnRqnpUNezrK2dELFxua5S796P4qq/dzVX3gCOPLiM+n9GioZqLVxmXIy1rG7b0vI8
         MSNNUDfMCBo8aqurO15CXEonDhQua9VepkG2dRM77iO388X0GRtz8dEQgZI/Izum450j
         ktDZGkkDZNg+kRspziXE+WAldUuNHBBdeAr1fwNLH6hVlTT0fDBSW9SQFcwkNn7/UkO9
         bGBWNp8EtR6rutOvP6jw2n5Rwm55NeGRWy3tpuxnqgrInSqibEmG74Iyo7gGy7Jpf4/G
         dzcA==
X-Gm-Message-State: AOAM532oSlnQKGHpC84p2LtrPw/+vzAwhs7wLzoBss0w74TRPpw8pk68
        iJ9LCgz3ROvvYwJHRV5zKHg=
X-Google-Smtp-Source: ABdhPJyMjXaaGlEXDYH18mv/ajTq/1UvUnBk6wpaczQ3e/UYYg+Elxnz3yP4MVw5aiAbDChiC2E5cQ==
X-Received: by 2002:a17:90a:b78d:b0:1d9:4f4f:bc2a with SMTP id m13-20020a17090ab78d00b001d94f4fbc2amr2839800pjr.155.1652235577926;
        Tue, 10 May 2022 19:19:37 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a880a00b001cd4989fee6sm2470062pjn.50.2022.05.10.19.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 19:19:37 -0700 (PDT)
Message-ID: <627b1d39.1c69fb81.fe952.6426@mx.google.com>
X-Google-Original-Message-ID: <20220511021936.GB1482876@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 02:19:36 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 12:34:20PM -0700, Yang Shi wrote:
> On Mon, May 9, 2022 at 6:43 PM CGEL <cgel.zte@gmail.com> wrote:
> >
> > On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > > [...]
> > > > > > If there are many containers to run on one host, and some of them have high
> > > > > > performance requirements, administrator could turn on thp for them:
> > > > > > # docker run -it --thp-enabled=always
> > > > > > Then all the processes in those containers will always use thp.
> > > > > > While other containers turn off thp by:
> > > > > > # docker run -it --thp-enabled=never
> > > > >
> > > > > I do not know. The THP config space is already too confusing and complex
> > > > > and this just adds on top. E.g. is the behavior of the knob
> > > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > > child says always? How does the per-application configuration aligns
> > > > > with all that (e.g. memcg policy madivise but application says never via
> > > > > prctl while still uses some madvised - e.g. via library).
> > > > >
> > > >
> > > > The cgroup THP behavior is align to host and totally independent just likes
> > > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > > user to understand or control.
> > >
> > > All controls in cgroup v2 should be hierarchical. This is really
> > > required for a proper delegation semantic.
> > >
> >
> > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > Some distributions like Ubuntu is still using cgroup v1.
> 
> Other than enable flag, how would you handle the defrag flag
> hierarchically? It is much more complicated.

Refer to memory.swappiness for cgroup, this new interface better be independent.
> >
> > > > If memcg policy madivise but application says never, just like host, the result
> > > > is no THP for that application.
> > > >
> > > > > > By doing this we could promote important containers's performance with less
> > > > > > footprint of thp.
> > > > >
> > > > > Do we really want to provide something like THP based QoS? To me it
> > > > > sounds like a bad idea and if the justification is "it might be useful"
> > > > > then I would say no. So you really need to come with a very good usecase
> > > > > to promote this further.
> > > >
> > > > At least on some 5G(communication technology) machine, it's useful to provide
> > > > THP based QoS. Those 5G machine use micro-service software architecture, in
> > > > other words one service application runs in one container.
> > >
> > > I am not really sure I understand. If this is one application per
> > > container (cgroup) then why do you really need per-group setting?
> > > Does the application is a set of different processes which are only very
> > > loosely tight?
> > >
> > For micro-service architecture, the application in one container is not a
> > set of loosely tight processes, it's aim at provide one certain service,
> > so different containers means different service, and different service
> > has different QoS demand.
> >
> > The reason why we need per-group(per-container) setting is because most
> > container are managed by compose software, the compose software provide
> > UI to decide how to run a container(likes setting swappiness value). For
> > example the docker compose:
> > https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command
> >
> > To make it clearer, I try to make a summary for why container needs this patch:
> >     1.one machine can run different containers;
> >     2.for some scenario, container runs only one service inside(can be only one
> > application);
> >     3.different containers provide different services, different services have
> > different QoS demands;
> >     4.THP has big influence on QoS. It's fast for memory access, but eat more
> > memory;
> 
> I have been involved in this kind of topic discussion offline a couple
> of times. But TBH I don't see how you could achieve QoS by this flag.
> THP allocation is *NOT* guaranteed. And the overhead may be quite
> high. It depends on how fragmented the system is.

For THP, the word 'QoS' maybe too absolute, so let's describe it in the way why user
need THP: seeking for better memory performance.
Yes as you said THP may be quite overhead, and madvise() may not be suitable some time
(see PR_SET_THP_DISABLE https://man7.org/linux/man-pages/man2/prctl.2.html).

So I think this is just the reason why we need the patch: give user a method to use
THP with more precise range(only the performance sensitive containers) and reduce
overhead.

> 
> >     5.containers usually managed by compose software, which treats container as
> > base management unit;
> >     6.this patch provide cgroup THP controller, which can be a method to adjust
> > container memory QoS.
> >
> > > > Container becomes
> > > > the suitable management unit but not the whole host. And some performance
> > > > sensitive containers desiderate THP to provide low latency communication.
> > > > But if we use THP with 'always', it will consume more memory(on our machine
> > > > that is about 10% of total memory). And unnecessary huge pages will increase
> > > > memory pressure, add latency for minor pages faults, and add overhead when
> > > > splitting huge pages or coalescing normal sized pages into huge pages.
> > >
> > > It is still not really clear to me how do you achieve that the whole
> > > workload in the said container has the same THP requirements.
> > > --
> > > Michal Hocko
> > > SUSE Labs
