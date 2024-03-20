Return-Path: <cgroups+bounces-2070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF90880F43
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 11:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4111C21FDD
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37533BBEE;
	Wed, 20 Mar 2024 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z2OgY89N"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2093.outbound.protection.outlook.com [40.107.104.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DB38F94;
	Wed, 20 Mar 2024 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929180; cv=fail; b=TPAOtso9YVBW6EDKcb0NvHRbR/xo0Ndeep+9MLnWTukwapDybZXbOiJSGQHn9rmk3EJ8ZCHTUwbcfiTlWXtKMsYijW0oltfFJuX4rOhGoOJfMdd2plBwLRtggb/YRYz1DcLMb+ioAQddvR2LdeqKBRYYeyRNJNE2gn1eQ6W1kKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929180; c=relaxed/simple;
	bh=OvxnQ238DyKymwvltCQE3fOJTWKdyVQmKkO72JDg8N0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gGiVW00mcAG6EfE6rQKSLtbzCIa7J4axQvZw9yb2sqBmOMCrbqTrBTRI+BPbHo08mOsy+6q9MsbEujcrpFSMFDrODQGOWLuon+FIGmj3b6CAQkF+1esMtgA/p0vgtVz+QZn46tGdpsmNTseYmWunmqW+5DRgNp5uGN6HLYCBnrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Z2OgY89N; arc=fail smtp.client-ip=40.107.104.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn1MnHkysLZEa7iPDX6ljaRcfDEUNnd6kBb/isZlsfOfUcjCqIrM38bGYyZ93jlZleUeqFuWEkjhkU+P+f5NqiUAfm33AmdtyFVHJF12pRgrHrhOlm/o12ImJpZUV8W3bn93Qz+LsQ01xadTkxIzNDHww4EYvgDJlr8um2LazUaO4LZiJIfX8h67Ci5JawpBAmeWOmqtBoAccsDrExVodCm2XZGSLC55U+Hw1Lc+xx5lvOdNcU4dzhComfoe+LiNh/bKfQxf0FA1XtVDIL5mFdefQyoy0OTCTi918s7GvBQHtKNy0HPNjVR2JpwANQdUSfYo4kpDK6VIbi5Z9cfamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC8jldkPksl7L0pWIKVCXudCf2/yVpdYZ2UZLhm3CU4=;
 b=Xy6QOvLfKeFNYqXNg6YwJjXzPxHipmkbasF9b020083vzluFMxJaFzV/5A5X8BMMogYGnmrUc+pe8SO7GuNdwkUTryC5umwq9cFu9FIS1maNI2DtNcZywZgkLIzouM1ALcexNrKexxaumjBiDihmgeqDwd6/FUR4OL/4ymOQQ71P/gQmML82aoL5XHpKgWavUws/b1WkrRHWY7FRyOClQYbgSl+oAiyk8s21dYcG5bodXpWc6qFnCI2AbRCjBwg5eIqt0a/2nG8yA+Ye/Pg8htWoStywDExYxkaO6pKQ3HSCPbO2GTsckTwWBSpu68zKHD5mZedSThJb7yppduUP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC8jldkPksl7L0pWIKVCXudCf2/yVpdYZ2UZLhm3CU4=;
 b=Z2OgY89NG9SMQ3FnkP8JHLOjtoJ4FIMGcdEa1r9FDl1S8SX/zOqfSRfrx6hL5/vOZu88h1kSYRTOLCOFSWnlrLAZ5w2vO5zECJ6a7mk58dSDTb8h5NtCClG7IAZjCBWL0qTtaThY3t6nR7Pf+x+AnyaUzUlBIbtwPDX/jL01O1sEST1YMzZm4eurEztufDfmZbGuGlJg7mDaypPauC2qTQ3t5+XfKtUho+Ahxv3ekc2MB0JUu5vcCJMpL+Sqwpym+KWO9Whs24APBB3YVRymant4oP7Jf3CGYqxB+fjvPNPf3EJJmUyV3v6Sph+A0sX6bqDspR5p4HXu694uryvt5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PA4PR08MB7435.eurprd08.prod.outlook.com (2603:10a6:102:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 10:06:14 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 10:06:14 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] mm/memcontrol: stop resize loop if limit was changed again
