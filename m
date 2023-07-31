Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D43769A49
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGaPEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGaPEZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 11:04:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121CE78;
        Mon, 31 Jul 2023 08:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6G6Jp47lEhsBeCXX/oAoMEzbibLHzsZhtuNKlyW/T0GU0aXm5MZLcOEBhB+T9YJfdQefu1YYWuH+Xdj71gmJrpPOL4NbgoSvv1JQe53uh34pTpi8xVrETl7tZWZq1bbn+p32vEAZ2Em/LO0GBJH4im1f22C17Upxf/orkCfK/hfJ9zoEfiMD/oBoT3ovYhK3qzx6yCL2VLkuUcmeAQLXHsd56Fyxi8excR9k8gLG1seZDgYPqHe8UsqosvSgTc8nwaSd/LVVriBShC9B0fZrKNu8CqzT/cTpQHna0iGDIzJV3F2lHgqrAMDrpPdXeMLCI/BQ2CLLfbKhietccODTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bazck+NSeWS8nQUxV63068N65y644YleC1gT1b/6Hs=;
 b=gJP6oX+0NWJHXUsMp3R+4XsRktogMP38eJseQoz23gHzUHkWEm3y6OM9ZOmc6x6lJ/wr5hy49zTUh4dT/CxYRhtH/SRDYUK/YsyCMZVJ2F1MdET0FHoo1tAu7I14EkMJy7p5eQJ1Et6+Rnz3E0TduNuYbqaenswwVrbMIBvZOUblkUawyAQNUJ31WU8ZA5pyv2fzSGGDQ9Wl+Iy7AsQJZ+NfHGgePOuWqzIkLSfvf/EZyFV1yojI/lSWkHVxaIohYox3BvxRhLhEyh7vPoLWRaIqdscqQWRe8qMM6KnIDlzOU0DoyUGM3PuqqkOAEoolRsLF94JxfD8PhtPPuT8ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bazck+NSeWS8nQUxV63068N65y644YleC1gT1b/6Hs=;
 b=A/bLWs5DHGfNVorZL0MUvfyhsId7QIGgj83MEseDYpY37Rm0gV2eMmsgcVnYEdobB31R5FABMnFEGSPDRcQxXQjtWNNETZPyfVDBLS9xGYobL9+VAp29D+rRzY1XznC71oPY7ivvqOn/TzA+4fO7IiVU4S/BO/JmakYRa0Pqa+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 15:04:17 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 15:04:16 +0000
