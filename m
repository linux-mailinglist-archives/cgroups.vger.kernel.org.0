Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E272983CA
	for <lists+cgroups@lfdr.de>; Sun, 25 Oct 2020 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419049AbgJYVve (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Oct 2020 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417552AbgJYVve (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Oct 2020 17:51:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF24C061755
        for <cgroups@vger.kernel.org>; Sun, 25 Oct 2020 14:51:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w191so8641567oif.2
        for <cgroups@vger.kernel.org>; Sun, 25 Oct 2020 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YAHu+XD7fmJhaHjVlF1xXoR57+hF9rH/Dr12jxUTtxc=;
        b=h33HuZaDLr3UXXiRxNY510M1WCgPWJB79ha/94zaQgSXK8Y35koCLjYNGdjMOF74qy
         bDqheYKZX1n6r7iTbL1OZ51tND6aSc1Y0RP9fOjkxs03MJvc6AmdZrGcOkpgvqx5dohS
         YtyL/a48CbkLdegzwI+2wTmqFhYkx22wgnYbiKzjqol2hZQcLSShNYQdGsR4oNppQDYV
         n7IkDSHUpTn246k/7CT0yTjVBGB0YYzIeP1FiIFDMn/26J0SKi65+vgt9VtvD5rYJREb
         UnYI593LF3uMe86X+m15aUUQ6UthPXNRrvIC4kzIymx+Hi6CTjTZWKvPM07l8O/jLX0f
         +eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YAHu+XD7fmJhaHjVlF1xXoR57+hF9rH/Dr12jxUTtxc=;
        b=rPRGLMJ3Q5TN6c9orpAHMBgMoIU3ErdTJWt3bmeCct/h8Q46jGfQql+chXnbf//XMb
         AVq+xJNGK2uE2ikFJGsDpZJwJsAb1pOuK3zA5MtFS5Bw+iYXb0xkmlFs0e/b2hlWai6V
         0YaECADbuSBUt6QWViC3on4IJx5RVmRQEQFbghekSgGiC8IeQBp0lxC9AoGcNkN2hm09
         Mxrfczm4L2o1iEgqOsGeh22M0IGlUM4tUPd0RBEi/VpdhyilTRj8b2DhWvlU/nv7He7Z
         KSBT1vhs3Ja/zknBXco4PU5Bqa8Lvso0s/bS5cDlHhZ79ZSnTeZ5x2rVEjIw3peWvynN
         WHlQ==
X-Gm-Message-State: AOAM530ihKTmMRwGCSUMaDKM6DmniX3Xu2hajsIhO1v6e4HUiOzgybqg
        YTciajMqGun1oXKmwCdxYSE7lA==
X-Google-Smtp-Source: ABdhPJzTgf47g6hmh5h/oJCJbp3MoiBdOTekNAh4+SSKY8AT5RWEayucEEBcGtBy/id0gRx5WkJtWw==
X-Received: by 2002:aca:c692:: with SMTP id w140mr8705827oif.94.1603662691383;
        Sun, 25 Oct 2020 14:51:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x13sm2185468otg.66.2020.10.25.14.51.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 25 Oct 2020 14:51:29 -0700 (PDT)
Date:   Sun, 25 Oct 2020 14:51:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Rong Chen <rong.a.chen@intel.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "lkp@linux.intel.com" <lkp@linux.intel.com>
Subject: Re: [PATCH v19 18/20] mm/lru: replace pgdat lru_lock with lruvec
 lock
In-Reply-To: <ef27dcbd-37fe-c16a-71ee-61709cc135f3@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2010251240030.2287@eggly.anvils>
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com> <1600918115-22007-19-git-send-email-alex.shi@linux.alibaba.com> <ef27dcbd-37fe-c16a-71ee-61709cc135f3@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-928140997-1603662689=:2287"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-928140997-1603662689=:2287
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Oct 2020, Alex Shi wrote:
> =E5=9C=A8 2020/9/24 =E4=B8=8A=E5=8D=8811:28, Alex Shi =E5=86=99=E9=81=93:
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -273,6 +273,8 @@ enum lruvec_flags {
> >  };
> > =20
> >  struct lruvec {
> > +=09/* per lruvec lru_lock for memcg */
> > +=09spinlock_t=09=09=09lru_lock;
> >  =09struct list_head=09=09lists[NR_LRU_LISTS];
> >  =09/*
> >  =09 * These track the cost of reclaiming one LRU - file or anon -
>=20
> Hi All,
>=20
> Intel Rong Chen, LKP, report a big regression on this patch, about
> 12 ~ 32% performance drop on fio.read_iops and case-lru-file-mmap-read
> case on wide Intel machine with attached kernel config.

Many thanks for the stats that followed: but though I spent many hours
poring over them, I ended up (as all too usual for me) just drowning
in the numbers, less and less able to arrive at any conclusion.

Why is 141% such a common standard deviation? I presume an artifact
of trying to estimate a stddev from only 3 runs? I wanted to ask you
to increase the runs from 3 to 12: too many of the numbers looked
unsafe to rely upon. And perhaps to increase the runtime from 200s
to 1000s, since some of the entries (invalidate_mapping_pages) look
as if they come from test preparation rather than the test itself.
But don't bother unless someone else asks: I would only drown again!

I have come to a tentative conclusion below, I don't see those stats
contradicting it, but I cannot argue how they support it either.

> Hugh Dickins pointed it's a false sharing issue on the lru_lock.

Well, I did suggest that as a possibility at first, before finding
that the slab (or slob) cache is guaranteeing cacheline alignment to
the mem_cgroup_per_node, hence to the lruvec, hence to the lru_lock.
So, I could not then see any false sharing.

> And that could be fixed by move the lru_lock out of busy lists[]
> cacheline,

No, access to those lists[] is always under that lru_lock: they
belong together, and sharing a cacheline between them is very
efficient: that is good sharing, not false sharing.

> like the following patch:

Not really.

>=20
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a75e6d0effcb..58b21bffef95 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -272,9 +272,9 @@ enum lruvec_flags {
>  };
>=20
>  struct lruvec {
> +       struct list_head                lists[NR_LRU_LISTS];
>         /* per lruvec lru_lock for memcg */
>         spinlock_t                      lru_lock;
> -       struct list_head                lists[NR_LRU_LISTS];
>         /*
>          * These track the cost of reclaiming one LRU - file or anon -
>          * over the other. As the observed cost of reclaiming one LRU

Aha, that's a different patch than you showed me before, and it's
wonderfully simple, but rather surprising.  This patch really works
to fix the reported regression?  That's great, so long as it doesn't
turn out to introduce regressions elsewhere.  If it works, it's so
simple that I strongly approve of it, even if I don't understand it.

But (I see it in the lruv20 branch of your github tree) I would much
prefer you to remove my name from the commit message: it's your patch,
all I contributed was misdirection and bafflement.

>=20
> Although the problem fixed=EF=BC=8C But I still no idea of the reasons
> and the gut problem. Any comments for this?

Right, how to explain it?

Well (and I'm assuming a 64-byte cacheline - I do hope the machines
you've been testing on really have that, rather than some greater
size that the slab allocator is unaware of), with your patch in
the first cacheline of the struct lruvec is:

inactive_anon.next inactive_anon.prev active_anon.next active_anon.prev
inactive_file.next inactive_file.prev active_file.next active_file.prev

And the interesting second cacheline of the struct lruvec is:

unevictable.next   unevictable.prev   lru_lock         anon_cost
file_cost          nonresident_age    refaults[anon]   refaults[file]

(I hope I'm not missing some debug option in your config, which would
expand lru_lock from an int plus a pad int, to something much bigger.)

Of those fields, unevictable.next unevictable.prev anon_cost and
file_cost are accessed under lru_lock, so are good to share its
cacheline.  snapshot_refaults() does not take any lock when setting
refaults[2], and they are not atomic; shrink_node() does not take
any lock when reading them.  We could quite easily change the code
to require lru_lock to access them, but it looks to me as if all
that would do is add unnecessary overhead: I could be wrong, but
they don't look worrying to me.

The worrying one is atomic_long_t nonresident_age.

And the advice we would usually give is to keep that in a separate
cacheline from lru_lock and its domain.  But what your patch does is
the opposite: it moves lru_lock into the same cacheline as its "rival";
and testing (so far) has shown that to be a good choice.

That seems audacious and surprising to me, but not impossible:
if it works, go with it.  But I wouldn't know how to write the
justification for the commit.

The image I have in my mind is: trying to get through a door in a
howling gale, while holding a bunch of cacheline kites tied together.
By forcing lru_lock and nonresident_age into the same cacheline,
you're making sure there is one less kite that can blow away in
another direction before you get through the door.

And Yu Zhao (in offline mail) has already drawn our attention to the
inefficient way move_pages_to_lru() calls workingset_age_nonresident()
repeatedly, all while holding lru_lock.  That's not much of a problem
in the base tree, but with per-memcg lru_lock, and more than one level
in the memcg hierarchy, that gets to be nasty - atomically modifying
the cacheline of a parent lruvec while holding the child's lru_lock.
I don't believe there's any deadlock in that, but I would expect
increasingly regressive performance at scale, even with your patch.

Here's a patch I was testing last night, on top of 5.9 and yours: works
for me, but my scale is too small to tell how well it will work for you.
I did consider whether we could use lru_lock on nonresident_age instead
of it being an independent atomic: in other places that looks plausible,
but adding lru_lock into __remove_mapping() feels like a very bad idea.

I'm not saying this or similar patch needs to go in right now
(and we shall certainly want Johannes's opinion before pushing it),
but I think it is going to show up as needed quite soon.

[PATCH] mm/lru: minimize workingset_age_nonresident() interference

1. move_pages_to_lru() batch workingset_age_nonresident() (from Yu Zhao)
2. workingset_age_nonresident() after unlock of lru_lock (from Yu Zhao)
3. lru_note_cost_unlock_irq() to remove an unlock+lock of lru_lock
4. lru_note_cost_unlock_irq() include updates of nonresident_age
5. workingset_refault() use that OR workingset_age_nonresident()

Of those, I expect 1 & 2 (from Yu Zhao) to be the most significant,
increasingly so with more cpus, increasingly so with more levels in
the memcg hierarchy.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---

 include/linux/swap.h |    7 +++----
 mm/swap.c            |   26 ++++++++++++++++----------
 mm/vmscan.c          |   23 +++++++++++++----------
 mm/workingset.c      |   11 +++++++----
 4 files changed, 39 insertions(+), 28 deletions(-)

--- 5.9-alex/include/linux/swap.h=092020-10-24 12:25:17.290383664 -0700
+++ 5.9-hugh/include/linux/swap.h=092020-10-24 18:31:58.396795250 -0700
@@ -332,11 +332,10 @@ extern unsigned long nr_free_buffer_page
 /* Definition of global_zone_page_state not available yet */
 #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
=20
-
 /* linux/mm/swap.c */
-extern void lru_note_cost(struct lruvec *lruvec, bool file,
-=09=09=09  unsigned int nr_pages);
-extern void lru_note_cost_page(struct page *);
+extern void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
+=09=09unsigned long nr_pages, unsigned long nr_active)
+=09=09__releases(lruvec->lru_lock);
 extern void lru_cache_add(struct page *);
 extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
--- 5.9-alex/mm/swap.c=092020-10-24 12:25:17.314383732 -0700
+++ 5.9-hugh/mm/swap.c=092020-10-24 18:31:32.524708589 -0700
@@ -259,12 +259,12 @@ void rotate_reclaimable_page(struct page
 =09}
 }
=20
-void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages=
)
+void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
+=09=09unsigned long nr_pages, unsigned long nr_active)
 {
-=09do {
+=09for (;;) {
 =09=09unsigned long lrusize;
=20
-=09=09spin_lock_irq(&lruvec->lru_lock);
 =09=09/* Record cost event */
 =09=09if (file)
 =09=09=09lruvec->file_cost +=3D nr_pages;
@@ -288,14 +288,20 @@ void lru_note_cost(struct lruvec *lruvec
 =09=09=09lruvec->file_cost /=3D 2;
 =09=09=09lruvec->anon_cost /=3D 2;
 =09=09}
-=09=09spin_unlock_irq(&lruvec->lru_lock);
-=09} while ((lruvec =3D parent_lruvec(lruvec)));
-}
=20
-void lru_note_cost_page(struct page *page)
-{
-=09lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
-=09=09      page_is_file_lru(page), thp_nr_pages(page));
+=09=09/*
+=09=09 * Update nonresident_age like workingset_age_nonresident().
+=09=09 * Better to drop lru_lock first? Or better to do that last?
+=09=09 */
+=09=09if (nr_active)
+=09=09=09atomic_long_add(nr_active, &lruvec->nonresident_age);
+
+=09=09spin_unlock_irq(&lruvec->lru_lock);
+=09=09lruvec =3D parent_lruvec(lruvec);
+=09=09if (!lruvec)
+=09=09=09break;
+=09=09spin_lock_irq(&lruvec->lru_lock);
+=09}
 }
