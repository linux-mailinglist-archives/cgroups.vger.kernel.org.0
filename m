Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16F6883AC
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 17:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjBBQHq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 11:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBBQHq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 11:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A2DD
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675354020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7phcfiE83fVwz5I8bWRnbFjaiLhRCsY0h7b3g24mK8=;
        b=AW496yp2glKYX90OUYaHtuuGXVy+pO2vCOPu3U/eqrxBJb/1aifyPa4E2eT6Nsibj/wGAA
        TWO9tljCuFdD+8dgGMhVlf47CHsWUTZPvqhiTGEDGcYLqJqqnpxCw64sCDaG8pYDG3ukbP
        mniapK6/BXwr1Ak/skk4rJvzLu22WuU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-_-kt1zdcP-2gghTR1sSrxA-1; Thu, 02 Feb 2023 11:06:56 -0500
X-MC-Unique: _-kt1zdcP-2gghTR1sSrxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9945938288A7;
        Thu,  2 Feb 2023 16:06:52 +0000 (UTC)
Received: from [10.22.8.157] (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6C1E140EBF6;
        Thu,  2 Feb 2023 16:06:51 +0000 (UTC)
Message-ID: <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
Date:   Thu, 2 Feb 2023 11:06:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/23 03:34, Peter Zijlstra wrote:
> On Tue, Jan 31, 2023 at 11:14:27PM -0500, Waiman Long wrote:
>
>> A major concern I have is the overhead of creating a poor man version of v2
>> cpus_allowed. This issue can be worked around even for cpuset v1 if it is
>> mounted with the cpuset_v2_mode option to behave more like v2 in its cpumask
>> handling. Alternatively we may be able to provide a config option to make
>> this the default for v1 without the special mount option, if necessary.
> It is equally broken for v2, it masks against effective_cpus. Not to
> mention it explicitly starts with cpu_online_mask.

After taking a close look at the patch, my understanding of what it is 
doing is as follows:

v2: cpus_allowed will not be affected by hotplug. So the new 
cpuset_cpus_allowed() will return effective_cpus + offline cpus that 
should have been part of effective_cpus if online before masking it with 
allowable cpus and then go up the cpuset hierarchy if necessary.

v1: cpus_allowed is equivalent to v2 effective_cpus. It starts at the 
current cpuset and move up the hierarchy if necessary to find a cpuset 
that have at least one allowable cpu.

First of all, it does not take into account of the v2 partition feature 
that may cause it to produce incorrect result if partition is enabled 
somewhere. Secondly, I don't see any benefit other than having some 
additional offline cpu available in a task's cpumask which the scheduler 
will ignore anyway. v2 is able to recover a previously offlined cpu. So 
we don't gain any net benefit other than the going up the cpuset 
hierarchy part.

For v1, I agree we should go up the cpuset hierarchy to find a usable 
cpuset. Instead of introducing such a complexity in 
cpuset_cpus_allowed(), my current preference is to do the hierarchy 
climbing part in an enhanced cpuset_cpus_allowed_fallback() after an 
initial failure of cpuset_cpus_allowed(). That will be easier to 
understand than having such complexity and overhead in 
cpuset_cpus_allowed() alone.

I will work on a patchset to do that as a counter offer.

Cheers,
Longman



