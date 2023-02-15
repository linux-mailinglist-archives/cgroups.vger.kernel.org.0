Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844BB697FB8
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBOPlg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 10:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBOPlc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 10:41:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32D1A964;
        Wed, 15 Feb 2023 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pp8J3FGpQVVxmK5MKJYP1/LwjqePRMBzRQKB1R9+njg=; b=UQs9d+wk5nXuAIIElOHTs4slay
        fOiSZ+YlSaPH2aFP+w5aqTClcGg0sOPkwOUqZCBh0KesaAr+45/AXkKaJ+X9QLerJ1hbbpLgbuXtj
        kdbepirVH+YcR6ZWERVQPhzOONE01jU5U3YT+MQALQPa35xP6ww9uuaTkshx3A1OdwmgCDpgmRq8M
        qL8AtVCQzZTzkUa29npfQ/r4AMz7q1jp+zE5yg2QHlLrQcJtxbQCZli1NHlxNhQ4VApfIeQCsoT28
        OUBrR1t1080Po2ONwgYSO0slfeswePnlGFNBux557gNcuhP/8GyQvUxlYDVrn4loM4aJkyyNAWKNR
        OONpnvLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSJoT-007a1r-Kt; Wed, 15 Feb 2023 15:35:17 +0000
Date:   Wed, 15 Feb 2023 15:35:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: change to return bool for folio_isolate_lru()
Message-ID: <Y+z7tT6amGO4wNf4@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <8a4e3679ed4196168efadf7ea36c038f2f7d5aa9.1676424378.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4e3679ed4196168efadf7ea36c038f2f7d5aa9.1676424378.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 15, 2023 at 06:39:34PM +0800, Baolin Wang wrote:
> Now the folio_isolate_lru() did not return a boolean value to indicate
> isolation success or not, however below code checking the return value
> can make people think that it was a boolean success/failure thing, which
> makes people easy to make mistakes (see the fix patch[1]).
> 
> if (folio_isolate_lru(folio))
> 	continue;
> 
> Thus it's better to check the negative error value expilictly returned by
> folio_isolate_lru(), which makes code more clear per Linus's suggestion[2].
> Moreover Matthew suggested we can convert the isolation functions to return
> a boolean[3], since most users did not care about the negative error value,
> and can also remove the confusing of checking return value.
> 
> So this patch converts the folio_isolate_lru() to return a boolean value,
> which means return 'true' to indicate the folio isolation is successful,
> and 'false' means a failure to isolation. Meanwhile changing all users'
> logic of checking the isolation state.
> 
> No functional changes intended.
> 
> [1] https://lore.kernel.org/all/20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com/T/#u
> [2] https://lore.kernel.org/all/CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com/
> [3] https://lore.kernel.org/all/Y+sTFqwMNAjDvxw3@casper.infradead.org/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
