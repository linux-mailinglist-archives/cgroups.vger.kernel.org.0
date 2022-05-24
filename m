Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF65331B5
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiEXTXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiEXTW7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:22:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B16AA63
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:22:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id p63so1588836qkf.0
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eBZErP5czN+01wncC3vU6ANkkXJCnBdE/nLZtn+4no4=;
        b=Ud5kMRHcsdoYSkO0HP8seo+5h8qtDRtoKNaGP9nfR8+ds9MnDJ6WSJaq2UWUXOET9K
         Jw9+WsOb+cRJuXQDbo/gnz31Cw1KnFqB2MrLxptKAlyjIzx/VnKAaOdduG0J8Zj2YSi2
         lTeihSOkv3MJjoQXRYaYHZeSI+P7ygyIcpSwgEiIkaZXpVwgexkowHJiiAed1Mi1r+U3
         esI/F7rw+Nxy0NeRFtqOkxT9Qgl9lpS3jvGj8iTUJO2HG+lTdnnUGKxDbiMovr90icXe
         kQ/se6khCaSSViH2cyEnQtPuk56rfMbiRiy6vccXBphwfOgDKMgIh62neEVNenYUBh9D
         YlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBZErP5czN+01wncC3vU6ANkkXJCnBdE/nLZtn+4no4=;
        b=ZWm+a4VJZA9KxUma1gs5q9G2AbRsfO51tLlVVWriC2QXFXvIsV9+HqBgani+M0YMWG
         j1BjfwATJAkA7SOmH1TAjN4RtkS2VL8cFBRmFrSZKoly46hwzwAGyiYorPRa7dqOp5wF
         C1jN16CKmKzQI96JmbcVKMvUKbIntVFMc/G2S+dyu5KKxavrBM71vn/a6UpYxb8pBFd1
         JG61ENryIl+6fZAH+nGBk53pAIVC13p13ZQ0/J0kIpMgUUrmKjmORhhl7bcdbUbTSF0G
         Nmbso5MZ9G4HHdY0aGjcwoFluUwuzEKlmnVamy3bQ/kbBb9xcyvZBsafNMYjdQQ6kIaK
         9BvQ==
X-Gm-Message-State: AOAM531iQnswZzBxQ0mD8a/3pVmtwqWLxLWHynPxRtwfFto8H1DHtD9c
        iD6FHtjsvbTdPcn4d+i/LBq1Ag==
X-Google-Smtp-Source: ABdhPJwwjtpDlHgQpvTIIv25MCTF+gUT3NytbYxtasTIYco4Glt2sc4uT1Wff5MRD/hs4bA0tyF+oQ==
X-Received: by 2002:a37:a6d5:0:b0:6a3:4872:32fb with SMTP id p204-20020a37a6d5000000b006a3487232fbmr15638364qke.588.1653420177122;
        Tue, 24 May 2022 12:22:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id k5-20020a37ba05000000b006a39da89f32sm40030qkf.68.2022.05.24.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:22:56 -0700 (PDT)
Date:   Tue, 24 May 2022 15:22:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 02/11] mm: memcontrol: introduce
 compact_folio_lruvec_lock_irqsave
Message-ID: <Yo0wj9OAPptmUoWM@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:42PM +0800, Muchun Song wrote:
> If we reuse the objcg APIs to charge LRU pages, the folio_memcg()
> can be changed when the LRU pages reparented. In this case, we need
> to acquire the new lruvec lock.
> 
>     lruvec = folio_lruvec(folio);
> 
>     // The page is reparented.
> 
>     compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> 
>     // Acquired the wrong lruvec lock and need to retry.
> 
> But compact_lock_irqsave() only take lruvec lock as the parameter,
> we cannot aware this change. If it can take the page as parameter
> to acquire the lruvec lock. When the page memcg is changed, we can
> use the folio_memcg() detect whether we need to reacquire the new
> lruvec lock. So compact_lock_irqsave() is not suitable for us.
> Similar to folio_lruvec_lock_irqsave(), introduce
> compact_folio_lruvec_lock_irqsave() to acquire the lruvec lock in
> the compaction routine.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This looks generally good to me.

It did raise the question how deferencing lruvec is safe before the
lock is acquired when reparenting can race. The answer is in the next
patch when you add the rcu_read_lock(). Since the patches aren't big,
it would probably be better to merge them.

> @@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
>  	return true;
>  }
>  
> +static struct lruvec *
> +compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
> +				  struct compact_control *cc)
> +{
> +	struct lruvec *lruvec;
> +
> +	lruvec = folio_lruvec(folio);
> +
> +	/* Track if the lock is contended in async mode */
> +	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
> +		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
> +			goto out;
> +
> +		cc->contended = true;
> +	}
> +
> +	spin_lock_irqsave(&lruvec->lru_lock, *flags);

Can you implement this on top of the existing one?

	lruvec = folio_lruvec(folio);
	compact_lock_irqsave(&lruvec->lru_lock, flags);
	lruvec_memcg_debug(lruvec, folio);
	return lruvec;
