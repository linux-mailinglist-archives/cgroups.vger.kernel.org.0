Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADB6DFD8A
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDLSah (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLSag (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 14:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F71BD
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681324195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWy6sv13whg9JBQjJjQUf4sYt60lbACx2Lp0OS4PkY8=;
        b=D5l7WUWTCLSZCk29NeBNCBzDz0QoAY5/Ytj4T/OOvyGUeD41Oq0qv6EzZiPkxBbozE0jEm
        XVpfMyA2JJ6/O054VXCCrRLLJjRV3NqyKDLpR/PUYGHods4+wQJbKm16R+y8AOGxtH1qqJ
        Eu9TcZF/SnznlJRaf4dGG71QncidKkA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-iuGBN4_CMWWqzejEkV-1eA-1; Wed, 12 Apr 2023 14:29:48 -0400
X-MC-Unique: iuGBN4_CMWWqzejEkV-1eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 648773C025C1;
        Wed, 12 Apr 2023 18:29:47 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88A5D40C6E70;
        Wed, 12 Apr 2023 18:29:46 +0000 (UTC)
Message-ID: <168bb07f-844f-13f5-e4bd-77c2cec94046@redhat.com>
Date:   Wed, 12 Apr 2023 14:29:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/5] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem &
 other issues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230411133601.2969636-1-longman@redhat.com>
 <ZDb32V9xcWOi2_CL@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDb32V9xcWOi2_CL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/12/23 14:26, Tejun Heo wrote:
> On Tue, Apr 11, 2023 at 09:35:56AM -0400, Waiman Long wrote:
>>   v4:
>>    - Add missing rcu_read_lock/unlock to cpuset_cancel_fork() in patch 3.
>>    - Add patch 5 to reduce performance impact for the
>>      non-CLONE_INTO_CGROUP case.
>>
>>   v3:
>>    - Update patches 2 & 3 to put task_cs() call under rcu_read_lock().
>>
>>   v2:
>>    - Drop v1 patch 3
>>    - Add a new patch to fix an issue in cpuset_cancel_attach() and
>>      another patch to add cpuset_can_fork() and cpuset_cacnel_fork()
>>      methods.
>>
>> The first patch in this series fixes a problem in
>> cpuset_cancel_attach(). Patches 2 and 3 fixes the CLONE_INTO_CGROUP
>> problem in cpuset. Patch 4 is a minor fix. The last patch is a
>> performance optimization patch for the non-CLONE_INTO_CGROUP case.
> Applied 1-4 to cgroup/for-6.3-fixes w/ stable cc'd. Given that the fixes are
> a bit involved, the breakages have been there for quite a while and the
> cpuset code has changed quite a bit, backporting might not be trivial tho.
> Let's see how that goes.

I know stable backport won't be straight forward. I am planning to help 
in the backporting effort. Thanks for taking these into your cgroup tree.

Cheers,
Longman

