Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246364AD706
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiBHLbf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 06:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356083AbiBHKIW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 05:08:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40DC03FEC0;
        Tue,  8 Feb 2022 02:08:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76BA61F388;
        Tue,  8 Feb 2022 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644314900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePNInOzC6B5yJASGd/cwztAJV06U48l5tV+fyrVP+Cs=;
        b=UUqjWtY9SCXAhFmVatTniPu2rGbqj9soOjeMqZZUKgqY0wGYEx99UAcgCBeWBfXuqinAUR
        CuI6xMeqwBDeZyaUWLf68hyGwMFwu0aZZSiHHYuq5MyqmyaTx8PSttFuah16OymkTYBciv
        2ub3JHIEYPTnLJ9em/aYA989OP2dRbY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07731A3B87;
        Tue,  8 Feb 2022 10:08:20 +0000 (UTC)
Date:   Tue, 8 Feb 2022 11:08:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 1/4] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YgJBEgYUuu/b8ZER@alley>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202203036.744010-2-longman@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 2022-02-02 15:30:33, Waiman Long wrote:
> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Note that vsnprintf() will never return -1 to indicate an error. So
> skipping the call to vsnprintf() when size is 0 will have no functional
> impact at all.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
