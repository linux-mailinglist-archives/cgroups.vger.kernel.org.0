Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942365AEF4C
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIFPtM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiIFPrw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 11:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCECDA61FC
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662476278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYOnT3WdHbcwCr8H+t7+tWjbf0atY1c9YvOA6+hgbSo=;
        b=LVKSSiJlyHNN/2zIbGrZ2LITUa1Va8rEsUyp4396hucy9peNT3sPAJDyLsrD4L//erBtKY
        QG2rxjmwn9N9CNHNCQepe6cH9fmh2uPalyUCASj10+GRLvofuoXw/9PkJdnC8K/aPa8qQq
        DSkGD4J1v9hfwDqDD18L4OxQ4uORKwY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-_IgzUhngPAiRRZqjq7yHDw-1; Tue, 06 Sep 2022 10:57:54 -0400
X-MC-Unique: _IgzUhngPAiRRZqjq7yHDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8C1B1C0BDEA;
        Tue,  6 Sep 2022 14:57:53 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120181410F3C;
        Tue,  6 Sep 2022 14:57:52 +0000 (UTC)
Message-ID: <323f6375-0e1b-8326-2c74-b7a4db4693a1@redhat.com>
Date:   Tue, 6 Sep 2022 10:57:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v12 09/10] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220901205745.323326-1-longman@redhat.com>
 <20220901205745.323326-10-longman@redhat.com> <YxRfy/SaKkJSm5jY@debian.me>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YxRfy/SaKkJSm5jY@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/4/22 04:20, Bagas Sanjaya wrote:
> On Thu, Sep 01, 2022 at 04:57:44PM -0400, Waiman Long wrote:
>>   	It accepts only the following input values when written to.
>>   
>>   	  ========	================================
>> -	  "root"	a partition root
>> -	  "member"	a non-root member of a partition
>> +	  "member"	Non-root member of a partition
>> +	  "root"	Partition root
>> +	  "isolated"	Partition root without load balancing
>>   	  ========	================================
>>   
>> <snipped>
>> +	On read, the "cpuset.cpus.partition" file can show the following
>> +	values.
>> +
>> +	  ======================	==============================
>> +	  "member"			Non-root member of a partition
>> +	  "root"			Partition root
>> +	  "isolated"			Partition root without load balancing
>> +	  "root invalid (<reason>)"	Invalid partition root
>> +	  "isolated invalid (<reason>)"	Invalid isolated partition root
>> +	  ======================	==============================
>> +
> These tables above produced htmldocs warnings:
>
> Documentation/admin-guide/cgroup-v2.rst:2191: WARNING: Malformed table.
> Text in column margin in table line 4.
>
> ========      ================================
> "member"      Non-root member of a partition
> "root"        Partition root
> "isolated"    Partition root without load balancing
> ========      ================================
> Documentation/admin-guide/cgroup-v2.rst:2229: WARNING: Malformed table.
> Text in column margin in table line 5.
>
> ======================        ==============================
> "member"                      Non-root member of a partition
> "root"                        Partition root
> "isolated"                    Partition root without load balancing
> "root invalid (<reason>)"     Invalid partition root
> "isolated invalid (<reason>)" Invalid isolated partition root
> ======================        ==============================
>
> I have applied the fixup:
>
> ---- >8 ----
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 76b3ea9fd5c560..77b6faecf066cb 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2185,11 +2185,11 @@ Cpuset Interface Files
>   
>   	It accepts only the following input values when written to.
>   
> -	  ========	================================
> +	  ==========	================================
>   	  "member"	Non-root member of a partition
>   	  "root"	Partition root
>   	  "isolated"	Partition root without load balancing
> -	  ========	================================
> +	  ==========	================================
>   
>   	The root cgroup is always a partition root and its state
>   	cannot be changed.  All other non-root cgroups start out as
> @@ -2222,13 +2222,13 @@ Cpuset Interface Files
>   	On read, the "cpuset.cpus.partition" file can show the following
>   	values.
>   
> -	  ======================	==============================
> +	  =============================	=====================================
>   	  "member"			Non-root member of a partition
>   	  "root"			Partition root
>   	  "isolated"			Partition root without load balancing
>   	  "root invalid (<reason>)"	Invalid partition root
>   	  "isolated invalid (<reason>)"	Invalid isolated partition root
> -	  ======================	==============================
> +	  =============================	=====================================
>   
>   	In the case of an invalid partition root, a descriptive string on
>   	why the partition is invalid is included within parentheses.
>
> Thanks.

Thanks for the fixes. Will apply that.

Cheers,
Longman

