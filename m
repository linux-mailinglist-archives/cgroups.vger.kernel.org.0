Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F65331BD
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiEXT1Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiEXT1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:27:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6DB6D18B
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:27:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id y20so14921765qvx.3
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHC/s/wKwgFf20BDbmEN0QqnLll5khAsu3zMTLCS7uM=;
        b=UOC+0QNjQ3eKtHdh787nVfBuk5iczhXDMucSuwob+bzfFcNtAZ+/MFwi7vgLF+FeJP
         11/fIC8zmH9vY/GeNbcQ712AygNw9xkKvd6SDfeEPD3F6qaP1f8fEn7ZrlDOU4WGI5Ff
         z5pdg9OTxMI4cL/Ehl8ERiSnZ/igYnqO4lPvjTIbs0efPcmei6QsIaloTvfDsyoKW6fd
         LNxBy8sftRPoA3ZDAK0onSKD2/ifzv8crV+QgtDtMb2OK3gGaWEOmwQa8F5ZbYREzYva
         japzLzS7tfBh0n+gxMVTf/NTZ6c9AVBsngN53dvoa7sL8jl3O++5lxB+FRm3VpLY+CKu
         gC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHC/s/wKwgFf20BDbmEN0QqnLll5khAsu3zMTLCS7uM=;
        b=G5V+ILa0Oyi8WqLEjR73S3fjAn67fs2EFDwFV744fCoJs8s4E0652sG9UxVLe/2+Rh
         zBKPLZ0wx3PsI2KlAYMrQy1nwOkMFcbyDwtGGSTPoHLLbi2NXmSCkWR0f9BNjEYohKnM
         WqLf4dRB+MzaD7G1EiNN5PzqLlb/x/bUEkSL4ypJXKIBihXCNcmZHlrC6tp2SS6GOvp7
         QfixYRFsWeX9bwbWzvRkbwr8I1XqtRzMooYi8FnyLdsFHhdjOUYy+noZWKHlNk5T31xu
         b9Ovn30whBH9loQd9jdST/z3jmw1dpHSKUhZz96TmoDVgz4EzeGkv7fKg/9dlYC+O5Tb
         mHUA==
X-Gm-Message-State: AOAM532GYAMmLTV3kYNUmcy3vby3/ux0E2UOfke0rj6SJW3Qioz3421g
        Gm3qzDfyQTBvWJQyexRYjbPd0g==
X-Google-Smtp-Source: ABdhPJy2OwvCOJmjjwyCa3viSDMz2mksAOJUg3A06mu8Q30SP28gw1u1rhxY3E5kqJtA2PkBP3xgQw==
X-Received: by 2002:ad4:47ca:0:b0:461:d5ac:b65b with SMTP id p10-20020ad447ca000000b00461d5acb65bmr22659303qvw.85.1653420441552;
        Tue, 24 May 2022 12:27:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id i25-20020ac860d9000000b002f39b99f66fsm140310qtm.9.2022.05.24.12.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:27:21 -0700 (PDT)
Date:   Tue, 24 May 2022 15:27:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo0xmKOkBkhRy+bq@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-4-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> The diagram below shows how to make the folio lruvec lock safe when LRU
> pages are reparented.
> 
> folio_lruvec_lock(folio)
>     retry:
> 	lruvec = folio_lruvec(folio);
> 
>         // The folio is reparented at this time.
>         spin_lock(&lruvec->lru_lock);
> 
>         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
>             // Acquired the wrong lruvec lock and need to retry.
>             // Because this folio is on the parent memcg lruvec list.
>             goto retry;
> 
>         // If we reach here, it means that folio_memcg(folio) is stable.
> 
> memcg_reparent_objcgs(memcg)
>     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>     spin_lock(&lruvec->lru_lock);
>     spin_lock(&lruvec_parent->lru_lock);
> 
>     // Move all the pages from the lruvec list to the parent lruvec list.
> 
>     spin_unlock(&lruvec_parent->lru_lock);
>     spin_unlock(&lruvec->lru_lock);
> 
> After we acquire the lruvec lock, we need to check whether the folio is
> reparented. If so, we need to reacquire the new lruvec lock. On the
> routine of the LRU pages reparenting, we will also acquire the lruvec
> lock (will be implemented in the later patch). So folio_memcg() cannot
> be changed when we hold the lruvec lock.
> 
> Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> remove it.
> 
> This is a preparation for reparenting the LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This looks good to me. Just one question:

> @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>   */
>  struct lruvec *folio_lruvec_lock(struct folio *folio)
>  {
> -	struct lruvec *lruvec = folio_lruvec(folio);
> +	struct lruvec *lruvec;
>  
> +	rcu_read_lock();
> +retry:
> +	lruvec = folio_lruvec(folio);
>  	spin_lock(&lruvec->lru_lock);
> -	lruvec_memcg_debug(lruvec, folio);
> +
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock(&lruvec->lru_lock);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * Preemption is disabled in the internal of spin_lock, which can serve
> +	 * as RCU read-side critical sections.
> +	 */
> +	rcu_read_unlock();

The code looks right to me, but I don't understand the comment: why do
we care that the rcu read-side continues? With the lru_lock held,
reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
