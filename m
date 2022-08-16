Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948059653B
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiHPWLM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiHPWLK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 18:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398B474DA
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660687868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K219zFXEgyRo40dCsRP0DxF0BwKck2dNw2HkaSxa61Y=;
        b=YOwnwUsWH8chTMbCLhEv623pf4Va9tUrG9oe4Jb4XKlHiF2jW0/eR0Pds2pz7bzG3WGmLa
        SNkaocLHEhyZulg0xC3gUmoH7CPQVDbC3FcAzaZUPBC2Ji67FlT0sAUXkeIy/AgFw89mQi
        lzMuUrIQfD/dOkX6rwKMFNFJhs7gbys=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-QGgImqF0P82MT71U89AKng-1; Tue, 16 Aug 2022 18:11:05 -0400
X-MC-Unique: QGgImqF0P82MT71U89AKng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E714329ABA39;
        Tue, 16 Aug 2022 22:11:04 +0000 (UTC)
Received: from [10.22.16.150] (unknown [10.22.16.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5BD2026D4C;
        Tue, 16 Aug 2022 22:11:03 +0000 (UTC)
Message-ID: <c10e4f69-9951-6c38-6e28-fafcaec00d89@redhat.com>
Date:   Tue, 16 Aug 2022 18:11:03 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yvv66EWygCwHUCqy@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/16/22 16:15, Tejun Heo wrote:
> On Tue, Aug 16, 2022 at 03:27:34PM -0400, Waiman Long wrote:
>> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
>> +				       const struct cpumask *mask)
>> +{
>> +	cpumask_var_t new_mask;
>> +	int ret;
>> +
>> +	if (!READ_ONCE(p->user_cpus_ptr)) {
>> +		ret = set_cpus_allowed_ptr(p, mask);
>> +		/*
>> +		 * If user_cpus_ptr becomes set now, we are racing with
>> +		 * a concurrent sched_setaffinity(). So use the newly
>> +		 * set user_cpus_ptr and retry again.
>> +		 *
>> +		 * TODO: We cannot detect change in the cpumask pointed to
>> +		 * by user_cpus_ptr. We will have to add a sequence number
>> +		 * if such a race needs to be addressed.
>> +		 */
> This is too ugly and obviously broken. Let's please do it properly.

Actually, there is similar construct in __sched_setaffinity():

again:
         retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
         if (retval)
                 goto out_free_new_mask;

         cpuset_cpus_allowed(p, cpus_allowed);
         if (!cpumask_subset(new_mask, cpus_allowed)) {
                 /*
                  * We must have raced with a concurrent cpuset update.
                  * Just reset the cpumask to the cpuset's cpus_allowed.
                  */
                 cpumask_copy(new_mask, cpus_allowed);
                 goto again;
         }

It is hard to synchronize different subsystems atomically without 
running into locking issue. Let me think about what can be done in this 
case.

Is using a sequence number to check for race with retry good enough?

Cheers,
Longman

