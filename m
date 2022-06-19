Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED2E550CD1
	for <lists+cgroups@lfdr.de>; Sun, 19 Jun 2022 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiFSTrx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jun 2022 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiFSTrw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jun 2022 15:47:52 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EEA1FC;
        Sun, 19 Jun 2022 12:47:48 -0700 (PDT)
Date:   Sun, 19 Jun 2022 12:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655668066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmVesAtZj3F0FKl2f4W9KeAOvC/uB1VCNNtyFwxxP9I=;
        b=OY6DMLII7wiyFQUlghxLigw/dZpLgmKP6un0IhO4Cligy+mRBNPXEPRJwVeV1R4Ul0e3KP
        Jps9VNA7Gn97vU3YbFrLGWC3b4hV61+aEF3XU2HbFdMzi3kMOb9X7K5HsFDJwbgmhiMs7T
        6mkneWt1ousS67WqNBDSmvJflVA5YWg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 08/11] mm: memcontrol: introduce memcg_reparent_ops
Message-ID: <Yq99W9ps1b/+XOwh@castle>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-9-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-9-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 03:49:16PM +0800, Muchun Song wrote:
> In the previous patch, we know how to make the lruvec lock safe when LRU
> pages are reparented. We should do something like following.
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>         spin_lock(&lruvec->lru_lock);
>         spin_lock(&lruvec_parent->lru_lock);
> 
>         2) relocate from current memcg to its parent
>         // Move all the pages from the lruvec list to the parent lruvec list.
> 
>         3) unlock
>         spin_unlock(&lruvec_parent->lru_lock);
>         spin_unlock(&lruvec->lru_lock);
> 
> Apart from the page lruvec lock, the deferred split queue lock (THP only)
> also needs to do something similar. So we extract the necessary three steps
> in the memcg_reparent_objcgs().
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         memcg_reparent_ops->lock(memcg, parent);
> 
>         2) relocate
>         memcg_reparent_ops->relocate(memcg, reparent);
> 
>         3) unlock
>         memcg_reparent_ops->unlock(memcg, reparent);
> 
> Now there are two different locks (e.g. lruvec lock and deferred split
> queue lock) need to use this infrastructure. In the next patch, we will
> use those APIs to make those locks safe when the LRU pages reparented.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I've mixed feelings about this: it looks nice, but maybe too nice. I wonder
if it's better to open-code it. Not very confident, I wonder what others are
thinking.

1) Because the lock callback is first called for all ops, then relocate, then
unlock, implicit lock dependencies are created. Now it depends on the order
of elements in the memcg_reparent_ops array, which isn't very obvious.
2) Unlikely there will be a lot of new ops added in the future.

The code looks correct though.

Thanks!
