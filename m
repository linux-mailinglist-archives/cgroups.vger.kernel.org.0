Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF265533F8A
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiEYOtB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244917AbiEYOs6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 10:48:58 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A71AE27D
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 07:48:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 135so15049472qkm.4
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EC3qSzV90yIEpJPSb9gAka294lEXNvP+jK/k6V2VkwY=;
        b=sP6nIiJRj1gRoaVX7vHfBXwVVy5eYYU++U485svk6SpXKrAg619n1A96DqCaV5FkTy
         w5w3iKKMFkLE4auXFj/aXfZJ5LPy5up3GbiHdOpKNiIE2VFqSozTMNo8Z5JrGnlrPSxr
         FGBkY22R8Ok4K4xbXLOtAw+5WpvMIZnnDRImsKSd8fZ6krbHAwyGN5O/1zXBg7t2iiKd
         6QUp7DCaIcUgitzRn19UEloMeMIf222lzADnzLtWyvg1k1G6/IvzHz7fDWDjcRMCUJh4
         XmmmhpgKWvFtDkJT7EDuBJkZ21628wMOPAE7wtEyiNB5/GOfFuje3Xy9mAPkwzShrjmb
         xE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EC3qSzV90yIEpJPSb9gAka294lEXNvP+jK/k6V2VkwY=;
        b=OeXnHBzCR5Kpsv7JVgHRSAH6outVdglhgcxLqnHXl9Lyaj18F8pZesKzN0cvdyuvbB
         zqJikBpCge1i6zfqyAaAvEYmD6JB3zs7rGZhZS9J+915PIiE/4mYGTiBG5d5zGpmVNNb
         RpDCoWry1XRT5hEuEFG+hmjeL9hM73iS0CWsTfzyGUuj7xton3L9vzcKvSq1XumIsgN0
         xUmmOBi8fpcCFJ/zQ//fcVszvzMdf5DnT5myK0COcLKwDdc51YCB0z261XU8V5qFJmyl
         lAAgdrp2oCqutybuXlfzXuDMW0aqrN3Vi68vQhLhwHJRlk6xZ+J4f5M6f6pivyHxxnBi
         N2oA==
X-Gm-Message-State: AOAM531IZK6X0dRQeLOI2RQlFxhS0hCdRPOrRWqkIpftW327jznlnc/X
        y6oZhMPRJcSCNtTXYKJJPOVzyw==
X-Google-Smtp-Source: ABdhPJxvS5UW3uut5wpR0Ev8PQCVzxaIKMBquTJCK5MdIQkK4XdIeIg7BeodNwxRYmzmYLQIXoHEsw==
X-Received: by 2002:a05:620a:4154:b0:6a5:7577:3e1b with SMTP id k20-20020a05620a415400b006a575773e1bmr5859679qko.694.1653490135896;
        Wed, 25 May 2022 07:48:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id a3-20020ac85b83000000b002f9303ce545sm1666015qta.39.2022.05.25.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:48:55 -0700 (PDT)
Date:   Wed, 25 May 2022 10:48:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo5B1tLcYPUoaACS@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org>
 <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 09:03:59PM +0800, Muchun Song wrote:
> On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
> > On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> > > On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > > > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > > >   */
> > > > >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> > > > >  {
> > > > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > > > +	struct lruvec *lruvec;
> > > > >  
> > > > > +	rcu_read_lock();
> > > > > +retry:
> > > > > +	lruvec = folio_lruvec(folio);
> > > > >  	spin_lock(&lruvec->lru_lock);
> > > > > -	lruvec_memcg_debug(lruvec, folio);
> > > > > +
> > > > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > > > +		spin_unlock(&lruvec->lru_lock);
> > > > > +		goto retry;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > > > +	 * as RCU read-side critical sections.
> > > > > +	 */
> > > > > +	rcu_read_unlock();
> > > > 
> > > > The code looks right to me, but I don't understand the comment: why do
> > > > we care that the rcu read-side continues? With the lru_lock held,
> > > > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> > > >
> > > 
> > > Right. We could hold rcu read lock until end of reparting.  So you mean
> > > we do rcu_read_unlock in folio_lruvec_lock()?
> > 
> > The comment seems to suggest that disabling preemption is what keeps
> > the lruvec alive. But it's the lru_lock that keeps it alive. The
> > cgroup destruction path tries to take the lru_lock long before it even
> > gets to synchronize_rcu(). Once you hold the lru_lock, having an
> > implied read-side critical section as well doesn't seem to matter.
> >
> 
> Well, I thought that spinlocks have implicit read-side critical sections
> because it disables preemption (I learned from the comments above
> synchronize_rcu() that says interrupts, preemption, or softirqs have been
> disabled also serve as RCU read-side critical sections).  So I have a
> question: is it still true in a PREEMPT_RT kernel (I am not familiar with
> this)?

Yes, but you're missing my point.

> > Should the comment be deleted?
> 
> I think we could remove the comments. If the above question is false, seems
> like we should continue holding rcu read lock.

It's true.

But assume it's false for a second. Why would you need to continue
holding it? What would it protect? The lruvec would be pinned by the
spinlock even if it DIDN'T imply an RCU lock, right?

So I don't understand the point of the comment. If the implied RCU
lock is protecting something not covered by the bare spinlock itself,
it should be added to the comment. Otherwise, the comment should go.
