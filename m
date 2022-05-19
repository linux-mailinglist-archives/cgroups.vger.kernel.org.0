Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D452D114
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiESLDC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbiESLDC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:03:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBE5C347;
        Thu, 19 May 2022 04:03:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B522219AD;
        Thu, 19 May 2022 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652958180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzXgw0a74dIiLsfsgpX507bbTu4KgqdYCg8XDacIqHw=;
        b=p6eg7yMBMmZI2a2JOGfaZfOHUgEOzr0pYRni8ATdIoJyZhzflN3bAt8hpReN3HD8VnJ9qZ
        EOq6iF/jJF96GHnLG2V2n1ZpPZntJNxjElw0yW8Q29RCIQOzEe40LqFOlEuEEvCAxCHZz+
        iR5Y6RjT79txDZA425cVGDkX0PR58WM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37F412C141;
        Thu, 19 May 2022 11:02:59 +0000 (UTC)
Date:   Thu, 19 May 2022 13:02:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
Message-ID: <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518223815.809858-1-vaibhav@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 19-05-22 04:08:15, Vaibhav Jain wrote:
> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> of pages scanned and reclaimed is still not directly available to the
> user-space.
> 
> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> readable which returns the number of pages scanned / reclaimed during the
> reclaim process from 'struct vmpressure' associated with each memcg. This should
> let user-space asses how successful proactive reclaim triggered from memcg
> 'memory.reclaim' was ?
> 
> With the patch following command flow is expected:
> 
>  # echo "1M" > memory.reclaim
> 
>  # cat memory.reclaim
>    scanned 76
>    reclaimed 32

Why cannot you use memory.stat? Sure it would require to iterate over
the reclaimed hierarchy but the information about scanned and reclaimed
pages as well as other potentially useful stats is there.
-- 
Michal Hocko
SUSE Labs
