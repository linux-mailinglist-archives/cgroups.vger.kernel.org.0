Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CE6D9333
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjDFJtF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbjDFJsu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 05:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAA9EE2;
        Thu,  6 Apr 2023 02:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A584A64509;
        Thu,  6 Apr 2023 09:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B22C433EF;
        Thu,  6 Apr 2023 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680774359;
        bh=CNnljoUNyOiCQnpEpUjEBMYYwt8hw2OqgmnQ53lJJC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NO4KxgWW4fGaPj/jgCTdne5zTkmD5p5XSq8odegv2hTDIN/+Gx/hpw686wJ2vJzt7
         dThSxxFMxxBYdfBZ93TM3nfZyuEoi3I0NZHSLTo6SaqR8RxxjSJ4+xVUb6R4n8Qbon
         GLYOO6EQQpJr6x7794UnkMjbDvkz/flUyRCXjk6FHck+y0PL1EgOy4HFQFTDEMqmkl
         iKmrWRC6JsPXFyJN4tb8IekF1NjUDg+0qKMJNTSoVk8mV0MZVYn6KqvBxgROg6j8VO
         TAbrbZJQUyQi3wL8C99KaZlaVKV0Xy106X4QSyidFU0RfdMaTf3HEUuxxV4cgcD6KT
         hE6QQEdsCIS7w==
Date:   Thu, 6 Apr 2023 11:45:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Message-ID: <20230406-vernommen-kurieren-e75f4ee6ea96@brauner>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331145045.2251683-2-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 31, 2023 at 10:50:43AM -0400, Waiman Long wrote:
> By default, the clone(2) syscall spawn a child process into the same
> cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
> introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
> into cgroups"), the child will be spawned into a different cgroup which
> is somewhat similar to writing the child's tid into "cgroup.threads".
> 
> The current cpuset_fork() method does not properly handle the
> CLONE_INTO_CGROUP case where the cpuset of the child may be different
> from that of its parent.  Update the cpuset_fork() method to treat the
> CLONE_INTO_CGROUP case similar to cpuset_attach().
> 
> Since the newly cloned task has not been running yet, its actual
> memory usage isn't known. So it is not necessary to make change to mm
> in cpuset_fork().
> 
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Just two nits. I think this needs a Cc stable and it would be nice if
you could give Giuseppe a "Reported-by".
