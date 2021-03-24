Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA283348074
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 19:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhCXS0U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Mar 2021 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbhCXS0C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Mar 2021 14:26:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A6C0613DE
        for <cgroups@vger.kernel.org>; Wed, 24 Mar 2021 11:26:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a198so33418736lfd.7
        for <cgroups@vger.kernel.org>; Wed, 24 Mar 2021 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4N8DBRr0y3pnQ+GYU6PHDcjxPfiucyRsdqMiT4zgqA=;
        b=G6Mpzu8Fe8xOBs6JczHBtn8H0S8SCoL1f8ofwhnllztiurQZdtRKZfp9fQh5HV+Zha
         u8r+/u2f70a05QIFYREh/+taoxH++OKNA425bEESIlpfmAPzzV5mU2NydGChVd/0LHxY
         XEUViqaaHmjCHFqeIrZDAqfMHH8MMp0dHbZE7EKo00GjFbl8Bdqgyja6/NxSJdNGVYBp
         p4NJfhzdfQ9irpzalC4O5NRVp6DG1A3wZIOSxd0RZ0EMqHYYjg2haX0i1RyhustM4tnU
         C6LDzJlJpcs47PgnI0rbDzEzYUarNvEY9LvK/4MffNmBCPBazyFFVsd3/7ZhxAiY1+Nh
         a6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4N8DBRr0y3pnQ+GYU6PHDcjxPfiucyRsdqMiT4zgqA=;
        b=FdaErJ/JUUYhSnKM7Ma/pV44/PQHBAWKf/Pw0+K2VxfsOjrP8plgAlIskH69/sS4S6
         IrTX7i2fQPGI1x3udEvGpODXkQ9Eg/4bLLPpeyQ0veU34vSYzKLBVKSOhp71RqI0FVTn
         q/bl/Km2HHaFoK4lhgmTs1JZbIC6lc/nRhhS15+ptY0Q8DkzQVozPi4IMCNiivmmgdA5
         edZdttiG4Kb7ZiTxHg4+n6irOEUUfAHeTFZW5JkkGqN0QEjQg9sTfhWgZul5K9zPoY0u
         rybyO4OXFYh1tfBV5tDbHO9L9BTzHPYn4QFPrSaAuZgCDH8j5u5AWODtV/ZJVTFdtDP5
         8ymA==
X-Gm-Message-State: AOAM532ozFkHL1wVGpuMPsbBt1r/Iobo4zfKVH/LEecJjQQyHAjAXYO5
        l2IYow2ZwxOEqow1XgKx5EbWwseDxmrlDbFrTtAVzQ==
X-Google-Smtp-Source: ABdhPJzU2LObFzD9uVmKqWKo6lDRJghCKK6OF13SkHBoNeLbJ3Nm3c7JlGcLbbioSEdzB+IJyTohlPk5Vn9yuz2lt14=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr2611590lfo.549.1616610359718;
 Wed, 24 Mar 2021 11:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210316041645.144249-1-arjunroy.kdev@gmail.com>
 <YFCH8vzFGmfFRCvV@cmpxchg.org> <CAOFY-A23NBpJQ=mVQuvFib+cREAZ_wC5=FOMzv3YCO69E4qRxw@mail.gmail.com>
 <YFJ+5+NBOBiUbGWS@cmpxchg.org> <CAOFY-A17g-Aq_TsSX8=mD7ZaSAqx3gzUuCJT8K0xwrSuYdP4Kw@mail.gmail.com>
 <YFoe8BO0JsbXTHHF@cmpxchg.org> <CAOFY-A2dfWS91b10R9Pu-5T-uT2qF9h9Lm8GaJfV9shfjP4Wbg@mail.gmail.com>
In-Reply-To: <CAOFY-A2dfWS91b10R9Pu-5T-uT2qF9h9Lm8GaJfV9shfjP4Wbg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Mar 2021 11:25:47 -0700
Message-ID: <CALvZod527EgYmkqWdoLCARj2BD2=YWVCC9Dk87gfQRG8NViX_A@mail.gmail.com>
Subject: Re: [mm, net-next v2] mm: net: memcg accounting for TCP rx zerocopy
To:     Arjun Roy <arjunroy@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Arjun Roy <arjunroy.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 23, 2021 at 11:42 AM Arjun Roy <arjunroy@google.com> wrote:
>
[...]
>
> To summarize then, it seems to me that we're on the same page now.
> I'll put together a tentative v3 such that:
> 1. It uses pre-charging, as previously discussed.
> 2. It uses a page flag to delineate pages of a certain networking sort
> (ie. this mechanism).
> 3. It avails itself of up to 4 words of data inside struct page,
> inside the networking specific struct.
> 4. And it sets up this opt-in lifecycle notification for drivers that
> choose to use it, falling back to existing behaviour without.
>

Arjun, if you don't mind, can you explain how the lifetime of such a
page will look like?

For example:

Driver:
page = dev_alloc_page()
/* page has 1 ref */
dev_map_page(page)
/* I don't think dev_map_page() takes a ref on page, so the ref remains 1. */

On incoming traffic the page goes to skb and which then gets assigned
to a struct sock. Does the kernel increase refcnt of the page on these
operations?

The page gets mapped into user space which increments its refcnt.

After processing the data, the application unmaps the page and its
refcnt will be decremented.

__put_page() will be called when refcnt reaches 0, so, the initial
refcnt which the driver has acquired, has to be transferred to the
next layer. So, I am trying to understand how that will work?
