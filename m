Return-Path: <cgroups+bounces-9810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF93B4A2A7
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9504E63B6
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2E303C85;
	Tue,  9 Sep 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oQRf2J6s"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A32EA74C;
	Tue,  9 Sep 2025 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400872; cv=fail; b=vBHR36dvM5DkEFQxbr9qf1VXC73Oon3wQqUpfLD402f/EA0nQo/1Y3outITYMGGbSYzy6Qt3nVLhqU096MMHZO1aUXi5fDjKLHY7k4gbgSNLXLhbK9V8v3F41XNG49lRQPSpD3Che03U4ts72lrAkb8vSgRWuU4jNDyYjIrZu4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400872; c=relaxed/simple;
	bh=9mmdMaMM0aFfCsRLOAdP5++t6e0yY/W9EHJVKmpTU38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9Y5gPs3pWYKSTUYpPxSLxhQN6+y2oH8nf6Mfi5rctNaPhLbe7AxBpHK4be9bZT8dGbRr4Azzk/f/gdt3eA8/U+NwD8AhoXXO9XE8tzOs28sQcvePKjXgawZ/Vojp48hnTJYRXetGiwkPgdR+rklXjmYkDcUGG3m4fmevxCPUOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oQRf2J6s; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6sivpPJBSmgIJ4yb2j6Dgnz4G7Aumhe397J8qPFNroi9OvLFbUNaGiMFrBpgDJV2Tqvng9yKW+VRWcPar/6uMG4e2dMRpgu2XyPGFB4nURLj0VzszItUNSLY+bcPw+AA9uNEwmyeZ+Sk2eXgKoR1rzOvAddEbPZ6lqv4FJYDoqQ3PJsYjg3yS/RqkQaXqjo//gYs0+8kcdOKTeaDZg8UsY9ljnl2fWgmePGuUb1xMR86hIKwpn0gBJS7tn3+CjCUjpLkb35iWLtoYus5SUbivwE1Drq4sB6ZaBIts6PYgQk8nadBUUUCzPoiuaHfbY157NtswCZdGgHb1qOA9D5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaZ47AlNohv0Lb5WRO+RfWV0Nkg2ew8eI7rFvjd49l8=;
 b=nvlWyYMNNHzhuXDqV9h1sZcBC1ud81lxgMK6N9Dy4n5HmuSL2YcljNoWkZNfU+xFCXI1QTk5XRv00pjWeI0nCJdKPvQv1wuakU9md/xircVOiyWSJlWwSyGPJ9kchOTfLAUXnaWC2kJl2yWZDm7pnsOEgbDpPocDSIzK13f3pspffpZhD8CgpXu6k2kw0PXzA/QwG1hRKOyUppvLDHQtc9xmsy2m0FBCm9tUMDuWotYdvF2zf0P2PiohhZ9lTAbbtHHGzjiYaP8ZP4LNmUTiQo7YXUAfH2uDjYlrWkCmxOo0KwIoBg5iX2ihzjJiYx0DmuiFXD8zSPAQnBVBAsMaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaZ47AlNohv0Lb5WRO+RfWV0Nkg2ew8eI7rFvjd49l8=;
 b=oQRf2J6sWpnBCT4WHGTm1VYgQ51c6JlW43+uHCvvb6gvxj5JqqWPAIaSCm3VPCDvYLDko5vCGKTEhQDjPjAUZwieNoHVvG1/MT6vyP6JqgWAz1GJ4mDGEbx4dZtGTYvLaHrAVg5O0jTPSM0tk3GZL7Mu/5CrTupK6MNw52yCY4GO9r5zjUoERveNriE0M1xNSJ43/SxlVpRhIeUU1HbojO46tvYbSgCe6aU/nZVgi7OJRyifDpUV76edUmvtQW8R/F9NPTD/dyAAFB60tMiop7mHxAN/OuzioBLwpIhxeGHO1C5FmW0c1dV35WsKAq04MOS7dvLiv3wQFw0lNWw4PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:54:27 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:54:27 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Chen Yu <yu.c.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Hao Jia <jiahao1@lixiang.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - OOM KILLER),
	linux-kernel@vger.kernel.org (open list),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Cc: Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v0 1/2] mm: swap: Gather swap entries and batch async release core
