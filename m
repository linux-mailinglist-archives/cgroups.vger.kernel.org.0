Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600DF336CA7
	for <lists+cgroups@lfdr.de>; Thu, 11 Mar 2021 08:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCKHAy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Mar 2021 02:00:54 -0500
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:22338
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229731AbhCKHA3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 11 Mar 2021 02:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHD8xlQc469qn3nqBTdDwEOR3yxUCITzobMkPAF2IcfGytGk0hkMKFzA4BTns8B5QRYB2HvePm5d5ujIWkbqoxuvgv37+b13PobGR9LwzjnewcVLUBqKc7gx82MklGVasieVAPzxQy0f9Gg/fV0kPPW3AB2Qqt2HIN9b0ov1a2RDOw/kWjP/tBmA6Y/n5JtyQeLtN+nbSnyI9r0TsXHvx2ZXAAlfyTUQ4+kmxOEk/QOktz+jeMWu7nCKK23o+pPzW0obPxVv3/Osx44YMP7pbQBEWRWhF4OssiT2OrEKJYjWAEgIJueI94wVBqJHO/K22KsgIahB7+lg2tR4xuY4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XPR4e7Qekz+ZPzIgfhEI9MBflHrYmy/+tDff+zpX30=;
 b=FgGZnFCS8brWJEq2Hp8uCq8l5jPBams5R7zPCVyiRYPfVpNBO/IRCzvHZ98F1nvg0PKdjmRMbVMcI3pn1YShucBeGE2nItOawzgq5zLtsrPfuFWaE2W0B7JF+ijqU9t371W1tK6B9I7eWDvRZn4uirjdGnKHLcL7RlOpF/eKBTr74CJi+Zt36vPlyIvBc1H3B8R9vpM/Lzb1lTudGLJbbjbHZgtRQyl+Ax2P2+Fh1DNvUVR+LeMq9TpT0Z/N4QaD3PNpdkNdtIn/neBCiyUsuW9nYS2kY/+e6FyRUPYMlvIQSEUedjlCsNXHeMfAeVp7xVEtNn4wsYDBPNADRVB4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XPR4e7Qekz+ZPzIgfhEI9MBflHrYmy/+tDff+zpX30=;
 b=A+6eWPlIyvvZRRYeZxrKxIlyg3t95fJoF6pdp1ZWgVwLwwgSL6OpY7ciQupLfgVr+oNYMzuIq+bDpb1FfyHZ9jRtn/GviVI634k+KKnc9hGsDJh2OhAQ34MrD8ryvQozONgLZAgOk9EZFjd7n0b4KX2M2bciDnkwDWiTOq4SRcA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB4719.eurprd08.prod.outlook.com
 (2603:10a6:802:a6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 11 Mar
 2021 07:00:20 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.031; Thu, 11 Mar
 2021 07:00:20 +0000
Subject: Re: [PATCH 0/9] memcg accounting from OpenVZ
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
 <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
 <ad68d004-fa84-3d21-60b7-d4a342ad4007@virtuozzo.com>
 <YEiiQ2TGnJcEtL3d@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <24a416f7-9def-65c9-599e-d56f7c328d33@virtuozzo.com>
Date:   Thu, 11 Mar 2021 10:00:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEiiQ2TGnJcEtL3d@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0225.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::32) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0225.eurprd02.prod.outlook.com (2603:10a6:20b:28f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 07:00:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d4b4f5-573c-4c31-84bb-08d8e45b55a9
X-MS-TrafficTypeDiagnostic: VE1PR08MB4719:
X-Microsoft-Antispam-PRVS: <VE1PR08MB47197C44ACE4B9B9165F9654AA909@VE1PR08MB4719.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/h0Jgzmx953SdhVRGV/0gHhyUjoIgGA6Q3NbLnKz16movPdOoMZnct+sUGRLoRYY1ZMxo3UtEtDNVB/NhTo0fwFezXi0xdhwEKV/Pr0fLmz7O2JrZW+K02les4vIuKoFm5z6IrtldMJFs/J0UqPetvB7ZUT1S+gbmnt/A3ws7BlMNjbMdeseRM05zW+gKlFdBzxzf430G6/a2CE7VF0hhr7QkDy1sPoj/KxZ8FzZHznvovwy5+j2qA8X1NjQJ6T61tjUlZZByXA2ZbV0E26LKNH4dRDe2ccYR1K+3v91uVtN5n723ANRK8ciCq3sLKAehfmTJrpEqyJ4Xlrrbj3n/vwdYzqmTo63qx18UoiIEPpN5np5cP2nzdf96uGKdJYIS9eB6h6yNFux1L+v8OrF1ttkh3dthuixzH8yLcFjBs/YZS8j9FNTGS8RUobjdu1MN83VUMsrgoJStn2hUTeDSY21UY1WDuLpOBEKKTZYSg44IokzuRZlGOZSRFZzajcrITgAJ66IBRIVXKf08zqDHlYiBaPtai9CarruNh3yrROE7ekkx92moLg6lZ+zR3dqHqOPoX8+i/Jcf0R7S6hURC3JYQIefyBMq2JR64lYHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39840400004)(346002)(376002)(396003)(31686004)(16526019)(6916009)(66946007)(86362001)(66556008)(478600001)(2906002)(54906003)(316002)(956004)(186003)(15650500001)(5660300002)(16576012)(26005)(2616005)(31696002)(6486002)(83380400001)(52116002)(4326008)(8676002)(66476007)(36756003)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTh0Vk9vNzNidmxDaC9QYW1Cc21mTnJ6bS91NkJoVnNjbnJCcHFaNmZXdHU3?=
 =?utf-8?B?M0hpcXQ1d21YdDFNMHZYSk1aakZtcUVZclVQTFVhak5jSTNka2NRVTBURzYv?=
 =?utf-8?B?RFg4MTdLYWkxcXBmMm5VcjlPT3ZLWmFzR0x4Tm1WMHhwOWlzRTNXNmV6cEVq?=
 =?utf-8?B?eGJ2eXJQcDc3QXI3ZEtkQW1nZ0ZDV2hiQW55Y29mVzdja0I4VEJjT1VvT25o?=
 =?utf-8?B?UzJ2V0FkZW9sM0dsRVExNFIyVzhDRDlKQUFpSi9ocHJJcHlmTTRaYXh2bVRD?=
 =?utf-8?B?RmgzdnVpV3hsdlF1ZTAzdnFJRWlWT1dYWGdTRWVaU05IZXlRVllCNGxkdzdi?=
 =?utf-8?B?bWMyOTZoZERkZWJuTzJUaWZKZXZWRHZnZVRoNzVsYU02ckJNUk5YSnplWG1W?=
 =?utf-8?B?aWpKcHJXa01yd0czVE95OU9sZW9BenhyUHp6ZW0vQ0ZwT0s0THUvWThZVGl6?=
 =?utf-8?B?SnNRTHBVbUNxcUhBV0xXOVBOQzRzNlBWNUd6bWdxTW55SFhnT1pnUGZMaEho?=
 =?utf-8?B?cElSbGNEcnpRWHdNVkU0eWplczhXc3V0M1dtb0s3NFRVcDVQVXJjQ2hwNHZn?=
 =?utf-8?B?dUQ4R3ZLUjZMdGxUcitHRk5PaW43eUlPVUNYcVhkekJkOHYvZzl2N2dYQ0ZU?=
 =?utf-8?B?ZHBGazd1Mk9SQXdZdElqcmdDenpTbjg3M0VTU1dFU2dlY3dGY1plNVpockFi?=
 =?utf-8?B?aHY2SndlalVIMG1pcnEvSHZ5U0NPM1FpQXhSQXN2U3NJVGVSbDdxSmw4R2p3?=
 =?utf-8?B?aEJudzNyZmhFcW1YTzAxOHRiR09BQUpzaXBBcFFidDhxWHhHWlJaNkh0VTRJ?=
 =?utf-8?B?SUpOOW9uaFQ5bTFTMGZvM3pJbTFEOFEwUW95SThNZGdnN3p0cStSQWc0NERP?=
 =?utf-8?B?YmtXN3JEOHM2UUt5dWdCdkdLOGFjckRhaDdHUk56Z0poNUcyYVIvU1N1TURY?=
 =?utf-8?B?b3l1a2hVZ0QzR0o2V0JXc3BITlhZajRBL2lBbUQxRFBCOWxuckIyN3hyUnZl?=
 =?utf-8?B?TVFmVEFTajd0TWVDTFZKa2xuQjB5QkVoRzVYUHRBamxGN1l6NWNLa2d3TzVS?=
 =?utf-8?B?L216R2VRalR3M0lHSmkrY3RyelhzUlJWbFBjKzg0cnpvaExhV2V6eGtsK3pr?=
 =?utf-8?B?UFlhUGNtaE94TjlJUlIwV2J1QU9pcHNLY08vOHR6SXNjNGdtVElrMHFZUy90?=
 =?utf-8?B?czN6cmVPRWNIRHNwZ1I0dGZBYWs1cHNvS0VqdWVDdE4wZ25sMjdKVEtaZTVZ?=
 =?utf-8?B?RlQ1eXZ5Mmpndi9mQWFTRjhRZFJFcUhmdE5vK2t3QjJDK04ybldGNVY5WEFo?=
 =?utf-8?B?WExmNnBiWnJQdlhvZy9BRVM5b1d5SFlvaURRcm9vM3NaV3dHMU9qYk14b1Fa?=
 =?utf-8?B?M2JXekhmU0dBbzMzcGZ6YXBrMzIvU1loU3V5dXVia1hucCtJZE1JTHdYVXUz?=
 =?utf-8?B?dVFXZTV4VGZ3b2o4RVdvandGcER5ZXc5WXFEaDVMNTdCbnFIL0M4eTlsWm9U?=
 =?utf-8?B?MEtZcGlVbFNjN1hLcXRaMEpNOC9tRmFMNkRaTzlmT0d2VTRrdGhoajRNMmZY?=
 =?utf-8?B?SDlaK3VxTi9BV0JLQjlISURMbHRmQ1NvcmVDRmFEQ0NTWld3ckNCS2RCWFNx?=
 =?utf-8?B?dE5aY25tTkJJcFJVb0FhUlcrdzZXUUp4V3dHOEROOG8wV1ZXTlNJeGlhbm1r?=
 =?utf-8?B?NDFLNEFkbjBaSVhaRlhYOEZ5S3FKdEFoQWg1QjJvQlRTSks4SmJyVkkyMkkr?=
 =?utf-8?Q?41CangvWlzjp0CGdUjD+Y2A40PoQA1R+1XNoSNG?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d4b4f5-573c-4c31-84bb-08d8e45b55a9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 07:00:20.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od4ndQS2WBXJY7n4SKbAbmYRPxPNC8ZRf4b0K2RHu6eSSGeLiueEGBDQIWlkYESp1DzgVKx3hXbUwXu9pohJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4719
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/10/21 1:41 PM, Michal Hocko wrote:
> On Wed 10-03-21 13:17:19, Vasily Averin wrote:
>> On 3/10/21 12:12 AM, Shakeel Butt wrote:
>>> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>>>
>>>> OpenVZ many years accounted memory of few kernel objects,
>>>> this helps us to prevent host memory abuse from inside memcg-limited container.
>>>
>>> The text is cryptic but I am assuming you wanted to say that OpenVZ
>>> has remained on a kernel which was still on opt-out kmem accounting
>>> i.e. <4.5. Now OpenVZ wants to move to a newer kernel and thus these
>>> patches are needed, right?
>>
>> Something like this.
>> Frankly speaking I badly understand which arguments should I provide to upstream
>> to enable accounting for some new king of objects.
>>
>> OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels) 
>> and we have accounted all required kernel objects by using our own patches.
>> When memcg was added to upstream Vladimir Davydov added accounting of some objects
>> to upstream but did not skipped another ones.
>> Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
>> "skipped" objects by our own patches just because we accounted such objects before.
>> We're working on rebase to new kernels and we prefer to push our old patches to upstream. 
> 
> That is certainly an interesting information. But for a changelog it
> would be more appropriate to provide information about how much memory
> user can induce and whether there is any way to limit that memory by
> other means. How practical those other means are and which usecases will
> benefit from the containment.

Right now I would like to understand how should I argument my requests about
accounting of new kind of objects.

Which description it enough to enable object accounting?
Could you please specify some edge rules?
Should I push such patches trough this list? 
Is it probably better to send them to mailing lists of according subsystems?
Should I notify them somehow at least?

"untrusted netadmin inside memcg-limited container can create unlimited number of routing entries, trigger OOM on host that will be unable to find the reason of memory  shortage and  kill huge"

"each mount inside memcg-limited container creates non-accounted mount object,
 but new mount namespace creation consumes huge piece of non-accounted memory for cloned mounts"

"unprivileged user inside memcg-limited container can create non-accounted multi-page per-thread kernel objects for LDT"

"non-accounted multi-page tty objects can be created from inside memcg-limited container"

"unprivileged user inside memcg-limited container can trigger creation of huge number of non-accounted fasync_struct objects"

Thank you,
	Vasily Averin
