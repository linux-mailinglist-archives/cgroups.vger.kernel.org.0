Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14BC33B279
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCOMXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:11 -0400
Received: from mail-eopbgr150139.outbound.protection.outlook.com ([40.107.15.139]:65315
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230015AbhCOMW4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikt9IXmRcf4c6rsVBS1YbglpRSMYu5emNR+CfkNHQQ7CiqLbqrYrx7Cf5qymZFJZ4X9o7EsIOG3bKZHY5akwo3vy71mKj8AE6W/WHHlkdrIeVfW0L5hfE4Oy0vQfPBu8Vp8ki2CTLOJlGIj3pt6MY79gqV5pMs7UKs8c2crBKM8OgRnd8ZwcXRpHfzivIMb7Tby2wzEIY1bbmVD5vh1Twv8FEhx6ReSsxGie/Hu1m2Zq8biv0BFy+s++NKad0zBf1wNxLAxGGnRaiUTQfr6Hev6YuP5k0O/sSqs7H0wpCCaoE6pgIosNLrAvKGjff/+qK5MsEoV8nsuaRt1VjYkseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCXwU4FXpFSuBc5/wFYrPNQuRITNdbEhp7YK+3FecE8=;
 b=bn0ZvqbNmlfP7wxTJEGL5wyk/evpwvnBWA2X0GONGVpyjJTsGlGh834eBb5eWoOof0UdIYQZPO3lcGV3t6h3FKigzIYBFH+PQ+PwoDFxc6LRn+ExKwkryZigwRuVGuVXdxXDelr9ad9lJ/jfd9nyo4T3WWxeSHe2lBBJs75efE7cZEx1STG4b0oocN8JdafmgThy5QGcXWa20BvDch3UcKwuhoVLq17bLc51lUxQkLZ5rERkBQTf/Gq4h4iScgatGnX+gbZVC960V7iYn2FRwqCrkaW3q5YASBYTfvwgC3dY5Ws2MVhEEF7I0UooenuceZ5TmGfnSTapVEhgEc1shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCXwU4FXpFSuBc5/wFYrPNQuRITNdbEhp7YK+3FecE8=;
 b=NoSErGEmRB6WLqv+nDiGd+ml4CDqITahdG6HZQiK4yNIEhK0bT/OhnWGTpOuyU2vScRAVRJQ7z/50j4rDqwA4UXg3SgTx+4ooqJzY4/+Boitp4GMizIYCA/p97vEwskuFXEI4gerF5sCDm3t3ibTk6azh2Fuk3CzLxUxoFJocJw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB5518.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:22:54 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:22:53 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 0/8] memcg accounting from OpenVZ
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:22:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Mon, 15 Mar 2021 12:22:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5f7251-13be-4ff7-f95f-08d8e7ad0eb0
X-MS-TrafficTypeDiagnostic: VI1PR08MB5518:
X-Microsoft-Antispam-PRVS: <VI1PR08MB55189EE4AB2835C5AD0EA69AAA6C9@VI1PR08MB5518.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+dvC/HuhX76hJtyYbec2jArY/BxwITZFHGz+BsOVqoFwRDch7lNVTfFUdlMsMrfA7ZZuzyyipfDDJr/HVMM9w2er6WSJagA3a2jV6fHFYqXRI607VdVhZar0+hf8XusB76gicVkO03njbF/DlwmGacr2h4I2nRGcK87KUPzJbJO4fmXzrvOlY1+q17yF2V7LZN27CY21sTwD3vqn0jmV+xfn/ZNyFq21FQDyxxI1Hawp3UvQm0O6i3vWr1u9ccP7bZoL4g9PXkKGDoGUGELUalbIwzQPQ9un6JiiTFnuUgtdKVQ3WtBoo8kJoO8J/o41Y7U/yhtq0+0//sefAPWCaOSVd7mZ5fylTRd47NSfixWO6VNhr+XTUhFdq+BoKyBQbclvzYuB3z8GNqllj5dOLJc3OiSnY6kt6vomELbmZXDcZBmGVUQKhbYHlvmr0jezt+y6pUmFhPF3TX+TKGtfo2t7UE3eXNsczXiyF6rGS99TT2yXwVyin4z/pzpkGFJ2QcrXy5PTNW20oPdbGHYhd4IGHNc+YmAz4nR3p/E40D+7mlbK6Y/1YCrAk0U2zenYNLb00lrPZMxitY8pX6mr+DLhnsor+7po989Xq0QmQ5TYlfc9sZNgCxsgo+J+/+ldK4y+ExtvLYqCPcaElej4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(54906003)(8936002)(86362001)(31696002)(5660300002)(316002)(6916009)(16576012)(66476007)(8676002)(4326008)(66556008)(66946007)(26005)(2616005)(478600001)(83380400001)(6486002)(15650500001)(956004)(52116002)(36756003)(186003)(31686004)(2906002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1JyTXc3c3M2UUtEVWNCMktoVDArQWsxMDJLRXUzMmRZT2lmUkFGN3NOVmtt?=
 =?utf-8?B?ajNGNW1kc1JCK2M1RGtpQVNZbGk4OEhiMEZLRTAxL3I1ZDJUK2s2OUNIMmFD?=
 =?utf-8?B?ZW1IR1NBak1nMXMwU0l6QittcFcyUi9SaS9FZE9LQlAyMFp3MlVGOXd4MkVj?=
 =?utf-8?B?YmVrWTBTL3Q0Nnk3NU84cmdkNnFZUHlzMjlFVkIzMjFtbjFzdmg1NDNua2Nm?=
 =?utf-8?B?YWNFVmQ4TEdOM0VHSUJzUklsK05aSVpDeCtPU3VIQ2xybzMwK1lOc2NCdTFp?=
 =?utf-8?B?dGVieG9DaUFteVBzTlJvR0NWQklxL0NlSURjTWdrcDNXQ3Q5ZWwwZXdkUzNj?=
 =?utf-8?B?TjFhUGVSSnZZWnNBRjhWRkZBd0lOdUtCWG42QW1sSkoydklOTm5sZzN6S1Vk?=
 =?utf-8?B?QjRvVnZGNkVMZ09PdTdOZG1sZVpMRU5YYXJOU283MlkzcnFzbWEvUTdjSisz?=
 =?utf-8?B?RTBESnVXbUllVzBZcEVETDB1Mk5kRVYydFN5RWY0TDNhSGE3TkRDbjBQczhn?=
 =?utf-8?B?WGJJWHc3cGwrVGZxbkZKeEc1WFpwcStiOEpCc2k1ZmxnZGgvTGhHOWZIbGMw?=
 =?utf-8?B?MG5IZCtmKzFNTEhZeTU2RS9HaGxlRXVlNk9nMGk5TmRsQjllcEJZeHhYd2ZN?=
 =?utf-8?B?YlYvSjJzMFNOMURINTU1YitoeG9kcjNDaWpnUWEzRkUwOG1UWGgzcU5xK2hZ?=
 =?utf-8?B?QkpXNmVzUFA1ZDNha3pWUWhieHVKMEE2MkdqQVlCUnc2MGxvSkt1WGIxd2dx?=
 =?utf-8?B?NUl6UE1Wd1VMcDhmb05iSmVTYVpNU1JDT2Y2NG5hS3ZHWXVGSitVMmwyZ3lQ?=
 =?utf-8?B?bEFtbGcvNXBybkFCNXAyREo3a21qQnhzZGpMZlFVaXZhMzBKNmVYNkhyR0Jj?=
 =?utf-8?B?VFNLQjJWVXBzS1JwcjJWaC9pREE2a3JTWWt5Skg5R0szSFpTMDBBK1c2MFBV?=
 =?utf-8?B?elBIVDhxc0tBNllxeXhtK2lNaEdwTk5oaEY5SW9OQldTZm9udFRNN2pNa1A4?=
 =?utf-8?B?MmRTS0lhUkFBNzZrWkxlV2YrRkRNQ0NWcHNLVkdmbjUveVNRNS9sazY2TWpM?=
 =?utf-8?B?emtKMzNyZjV4SG9WWEo0NUthdDFoWndZQjZtQ2FGMWFwTU43ZkFTVFBTcTNo?=
 =?utf-8?B?YWxQOEZ5ZENuRmI5UERYcnZFd0VkUzRtemhpeVNlUHN6RlBNOW12aUhWbFRW?=
 =?utf-8?B?dW53VnhTdi90Q2FmSWlHYlRVSlJYZFhDZGRwWkZDRFBGMG9GTmJNVVU1dmgv?=
 =?utf-8?B?Rllqa2pGS1F2R2NRUnllL3pUTmxEeGtEMC91aVMyNklpZ1BaSnBoak5vaTB2?=
 =?utf-8?B?NUZLa0I0bzY0dVR6U0xrMGo1aUhNM2VqNC9YLzNPblF4ZDBUMnJsamQ0c3A1?=
 =?utf-8?B?NDI1V3h4aVhPMGRZYXZkbW5vdVAzRXdBRmlGYjhKWS9zaWxPenUzci9sYW01?=
 =?utf-8?B?MjkwLzFRaWZUTDduL3ZCUE1JU2RzcExUeVRuUVo5REtvZ3A2NzJvdTRJbllt?=
 =?utf-8?B?SnJkVW43RzZoMFJHVDZHYmNwc3YzN0VwTnNQeW9tc2xLaHFkZUp1SnlaQ2Nz?=
 =?utf-8?B?M0hBazRmT3RPSDhTaGw4T09oQVp0aEdpdW9HSjVkdnA1UEg4Ukhtb1dRZDJ3?=
 =?utf-8?B?NmtZdHQrMGtjek0wNHZsWFR1Y3pzUzl6ZEg2TlZzSlpWTGdrWnR4emY3RUY5?=
 =?utf-8?B?NFFKSlR6OHFWb2hmaFczUzlId1k1MldmclNtazJ1UWhXRjRJakNTK2JlQTRM?=
 =?utf-8?Q?weG9SNIRt7A06pPFSdwAPRbbLB1HUxBEOZHg6RG?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5f7251-13be-4ff7-f95f-08d8e7ad0eb0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:22:53.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sM0ryxHPqpXrwfoeOV9M2914Wd5UkG4NUDzs70n0QBnCtvStnaBmUklGBqJo1uxY8OW8wOxlZTHAeQh8jHb9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels) 
