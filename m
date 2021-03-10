Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA63338B4
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 10:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhCJJ1P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 04:27:15 -0500
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:1345
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhCJJ0o (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 04:26:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0OtuYviabkIAlWRFOnN2G6NmACp4mhRNcg0pxroY31pmyHBkbF4VE1p/RZ+OEB3nmTC1gxDQUiLkuDB9J9VW3WA45AfKom+Xc+qZWbt8qeOXiPp3w1KkrhGYb6gVToBU5i9oaWqBg4aI4lRmegfjidk+keBOa8yoS7uRx6rcwfg3V813q4NkeLg5XVQWcMVpox1rO1W8+x5g8d4owm4EMD37GcLWIpA2Todp6J1UZPaMG6V/EYmP5Ih1LcOz4YtyMXJcQlPrTIXdCVB/RZQelKUWpCmWKRsRf+wBwfZO+y4eh5nyuoQArLPZKiDAL8/oyhDHvWm6qPvJZFC/c2RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWWaYVLPJdPQFobd7qBOUoO35ucTbEpZaavQEamL6yU=;
 b=MvfbrhKxB4c2anvxb5f+srlrnkWsEKGlCKXPFKzfkeSLwkmFuBLgC27Jh+kd4kkugoqKVNjBx8CJGbb0ZjW9ukd09h6lSHZliNuGM//4fF/IcvodkZGplDWmIxnnOpGxlWDwaZOKmi4QwV5TRju2icJYjunP63IKcYnx0KodplNQZtFuA0PPERKx0ow3MjFerInEjydPLP6GVaC3JJupXWYcN65UayajnyGP8Or2ELQ+V/LAvaxcgvLegY/ScjlquCfBUFFPW0HXxZOphLvwc1thEUa/EmVZt35s8LUVELQ4g2UcVumLiKDyHXBlTLd5cXmLh8PA94C+njQ0JvF3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWWaYVLPJdPQFobd7qBOUoO35ucTbEpZaavQEamL6yU=;
 b=NFRVRTAp2qY4bU3XD03rJ/nKFU++GkcknT2licYvsn5+04tipP5uc/mTkfDqsHxmeK1AIs80yNdS+8flExVtIlMmd90JtzrcOFvj7OQy3gRzJ2E1creE9AGgu5zwJhPtiHvH2j1fF9bG7PauuiOGT2mZwrNcSq+EZgx8nXw8m/E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB3903.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 09:26:40 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Wed, 10 Mar
 2021 09:26:40 +0000
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <YEfc9uCc8sfs7ooT@carbon.dhcp.thefacebook.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <e1d40d68-4ba4-8de1-ee04-c644b6f771fe@virtuozzo.com>
Date:   Wed, 10 Mar 2021 12:26:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEfc9uCc8sfs7ooT@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:208:1::43) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:208:1::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 09:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e2b535-51a3-4cd1-0c9d-08d8e3a69ca7
X-MS-TrafficTypeDiagnostic: VI1PR08MB3903:
X-Microsoft-Antispam-PRVS: <VI1PR08MB390387DF21E965D1389E8364AA919@VI1PR08MB3903.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkYeE4/YqbjU0BEaZHrIudwmjjsPvHOOwllGhkfS6LZYyRXBdP2lVCOskGVzABb3XTnLuaVZwXNAwKsVdLB8UCn5ozvvIMVhNx5HW80kigT152us6ur8uOx9ZQ5WvQi+F4uZtgvYP+OKbAIfrae4eY0kCdnF0g0aDT7rnsiByAKmrd8qsi/6WO5CPAlkHJUAPo0DGVV3AYj/5vy6yvRliddmrpDegCoIoLG9qKZE53vWemMRzFQwq6tSz7RyXUSnxk2CfkcypL8NWRKKpweTwYyhQXtYHDg7Ii2rFQf08nNjLsluHFqBK+ITq3Hh6VWBNSTBykhmKvrucv46SwdF8k5SEMKvV/iws0eTfbPQGf40oITl2lFdlGhjGkrly0NNp2m0FqIn8CmrIG8ReCjKtOHeiSGSCgeYHFZCTKkVbAYNQpcPTu3yV5Td9DB2IP9pHpF4R2yAw9sRlK4xBSR681QHFWXkN1uyNFEu6Qdzh4TzllfmqN3QZhlVEIETEtuPNx7sHBwpj1H4ZnOkxkmFAVQHYWQZfd7RNobsTHHKfw4FXP081d/ZA8Ay5mFf+rDNDQfVoofHi+oPiS+tMe+GGXvVMmfNUT5EUGXx8z/AWi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39840400004)(376002)(366004)(346002)(54906003)(316002)(83380400001)(2906002)(6486002)(36756003)(15650500001)(8676002)(86362001)(4326008)(31696002)(66946007)(26005)(66556008)(5660300002)(16526019)(66476007)(186003)(53546011)(478600001)(4744005)(6916009)(16576012)(52116002)(2616005)(956004)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0dES3Z5RzAxZEg4OTZEYTN5ek5iTytyT2pNTzRneHlxNFUxbVNqeFZ4SlFH?=
 =?utf-8?B?RHJYQ2lJUldpT3hvN2szSVBzdmx0eXc3cVdRQjljdWpnUGlMdWl5L21pMkhW?=
 =?utf-8?B?TEdZU2hlYmk2Zk0rc0hCd0FQOHh2L3NoSWpacU5MWGtwUGpSY25Hc3BBZkVS?=
 =?utf-8?B?aEtHVjBGV2U1NGo0ZGZBTmV4RHAxcWM0NERCd0c5c0wvdndiVnQ0NUY5S1Z0?=
 =?utf-8?B?QlNTeW4xUUlTSFF1V1dmRXJtWGZHbmFqYjNHTTEyeHF4K0krbmlOV1BhTUhD?=
 =?utf-8?B?MG9VbnA3RGdja0dFWlQ5M0R2cmJhTkxxajRuc1YrdEgxMzNIM3RvZ3ROOGdo?=
 =?utf-8?B?T1JmWm1VZ1dyYzZqVEJNZVh4SWNZZVNYN2NjMHBVUE5yZVJaYTRmVjlDWEZP?=
 =?utf-8?B?MXEwMzQzMkp5d2JaREt2MVQyN1B4R3UxbWNOd0FrdTNSTWx4TnJvbkdLUVRv?=
 =?utf-8?B?U1I3b1FwcUlaRnMyY0VGSTZ4NVY1cEdlREZnbzcrRnFDODMzUVdhRXRxK09S?=
 =?utf-8?B?c1h2cmJmbFM1dkgzcFVGcXRKK011UGlFWFRHWVlNd3ZZS2xBZnNmTURUVFg4?=
 =?utf-8?B?VEJURHJVQ2ROQldnTDk4c253OWVEK2Q5ZG4yWDNmMTM0czlNMTlyM0tlS08x?=
 =?utf-8?B?ZWQzaFR0bzVpSWdiN2k4dDJNS3U4cUFMWjVPZk4wejhLMmltVnRBNkRYVzc5?=
 =?utf-8?B?cXI5MVNxaUJqMjRrcUdFazZETWQyTEV1YWdzRzVpbEl0RkxhQ21uNXByY1Vt?=
 =?utf-8?B?d0h0RE9UL05qK24wU2tYa1Y4MnoyOGpjcUR0TDl6WUM2ZHltWFl0YVVQdVpn?=
 =?utf-8?B?Uk9wbW1UQy9pUnJTdG9YaUNMZUpOd3ZpN2hCOUFyU1VVS0pUYnUrbzVNNlpI?=
 =?utf-8?B?cmh2TmlVTklrT1Z1TWc4aDF2dDVUa01LeTNzNUliWEVXOW16di9EYmYxMWp3?=
 =?utf-8?B?QUlxK2k3cWllRjNBdG0zVVRiMjN3dHdwbk5mREYrSkRvWGJHSVNkaURsVHBv?=
 =?utf-8?B?ZEVPNzRpTzgwcWp5Szd4TzBROWs1MXNDUmhRWFpmckpIeFNpTE1VMXMvcmVQ?=
 =?utf-8?B?cW5FQ21Ma2I2Z0k5R1ROUEw4NmJPd09HRm56MWMzdlZNSm1sUUxIRVNzRElN?=
 =?utf-8?B?WDZUdDJOTVJQRTJHSGNSMlhZeFFocFZrOVJjRk11VVZEa0RZNDdocUNsOGhX?=
 =?utf-8?B?b1lBa21rejdrY0VtYlRzYmZValNHcEY0TTNwbnJWdW8xeVZmY3o1cXZiaU9m?=
 =?utf-8?B?RXdTWXovTEZ5em00Zkt5NzJVWGI2bEYwdjhlNXBZc2g1bGZYZTl6cG00SmRp?=
 =?utf-8?B?aUJvczlobU9Sejd5ZU42K3J5VFQzSVBoRWVXalFJNmpIR1RkZDJ6N0RzOG84?=
 =?utf-8?B?MCtQYXVFSUNrRWp6QU9QbWtha1JjOExBNk5SUmIwUzErQ0g0Z1ZHZzZsQSsy?=
 =?utf-8?B?eEJXSGlIWGlpVEpTRWhSeFVsejNkelptOG5ham1VRGRHUDN3Sjl3ZmNuSVQv?=
 =?utf-8?B?Y1dlMzNBNkNOU0E3cVp2WFprSnE2b1J3WHF0SndMdXRTcHY0VmxQOVMvWFN4?=
 =?utf-8?B?RWhESkxic3ozNWpLSWpaY2R5TkxJWm5waU5sN2ovR1JOcTdaWGxQNTNnWTJC?=
 =?utf-8?B?UmVVdlBhYkwwR25vWVhrMGxBTzlzTVJZa3VhRnVTaVFaeGFRZWlWYUs2bmhn?=
 =?utf-8?B?V1ZOVVZsZm0yYlZYcmhndkdHclhzUktINFJ2em9jK055Z0tZeUdoR21oTjZj?=
 =?utf-8?Q?6Esq0mEKkfErYhylulUCMcAzUya8AV4iFaoreP3?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e2b535-51a3-4cd1-0c9d-08d8e3a69ca7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 09:26:40.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qi+nAQlUh/IxUlD6dVKT9iiI+5v7yqUlgP/YEQMz7jN1EalALgzcqtMW+70Rni1NVyVpyOTJ/3rlboeyOKRLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3903
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/9/21 11:39 PM, Roman Gushchin wrote:
> On Tue, Mar 09, 2021 at 11:03:48AM +0300, Vasily Averin wrote:
>> in_interrupt() check in memcg_kmem_bypass() is incorrect because
>> it does not allow to account memory allocation called from task context
>> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Good catch!
> 
> It looks like the bug was there for years: in_interrupt() was there since
> the commit 7ae1e1d0f8ac ("memcg: kmem controller infrastructure") from 2012!
> So I guess there is no point for a stable fix, but it's definitely nice to
> have it fixed.

I did not noticed that this problem affect existing allocation,
I just found that it blocked accounting of "struct fib6_node" in __ip6_ins_rt() 
added in my current patch set. So I do not think it should went to stable@.

Thank you,
	Vasily Averin
