Return-Path: <cgroups+bounces-3487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48892389A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7573CB24161
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E3C14F9FA;
	Tue,  2 Jul 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Uleg6qOv"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70014883E;
	Tue,  2 Jul 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909971; cv=fail; b=nwmr57bicxgZdQ2b6fZvVMwTD29N8N+Sbh3/e5y8f+tDZshMnBZQwUFG0ymVzV51zAmLzTeRjnNqE9o9BU0JOTWhIYwrOoym/GtA5WThHxPdMpP1h46/q+eYAnGhFq1/rEr4gKKGQ54z7hxJX4tCwcqr8YCvFTFhhVjkTAJfgOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909971; c=relaxed/simple;
	bh=z1SOsXXLrTMLBIFQ74lUffXP3Mn/1wGvSqo3YZPCBp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNoACLTIsWVvgGDKL5DzWHRVxEq8uCB3bUHkR8Ma8i6IUWr97dljEyb6r/aWgA6bL6Ec4mZBOmUBJ870vCY4w6CLdZUMeB4qTDna+8/2aib1rycUlKwuvEqw12KoBKqDVO57hHtwvKgYBHtyxTm/UYDP96pE5ti3PIX15wxY5UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Uleg6qOv; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PArtcsHgRAOSoH4wlQV0BTnJwYMYtPxo9TNyjMxlu+Io0MD6KyPqi640mghyMjGo2MhaESfmWTiFGAP3zFvPZvVhnhSbxOszrRKQpJ+WoUFnm+DmLJcwqc0Ut3wxe5+6B/SXC6WqZAvAan4tnspWxMiznXHbwWr23D/f3LimnOU9gHMwlyEp92zD+ZnkcM6+YbbuVtloeAB7KmO6e3uGVpnkWdyLuPMBzmq93mckW11oLse4pdXgIjLz5OTbzYugTaWqaisa205A2VSG2GERD/xMqJABcTnTyyYA1mD6T1FUYeiX+yeJ9IIwyZCk4DjOsYJdb4E7lkDiYMFMHeeaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdNNIIt5i57KrDH2G5inTTWNfKhy1MKf1/9NPo25L0U=;
 b=ZyE/rjfdNJvt1dGaNUOndoRB4Z3p7ZGQPywyq5lCS1muakE8fnop1g5OJpxtlWwFjlAOT5k1OwAq3jCXTuvCZlD4lxntLbfe/0gU+Y9F/R9u7+L9H6NcP+mHmG5HT3MPvLMGOnZE69lXo9kni0LaXA5quJScAwHPP0wr3qLDAiqs/94/mKc5z979BNV8CRY7Zbs77D6uWFJmfYiNRaC7LkJr7UFDcQUa1auIaBqDMgxvK+cUBU1u1mK5iRKKh2fNinbrvQpMNSR27Z7rYxlts9IVm/legA9w4M51x1Ry//O5C9X1lW9Hp4mRf+1CdKC+WbYZwuDKgzWTVbfVbHDurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdNNIIt5i57KrDH2G5inTTWNfKhy1MKf1/9NPo25L0U=;
 b=Uleg6qOvvtBmqW/bniZ1yZvAX/tErIBcHdw7gJV6hKmLW1fQrnwPboNr2XAIdhL35QqJoJ6d0G6wHcQunSRsrZdclBX7MPPO6lQOyvT65Y1ox07rY69CkadkOuzUXL+BhhVac08YoHfq5L2KeCWDQVGLP4lMAaQjAX5FVECqxui+/2vqkkQuSfP3mNmEjhldD/RELjPfjYchPRh2SFugas4ZQWrtbqCXHV2iTSnWGcNWJ4e3qYhiCkIdZfLeaINF2cFOc+PzJiKJ6QLmL40by/5aL/Gck3j3UPOr7NOg2aEw9mv0H/+04uOQlimQamPRNbyAc29U0eulwOXbv0A0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 08:46:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:46:05 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Huan Yang <link@vivo.com>,
	Kairui Song <kasong@tencent.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 1/4] mm: memcg: pmc framework
