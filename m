Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236B5389FE
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbiEaCqc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiEaCqb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 22:46:31 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDFF94185;
        Mon, 30 May 2022 19:46:30 -0700 (PDT)
Date:   Mon, 30 May 2022 19:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653965188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWLskQLKMPVKxlcT8cF2mhzS9rXCoBmCHqKI67gGiCw=;
        b=f5jx0zSo1IDRLLA2GZuXmPBxAvu6IPoXlGGFIPAW6XeA5oP8KzsIUya+c1dZtZ3UwqO1Y6
        alTzIKwUDxFq+Ya5GGK63RBl/slscys5MmU+WjXwPXiLMFoPRataIRfeAwFWACW+GEE26w
        rUWXxNveDigVU/2Y0MKCi5DvmbtlULU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, shakeelb@google.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YpWBfPviP0TTSF4d@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530141711.6cf70dcf200e28aa40407f6e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530141711.6cf70dcf200e28aa40407f6e@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 02:17:11PM -0700, Andrew Morton wrote:
> On Mon, 30 May 2022 15:49:08 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > This version is rebased on v5.18.
> 
> Not a great choice of base, really.  mm-stable or mm-unstable or
> linux-next or even linus-of-the-day are all much more up to date.
> 
> Although the memcg reviewer tags are pretty thin, I was going to give
> it a run.  But after fixing a bunch of conflicts I got about halfway
> through then gave up on a big snarl in get_obj_cgroup_from_current().
> 
> > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
> 
> Surprising, that was over a year ago.  Why has is taken so long?

It's partially my fault: I was thinking (and to some extent still are)
that using objcg is not the best choice long-term and was pushing on the
idea to used per-memcg lru vectors as intermediate objects instead.
But it looks like I underestimated the complexity and a potential overhead
of this solution.

The objcg-based approach can solve the problem right now and it shouldn't
bring any long-term issues. So I asked Muchun to revive the patchset.

Thanks!
