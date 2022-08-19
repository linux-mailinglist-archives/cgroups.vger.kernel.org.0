Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4C59A350
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350149AbiHSRLI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350087AbiHSRKi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 13:10:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E911BB1D;
        Fri, 19 Aug 2022 09:30:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c24so4070899pgg.11;
        Fri, 19 Aug 2022 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=UMwZBhpqxvMN4MWwkHckLMAVG27kfXbnwXOCeD112cI=;
        b=GCXQ0jrSKwhxTdDFaLB9Yx0otU4yPi1wlSwQtWbV+ZH7O/f4QKRxXJTQenmXQDThwK
         qOzg+oLhbwQWO+mboLEBXF4mWTEdBiQjEth/eUYaDnlQHfA4oxAr+S6jlTmbfb+B4RBm
         MMfkAsBxGk04ZGAWr3GQUVXWvZbwjGhcIkk32qwPQbVMESPB1oNgBnV1oBsktWK3btWP
         aZfzgsVl5keC0Xcy0DfJxAfbrQmNzJY/SpNIPEomjheSRkuln3FTfweWPPzG9+7R/+Lb
         WKZy3Hkc9y4q+EWRBO2VhDaNdmmQHnhx4NU8x8D18sXITF2WqzIyVgyGGkWRVjT1lcmI
         bzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=UMwZBhpqxvMN4MWwkHckLMAVG27kfXbnwXOCeD112cI=;
        b=0GiixpWqjYIut3jKnJm4pLJVkx1ro6Egtrhv4XeL/3Gef2kgJaXkqmLbj8ZYItXy/5
         /6BAxoR5ib94X3fC09opuwL9nVg/03UQxYXIVP4uXhj7vUKpuJPschs5xkegfVD6k6Z7
         p9cpg+xFAbhIid/cKkF8Rr9+mhhBoSrC0IOrg3S511/tPpP8DaFhlV8dSBQEmzcKC/9x
         xAZz6osl3//WYinqmSqg8pTcxFtM3EOPOeM/Tu40NMC3Tg/NcxA9fgXRs6Pi0EfEQ4On
         eULGRgzad545ZJjJk6+BZrtWvRoFra2zgA9w7P6GESDd/dHP7RlsXSOIeeQE67eyaBKi
         e4vg==
X-Gm-Message-State: ACgBeo3YUVEqGLiaLt7jnTn1fN8ZxKUeIgPUmD+Gqv66artg2CmwkzGq
        sZ5/nwcRq2YPFIDLmOn3k+M=
X-Google-Smtp-Source: AA6agR7qwQkeiT9bIYFGWoJJzTnKudCWsCo3wg9a4a8ZRYNU25geqs9/HUiLyJqucTL0mwrA2mRmEA==
X-Received: by 2002:a63:8848:0:b0:42a:1a29:c261 with SMTP id l69-20020a638848000000b0042a1a29c261mr5606255pgd.51.1660926565069;
        Fri, 19 Aug 2022 09:29:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:db7d])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0016ee4b0bd60sm3402498plx.166.2022.08.19.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:29:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 Aug 2022 06:29:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        ke.wang@unisoc.com, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <Yv+6YjaGAv52yvq9@slm.duckdns.org>
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
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

On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> It is observed in android system where per-app cgroup is demanded by freezer
> subsys and part of groups require memory control. The hierarchy could be simplized
> as bellowing where memory charged on group B abserved while we only want have
> group E's memory be controlled and B's descendants compete freely for memory.
> This should be the consequences of unified hierarchy.
> Under this scenario, less efficient memory reclaim is observed when comparing
> with no memory control. It is believed that multi LRU scanning introduces some
> of the overhead. Furthermore, page thrashing is also heavier than global LRU
> which could be the consequences of partial failure of WORKINGSET mechanism as
> LRU is too short to protect the active pages.
> 
> A(subtree_control = memory) - B(subtree_control = NULL) - C()
> 							\ D()
> 			    - E(subtree_control = memory) - F()
> 							  \ G()
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Just in case it wasn't clear.

Nacked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
