Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098571F707
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjFBAKg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFBAKe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 20:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB3136
        for <cgroups@vger.kernel.org>; Thu,  1 Jun 2023 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685664588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQBTL4KWFtPVFbs25Ot9x0LJbTVOUU336wX1+2B8Rjk=;
        b=SupiPRc9oKFa+Gk1jUVkI+qcMzcrPPHZ8VbEQ3wWUX0z4XxvSZoOzdASX12bLcVyFn6jo3
        b0551IFjvfk5LrOtKuTyGshq3A8FX87Vb/KKvSTP1VWivXu6n82r+Q5fZislQ58InGqOdH
        yVwwTyHQdV0XRE9w+Yc8GTTIMu63lgg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-bkhrC-83MXW-CYPiVx5WNw-1; Thu, 01 Jun 2023 20:09:43 -0400
X-MC-Unique: bkhrC-83MXW-CYPiVx5WNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59A152932493;
        Fri,  2 Jun 2023 00:09:43 +0000 (UTC)
Received: from [10.22.8.52] (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1B0A40C6EC4;
        Fri,  2 Jun 2023 00:09:42 +0000 (UTC)
Message-ID: <f0cf5dd9-47fa-742d-a23c-42602dc3b89e@redhat.com>
Date:   Thu, 1 Jun 2023 20:09:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
 <e6ae97f4-cdae-e655-d118-a11b3d679fd6@redhat.com>
 <20230601195345.GB157732@cmpxchg.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230601195345.GB157732@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/23 15:53, Johannes Weiner wrote:
> On Thu, Jun 01, 2023 at 03:15:28PM -0400, Waiman Long wrote:
>> On 6/1/23 14:38, Dan Schatzberg wrote:
>>> The existing documentation refers to memory.high as the "main mechanism
>>> to control memory usage." This seems incorrect to me - memory.high can
>>> result in reclaim pressure which simply leads to stalls unless some
>>> external component observes and actions on it (e.g. systemd-oomd can be
>>> used for this purpose). While this is feasible, users are unaware of
>>> this interaction and are led to believe that memory.high alone is an
>>> effective mechanism for limiting memory.
>>>
>>> The documentation should recommend the use of memory.max as the
>>> effective way to enforce memory limits - it triggers reclaim and results
>>> in OOM kills by itself.
>> That is not how my understanding of memory.high works. When memory usage
>> goes past memory.high, memory reclaim will be initiated to reclaim the
>> memory back. Stall happens when memory.usage keep increasing like by
>> consuming memory faster than what memory reclaim can recover. When
>> memory.max is reached, OOM killer will then kill off the tasks.
> This was the initial plan indeed: Slow down the workload and thus slow
> the growth; hope that the workload recovers with voluntary frees; set
> memory.max as a safety if it keeps going beyond.
>
> This never panned out. Once workloads are stuck, they might not back
> down on their own. By increasingly slowing growth, it becomes harder
> and harder for them to reach the memory.max intervention point.
>
> It's a very brittle configuration strategy. Unless you very carefully
> calibrate memory.high and memory.max together with awareness of the
> throttling algorithm, workloads that hit memory.high will just go to
> sleep indefinitely. They require outside intervention that either
> adjusts limits or implements kill policies based on observed sleeps
> (they're reported as pressure via psi).
>
> So the common usecases today end up being that memory.max is for
> enforcing kernel OOM kills, and memory.high is a tool to implement
> userspace OOM killing policies.
>
> Dan is right to point out the additional expectations for userspace
> management when memory.high is in used. And memory.max is still the
> primary, works-out-of-the-box method of memory containment.

Thanks for clarification. I have to reset my false assumption.

Cheers,
Longman

