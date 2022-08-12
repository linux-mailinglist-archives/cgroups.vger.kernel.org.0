Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE125915C5
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiHLTGS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLTGS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 15:06:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161A83BF2;
        Fri, 12 Aug 2022 12:06:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so9147256pjm.3;
        Fri, 12 Aug 2022 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=K5kHnejuEt7Pt9e4fwYPne3BNnxtsVlr6ROsJLvAIa0=;
        b=Qar1VMGJIJ0ygpP/aVRz6hN912vPbq1cxrcogPE79/v7qrHH5Fpt6e7GL1LNHUsgLf
         Ym3uNok4Eaib+wurgKcpDQ8KTxPK3A34Q+SsBzqhBL0rRqNzX5O+7snQNLrMDnCvof23
         Oq4jREnkRCQ67jemY3M/fdd8l7mh4iRBb1njKQBNzdg3Vf1xEm1Lr3HWX0Wkw7Zr2lcu
         yCFl2/gf5DdFkdIUuRsgBe/EY3u/1ca77S5GxMST03y2J8TXCXJAEnNsQ3aT8C7PJd7k
         NKWMKAf6i1iem+kaaWl5e8m7DJkzjoNYDpc6YMRSRgWTSgg3AUf3XoT+/RhCH4B7D42x
         RwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=K5kHnejuEt7Pt9e4fwYPne3BNnxtsVlr6ROsJLvAIa0=;
        b=iRY9YVGmjQABpbe3b0oE76SqtV4C8gWVV1kUB2UEHXAWH9u8yjU4I4itPdTaj4i6mN
         I9mYu9ozrXGujmS40i+Svn+D7rSI/95XZivURewoWYq9aTocbiM/ecbjJFJXS3GiSjbF
         71i/sXx1Ca5OBE/ZUC85QD/UY4Ns/Aof4EH/y6r95wBBPGLE3JJXEs159o6Ijd5alSYq
         2DOleaWo7+fMOj94T6Gv5yUvtwK4uDHmPJcdGmNPs+0CspKMloK4PwHyBnQ42y3DKg0e
         jV2OCXpLKCIAxOmEyY3vMk7412a3XDK2c4ofpFoVgQPA6WZorEPVL6ePuWRuUQ7qT1D5
         fdsA==
X-Gm-Message-State: ACgBeo1YHsUCwk8yGEQQlZ9sBEhw5/O+JpfnizWjb465tDY/TiRpkN3j
        7W+2qGWPJrHVrOeVvLQDCfXQpiuz+xg=
X-Google-Smtp-Source: AA6agR7Trd2hlUSuqdEniygMC1W6QD2WA0qwHIWssKTeTDIqNlX9TLL0eLSoWXssvnAsIkuF2wfTMQ==
X-Received: by 2002:a17:902:694a:b0:16e:e270:1f84 with SMTP id k10-20020a170902694a00b0016ee2701f84mr5367777plt.89.1660331176560;
        Fri, 12 Aug 2022 12:06:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:aae])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0016efa52d428sm2092099pll.218.2022.08.12.12.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 12:06:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 12 Aug 2022 09:06:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        ke.wang@unisoc.com, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [RFC PATCH] cgroup: use root_mem_cgroup as css when current is
 not enabled
Message-ID: <YvakpukeF9d35Bc8@slm.duckdns.org>
References: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
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

On Fri, Aug 12, 2022 at 06:09:26PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Memory charged on group B abserved on belowing v2 hierarchy where we just would
> like to only have group E's memory be controlled and B's descendants compete freely
> for memory. This should be the consequences of unified hierarchy. Solve this by
> have the cgroup without valid memory css alloced use root_mem_cgroup instead of
> its ancestor's.
> 
>  A(subtree_control = memory) - B(subtree_control = NULL) - C()
>                                                          \ D()
> 			     - E(subtree_control = memory) - F()
> 							   \ G()
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  kernel/cgroup/cgroup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1779ccd..b29b3f6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -533,6 +533,14 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
>  	 * can't test the csses directly.  Test ss_mask.
>  	 */
>  	while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
> +		/*
> +		 * charging to the parent cgroup which hasn't distribute
> +		 * memory control to its descendants doesn't make sense
> +		 * especially on cgroup v2, where the parent could be configured
> +		 * to use memory controller as its sibling want to use it
> +		 */
> +		if (memory_cgrp_id == ss->id)
> +			return &root_mem_cgroup->css;

This is gonna be a hard nack. A given cgroup always encompasses all the
resources consumed in its self-including subtree.

Thanks.

-- 
tejun
