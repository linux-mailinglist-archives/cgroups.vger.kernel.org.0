Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE2749DA1
	for <lists+cgroups@lfdr.de>; Thu,  6 Jul 2023 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGFN22 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGFN21 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 09:28:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27377E1
        for <cgroups@vger.kernel.org>; Thu,  6 Jul 2023 06:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO8gWlzc9+y86tOEFjZO8r1rMjxaDohG49McVYxYzgvWkQ6shclslvsdvltFXPbespA7xjOU48/fW5vAFwlypfYUnFieJVUhLOpjp3GAAordyCy7vpwISqllnFtgudHNDiyM80o3iZUEgkGZaZhnjSqQExjVsCnPvzG9JIWzLathXOALlyqm9PJwXuyZba+8lxEbBaxirq2i/aXL83iwFvnzGT8Cz/zkZF+IHjYDUIqEQ2lNB8DekTaELEaL74EU84WqLOi5zeJoXyFTbBKnml44cSiXQ2kd2UjH3fsAgF3mzkbrkH2njMMkXLOUmPuxudM+erEz2BiVUlz4Hv0GVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9xKj7Pk06sdn8V7DEo12Lkia0TREWf7VNceeMyOmmI=;
 b=KEGqx4ihPAlgBTaIcZ/A9vrkReJ0PhXrcspZAbBwIjLQyo9j+Y7+T89AS3VzDZQVgJoLTKSdMaWvLT4wpu5+RRrnuDubMzEkOLZmYkuLK8Py++Ctz5i2XmwiDuFR8IMZAaTnkCzZ6yVJdhy+8990x0KVrUxUw+r4PQQZ9JTjMJfg0KD96paaevVGSrPUC/k9CQHGg2+QGRYFOYqryVkgeuuF0/1h6R5epcAAAc9KHYG9pHIbwA783y4AtWbzfKfk1nLTC41hICPWm0cnwDxKXaNsgANLO4SzGNDdBt84WYBi85ilqnhvUrkbAMkj0LITmsU09sy/7lcJYCuAvYKGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9xKj7Pk06sdn8V7DEo12Lkia0TREWf7VNceeMyOmmI=;
 b=IJ9MrPsTXIRaIueDbZGh7UT/ez7081gUA2Gj6TKXWPIXh2IvuDn9j5hWjPWK0D2h5AEHWWdjvP9AG+cKVM7xu9TExpwuINCnckU60Bs+y3Z9Fqs3QWqY5E4yBDJpDZKeKd5/e2+Szx9uxfQdgL+nj1jCeoB4QtHdSrD7G9DFVE8yPFP/Adh3rzoYoW0yFSTVvCeJYkflhgKhHwZgTcxHuYd1IOIyJk6mi4RmCWfO0Mj/QBecox/7lGgfRDIsQjvjSjEmE3oVNltSKVP7qwGvAev49lDgptgdQQY/45fZAJeRu6ZLDCeC+XJaAIbmsUmBp4MogtJoq4ytyJlpFuU0bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (2603:10a6:6:e::20) by
 PAXPR04MB8798.eurprd04.prod.outlook.com (2603:10a6:102:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 13:28:22 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::8a17:4a1c:d46:b377]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::8a17:4a1c:d46:b377%5]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 13:28:22 +0000
Message-ID: <d576007e-1e6b-848c-113c-a9365d278c88@volumez.com>
Date:   Thu, 6 Jul 2023 16:28:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        cgroups@vger.kernel.org
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
 <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
 <ZKMehaAF0v-nV1qt@slm.duckdns.org>
 <b181b848-b2c7-4a7e-7173-ff6c771d6731@grimberg.me>