Date: Tue,  2 Jul 2024 16:44:04 +0800
Message-ID: <20240702084423.1717904-2-link@vivo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084423.1717904-1-link@vivo.com>
References: <20240702084423.1717904-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 84119b26-1c3e-469d-ac40-08dc9a736905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMOCAppgicIGMw9JCerPdCkLRRDdwAiX/jpU7zGN5fSPeyM2dr7gvAh2gb+r?=
 =?us-ascii?Q?JQUTogBf8Qu4Lg58CjBNUiZqFjjhZ9wsRHzLo4a2GaEiZW/aW/THCANTGtHd?=
 =?us-ascii?Q?UyuQPOoQ54TNsRLXci3Ysv0vJjZuNY4nz+wNlBIwo9JXBYBoJ71xORkQwRzd?=
 =?us-ascii?Q?Z/7y4Z0BhkbCcFTHoprPE0bjnBnjKGTZcVntGQSAwemHESM6zQxQm1F8QS/A?=
 =?us-ascii?Q?dHbObv6J4oujjaHQC81XiURMmR6O3tw0/yszKQ2aTFUTKUMWTLXX9pC5RX3h?=
 =?us-ascii?Q?AG+zyJQBWjIUqkhu9AFmubFIRPPArBuiz7b24Z1xiXzVX9/K5iTCV9Tq6dSR?=
 =?us-ascii?Q?v55chyoW8F+3WRRVheZaMY5hE38enCer91bEipc1jYHDwpFTZKYvzNF0V0YU?=
 =?us-ascii?Q?isOUI54XiTkKYo/q7wOmzl6bvNHC61bBIyO3PAEssYiRZkHvaKoSVDaW3tao?=
 =?us-ascii?Q?Loqlf7FexSV5jWFE8q9lBhjJvNlyrXccPs4eXxZouAzgVG6wiVHEJK+EKsEl?=
 =?us-ascii?Q?eVmXBsWH9AzytpQScUI1qkaDzGXZ6mtz5aVQgzyN2P188R0bsyv1pjSQvBkd?=
 =?us-ascii?Q?S8xQnfqddxkCQd/TsNtBwW43zbytHnTWFwC6xH2CPCs8fQSJeuWZsAuf2G/N?=
 =?us-ascii?Q?VtU1sgyCEk9Cjcekm+TLWDcq8SAth/D3SBP3YKoeOE13nO1zwZho66vUzbBG?=
 =?us-ascii?Q?c/VfUGABv0RkQix06lckJ1Whc6cfGCchZBRDBrRhh6q3qn60r4Z34EvdXvYH?=
 =?us-ascii?Q?UnokPiXC/WLKq1O/mbT2YbYVa0iolF4CyNxLaQGEa69Jb47EFJfwlw7q/ffz?=
 =?us-ascii?Q?OQMwkEONygG5JBPuRPsV/1R2vTRWsLI/s4hyOH/l6VTE/zqUwmQUe1W6yR8X?=
 =?us-ascii?Q?2xVW8EsnvQBLHS/G9CU7z321yWW/lZl4JBxKCNDdKejdDWNAK8YfHAmalIe4?=
 =?us-ascii?Q?8HAY5CYaiSI2W17Vk8bu4sU3o0IBKkxidMlWZTAo5uuQNKkc5o4pOXdWM4Mq?=
 =?us-ascii?Q?uGDLNaxep8xLCBvRajDZTNTBGZwH1fj7PBlDUwwiAXPdZCiNlSuP0UBZwEPM?=
 =?us-ascii?Q?s/wkdSxWUK/DAw7bQ4URDjJqlpVyrY0uXUj/05MopO0w5XN8vfIrMZdEcvHO?=
 =?us-ascii?Q?yUZPU1uU9451UmcuoYeCxvBgILQ5k2glpu3j1IWr/xsnbzamrKDtrGWMscbO?=
 =?us-ascii?Q?k0GlmXIHH3jgu6GmtC1GLpnxjjsxiCxw4YQas1HhazlbB8LtU3M3lJqz9Ius?=
 =?us-ascii?Q?59+x0D0ZeQ1UQ9BSyAyO4nRI4ZRxbzqMjzI5H7HeuCVY5u67xCbGl1tUvO+J?=
 =?us-ascii?Q?Btb2f+2mou5lJO0qi6V5ezQ4ppZPBbJPd66NjRPlSaLYvgNs3hrBYNLLB4GK?=
 =?us-ascii?Q?qHqjV/dPSPzHb56H4w2EwUsX2k6vnpM95HdMGQzvQ6B4OwDCgE+R/gf2p7b6?=
 =?us-ascii?Q?6qznO7v0dyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rMuw7FBY94xkJq2Gp8p50HP7cnuz+T1pVbvGAQeSpi/dSPjeGNCWmnUa9kp4?=
 =?us-ascii?Q?YAoBdGOCXnqcQECybIG/4nLJmki/AgeEny7/DmHre4+0E/OUYNxcxG0sbQkF?=
 =?us-ascii?Q?RDmN4xHmWHICms4rdYQX4opsULKFiCAAy8HntHF6ERbxCbvaAHZeFKQO9GVW?=
 =?us-ascii?Q?QxToq7pXfp37+KvcTS5PJTrbblJ79Qopi+LTf4Hf8bfjKRG2ugNIOVXK1E8u?=
 =?us-ascii?Q?3YIY53iXdXQcFeW97grJRqXemV3b1F4sVEBY5arw+iywX6zLNXEghOcp1mqk?=
 =?us-ascii?Q?gNGWzMBUaG2ARKsxUw3f9/NBvqkpZq2nhOmyIpApK3jcBB56Tmr/+avQY/Bo?=
 =?us-ascii?Q?Q5kZY+aZQ5MaOfNLAnFoQ1gegXZcQ1RhHVGRMRQuT2CMPRMxCyJIurIhPSeJ?=
 =?us-ascii?Q?UNKuOxZqzDc8E5kSPW47poBzOf086PLkJvvfRQ5hIhMpzcX7VlF+Tv0R16bg?=
 =?us-ascii?Q?GHzCLvq0/gHRLvOb0rK94CA2ummYLW4QQr11fqEB42ZmoIS/vT7nLfZCBKP6?=
 =?us-ascii?Q?bNb6cLcTQuG1IEmtZcNx462srUyqZq5pEuOtbCaDoJuh7+3DzkaOyyIZS3Kb?=
 =?us-ascii?Q?235fTJ6ALHnvFf3u72bnjKoO/8hrq50xMyCuOSiqE8WDqgWEpv2gz9sSMqXu?=
 =?us-ascii?Q?zqel5GG2TCRALWIDGDqlyE70wr/W05V2uG37F7w/xMbI9HxzmQMktU/aazSn?=
 =?us-ascii?Q?0kCnUyRgV6m/p5LbBuADxhUs2MC+T8Ow8XfMYHxwImky1JElXXOHoIDrmyvx?=
 =?us-ascii?Q?n4pw8Q1eYg5orXFTm6avKxb4KX0mxzf34g2zBevOI3hO2AnTXH2TcwPLV9q6?=
 =?us-ascii?Q?ZhkffIsKc88Ny9r4OZ3sNWQ+wIHNGxoLLLkKrxXEmSgwDTqxlgcQes64yMyZ?=
 =?us-ascii?Q?puBRKNy+WICLJpvvUqKpSe3Xx8rAEFViGPzfZSoZ62LwXkPJTxZkCRzvhRrC?=
 =?us-ascii?Q?jkCBcuFP09gl90WwJiRAW2nMMdYIHxpxdSJ4s/ecS3oDsVhJfTHf1IHZLU2/?=
 =?us-ascii?Q?gMaXJv9ni9lVURo1kCjin6lUjZjBkuITyR7LYWK7A0+r8/aMBJNQ/aaulWKB?=
 =?us-ascii?Q?bT3lgjJjud+NBdidOPK1ryjXjmqrofvihhgItMZCpHPjh7RCwS3917pE8lLM?=
 =?us-ascii?Q?WLwttgZaiar9L5jGGErl6Rzdm1u3QuH/iRI9+ZO4bJP/h3Ti9tFNBADvSTen?=
 =?us-ascii?Q?yvBD2mMaNoQzE65vU4osPACP7jWOa0hg+2ifDFg03wJ36PxIXn9mF3pepXKL?=
 =?us-ascii?Q?ytCYf/snEvh9HNJD55Et58dveKPSzSO8dHb7qRjgDbtdYh+fdbxPuJvHwoCw?=
 =?us-ascii?Q?HSiB516nTriR+S8mx9Iwsn8bzrYTkUAl72FzgbE44VYBu7fKpYhgbpAQeheT?=
 =?us-ascii?Q?5+Maym+lYBwLJRtmvvjgL/sGvfxdsNlEgR4MQ3yRnlma5X4uARkB1hAZFKsi?=
 =?us-ascii?Q?KzN4KtVjthzYqgYyvZ90VmGaFSXTN8j6ucnayRJmMtLhvoIpdKKrAnc2Un51?=
 =?us-ascii?Q?6jIy3faEKkBpFeGXk0p2I1mfeZcbtNkxmwh8zWcVcSJi3KNAD9rw008N6xUV?=
 =?us-ascii?Q?Bhuig6T8YTvLhkmIdcpZte0SlEfdOZOD/T/a+cE2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84119b26-1c3e-469d-ac40-08dc9a736905
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:46:05.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1kgVzoS6lowAWmEcHfN2rn34YWoi5y3uowseeJVne2cYk0TPp806UqtaQ7TgD+uM1NR3Kp7oeBa6MM+OXaptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790

