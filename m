Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B1596640
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiHQANi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiHQANh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 20:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6F2CDC6
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660695214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9qL/h6uXIAb6VYdRPx1bWna3ld2RQQy7Q8vkiGHtWQ=;
        b=YF4vFqcfxWEEd5k189P4s8bOWgjNDSP43I7RHjVOaCeg2l7RkduHsbLg8a2xraciDDqNwP
        yqPSgf3oPa618PcWQ6zhtG4u+BDosfaf4nh2KHBiQ5YPiUyUfBXNaFzsafhYulDo0GuKTL
        TRt1VCIjyb8BlOAXocwv729rMAK34K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-tHEhQ5eaPl6ec8C8iEqrAQ-1; Tue, 16 Aug 2022 20:13:28 -0400
X-MC-Unique: tHEhQ5eaPl6ec8C8iEqrAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CDEE101A54E;
        Wed, 17 Aug 2022 00:13:27 +0000 (UTC)
Received: from [10.22.32.9] (unknown [10.22.32.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA9140D2827;
        Wed, 17 Aug 2022 00:13:26 +0000 (UTC)
Message-ID: <eed3b91b-5297-c27a-acab-87e4afb4148c@redhat.com>
Date:   Tue, 16 Aug 2022 20:13:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/3] cgroup/cpuset: Keep user set cpus affinity
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-4-longman@redhat.com>
 <Yvv66EWygCwHUCqy@slm.duckdns.org>
 <c10e4f69-9951-6c38-6e28-fafcaec00d89@redhat.com>
 <YvwX24GXadKQNp6V@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvwX24GXadKQNp6V@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/16/22 18:19, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 16, 2022 at 06:11:03PM -0400, Waiman Long wrote:
>> It is hard to synchronize different subsystems atomically without running
>> into locking issue. Let me think about what can be done in this case.
> I have a hard time seeing why this would be particularly difficult. cpuset
> just needs to make the latest cpumask available to sched core in an easily
> accessible form and whenever that changes, trigger a set_cpus_allowed call.
> There's no need to entangle operations across the whole subsystems. All
> that's needed to be communicated is the current cpumask.
>
>> Is using a sequence number to check for race with retry good enough?
> It seems unnecessarily fragile and complicated to me. If we're gonna change
> it, let's change it right.

Thanks for the suggestion. I think I get what you want. I am going to 
migrate the cpuset_set_cpus_allowed_ptr() logic into 
set_cpus_allowed_ptr() itself. IOW, if user_cpus_ptr is defined, it will 
be an additional mask to be applied on top. It does affect all callers 
of set_cpus_allowed_ptr() though. I am going to drop this cpuset 
specific patch.

BTW, I will be on PTO starting tomorrow until next Tuesday. So I will be 
slow in responding to emails.

Cheers,
Longman

Cheers,
Longman

