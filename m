Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5956B1DA452
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgESWPz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESWPz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 18:15:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E0C061A0F
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 15:15:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so1062958lje.9
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxz1rZqNlsCeuSR9curwxPKa4W3jWsGY4pCm9jvZnw4=;
        b=R1QBH9j9Pfl17Bi+U8Qt2VYdio0ibXZeuPzMFPRICYI09H3qud7ZA4YhliJOOAHMyI
         XnH/PDsy9mOHrzltFj/g3AaYFFgEuvacpT69/ZdVP0CmwhSkE9FOGeflb/LncvcAMaQQ
         +4lUtF5q19jT0bHX4DRT+eOQ5YTpWKhQZ8bm+b+shDMlZqKFhNTIOeEy79zvtgcc2CzO
         KfRdFtFBkugMp4EWpLIDt3RTCpPwBGqumGzd2kdRK1EPcqv2mp4hIONURpKdHrAgaL5n
         H8TnZuYXMvUbkTnG7vvm4ZHQWUxN7FYYU28AaK4RP+IGyHFAfrwQwpwbQJeWzkiP9dAa
         JN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxz1rZqNlsCeuSR9curwxPKa4W3jWsGY4pCm9jvZnw4=;
        b=nTovNTmv8SmM52uE/saO4Ty2Id53yPH+jmRe0u/cA3oOMhDGTLVJI7cL4mtI4CteuF
         tEK3a18/ci9xVMBGB/np6OhQdGv6Am7Yu63qRN1/tGiXvmPXvc73ELOFuxCO/bwMFZaf
         Z3FBQ8aT0xNDgRTOVaWHvoYol0IpkW7fs7Igt8lQERUnECPtWqV6NziwkG9dJcrwlq6p
         3ReOI0ZTsPueNserQTl1lNzYeyQvSep/bK+enoshcHcSkxQLEgfMlW4zSBWm4QpGZdvs
         0mRaA3mTPYtm56yw5VQhWG4zEyU5kW9sHh9PhZssMrxijgD2jSBA5P6mBGqKAYZj0JMz
         iJ/w==
X-Gm-Message-State: AOAM531i9BIXjtbe6aeeHl6Kpgd35emI7/4QJxyq09jASI+ZDJWZ1pG3
        TKBDDQkiaR3vmORmMFs58ZefuxfhulpL27RNXFksTg==
X-Google-Smtp-Source: ABdhPJxJ6wnamohB2dBwxbIP6tQQaQyWD038Gx0AMF71yPx9BJ3T2gX/JTmuPhp10wrySm8J0xsqo/1mcDGQS8Ujk/I=
X-Received: by 2002:a2e:3e15:: with SMTP id l21mr844680lja.250.1589926552449;
 Tue, 19 May 2020 15:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200519171938.3569605-1-kuba@kernel.org> <20200519171938.3569605-4-kuba@kernel.org>
In-Reply-To: <20200519171938.3569605-4-kuba@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 May 2020 15:15:41 -0700
Message-ID: <CALvZod4i2sBWcbKe3MHMuSMV3ywWwQx1Xr-abEqPS6n8vioC7w@mail.gmail.com>
Subject: Re: [PATCH mm v4 3/4] mm: move cgroup high memory limit setting into
 struct page_counter
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 19, 2020 at 10:19 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> High memory limit is currently recorded directly in
> struct mem_cgroup. We are about to add a high limit
> for swap, move the field to struct page_counter and
> add some helpers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
...
[snip]
...
>
> +static inline bool page_counter_is_above_high(struct page_counter *counter)
> +{
> +       return page_counter_read(counter) > READ_ONCE(counter->high);
> +}
> +
...
[snip]
...
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -198,6 +198,11 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
>         }
>  }
>
> +void page_counter_set_high(struct page_counter *counter, unsigned long nr_pages)
> +{
> +       WRITE_ONCE(counter->high, nr_pages);
> +}
> +

Any reason not to make this static inline like
page_counter_is_above_high() and in page_counter.h?
