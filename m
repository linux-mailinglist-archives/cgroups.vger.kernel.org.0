Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79A53BD83
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiFBRqv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiFBRqu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 13:46:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C71739A;
        Thu,  2 Jun 2022 10:46:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 187so5336022pfu.9;
        Thu, 02 Jun 2022 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0kiPQZyWlYVIOJkiV7UkjYaE9b35apJIAe4jrH0pmE=;
        b=kO2DY3HPvb+3eEPd6LYATCmZzcBFTRNM1TmFlyQ3BCQ39OQfDP/80su+HJub539UCX
         mAAf/8f5bBYQJFafrQBX7h++LbgnuLdMzl84tr9BbOpVvDrSmosmtasLj+l+LzkUbHe2
         WugmU0OhU6xm0rEawAcbdFCgSh/LizY4ldHmL0VbAWhHRTJrKQEviTclXHeXRp5GdOa5
         XyHQpuxVbS51/K59T9mIXRr5jMinKxlt/1bMd7/ZIY/7ayduain8sOvhTGiixu1OnRBF
         3qgdn49fml1TLsnCDFoipgFQP9QJrxuStRusAYujgTf2nhuOf08B35nG2Bpg1j4HO85p
         fXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=S0kiPQZyWlYVIOJkiV7UkjYaE9b35apJIAe4jrH0pmE=;
        b=hjWUpLFY1p2Bb9uKvgQKUenkU618lGQZCWMRZT7BDIfm2axNWGLup7HwPwnr5myacx
         OOzcht+22lRPhgAam0ulONOFp+SeoJlJrWfXNDEmkJZn0AgANtFaT5A1Leulpw6+PaIH
         7duXQBKKjq/lvOsgF9CxpbJG0f1wfvODuMM8vq15mZeAyhrQXPFPv5IFkR4c/XLnH+eb
         KMv79dywHO36pc/a4j+8ZC3Od8PJyDFq5HIuBa1GZ4PZ3wDz6caZI1XtZKB1vn/jdAAa
         Ca6Vq6E2CLfAjh3IxBvmw79/gcfWE2xD0z6CDAH47jgLrKQvr+Vjc0dQamgjkZ3EGIIM
         c86w==
X-Gm-Message-State: AOAM530WGeNqp6V9+O85TF5fgUBcsg0zrfoEfkWV226yVIHm1cw6b1jd
        UPiM1yS9MtjEvvgPfyqcFP8=
X-Google-Smtp-Source: ABdhPJz7y32iYDT2F/DMmapftPbyZXOxJDY02/3F1ptZUEjlRkeChivP9vk2/181q5VWGJeZ8Wd3Yg==
X-Received: by 2002:a62:7b94:0:b0:51b:c723:5724 with SMTP id w142-20020a627b94000000b0051bc7235724mr4685709pfc.8.1654192007390;
        Thu, 02 Jun 2022 10:46:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:49ff])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b00163ef7be14csm3744464plc.89.2022.06.02.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:46:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Jun 2022 07:46:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <Ypj3hcodkAU1MUR7@slm.duckdns.org>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220602133543.128088-4-longman@redhat.com>
 <YpjsTNZx4DG+kot4@slm.duckdns.org>
 <42da456d-8f6a-3af0-4cd3-d33a07e3b81e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42da456d-8f6a-3af0-4cd3-d33a07e3b81e@redhat.com>
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

On Thu, Jun 02, 2022 at 01:26:10PM -0400, Waiman Long wrote:
> 
> On 6/2/22 12:58, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Jun 02, 2022 at 09:35:43AM -0400, Waiman Long wrote:
> > > @@ -2011,9 +2076,16 @@ void blk_cgroup_bio_start(struct bio *bio)
> > >   	}
> > >   	bis->cur.ios[rwd]++;
> > > +	if (!READ_ONCE(bis->lnode.next)) {
> > > +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> > > +
> > > +		llist_add(&bis->lnode, lhead);
> > > +		percpu_ref_get(&bis->blkg->refcnt);
> > Hmm... what guarantees that more than one threads race here? llist assumes
> > that there's a single writer for a given llist_node and the ref count would
> > be off too, right?
> 
> The llist_add() function is atomic. It calls into llist_add_batch() in
> lib/llist.c which uses cmpxchg() to make the change. There is a non-atomic
> version __llist_add() which may be problematic in this case. Note that irq
> is disabled in the u64_stats_update* critical section, there shouldn't be a
> racing thread running in the same cpu. Other cpus will modify their own
> version of lhead. Perhaps the non-atomic version can be used here as well.

Ah, right, this is per-cpu, so there can be no second writer trying to add
the same node at the same time. Can you add a comment explaining the overall
design / behavior? Other than that, please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
