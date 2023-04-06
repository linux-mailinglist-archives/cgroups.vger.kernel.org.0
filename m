Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777DB6D992C
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbjDFOKS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjDFOJz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF8AD10
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KANTDl9cP5Foo4kRIPvE9J1MD539S2x+RsUY14Y5myk=;
        b=Mn3Ghn0EV4C3eoqo3ZqwS+wSD6r1Grv+Rpap2gYsK70uJ6vGJD7MaQzz2siOeKYCDtfFzm
        4lm7VUOA1wYJpYbiuNCg24VYC+vcnMHZ4zlaeFuOZ3ZSCr5WREPodmod4DPZKUjstL0DMr
        6LRf7/hgfNG2r9fSjNRmqtr5lcuPds4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-6G4ZrLGKNxeLGG7o1dz7DA-1; Thu, 06 Apr 2023 10:08:32 -0400
X-MC-Unique: 6G4ZrLGKNxeLGG7o1dz7DA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 424348996E7;
        Thu,  6 Apr 2023 14:08:32 +0000 (UTC)
Received: from [10.22.9.26] (unknown [10.22.9.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD84E492C14;
        Thu,  6 Apr 2023 14:08:31 +0000 (UTC)
Message-ID: <a115f40d-057e-a4a9-474f-fb3dcf04edee@redhat.com>
Date:   Thu, 6 Apr 2023 10:08:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
 <20230406-vernommen-kurieren-e75f4ee6ea96@brauner>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230406-vernommen-kurieren-e75f4ee6ea96@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/6/23 05:45, Christian Brauner wrote:
> On Fri, Mar 31, 2023 at 10:50:43AM -0400, Waiman Long wrote:
>> By default, the clone(2) syscall spawn a child process into the same
>> cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
>> introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
>> into cgroups"), the child will be spawned into a different cgroup which
>> is somewhat similar to writing the child's tid into "cgroup.threads".
>>
>> The current cpuset_fork() method does not properly handle the
>> CLONE_INTO_CGROUP case where the cpuset of the child may be different
>> from that of its parent.  Update the cpuset_fork() method to treat the
>> CLONE_INTO_CGROUP case similar to cpuset_attach().
>>
>> Since the newly cloned task has not been running yet, its actual
>> memory usage isn't known. So it is not necessary to make change to mm
>> in cpuset_fork().
>>
>> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
> Just two nits. I think this needs a Cc stable and it would be nice if
> you could give Giuseppe a "Reported-by".

The presence of a fixes tag should make this patch picked up by stable. 
Yes, I will cc stable when I need to update the patch next time.

Right, I should have added

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>

Cheers,
Longman

