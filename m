Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBC584322
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiG1Pfg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiG1Pff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 11:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC45920F7E
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659022534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2lk2hqDKcE3DDLOhqbpwiGyywL02+HBUzoqQOKIEfY=;
        b=e7I3jQYqn+i1jh+28n62ByMkPKXnBhZ1RSKhHHCbdq1r2f4hizoMIJcT68wmz+YZ3w1bHG
        d37QNPxZedsLV6ogKw+dgPEvnh8i6yNSPEmIULk2ZBNI6vPF8K6sHvAcSWGNoerZ1rA+q/
        Atf3CZHyUqBBYECC81Ldv6i4P6UXs3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-PA64DZPlMt2YhMyv00gn8g-1; Thu, 28 Jul 2022 11:35:28 -0400
X-MC-Unique: PA64DZPlMt2YhMyv00gn8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1473E8037B5;
        Thu, 28 Jul 2022 15:35:28 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91DDB2166B26;
        Thu, 28 Jul 2022 15:35:26 +0000 (UTC)
Message-ID: <a252d963-aedd-c9fe-e507-2b8fea8d375d@redhat.com>
Date:   Thu, 28 Jul 2022 11:35:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
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
 <20220728144420.GA27407@blackbody.suse.cz>
 <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
 <20220728152355.GB25894@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220728152355.GB25894@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/28/22 11:23, Michal Koutný wrote:
> On Thu, Jul 28, 2022 at 10:59:01AM -0400, Waiman Long <longman@redhat.com> wrote:
>> Cgroup v1 doesn't have this problem.
> v1 analogy would be:
>
> 	echo 2-3 >$dst/cpuset.cpus
> 	# job runs in $dst
> 	# one task T in $dst sets affinity just to one cpu
> 	# I rethink my config, I want to allow $dst more space
> 	echo 2-5 >$dst/cpuset.cpus
>
> Most tasks in $dst happily utilize the new cpus but it breaks affinity
> for T -- this must have been broken since ever.
>
> (Or I'd argue that per-thread affinities are just recommendations, if I
> have a task for nohz CPU, I should enforce its placement with cpuset
> from the beginning.)

I should have clarified that what I meant is systemd on a cgroup v1 
environment doesn't cause this cpu list reset to happen. It doesn't mean 
that cgroup v1 has no similar problem. Sorry for the confusion.

Cheers,
Longman

