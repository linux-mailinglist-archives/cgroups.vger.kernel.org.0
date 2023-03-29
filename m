Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048B6CD2D4
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjC2HTe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 03:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjC2HTd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 03:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D626AD;
        Wed, 29 Mar 2023 00:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C1E61AA0;
        Wed, 29 Mar 2023 07:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAC1C433D2;
        Wed, 29 Mar 2023 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680074371;
        bh=DJrGjjYVJpklJpi1Yq8f2deLg7xBT/QYXB70zUacqlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wjl7AZtgidfWsFBwLpkWu6wrTOCYLeiIt/T9ZtM1cHbhm9JBWbILWp+3B0DMqyTAm
         ZwRHtvM8wy1Wvxx5PdJScuqKzz5BTDDBZ6kC1r1zwo6Rjoy+q2g45h2PVQcU9XoK7c
         wSNoFuQ2GqjoNIWUhFdCC6H60l9Y+6yZk5Zqf/mZS7Z8aTJoH0uIgz+eCiLD9jlzIO
         rkuw851jOE6lFcY4HW2xdSjvLlbb9N4DedrBXMwFvir1l+n8LcB/ZDs61qtbq0XmX6
         /mik1o1PMtNarwUWCvkq0xce+PFK4BErlxMGigSUCUYTeTLnno3D9iMVR9T3QsLqyC
         6lk1dTHj9Th0w==
Date:   Wed, 29 Mar 2023 09:19:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Message-ID: <20230329-unripe-imminent-655bed17aad2@brauner>
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
 <c3d9cf24-1c3a-cda4-5063-6b7d27e9116f@redhat.com>
 <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 10:48:49PM -0400, Waiman Long wrote:
> On 3/28/23 21:30, Waiman Long wrote:
> > On 3/28/23 11:39, Christian Brauner wrote:
> > > Hey,
> > > 
> > > Giuseppe reported that the the affinity mask isn't updated when a
> > > process is spawned directly into the target cgroup via
> > > CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
> > > mask to be updated (see the repro at [1].
> > > 
> > > I took a quick look and the issue seems to be that we don't call the
> > > various attach handlers during CLONE_INTO_CGROUP whereas we do for
> > > migration. So the solution seems to roughly be that we need to call the
> > > various attach handlers during CLONE_INTO_CGROUP as well when the
> > > parent's cgroups is different from the child cgroup. I think we need to
> > > call all of them, can, cancel and attach.
> > > 
> > > The plumbing here might be a bit intricate since the arguments that the
> > > fork handlers take are different from the attach handlers.
> > > 
> > > Christian
> > > 
> > > [1]: https://paste.centos.org/view/f434fa1a
> > > 
> > I saw that the current cgroup code already have the can_fork, fork and
> > cancel_fork callbacks. Unfortunately such callbacks are not defined for
> > cpuset yet. That is why the cpu affinity isn't correctly updated. I can
> > post a patch to add those callback functions to cpuset which should then
> > able to correctly address this issue.
> 
> Looking further into this issue, I am thinking that forking into a cgroup
> should be equivalent to write the child pid into the "cgroup.threads" file
> of the target cgroup. By taking this route, all the existing can_attach,
> attach and cancel_attach methods can be used. I believe the original fork
> method is for the limited use case of forking into the same cgroup. So right
> now, only the pids controller has the fork methods. Otherwise, we will have
> to modify a number of different controllers to add the necessary fork
> methods. They will be somewhat similar to the existing attach methods and so
> it will be a lot of duplication. What do you think about this idea?

The overall plan sounds good to me. I have one comment and question
about making this equivalent to a write of the child pid into the
cgroup.threads file.

The paragraph above seems to imply that CLONE_INTO_CGROUP currently
isn't equivalent to a write to cgroup.threads. But it's not that
straightforward. CLONE_INTO_CGROUP needs to handle both threads and
threadgroups aka being or-ed with CLONE_THREAD or not. It does that in
cgroup_css_set_fork() when calling
cgroup_attach_permissions([...] !(kargs->flags & CLONE_THREAD), [...]).

What it's missing is calling the relevant handlers that would be
executed in the migration path. They might be different between the
CLONE_THREAD and !CLONE_THREAD case. But the crux remains that
CLONE_INTO_CGROUP needs to handle both cases.

So afaict, what you're proposing is equivalent to what I sketched in the
initial mail? Or is there something else you mean by making this
equivalent to cgroup.threads that goes beyond adding the missing
handlers? Just trying to make sure we're not accidently changing
semantics.