pmc - per memcg cache

This patch add a feature pmc in each memcg unless root memcg.
User can enable pmc in a target memcg, so all task in this memcg
will share a cache pool, the alloc/free order 0 page will high
priority turn in this cache pool.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/memcontrol.h |  41 +++++++
 include/linux/mmzone.h     |  25 ++++
 include/linux/swap.h       |   1 +
 mm/memcontrol.c            | 237 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            | 146 +++++++++++++++++++++++
 5 files changed, 450 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8f332b4ae84c..5ec4c64bc515 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -130,6 +130,7 @@ struct mem_cgroup_per_node {
 	bool			on_tree;
 	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
 						/* use container_of	   */
+	struct mem_cgroup_per_node_cache *cachep;
 };
 
 struct mem_cgroup_threshold {
@@ -336,6 +337,8 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+	bool cache_enabled;
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -557,6 +560,8 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
+extern struct static_key_true pmc_key;
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
@@ -1185,6 +1190,25 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline bool pmc_disabled(void)
+{
+	return static_branch_likely(&pmc_key);
+}
+
+static inline bool mem_cgroup_cache_disabled(struct mem_cgroup *memcg)
+{
+	return !READ_ONCE(memcg->cache_enabled);
+}
+
+
+static inline struct mem_cgroup_per_node_cache *
+mem_cgroup_get_node_cachep(struct mem_cgroup *memcg, int nid)
+{
+	struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+
+	return nodeinfo->cachep;
+}
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1648,6 +1672,23 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static inline bool pmc_disabled(void)
+{
+	return true;
+}
+
+static inline bool mem_cgroup_cache_disabled(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
+
+static inline struct mem_cgroup_per_node_cache *
+mem_cgroup_get_node_cachep(struct mem_cgroup *memcg, int nid)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81ef..773b89e214c9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -603,6 +603,31 @@ static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 
 #endif /* CONFIG_LRU_GEN */
 
+struct mem_cgroup_zone_cache {
+	/* cache pages, current only hold order 0 */
+	struct list_head pages;
+	spinlock_t pages_lock;
+	atomic_t nr_pages;
+	atomic_t nr_alloced;
+};
+
+struct mem_cgroup_per_node_cache {
+	/* per zone cache */
+	struct mem_cgroup_zone_cache zone_cachep[MAX_NR_ZONES];
+	struct mem_cgroup *memcg;
+
+	/* max number to hold page, unit page, default 100MB */
+#define DEFAULT_PMC_HOLD_LIMIX ((100 << 20) >> PAGE_SHIFT)
+	unsigned int hold_limit;
+
+#define DEFAULT_PMC_GAP_WATERMARK ((50 << 20) >> PAGE_SHIFT)
+	/*
+	 * Only when zone free pages above high+allow watermark, can hold cache,
+	 * unit page, default 50MB
+	 */
+	unsigned int allow_watermark;
+};
+
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
 	/* per lruvec lru_lock for memcg */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 11c53692f65f..d7b5e0a8317c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -420,6 +420,7 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
+extern int mem_cgroup_release_cache(struct mem_cgroup_per_node_cache *fc);
 
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b3c3394a2ba..404fcb96bf68 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,6 +95,15 @@ static bool cgroup_memory_nokmem __ro_after_init;
 /* BPF memory accounting disabled? */
 static bool cgroup_memory_nobpf __ro_after_init;
 
+/*
+ * How many memcg enabled cache? If none, static branch will enable
+ * so none task free/alloc will into PMC path.
+ * Else, hold/free cache in target memcg, disable static branch.
+ */
+static atomic_t pmc_nr_enabled;
+DEFINE_STATIC_KEY_TRUE(pmc_key);
+
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
@@ -5738,6 +5747,8 @@ static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
 	lru_gen_release_memcg(memcg);
 }
 
+static int __disable_mem_cgroup_cache(struct mem_cgroup *memcg);
+
 static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -5762,6 +5773,8 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
+	if (READ_ONCE(memcg->cache_enabled))
+		__disable_mem_cgroup_cache(memcg);
 	mem_cgroup_free(memcg);
 }
 
