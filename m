Return-Path: <cgroups+bounces-7797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AAA9ACF2
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3111943B17
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5B2343C7;
	Thu, 24 Apr 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EJcCLUxf"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013018.outbound.protection.outlook.com [40.107.44.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E623278D;
	Thu, 24 Apr 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496631; cv=fail; b=deSr0AeweFTxOOHhim1K31/UiaV1L9mw4fB/eHAyISRAriIFcVwXqJtBfhSGjz45TSn1SyTeSWTsBgoGwS7M0YPwVW2H2WcoVZr6cymHrE3jCWLVXwAfazWDYfY7NsGPizdDgENTnidfBBy1x4GrEeS+hG2L/BF8hAajiLxzza0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496631; c=relaxed/simple;
	bh=kjJ0HS9DGq1ZZHd/Ipr/Mi3A4WxJBI9HujUD4crlYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eBrFT7XMZcteyZ6QHWFX5w55xKHHJ8OHrjldXz3nm+I7WOGqdfnteryR7o9by/xcRKe1PtKVGmEWdg3xtx4TgB33h/yivp8kQggxhka0+Od3tSjYkzAtBNtfl3KLVxMy5mamkRK85Vz+8YoHzf3uWEvNV4ZaJUTkz3qjHZc6xJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EJcCLUxf; arc=fail smtp.client-ip=40.107.44.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWYsq5aqiBJhMAhpSip/JNrE361GcC+bo8o4lQg/LPNwEGpywih9fGPUfsTTpf+T8ZcgBlHQI/DMpvG3d9HOJteRZaezVjxSp4/APNgV0VSe/LX72mfjKMBXS9UGmEkc0TfNtucX0DR005Vq4yYkM+Z8N8JYaMel6h6rtIfuOA9OhNWBmlPg7sDCEEG3D7d0pYNaj5ZeNq5wpxTo9KcIiCBkfqh+JRCxUymmEswuvqS+CggfSTjl7gP7awN8ZiNzM03L4QL12zIE4YcqHzK+94YX4f/IrTg9MEmdat74yUPqvjyo0cpyfQbdmBIJdF68IBTYf4YSUZEQz1S1O4jsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZWBjqzuuEVsBzdLElOODx4qKZ9veU2ZHPQzi7Y9BnE=;
 b=vrjaLATy8zTVLnlg05tP/hsSRmY30Mx7Qcsa/L+qf8vHM5LOLslBrH9yzC3LqL3tJQ/T3gajVDb/NdqomWo8lvLKquBBogJagL4R7i/+9ZsfwYicCbGE82nEa1NL/6h3oP25G1g+S/bkLwNSB7akxcF6mToYWMU5wLQBwnV5C0ixBI34M8rffjKCEMlpfnYyrCvElQZgxUEBdXKYbEb+wmef0BJ6ezsE4l6PdM8Qh1lw8j1atzHt4o+vSqBAEgic+9Ts++nHL8lf0uZUr/N4wkZTrZfNJvT2oKyfGNmdOASjsb6jKttrZ8klDVkGUp2BplwIp3nKbFdO0abf5vMrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZWBjqzuuEVsBzdLElOODx4qKZ9veU2ZHPQzi7Y9BnE=;
 b=EJcCLUxfpFKMVmreLwzn8uZNxtkg7i4Xd0yXQo1QPyZ7hQVJCTSYlDoB6dxlP1H9h6Ox6RwV6bYPIlOM8ecDITJggnwlQZqLmf6i2cA25a8UtZZ7AOswO+5vEv+PcvfJrVEiGvZ5ZEifLcMDkekXfME4WmdhyCOek/KQ+p2sG3PcSBS9UsXb1gbh7LUJxAQVnZVIZpJOEvxgtuycIoHrXXQfebaQ101UprWKpwsNB1nQac55zMFeR912dgwVLk7q9+Jxf0EKDbm330btbteT4fXgtgmIt+m2VCJRocfFQ5jL1BuBpQ+buzi45jJU9PnjUMMRce50zNA/ChuTOgDoMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 12:10:27 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 12:10:27 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Huan Yang <link@vivo.com>,
	Francesco Valla <francesco@valla.it>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	KP Singh <kpsingh@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Raul E Rangel <rrangel@chromium.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 2/3] mm/memcg: use kmem_cache when alloc memcg pernode info
