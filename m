Return-Path: <cgroups+bounces-1522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB902853DDF
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 23:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF941F2CEEC
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EE6214D;
	Tue, 13 Feb 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="LVQwYYU9"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2091.outbound.protection.outlook.com [40.107.102.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C961695;
	Tue, 13 Feb 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861394; cv=fail; b=FaP5M6xa27eU5/W32qJKmJf0UO4Zj0K4DjIh0oUxj8lmpf28Or/cK+I/S0xN22cubnfqFNFhc/T4xcRI+Et3YBcb8XdcIfOTh1nFiu2Rr7yjNAJcVbufN8Rkg8m2afOXues1sIFMokAFWorcRdsp+0R5zNJ9D3njgpwz9kBoRo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861394; c=relaxed/simple;
	bh=A+rjHPrVnewG792klY3Tc84EDI5hIW5C66QHFWYYM/U=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=INpjo88//mLPNpkQS/ilNL3hl9b1w/fRyuAuaa1XG2EIgFPi1U3osWupzEkMYhahPhtEGS7UpW3xhusY2BdYv/vYuLVNl9PTg3VRAe17AMhC4SmJz6OgD9V/PAhtSSfP1trPLdhbV5n9nV2GJUm+rRRfbQQOEXVfAjN+Kt6/IL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=LVQwYYU9; arc=fail smtp.client-ip=40.107.102.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdTxYjbQAj8aPHiX9aK6NV1vjqsIZF2aHAydCQ4qNOqlQXAaXqSaT1ohVbh2uxDi1Y4wtVoxCtPKTl4eT/qDBCl/rhjri4bTE3MBdgfbFkDMCE6So5XfyYnOjwgSi2V/UJKStfe+dy8BLxXitLcrmFcp4Np7Dju22URaDmhpgvqrMxyvSEfb07sgHuLnv/mJPsmCpjHDmz38P6xuDxqBbau/Te8kxlcLAWbkAJ4jJ9uxIrG3ABnUO+c/+3iFndcl0ytsHYj0Cin4XKdZ0P++xdI7ZHYzD4vkHRRm7jSqHnxcQaGQHLPJth85Nd+4a8jjksrY1smmwT4iABldmGbDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbSY+mIhMEBqPxs6kaSUCiP7Ans6rCJhGr04oMsXQyY=;
 b=TFhrQzSjZKjaIneMYW+5mBQ2d/IZLKtfc7ZeA5C+yrjuZX11S7nQ8SCVFk0CSLcNdRAjU6V2o1qZbCYLIEqaZddX8YBCpGzpj3yjRHdqeva/XYBH02abfbkN7gurYRNEOd7zIWpZbeCjm5OU4w3i/P2ZDzgQ5udYvFbj1HJYNONHc9ZpqxNJA1s38lyCtxG3Vf2jSoO6V6/Z9JMYDM0Wu2TIJFUgVIqN3F1Hafdl5sWs42yQidHvRZEP1jHCbB7j/7uzb60GY3ELTq/5CxuqsdapWJ0+SHVbbBTlCn5Ie7cLWvWUUbOfKnOpPOJOVqfzYi3jswZ9eTAXwRVfVoE3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbSY+mIhMEBqPxs6kaSUCiP7Ans6rCJhGr04oMsXQyY=;
 b=LVQwYYU9S1Kt+Wkz+OCOLTXgqXK93xG6vvfMnFcOaf2OzvuwPsBahGwYc+vvr+g8rcHLcWQkK3OG7CDTPJMCgZPd5dAhH63hpbJ/GtBUVcIzmVlJWloGvSHrcYe1ao14nRNkBkjkkyzjaVTi6SwdcPx8jRbcaqS1NpgYjmne6nrRKewe7w31qJuqhTv4gg2LH/m3hvUsrGYsqUqbWaAOavKccSL6GtZX7gkoNLjvkIo878XS4vVAdRwyxxwQvS6Ydvife7nPs/urUOfi+MBFC6SkY9ZQO6drIf6yFkkO9AqARvXg4/3wNxrAVP85CZIxsgaaPMpqdig5ecRDW1kmdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 21:56:27 +0000
Received: from CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3]) by CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3%5]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 21:56:26 +0000
Date: Wed, 14 Feb 2024 05:56:20 +0800
From: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <longman@redhat.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH v4] cgroup2: New memory.max.effective like cgroup1
 hierarchical_memory_limit
