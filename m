Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BA55AE05
	for <lists+cgroups@lfdr.de>; Sun, 26 Jun 2022 03:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiFZBl4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiFZBl4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 21:41:56 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD413DE3;
        Sat, 25 Jun 2022 18:41:54 -0700 (PDT)
Date:   Sat, 25 Jun 2022 18:41:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656207712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHwnwrn3rPLBw4iau7Jw3zxeWr01E6ma/j2ZXjk5zGg=;
        b=inhynC+/9JmTzlEUN75pSJA6UyVqmDxmnGSgTFQHSr2kBt1CK8HHksb3zxHQsrKsUctugk
        SpYIih+PNnMaCVDkKN7IUONVnXa4JDeJ+OIHiL6jjGlrQTlPkj+zbYVVeDLiEFoaJXx6oQ
        3ELrf+PeJB10lLu5X+Q7mJuA9mTGfk8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Xiang Yang <xiangyang3@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/memcontrol.c: replace cgroup_memory_nokmem with
 mem_cgroup_kmem_disabled()
Message-ID: <Yre5WiiXDejuhwe/@castle>
References: <20220625061844.226764-1-xiangyang3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625061844.226764-1-xiangyang3@huawei.com>
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

On Sat, Jun 25, 2022 at 02:18:44PM +0800, Xiang Yang wrote:
> mem_cgroup_kmem_disabled() checks whether the kmem accounting is off.
> Therefore, replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled(),
> which is the same work in percpu.c and slab_common.c.
> 
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
