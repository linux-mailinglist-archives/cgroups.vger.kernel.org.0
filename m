Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66217522D2A
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiEKHXn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiEKHXh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 03:23:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AC198766
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 00:23:35 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z26so1182817iot.8
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJSkUgLXvualcu4yScFNgMcnLoh/M7+w0nEwWnW4pbs=;
        b=cj77kxh/M2LDVTpVxQojt06kHiCwZik0yMWg84kwgaBpWv0OvH+OF0I9uUiCDdo27i
         a0mqHBBFXFURc6yyAA2l8Iy0PFNTeDPlmCCWoKnSlF5Sikk/UTxshwtA8zRW756wXuiY
         yf8CEbmTrAngMsngIGr0TpwT92kzwZ7owMaguKQNb0NVOfxBNlo11U+fEwtsIKO1y4Oe
         n2OLd88b4zcAPMTifMTnT/TojDZOgfBIWU/iW1Zsn498Chc9+Z6A5CbN9TYnExji7Vzn
         FxarmoF0Iz2pcul4TVFxp6otlhQqS5o9LAaaItAgPOYMr2pHKwUc3VKqppdrFLpku7x3
         hiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJSkUgLXvualcu4yScFNgMcnLoh/M7+w0nEwWnW4pbs=;
        b=A+UrYywiL9z9FmvLLGltl83F+tDP6LUkKmy4+kSWai6/4UmJw+hLxZG95dKDhO1ZTX
         +DfB0fG99gLoUguSpc2GOqqbQ7022CYhKE3IKhpxoQ4zjxGP4K66157lmM/7aiUrY+1t
         RssjI0eEdj7AvAbjW9E5TPiPbL8zNHRQGtVQvOORG3MjEJCbFFfvDZBtodhRmv6kusRr
         ltf+iaRUrbN+f+JPF6BusR099ZXilIPn9MJhcdR/Amw/IFq1jRsSsthQtfxwvzPIO6JG
         VjQ3UTrHHNXzy3i8kF1ZEv9KZH91VVCXdd9lCbWOgmUy9X2o6v5i5N9XnhBytzGsq7wB
         JcDA==
X-Gm-Message-State: AOAM532RGtRfwaft2lctFzBYfwpAOzSP1WxGiWfSaX249E6PUUiYeCGQ
        dK+ZhPxHBNqhtpz3VnxXnkX7cR3SRw1ReIGFvozg65CVy/NkIQ==
X-Google-Smtp-Source: ABdhPJw2WmHk1nrcKec1xt11oLF+VeS1JW2lmCKlopF2TR+OwhXGa1zfRYeYHD+OmiUtZBUu/q/4j52wRpaAXFy2yLA=
X-Received: by 2002:a05:6638:140d:b0:32b:c643:e334 with SMTP id
 k13-20020a056638140d00b0032bc643e334mr11756608jad.125.1652253814626; Wed, 11
 May 2022 00:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com> <YntiE+qNnHQBV4zE@dhcp22.suse.cz>
In-Reply-To: <YntiE+qNnHQBV4zE@dhcp22.suse.cz>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Wed, 11 May 2022 12:52:57 +0530
Message-ID: <CAPD3tpGgkMKMtMJGbOHSzjut2MQ1hvBsnmuw_JaUws_L0NqizQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 12:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 06-05-22 22:09:16, Ganesan Rajagopal wrote:
> > We run a lot of automated tests when building our software and run into
> > OOM scenarios when the tests run unbounded. v1 memcg exports
> > memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> > metric to heuristically limit the number of tests that can run in
> > parallel based on per test historical data.
> >
> > This metric is currently not exported for v2 memcg and there is no
> > other easy way of getting this information. getrusage() syscall returns
> > "ru_maxrss" which can be used as an approximation but that's the max
> > RSS of a single child process across all children instead of the
> > aggregated max for all child processes. The only work around is to
> > periodically poll "memory.current" but that's not practical for
> > short-lived one-off cgroups.
> >
> > Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
>
> Yes, I can imagine that a very short lived process can easily escape
> from the monitoring. The memory consumption can be still significant
> though.
>
> The v1 interface allows to reset the value by writing to the file. Have
> you considered that as well?

I hadn't originally but this was discussed and dropped when I posted the
first version of this patch. See
https://www.spinics.net/lists/cgroups/msg32476.html

Ganesan

>
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> >  mm/memcontrol.c                         | 13 +++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 69d7a6983f78..828ce037fb2a 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1208,6 +1208,13 @@ PAGE_SIZE multiple when read back.
> >       high limit is used and monitored properly, this limit's
> >       utility is limited to providing the final safety net.
> >
> > +  memory.peak
> > +     A read-only single value file which exists on non-root
> > +     cgroups.
> > +
> > +     The max memory usage recorded for the cgroup and its
> > +     descendants since the creation of the cgroup.
> > +
> >    memory.oom.group
> >       A read-write single value file which exists on non-root
> >       cgroups.  The default value is "0".
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 725f76723220..88fa70b5d8af 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6098,6 +6098,14 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
> >       return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
> >  }
> >
> > +static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > +                         struct cftype *cft)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> > +
> > +     return (u64)memcg->memory.watermark * PAGE_SIZE;
> > +}
> > +
> >  static int memory_min_show(struct seq_file *m, void *v)
> >  {
> >       return seq_puts_memcg_tunable(m,
> > @@ -6361,6 +6369,11 @@ static struct cftype memory_files[] = {
> >               .flags = CFTYPE_NOT_ON_ROOT,
> >               .read_u64 = memory_current_read,
> >       },
> > +     {
> > +             .name = "peak",
> > +             .flags = CFTYPE_NOT_ON_ROOT,
> > +             .read_u64 = memory_peak_read,
> > +     },
> >       {
> >               .name = "min",
> >               .flags = CFTYPE_NOT_ON_ROOT,
> > --
> > 2.28.0
>
> --
> Michal Hocko
> SUSE Labs