=20
 static void __activate_page(struct page *page, struct lruvec *lruvec)
--- 5.9-alex/mm/vmscan.c=092020-10-24 12:25:17.318383744 -0700
+++ 5.9-hugh/mm/vmscan.c=092020-10-24 18:37:31.389910659 -0700
@@ -1818,10 +1818,11 @@ static int too_many_isolated(struct pgli
  * move_pages_to_lru() moves pages from private @list to appropriate LRU l=
ist.
  * On return, @list is reused as a list of pages to be freed by the caller=
=2E
  *
- * Returns the number of pages moved to the given lruvec.
+ * Returns the number of pages moved to the given lruvec,
+ * or the number of pages moved to the active lru if count_actives_only.
  */
 static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec=
,
-=09=09=09=09=09=09     struct list_head *list)
+=09=09struct list_head *list, bool count_actives_only)
 {
 =09int nr_pages, nr_moved =3D 0;
 =09LIST_HEAD(pages_to_free);
@@ -1872,9 +1873,8 @@ static unsigned noinline_for_stack move_
=20
 =09=09update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
 =09=09list_add(&page->lru, &lruvec->lists[lru]);
-=09=09nr_moved +=3D nr_pages;
-=09=09if (PageActive(page))
-=09=09=09workingset_age_nonresident(lruvec, nr_pages);
+=09=09if (!count_actives_only || PageActive(page))
+=09=09=09nr_moved +=3D nr_pages;
 =09}
