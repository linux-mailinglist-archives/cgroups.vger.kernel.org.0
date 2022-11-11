Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A327626100
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKKSYo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiKKSYm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:24:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243E532C8
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 10:24:38 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id b2so4103531iof.12
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 10:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFgOYEQ6NOhR14F+o1liXDfDhEK9cBQJ7rg815eUQn8=;
        b=N6wKqF8yyEt+Eo6I+YHl1q4P0AiwetFsOZQGEI+Xq9xFJz0aQPV1YS8smiPR5fq8tw
         8HGxIaRNTcgdsULpAgSBfAUzKw8X+BuKmgrdfJVjEZQA+daVSKvyPziVjoG3BnbNalFi
         KI0TIyRwmMMher+y15JVLg9Z8qiY8H+LIcipf2u8ithG+kYyKO9EdAXW06OY0nd5SzgF
         UlIuOHYW0oFo0Bc3iS6P5+JiFMwHDodZekYcXrSE8DGpNm3CHtc4jK7j1WlV1VJRrUYG
         77YuD/S6xG4OWiHiPDMxXwbDs/+4RHBwiRn22XPv7C7r5aBO6sac4kB+aRprIyoHee8Z
         isaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFgOYEQ6NOhR14F+o1liXDfDhEK9cBQJ7rg815eUQn8=;
        b=GUmWsSifHdqCVjMMp0O0MGbjl4kmUvkPpEkZK2TGTJhcfawWJBwEO0LbIkFuMpEdru
         lndNwg39oZdrbUiV6apfMwoNgvyQ1nnOlGY6PTC+jg/rwuiyGAe1RZmkRfA83+I6JROk
         vmBYbaZa0IjBnRnxoR7EUQIsx2aJjU+MpfI8HP1LOJDCAjVGvFFmtBocp3hfGKiG6HNq
         34dGZXHnrDXkYUaYEuT7qMbWtPKcicwjGH2zPI3ORRv6Eeq2K85e8561tB/2dr+imlDb
         0jDJdHbmgjiRnhJFttMVwtNVo4sVvExx941e0JIkyNY2zPdU2o6L4Ulb9yuJ5MaMWaml
         1log==
X-Gm-Message-State: ANoB5pkRVOj2U9rlerPuHjmZJwhznVPoKfCVcIiFEzBiQk1+lCUtT+Pu
        4inBYv/74YYqiTCq/GfjUrOI+jsInuLeFSenMz9/1A==
X-Google-Smtp-Source: AA0mqf7qknZ+eornSMASLh6oCDao/i148IgoUZYiERYHbL/Nz3MBkKbo80KCtpDP4lzDoUMwcBeMK5Hf6NIwI18e7Sc=
X-Received: by 2002:a02:2b10:0:b0:375:1ad6:e860 with SMTP id
 h16-20020a022b10000000b003751ad6e860mr1381798jaa.191.1668191078126; Fri, 11
 Nov 2022 10:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20221110065316.67204-1-lujialin4@huawei.com> <20221110144243.GA10562@blackbody.suse.cz>
 <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com> <20221111100843.GG20455@blackbody.suse.cz>
In-Reply-To: <20221111100843.GG20455@blackbody.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Nov 2022 10:24:02 -0800
Message-ID: <CAJD7tkYWvR+2o==-R38hDBEM=k=2bta9kKRND3wxDLF1pWbp6A@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in memory.reclaim
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 2:08 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Thu, Nov 10, 2022 at 11:35:34AM -0800, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > OTOH, it will reduce the page counters, so if userspace is relying on
> > memory.current to gauge how much reclaim they want to do, it will make
> > it "appear" like the usage dropped.
>
> Assuming memory.current is used to drive the proactive reclaim, then
> this patch makes some sense (and is slightly better than draining upon
> every memory.current read(2)).

I am not sure honestly. This assumes memory.reclaim is used in
response to just memory.current, which is not true in the cases I know
about at least.

If you are using memory.reclaim merely based on memory.current, to
keep the usage below a specified number, then memory.high might be a
better fit? Unless this goal usage is a moving target maybe and you
don't want to keep changing the limits but I don't know if there are
practical use cases for this.

For us at Google, we don't really look at the current usage, but
rather on how much of the current usage we consider "cold" based on
page access bit harvesting. I suspect Meta is doing something similar
using different mechanics (PSI). I am not sure if memory.current is a
factor in either of those use cases, but maybe I am missing something
obvious.

>
> I just think the commit message should explain the real mechanics of
> this.
>
> > The difference in perceived usage coming from draining the stock IIUC
> > has an upper bound of 63 * PAGE_SIZE (< 256 KB with 4KB pages), I
> > wonder if this is really significant anyway.
>
> times nr_cpus (if memcg had stocks all over the place).

Right. In my mind I assumed the memcg would only be stocked on one cpu
for some reason.

>
> Michal
