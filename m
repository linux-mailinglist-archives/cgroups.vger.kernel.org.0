Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35B533D2B
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiEYNEO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 09:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbiEYNEM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 09:04:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374712E9D5
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 06:04:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f4so3559577pgf.4
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwBT4g14vYXymE6X+0Ue3RPk57uheIJlCkFHpAJ6pRk=;
        b=ZidvWTWQLhs+qxK+czFWiUM2yn05AKjy33y9lcAXvSJqpWLzIj1uMe9jxplyskdO3I
         5QRSBT/MJanWvJ7tylrvEqtFCJYb9VZsMpscxiot4GDbirdqvsmm2ArflQ894D2CjJqf
         XdATAsTOsEMMmq06GT0jDJ1C9MYCztghh/capKTccvYcJcoHtRhy4UmdTl7GUsblwRYm
         NnCEUyS+8i6ozvjD380Wke39KNyXUs14HB2/iXbngP6IcEo6QaGpB33D2GcsVIXgx6wl
         dlhevHqjO8CcPqo6R+KwbdSG79xYWpXYADNv35I0JXli2cHDSH0yMDPEHc8ikpGfoXX2
         fyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwBT4g14vYXymE6X+0Ue3RPk57uheIJlCkFHpAJ6pRk=;
        b=1KuRuz1f/AF+SdpNKxgnXPDVlFf8/rMCPRCGdL71yMF81dGcvwGQfXwZIN27NLz1ze
         DMOiGSwTroy/93Ka3KOT24GE0RXL2sKFwax6S5yFgH8uJh6wxWYtBSBhESkCZiiBlSiL
         dqtUb5J0fehwZIOL7mk19PfM/x7s6wdF4koqRTGQRsLNON9FtYodfht6W18t/WxQGBEL
         wBjzI8FmlJrsSJq1uGS6CpwiqEavDwnKL76oosYH9eetNUXKoxzU8qKEjaxpVdE16wX0
         9wBPghATdFRe1hHPlkigd/JWzE/5n2/BqQGv6tYBkmeu2L6/N7Pm2qZFTuTDucStequ6
         WuKA==
X-Gm-Message-State: AOAM533vx7AE0MyLCq+Ls4o2NuVlno96AwIKyLn1t4Jm6XDMBxubK4H0
        klVQAgQgmg1dMuM3VcWmbPTIKg==
X-Google-Smtp-Source: ABdhPJzu+LJHnKWEci/nJS1Zg1m/v+3VYPOAVa9mbI0JAMOz8ytYQrHbvgWB29jNwjd9XxfBX9RhmQ==
X-Received: by 2002:a05:6a00:1411:b0:4fd:e594:fac0 with SMTP id l17-20020a056a00141100b004fde594fac0mr33594230pfu.79.1653483850683;
        Wed, 25 May 2022 06:04:10 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id w198-20020a6282cf000000b005184c9c46dbsm11338684pfd.81.2022.05.25.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:04:10 -0700 (PDT)
Date:   Wed, 25 May 2022 21:03:59 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4hVw7B+bUlMzLX@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
> On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> > On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > > The diagram below shows how to make the folio lruvec lock safe when LRU
> > > > pages are reparented.
> > > > 
> > > > folio_lruvec_lock(folio)
> > > >     retry:
> > > > 	lruvec = folio_lruvec(folio);
> > > > 
> > > >         // The folio is reparented at this time.
> > > >         spin_lock(&lruvec->lru_lock);
> > > > 
> > > >         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> > > >             // Acquired the wrong lruvec lock and need to retry.
> > > >             // Because this folio is on the parent memcg lruvec list.
> > > >             goto retry;
> > > > 
> > > >         // If we reach here, it means that folio_memcg(folio) is stable.
> > > > 
> > > > memcg_reparent_objcgs(memcg)
> > > >     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> > > >     spin_lock(&lruvec->lru_lock);
> > > >     spin_lock(&lruvec_parent->lru_lock);
> > > > 
> > > >     // Move all the pages from the lruvec list to the parent lruvec list.
> > > > 
> > > >     spin_unlock(&lruvec_parent->lru_lock);
> > > >     spin_unlock(&lruvec->lru_lock);
> > > > 
> > > > After we acquire the lruvec lock, we need to check whether the folio is
> > > > reparented. If so, we need to reacquire the new lruvec lock. On the
> > > > routine of the LRU pages reparenting, we will also acquire the lruvec
> > > > lock (will be implemented in the later patch). So folio_memcg() cannot
> > > > be changed when we hold the lruvec lock.
> > > > 
> > > > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > > > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > > > remove it.
> > > > 
> > > > This is a preparation for reparenting the LRU pages.
> > > > 
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > This looks good to me. Just one question:
> > > 
> > > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > >   */
> > > >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> > > >  {
> > > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > > +	struct lruvec *lruvec;
> > > >  
> > > > +	rcu_read_lock();
> > > > +retry:
> > > > +	lruvec = folio_lruvec(folio);
> > > >  	spin_lock(&lruvec->lru_lock);
> > > > -	lruvec_memcg_debug(lruvec, folio);
> > > > +
> > > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > > +		spin_unlock(&lruvec->lru_lock);
> > > > +		goto retry;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > > +	 * as RCU read-side critical sections.
> > > > +	 */
> > > > +	rcu_read_unlock();
> > > 
> > > The code looks right to me, but I don't understand the comment: why do
> > > we care that the rcu read-side continues? With the lru_lock held,
> > > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> > >
> > 
> > Right. We could hold rcu read lock until end of reparting.  So you mean
> > we do rcu_read_unlock in folio_lruvec_lock()?
> 
> The comment seems to suggest that disabling preemption is what keeps
> the lruvec alive. But it's the lru_lock that keeps it alive. The
> cgroup destruction path tries to take the lru_lock long before it even
> gets to synchronize_rcu(). Once you hold the lru_lock, having an
> implied read-side critical section as well doesn't seem to matter.
>

Well, I thought that spinlocks have implicit read-side critical sections
because it disables preemption (I learned from the comments above
synchronize_rcu() that says interrupts, preemption, or softirqs have been
disabled also serve as RCU read-side critical sections).  So I have a
question: is it still true in a PREEMPT_RT kernel (I am not familiar with
this)?

> Should the comment be deleted?
>

I think we could remove the comments. If the above question is false, seems
like we should continue holding rcu read lock.

Thanks.