=20
 =09/*
@@ -1909,6 +1909,7 @@ shrink_inactive_list(unsigned long nr_to
 =09LIST_HEAD(page_list);
 =09unsigned long nr_scanned;
 =09unsigned int nr_reclaimed =3D 0;
+=09unsigned int nr_active;
 =09unsigned long nr_taken;
 =09struct reclaim_stat stat;
 =09bool file =3D is_file_lru(lru);
@@ -1952,7 +1953,7 @@ shrink_inactive_list(unsigned long nr_to
 =09=09=09=09&stat, false);
=20
 =09spin_lock_irq(&lruvec->lru_lock);
-=09move_pages_to_lru(lruvec, &page_list);
+=09nr_active =3D move_pages_to_lru(lruvec, &page_list, true);
=20
 =09__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 =09item =3D current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
@@ -1960,9 +1961,8 @@ shrink_inactive_list(unsigned long nr_to
 =09=09__count_vm_events(item, nr_reclaimed);
 =09__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 =09__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-=09spin_unlock_irq(&lruvec->lru_lock);
=20
-=09lru_note_cost(lruvec, file, stat.nr_pageout);
+=09lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout, nr_active);
 =09mem_cgroup_uncharge_list(&page_list);
 =09free_unref_page_list(&page_list);
=20
@@ -2089,8 +2089,8 @@ static void shrink_active_list(unsigned
 =09 */
 =09spin_lock_irq(&lruvec->lru_lock);
