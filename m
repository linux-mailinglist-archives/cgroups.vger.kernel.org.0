Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE051D64
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFXVwV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 17:52:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44856 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfFXVwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 17:52:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so14098077ljc.11
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2019 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2TgnyjeWoDT8cizs+0926CcrBI/Czk7Q1OwFweZT40=;
        b=YW+HL5IBGifOF6jZu1p6PtaguBQyhJkmQ9YMn7Jji10endO+CCULhFAsaLYdbA85HU
         bFUAnpfdTAsZ1Gvy96tlCor3QNdK05lm3AEeLiJmDqpEr3l1mXaGi+f50BoXwSjtl9UA
         vNVPNKHu+JCKTKrlQwc17yT7GYO7Y66TTo8Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2TgnyjeWoDT8cizs+0926CcrBI/Czk7Q1OwFweZT40=;
        b=HdvKJBUXDcDGL5m7lJybfuQLRPi7CDvGYzIbJ07Ae2WnAbPoyO6tjjD3KKYGiJLIKh
         /9kVGk/sdVnTqqiFsS+fQagvg1wV77+Vmf4zz3ljYghNsaadkxhCOySb4+NLl7NDguq4
         FIjHfKjBYG3A7WG9uygBkKqxLEkuKDB6c3l9vToLlhqDXz6ZdCR3vtlSAgessANg38dw
         nKGCXYSb5L2Tp4uuaR1loY6HaGWpmvl+mCyaNHdWV/3QeyPYUbg6EgpVQPdydo3DRfQg
         0CDZWuip8V62jnqFvu65dvD75mYJS4iocNERIGIM8xZbg5Q4XFF4MjWk2ddIzJ0WgIij
         pq3Q==
X-Gm-Message-State: APjAAAUUjl6x1gjQdh1cK4+WyVUUXKXs97uyhCoZiA0Nv60AmgvzuSVr
        zNn2RndA+r8Jxd4twZkRPRJqvtgBw6I=
X-Google-Smtp-Source: APXvYqw7wwseVrLcOT1v4bEiS/fcI6nKByDfM2gBmKuHr5PDP/Wihp0Msg2HDSOvhMVl9k2PsUdilw==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr833898lji.15.1561413138548;
        Mon, 24 Jun 2019 14:52:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j90sm1905968ljb.29.2019.06.24.14.52.17
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 14:52:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 136so11129947lfa.8
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2019 14:52:17 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr28053521lfm.134.1561413136997;
 Mon, 24 Jun 2019 14:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190524153148.18481-1-hannes@cmpxchg.org> <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org> <20190530161548.GA8415@cmpxchg.org>
 <20190530171356.GA19630@bombadil.infradead.org> <20190624151923.GA10572@cmpxchg.org>
In-Reply-To: <20190624151923.GA10572@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 05:52:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjcO7WjWyAoBmXDWcn7spfJbbgF_tXaHrqANVqEH8DGmQ@mail.gmail.com>
Message-ID: <CAHk-=wjcO7WjWyAoBmXDWcn7spfJbbgF_tXaHrqANVqEH8DGmQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix page cache convergence regression
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 24, 2019 at 11:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hey, it's three weeks later and we're about to miss 5.2.
>
> This sucks, Matthew.

Yes.

And I do think that having a real gfp field there would be better than
the very odd xa_flags that is *marked* as being gfp_t, but isn't
really a gfp_t at all.

So how about we apply Johannes' patch, and then work on making that
xa_flags field be a proper type of its own. Because it really isn't a
gfp_t, and never has been, even if there might be some very limited
and hacky overlap right now.

Alternatrively, the subset of bits that _can_ be used as a gfp should
actually be used as such, in xas_alloc/xas_nomem. So that you can do

    xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | __GFP_ACCOUNT);

in __address_space_init_once() and it would do what it is supposed to do.

Willy?

               Linus
