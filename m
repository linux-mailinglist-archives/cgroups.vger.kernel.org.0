Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CC5BDA1B
	for <lists+cgroups@lfdr.de>; Tue, 20 Sep 2022 04:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiITC1u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 22:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiITC1r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 22:27:47 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33B248DB;
        Mon, 19 Sep 2022 19:27:45 -0700 (PDT)
Date:   Mon, 19 Sep 2022 19:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663640863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeERVvMe/yZ4WRpFkDFlzsr8+m+omuR9+WcKqeq+40g=;
        b=bk877dvOilqXPR/W2GG9QgSFDJ9hkO2gNM3LKayAg5uyueSbyMhG/o5ByJqgdQJ5D9Rzrn
        DWn1zzfwIgbieK6vuTTp9CrshXf8Ve3oCCt49LtQdIuprua3AncXc3rlU2hSF02RZMQF6N
        aDy7OIouYOiGvqP5COG4nKlU71QdrIs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kairui Song <kasong@tencent.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcontrol: use memcg_kmem_enabled in
 count_objcg_event
Message-ID: <YyklGi1KVaOL6d7C@P9FQF9L96D>
References: <20220919180634.45958-1-ryncsn@gmail.com>
 <20220919180634.45958-2-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919180634.45958-2-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 20, 2022 at 02:06:33AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently two helpers for checking if cgroup kmem
> accounting is enabled:
> 
> - mem_cgroup_kmem_disabled
> - memcg_kmem_enabled
> 
> mem_cgroup_kmem_disabled is a simple helper that returns true
> if cgroup.memory=nokmem is specified, otherwise returns false.
> 
> memcg_kmem_enabled is a bit different, it returns true if
> cgroup.memory=nokmem is not specified and there was at least one
> non-root memory control enabled cgroup ever created. This help improve
> performance when kmem accounting was not actually activated. And it's
> optimized with static branch.
> 
> The usage of mem_cgroup_kmem_disabled is for sub-systems that need to
> preallocate data for kmem accounting since they could be initialized
> before kmem accounting is activated. But count_objcg_event doesn't
> need that, so using memcg_kmem_enabled is better here.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Kairui!