=20
-=09nr_activate =3D move_pages_to_lru(lruvec, &l_active);
-=09nr_deactivate =3D move_pages_to_lru(lruvec, &l_inactive);
+=09nr_activate =3D move_pages_to_lru(lruvec, &l_active, false);
+=09nr_deactivate =3D move_pages_to_lru(lruvec, &l_inactive, false);
 =09/* Keep all free pages in l_active list */
 =09list_splice(&l_inactive, &l_active);
=20
@@ -2100,6 +2100,9 @@ static void shrink_active_list(unsigned
 =09__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 =09spin_unlock_irq(&lruvec->lru_lock);
=20
+=09if (nr_activate)
+=09=09workingset_age_nonresident(lruvec, nr_activate);
+
 =09mem_cgroup_uncharge_list(&l_active);
 =09free_unref_page_list(&l_active);
 =09trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate=
,
--- 5.9-alex/mm/workingset.c=092020-10-24 12:25:17.322383755 -0700
+++ 5.9-hugh/mm/workingset.c=092020-10-24 16:55:08.733369734 -0700
@@ -291,6 +291,7 @@ void workingset_refault(struct page *pag
 =09unsigned long eviction;
 =09struct lruvec *lruvec;
 =09unsigned long refault;
+=09unsigned int nr_pages;
 =09bool workingset;
 =09int memcgid;
=20
@@ -374,16 +375,18 @@ void workingset_refault(struct page *pag
 =09=09goto out;
=20
 =09SetPageActive(page);
-=09workingset_age_nonresident(lruvec, thp_nr_pages(page));
-=09inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
+=09nr_pages =3D thp_nr_pages(page);
=20
 =09/* Page was active prior to eviction */
 =09if (workingset) {
 =09=09SetPageWorkingset(page);
-=09=09/* XXX: Move to lru_cache_add() when it supports new vs putback */
-=09=09lru_note_cost_page(page);
+=09=09spin_lock_irq(&lruvec->lru_lock);
+=09=09lru_note_cost_unlock_irq(lruvec, file, nr_pages, nr_pages);
 =09=09inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
+=09} else {
+=09=09workingset_age_nonresident(lruvec, nr_pages);
 =09}
+=09inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
 out:
 =09rcu_read_unlock();
 }
--0-928140997-1603662689=:2287--
