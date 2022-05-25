Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85714533BDC
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiEYLi7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiEYLi5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:38:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A615A2047
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:38:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j6so18958042pfe.13
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+XvTKuREjiScrS3Wh3we/csDNgvvsNrhuVBevDa5cpg=;
        b=fVm+KR5uG2kq3XNouhS2R/L94OvDDTU5coc7ipX7iW9rngv/ZEpY3fR7NHUagopxnq
         NOwZb9CkIdXE0nJjQCctq7BtxhLQ5RH5UDgwn7ez4SWe2+R/yap0p0jr7yj17acjt5hw
         G2PZoTAJr6pA91fcCSfWMXpeVKvzq6Pj2WOXEWXqJDxveE9fTloLLW0HvKPKCRpfOOvj
         kTsCQO3/q12cvQi9bx61yDyTEow8FG97UUPM/VzTxV7mxBmQY4NlM1Qjv6zJQds3Twro
         mlhbxszL5yozEO+IH9fK94imsjOF7jy+Dv2HjJPKoYorkW96w95P6s8sUB0SsP3o98AX
         0syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XvTKuREjiScrS3Wh3we/csDNgvvsNrhuVBevDa5cpg=;
        b=ctvAbnwls7plMoT/RpxZg+BLAr/6XBYWmSJHJGLc2oiTFOn1iHgAU/ci3BtO4vsebe
         guudGuvB0BfYgYiekU2lIaAWaVmTDjPkT1UAr30PGE7GacQe6ilIsWsMtK1lwEOaLBhL
         if7tHSorwiuoEv0I0uhMAKKOEyY4Af359WYAMpxWbfDpUwteWNAJ6VSR+pNaQ+/0BYlV
         5aY71hX50J0P1riz11X+y1BRUBd5awhY/i7YEVNPE/BX8mlbEtWqmEEj+RgfZJe56Dej
         ifytbqxMp/lM5LdEjPqnVzsBj28ZYOVgkp3yiqFXLEnZpQJwwaRh6BpF6ksYXgNIBDC2
         C1ZQ==
X-Gm-Message-State: AOAM532EIYZC0y83ZT17T/MkFIWrIMOHBlwdHav3xDOw9RoWlXqOZFy0
        8w1XqsupkT1UAVZvLSuWFMifWvwB+9ZDUQ==
X-Google-Smtp-Source: ABdhPJywMg+/gvLv6CGzubqG5U05Br0QQh9ssP+pJgA5WkDyf0g/dnqlzvymmRS4/K2osf4odF5nUw==
X-Received: by 2002:a63:9142:0:b0:3fa:dc58:8726 with SMTP id l63-20020a639142000000b003fadc588726mr2648562pge.349.1653478734613;
        Wed, 25 May 2022 04:38:54 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b0050dc762814fsm11277985pfp.41.2022.05.25.04.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:38:53 -0700 (PDT)
Date:   Wed, 25 May 2022 19:38:49 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Message-ID: <Yo4VSbeNRqxzd11c@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
 <Yo00Svsy/N8cJVmf@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo00Svsy/N8cJVmf@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:38:50PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:44PM +0800, Muchun Song wrote:
> > In the later patch, we will reparent the LRU pages. The pages moved to
> > appropriate LRU list can be reparented during the process of the
> > move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> > should use the more general interface of folio_lruvec_relock_irq() to
> > acquire the correct lruvec lock.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/vmscan.c | 49 +++++++++++++++++++++++++------------------------
> >  1 file changed, 25 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1678802e03e7..761d5e0dd78d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2230,23 +2230,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
> >   * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
> >   * On return, @list is reused as a list of pages to be freed by the caller.
> >   *
> > - * Returns the number of pages moved to the given lruvec.
> > + * Returns the number of pages moved to the appropriate LRU list.
> > + *
> > + * Note: The caller must not hold any lruvec lock.
> >   */
> > -static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> > -				      struct list_head *list)
> > +static unsigned int move_pages_to_lru(struct list_head *list)
> >  {
> > -	int nr_pages, nr_moved = 0;
> > +	int nr_moved = 0;
> > +	struct lruvec *lruvec = NULL;
> >  	LIST_HEAD(pages_to_free);
> > -	struct page *page;
> >  
> >  	while (!list_empty(list)) {
> > -		page = lru_to_page(list);
> > +		int nr_pages;
> > +		struct folio *folio = lru_to_folio(list);
> > +		struct page *page = &folio->page;
> > +
> > +		lruvec = folio_lruvec_relock_irq(folio, lruvec);
> >  		VM_BUG_ON_PAGE(PageLRU(page), page);
> >  		list_del(&page->lru);
> >  		if (unlikely(!page_evictable(page))) {
> > -			spin_unlock_irq(&lruvec->lru_lock);
> > +			unlock_page_lruvec_irq(lruvec);
> 
> Better to stick with the opencoded unlock. It matches a bit better
> with the locking function, compared to locking folio and unlocking
> page...
>

Seems like we are missing folio unlock variants.
How about intriducing folio_lruvec_unlock() variants?
There are a lot of places where locking folio and
unlocking page.

Thanks.
 
> Aside from that, this looks good:
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>

Thanks.
 
