Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34D68D58F
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 12:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjBGLdo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 06:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBGLdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 06:33:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA737545;
        Tue,  7 Feb 2023 03:32:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FB56134B;
        Tue,  7 Feb 2023 11:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A051EC433EF;
        Tue,  7 Feb 2023 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675769554;
        bh=Rx3qesTFjYVQZeUfWaFK3pteCQOp67kpFcX7NQe4XWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouCviE7soxWQaxNuMqAEp/UxyNwdNn8JwBvupPyex57tqzN8UnwSOAmK/n07K5s1V
         ZIfTMQj9JdA+Wli5BUDE1FdqJmcovbxES/o2fXTXMa1QbLe0SrE+N7cE291dLOt4xm
         rXXdQpWZ7pb2n5wnXoJFRWCAEUgEQ69n8XPo908PMo9vJq7uesEdPujJ0+W8NXUnOO
         mfPQPcToqZb14qF8B3VmuNl+FJDnXQ/UspowogT2uMKFjoQQvOtdQXDftYwJXh6FT4
         NoSh2Lqmf4eKMukkM0sd+H+qBsyAsN5ie2mrPtmp+sRl1LozhyJT+naka9fpJR0+hE
         CaoyFHnIeFhOA==
Date:   Tue, 7 Feb 2023 11:32:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <20230207113228.GB12147@willie-the-truck>
References: <20230203164040.213437-1-longman@redhat.com>
 <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
 <f356b916-1c10-1565-73fb-34027c6c510a@redhat.com>
 <20230206110540.GA11024@willie-the-truck>
 <Y+FgQXvnzSF1OrmO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+FgQXvnzSF1OrmO@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 10:17:05AM -1000, Tejun Heo wrote:
> On Mon, Feb 06, 2023 at 11:05:41AM +0000, Will Deacon wrote:
> > > If we want to get it into the next merge windows, there isn't much time left
> > > for linux-next testing. So a lower risk solution is better from that
> > > perspective too.
> > 
> > This needs to land for 6.2 to fix the regression. The next merge window is
> > too late. That's why I cooked the reverts [1] as an alternative.
> 
> Yeah, I think Waiman meant before the coming merge window. We have at least
> one more week so let's try the two patches and see how that goes. We can
> always revert if it doesn't work out.

I see this has landed in Linus' tree now, so thanks for that! I also tested
his branch just to make sure and it all seems fine in my asymmetric
environment.

Cheers,

Will
