Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9133CE6D
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 08:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCPHQZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 03:16:25 -0400
Received: from mail-am6eur05on2100.outbound.protection.outlook.com ([40.107.22.100]:49185
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229936AbhCPHP6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 16 Mar 2021 03:15:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6blqwdXfYae2vAPbYDWn2eDKQt3Na/ikgQXSlvtXq8U/HNpoyTipT3dQ7dW9ReEsTUhyh4qkbKI+9DMvq1U1qeMuNLJBaX9PVQN09r3pT4VkiV5gSk4QnxSBkfmpFSgpVoFP4qSt9/YirWpIjmKdwcrKyAF3aEcyrjuFge3qRYFfXWbq6qMg2boePr/LIXWjSVIUe65njctVVMtihbjrYsLApzDIUanl2fNBwrIWTIN+2Gel2mF0gLx9OkbQ26GuXPPid9w4Qd9GN386BNXNR+YQcl7PU6levTiHkPYxzWGw4FWPfAJNuejQuxGcPHwZZiKrKepIB2Vslha2lq+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2vqutNe7RuTTHI8szTkw0BwnWOR+xhpcQjCXW9KaLA=;
 b=THqofVnCDP1WFvWWC8ev/xiEUgRiF1dxpeUBDnQYPNa6/EMf66DHaFBvQ3BcEb3NXV0QAuG4zvZjyh9IUVS44Z84gLuWeHjY7eqjMIyWXAeCBWJxRzkEU42UxVekP1D2jctKRghxJbiSwf5mqNqLpYosYKm0ezTK+g9aArBehOHl4nQwUfTniQIF5RvU4V0s4m1+zs21ILTdl0v+CbCiZ/wXagEB0Dm8a6WQ4PSDs2MrMOiq9r3U6Fdlu7ssQcj/RdW7Ul1JPo9/C6u0QEHwCr758jW7ehuyNsF1u8jIVSWcEwKcHQVj80kp3rqUg/d3xqomIiknq34eSZHkKkW0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2vqutNe7RuTTHI8szTkw0BwnWOR+xhpcQjCXW9KaLA=;
 b=IXmCOcacksnTBmA1LNgeBIqZcEzDoGdh/VhA01Y91vRxsAcTs/RILzCimDs3nfQ6H8wENqkAtvgPnlDK7hTrEdfAlAKOHwCSvRW8Ic1gLQQ4UBcuRYc7oUAQNwUlR1QbwB+NZDhCehulIL9mllOAJvRlVSUdNr1ur2cyXL0be64=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB4589.eurprd08.prod.outlook.com
 (2603:10a6:803:ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 07:15:55 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Tue, 16 Mar
 2021 07:15:55 +0000
Subject: Re: [PATCH v2 0/8] memcg accounting from OpenVZ
From:   Vasily Averin <vvs@virtuozzo.com>
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Message-ID: <ba55ad76-ebc4-b8a7-285f-fb4465e0a0eb@virtuozzo.com>
Date:   Tue, 16 Mar 2021 10:15:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM9P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::23) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM9P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 07:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5605cd3e-81b0-43a8-9aaf-08d8e84b56d7
X-MS-TrafficTypeDiagnostic: VI1PR08MB4589:
X-Microsoft-Antispam-PRVS: <VI1PR08MB4589F47A8C41F34A2528D013AA6B9@VI1PR08MB4589.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AIoDOFEsSRAdrlanXzxmfjRhMXAGL6rTV627kl/Yxtr8Gp+JVhfgpVQdceRlmg8LVj2piN3lDODiFd62yivHBNdXnLruEGPGCz+a/2onOmyh1yZa2bH1bSKPZplzguqxbztuhV56wvqnqehgzyqd7daSqDpWOoH/XvJSopbaFO9wcM5i8Va5Me6T8/7UbbrrC3S4S3JmzlCXEwVis/RLgEZz99uCgp0GcAFjpM4RpW7QrBSIeskqcHs0eSer3p5VdULlF9f+XWNAeMeAQUmElI9D7P48p9nrrhPo/jQ5JYBvlFg0XnUoQOD/OAPZzoWR0bEU1R8wZJAD74h67CyZQDtu1pL0f5eclPrnBrKt8ag01x7nhcBAkkXGL31Yxdd6nFG4xRPhw79s7zEWjvavIOWICEQONvnSdaqZIp/sb1oiBd2M5sFdvnbp4t1Abq2XJQ1SxJBOgUK0BZhah5O6Z14sTCDxT/MiWze+3AFvX/dXbzTxn1VPLTnCBLj6v/pR/5XIsj047Lx+EHeX8kYSwtC+dlB5ZICjzK3kc9/MWsQcHtKifYYaBvUwOmZ5dOSD/iXGEOpwF7xWU8bYNemEi1s+8g341DDEhgIBlKsLshi+TeuB+TEydpS4S1faXpMj0Jmzz66Rmwbs6SjDpwlQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39830400003)(956004)(2616005)(31686004)(316002)(31696002)(16526019)(186003)(36756003)(26005)(66946007)(16576012)(5660300002)(8936002)(53546011)(478600001)(2906002)(8676002)(66476007)(110136005)(15650500001)(52116002)(66556008)(83380400001)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXRtako2amF3clo0ckpYakhpRU0yVHlCSTJZbkxKQ05iSDNZYnFRS0JWTnNY?=
 =?utf-8?B?YkJpNEJrVHBISjcyblVEbXo5UllQZ3dUclhSTVZ3N3NoSi96NCs4aTJHTjlh?=
 =?utf-8?B?cUdLVFhIaGVlSVdCNi9TRmRZeEdYQm1KQjk5S2phTzY3OFJrVmFVWG9NWE04?=
 =?utf-8?B?ZU1RQWJhSkdJVTluc2wydmV6MTRRZzI5UEVCaXo2eFUrdjU5dnFBS2ljT09r?=
 =?utf-8?B?c1FJN21LcXlqNWZsQmlRSXhzMHJpQ05FQlp0aDlhRTAwcEhWMEpZcDFkSzJI?=
 =?utf-8?B?SXlLSHpEemYyS3VzZmlYQUY4NjJobG94SjlBeDJQOTZQandHTnpvRWc3N3VF?=
 =?utf-8?B?MFhUMUdIbFgxZ1FNcVRDUWhFTnlvanVvdTJlaCtIZjArTlZsZ0tUTm1hNjQv?=
 =?utf-8?B?c3E5ekM0UDh3SzZzd0Uvenlia01lL3paOEIrdStNb3RiMEk3bFh3c05oTEZ5?=
 =?utf-8?B?RzA5bXVNQUdLVG9NQTFCQ0xiOE8xbkVIQjJUZFF0alVpV3hocS9XNjY5MzM1?=
 =?utf-8?B?eklzRGZpSG5wbG8zZTk2OW1ZSm94M1pkeDZSVFY2T2dETmErb3hFajBiMjl4?=
 =?utf-8?B?eVorK2wxdzNyM1ZYTjhGMHR3YkZLMGxvNmxPU04vaXhQY1ZEVHdwK3dWZHRK?=
 =?utf-8?B?R2VUWjF5TkRiLzhVK3AwQUNmYllzVElML2h0MStHaWVab3NCeDdzMW1hN2VC?=
 =?utf-8?B?dk0yOFU1ZHpHbHh4V3ZWdDdOTU1yL3dBeTFaM3lmUlp4VlRWS1JYRmh2L3Bu?=
 =?utf-8?B?OW41NUJGbG5xNjRmaDZ5MUMxeGoxS0Y1T3NKVzIvaFJHWXY5dzZDK3Azdjha?=
 =?utf-8?B?aThMeHk3UlgzOUhxU2FEdXV5UHVlanVvLzhqSURrUUs2bWMyODI5cXdGRWV1?=
 =?utf-8?B?YjNXRU5BU3hOZ2JsV2NEUjI0NnRTajcvU09OMDA4Z1U4VjhacW9LY05TOHNn?=
 =?utf-8?B?UkRuQ2xKaGQ4VE5sSzlPWWxnT21KR2VsOXg4RVgxUWFhSVQyQi9aVlRoV0NU?=
 =?utf-8?B?VXZhUnJabERwdzRHNm15NHRLYTJMVGFFbjJPejdFNDJCMlM1NUlmQk90K21n?=
 =?utf-8?B?cjdZUUxPTFZ5Y3VQc1ZIN29hSWFkZjdBeUN3ZW1VYzVCZWpBL1krcTVGZ2JL?=
 =?utf-8?B?a1pFUm5XSHFHalhQUnZWTWxmL2NsVlZhczdwS05TaUdnTlBndEhRMmErSExI?=
 =?utf-8?B?K05aRXAwRzZjZ21aRXVJaUZjUzNldU13UDZUcFVQVTB4ZE01ZXd0RnpCMDFJ?=
 =?utf-8?B?alhZY0VUYVN2MXNsSi83dlpUR0ZBUXpoNzdER1Q0bVpUZ2hTVjl1bldyb3NM?=
 =?utf-8?B?T1g2R2t0VVgxMXd3Snd6UUJGRHVvbCtKLzlkVXJsY1I0N0xhNTZsYzF3dkgv?=
 =?utf-8?B?Ui96M0VoN3EzV25LNTBFNVErUTE3OVRHUkhNWEduaFc3STRIR0c5LzFGM3M2?=
 =?utf-8?B?YnE3bzRyWUFQcVBuWFFhWDBqWVlxQXVYZGRTUGxrV1ozUXE3QlJ6d3BaeXQ3?=
 =?utf-8?B?TTEwT3hpNnVhQnFlOUQ3dEtyQmMvWmt4YzZqNkYzdUxiRWdOeW1jeDM2QUF3?=
 =?utf-8?B?ZlovZmVwcEM4TkFFYjdaVTJTTkdQYVAxNjBWUVY4K211Z0VEMzZLekUwRlp6?=
 =?utf-8?B?cUJDU0VpMEZKS0VScFFKVlpPa2J4TzZ2Q3dLaDJwb2kvSUFvNVduUHJ6RWFE?=
 =?utf-8?B?em9lVFUwbzBVNHV1TnlIRHcwQkoxTkhjTkRhTnRzZnNJOWRQVlNZYmdDcEV0?=
 =?utf-8?Q?nlanJZS+GLr91RMKuH5HJu8IVnpHkd1EdwBQLIL?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5605cd3e-81b0-43a8-9aaf-08d8e84b56d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 07:15:55.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU90v7dsPiDl/PpPX8TbrLvjl616WYOXs7CBJS4OR9b58zbPlxAYhLMjmsqMmE185Fu7/W9OYf8PV9sju39o+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4589
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal, Shakeel, Roman,
thank you very much for your help.

