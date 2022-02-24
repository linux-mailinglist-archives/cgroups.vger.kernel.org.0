Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24D4C2483
	for <lists+cgroups@lfdr.de>; Thu, 24 Feb 2022 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiBXHkH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 02:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBXHkH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 02:40:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE8175856;
        Wed, 23 Feb 2022 23:39:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBADF1F782;
        Thu, 24 Feb 2022 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645688375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEgq5b010Dc6+wc2/YsOMt1qe+8jokFJKfqLno0+jwE=;
        b=QjzSY5riKfB7KYO1FLjOw7ijkE4br3EC2PSfKMS59pnnJ6juy//nXJPCTK+XueysGy/69D
        TPToJ1yuwUnYW41+f3ezzYFH+KnA7QHSHKbuBu0wLyzvHrS65PRLQD0FolGrxjuiccO7oG
        T0+KYA2MHXIM5exHnXEPmb81gVQqOf0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4565DA3B81;
        Thu, 24 Feb 2022 07:39:31 +0000 (UTC)
Date:   Thu, 24 Feb 2022 08:39:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
Message-ID: <Yhc2NryrtsqPN4Jr@dhcp22.suse.cz>
References: <20220224060148.4092228-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224060148.4092228-1-shakeelb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 23-02-22 22:01:48, Shakeel Butt wrote:
> I have been contributing and reviewing to the memcg codebase for last
> couple of years. So, making it official.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>

Thanks for stepping up, Shakeel!

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ab8f1621d027..cb97140e7dda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5014,6 +5014,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
>  M:	Roman Gushchin <roman.gushchin@linux.dev>
> +M:	Shakeel Butt <shakeelb@google.com>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.35.1.574.g5d30c73bfb-goog

-- 
Michal Hocko
SUSE Labs
