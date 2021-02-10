Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB6316843
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBJNrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 08:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhBJNro (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Feb 2021 08:47:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A6C06174A
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 05:47:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w36so2983015lfu.4
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7AQuIHqlGeDKdDmQaoPxTGljXqoMuKxFCh/+vT0i5k=;
        b=nOGKWwErjCXi0YFKi585FYnDqp7VZktLvttuvqdhK0nRwzl46aW1e6ZK2y4GhoJ9i8
         KpIxBAdYnb+08xigU5i30VZuFTrxH9hEDGhvwYEsy/vXJ20y3z8qmZGxB570y+8nwDXr
         KqRlvpUxKhal/kP45OJ60gFtDUeeffZe8T1LC5rRY+O2Fx+sJ5NgQqI1K5vhBdjd2A6B
         qJw8QKEDXZMZlFJvt+pc5moGlNUZkY9BSRYZmVwipRgXbnYqLGFJEc+CMn2+gVC3m7gE
         4OfOhMBxuIem8mVWHVp+YR/xI5Pyv3MgEexPFS4XvAKqbFwqVEoJy6zxsM+1KZMJkXNM
         BJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7AQuIHqlGeDKdDmQaoPxTGljXqoMuKxFCh/+vT0i5k=;
        b=YuCMV/W5yo8nbv6AhMqfuCuy81bgkr+tJzRJrF6K/HV1iu4d6fj4czdfWZAkJOceKu
         hmWHvws6kyadc74+Kr9vYT6HT9CN4sWi7YUOglF3sekMz2M8G2CESau2QfoAqRcNCdQH
         VMVkSt7tP7lxtq4UwVaaVWzMc+BMlJjdsW9ZOEl3a9Hvjd3jbw+iePq5l7h4ZTlRWgBV
         fQyhgf97YZR5q8F8BpdovEaf537tUfZobND+bweESrWYisRhgMUSsfWdCu/adkoQYqgZ
         wQ2801cDVsF1NwawfLkniWLW6LqXiao164PhAP+KaNp/9kFkOX0Zhq/2rlSawh3k88lP
         vRng==
X-Gm-Message-State: AOAM530FKU0YkHyF99SM3ans9EMAnUi7qaS8jDtirTYPIvRl/Cs+lde9
        c+twpO9+Rn4ff4wyj9gXpb0b1Ig4byhEYORJV1P7lw==
X-Google-Smtp-Source: ABdhPJz841Cfn+4sq64Q5uE+gYJv38/kovaen61M8ii6Y201iSug/qJh/kkiv/4ACj5E6wmRFUhiWf/OXsFV7bvBq+s=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr1722867lff.347.1612964822071;
 Wed, 10 Feb 2021 05:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210209214543.112655-1-hannes@cmpxchg.org>
In-Reply-To: <20210209214543.112655-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Feb 2021 05:46:51 -0800
Message-ID: <CALvZod7Tf+KBhT=3WCQ_uWa7_mZad6-L8wQJghxPRL_tVyQ8Cw@mail.gmail.com>
Subject: Re: [PATCH] mm: page-writeback: simplify memcg handling in test_clear_page_writeback()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 9, 2021 at 1:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Page writeback doesn't hold a page reference, which allows truncate to
> free a page the second PageWriteback is cleared. This used to require
> special attention in test_clear_page_writeback(), where we had to be
> careful not to rely on the unstable page->memcg binding and look up
> all the necessary information before clearing the writeback flag.
>
> Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> explicit reference on the page, and this dance is no longer needed.
>
> Use unlock_page_memcg() and dec_lruvec_page_stat() directly.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
