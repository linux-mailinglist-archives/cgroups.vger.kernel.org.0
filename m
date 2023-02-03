Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63AE68A2EC
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjBCTZt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjBCTZs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:25:48 -0500
Received: from out-76.mta1.migadu.com (out-76.mta1.migadu.com [IPv6:2001:41d0:203:375::4c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB7A0017
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 11:25:28 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:25:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675452324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xemEPS75g6CyaGYVTuNx4T5APXnPBUE9kBl1lVKlrTM=;
        b=ah/EreyLTKURus8ZQYbvdkwIeyZn+6VcKKQqlNdRE+EKzIxTpJdYzfdCWnCx8dIjocnERr
        FabQHAoVFjL7/nCF4j6JwNDZ3IxOsSqSwgKBVNOg8H1r2A4U/yDR8aWkgHFDw5EsvHH5ad
        z01tV+bx4YqgPBnEsnYYSL0KSmKrlEo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y91fnF5uEcSA0/99@P9FQF9L96D.corp.robot.car>
References: <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
 <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
 <Y9QVWwAreTlDVdZ0@P9FQF9L96D.corp.robot.car>
 <Y90mZQhW89HtYfT9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90mZQhW89HtYfT9@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 04:21:09PM +0100, Michal Hocko wrote:
> OK, so this is a speculative patch. cpu_is_isolated doesn't exist yet. I
> have talked to Frederic off-list and he is working on an implementation.
> I will be offline next whole week (will be back Feb 13th) so I am
> sending this early but this patch cannot be merged without his one of
> course.
> 
> I have tried to summarize the reasoning behind both approach should we
> ever need to revisit this approach. For now I strongly believe a simpler
> solution should be preferred.
> 
> Roman, I have added your ack as you indicated but if you disagree with
> the reasoning please let me know.

Great, thank you for preparing it up! Really nice summary.
My ack definitely applies.

If you want, feel free to add a
"Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>"
tag to blame me later :)

Thank you!
