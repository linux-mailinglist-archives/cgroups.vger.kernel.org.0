Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7155B134
	for <lists+cgroups@lfdr.de>; Sun, 26 Jun 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiFZKcm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFZKcm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 06:32:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BF1275F
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 03:32:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i1so4587986wrb.11
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGwBQWTfDP6NE9brdT5NpzAYQxVOdxA8Jol43hGxIq4=;
        b=F1UaSNRjTXS2/5lwFjrcRrOhaAihT2PhrHs5IN+vAP194dJCSPRi2f4Wcy4HRiDFXr
         z9RDXTNqOU8Kor9bg9JVir4Vq1k19REe1H5I9Yjy7dNSfJYwYekTzJoXw7e1AoTZp57e
         3P3jhkbyobnGxWKU+R7p5c3t7y5IIGmC+Nyc6P+5+xlPi2UXxrMKgCvMQYpWxMtSPBUP
         Te6C9AT25mJZlhbY2bK4jnMlOGbUUjrpwvIViYOVxV+DSQnWYjhxxQZ+z32yRES3lIYz
         qazhfNZa+OE63i9s+VfcF1R3VF0rS92upyMIr1LKocriqOvOnHdajyRRg6AfL3KW7frF
         8aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGwBQWTfDP6NE9brdT5NpzAYQxVOdxA8Jol43hGxIq4=;
        b=Y2vZIq1Et5uUwjw7xh6GIntjoCt7vY774PMOF5d5CdrGqSIFHcMKpb0W783/hunSpI
         0LjADx6t4OSR5SNoTjiKU1NdmxnawJtDAoQkQwlBeOYy8xX/4ZjaIE2XuU661+sxLbLI
         2DERFnyg6XlcP/S56AF1BFpiCGXrpKtUrFjNePo8aGgU5Oo2vWvNxuJZLUF1Vqlv/8Or
         FOVzZHVjIda90rqibimuqNq7oZ0y3vRJSU6/mCIaksong5sFpYtjd49K4m1QOKo836yC
         ZLD1RCt9/vUfGQD5qQla1K5czD34l6+TUxmuEU8FXGVUPPDKdvYNOVOMLnK64h++pMWj
         FuNQ==
X-Gm-Message-State: AJIora8OG+qLG/4SHe+hmw5kWpGwk054qdNPdmxj7BspKws+aWRmXBLJ
        KTL7iL/B0U3LpK+P/wNODi2xpSiP7t1Dbr323TciQg==
X-Google-Smtp-Source: AGRyM1uv2Fb0vmV5Ldn12v57Z3hlE8uuqavFy4lA6eVzUuCrmltZNqcMYzyQwipMvAc6TpEupiqQbjkXzCbC5BylU1E=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr7761939wrq.210.1656239559155; Sun, 26
 Jun 2022 03:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 26 Jun 2022 03:32:02 -0700
Message-ID: <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, longman@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, duanxiongchun@bytedance.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> This version is rebased on mm-unstable. Hopefully, Andrew can get this se=
ries
> into mm-unstable which will help to determine whether there is a problem =
or
> degradation. I am also doing some benchmark tests in parallel.
>
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
>
>         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab obje=
cts instead of pages")
>         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to char=
ge kmem pages")
>
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by th=
e
> second, third, fourth, ... instance of the same job that was restarted in=
to
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memor=
y,
> and make page reclaim very inefficient.
>
> We can convert LRU pages and most other raw memcg pins to the objcg direc=
tion
> to fix this problem, and then the LRU pages will not pin the memcgs.
>
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the numb=
er
> of the dying cgroups will not increase if we run the following test scrip=
t.

This is amazing work!

Sorry if I came late, I didn't follow the threads of previous versions
so this might be redundant, I just have a couple of questions.

a) If LRU pages keep getting parented until they reach root_mem_cgroup
(assuming they can), aren't these pages effectively unaccounted at
this point or leaked? Is there protection against this?

