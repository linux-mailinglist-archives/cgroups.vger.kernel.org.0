Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D3742962
	for <lists+cgroups@lfdr.de>; Thu, 29 Jun 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjF2PVo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jun 2023 11:21:44 -0400
Received: from mail-vi1eur04on2132.outbound.protection.outlook.com ([40.107.8.132]:32179
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231778AbjF2PVl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Jun 2023 11:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV64USKxm0uEhjTwVgwlnQSunDDSg3uruwmihbruY0xG5NWrexUbz3hEtx6xXGaGh9JFQMnQjKHCQzuhBU4nQfOFO1zB+DDpTfce9KA2SQKvgCNVERVjOuM6+VA1Cu6fxmTezfDJpjQx9nKM8est+BEEoDAje1EY4UoqSICYzS/9L+aWjnza1v6gcYD5mi2HSxf0NBDJOEM3YtK4INogs7WplAfo+ta4b8VcbwJq/IM/MhTa54lBllF1Kq3Fyrl+CVIAdhy76HWBZBmVEHs8JrJBXMefitWi2JHLtm9dHyaDFAnt2/WqEA1pfHMW+qKR8mBgL+Bn60RulAui32Y5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+MMVO/dqjwV1A2wjcuyWZSsEAaTmHE1YpSZ36251Ow=;
 b=LvY9HgkQs9Qv/VzSqH+0uCksNj1quQ0ILOYa4RFkWsL6zupb5bxC2idg/FISuejd/Xki2HzgLdnwSVupPmrmMTJkfX8Zz92f5ma2rj11+dH1yQycr7K2gL59mOaVMJpjxWhw0h9kxBxmAK0Yfq2SiIqaO6pQsRuEG6YyEkV1aP6Z0EVX1bapkCQ+ais2hkY33L9RYZCpKE1Cg5oFt5X35DhbIMSTIZxRLPxUiefKrFeRoOh8AHdIV+gm/WcMfLpAFB+Yv+4sNTVErlozXESZQOAmuK98PIwwbCTNiovtW72+tAsiBjXJ8pZp3W3Ugp6qN/ISSwoRTVp8bUOZ6/JCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+MMVO/dqjwV1A2wjcuyWZSsEAaTmHE1YpSZ36251Ow=;
 b=cVWPtNYHz7p684ZEBKwTZQ9DcofpySGBTp2bbB18aRRdVX38FJ7qkSme+1IsbiwV44wDakL8epTryohyrm9lD/U8nThZZsRKdVpeRvubvZDjvmmZaZPGXwxZWG/1yFz0QnKimmDG1bAAgFH5VO1XYArEYitJEK+K7wKOQcbmIyM6gr6YfJpnoSdncC1RrwTbuITI3UTC7j0Fd3pgwQWrAA+x+ZYVC/QGLGwf5u4iydjgwd9kOd5XZyV+xkW0FHDqAvpF0HZ3EfIXjcUxy4KLe8KRg+UT/5gUSUjNQ5TcuGrcxFwhtQNch4Ox1BnntFKX8Mg0068KcEJUzStePuJukg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from HE1PR04MB3227.eurprd04.prod.outlook.com (2603:10a6:7:1a::16) by
 DB9PR04MB9773.eurprd04.prod.outlook.com (2603:10a6:10:4ed::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Thu, 29 Jun 2023 15:21:38 +0000
Received: from HE1PR04MB3227.eurprd04.prod.outlook.com
 ([fe80::2e7f:1eff:dd5d:86c7]) by HE1PR04MB3227.eurprd04.prod.outlook.com
 ([fe80::2e7f:1eff:dd5d:86c7%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 15:21:37 +0000
Message-ID: <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
Date:   Thu, 29 Jun 2023 18:21:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, cgroups@vger.kernel.org,
        tj@kernel.org
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
From:   Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:803:104::26) To HE1PR04MB3227.eurprd04.prod.outlook.com
 (2603:10a6:7:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB3227:EE_|DB9PR04MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 352a41ef-320f-4a37-631d-08db78b48812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8grZV9Vp+y6YNxAKx9K1xQNGLWS6AqTM9K8tEKiD/uWRgfB1xQokwZDLf5nl8Pp/rUHCQpfY//z/RKL+i6JRcUZEUVD6pUvKQAk2SQ1mAiACfhlHrTZYOquPkzCnsSPyG/ZBc2UnrXlFC5aRqE8Lu30VKjaOKO4WAyghZhHyQoTOKbepi3CD7UrX8LpM77OFFwZMJLqPLFdvcK2U80+v0GclSNn9BTyxHOmTTxkfPe/Jv84xWM5nhv1Q368j3amoFqGKbBovndAv5tFe6k+6Rfkz931eC4ptQ+uw3g3184uvRYR1ds27zXS0mm2WjsAS9Auguf9DU7T8RGqdGIre8ESbr0rl9r8GoU8fYWDLunTwSBdR7EHznVT9rKkWkBIxyVYBm6lIc37Lbqjwmc0Gt+ArjihCc2L6BKZibTRuMQ7g/JwgmTdwquUnPkAuZt2UW+m8qHk7R3quAdeZp/SVJGIlUCGohoa+727A3JHc5xcSPsUe/mRDSRl5ciFH1mL8SaoGLZkpfM8VojfC9EHpoCAhN2RGUROuNEBhJyfEtluf3zofCPSv4sqTVLvxaombcYU27HIHj7/k0Ds+/UqQFWjwXTEf/ThO+KP/SYV125+pwWUqzxQRLRUNat6FFrOGb9WdOhaHAKLLCwoVD9ZQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3227.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(376002)(396003)(346002)(451199021)(66476007)(8676002)(41300700001)(66556008)(316002)(8936002)(66946007)(6506007)(6916009)(26005)(186003)(6512007)(55236004)(53546011)(966005)(54906003)(478600001)(6666004)(4326008)(2616005)(6486002)(2906002)(5660300002)(30864003)(44832011)(38100700002)(36756003)(31686004)(31696002)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJ4eWtQY0pxYkZCdHdRNnpDV0dzZlM2Rnl5anZPc1UvTko5Wm9tUHBOOVJT?=
 =?utf-8?B?b2RzRnVWNHp2OFRDa3M5bE1JaEpocDFMc29nRDBqY05sKzlaN2ttUEdIS3Zt?=
 =?utf-8?B?dm9GazI2RHRDUTV4SnZ3empTZlZxYjZENUJRRVZRNzNjdkFIWXd3Rkp3ZmdB?=
 =?utf-8?B?Zllqazl0bU1JYVg0Q1dKbjVNOU9rSjZ2cHRCSUx5dWhneEMxd1RNaThkcDRN?=
 =?utf-8?B?NnVyZm10c1FhNlpXYkYrTy96aEpMZWZFWVJCc2hhdzhVcExBcWo0ME9McWEv?=
 =?utf-8?B?ejMzMXI5MVFON1ZQZXVxNWNFc0RlaDZZWmpJeGlyZzhnQ2tJOUd3N1VwUjdP?=
 =?utf-8?B?WDdZQ0wzL01tb1liakMwZi9JeGNJT3ZyODVCd2NyR0NPNEtBV1FXNU92MDBo?=
 =?utf-8?B?b2tNWUNxaHdMR1NVK2ZUOHNYVEpUanhQTjNTdDZ4ZHdseE1IbTZCazBCYW1C?=
 =?utf-8?B?R1o3eUNWSFZ6djl3K2RBOGpwZHFxM1RKSTc0UnFZK0FvMUZZZVVOenNFNENF?=
 =?utf-8?B?NnV1ZEpLWnN4V0ZQZ1YvbHB0OTh1WU93cmtBU1NabnVLbXNDaUFjdGZPTGY5?=
 =?utf-8?B?VmYrbGNTOFUyK1QxbXRTYzI3WTZBaitydUVMOGp2bm9ibUhQRHJkZm5QRElk?=
 =?utf-8?B?RWxwRXZBc2Y2bWFMQ0kwSWhnVnlXWEZDc2VHZ3diMWswU1MwMCs2NGMyWHFS?=
 =?utf-8?B?Y0FpVGdEOE8yckF0b1hIRFBkc0kraXZIZlpDYXN1OE42NjZQTXBhUjAyQUZZ?=
 =?utf-8?B?Nk5zVEthbGRrZjR0SU1RQXlvVTE1Q3dvVENRMzRVbHhaaDVPbnh3Nm9qTVJK?=
 =?utf-8?B?djZXcitOL3N4Y0ZZSzJ6bVBGNG41UnJsc3FZQVEwdFlZNkFRbmk2RGZPNkcw?=
 =?utf-8?B?Nm96cjFYMVdwRWtXODNBcC95QytxSGs3ZlZMVHhFYTdIaTJWYUhJTWdLZGp2?=
 =?utf-8?B?dWRDR2dRWXRiNDFFUlAzN3pOOUJPcGJwampwVWtzUzB5eVJpNnpQZ3MrTjZV?=
 =?utf-8?B?UG1YdytHVkljWGc3RU0wRHlxTCs4cUgreVFIdkE3b2NZM0NOYkpzWCtOQmlu?=
 =?utf-8?B?STA4MWNkNVlsY1BDY1Z4c1Y1K1lBcGFzZzVQQ3ltaUlyZVRiOGFXZVkrL2Nv?=
 =?utf-8?B?NVlKL1Z0bUtNa2lJVVh1UEEzM2xGb0FhRm9OT3hrdFpnZlBWNHlnK2xhTVhr?=
 =?utf-8?B?a2E1RVl0YzJoU1AzVFZQbFg5N29sdUJUdktPK21oWlR5YWZJdi90YW14ckY0?=
 =?utf-8?B?SUg5RGNzS1N6SzlQWlg5RkUvT3RteGc5UHpKT1F2WVhCcU1tOThCaEVKNHAr?=
 =?utf-8?B?TXoxb05XSkpiSzYvU3dWVWpBNnJNaWdSK1Y2NkJPbjNFV3ZtTmdhR3U0aWxw?=
 =?utf-8?B?UitOcm5Pb1F2allFTDhnNnhFZk9yY3ZaRGpXUFUrWU1tNVc2Z2FkNitJOEZh?=
 =?utf-8?B?MUhLTGp6RDQvdGRodjFLd2FUeXRnNFBPdnZYKzUzbFBlT29UK0lEbGl1WTFx?=
 =?utf-8?B?UWVGZTdOakNSa2xGQUVtc0c4c080dk10UndtQXJscDlyR1hFR2dVM3YzQlg0?=
 =?utf-8?B?Qkh1dWwxVG0wNXV6T2tRRXlraDNMRG00NUtzQjYvNllVZ3RzZTU5eEthSVlF?=
 =?utf-8?B?Q1pLeEdvZGpPWld0di9XRXhYcCtQcDdTWjBnTlVoT0t4enE1Ry8zWDA4M05I?=
 =?utf-8?B?bnhvdDd4bnVteWMvc2kwVTc2UDlVSU5paWpZUEZZT0QxVVU3R24zSHZpeHBu?=
 =?utf-8?B?MS82WUdjY3pydXpsNzVzbndPNjFRdmZCOU5TVHVmY3NzcjB5L2hqV1NabmJC?=
 =?utf-8?B?TUxkT29PWG9kRWxhdjhQTTd5bU1vODgxQmVVdm1YT01tcXcvYW5MRStCVjRE?=
 =?utf-8?B?Nk9HYmdhZkNUa0tOUzU4WTMxSkxhSkxUMlkrZmh6azJ3cTdJaWFYS2tBZnpT?=
 =?utf-8?B?eHh0cXFBMzU4bFVVYXFSM0NoSmg2MkJPZER6M1BHVWtTRm5rS0N0U2F6Z1Y1?=
 =?utf-8?B?ZHBBaDl1cXU5OWxWQmFHY0FJWWRuc2JKTFJhenhBZjNSUmJXbStjYmdYYnd3?=
 =?utf-8?B?Y1BsNDFJdHRUL1d4YW9hV1FSZ014ZndLSTgrTTJJTzhqSGtnUkJJZW5pUXJp?=
 =?utf-8?Q?IK5ibCJl30CpHQZEv41DKtPhO?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352a41ef-320f-4a37-631d-08db78b48812
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3227.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:21:37.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnnfpdOUpaa7BVHjaUNF+FnMxiSYBztGxHhPAK7HKNvki3abx0cVVEOXEgjDOn4zjDcB+aA1nieIM8J4mc0byQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9773
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Sagi and Chaitanya,

On 28/06/2023 5:33, Chaitanya Kulkarni wrote:
> On 6/27/23 14:13, Sagi Grimberg wrote:
>> Hey Ofir,
>>
>>> Currently there is no way to throttle nvme targets with cgroup v2.
>>
>> How do you do it with v1?
With v1 I would add a blkio rule at the cgroup root level. The bio's
that the nvme target submits aren't associated to a specific cgroup,
which makes them follow the rules of the cgroup root level.

V2 doesn't allow to set rules at the root level by design.

>>> The IOs that the nvme target submits lack associating to a cgroup,
>>> which makes them act as root cgroup. The root cgroup can't be throttled
>>> with the cgroup v2 mechanism.
>>
>> What happens to file or passthru backends? You paid attention just to
>> bdev. I don't see how this is sanely supported with files. It's possible
>> if you convert nvmet to use its own dedicated kthreads and infer the
>> cg from the kthread. That presents a whole other set of issues.
>>
> 
> if we are doing it for one back-end we cannot leave other back-ends out ...
> 
>> Maybe the cleanest way to implement something like this is to implement
>> a full blown nvmet cgroup controller that you can apply a whole set of
>> resources to, in addition to I/O.

Thorttiling files and passthru isn't possible with cgroup v1 as well,
cgroup v2 broke the abillity to throttle bdevs. The purpose of the patch
is to re-enable the broken functionality.

There was an attempt to re-enable the functionality by allowing io
throttle on the root cgroup but it's against the cgroup v2 design.
Reference:
https://lore.kernel.org/r/20220114093000.3323470-1-yukuai3@huawei.com/

A full blown nvmet cgroup controller may be a complete solution, but it
may take some time to achieve, while the feature is still broken.

>>
>>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>>> ---
>>>   drivers/nvme/target/configfs.c    | 77 +++++++++++++++++++++++++++++++
>>>   drivers/nvme/target/core.c        |  3 ++
>>>   drivers/nvme/target/io-cmd-bdev.c | 13 ++++++
>>>   drivers/nvme/target/nvmet.h       |  3 ++
>>>   include/linux/cgroup.h            |  5 ++
>>>   kernel/cgroup/cgroup-internal.h   |  5 --
>>
>> Don't mix cgroup and nvmet changes in the same patch.

Thanks for claryfing I wansn's sure if it's nessecary I would split the
patch for v2.

>>
>>>   6 files changed, 101 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/configfs.c 
>>> b/drivers/nvme/target/configfs.c
>>> index 907143870da5..2e8f93a07498 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/ctype.h>
>>>   #include <linux/pci.h>
>>>   #include <linux/pci-p2pdma.h>
>>> +#include <linux/cgroup.h>
>>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>>   #include <linux/nvme-auth.h>
>>>   #endif
>>> @@ -281,6 +282,81 @@ static ssize_t 
>>> nvmet_param_pi_enable_store(struct config_item *item,
>>>   CONFIGFS_ATTR(nvmet_, param_pi_enable);
>>>   #endif
>>>   +static ssize_t nvmet_param_associated_cgroup_show(struct 
>>> config_item *item,
>>> +        char *page)
>>> +{
>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>> +    ssize_t len = 0;
>>> +    ssize_t retval;
>>> +    char *suffix;
>>> +
>>> +    /* No cgroup has been set means the IOs are assoicated to the 
>>> root cgroup */
>>> +    if (!port->cgrp)
>>> +        goto root_cgroup;
>>> +
>>> +    retval = cgroup_path_ns(port->cgrp, page, PAGE_SIZE,
>>> +                         current->nsproxy->cgroup_ns);
>>> +    if (retval >= PATH_MAX || retval >= PAGE_SIZE)
>>> +        return -ENAMETOOLONG;
>>> +
>>> +    /* No cgroup found means the IOs are assoicated to the root 
>>> cgroup */
>>> +    if (retval < 0)
>>> +        goto root_cgroup;
>>> +
>>> +    len += retval;
>>> +
>>> +    suffix = cgroup_is_dead(port->cgrp) ? " (deleted)\n" : "\n";
>>> +    len += snprintf(page + len, PAGE_SIZE - len, suffix);
>>> +
>>> +    return len;
>>> +
>>> +root_cgroup:
>>> +    return snprintf(page, PAGE_SIZE, "/\n");
>>> +}
>>> +
>>> +static ssize_t nvmet_param_associated_cgroup_store(struct 
>>> config_item *item,
>>> +        const char *page, size_t count)
>>> +{
>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>> +    struct cgroup_subsys_state *blkcg;
>>> +    ssize_t retval = -EINVAL;
>>> +    struct cgroup *cgrp;
>>> +    char *path;
>>> +    int len;
>>> +
>>> +    len = strcspn(page, "\n");
>>> +    if (!len)
>>> +        return -EINVAL;
>>> +
>>> +    path = kmemdup_nul(page, len, GFP_KERNEL);
>>> +    if (!path)
>>> +        return -ENOMEM;
>>> +
>>> +    cgrp = cgroup_get_from_path(path);
>>> +    kfree(path);
>>> +    if (IS_ERR(cgrp))
>>> +        return -ENOENT;
>>> +
>>> +    blkcg = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
>>> +    if (!blkcg)
>>> +        goto out_put_cgroup;
>>> +
>>> +    /* Put old cgroup */
>>> +    if (port->cgrp)
>>> +        cgroup_put(port->cgrp);
>>> +
>>> +    port->cgrp = cgrp;
>>> +    port->blkcg = blkcg;
>>> +
>>> +    return count;
>>> +
>>> +out_put_cgroup:
>>> +    cgroup_put(cgrp);
>>> +    return retval;
>>> +}
>>
>> I'm not at all convinced that nvmet ratelimiting does not
>> require a dedicated cgroup controller... Rgardles, this doesn't
>> look like a port attribute, its a subsystem attribute.
> 
> +1 here, can you please explain the choice of port ?

In cgroup threads/processes are associated to a specific control group.
Each control group may have different rules to throttle various devices.
For example we may have 2 applications both using the same bdev.
By associating the apps to different cgroups, we can create a different
throttling rule for each app.
Throttling is done by echoing "MAJOR:MINOR rbps=X wiops=Y" to "io.max"
of the cgroup.

Associating a subsystem to a cgroup will only allow us to create a
single rule for each namespace (bdev) in this subsystem.
When associating the nvme port to the cgroup it acts as the "thread"
that handles the IO for the target, which aligns with the cgroup design.

Regardless if the attribute is part of the port or the subsystem, the
user needs to specify constraints per namespace. I see no clear value in
setting the cgroup attribute on the subsystem.

On the other hand, by associating a port to a cgroup we could have
multiple constraints per namespace. It will allow the user to have more
control of the behavior of his system.
For example a system with a RDMA port and a TCP port that are connected
to the same subsystem's can apply different limits for each port.

This could be complimentary to NVMe ANA for example, where the target
could apply different constraints for optimized and non-optimized paths

To elaborate, such approach fits nicely into NVMe controller model.
Controllers report namespace's ANA group and different controllers may
report different ANA groups for the same namespace.
So, namespace's ANA group is basically a property of controller and not
a property of subsystem.
Further, the controller is associated with port and thus might inherit
some of its properties.

> also for cgroup related changes I think you need to CC Tejun who's
> the author of the cgroup_is_dead() and whatever the right mailing list ..
> 
> -ck

Thanks for clarifying I wasn't sure if it's necessary or not.

>> +
>> +CONFIGFS_ATTR(nvmet_, param_associated_cgroup);
>> +
>>   static ssize_t nvmet_addr_trtype_show(struct config_item *item,
>>   		char *page)
>>   {
>> @@ -1742,6 +1818,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>>   	&nvmet_attr_addr_trsvcid,
>>   	&nvmet_attr_addr_trtype,
>>   	&nvmet_attr_param_inline_data_size,
>> +	&nvmet_attr_param_associated_cgroup,
>>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>>   	&nvmet_attr_param_pi_enable,
>>   #endif
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 3935165048e7..b63996b61c6d 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -376,6 +376,9 @@ void nvmet_disable_port(struct nvmet_port *port)
>>   	port->enabled = false;
>>   	port->tr_ops = NULL;
>>   
>> +	if (port->cgrp)
>> +		cgroup_put(port->cgrp);
>> +
>>   	ops = nvmet_transports[port->disc_addr.trtype];
>>   	ops->remove_port(port);
>>   	module_put(ops->owner);
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index c2d6cea0236b..eb63a071131d 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/blk-integrity.h>
>>   #include <linux/memremap.h>
>>   #include <linux/module.h>
>> +#include <linux/cgroup.h>
>> +#include <linux/blk-cgroup.h>
>>   #include "nvmet.h"
>>   
>>   void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>> @@ -285,6 +287,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   	bio->bi_iter.bi_sector = sector;
>>   	bio->bi_private = req;
>>   	bio->bi_end_io = nvmet_bio_done;
>> +	if (req->port->blkcg)
>> +		bio_associate_blkg_from_css(bio, req->port->blkcg);
>>   
>>   	blk_start_plug(&plug);
>>   	if (req->metadata_len)
>> @@ -308,6 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
>>   					opf, GFP_KERNEL);
>>   			bio->bi_iter.bi_sector = sector;
>> +			bio_clone_blkg_association(bio, prev);
>>   
>>   			bio_chain(bio, prev);
>>   			submit_bio(prev);
>> @@ -345,6 +350,8 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>>   		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
>>   	bio->bi_private = req;
>>   	bio->bi_end_io = nvmet_bio_done;
>> +	if (req->port->blkcg)
>> +		bio_associate_blkg_from_css(bio, req->port->blkcg);
>>   
>>   	submit_bio(bio);
>>   }
>> @@ -397,6 +404,9 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>>   	if (bio) {
>>   		bio->bi_private = req;
>>   		bio->bi_end_io = nvmet_bio_done;
>> +		if (req->port->blkcg)
>> +			bio_associate_blkg_from_css(bio, req->port->blkcg);
>> +
>>   		if (status)
>>   			bio_io_error(bio);
>>   		else
>> @@ -444,6 +454,9 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>>   	if (bio) {
>>   		bio->bi_private = req;
>>   		bio->bi_end_io = nvmet_bio_done;
>> +		if (req->port->blkcg)
>> +			bio_associate_blkg_from_css(bio, req->port->blkcg);
>> +
>>   		submit_bio(bio);
>>   	} else {
>>   		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index dc60a22646f7..3e5c9737d07e 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -20,6 +20,7 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/radix-tree.h>
>>   #include <linux/t10-pi.h>
>> +#include <linux/cgroup.h>
>>   
>>   #define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
>>   
>> @@ -163,6 +164,8 @@ struct nvmet_port {
>>   	int				inline_data_size;
>>   	const struct nvmet_fabrics_ops	*tr_ops;
>>   	bool				pi_enable;
>> +	struct cgroup				*cgrp;
>> +	struct cgroup_subsys_state	*blkcg;
>>   };
>>   
>>   static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 885f5395fcd0..47e2a7cdc31e 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -562,6 +562,11 @@ static inline bool cgroup_is_populated(struct cgroup *cgrp)
>>   		cgrp->nr_populated_threaded_children;
>>   }
>>   
>> +static inline bool cgroup_is_dead(const struct cgroup *cgrp)
>> +{
>> +	return !(cgrp->self.flags & CSS_ONLINE);
>> +}
>> +
>>   /* returns ino associated with a cgroup */
>>   static inline ino_t cgroup_ino(struct cgroup *cgrp)
>>   {
>> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
>> index 367b0a42ada9..8c5c83e9edd7 100644
>> --- a/kernel/cgroup/cgroup-internal.h
>> +++ b/kernel/cgroup/cgroup-internal.h
>> @@ -181,11 +181,6 @@ extern struct list_head cgroup_roots;
>>   	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
>>   	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
>>   
>> -static inline bool cgroup_is_dead(const struct cgroup *cgrp)
>> -{
>> -	return !(cgrp->self.flags & CSS_ONLINE);
>> -}
>> -
>>   static inline bool notify_on_release(const struct cgroup *cgrp)
>>   {
>>   	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);


