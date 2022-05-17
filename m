Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADE52A9FE
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbiEQSHc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351889AbiEQSHZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 14:07:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED577517EB
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 11:07:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so25772830wrg.12
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5miC2kWn/l2e0BUuAIeZlYgpjUY+Gi8Grdp3KqcrK8=;
        b=UXqcmaywsD5AB9IxCHPt0Uzp0QohHozlmtmz6BUjExY3c7FuVDvcAcFQPalL4lBncW
         HtxU2aNWgnohBNpUkXNy+DMO7+l8Aegg71l0oKsr2IbYmOXivgmCvqYeFrXCGjan04ps
         ZvtMyokVjpdqSs/XCEBXmjvND+xdFFHhS4+8FmNzP0sffxiidGouM1ciTVqvVK8lMe4I
         zEcOxXsXYwHSqvRi89rmltszgIXa2B2qqfRRhcat7Zq59yG6GNoXxAFvzvqtctcP9Mmp
         fIJIGOBXKWXzGaWOqzbGojB9SYCA0y6yoI2nss/O5wQvCxq6wXVn5a4cAlRTGeth+PyV
         Bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5miC2kWn/l2e0BUuAIeZlYgpjUY+Gi8Grdp3KqcrK8=;
        b=1ifQwTRic4pr1zPhWXjur5d0YZoJ8pcL2pX7+4NGZqmtGXrog3sr4WXQGIyTxlBTNE
         zzzen+iDcrhytBLc3rfR1DnOEGOpeR4y9MVH1Ef3F+K9txjV84BCbEd31iplyK1of4v4
         4FUdKde1y1ynXRdYqH95ke7dvJc1Es1QGzRVYBVv/AX+zCtfZ85eddYKK/iXXKcKCgj7
         N1W0+XMvt2FfgvmMWfT5gRBaWTlFq1GfoW9AOBRPZcLWpKh8Irk/7cDEH+BRm5kDN0Yd
         WLXHQ4wbAMZlfOeJas+kn//egTfFcdlhYvuHj2EKroi/sI57i1vRw9DeXQpzjp/X+qUY
         VZog==
X-Gm-Message-State: AOAM532YBW1bhFVEZDdX+AZsyuTwJyBVyOluAE2vr/bXj1VC9z9cYMuh
        x/Pnvy3I98MRzZQ/NmAM1V/7leLKLWJovH82ZKKDsNhfQxKrDQ==
X-Google-Smtp-Source: ABdhPJxgPBQ3jZTZo+4lcUoUUl3HUD7KiwclMhzdPE5ncEPURSEx6ftaxhVvrc8sFgY/RBdbkWQeiKwl97+aJV93RCg=
X-Received: by 2002:a05:6000:1815:b0:20a:deee:3cf0 with SMTP id
 m21-20020a056000181500b0020adeee3cf0mr19322657wrh.210.1652810832119; Tue, 17
 May 2022 11:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz>
In-Reply-To: <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 17 May 2022 11:06:36 -0700
Message-ID: <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
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

On Mon, May 16, 2022 at 11:56 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 16-05-22 15:29:42, Yosry Ahmed wrote:
> > The discussions on the patch series [1] to add memory.reclaim has
> > shown that it is desirable to add an argument to control the type of
> > memory being reclaimed by invoked proactive reclaim using
> > memory.reclaim.
> >
> > I am proposing adding a swappiness optional argument to the interface.
> > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > provides a way to enforce user policy on a stateless per-reclaim
> > basis. We can make policy decisions to perform reclaim differently for
> > tasks of different app classes based on their individual QoS needs. It
> > also helps for use cases when particularly page cache is high and we
> > want to mainly hit that without swapping out.
>
> Can you be more specific about the usecase please? Also how do you

For example for a class of applications it may be known that
reclaiming one type of pages anon/file is more profitable or will
incur an overhead, based on userspace knowledge of the nature of the
app. If most of what an app use for example is anon/tmpfs then it
might be better to explicitly ask the kernel to reclaim anon, and to
avoid reclaiming file pages in order not to hurt the file cache
performance.

It could also be a less aggressive alternative to /proc/sys/vm/drop_caches.

> define the semantic? Behavior like vm_swappiness is rather vague because
> the kernel is free to ignore (and it does indeed) this knob in many
> situations. What is the expected behavior when user explicitly requests
> a certain swappiness?

My initial thoughts was to have the same behavior as vm_swappiness,
but stateless. If a user provides a swappiness value then we use it
instead of vm_swappiness. However, I am aware that the definition is
vague and there are no guarantees here, the only reason I proposed
swappiness vs. explicit type arguments (like the original RFC and
Roman's reply) is flexibility. It looks like explicit type arguments
would be more practical though. I will continue the discussion
replying to Roman.

> --
> Michal Hocko
> SUSE Labs
