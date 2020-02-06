Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA18153C7C
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2020 02:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBFBQY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 20:16:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38386 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFBQY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 20:16:24 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so4435807iog.5
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2020 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chLy6GSqBy+/ujDvuDbaQr9IHlDEdCi1z2Q2e8diLQ8=;
        b=qWv+0a7lMviAtTjNnAhSW6ND/5nGN3RodZOnsMKnv4AJkUYAklJ2g2Fp/S9s2S3JAu
         blKHSdIES0qLGdq9AVfz0GTp4ieYwFM9pCQ15JXZ4/XpRO2U92IWzP7fd9vsvDuZ/g7J
         uRcWMALZxvOEjC82DQ8heQ/0A/MczdlTIBmzUhp++Rv61anYp/wCgmXimFB1PTdpW8rU
         yRhnxVoRLu0h4XKmosThqKaWJUPQN6UKmL8vzFEa3eiQYytIiyNmjiCsjiSDITJFUMJ4
         x01FFn3M6VPUGBKl5VjlLoO3RIEOQvi+5sSbnvkE9qgJhBUMNt94/DeX8XH+CxdD4idu
         ATQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chLy6GSqBy+/ujDvuDbaQr9IHlDEdCi1z2Q2e8diLQ8=;
        b=GO0N7fUUWLF90xLWtPj/O6Gjn2WI/Rz2skC7NaZd2erNXo4ImFHfy1y3F+9RxO0rcS
         wyaeb4iGEGO8oLOLKWf08VchjR9hBWChkwkecPw0i73lWs+jxlwO02Mk212KPjNHLRgs
         Bk128mLaClU8tWo8Nw8n/I2rfNCy+lHM0+t812veqd+fHz6R8Cfc92QJxplzIYXQZI01
         8Fnfynv2da6Ov3Ool4XSPiGlW8keZtg4/7K2AW24Qgm2+Xy5nhl9R50LLfIr0ShADL7d
         YOfHOhZMiO8/N+uCzNkwr6TfAJlW0ULNuPTt3cgWt7YZCEG1/VOww8nIfcD7VnwZ1yk7
         nsRg==
X-Gm-Message-State: APjAAAViJiJcUnhWLfM1GbqNRNvimc2HoT9Arxuq8G/YYVHQwxZNqZUm
        m8GqvH1eUG7tTbDlkhNePk2DSWEvq+bHpwiOObw=
X-Google-Smtp-Source: APXvYqwHAYTsP7K7B+ndhHTLjs1zcYiD+XgnPum5jlyC/WP191Q7r08iYsK7BnakPsyGQ1hVMPveJNHAqT5WyrVnzvg=
X-Received: by 2002:a02:c558:: with SMTP id g24mr31475604jaj.81.1580951783272;
 Wed, 05 Feb 2020 17:16:23 -0800 (PST)
MIME-Version: 1.0
References: <1580922215-5272-1-git-send-email-laoar.shao@gmail.com> <1ef8ee2e-0f50-fcd6-ae13-d6524fcf9764@redhat.com>
In-Reply-To: <1ef8ee2e-0f50-fcd6-ae13-d6524fcf9764@redhat.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 6 Feb 2020 09:15:47 +0800
Message-ID: <CALOAHbDaHifzkf8ZVBdNr60hkuke8aapsHwh8Fb9+BPJ5M==Uw@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: fix build error around the usage of kmem_caches
To:     David Hildenbrand <david@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 6, 2020 at 1:19 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.02.20 18:03, Yafang Shao wrote:
> > When I manually set default n to MEMCG_KMEM in init/Kconfig, bellow error
> > occurs,
> >
> > mm/slab_common.c: In function 'memcg_slab_start':
> > mm/slab_common.c:1530:30: error: 'struct mem_cgroup' has no member named
> > 'kmem_caches'
> >   return seq_list_start(&memcg->kmem_caches, *pos);
> >                               ^
> > mm/slab_common.c: In function 'memcg_slab_next':
> > mm/slab_common.c:1537:32: error: 'struct mem_cgroup' has no member named
> > 'kmem_caches'
> >   return seq_list_next(p, &memcg->kmem_caches, pos);
> >                                 ^
> > mm/slab_common.c: In function 'memcg_slab_show':
> > mm/slab_common.c:1551:16: error: 'struct mem_cgroup' has no member named
> > 'kmem_caches'
> >   if (p == memcg->kmem_caches.next)
> >                 ^
> >   CC      arch/x86/xen/smp.o
> > mm/slab_common.c: In function 'memcg_slab_start':
> > mm/slab_common.c:1531:1: warning: control reaches end of non-void function
> > [-Wreturn-type]
> >  }
> >  ^
> > mm/slab_common.c: In function 'memcg_slab_next':
> > mm/slab_common.c:1538:1: warning: control reaches end of non-void function
> > [-Wreturn-type]
> >  }
> >  ^
> >
> > That's because kmem_caches is defined only when CONFIG_MEMCG_KMEM is set,
> > while memcg_slab_start() will use it no matter CONFIG_MEMCG_KMEM is defined
> > or not.
> >
> > By the way, the reason I mannuly undefined CONFIG_MEMCG_KMEM is to verify
> > whether my some other code change is still stable when CONFIG_MEMCG_KMEM is
> > not set. Unfortunately, the existing code has been already unstable since
> > v4.11.
> >
> > Fixes: bc2791f857e1 ("slab: link memcg kmem_caches on their associated memory cgroup")
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/memcontrol.c  | 2 ++
> >  mm/slab_common.c | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6f6dc8712e39..43f0125b45bb 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4723,6 +4723,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
> >               .write = mem_cgroup_reset,
> >               .read_u64 = mem_cgroup_read_u64,
> >       },
> > +#ifdef CONFIG_MEMCG_KMEM
> >  #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
>
> Not sure if
>
> #if defined(CONFIG_MEMCG_KMEM) && \
>     (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
>
> is preffered
>

Seems better. Thanks for your suggestion.

Thanks
Yafang
