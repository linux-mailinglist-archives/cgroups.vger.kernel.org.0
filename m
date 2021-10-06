Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2D423773
	for <lists+cgroups@lfdr.de>; Wed,  6 Oct 2021 07:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJFFWv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Oct 2021 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFWu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Oct 2021 01:22:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651AC061749
        for <cgroups@vger.kernel.org>; Tue,  5 Oct 2021 22:20:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so5322594lfv.4
        for <cgroups@vger.kernel.org>; Tue, 05 Oct 2021 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciDVGqsYOH35J7AcMoo3IqFXoCRGKtna/4nNh2oAa8I=;
        b=PX0XPkQdsK6VcV1+qe5E+Ws3MuZHQRH5zK2EJhibfZ1p+ae4ZLUqE2uyBANAjRuZCx
         GeXpFV/AWrWBo/t32n6nw7eG4uGD/5B7/23okivlIH+KKES5dAZfgyXnQ8zz89hrnhPM
         liKp70d2Hxfq9gkAMHIEsKT5+fjZa7TZwmjSBJXjsXXQEkrxQdL0FD32ljWrdxHAMCbX
         WnJASMLr+YbRvIAuQ2AVgfQQBurUUPQzn36gJAv4Bo6RUWXkC5/e0yQ0j6zENpg0Y1xI
         6hc+6ZYVIm6sWazuZZAzbzbGlbefkJHxqehgLmcH6zD4QcLJtCvSBX/YGszd1nb/k+W0
         vdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciDVGqsYOH35J7AcMoo3IqFXoCRGKtna/4nNh2oAa8I=;
        b=4xF8bbNmYTYzfBxfzd980SFlDwCD7AASS5ULH73nkXiWYgwJKYRgNhho/P6kP6kPbJ
         3ONQUkK/K/ER/4glSm17eXJA0+Fi+I5ZktqB5UNTjJoduNJnFNptTyyOi7fdIsiXb793
         g3yehlfvyjJh0yGqfjvCLZ+nDeQOmP4WXGOMMMoAFMu29xaL/CkvYk/zJVbDYkiqgZ7G
         shp0rHb8JcMvdRIDorQWltRV/7njWEzM2tqYqJjuS4c9x92cK9EDvfIcG44y+GiKHsip
         OSj3B9JjKz1gPEaPnvjk6Q/mXBrCs/g64PYu4WwZ/epaFcFVVsZ88gdxXNg9fr0lJNm8
         pgWQ==
X-Gm-Message-State: AOAM5310+Lw4uEadzP5PN4RyCiAHueWcwhnx+gIVWBhcILZep5AVgcHd
        Ubc86IWHNq9IvMGeFhye4NeQ2fsMvO7dAK4vutD5eA==
X-Google-Smtp-Source: ABdhPJwOOgy1WotQnWFPm8n0pGDBcluDmJgc+49p7hGhcTZ2QvP2pF5lVEYlLy0mnXHpJxuod/wIwBgpVBsKuG446WM=
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr7906462lfv.8.1633497656441;
 Tue, 05 Oct 2021 22:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211005202450.11775-1-longman@redhat.com>
In-Reply-To: <20211005202450.11775-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Oct 2021 22:20:45 -0700
Message-ID: <CALvZod4Rhv8vSVRGnqHwRuuBHQ=E-YZk7JGjRWHftM4+9cSQ5A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 5, 2021 at 1:25 PM Waiman Long <longman@redhat.com> wrote:
>
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online which can happen when
> online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
> is confusing and it is more clear and straight forward to call
> memcg_offline_kmem() directly from mem_cgroup_css_free().
>
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
