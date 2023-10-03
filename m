Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADD7B712B
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbjJCSjf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbjJCSje (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 14:39:34 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF815CE
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 11:39:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b0c9fb673so7192676d6.1
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696358370; x=1696963170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctR4Qss20hNlLcuTpt2GjwPGaaqxpILrMeXzriM3900=;
        b=Ri6Xwu9cUGzINSt9kMvZ0b8bNlHK697lgtf39cX6ppPfzbnJHS+6WxXWjWkLhbKV/G
         O+nmwi/8TXfJLs2nlJfH9jCXU8unG7J0tIgKLSwnQrtIa0eRvC90F12x86h8pkHOTrsB
         syXSgHSOYHz9zpqgsTF9uEjiQUaD3H09E6wBR0HONfUZ57LshzzHrJnIxjXMbsgtHW8n
         tpJTpU/Ba22IB7sW+TqDPZB1CaRs3Z/m+rq9bhfB8d1FJtnsfvTVMIIb/Zzopmnmr3GW
         Bb1Pzz0eDQFvqDXnIOVZiENaoTPPDM5AYsh8cbc5ZlMHtMzS9lxlEzGqDnyN2kkBpplo
         48+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358370; x=1696963170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctR4Qss20hNlLcuTpt2GjwPGaaqxpILrMeXzriM3900=;
        b=dgOJDcrCBglkdQQpb/oU5owK6j3DROigEtQ0gw6fNo5h5pOwc9xQj1K0uYeDMmU9Ag
         4uDVx4IBwlqeqkj5taFHbMI9cFhfuCSVjlkdWeVHi+gZCI/BJzwMvbVGX3eWQhlmG0+H
         iIeLLt0+wak+x0zKbScd+CAaW84jyR1zLqkd0DZTn/6KRVtp3bvFATmkIKKQolvE8wti
         aVHZUCPJQTcd1P+nr7MjLGE7MF2mUEaujT9ESudchl38rTGiWpM9+S0cg+p6FXpN+qkb
         IkyQGighlgXTsRWPjmbWIKgsO8F3WfpLL7uCBIu+mBMlApbEQhq84cEz0Vh7qrMDDqQM
         jTZw==
X-Gm-Message-State: AOJu0YwQqLYDTmS+Ne6OkVIeZvIinDvBDOArmCSNtntiEqEtpdG1jA8h
        VmFuOb5jMoGnQJnNSO3bHySCTA==
X-Google-Smtp-Source: AGHT+IFJsgnCuHI5XnWSVYHlvhhimI0gL5pQbE6bdVmrvG4Sb4ugSd4dt+Kkwo8wesQqBgOoiOPooA==
X-Received: by 2002:a0c:c407:0:b0:658:243e:3084 with SMTP id r7-20020a0cc407000000b00658243e3084mr163657qvi.55.1696358369899;
        Tue, 03 Oct 2023 11:39:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id c19-20020a0ce153000000b0065b17ec4b49sm691220qvl.46.2023.10.03.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:39:29 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:39:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231003183928.GC20979@cmpxchg.org>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
 <20231003171329.GB314430@monkey>
 <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 03, 2023 at 11:01:24AM -0700, Nhat Pham wrote:
> On Tue, Oct 3, 2023 at 10:13 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 10/02/23 17:18, Nhat Pham wrote:
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index de220e3ff8be..74472e911b0a 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
> > >                                    pages_per_huge_page(h), folio);
> > >       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> > >                                         pages_per_huge_page(h), folio);
> > > +     mem_cgroup_uncharge(folio);
> > >       if (restore_reserve)
> > >               h->resv_huge_pages++;
> > >
> > > @@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > >       struct hugepage_subpool *spool = subpool_vma(vma);
> > >       struct hstate *h = hstate_vma(vma);
> > >       struct folio *folio;
> > > -     long map_chg, map_commit;
> > > +     long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
> > >       long gbl_chg;
> > > -     int ret, idx;
> > > +     int memcg_charge_ret, ret, idx;
> > >       struct hugetlb_cgroup *h_cg = NULL;
> > > +     struct mem_cgroup *memcg;
> > >       bool deferred_reserve;
> > > +     gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> > > +
> > > +     memcg = get_mem_cgroup_from_current();
> > > +     memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
> > > +     if (memcg_charge_ret == -ENOMEM) {
> > > +             mem_cgroup_put(memcg);
> > > +             return ERR_PTR(-ENOMEM);
> > > +     }
> > >
> > >       idx = hstate_index(h);
> > >       /*
> > > @@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > >        * code of zero indicates a reservation exists (no change).
> > >        */
> > >       map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
> > > -     if (map_chg < 0)
> > > +     if (map_chg < 0) {
> > > +             if (!memcg_charge_ret)
> > > +                     mem_cgroup_cancel_charge(memcg, nr_pages);
> > > +             mem_cgroup_put(memcg);
> > >               return ERR_PTR(-ENOMEM);
> > > +     }
> > >
> > >       /*
> > >        * Processes that did not create the mapping will have no
> > > @@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > >        */
> > >       if (map_chg || avoid_reserve) {
> > >               gbl_chg = hugepage_subpool_get_pages(spool, 1);
> > > -             if (gbl_chg < 0) {
> > > -                     vma_end_reservation(h, vma, addr);
> > > -                     return ERR_PTR(-ENOSPC);
> > > -             }
> > > +             if (gbl_chg < 0)
> > > +                     goto out_end_reservation;
> > >
> > >               /*
> > >                * Even though there was no reservation in the region/reserve
> > > @@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > >                       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> > >                                       pages_per_huge_page(h), folio);
> > >       }
> > > +
> > > +     if (!memcg_charge_ret)
> > > +             mem_cgroup_commit_charge(folio, memcg);
> > > +     mem_cgroup_put(memcg);
> > > +
> > >       return folio;
> > >
> > >  out_uncharge_cgroup:
> > > @@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > >  out_subpool_put:
> > >       if (map_chg || avoid_reserve)
> > >               hugepage_subpool_put_pages(spool, 1);
> > > +out_end_reservation:
> > >       vma_end_reservation(h, vma, addr);
> > > +     if (!memcg_charge_ret)
> > > +             mem_cgroup_cancel_charge(memcg, nr_pages);
> > > +     mem_cgroup_put(memcg);
> > >       return ERR_PTR(-ENOSPC);
> > >  }
> > >
> >
> > IIUC, huge page usage is charged in alloc_hugetlb_folio and uncharged in
> > free_huge_folio.  During migration, huge pages are allocated via
> > alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there is no
> > charging for the migration target page and we uncharge the source page.
> > It looks like there will be no charge for the huge page after migration?
> >
> 
> Ah I see! This is a bit subtle indeed.
> 
> For the hugetlb controller, it looks like they update the cgroup info
> inside move_hugetlb_state(), which calls hugetlb_cgroup_migrate()
> to transfer the hugetlb cgroup info to the destination folio.
> 
> Perhaps we can do something analogous here.
> 
> > If my analysis above is correct, then we may need to be careful about
> > this accounting.  We may not want both source and target pages to be
> > charged at the same time.
> 
> We can create a variant of mem_cgroup_migrate that does not double
> charge, but instead just copy the mem_cgroup information to the new
> folio, and then clear that info from the old folio. That way the memory
> usage counters are untouched.
> 
> Somebody with more expertise on migration should fact check me
> of course :)

The only reason mem_cgroup_migrate() double charges right now is
because it's used by replace_page_cache_folio(). In that context, the
isolation of the old page isn't quite as thorough as with migration,
so it cannot transfer and uncharge directly. This goes back a long
time: 0a31bc97c80c3fa87b32c091d9a930ac19cd0c40

If you rename the current implementation to mem_cgroup_replace_page()
for that one caller, you can add a mem_cgroup_migrate() variant which
is charge neutral and clears old->memcg_data. This can be used for
regular and hugetlb page migration. Something like this (totally
untested):

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a4d3282493b6..17ec45bf3653 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7226,29 +7226,14 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Page cache replacement: new folio already charged? */
-	if (folio_memcg(new))
-		return;
-
 	memcg = folio_memcg(old);
 	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
 
-	/* Force-charge the new page. The old one will be freed soon */
-	if (!mem_cgroup_is_root(memcg)) {
-		page_counter_charge(&memcg->memory, nr_pages);
-		if (do_memsw_account())
-			page_counter_charge(&memcg->memsw, nr_pages);
-	}
-
-	css_get(&memcg->css);
+	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
-
-	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, folio_nid(new));
-	local_irq_restore(flags);
+	old->memcg_data = 0;
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);

