Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620442CDEC
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 00:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhJMW22 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 18:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJMW22 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 18:28:28 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A41CC061746
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 15:26:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w10so10073406ybt.4
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9ddwzDwjBRvjNSeQZZTZvJ2NfxDHWqyayJGGbMH5Mc=;
        b=g+egBO0u1JLmFD3nechTRv3dWXbR4MmZz3U4Tu2XhQNHpDt5Cp/41Rr8/9empDSbjJ
         LwTyaSGs2kCyIlQ5cWGxt4GwyEtijW3UuCi8ykujsxgRizKFdNnZkilB7Ux19W3z4gXk
         yoW9Gn8FJ9q4h59ecIWXUCmwt2E6skuJhARdodYpzxetPL8QM0/A9+30BzxUhSx2SImy
         /QlM39coka72/w8/hbx03q7tBa6oCSLHFOgWh/TgBgG+jiYkM9kqRQIq0NGkPEmH0gS+
         fEs7UZWcNO+b4yX+wQcCTrC24kNsN3iEVgn44C5l5Pdsw/0kIgw1/4OBAs7tuax/gFPm
         tt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9ddwzDwjBRvjNSeQZZTZvJ2NfxDHWqyayJGGbMH5Mc=;
        b=qw/twiXsaqwuyQponGBLzPk6BKQVzo26cU5eLLC79H4vnsAtkjbg5c/iqy/V/NwN6I
         bGOZmtIs62rSGEwXghx9+Jz9VUkzw/6anp74EgeSsF8o9XOgl3RtMqF00pY+vIYVnSkR
         GGhWIb825ZbrvxbLe9fIjycROcSJ1hH5lgrn4LAoSWEPWAvKdMnCuj/yv6CiEBMPp767
         +5QzkBBZ6V45xTtC0CFA8Dmz7ua1VtjhKRN3bqAe8sHoUTUlvyCjUmRAo4UzptXh3Cbv
         psy9Gko1glr9BpPLppucgmboeGoCkjlkCysFnj8LNhN8063AHIUaMvDjPPAjorIdxVDe
         2DVA==
X-Gm-Message-State: AOAM5330Ve418kcaqfJAre0XQv0Rj215+/qXv84CKe2I+WQ+lRa5epy5
        2xDS8meN+5m5lbttKptUiIVgtI7zl3IhlikNhEqkQw==
X-Google-Smtp-Source: ABdhPJyfto3QlbGgFWppfUHSUw8DtFI2urBmgJXpBxQvxuI0GnqeXTrAMQMhYA4YvMxA1Mt8j8zni80xu6X3kvlKnyk=
X-Received: by 2002:a25:1c08:: with SMTP id c8mr2421015ybc.316.1634163983003;
 Wed, 13 Oct 2021 15:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211013194338.1804247-1-shakeelb@google.com> <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
In-Reply-To: <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 15:26:11 -0700
Message-ID: <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 3:03 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Oct 13, 2021 at 12:43:38PM -0700, Shakeel Butt wrote:
> > The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> > __vmalloc_area_node()") switched to bulk page allocator for order 0
> > allocation backing vmalloc. However bulk page allocator does not support
> > __GFP_ACCOUNT allocations and there are several users of
> > kvmalloc(__GFP_ACCOUNT).
> >
> > For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> > future if there is workload that can be significantly improved with the
> > bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> > decision.
> >
> > Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  mm/page_alloc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 668edb16446a..b3acad4615d3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >       unsigned int alloc_flags = ALLOC_WMARK_LOW;
> >       int nr_populated = 0, nr_account = 0;
> >
> > +     /* Bulk allocator does not support memcg accounting. */
> > +     if (unlikely(gfp & __GFP_ACCOUNT))
> > +             goto out;
> > +
>
> Isn't it a bit too aggressive?
>
> How about
>     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))

We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
trigger bulk page allocator through vmalloc, so I don't think the
warning would be any helpful.

>        gfp &= ~__GFP_ACCOUNT;

Bulk allocator is best effort, so callers have adequate fallbacks.
Transparently disabling accounting would be unexpected.