b) Since moving charged pages between memcgs is now becoming easier by
using the APIs of obj_cgroup, I wonder if this opens the door for
future work to transfer charges to memcgs that are actually using
reparented resources. For example, let's say cgroup A reads a few
pages into page cache, and then they are no longer used by cgroup A.
cgroup B, however, is using the same pages that are currently charged
to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
dies, and these pages are reparented to A's parent, can we possibly
mark these reparented pages (maybe in the page tables somewhere) so
that next time they get accessed we recharge them to B instead
(possibly asynchronously)?
I don't have much experience about page tables but I am pretty sure
they are loaded so maybe there is no room in PTEs for something like
this, but I have always wondered about what we can do for this case
where a cgroup is consistently using memory charged to another cgroup.
Maybe when this memory is reparented is a good point in time to decide
to recharge appropriately. It would also fix the reparenty leak to
root problem (if it even exists).

Thanks again for this work and please excuse my ignorance if any part
of what I said doesn't make sense :)

>
> ```bash
> #!/bin/bash
>
> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
> cat /proc/cgroups | grep memory
>
> for i in {0..2000}
> do
>         mkdir /sys/fs/cgroup/memory/test$i
>         echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
>         cat temp >> log
>         echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>         rmdir /sys/fs/cgroup/memory/test$i
> done
>
> cat /proc/cgroups | grep memory
>
> rm -f temp log
> ```
>
> v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@bytedan=
ce.com/
> v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedan=
ce.com/
> v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedan=
ce.com/
> v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedan=
ce.com/
> v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedan=
ce.com/
> RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@byt=
edance.com/
> RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@byt=
edance.com/
> RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@byt=
edance.com/
> RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@byt=
edance.com/
>
> v6:
>  - Collect Acked-by and Reviewed-by from Roman and Michal Koutn=C3=BD. Th=
anks.
>  - Rebase to mm-unstable.
>
> v5:
>  - Lots of improvements from Johannes, Roman and Waiman.
>  - Fix lockdep warning reported by kernel test robot.
>  - Add two new patches to do code cleanup.
>  - Collect Acked-by and Reviewed-by from Johannes and Roman.
>  - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq()=
 since
>    local_lock/unlock_irq() takes an parameter, it needs more thinking to =
transform
>    it to local_lock.  It could be an improvement in the future.
>
> v4:
>  - Resend and rebased on v5.18.
>
> v3:
>  - Removed the Acked-by tags from Roman since this version is based on
>    the folio relevant.
>
> v2:
>  - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and the
>    dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
>  - Rebase to linux 5.15-rc1.
>  - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
>
> v1:
>  - Drop RFC tag.
>  - Rebase to linux next-20210811.
>
> RFC v4:
>  - Collect Acked-by from Roman.
>  - Rebase to linux next-20210525.
>  - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
>  - Change the patch 1 title to "prepare objcg API for non-kmem usage".
>  - Convert reparent_ops_head to an array in patch 8.
>
> Thanks for Roman's review and suggestions.
>
> RFC v3:
>  - Drop the code cleanup and simplification patches. Gather those patches
>    into a separate series[1].
>  - Rework patch #1 suggested by Johannes.
>
> RFC v2:
>  - Collect Acked-by tags by Johannes. Thanks.
>  - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
>  - Fix move_pages_to_lru().
>
> Muchun Song (11):
>   mm: memcontrol: remove dead code and comments
>   mm: rename unlock_page_lruvec{_irq, _irqrestore} to
>     lruvec_unlock{_irq, _irqrestore}
>   mm: memcontrol: prepare objcg API for non-kmem usage
>   mm: memcontrol: make lruvec lock safe when LRU pages are reparented
>   mm: vmscan: rework move_pages_to_lru()
>   mm: thp: make split queue lock safe when LRU pages are reparented
>   mm: memcontrol: make all the callers of {folio,page}_memcg() safe
>   mm: memcontrol: introduce memcg_reparent_ops
>   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
>   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
>   mm: lru: use lruvec lock to serialize memcg changes
>
>  fs/buffer.c                      |   4 +-
>  fs/fs-writeback.c                |  23 +-
>  include/linux/memcontrol.h       | 218 +++++++++------
>  include/linux/mm_inline.h        |   6 +
>  include/trace/events/writeback.h |   5 +
>  mm/compaction.c                  |  39 ++-
>  mm/huge_memory.c                 | 153 ++++++++--
>  mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++------=
------
>  mm/migrate.c                     |   4 +
>  mm/mlock.c                       |   2 +-
>  mm/page_io.c                     |   5 +-
>  mm/swap.c                        |  49 ++--
>  mm/vmscan.c                      |  66 ++---
>  13 files changed, 776 insertions(+), 382 deletions(-)
>
>
> base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> --
> 2.11.0
>
>
