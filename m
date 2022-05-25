Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD2533CAA
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiEYMaV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiEYMaU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 08:30:20 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502556D3BE
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 05:30:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g21so8298380qtg.5
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E4cl00r8fZFLtwJTErC/nGIuII++sdl50FiWVn7DYDg=;
        b=LQ44JAnhD9qNj4RiG4BM2QieawWgPoEVj/ws0ERKGtEhPFWMXrtNEm98uQ7TUyheVo
         rk/xoF8YnmB9J1kXL50vICactGTOfnUzWkgZ5Rjf6EfYzCl2W+IYJlJp33UWMk+WGB7T
         Dcl16HXheBKsBpvtLqQ+yx8Za8a3WR6Kn3Nju7kW8r9mqfz11Aniqi/lRVfU6DRwCwgQ
         2yFPkQFNmwRVRHp7KaE3L9wsBmOW5Z2zeZWdhm6o1lQyde6g8wdx2SkgDj9sUgKdWe5A
         D/gdxNoQMWC3mFXaHsiFzQeLLgD9lgIkx1FigDCGECAU0PkhOej/l8N6FPGcdmbMDvWl
         ouVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E4cl00r8fZFLtwJTErC/nGIuII++sdl50FiWVn7DYDg=;
        b=WOaaELCtLKkbF8VXUjQIkrIEYa7AGMXpr52D7tas6EaIOha4hC0GVmqGPIyGOIBxaF
         Dttro1H2Jlu1Np67fvxddrkXtjiqzL8vG795XG0nmif2fxKTD496M1abrM5VSJifgV3M
         +nF0VpRsFjDoVy3Wde4sd3TWqQRZAEfkMEW5Zhcj/f+GS6t4nCKW/8aMrXdSLvSbMxS8
         QWzDh16DX52dJG/yjl2in8jmGXiMLohBchUuWQuhQoeTGDhIDsq9jTPyJxuV9WUUMKMO
         NLk61BkwvvlrHB02198L0CVNfOx3VFWUmBc2/zKXxkeDnDAGwZOSi3NzHgu1TC9AulIJ
         y14w==
X-Gm-Message-State: AOAM531hwBIyE3IaOeDWxb0DN3by4J88g2YnhV45cRAFc2GOtFuw9M0J
        336I0c8/GRYIhncSnlMUM/ZNwQ==
X-Google-Smtp-Source: ABdhPJyytRziWVwawprnzpoB9zMapge3xdxp4ugjwWUqfzlZvOH+tTzED4y/XZJINd6rGGx4ow4q7w==
X-Received: by 2002:ac8:5e4c:0:b0:2f3:c50e:53a6 with SMTP id i12-20020ac85e4c000000b002f3c50e53a6mr24090727qtx.499.1653481817698;
        Wed, 25 May 2022 05:30:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id o16-20020ac85550000000b002fb673aa50asm330344qtr.89.2022.05.25.05.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:30:17 -0700 (PDT)
Date:   Wed, 25 May 2022 08:30:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo4hVw7B+bUlMzLX@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > The diagram below shows how to make the folio lruvec lock safe when LRU
> > > pages are reparented.
> > > 
> > > folio_lruvec_lock(folio)
> > >     retry:
> > > 	lruvec = folio_lruvec(folio);
> > > 
> > >         // The folio is reparented at this time.
> > >         spin_lock(&lruvec->lru_lock);
> > > 
> > >         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> > >             // Acquired the wrong lruvec lock and need to retry.
> > >             // Because this folio is on the parent memcg lruvec list.
> > >             goto retry;
> > > 
> > >         // If we reach here, it means that folio_memcg(folio) is stable.
> > > 
> > > memcg_reparent_objcgs(memcg)
> > >     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> > >     spin_lock(&lruvec->lru_lock);
> > >     spin_lock(&lruvec_parent->lru_lock);
> > > 
> > >     // Move all the pages from the lruvec list to the parent lruvec list.
> > > 
> > >     spin_unlock(&lruvec_parent->lru_lock);
> > >     spin_unlock(&lruvec->lru_lock);
> > > 
> > > After we acquire the lruvec lock, we need to check whether the folio is
> > > reparented. If so, we need to reacquire the new lruvec lock. On the
> > > routine of the LRU pages reparenting, we will also acquire the lruvec
> > > lock (will be implemented in the later patch). So folio_memcg() cannot
> > > be changed when we hold the lruvec lock.
> > > 
> > > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > > remove it.
> > > 
> > > This is a preparation for reparenting the LRU pages.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > 
> > This looks good to me. Just one question:
> > 
> > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > >   */
> > >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> > >  {
> > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > +	struct lruvec *lruvec;
> > >  
> > > +	rcu_read_lock();
> > > +retry:
> > > +	lruvec = folio_lruvec(folio);
> > >  	spin_lock(&lruvec->lru_lock);
> > > -	lruvec_memcg_debug(lruvec, folio);
> > > +
> > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > +		spin_unlock(&lruvec->lru_lock);
> > > +		goto retry;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > +	 * as RCU read-side critical sections.
> > > +	 */
> > > +	rcu_read_unlock();
> > 
> > The code looks right to me, but I don't understand the comment: why do
> > we care that the rcu read-side continues? With the lru_lock held,
> > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> >
> 
> Right. We could hold rcu read lock until end of reparting.  So you mean
> we do rcu_read_unlock in folio_lruvec_lock()?

The comment seems to suggest that disabling preemption is what keeps
the lruvec alive. But it's the lru_lock that keeps it alive. The
cgroup destruction path tries to take the lru_lock long before it even
gets to synchronize_rcu(). Once you hold the lru_lock, having an
implied read-side critical section as well doesn't seem to matter.

Should the comment be deleted?
