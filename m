Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8F33B27A
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhCOMXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:11 -0400
Received: from mail-eopbgr150104.outbound.protection.outlook.com ([40.107.15.104]:43649
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhCOMXF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ruc/bidIMLybdvU14C7Br2edefLdHbwJI1j48Ga/pme10RsYz42rRtCCdy9+LmJHAnAPZRMw1LoVBXL0sLMNXFe+4IxqBfTfWohU3FDdNugGqXgZsaKTMamYofa1vSeq6cyqhpfg17sKirH6JpvdEWD5kAqoLeZxgug0OkMurNJm4sImDxe/nhXa1iSd7QXx0hXqYMFVhZxFvO0U/O7/dQn1nc8Av6obPWh/y706nL+Q+x0OoGrFY8wSz5Q1jbwoPOqe7tvikSTDI261xo4CUMgo9i6xs/PV9FQqePCI16IujUpTUWhJtD78dNXhz2UkzZFiI/YPnmUN/Zv6EqCsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/tFSq0j5W0x7QzUgqbepV02dkIN9FGfWCz1gtWrMQ4=;
 b=Qbe57BvSwmawhKHKg6+4uCqHjDyaxiUM99VsncKNG4CoxXU4RnmTmgLsUZUOvk+GikMqYqLpQNkivg58G+lqlz2hrjWbvZShJLGa8amDmFtl8vgyyb570eL4sYt/qxVW/4wBwxBTyO3E4ioqcxprathgVJ4WZyyn9k9QWZqd5lokdeSSBPpxpV7lnsbzLafWdJ8LJOHyaPT/3f9E1zd6YyudcNMB3w2PM2+KMwxmkVaF1nPWF9Tho1zTK0lERMV0Xp2tiw7evnJaGt2qx4saA53uYTD9sxF2VtXj3SkDLJQMdaKfHP2wnaGdRZZ2tszhjxYytWb3O67s36iVztv9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/tFSq0j5W0x7QzUgqbepV02dkIN9FGfWCz1gtWrMQ4=;
 b=Cp73d2C/16nCAKExXC2PI0+JMvZlKd5QbAn7cLPimZEOB7NjebHI5OpZkOsDjW/eUESsiCYCaly5lNaGZZwnDKDu6caRn79OHa/SUu5U6X9vwCM+AgN195TDi54f6rfRjHNWH1zjodU9toEs8/Ajvbm/wR1eWn/xT0gY231DbFw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB5518.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:23:03 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:03 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0067.eurprd07.prod.outlook.com
 (2603:10a6:207:4::25) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0067.eurprd07.prod.outlook.com (2603:10a6:207:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Mon, 15 Mar 2021 12:23:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c25ac53-72c9-4b14-fa27-08d8e7ad148c
X-MS-TrafficTypeDiagnostic: VI1PR08MB5518:
X-Microsoft-Antispam-PRVS: <VI1PR08MB55182C166C8C87344B25902CAA6C9@VI1PR08MB5518.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dfl3RLxCTRqlbskC2YjeQ1+YLac4yNEMgm3wAuCS8PYxhrE/5MkP6cBqJvcjpnxcIdNauBN818Fkn5WfLNjIO/jp+0TdYLLZFhx2NP/gcR/xDfPzcbFVF0Mt+IvfLKbimQWNvX6UoYru/hhZ5cSZTeCqygdIEiqDki6mUjVSgcobqPPLAs+Z8CGT49jDzzFNrb9fv7/6Kpjfk6Ab9B+FZaPBy8ZVk+aD4lc1L+WdSKOvPXiGbRbuDYBg8xT4PMWaFYBStUOP8qpf8kJxr6XunKzkS8TM/uW0JLO+XeLtYL8K6L/th8DF7QaR+XqFVme3LTxkUaUIHcd18TmAC+8LhIdLaUqDqUhLFmFHpw4HU5n6BDTufG1LsM1zgqGGqL7nIckOQUmMsBfQWk+ZEJxbOgjiwaAxr6bH5ypkkxKE8ogARgjBPcaUFNs5ywRi4vSTHnMS6SQVCnvdgDXL9KujXlsQGDOpuyR9GHLz0sBuyywXd1mW+2ZPsJ+YliotdkX6pb5m3hGo3GC4GBpbNA54oGpGgByletY2qydVYt+hFH35/z4pitwL4owkW9T+K6Db8HT6NKrBy6A6Iy02nL9Wo3RVaOryvGRSUCmClNZSET/j1WIC3qAlWkEwCN1BRvHoFdwBfdz/DMKwZGG7DtboQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(54906003)(8936002)(86362001)(31696002)(5660300002)(7416002)(316002)(6916009)(16576012)(66476007)(8676002)(4326008)(66556008)(66946007)(26005)(2616005)(478600001)(83380400001)(6486002)(15650500001)(956004)(52116002)(36756003)(186003)(31686004)(2906002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHk2VmdoSU9UcFROVElVa09ldDVYTnI3MkQ3alBBdm1XMURZYW9acTRGVVV3?=
 =?utf-8?B?amVpd3dKWUIvRHQzcWVOcE1UTm9EU2Qyc2RKMk82ZFQ4eWVYQ1JIdmhXT05S?=
 =?utf-8?B?ZDA2YUxlaWlWbk4vVTdpbXRGQU1MSFlxVWF5VVl6bUU2V2RMcmdYWXhvK3A2?=
 =?utf-8?B?ODdmOUFYN2pFdjZkLzBQdVlQZnhqdklhNmxsL1BLU3NHUWc1WUdROE9tckZJ?=
 =?utf-8?B?QjgzeElwRDZROGZiV2l1Zk9hSEJyb1RrZ2RZaXhzY0dpaEl4Ti85RWZIVDE0?=
 =?utf-8?B?eS91NTN6Nlh5LytNNEdtd0I4M0dJRTdhTVVhQ0w2bnNaUzJJN09xWklyZ2RM?=
 =?utf-8?B?TjVKN3crT1NZRm4veTlzZnY4UXk4WWFocm04SmJDUlRPUUFWYlVraEZNbUNa?=
 =?utf-8?B?MHRudEk5ODludzMxbWsyWXFONUN2WlRoZ1l5aUdiYTg0YUowcHJYUjF0MnJ0?=
 =?utf-8?B?MWdLSWVrTjY4U3paUlNsSE5OZ3BFaDNsVHNTcjNVc1g2MXdTNi9UTlpKRE16?=
 =?utf-8?B?R0pPZmQwbFB4WmUvMkphWWhXT2c1bTEwd2hETU1NTklpK1lreWdQNER5cHlR?=
 =?utf-8?B?MmZDVGgvWUtwMFZTUDhMYjhaTkVmVnJjbUNsZEZEYlo4YnpCQ0V5VUZNRjY5?=
 =?utf-8?B?MWRFdXBVeGVvMXR6QmI2azFicTM3Wmk5YWtSTWhXNnpBMnhMbFM4WmZMU3NN?=
 =?utf-8?B?SFdyZG9sdHljVk56UU1FcGx4UHdOTGNzbVl5amdDYytYOTFFN0dHM1ZhSkNY?=
 =?utf-8?B?bXBNQUhjY3ltbU52NVdqZGhpRGtwUnZyWldweTd1SWVDaDRUZWplTTE3aVEz?=
 =?utf-8?B?bmMzRGVRRDJWYjhMeE9qTnNndXFjSzFTTXh4MlpkWjFPQ1pLajFrdGF3aFdE?=
 =?utf-8?B?eHRZd0FEbEc1a09KUlVTZjBXOFNkdGhveHRCWXl6ZG40QzhhSnhmVlVkdWZG?=
 =?utf-8?B?eElLN3QxeEdsNmh2MjgwWERsWEZ0OXhTaEFsZzZxZjBVRzZKVGZlbHl5dE1u?=
 =?utf-8?B?NjY3UTNmUWswU3kwQnA3aGlnTTJ3VDlaMFhjZndTRlQ1SlI4aU9TNmRFNUkv?=
 =?utf-8?B?Z2lEbXFtZ1dYZHdqQmdmSDhKSHNiRyt6eGxMMi8wSEw2MTlTYjA4Y0MwMlpD?=
 =?utf-8?B?eUFNL2hQY2VSeHFLSVpwam1odUFXTVNBTTJZcDJXNG8xZFROVDNGZ1hXU0di?=
 =?utf-8?B?YWppWWNXY1dON1ljSGxLVlBNd3ZPNHV0SERoODZkdXd0VEhCYjJQS0h4ZFBN?=
 =?utf-8?B?bG4wbkhzWW5Pc2k2ODBHUVQ4cjliaWY1VmtsU3JQSGtxWXhaRUdtYWRIS2Zx?=
 =?utf-8?B?LzhFdHpOeEJaRzFoU21MZm9tYTFnaUFWVkJKMWZ3ZlpSY1RQTDVsTDF2WEZ0?=
 =?utf-8?B?QjZ0K0x4ODRLYllhYlM0L2ZLOEkyUzRMTkltdVFpWHE0RDZqYmFGK3dEWVZ3?=
 =?utf-8?B?UnNBRGZLSUN2alk1ejBBc1BuZjZxelc1SG41UmsrOE9BVzhBTWpUYS9GQkpF?=
 =?utf-8?B?MTRjRTA2cXZkRDZ4eHozQkVHMS9Qa3poSTR6TVNuNStGU0VVT21pcnNIbkdk?=
 =?utf-8?B?U0Y4SFNYY0ZVUXVUS2JVb1Ric3V4RnRYK2Z0eWlpWmoyYTFtTFBiZXdWM0tF?=
 =?utf-8?B?cHR2Q1lCNFRxNzgwZ2lsQVFzSnFWTzdmUnl6d3hjdHUvOEtPbjVBaDdkMlVm?=
 =?utf-8?B?SXlIZUxjMC9RbkRxeHVvbjhpZXAvNitPcTZpd0svd3NOL0wrTmRvZkVUY3pL?=
 =?utf-8?Q?TIbzw4hkgbEEARQxpFCXYbA6/r+mJz1I4aaj5DF?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c25ac53-72c9-4b14-fa27-08d8e7ad148c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:03.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjyb++egOu7czGrFSICGtFxUAcm7MO8IjA/+Ap01Kk77RGZYIZ/7KmwrUyc3lUiYM2ylBTT2dQ8pofS1Z+MXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An untrusted netadmin inside a memcg-limited container can create a
huge number of routing entries. Currently, allocated kernel objects
are not accounted to proper memcg, so this can lead to global memory
shortage on the host and cause lot of OOM kiils.

One such object is the 'struct fib6_node' mostly allocated in
net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:

 write_lock_bh(&table->tb6_lock);
 err = fib6_add(&table->tb6_root, rt, info, mxc);
 write_unlock_bh(&table->tb6_lock);

It this case is not enough to simply add SLAB_ACCOUNT to corresponding
kmem cache. The proper memory cgroup still cannot be found due to the
incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
To be sure that caller is not executed in process contxt
'!in_task()' check should be used instead
---
 mm/memcontrol.c    | 2 +-
 net/ipv6/ip6_fib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec0..568f2cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
 		return false;
 
 	/* Memcg to charge can't be determined. */
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
 		return true;
 
 	return false;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index ef9d022..fa92ed1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2445,7 +2445,7 @@ int __init fib6_init(void)
 
 	fib6_node_kmem = kmem_cache_create("fib6_nodes",
 					   sizeof(struct fib6_node),
-					   0, SLAB_HWCACHE_ALIGN,
+					   0, SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT,
 					   NULL);
 	if (!fib6_node_kmem)
 		goto out;
-- 
1.8.3.1

