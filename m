Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7868A68983D
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjBCMHg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 07:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjBCMHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 07:07:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F42953CC;
        Fri,  3 Feb 2023 04:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA962B82A86;
        Fri,  3 Feb 2023 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F60C433D2;
        Fri,  3 Feb 2023 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675426048;
        bh=msGwOm825d5bTfkvH6VS4qDGirjySSflMwYCy++8sKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mm+hrRsZd6lHoQ4P32lEMMW/tnzXNG69D1a5bhZ18l3dD4lVqQsHuUiOz7kgZk8S2
         bfgNAN0H0THHk2/t1+Wi0s1tqGQdfQ9bNAVxRbF97I3Ly8781eoEWOoANXXAYAavXJ
         EnUWqZWGUqJfRdz36tJd4EGtwEQYGOWb+/jmuNKpWczJHCjvfNxDc4AXwsShZv6IPN
         jU3xHdXUWYpBFT5jO9MkcRn8P2WUz28PnrRbuXiVqv++DCBHczaxXAuCFYHh01MI9Y
         po7tGfu5rS17z7cq+dnMSArLm/JJV+ec2AR/v1SMWFP8k9rzo46kz0o1WmAGEhccaZ
         OcMdgfMUuJ3ZA==
Date:   Fri, 3 Feb 2023 12:07:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/2] cgroup/cpuset: Make hotplug code more efficient
Message-ID: <20230203120722.GB6274@willie-the-truck>
References: <20230202143200.128753-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202143200.128753-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Waiman,

On Thu, Feb 02, 2023 at 09:31:58AM -0500, Waiman Long wrote:
>  v2:
>   - It turns out it works around the v1 cpuset missing offline cpu
>     problem better than I originally thought. So the patch description
>     is updated accordingly.
> 
> This small patch series makes the cpuset hotplug a bit more efficient
> by eliminating unnecessary task iteration and cpu/node masks update
> when a cpu hotplug event (online/offline) happens.
> 
> It can also largely work around the known problem of missing previously
> offlined cpus in v1 cpuset with some exceptions.

I can't tell whether this is intended to address the issue I initially
reported at [1], so I gave it a spin anyway and it doesn't seem to help.

If it's unrelated, then sorry for the noise!

Will

[1] https://lore.kernel.org/r/20230117160825.GA17756@willie-the-truck
