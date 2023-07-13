Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13026752330
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjGMNRJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jul 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjGMNRI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jul 2023 09:17:08 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D1EB4
        for <cgroups@vger.kernel.org>; Thu, 13 Jul 2023 06:17:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689254225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+dPUPTmwBYtftPXHExk6W0A20wTkFyNXTYbt9nVnXc=;
        b=Plf1VJZqsSocTgkFrvxT3pd8zwNJ3D3lTkylOpz2s1XWebviS34/mH15tUhOnXdXnrAeht
        KjpZvZZ5RCLrfkACYLGWk9t66HInMYsE0xVVoFXFJc7K7Xgcc83jofaWDe8g3l6Phw7YYn
        g7iZVP2HiFm7/jeu8KZOUuEFKDmycvQ=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memcg: fix obsolete comment above
 MEM_CGROUP_MAX_RECLAIM_LOOPS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230713121432.273381-1-linmiaohe@huawei.com>
Date:   Thu, 13 Jul 2023 21:16:25 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F1480552-81A0-4245-A444-5F49BAB7D0AF@linux.dev>
References: <20230713121432.273381-1-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Jul 13, 2023, at 20:14, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> Since commit 5660048ccac8 ("mm: move memcg hierarchy reclaim to generic
> reclaim code"), mem_cgroup_hierarchical_reclaim() is already renamed to
> mem_cgroup_soft_reclaim(). Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

