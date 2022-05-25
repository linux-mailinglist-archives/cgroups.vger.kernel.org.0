Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19085533A49
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiEYJxn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiEYJxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 05:53:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B3338B0
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 02:53:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z11so9418819pjc.3
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rlBY3PNi6qAmOpJr9mzzdY/bjGa01SJNfhk40so+9E=;
        b=wB/9UutLwYmlC+hqMcMe5v7VpbPZIPOASKIhNz9TI/rIZ1iZqhiPzsV3k6XUuyFwVl
         wW4IxGffPtaW4/prC4C2aAqCJtfPlalwcq8Wv6vEefOE0/fBUVRKpEkfooGCniuHL7Pz
         dSwf18AUMYPjciMSpPEeI6qjH0O1BNyMXPddZuPwMzFuNxhX1pEXGhJK3jLVr/FSBi9f
         BXe5+QYLLLBMeSOAY9p5fmkKulrpayS+1qpMnGy2lQUMgQMQLCzwa/34Ucu8uhyBHr6m
         92ICCkyEyw4C1v419exrTlpxo7R6iBrLAV6Jxrg9bEPC+S/khe/tSeTeAkXmrlrsIqqM
         lUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rlBY3PNi6qAmOpJr9mzzdY/bjGa01SJNfhk40so+9E=;
        b=ANpsIUhE2INX/hGG03HLXNs+ZjWPy2ec3Rj+eUSjCrIOCHl4Ot83cCElfTj4czAXME
         jG4QC5FJo+Mb3W3hziThyfmg3TOQMIRRRPJDOx6NPaS9ZTq4YzDa2hI4CcMzqqEgupqn
         WrQnvhXakORl4GIHfIIQGzpbat36wTA9xyVCI2QSY2/wUU+b4IdpLIdq8c0r4AUn6li/
         wqpSX475nvNRfdXbXJnAoEwmmwgKPuEBE+0OUATBhwMas7oCqYTPg9NJpFFZ2lX4gAgy
         4ewQcTHtulzSvBDVuljNE/e9bV67Zq6qhKqrXzeDx+pW0K97bSdGXLfk3ZrT7MQzObgl
         293w==
X-Gm-Message-State: AOAM533YV1CDNSmooF8V/J3v9LDBqOC3XQaqVZMYJ9VaVfel37WLgmGk
        BxFHF/pkUFjGQhzYZmGTxtzajg==
X-Google-Smtp-Source: ABdhPJzMyMkX24hof16RTJ9atm/eD3WpDblvZiEcBgbvezw96LMmNP9gRlSJkV4qLO1RDOIR/ebBmg==
X-Received: by 2002:a17:90b:1d10:b0:1e0:4bbb:3393 with SMTP id on16-20020a17090b1d1000b001e04bbb3393mr9406657pjb.218.1653472415573;
        Wed, 25 May 2022 02:53:35 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b005184640c939sm1474506pfn.207.2022.05.25.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:53:34 -0700 (PDT)
Date:   Wed, 25 May 2022 17:53:30 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0xmKOkBkhRy+bq@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > The diagram below shows how to make the folio lruvec lock safe when LRU
> > pages are reparented.
> > 
> > folio_lruvec_lock(folio)
> >     retry:
> > 	lruvec = folio_lruvec(folio);
> > 
> >         // The folio is reparented at this time.
> >         spin_lock(&lruvec->lru_lock);
> > 
> >         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> >             // Acquired the wrong lruvec lock and need to retry.
> >             // Because this folio is on the parent memcg lruvec list.
> >             goto retry;
> > 
> >         // If we reach here, it means that folio_memcg(folio) is stable.
> > 
> > memcg_reparent_objcgs(memcg)
> >     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >     spin_lock(&lruvec->lru_lock);
> >     spin_lock(&lruvec_parent->lru_lock);
> > 
> >     // Move all the pages from the lruvec list to the parent lruvec list.
> > 
> >     spin_unlock(&lruvec_parent->lru_lock);
> >     spin_unlock(&lruvec->lru_lock);
> > 
> > After we acquire the lruvec lock, we need to check whether the folio is
> > reparented. If so, we need to reacquire the new lruvec lock. On the
> > routine of the LRU pages reparenting, we will also acquire the lruvec
> > lock (will be implemented in the later patch). So folio_memcg() cannot
> > be changed when we hold the lruvec lock.
> > 
> > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > remove it.
> > 
> > This is a preparation for reparenting the LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> This looks good to me. Just one question:
> 
> > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> >   */
> >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> >  {
> > -	struct lruvec *lruvec = folio_lruvec(folio);
> > +	struct lruvec *lruvec;
> >  
> > +	rcu_read_lock();
> > +retry:
> > +	lruvec = folio_lruvec(folio);
> >  	spin_lock(&lruvec->lru_lock);
> > -	lruvec_memcg_debug(lruvec, folio);
> > +
> > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > +		spin_unlock(&lruvec->lru_lock);
> > +		goto retry;
> > +	}
> > +
> > +	/*
> > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > +	 * as RCU read-side critical sections.
> > +	 */
> > +	rcu_read_unlock();
> 
> The code looks right to me, but I don't understand the comment: why do
> we care that the rcu read-side continues? With the lru_lock held,
> reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
>

Right. We could hold rcu read lock until end of reparting.  So you mean
we do rcu_read_unlock in folio_lruvec_lock()?

Thanks.
