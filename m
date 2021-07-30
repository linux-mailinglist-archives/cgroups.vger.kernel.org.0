Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C33DB148
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 04:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhG3CnO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3CnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 22:43:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACDC061765
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:43:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so13009406pjv.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k7fEyFu7zGXyqWbkTSjvJ6JOYMr8rw/z8q7mEIUc8A=;
        b=JgClgnU9EdwSANU8A5FerpxJDoCmKESOX5v+FZM6r2TrDY8Hsmgx4fSSGUaIChBFJW
         nJ4E/ZBbz1I3MA/8EDBPDxWMF5E3u1sHgvJuQ0NooOw3kwGeUDjcHTC+SoVHq9wRE0PY
         V4+8QyMzbmoBDl3xFidcOKambkn17SDAQFg8woP+NP1uNpxlfm+hNQguFbWO9M9rTIVj
         MwfqoK+BfnglDvvyR3no3rQ73c+0mKGVgwByOa85doAmoI1ui4CnZ0yfBRS+cazSq3l2
         5gkMKx8CC8QVd/AoL8jHejUm2ApZHIr/tSINLrhVkby6HYZ5KngrD4z7/lZ6WSX0Me4t
         aXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k7fEyFu7zGXyqWbkTSjvJ6JOYMr8rw/z8q7mEIUc8A=;
        b=j0dS8MoXX3JAOo897H7YY2++F9eYe9GfAYnC4Tpa6LCbT8Q6O7Nv3GO6Iys9OfZztV
         6on7ZroMiPGUnzUcKrOTsKeklSKAsz2EweCrU8+3ZQYgmUhUqa9AF1Q63aJymCUJ4FMY
         PTWIki2qJ7shyQTpLqd0DY4+FKFfMKJ+jFXpeXJib4sbFuEnsTx9KsJw717jNX2iXwqV
         a83RbTNwY3JZAeDLpdmwvlyvR19kcCRd6I7MZBlzWzGDxUKNANf0GrVEfeAqv8OdVAnS
         U400O17/wk4uEHxIYXWIy3k7yMKpo7/aRobYY1fdFDDDXL1lfq+fvqhs0pfm+hPD3WIu
         cJDg==
X-Gm-Message-State: AOAM530vwPmW00XEFAnanut/pU6SUqZv8JSmI/6M2z+LPUXOWTV/k5dP
        PsTt19gcrOSNk0Y5HahYnZZf8C98A+Ee7m67gY543A==
X-Google-Smtp-Source: ABdhPJyKMjwJtks3kZrAExse5sOaTz+Y2l4NgrwbHMWIdimiFgom2e4JKhi5i2WQTiXiZnf08teTGdgENzry63QbeGo=
X-Received: by 2002:a17:902:6ac9:b029:12c:3bac:8d78 with SMTP id
 i9-20020a1709026ac9b029012c3bac8d78mr348102plt.34.1627612989962; Thu, 29 Jul
 2021 19:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-3-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-3-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:42:29 +0800
Message-ID: <CAMZfGtWESFeDgV7H4N6ch+PpwYAkV+=qPJKiamnZ7sX=6t3e4g@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 8:58 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> narrow the scope of percpu_charge_mutex by moving it here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
