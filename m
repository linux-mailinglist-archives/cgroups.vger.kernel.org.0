Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85DA681AF4
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjA3T6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 14:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjA3T6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 14:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA59E39D
        for <cgroups@vger.kernel.org>; Mon, 30 Jan 2023 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675108680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFzo0SjIoUeHUUad6uKtgnkYXlNez2WsK0EUt/zmXC8=;
        b=WybJXil4nSn6GsnU0D610wbRMxK21qVCP3CqvKOH8xWN+5EtTVwY/IcVZFRZlGnTsnuF9g
        wG9fMiB6sZXOdp0VnIbOSJLmj7uECrOO9MTnbOLZPkPT4rYey35PYUIRCmN58q15n4UQmP
        oPpVBMR/Ng2B5+eH78ebNfXRY6TGWug=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-2z3evavvMD6QWxQ7aQ4Wsg-1; Mon, 30 Jan 2023 14:57:57 -0500
X-MC-Unique: 2z3evavvMD6QWxQ7aQ4Wsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D00B93C025D3;
        Mon, 30 Jan 2023 19:57:56 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE984140EBF5;
        Mon, 30 Jan 2023 19:57:55 +0000 (UTC)
Message-ID: <17537d7f-8734-2186-b27c-f39f3110ffe5@redhat.com>
Date:   Mon, 30 Jan 2023 14:57:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
 <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
 <20230130130038.2qx3pkzut6ypqdub@airbuntu>
 <253ced33-c3a8-269f-90cc-b69e66b10370@redhat.com>
 <20230130194826.rxwk4ryvpyxemflm@airbuntu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230130194826.rxwk4ryvpyxemflm@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/30/23 14:48, Qais Yousef wrote:
> On 01/30/23 11:29, Waiman Long wrote:
>> On 1/30/23 08:00, Qais Yousef wrote:
>>
>>          just skip the call here if the condition is right? Like
>>
>>                  /* rebuild sched domains if cpus_allowed has changed */
>>                  if (cpus_updated || (force_rebuild && !cpuhp_tasks_frozen)) {
>>                          force_rebuild = false;
>>                          rebuild_sched_domains();
>>                  }
>>
>>          Still, we will need to confirm that cpuhp_tasks_frozen will be cleared
>>          outside of the suspend/resume cycle.
>>
>>      I think it's fine to use this variable from the cpuhp callback context only.
>>      Which I think this cpuset workfn is considered an extension of.
>>
>>      But you're right, I can't use cpuhp_tasks_frozen directly in
>>      rebuild_root_domains() as I did in v1 because it doesn't get cleared after
>>      calling the last _cpu_up().
>>
>> That is what I suspect. So we can't use that cpuhp_tasks_frozen variable here
>> in cpuset.
>>
>>       force_rebuild will only be set after the last cpu
>>      is brought online though - so this should happen once at the end.
>>
>> Perhaps you can add another tracking variable for detecting if suspend/resume
>> is in progress.
> I think cpuhp_tasks_frozen is meant for that. All users who cared so far
> belonged to the cpuhp callback. I think reading it from cpuset_hotplug_workfn()
> is fine too as this function will only run as a consequence of the cpuhp
> callback AFAICS. cpuset_cpu_active() takes care of not forcing a rebuild of
> sched_domains until the last cpu becomes active - so the part of it being done
> once at the end at resume is handled too.

Well we will have to add code to clear cpuhp_tasks_frozen at the end of 
resume then. We don't want to affect other callers unless we are sure 
that it won't affect them.

>
> It's just rebuild_sched_domains() will always assume it needs to clear and
> rebuild deadline accounting - which is not true for suspend/resume case. But
> now looking at other users of rebuild_sched_domains(), others might be getting
> the hit too. For example rebuild_sched_domains_locked() is called on
> update_relax_domain_level() which AFAIU should not impact dl accounting.
>
> FWIW, I did capture a worst case scenario of 21ms because of
> rebuild_root_domains().
>
> /me thinks rebuild_root_domains() is a misleading name too as it just fixes
> dl accounting but not rebuild the rd itself.
>
> What makes sense to me now is to pass whether dl accounting requires updating
> to rebuild_sched_domains() as an arg so that the caller can decide whether the
> reason can affect dl accounting.
>
> Or maybe pull rebuild_root_domains() out of the chain and let the caller call
> it directly. And probably rename it to update_do_rd_accounting() or something.
>
> I'll continue to dig more..

Looking forward to see that.

Cheers,
Longman

