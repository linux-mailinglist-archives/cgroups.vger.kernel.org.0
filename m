Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD94D155E9B
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2020 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGTai (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Feb 2020 14:30:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44315 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTai (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Feb 2020 14:30:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so177002qkb.11
        for <cgroups@vger.kernel.org>; Fri, 07 Feb 2020 11:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZ0miLyLVEkfKHeEyE0u4OVk16FS3JucgNtnKmSivzw=;
        b=a2ght5jDtaODJqTahY9YF9dET2z5wQ9d8zyuDNRJFlx+w25JwWWveGiuzoOi8eX7Sq
         0u+pc0jfAQ/M4MpRfAHn2ZRyrhj4SNYZzBZ5sC33jWhlUsVjm7wjfQb3ZTKOS0gKT+Vn
         oZFYu+9ScaZvOlTkucdePP7dVqc7Ga90r647D2VD6icMNvYK8xeBqmzgEk1vKy2arM8k
         XvQFALHfxaUJLkw1T2I9ixxJDecnaWYEVuOAsRDC/AcGdcWc9Cp9YtiWJ3Pseyfj4BXw
         0uEhBbc1myFWX0E+xkHXapKLMPsHfiZvxKIjSBZYfdiYg3NEfH9fZYqFugj2eNpVCU34
         ooBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZ0miLyLVEkfKHeEyE0u4OVk16FS3JucgNtnKmSivzw=;
        b=n18wofWk809DMir7LQetOjI9wN71UC3+1TsgMFuOF8H6GpYavzW+94YRUVwuDglIAS
         WJYPtxqeVqRySxl4dWqD2Fv/sQIdCKP55LHUcyb+h+zsrzHGln+Fl25EPlaIKt3JmEqY
         1bXw8C2uZUGyATJFoa8bKUJq1HQSKPKlMYbah3gl+6SRMXNge9ls7Xcwkw5aKXThOx3w
         Kfd03fQHygZFheUKTwMOq3LcYVJjba5c2F1aMUOlqVnE8FQWeh8Q4oJmXMhTJH5IMmh1
         /jV5Yv0SeVWxymP4T94wktHyDTVBv2KFBiP8+Kufo8CiNNeHa3ASfdRL51K3TjyB5T/U
         z/TQ==
X-Gm-Message-State: APjAAAW3EvbID1XK8YbVSwGt/UGjTSxq4ngKZWamJ3qUpQ9DOuOKi9cw
        aRzeAf24CMIekQZ1cKM5tVzdTw==
X-Google-Smtp-Source: APXvYqx7Gsfkcq3qBYJBKT+EKAajHZ37ndjZ5UQYjaYzGpLbtnwyQel1LRm60MlN7RHfb+oDQNSGuw==
X-Received: by 2002:a37:4a51:: with SMTP id x78mr377646qka.445.1581103836795;
        Fri, 07 Feb 2020 11:30:36 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b144sm1776928qkg.126.2020.02.07.11.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 11:30:36 -0800 (PST)
Message-ID: <1581103834.7365.22.camel@lca.pw>
Subject: Re: [PATCH v2] mm/memcontrol: fix a data race in scan count
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Feb 2020 14:30:34 -0500
In-Reply-To: <CANpmjNMk5zw+nbLa4Ko7zUdWOY8pFR6EuQ6WbRECmX=8o8PLUw@mail.gmail.com>
References: <1581096119-13593-1-git-send-email-cai@lca.pw>
         <CANpmjNMk5zw+nbLa4Ko7zUdWOY8pFR6EuQ6WbRECmX=8o8PLUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2020-02-07 at 19:19 +0100, Marco Elver wrote:
> On Fri, 7 Feb 2020 at 18:22, Qian Cai <cai@lca.pw> wrote:
> > 
> > struct mem_cgroup_per_node mz.lru_zone_size[zone_idx][lru] could be
> > accessed concurrently as noticed by KCSAN,
> > 
> >  BUG: KCSAN: data-race in lruvec_lru_size / mem_cgroup_update_lru_size
> > 
> >  write to 0xffff9c804ca285f8 of 8 bytes by task 50951 on cpu 12:
> >   mem_cgroup_update_lru_size+0x11c/0x1d0
> >   mem_cgroup_update_lru_size at mm/memcontrol.c:1266
> >   isolate_lru_pages+0x6a9/0xf30
> >   shrink_active_list+0x123/0xcc0
> >   shrink_lruvec+0x8fd/0x1380
> >   shrink_node+0x317/0xd80
> >   do_try_to_free_pages+0x1f7/0xa10
> >   try_to_free_pages+0x26c/0x5e0
> >   __alloc_pages_slowpath+0x458/0x1290
> >   __alloc_pages_nodemask+0x3bb/0x450
> >   alloc_pages_vma+0x8a/0x2c0
> >   do_anonymous_page+0x170/0x700
> >   __handle_mm_fault+0xc9f/0xd00
> >   handle_mm_fault+0xfc/0x2f0
> >   do_page_fault+0x263/0x6f9
> >   page_fault+0x34/0x40
> > 
> >  read to 0xffff9c804ca285f8 of 8 bytes by task 50964 on cpu 95:
> >   lruvec_lru_size+0xbb/0x270
> >   mem_cgroup_get_zone_lru_size at include/linux/memcontrol.h:536
> >   (inlined by) lruvec_lru_size at mm/vmscan.c:326
> >   shrink_lruvec+0x1d0/0x1380
> >   shrink_node+0x317/0xd80
> >   do_try_to_free_pages+0x1f7/0xa10
> >   try_to_free_pages+0x26c/0x5e0
> >   __alloc_pages_slowpath+0x458/0x1290
> >   __alloc_pages_nodemask+0x3bb/0x450
> >   alloc_pages_current+0xa6/0x120
> >   alloc_slab_page+0x3b1/0x540
> >   allocate_slab+0x70/0x660
> >   new_slab+0x46/0x70
> >   ___slab_alloc+0x4ad/0x7d0
> >   __slab_alloc+0x43/0x70
> >   kmem_cache_alloc+0x2c3/0x420
> >   getname_flags+0x4c/0x230
> >   getname+0x22/0x30
> >   do_sys_openat2+0x205/0x3b0
> >   do_sys_open+0x9a/0xf0
> >   __x64_sys_openat+0x62/0x80
> >   do_syscall_64+0x91/0xb47
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 95 PID: 50964 Comm: cc1 Tainted: G        W  O L    5.5.0-next-20200204+ #6
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > The write is under lru_lock, but the read is done as lockless. The scan
> > count is used to determine how aggressively the anon and file LRU lists
> > should be scanned. Load tearing could generate an inefficient heuristic,
> > so fix it by adding READ_ONCE() for the read and WRITE_ONCE() for the
> > writes.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: also have WRITE_ONCE() in the writer which is necessary.
> 
> Again, note that KCSAN will *not* complain if you omitted the
> WRITE_ONCE and only had the READ_ONCE, as long as the write aligned
> and up to word-size. Because we still don't have a nice way to deal
> with read-modify-writes, like 'var +=', '++', I don't know if we want
> to do the WRITE_ONCE right now.
> 
> I think the kernel might need a primitive that avoids the readability
> issues of writing 'WRITE_ONCE(var, var + val)'. I don't have strong
> opinions on this, so it's up to maintainers.

Those are good points. Andrew, feel free to pick the v1 instead which seems like
a reasonable trade off.

> 
> Thanks,
> -- Marco
> 
> >  include/linux/memcontrol.h | 2 +-
> >  mm/memcontrol.c            | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a7a0a1a5c8d5..e8734dabbc61 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -533,7 +533,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
> >         struct mem_cgroup_per_node *mz;
> > 
> >         mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > -       return mz->lru_zone_size[zone_idx][lru];
> > +       return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
> >  }
> > 
> >  void mem_cgroup_handle_over_high(void);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6f6dc8712e39..daf375cc312c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1263,7 +1263,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> >         lru_size = &mz->lru_zone_size[zid][lru];
> > 
> >         if (nr_pages < 0)
> > -               *lru_size += nr_pages;
> > +               WRITE_ONCE(*lru_size, *lru_size + nr_pages);
> > 
> >         size = *lru_size;
> >         if (WARN_ONCE(size < 0,
> > @@ -1274,7 +1274,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> >         }
> > 
> >         if (nr_pages > 0)
> > -               *lru_size += nr_pages;
> > +               WRITE_ONCE(*lru_size, *lru_size + nr_pages);
> >  }
> > 
> >  /**
> > --
> > 1.8.3.1
> > 
