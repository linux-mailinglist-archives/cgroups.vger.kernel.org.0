Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1D1BED93
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgD3BcB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 21:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgD3BcA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 21:32:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89986C035494;
        Wed, 29 Apr 2020 18:32:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so3568639ion.0;
        Wed, 29 Apr 2020 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w8kJY9j/FEki6CAhMOKe13kIgQ0o8hCyo6pGzmOYdc=;
        b=MPwVE+Bkz9CcDJalk+jgqmR3yxPIKUJC9RYNqy7zduk8OZljggsMW54Iu0DIGQxaKG
         fdbwsrCCpogT+InOFKVy82EoAxMwVggL1RJOkUH2Q02y1wlfKbCrlNbt5CcaVv20Z+FL
         vtJXW1aC5Aw5Wz4IGBUkzIkcsn6XtJeWsA8S0Z8MAX9Zv5uI6T42mM0xogcGR76LyuCH
         2geNetHgdjA7o06cI3ZjVvsDPq/TlwcYzBJL9HfhiTot/9NI/D+pT2RhoTnJblRugKJo
         kqomD+/oVM6lCXM4NUSGp/oVrh5MHBenNP42ujYcZQF7JDZ/4qmFgrnvvnD4lCrrwxyd
         J1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w8kJY9j/FEki6CAhMOKe13kIgQ0o8hCyo6pGzmOYdc=;
        b=aujRmef9ltzCJaHiqw/F2B1KHkjvVlk75X8kmKlFmpvyrca3ktFa5Zj3TLV/rkDR3k
         3rEaUOKgp2k76JDN3Y/Dzgw5m8pj0SMk/wqo+OraEcb/5Ns7Y0Yzii8zPIHW1zXmA7TJ
         QXsYU6luczLXiQNBdvzJ5STZ0mCXcJCwZ9M/v5xNfEUdkpuSA5vN1K/XP6kd8onHhXmf
         9Dvp/zue2svPauAqD+u9We+GP6KsVLvwpdvgkxhcEWDZlqimaCqtQsZ5uvHMNkx8Y7KE
         p7KsssPwLuNMguWHUuFBug6mU8MfXMGmRrB9MrA58vVyAMzNAAYtxO/xInes2hjtxC6t
         wrUg==
X-Gm-Message-State: AGi0PubrWQjzcwaTnzcj3X+XC9FOl5ZIRscgaQIqitZkRtZUptK06HwM
        JyrUOgAsSjFNCq2lbcuxEq5gBNg5+ZSrXlH9Bu8=
X-Google-Smtp-Source: APiQypLz8FaqWq2KOraprYF34ICk96Epr8NTd6xyOTTliXByvTRhVsnLYttoWEeIb2tqNvg6vtoysi3FjHUndN+hZtw=
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr1002541iob.10.1588210319908;
 Wed, 29 Apr 2020 18:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588092152.git.chris@chrisdown.name> <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com> <20200430011626.GA2754277@chrisdown.name>
In-Reply-To: <20200430011626.GA2754277@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Apr 2020 09:31:23 +0800
Message-ID: <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 9:16 AM Chris Down <chris@chrisdown.name> wrote:
>
> Hi Yafang,
>
> Yafang Shao writes:
> >Would you pls. add some comments above these newly added WRITE_ONCE() ?
> >E.g.
> >What does them mean to fix ?
> >Why do we must add WRITE_ONCE() and READ_ONCE here and there all over
> >the memcg protection ?
> >Otherwise, it may be harder to understand by the others.
>
> There is already discussion in the changelogs for previous store tear
> improvements. For example, b3a7822e5e75 ("mm, memcg: prevent
> mem_cgroup_protected store tearing").
>

I'm sorry that I missed the changelog in the other one.
So you'd better add these commit log or comment to this one again.

> WRITE_ONCE and READ_ONCE are standard compiler barriers, in this case, to avoid
> store tears from writes in another thread (effective protection caching is
> designed by its very nature to permit racing, but tearing is non-ideal).
>
> You can find out more about them in the "COMPILER BARRIER" section in
> Documentation/memory-barriers.txt. I'm not really seeing the value of adding an
> extra comment about this specific use of them, unless you have some more
> explicit concern.

My concern is why we add these barriers to memcg protection
specifically but don't add these barriers to the other memebers like
memcg->oom_group which has the same issue ?
What is the difference between these members and that members ?


-- 
Thanks
Yafang