Date: Thu, 24 Apr 2025 20:09:28 +0800
Message-ID: <20250424120937.96164-3-link@vivo.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424120937.96164-1-link@vivo.com>
References: <20250424120937.96164-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ce1817-abd9-4c93-16c0-08dd8328ffc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qLTLvDKzQabfuDNz7GExDsLZyS8AVGJkDA5CbAeHUOoF7rrVIW/hZHLjYyrG?=
 =?us-ascii?Q?DlndLr0rHscKIWShAzWY34bRX2td+VTILEnabWJHeZbSYTY6O3qeKtegPkaa?=
 =?us-ascii?Q?cyidmnLl5kUJZg809IX1jsyhvCaCJ57WFvbY7TYVqucMF6rQI21E2cQIowmX?=
 =?us-ascii?Q?ZfdtaoMj5EZbGFatP7zJgGZLxocVSDx9Yxa3z0NSfj9QUD+YtD35Bv7CBmu1?=
 =?us-ascii?Q?s34Fnl3gdB3/3SVQ32JArF+pf5fcSl6T7b1Dxcbyd6vyNxOndKwZhXUvReMt?=
 =?us-ascii?Q?PUSZjEwsSB8IsFWS+cKeMpRDITqO22J7XN/qRt10dVeL33msGDlH38kpO5Zk?=
 =?us-ascii?Q?B2AErwICcqINoYfL6SHbow0UQ+jSbfzM6u1B0ZJ6a5m7coelhZ5V/2iMEuFH?=
 =?us-ascii?Q?oA8ZySiN3F6vrLKciBKXsoIBs6hYBFRVjybW5Kjy3iwGbalnpwtsLrg3Unvw?=
 =?us-ascii?Q?CcOCGrDbZQw6cy5Xlk6twfklqfzNEH+rdN+HyKZg/NLDOBg6LSC4AjR5wqcT?=
 =?us-ascii?Q?qpHgit83Jw4fIcXaiIQYISjjiaaQBwa0a8RKEjIvMglJIO5pz9KYPbfhvXGs?=
 =?us-ascii?Q?xBqQ29z/kTNvt1qPtb/M/XP9/GzuY5BXgAUza6Uvpf3bV93/vciWitas1s3T?=
 =?us-ascii?Q?VGDlMWiZFk9EgtuWpxxs7ILbjz0Heda8r33YbqqIR5CtClvEZUC86kAvfbEG?=
 =?us-ascii?Q?3pSwrYIluSmhrjyT9+YVkwn6AWooigIzt8cr6wYalZV4phOZCQ+DF/LEXV/g?=
 =?us-ascii?Q?coGmWzU157MHl03BUE5yruLVBIMzu8fMdFp1hvPaO4X2nabYlXiWMVCDRovF?=
 =?us-ascii?Q?8u1zz0ZeyDzCne0/rxGPuh01ngQjoluOWKNTmIjjsqmZ5jl0sfxr2CS/7PV8?=
 =?us-ascii?Q?69ynxg/LmtVe6dz5Ae642J7QyQ9zE+a1XPq2zDKKup9MKbeDoE169WjN0rVO?=
 =?us-ascii?Q?mKUkUoMr/r6OfL/WddiPIlGVmjvllYa4gXMLNBLD365zOjYiKM2ImZnhjjFv?=
 =?us-ascii?Q?cA70BAzOxVshVozD0gXAshSZTAYa1qyB9zx1GPUArayUAf8DjG0bZN0HVFTR?=
 =?us-ascii?Q?ED6ok7dhuC1mXIZsB8rvwzdrdUcDFOTqzW+Ak5I20/feFBbFqs0WDfVt1rhg?=
 =?us-ascii?Q?1qX3KQqQ0Rof364v8Lt++wUZr2PErv49T/G5OBUYuhQpXmQ5E8SJfWlgt1iU?=
 =?us-ascii?Q?VFe6ZR7sKf35oevUQ78KO4JyQVVT+cXxqWULVjmsf/OYaSUBaI26C+FQfcU6?=
 =?us-ascii?Q?dfwS317I8bpdWV/yJejoYtGMRv7R16VJHr+NK2nJLEbU/DtV57JXzkctSCiQ?=
 =?us-ascii?Q?QD01N1R4XiUuVjAdORtUCwy6Bu7OixoRbU8eNP+LejYa6wgu0sEIHh/CnsQp?=
 =?us-ascii?Q?SjxNjuZdPvZYT8bvIpVrm7NoygXaoaHOaVSP9KDgm6N9q/m+JhQPiCbQPMmI?=
 =?us-ascii?Q?cIsrgXwSEbH/SLvEDfhHZjV8zN6jFnzX8jmQdrS4aAuDFdaQoMA2vWui1zze?=
 =?us-ascii?Q?h6Fho/NgVqzvow0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrramREbwX7uxWH2ecYl3IH5ZfohBwMqVEuIK/5HTwj3IvjkIOtKqRn5fHp6?=
 =?us-ascii?Q?T6ikFjrzXm7rkkxS2lrk35uM1sxro6Qpwo4C8taVBMOKb97DJv4T/yalqhu5?=
 =?us-ascii?Q?girFCmgi2KrKIr+A1TVHMMgDTxK1++hH/pW+wrmLvbDL6vcBe3kjpQtyCwnn?=
 =?us-ascii?Q?WkDOF5FymRWAry7D3peEGUgvYZ9MdxSZbn2eW/rFEAo3iDTqMe6WmkZ2vdIf?=
 =?us-ascii?Q?foVvOHqoZJ8qwpvrkzbj9MWTa1tKRFL2wKMA0CGGkDaG6iOuZ/WXvhzCEHnf?=
 =?us-ascii?Q?aVfa21D5GhRRMuxC5WSEqfHAJT/xK6Ef58RsDfTj44CzluFXfrYPIlA4xdLT?=
 =?us-ascii?Q?SS/O40WXM0LnnpzHmS4fYRJQqSDyJDYpYp0GP5xKYjaUb/9eP3h0YvcEUx2U?=
 =?us-ascii?Q?8G7Kig+FtpVhNrqluS9Dfr/0RnJBm4Iawj27dAFv88KpFxsTwz9v7D7boMkz?=
 =?us-ascii?Q?PNpWrl1x1m6hJAu9xUHunb0wT8qH/BieRtN857e4MgYMN5TVidse7HrdWlXP?=
 =?us-ascii?Q?aNcXXlYPxWTFqj9VzXls0be+c+ko39GUBei9F0MQk3CXRd4ExjeZ4B3ToDkg?=
 =?us-ascii?Q?0Hv0grajRTT4MEPYqs/DwwxAZ69kcE10Xds3rrbkii0IPFG3ytmvmaaYDexE?=
 =?us-ascii?Q?APQ118XvthBmvYwLXmBnfoAc1WOfo1KfJ57uGqpM0p7c+kHB5i81/ald2n5q?=
 =?us-ascii?Q?AAzq4WqsTtfruXuKNpk29EBkpyPF7+XQR+87Z90SrqOKDPVtdPXagKiBE4LW?=
 =?us-ascii?Q?pI3B/i5rz7kWwPTS/cY4jR6gh6e40BprgaLRdQQp4HX1Ol3BOXn4NXFbcCep?=
 =?us-ascii?Q?D+5QC5flsy8tnCRxBKlvQDzrZPye1Ew58NWGbyd7VkySIsRlStZeVZL3hG2c?=
 =?us-ascii?Q?1ILhwbFdjWcDCjpg+S08VtdsqPd/Tem3mXOrw0OWbJ7mpu1ZXR1JYtUIQOF6?=
 =?us-ascii?Q?eQjHWQ/3oQ6zPhxhYOXIiGF54nZTO2VC6BIshOyhRP4M9XelOqg4TNKPbW9+?=
 =?us-ascii?Q?6KdsGcWU+fwTl79neeDnU7VYmCp5uejwrORURbGM6R2i/VzQ1s++NAxGJ1Ya?=
 =?us-ascii?Q?DiG3EsAhknrXSi5pWM5R9ZC6BYm2Sy/pkHFC37TAb6db0+xVohsIVdk0/A6D?=
 =?us-ascii?Q?aN73Y+4JgCGi9nkUn2I0MVtg5/QeScKio1boqXV/kSCMvWBZLJLiSKGT7rlT?=
 =?us-ascii?Q?OjI3gwg/J9mWxToS/mQcMxmVBODO67DyLEpg9WfXX3hXF7KTG3AlMDMzqIgq?=
 =?us-ascii?Q?qgU8kvuFlQfu7/OZ6/0vqCNHLAsBOSHuVR41+H3dA0vFm9n/bRFDgewHSG7G?=
 =?us-ascii?Q?YK+K2TzmD8JUPW9USHFbKJaRny34St8arRj0phhDFYRAB1RxgShjYL66t9Bk?=
 =?us-ascii?Q?8w/Ttrx+Oq8UmmM4EYrLNuvXo0YMkzDFZWcLTnGO4AXhLyVUExJnICwZvYfk?=
 =?us-ascii?Q?Iryq+BA4Bw19cNl7Vf8phO5Z1oxr8LjApJS2wcClW0VR8T85nelvIJHqf2Dg?=
 =?us-ascii?Q?TIUEzLHP7vH8cX+E8RH/h/VtetjGHq4Cwec9jCZ9bWcTm6Bg1C3V4mdEm5N/?=
 =?us-ascii?Q?NxQT4ULw7zhtK0ai4O40OJmbhorWbUIpgXVB1m/Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce1817-abd9-4c93-16c0-08dd8328ffc1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:10:27.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvDQ9p79cgp6pfuC9kx+03FOoHGw1DBRVWMP8mpiwn7MgsDolxG+0+X3usQe+FsWJk5tve/+q+scReJJcLOaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

