Return-Path: <cgroups+bounces-233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD27E50BB
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A871B20F50
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E7440C;
	Wed,  8 Nov 2023 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T5g6S6Tl"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E137D267;
	Wed,  8 Nov 2023 06:59:42 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36731715;
	Tue,  7 Nov 2023 22:59:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCraBDGS4nJwarZ3PkRvhZd8T/mhAFQIIROGgSIlLYDiOC/WmskRfqk6qfAscw3wSbp/UTLCQQVBv3ccRwvMbVuV0fXXJJlghCJ/4bCEKXMWpUSLv5rhACBqdAhcWWGvZbOJXuMljTlnsCekjzpguycCnx3diy6K8QGS/dp8lc+pDsdDLiBaRbshplypDDE1bQzHqhRTjnONWNre7HWOX891+6PnoGNGghAGgILS3emlPnqaVY6sa39DdhsPCBfDNf5bJCrwmM1Oh/Jb3INU/fHFRo3Le9v3zSU4HQ8rt0DGxF0bSQbOx9eSen/DjAZ3ggqqDScxXfAdRmbxcFk7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpt3abWMWZL86cwkXtjUBIcD5jhjGiRn8Da7mv9vXpM=;
 b=gL3lZEyVtmJWEIKiOJe0EBXFrpTe28Pk4dfVINXgw7Xdkmxxs+SA2ivCpVZsmaRiic6uXSyNH3mRc7PulyPJtjybJCOk7aStiSynB64VYUPo4AuFsDYHVZTkUes4LlNQifTgZ0GpzjSqT4zMttQg7aFjjQLj0RWCkv6XrKZC3w4A5dDKRlg3gAVe4DOhWIUX88V+n6hIftgsJDQ7ao/fWSWP3j89rbiHFVj17ATO5gWbO0T1gkjWOu6rXNS+JGCaDP8OY7wB/CBmrWuQtOMr6WcU0tO9M49x69ngjg+GuMpi/2JDafpSsXp4gqwXvg68S777y42nrjURfxE+cX8PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpt3abWMWZL86cwkXtjUBIcD5jhjGiRn8Da7mv9vXpM=;
 b=T5g6S6Tlf3UWfalMHqwfDUd1akd+qmNpuWnyKPIcik7mlHhPmS3OsnUTQJAY0QloERNytsjhUxRk1WuNO8lHYxqn2Uq1qsNOhyzWophTUR0VB4QEHUANJmfXaFQH8SwIVPrmgw4EiDG1iYIXJkko11Az8egS8Nnw9zKy3mwwHDTmVHFAgWIcFcWO3eQkwwGifqMLHIffNJBIW+AotG0ovr8qcAelTH4D9u843wLi2kH2dNxdlF5resw3ImwFVRFAZqeaoPV7CNFUH85OpY/MjyTKfasqVWbHp4gqyWYn7l94e2FWrJKwUYfUJHAkL1gLlS1gwHD5nBqFv8SANnh6+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB3983.apcprd06.prod.outlook.com (2603:1096:400:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Wed, 8 Nov
 2023 06:59:36 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:59:36 +0000
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
Subject: [PATCH 4/4] mm: memcg: apply proactive reclaim into cgroupv1
Date: Wed,  8 Nov 2023 14:58:15 +0800
Message-Id: <20231108065818.19932-5-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20acc9e2-58a7-4525-20d8-08dbe0284504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m0d0S7dPrYxKIv/KvKIcZDpSuhQUlfqSF38FYFnQ9sMAibzE1RQ04hVvFBb1cPkaNn84TF0tP729kh5cDm5iRuB4SGFz0Q5V1m78wtJG9qZwHZOkXMBzyoQ12p/GsATf8jwTgmbxvMedHfu7SbFZxUWdI3cnCRK6MPdqeDcTS19sBponAL05mkGmO4teCz4W56lPKITUaWp7VgPpX6rIVmXe/fhC4XHVCQ9PNq8Afxsa/6grdww1ezMKRO/AAQ32rePxyqvHnfoxSvgsCed4ZMdHOerh0rpcA/vbZ7MC2vPebwf6JXy9rju9MhGmsSafx7SYmgPh7s/p58cNh8iPzRDD0ZUSycznujZreMeazcY8q7DwkTLDY1BeLiITIL3LdTJ2/Ku71R+pR+CxaxizwoFSw4OKKEo27bv7i2DvwzSs998w7b3jhfKMJnu59JdLIotH14ELHOk+/J4p0QDRMrTS5aQclaSRHmPkxVSdoTlRwtxAJE8LuvnFip4YAGekZUNbdNcE9Wy/xMsqqsNzIPDLQQZdy13s7LCXv+5wegzLlJKlu1eLhoIfBMGa1C2YdvqsgUIp/YysZyKXpcGOGWWwmkjFf8R21N8mqHLABiKzrBaX6BqLYyWk/ad7nGRFUzdz+4qm9PAr/qXXeOIiEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(5660300002)(6506007)(478600001)(52116002)(6666004)(83380400001)(8936002)(8676002)(4326008)(7416002)(316002)(2906002)(26005)(110136005)(66556008)(66476007)(66946007)(86362001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(38350700005)(921008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlPaXpZhkN6WqfJIzxQvj13oPxcigxKR51rIimCIRc15ghggxGoQCKX6chvJ?=
 =?us-ascii?Q?n2FYADzlaOfqhWNotGDp5lYl9PrMg10eCNCbvVgOLAK9j34ilnYd+CdVJ1z5?=
 =?us-ascii?Q?5n9KPhjnMw7THTcCN8e9PnZi9BJTxTkWskCHXrWUqtxw4GTHnrYkLBgW29hB?=
 =?us-ascii?Q?Yw4UU+oZXhRcU9XicMvaoVWqxwZg5J5hgNVQhBAsYgGPsVUpKW62FlY97XI0?=
 =?us-ascii?Q?APrj+7cZ0CrBrQaQpcnTvFa++QzNEtRqrfAqTKgYcuZKtHgbZ3fj3ZqATakI?=
 =?us-ascii?Q?zDuGtHMKoWGfB5NZb39b40z2aDduSQpUgg8kWOyO7wvdxIseBDAJyz2Nz5yl?=
 =?us-ascii?Q?/azZayzpIveQgHsXwNW861OOB2fvbImpA9oKXi78EVWWiRVFzl5qmaYrTPp+?=
 =?us-ascii?Q?gmuhYdXqn6K2QCMXKPTA7+pU6paI5RMhGGyCqf9gYolcKrseGv8tR7Ksn26I?=
 =?us-ascii?Q?h8MDII6X15UuNpS6MHPCPs3Hcp0neKDITDmcqiQQDrQUxGLYhSsZLATbVwwD?=
 =?us-ascii?Q?HiOvsZMQoqvq9hydbxbi1JK6G0PCxN3acI8xaDxhQu1nI+UB4+0CrMdmJj2R?=
 =?us-ascii?Q?8v4XVVArv3KCpyuf/kFsMudaxZoN307DAkzHwb3GpZ6iCnovvRmJsXEl1jZa?=
 =?us-ascii?Q?GXPcl08rIcWH219JfIj3ihQlf/17r7yFEN9yclC+nxpQ+/5OZcE9MHN5tTVe?=
 =?us-ascii?Q?hTHwp4AngpGBoxVWpreMY1OJBZCGANkL2oaN2lvxNpNd1N0MDkooQncfRGUH?=
 =?us-ascii?Q?29NjPOGBntpuJeMMQjae7zWSklyJmaAWrbuHSNlx1MfvwRlWuesWGcTya1I3?=
 =?us-ascii?Q?Nz93gAoTwuBigJu0ewfuERSI3wXfOw2TMPjLhxSMHHp5sIWFq10HMqYBMNt3?=
 =?us-ascii?Q?X2CCHdFiu2mScy4vubCY8Bj+laqGAGOBbpGNhHnn7TPkS06eni0SPFMHl9P0?=
 =?us-ascii?Q?KWBAshtCACY6oHbyZDnjqUaCl2q8OXXHmMUFjfIWo49c+ko1z+ygswXvNfu+?=
 =?us-ascii?Q?YLvtt+9g4yHUXe3M1LFyQj459P0BapCN29vXTYJpKxEtHXG0uLYmob2Bl58a?=
 =?us-ascii?Q?rFeoJOpQzVpYCQuXCZwdIv2OKg2jL1y+9nv6L/c46bdv8jWo4izEapInqyCg?=
 =?us-ascii?Q?N5O630s6Atzn7j+CEAdtzxeYqSXfVo2l7EIv56FrJ9982GQcpJ0d1plSD4NS?=
 =?us-ascii?Q?nA0HttGzIpGztzOvykOMqvf4Jpi3SkAbZ/hrH7kKG367NNfz6i8UVkumYfli?=
 =?us-ascii?Q?Unpfhe2AnqW5PRO1rW+n1idoqhf7BY2aAgh0FwDBhVnLxaDFiW5YxXj/HpZz?=
 =?us-ascii?Q?n/h5m+/X6KfChCx16bZf72xH0wiHm/C32g2WzMItWbU2Zo3lwUeZ7FNnGb5U?=
 =?us-ascii?Q?8KV29POxYGh8tpWvgAlrESNRr7c+Yds4Zksd954cUeAAJl4pqZwdOdSvfx6k?=
 =?us-ascii?Q?c8/5dfyz0tM9Ue1znhmk68d5zMHkInbNcQsMqDCqcf861b11s6t8ZZPNj4vE?=
 =?us-ascii?Q?Nt69q8zQn51P2AzISTeJ/hUZWHKjqlKeGdZpLsPnf9xeQd0H/AODOezyMrbD?=
 =?us-ascii?Q?NDy6TGTxwvWFL6F0MuaIewp9qz0Yljc/9PC12zlg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20acc9e2-58a7-4525-20d8-08dbe0284504
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:59:36.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSS/k6YWNSQpN8HOWteW9MF3EkxY5wmnTwpXNJvyn9d3FdCwRi+q7gY/OPiSeUcwPsWYbIZSokxxEzzINpjYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3983

For android use, apply proactive reclaim into cgroupv1

Signed-off-by: Huan Yang <link@vivo.com>
---
 .../admin-guide/cgroup-v1/memory.rst          |  38 +++-
 mm/memcontrol.c                               | 170 +++++++++---------
 2 files changed, 124 insertions(+), 84 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index ca7d9402f6be..600bf26a470a 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -90,6 +90,7 @@ Brief summary of control files.
                                      This knob is deprecated and shouldn't be
                                      used.
  memory.oom_control		     set/show oom controls.
+ memory.memory		     proactive reclaim.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
  memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
@@ -972,7 +973,42 @@ Test:
    (Expect a bunch of notifications, and eventually, the oom-killer will
    trigger.)
 
-12. TODO
+12. Proactive Reclaim
+========
+memory.reclaim A write-only nested-keyed file which exists for all cgroups.
+
+This is a simple interface to trigger memory reclaim in the
+target cgroup.
+
+This file accepts a few key, the number of bytes to reclaim.
+Few nested keys are currently supported.
+
+Example::
+
+  echo "1G" > memory.reclaim
+
+The interface extended with nested keys to configure the
+reclaim behavior. For example, specify the swappiness of
+memory to reclaim from (anon, file, ..).
+
+Example::
+
+  echo "1G" 200 > memory.reclaim (only reclaim anon)
+  echo "1G" 0  > memory.reclaim (only reclaim file)
+  echo "1G" 1  > memory.reclaim (only reclaim file)
+
+Please note that the kernel can over or under reclaim from
+the target cgroup. If less bytes are reclaimed than the
+specified amount, -EAGAIN is returned.
+
+Please note that the proactive reclaim (triggered by this
+interface) is not meant to indicate memory pressure on the
+memory cgroup. Therefore socket memory balancing triggered by
+the memory reclaim normally is not exercised in this case.
+This means that the networking layer will not adapt based on
+reclaim induced by memory.reclaim.
+
+13. TODO
 ========
 
 1. Make per-cgroup scanner reclaim not-shared pages first
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a0e460abd41c..03de3387d714 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5209,6 +5209,89 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 
 static int memory_stat_show(struct seq_file *m, void *v);
 
+static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned long nr_to_reclaim, nr_reclaimed = 0;
+	unsigned int reclaim_options;
+	int swappiness = -1, org_swappiness, n;
+	char *tmpbuf;
+	int err;
+
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
+	if (err)
+		goto out_free;
+
+	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	if (swappiness != -1) {
+		org_swappiness = memcg->swappiness;
+		memcg->swappiness = swappiness;
+		if (swappiness == 200)
+			reclaim_options |= MEMCG_RECLAIM_ANON;
+		else if (swappiness == 0 || swappiness == 1)
+			reclaim_options |= MEMCG_RECLAIM_FILE;
+	}
+
+	while (nr_reclaimed < nr_to_reclaim) {
+		unsigned long reclaimed;
+
+		if (signal_pending(current)) {
+			err = -EINTR;
+			goto out;
+		}
+
+		/*
+		 * This is the final attempt, drain percpu lru caches in the
+		 * hope of introducing more evictable pages for
+		 * try_to_free_mem_cgroup_pages().
+		 */
+		if (!nr_retries)
+			lru_add_drain_all();
+
+		reclaimed = try_to_free_mem_cgroup_pages(memcg,
+					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
+					GFP_KERNEL, reclaim_options);
+
+		if (!reclaimed && !nr_retries--) {
+			err = -EAGAIN;
+			goto out;
+		}
+
+		nr_reclaimed += reclaimed;
+	}
+
+	if (swappiness != -1)
+		memcg->swappiness = org_swappiness;
+
+	return nbytes;
+
+out:
+	if (swappiness != -1)
+		memcg->swappiness = org_swappiness;
+
+out_free:
+	kvfree(tmpbuf);
+	return err;
+}
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -5272,6 +5355,10 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.seq_show = mem_cgroup_oom_control_read,
 		.write_u64 = mem_cgroup_oom_control_write,
 	},
+	{
+		.name = "reclaim",
+		.write = memory_reclaim,
+	},
 	{
 		.name = "pressure_level",
 		.seq_show = mem_cgroup_dummy_seq_show,
@@ -6946,89 +7033,6 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
-static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
-			      size_t nbytes, loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
-	unsigned long nr_to_reclaim, nr_reclaimed = 0;
-	unsigned int reclaim_options;
-	int swappiness = -1, org_swappiness, n;
-	char *tmpbuf;
-	int err;
-
-	tmpbuf = kvzalloc(nbytes, GFP_KERNEL);
-	if (unlikely(!tmpbuf))
-		return -ENOMEM;
-
-	buf = skip_spaces(buf);
-	n = sscanf(buf, "%s %d", tmpbuf, &swappiness);
-	if (n < 1) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (n == 2 && (swappiness > 200 || swappiness < 0)) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	err = page_counter_memparse(tmpbuf, "", &nr_to_reclaim);
-	if (err)
-		goto out_free;
-
-	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
-	if (swappiness != -1) {
-		org_swappiness = memcg->swappiness;
-		memcg->swappiness = swappiness;
-		if (swappiness == 200)
-			reclaim_options |= MEMCG_RECLAIM_ANON;
-		else if (swappiness == 0 || swappiness == 1)
-			reclaim_options |= MEMCG_RECLAIM_FILE;
-	}
-
-	while (nr_reclaimed < nr_to_reclaim) {
-		unsigned long reclaimed;
-
-		if (signal_pending(current)) {
-			err = -EINTR;
-			goto out;
-		}
-
-		/*
-		 * This is the final attempt, drain percpu lru caches in the
-		 * hope of introducing more evictable pages for
-		 * try_to_free_mem_cgroup_pages().
-		 */
-		if (!nr_retries)
-			lru_add_drain_all();
-
-		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
-
-		if (!reclaimed && !nr_retries--) {
-			err = -EAGAIN;
-			goto out;
-		}
-
-		nr_reclaimed += reclaimed;
-	}
-
-	if (swappiness != -1)
-		memcg->swappiness = org_swappiness;
-
-	return nbytes;
-
-out:
-	if (swappiness != -1)
-		memcg->swappiness = org_swappiness;
-
-out_free:
-	kvfree(tmpbuf);
-	return err;
-}
-
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
-- 
2.34.1


