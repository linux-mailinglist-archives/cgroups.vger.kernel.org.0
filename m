Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9D332032
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhCIIEP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:15 -0500
Received: from mail-eopbgr130103.outbound.protection.outlook.com ([40.107.13.103]:32676
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhCIIDo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:03:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWY30OFTYql7zuo/G6zvNjz/P41KmLrKK4Uamava6QlNUgKWFq8WoV5m7jAwMSEHJKtC3R/Celw/Ff+0SCIdd0mulRWxdu9dLegBBrdVkvnp8jX5M9V1LnAy+XgfSv9er4GN/h2wAHNM3eqZ+Vr8+lmxjKcZRWfveQS9pVixNzjoQWl5ZLySZAtqj2oVPp+/TTmBRoe6yIPRhmkPXxpjpN2hVP2zN8hkPjeth1D1kUPUorU3DrQPDWrVWauqyyy7qkZpaOzW/++rFwnkPuKdzH1GUEGmV3bgpHmN9ajrtxzWL2HMNn9JxzqoWqQAlWZ9FER/N4GEKgygJFvy+B5+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6uPTswKNmLvexfE4/75jOdnrZwI9g4iTWJL/mKN+8g=;
 b=N7C3+wGUuj5KWG1FCej3ZZxVFYXnHocMXgz/P/0b8EnMh0nTt9GQXbmDD3o2bLCbMMua3nQDksdJXuRkdUMpt63z9LRSBfby4zjnF2lKQmpbkB+7pUOxyF84+avK6v3r4SpVY0YIpK9/PnJSHbw/+zGpEWZXKx+2ixWA6fq90wz4FD3T60PdVQWvify6DcFMLoBqt0rjLaArNseZjUk3RBf7FxIh233yahxNx7LJxN/2CFzwhrUTJoJGdc0Auld3xmyGB3jERAqpNt73nF1rN/I0hJ0ra4Chs7qeFn5Kx7vgWOVJb/BHVzlGdC+7HhCBtfj+rq9zO/NaT489IzQFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6uPTswKNmLvexfE4/75jOdnrZwI9g4iTWJL/mKN+8g=;
 b=dgDJo6Xnm42fPBfYY3hUmPlYwHhQxEC8yfdhS9qj58rAtya0VBKyo85rONiajYrpVXMFKbnLX2FyRZ6q1VZJza/Jux55PDRB9wyZ31r3e8RrSH/2t6uqsPvIJP2tlbVyAfzwfYJqNZOA6FnXa47xffBT6yys77lxGNHnObpxbbo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0802MB2511.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 08:03:41 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:03:41 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/9] memcg accounting from OpenVZ
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:03:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:208:3e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74f4325-0a42-4e07-a844-08d8e2d1d9cf
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2511:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB25111607280D36E237F2B22DAA929@VI1PR0802MB2511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Onk6lNgwc+FTB6DFK4Br8b30UOLIHrzbt9cQsn+aE9jjyZDVfehR+Xh3vorFCnY38YMUt2KqjuJgLhXhpUmYVtvtIrk9/epzTo/cJ77aJfbqSOKS+JNh9x9TNdQNTmxuA+2WgeFUY7FKfDxvIeK4RKJQeNq2duRM5r1akafZ8ka0HvsA+xNvBy0gkKAmFVODI0f/dFiKBrk4Mj+WMR5+lUx9R4Soi/pJ1Gf+ycZxWCHYbHYnFJAcW7XoPGhAs5yrjONKiWUXEpscydYIq3Z0Kcf+gcl/TEc0blgofhShGRF6X/clG/9etxQ/iLWD+1Rxw1rkJShiVM5Q8k9+zNj9tEhKCkmJuthUW97/W6g3vs4pUvhSQxktJNa/O3KkQP9SEuSaCgxQg9QVZGviVpAKQ5IdM1xpUe2Pc+prLOneO1wfJd0lRAfPtp8QwfNo+6qlrvSn0k+80uxx5ADw99FogczkXzB1Rf04wq+904aN4uWIXZBNDs6CCKztxb5Pk3GBttGOFKA2XNDkrb2H0CavbMG/QfyHzCXVb/Hk/uyh+XfU/Dl5ypy/iKQ+DSXQ+Y4w+tVgOC9fsI/dxS3nLoiA9tT6l6459+5sHbTI6lBmfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(16526019)(66556008)(15650500001)(86362001)(6486002)(2616005)(8936002)(66476007)(5660300002)(478600001)(956004)(4326008)(316002)(26005)(83380400001)(66946007)(4744005)(2906002)(31696002)(8676002)(186003)(31686004)(54906003)(16576012)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUhDL1l6L1A1dWNZMlh1Z2ZqT2t3bkdQUGFEU25RZ0h1bno3UDljQmFIMldk?=
 =?utf-8?B?c01ReGdSMjJHRzVMbVpwKzR4MWlrMXE2bDJXVnZ2MVlmb1ZBc3R4aXJINmN4?=
 =?utf-8?B?bmpwTk9CLy96MjBRUVByL2JxeU9zd3dlYWc5dUIrb0o0R3dTYnpXWmRMMWlS?=
 =?utf-8?B?RThsRnZNbmQyT2J4YXpXbWJlMFBuMDFhUkFkNVhNTDJnZ3F1L0tVL1lMRDF0?=
 =?utf-8?B?YkRtdzB1a2U2enFoTUNkaTlFTllocDJHTEwzZmtvSDdGTzZnWHpwN2Jnbm1X?=
 =?utf-8?B?d0tsdHV1bmM1SUh3aUo1VEVPL1pkTzcxa3ZaUHJuVEk2elhTcnJqRDRnZlI1?=
 =?utf-8?B?dmVtVjVYVVBGMmJBbmloRkxXZXk0QTNRTzgrZjlodEZKSWhPbnNJWWZoRHZC?=
 =?utf-8?B?SnJaUnh5Rko5N2pUTDIwbXdlZHhkODFnb0M5VG5pdVJlUGNPdERGZmU0dmYx?=
 =?utf-8?B?azJPYUZXaWdYQjdTY2RhcDhMU3dqU1M0NzNDanhtS243OFlFWC8zVUd0eVFx?=
 =?utf-8?B?ZHVPOXVhcGxxMWV4OEtoQTI4K0dtWFBzZ0JHcGJaemJPdkpkVElZUDhHc2ps?=
 =?utf-8?B?aWl6N0l4ZUJMSnZZbUdDZjU2bVZmQWFiN0dmMGdObU9YbGllY3k5WEVROS9v?=
 =?utf-8?B?OU5YYUhJd2R2YkdtcE1Bait0NVlqY3JWUmw0YWhmRDdZMDZ4WFBZcERocEtJ?=
 =?utf-8?B?eGplbmtQUzByTE8ydHNXZERIZUhFcUxxVVc2c3dFVStZQWJXZExVNlVYcUlV?=
 =?utf-8?B?MzZBQVUzTkdyZUNqbWs1NGtjN09zaVpDNEgzV2gzQnZ4QjRNd0lzUzc0Y0VT?=
 =?utf-8?B?L0g5L1pYYjJ0R1k3eWUzMlp2OXp3STlJNytmZGlFRDg5RkJSem95bEZuRFFq?=
 =?utf-8?B?R29vV3VjM1hDZE15U3B3MG5jSkhrSFlIM1JOQThjNjgxT2QyUzgvL0VwT0hQ?=
 =?utf-8?B?YTVNR3cxYzdPWUpmN0NDTkxkdHBtdjFtaHVqK0xTVnpKanc5UlgrbkgyZmx6?=
 =?utf-8?B?T3R3QWxwRHFrQ05hdHZaV1NTckpsTlZreHB4aVc0bW1aNVhTcVd5dU94b0Yx?=
 =?utf-8?B?QVplUUMrUGZNOEFlZkxnOHdGYWV3L0l5NlRwKzhTcVcvVTB1NTNpdm80NWt1?=
 =?utf-8?B?ZDF4d2VBTW1DSUdpYkxxdElWZlFTdENRTlRKLzNyWUhoVEczRFdHNms3MHhD?=
 =?utf-8?B?VHNYUDdXczA5TktUTlJQckFoR2NPQ2UvdC9oM09jaWl3ZHlCWHQ5L2x4a3ha?=
 =?utf-8?B?QnIrWjRBZXRva2U5OUQvMDhMZHA0dWwvb2svejh6eHhnOWhEQUpmTzNKV1lB?=
 =?utf-8?B?MXROTXUyQUJyWlBwYWVGck5LYmZRUTIxSGY0dW1SRGRUMjlOeWJTa25aQWF5?=
 =?utf-8?B?QVUzTExJbVJNRFd0UG9XakxNektGeS81bytUb3p1RHNkME85ZFFHNnpHaGUw?=
 =?utf-8?B?dWI0TWpGdUlOMHEwZEwvUVhJUUFDTkRuaEV1MWo4U09NRG9TRjZqMVh0WUFY?=
 =?utf-8?B?dmlWc2RCamRwZGJpd2hkc0ZrSmtaVzdxUm9IbHFhQy84NnJWeFpNVnE3YWNE?=
 =?utf-8?B?S3FLYU9kdldGWEZlV1RZYnNxZVh5MmdBREovR0JtdGU2T3E4SzR3VTdmaEN5?=
 =?utf-8?B?OEEzVncxRGVLTmMyNVpsMnhNd3EwcHpBazJ2VWRoSXYzWi9ZeVk2QVVzQ3pI?=
 =?utf-8?B?RGd2RXJYTndNQmRXRmlVeGo1WFNkbEV0V2ZFdFd6dDIxZDZaRWUreXpwSjZ3?=
 =?utf-8?Q?aYgzgqbEzwK34Bdz1UaWRqLm1GjjeTumEfCQwce?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f4325-0a42-4e07-a844-08d8e2d1d9cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:03:40.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOe2C0pZIBZykr2gPFjMTeluRulsvJ5NXg+62DXuVGuHzprVI/C7eXDM1LgBznpUxm4tfYx5MxOrt5OzwMDx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2511
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

OpenVZ many years accounted memory of few kernel objects,
this helps us to prevent host memory abuse from inside memcg-limited container.

Vasily Averin (9):
  memcg: accounting for allocations called with disabled BH
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

