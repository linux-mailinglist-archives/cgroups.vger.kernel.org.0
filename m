Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA93589AD
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhDHQZN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhDHQZK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 12:25:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA5C061762
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 09:24:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so5049251lfa.3
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhP7GymXFSKtZlfnt0/yi6SF4MHiLfNobLLfZttkPNg=;
        b=pNP3+nw0beqqrktG7Qie1dyDV4VmIMTq0UwmxM/5Sy5GbRLRfwgh+YWj0pIv0+jMw9
         9WCqIIzsivso6CM/3M1eM/MyxDQaZtoRm3iZj8GpXZGLq6USw578MYrsIwfXNlFIulIW
         +n/4hMXYlP5tphCL1r7xo3d4yFIedzoQ0a+4oFS8tmLcnsC0sIEBa1ZY7vW5CXPGFLzJ
         XiT4U5W3LAeXk/7KXilNkSqdc/gXcnKNG6GNEyGR/lbZJB1QcGjyTjAad7FcLS7ZJMWB
         4RMNOqfrgOqnCQ/w7oNhEe3XoBeJqmHp2rYfhs3bNxY8mlIWL6O4nxCOB7PN7PhBZgbM
         XaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhP7GymXFSKtZlfnt0/yi6SF4MHiLfNobLLfZttkPNg=;
        b=j0Tlwz5OCzOS427e1viiHAXEPP1d3pxoDt1hatUy8IwpLpsu2/h+N+Ct+ncbcU7LUf
         3lJLsRT/smo7LBStSYzm5wNUrnnpva7ci66Wxr/TklADCPCHPpqKVIY21MINUYDbLtXN
         8t1AkSpiykvYTMM9ZH0aTrqQAs0LyY8+C6XAFoAUYkllL5Bb7tF+bTvNBXjLYmRyMch8
         ENm9iTz1jdDpzb5kMkNO8TYADtu+HyWruH1r9STiZS0T9Ti9BaJfPfFKy+ci9Xg+A+2R
         bo/DZdSiYopoa4cTNBZfUQt6/Cg8tW3VdzmfOjm5p4/Ot/la0qJo/S7oKxYFYxQx33Qs
         JDcQ==
X-Gm-Message-State: AOAM533Ex9z7zx4uSeozYzERChiEuy9mrVvnYtzTtDmmYNfEirU0zy6p
        fWTdfDZqf249+/SvxLoqbzN63v97q4gELPrSRUki6Q==
X-Google-Smtp-Source: ABdhPJxsgbICoUQRcb1rmHa4XodJWpA+CFTgt6poDqrvLhhm+JBXzDn91yCcJEWT8t2q20D9XXM4smuQa4urJhCK5mA=
X-Received: by 2002:a05:6512:34c7:: with SMTP id w7mr6855594lfr.83.1617899096362;
 Thu, 08 Apr 2021 09:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210408143155.2679744-1-hannes@cmpxchg.org>
In-Reply-To: <20210408143155.2679744-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 09:24:45 -0700
Message-ID: <CALvZod4W+7_EZUmUQLoz-9-C2LeMtqbdvFxK31m4qV6qHOrejQ@mail.gmail.com>
Subject: Re: [PATCH] mm: page_counter: mitigate consequences of a page_counter underflow
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 7:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When the unsigned page_counter underflows, even just by a few pages, a
> cgroup will not be able to run anything afterwards and trigger the OOM
> killer in a loop.
>
> Underflows shouldn't happen, but when they do in practice, we may just
> be off by a small amount that doesn't interfere with the normal
> operation - consequences don't need to be that dire.
>
> Reset the page_counter to 0 upon underflow. We'll issue a warning that
> the accounting will be off and then try to keep limping along.
>
> [ We used to do this with the original res_counter, where it was a
>   more straight-forward correction inside the spinlock section. I
>   didn't carry it forward into the lockless page counters for
>   simplicity, but it turns out this is quite useful in practice. ]
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