Date: Wed, 20 Mar 2024 18:03:30 +0800
Message-ID: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::18) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PA4PR08MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da4412-e651-46c5-9ebc-08dc48c56032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2b2Nima6eW7Ay6kAxgpMQzmvXza+o3EqS2lSI6I3b4FXvg24iHO0VWkrTY3p4PVDXdDkHOj4F7oN9WFr3XaBwSOB6tcgFPCwK+3yMA6mLJTDF4ncs/crXxAVhxfoUWNzytlhG/lfsXsPijJBkGvXs8BHxDfu6DxlzneCcCoDerIKboCaCTaqzftjr06WOiy0bmAqnnLQSdf22Mhj0hdMtJxZQyMPAGtPUZmjYBWbq8pWzVHi5/wo54cx3ZMtrXhGGALeEFABNTJlD45AsIT5kTe1oEP6mU+2OLMs2x+QO9rkb0XwoY7Q6cFUoKJXnf4e5Wn0EEcVpEWVbIvMh5PQ++ePZEnP6+o/Y1ykIPq9W+s+BYKPj0Hk4d22YNxk2D5rOHDTzkPdxt3Hm8CeN05E0Gnpycd/9SnsvTzNfFGYXsKDJa4R5cYVu3GAmr6siD0FlpG23G6jnF2ytACI3a358jx03Nci6I6kxqIBu4QzW0Sl5Q+P05RPMkZG5iDKuVuFkqSR+ckIKDBZjbq4UdaKLb2454qFrEOdx4K97ujwutk3AcvKNaeELB2RZis+8CzAVFOjRe/hXoa6vfkTeY/jSgTcB3K7NbA/QbA3DzFd0h5xWWUX/BjqWb2+hCAd316THaGyJLLlObDcnFf9BE8PkOKynY5CeKHs/ubPm22I1XM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/rWpzhq1P7lwp0l2jO9wZUbgqpZTvQvFjkB4op+TaDREEyplinexw8PyAB7?=
 =?us-ascii?Q?HmefpM0/aQ4CQv0KKIKMCwZM+LaLDIRZ5FtV7ok6+M7PeIlkKgog65sznnm2?=
 =?us-ascii?Q?1hDaoxVRWoXJE8fzeFGfv6yFRBwA8HS1YoNPT2UOXotrvBeGTiSjZwV08jan?=
 =?us-ascii?Q?98Nr+GZQT7NSoQIERxIEMkhGfR7PsAbrPAxLSAOeLBOUlmdZKT5ojk5m54st?=
 =?us-ascii?Q?sv7yesviwD2CFY5P5MvmxtuRHc4Ijnd4ikGhj4XdpOFklrfXKu9GzmHSPQvZ?=
 =?us-ascii?Q?6o4jG3wZuHZ1KD6c28T2Zc2VuLSELdx0iJs0NzWttRAq53BPajaUgGaC1uhW?=
 =?us-ascii?Q?zjz2r4YRk7YjSo6YRQRk67HAOjSNwA3GhBBI2xrbDRnjvAD/+jR7jQhBzOn/?=
 =?us-ascii?Q?yOpBhawKoXieU05RyQUStXceiYCosg6jAXXtHpoO8656WS04Cm6zjNh0H6i8?=
 =?us-ascii?Q?WpyxF965xDwQEb2I4ElUACI419Htpn6n05+/Af0EvptGCdoP25gUJnQSjS/0?=
 =?us-ascii?Q?+LPRMi/VgsUrwwLiw6wyJUr28OIGJGAkew7ChZbGNLhSP6LkK7IYDqbFKrxo?=
 =?us-ascii?Q?KZEvceayfMSMyQzdbyGEqTUs+bZ3UF0A0KT6x00cE0C+aUKJuMouUEBVEmvZ?=
 =?us-ascii?Q?J8r6VhGgPrlGi/55WTt4xcCFmAMH1XgxBk/Sv0cGFXvY8GxLZzIR0zyNrR7b?=
 =?us-ascii?Q?TzbVPKOLv46GBvHU/Q72DI5rCcUa/v/sZX5pCxJavtKbV1F7+QjcduHVd/vo?=
 =?us-ascii?Q?CIMsPzIQzPJmuwlnA9Cx15o6spP9G5onxXvmDVixeq3TQxClfMDoFkAL8KlI?=
 =?us-ascii?Q?5yrPR8FTe7ihFyuw1OY4c1ScZzKmmJvVfemRHGu94sQnU1uBDZvcC4i6yAn6?=
 =?us-ascii?Q?fgM8QUWRCd2JKggSS+cyk6+ulfklGFfgACX5W8+fJdxo+zG7YriuzW0n7ce1?=
 =?us-ascii?Q?c0NfMhoZodyGTS19xRaI323NeGs6PogcuJeKxcfRkhfZailorux0iDHqD1dN?=
 =?us-ascii?Q?EPBZu4i4eKN6gZfspD5BHL6gXIIUqT3lFLLz/lyXIhf8rMThpDqZrJGfn69T?=
 =?us-ascii?Q?i8WRDT9JunkNkAHzmok2m6bMjJ8EN+ToIDLvsnnHDi76Tg57P/CvHfpR8O6U?=
 =?us-ascii?Q?caxqe8r6ER92zfyZf8vHL/8+0FQ7Q/mxE1Doitdo/Ti7oTzwrgXNAcKh0U9s?=
 =?us-ascii?Q?aS69o2vafVT6K4c6cV9dkJMfn9gppeSpAJgJYnTAGnnihWVIIr+JK6khdCC3?=
 =?us-ascii?Q?PYmi9dR3G9gh2howExyStBCRwAvd3ntN7CdI/BM3hpRMtol84N9ihR/JpqOc?=
 =?us-ascii?Q?BnPf9ibgL6RtJUyA4+yKz3CZazZrwLHAlyck0dFyxq8dtCzb8CcfMYx2mrL1?=
 =?us-ascii?Q?05QKOx9TInhwvcw4E7WtBueUNNF/wZ3wjgcobU07ApHOGD4mT5ANTkZW0KEg?=
 =?us-ascii?Q?rZRd4zMX4ngamfvkzyjyp7k7IqK4XP6LmbwDPcfjb8ZqT2+9tCmUXmQCUCQW?=
 =?us-ascii?Q?vE/TmsfbcsZjSCk1b7LueLTzb5qD4ItXQ/D+GU4KgqDdZhn7+zgtHenOVLVR?=
 =?us-ascii?Q?9qRXBBEND31/eNFKKLrE674QkoQrfOVTXP/pjyW/TrVH3OoLSlHHFFBZ+vjY?=
 =?us-ascii?Q?uXYUIT5vUeY6su4M/Mz3f8IoUMlYHV3PxjvVTXFCSqcD6+ZGqzTD5EYkWOGo?=
 =?us-ascii?Q?Bd9IEA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da4412-e651-46c5-9ebc-08dc48c56032
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:06:14.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZp4bIb1N0CvFpvwNg/tjfXMBiw6m3GL54BiAM/RxjfQL3WlEzcS1t28jZguZHwRAup0ee//k9FCuBsMvBmzEQxSZPVygMHEg/UvpZ81I14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7435

In memory_max_write() we first set memcg->memory.max and only then
try to enforce it in loop. What if while we are in loop someone else
have changed memcg->memory.max but we are still trying to enforce
the old value? I believe this can lead to nasty consequence like getting
an oom on perfectly fine cgroup within it's limits or excess reclaim.

We also have exactly the same thing in memory_high_write().

So let's stop enforcing old limits if we already have a new ones.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61932c9215e7..81b303728491 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6769,6 +6769,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 		unsigned long reclaimed;
 
+		if (memcg->memory.high != high)
+			break;
+
 		if (nr_pages <= high)
 			break;
 
@@ -6817,6 +6820,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 
+		if (memcg->memory.max != max)
+			break;
+
 		if (nr_pages <= max)
 			break;
 
-- 
2.43.0


