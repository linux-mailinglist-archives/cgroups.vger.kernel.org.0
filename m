Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7460853AF3E
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiFAV0h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiFAV0g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 17:26:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57882163F4D;
        Wed,  1 Jun 2022 14:26:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o17so2891419pla.6;
        Wed, 01 Jun 2022 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DeE+qfoJQxYST9JQ5L5VBWKSrvnnbYr6lQAJ2d+3gZo=;
        b=bZarlHf+0nmOJr5LAhMr+3x25ZSPmU3TgSFxbodDq9aYvF4AHoOy0lk0jPg3j85osx
         0PJOgkJ1BCkoi7zh+7YLyA5mLake7Yk4EeLweEbtOpB1OHDle2WqTLbT8/zUOD3gZeUy
         f5yt1hN5H/BiJ09myqiKjYvsl4rwoqVXERyi4txJMErXYjD2KVQFwCKgula3rU/0CE8I
         kVtUBkNARN2ag5FAM4lGtGnV3PjOZqF2Ss8FL0NZEa812VDE9YKGoJyv9d+of4InPpt8
         PRtBVqiysI+YOgr9NB2ijkZD/9WpVO0FulqYolM0DXzLUccydmTGKNfqCysBMkUMLnJF
         DTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DeE+qfoJQxYST9JQ5L5VBWKSrvnnbYr6lQAJ2d+3gZo=;
        b=gtJWlkzOU4+NmABolHBrI722uAG7brBTT2zNdvBf1OuB2qt7rKwc2lKSykZPSIS7uH
         Flk98NNIJGkk9pTQd7M2zLhLyfeGRJmRSoHjTThqfzqKzwWf9qqFz4L9IguXsTxye8nx
         q0tvNadzLrIc6mpDjg9daY4sW/tEv6TmOHT21yhR0FUHoLlI7k/fW+wx+KDqiDihIXFu
         xfOl3WQMq/d3xH61+a7OfaPuSLBG47bbNdn0WWxRUnq94DOiA8gzAJj+R92NGz9h/ZYA
         ycLzvf6BIV+UAy2IgLFe+5iGpEGWcgWEWLCmFuJF1uRc4Dd2j0Av6ZzyXpbsYJ4kzSNB
         myvw==
X-Gm-Message-State: AOAM533jPpL5mvgsCYph34D7KSI6DTR8ZjNF+DnsRWfb4HCM6184CXZ9
        W0OOHsPqH8D/go5KglmSG5k=
X-Google-Smtp-Source: ABdhPJxbJJEPOgeu3ZuVsAdO+IHTjSCpJvrll8FvdVNwxxhDB3DHdrPjv5bjQi4qlKlXaSdWHIpXcA==
X-Received: by 2002:a17:902:f70c:b0:14e:f1a4:d894 with SMTP id h12-20020a170902f70c00b0014ef1a4d894mr1389893plo.65.1654118793497;
        Wed, 01 Jun 2022 14:26:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0051b9ac243dfsm1897600pfn.119.2022.06.01.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:26:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 11:26:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpfZh6JZZMzUQIAt@slm.duckdns.org>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220601211824.89626-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601211824.89626-3-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 05:18:24PM -0400, Waiman Long wrote:
> @@ -59,6 +59,57 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
>  
>  #define BLKG_DESTROY_BATCH_SIZE  64
>  
> +/*
> + * lnode.next of the last entry in a lockless list is NULL. To make it
> + * always non-NULL for lnode's, a sentinel node has to be put at the
> + * end of the lockless list. So all the percpu lhead's are initialized
> + * to point to that sentinel node.
> + */

Can you please add why we want all entries to have non-NULL next?

> +static inline bool blkcg_llist_empty(struct llist_head *lhead)
> +{
> +	return lhead->first == &llist_last;
> +}
> +
> +static inline void init_blkcg_llists(struct blkcg *blkcg)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu_ptr(blkcg->lhead, cpu)->first = &llist_last;
> +}
> +
> +static inline struct llist_node *
> +fetch_delete_blkcg_llist(struct llist_head *lhead)
> +{
> +	return xchg(&lhead->first, &llist_last);
> +}
> +
> +static inline struct llist_node *
> +fetch_delete_lnode_next(struct llist_node *lnode)
> +{
> +	struct llist_node *next = READ_ONCE(lnode->next);
> +	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
> +					    lnode)->blkg;
> +
> +	WRITE_ONCE(lnode->next, NULL);
> +	percpu_ref_put(&blkg->refcnt);
> +	return next;
> +}

It's not a strong opinion but I'm not too fond of using inlines to mark
trivial functions. The compiler should be able to make these decisions,
right?

Other than the above two bikesheddings,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