Date: Tue,  9 Sep 2025 14:53:40 +0800
Message-Id: <20250909065349.574894-2-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909065349.574894-1-liulei.rjpt@vivo.com>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: c407183d-34b8-4e2f-9cd1-08ddef6db812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|42112799006|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ef/Z3ZNtFrwChPLv0aPUmMlAjOxpmWZI2DSrMzRsdy2TiKhiAq8pb7dp+aDv?=
 =?us-ascii?Q?WuAv7L892wbiDRJdxX6TVwz0RSbILwXFYvIDyDYJsMIggfK39KihDZ16Zmoa?=
 =?us-ascii?Q?rOtY5niqqW32WcOwJ1NL1D29uYqVcYp0G2XDHJIGpO9K3a8wB0gfsAkWLs/L?=
 =?us-ascii?Q?5J1Ea8TafSrSHjVZ0xS4VQ8fc3Ib0lJcwj8ACI+0kZ1K6QnyC+dp7GRxxgx9?=
 =?us-ascii?Q?vgI4FpCry+wHXAclXqrY5Cy9XshztF8k4yA2zjW+nM576dGoThEXtLFKjhv+?=
 =?us-ascii?Q?tWA73jLxlarQheYen5HQNN3J65swK+l4ApJo1cU7FzIvWg1lrKsKBSOrux/e?=
 =?us-ascii?Q?M/tmK3rylSFRxgYVZ48oillUR/CY3wJY4lYmhl2o3C6AJcrCCn21rWI8p4RY?=
 =?us-ascii?Q?GKgu/NwS5AQg6wukx/XPQhBB8eM7/SqpDQN3NIdTNWQo+ylZfpv37uqs02+e?=
 =?us-ascii?Q?mXzESPI3rkQ0DAIduPe1yVdrM70erX+wcJx0B5CGFkAOXQCfj+qI8a9kMCC3?=
 =?us-ascii?Q?EMm8f9GI7DHvyN+bPJ2iM6nHA+0u2xNTyCYO3wEu8NWl8UUW6XVbRSgld65E?=
 =?us-ascii?Q?fzi3WLSAs9c5BDlkolQ52H1/nD7UDVF+g1aWmB3lhPGlolf4DU5Oly6cfGAw?=
 =?us-ascii?Q?AATFJeRAoN4jDtLjoolZ+FUGFi+feJd5Jgo+QRCjkucsGVov4DXLRZ0SugY4?=
 =?us-ascii?Q?/Uaq38uk7wl0lozBl2VmryDoa9F4yMRc/GHY7Hcu1hc1A//UjvuTHqG4r1qo?=
 =?us-ascii?Q?evhSX+pIH/lQl8fFeKJmkSm34Hu886FKdKoJDxL06Gk+o78V2C5Y/BaJeQFt?=
 =?us-ascii?Q?Nr5mBrxb/BOo5NR8aKqu7CzFUQgfgDdzohAXV0jXWQDEcIRLyAvwCLUG3+8d?=
 =?us-ascii?Q?aniMHS4x3FSvU1Xg9kKxEQnRz/gS8otjNrqqiE7IZe6CKI7o2NJA1h0g65z7?=
 =?us-ascii?Q?3ovPAhCPhAcKXPtuZqV/ht0QpYQB7PkIqJQeZryDLDnlqVQRjpyypCHcbRru?=
 =?us-ascii?Q?PFnm9WJR9RUVgru2D7jBHcTeN593rampTKqzibD+2D7cJxXyFZIXH1B6l0B/?=
 =?us-ascii?Q?EEWlYNuLDuA2GdApBMVPRQIXj4BJ7h2I5oFoJXSY7UsBfpG3zcOWaBzEu17q?=
 =?us-ascii?Q?xJXo5x+WD4HgYCivdmx9ZbNZ+7b9zD9cP8noOCaOjXpwBCpV93ffxftoSmCb?=
 =?us-ascii?Q?EFf+rq/p2lqsMS/3wCpCgHeQTCinfi5IZ4P5Sf57BYEqcFHmyytjceuS/VSl?=
 =?us-ascii?Q?ZDtGdVJx3rfVGIUPnZ9dg2ThJge9/N3FhctoGBAvRVgQKCohIjwpYQTUBWdN?=
 =?us-ascii?Q?IZhOnJ7kvcfu70ePX8eWXzvfCl4Tad/SBeJWDSibCi4TMWdxnWKzkxSrNEST?=
 =?us-ascii?Q?xc3aqESBHQHfpn0Iy+rHAfejhE2WY+jlOq6FMQEv/RUFHHjet7NmuvzfYa4f?=
 =?us-ascii?Q?hcWaRBVURg7or4sacEsf6m9bWK/rWnyjQExOujC+OZKbFDqhu5piI/MPAsh5?=
 =?us-ascii?Q?yS+wUsO+3/SaeY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLLfrgQSrGNu6dZHwxRGRJBTttxxvC6PwLnF+rg9Sd+Gspuy56cuxDAzBTdU?=
 =?us-ascii?Q?vl5ZYidPTpKPVwnCx4uQPKfbBoIQW9F7Zofm91ij60gYMW6BELwQ/IDvplya?=
 =?us-ascii?Q?CfK3nja+0G0pxwX5JL7Djo71Fj/m1nnMxHPGtTfiCC5hxFmXogVFUkDg46lj?=
 =?us-ascii?Q?4m7iJVT+lLzlCP3Kyp3Ex8f+qOEMA5kLKmg8+A5hiV+UTFX08tKLwmczu+mt?=
 =?us-ascii?Q?cuDx/MIpg8MEtA8BWXkEuZk4uCCGJoCVnxi43jIQMQoZNiTdnFwWgQjvLFET?=
 =?us-ascii?Q?cdD+FIuW9Z5SubdFzpPBv+l9cWprwuYDqA4ytXOwwuZyZ8sZpwUqGgQPLJcC?=
 =?us-ascii?Q?MmzX5iohoKO2FKXJQxURLr9B0cbAfF6vcNaECoTxYHK21np00ikJlC7pX7e1?=
 =?us-ascii?Q?iJUrrU9toTOk5+HgMyAxWef+nNrlKhEyOWlVNRh7SFl78xV+EdD+28z3m+1A?=
 =?us-ascii?Q?t0qSWtrAqyFUb5j8GkAYEqLIk8+WRNTkHW2lZGODmBxIAZbiw5wgeUODaVt+?=
 =?us-ascii?Q?GrtQjyHdX+z9P2urOS3jxcwA4VTvboHGm87TYwBlXz2al5KtwpzGwvrompZC?=
 =?us-ascii?Q?mN5FLzqIEmAeSqEdBetJ/wXx6+kpExIFImo5AEsTGa7grqvUynuQKcy2VZ7Z?=
 =?us-ascii?Q?QmlTyYxEBhtWYtxR6eBWuxlEZLVBakGb/JVWJoHheNJ0f09zzCoxConPBVrt?=
 =?us-ascii?Q?S0u1b59uBUWAdCM2rOUk8+PW4n8vWTptOlrYivMCyBQja2pysXOi38gwty21?=
 =?us-ascii?Q?WmhfHrr7U7uiagq/AnnCAVq4GjKwzwi3XCO+dnPu6Atk4sQHiFfHys+1BXow?=
 =?us-ascii?Q?GZXizRt8nJaqyWnx6wPWdOdRxbLxNgGLoF0KeTzJj18Dh+yjZpjuWDXe6TpI?=
 =?us-ascii?Q?AoBRXnXVh4F4dobnUds15gCMwyhQBTR+g2u8gupmIo/G27dOArYz2GoceF73?=
 =?us-ascii?Q?TJdVqH6vWN8JoqY5ta1L3utNywC54wQI6YCbTaXvJVXRS1zG+QWC1/okkUe7?=
 =?us-ascii?Q?poOpYONFgvIB+aLrPk6yGFZme2/czcvGqG28bTBAgdBFTQ0khGLR7y4bXjE8?=
 =?us-ascii?Q?B66Qubpti2a24Pff+10aU/YqDAZWyq2wZ7RWVVaNCI1A3REEfDv56vSAfu0M?=
 =?us-ascii?Q?9MIX7DjMsJjzkkDh4LkHD1RaNsgnTr9XaGIufloAQIN2lqnFj4nuYcCp48uk?=
 =?us-ascii?Q?MT4+Y94zKtqhRsIgWDHjnG0Wc8qzK1yTfTd0Yjqe6i/zAZsOrbKWHBoyrSE/?=
 =?us-ascii?Q?U1Q9zlZA0FUeF5QhLDbGF3VuVjv4YtwwedqnZ+ckKQQwHch13M5oQbfBhqw1?=
 =?us-ascii?Q?Hnfxkr3+6WmUw7W/557B91Jq4HUHk0KYcMDnn6kyRNhtxgWJjaQGgPFjXhuq?=
 =?us-ascii?Q?ajnhJVMHqMZaBNTsHYyZRgLauDbpJ06CgBnri3vFXGqkD5n4LiePQI9K2tpQ?=
 =?us-ascii?Q?QRkPr//rnU5YDFi671TYdfXwxOwuUGX1Xe28LuH3utZzNDupiLJFaPRQMgDK?=
 =?us-ascii?Q?/keJP/IxKEJoBmcH2Ylo/BetA25hlCxTDAzuiZwaK5qoV1FclhW1JDxrYx0T?=
 =?us-ascii?Q?psPoZ6YZvyeU9Hs1Xj1MsMgSteB/SkGrbWjPthTm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c407183d-34b8-4e2f-9cd1-08ddef6db812
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:54:27.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWSKLwBEaW2CshgxtKifYL3/jzS2x9pS2yAwv6d0ZtEVx6Sydc2mHL4ZDN/e9aHy61n2iFIv0jUaxyFnuAVQ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897

