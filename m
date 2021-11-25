Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4245D399
	for <lists+cgroups@lfdr.de>; Thu, 25 Nov 2021 04:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbhKYD1k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 22:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhKYDZj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 22:25:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C8C0619E0;
        Wed, 24 Nov 2021 19:14:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so19122880edd.13;
        Wed, 24 Nov 2021 19:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUJ2xL+Px+DOun+h5cyap9d/dwV4T1osfNsX5aVR3pw=;
        b=nDcBW1cRvwI3INDB/78zeUB31/ODkKV5AQk+Mv9y1EzYqq4NByJ2IuLdxSnJvIVwPR
         PPYZJ5f1JTGOlao2bfW/eExJuS02Do+tl2cpuuBbw9gy6QL6HQj1NLFJ51enf9mhG5KN
         X5f8/n2GVyfST9jajOklGweUJG2VNBiPWjxZW47TPHj6mvwOlwceHiBAaTFp1vWa3xGq
         oI4Iwq/XBps2Q4wSsH6nfi6dsta5cktP1DweFQ2XPn329xrU0sR5CAEi1J4UQrrQ3q2i
         TOS6SHWMslVeZWSAf+qsnzpFZm2+/AJsoTqe43/Ryyta71lv7BjIFkHXJvdC/CBf/mpJ
         FbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUJ2xL+Px+DOun+h5cyap9d/dwV4T1osfNsX5aVR3pw=;
        b=NPWaYSwWdaqwcUXt64K3uRgHPVcgy1estGvuf9cHVZGa1dIzrgOrhXFLSbfy52U87M
         GjY1MeV6zxu3Jv3m8VZViPbkHv1w0xgAjW7kBz7aPj2Tk4Hk2bTkbgu/zQqj5AbU9w47
         0n/Y2PFR5hoBrfmshjEsTPDhwWngT88myRCfff18qmirpZlEW0GJUqh51ifebX5rwBEs
         OZi75lrF7poG1UEUatXl2WbBNtj1zSrDF3Z1SV35n8uSZBl3WJhIfDvv8+KxBQZ3jq42
         h5wgNSRCMODV7RX6xHnanhH/CTGUG5McEtPUviikieYen75/Dv9QLaGThASL4fseFFXQ
         lQNg==
X-Gm-Message-State: AOAM533x+RoOVpVPkqcwKsDPwC7WIsKxJ/w1rsy4JA/TsWjXOn2vpJJS
        JJVaWVRwKMB9Qgc1IzB8IO1gFJ27aiz8YsTS3e8=
X-Google-Smtp-Source: ABdhPJwoRS/tohgTWgFAJPxXbo8/xibUjch7SlGQl9ze/Bd7FE7P8ZqYx6H2IQ+8pYaFsTCAdaakCh68g53Y+cz/SPk=
X-Received: by 2002:a05:6402:2806:: with SMTP id h6mr32986106ede.120.1637810046318;
 Wed, 24 Nov 2021 19:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20211124151915.GA6163@haolee.io> <YZ5hBtWPBpHDWzE4@casper.infradead.org>
In-Reply-To: <YZ5hBtWPBpHDWzE4@casper.infradead.org>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Thu, 25 Nov 2021 11:13:54 +0800
Message-ID: <CA+PpKPm4nfFM1XNifQoQT6Q_f3hQ6gSNnCgUumLDnruaLaUgvQ@mail.gmail.com>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org,
        vdavydov.dev@gmail.com, Shakeel Butt <shakeelb@google.com>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 24, 2021 at 11:58 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Nov 24, 2021 at 03:19:15PM +0000, Hao Lee wrote:
> > When several tasks are terminated simultaneously, lots of pages will be
> > released, which can cause severe spinlock contention. Other tasks which
> > are running on the same core will be seriously affected. We can yield
> > cpu to fix this problem.
>
> The realtime people will eat you alive for this suggestion.

Thanks for pointing out this.

>
> > +++ b/mm/swap.c
> > @@ -960,8 +960,14 @@ void release_pages(struct page **pages, int nr)
> >               if (PageLRU(page)) {
> >                       struct lruvec *prev_lruvec = lruvec;
> >
> > -                     lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
> > +retry:
> > +                     lruvec = folio_lruvec_tryrelock_irqsave(folio, lruvec,
> >                                                                       &flags);
> > +                     if (!lruvec) {
> > +                             cond_resched();
> > +                             goto retry;
> > +                     }
> > +
> >                       if (prev_lruvec != lruvec)
