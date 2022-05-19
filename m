Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9052CEBA
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiESIxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiESIxt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 04:53:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C39CF57
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 01:53:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i17so4198257pla.10
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qb0g91B4uY7eJRc6xeHQ2DAiXKBk0/y0aultWo/u9CY=;
        b=RqwsFn2TEA+P6oiyLBWbQ+AUkd9t7DXfQDPEBNB4xm8lld/qbcQsgni+Qt8A5akZAn
         Q2TA2GnYSjn1HWpwrQ+vUkLlOFRN0Yuil/kEKYFfmAUk+ff6qXesxAWpmAnjVf6sT/HE
         KRI4OcTynB6Dq9rp0UvorxFA6Icz3Fs1sWZaegWjqOneg0BkOoj1MQ/aky19TaLNcYj9
         yQucjjZZqQiMN5pWjvGh01DmYwwYrS1KQbq4zBPJfUg+aDGniz1u+gmkn/tAwOoxuvw/
         wdjyFWOj8f1MfUQTxW/4/OOiGYuW7zFE7ArHBO44jp0CoTPpJ6sp8K8vpkWGAlzd2s3/
         oQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qb0g91B4uY7eJRc6xeHQ2DAiXKBk0/y0aultWo/u9CY=;
        b=KL+Px6IvYfaPojBqQTRldry+OCtaToGjhmblGF2Wvpslr0g0AbaZwXB1QrIyXRGCIy
         nwZXaNEukNAqtoowriYserjTEkglS7BwLbnnqDvEizeRhsaIFEyN8j2th/sZ+Sl/n7iM
         sxJzPkOhm68ycfyMlHMnHKrCX4O5DPPm6vpXXuspsCzq5mz0WSLL5MxvGIhoKtSFdrdn
         6OPOhndcZSVFA+t4Ut8Ue25u2ZWIEV0ALeE5eZnfks7/GCXRFIKIQG/u02wLRr9hGeja
         9MMqp9X2daqIn0xd6xCR0kurls3DVsf+NagJcHnKS8sMDTrQx9Thz8kYQNfs/O4+nz2Y
         M7iQ==
X-Gm-Message-State: AOAM530qF7q9qZScPV8KUjZG7YIvCZC7EgVMHfWXm7imLXkUAfcxxVH/
        wklUPJADV3ut6BFhfgwbYqTitg==
X-Google-Smtp-Source: ABdhPJymegXU+LYRYsLtON1UbHo2oi9iTpwUvqyD3wXV6WQW0QT6iUUVcY3jUwxVTHWraQvQRe6peg==
X-Received: by 2002:a17:902:a9c6:b0:15e:fe5d:cf67 with SMTP id b6-20020a170902a9c600b0015efe5dcf67mr3869503plr.74.1652950426842;
        Thu, 19 May 2022 01:53:46 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id p127-20020a622985000000b0050dc76281c1sm3486635pfp.155.2022.05.19.01.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:53:46 -0700 (PDT)
Date:   Thu, 19 May 2022 16:53:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
Message-ID: <YoYFl31LJh0Uy+oD@FVFYT0MHHV2J.usts.net>
References: <20220518190911.82400-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 18, 2022 at 03:09:11PM -0400, Johannes Weiner wrote:
> This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.
> 
> Its premise was that cgroup reclaim cares about freeing memory inside
> the cgroup, and demotion just moves them around within the cgroup
> limit. Hence, pages from toptier nodes should be reclaimed directly.
> 
> However, with NUMA balancing now doing tier promotions, demotion is
> part of the page aging process. Global reclaim demotes the coldest
> toptier pages to secondary memory, where their life continues and from
> which they have a chance to get promoted back. Essentially, tiered
> memory systems have an LRU order that spans multiple nodes.
> 
> When cgroup reclaims pages coming off the toptier directly, there can
> be colder pages on lower tier nodes that were demoted by global
> reclaim. This is an aging inversion, not unlike if cgroups were to
> reclaim directly from the active lists while there are inactive pages.
> 
> Proactive reclaim is another factor. The goal of that it is to offload
> colder pages from expensive RAM to cheaper storage. When lower tier
> memory is available as an intermediate layer, we want offloading to
> take advantage of it instead of bypassing to storage.
> 
> Revert the patch so that cgroups respect the LRU order spanning the
> memory hierarchy.
> 
> Of note is a specific undercommit scenario, where all cgroup limits in
> the system add up to <= available toptier memory. In that case,
> shuffling pages out to lower tiers first to reclaim them from there is
> inefficient. This is something could be optimized/short-circuited
> later on (although care must be taken not to accidentally recreate the
> aging inversion). Let's ensure correctness first.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
