Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4187C7671
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442046AbjJLTLu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441905AbjJLTLu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 15:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185BAB7
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697137862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQUSlWXqP7fdJBvIHewmJ/XbyH4Qojk9VyW+H5X9CBk=;
        b=g80hw/d5qr3emEvUL5AgMLISrxJEYGBfoQr5ubYWXvZzkcI2IkfnFkfZ2niScLjGPvz9TV
        zefSUbcpml1SQ7neidn6Xw0QDEWdNO4fDP9oBi4FTFtz2XTI7RJjfYiRa9/6cFH0wdzwp4
        EMCjAziHM7kMMToUz/vbxiOvmvtCqXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-7FqDobdUP-y8uDiXMGdhmg-1; Thu, 12 Oct 2023 15:10:48 -0400
X-MC-Unique: 7FqDobdUP-y8uDiXMGdhmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40359381079F;
        Thu, 12 Oct 2023 19:10:48 +0000 (UTC)
Received: from [10.22.32.234] (unknown [10.22.32.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E73B202701E;
        Thu, 12 Oct 2023 19:10:47 +0000 (UTC)
Message-ID: <f7c9b6a6-3c60-431d-3f91-3dc9b012adc6@redhat.com>
Date:   Thu, 12 Oct 2023 15:10:46 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <11efaeb8-eac1-4a12-8283-6e9ce168e809@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/12/23 13:27, Joseph Salisbury wrote:
>
>
> On 9/28/23 04:39, Sebastian Andrzej Siewior wrote:
>> On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
>>> Hi All,
>> Hi,
>>
>>> I have a question regarding the isolcpus parameter.  I've been 
>>> seeing this
>>> parameter commonly used. However, in the kernel.org documentation[0],
>>> isolcpus is listed as depreciated.
>>>
>>> Is it the case that isolcpus should not be used at all?  I've seen 
>>> it used
>>> in conjunction with taskset.  However, should we now be telling rt 
>>> users to
>>> use only cpusets in cgroups?  I see that CPUAffinity can be set in
>>> /etc/systemd/system.conf.  Is that the preferred method, so the process
>>> scheduler will automatically migrate processes between the cpusets 
>>> in the
>>> cgroup cpuset or the list set by CPUAffinity?
>> Frederic might know if there is an actual timeline to remove it. The
>> suggestions since then is to use cpusets which should be more flexible.
>> There was also some work (which went into v6.1 I think) to be able to
>> reconfigure the partitions at run-time while isolcpus= is a boot time
>> option.
>>  From what I remember, you have a default/system cpuset which all tasks
>> use by default and then you can add another cpuset for the "isolated"
>> CPUs. Based on the partition it can be either the default one or
>> isolated [0]. The latter would exclude the CPUs from load balancing
>> which is what isolcpus= does.
>>
>> [0] f28e22441f353 ("cgroup/cpuset: Add a new isolated cpus.partition 
>> type")
>
> This question may be for the cgroups folks.  The kernel.org 
> documentation has a WARNING which states: "cgroup2 doesn't yet support 
> control of realtime processes and the cpu controller can only be 
> enabled when all RT processes are in the root cgroup "[0]. Does this 
> mean real-time processes are only supported on cgroupsV1?
>
> Also, this warning is stated for the "CPU" Controller, but there is no 
> mention of this for a "cpuset" controller. Does this imply that 
> real-time processes are supported with "cpuset" controllers?

Yes, the quoted description applies only to cpu controller. Even for v1 
cpu controller, the realtime support is problematic and there is no easy 
solution to that. That is why cgroup v2 doesn't support it.

For other controllers, whether the processes are RT or not are 
irrelevant. They are equally supported.

Cheers,
Longman