Core functionality implementation for asynchronous release of swap entries:
1. For eligible processes, swap pages are first asynchronously aggregated
to a global list
2. Batch release occurs once a defined threshold is reached
3. Asynchronous release is executed by kworkers of a workqueue, with a
max_active configuration macro provided to control concurrent work item
numbers and address NUMA release efficiency issues

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 include/linux/oom.h           |  23 ++++++
 include/linux/swapfile.h      |   1 +
 include/linux/vm_event_item.h |   1 +
 kernel/exit.c                 |   2 +
 mm/memcontrol.c               |   6 --
 mm/memory.c                   |   4 +-
 mm/swapfile.c                 | 134 ++++++++++++++++++++++++++++++++++
 mm/vmstat.c                   |   1 +
 8 files changed, 165 insertions(+), 7 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..aa34429cc83b 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -56,6 +56,23 @@ struct oom_control {
 extern struct mutex oom_lock;
 extern struct mutex oom_adj_mutex;
 
+extern atomic_t exiting_task_count;  // exiting task counts
+
+static inline int get_exiting_task_count(void)
+{
+	return atomic_read(&exiting_task_count);
+}
+
+static inline void inc_exiting_task_count(void)
+{
+	atomic_inc(&exiting_task_count);
+}
+
+static inline void dec_exiting_task_count(void)
+{
+	atomic_dec(&exiting_task_count);
+}
+
 static inline void set_current_oom_origin(void)
 {
 	current->signal->oom_flag_origin = true;
@@ -76,6 +93,12 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
 	return tsk->signal->oom_mm;
 }
 
+static inline bool task_is_dying(void)
+{
+	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
+		(current->flags & PF_EXITING);
+}
+
 /*
  * Checks whether a page fault on the given mm is still reliable.
  * This is no longer true if the oom reaper started to reap the
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 99e3ed469e88..dc43464cd838 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -4,6 +4,7 @@
 
 extern unsigned long generic_max_swapfile_size(void);
 unsigned long arch_max_swapfile_size(void);
+int add_to_swap_gather_cache(struct mm_struct *mm, swp_entry_t entry, int nr);
 
 /* Maximum swapfile size supported for the arch (not inclusive). */
 extern unsigned long swapfile_maximum_size;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..05f33d26d459 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -186,6 +186,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KSTACK_REST,
 #endif
 #endif /* CONFIG_DEBUG_STACK_USAGE */
+		ASYNC_SWAP_COUNTS,
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d5..c879fe32aa0e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -897,6 +897,7 @@ void __noreturn do_exit(long code)
 	WARN_ON(irqs_disabled());
 	WARN_ON(tsk->plug);
 
+	inc_exiting_task_count();
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
@@ -1001,6 +1002,7 @@ void __noreturn do_exit(long code)
 	exit_tasks_rcu_finish();
 
 	lockdep_free_task(tsk);
+	dec_exiting_task_count();
 	do_task_dead();
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..79bc4321cbb3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -102,12 +102,6 @@ static struct kmem_cache *memcg_pn_cachep;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
-static inline bool task_is_dying(void)
-{
-	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
-		(current->flags & PF_EXITING);
-}
-
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..e09db2932b25 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -75,6 +75,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/swapfile.h>
 
 #include <trace/events/kmem.h>
 
@@ -1617,7 +1618,8 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 
 		nr = swap_pte_batch(pte, max_nr, ptent);
 		rss[MM_SWAPENTS] -= nr;
-		free_swap_and_cache_nr(entry, nr);
+		if (add_to_swap_gather_cache(tlb->mm, entry, nr))
+			free_swap_and_cache_nr(entry, nr);
 	} else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_folio(entry);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..7c69e726b075 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,10 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/vmstat.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -170,6 +174,136 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 /* Reclaim the swap entry if swap is getting full */
 #define TTRS_FULL		0x4
 