@@ -7088,6 +7101,223 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+static int __enable_mem_cgroup_cache(struct mem_cgroup *memcg)
+{
+	int nid, idx;
+
+	if (!mem_cgroup_cache_disabled(memcg))
+		return -EINVAL;
+
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node_cache *p = kvzalloc_node(
+			sizeof(struct mem_cgroup_per_node_cache),
+			GFP_KERNEL, nid);
+
+		if (unlikely(!p))
+			goto fail;
+
+		nodeinfo->cachep = p;
+	}
+
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+		pg_data_t *pgdat = NODE_DATA(nid);
+		struct mem_cgroup_per_node_cache *p = nodeinfo->cachep;
+
+		for (idx = 0; idx < MAX_NR_ZONES; idx++) {
+			struct zone *z = &pgdat->node_zones[idx];
+			struct mem_cgroup_zone_cache *zc;
+
+			if (!populated_zone(z))
+				continue;
+
+			zc = &p->zone_cachep[idx];
+
+			INIT_LIST_HEAD(&zc->pages);
+			spin_lock_init(&zc->pages_lock);
+		}
+
+		p->memcg = memcg;
+		p->hold_limit = DEFAULT_PMC_HOLD_LIMIX;
+		p->allow_watermark = DEFAULT_PMC_GAP_WATERMARK;
+
+		atomic_inc(&pmc_nr_enabled);
+	}
+
+	if (static_branch_likely(&pmc_key))
+		static_branch_disable(&pmc_key);
+
+	//online
+	smp_wmb();
+	WRITE_ONCE(memcg->cache_enabled, true);
+	atomic_inc(&pmc_nr_enabled);
+
+	return 0;
+
+fail:
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+
+		if (nodeinfo->cachep) {
+			kvfree(nodeinfo->cachep);
+			nodeinfo->cachep = NULL;
+		}
+	}
+
+	return -ENOMEM;
+}
+
+static int __disable_mem_cgroup_cache(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	if (unlikely(mem_cgroup_cache_disabled(memcg)))
+		return -EINVAL;
+
+	//offline
+	WRITE_ONCE(memcg->cache_enabled, false);
+
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node_cache *p;
+
+		p = nodeinfo->cachep;
+
+		mem_cgroup_release_cache(p);
+
+		kfree(p);
+	}
+
+	if (atomic_dec_and_test(&pmc_nr_enabled))
+		static_branch_enable(&pmc_key);
+
+	return 0;
+}
+
+static int mem_cgroup_cache_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg;
+	int nid;
+
+	if (static_branch_likely(&pmc_key))
+		return -EINVAL;
+
+	memcg = mem_cgroup_from_seq(m);
+	if (!READ_ONCE(memcg->cache_enabled))
+		return -EINVAL;
+
+	seq_printf(m, "%4s %16s %16s\n", "NODE", "WATERMARK", "HOLD_LIMIT");
+	for_each_online_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node_cache *p;
+
+		p = nodeinfo->cachep;
+		if (!p)
+			continue;
+
+		seq_printf(m, "%4d %14uKB %14uKB\n", nid,
+			   (READ_ONCE(p->allow_watermark) << (PAGE_SHIFT - 10)),
+			   (READ_ONCE(p->hold_limit) << (PAGE_SHIFT - 10)));
+	}
+
+	seq_puts(m, "===========\n");
+	seq_printf(m, "%4s %16s %16s %16s\n", "NODE", "ZONE", "CACHE", "HIT");
+
+	for_each_online_node(nid) {
+		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node_cache *p;
+		pg_data_t *pgdat = NODE_DATA(nid);
+		int idx;
+
+		p = nodeinfo->cachep;
+		if (!p)
+			continue;
+
+		for (idx = 0; idx < MAX_NR_ZONES; idx++) {
+			struct mem_cgroup_zone_cache *zc;
+			struct zone *z = &pgdat->node_zones[idx];
+
+			if (!populated_zone(z))
+				continue;
+
+			zc = &p->zone_cachep[idx];
+			seq_printf(m, "%4d %16s %14dKB %14dKB\n", nid, z->name,
+				   (atomic_read(&zc->nr_pages)
+				    << (PAGE_SHIFT - 10)),
+				   (atomic_read(&zc->nr_alloced)
+				    << (PAGE_SHIFT - 10)));
+		}
+	}
+
+	return 0;
+}
+
+enum {
+	OPT_CTRL_ENABLE,
+	OPT_CTRL_ERR,
+	OPR_CTRL_NR = OPT_CTRL_ERR,
+};
+
+static const match_table_t ctrl_tokens = {
+					   { OPT_CTRL_ENABLE, "enable=%s" },
+					   { OPT_CTRL_ERR, NULL } };
+
+/**
+ * This function  can control target memcg's cache. include enable\keys set.
+ * To enable\disable this cache, by `echo enable=[y|n] > memory.cace`
+ * in target memcg.
+ */
+static ssize_t mem_cgroup_cache_control(struct kernfs_open_file *of, char *buf,
+					size_t nbytes, loff_t off)
+{
+	bool enable;
+	bool opt_enable_set = false;
+	int err = 0;
+	char *sub;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	buf = strstrip(buf);
+	if (!strlen(buf))
+		return -EINVAL;
+
+	while ((sub = strsep(&buf, " ")) != NULL) {
+		int token;
+		substring_t args[MAX_OPT_ARGS];
+		char tbuf[256];
+
+		sub = strstrip(sub);
+
+		token = match_token(sub, ctrl_tokens, args);
+		switch (token) {
+		case OPT_CTRL_ENABLE:
+			if (match_strlcpy(tbuf, &args[0], sizeof(tbuf)) >=
+			    sizeof(tbuf))
+				return -EINVAL;
+
+			err = kstrtobool(tbuf, &enable);
+			if (err)
+				return -EINVAL;
+			opt_enable_set = true;
+			break;
+		case OPT_CTRL_ERR:
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (opt_enable_set) {
+		if (enable) {
+			__enable_mem_cgroup_cache(memcg);
+		} else {
+			__disable_mem_cgroup_cache(memcg);
+			return nbytes;
+		}
+	}
+
+	return err ? err : nbytes;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -7156,6 +7386,13 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	/* free cache field */
+	{
+		.name = "cache",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = mem_cgroup_cache_control,
+		.seq_show = mem_cgroup_cache_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1beb56f75319..54c4d00c2506 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -530,6 +530,14 @@ static inline int pindex_to_order(unsigned int pindex)
 	return order;
 }
 
+/**
+ * Per memcg cache currently only allow order 0.
+ */
+static inline bool pmc_allow_order(unsigned int order)
+{
+	return !order;
+}
+
 static inline bool pcp_allowed_order(unsigned int order)
 {
 	if (order <= PAGE_ALLOC_COSTLY_ORDER)
@@ -1271,6 +1279,43 @@ void __free_pages_core(struct page *page, unsigned int order)
 	__free_pages_ok(page, order, FPI_TO_TAIL);
 }
 
+int mem_cgroup_release_cache(struct mem_cgroup_per_node_cache *nodep)
+{
+	LIST_HEAD(temp_list);
+	int zid, num = 0;
+
+	for (zid = 0; zid < MAX_NR_ZONES; ++zid) {
+		struct mem_cgroup_zone_cache *zc = &nodep->zone_cachep[zid];
+		int i = 0;
+
+		if (!atomic_read(&zc->nr_pages))
+			continue;
+
+		spin_lock(&zc->pages_lock);
+		list_splice_init(&zc->pages, &temp_list);
+		spin_unlock(&zc->pages_lock);
+
+		while (!list_empty(&temp_list)) {
+			struct page *page =
+				list_first_entry(&temp_list, struct page, lru);
+			struct zone *zone = page_zone(page);
+			unsigned long pfn = page_to_pfn(page);
+
+			list_del(&page->lru);
+
+
+			// is good to put into pcp?
+			free_one_page(zone, page, pfn, 0, FPI_NONE);
+			++i;
+		}
+
+		num += i;
+		atomic_sub(i, &zc->nr_pages);
+	}
+
+	return num;
+}
+
 /*
  * Check that the whole (or subset of) a pageblock given by the interval of
  * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
@@ -2603,6 +2648,41 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	}
 }
 
+static bool free_unref_page_to_pmc(struct page *page, struct zone *zone,
+				   int order)
+{
+	struct mem_cgroup *memcg;
+	struct mem_cgroup_per_node_cache *cachp;
+	struct mem_cgroup_zone_cache *zc;
+	unsigned long flags;
+	bool ret = false;
+
+	if (pmc_disabled())
+		return false;
+
+	memcg = get_mem_cgroup_from_current();
+	if (!memcg || mem_cgroup_is_root(memcg) ||
+	    mem_cgroup_cache_disabled(memcg))
+		goto out;
+
+	cachp = mem_cgroup_get_node_cachep(memcg, page_to_nid(page));
+	zc = &cachp->zone_cachep[page_zonenum(page)];
+
+	if (high_wmark_pages(zone) + READ_ONCE(cachp->allow_watermark) >=
+	    zone_page_state(zone, NR_FREE_PAGES))
+		goto out;
+
+	spin_lock_irqsave(&zc->pages_lock, flags);
+	list_add(&page->lru, &zc->pages);
+	spin_unlock_irqrestore(&zc->pages_lock, flags);
+	atomic_inc(&zc->nr_pages);
+
+	ret = true;
+out:
+	mem_cgroup_put(memcg);
+	return ret;
+}
+
 /*
  * Free a pcp page
  */
@@ -2634,6 +2714,17 @@ void free_unref_page(struct page *page, unsigned int order)
 	}
 
 	zone = page_zone(page);
+
+	/**
+	 * This function can cache release page before free into pcp if current
+	 * memcg enabled cache feature.
+	 * Compared to PCP, PMC is unique, only processes in PMC can access it.
+	 * So, if the conditions are met, it should be prioritized to be
+	 * released to PMC before being released to the public CPU cache.
+	 */
+	if (pmc_allow_order(order) && free_unref_page_to_pmc(page, zone, order))
+		return;
+
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
@@ -3012,6 +3103,49 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	return page;
 }
 
+static struct page *rmqueue_mem_cgroup_cache(struct zone *preferred_zone,
+					     struct zone *zone,
+					     unsigned int order,
+					     int migratetype)
+{
+	struct mem_cgroup *memcg;
+	struct mem_cgroup_per_node_cache *cachp;
+	struct mem_cgroup_zone_cache *zc;
+	unsigned long flags;
+	int nid = zone->zone_pgdat->node_id;
+	struct page *page = NULL;
+
+	if (pmc_disabled())
+		return NULL;
+
+	memcg = get_mem_cgroup_from_current();
+	if (!memcg || mem_cgroup_is_root(memcg) ||
+	    mem_cgroup_cache_disabled(memcg))
+		goto out;
+
+	cachp = mem_cgroup_get_node_cachep(memcg, nid);
+
+	zc = &cachp->zone_cachep[zone_idx(zone)];
+	if (!atomic_read(&zc->nr_pages))
+		goto out;
+
+	spin_lock_irqsave(&zc->pages_lock, flags);
+	if (list_empty(&zc->pages)) {
+		spin_unlock_irqrestore(&zc->pages_lock, flags);
+		goto out;
+	}
+	page = list_first_entry(&zc->pages, struct page, lru);
+	list_del(&page->lru);
+	spin_unlock_irqrestore(&zc->pages_lock, flags);
+
+	atomic_dec(&zc->nr_pages);
+	atomic_inc(&zc->nr_alloced);
+
+out:
+	mem_cgroup_put(memcg);
+	return page;
+}
+
 /*
  * Allocate a page from the given zone.
  * Use pcplists for THP or "cheap" high-order allocations.
@@ -3038,6 +3172,18 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 */
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 
+	/*
+	 * Before disturb public pcp or buddy, current may in a memcg
+	 * which already enabled cache feature.
+	 * If that's true, first get page from private pool can boost alloc.
+	 */
+	if (pmc_allow_order(order)) {
+		page = rmqueue_mem_cgroup_cache(preferred_zone, zone, order,
+						migratetype);
+		if (page)
+			goto out;
+	}
+
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
 				       migratetype, alloc_flags);
-- 
2.45.2


