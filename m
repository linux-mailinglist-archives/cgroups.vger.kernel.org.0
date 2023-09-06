Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1682C793D47
	for <lists+cgroups@lfdr.de>; Wed,  6 Sep 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjIFNAE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Sep 2023 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjIFNAD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Sep 2023 09:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89E10E2
        for <cgroups@vger.kernel.org>; Wed,  6 Sep 2023 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694005155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgZ9wSbbXHdI9NbJUdhnyHFT9UmT0O3FFw+d3lc9Q3A=;
        b=hH4PjjNp3VQMGrTDckbJI2zA5Mbj5MPdrulIQ3Svava/Eripc+JukRRuSrzHhsiuDKf8l6
        Z9xfoxQj1VgBXRGIiciJSnCe235hlg5v/xLjz1fZmtwGe/TbcDKDXVggba83uxudV1n1zK
        WAq1npmbZZi8nHxHR8LM2k29CydREh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-1ZQCz8nIOM-SugWY1qynrQ-1; Wed, 06 Sep 2023 08:59:12 -0400
X-MC-Unique: 1ZQCz8nIOM-SugWY1qynrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9860010264F3;
        Wed,  6 Sep 2023 12:59:11 +0000 (UTC)
Received: from [10.22.32.253] (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4EB25CC01;
        Wed,  6 Sep 2023 12:59:10 +0000 (UTC)
Message-ID: <ac50c7a3-c2af-26c1-cdd3-0add6b299994@redhat.com>
Date:   Wed, 6 Sep 2023 08:59:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lcapitulino@gmail.com
References: <20230906005712.66461-1-luizcap@amazon.com>
 <5487ed0a-8483-0a92-c7c1-9ca3ed8e6162@oracle.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <5487ed0a-8483-0a92-c7c1-9ca3ed8e6162@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/6/23 02:58, Kamalesh Babulal wrote:
> On 9/6/23 06:27, Luiz Capitulino wrote:
> [...]
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 1fb7f562289d..2b7d74304606 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
>>   static u16 have_release_callback __read_mostly;
>>   static u16 have_canfork_callback __read_mostly;
>>   
>> +static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
>> +
>>   /* cgroup namespace for init task */
>>   struct cgroup_namespace init_cgroup_ns = {
>>   	.ns.count	= REFCOUNT_INIT(2),
>> @@ -2243,9 +2245,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
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
>> @@ -6764,6 +6766,12 @@ static int __init enable_cgroup_debug(char *str)
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
> Consider a case where the kernel is compiled with
> CONFIG_CGROUP_FAVOR_DYNMODS=n and kernel command line is passed with
> cgroup_favordynmods=true, this would set the have_favordynmods to true.
> In cgroup_favordynmods_setup(), should it return 0 with a pr_warn(),
> when CONFIG_CGROUP_FAVOR_DYNMODS=n in the above case, or is this
> expected behavior?

According to the documentation of __setup:

/*
  * NOTE: __setup functions return values:
  * @fn returns 1 (or non-zero) if the option argument is "handled"
  * and returns 0 if the option argument is "not handled".
  */

So the return value should tell whether the input parameter is a 
recognizable true or false value, not whether it is true or false. 
kstrtobool returns 0 if it is a recognizable T/F value or -EINVAL 
otherwise. So the check is correct. I did double check that before I 
ack'ed the patch.

Cheers,
Longman

