Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7C792E94
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbjIETNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjIETNh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 15:13:37 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDD10F9;
        Tue,  5 Sep 2023 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693941187; x=1725477187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RtGZX3EuEn1Pqxl6Ng+QSA/c3MIgDkLWa0RmqqyIoTI=;
  b=CoNWbBzeRKx9lsKJheo8qwgKMbPudtX5CQxyJrJU/rky4uBtLVpmWKbw
   tG8MnMkj0nQg11+f5jmgzlXZienZfe83B7mxaVoiY8rH6V/K6p4NRQRM3
   9SxdWCWEytQP+MG7pszCnBJPKwCTr2W/glYH5ktkKfo37t/x+7lVvnupy
   8=;
X-IronPort-AV: E=Sophos;i="6.02,229,1688428800"; 
   d="scan'208";a="152726376"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:09:58 +0000
Received: from EX19MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id 723FA40DA9;
        Tue,  5 Sep 2023 19:09:56 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 5 Sep 2023 19:09:55 +0000
Received: from [192.168.196.178] (10.106.239.8) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 5 Sep 2023 19:09:53 +0000
Message-ID: <db22fc20-c6df-50a7-f4ae-582ced24835c@amazon.com>
Date:   Tue, 5 Sep 2023 15:09:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATH] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lcapitulino@gmail.com>
References: <20230831142046.37177-1-luizcap@amazon.com>
 <20230905170318.GA16629@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
 <af394f53-224d-baff-5c7d-87eff7fcaad2@redhat.com>
 <664019c3-c4b1-6603-7a3d-f44a81737178@redhat.com>
 <7ae52eec-0df3-9bef-e4f6-e33a1873c464@redhat.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <7ae52eec-0df3-9bef-e4f6-e33a1873c464@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.239.8]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023-09-05 15:06, Waiman Long wrote:

> 
> 
> 
> On 9/5/23 15:03, Waiman Long wrote:
>>
>> On 9/5/23 14:59, Waiman Long wrote:
>>>
>>> On 9/5/23 13:03, Luiz Capitulino wrote:
>>>> On Thu, Aug 31, 2023 at 10:20:46AM -0400, Luiz Capitulino wrote:
>>>>> We have a need of using favordynmods with cgroup v1, which doesn't
>>>>> support
>>>>> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
>>>>> build-time is not an option because we want to be able to selectively
>>>>> enable it for certain systems.
>>>>>
>>>>> This commit addresses this by introducing the cgroup_favordynmods=
>>>>> command-line option. This option works for both cgroup v1 and v2 and
>>>>> also allows for disabling favorynmods when the kernel built with
>>>>> CONFIG_FAVOR_DYNMODS=y.
>>>>>
>>>>> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
>>>> Hi,
>>>>
>>>> Would somebody take a look at this patch please?
>>>>
>>>> Thanks,
>>>>
>>>> - Luiz
>>>
>>> The patch looks good to me. I do have a minor comment that it may be
>>> better to use the relatively new __ro_after_init qualifier instead of
>>> __read_mostly.

Will do the change and post v2 shortly.

>>>
>> With this patch, CGROUP_FAVOR_DYNMODS kconfig option will have no
>> user. So this config option should be removed as well.
> 
> My bad. That is not true. Please ignore this comment.

OK, big thanks for taking a look so quickly!

- Luiz

> 
> Regards,
> Longman
> 
