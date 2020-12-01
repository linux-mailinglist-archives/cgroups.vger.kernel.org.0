Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382842C9E10
	for <lists+cgroups@lfdr.de>; Tue,  1 Dec 2020 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgLAJbG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Dec 2020 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgLAIzH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Dec 2020 03:55:07 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B42C0613CF
        for <cgroups@vger.kernel.org>; Tue,  1 Dec 2020 00:54:21 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id e5so826974pjt.0
        for <cgroups@vger.kernel.org>; Tue, 01 Dec 2020 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niYaq/JRpKzB99MWM85q+70GJ2PSdrtB0S69IuuZNQw=;
        b=l0RgZkr/ooILtuQNf9RcVw8IoO2KP6POtGiNC/rcv5cNIRvSz9UPSEkkRN0q+ZduaQ
         pssQKPNZ79aC1+B83P54e2Du+lK6TMRWg2ZzIffub/R03C3mnsN5LA6VxjJi/J+PwSy8
         WwZ9X65aTRsj2ulLLDCFKXrkRHOMW/0yeb73X6TKbhFdHdcGOrnGcRQlnGlbAbbFViS7
         xEVIDudge5yRqV3e07lfxvmIVeoLZz9srEH1gVzQZV5yEiAweAq51wOv6eWi5nrDrs8h
         w8syYqUaaQ7WUfaRxU23EvFdAb4k0gTz0F8YDslH7Qwv4VHnGzCL+z0jvKcZyjCOtUmh
         4bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niYaq/JRpKzB99MWM85q+70GJ2PSdrtB0S69IuuZNQw=;
        b=Hbcyt/R9/Xcn6dfG96vjEXik9To3DPzo8pletNu7I5R5WcF5J8cuz+ORwIAi7ntWJv
         vGmdIHDicasVhagrhoNqFavMvowltvzKqCfUk4QZbbynp9n2aDVfS4a5cLbWgRBfErvk
         2n2xMwYtlgKppCapvulN/uDma+YVfvSnkr6Q4HTgxxe53BuPiJ7n4bKNcqRcwCR1Lnfo
         iobDE2utkXCsg+us3RaUdxRiyUy8a+2Jxxs6gVKC0TJiy46cYXguyeEoxx47DTZpcO70
         pwxYlToncKNhbjV1PnHuKC27fc6HfW/4177T73FjeV9ZrFKuTac/wT/mnlDxEDFEOV5E
         0ObA==
X-Gm-Message-State: AOAM533uHWKgbP+YSKDhcPvxT35B9YFU7ZwjTyjymRzE/hTsRKHp8cf1
        CF1LPjSXY27fQkw+3AWAk8QOKAnMFg6Hj8O319AiWw==
X-Google-Smtp-Source: ABdhPJwo8+fWwdRXF65E5blWn6IRolCg3aG0zKG6QXDMLIDW3SB6+ovX2dcMxBJQjXU7RrgwmROOOyCmkMiy0xq4xeo=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr1771540pjq.13.1606812861293;
 Tue, 01 Dec 2020 00:54:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
 <CAA5enKbujU+PRwA3qeYqx-Ydcj7owJnYkeTYJFdBweQJjWU78w@mail.gmail.com>
In-Reply-To: <CAA5enKbujU+PRwA3qeYqx-Ydcj7owJnYkeTYJFdBweQJjWU78w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 1 Dec 2020 16:53:45 +0800
Message-ID: <CAMZfGtUQMmH566CTT2G0KugLsX_3ouOM_80Kqk1R6b1N_NGB-Q@mail.gmail.com>
Subject: Re: [External] Re: BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0x1e0
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        inux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.co,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 1, 2020 at 4:02 AM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> On Mon, 30 Nov 2020 at 19:52, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > [  285.863025] BUG: kernel NULL pointer dereference, address: 00000000000000c8
>
> This looks to be the same as
> https://lore.kernel.org/linux-mm/20201130132345.GJ17338@dhcp22.suse.cz/T/#t

I am sure it is the same issue.



-- 
Yours,
Muchun
