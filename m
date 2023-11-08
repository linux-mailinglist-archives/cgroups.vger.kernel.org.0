Return-Path: <cgroups+bounces-232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6457E50B7
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21109B20F4D
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143FBA52;
	Wed,  8 Nov 2023 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Sj8IDEbg"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB68D26C;
	Wed,  8 Nov 2023 06:59:33 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E261723;
	Tue,  7 Nov 2023 22:59:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/v/3DHoUM7PQJydUF0zXCw2oQGQznx7ooJ107rXM2INN8EPXeOmygABV49OxiNTZ3xsis+s5LeV6BLXkvfGiNO3UmJ/leUKttmVKe00+h58HZyADIU8VLpOlmD7TlD5kXIPM2QGvDSUk+h5m7u6wX6qC9UuFypKmpiAFdnPeJnovBVrB7mQNohOVtT3mG3+H5xvvLx4lDbouiOycnwcRdq9O2UeKxSJYuIzfmbFFL6/Yk636UWWqzqt6eVn67xPuoxluBpoh5Td5r2msxNERB6P0Sd3TzA6EgIAlBEd555LJGrHEQdvMxbWTfsiwJGazrAgOxTnGXIEAu/UbftpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/a3qGG+gxnMlTwRqqKpV2cYE/HaVgtTpeXXE6orwqA=;
 b=SNw4AzEH82JxfSidnD3UxZ16kXprEWxThCUKsDA2roaag5ziB+oayFxX4tSsJ5hJywSRTFhSZfwbkkWuGQ2gF0JQm0o7v7FVi20xrJ2/OZjVCxplG6fXHXGvDtSgAm78q0JBJnxKvv7NRa5JGmfKz5aVGIJcP4pomG05Wq7NT1UWYmL7Goo+HoKU8jcn9D1ZpT8cnKzikApMvH2qjSsNLpKF8CGj3SSQ9EFbUQov86leWDNFxAEzD0TkgQsQoay3WcM2s91hfn/dpJUJMPsRPQR2bYVifyivyPY3MjIXpL2liHPmKnmPKQIC2r/k5Gtwl9yOsihYv44iiW4FaFVQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/a3qGG+gxnMlTwRqqKpV2cYE/HaVgtTpeXXE6orwqA=;
 b=Sj8IDEbgtHPcGKQ05v584Fp3mcp3Z1zdzUYU0gVIgA10s3UaGuYvHna4AHg8pJqHEBqDMmr4gtRBSQ8Ms9UQhqOhayUkZ/Yyluqu/AzGUek4Xw8ldfv/ErYRzz/fKuelhNlkHMTtRa4VFVGHs39CCc8vEH32m24RjwOLsY26Q3Z3CdjDBspU7IbvaiPTNY7KjH7rviMsSRyiQ+q4mXdB6FZC/1OMJDpMbwxFDaiGpGcsdRIhD9q76e8TBcDlyrqDGg2BA5MhhyRMThNpsjlrdHiK4SLUrZUdUT0rRh6oYtKtzzqu6HjLZBbAEmK5UnB9ubnAckBvd8GWRVztfCkbaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB3983.apcprd06.prod.outlook.com (2603:1096:400:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Wed, 8 Nov
 2023 06:59:30 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:59:30 +0000
From: Huan Yang <link@vivo.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH 3/4] mm: memcg: implement unbalance proactive reclaim
Date: Wed,  8 Nov 2023 14:58:14 +0800
Message-Id: <20231108065818.19932-4-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108065818.19932-1-link@vivo.com>
References: <20231108065818.19932-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB3983:EE_
X-MS-Office365-Filtering-Correlation-Id: f00081a1-2242-4184-c1d2-08dbe028411a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H3auOJeIIWjtcC7WXVsZ3rGrFwz2HnOtxFLkdptslO/e/87jVncveHSPNPLRrW/Fa62/+D0owwn4wZfRibKrhFAmKZnSPCl2M2MNh4BVDxC665vFlfpo+RxdaN/9gsWlh8RnEcbj4Av27BtUBoQQMw+OYLIPolWR2Gqfr6vOAEjenw2sVM3qqexGXOTdeJjSAhuVZ4MFyXIG8YaAS+0q4sGSnw2vSuDc0WIUpcouTl482C5/fIeZBw4u3/tq7gQYMnZkrg+jENv2q13ShxnltlNVMuXB+VJw6aJ83CY7p9W4PVxwBSmaURmymEdRvKSZdzgSYix2JbtymJ1TdF68VREVyrL1cB5800s/j0KpzvMZbx637KDReCp/8xPxN+25OGAyAQIHaZeCmV1H9I/XfhHDbLXtbfhauci3Vwlzqjzhdin8Vx8/sGgIYb2Ssau2ckc7B8v294Zs/V4G32uCF4zaiJDWhzgEq/snMMokXlub8mVMMiCqu5LnkagtZe45g/3NSLKx0ahB+QwmRFxRARmEa1caZAB0S8BdIp1yxjopr9CYTnuOCwHpLyKeSg7puMm0ylE9vNdwW9MrfWsTKFswbNtv73egIkEDrBk0dGfBKIaOzpRrUh0MBiuWM1WlB9ElXsdYYNocbrb9QCmWgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(5660300002)(6506007)(478600001)(52116002)(6666004)(83380400001)(8936002)(8676002)(4326008)(7416002)(316002)(2906002)(26005)(110136005)(66556008)(66476007)(66946007)(86362001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(38350700005)(921008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BS3Nsbd1Wt+eTrMDCWB47aIWx+76v6eyIIOgogKDDxRXbb5SyUh05lKj0Jm?=
 =?us-ascii?Q?uLkrt1pkQyNvrnLkW9rNCOI0YkoePhxJCEpzg82r9FJ7FZlBLEBTWLyTGDJa?=
 =?us-ascii?Q?Sf/dxYBanIbWHrEIBBWVayIhtMJDYeWpFn2/38aD+lzv+Ni+laE9+ygd0qw1?=
 =?us-ascii?Q?gthOPFrrY+tqpGbkUDEOK4YBpv71C+7uyge/HSqGMnEX99vPM7t/3UrdbBb0?=
 =?us-ascii?Q?vuQyv1I2Doe4VmA6WZH8QyWbdEQlD2Bx22I5gCeJftOvS268H5tsZoA+9uq1?=
 =?us-ascii?Q?GROEOca/bu8sNgerR1TvHnUrJEEq44tes6Bb08rLTJ6HhOK7ZvgcIpxV9VbM?=
 =?us-ascii?Q?t/8WgCa/CW31rPChetROeCzRj3hqN87y9e8a1K16A8i4CM9pporI08eFhiDM?=
 =?us-ascii?Q?AAGFqFcB3eu4XnDKquXb5xxL3+wDblfug3Vt3bBudTQsfdTCsIIdb0KqlzJS?=
 =?us-ascii?Q?TLiTJj8vkDyCXW9RJhsSI/nw3ddI6qNNgy5LsxMUolhxw4AcKyq0TFGXZI0Q?=
 =?us-ascii?Q?QfIN4lCZVDYLf28Sts8hDDT4sLSHXgCOrCTVX6zaHeTMx/DfR4Z75z96FE9u?=
 =?us-ascii?Q?0Y0J/iA+YcWri+sHOaPrwr3/T02j8ZX4tKO5bi/kFRlUvJb9hkLCKbBL45mq?=
 =?us-ascii?Q?rC5rvgtjeYpMwNvmR3l3PQ1/UKyn2OC5zfhNAo0o2mPmkFZNNsBkI70RteHD?=
 =?us-ascii?Q?fU/ItcxmIAyxUGP9ff59q23Q5cqoUPs6lypIWQ3rFSd4Ha2BP293Ld/GaVCO?=
 =?us-ascii?Q?fwDiIk+XVsZLVGAGkFspx8y5Dumujv6R4fwbGcnykY0gqLrGQpDe7D0sEryd?=
 =?us-ascii?Q?dW/LLjOYjSUwQn5Hao67Xnus363ggcvpL/e0UfOghyYxlWO2XFWNq81Frigj?=
 =?us-ascii?Q?smIggsS2cwP1QRC4tX0BWjbf1LtoTITcf3b2OxuOvRxjA1opHjkS/b3fNjoK?=
 =?us-ascii?Q?c1375dNqpWFxqbyFgSTLOUmo1vKGcWpyF+l3t+Wf6KywsTdEy5rpG7MP/NET?=
 =?us-ascii?Q?aSKForjnrhzEQOL9FYVyfAySRW5dcn3e9HdtzFYgNklH00hlmmkjeGs+TmqR?=
 =?us-ascii?Q?cuDI1DdJUdxYls8uT+o7MMqS/6fzekValbybtjKq+E/zh9H5HC568kSQEprc?=
 =?us-ascii?Q?G+3PD/ZhWlNIipap2cBHLUKjPhLSc/tMfmu+wg4ejKGX8EMRV78vGsa4nAc8?=
 =?us-ascii?Q?8YDPNb6C074o7QQrfOno5HvG2IMq04/ZZGjOgaiHx1XfEtVYs7RqPt3xl/nT?=
 =?us-ascii?Q?A4nE24g2QOcqyjJYRAF26kj1uqbK0GHanRv0+WCBuPaJjoqFJ1LOZHpC+qUS?=
 =?us-ascii?Q?zmMoWj/v3J8UlVJzOpUKIdIrUqDut83QPJv5vMI9BYf1W58ZS38fmOdxQkbv?=
 =?us-ascii?Q?I12pTzj+zcaIF6OI3HWTPfl/K49phR1a5sYLH1GLlVLW/HFaEyDlmX/8Jor9?=
 =?us-ascii?Q?mmZat8LTrotxgWSws0PxPAqYMqPQJoXK0IdEzkwG0OMqTxogg6HGDwJUoqlU?=
 =?us-ascii?Q?Xl8C7cFN+hRF9UfMQxNdnJhVqRqJRdgHDqnUq78Xgkwfg1VWfrukgH7KyPBH?=
 =?us-ascii?Q?FVVqw6Z7NeUTNl0PMdEvhc3Vtp7nOZffFBIhqGpI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00081a1-2242-4184-c1d2-08dbe028411a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:59:30.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9lbTUdfwed/zxPwztNYWJBon8MAeXOIEcPvXi2KMgAXQcTC00KcnSW46ar7mKHjU2PK9BmgFwOBFB2NTrKZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3983

This patch add swappiness arg into proactive reclaim interface.
User can type "bytes swappiness" into memory.reclaim to control
reclaim tendency.
Specially, user can type below to only reclaim anon folios:
`"100M" 200 > memory.reclaim`
Or, type below to only reclaim file folios:
`100M 1 > memory.reclaim`

User can only type key into memory.reclaim to keep original use.

Signed-off-by: Huan Yang <link@vivo.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 ++++---
 include/linux/swap.h                    |  2 +
 mm/memcontrol.c                         | 55 +++++++++++++++++++++----
 mm/vmscan.c                             |  2 +
 4 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c153d0c75f34..5a471ac7f0c3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1275,16 +1275,22 @@ PAGE_SIZE multiple when read back.
 	This is a simple interface to trigger memory reclaim in the
 	target cgroup.
 
-	This file accepts a single key, the number of bytes to reclaim.
-	No nested keys are currently supported.
+	This file accepts a few key, the number of bytes to reclaim.
+	Few nested keys are currently supported.
 
 	Example::
 
 	  echo "1G" > memory.reclaim
 
-	The interface can be later extended with nested keys to
-	configure the reclaim behavior. For example, specify the
-	type of memory to reclaim from (anon, file, ..).
+	The interface extended with nested keys to configure the
+	reclaim behavior. For example, specify the swappiness of
+	memory to reclaim from (anon, file, ..).
+
+	Example::
+
+	  echo "1G" 200 > memory.reclaim (only reclaim anon)
+	  echo "1G" 0  > memory.reclaim (only reclaim file)
+	  echo "1G" 1  > memory.reclaim (only reclaim file)
 
 	Please note that the kernel can over or under reclaim from
 	the target cgroup. If less bytes are reclaimed than the
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3ba146ae7cf5..a024194301d4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MEMCG_RECLAIM_ANON (1 << 3)
+#define MEMCG_RECLAIM_FILE (1 << 4)
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be2ad117515e..a0e460abd41c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6953,19 +6953,47 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	unsigned int reclaim_options;
+	int swappiness = -1, org_swappiness, n;
+	char *tmpbuf;
 	int err;
 
-	buf = strstrip(buf);
-	err = page_counter_memparse(buf, "", &nr_to_reclaim);
+	tmpbuf = kvzalloc(nbytes, GFP_KERNEL);
+	if (unlikely(!tmpbuf))
+		return -ENOMEM;
+
+	buf = skip_spaces(buf);
+	n = sscanf(buf, "%s %d", tmpbuf, &swappiness);
+	if (n < 1) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	if (n == 2 && (swappiness > 200 || swappiness < 0)) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	err = page_counter_memparse(tmpbuf, "", &nr_to_reclaim);
 	if (err)
-		return err;
+		goto out_free;
 
 	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	if (swappiness != -1) {
+		org_swappiness = memcg->swappiness;
+		memcg->swappiness = swappiness;
+		if (swappiness == 200)
+			reclaim_options |= MEMCG_RECLAIM_ANON;
+		else if (swappiness == 0 || swappiness == 1)
+			reclaim_options |= MEMCG_RECLAIM_FILE;
+	}
+
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;
 
-		if (signal_pending(current))
-			return -EINTR;
+		if (signal_pending(current)) {
+			err = -EINTR;
+			goto out;
+		}
 
 		/*
 		 * This is the final attempt, drain percpu lru caches in the
@@ -6979,13 +7007,26 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
 					GFP_KERNEL, reclaim_options);
 
-		if (!reclaimed && !nr_retries--)
-			return -EAGAIN;
+		if (!reclaimed && !nr_retries--) {
+			err = -EAGAIN;
+			goto out;
+		}
 
 		nr_reclaimed += reclaimed;
 	}
 
+	if (swappiness != -1)
+		memcg->swappiness = org_swappiness;
+
 	return nbytes;
+
+out:
+	if (swappiness != -1)
+		memcg->swappiness = org_swappiness;
+
+out_free:
+	kvfree(tmpbuf);
+	return err;
 }
 
 static struct cftype memory_files[] = {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9243a1f0d606..f4221ec833db 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6505,6 +6505,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.unbalance_anon = !!(reclaim_options & MEMCG_RECLAIM_ANON),
+		.unbalance_file = !!(reclaim_options & MEMCG_RECLAIM_FILE),
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.34.1


