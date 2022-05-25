Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0453407A
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiEYPio (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiEYPil (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 11:38:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F411A83C
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 08:38:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j21so18987608pga.13
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XfUA65d3SdbF2oQUu55YnSpsWlaG2pXPKVSvY3AeaaY=;
        b=HdWmnFghAeH4LB9aqAeQKPfx4YaL1PQAnvmeL63qjEhQAsAKGPbUoWiw805DbWMH7w
         XoiBlH8sgL6Qd92qTjABYEtmtm8Cg+0qLN6NFvKknvRaO+mJDJqgzHyWB8HEZuWXscrH
         Xz1wzE6LmtCY4J5IB9STw0NM5YtUlc4+LnGaMH+uaVJ+9hl2W1D75vtJW+gstoCx0AkA
         d24A8qRFz6/7+LHkWFIXmI8WCtXovRtftQ/wkbSch57kOh30B0HA6YIDAZKaOqrc/HGo
         AI0GxMStontX+lP5N4q0iFkpJeCCyO1oQ5OEx/TB6KuwVerlzTV7dTM9Yp0K4fMtVoKp
         48LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XfUA65d3SdbF2oQUu55YnSpsWlaG2pXPKVSvY3AeaaY=;
        b=EQAT3W8i4+RfJHDexzAfClokb/39FxIhQvb9ycP6DmB7uk6HiAfclro5iIw14E3oqz
         ZiHOSI1090EfSF/Qr+C1GkpuK5Jr9s5dfns0X5QB5xHUsXQW+B30uJ1pe+I6OAfLGBgR
         bI0b3UlxxLiawmmC3/QhzE72u95lf+8z1ydor+kNibcKWPwIDY4iAbHFxsuSu9dNTk1w
         SFAC3P6wehgH6opaq/GilT1IP8B7NjwHdalhgHjRc4Ev9QPx0RipUQVxCt0qsZO/YhH2
         IH7+5ASKn5WSnxlQgRTKyzaX8x53pb0tP51Hpz9V+/VatK01smeoKW46ErVmlgc8vOTN
         xN6g==
X-Gm-Message-State: AOAM532kRLyqySCUVegqAIzhNzZxU1Pki2mGLDHbOyLT1egVNGiQOn7r
        TjB/eT4GiCPBqvAHGpXF4gYVfg==
X-Google-Smtp-Source: ABdhPJw8ma6FFkHhjBy1EOWCJFVdGQF0wo4kNYjbEkPmz677E+idKlyhbhGwlIzdJdTyXCoafh/Lkg==
X-Received: by 2002:a63:1a17:0:b0:3fa:e901:1c68 with SMTP id a23-20020a631a17000000b003fae9011c68mr2278636pga.243.1653493114887;
        Wed, 25 May 2022 08:38:34 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001618fee3900sm9707878plg.196.2022.05.25.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:38:34 -0700 (PDT)
Date:   Wed, 25 May 2022 23:38:30 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo5NdncOsqL0xP8Q@FVFYT0MHHV2J.googleapis.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org>
 <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
 <Yo5B1tLcYPUoaACS@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5B1tLcYPUoaACS@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 10:48:54AM -0400, Johannes Weiner wrote:
> On Wed, May 25, 2022 at 09:03:59PM +0800, Muchun Song wrote:
> > On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
> > > On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> > > > On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > > > > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > > > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > > > >   */
> > > > > >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> > > > > >  {
> > > > > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > > > > +	struct lruvec *lruvec;
> > > > > >  
> > > > > > +	rcu_read_lock();
> > > > > > +retry:
> > > > > > +	lruvec = folio_lruvec(folio);
> > > > > >  	spin_lock(&lruvec->lru_lock);
> > > > > > -	lruvec_memcg_debug(lruvec, folio);
> > > > > > +
> > > > > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > > > > +		spin_unlock(&lruvec->lru_lock);
> > > > > > +		goto retry;
> > > > > > +	}
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > > > > +	 * as RCU read-side critical sections.
> > > > > > +	 */
> > > > > > +	rcu_read_unlock();
> > > > > 
> > > > > The code looks right to me, but I don't understand the comment: why do
> > > > > we care that the rcu read-side continues? With the lru_lock held,
> > > > > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> > > > >
> > > > 
> > > > Right. We could hold rcu read lock until end of reparting.  So you mean
> > > > we do rcu_read_unlock in folio_lruvec_lock()?
> > > 
> > > The comment seems to suggest that disabling preemption is what keeps
> > > the lruvec alive. But it's the lru_lock that keeps it alive. The
> > > cgroup destruction path tries to take the lru_lock long before it even
> > > gets to synchronize_rcu(). Once you hold the lru_lock, having an
> > > implied read-side critical section as well doesn't seem to matter.
> > >
> > 
> > Well, I thought that spinlocks have implicit read-side critical sections
> > because it disables preemption (I learned from the comments above
> > synchronize_rcu() that says interrupts, preemption, or softirqs have been
> > disabled also serve as RCU read-side critical sections).  So I have a
> > question: is it still true in a PREEMPT_RT kernel (I am not familiar with
> > this)?
> 
> Yes, but you're missing my point.
> 
> > > Should the comment be deleted?
> > 
> > I think we could remove the comments. If the above question is false, seems
> > like we should continue holding rcu read lock.
> 
> It's true.
>

Thanks for your answer.

> But assume it's false for a second. Why would you need to continue
> holding it? What would it protect? The lruvec would be pinned by the
> spinlock even if it DIDN'T imply an RCU lock, right?
> 
> So I don't understand the point of the comment. If the implied RCU
> lock is protecting something not covered by the bare spinlock itself,
> it should be added to the comment. Otherwise, the comment should go.
>

Got it. Thanks for your nice explanation. I'll remove
the comment here.