On 3/15/21 3:22 PM, Vasily Averin wrote:
> OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels) 
> and we have accounted all required kernel objects by using our own patches.
> When memcg was added to upstream Vladimir Davydov added accounting of some objects
> to upstream but did not skipped another ones.
> Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
> "skipped" objects by our own patches just because we accounted such objects before.
> We're working on rebase to new kernels and we prefer to push our old patches to upstream. 
> 
> v2:
> - squashed old patch 1 "accounting for allocations called with disabled BH"
>    with old patch 2 "accounting for fib6_nodes cache" used such kind of memory allocation 
> - improved patch description
> - subsystem maintainers added to cc:
> 
> Vasily Averin (8):
>   memcg: accounting for fib6_nodes cache
>   memcg: accounting for ip6_dst_cache
>   memcg: accounting for fib_rules
>   memcg: accounting for ip_fib caches
>   memcg: accounting for fasync_cache
>   memcg: accounting for mnt_cache entries
>   memcg: accounting for tty_struct objects
>   memcg: accounting for ldt_struct objects
> 
>  arch/x86/kernel/ldt.c | 7 ++++---
>  drivers/tty/tty_io.c  | 4 ++--
>  fs/fcntl.c            | 3 ++-
>  fs/namespace.c        | 5 +++--
>  mm/memcontrol.c       | 2 +-
>  net/core/fib_rules.c  | 4 ++--
>  net/ipv4/fib_trie.c   | 4 ++--
>  net/ipv6/ip6_fib.c    | 2 +-
>  net/ipv6/route.c      | 2 +-
>  9 files changed, 18 insertions(+), 15 deletions(-)
> 

