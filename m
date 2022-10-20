Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6066605EE9
	for <lists+cgroups@lfdr.de>; Thu, 20 Oct 2022 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJTLdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Oct 2022 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJTLd2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Oct 2022 07:33:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB41DB8B1;
        Thu, 20 Oct 2022 04:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ohulQ/QL63kmcehOlCVV2NLx28Z6mXNKWaarEBoryXkV+/pI0dGpMwgtdOlQL+H4Y3jIIV4b5lBSTKNzzph1wQ234KEw572by120mD4FQVph3VtvM/pCf/DLsNGqe6TH3JPkUOLWm3p2I/m5G3fgADbmU+Gwci08otohwzm/b5hcRgYXbQXPdhJQDC1q9a1/abvb+IqLHmzul0AtNeiRpAx6tVZ9/1QhJhb6xIVW4wCBIAkV6PYwVBcfCJwtrl4anzhLbrx3IIo0FrZXAXPVH4O4LlUzphwfcPTXS+y95F8B+OisbaLHPnKe8divazir62LGZIT7t6K+fRsym8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsAXf2H/ureaPRL6U2JgyBys57SQ9K7/6XL+NC9ya3U=;
 b=OR30UMMf/TC+s5U8fpESoAIjhaNa42bgFm7UcR2vuDQJ5mqT52FH4IAOTg1Ej4FC69vXTHHtiDF5OEQ5iWPPbhDh1tfqXDc705avfgV71vMort0ct4m3w/qGRWqa+RbhLauayp4VuIQa3MhEG9QKrSWLUs/2ORfh8CqaR6/vWSLn013b/iECUe0AFZ+X9zAdpMBRFdXMc9bCfBtn+xe4NS/l+z5eqkhvB8rU76t3tqa1at+Nd3D8NQYuwXicyowKuTpEFSLZbW7J4yAslxIFtIh9bcHqVkEazivOA5laCtCV5w0e6X71byWuOY+i7dTjsLSH8oiyGYlUyu5ZLRM6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsAXf2H/ureaPRL6U2JgyBys57SQ9K7/6XL+NC9ya3U=;
 b=WbNkwJA1up60db+RwXXNcmxdHYB+a8KhR514cH1E8wY9cbhA2EnG2uHZiHSD4dKWfwpgD7KWgdh9lh2XnURDH/wbYqv2VNg5FMUPh+LXWiGHC7AQ7TDOupTnS+a8imDzC0cmNH3vBdPPsjU2snHH3I5P/XFQNqrLyNVAQFVsDCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 11:33:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 11:33:22 +0000
