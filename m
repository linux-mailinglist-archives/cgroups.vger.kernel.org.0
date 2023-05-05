Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A16F7BB0
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 05:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjEEDyh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 23:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEDyg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 23:54:36 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 20:54:35 PDT
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49B11572
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 20:54:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683258410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdstHLLK2gjOImYQV2bW8W6qJ+VMebC2r6lpW7ASjOQ=;
        b=xpmr4J6VcuQA8arCmDuI/+V4og63KJIFBlBzrrrblGmtHqWON1ivEOMglN2h2Qg1/o2CmT
        PbGxWGdhKcG8mr/PRQxdIZQ0x2lMKuu0yKmnKqz6/P6PSOSqzbU0b2CJ1QqGfpf6owumUc
        JiLrELiAIJ/U3ooS/lf+LknWuujeGds=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] memcg: use seq_buf_do_printk() with
 mem_cgroup_print_oom_meminfo()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230428132406.2540811-2-yosryahmed@google.com>
Date:   Fri, 5 May 2023 11:46:10 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5BE37965-9A20-4743-A2BC-E407D89C53D1@linux.dev>
References: <20230428132406.2540811-1-yosryahmed@google.com>
 <20230428132406.2540811-2-yosryahmed@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 28, 2023, at 21:24, Yosry Ahmed <yosryahmed@google.com> wrote:
> 
> Currently, we format all the memcg stats into a buffer in
> mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
> However, this buffer is large in size. Although it is currently working
> as intended, ther is a dependency between the memcg stats buffer and the
> printk record size limit.
> 
> If we add more stats in the future and the buffer becomes larger than
> the printk record size limit, or if the prink record size limit is
> reduced, the logs may be truncated.
> 
> It is safer to use seq_buf_do_printk(), which will automatically break
> up the buffer at line breaks and issue small printk() calls.
> 
> Refactor the code to move the seq_buf from memory_stat_format() to its
> callers, and use seq_buf_do_printk() to print the seq_buf in
> mem_cgroup_print_oom_meminfo().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

