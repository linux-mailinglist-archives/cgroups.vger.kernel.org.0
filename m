Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B327C76A3
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379700AbjJLTXZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442125AbjJLTXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 15:23:22 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1DFC;
        Thu, 12 Oct 2023 12:23:17 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3656C3F6C3;
        Thu, 12 Oct 2023 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697138593;
        bh=20vMW8rXM/m+fods5+JgqlCOx1Ds3mHKLfQHeyOZVXE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MHh+nwGwBCZvPqrUJpwWZHVLOTXlxWkZ/xyXiRvIHzjjdcrFdkVG4jeiUyMbJAuOL
         VmvjPT6MWCdjedo6fBAQPq5HeS8jMScwIJxNahjoIvrfnrK+brBHzUT9qUBYetDhQd
         gCescUCDJNSk0wkrbw5wswD5BeXpY1GDYAkfVpDJ4h8Gw4GdZNDiHKqaFB7eWOJqC/
         EcW/uiiq27Rf145fKW2rzzNPOUqufrl749OkDjWkxrfyqMjhPKCno4VjeSxn9PNVeF
         3lerhZeFDT6PZLm4eLtkVFSfcxF0qjrxJiR5VQuz/ZTKBOiqtK1hmNm7pG0Av4UP5G
         ppDpUGnKnY/Yg==
Message-ID: <f3604bef-6834-4b69-8708-7d3f6727a873@canonical.com>
Date:   Thu, 12 Oct 2023 15:23:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question Regarding isolcpus
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, cgroups@vger.kernel.org
References: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
 <20230928083909.KySJvo1d@linutronix.de>
 <11efaeb8-eac1-4a12-8283-6e9ce168e809@canonical.com>
 <f7c9b6a6-3c60-431d-3f91-3dc9b012adc6@redhat.com>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Autocrypt: addr=joseph.salisbury@canonical.com; keydata=
 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
 p24lPxLL08SuCEzuBw==
In-Reply-To: <f7c9b6a6-3c60-431d-3f91-3dc9b012adc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 10/12/23 15:10, Waiman Long wrote:
> On 10/12/23 13:27, Joseph Salisbury wrote:
>>
>>
>> On 9/28/23 04:39, Sebastian Andrzej Siewior wrote:
>>> On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
>>>> Hi All,
>>> Hi,
>>>
>>>> I have a question regarding the isolcpus parameter.  I've been 
>>>> seeing this
>>>> parameter commonly used. However, in the kernel.org documentation[0],
>>>> isolcpus is listed as depreciated.
>>>>
>>>> Is it the case that isolcpus should not be used at all? I've seen 
>>>> it used
>>>> in conjunction with taskset.  However, should we now be telling rt 
>>>> users to
>>>> use only cpusets in cgroups?  I see that CPUAffinity can be set in
>>>> /etc/systemd/system.conf.  Is that the preferred method, so the 
>>>> process
>>>> scheduler will automatically migrate processes between the cpusets 
>>>> in the
>>>> cgroup cpuset or the list set by CPUAffinity?
>>> Frederic might know if there is an actual timeline to remove it. The
>>> suggestions since then is to use cpusets which should be more flexible.
>>> There was also some work (which went into v6.1 I think) to be able to
>>> reconfigure the partitions at run-time while isolcpus= is a boot time
>>> option.
>>>  From what I remember, you have a default/system cpuset which all tasks
>>> use by default and then you can add another cpuset for the "isolated"
>>> CPUs. Based on the partition it can be either the default one or
>>> isolated [0]. The latter would exclude the CPUs from load balancing
>>> which is what isolcpus= does.
>>>
>>> [0] f28e22441f353 ("cgroup/cpuset: Add a new isolated cpus.partition 
>>> type")
>>
>> This question may be for the cgroups folks.  The kernel.org 
>> documentation has a WARNING which states: "cgroup2 doesn't yet 
>> support control of realtime processes and the cpu controller can only 
>> be enabled when all RT processes are in the root cgroup "[0]. Does 
>> this mean real-time processes are only supported on cgroupsV1?
>>
>> Also, this warning is stated for the "CPU" Controller, but there is 
>> no mention of this for a "cpuset" controller. Does this imply that 
>> real-time processes are supported with "cpuset" controllers?
>
> Yes, the quoted description applies only to cpu controller. Even for 
> v1 cpu controller, the realtime support is problematic and there is no 
> easy solution to that. That is why cgroup v2 doesn't support it.
>
> For other controllers, whether the processes are RT or not are 
> irrelevant. They are equally supported.
>
> Cheers,
> Longman
Thanks for the feedback, Longman!

>
>

