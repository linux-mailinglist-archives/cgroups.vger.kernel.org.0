Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E851F533C1F
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiEYL62 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiEYL62 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:58:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BF65E5
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:58:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so19014235pfh.8
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83P9lIf96SgEF4FIz+2NIYTMoqq/3LIlBOcpNeCCdxU=;
        b=V9H/HXtZcLAXr098dtpBDsWTnNouWEfreWbUot8dXiLuBzVLB4mCHrI6WKX6pVyZBD
         kiNUVaM5D5ayScwD40y9Txc6lXPYaCgigth5ZN7Ae3+g2nfLeqXrNFEtKPGXdutjjO3n
         XhABixH/23MX1UYyLqe8AiN6xxOLpLYfmjfZzE4eMmEaIK+3FtTAdD/h92PM9AcDNnvv
         l3sS52cpVjTlm0KWQFUHr4gAgMldcOrjQLPJSBo5dCH5wXpwJDUCn8jjooO4sCA/4QAp
         wZktZJWFJjkaF/4ebJ6wXuCrOZYssWMh3qoqUYyRbVykBTT1PCykeNLMxk3ucGph1lD3
         Oa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83P9lIf96SgEF4FIz+2NIYTMoqq/3LIlBOcpNeCCdxU=;
        b=5CxwAey41LY7rtndAmWlLf+l+6X35GVRUuXC0IHlCtIhAFIZcPbzLYF+IktistMWSi
         kKrGdafrXpg5LB3L6k1JmNzXbwV2fROxpzkb3k8Jl6Eo/ya9H6DlYzR9Zro6nv/jUeoI
         IlampzilpIua+nx9z6F4UKLZqbRhplWbVRLJsmLiRAXuSGWBHViIcBPnJZLeloxdMVzk
         u0aFyXfJ+rQPqVZi3THZyR9JXvdgo1A/7uFEIdxinOo2fkEpSE+F1W7H51d/a2wH2qkF
         DBPv7h5V3N/sC3q4V1Z7YtS+wLzhuzrxbSIaXNueOn6Y1AMfV/cdVlSeaicjxiv7HDaS
         ekjQ==
X-Gm-Message-State: AOAM533HmTfYOAc6HJBLGKkt42eOzdQe3DiXWVkr1wynJi2Gbl7fJKfG
        JUudQ1XSz29wHwZGZydPno19ug==
X-Google-Smtp-Source: ABdhPJy6C9/wlVQXBjuDdY4kOc2ORx1gRErc2TwqWFNwz6hz8oeSgI2sbVa3QRuLVigKCeQY/mA12Q==
X-Received: by 2002:a62:14d2:0:b0:518:1576:65f2 with SMTP id 201-20020a6214d2000000b00518157665f2mr33285530pfu.24.1653479903310;
        Wed, 25 May 2022 04:58:23 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id e24-20020a637458000000b003f5e0c264bcsm8276248pgn.66.2022.05.25.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:58:22 -0700 (PDT)
Date:   Wed, 25 May 2022 19:58:16 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yo4Z2KfGxGyIlmmI@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-11-songmuchun@bytedance.com>
 <Yo2XBdLxcJ/J6KJp@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo2XBdLxcJ/J6KJp@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 07:40:05PM -0700, Roman Gushchin wrote:
> On Tue, May 24, 2022 at 02:05:50PM +0800, Muchun Song wrote:
> > We need to make sure that the page is deleted from or added to the
> > correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
> > users.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/mm_inline.h | 6 ++++++
> >  mm/vmscan.c               | 1 -
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index ac32125745ab..30d2393da613 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -97,6 +97,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
> >  {
> >  	enum lru_list lru = folio_lru_list(folio);
> >  
> > +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> > +
> >  	update_lru_size(lruvec, lru, folio_zonenum(folio),
> >  			folio_nr_pages(folio));
> >  	if (lru != LRU_UNEVICTABLE)
> > @@ -114,6 +116,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
> >  {
> >  	enum lru_list lru = folio_lru_list(folio);
> >  
> > +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> > +
> >  	update_lru_size(lruvec, lru, folio_zonenum(folio),
> >  			folio_nr_pages(folio));
> >  	/* This is not expected to be used on LRU_UNEVICTABLE */
> > @@ -131,6 +135,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
> >  {
> >  	enum lru_list lru = folio_lru_list(folio);
> >  
> > +	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
> > +
> >  	if (lru != LRU_UNEVICTABLE)
> >  		list_del(&folio->lru);
> >  	update_lru_size(lruvec, lru, folio_zonenum(folio),
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 761d5e0dd78d..6c9e2eafc8f9 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2281,7 +2281,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
> >  			continue;
> >  		}
> >  
> > -		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
> 
> The commit log describes well why we need to add new BUG_ON's. Please, add
> something on why this is removed.
>

OK. Will do in v5.

Thanks. 