From:   Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <b181b848-b2c7-4a7e-7173-ff6c771d6731@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:802:2::22) To DB6PR04MB3223.eurprd04.prod.outlook.com
 (2603:10a6:6:e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3223:EE_|PAXPR04MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: ff368680-4510-4956-65e5-08db7e24de89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDR4LyviehdY3sTd82N31u9xuGP/A93nOhJqAl40Bba6AjdY//snrdmlUvrGg/Xqhr0wdB5k2N+Udh2GqsfU3YkWw0D5bLffgXjyJhJ0TfiCxu2kQujGmPDXYTdIQOHVRFFKSSdkCgM4MLTIJjVdlPgCzwNxKkwiBExgD+5gsoMGlSBIDLdW0DSDnUNX0hNPBfaKM7cNoXMc7ouJh7cIHFOWSrGsES16qE0kX3xTAeVNci0UpmOZ7aO3BtqzzbJOkqWUzZNPN5ncq4IFANosXdSHmIjXrVNsVH5muLfHR4v4eBNathzY9Pp3qjaOC2z3pdKWWxOesMwXrdNefnIWQczT5yeuCPBiUDHv5F3Qsnu2ALDMjNz7fJJZVnXWtsxjhWi3qe/4/2MIbYyoWI1+2V5HukXzuljh3wfRqFyZsOHjYrl/tFCgN3V2SHcigjfj7JvxnPmhA472tMKazYikfALcN4QdJ8CDEPc16/56o4+rSO/u8UKlZf+u/sn7h8QN/zdK2r3JGJxd6MYYG3LhArBvb357v6Jn3itF2gqpv7PH8Buifj1foYyJcnUAsvWSQAoBrvxBrbXFHs1hi53lbxYM+sCnrY4RA4M0QDmCPzxVnUJVQ72qQ3VyoOFwVXih6mW2d/eV1rwdqDodO4lHhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3223.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39840400004)(136003)(396003)(451199021)(6512007)(55236004)(53546011)(6506007)(66556008)(316002)(38100700002)(66476007)(66946007)(83380400001)(2616005)(186003)(4326008)(26005)(478600001)(110136005)(54906003)(8676002)(8936002)(86362001)(44832011)(31686004)(31696002)(6486002)(2906002)(5660300002)(41300700001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjhjbG1Ob0FaK3A1TG1hWFRyam9DUEI5dGpibWgvR040amd1TjhteVFsMlBN?=
 =?utf-8?B?RXc3UmxXSEQ1NEUycnZOQjNPZDlia2gzRXhTT3lZZklZSFF5blV6TDgyVmJl?=
 =?utf-8?B?YUM0dkNZalRRbUpaSSt5Y2tCZm0xRWZEdm1lT1E4YnlWT1oxYUVKbm1Sc2R3?=
 =?utf-8?B?alMyRXF1SEhYbnIvZ2hRNXBtL3gyMmJwNUJWMkV4bFpQaG8wN0dBUERzdFcx?=
 =?utf-8?B?d2x2S2VnNjV5Sk03SGFRc3g1ZS9ma2Q4ZkNvSkJkbzMvakpGMXBpbVhwMHBz?=
 =?utf-8?B?MGtzOUNKWjAvMHBaWDFKQzgzVUJ2TGp6WE1OQUc0aTYweHpPMVBBeGhPN0Nj?=
 =?utf-8?B?NTRzTlhzd3RCY0lzQXl3d1BVaDlwMkwvcVcxRlFSREJCUVJOZ1lnM1hPR21N?=
 =?utf-8?B?MHJWek40akxXU3FTMHIvZE01czA4RFQrUEkweSt0LzIwcEs4RGxlY0c4U29l?=
 =?utf-8?B?R0IxUXZQbFk1VWV5WkJhSlluNGtkZVlVSWRNcEJwYnNFL2Y5WUlTaFFVREEw?=
 =?utf-8?B?ZWpHQlVXZzlvVmw1Vk5hV3VVRUdqZlNsMmRydmpPRnFBRmt2Zk1jS1pNczB4?=
 =?utf-8?B?bStWaFZmRkZDY2FhT3JJNUNjMFNRV2FNaWlHN1luVmhyTFlQejFHSWplZ01S?=
 =?utf-8?B?WC9ZY2xtUGh2clB0eVlETkdBMHlwdU5ySTVvVmtwQzJESEMyMGk5YlAzcHFu?=
 =?utf-8?B?MkRBcmNyeEdDTUtYRHRra2t2U2JsczErWkFJMEs2Nm9TZmh4K3BHaU1vcFJl?=
 =?utf-8?B?em9LR0hjbUtvUWN1MjV5SDZKVnNPVGNnU1dCRkM5TUNLQktIUWlreVl4QSsz?=
 =?utf-8?B?VHY4bko0Z0ZMOGpKOG1XSWZGeFZZTHEwNHdRQWZ2Y2QwWFhwbHhzQ1pmWGFB?=
 =?utf-8?B?WmRXMWoxQTBrQlU1QUJ2VGhnOXVQMkY0T3dRcVpyV29Wc2FueG1aajBBOXNM?=
 =?utf-8?B?czBVL08ya2t2LzZ2Z0IvaUl3R2RaV0JrVEcxbzZVanBpb203cXdOVVpFcGo2?=
 =?utf-8?B?ckI5Vjl4T2pIWkNXejJGcUdFUVdVN3dPMkFJREhvdUJFOUFESk8vNkRaRG9B?=
 =?utf-8?B?NEZtd3JWenl2NnBhVHl1ei85REppcjFpOE44aktuSWZ6SVlwejA5cExHdWdL?=
 =?utf-8?B?RHpKdHVnb1I2T0lLejJZOUtBd0JDZ2xvSStuTHU2SlZqSWRQTFJkWEh0VXY2?=
 =?utf-8?B?dnZaQVJhUmt6M05tVkFWbnJzR09qSVR2Z0NkMDZDRERSUzZ6b3ZhVHNUcmRq?=
 =?utf-8?B?bThjYXNVRG8waHpubHd4cnU2M2s1cGVwbEQ0YURZb2NXYy9Xb3pKYjhtQWUz?=
 =?utf-8?B?WlR5QkZxYW95bWhEeHNaSmNSTW9kblhTZm9tZUQyNG52N0kwdXQ2Q0ZFYXhO?=
 =?utf-8?B?SjhNWVRTNVg1T3BpQlByajkvMlBXRVNackdiN3JyRmhEZEdaRS9oWVR2czNw?=
 =?utf-8?B?VlBadTh6bldXVVFiWVZ1YlRra3dwVHBkendNekYwNEdva1VMUktySTFjUWRl?=
 =?utf-8?B?R0RHYUN0YXVLWDgvSnZ2RDVTbEUxUEVKV05tUmUyWXZKOTRwdnNJRHVZSHVk?=
 =?utf-8?B?a2loVjhKWUhQSFBxVzczTGxmeEp4ckd4OGhvandhQTZLRzE4VG4wZ0tBWEJB?=
 =?utf-8?B?TVdjRnQ4VTFSZGk4SlFvN21Fcm81bG9iNHVZZlVWOUtmWFZHSHhJTXpVZS9J?=
 =?utf-8?B?UFpEZ25zSlhvbUZwdjQ3UDBWWFVWVVVTOXJvQVc3azFPK1Z0cld2eUN3WjZV?=
 =?utf-8?B?Q3RIbGRoNENNQ29xVEZ6eG9HRVMyT3NLdC9FenhYU2tST2FtaFBsRkpwVzdt?=
 =?utf-8?B?UERRZnkyMExyeExiZVVFRkIyMjYxay9KT2t5WC8xV25ZNTRaTGZKWXhrdGtv?=
 =?utf-8?B?MXNPMDVFd2cyM3BaUlAwNVE4OG5jUDVZU3lUeGFmQ2Y4Z2hqKzlkdEhRY01u?=
 =?utf-8?B?czRpVG9ObzVDUlVuS1hiSnhkT2F0dFBRdXd5UWJ1bmFZTWtnWHd1aGJ1cW1I?=
 =?utf-8?B?SnBHWnczemYxY1ZJb3JjbEljeExGMzNFTXdIenFHSldaWUxEN3F6eFFkZXQ3?=
 =?utf-8?B?TXpYZzQ2Y1VYNTQ3cVpLNFRycW9NSGV4eWIrejM4ZDY4bHZGazRRZEYxQUY4?=
 =?utf-8?Q?bFuhWL9UlQDiKxFXYZHP2r94w?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff368680-4510-4956-65e5-08db7e24de89
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3223.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:28:22.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48gVuWQo6pX4Gi4a0MP9E4zzgX52Qkj8ZwBbeI6prX4U0MCp4xiOTp9dmgoh8e7qvhSTaONFH6xiEGsh1ysaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8798
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/07/2023 10:54, Sagi Grimberg wrote:
>>>> A full blown nvmet cgroup controller may be a complete solution, but it
>>>> may take some time to achieve,
>>>
>>> I don't see any other sane solution here.
>>>
>>> Maybe Tejun/others think differently here?
>>
>> I'm not necessarily against the idea of enabling subsystems to assign
>> cgroup
>> membership to entities which aren't processes or threads. It does make
>> sense
>> for cases where a kernel subsystem is serving multiple classes of users
>> which aren't processes as here and it's likely that we'd need something
>> similar for certain memory regions in a limited way (e.g. tmpfs chunk
>> shared
>> across multiple cgroups).
> 
> That makes sense.
> 
> From the nvme target side, the prime use-case is I/O, which can be on
> against bdev backends, file backends or passthru nvme devices.
> 
> What we'd want is for something that is agnostic to the backend type
> hence my comment that the only sane solution would be to introduce a
> nvmet cgroup controller.
> 
> I also asked the question of what is the use-case here? because the
> "users" are remote nvme hosts accessing nvmet, there is no direct
> mapping between a nvme namespace (backed by say a bdev) to a host, only
> indirect mapping via a subsystem over a port (which is kinda-sorta
> similar to a SCSI I_T Nexus). Implementing I/O service-levels
> enforcement with blkcg seems like the wrong place to me.

We have a server with a bdev that reach 15K IOPs, but when more than 10K
IOPs are served the latency of the bdev is being doubled. We want to
limit this bdev to 10K IOPs to serve the clients with low latency.

For sake of simplicity The server expose the bdev with nvme target under
a single subsystem and with a single namespace through a single port.

There are 2 clients connected to the server, the clients aren't aware of
each other and are submitting unknown amount of IOPs.
Without the limitation on the server side we have to limit each client
to half of the bdev capability, in our example it would be 5K IOPs for
each client.

This would be non-optimal limitation, sometimes client #1 is idle while
client #2 need to submit 10K IOPs.
With a server side limitation, both clients can submit up to 10K
combined but are exposed to "noisy-neighbor".

>> That said, because we haven't done this before, we haven't figured out
>> how
>> the API should be like and we definitely want something which can be
>> used in
>> a similar fashion across the board. Also, cgroup does assume that
>> resources
>> are always associated with processes or threads, and making this work
>> with
>> non-task entity would require some generalization there. Maybe the
>> solution
>> is to always have a tying kthread which serves as a proxy for the
>> resource
>> but that seems a bit nasty at least on the first thought.

A general API to associate non-task entities sounds great!


On 03/07/2023 13:21, Sagi Grimberg wrote:
> cgroupv2 didn't break anything, this was never an intended feature of
> the linux nvme target, so it couldn't have been broken. Did anyone
> know that people are doing this with nvmet?
> 
> I'm pretty sure others on the list are treating this as a suggested
> new feature for nvmet. and designing this feature as something that
> is only supported for blkdevs is undersirable.

I understand that throttling of an nvme target was not an intended feature.
However it was possible to create a global limit for any bdev, which
allowed throttling nvme target with bdev backends.
Today with the new cgroup architecture it is impossible.

I don't see how this does not count as a user-space breakage.
I think this patch can be a temporary solution until a general API will
be designed and implemented.