Message-ID: <ZcvlhOZ4VBEX9raZ@host1.jankratochvil.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: VI1PR06CA0095.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::24) To CH2PR11MB4342.namprd11.prod.outlook.com
 (2603:10b6:610:3b::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf0a830-9b0a-4752-3a29-08dc2cdea05e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vuhqRv1svc4hrrZNLEdppysYpQGtgMkCfCsXmAVpi/BTmC1GQTy/G3+uqZZZCwqiByouEd1yrQqQxGQc9RTesowGQI0uoasq+gvQ5CvvCcOmQoRRlvEpo3nwQXSydg74LiLcbiiSrzBCU7mZMBmW/vWeRj/eIKF4Jy6nwR9H1tHjeSaunvh+smfzw2tdzOOVXeKil+ncVogTXH7hAOaZcMVjbcqO/d6RlG4BkfBdDPdUHIajF/Mrj0GrH/oZbU3CjB936ZH6bk9+GtYTJa5yizs5kAKM1FXVuQMV1q2jJihVXUOKmMBtSKCh8nuBw7ofYxHbi8IZ8lr7PuvWR7W6whv9trqwUMDi/bNvQvyy/K2FYM2ufwN2bavUSGYu6iYhCu7Hm/OHMOBxoYPcfdu2q8miNIn//Mla4btCl+dNkHKrJSf5QPDnNuwd5RbNTpZ2eH1cFdewom4+oizhN2oCY395Xpe5mwrszPhzCLLG0pIyOLjWfrOFwpkVkm0hdL8Al5RbnzuDCyvTPELjGkMpuDiNkHtCUVBeMmf/vU72zRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4342.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39850400004)(366004)(136003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(86362001)(966005)(316002)(110136005)(478600001)(8936002)(66946007)(6486002)(66476007)(66556008)(8676002)(2906002)(5660300002)(9686003)(83380400001)(6506007)(6512007)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhSlqKCQV3V/Pv0WDyFuY/Opjq8vYyLFKUrVWF6npmMApSFWPhgKUIOmt9Dw?=
 =?us-ascii?Q?TlNALsyuiIjxuVqNYo0lbpifr6GpJsmn3q5XXqrdOjvf5RxklblEwdmM0piE?=
 =?us-ascii?Q?dLI0fuJJWVGJbu2D4djTD3bmb29m5lD88l7nqsvjDnm3ohdRE1zTngIs9FVm?=
 =?us-ascii?Q?/MrTulqU0wXIRn6RfLdDDwXVxYJHBaP6KGxIWewIzz94wZTckdW3VG+EK4cg?=
 =?us-ascii?Q?SqJA0HPLz4EcjoRiHUMEOIP8dx/PRWhhjBoGwhTq9qeuSBFPettFtwAOAkWM?=
 =?us-ascii?Q?jqLkM/uwHSWYJKxX4sfNJsu/UDSVaBcPZeUcBBeKPpVOYmR0ppIYsxhpKaGZ?=
 =?us-ascii?Q?aKqm7JdqfMWPkstLjsoYiQqBmsGCfP2msK9qsXlH6Kqvqs177N6bSsPkzLDF?=
 =?us-ascii?Q?MkdQk9CSxCRSPLdQdlSKHbK53SZCTbxFazSXt/r6ot98QECSxF96Y94HJt2c?=
 =?us-ascii?Q?OqPgL76Zg5fUfCg1DJf/wMaaohcbOFrFSoF2zBywk8fb74bsllnonufrcyrT?=
 =?us-ascii?Q?hVzv6QbBRlG9aa+/o7PCJml0Ik4Ce7qH3Tmy7iBRynkGtGxHt4pKpvojH6sT?=
 =?us-ascii?Q?TbWiRDXetqRc1rhwkvXZSPz0oHNMbWwtYlrRSrM8RAyYvxH9ozLtqXtZRN3U?=
 =?us-ascii?Q?hjknrIEXaPmRxDZkwk8WPqQwBBR2C5c/FOPgbDPj4nC7NhFzRa9nPSuPxIQD?=
 =?us-ascii?Q?SfBeoPSe3ZB1iPVgyZ2rjaPeFW4HTywZ0Es2lVeN2aDDmxZYBANVOvYlerEn?=
 =?us-ascii?Q?r7hnRreYpdNYqTnXm4hQ63k5XgYhqSMO77r5/vSbmRaKRPQU6eNKAlLvsZMf?=
 =?us-ascii?Q?DrnljPkRtfbG+idQ7sAmVTrzfwodPXfuhDRGC46uM29tjdv4W/7pERbGOp5R?=
 =?us-ascii?Q?AI4BW/TYuP8qYMgjuuTTnFCM4kgZhuLTqxc+Q+YzCX2WoSIFnv8uqOedHsCp?=
 =?us-ascii?Q?n9gvdPG4WXyA5zF6UWDiQzOiYoF4NZqSLD3E8gmzEACNzCX7hCgYR/45LTo7?=
 =?us-ascii?Q?sTDd6b7IaMwzUTN0dyhsBX5KvSDl7FrqOFBJ/Mljxv5nwpqe/mDn5kNIV7dX?=
 =?us-ascii?Q?gnuBQH8Dga3ALUd2Y3dnlrNvboarN/ew0eGBvt7m5Sn/4E0LL8vi4FYD+xBl?=
 =?us-ascii?Q?4/6yvVCuGSgoCY3qWWsL3JYjrppWFFuvrYAzqncCp8ZPOMcO65GsdW7vzRDD?=
 =?us-ascii?Q?iBvRmIL+RPFOa1DY6YwPBMPUY0/dCH+bA2AM2B4M0OkrGqJ6ty44tArB8Rkt?=
 =?us-ascii?Q?ArYx7EgvfzSal9WGt5gu80GF/01tZE3XKfo+m3bA2KQhYM30FdRoYPAx8QCG?=
 =?us-ascii?Q?7Jln1XKsYR2dghiDXezwZe7KHIw4PDH/7BD21KVZGDhnzHvNPtLPmoRebIMv?=
 =?us-ascii?Q?zOi8He/x3Sx5ZXU8suNhGl8TYpq1QOTCCJh2gkPZAPBNqVGdM/8aLz1PyeOv?=
 =?us-ascii?Q?ZQNvtqU0pT6VP4SDlhV+iYZ6mPzkoO+JYd+n2KA8nMJRKIiIFx+OsWHsOYB/?=
 =?us-ascii?Q?uM7urtymBjRSNkDMsLIyJXa49SOBHFGcP5xTCQBVmb6x2c5acJxoAsKuBpC7?=
 =?us-ascii?Q?UdKYHOBG9Do8ehPVP466O5xCAX2g6A4jnWdIRbeHS+oiRGvYHmsjwcGcraNi?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf0a830-9b0a-4752-3a29-08dc2cdea05e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4342.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:56:26.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh/r1UymEPVwhcVuWKGXv1jbx1ktq47ziXH/P02HbdZKTV0e2D5xq6Im1XISCeVsfZxoBpUtfqI311rTnQRLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268

Implement cgroup2 "memory.max.effective" and "memory.swap.max.effective" files
similar to existing "cpuset.cpus.effective".

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

But for cgroup2 it has been missing so far.

v4:
Adjust the commit message.
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

