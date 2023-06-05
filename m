Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E77230AD
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFEUGQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFEUGN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 16:06:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA720D9;
        Mon,  5 Jun 2023 13:06:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53202149ae2so3058380a12.3;
        Mon, 05 Jun 2023 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995570; x=1688587570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5hQoOCxhs453xi/1xca1lXP1aH3gtCI6WwDeyRP63c=;
        b=Y43DZ0GCTRMugXfq0CMHam8i9MEZRHXQ+jXMEWANEr4KIS+AWp+WYS0MX0I3dTM908
         fH1WoRhVJF6aKvlmt651KZ1izZ7NUx9Z96SbrhUfUSrOAg9CNfd7fB/qQ9x3N0+rTY35
         X41VjESyV3yoUVztrZBPGLs0fDcKaXZcSpzwsMfsMJ3enlcEAsZzzPcT32eZ2Os/An73
         DgdKux9OkDblzWOjgMGfrdyEXQJm1j0ATsHMFx5sGs6mOQZb+S5Xf92Tx+1d+jju1Fg8
         4i10VmbTe22RQxYDVbD8Q3/SRq1mhbgzxwjtB3AlclckOZFRE4emZR0Rjhfv0JY0kwbb
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995570; x=1688587570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5hQoOCxhs453xi/1xca1lXP1aH3gtCI6WwDeyRP63c=;
        b=ht3XFnrHTCOLY9FDNecIkqBb6hXZNbowviFpDtePwYqX2C5d2OhVwE18IwL82okvU6
         3g0kk9XZ/B8wFFawQpx9LockoxLMILQlo4T+1jy4wvFLz32e5Fu9DEkywsgXmI639RXx
         gfwpMx8mpCx2OztZsWmBdCREwBEdzY16TV2JKGQEpNj3UCCADagJhiwU8hkmrUlaFDR+
         hkRiTQ3GkipEytNmQzSWJfkb+oHzjXf9v8OpBJg7zjan86cXJp9/8ZgJlUfpan90xbzU
         tzTfzLmzzgHgHVDAZApcd2ua66mA/4s0j16YxA9DLY0S5SdjrH31sYaE6FVUYRMHHk0s
         xjjA==
X-Gm-Message-State: AC+VfDwgF3y7OkDuwmovy9lrq3X4/ZJ6IQYXeIuAEEzdQoHx0nHMAl/s
        LQYOMbQQa+ysarFdoB9ez4E=
X-Google-Smtp-Source: ACHHUZ6ibwdv9H2KS7FiVw95/3kuHDSiZkBg6B220hXGG7z3TPphXvSSCOiYX4euHqzveu2o8Wzkjw==
X-Received: by 2002:a17:903:2445:b0:19d:1834:92b9 with SMTP id l5-20020a170903244500b0019d183492b9mr5825844pls.56.1685995570071;
        Mon, 05 Jun 2023 13:06:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b318])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001b0395c4002sm6971157plg.210.2023.06.05.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:06:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 10:06:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuigaosheng1@huawei.com
Subject: Re: [PATCH] cgroup: Stop task iteration when rebinding subsystem
Message-ID: <ZH5AL4fWfObSstnG@slm.duckdns.org>
References: <20230526114139.70274-1-xiujianfeng@huaweicloud.com>
 <ojymhf4m3p52py6sezwbc2zamxm46wmhxs577uucima6evj2sc@djoi3dhzbdf6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ojymhf4m3p52py6sezwbc2zamxm46wmhxs577uucima6evj2sc@djoi3dhzbdf6>
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

On Thu, Jun 01, 2023 at 07:33:53PM +0200, Michal Koutný wrote:
> > Inside css_task_iter_start/next/end, css_set_lock is hold and then
> > released, so when iterating task(left side), the css_set may be moved to
> > another list(right side), then it->cset_head points to the old list head
> > and it->cset_pos->next points to the head node of new list, which can't
> > be used as struct css_set.
> 
> I find your analysis sane -- the stale it->cset_head is problematic.
> 
> > To fix this issue, introduce CSS_TASK_ITER_STOPPED flag for css_task_iter.
> > when moving css_set to dcgrp->e_csets[ss->id] in rebind_subsystems(), stop
> > the task iteration.
> 
> Does it mean that iteration would not yield all tasks that are
> associated with give cs->css? That sounds like broken correctness of the
> iterator.
> 
> I may suggest a slightly different approach that should not affect
> running iterators.
> - I had to switch from all css_sets to only scgrp's css_sets since
>   css_set_table order of css_sets may be different than scgrp->e_csets
> - Not sure how portable is using array element as a `member` argument of
>   offsetof (in expansion of list_for_each_entry_safe).

Both look fine to me.

> This is only to illustrate the idea, i.e. merely compile tested.
> 
> WDYT?
> 
> Regards,
> Michal
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..e67d2a0776c1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1798,7 +1798,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  {
>  	struct cgroup *dcgrp = &dst_root->cgrp;
>  	struct cgroup_subsys *ss;
> -	int ssid, i, ret;
> +	int ssid, ret;
>  	u16 dfl_disable_ss_mask = 0;
>  
>  	lockdep_assert_held(&cgroup_mutex);
> @@ -1842,7 +1842,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  		struct cgroup_root *src_root = ss->root;
>  		struct cgroup *scgrp = &src_root->cgrp;
>  		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
> -		struct css_set *cset;
> +		struct css_set *cset, *cset_pos;
> +		struct css_task_iter *it;
>  
>  		WARN_ON(!css || cgroup_css(dcgrp, ss));
>  
> @@ -1860,9 +1861,18 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  		css->cgroup = dcgrp;
>  
>  		spin_lock_irq(&css_set_lock);
> -		hash_for_each(css_set_table, i, cset, hlist)
> +		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
> +		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id], e_cset_node[ss->id]) {
>  			list_move_tail(&cset->e_cset_node[ss->id],
>  				       &dcgrp->e_csets[ss->id]);
> +			/* all css_sets of scgrp together in same order to dcgrp,
> +			 * patch in-flight iterators to preserve correct iteration,
> +			 * cset_head is under css_set_lock */
> +			list_for_each_entry(it, &cset->task_iters, iters_node) {
> +				if (it->cset_head == &scgrp->e_csets[ss->id])
> +					it->cset_head = &dcgrp->e_csets[ss->id];

This looks fine to me too but this is rather subtle and it'd worth
explaining further. e.g. on the first glance, it may also seem like we'd
also need to update it->cset_pos and friends because they get initialized to
e_csets[]. This isn't the case because the iterator is always advanced right
away and doesn't remain pointing to the head, but it is kinda tricky.

Thanks.

-- 
tejun
