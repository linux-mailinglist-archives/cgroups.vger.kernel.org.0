Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D259C3B4
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiHVQGb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiHVQGa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 12:06:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DC2CE2A
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:06:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so10323953plq.12
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Hzk+uAP2EkRL9Sia/SFiFvZ5KFrXcliMp2X+SwbXgJE=;
        b=FE+FMGBU8Io/f8ZTnMHGJbZ5+wKLBIfpgdiJ6n9Ye3xjsJwJiWRthFQZesalJXxr6v
         asH26nv62+9fFdn9DJY/PQ1wPTtD6mMrkdyqnfgjWtwbLUQNbfsJW7Z+/hWmDC3TbCia
         2FYtPJmqybTobZ3vBqr+CuVzk+yEwkmsH9R0W5mALHZIucQJPqWPJCmrJrzIS1ROB3sd
         6xEvpo7fvLpHxrjZZw/rZL5CitN6yBN20KzM1+O9ofyu/Fq8+Fm97MZib4/BNUa3yJIN
         hdYuobZLS7CYbd0581wdytZboHm0+/k0dtsJtGtlEMvmaubqnB7a7hY+Xz9Gr4zduXKf
         Y4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Hzk+uAP2EkRL9Sia/SFiFvZ5KFrXcliMp2X+SwbXgJE=;
        b=kxmGrwwsfjbFkl/v2I8k7iJIgA3KVU9+8WppoEe9w1QjJ5TQoKwHQIw1SSJl97BGuw
         3dqL4df5YN0fJS4ANEVZR+8eOphXAq2um83LE6luxIA3pS9VrzhAuQ1Lc7NNtR3vxvOP
         L8U/DUIsy34UtZuqMKhJWkEzgd7yligPQ+8MOYND1+L3zH9OyO/m+BLcgRCFcIYv4hJt
         46TWqCNXDOG1Y2/XWuhIY6SzUP4i0LFYG61hXjomU/Ox1NFi/NDsWmTs9OSI6cEhtYPH
         2Z9O3fb4+snL+wLFuk0fGP/df1hU3KZvo8tIrImnW+AS8Aj/Ig/hQjyLLMBCI3g6Km+K
         QitQ==
X-Gm-Message-State: ACgBeo1XL+d7V6ynuGYRJbRnveZWFyI4W5igAbKQUhbUJ3BpcS6F28Tk
        /N/3BbarCkoTe8j8Dz0HT+6GdictpLX10rYD5eOFYQ==
X-Google-Smtp-Source: AA6agR6jVzDkGiBKD1GwoCYyQtpCU1z9BROhd8tOPEO6X5bKXjyo66sucaWs+VXhEve1C/WahqOzVbUuMF7phoy6aII=
X-Received: by 2002:a17:902:e80e:b0:16f:14ea:897b with SMTP id
 u14-20020a170902e80e00b0016f14ea897bmr20878023plg.6.1661184388337; Mon, 22
 Aug 2022 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com> <20220822001737.4120417-2-shakeelb@google.com>
 <YwNSlZFPMgclrSCz@dhcp22.suse.cz> <YwNX+vq9svMynVgW@dhcp22.suse.cz>
 <CALvZod720nwfP68OM2QtyyWJpOV5aO8xF6iuN0U2hpX9Pzj8PA@mail.gmail.com> <YwOeocdkF/lacpKn@dhcp22.suse.cz>
In-Reply-To: <YwOeocdkF/lacpKn@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Aug 2022 09:06:17 -0700
Message-ID: <CALvZod7iuuwfSq18kyNSo4DXGjfVm3FWS77DtoSeP2jrz5gpDA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: page_counter: remove unneeded atomic ops for low/min
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 22, 2022 at 8:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 22-08-22 07:55:58, Shakeel Butt wrote:
> > On Mon, Aug 22, 2022 at 3:18 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 22-08-22 11:55:33, Michal Hocko wrote:
> > > > On Mon 22-08-22 00:17:35, Shakeel Butt wrote:
> > > [...]
> > > > > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > > > > index eb156ff5d603..47711aa28161 100644
> > > > > --- a/mm/page_counter.c
> > > > > +++ b/mm/page_counter.c
> > > > > @@ -17,24 +17,23 @@ static void propagate_protected_usage(struct page_counter *c,
> > > > >                                   unsigned long usage)
> > > > >  {
> > > > >     unsigned long protected, old_protected;
> > > > > -   unsigned long low, min;
> > > > >     long delta;
> > > > >
> > > > >     if (!c->parent)
> > > > >             return;
> > > > >
> > > > > -   min = READ_ONCE(c->min);
> > > > > -   if (min || atomic_long_read(&c->min_usage)) {
> > > > > -           protected = min(usage, min);
> > > > > +   protected = min(usage, READ_ONCE(c->min));
> > > > > +   old_protected = atomic_long_read(&c->min_usage);
> > > > > +   if (protected != old_protected) {
> > > >
> > > > I have to cache that code back into brain. It is really subtle thing and
> > > > it is not really obvious why this is still correct. I will think about
> > > > that some more but the changelog could help with that a lot.
> > >
> > > OK, so the this patch will be most useful when the min > 0 && min <
> > > usage because then the protection doesn't really change since the last
> > > call. In other words when the usage grows above the protection and your
> > > workload benefits from this change because that happens a lot as only a
> > > part of the workload is protected. Correct?
> >
> > Yes, that is correct. I hope the experiment setup is clear now.
>
> Maybe it is just me that it took a bit to grasp but maybe we want to
> save our future selfs from going through that mental process again. So
> please just be explicit about that in the changelog. It is really the
> part that workloads excessing the protection will benefit the most that
> would help to understand this patch.
>

I will add more detail in the commit message in the next version.

> > > Unless I have missed anything this shouldn't break the correctness but I
> > > still have to think about the proportional distribution of the
> > > protection because that adds to the complexity here.
> >
> > The patch is not changing any semantics. It is just removing an
> > unnecessary atomic xchg() for a specific scenario (min > 0 && min <
> > usage). I don't think there will be any change related to proportional
> > distribution of the protection.
>
> Yes, I suspect you are right. I just remembered previous fixes
> like 503970e42325 ("mm: memcontrol: fix memory.low proportional
> distribution") which just made me nervous that this is a tricky area.
>
> I will have another look tomorrow with a fresh brain and send an ack.

I will wait for your ack before sending the next version.
