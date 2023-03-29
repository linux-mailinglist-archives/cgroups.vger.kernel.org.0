Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA56CF14E
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjC2Ro0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjC2RoX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 13:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B955B1
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680111817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNiOEETt5ceepAWfcz8ECfQ8OGyjPyRpc2CWu+K0Sd4=;
        b=PZpbwvFH9veQkgEXtvQ5HCjuinul9iQJCR2THwyNT2lg7RFDnfBY91xdn8AC3cNHSP+jzr
        AO8D8zlEpSY7WSCeO5HT66miJX6gnOGxABO+MwBTgHn5+t4Gf6kPmfCJslCreYdzbw6JxB
        Sr5p770cv2iXHRKWDMqvZGcrb2Ankmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-g2rJpyJjMyW__HbcjQzbpQ-1; Wed, 29 Mar 2023 13:43:33 -0400
X-MC-Unique: g2rJpyJjMyW__HbcjQzbpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6263C85C069;
        Wed, 29 Mar 2023 17:43:33 +0000 (UTC)
Received: from [10.22.34.224] (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 135E71121331;
        Wed, 29 Mar 2023 17:43:32 +0000 (UTC)
Message-ID: <47d478a9-9730-eda8-e4dd-c848f01c0834@redhat.com>
Date:   Wed, 29 Mar 2023 13:43:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
 <c3d9cf24-1c3a-cda4-5063-6b7d27e9116f@redhat.com>
 <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
 <ZCRQsAoe1lN1qCiB@cmpxchg.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZCRQsAoe1lN1qCiB@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/29/23 10:52, Johannes Weiner wrote:
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
> That's what I thought at first too, but then I had some doubts.
>
> The callback is called 'attach', but it's historically implemented
> when moving an established task between two cgroups. Many controllers
> use it to move state between groups (memcg, pids, cpuset). So in
> practice it isn't the natural fit that its name would suggest, and it
> would require reworking those controllers to handle both scenarios:
> moving tasks between groups, and new tasks attaching to a cgroup.
>
> Now I'm thinking it probably makes more sense to keep using attach for
> moving between groups, and fork for being born into a cgroup. That's
> what the pid controller does, and it handles CLONE_INTO_CGROUP fine.
>
> There is naturally some overlap between the two operations. But it
> seems cleaner to me to use common helpers for that, as opposed to
> having both attach and fork callbacks handling forks.

I was thinking along the line of using common helpers for doing fork and 
attach. However, the expected method function prototypes are quite 
different. For example,

int (*can_attach)(struct cgroup_taskset *tset);
int (*can_fork)(struct task_struct *task, css_set *cset);

We need to make them more similar before we can use common helpers. I 
can take a look at that.

Thanks,
Longman

