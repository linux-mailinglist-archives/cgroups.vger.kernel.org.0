Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710AD4AD701
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 12:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiBHLb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiBHKvr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 05:51:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3BC03FEC0;
        Tue,  8 Feb 2022 02:51:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E47A1F387;
        Tue,  8 Feb 2022 10:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644317503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xfvi4t6v0E3o8m/BrX7OSyshdoPR/okbuDAi6c9K9Rc=;
        b=By/NatfU9q5/32V4vpdjlTTwvMuHnRPEfjJni8g4r2EgT6xLl48+zn+/fJ0VU9xgEr9zWa
        HW1oGFPuTLIoHd7m+IShMeqYSY+XUU/aeUGXBT7k6ly/qyW/AEaS0oJmdcMw4fMrG/xB0W
        iJ9ZbifzVS3EPlo+CS0nhO3K00YBGWc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA181A3B91;
        Tue,  8 Feb 2022 10:51:42 +0000 (UTC)
Date:   Tue, 8 Feb 2022 11:51:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: [PATCH v4 2/4] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Message-ID: <YgJLPpUqkTaA298Y@alley>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-3-longman@redhat.com>
 <5c03fa31-35a5-4cbc-6b0e-872d5db82a41@suse.cz>
 <42cca916-d4c8-daa1-4a91-60738c499c89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cca916-d4c8-daa1-4a91-60738c499c89@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 2022-02-03 13:49:02, Waiman Long wrote:
> On 2/3/22 10:46, Vlastimil Babka wrote:
> > On 2/2/22 21:30, Waiman Long wrote:
> > > The snprintf() function can return a length greater than the given
> > > input size. That will require a check for buffer overrun after each
> > > invocation of snprintf(). scnprintf(), on the other hand, will never
> > > return a greater length. By using scnprintf() in selected places, we
> > > can avoid some buffer overrun checks except after stack_depot_snprint()
> > > and after the last snprintf().
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Looks like this will work, but note that if the purpose of patch 1/4 was
> > that after the first scnprintf() that overflows the following calls will be
> > short-cut thanks to passing the size as 0, AFAICS that won't work. Because
> > scnprintf() returns the number without trailing zero, 'ret' will be 'count -
> > 1' after the overflow, so 'count - ret' will be 1, never 0.
> 
> Yes, I am aware of that. Patch 1 is just a micro-optimization for the very
> rare case.

In theory, we might micro-optimize also the case when "size == 1".

Well, I am not sure if it is worth it. After all, the primary use-case
is to print the message into a big-enough buffer. Lost information is
a bigger problem than the speed ;-)

Best Regards,
Petr
