Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3355A0D8D
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiHYKLm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbiHYKLk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 06:11:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567699A695;
        Thu, 25 Aug 2022 03:11:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so16339596lfo.11;
        Thu, 25 Aug 2022 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vnEJEeMF2AE4KxAkE8pFWCq29ZFBba+mEDUrxnkbubM=;
        b=mxRAvOKhdn8T9NwgbWp0p3+x7XpqNID2pV90xgRQeuY9cXpHX8jpfcu515trEPmGIk
         yXpm6WKMG2ujC33kXZlEbt7CFaCFh2qqB2KO+AHFU8Z8NQDWGNqLDBsM+X5i0DnkGX2K
         dr7liyUGjF4cymJwj1hyeZsoVXLqownOuwKrgcStuLIlTIY/bGCjk7I1DpT1RuA6dQs4
         soXomcu2m/MrFqNhsPUFwGIFxOVpa+GANbCZ75+y/TBD/U5JunxlxfAkWtHfFnLaNo/p
         SU+aK56MqrnU18R7CLczUwjBW7rYEdtcdvgtKogZzNkAQeSKd32wCBNkEOZzQzGioN3t
         C+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vnEJEeMF2AE4KxAkE8pFWCq29ZFBba+mEDUrxnkbubM=;
        b=wzw89k5ZmUvs/uHNwKySf77Mtz165Rk5gQkffaC32DZk912E7cFl57FyZjMo3XWoA9
         IuAhJ3wHJOeXke1mn2aWRUoZUtlgmA+RPvttrmxUSRLtzrPmeGprDzSodMCu2MF68Nsm
         qyZFVoYXnQRvksBtFjcJNFAPwY6ssvRlnaK7SA685GtGY5gPVZ8mrdPJAFAJ1qkz8ZV6
         04hco2bGnzBerToP7sUltSZ1pgcn2WpyP1tPfqJArc01l20u+jEvPngpoNu3z6kEh4ip
         bCEVkCX1pYDlhm2QY3Y9jeHjLeD0ikAw0Rd2ASNkDHdCga7g5ROswReeM5oVC51vxaFj
         zjqg==
X-Gm-Message-State: ACgBeo00PFr88JaaFcDfdGjUmJ1j0Mv/m/bmVWr5mU1p/kjS5zpOmCE+
        euJQQgxDx/frn+UqIo+4T+NpHhLVDH6Lfe/V5QcHrx2MxlkxbQ==
X-Google-Smtp-Source: AA6agR4WDEjZYCMKzLQ4hunM2CsnlULc04fC2EaGu4C97BcS6jbk5YsGslWkhMuPW5GZ2NobTkCo9Dua51UO6zGXQyw=
X-Received: by 2002:a05:6512:3049:b0:492:f394:11cd with SMTP id
 b9-20020a056512304900b00492f39411cdmr998982lfb.165.1661422297676; Thu, 25 Aug
 2022 03:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <YwSQ4APOu/H7lYGL@dhcp22.suse.cz> <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz> <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz> <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz> <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
 <YwcZctA2S3Sd0LBN@dhcp22.suse.cz> <CAGWkznH5gQXigdLx=fwdL0uqdGx4WE9QP8b8cbWFxr=Rdg-CZQ@mail.gmail.com>
 <Ywc34ci5XUMXOSYA@dhcp22.suse.cz>
In-Reply-To: <Ywc34ci5XUMXOSYA@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 25 Aug 2022 18:11:09 +0800
Message-ID: <CAGWkznHL_G3OoAc5gJ+iwxqxonr21-fU+F4T2gkpXH68keLpuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
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

On Thu, Aug 25, 2022 at 4:50 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 25-08-22 16:34:04, Zhaoyang Huang wrote:
> > On Thu, Aug 25, 2022 at 2:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 25-08-22 08:43:52, Zhaoyang Huang wrote:
> > > > On Wed, Aug 24, 2022 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
> > > [...]
> > > > > > IMHO, charging the pages which out of explicitly memory
> > > > > > enabled group to root could solve all of the above constraints with no
> > > > > > harm.
> > > > >
> > > > > This would break the hierarchical property of the controller. So a
> > > > > strong no no. Consider the following example
> > > > >
> > > > >        root
> > > > >         |
> > > > >         A
> > > > > controllers="memory"
> > > > > memory.max = 1G
> > > > > subtree_control=""
> > > > > |      |      |
> > > > > A1     A2     A3
> > > > >
> > > > > althought A1,2,3 do not have their memory controller enabled explicitly
> > > > > they are still constrained by the A memcg limit. If you just charge to
> > > > > the root because it doesn't have memory controller enabled explicitly
> > > > > then you just evade that constrain. I hope you understand why that is a
> > > > > problem.
> > > > IMO, A1-A3 should be explicitly enabled via echo "+memory" >
> > > > A/subtree_control since memory.max has been set.
> > >
> > > You seem to be missing the point I've triedy to make here. It is not
> > > about how the respective subtree should or shouldn't be configured. It
> > > is about the hierarchical behavior. Configuration at a higher level should be
> > > enforced under subtree no matter how that subtree decides to
> > > enabled/disable controllers. Such subtree might have beeb delegated
> > > and configured differently yet the constrain should be still applied.
> > > See the point?
> > >
> > > What you seem to be proposing is similar to cgroup v1 use_hierarchy
> > > configuration. It has been decided that this is undesirable very early
> > > in the cgroup v2 development because it make delegation impossible
> > > (among other reasons).
> > Ok, I would like to know how AA3 achieve the goal of competing with A1
> > and A2 for cpu but keep memory out of control under current policy?
> >         root
> >          |
> >          A
> >  controllers="memory,cpu"
> >  memory.max = 1G
> >  subtree_control="memory,cpu"
> >  |      |            |
> >  A1     A2     A3 subtree_control="cpu"
> >                       |      |
> >                     AA3   AA4 controllers="cpu"
>
> I cannot really give you configuration you want without understanding
> what you are trying to achieve and why do you need it that way. Really,
> you can construct arbitrary hierarchies and only a very small subset of
> them actually makes sense. So far you have been very terse at your goals
> and intentions but rather demanding on the underlying mechanisms. This
> doesn't really makes the discussion productive.
>
> I hope you have at least understood that hierarchical property of the
> cgroup v2 is a must and it won't change. If you need a help to construct
> hierarchy for your specific workload I would recommend to clearly state
> your final goal and reasoning behind. Maybe you will get a more specific
> help that way. Good luck!
Sorry for any misunderstanding among the discussion. My purpose is
real and simple as I have stated from the very beginning that I would
like to have per-app cgroup hierarchy to charge memory to root if it
is not enabled explicitly for memory. The reason has also been stated
like reclaim and workingset regression in suren's report. I don't
think my proposal will do any harm to current v2's mechanism besides
asking for the admin echo "+memory" to their desire group.
> --
> Michal Hocko
> SUSE Labs
