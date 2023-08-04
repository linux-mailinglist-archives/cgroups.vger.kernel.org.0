Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61776FA37
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHDGho (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHDGh1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 02:37:27 -0400
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6C46B2
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 23:37:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691131041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNm9pORzTgeogyqyW+mD8AlYYC8dXpJMUZdeirF8KCc=;
        b=lGU4btESR6WhEkMDXa2K6SgziaZU8b0hBHTqqAyF7szoZin5ZQ2hAjVHd1brkR/ab5Pt1E
        EBkiru/eTktl0j/74+CcJPbEcas/cdaQVsMEanF1vKFOevsW382PoWFv7lWAEZUBjxY5nV
        ozwpR2K+WN/7PlcwbrKAt776kTFudsg=
MIME-Version: 1.0
Subject: Re: [PATCH v3] selftests: cgroup: fix test_kmem_basic slab1 check
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <zff2gqiy4cggy4px2hbcyna6eipy56qc4itx5cx5agtxlzdxt7@dvfdarqkucac>
Date:   Fri, 4 Aug 2023 14:36:36 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <22339C68-8BCA-4CB4-895B-9FE679D4D34B@linux.dev>
References: <zff2gqiy4cggy4px2hbcyna6eipy56qc4itx5cx5agtxlzdxt7@dvfdarqkucac>
To:     Lucas Karpinski <lkarpins@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 4, 2023, at 02:25, Lucas Karpinski <lkarpins@redhat.com> wrote:
> 
> test_kmem_basic creates 100,000 negative dentries, with each one mapping
> to a slab object. After memory.high is set, these are reclaimed through
> the shrink_slab function call which reclaims all 100,000 entries. The
> test passes the majority of the time because when slab1 is calculated,
> it is often above 0, however, 0 is also an acceptable value.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks

