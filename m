Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AF75810F
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGRPha (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGRPh3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 11:37:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E684DD;
        Tue, 18 Jul 2023 08:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGypn2GJfjrThRwwVX/IXSwHtdT10wA/FUkhqWuO0eHBfGxcfJe9a5j14hVI8i3VPWAeEH5bOY5t9zURDMN2jMSirfd4mG/rkdHMaU+2KnFfNkN9dZyhMlfn2Fa8kvfFsjuy1VGSFsCRTZ/y/4C3xdjK1vDky+ewsItQr9tg6dHw0EMwJwjE7UOOgZozyCCxACz1Qq+QfAcyu+Z00t7oLyMfbTKukFGj0dI4mGLVvgoVGK0IYazVOcuS8qvEz9JILWbulyeOL6UO5/er3j6wZZZE2DFHNHdgZvaNtmWia93IC4JQ/wafr1G4yxAvr4BESS0DAOt3VdCBcA6nf42kRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7XHEmfyWtTbSEl7bLivWOkRxdzNXEMVg3qG+Go3LlA=;
 b=FiJb0CL56rH05Rc/J7Ysihlxr4ybkrIV2e8qxkdm7Oqpy+1pZUCnoK9v+HrSV1ur0i3+UAmqMTo/BCZEi0DOfLRfEPOb7YeGKnsJ1QT9cKtK0dUaHHOPte5AnTqEJc0Pcs/d4iCw15EzmYtJuZegpxbWVW9YsNM0Xx3+src/cjGH/xT1TY6Jg8vI67eU/TAWZFGaiEea1GSvw01uAY+3jJau1j/3wh9p63uO4NZ15LJJ/jxA/5lEXN9UL+X2Ah1o9JQJEmuyZ0l+wVV76x4zhh2VHHR4CbcZ+NCQgbSmemjVKC+RsfCf5EGX4QA4bY6scsIqeSV6hDOaQ13gzAgP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7XHEmfyWtTbSEl7bLivWOkRxdzNXEMVg3qG+Go3LlA=;
 b=fPW+EOBC/QjKl1LI2/ls5Bs5At/UQRyTrGyrmFeCq4Jx/+53vLVvBjb2WJhb1MKeU80j0FozOFHu+d+D6Cy/f4SFVeJ62E9sqEVmMcml8hMCIMTKjn+4YQ231loQj6u9Dy77SMOtMQkfIQ4HhxLnowPr5/ycKqKzojCdZRtM/4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:37:26 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:37:26 +0000
Message-ID: <7044d6b3-a5d1-572d-a755-74f8d4fd31c5@amd.com>
Date:   Tue, 18 Jul 2023 10:37:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd <amd@localhost.localdomain>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:806:23::23) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e1bc97-5345-4c8b-6ec0-08db87a4e318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qP2KqbL+PSpZ9t4vxpmNQpY0sj7d/VOJi2c/Ie0OVX8PzsrALrjDzCZF5aXMknbIzI1JW7hM5GZV6EQ8psGND730Z5UIpXAkSjCUHBLu/euQ9XGs1Ijn/w0Wyxt5UgKPyDhByggm+jRxQNPOcsqxxO6ha4Cu4NiIacYK7BgEffpa8YE1mjYnL7Cs4TgStVYs+D/5Zq+ju4FwIKBTy0cR5gy/Erm4aP4H2+0amwNSlORkDxnNZc0krbhBrZRljC9YS0hP1To+OGDqYSac+fFxjqRBLDH2amLBD1hXcorlnh1Ofy+cCrl/hnD2CnKC8Gk4NT84mNiTAlH0YNdzyynpsgbEOjhxSE9/i0K2EEfNToscfRyw2K9nesP0VCmsF30W4++VrVzq/DxzBd0uSZX/vFBBh82oBZPokBXfDWmKxRU58rSD+WwctL2v5mUd1wgbgWWq/t+J4vsEgk40Tthb0OacEzmbttj9vvOzf7gWhh9N2MDOSrmIov7Hy6inadB8FLdHKxuLv5JmpeS7UgJ0lBdgTTs8VJiIuVRqqexUPyId1+nnFHdTcWz3Kyg6+Vk9N8ZqY8CISfOihx46+8LKvgszivaqwsexjNovIhdw+OdhWL8lGSjWYn4PKDcifnPFX+p77sGRd/ehXgUa8VJdgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(31686004)(478600001)(6486002)(6666004)(2616005)(83380400001)(31696002)(86362001)(186003)(4744005)(2906002)(6506007)(53546011)(6512007)(36756003)(26005)(44832011)(66556008)(38100700002)(4326008)(66946007)(41300700001)(6916009)(5660300002)(66476007)(8936002)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVoTEJKUGplcHJXRkRUTTdOVUdtS3I1L2E2MjZnUGJ5TSt1Mjg1OFlCMHN5?=
 =?utf-8?B?dnNrRUNjd3lFL3JUQ2RNVWZxdlRPbDc1TEpXSkFFd0JYYWxzbE9tZEFRa2tS?=
 =?utf-8?B?WktUamdqVlc1d3lrSGQ5b3JjVVhIdEtScTdKVVBpRVpiamo4UVNkWGpGaHVh?=
 =?utf-8?B?L0ZsRVhJajBCTlNJSUluaUpmZnVmdEJSdCtiTWcyTng3RHVPRDNKczdNU1hD?=
 =?utf-8?B?bXRxdW9qdDNEeVRJVXNDZmpldmNIR1Z5YXBmYTYrN0R0MjhzRkh6emRKczJr?=
 =?utf-8?B?Y3Z5Wk03eU50Sk5JRzJQSEtzY3J2M2o0ak1UTHpMeEI4WXZBZldHVUVWT3dU?=
 =?utf-8?B?SzRtSUhoTTM3eVlrd2pmZXZkSVpkbVNQMXRzemlBSkpPZEJWeUNWRzV6QmFr?=
 =?utf-8?B?SkN6NW1UV1AybUNBV1dVclo1RFZGcDJvb3hYcjV1L2o4RU5iSWEyTmFXcWN3?=
 =?utf-8?B?c1JuTHU1UU1KMlhLWUtlMU52VUZBRVBPMzNzb3gxTWxPejVmdE4ydXJ0UDZa?=
 =?utf-8?B?M3RaQlBoaEs5TlpFWFk5dW9UdjlxZDUwd3g1UDZqTGxCK05DUHNzbUxjK0Rl?=
 =?utf-8?B?K04vT0lENzd5SGRJQm0xUDErWTZZbUI4T0E4OElDcTMzTFdQRS90ZFJhTHdD?=
 =?utf-8?B?aHZjY0J5K3JZZGJWZ1dVVGVPUFlDUnJjOC9FTjQ4TExSb3NkYXI2RVFwb2hm?=
 =?utf-8?B?dXRmTkk5OElzQzJJTUU4TTQzL1FRRzBabUVNRWZoYVNiRGFZRjdxOUhaZ2dU?=
 =?utf-8?B?YkEzWlpNaEJkQ3FXVjcxaUNPMGIybllkQlZMNDNvWUNWTWVoT3pZb0FBMGlY?=
 =?utf-8?B?WCt5eit1ZmNLK2xITk40bU5mRTM1L1VjNmpvVUl2OGhVSkdzMFV0Zk55dnpa?=
 =?utf-8?B?UUtmeTh2UjA0bmlySXJEOGM3elhiR3N1dU14VFpWSzFTbDR2QmtEamF3T0ls?=
 =?utf-8?B?bExmTEJ2QmJBODZ5UGVQMERLQXdQTmVSN2IyY3FpK2JNaDRNZjBQVWxyT2d5?=
 =?utf-8?B?UHQwTnRyY3Z5MDBobW5YdGxFTXBtS29kc29RRXVHRG9MenE4RTEwZzFGK3hu?=
 =?utf-8?B?SjBGRjUvMkdvbFhLdlZoWGU4MnZ0K3hsMm9YRnlIbXAycWlMN2NCaFk2N0ox?=
 =?utf-8?B?UU1MamNoczZ3RHFvemZKTjdjalA3SXJzSmxjVjY2N3o3eDMxTnNHdlhHZy9p?=
 =?utf-8?B?cmtIUkFHc0hFRFk4ZERSNmRLZ1BJLzhOZjdxeXNTdm5JUFNYdytGcDczOG5V?=
 =?utf-8?B?SWsrREZ3U0xsc29sMURCUW5qMGNFc05tM2p4YWhFemdLczRPRUpwWkJlVWZn?=
 =?utf-8?B?SFl1VE5ZbGRtazZGUE5DK0VSbm1tRVFIbWNYZU55VmR5bXg0YUNDSTV6STdJ?=
 =?utf-8?B?RmFkSnRnQUJFbkZDNExjaWF4ekxxYS95Q0s0N3VMWERLQ0pYVjBjUUozYVdh?=
 =?utf-8?B?SkFuanpZT1BwRUdpeFlxNU9zaHdOOEhoUnlKSGVidFUxbGtLOUFpbkhxQ1g2?=
 =?utf-8?B?WGFFRktvUC9vTTZoNEQzeEJtZFIzQXR2NEJrbnJ5K2JBS3dGdUE0bUhGMW4r?=
 =?utf-8?B?TFJLOUZZZDBFMDl6WXBESngxbjFvY3dDUmJxR2hMVmdlZEw1aXF1TkJ1RGo4?=
 =?utf-8?B?YUVnTEhYQmRGWHBNNGJKczdFZHlGWDF1QWZXbWZySmRHdFhPeEJZQUwvbGFG?=
 =?utf-8?B?TllobFUzQUxCSWExN0R3aVA2eVlCcmt6YmhVbWlONG80OUNtR3J1UEt0OHNB?=
 =?utf-8?B?ZVU3T1Y5ejZUSGd5UzNBMTFRZ0kyTEVFUElvMEZRSnBUK2VMUjVjbU9IVTlZ?=
 =?utf-8?B?ZnZ5cXBmUVViS1huYjFWTjJaSG0vYm5xT0Zobm9wSlFVSi91OUVGMmM4dytv?=
 =?utf-8?B?dGlIellNdVBQN1g0Wno4cE1uYXBFZUNTOG9qWThjTnQ0SjhSOXhGanZkbDdH?=
 =?utf-8?B?aWc3NUE3TFhFNlUzS0V5Mk0zTzc4dlBsUGxZV0hYVFNQSVpjeFVxdjR0VGpq?=
 =?utf-8?B?QXQvWkszWitTOEpWdm5xdlFLNVBSVWRlUjQwTDRYVHE5ajQyNXUvbHYzWDJY?=
 =?utf-8?B?R3FTVXRRR0RjYnZtT3JGSVFPbVE1STJxa1Bob0poWFl5VkF6VDNMYlBQSmY3?=
 =?utf-8?Q?EkOHPt+vlMmDNrotLaY+BNEFQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e1bc97-5345-4c8b-6ec0-08db87a4e318
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:37:25.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tPX7fDNnLaF91q1NvPO161OCtpj7bWVytPs9Ce6yV1l83EG7fS1wLF5QMXJ6WNWAHxlRNS7U+6CE/o1MVs95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/17/23 13:49, Tejun Heo wrote:
> On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
>> From: amd <amd@localhost.localdomain>
>>
>> Fix two type mismatch errors encountered while compiling blk-iocost.c with
>> GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
>> result of the division operation to (unsigned int) to match the expected
>> format specifier %u in two seq_printf invocations.
> 
> Can you detail the warnings? Was that on 32bit compiles?

The concrete error was: "format ‘%u’ expects argument of type ‘unsigned
int’, but argument 3 has type ‘long unsigned int’". If I run:

$ echo | cpp -dM | grep __LP64__
#define __LP64__ 1

which makes me believe it is not 32 bits.

> 
> Thanks.
> 

Thanks,
Carlos
