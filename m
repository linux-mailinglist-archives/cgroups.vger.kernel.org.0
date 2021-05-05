Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F84373F41
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhEEQKZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhEEQKY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 12:10:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D3C061574
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 09:09:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z13so3366953lft.1
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKsuEFeD+gJYSLJ7ekg4hfVqsnbJkGKmSnFbVOc/YJ0=;
        b=pGurct48b4cD8PojrnEnwDogn490UJ9vqixvhsKhgQxNctHN1tmUuM3UD9+ybdnCIY
         UxaEbOhE28qlVJbcYa48VZQspRkpa6R+BdyW29LwM/CJLY+97Y+uD6Cp5fdO4dnPj2rX
         A0mfjYE/DSuuRi1bqPpZG1hrFxCO7tuqYHZDpNQeXKfe+E+ImMxuIh9hdW3twa5HeDV6
         G2NJHXEeRLfd4fcv1JDhs3H8kWGJrtpuq9tLRg6pUf6vAquDmBcDLuBANRZ1u8FO36ON
         PDLNDLz8lbu0hary8tnz00mf3UhHAdg/2teGSWUTWOyMpHy/jr1tEsiXr/46vVNPzP75
         9Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKsuEFeD+gJYSLJ7ekg4hfVqsnbJkGKmSnFbVOc/YJ0=;
        b=R9H+zly9AeHPPHr1i8G34me0dz8W5/n+xvS+Ndek5l1hs3DKgbc3i19e87aVGcrVc0
         isxiXtFAWZH83RiJ3qGNqU2ARYmJKYVH6iX8hs0JudH93/zKaQpAnY0xxKpA8rZMpkws
         lUXhpGTnGKdU6oUge64uYRCR+cP76scnNUstnab40MUyFjGZWqp3/wXSmxrObz06cgj1
         2qa0TGKXuNAedmtCunj2hctOa8PNrg9vEhvoVz7gZglWbITC+gyzKWKuJdM7H/Tdqkue
         u68P86FDSUByqyUNJSVTnmXQRZkc7HnkSdr0cXJ0lqj6s2Pg6lRV0G+H+u05jFCIEIzg
         8KQw==
X-Gm-Message-State: AOAM530Ioawoc7SnHzl+m9Sqv+iqnKgZB7ItRyA//NH7bLmrx8EBkYPy
        zEVCKtuMgK2lihSg/UMy/sWTByVupf2eCX71m1wlzg==
X-Google-Smtp-Source: ABdhPJxwJ64DO2bcAnK++U2Uq7VZ5qveX0vCIByuvshyxCHklvLxOYW/x/1x+Z2L38EpLEypgc6eYhFyefEOpbx9m1A=
X-Received: by 2002:a05:6512:92e:: with SMTP id f14mr20767256lft.347.1620230965352;
 Wed, 05 May 2021 09:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210505154613.17214-1-longman@redhat.com> <20210505154613.17214-2-longman@redhat.com>
In-Reply-To: <20210505154613.17214-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:09:14 -0700
Message-ID: <CALvZod6AfOiKC3tmnJzgAJEUKwXwS__n8on59qbmHyHG2XAc4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 5, 2021 at 8:47 AM Waiman Long <longman@redhat.com> wrote:
>
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
>
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
>
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
