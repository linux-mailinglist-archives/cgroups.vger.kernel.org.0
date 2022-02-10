Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07B4B181B
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiBJWZR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 17:25:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiBJWZO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 17:25:14 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294325C2
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:25:14 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i34so13126775lfv.2
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9taNQqr53065W1oX4JDNtAk/+njpm3x8DzxRxP1lHU=;
        b=D959OvVwl7BXuwDxGu0YH5B8iaG9JycwJXSActYL0Rhkvl1XpSclE6R6SP/TS9KpOb
         uIITo6yOM2u/NW7Lpt2qvugxdahKXm7DxUSfw4CvZOax6yiLj0PuPiJD0kxUvrCoLRZE
         8+tEADL2hNCtlzAphVfr0GXuxsruicxdkryZKu4A3EZQYGNy1YGT2PXBJWQ7cmvCU5sT
         JmTq6TyMVzqerdn7CZcyv983bkS+4BRuAEOfAWl2vQTFGVVjXWYx7YXbhJ8zrn9tghSq
         n6Z4aZpGnza7LI6CgiHjzXoxAuxZQeb8ZX3fWnC9sHKXTbS9MAdJvXlr3WYwA+ZhdPb1
         7tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9taNQqr53065W1oX4JDNtAk/+njpm3x8DzxRxP1lHU=;
        b=sUoyfRlH1m/DNj89lai9nv9zJVYVc2oEvrvCT6+sSoQkM4g88eCLqi2nceQiDZV3HM
         lIqyWkYpnxe4ytaBMbZJhSRWLje9UREB1kDBnzUJYO0fWh7+LHwPBG5KFkex9krRd29y
         JbRDuvFsb4L95LjLDiVEWFr/YeP9erALqgZVeE0sLByZ3FZHj1oxd1iyAWmUZdFTQEPp
         dW9tg/nc/aib9Os1R4BKD6oqsuzm9g1XpE1ZYUXINnfzL8UPlp5wGFGc0/pSCYLw669u
         zibG1IRJUczl0G99i0ICfWTILZXd1ViTvBwjJrga9rAdMBg2elSApgD7OfE/vNYBLQgA
         TrDQ==
X-Gm-Message-State: AOAM532dJIK6FKtHOPn2KaA89q87DUSJmDbKniWRjRLuP9qeS9ZLARXJ
        LamBBQZtTne3fmgk/uGeYwbotHrVzE41pq1v9FiWAHsfq9YjKw==
X-Google-Smtp-Source: ABdhPJyM1osoqKEaHQe/4Fm9kFoRNB8nnlkgffkyJW13U9ZE2XGrrPprjfDe61hw1PjYuIsv/WI+Ymv70pU4S4b9iCg=
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr6592317lfl.8.1644531912995;
 Thu, 10 Feb 2022 14:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com> <20220210081437.1884008-3-shakeelb@google.com>
 <YgVvgCbbTrDPb5tT@carbon.dhcp.thefacebook.com>
In-Reply-To: <YgVvgCbbTrDPb5tT@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Feb 2022 14:25:01 -0800
Message-ID: <CALvZod5FBEHzNcXD-Wo5BPmMxu+Kf-ZA8s6N9EmD6TeFocs3_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] memcg: unify force charging conditions
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 12:03 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Feb 10, 2022 at 12:14:35AM -0800, Shakeel Butt wrote:
> > Currently the kernel force charges the allocations which have __GFP_HIGH
> > flag without triggering the memory reclaim. __GFP_HIGH indicates that
> > the caller is high priority and since commit 869712fd3de5 ("mm:
> > memcontrol: fix network errors from failing __GFP_ATOMIC charges") the
> > kernel let such allocations do force charging. Please note that
> > __GFP_ATOMIC has been replaced by __GFP_HIGH.
> >
> > __GFP_HIGH does not tell if the caller can block or can trigger reclaim.
> > There are separate checks to determine that. So, there is no need to
> > skip reclaim for __GFP_HIGH allocations. So, handle __GFP_HIGH together
> > with __GFP_NOFAIL which also does force charging.
>
> This sounds very reasonable. But shouldn't we check if __GFP_DIRECT_RECLAIM
> is set and bail out otherwise?
>

We already have a gfpflags_allow_blocking() check which checks for
__GFP_DIRECT_RECLAIM.
