Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537BB533A08
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiEYJis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiEYJir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 05:38:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7516567
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 02:38:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so4530829pjf.5
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sl7ih2YcYfsKEJm1KeaU131K5lwzTZba3+OLLF53Vww=;
        b=Rn2pap2S0KViSmWOIIHDkjxdgyfSovtzuKxNe2Ls2oS3VWSeEsTOBJ7CaNAkB8SxJo
         gCC717pKh8MadpjyqV8DcX8KykwT4iGOgd66to1uZTIxylcRuPrzke0u5sn2RHbXhCM0
         yy/02qaaTXJyJlqE/KyvV9jXXe7H6GdcX9qcNV9ovWcGxqfw5acK3KAh3EAPjtm9fxZv
         4WtI49bHN3Y/EV44y9ND2e4WUKF1EQxQX381CosCpZiOhaw6JWbF++Cxnv3sQRKq7Stq
         KlHpR4b8Ab1tvHM2RpmS3ctwg2v9j3oYfsnU8Bu+djUNashMDbSsk/LuKGGz7vylEvab
         LwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sl7ih2YcYfsKEJm1KeaU131K5lwzTZba3+OLLF53Vww=;
        b=bKUiuDCJ+ghevmwFawOQN+pG7cIXzESwPz2ClNYQLMv9U54vDxmOULLUO7eeYJNCyb
         PnYNr3TieQ13yBhMUG90LdQJz1p/RDS/gJmH+23vxyxjX7PFDi0UulBAqiaPDiFO5ZRF
         TaMuVAXBRG8lYkhpF5AKYbruDz8f18pWbu1mVaB2BKoOaW3KgJm+rt+ChNPsNlTclI8a
         EBWsV6Sey8389CnqgFebAaeiRB1+UzO/Ck47zrvzxSWQSOAJtZlSsmj5dtFgTxkS5+iN
         BBAAcAMr3OA2uHvwjnFE+E0bpyiA+Jx9QPcPxYp3Gfzujp6571DdZ1Gk/iLfNU95X7y7
         CTgw==
X-Gm-Message-State: AOAM531DgrNpTvYvPyQtGzRGOp+OofWjVOn9Cs7Y4fQGsMimrch7lVh1
        WAWUY8PPyNbrsJyBNc1wW7Db9Q==
X-Google-Smtp-Source: ABdhPJzs4mYbPl2+GVN3dqT2Kjrn2lZklnRuhZcuefWSSk5g14iB9r2baDj7hF1oIxX9Mj3ico58tw==
X-Received: by 2002:a17:90b:1642:b0:1e0:96b:c3f2 with SMTP id il2-20020a17090b164200b001e0096bc3f2mr9424262pjb.228.1653471526466;
        Wed, 25 May 2022 02:38:46 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b0015edb22aba1sm8984602plg.270.2022.05.25.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:38:46 -0700 (PDT)
Date:   Wed, 25 May 2022 17:38:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 02/11] mm: memcontrol: introduce
 compact_folio_lruvec_lock_irqsave
Message-ID: <Yo35ITjnDUrvLpfC@FVFYT0MHHV2J.googleapis.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-3-songmuchun@bytedance.com>
 <Yo0wj9OAPptmUoWM@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0wj9OAPptmUoWM@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:22:55PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:42PM +0800, Muchun Song wrote:
> > If we reuse the objcg APIs to charge LRU pages, the folio_memcg()
> > can be changed when the LRU pages reparented. In this case, we need
> > to acquire the new lruvec lock.
> > 
> >     lruvec = folio_lruvec(folio);
> > 
> >     // The page is reparented.
> > 
> >     compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> > 
> >     // Acquired the wrong lruvec lock and need to retry.
> > 
> > But compact_lock_irqsave() only take lruvec lock as the parameter,
> > we cannot aware this change. If it can take the page as parameter
> > to acquire the lruvec lock. When the page memcg is changed, we can
> > use the folio_memcg() detect whether we need to reacquire the new
> > lruvec lock. So compact_lock_irqsave() is not suitable for us.
> > Similar to folio_lruvec_lock_irqsave(), introduce
> > compact_folio_lruvec_lock_irqsave() to acquire the lruvec lock in
> > the compaction routine.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> This looks generally good to me.
> 
> It did raise the question how deferencing lruvec is safe before the
> lock is acquired when reparenting can race. The answer is in the next
> patch when you add the rcu_read_lock(). Since the patches aren't big,
> it would probably be better to merge them.
>

Will do in v5.
 
> > @@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> >  	return true;
> >  }
> >  
> > +static struct lruvec *
> > +compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
> > +				  struct compact_control *cc)
> > +{
> > +	struct lruvec *lruvec;
> > +
> > +	lruvec = folio_lruvec(folio);
> > +
> > +	/* Track if the lock is contended in async mode */
> > +	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
> > +		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
> > +			goto out;
> > +
> > +		cc->contended = true;
> > +	}
> > +
> > +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> 
> Can you implement this on top of the existing one?
> 
> 	lruvec = folio_lruvec(folio);
> 	compact_lock_irqsave(&lruvec->lru_lock, flags);
> 	lruvec_memcg_debug(lruvec, folio);
> 	return lruvec;
> 

I'll do a try. Thanks for your suggestions.
