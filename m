Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAA4EE5BB
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiDABgT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 21:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiDABgT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 21:36:19 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FA231939;
        Thu, 31 Mar 2022 18:34:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kc20so985964qvb.3;
        Thu, 31 Mar 2022 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OO61RXD1UQQlNqnQzgeVM0kWox51DdMl6bQr1525nQg=;
        b=p4gwZPXJ32qPFxQBPNIwc2U4bV4VVZK1GVtHoEpqp8EeXPTpe/97y8CCj+AG+Sf/yj
         ej3wJrClyAZ29L642a9Mts49QtN2MIUmhNqKaZ47CIgNlVIcGuFIJBoIFqGUsQD8NMf/
         foB8uj4lZnc5b2yY0Lo9CfcokPcgJ84OvzuLXGUk58gws1Mn5MsL+PReCOR74hz0ryAG
         HaLLloFD0vxVIiySn8Fpv5K5WoPwDB2GlGP4Vnh/zovEGJjJ06eedD9f00/Limyu+SpK
         X51T7UekluL2AArKcmG6OPYcilTV5HPVcig62WZR18cdiSpN8uqXqgrzqM3GNQqI6uyE
         eTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OO61RXD1UQQlNqnQzgeVM0kWox51DdMl6bQr1525nQg=;
        b=I0k8XcmgqSgi8v5iyq2wWSD54uW4ypqco6AOBYa8E60tx9YjyELxVdme5fI8vccDu4
         rES3uCaPkRU2+paoWxrIF5vB2Kr2dHNwuxd80O7oHmH++MIm3K/i4cv942KzNyRi0q3z
         Zz4ku9+joAYr+0QEld6aihznJqUWaFo3Wc9UMMbpQ8eNRyifwgCXcB3PIFVCnoB5pSbT
         OKaJedx1GRiR6m9PuEGdTlX0tTy/GPy5yyJf36BaU9GNwQjkJA/ZlxuFa9LL8zIKagm/
         tPMrjpFK3vWqAKa+dPb/yQ9CX5tdpibK0BCJ4r6tt6Ukj64XrduFDsr2QgjhxoqQpc0p
         30wQ==
X-Gm-Message-State: AOAM530uvLJvnKCa2ePK5a4WhlMR153hwBSm/soyHb5yDqIYjU/MuqCz
        B3XNleaSwoWQG5KZN/Lwnjya1LeaSxL4KiIfZvI=
X-Google-Smtp-Source: ABdhPJxbujoJAHrQsW7VFgvsWVbk3K2SMvlp7+AO426NGykoFEb7GaBtXUPMbVMay4Pvg4FhUukNnf5ZAOScLkgJ/ik=
X-Received: by 2002:a05:6214:d42:b0:440:d56b:4233 with SMTP id
 2-20020a0562140d4200b00440d56b4233mr6196293qvr.15.1648776869848; Thu, 31 Mar
 2022 18:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
In-Reply-To: <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 1 Apr 2022 09:34:02 +0800
Message-ID: <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 7:35 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > by loading an special algorithm into its virtual address space and make it hard
> > > > to protect the expanded usage without userspace's interaction.
> > >
> > > Do I get it correctly that the concern you have is that you do not know
> > > how much memory your workload will need because that depends on some
> > > parameters?
> > right. such as a camera APP will expand the usage from 50MB to 500MB
> > because of launching a special function(face beauty etc need special
> > algorithm)
> > >
> > > > Furthermore, fixed
> > > > memory.low is a little bit against its role of soft protection as it will response
> > > > any system's memory pressure in same way.
> > >
> > > Could you be more specific about this as well?
> > As the camera case above, if we set memory.low as 200MB to keep the
> > APP run smoothly, the system will experience high memory pressure when
> > another high load APP launched simultaneously. I would like to have
> > camera be reclaimed under this scenario.
>
> OK, so you effectivelly want to keep the memory protection when there is
> a "normal" memory pressure but want to relax the protection on other
> high memory utilization situations?
>
> How do you exactly tell a difference between a steady memory pressure
> (say stream IO on the page cache) from "high load APP launched"? Should
> you reduce the protection on the stram IO situation as well?
We can take either system's io_wait or PSI_IO into consideration for these.
>
> [...]
> > > One very important thing that I am missing here is the overall objective of this
> > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > protect some portion of the charged memory and that the protection
> > > shrinks over time depending on the the global PSI metrict and time.
> > > But why this is a good thing?
> > 'Good' means it meets my original goal of keeping the usage during a
> > period of time and responding to the system's memory pressure. For an
> > android like system, memory is almost forever being in a tight status
> > no matter how many RAM it has. What we need from memcg is more than
> > control and grouping, we need it to be more responsive to the system's
> > load and could  sacrifice its usage  under certain criteria.
>
> Why existing tools/APIs are insufficient for that? You can watch for
> both global and memcg memory pressure including PSI metrics and update
> limits dynamically. Why is it necessary to put such a logic into the
> kernel?
Poll and then React method in userspace requires a polling interval
and response time. Take PSI as an example, it polls ten times during
POLLING_INTERVAL while just report once, which introduce latency in
some extend.
>
> --
> Michal Hocko
> SUSE Labs