and we have accounted all required kernel objects by using our own patches.
When memcg was added to upstream Vladimir Davydov added accounting of some objects
to upstream but did not skipped another ones.
Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
"skipped" objects by our own patches just because we accounted such objects before.
We're working on rebase to new kernels and we prefer to push our old patches to upstream. 

v2:
- squashed old patch 1 "accounting for allocations called with disabled BH"
   with old patch 2 "accounting for fib6_nodes cache" used such kind of memory allocation 
- improved patch description
- subsystem maintainers added to cc:

Vasily Averin (8):
  memcg: accounting for fib6_nodes cache
  memcg: accounting for ip6_dst_cache
  memcg: accounting for fib_rules
  memcg: accounting for ip_fib caches
  memcg: accounting for fasync_cache
  memcg: accounting for mnt_cache entries
  memcg: accounting for tty_struct objects
  memcg: accounting for ldt_struct objects

 arch/x86/kernel/ldt.c | 7 ++++---
 drivers/tty/tty_io.c  | 4 ++--
 fs/fcntl.c            | 3 ++-
 fs/namespace.c        | 5 +++--
 mm/memcontrol.c       | 2 +-
 net/core/fib_rules.c  | 4 ++--
 net/ipv4/fib_trie.c   | 4 ++--
 net/ipv6/ip6_fib.c    | 2 +-
 net/ipv6/route.c      | 2 +-
 9 files changed, 18 insertions(+), 15 deletions(-)

-- 
1.8.3.1

