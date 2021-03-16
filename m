Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1605333CDEC
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCPGXF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCPGWj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 02:22:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4EC06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 23:22:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c16so16479247ply.0
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHVFZ6ek9UWH6gJaYSFsmDxhb9ekTRVKDZq6Jazc5rQ=;
        b=pnrONYLdoVlRUvqukdeM+bXd8Ij3mjhE5t0V3KUkfpk/yrSbJMiTCr/S7UD0odUa02
         dWaR7hogUC6ysiqCkMkPEk2Rm3IVlquKQdHRqaOjcwbaGU5bYrQgZbR/QG+VhgyITwf6
         e/ragJyDp+NpS773hJSNltE3XoRaFmfNc8Iq8U25yWlB4aNnetpoVFz4yl7ETuoMnP83
         2M+UYJc9wZw4k2VjBiPyaeFI/Y9/7t/nEJhE31nhE3tiAMGH/f/B+TGq6ZdxRnsfEJnc
         y46UwmnnQfOkJuGmkcKJv5m/gRbBj8RETOssa7aTxyXocQ25FcQhbN+O8uXfxhn888eb
         XcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHVFZ6ek9UWH6gJaYSFsmDxhb9ekTRVKDZq6Jazc5rQ=;
        b=s/5aWBHzN1jhyfpjknyiMLvpNoKiNyGXv/bU/kctpl6uV2grxXE0hKzrznoofrfZQO
         acjiJfg/XJQ8b1dc/d28JMnYUwZQfkAMnm75KiR3gNUparihqhkUgQYn6L1MZAUTqKFk
         n82L9yGoP1q7p72xLqf8YMk4IbzNisdZ4hEcGx7Nj0QjY/2a6ow7fklW3bM85HJwTWLf
         Wi30h75uanWZKw/Qz34NDYChO3jdrudZxpeGIYjsKvdbw0mIAVpiBe/oMuiIQGdRvdTf
         5rFWt0+giTTAQOc3u6DVWyED1+lripRHyEXjLKRjkKdR7InLObFNeuoGbhDpD5IClU30
         mRCg==
X-Gm-Message-State: AOAM530rPBEittuRPjLiFpPQ77Fg2Wn8rXMOdRSAxmQUgSgbsL2+E/Fj
        qZwZQAUFVcvSKfDR3Z3Lqn9kYRfu6RlYi11AXl6NlQ==
X-Google-Smtp-Source: ABdhPJzwigYVXz2vofcgYR8WF6McxMTqCfCE2w04XtmytRTQbUcrh1yt1B0vcVv1/ZkImkLny9NzW7QBJVGP8TQlx/s=
X-Received: by 2002:a17:90a:ce0d:: with SMTP id f13mr3153239pju.85.1615875758578;
 Mon, 15 Mar 2021 23:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210316041645.144249-1-arjunroy.kdev@gmail.com>
 <CAOFY-A1L8c626HZYSWm6ZKFO9mqBdBszv6obX4-1_LmDBQ6Z4A@mail.gmail.com> <CALvZod7hgtdrN_KXD_5JdB2vzJzTc8tVz_5YFN53-xZjpHLLRw@mail.gmail.com>
In-Reply-To: <CALvZod7hgtdrN_KXD_5JdB2vzJzTc8tVz_5YFN53-xZjpHLLRw@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Mon, 15 Mar 2021 23:22:27 -0700
Message-ID: <CAOFY-A0v2BEwRinhPXspjL_3dvyw2kDSyzQgUiJxc+P-3OLP8g@mail.gmail.com>
Subject: Re: [mm, net-next v2] mm: net: memcg accounting for TCP rx zerocopy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Arjun Roy <arjunroy.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 9:29 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Mar 15, 2021 at 9:20 PM Arjun Roy <arjunroy@google.com> wrote:
> >
> [...]
> > >
> >
> > Apologies for the spam - looks like I forgot to rebase the first time
> > I sent this out.
> >
> > Actually, on a related note, it's not 100% clear to me whether this
> > patch (which in its current form, applies to net-next) should instead
> > be based on the mm branch - but the most recent (clean) checkout of mm
> > fails to build for me so net-next for now.
> >
>
> It is due to "mm: page-writeback: simplify memcg handling in
> test_clear_page_writeback()" patch in the mm tree. You would need to
> reintroduce the lock_page_memcg() which returns the memcg and make
> __unlock_page_memcg() non-static.

To clarify, Shakeel - the tag "tag: v5.12-rc2-mmots-2021-03-11-21-49"
fails to build on a clean checkout, without this patch, due to a
compilation failure in mm/shmem.c, for reference:
https://pastebin.com/raw/12eSGdGD
(and that's why I'm basing this patch off of net-next in this email).

-Arjun
