Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5B322D60
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 16:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhBWPWz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhBWPWx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 10:22:53 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9896C06174A
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:22:10 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a22so63409350ljp.10
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGL+ZEl1VxWchCvh5LCCnMOsswk/yP/QAWF1B7tp0PE=;
        b=Wy4BbxDEhgR4O7gMewi35UNKdoIq+5jPJHkEkUPI4l+zHkf/xvB3AtgtOh0iXos53O
         Zk5wGQPK48Zhpdf64dMiDAILYpmCATxqBwyi0OlNqSYSwz+hK+/9WNhp8lMNLJqBX99c
         wK4rGFVCouTcrfF/JOUpofuiPJ8fF49tqSkBBrTFMUmEw9nAgfPYyBuuln6d8YW5I8Vc
         keqpKNlB6pCw7G2BICq8n+GOkqOstBrhwKcOBIXQybErStqxgPXeiIgiNLY1VeybMdgO
         kzt0LAl78laUJAX1afg+UQPm4iS7baqN1P55qK5me5WGklMBebxv6wW+nN/50r8akgA1
         a/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGL+ZEl1VxWchCvh5LCCnMOsswk/yP/QAWF1B7tp0PE=;
        b=DrevbKHqgHfoi6JOeuHBqSsUOqBnEepQxQ6fVBJ0EoUlO1Ux00ViqV6YFAjuMSl14I
         ma2wsl0cbH3A7529EklWCTbnPefwnSfMvICTEuGu6rlhBFddu93dV7Z+slMPWtsWvOLA
         ej3LA8LrU2ZJd9gnt4Uxa8XRacI2so8s2y6aMGeUclsBBhvkqLAqBH40XS3ptiBgnvew
         AepBrGOpJf9kcjje3hsSP6nSOfeRAABZ7m+iKcOmMAN2lmecWIfELzZKbJLlkRWW4lEB
         cDMGdiK8jYmQWcccM/rUSF1vATFP/SHkxVXsgLKe2ascg8MYZrdL3zpZ3ucOqkHD6s8n
         O7SA==
X-Gm-Message-State: AOAM530yp0q4DbJGtyT67mLFjfxWkYFRp4SNDlaQSj24JRV+pMedVUu3
        6EIUJOzAdMdqg6aPB/+b5szOQy+j6hAvxDVtxRJrGQ==
X-Google-Smtp-Source: ABdhPJwIlmw07SdzqXAyuw6LI5ynN6o9c4dTEnBt/ZtckCdCovwV8lO7Org5W5KV9NSnIS4DjO6/q9OP4G3TRBtQBhw=
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr17816849ljm.34.1614093728978;
 Tue, 23 Feb 2021 07:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20210223092423.42420-1-songmuchun@bytedance.com>
In-Reply-To: <20210223092423.42420-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Feb 2021 07:21:58 -0800
Message-ID: <CALvZod4fYvxusqw=g=Sc99eiW5pd7Qu0YFh=SpUna5Ltd9Pwbg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix slub memory accounting
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 23, 2021 at 1:25 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> SLUB currently account kmalloc() and kmalloc_node() allocations larger
> than order-1 page per-node. But it forget to update the per-memcg
> vmstats. So it can lead to inaccurate statistics of "slab_unreclaimable"
> which is from memory.stat. Fix it by using mod_lruvec_page_state instead
> of mod_node_page_state.
>
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
