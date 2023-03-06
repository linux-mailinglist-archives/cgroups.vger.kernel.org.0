Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694D6ACB53
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCFRwo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCFRwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:52:44 -0500
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600726C181
        for <cgroups@vger.kernel.org>; Mon,  6 Mar 2023 09:52:15 -0800 (PST)
Date:   Mon, 6 Mar 2023 09:51:32 -0800
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v2, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store
 tearing fixes
Message-ID: <ZAYoJPAEHemTFjtY@P9FQF9L96D>
References: <20230306154138.3775-1-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 06, 2023 at 11:41:34PM +0800, Yue Zhao wrote:
> This patch series helps to prevent load/store tearing in
> several cgroup knobs.
> 
> As kindly pointed out by Michal Hocko and Roman Gushchin
> , the changelog has been rephrased.
> 
> Besides, more knobs were checked, according to kind suggestions
> from Shakeel Butt and Muchun Song.
> 
> v1:
> - Add [WRITE|READ]_ONCE for memcg->oom_group
> v2:
> - Rephrase changelog
> - Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
>  memcg->swappiness, vm_swappiness and memcg->soft_limit
> 
> Yue Zhao (4):
>   mm, memcg: Prevent memory.oom.group load/store tearing
>   mm, memcg: Prevent memory.swappiness load/store tearing
>   mm, memcg: Prevent memory.oom_control load/store tearing
>   mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Thank you!