When tracing mem_cgroup_per_node allocations with kmalloc ftrace:

kmalloc: call_site=mem_cgroup_css_alloc+0x1d8/0x5b4 ptr=00000000d798700c
    bytes_req=2896 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false

This reveals the slab allocator provides 4KB chunks for 2896B
mem_cgroup_per_node due to:

1. The slab allocator predefines bucket sizes from 64B to 8096B
2. The mem_cgroup allocation size (2312 bytes) falls between the 2KB and
   4KB slabs
3. The allocator rounds up to the nearest larger slab (4KB), resulting in
   ~1KB wasted memory per memcg alloc - per node.

This patch introduces a dedicated kmem_cache for mem_cgroup structs,
achieving precise memory allocation. Post-patch ftrace verification shows:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0x1b8/0x5d4
    ptr=000000002989e63a bytes_req=2896 bytes_alloc=2944
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=0 accounted=false

Each mem_cgroup_per_node alloc 2944 bytes(include hw cacheline align),
compare to 4KB, it avoid waste.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb32a498e5ae..e8797382aeb4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,7 @@ static bool cgroup_memory_nokmem __ro_after_init;
 static bool cgroup_memory_nobpf __ro_after_init;

 static struct kmem_cache *memcg_cachep;
+static struct kmem_cache *memcg_pn_cachep;

 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -3601,7 +3602,10 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;

-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = likely(memcg_pn_cachep) ?
+		     kmem_cache_alloc_node(memcg_pn_cachep,
+					   GFP_KERNEL | __GFP_ZERO, node) :
+		     kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
 		return false;

@@ -5065,6 +5069,9 @@ static int __init mem_cgroup_init(void)
 	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
 					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);

+	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
+				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
--
2.48.1