+/* Minimum number of exiting processes, adjustable based on system load */
+#define MIN_EXITING_TASKS_THRESHOLD 1
+/* Number of active work items for asynchronously releasing swap cache.
+ * Defaults to zero and is determined by the system itself, it can also
+ * be configured manually based on system load.
+ */
+#define NUM_ASYNC_SWAP_WORK_ITEMS 0
+
+static struct workqueue_struct *release_wq;
+static LIST_HEAD(swap_cache_list);
+static spinlock_t swap_cache_lock;
+static int cache_count;
+static int max_cache_entries = 32;
+static struct kmem_cache *swap_entry_cachep;
+atomic_t exiting_task_count = ATOMIC_INIT(0);
+
+/* Represents a cache entry for swap operations */
+struct swap_entry_cache {
+	swp_entry_t entry;
+	int nr;
+	struct list_head list;
+};
+
+static int async_swap_free_counts_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "exiting_tasks:%d cache_counts:%d\n",
+		   get_exiting_task_count(), cache_count);
+	return 0;
+}
+
+static void async_release_func(struct work_struct *work)
+{
+	struct swap_entry_cache *sec, *tmp;
+	unsigned int counts = 0;
+	LIST_HEAD(temp_list);
+
+	if (cache_count) {
+		spin_lock_irq(&swap_cache_lock);
+		list_splice_init(&swap_cache_list, &temp_list);
+		cache_count = 0;
+		spin_unlock_irq(&swap_cache_lock);
+	} else {
+		goto out;
+	}
+
+	list_for_each_entry_safe(sec, tmp, &temp_list, list) {
+		free_swap_and_cache_nr(sec->entry, sec->nr);
+		kmem_cache_free(swap_entry_cachep, sec);
+		counts++;
+	}
+	count_vm_events(ASYNC_SWAP_COUNTS, counts);
+out:
+	kfree(work);
+}
+
+static void flush_cache_if_needed(bool check_cache_count)
+{
+	struct work_struct *release_work;
+
+	if ((!check_cache_count && cache_count) ||
+	    cache_count >= max_cache_entries) {
+		release_work = kmalloc(sizeof(*release_work), GFP_ATOMIC);
+		if (release_work) {
+			INIT_WORK(release_work, async_release_func);
+			queue_work(release_wq, release_work);
+		}
+	}
+}
+
+/*
+ * add_to_swap_gather_cache - Add a swap entry to the cache.
+ * @mm: Memory descriptor.
+ * @entry: Swap entry to add.
+ * @nr: Associated number.
+ *
+ * Returns 0 on success, -1 for unmet conditions, -ENOMEM on allocation failure.
+ *
+ * Checks task exiting counts, allocates cache entry, adds it to the swap cache
+ * list, and may trigger a cache flush.
+ */
+int add_to_swap_gather_cache(struct mm_struct *mm, swp_entry_t entry, int nr)
+{
+	struct swap_entry_cache *sec;
+
+	if (!mm || get_exiting_task_count() < MIN_EXITING_TASKS_THRESHOLD)
+		return -1;
+
+	if (!task_is_dying() ||
+	    get_mm_counter(mm, MM_SWAPENTS) < (100 * SWAP_CLUSTER_MAX))
+		return -1;
+
+	sec = kmem_cache_alloc(swap_entry_cachep, GFP_ATOMIC);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->entry = entry;
+	sec->nr = nr;
+	INIT_LIST_HEAD(&sec->list);
+
+	spin_lock_irq(&swap_cache_lock);
+	list_add_tail(&sec->list, &swap_cache_list);
+	cache_count++;
+	spin_unlock_irq(&swap_cache_lock);
+
+	flush_cache_if_needed(true);
+
+	return 0;
+}
+
+static int __init swap_async_free_setup(void)
+{
+	release_wq = alloc_workqueue("async_swap_free",
+				     WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				     NUM_ASYNC_SWAP_WORK_ITEMS);
+	if (!release_wq)
+		return -ENOMEM;
+
+	swap_entry_cachep = KMEM_CACHE(swap_entry_cache, SLAB_ACCOUNT);
+	if (!swap_entry_cachep)
+		return -ENOMEM;
+
+	spin_lock_init(&swap_cache_lock);
+	proc_create_single("aswap_free_counts", 0, NULL,
+			   async_swap_free_counts_show);
+
+	return 0;
+}
+
+postcore_initcall(swap_async_free_setup);
+
 static bool swap_only_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
 {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..fa7fe910becf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1494,6 +1494,7 @@ const char * const vmstat_text[] = {
 	[I(KSTACK_REST)]			= "kstack_rest",
 #endif
 #endif
+	[I(ASYNC_SWAP_COUNTS)]			= "async_swap_count",
 #undef I
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 };
-- 
2.34.1


