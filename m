Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC73CA57B
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGOSZO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhGOSZO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 14:25:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7DC06175F
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 11:22:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so11559639lfq.0
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1H/bWMbBZ+Edpc8fYBwimkAh3hVifPS5VIkP0ejhXM=;
        b=kKak+JOk+MJfDv2F7RXrt3mwVvzMfe5u5QF+FTa8kVNr/0kDzmQ8K59PTs+ihYjGud
         GDgPuLMACsaJ8lKeAOD9jHahyL0gpPaGg8FZFtKsZCcvrTJDM7y9IYAeXg8uXz4RqzAg
         fWVCp0S3F6cF6U9aiOg8XjrZfCj2Kgp66z97hyfV2lVckGC/v/lWSMbeAcjOvlKwJWJj
         g0SkA7O5ZXZKpK/+SO8D5K+O3xaY76PDvKDvz4fbbvs/KEJm7d8/e8ynAKsn8hnxhEap
         aClCZ7jLFilMZI3GCplmR/1UTxs7hptszBd3Y293WXpajuNS89Wt1AYCm6JLt/scl3HX
         8IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1H/bWMbBZ+Edpc8fYBwimkAh3hVifPS5VIkP0ejhXM=;
        b=UgjxH8od9MxKpWxiViCBIVD1416lVCkSo4Qm2fWU3fUltAQ7z9yXQK2xE5Ox3SFiBl
         HLo8iaQDS6EtR6qGDgoRuunSQtgCbhRmYCQiosyH+kRG/cSOQyNMOpd8bxv0+e6Yg9PU
         UJEkgQO4K5UTc+uur0SEjMoM8/nAXh4v3Ubdnk5Tj3mlzYHLRy6i2h1LfXceEpNll+oi
         1ZWftiyWNPvcxeNxpJiID8dJf8eKtQgSWarxw+qs3XVJyZ7oKheI12r/Y5iUZmYrZ3Hv
         fzO9F3Fb/zRDbPlkuZDq1jjZbPWsrvYaw5ms+ZRL3x5GmSP+2lFvgKlihgpqBcXPF6JK
         HKGA==
X-Gm-Message-State: AOAM531aHj6s5h39LpdbDrQ5bx4ehpFBPmuXfWHkOmEiXWwx9yEADjrW
        8j26DSNnRSxiPdL5/WC0VZrvVxLLM4QtOmE6pEuT0w==
X-Google-Smtp-Source: ABdhPJwaYi06+2Yqd174ywvY5No8oZFV+JpRoqSRFcHPyb7bSJE9pNhNtlm7eepc3Y9QXgKPq77mgjiuYd3+zXsQzS8=
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr4660747lfu.299.1626373337406;
 Thu, 15 Jul 2021 11:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <1626333284-1404-1-git-send-email-nglaive@gmail.com> <YPB1EPaunr5587h5@casper.infradead.org>
In-Reply-To: <YPB1EPaunr5587h5@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 15 Jul 2021 11:22:05 -0700
Message-ID: <CALvZod7sGcOASaFi6st40DSsXh1a0mv7HQ7Vc1pXxnsDgmDPkg@mail.gmail.com>
Subject: Re: [PATCH] memcg: charge semaphores and sem_undo objects
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yutian Yang <nglaive@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 15, 2021 at 10:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 15, 2021 at 03:14:44AM -0400, Yutian Yang wrote:
> > This patch adds accounting flags to semaphores and sem_undo allocation
> > sites so that kernel could correctly charge these objects.
> >
> > A malicious user could take up more than 63GB unaccounted memory under
> > default sysctl settings by exploiting the unaccounted objects. She could
> > allocate up to 32,000 unaccounted semaphore sets with up to 32,000
> > unaccounted semaphore objects in each set. She could further allocate one
> > sem_undo unaccounted object for each semaphore set.
>
> Do we really have to account every object that's allocated on behalf of
> userspace?  ie how seriously do we take this kind of thing?  Are memcgs
> supposed to be a hard limit, or are they just a rough accounting thing?

The memcgs are used for providing isolation between different
workloads running on the system and not just rough accounting
estimation. So, if there is an unbound allocation which can be
triggered by userspace than it should be accounted.

>
> There could be a very large stream of patches turning GFP_KERNEL into
> GFP_KERNEL_ACCOUNT.  For example, file locks (fs/locks.c) are only
> allocated with GFP_KERNEL and you can allocate one lock per byte of a
> file.  I'm sure there are hundreds more places where we do similar things.

We used to do opt-out kmem memcg accounting but switched to opt-in
with a9bb7e620efdf ("memcg: only account kmem allocations marked as
__GFP_ACCOUNT") with the reason that number of allocations which
should not be charged are larger than the allocations which should be
charged.

Personally I would prefer we go back to the opt-out accounting
specially after we have switched to reparenting the kmem charges and
shared kmem caches.
