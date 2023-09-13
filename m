Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156279E4FC
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjIMKdf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbjIMKdb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 06:33:31 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2109.outbound.protection.outlook.com [40.107.105.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC619B0;
        Wed, 13 Sep 2023 03:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzcrJM79+T/iFro02aUGmY9dd24i3Y/BO1EHTEBUhafH/ibsjcYpJ3nH5WwVt5sA6ZF8VlldvhV7WLg3Sa9l9D7QUiJD499gOvv1aq8KUPS3oA0VJgN4I2XoApv1aUYmJ5eGMfUlyZCiDEVDCQ5/cJ4CJcJSKE1slAg6/8JGnPiD4H0/82Gh6Sb3JityQHAEG8O/NDztZXkBNe9NRxkyqHOta+fzCQMqyfVPTkPsCCfLvsUW0mU4GJ/lKt2iK0tkXg9I168bMviv1XMwLtEiFBq9fRh+LNHNLY4eg7LokMLjnCbupAqpY9ubyHzXJ5M6Pv+epz/9g3ffyNEED37lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekdn15n92GL4zx+tdFl3RKpQXUo/DkDvzH68NHWVF5g=;
 b=N/UrzPPF2FG02+ARADlVtbHxhh8qEJ+/kU4eoOkV/Xmzd75OmkSdBzLwJvAYZD8v5rGyVUBUXj8epQrxv8RoxXCyAm+rsnUHCf47DQocgdT1rb1A56/gMspDGPXXRHlAja1oaOprjaDB0U5taPB9EeIVRo4vTdCTqXjoTUjwATHwBwyb85eVy6qj8E+F73DN3Ca4zLyNHud9A3HFRFZSpqPQkN96lPBeX9ZWONrJ7koJLp+6cN3StrEcZphxJUXqTLafL0Wq441Zl3cxq9F9uCgVVKNAH6ZtEx0j27lzuXIarK8Kj0v/nYr5PBbkIkqI2CUMqjdUtkvll/le9+wW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekdn15n92GL4zx+tdFl3RKpQXUo/DkDvzH68NHWVF5g=;
 b=WjUGBP1saJ98eIlMP3dPdojAHc52nxjkzsGfLbpTIoilqEYVn8mXKimgdnppbI2UV+QwGmTtlOYTHHdhbIxHCE6WXQOOWCZAjZli5NJaJPXPT8QQlZwyURzFpFisvptF9VhnzgzW628X2ew6RnpJXYzl53Kh10QZ6LQdCJOuEqBC0h/s9QFtcN/j/89ZzEzJkHklinyCcya+XpGVFKq0TIGHzXk9qkvb98pAeBOTSVSOoLG3rRRd1wSMWfPLDh36gBopU8o4kiAE71nBszhnz5vxYBNDPjJotBThAy8teTjhLEEX/jzk55/YOpFd2eA9u/jhUQpJczXvEcMcPNx16g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 PA4P190MB1040.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:101::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 10:33:24 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 10:33:24 +0000
Message-ID: <476c3048-0009-4ac8-bfd2-40411a4ec094@nebius.com>
Date:   Wed, 13 Sep 2023 12:33:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs
 files
Content-Language: ru
To:     "tj@kernel.org" <tj@kernel.org>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        NB-Core Team <NB-CoreTeam@nebius.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrey Ryabinin <arbn@yandex-team.com>
References: <20230911075437.74027-1-zeil@nebius.com>
 <20230911075437.74027-2-zeil@nebius.com> <ZP9itivlZQIb5wZ0@mtj.duckdns.org>
From:   Dmitry Yakunin <zeil@nebius.com>
In-Reply-To: <ZP9itivlZQIb5wZ0@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:3a4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P190MB1860:EE_|PA4P190MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: fde70779-8bfb-4078-cef7-08dbb444db91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbWzpZj6iqB3S+DdYS/6x46rJ3ebML9UHZpuXP0WA3YahcUdyuH9/Q4jROA/ROyr6MPDiJ/eHEQ4FE7lxXUb+tqvcms/RLJxIm87Vf6EXsxkNV89DSiAtI4oiPaDHBjIprENvPt7NzFkcsLZYUY0yrJ4+3IQxNQhkucQERCBjricWw/KVbx0mU1Y7u2qPA8gKVQKavOwgKwiB8o17p1FkgtJ+aFzXWLI7KzR4abgQwkYoY1ozD9nhvuJMpSY4pp9rW05CET2fabEEhdboJ2xazPcTsFKCde4fpmjyUBzXpkbWgix4dJ4HaQXQHKUci2p/BtIXVeF/KKVaMrLpE5gO7qtOnvBQBSnJqEZ8qY6seMiu5vd/xv0XEiPdhT6QYz8FZgCVtXGIzAMlv+nASLNTu4bfaxBihyF63fEmhbTj/RbeKH59F88k4klrmjBV9kHAaSOGhQmqaz8RUXIoHUB4anPRPS76M6HsYKQWyefImIQuYFOIch0/u96AWkumEFWU6TUXcwOhRU40A8BhpwqQ3mmoLEPD8I8C101o7MhRMqlPOJb11I3IZ9n4acejUQL0SwNTDIW84JcRhP3ANfDKKn14RvnpTr7dKuqrRZdZ/E959oCcS5XYfraYAu1k3ZaewoJ520IDMluVBXlER333A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(186009)(1800799009)(451199024)(6666004)(6506007)(53546011)(6486002)(6512007)(478600001)(2616005)(26005)(4744005)(2906002)(6916009)(66946007)(66556008)(54906003)(66476007)(316002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBaVW1CWmhZN0tFUzBwVGlsdjdVbVFxSXBxck5uNGVlTUhFNmEwRGgvUE83?=
 =?utf-8?B?MXpsUnBPbXhXa1k0a0tIMkorWmlFeEpoSGVOczluaUpLTm1LaHE4Y2RWa2dl?=
 =?utf-8?B?WVVTbG1jRzhSUFJxeElrL3RTUS95STF5K0RleFovMFdaRmpla3ZxZDhhWEtV?=
 =?utf-8?B?Z1Q1WFhTc0RENk4vcnJFbGYrWTEzSHhuTEV3MFZ3NktiWWVJOGxlaE5MUXpM?=
 =?utf-8?B?a2FFV3pDRGVpOXp1OEU4SkNOWVFvc0VSVVZyYStIanhqOXkxSURudXB5eTRJ?=
 =?utf-8?B?empMTUtWek95bFpKOEdLVU5ZQVduaklYWUU5ZHBaMVIyWnQzMUpiejFUa2ds?=
 =?utf-8?B?VlduMkJBRFk4Z0xUWEg2cDJ2bExyZlNjOHBjZStEelVoOUEvc3dLY3pIVVRS?=
 =?utf-8?B?YjhvS1RXZ1JIMG01WXNzRjRkdXkxdURCb1JoK3BuY3BDMHV2b0gyRnVkbnZu?=
 =?utf-8?B?cEYzU2FxOUlMZjVGdUg1OXQwQlpPN2tsditGVHhnSzVvL0ZPTW5MenBZMjU3?=
 =?utf-8?B?NFZyNzI4WFpZS21VdUNKT28vNXdDY2o1dXdFZWYxaUlHclplbU91dnVvL2tw?=
 =?utf-8?B?ekQyNHBQNUZSTklvWmVicUVzMzhQM0MwTjhaWENzZk1LR2E4aW9ON1NiSGRI?=
 =?utf-8?B?emloSnFqUkYrcE1lcHlQcDVkbHorWk1BTUNTbnFGTzN0TW10QWJqSlArQlRE?=
 =?utf-8?B?L0w4Y2tJcGtuN2RhbDNGZ3gwM2NrTHNyNVF6eUJBdU9QU0lpS1R5cVJHRjZa?=
 =?utf-8?B?Qkg4NlI0Rk9XZlNacGJaL3A5TFpSRkQ2NlpyQU4wcmFNaUFKVjFkbXNNNXY4?=
 =?utf-8?B?NUtBbjFqNC9uejN6Y1EwRnkwV0NxemhOMTNGVEpZYjNCSFNmc0pBSzQ3bHBJ?=
 =?utf-8?B?UU9LY1RrYWY0S25GakNUVnQvSG9IaTNDZitrcWs2R0NKYndYVklXMlZNZHFi?=
 =?utf-8?B?NjhMdWphc1NWUm9zdlNqbDhhU1hONG0wMy8yOEt5Zms3eVpidWhpWU1oaExa?=
 =?utf-8?B?bDRhYWhBUE5pb0FCM3ZMSWdJQy9vN09mMlhURm45dTRHemthYVp6aUNhOXFx?=
 =?utf-8?B?eGd0ZmR1UVJqQ1VKNlk1RVBueVVxcXRNNmJWcEpoQ0hFWGd1WFJDQ3FtSXBD?=
 =?utf-8?B?V2d5OFRTc0dqNytIMVQwTXRkUUZlbFk4SXBGd1lvaUFDWVVLYjFCcURqQjdj?=
 =?utf-8?B?NHd2NVc0S2psNys5YW85ZTRySERJRXBkN3VjZ1NXeWEzQnJpYkdpU2tRckZF?=
 =?utf-8?B?SHZCSGtjN1NiNEZyc1JpbVkxK1NOWG1oMFVvR3REeWVPZWV4R0pzTHlmVjJh?=
 =?utf-8?B?TmQ5Q1hldlN5OWg4UWhIdlF3WmthWU1DcW5GMFFaLzFHMXBNUS9xRFFibFFX?=
 =?utf-8?B?NmozeXNFdHlDcGp6TWlMWjdEN3h3YUNINTdYd2dhVzNRdXE4VFozeWZYMjJR?=
 =?utf-8?B?ZjkrcWd1cnhHNzFkR3UvWThvTTYrSUlaQ1BuQ04wTHMyQTA0TW51UHRrdE04?=
 =?utf-8?B?SEJuOFFuK2kzYTlHZHFUS0RRYXFFMHNzSzJGV09JSXlNU2ppN3V4SkVvY3RP?=
 =?utf-8?B?ZlhBeXU0S0pwWmlGMTRFL0JpRC9NeHZEUkFDK2FiVnFnZ1htWnpIeWl6eTdC?=
 =?utf-8?B?Mk15aUlRTEljdTkweVpIZEJLSGFWV0IrY3k2VzVVMXdwVFd2WCt2bDA1azky?=
 =?utf-8?B?OFZnYXQ4dzdURHVraGhIYUx1M2xOekZIV2IxMnN1cTBqdkwvR1FlbDdNU2k1?=
 =?utf-8?B?L1RaOTRNM2VjT1QrMDd5YXo1NG9Pc0h5QVNyWm4yeEUxYjFRUUREZjc1dmRD?=
 =?utf-8?B?aE5HS2FDRkMzNDRoVTJLTVBrUmNaZ0Z4YXVRY0UrSXdZVWgwYy8yd1pjSmhs?=
 =?utf-8?B?bDVLTnJMeFI3T0oweTZOV3pGTTBMbUo4Ymo1dHVnNjJmSmhlUjhWejdRVlMv?=
 =?utf-8?B?RHEraDMyVkl1R1hVNHloejF5b2pKVDlQUlF5NkJGWW0yL1cxNW5nV3FMRk15?=
 =?utf-8?B?YlJOWC9SdEo1UmhQTjN3QVdiVU42M2h2bFlGV1lwU0FsMlpDSDZObHRpcVBn?=
 =?utf-8?B?d2ZDNDVNdlE0ZGtjakdBN3E1VThKT2FVVmh5Z3ZYdEJDblhqdkEyRzBFQXV5?=
 =?utf-8?Q?kavvjHg00ev5G8843wCRbVLjQ?=
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde70779-8bfb-4078-cef7-08dbb444db91
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 10:33:24.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAKXybK9fu8zDm4CDVv8COOCSspP3QvBLLmbIPMO5p4/TjhAqzdrjyoMHNXp5MPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1040
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thank you for pointing out to drgn scripts in kernel source tree, didn't 
know about them, I will take a look.

On 11.09.2023 20:55, tj@kernel.org wrote:
> On Mon, Sep 11, 2023 at 07:55:15AM +0000, Yakunin, Dmitry (Nebius) wrote:
>> +static void mem_cgroup_css_dump(struct cgroup_subsys_state *css,
>> +                             struct seq_file *m)
>> +{
>> +     struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +     seq_printf(m, "mem_id=%u memory=%lu memsw=%lu kmem=%lu tcpmem=%lu shmem=%lu",
>> +                mem_cgroup_id(memcg),
>> +                page_counter_read(&memcg->memory),
>> +                page_counter_read(&memcg->memsw),
>> +                page_counter_read(&memcg->kmem),
>> +                page_counter_read(&memcg->tcpmem),
>> +                memcg_page_state(memcg, NR_SHMEM));
>> +}
> Can you please take a look at drgn (https://github.com/osandov/drgn) and see
> whether that satifies your needs? We can easily add drgn scripts under tools
> directory too (e.g. iocost already does that).
>
> Thanks.
>
> --
> tejun
