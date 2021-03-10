Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3B33389D
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhCJJVy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 04:21:54 -0500
Received: from mail-eopbgr60133.outbound.protection.outlook.com ([40.107.6.133]:27414
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231366AbhCJJVo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 04:21:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae5mE9ozcQNwL6/ZONOjqelU3bi9mltkc2vzun3qxtPBmgASkYmDBcFZQEyFi3seyN+fjMLjFECBBehsKUFooD9yG8YUrHe3ZOkmCRWxS+hGLNXIeeDJjtJWDuhfVbeIw8uclU1hPHoYhZaP4BY0+On1dD9m7zQ2JzOhOoctTC/hdGjV/rjbZF7UDnDf9PF5tZKKwqUwbCOlVu5mpwYT+X0bIt1ZU2vCycLyMDvm73T9tVaCDuf00Zdp1FlVMM2e2BULFLa6C69k1BFIuqL0Hc4tw/SaE6z8vmwoqyAYZkc7r3WbTx6k9JZCvLa6NLkVspNGxRWRYk37LuQqx7nlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/fNXpTuxABcaNN8chdZ8GWl7T6M35RohMwWnBTGqKk=;
 b=LLIVOaYw2ABoFHjGchz6ovWTE+5J5HcmBHeec9LdKZR/MQ8cUEOzs8P8K9pc0rm+tGc2rMVD92QR1Dc+flklQC/tzwoWE4z5LLf34/0D++4lAqO6RfSO/19KYsHL5N0ZtPSz2jBlGD0Cmhb8rFrGLEGkONkQHfuOj3XS/G4bsgJRlsWIt477O1XfPA6IDQytkaOT/xgaIY5ZYrmJN7rp3/rQm7jp/EMo8VmilsENCGe4/509/kded6Nd61r2naPYHnUvql8udOS6KHjovlecTNv9Qt5MnZ7qll6Ho6Kd0VgkiRkYHRsplmFax/wIzECJG3RsTIOrPkDGyJgbZQIA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/fNXpTuxABcaNN8chdZ8GWl7T6M35RohMwWnBTGqKk=;
 b=Cfmny1WRBpD8/ahSv2CkA86TuXy+cNk728//sUzoC1FcHzCfHiI41QKry+9xnVRuGxV81S4+w5CmFgsKAlUR/kccxcfRshHCVZLxFJ5pdOe+8YRcinSPZ0TWriBZizGTRIrxoKjNfb8HlfKIBQ2O6fzo5+pTxk2Y4uEMCMEc+Eg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5744.eurprd08.prod.outlook.com
 (2603:10a6:800:1af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Wed, 10 Mar
 2021 09:21:41 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Wed, 10 Mar
 2021 09:21:41 +0000
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
To:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
 <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <32fab450-c62b-4f71-4d8e-4e956bc37cdd@virtuozzo.com>
Date:   Wed, 10 Mar 2021 12:21:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0302CA0015.eurprd03.prod.outlook.com
 (2603:10a6:205:2::28) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0302CA0015.eurprd03.prod.outlook.com (2603:10a6:205:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 09:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf8c22b-38fc-44b4-c652-08d8e3a5ea22
X-MS-TrafficTypeDiagnostic: VE1PR08MB5744:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5744931F8F3E634CE8646B6EAA919@VE1PR08MB5744.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8L+Xl2wDGv2Ys+12CzVpOuI/eLhfvG0QmpBxX3oX4yohHLRhjSfabcjL3jaEJvWHcdItMFxIniKYvWnyRLUwrciJF5FU3fJBXpBoX2Phg1C6hdASDPLlZ9CoqCJVusqjOqhfv1KP3Kb6OHImuWwQVY1Z8fvy0ISNXhJ4qpJU47APOqBYk1qFcVAn4LslxM3vjVWbEgA5VgxGU/7OXpy6vEK4X5sxYhZYrQavFzYNqd2uJRRR00bNL2J4Dqhg/snRSZmT376YUcsyCr7jj21+xWDfVQkjVWjhJN2OpOeTZFq+tPzIEZvdZWQmWnhHGOrkci24/INOdpm0ea0onB5SsMNUrl6hZTvqZVw0Wy3UHUOv3gkwSBzSXvtLvEoIl1NdK/BSkn9Gox7tXO3d/EhbBIm0ra+w/Vt24a8QwGic8PmKNaWpxajPifDHYCsVdTYaeC8G3LkopRBqfyyXbP48H+8qD8fXjD4NWmnTcNuk5fA5Eav2jJxUom8uPqt4bSyKBHSRhtK2UKBjedABJXe6DYXfvKgUOhr344pL4kJ079+reCxXdWOUpC8zZbsnKym5QXBInTxrv63w09mKK8/nNCz3Ze+31RF9SLrW1+nK54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39830400003)(136003)(83380400001)(316002)(186003)(16526019)(26005)(4326008)(15650500001)(4744005)(2906002)(66556008)(66476007)(956004)(66946007)(2616005)(5660300002)(36756003)(6486002)(31696002)(8936002)(8676002)(52116002)(53546011)(86362001)(478600001)(54906003)(31686004)(16576012)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3VxU0J4d1NCbkljN3NtYnQ0MHo5ekMvTitWWVE3Q1N2clBuZVFQZ1A1eWJ1?=
 =?utf-8?B?Nll3RVNwdjY1NW8xcGFOQUxpR3pvMUpMbndQU2dFd2hkbWlVTXRIVzNVTFV4?=
 =?utf-8?B?YlY2a04rMEVJMWlTVW8xTER0Vy9zOE9qeEorY1VkMXBJZzZOSytQUWpXaysx?=
 =?utf-8?B?YWtaQ1R1dm9mWVBYdjZERWpCNk5wZlRXbEJQc29tQjJxOUlIMEF4aVFDVG1s?=
 =?utf-8?B?TW4rN3JKY1MvNThsUmwvUGxyMTF6d2p5VXByUkdWM0VLSmd5T1FIWHF5bG5x?=
 =?utf-8?B?Uk1kdzFhdkdnSzZpOERnY2FZQ3VFQVBQUGtOdzBsNlJUbkJNZnYrRjY5UURV?=
 =?utf-8?B?NVBtY2VIVjcrME9mRE00TEFOV2ZzUzB3Smh2Slp1MDlPZUpUMVFrV2NkRGor?=
 =?utf-8?B?ZjI4N2oxbGVmTkZXTEM1bVdMN01mRjhaelVMek5VOExnSnc1TlhVQkErZ3hE?=
 =?utf-8?B?U3dHYmNEZjR5WTBZTTdmcEhpK3l0eWNwTTBCMm96a3luZWk0anBacFg2eVNC?=
 =?utf-8?B?TjVOL05oMjFvbVhId1U4cXV5U0d0a3FFbk9obFZZc2tEbGRsZkh0eWhxWEhV?=
 =?utf-8?B?a20zNFBvL1N0RGNYRzdibklwR0NNNWxEbkZJUmg4Njgzc3JhSzBPQ1ZQbXZ6?=
 =?utf-8?B?bjc4cSsrVzdiN3ZHd2RSeks4UGpXSWpFY2V6cXY4TmNJSlFFVXBmRlFrTlNm?=
 =?utf-8?B?Z0czNzhpbXZUOGhBTkI3aWNFQWxJK3FzRkRuKytiU2JreXFobGVHcS9PNDJI?=
 =?utf-8?B?QUpGdGUvRlpDZGR0cjlFT0xJaUxqYlhucGYwa0h4MDR6elBtaUI5VjJGUldY?=
 =?utf-8?B?TFYyOHFVYlZuWmJmVnJkTlIyMEZhYTFlZVovSVVRMVpzZDJTTVJpTE16WjUr?=
 =?utf-8?B?aVYzelNXTTNBQU5HZXFoanh6MW9MOGN3aU8rVE5LYVk0cHFXOHN4RU1KallL?=
 =?utf-8?B?MUpkUzhiMjZBejdHR2YvTXE0aFZaTXRqNXVXWnVjQlRoYnNGMnV6MjF6c1ZT?=
 =?utf-8?B?UGVzU3dwMTM0L3VhUVcwYS9jeHFRQTZJQkY0clBUOFViVVVBOVJFdXpoaEZa?=
 =?utf-8?B?OTZQTUVuUUxVMThaNWpMMGJnY0k1U2p3c2ZKR2lZUjE4U3lidFJQUGxVODRK?=
 =?utf-8?B?M0hKYnUzL2MreUtWRDg4VmV0d041REtkcStUQ3JyMStZWldaNHZja0NLbU9Q?=
 =?utf-8?B?TlBmL0x0WlE5M1YxeEJ1aVp5dUN2WnF2ZzIveCtJNEw0RDlic3cySnpWNUlC?=
 =?utf-8?B?bms5TFB0SExXL1JUUE9lb2J1clFpdWlqMFBpV1dVTy93cTVaM0Q3MXBaMCth?=
 =?utf-8?B?clFFRmRDUzBMOHRJMStlaldMZ0NwSUFWVk1JdGFyVGp5VER5NXJQNTdJVW85?=
 =?utf-8?B?b056ZG10am5wRnppcTExemFkaGZvMHFoaUttZi9TQTh2YTVIT1R0RnJKc2Fm?=
 =?utf-8?B?SEdtditpQ1lHVFhyS3JlczR6R2JyaE5idnBLakRNaE1hcmFiejQ4RlJOSERF?=
 =?utf-8?B?T2NTb2FuRlI2YlByK01ETFp0ZS9BZ2ZKbUxHcDFlWnpLTjJVbGFBa1RMUHlU?=
 =?utf-8?B?SXJRZDEzdXFnY3BpQm1SNmpMVWxBYXllWEswNy9QNUZ5enlSc1o3RmVDQk9I?=
 =?utf-8?B?Z1B6MVhXVVprNkljbHpYL21HcTRRQ1FHTmJTVU90OS8rbUFTRGhzcFY5aWhX?=
 =?utf-8?B?VE9wNlNGVjBJTmgvTmhZM0UvQWQ2dkRLOHJ1RGhCcEJEcWFFOFRzaU5vRHJT?=
 =?utf-8?Q?0cKWpmllQym2qmOn+2Q8jhCnKn/Yc1kJTz0QJFK?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf8c22b-38fc-44b4-c652-08d8e3a5ea22
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 09:21:41.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkjHTdqtmoYhyOxq/SIrPAazJX/U7r2+XehLA2iJ9+xpzojEpK76cTgoFcpSp/Bc9n1ER7pEGH38BIoEebvQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5744
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/9/21 11:18 PM, Roman Gushchin wrote:
> On Tue, Mar 09, 2021 at 11:39:41AM -0800, Shakeel Butt wrote:
>> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>>
>>> in_interrupt() check in memcg_kmem_bypass() is incorrect because
>>> it does not allow to account memory allocation called from task context
>>> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
>>>
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>
>> In that file in_interrupt() is used at other places too. Should we
>> change those too?
> 
> Yes, it seems so. Let me prepare a fix (it seems like most of them were
> introduced by me).

No objects from my side, just keep me informed and add me in "Reported-by:" in your patches. 

Thank you,
	Vasily Averin
