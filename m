Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED365357F0
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 04:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiE0Czk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 22:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiE0Czi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 22:55:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD51E8BB1
        for <cgroups@vger.kernel.org>; Thu, 26 May 2022 19:55:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so3026528plg.5
        for <cgroups@vger.kernel.org>; Thu, 26 May 2022 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yuwVnApgi9MDFT2rN0f5AwfAJ/OcShQIf6fyKMPeJKY=;
        b=trgl7zimFq+jjxSKGE+eRM0KjdEFcKXRfyUC1CMFQx2jc5m5ZGc1LDB9U/bGKZq+6k
         g9Zecb4Kg/Z2nt8zJW1P+UEnfAkbWhti8JLFagRac6ap3LSEUBkZOz69BnCZ/fU7s2mA
         TDhjiHtPDCE+hfSP1+jCvWCwJsRcTPKA8rxRV+uEEtpGLk13lDAWMBT/sPNNgwIwXlX0
         9BmvY/XA6zhuYfVaz47ZWsgNp/5KkEWAFKmyKHn8bP1jRpaUCm2UUoyxn2MnsKS1lOb2
         DqTu50/zB88pZq0wlhGePgVBWC9SsSWrPJis+CC/j4rWkKSSNNHmKapWDfO9kyyldvsa
         ZRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuwVnApgi9MDFT2rN0f5AwfAJ/OcShQIf6fyKMPeJKY=;
        b=qzh4Wg8PLHwZXwJagV3VoW6peRyRI7c84AXXjvWF1LbLvxbuKY+58Hr6ZeAvn/Yfed
         i45uEJms+Y7D/WqnzRfB1hc2bxX/VbZOoktdrGQFeRR1LXijMlPNmNk5dQ0LtOCkkbj3
         JbpNqMcQqrsBB9BW231tCWT0pbLjIivuLv0zBK4qyCy76BJ+RJ3mIo1LzOta3L9szmcM
         IYE7xBwxlILahHVVOE/iiN9Zjt5QIVtff+hSloyh4Q0TR4YlYK/xtxpP4rgXZsbyo6bE
         1VJ0NNNIqrnkBuaVg+AgbiDvW5EW3JDy8IGqXuqkefgiUKTfp3GMLRvLvvCDBgeO7exs
         BerA==
X-Gm-Message-State: AOAM5328gkmLoq1ZklSVUqxrhWowFyspiWLvTo+ews4OCdbsM6ntqJ/E
        Zb55aap7RXV90ss916pQ8hRQpQ==
X-Google-Smtp-Source: ABdhPJz9Z5VK0bzXKTxJhdyCoPCs/72Zg/kC66tJ8oRkdvuAUXPaG5d/MaaDccUvoakb6rCWvl3RgA==
X-Received: by 2002:a17:903:2352:b0:163:5f7d:cd0d with SMTP id c18-20020a170903235200b001635f7dcd0dmr10018344plh.35.1653620136172;
        Thu, 26 May 2022 19:55:36 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b0015e8d4eb2adsm2365787pll.247.2022.05.26.19.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:55:35 -0700 (PDT)
Date:   Fri, 27 May 2022 10:55:30 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <YpA9omBZ8O4+szbY@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org>
 <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
 <Yo5B1tLcYPUoaACS@cmpxchg.org>
 <Yo5NdncOsqL0xP8Q@FVFYT0MHHV2J.googleapis.com>
 <9fe57cf7-9d21-3f91-ef27-e046b426c219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe57cf7-9d21-3f91-ef27-e046b426c219@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 26, 2022 at 04:17:27PM -0400, Waiman Long wrote:
> On 5/25/22 11:38, Muchun Song wrote:
> > On Wed, May 25, 2022 at 10:48:54AM -0400, Johannes Weiner wrote:
> > > On Wed, May 25, 2022 at 09:03:59PM +0800, Muchun Song wrote:
> > > > On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
> > > > > On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> > > > > > On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > > > > > > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > > > > > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > > > > > >    */
> > > > > > > >   struct lruvec *folio_lruvec_lock(struct folio *folio)
> > > > > > > >   {
> > > > > > > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > > > > > > +	struct lruvec *lruvec;
> > > > > > > > +	rcu_read_lock();
> > > > > > > > +retry:
> > > > > > > > +	lruvec = folio_lruvec(folio);
> > > > > > > >   	spin_lock(&lruvec->lru_lock);
> > > > > > > > -	lruvec_memcg_debug(lruvec, folio);
> > > > > > > > +
> > > > > > > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > > > > > > +		spin_unlock(&lruvec->lru_lock);
> > > > > > > > +		goto retry;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > > > > > > +	 * as RCU read-side critical sections.
> > > > > > > > +	 */
> > > > > > > > +	rcu_read_unlock();
> > > > > > > The code looks right to me, but I don't understand the comment: why do
> > > > > > > we care that the rcu read-side continues? With the lru_lock held,
> > > > > > > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> > > > > > > 
> > > > > > Right. We could hold rcu read lock until end of reparting.  So you mean
> > > > > > we do rcu_read_unlock in folio_lruvec_lock()?
> > > > > The comment seems to suggest that disabling preemption is what keeps
> > > > > the lruvec alive. But it's the lru_lock that keeps it alive. The
> > > > > cgroup destruction path tries to take the lru_lock long before it even
> > > > > gets to synchronize_rcu(). Once you hold the lru_lock, having an
> > > > > implied read-side critical section as well doesn't seem to matter.
> > > > > 
> > > > Well, I thought that spinlocks have implicit read-side critical sections
> > > > because it disables preemption (I learned from the comments above
> > > > synchronize_rcu() that says interrupts, preemption, or softirqs have been
> > > > disabled also serve as RCU read-side critical sections).  So I have a
> > > > question: is it still true in a PREEMPT_RT kernel (I am not familiar with
> > > > this)?
> > > Yes, but you're missing my point.
> > > 
> > > > > Should the comment be deleted?
> > > > I think we could remove the comments. If the above question is false, seems
> > > > like we should continue holding rcu read lock.
> > > It's true.
> > > 
> > Thanks for your answer.
> > 
> > > But assume it's false for a second. Why would you need to continue
> > > holding it? What would it protect? The lruvec would be pinned by the
> > > spinlock even if it DIDN'T imply an RCU lock, right?
> > > 
> > > So I don't understand the point of the comment. If the implied RCU
> > > lock is protecting something not covered by the bare spinlock itself,
> > > it should be added to the comment. Otherwise, the comment should go.
> > > 
> > Got it. Thanks for your nice explanation. I'll remove
> > the comment here.
> 
> Note that there is a similar comment in patch 6 which may have to be removed
> as well.
>

I have noticed that. Thank you for remindering me as well.
 
