Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E315A593D
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 04:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH3CTb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3CTb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 22:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02019DF88
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661825966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acxiXerhGK/mk1WIiLY7l7lFOnLhh2aPqN8iFAXUUqg=;
        b=ICmSuLKJXCyiXF+TNE5ioSfGe33YVOIiwzRSKQIdTlRYDyQ+5cUjLe+PIrpNjfq1lry4bR
        Cl9n3sU1KERUrBHhJ7Nd8VGZQwywGrC/acoAPbpX73saveVP3v1GLLa7IwccbrsNkNlubl
        bJ1+YumcEVdry65LB6EycExrqQV7R2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-fVPrXc5kO36qO1qH2zcptw-1; Mon, 29 Aug 2022 22:19:25 -0400
X-MC-Unique: fVPrXc5kO36qO1qH2zcptw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCC421C0514B;
        Tue, 30 Aug 2022 02:19:24 +0000 (UTC)
Received: from [10.22.8.171] (unknown [10.22.8.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90F281410F37;
        Tue, 30 Aug 2022 02:19:24 +0000 (UTC)
Message-ID: <23924a85-1ddc-64c7-68c7-2dbd53eea4ee@redhat.com>
Date:   Mon, 29 Aug 2022 22:19:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: cgroups v2 cpuset partition bug
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     =?UTF-8?B?TWF4aW0g4oCcTUFYUEFJTuKAnSBNYWthcm92?= 
        <maxpain177@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
References: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
 <YwT/BNqIdCEyUpFR@slm.duckdns.org>
 <ef183fe9-8458-8a7f-2b8e-1c38666b6399@redhat.com>
 <26A2A485-B70C-4361-8368-1A0081570E7C@gmail.com>
 <961450c4-6b32-63ba-ff81-2f6184032de9@redhat.com>
In-Reply-To: <961450c4-6b32-63ba-ff81-2f6184032de9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/29/22 13:48, Waiman Long wrote:
>
> On 8/29/22 13:16, Maxim “MAXPAIN” Makarov wrote:
>> Hi. I used top and htop programs to check what CPU is using, and it's 
>> showing that this task is running on CPU 2, so I think it shows the 
>> correct CPU that is currently being used.
>> Please note that the containerd process has /system/runtime cgroup, 
>> which inherits cpuset from the root cgroup. /system/runtime cgroup 
>> doesn't have any cpuset settings. Maybe this is the reason?
> Oh, that could be the reason. Yes, it is probably a bug that other 
> sibling cgroups should also be updated. I will look into that.
>>
>> I tried to remove the lowlatency group with 
>> cpuset.cpus.partition=root and do taskset -cp 4 1079 manually, and it 
>> works without any restart.
>>
>> I updated my post on StackExchange and added some new screenshots, so 
>> please check it out.

I tried to reproduce it but couldn't so far. Would you mind telling me 
what kernel version are you using to show this bug? BTW, how do you make 
htop show the CPU number, the CPU number isn't there by default.  What 
htop version are you using?

Thanks,
Longman

