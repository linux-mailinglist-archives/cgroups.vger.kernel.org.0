Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88167550CC6
	for <lists+cgroups@lfdr.de>; Sun, 19 Jun 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiFSThm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jun 2022 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFSThm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jun 2022 15:37:42 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E063B31;
        Sun, 19 Jun 2022 12:37:40 -0700 (PDT)
Date:   Sun, 19 Jun 2022 12:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655667458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YC8yB2PG4+G4xynDd4qhQyEPOAofxKVrbu3RRitWED4=;
        b=qD+Mvbj8IaI6qDNJWPeluOnJwp3jOJoDFAlyYvn3hpSvpPHCy2u9O7pXCmd/wKVQaa191Z
        BL+H+G8SckXSSX4/zrN40egc6e0GXplsUqbnw5+JYBugq02IQYc5TAljDysQhZNjUYe+lb
        /lPOYR+3IUzs8PTIkjMG8AUO96ECJrU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 07/11] mm: memcontrol: make all the callers of
 {folio,page}_memcg() safe
Message-ID: <Yq96/NEanbbUUUIW@castle>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-8-songmuchun@bytedance.com>
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

On Mon, May 30, 2022 at 03:49:15PM +0800, Muchun Song wrote:
> When we use objcg APIs to charge the LRU pages, the page will not hold
> a reference to the memcg associated with the page. So the caller of the
> {folio,page}_memcg() should hold an rcu read lock or obtain a reference
> to the memcg associated with the page to protect memcg from being
> released. So introduce get_mem_cgroup_from_{page,folio}() to obtain a
> reference to the memory cgroup associated with the page.
> 
> In this patch, make all the callers hold an rcu read lock or obtain a
> reference to the memcg to protect memcg from being released when the LRU
> pages reparented.
> 
> We do not need to adjust the callers of {folio,page}_memcg() during
> the whole process of mem_cgroup_move_task(). Because the cgroup migration
> and memory cgroup offlining are serialized by @cgroup_mutex. In this
> routine, the LRU pages cannot be reparented to its parent memory cgroup.
> So {folio,page}_memcg() is stable and cannot be released.
> 
> This is a preparation for reparenting the LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

The locking seems to be correct. I'm slightly worried about a potential
perf degradation, especially on dying cgroups, where css_get() is relatively
expensive. I hope getting it into mm-unstable will help to determine
whether it's actually a problem.

Thanks!
