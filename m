Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BD322EEE
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhBWQkq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhBWQko (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 11:40:44 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17DFC061786
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 08:40:03 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q23so3864573lji.8
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+E3RqKwI3DqPgCvOyDy4gIUAe0bpQ6Te+CARgN71T3Q=;
        b=GhVta4M2dkEUmj17lyRCCl5KAtHb5qECT6ll8PfiYJYL+xyd5EIkxm+jnsnp4LgOlZ
         fo0vMcBFEttAdGXi8HlTG0RiPUE2KVzD3kQ/R0Y0t+f/2kyPTKNfUpht4YXxP3mmLuKy
         71bYLKPMzAfBzcWRj0zEPNBOUnXUVY0DyC0qH7w1QuqUW74NYEi/hGzwvMpkFbucKUz6
         /J17k3uojknHtxBXUR2HNiGXiie9Vt2mVTlXH6s/WHxnajKgtLpdaUSx0A5jgWxdCIi/
         8WP2Bjo888QxYCbTCr7wPv6aQNB+FmewUo+AzmfOZbj0S2VvnJCfSzfRJhizLlOe2u72
         0UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+E3RqKwI3DqPgCvOyDy4gIUAe0bpQ6Te+CARgN71T3Q=;
        b=l7yJ0Dd8osJUQNTIKwigsMrPTOk2SpbWgWdLXHi43ePX/S2jB7eOi09YQ6G803Te8L
         zEi0bSzjSwvMzrrCBq5jBin5Gd2WNdenl9Axmy+gJM7FJF/sqlreVkqoYMDDFT1AyeUe
         I9RQ0h+zONdiuzhmyG/RYs89D9FfAUFrZmZwTpm3iWmcD9ta/B7J3Arc9ix/Y9YB0Hjv
         lQCgK9h40wMok0Xkw0WXzZcafj3QLiN2e1sAGOAo92c/2ULrjKi943YB25KA0gFOVBZ/
         95GXBKkvS3CAzgp3jJQytvNOuGRbi9m2o3sp0AzVppcunEcJvGX4NrSTMd7WzrK5CW1D
         P6ow==
X-Gm-Message-State: AOAM532T7v53UdEhmjDMYd2nZ+A/jSFSLxBkvbrFEQ89TzqNXBbmrSBL
        tyvyIV4ljNuK8QjtDkdZRmWu//wv7tRE+NaA3OK+AP4nFQI=
X-Google-Smtp-Source: ABdhPJxDmAkEYhL3kIjIJ8vXDU1llWl2if3R+WoY60Q0/4E8qQ50rSwMtF1b6ZutD0HAV9BY/3awG/i911SNczxHoWI=
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr17985871ljm.34.1614098401989;
 Tue, 23 Feb 2021 08:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20210223055505.2594953-1-shakeelb@google.com>
In-Reply-To: <20210223055505.2594953-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Feb 2021 08:39:51 -0800
Message-ID: <CALvZod73d_ECo+OVW9NMbnCe5g2iYxL6jCQaSTktvR-=z6vdgQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: charge before adding to swapcache on swapin
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 22, 2021 at 9:55 PM Shakeel Butt <shakeelb@google.com> wrote:
[snip]
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -596,6 +596,9 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  }
>
>  int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> +int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
> +                                 gfp_t gfp, swp_entry_t entry);
> +void mem_cgroup_finish_swapin_page(struct page *page, swp_entry_t entry);
>
>  void mem_cgroup_uncharge(struct page *page);
>  void mem_cgroup_uncharge_list(struct list_head *page_list);
> @@ -1141,6 +1144,17 @@ static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
>         return 0;
>  }
>
> +static inline int mem_cgroup_charge_swapin_page(struct page *page,
> +                       struct mm_struct *mm, gfp_t gfp, swp_entry_t entry);

I didn't build-test the !CONFIG_MEMCG config and missed this
semicolon. Andrew, let me know if you want me to send a new version.

> +{
> +       return 0;
> +}
> +
