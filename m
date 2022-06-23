Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B155574D8
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiFWIGA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFWIF7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 04:05:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DA473AA;
        Thu, 23 Jun 2022 01:05:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B06011FD3B;
        Thu, 23 Jun 2022 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655971557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9JvyrtgVzfCy9ltHeRGduIrfv2kgcjya7gqZ8Tg/Eg=;
        b=NyVtGuJt8cxNsPfYFDoV+sIvK1KTL8xU6r6mwnAYB2JKqguCEJ9f/3TqAsImvAR01eR767
        q/fw2eL8mU8xVld1PKOtc+bBWtYdBf2xpd/9Pmk20D0RpEweflTKcZjNKqraXVi4sWplQi
        PO+js2nqOqm2w+GNEKhlXlL7F+vzvlQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50F6B2C142;
        Thu, 23 Jun 2022 08:05:51 +0000 (UTC)
Date:   Thu, 23 Jun 2022 10:05:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
Message-ID: <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
References: <20220623000530.1194226-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623000530.1194226-1-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 00:05:30, Yosry Ahmed wrote:
> Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure") made sure that memory reclaim that is induced by
> userspace (limit-setting, proactive reclaim, ..) is not counted as
> memory pressure for the purposes of psi.
> 
> Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> from try_charge() and reclaim_high() wrap the call to
> try_to_free_mem_cgroup_pages() with psi handlers.
> 
> However, vmpressure is still counted in these cases where reclaim is
> directly induced by userspace. This patch makes sure vmpressure is not
> counted in those operations, in the same way as psi. Since vmpressure
> calls need to happen deeper within the reclaim path, the same approach
> could not be followed. Hence, a new "controlled" flag is added to struct
> scan_control to flag a reclaim operation that is controlled by
> userspace. This flag is set by limit-setting and proactive reclaim
> operations, and is used to count vmpressure correctly.
> 
> To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> is effectively reverted and the same flag is used to control psi as
> well.

Why do we need to add this is a legacy interface now? Are there any
pre-existing users who realized this is bugging them? Please be more
specific about the usecase.

-- 
Michal Hocko
SUSE Labs
