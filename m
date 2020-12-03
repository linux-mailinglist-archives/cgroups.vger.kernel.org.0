Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C892CD450
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbgLCLKV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Dec 2020 06:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbgLCLKV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Dec 2020 06:10:21 -0500
Received: from smtprelay.restena.lu (smtprelay.restena.lu [IPv6:2001:a18:1::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED159C061A4E
        for <cgroups@vger.kernel.org>; Thu,  3 Dec 2020 03:09:39 -0800 (PST)
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:10:fa75:a4ff:fe28:fe3a])
        by smtprelay.restena.lu (Postfix) with ESMTPS id EB27640D86;
        Thu,  3 Dec 2020 12:09:36 +0100 (CET)
Date:   Thu, 3 Dec 2020 12:09:36 +0100
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Regression from 5.7.17 to 5.9.9 with memory.low cgroup
 constraints
Message-ID: <20201203120936.4cadef43@hemera.lan.sysophe.eu>
In-Reply-To: <20201125182103.GA840171@carbon.dhcp.thefacebook.com>
References: <20201125123956.61d9e16a@hemera>
 <20201125182103.GA840171@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Roman,

Sorry for having taken so much time to reply, I've only had the
opportunity to deploy the patch on Tuesday morning for testing and
now two days later the trashing occurred again.

> diff --git a/mm/slab.h b/mm/slab.h
> index 6cc323f1313a..ef02b841bcd8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -290,7 +290,7 @@ static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  
>         if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
>                 obj_cgroup_put(objcg);
> -               return NULL;
> +               return (struct obj_cgroup *)-1UL;
>         }
>  
>         return objcg;
> @@ -501,9 +501,13 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>                 return NULL;
>  
>         if (memcg_kmem_enabled() &&
> -           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
> +           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT))) {
>                 *objcgp = memcg_slab_pre_alloc_hook(s, size, flags);
>  
> +               if (unlikely(*objcgp == (struct obj_cgroup *)-1UL))
> +                       return NULL;
> +       }
> +
>         return s;
>  }

Seems your proposed patch didn't really help.



Compared to initial occurrence I do now have some more details (all but
/proc/slabinfo since boot) and according to /proc/slabinfo a good deal
of reclaimable slabs seem to be dentries (and probably
xfs_inode/xfs_ifork related to them) - not sure if those are assigned
to cgroups or not-accounted and not seen as candidate for reclaim...

xfs_buf           444908 445068    448   36    4 : tunables    0    0    0 : slabdata  12363  12363      0
xfs_bui_item           0      0    232   35    2 : tunables    0    0    0 : slabdata      0      0      0
xfs_bud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
xfs_cui_item           0      0    456   35    4 : tunables    0    0    0 : slabdata      0      0      0
xfs_cud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
xfs_rui_item           0      0    712   46    8 : tunables    0    0    0 : slabdata      0      0      0
xfs_rud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
xfs_icr                0    156    208   39    2 : tunables    0    0    0 : slabdata      4      4      0
xfs_ili           1223169 1535904    224   36    2 : tunables    0    0    0 : slabdata  42664  42664      0
xfs_inode         12851565 22081140   1088   30    8 : tunables    0    0    0 : slabdata 736038 736038      0
xfs_efi_item           0    280    456   35    4 : tunables    0    0    0 : slabdata      8      8      0
xfs_efd_item           0    280    464   35    4 : tunables    0    0    0 : slabdata      8      8      0
xfs_buf_item           7    216    296   27    2 : tunables    0    0    0 : slabdata      8      8      0
xf_trans               0    224    288   28    2 : tunables    0    0    0 : slabdata      8      8      0
xfs_ifork         12834992 46309928     72   56    1 : tunables    0    0    0 : slabdata 826963 826963      0
xfs_da_state           0    224    512   32    4 : tunables    0    0    0 : slabdata      7      7      0
xfs_btree_cur          0    224    256   32    2 : tunables    0    0    0 : slabdata      7      7      0
xfs_bmap_free_item      0    230     88   46    1 : tunables    0    0    0 : slabdata      5      5      0
xfs_log_ticket         4    296    216   37    2 : tunables    0    0    0 : slabdata      8      8      0
fat_inode_cache        0      0    744   44    8 : tunables    0    0    0 : slabdata      0      0      0
fat_cache              0      0     64   64    1 : tunables    0    0    0 : slabdata      0      0      0
mnt_cache            114    180    448   36    4 : tunables    0    0    0 : slabdata      5      5      0
filp                6228  15582    384   42    4 : tunables    0    0    0 : slabdata    371    371      0
inode_cache         6669  16016    608   26    4 : tunables    0    0    0 : slabdata    616    616      0
dentry            8092159 15642504    224   36    2 : tunables    0    0    0 : slabdata 434514 434514      0



The full collected details are available at
  https://faramir-fj.hosting-restena.lu/cgmon-20201203.txt
(please take a copy as that file will not stay there forever)

A visual graph of memory evolution is available at
  https://faramir-fj.hosting-restena.lu/system-memory-20201203.png
with reboot on Tuesday morning and steady increase of slabs starting
Webnesday evening correlating with start of backup until trashing
started at about 3:30 and the large drop in memory being me doing
  echo 2 > /proc/sys/vm/drop_caches
which stopped the trashing as well.


Against what does memcg attempt reclaim when it tries to satisfy a CG's
low limit? Only against siblings or also against root or not-accounted?
How does it take into account slabs where evictable entries will cause
unevictable entries to be freed as well?

> > My setup, server has 64G of RAM:
> >   root
> >    + system        { min=0, low=128M, high=8G, max=8G }
> >      + base        { no specific constraints }
> >      + backup      { min=0, low=32M, high=2G, max=2G }
> >      + shell       { no specific constraints }
> >   + websrv         { min=0, low=4G, high=32G, max=32G }
> >   + website        { min=0, low=16G, high=40T, max=40T }
> >     + website1     { min=0, low=64M, high=2G, max=2G }
> >     + website2     { min=0, low=64M, high=2G, max=2G }
> >       ...
> >   + remote         { min=0, low=1G, high=14G, max=14G }
> >     + webuser1     { min=0, low=64M, high=2G, max=2G }
> >     + webuser2     { min=0, low=64M, high=2G, max=2G }
> >       ...

Also interesting is that backup which is forced into 2G
(system/backup CG) causes amount of slabs assigned to websrv CG to
increase until that CG has almost only slab entries assigned to it to
fill 16G, like file cache being reclaimed but not slab entries even if
there is almost no file cache left and tons of slabs.
What I'm also surprised is the so much memory remains completely unused
(instead of being used for file caches).

According to the documentation if I didn't get it wrong any limits of
child CGs (e.g. webuser1...) are applied up to what their parent's
limits allow. Thus, if looking at e.g. remote -> webuser1... even if I
have 1000 webuserN they wont "reserve" 65G for themselves via
memory.low limit when their parent sets memory.low to 1G?
Or does this depend on on CG mount options (memory_recursiveprot)?


Regards,
Bruno
