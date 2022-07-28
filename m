Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC158466A
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiG1TVg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiG1TVf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 15:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FE967585
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659036093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpAAXgdBuqbloSbXAkh13drsVm6WLwNgqwukGGREVlE=;
        b=VGZPINUCWBbksqHCbK7r10+hZ4369nQ/+ZCUeLnC7jGOxYu6wxTbsjhBHzqjJua9IaZGCV
        nPm+NaSpY/lrU9ccPSQMa2T3todnVb/BajY05VXTBXHXk2ZaElNPZ9OIoKbCqy5O33b86E
        mXuUm+HfNVjvVlC7cS1tMLNtaF3sEUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-jSAs81R-P-yYNJnPyJpCMg-1; Thu, 28 Jul 2022 15:21:28 -0400
X-MC-Unique: jSAs81R-P-yYNJnPyJpCMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A82A2185A79C;
        Thu, 28 Jul 2022 19:21:27 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9EB8492C3B;
        Thu, 28 Jul 2022 19:21:26 +0000 (UTC)
Message-ID: <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
Date:   Thu, 28 Jul 2022 15:21:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
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
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YuLdX7BYGvo57LNU@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/28/22 15:02, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 28, 2022 at 02:57:28PM -0400, Waiman Long wrote:
>> There can be a counter argument that if a user found out that there is not
>> enough cpus in a cpuset to meet its performance target, one can always
>> increase the number of cpus in the cpuset. Generalizing this behavior to all
>> the tasks irrespective if they have explicitly set cpus affinity before will
>> disallow this use case.
> This is nasty.

That is a nasty example, I know. There may be users depending on the 
existing behavior even if they don't know it. So I am a bit hesitant to 
change the default behavior like that. On the other hand, tasks that 
have explicitly set its cpu affinity certainly don't want to have 
unexpected change to that.

> The real solution here is separating out what user requested
> and the mask that cpuset (or cpu hotplug) needs to apply on top. ie.
> remember what the user requested in a separate cpumask and compute the
> intersection into p->cpus_maks whenever something changes and apply
> fallbacks on that final mask. Multiple parties updating the same variable is
> never gonna lead to anything consistent and we're patching up for whatever
> the immediate use case seems to need at the moment. That said, I'm not
> necessarily against patching it up but if you're interested in delving into
> it deeper, that'd be great.

I believe the current code is already restricting what cpu affinity that 
a user can request by limiting to those allowed by the current cpuset. 
Hotplug is another issue that may need to be addressed. I will update my 
patch to make it handle hotplug in a more graceful way.

Thanks,
Longman

