Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C37A01F7
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjINKtK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbjINKtC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 06:49:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC591FCE;
        Thu, 14 Sep 2023 03:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDH9cnh/VnqzjPKBiruSw61OfZp0TEb4h4/5yW3/HSkQOyb6SUMpqJq8uaJfPGEy83gRD5JTA3x00B0qmfQ9uTyAa1tphZU0Ka3nh9Q/GcoFWAgKkzSF3bQ3Lc0K2p8SEsGky3T/ixPownbczp+9Uth74uLLP5KY5WVJECjQgh5Hz3yYT25+MO8mPxU0jJX+n6ub/bmdECTqQJlTvThfanQE3Xhtnodo/ms6ju1Cn25DSc6G3zHdxYCJsY7+y6lZaO9oORLtLxtQ5XWp1DNxdEyPJGMx185t9Gy1wnEbl33o8hfKxa45g4Jkkga5RJh8fTTGMh+MlTlAOvvFODmILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkdcu0RJevDOOepNMe9zA/YQFdE14GSo/+eXT41SmFY=;
 b=kBLERCz+dCbiVaBX4pFdfbi5zazPv1AEuweQjcd6ZaFyZpg2iVtjtPwQVFs2uyQMO4NgjOjyqcW5hkvSACOg0kBCSX1oCmixyPjuhrTFrAmIXL0Y6c0x9Nnz1JLG6RIYaYR5MnpEawQISpXabM2CGkBt+4t87d3mLnNc9r1rFwXR5z0C/wRAqkIGTcTxQS/R0ghwPhkdGHO4S/EyAGxXNMw9IxIBwnxjrnokdDRZczlFZQV10iBRn/JwweiIGPPYPbb8nC2pyH5WznfCK95CYkBuVo+yDwuoKRrfKI3n4VMAFjqBmw8QroItWxJINOaEld/+zbBYaFhTE+FM5iRHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkdcu0RJevDOOepNMe9zA/YQFdE14GSo/+eXT41SmFY=;
 b=JLQidermfHMYYERI+cnyDx5Uvcy9ZKUuDudM4//wKNnYDtqRrmUpVAzaIstkCXEQzklZ8oInT/Dw6HHnW9w5xptYLNSwRIzbQdVMb0MIJMva+EPw6PaGjOm5NLf87at64j/z3hVXn09Fu9dek5XzC6f1Knzog4XYAysmk48abT56Iumd41t5Nm8kkMsan1KbZFeg8q2B99ibC6QjIzAlF1ZQgZF5NTAKfs3x1pWuglpecQcwFlc1lRgEctQF0xYKWb96oHcB3o8CPtHUPWvNOwPziMYP4tIHlcoW0BgaByVnEkV58/stH9Dn00BWC9Fe5tFgRLzFuXDQuHwU919Hrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB5929.apcprd06.prod.outlook.com (2603:1096:400:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 10:48:54 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:48:54 +0000
From:   Huan Yang <link@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suleiman Souhlal <suleiman@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Yu Zhao <yuzhao@google.com>, Huan Yang <link@vivo.com>,
        Brian Geffon <bgeffon@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel@vivo.com
