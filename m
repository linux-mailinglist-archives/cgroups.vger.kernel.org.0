Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB0550CED
	for <lists+cgroups@lfdr.de>; Sun, 19 Jun 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiFSUc1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jun 2022 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiFSUc1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jun 2022 16:32:27 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E5E71;
        Sun, 19 Jun 2022 13:32:25 -0700 (PDT)
Date:   Sun, 19 Jun 2022 13:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655670744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iFzVnSMJWQfW6ecslMrsDUmHZ1b88XfEpJU+8AWm4I=;
        b=jdnZFEZHOLbOp782xUrFZDV9bkoz87qvOXXknUfwfEDMS6vQCKYIHqWX9FuG3L49Ub8CqO
        X2SHeiVHXr59jzxUDeShfbhkM1/S8dJKtZWUxV3s1aCoQSk3UGq8JQ4OQBiQdMsu6iT7jb
        qHFttOTcjUj8VNbKGY4/L59wUe54hKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 09/11] mm: memcontrol: use obj_cgroup APIs to charge
 the LRU pages
Message-ID: <Yq+H0v0/nuxPRLX+@castle>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-10-songmuchun@bytedance.com>
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

On Mon, May 30, 2022 at 03:49:17PM +0800, Muchun Song wrote:
> We will reuse the obj_cgroup APIs to charge the LRU pages. Finally,
> page->memcg_data will have 2 different meanings.
> 
>   - For the slab pages, page->memcg_data points to an object cgroups
>     vector.
> 
>   - For the kmem pages (exclude the slab pages) and the LRU pages,
>     page->memcg_data points to an object cgroup.
> 
> In this patch, we reuse obj_cgroup APIs to charge LRU pages. In the end,
> The page cache cannot prevent long-living objects from pinning the original
> memory cgroup in the memory.
> 
> At the same time we also changed the rules of page and objcg or memcg
> binding stability. The new rules are as follows.
> 
> For a page any of the following ensures page and objcg binding stability:
> 
>   - the page lock
>   - LRU isolation
>   - lock_page_memcg()
>   - exclusive reference
> 
> Based on the stable binding of page and objcg, for a page any of the
> following ensures page and memcg binding stability:
> 
>   - objcg_lock
>   - cgroup_mutex
>   - the lruvec lock
>   - the split queue lock (only THP page)
> 
> If the caller only want to ensure that the page counters of memcg are
> updated correctly, ensure that the binding stability of page and objcg
> is sufficient.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Aside from two questions, which I raised in the comments to previous patches
in the series:
1) perf impact,
2) should we open-code the reparenting procedure to show the locking in a more
explicit ways?

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
