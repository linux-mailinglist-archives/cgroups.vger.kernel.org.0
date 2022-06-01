Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B147B53AC2D
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355217AbiFARsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiFARsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 13:48:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D66A02F;
        Wed,  1 Jun 2022 10:48:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso2772260pjg.0;
        Wed, 01 Jun 2022 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i0RZ8l73WFDDzM6Aj8EMNY9HnT718p+wPtqJImpAAXg=;
        b=S3qixs5BU1PZ015xxJdsdLuFlKjPKLu5LQhK9EbUs3wNr7hohaemHdXqaFP38FJxhS
         NOdL63FvglE0nVP/ytYaAQ8/SI+xisMk8kKFHjOr3Ms4MaIECDFfFugdb/7zdQw4gIfu
         z4jL2kM1LV6bt8zgoBPQ90Y2K7oI8ROA5R7kA49kP+DzTSQyhU/yk5JoliBZbvJUGjj0
         QXmS7mjQGFEewCudnT6f/JBAKstnLrbMznCYT9p4iZQKD35NI/VAH+GllJr6xxbwAkXh
         fZW4CRltCagOkCaM9d1YSvrCzLQisoFLpHHzeI/j9BQ32TzG4soMEMqy2Gf1po7c/nvH
         RDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=i0RZ8l73WFDDzM6Aj8EMNY9HnT718p+wPtqJImpAAXg=;
        b=27L9/7sGGzydvfO3PrjYXprlCNd+01tdzS/cr/m687kcfLJcLUQhIu/2FACdAwMk8w
         HiVZVP1XWWB96zUIgQCHz0LkDfkeHbYIe1cMCl428Bp5cpuq7ZOimTyOaNoQ03ZK89iF
         NCrg2fpCNPlUpvGF9BNwfZSx4g+6YLZw/+a+HmDWvlwgdopnbKW232r+6TAns8IbDj63
         1TX+pR3RC3aVF6axTApME/kxwQgH8gnTcF38t9Ed46JrwH3yeDZD5AY/Vt9p5mYLJwQi
         00pcGncd3q6b1dCb5ZP52COjbHDy69allNfyWvYCk6kL1zdShiIvHlq/5mE2dZjGmZHd
         W/Cw==
X-Gm-Message-State: AOAM531IJwiX+YEC/gUqqbuq3DpfmgQSkek0LVkCDy8nrsQLWe5yHe+m
        QPsYIRtJwN1sy01o75EXdqbP/wcLqBw=
X-Google-Smtp-Source: ABdhPJxZ0uPByzaE81WrLrAl6/5NjIv/VzL+/GMbIeHfQK4VDBfF+GX9JxV39g3M9z/PFCeU37nCVQ==
X-Received: by 2002:a17:90b:1d0a:b0:1e0:c34d:8c9c with SMTP id on10-20020a17090b1d0a00b001e0c34d8c9cmr544436pjb.238.1654105688741;
        Wed, 01 Jun 2022 10:48:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 84-20020a621857000000b0050dc7628158sm1766629pfy.50.2022.06.01.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:48:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 07:48:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpemVpvaPomwH7mt@slm.duckdns.org>
References: <20220601165324.60892-1-longman@redhat.com>
 <20220601165324.60892-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601165324.60892-2-longman@redhat.com>
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

Hello,

On Wed, Jun 01, 2022 at 12:53:24PM -0400, Waiman Long wrote:
> +static struct llist_node llist_last;	/* Last sentinel node of llist */

Can you please add comment explaining why we need the special sentinel and
empty helper?

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
> +/*
> + * The retrieved blkg_iostat_set is immediately marked as not in the
> + * lockless list by clearing its node->next pointer. It could be put
> + * back into the list by a parallel update before the iostat's are
> + * finally flushed. So being in the list doesn't always mean it has new
> + * iostat's to be flushed.
> + */

Isn't the above true for any sort of mechanism which tracking pending state?
You gotta clear the pending state before consuming so that you don't miss
the events which happen while data is being consumed.

> +#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
> +	for (; (node != &llist_last) &&					\
> +	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
> +		nxt = node->next, node->next = NULL, true);		\
> +		node = nxt)
> +
>  /**
>   * blkcg_css - find the current css
>   *
...
> @@ -852,17 +888,26 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
>  static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  {
>  	struct blkcg *blkcg = css_to_blkcg(css);
> -	struct blkcg_gq *blkg;
> +	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +	struct llist_node *lnode, *lnext;
> +	struct blkg_iostat_set *bisc;
>  
>  	/* Root-level stats are sourced from system-wide IO stats */
>  	if (!cgroup_parent(css->cgroup))
>  		return;
>  
> -	rcu_read_lock();
> +	if (blkcg_llist_empty(lhead))
> +		return;
>  
> -	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> +	lnode = fetch_delete_blkcg_llist(lhead);
> +
> +	/*
> +	 * No RCU protection is needed as it is assumed that blkg_iostat_set's
> +	 * in the percpu lockless list won't go away until the flush is done.
> +	 */

Can you please elaborate on why this is safe?

> +	blkcg_llist_for_each_entry_safe(bisc, lnode, lnext) {
> +		struct blkcg_gq *blkg = bisc->blkg;
>  		struct blkcg_gq *parent = blkg->parent;
> -		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
>  		struct blkg_iostat cur, delta;
>  		unsigned long flags;
>  		unsigned int seq;

Overall, looks fantastic to me. Thanks a lot for working on it.

-- 
tejun
