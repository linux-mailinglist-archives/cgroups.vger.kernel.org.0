Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D17C8CCC
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjJMSIr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJMSIr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 14:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CDDE
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697220481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxD3yLMaugMz9laL1n30S34EuHC+wt57e2tE4WPzG4Y=;
        b=RPRnR0xI9H2Kouw4FDSjLBae2cQYoDsEPLaZxUkBfIXe0WqFktC1BgozglrrI25ya8dR23
        nUKRRMogEcXTNb43kyLdUUW2u8DV9THwBsvg3DdD+WSWbxM6k9YUFjBl9CZkKCBaHXweZk
        6u0iSpw1LsQ1tClnhMZW06gTasylv3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-LaywYfrTMtOfvvDJh-Eetg-1; Fri, 13 Oct 2023 14:07:56 -0400
X-MC-Unique: LaywYfrTMtOfvvDJh-Eetg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0096B3C0DDA6;
        Fri, 13 Oct 2023 18:07:56 +0000 (UTC)
Received: from [10.22.17.138] (unknown [10.22.17.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55F911301CF;
        Fri, 13 Oct 2023 18:07:55 +0000 (UTC)
Message-ID: <38a0078f-c9f7-47cd-686c-025b0fa09c88@redhat.com>
Date:   Fri, 13 Oct 2023 14:07:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Question Regarding isolcpus
Content-Language: en-US
To:     Joseph Salisbury <joseph.salisbury@canonical.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, cgroups@vger.kernel.org
References: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
 <20230928083909.KySJvo1d@linutronix.de>
 <11efaeb8-eac1-4a12-8283-6e9ce168e809@canonical.com>
 <f7c9b6a6-3c60-431d-3f91-3dc9b012adc6@redhat.com>
 <f3604bef-6834-4b69-8708-7d3f6727a873@canonical.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <f3604bef-6834-4b69-8708-7d3f6727a873@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/12/23 15:23, Joseph Salisbury wrote:
>
>
> On 10/12/23 15:10, Waiman Long wrote:
>> On 10/12/23 13:27, Joseph Salisbury wrote:
>>>
>>>
>>> On 9/28/23 04:39, Sebastian Andrzej Siewior wrote:
>>>> On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
>>>>> Hi All,
>>>> Hi,
>>>>
>>>>> I have a question regarding the isolcpus parameter.  I've been 
>>>>> seeing this
>>>>> parameter commonly used. However, in the kernel.org documentation[0],
>>>>> isolcpus is listed as depreciated.
>>>>>
>>>>> Is it the case that isolcpus should not be used at all? I've seen 
>>>>> it used
>>>>> in conjunction with taskset.  However, should we now be telling rt 
>>>>> users to
>>>>> use only cpusets in cgroups?  I see that CPUAffinity can be set in
>>>>> /etc/systemd/system.conf.  Is that the preferred method, so the 
>>>>> process
>>>>> scheduler will automatically migrate processes between the cpusets 
>>>>> in the
>>>>> cgroup cpuset or the list set by CPUAffinity?
>>>> Frederic might know if there is an actual timeline to remove it. The
>>>> suggestions since then is to use cpusets which should be more 
>>>> flexible.
>>>> There was also some work (which went into v6.1 I think) to be able to
>>>> reconfigure the partitions at run-time while isolcpus= is a boot time
>>>> option.
>>>>  From what I remember, you have a default/system cpuset which all 
>>>> tasks
>>>> use by default and then you can add another cpuset for the "isolated"
>>>> CPUs. Based on the partition it can be either the default one or
>>>> isolated [0]. The latter would exclude the CPUs from load balancing
>>>> which is what isolcpus= does.
>>>>
>>>> [0] f28e22441f353 ("cgroup/cpuset: Add a new isolated 
>>>> cpus.partition type")
>>>
>>> This question may be for the cgroups folks.  The kernel.org 
>>> documentation has a WARNING which states: "cgroup2 doesn't yet 
>>> support control of realtime processes and the cpu controller can 
>>> only be enabled when all RT processes are in the root cgroup "[0]. 
>>> Does this mean real-time processes are only supported on cgroupsV1?
>>>
>>> Also, this warning is stated for the "CPU" Controller, but there is 
>>> no mention of this for a "cpuset" controller. Does this imply that 
>>> real-time processes are supported with "cpuset" controllers?
>>
>> Yes, the quoted description applies only to cpu controller. Even for 
>> v1 cpu controller, the realtime support is problematic and there is 
>> no easy solution to that. That is why cgroup v2 doesn't support it.
>>
>> For other controllers, whether the processes are RT or not are 
>> irrelevant. They are equally supported.
>>
>> Cheers,
>> Longman
> Thanks for the feedback, Longman!
>
One further tidbit is the fact that the deadline scheduling policy can 
be used as a replacement of using cgroup v1 cpu controller RT knobs to 
place a limit one how many RT tasks can run on a CPU.

Cheers,
Longman

