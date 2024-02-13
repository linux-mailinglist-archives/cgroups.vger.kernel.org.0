Return-Path: <cgroups+bounces-1507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B455285309C
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249A9B2499A
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AED3BB3A;
	Tue, 13 Feb 2024 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="S1hFuMtT"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068172EB12;
	Tue, 13 Feb 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827776; cv=fail; b=fVjR4ZU0xjEcodPKs/yXShpGVNGDfBaq8Fns7SCWzkZI1eN/cyFRrQ27OBXcUfjx8GwWvBVeoG9vAZriEiYSVutcvo9kklDEEWcyzp/h5V/UaSmLrWW33YG59+Jjb/xUl/0J299jB97V1xbr/OgCSM0xIVS23WgoVuo9J6EqZH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827776; c=relaxed/simple;
	bh=W5lDbrBfZ4w9K8mc8WuM9LN4ZmyR88UOcsbdNUVFZeA=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Pnmgkf7uTIKqi3wPbs7ge+ldlvc6BXVLiwRxi525/fYV77kyjzqPxKVYCK9qWIsPMs7TeXhoJqZKJdoc+Ll+0V4u98QgQbNCZqZ3Jfw8aJhUWaVJ3hQgB4JQoJuqBwKXeENKCVG94W+IVaumJ30hHFMLLl9HgrNcXfYjneW4fXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=S1hFuMtT; arc=fail smtp.client-ip=40.107.223.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwl+5EbwTvugQS1Q7iwAtk9sKF9rhUOCgeAJlxlNdBGyhm8YyYa0MiOl4GwJ/XNWDmMnbQoFtc3Xgs1OwHCQ1/DKj8ZnclLXC/1aR43ZKAxsunR2Qiq1VpkCgmz+lAzijcFSSh2zIp7VxUViaYd8vGjviAen2DVYVvwKSrsTtNAmBqbdDzXWKgJ4rsxbLu1d0XURmPeqjOooY27YiXmGa150GC7C5/lZ+b4vTnNFch1BkgY8JM02Sf7VjXOnF5lcUH5a7AnAldEnOMU+xec2BHLE5i/6zpbefF0V1Qy0nfv/A21JlrdFMP5SlDjzJZTsX7ZsQGqGoAvYi9ku9UYG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OaIjqPI79Qx00eUjhBIJ6pNzFUVtXCr9JC8O5VwCdM=;
 b=Wagn5h6aSxbf++D2xtR4OqVCKnOrHfayGPCUkxYHhCcafXRMC5pVt06m4UY5U5NNCdOfJUF9xkaDKGhMVLjaJIZ/FXV8V9iCCsMqlZQSL3guyCcfRAJHCpygdVrzkiiXRMpUBfsHFVl8YIX7gQRawO/ONaEqQN5wkbRGRpDTIm3mb/V7DecGAfEQLEXZ9rk8/Gl+BuVmAGrvjSlLZxj3cqy+AkIltvtN5Tiu7845k+QXQ+uSkHOBk4V0r9Zw2Hkn4KzmPAfklewvyexxM8qIBdfr1ttLT7mfOOAPew6M0auejNd64aHOkxL6cNH6vTRKdk8LrCixt4WMlFAfTx9xEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OaIjqPI79Qx00eUjhBIJ6pNzFUVtXCr9JC8O5VwCdM=;
 b=S1hFuMtTlhPgiH1rSyfOGk7RsrpCYueA3t8Rz8/YYNyO7vE367vPaxcvX4xVKZJm2zV4aa2uryWYK9qy9eoFCjofaBixaNbRxbCP0T+2xBar52rZc9TzvkN3nk3Z/IaJIyvS3Dx8NxTKWuQnL0I19upkfpx0GcJ2rMI+s7M2OuysF32a1wE3QQgz4pZEnhFnNnwiqfRW390KuUg2a1jGovpxMLW7wk/TjgZmjKZ9Y5HM1rr3op3vPc80RFXkZPPdY7HekXfU5nOQ+YWDPg7iqsCxWvIy9u4k2sSyZv+tYXnQ2elrBagvocyP9mdre6bDOI7i4pj/emyVWraQauqzmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Tue, 13 Feb
 2024 12:36:10 +0000
Received: from CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3]) by CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3%5]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 12:36:09 +0000
Date: Tue, 13 Feb 2024 20:36:03 +0800
From: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <longman@redhat.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH v3] cgroup2: New memory.max.effective like cgroup1
 hierarchical_memory_limit