Subject: [PATCH 3/3] mm: multi-gen LRU: add per memcg "lru_gen" document
Date:   Thu, 14 Sep 2023 18:47:45 +0800
Message-Id: <20230914104754.55-4-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914104754.55-1-link@vivo.com>
References: <20230914104754.55-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f74d37-e443-41c4-142a-08dbb510305e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbllqsoqE65tlnIMgdlySB379oyTzkTzRqX8cI8J0HHD4hdTdZIDYtERvdvR8jzV+H8ZjcRrUyPAs7VHOFtTyMJYkAtZB/lVQBhlN7vwyWEi3/u4WaPiWyRj8a1BlH8yQ9AN0ZILZLcPp4ekIqV8AAThlZHbTNXvsXGG1CRxLDZeZ7TzQNMu7PUGXX7fD8Euj7/mYo6sRavQbyaV31LFpypTGFkPK+BbnBZ0b649vlUTEvMq44ix9maQZ/7UQF4yhsi5NBvnSR8A8rb1ACjSZLUFr5jtsvefc3BlelkZak3XYyZm3rpgAin4ySnk9o48PUbkcpUQqLGnGfm7+VHWEWMyN6+Z7gYcDYQ1xUK2hWYwtN0YGqA/VpdsqQ8kWQTs28ce/UQe4MBBo7jwaDjW4pM3NTz0P6EROf8pS8ZpOat89oPRna44ZUbHDr4RKpnm5igNCRldTj27Ob2FZcRas4SDYodSgJOz2hOGKHC3hEtfrJi6JvIbtsEyWaUQRdFl8jTqOFp/XeQU/J1JcolEuR45Ehgw1e+5bD6QW9Mmbn5Yu78/A/HZxg2YbVwnKNZSSqMR2S9tdwYbBHjBMzEa8QSyzlLxZ31Tev4btZKv48joJfdViWC8284MI+3prQeb1/crHf0hpIQ+E9jq1OkIJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39850400004)(376002)(366004)(186009)(451199024)(1800799009)(6486002)(52116002)(6506007)(41300700001)(7416002)(66946007)(36756003)(110136005)(86362001)(478600001)(316002)(2906002)(921005)(66476007)(66556008)(38350700002)(6666004)(38100700002)(83380400001)(1076003)(2616005)(107886003)(8676002)(8936002)(4326008)(5660300002)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQU8WO003E0YvKvoZeysTOWdHvG8/DeRrGT73qN65Z09szoGw1Y5LAfe7ePS?=
 =?us-ascii?Q?eUSabuLxF7HhXfKLRwr3r+PAgJkDHqt6+hEw9Zx6ZT2JQ3GoQkw14YHBMUVz?=
 =?us-ascii?Q?W753gz5/j+KYU++ba6GAI8pMW5Mq2OfYTGuN7Aj4iiwYr4UdfE3s4NzG/tEA?=
 =?us-ascii?Q?SCRdQRpFZuZiyHFIRd4cg8p7jRuo2KXDIkYmECWg8hrgzxYqx9dS6h5kdEjS?=
 =?us-ascii?Q?dNtWOVTv6HVP9MJO58jyyBMSl3nPyWP9JZFxyN807KOopQqXj8iB9AK+DOK+?=
 =?us-ascii?Q?x4XkKOeu+MvM/M2ceOndYwi5AAy46qLBmk+PHN1658XqLEuNjy3OUFn3FCOR?=
 =?us-ascii?Q?JS9G2p8dnhUezTDd+QCf9LiscOuLmkHIos64hOHgLy6FPcC1veULS0aHqKeP?=
 =?us-ascii?Q?gkgJIdybeM0cgBMsfz7OhZREVO4NA/xZHshrbHAfDWYTYt3p/kfBYs6pN/6k?=
 =?us-ascii?Q?GOKC2b8ZUnaRQdLmJLWZluROFvB2HLSi5mWpFXH4LdHaaNl3qc1yG2KZpB2h?=
 =?us-ascii?Q?Gc4X8GTcFE5m3c9VXvL+0ykOeaiQkpenWLwnBZ3NBoTvcnD504F3UD6fdWIH?=
 =?us-ascii?Q?G+o82WMvoYZ7FfSPWUOi/rQrCjL0TCtNI3SWe5IqBgodIyDflNA7VDfqngZ+?=
 =?us-ascii?Q?engzhlZqfcZ8TrEgWrkQjNVTwNCMLIW5gfVkYXT26LTMb5t3+Siy74QFpn/b?=
 =?us-ascii?Q?Psh/YarBVyDZilcPXMvVPP10stctdvmZoWEjykMq5dqwuqbebF0UZSmrqBId?=
 =?us-ascii?Q?QzfgDB6Omv2d0XGqGtNoo5ML8LKh34VZi82shUKFp27BmbcsUVuPeWOKUWzI?=
 =?us-ascii?Q?hwZ/JmC3f1UxTHNh2c5swbCVKNlBJMyZCUdSRzQCqGFKHdN+kt5pL0dIElcD?=
 =?us-ascii?Q?+B9H49TT/6kLvsVbPwaNFo6iPvsDd5l8OKWcpwYWuD9kbMo/y/8bq0P2AQZn?=
 =?us-ascii?Q?PnUk6iAtKrrUx/VNnuFQ5HsaAN7h1SvsKKPnsBKhxDVikwpkgHNvB9lKc6zi?=
 =?us-ascii?Q?/VgBQcptmes6Fehfn8OI6JBnpdhHNJ6f+ywX1jveGWH4PY1lwzK0umQD9ldW?=
 =?us-ascii?Q?jJd31hPTB8WswaBMrjhGz2Ziyug/pCLWhPedu6so43oZdnOZDB7CF75GhmyG?=
 =?us-ascii?Q?MWRVR3bQ4ws7QAM92kH/xRSYvrOXvPf6WX4SC6Rko1WcySTB92WKsYPDw8Hl?=
 =?us-ascii?Q?jban1F0tBEMemYsFQHAKw5t6kf9+i5LuXW9rbyHWtDhukoCRMx7qnNB5wsxJ?=
 =?us-ascii?Q?lZMZBdHW1fT9EIUlY62hMHKA+9DsH5nf1ShQFanCenvHVV0fDGliRDgorOQb?=
 =?us-ascii?Q?Xo0lEDMfn2OrqJjSJ0fJbZdiQiYLhfYRwRqXA9hDADAl+n8coJ3dxq4jzZTY?=
 =?us-ascii?Q?mw4x+bNCYRb2it/wypmqA4fPVH7bhBMLPbJb04QOacu47q43kwvpEIEjuLXl?=
 =?us-ascii?Q?E/alz+pYCHWKvDyykM/9m99UY2KZ1t8RlNQ32w4HiTExuo+sCQJkc99cYBlZ?=
 =?us-ascii?Q?09Qy40jWA6zxVKNJkIh1+vv8Ii71U7nFdBaxfL2QF/Q9hjbbOGlp//YC0efb?=
 =?us-ascii?Q?hv+WIxWVfgl5eEkmSZ1y6yattt9VrOsRiSbaxvTV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f74d37-e443-41c4-142a-08dbb510305e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:48:54.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt+Q1Gm7fO4TO2GdmWZs7/YVcVumuPGrxEFVCqANd2UTNtj+mHzpDlhK+rnxuQxlJ9T+jo7d+lL3JADzuhf4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5929
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

change multi-gen LRU document.

Signed-off-by: Huan Yang <link@vivo.com>
---
 Documentation/admin-guide/mm/multigen_lru.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
index 33e068830497..078056b8cc7c 100644
--- a/Documentation/admin-guide/mm/multigen_lru.rst
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -160,3 +160,13 @@ cold pages because of the overestimation, it retries on the next
 server according to the ranking result obtained from the working set
 estimation step. This less forceful approach limits the impacts on the
 existing jobs.
+
+Per memcg lru gen node
+-----------------
+In each memcg's dir, it contains ``lru_gen`` node. you can type upon cmd
+without input memcg_id to do the same thing.
+
+    ``+ node_id max_gen_nr [can_swap [force_scan]]``
+    ``- node_id min_gen_nr [swappiness [nr_to_reclaim]]``
+
+For show info, memcg's node always show the full info.
-- 
2.34.1

