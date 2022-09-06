Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE25AF588
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIFUKU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 16:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIFUJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 16:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444047269E
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662494664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kt6CEFAueWK0HKI9UIQ8H4IFzaooggSyLPO1T4AFfQ=;
        b=KYKiBqwfhlhgPozOCwwmDmEmsG8sigl1tT631aw7FrY4WBxTDLXULvOqi3nVKALCMm6Hp8
        iLodO8aSeFblUqZ07v+BjWG63nf942rRWyI5zKNAYZnMEnX6vAG1VR7gRYiRNzHjorm7gs
        0IQCuOwOqWRoxS5JMUtt3JysOBCGnNU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-95P6QindO7OjDY5gAuEzBA-1; Tue, 06 Sep 2022 16:01:12 -0400
X-MC-Unique: 95P6QindO7OjDY5gAuEzBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA503C138A2;
        Tue,  6 Sep 2022 20:01:07 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA191121315;
        Tue,  6 Sep 2022 20:01:06 +0000 (UTC)
Message-ID: <02b8e7b3-941d-8bb9-cd0e-992738893ba3@redhat.com>
Date:   Tue, 6 Sep 2022 16:01:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, lixiong.liu@mediatek.com,
        wenju.xu@mediatek.com
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
 <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
 <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
 <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/6/22 14:30, Tejun Heo wrote:
> Hello,
>
> (cc'ing Waiman in case he has a better idea)
>
> On Mon, Sep 05, 2022 at 04:22:29PM +0800, Jing-Ting Wu wrote:
>> https://lore.kernel.org/lkml/YvrWaml3F+x9Dk+T@slm.duckdns.org/ is for
>> fix cgroup_threadgroup_rwsem <-> cpus_read_lock() deadlock.
>> But this issue is cgroup_threadgroup_rwsem <-> cpuset_rwsem deadlock.
> If I'm understanding what you're writing correctly, this isn't a deadlock.
> The cpuset_hotplug_workfn simply isn't being woken up while holding
> cpuset_rwsem and others are just waiting for that lock to be released.

I believe it is probably a bug in the scheduler core code. 
__set_cpus_allowed_ptr_locked() calls affine_move_task() to move to a 
random cpu within the new set allowable CPUs. However, if migration is 
disabled, it shouldn't call affine_move_task() at all. Instead, I would 
suggest that if the current cpu is within the new allowable cpus, it 
should just skip doing affine_move_task(). Otherwise, it should fail 
__set_cpus_allowed_ptr_locked().

My 2 cents.

Cheers,
Longman