Message-ID: <7f451eb2-6e62-9e49-c47a-e0de59cc7ebf@amd.com>
Date:   Mon, 31 Jul 2023 10:04:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd <amd@localhost.localdomain>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <93557f79-c12c-3c3f-2c25-9ba50a618daa@amd.com>
 <ZLstYbAzqkqwIRzy@slm.duckdns.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZLstYbAzqkqwIRzy@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::9) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e1cf49-ba02-4374-fc24-08db91d768dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWqOhZ9RBVCZ54ygffNM2LG4BZT5oUnjNyLMEo3WXe76pIc3lnI1vEtOxZS/Qmk+r6cNcxpISdKC8m81s8qRGtMHNtehKBgxYsoOSwitRCUCJM/qlf03gMKQgMH03UUwQy59tyaxNhk77Mqx2/LuZL2gf6IVRzhmYLO86igbRYde2xKuVBpJXY3tL09saXe7Xs7ehRHsOyoPa11YpDnsTmLpLUMCoFsxJ8h9QhquGn5JRX9a+2J/I2h5NYxImi2OcuAOONJNkDdQISyEXor4JLD+29UpdPImgdQE3Nr9N34wFsn4taz2I6FdmFJFu7BDgxT9P1dK2WsdPQwNuWaJbeSUWj48dtjm6N3VsnSTFxn9lWl6052sKfasfUv7cEMkU1IgoSwVJ1XOxo7Er+C/BjSTpofjWLVQ+ZSpgl4HZgG5R+PbR30QllWi9tPnK705Luxwm1mqTr9n9/ghx0dmur/JSI9auO/soLZTarExCbA3bvMiRBYYoGemV8yfEP9ifJf69Enl2oeq3BNxBG1mNcdMhOOkb+KckDts52UEZd4GLKjFJxJl94TfNuIWbEVFYI20wJ0xPgDxeVmdOsgDFuewgvCagjQe7UMqixpSr1Qu6NgkmzUuOzQaCeRZo5Vl+OOA3MZ/UAOxKx1nqaakeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(966005)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(186003)(44832011)(66946007)(66556008)(41300700001)(31696002)(66476007)(86362001)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(31686004)(2906002)(478600001)(38100700002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpxRmxIZ2FCdmV2M21abjVIRWVRMEM1aS9oZ2dXQXgzRG5GYVNhc1BJMEF0?=
 =?utf-8?B?d2gyQ3daOWFGVVFzWjZjTGtDYUJYd1hXMUs0SVdFR2VKYUxYM1lYQWoxd0ln?=
 =?utf-8?B?QS8xems0NThTVjByZkNQYUVJS1pJTzBmWHFGNGNYRHVsaGxFazkrLzBaWlVj?=
 =?utf-8?B?aE1EWTZiTUpDb2xUb0svZkhia3JDdFl0M1RUZGlzZ1lZRTc0OFJXemxSMkEw?=
 =?utf-8?B?VzdXckIyZVlhaE5lR0xGKzQ5QWZtSTBQeFU4QXpST0I5RHJFMmFmNW1KY09Q?=
 =?utf-8?B?bmdtK1E5amtlbWphSU5lODlyUXNQTnJpZXh6RksxUEdiR2JRL0tONjVZYTlo?=
 =?utf-8?B?N1ZxRmtLT0dyZUxhRGxkdEVDalBvdENObGJsbG9LRTJtc3V1a0NHVHhFMzUv?=
 =?utf-8?B?V1JFV2RPNU5BU3BheHNjWUFoMjZBRW9ualcyL2RzdWFLekY4S3lJSzBzeDMr?=
 =?utf-8?B?V09SY214MFA1djhpaG5rU3E0N2RKUTQwZEpuYnJZZS9RS3RIaHFQM0dOOCtw?=
 =?utf-8?B?Rzk0Y1p0dFVsRFE5blpicTUycFgvZ2l2a1VabHB6aUlwYzIveUpyY3RqK2tI?=
 =?utf-8?B?SWNEVzIyR2YvcS9wRDVYZDZyZTBxU1ZRbmF2bXFtaFFxWTY3UUVCaVYxcmRa?=
 =?utf-8?B?YzUvOTN3OTRpWWcvMEpESFdOZHlySENreGJIWGZMVGFhTU5USUZFZm1CWG0v?=
 =?utf-8?B?ZFJObnlQY1VUZ3N3UjIrK2NWOTBIZGNGakUzQVRnNmFtYjhDK3F1VEhXamxz?=
 =?utf-8?B?aFJmVmsybmJnM296WXRwSXoyUjRnWVZCbk1yQ0FDRk5XZlNKaHZJT3FoZFky?=
 =?utf-8?B?c3dyaDFMaTVDLzdkRzZXVENWaGQzMHJaYy96TmpGTnlFN3ZudGlpVEZBbTNi?=
 =?utf-8?B?dEZsdW0vNHJLL1NxRTZtd2dXZWgxd1NJVkdaSmdYUSs3eUNjZjA1a2RpSi9Q?=
 =?utf-8?B?VW1Jd3ZMU25MT3VhQzlMYlROUk5vamhrNEp1Vlo0NzU2b3IxQ3lZc3I2M1h3?=
 =?utf-8?B?dFZOa1VhbWRZZ3VjdjlEWDg0VitVWTNDYW9uZ2cvc05kNHJISUdaZUVwZkMv?=
 =?utf-8?B?YTRKYXNKelpyZUp3ekRYVmMxZlZjS2dBQ2hYMThBRlBsdmwyeUNZR3RpUlZB?=
 =?utf-8?B?R0tZZWxMMWlLdmlzaVlUVDk4RkFxRGMyL2N6czJGd3paaTFKOEpsazdVL2lE?=
 =?utf-8?B?blIxaW1WR1owc2huQ2RBK1hxb21zM0NGZEsveE5Cc1ZFM21wdFB3aVFweGtm?=
 =?utf-8?B?UkxGM2pkUVgrcHArcWU0QlYweE0zVE5XNVJqNWR6OU84TkZmN2lSYmVxdnB5?=
 =?utf-8?B?OVNTSklWYSs4WWhYekhMZUJrU2oyTUZHM2s2YkN2QzhkOGJVZ2N4VzVXMDg4?=
 =?utf-8?B?RzNQckdncEV5OGsvYmphMndvNncxY1hQYThEVEVZOUNMdVJZWHNzUWk1TkMw?=
 =?utf-8?B?N3RyTFRRcUd4b2ZNWDk1Wk1zS1NmSjB1VUlCVzByUE1kcDJYV3dGcmozVE8r?=
 =?utf-8?B?R2xONkNvVHAwUWNEZkJrdzFiZUlYUkl1enRHdmlMTkhJV0tCV0s0T0J5WmFp?=
 =?utf-8?B?U2E0NHNRb1R2UzhXVGpuR0hENUpYYStBK3RhYlozaURES0U5VjhVZDFPSVhs?=
 =?utf-8?B?KzA5eEE4YloxUjQwb2NwNGZXUlBjZGVrM2VFSUozNXFvRzJVSEJRd0tCaHNQ?=
 =?utf-8?B?eHhSWjZDVGZzZjM3WlErcU54N3VhckNjaTNSV2NrNzVrUVZLVTYwczN1Q1FQ?=
 =?utf-8?B?ZTBZSHl5QXMwQkdYVzJPSkp6OXQ3anBYR1JNeTViUXNpdm1yYmk0RlZJd3RU?=
 =?utf-8?B?TW43aGN0UXZOem4vdk52dFZtNy83RnRDcHNLbjA5aTBvem5Rd2tNREJNaFAr?=
 =?utf-8?B?ZEVlOWI0aEdjV2M1bmkwdGpBb2tUVTlYWVpRZlQ4alBIazliU2poeFNhbS9F?=
 =?utf-8?B?RjQ5QWhUOGVqVDBUeTRVcm5tTVZtQk9GcmxQRmY4WEFDN0FoYU1yWnQyN25r?=
 =?utf-8?B?c1JweG5hQzJvY0kwL2FKL0MzUTV4YjM2ZXA0ckxBTWJhSTZBRlVEVWtFS2Yv?=
 =?utf-8?B?eDEzZ20zY1ZhUWhweXlvSUFPS3ViYlVDY0ZoRktMc28yakpDRjFNWThnZ0lk?=
 =?utf-8?Q?azckWv3XhsyLT5ORwOsb74AAR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e1cf49-ba02-4374-fc24-08db91d768dd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:04:16.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/uTICzlknux4WeQqidk22kkoKQ33iBL6HkMIwNshmHMa4iY0UiHNPxZ9o+vXPp0iMfnePlFxiXFgpQEzZjWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/21/23 20:14, Tejun Heo wrote:
> On Fri, Jul 21, 2023 at 05:32:04PM -0500, Carlos Bilbao wrote:
>> On 7/17/23 9:18 AM, Carlos Bilbao wrote:
>>> From: amd <amd@localhost.localdomain>
>>>
>>> Fix two type mismatch errors encountered while compiling blk-iocost.c with
>>> GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
>>> result of the division operation to (unsigned int) to match the expected
>>> format specifier %u in two seq_printf invocations.
>>>
>>> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> This should have been:
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> 
> Carlos, can you please retest the current linus#master?
> 

Yes, that version compiled successfully without changes in my compiler. The
kernel that gave me said error was a custom v6.1.0-rc4 (Obtained from:
https://github.com/coconut-svsm/linux/tree/svsm-host)

> Thanks.
> 

Thanks,
Carlos