Message-ID: <04182f67-2c98-add4-be60-539ffe2e9d6a@amd.com>
Date:   Thu, 20 Oct 2022 13:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 02/17] drm: Track clients per owning process
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
 <20221019173254.3361334-3-tvrtko.ursulin@linux.intel.com>
 <77499370-bb0e-7f7e-ac1b-ad14f47578d9@amd.com>
 <391a77ea-1120-eb23-31f9-e7a14d84b10e@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <391a77ea-1120-eb23-31f9-e7a14d84b10e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 002db41b-d6f3-4f8d-83ce-08dab28ee4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpIgpQeQA9xR1D7wPUihKvjAF8Bh8CCtAL+2CJfI3MHlQzAdMVUf2YOlVk7TFBeJWHHxV84wyFxkNJkYQqggmqGwTvoSsiS4WJubndaivNwD8EEarLLUh0tu2ZJp1iNoSkICD6Dp8hNQW2ZGsvI4zNUh2lfLLl2akRXm7VhGZm+fZDSkLqPcYp5oTuBWTfL0frYH2OysQMiHn9eTvWBrLtxcDOdvWv9MYNa4ZxtTMPtQhJAx3A83Cp11xDu7E7sxKOsTZS6uXsd9moVkfs1F+5TdY+16C7I+hP3rH/EQ96XwnmIIPENge6JucMMClI9nIxWVc44u5yWyODUi3FJ9yadSaOPiND3udVS+ZeymqiLo0H4MvV7fU49W+Vd2jm33UbMvXkZA3PNdOw0vibccqY2Y4/1yNJaFX+TtIXYqjA1031zVqoWjjK/yQfCcq7ZsSmkTFXD1fx4cX+Zi1moMxKk+hfimlQi5dorSWqImOR9fjIUcjpfcm2X+OB81mxNts5W+49/tB2uT6hj9YSSr9hWXUWojY4Ov3nyhEdBcf8cgGnnuJsVSDt6vnirz4QSqTEwOONe90jdbPN1+tg4Ti8l+tkli4kLEzECn/bStPTZ+4oEUz2kvCoS36Ns6kbYdSlLNVOtt/+KAoo6hTWNqOg1mZk4NzZKJ9/P7VjCwZgNQLu2y1SsnybSnDmTMRUVLunetPpLJ6rQN2EnrdF59sN8Xa9jXMV+G0T4eq3G79bZiEN94gTEQqgCRUQKEW3N6cuL3riGu9KOoeTXPPQcl42zopXtacK7hgwGQ56NQRQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(41300700001)(6666004)(66556008)(478600001)(5660300002)(4326008)(8676002)(66476007)(316002)(66946007)(6486002)(2906002)(26005)(6512007)(6506007)(53546011)(66574015)(186003)(38100700002)(83380400001)(36756003)(86362001)(31696002)(2616005)(8936002)(31686004)(54906003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1I3cTRGaDh4cTQ1S3luKzZORXRPVEdwYVNZL0tFYXFSUnoxS2libGNYclpL?=
 =?utf-8?B?MmpRZ0pyL1NZZE9abHEvb3V6NjVRby9jNmpzNU1keExsTTN2Zy9jTGtkSXZr?=
 =?utf-8?B?ZGorVitOYkhqVUM2b0dzSzlwSXdMSzJVanlTV08yS1doaFl2WkorTWJRNHhV?=
 =?utf-8?B?d05WbFFJTzlRSks1OURGQ2Y4ZHRjbElnMjN6MGtRMDVPSUZsTmw4YWk0NEhD?=
 =?utf-8?B?Y0dJY200Q3AzUXBVNUl3OEM5emFtcWthMGZ6VWFEcE1IMUJjbGR4ZHV6ZHYx?=
 =?utf-8?B?UHNyUzZWejkwREwvU3RvM1BQcjJPZ3FMZWxTRkZxUEQ0aFhzWUgweml1U2U0?=
 =?utf-8?B?UTlsSTlCK2dKd25vczFiM2MvaklCNVlUS2NVUmlWQ1UrSDJDaDg1M0NaYTBJ?=
 =?utf-8?B?OGZycnFEL0dBbzFSV2ZFU1JWY2c0bU5tblMwZkViU1d5OER2U2lXNW9TOFNw?=
 =?utf-8?B?dytRdUp4TVBjQXEvQUhpNGRXL2Y5dFB2L1lGUW14L1lPV2FrekowUGFnWkxY?=
 =?utf-8?B?aTQ3M2VQa0JJYVNwOEp2dlBCMWtVMys5bVN4ZGdTNVBocWU2dVJsYVYvakV3?=
 =?utf-8?B?aEwyTnpJTmJUb0FQOHRlZVlMYVJDdFFJVFRxVm51QkVFS0Vqek1xTCtTU2dk?=
 =?utf-8?B?WkQ0LzNCMHRPejRaR0FrRjc0bGVFTjFENWRXZUZHanZNelRCU05OOFp4KzFE?=
 =?utf-8?B?ZC9PK0lQMnRzTS9zYXF2c2ZucTVOVFR6TnRCMTBtUWphTU1OVVdTSlZWR3U0?=
 =?utf-8?B?OVNIYklKRUNCa0ErNlIvelZPdG9YZ1FhSlB1N244ak4zcnVsMmc1SzRWbzhW?=
 =?utf-8?B?Z25mRUdHYkNGZ1J4cFZBNUkyOXBRTVBpeUwzWkVoRUtLSk82TWt6MnZKbldi?=
 =?utf-8?B?cXgxNUUzMVFOaFNzZkM2Q1lUOHRYTVBDWnZCUTUwVUtVUG9GRFZUcStyd083?=
 =?utf-8?B?Z29KSlV4ZnBnSDBESU1OMk55SE9mRlhNN3VSY3VxZmMxTDVyN0FoY0M3ZVFG?=
 =?utf-8?B?TU9QSWZsakFobEdtUkJQNWFiRXAvODg3ODdQemxBRjVjSzdSZEpkL0plQzFP?=
 =?utf-8?B?dXVHSWtRcnZ1ZVY2WmxReFltOTBFWHZ2dFdpMjV4Q0tkdVh1VEVHTitmSnB2?=
 =?utf-8?B?VXozREtwdUc2V3ZCNHdPcHVXQ0NGck5wSW5xcWdWbStyOFJ1QnlrTExtMGhm?=
 =?utf-8?B?ZGx1MCtVOHFkeE54QTlGUGlYa21ia0h6QWZwbDdDckNQaTBPWlgvWUtiQjdo?=
 =?utf-8?B?VDVzeERVaStGK2tBNUlDZVZrVWl6UUNiWlhNTVFTNlJqVE9RaWJOQzRHVEsx?=
 =?utf-8?B?TkZFSmJrMS9QWW4vTmJ4RDlxY1pNSDhjS0QrR24yNC9PZzJJK1dJRmtGSE9n?=
 =?utf-8?B?QTVacC9IbzgxU0lMcC9qU0lwcHpYU2tQVm5QSVIxNnFZUW53cjVLSUkrbzVm?=
 =?utf-8?B?VDhmU0RJRXNURFpvNWk1RlM5MU1KM0xFREExdDhJT3N6K2d1K1JmajMzK3JV?=
 =?utf-8?B?dlVWNUN4STI0MDlvTnBOU2pDV1hhSmUwdmdQU2xCODV4YVp3bURhaUZqTHNS?=
 =?utf-8?B?ZWdyY2MvYzRjYVU0OTI0ZXlvd2lJeWhmNVpzK0hpTW1JRXZxT3BwMVRSZThQ?=
 =?utf-8?B?TDVNSmhqSGtneCswSEVBNlhSSGxBbXljQVRrWlp5czNCbllJNzJIM1dMSXkv?=
 =?utf-8?B?aldkYUcyci9aNThGZ1ZJTkI5NmxqQUNvRHN2N2t1cnZ1TUtOd2JRdDhqRCs4?=
 =?utf-8?B?WlNjeU1ORXhFdURHTWlPaHJZNVZGZ2RTN091VTR2VmZjbkR0NU0vUnJFT05B?=
 =?utf-8?B?OVc4bnZKYzM1bXNqd3pobWtMNnpGQVVXUllpK2M3bHY3NkY2ZnpnM3U2YjZK?=
 =?utf-8?B?a25kVktFbUpUS0FKRWdHTlRCM1pIRitoQWtZdEI5ZGc2N0I4M0VuMk1YUVFj?=
 =?utf-8?B?T3UrTmUxRk9XWWdLNkJCNlcvdEF0WkJjS2d6Sk5KUG1DaURaU1JIUEc5ekRB?=
 =?utf-8?B?Sk5JZEVWdHFYSDhHQ1hVSHVXelVQSDA2SHQrSm43Q3R6dW1jbXM2WDMxa1ln?=
 =?utf-8?B?ZTdkQmgxSjYvYkVlbG0vY2M5N3lkK3lLRUROaitqNG9jRDA5U1l5bTF4V0FH?=
 =?utf-8?Q?+aEk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002db41b-d6f3-4f8d-83ce-08dab28ee4a8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 11:33:21.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8pcshAkOXaZ9rohiFgygFwuPedDykspR9dmasdJkIPNP3tV13tUn35AeA9lKlFG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 20.10.22 um 09:34 schrieb Tvrtko Ursulin:
>
> On 20/10/2022 07:40, Christian König wrote:
>> Am 19.10.22 um 19:32 schrieb Tvrtko Ursulin:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>
>>> To enable propagation of settings from the cgroup drm controller to 
>>> drm we
>>> need to start tracking which processes own which drm clients.
>>>
>>> Implement that by tracking the struct pid pointer of the owning 
>>> process in
>>> a new XArray, pointing to a structure containing a list of associated
>>> struct drm_file pointers.
>>>
>>> Clients are added and removed under the filelist mutex and RCU list
>>> operations are used below it to allow for lockless lookup.
>>
>> That won't work easily like this. The problem is that file_priv->pid 
>> is usually not accurate these days:
>>
>>  From the debugfs clients file:
>>
>>        systemd-logind   773   0   y    y     0          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>               firefox  2945 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                chrome 35940 128   n    n  1000          0
>>                chrome 35940   0   n    y  1000          1
>>                chrome 35940   0   n    y  1000          2
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>                  Xorg  1639 128   n    n  1000          0
>>
>> This is with glxgears and a bunch other OpenGL applications running.
>>
>> The problem is that for most applications the X/Wayland server is now 
>> opening the render node. The only exceptions in this case are apps 
>> using DRI2 (VA-API?).
>>
>> I always wanted to fix this and actually track who is using the file 
>> descriptor instead of who opened it, but never had the time to do this.
>
> There's a patch later in the series which allows client records to be 
> migrated to a new PID, and then i915 patch to do that when fd is used 
> for context create. That approach I think worked well enough in the 
> past. So maybe it could be done in the DRM core at some suitable entry 
> point.

Yeah, that makes some sense. I think you should wire that inside 
drm_ioctl(), as far as I know more or less all uses of a file descriptor 
would go through that function.

And maybe make that a stand alone patch, cause that can go upstream as a 
bug fix independently if you ask me.

>> I think you need to fix this problem first. And BTW: and unsigned 
>> long doesn't work as PID either with containers.
>
> This I am not familiar with so would like to hear more if you could 
> point me in the right direction at least.

Uff, I'm the wrong person to ask stuff like that. I just can say from 
experience because I've ran into that trap as well.

>
> My assumption was that struct pid *, which is what I store in unsigned 
> long, would be unique in a system where there is a single kernel 
> running, so as long as lifetimes are correct (released from tracking 
> here when fd is closed, which is implicit on process exit) would work. 
> You are suggesting that is not so?

I think you should have the pointer to struct pid directly here since 
that is a reference counted structure IIRC. But don't ask me what the 
semantics is how to get or put a reference.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>> ---
>>>   drivers/gpu/drm/Makefile     |  1 +
>>>   drivers/gpu/drm/drm_cgroup.c | 60 
>>> ++++++++++++++++++++++++++++++++++++
>>>   drivers/gpu/drm/drm_file.c   | 18 ++++++++---
>>>   include/drm/drm_clients.h    | 31 +++++++++++++++++++
>>>   include/drm/drm_file.h       |  4 +++
>>>   5 files changed, 110 insertions(+), 4 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/drm_cgroup.c
>>>   create mode 100644 include/drm/drm_clients.h
>>>
>>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>>> index 6e55c47288e4..0719970d17ee 100644
>>> --- a/drivers/gpu/drm/Makefile
>>> +++ b/drivers/gpu/drm/Makefile
>>> @@ -59,6 +59,7 @@ drm-$(CONFIG_DRM_LEGACY) += \
>>>       drm_scatter.o \
>>>       drm_vm.o
>>>   drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
>>> +drm-$(CONFIG_CGROUP_DRM) += drm_cgroup.o
>>>   drm-$(CONFIG_COMPAT) += drm_ioc32.o
>>>   drm-$(CONFIG_DRM_PANEL) += drm_panel.o
>>>   drm-$(CONFIG_OF) += drm_of.o
>>> diff --git a/drivers/gpu/drm/drm_cgroup.c 
>>> b/drivers/gpu/drm/drm_cgroup.c
>>> new file mode 100644
>>> index 000000000000..a31ff1d593ab
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/drm_cgroup.c
>>> @@ -0,0 +1,60 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright © 2022 Intel Corporation
>>> + */
>>> +
>>> +#include <drm/drm_drv.h>
>>> +#include <drm/drm_clients.h>
>>> +
>>> +static DEFINE_XARRAY(drm_pid_clients);
>>> +
>>> +void drm_clients_close(struct drm_file *file_priv)
>>> +{
>>> +    unsigned long pid = (unsigned long)file_priv->pid;
>>> +    struct drm_device *dev = file_priv->minor->dev;
>>> +    struct drm_pid_clients *clients;
>>> +
>>> +    lockdep_assert_held(&dev->filelist_mutex);
>>> +
>>> +    clients = xa_load(&drm_pid_clients, pid);
>>> +    list_del_rcu(&file_priv->clink);
>>> +    if (atomic_dec_and_test(&clients->num)) {
>>> +        xa_erase(&drm_pid_clients, pid);
>>> +        kfree_rcu(clients, rcu);
>>> +    }
>>> +}
>>> +
>>> +int drm_clients_open(struct drm_file *file_priv)
>>> +{
>>> +    unsigned long pid = (unsigned long)file_priv->pid;
>>> +    struct drm_device *dev = file_priv->minor->dev;
>>> +    struct drm_pid_clients *clients;
>>> +    bool new_client = false;
>>> +
>>> +    lockdep_assert_held(&dev->filelist_mutex);
>>> +
>>> +    clients = xa_load(&drm_pid_clients, pid);
>>> +    if (!clients) {
>>> +        clients = kmalloc(sizeof(*clients), GFP_KERNEL);
>>> +        if (!clients)
>>> +            return -ENOMEM;
>>> +        atomic_set(&clients->num, 0);
>>> +        INIT_LIST_HEAD(&clients->file_list);
>>> +        init_rcu_head(&clients->rcu);
>>> +        new_client = true;
>>> +    }
>>> +    atomic_inc(&clients->num);
>>> +    list_add_tail_rcu(&file_priv->clink, &clients->file_list);
>>> +    if (new_client) {
>>> +        void *xret;
>>> +
>>> +        xret = xa_store(&drm_pid_clients, pid, clients, GFP_KERNEL);
>>> +        if (xa_err(xret)) {
>>> +            list_del_init(&file_priv->clink);
>>> +            kfree(clients);
>>> +            return PTR_ERR(clients);
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>> index a8b4d918e9a3..ce58d5c513db 100644
>>> --- a/drivers/gpu/drm/drm_file.c
>>> +++ b/drivers/gpu/drm/drm_file.c
>>> @@ -40,6 +40,7 @@
>>>   #include <linux/slab.h>
>>>   #include <drm/drm_client.h>
>>> +#include <drm/drm_clients.h>
>>>   #include <drm/drm_drv.h>
>>>   #include <drm/drm_file.h>
>>>   #include <drm/drm_print.h>
>>> @@ -298,6 +299,7 @@ static void drm_close_helper(struct file *filp)
>>>       mutex_lock(&dev->filelist_mutex);
>>>       list_del(&file_priv->lhead);
>>> +    drm_clients_close(file_priv);
>>>       mutex_unlock(&dev->filelist_mutex);
>>>       drm_file_free(file_priv);
>>> @@ -349,10 +351,8 @@ static int drm_open_helper(struct file *filp, 
>>> struct drm_minor *minor)
>>>       if (drm_is_primary_client(priv)) {
>>>           ret = drm_master_open(priv);
>>> -        if (ret) {
>>> -            drm_file_free(priv);
>>> -            return ret;
>>> -        }
>>> +        if (ret)
>>> +            goto err_free;
>>>       }
>>>       filp->private_data = priv;
>>> @@ -360,6 +360,9 @@ static int drm_open_helper(struct file *filp, 
>>> struct drm_minor *minor)
>>>       priv->filp = filp;
>>>       mutex_lock(&dev->filelist_mutex);
>>> +    ret = drm_clients_open(priv);
>>> +    if (ret)
>>> +        goto err_unlock;
>>>       list_add(&priv->lhead, &dev->filelist);
>>>       mutex_unlock(&dev->filelist_mutex);
>>> @@ -387,6 +390,13 @@ static int drm_open_helper(struct file *filp, 
>>> struct drm_minor *minor)
>>>   #endif
>>>       return 0;
>>> +
>>> +err_unlock:
>>> +    mutex_unlock(&dev->filelist_mutex);
>>> +err_free:
>>> +    drm_file_free(priv);
>>> +
>>> +    return ret;
>>>   }
>>>   /**
>>> diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
>>> new file mode 100644
>>> index 000000000000..4ae553a03d1e
>>> --- /dev/null
>>> +++ b/include/drm/drm_clients.h
>>> @@ -0,0 +1,31 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright © 2022 Intel Corporation
>>> + */
>>> +
>>> +#ifndef _DRM_CLIENTS_H_
>>> +#define _DRM_CLIENTS_H_
>>> +
>>> +#include <drm/drm_file.h>
>>> +
>>> +struct drm_pid_clients {
>>> +    atomic_t num;
>>> +    struct list_head file_list;
>>> +    struct rcu_head rcu;
>>> +};
>>> +
>>> +#if IS_ENABLED(CONFIG_CGROUP_DRM)
>>> +void drm_clients_close(struct drm_file *file_priv);
>>> +int drm_clients_open(struct drm_file *file_priv);
>>> +#else
>>> +static inline void drm_clients_close(struct drm_file *file_priv)
>>> +{
>>> +}
>>> +
>>> +static inline int drm_clients_open(struct drm_file *file_priv)
>>> +{
>>> +    return 0;
>>> +}
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
>>> index d780fd151789..0965eb111f24 100644
>>> --- a/include/drm/drm_file.h
>>> +++ b/include/drm/drm_file.h
>>> @@ -268,6 +268,10 @@ struct drm_file {
>>>       /** @minor: &struct drm_minor for this file. */
>>>       struct drm_minor *minor;
>>> +#if IS_ENABLED(CONFIG_CGROUP_DRM)
>>> +    struct list_head clink;
>>> +#endif
>>> +
>>>       /**
>>>        * @object_idr:
>>>        *
>>

