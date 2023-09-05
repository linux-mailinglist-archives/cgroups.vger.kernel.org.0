Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED5792E35
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbjIETCO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbjIETCD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 15:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AE180
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693940387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0aAtKGZKY2TsC8NWxjXlesPhzcxWuJvtlmaEX2vDxs=;
        b=J66oMCG7L7rNsQyQIlX1UU9bP2yxneyDDQdjjMlAXDp3bGOa2r3sIIpHSVveSAaBBzL7Wn
        zM2CKPFUaGlsF2wetL2uLqaMyZ7i0H0Ja2zMuI6gMb9YYopvdd+kEVkhiiacB291UroP73
        fLlQdrCzf4g9rY8wjaMrjRHDmITBioE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-s5tbT2DAPQe3yptpBGAfnQ-1; Tue, 05 Sep 2023 14:59:44 -0400
X-MC-Unique: s5tbT2DAPQe3yptpBGAfnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A765928E61;
        Tue,  5 Sep 2023 18:59:44 +0000 (UTC)
Received: from [10.22.9.87] (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADFA9200A4B6;
        Tue,  5 Sep 2023 18:59:43 +0000 (UTC)
Message-ID: <af394f53-224d-baff-5c7d-87eff7fcaad2@redhat.com>
Date:   Tue, 5 Sep 2023 14:59:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATH] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lcapitulino@gmail.com
References: <20230831142046.37177-1-luizcap@amazon.com>
 <20230905170318.GA16629@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230905170318.GA16629@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/5/23 13:03, Luiz Capitulino wrote:
> On Thu, Aug 31, 2023 at 10:20:46AM -0400, Luiz Capitulino wrote:
>> We have a need of using favordynmods with cgroup v1, which doesn't support
>> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
>> build-time is not an option because we want to be able to selectively
>> enable it for certain systems.
>>
>> This commit addresses this by introducing the cgroup_favordynmods=
>> command-line option. This option works for both cgroup v1 and v2 and
>> also allows for disabling favorynmods when the kernel built with
>> CONFIG_FAVOR_DYNMODS=y.
>>
>> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> Hi,
>
> Would somebody take a look at this patch please?
>
> Thanks,
>
> - Luiz

The patch looks good to me. I do have a minor comment that it may be 
better to use the relatively new __ro_after_init qualifier instead of 
__read_mostly.

Cheers,
Longman

>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>   kernel/cgroup/cgroup.c                          | 14 +++++++++++---
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 0c38a8af95ce..672f76a3c002 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -580,6 +580,10 @@
>>   			named mounts. Specifying both "all" and "named" disables
>>   			all v1 hierarchies.
>>   
>> +	cgroup_favordynmods= [KNL] Enable or Disable favordynmods.
>> +			Format: { "true" | "false" }
>> +			Defaults to the value of CONFIG_CGROUP_FAVOR_DYNMODS.
>> +
>>   	cgroup.memory=	[KNL] Pass options to the cgroup memory controller.
>>   			Format: <string>
>>   			nosocket -- Disable socket memory accounting.
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 5fa95f86cb4d..b625825e270b 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
>>   static u16 have_release_callback __read_mostly;
>>   static u16 have_canfork_callback __read_mostly;
>>   
>> +static bool have_favordynmods __read_mostly = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
>> +
>>   /* cgroup namespace for init task */
>>   struct cgroup_namespace init_cgroup_ns = {
>>   	.ns.count	= REFCOUNT_INIT(2),
>> @@ -2265,9 +2267,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
>>   	fc->user_ns = get_user_ns(ctx->ns->user_ns);
>>   	fc->global = true;
>>   
>> -#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
>> -	ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>> -#endif
>> +	if (have_favordynmods)
>> +		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>> +
>>   	return 0;
>>   }
>>   
>> @@ -6767,6 +6769,12 @@ static int __init enable_cgroup_debug(char *str)
>>   }
>>   __setup("cgroup_debug", enable_cgroup_debug);
>>   
>> +static int __init cgroup_favordynmods_setup(char *str)
>> +{
>> +	return (kstrtobool(str, &have_favordynmods) == 0);
>> +}
>> +__setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
>> +
>>   /**
>>    * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
>>    * @dentry: directory dentry of interest
>> -- 
>> 2.40.1
>>

