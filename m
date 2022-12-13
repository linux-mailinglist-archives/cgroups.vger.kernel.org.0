Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0244664BD9F
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 20:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiLMTx6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 14:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiLMTx4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 14:53:56 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F241A067
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 11:53:54 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 128so15756377vsz.12
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 11:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G68UrwkYoX/Qe/LoWiVKT0TgPWlsfh6ss6fYKw0/u6Q=;
        b=Sm8jgscfl0bxKQljesMfB/GLmzJaJD2vpXZGfn0SUkb5+iYT7soSkMXvoJkuAmGEi8
         Xf50Z0xzzN+cwQkwCYl+q6vPKzbkk4kB1e8tTanObV8TGNuryvpt+NjUQ2TkXxxqIzpO
         LYcjE7/r+2zyTzC2NQSG5lb8ylYzAAhsRfiQYBJ4M7f2VPPi5KYBls3PFjee2xiNgiCU
         +k3NJS+AJ0CdsG4wCv36sgBuDF+yZcefMFa7BEGCR1GbvSbdSINRBb/q5jrbF0UZrufz
         3hLaS3wKXAXEwWDVCMxik4Ytq8v6dEUK4LcVueiRfgrW+BpP7dnoSEuoNaVY6dRzSENK
         AT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G68UrwkYoX/Qe/LoWiVKT0TgPWlsfh6ss6fYKw0/u6Q=;
        b=xgz+TXcPTL1jZkDUEbdvOcQVkoR556Ye6fveT2L9npyk8XXaqZs4XVn5oD34yuoR8p
         UJ3AfnMYoU1pf3j4maJasvw1XbGs80k+1xAW2jksa++cXybth4YZxRyX6DgssA9ClQMo
         TxoQvg712yOkLU59cD42JxEfssOaHrYlP96kGkTbKdtJuDl3sz1ZuX/HEJlTrMAYDj/9
         ygq//atQRPjBb+X28cD9zmGVpKskr2HoDDKl/wBj8xmH1mCXR3gkJciqTMTPjX7i7dzu
         fHcTYOQjuvs1rZOngtQdZ1R79KvtSMpDJQjemwFFZSh7Nt4rimitqeockWfBFh5g65sx
         urog==
X-Gm-Message-State: ANoB5pkzQ5ymzrnf8/Ycg4dpAMlEXLeyzoEfZSTrcDpX+yYnSSRj6IrC
        g9lxPb8iZ7yBXYGB7nZpZQSNpsZ3Nr8z1wFP3YZ0XQ==
X-Google-Smtp-Source: AA0mqf6neKya6HOBCrEDVGywH2EKFZpIFqYaI1I7eSYfNlwOM6XXk5c5BHVV+2II+AgVkhYA1AerI7HFu29tEnLXKD0=
X-Received: by 2002:a05:6102:cd1:b0:3aa:1bff:a8a5 with SMTP id
 g17-20020a0561020cd100b003aa1bffa8a5mr55883869vst.67.1670961233827; Tue, 13
 Dec 2022 11:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz> <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <Y5g41HF2TcLzro4o@dhcp22.suse.cz> <Y5iet+ch24YrvExA@cmpxchg.org>
In-Reply-To: <Y5iet+ch24YrvExA@cmpxchg.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 13 Dec 2022 11:53:42 -0800
Message-ID: <CAHS8izPVbCZOeXxr=Fawa6N92WqJ=6CgP4vHuh-LA_aOH1QOvQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 13, 2022 at 7:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Dec 13, 2022 at 09:33:24AM +0100, Michal Hocko wrote:
> > I do recognize your need to control the demotion but I argue that it is
> > a bad idea to rely on an implicit behavior of the memory reclaim and an
> > interface which is _documented_ to primarily _reclaim_ memory.
>
> I think memory.reclaim should demote as part of page aging. What I'd
> like to avoid is *having* to manually control the aging component in
> the interface (e.g. making memory.reclaim *only* reclaim, and
> *requiring* a coordinated use of memory.demote to ensure progress.)
>
> > Really, consider that the current demotion implementation will change
> > in the future and based on a newly added heuristic memory reclaim or
> > compression would be preferred over migration to a different tier.  This
> > might completely break your current assumptions and break your usecase
> > which relies on an implicit demotion behavior.  Do you see that as a
> > potential problem at all? What shall we do in that case? Special case
> > memory.reclaim behavior?
>
> Shouldn't that be derived from the distance propertiers in the tier
> configuration?
>
> I.e. if local compression is faster than demoting to a slower node, we
> should maybe have a separate tier for that. Ignoring proactive reclaim
> or demotion commands for a second: on that node, global memory
> pressure should always compress first, while the oldest pages from the
> compression cache should demote to the other node(s) - until they
> eventually get swapped out.
>
> However fine-grained we make proactive reclaim control over these
> stages, it should at least be possible for the user to request the
> default behavior that global pressure follows, without jumping through
> hoops or requiring the coordinated use of multiple knobs. So IMO there
> is an argument for having a singular knob that requests comprehensive
> aging and reclaiming across the configured hierarchy.
>
> As far as explicit control over the individual stages goes - no idea
> if you would call the compression stage demotion or reclaim. The
> distinction still does not make much of sense to me, since reclaim is
> just another form of demotion. Sure, page faults have a different
> access latency than dax to slower memory. But you could also have 3
> tiers of memory where the difference between tier 1 and 2 is much
> smaller than the difference between 2 and 3, and you might want to
> apply different demotion rates between them as well.
>
> The other argument is that demotion does not free cgroup memory,
> whereas reclaim does. But with multiple memory tiers of vastly
> different performance, isn't there also an argument for granting
> cgroups different shares of each memory? So that a higher priority
> group has access to a bigger share of the fastest memory, and lower
> prio cgroups are relegated to lower tiers. If we split those pools,
> then "demotion" will actually free memory in a cgroup.
>

I would also like to say I implemented something in line with that in [1].

In this patch, pages demoted from inside the nodemask to outside the
nodemask count as 'reclaimed'. This, in my mind, is a very generic
solution to the 'should demoted pages count as reclaim?' problem, and
will work in all scenarios as long as the nodemask passed to
shrink_folio_list() is set correctly by the call stack.

> This is why I liked adding a nodes= argument to memory.reclaim the
> best. It doesn't encode a distinction that may not last for long.
>
> The problem comes from how to interpret the input argument and the
> return value, right? Could we solve this by requiring the passed
> nodes= to all be of the same memory tier? Then there is no confusion
> around what is requested and what the return value means.
>

I feel like I arrived at a better solution in [1], where pages demoted
from inside of the nodemask to outside count as reclaimed and the rest
don't. But I think we could solve this by explicit checks that nodes=
arg are from the same tier, yes.

> And if no nodes are passed, it means reclaim (from the lowest memory
> tier) X pages and demote as needed, then return the reclaimed pages.
>
> > Now to your specific usecase. If there is a need to do a memory
> > distribution balancing then fine but this should be a well defined
> > interface. E.g. is there a need to not only control demotion but
> > promotions as well? I haven't heard anybody requesting that so far
> > but I can easily imagine that like outsourcing the memory reclaim to
> > the userspace someone might want to do the same thing with the numa
> > balancing because $REASONS. Should that ever happen, I am pretty sure
> > hooking into memory.reclaim is not really a great idea.
>
> Should this ever happen, it would seem fair that that be a separate
> knob anyway, no? One knob to move the pipeline in one direction
> (aging), one knob to move it the other way.

[1] https://lore.kernel.org/linux-mm/20221206023406.3182800-1-almasrymina@google.com/
