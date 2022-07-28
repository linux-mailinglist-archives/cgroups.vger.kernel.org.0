Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C73584229
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiG1Otc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiG1Ota (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 10:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1904A52E62
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659019769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y72epJF5d8qli+9Ce0BVC/x2v9XQ9z23UFNcVj/FJ4A=;
        b=invJ8yjyj83zcaftgHCipsYac8x/U1edVPR6E9Gvwya9dxo86/KYdr2DE0BejxhY1sGESI
        oZndxhGEOgxG4PFsyvzSiwvSOO0Jul+MzAPD3NXyy55h6pwtN5NB9Ojynt3LssUMEg+F4Z
        Hicr55mRZbOWEqavqJHbJ+OigUfYQoc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-XijDdIi4PyCKyGWgOxNPkA-1; Thu, 28 Jul 2022 10:49:24 -0400
X-MC-Unique: XijDdIi4PyCKyGWgOxNPkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 513D81C0BC6A;
        Thu, 28 Jul 2022 14:49:23 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4854740CF8EB;
        Thu, 28 Jul 2022 14:49:22 +0000 (UTC)
Message-ID: <8e0a41e6-8d03-b0ad-02b5-04449c49c470@redhat.com>
Date:   Thu, 28 Jul 2022 10:49:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cgroup: Skip subtree root in
 cgroup_update_dfl_csses()
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728005815.1715522-2-longman@redhat.com>
 <20220728144426.GA26631@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220728144426.GA26631@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 7/28/22 10:44, Michal Koutný wrote:
> On Wed, Jul 27, 2022 at 08:58:15PM -0400, Waiman Long <longman@redhat.com> wrote:
>> The cgroup_update_dfl_csses() function updates css associations when a
>> cgroup's subtree_control file is modified. Any changes made to a cgroup's
>> subtree_control file, however, will only affect its descendants but not
>> the cgroup itself.
> I find this correct.
>
>> So there is no point in migrating csses associated with that cgroup.
>> We can skip them instead.
> Alone it's not such a big win but it componds with the recent Tejun's
> threadgroup_rwsem elision.
>
It is more an optimization patch trying to not waste cpu time doing 
unnecessary work.
>> ---
>>   kernel/cgroup/cgroup.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> Feel free to have
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
>
Thanks for the review.

Cheers,
Longman