Message-ID: <ZctiM5RintD_D0Lt@host1.jankratochvil.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: VI1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::33) To CH2PR11MB4342.namprd11.prod.outlook.com
 (2603:10b6:610:3b::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5bd3cd-f809-4255-d45e-08dc2c905b06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+TbHQVpxpVUYIH06VDO8b3qI9tMswF/T9qVeaUOTvQcDGmJIYHdo5ciIh8Ath/52wj0HlJ3AO9BjNG7jsDUjYBeLuW5J6OCUc8IsA0q7ZsiFbOAaK/8IuqxtSFhoKr3QcRMNc4ZpOyAQTDOVrDJtwydExDW0DqRX0UjzEmhpxQ3EM/D8/aovMFQuNsYpn1m/lqA7BO2+lCXYcsmW98UvktdZiy5qnbYLLIYpIb/G8rAEYiIZRUjuzHE6dfoafS7UhS6L+ffnUnOKXdb6SRzjznJSgRmw1jO6xcNGnOHfE+C0djuJae8DferlM7M81H2AuFBM/VUExDTOqneYy6+WbXPUzzvS16DWOC+Re3lfjnaJcSGs+lSvZYx+/weRfbzHmMm17kAk4R/L1TcihwodRNJ8AdBhSkiCjMcgYfjzKCQv2tkp9OqLwlLFeGU5MWJbGBHdeP4Ny+gbgqpVS0GoSix9y8uirH2XwjnxREG5rGr8xn8Eb+ejJrWo341xCPO8UM1/PxT8eUl0m1FgOMiJzf5kmfvLMUWww8S1N3jqvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4342.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(346002)(366004)(396003)(1800799012)(64100799003)(186009)(451199024)(6512007)(478600001)(966005)(6506007)(6666004)(6486002)(83380400001)(2906002)(5660300002)(9686003)(66476007)(66946007)(66556008)(8676002)(110136005)(316002)(8936002)(38100700002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zvqERnlWzLYS7QUyZZehgVVj2q5SAc18ny6Xw4RZkZMc50S45/z9HVGUxZkg?=
 =?us-ascii?Q?mP1hOte7pWI9q32EJs5CXLsCPi0ouE2IiNC2X0HKP2Vnpcrc/xi02bLPmjdQ?=
 =?us-ascii?Q?rmuDu4pp+FUSscYe6AbpM0xnG7Nvqp3iriz52j6QAod6c3vSmhORCtmNNUtw?=
 =?us-ascii?Q?MV4G2HD8gNWAleZhn+G17exbxZCPREjf96ID1JXAtAHvvVLo4B0L/4mv5zra?=
 =?us-ascii?Q?+6KpJh3hRnS+uACwnTk94wv12aXDw3AVZaLfcYQAG/jp412UryA0bFYHgYmF?=
 =?us-ascii?Q?kyY4GjxP8pLwJpynkbplQSgZye7HNmlWe+dmk/oUjW6chPEcy/4EbjiCoZz6?=
 =?us-ascii?Q?E2TVxmvZ+wY8vkLj8MiNU30o1v9nc1DqGv1FQQT4q56OxNFlJh7grBj862bE?=
 =?us-ascii?Q?Z0sL+Wb2ynVDRu6+ZGUiedQKPnMfxmris6MPjAXP6yb20EktGhUs6c5i4RQJ?=
 =?us-ascii?Q?lsue0UUQsr0y3m73O9USOX7LxLAeXt0bMU9bLqOSJwRt3i7UmCM8ao2i9db5?=
 =?us-ascii?Q?J3t2/EQ/HRxuF50pQ1p9os2TqH2XPuPUoXMr2hW61Q6KZTMY2jR83k0vSROz?=
 =?us-ascii?Q?5TfLYImY74sJ8onQ0HrDDxePia1P9eybOJKQB72qR1Y9mj27XLlCNhKts8zo?=
 =?us-ascii?Q?12+D+mbJ6Li7ZjkPUsAYVXwCyBMlvuQDF1d5im32RAp7Onldh/Nke5kQrIPa?=
 =?us-ascii?Q?qxvOsXIXw6jCewuHCK473UZyggoPTL4O4wYZzZwXqXEI06PEiEq8qLC8g6sJ?=
 =?us-ascii?Q?Baox7B9sbcrc/qt6nHSFtSlZIrYA7cHneq7hc0qFeGUStHqXqrXIMHcnzAxq?=
 =?us-ascii?Q?D0IYNsWeQMtRYUI4a8g0PTevVZJiBWn1qSbppo7CmY2r9eENgQSOWRLs2vo4?=
 =?us-ascii?Q?uT6tJwN6+EjtkdTTyjqfD0K2TpOXfAjmjqacx7mK+aqtHfro6GzMy9/0EBlY?=
 =?us-ascii?Q?wrZOpfTd+M4fCgU7MluSsIWI+Se/w7GSJHMd+mFUk68yoM9r7CDlxXfiGD++?=
 =?us-ascii?Q?XocYO01hlzEdDKReM9B12gFv1vUl5QDlYHxJjuprxD5Ktbs8URY8mLVMIzts?=
 =?us-ascii?Q?YRQgaAxhUUGlMJwImgXccDAikzNjPYVaKozOngk+UFpSzM/1uJYwtm/6jFH/?=
 =?us-ascii?Q?0XXj1y31Tk+VNFVtweecR/g30Zgr3dtthA7OvV39RnwkCti6k29JfLep8sKq?=
 =?us-ascii?Q?PBNiPRMBRSIBY79/lCn28B5R25ewhfRrXz1BDRcahDi8X6A23G8AjcKz7J26?=
 =?us-ascii?Q?2ieMI16VkR0a7SbkbKcghi8+xBeCdYZetF3i/vVJjVkNbM2Y8Ha81XdnCNZN?=
 =?us-ascii?Q?cWrV+0Ubfgz1cR2NC85atx7EAS3eOaeYLWjE6QXZ3p/xV7QZtwzL9A3DZhz4?=
 =?us-ascii?Q?cbjCg8aB9rK57H+42+Aeb+/N6W4ViXrPHMT+UlN7rgQDFVjUP2GmbTNpruZy?=
 =?us-ascii?Q?0LHirO8NnmnLyXV1jdnFTuuNU+De881nFaRfz370n6Ge+TT3UndeSetp+s4s?=
 =?us-ascii?Q?K6rJe7jA/d9R8JtpYdJz7uZxEjLTNyWGLXMEBZRORcvmNxjCQt4tZ3bEVh8L?=
 =?us-ascii?Q?JQAUiTfPXUYkyZyGwE4AhiS4W+b0VDVDqtsk6hpwbs0ewd9vsEgq3DtW9f34?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5bd3cd-f809-4255-d45e-08dc2c905b06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4342.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:36:09.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zlAwKsSkuTjHTBzkDhAjrAOX59PedNDE2QgBFec+I3281/I7S9QupMgYoQ2ZHbHU0zqr3UW0dneWX1PUFYLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283

Hello,

cgroup1 (by function memcg1_stat_format) contains two lines
	hierarchical_memory_limit %llu
	hierarchical_memsw_limit %llu

which are useful for userland to easily and performance-wise find out the
effective cgroup limits being applied. Otherwise userland has to
open+read+close the file "memory.max" and/or "memory.swap.max" in multiple
parent directories of a nested cgroup.

For cgroup1 it was implemented by:
	memcg: show real limit under hierarchy mode
	https://github.com/torvalds/linux/commit/fee7b548e6f2bd4bfd03a1a45d3afd593de7d5e9
	Date:   Wed Jan 7 18:08:26 2009 -0800

But for cgroup2 it has been missing so far. Based on Michal Koutny's idea this
patch now implements "memory.max.effective" and "memory.swap.max.effective"
files similar to existing "cpuset.cpus.effective".


Jan Kratochvil


v3:
memory.stat fields -> *.max.effective separate files suggested by Michal Koutny
v2:
hierarchical_memsw_limit -> hierarchical_swap_limit fix found by Waiman Long
v1:
hierarchical_memory_limit && hierarchical_memsw_limit in memory.stat


Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>

 mm/memcontrol.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ed40f9d3..8c4cb5f60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6845,6 +6845,19 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long memory;
+	struct mem_cgroup *mi;
+
+	/* Hierarchical information */
+	memory = PAGE_COUNTER_MAX;
+	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
+		memory = min(memory, READ_ONCE(mi->memory.max));
+
+	return seq_puts_memcg_tunable(m, memory);
+}
+
 /*
  * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
  * if any new events become available.
@@ -7038,6 +7051,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_max_effective_show,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -8040,6 +8058,19 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int swap_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long swap;
+	struct mem_cgroup *mi;
+
+	/* Hierarchical information */
+	swap = PAGE_COUNTER_MAX;
+	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
+		swap = min(swap, READ_ONCE(mi->swap.max));
+
+	return seq_puts_memcg_tunable(m, swap);
+}
+
 static int swap_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -8072,6 +8103,11 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{
+		.name = "swap.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_max_effective_show,
+	},
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,

