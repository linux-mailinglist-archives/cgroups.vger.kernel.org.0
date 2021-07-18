Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D83CC9F7
	for <lists+cgroups@lfdr.de>; Sun, 18 Jul 2021 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhGRRAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Jul 2021 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhGRRAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Jul 2021 13:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF3C061762;
        Sun, 18 Jul 2021 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ozqJ+/aQSjcd7Pmom3rhVpy9HyQmkQvEGQeoGv8EhNQ=; b=EBrcemI+F3ONTAb2qCb4CEiXIg
        OYQQFvoPudaW7rBK4ckow3sSEtO1iPo7moFRRx2My4GKi27935oIsbbE9ZXDpmXIDA4Gy2HeT8RkP
        PMo5gt0m311JLvrjuS9W8iZPz3mXKyyxf3QFAK2ltH78FIc5ELc2ENoTioPuPt1uxqCtCUGdevzks
        Bgg9PupQJhHpdlGAdDCggkjqj1HH1HsRNMzQEueEDkpp3wrW9tWOrp2JDtZPM1WpJPVjV7LFeRdOD
        E3N5TaOgKd0vAEJymLbibT2ApzY8njVJH1GWaPOdj48YuFFDrmyh1Qm72HEr/w7y/nipf4cDBgmqY
        DwE3ui3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5A59-0069Zd-JQ; Sun, 18 Jul 2021 16:56:08 +0000
Date:   Sun, 18 Jul 2021 17:55:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, songmuchun@bytedance.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, apopple@nvidia.com, minchan@kernel.org,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
Message-ID: <YPRdH56+dOFs/Ypu@casper.infradead.org>
References: <20210710003626.3549282-1-surenb@google.com>
 <20210710003626.3549282-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710003626.3549282-2-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 09, 2021 at 05:36:25PM -0700, Suren Baghdasaryan wrote:
> @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  }
>  
>  /**
> - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
>   * @page: page to charge
>   * @mm: mm context of the victim
>   * @gfp_mask: reclaim mode

This patch conflicts with the folio work, so I'm just rebasing the
folio patches on top of this, and I think this part of the patch is a
mistake.  We don't want to document the __mem_cgroup_charge() function.
That's an implementation detail.  This patch should instead have moved the
kernel-doc to memcontrol.h and continued to document mem_cgroup_charge().
