Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9675BB70
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGUAMS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 20:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGUAMS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 20:12:18 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 17:12:17 PDT
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BAFC
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 17:12:17 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:02:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689897749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2QMFvECdm8dFJV/IrLJkLq1p3G+GKee/U2h0MLyOkg=;
        b=KOmSPRR+QbQBjXhqggDP5pjoKz8izA0OgekgidARozZue4LF/JrgMyfSRsVOon8kZShUCs
        iuKScGj3/4eJx8nQmoeKvDrgYrl23dCurXmodrsSemoBLksfFX420En5g1UBLuJaEqjteF
        xsULlcNlaLyxKaP2p1y6iCgloSi1UGE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZLnLDlQ/B81Qb9pj@P9FQF9L96D.corp.robot.car>
References: <20230720070825.992023-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> This patch series implements the proposal in LSF/MM/BPF 2023 conference
> for reducing offline/zombie memcgs by memory recharging [1]. The main
> difference is that this series focuses on recharging and does not
> include eviction of any memory charged to offline memcgs.
> 
> Two methods of recharging are proposed:
> 
> (a) Recharging of mapped folios.
> 
> When a memcg is offlined, queue an asynchronous worker that will walk
> the lruvec of the offline memcg and try to recharge any mapped folios to
> the memcg of one of the processes mapping the folio. The main assumption
> is that a process mapping the folio is the "rightful" owner of the
> memory.
> 
> Currently, this is only supported for evictable folios, as the
> unevictable lru is imaginary and we cannot iterate the folios on it. A
> separate proposal [2] was made to revive the unevictable lru, which
> would allow recharging of unevictable folios.
> 
> (b) Deferred recharging of folios.
> 
> For folios that are unmapped, or mapped but we fail to recharge them
> with (a), we rely on deferred recharging. Simply put, any time a folio
> is accessed or dirtied by a userspace process, and that folio is charged
> to an offline memcg, we will try to recharge it to the memcg of the
> process accessing the folio. Again, we assume this process should be the
> "rightful" owner of the memory. This is also done asynchronously to avoid
> slowing down the data access path.

Unfortunately I have to agree with Johannes, Tejun and others who are not big
fans of this approach.

Lazy recharging leads to an interesting phenomena: a memory usage of a running
workload may suddenly go up only because some other workload is terminated and
now it's memory is being recharged. I find it confusing. It also makes hard
to set up limits and/or guarantees.

In general, I don't think we can handle shared memory well without getting rid
of "whoever allocates a page, pays the full price" policy and making a shared
ownership a fully supported concept. Of course, it's a huge work and I believe
the only way we can achieve it is to compromise on the granularity of the
accounting. Will the resulting system be better in the real life, it's hard to
say in advance.

Thanks!
