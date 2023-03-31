Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177C06D27CA
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 20:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjCaS2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCaS2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 14:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA81BF49
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680287249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYhblDY2uVVuzGjt43iHxyxL8ZY1RhpsgBR731PMnOU=;
        b=WPG/0F/5R+kVpQhTIKjp/QNHkvMYsGbJN/H2H323eV4UzfRmAGlcCqu0MIX8hmbwAKDzMG
        yCGyymU9+AYBSJyhe7AAdd3h1tJYjGm06jDk9m1gZUajx66FlpIsNlF8aV+wgDVek6en3Y
        RaIaEzyPq29H1kspKmOObImaZj9qSqM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-Aq92WrFNMeGmx7FIv48hGw-1; Fri, 31 Mar 2023 14:27:27 -0400
X-MC-Unique: Aq92WrFNMeGmx7FIv48hGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 460B429A9D38;
        Fri, 31 Mar 2023 18:27:27 +0000 (UTC)
Received: from [10.22.17.48] (unknown [10.22.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE7C202701F;
        Fri, 31 Mar 2023 18:27:26 +0000 (UTC)
Message-ID: <174663c9-84f6-1ea1-192b-cdc756802bdf@redhat.com>
Date:   Fri, 31 Mar 2023 14:27:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
 <c3d9cf24-1c3a-cda4-5063-6b7d27e9116f@redhat.com>
 <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
 <20230329-unripe-imminent-655bed17aad2@brauner>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230329-unripe-imminent-655bed17aad2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/29/23 03:19, Christian Brauner wrote:
> On Tue, Mar 28, 2023 at 10:48:49PM -0400, Waiman Long wrote:
>> On 3/28/23 21:30, Waiman Long wrote:
>>> On 3/28/23 11:39, Christian Brauner wrote:
>>>> Hey,
>>>>
>>>> Giuseppe reported that the the affinity mask isn't updated when a
>>>> process is spawned directly into the target cgroup via
>>>> CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
>>>> mask to be updated (see the repro at [1].
>>>>
>>>> I took a quick look and the issue seems to be that we don't call the
>>>> various attach handlers during CLONE_INTO_CGROUP whereas we do for
>>>> migration. So the solution seems to roughly be that we need to call the
>>>> various attach handlers during CLONE_INTO_CGROUP as well when the
>>>> parent's cgroups is different from the child cgroup. I think we need to
>>>> call all of them, can, cancel and attach.
>>>>
>>>> The plumbing here might be a bit intricate since the arguments that the
>>>> fork handlers take are different from the attach handlers.
>>>>
>>>> Christian
>>>>
>>>> [1]: https://paste.centos.org/view/f434fa1a
>>>>
>>> I saw that the current cgroup code already have the can_fork, fork and
>>> cancel_fork callbacks. Unfortunately such callbacks are not defined for
>>> cpuset yet. That is why the cpu affinity isn't correctly updated. I can
>>> post a patch to add those callback functions to cpuset which should then
>>> able to correctly address this issue.
>> Looking further into this issue, I am thinking that forking into a cgroup
>> should be equivalent to write the child pid into the "cgroup.threads" file
>> of the target cgroup. By taking this route, all the existing can_attach,
>> attach and cancel_attach methods can be used. I believe the original fork
>> method is for the limited use case of forking into the same cgroup. So right
>> now, only the pids controller has the fork methods. Otherwise, we will have
>> to modify a number of different controllers to add the necessary fork
>> methods. They will be somewhat similar to the existing attach methods and so
>> it will be a lot of duplication. What do you think about this idea?
> The overall plan sounds good to me. I have one comment and question
> about making this equivalent to a write of the child pid into the
> cgroup.threads file.
>
> The paragraph above seems to imply that CLONE_INTO_CGROUP currently
> isn't equivalent to a write to cgroup.threads. But it's not that
> straightforward. CLONE_INTO_CGROUP needs to handle both threads and
> threadgroups aka being or-ed with CLONE_THREAD or not. It does that in
> cgroup_css_set_fork() when calling
> cgroup_attach_permissions([...] !(kargs->flags & CLONE_THREAD), [...]).
>
> What it's missing is calling the relevant handlers that would be
> executed in the migration path. They might be different between the
> CLONE_THREAD and !CLONE_THREAD case. But the crux remains that
> CLONE_INTO_CGROUP needs to handle both cases.
>
> So afaict, what you're proposing is equivalent to what I sketched in the
> initial mail? Or is there something else you mean by making this
> equivalent to cgroup.threads that goes beyond adding the missing
> handlers? Just trying to make sure we're not accidently changing
> semantics.

It turns out that cpuset does have a cpuset_fork() method defined and so 
is the legacy freezer even though they don't have a can_fork method. So 
the simplest way to fix this problem is to extend the existing 
cpuset_fork() method to handle the CLONE_INTO_CGROUP case. I have sent 
out an upstream patch to fix that issue.

Cheers,
Longman

