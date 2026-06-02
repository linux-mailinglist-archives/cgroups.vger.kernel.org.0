Return-Path: <cgroups+bounces-16536-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCFYJqk+Hmq/iAkAu9opvQ
	(envelope-from <cgroups+bounces-16536-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:23:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC316272F9
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D4D3033516
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079534D4DE;
	Tue,  2 Jun 2026 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AECA+ZU5"
X-Original-To: cgroups@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB21FBC8C;
	Tue,  2 Jun 2026 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366621; cv=fail; b=rArED2lDAzgU/p/HHxsZRkjQC7Y2aIn/vJ6jSbck5F/KZVpWob61edFZYbl6BlfGFRaOJv00zqUvDeuArBsfOTmfHYqXMAhFpxaN74Ta9wYktTNzW8gxpHF1jjsiat+xC8uGVEEdJ9FxaXO3Twq3bi0digJzKkijhv1u/zetw+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366621; c=relaxed/simple;
	bh=aCMEC1k2ObJ07K1IRjf2c4Mkb8QAt3hPy+JqA5vpI5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUdAAbJ0RJ4eBw/8z+j1gTuOtAszF2Ehu3v7EuaiUpC6LyCXXP8obwRCZc1jXPeEY9KwD2mBiUyxVhtwWKErC5M0AiLleaEgVOVszp3xt1DzRChbU4mIIC/37IcqswrXev2yXZRJdwCo3m7wayLgq6fx7r03rzZpOe2o/mODS9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AECA+ZU5; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN9IMTYICZ9lRjLv2Oc3TljFRklsT2Ro0MmoqBTgCNXKTYe8hR+WXeoW4Pus3PjjDbRNJQixYYjUm7npbJWk9Eem6j+j72aw/ZZPYJpMKsxYboB3HOp8GzafYProXj/jKHpV7HT6kIfUDNI1KrXYq9IP2SzJ7YbF5UF0lsOKzbNVSZogSVMnwCYtiTXxELO6qMEnBTHdxr4CxcNpA2wj0Q6fhi/Vq9jfw3oK0j54XZU9Az4Bt4ZM9egMiHbJ53TMmLUG/nlt575cc3Ko6vUOsGwkPUDx23M81cLIZbyQytWTRakkqSRT1sp/ZykKaLgYjTUowJ4kVXlqJcXMrh3gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oWJQp9FI0zEZ8Felz92KhXzdo4p07tkn6/OuOGNaxI=;
 b=lzh+vWUqVE60lSpeMg4n7A6xAsKCtpRqMXp+cEDEWfh0mrpegyvvQjvq3l2Xv3vZpMiUPyiLOq9GhYfV6uRvZFY1h0V2ERpcTtwAEYjNOROHzEwahYRUh955psP+AxJ0nOyOkiIVPkp9Win0qEdGW8aXFTtv4woBXh92IFjDD7m/VzN4C5QipRVTiPEUYQqfsgRVnISYlRhlMieP+2+iX+hXU+tPbvTsKavGarW2B1Vsn1i37P0KJKM+F2jjQQfOBElBM5qETjoEEf3+tg9/4bs9wpFaXFcsAQXjx6rYht35BMdGtRtRozoqzBTqDkktrCBX1d66fFgKQyA3bN3ZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oWJQp9FI0zEZ8Felz92KhXzdo4p07tkn6/OuOGNaxI=;
 b=AECA+ZU5L9+fPbBS8LC/qGcjbWrOeLQBmUcNyFf86NJhjVotEI7xuCaGYRdtUxvi8Vqho8XtO68GjFcaQL1Wzb3shBeH2cSzYWXGOlr/Wn4+FcGCF4uIu2fdpdSg9J0EL5Si2T9To6kT7UEbUFyO7s96V94ArB5sW24rWbr5TuU9BpfC5v/IhePy7oVvKjzx6ncu+0mhwxTLAC+RAvBqYZognQJzlmprURcklwujJ79IZ46M2o1XGcH11W01XTW9n9nunEde5fnluMaF1CFRJ3fq9POdp871vkTCFNMWfH0rKT7k1s0C54J8IruCHkUsOzurgAMk+wxtorUahDlckg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 02:16:54 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 02:16:54 +0000
Date: Tue, 2 Jun 2026 12:16:50 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, kernel-team@meta.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	longman@redhat.com, akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	pfalcato@suse.de, rientjes@google.com, shakeel.butt@linux.dev, riel@surriel.com, 
	harry.yoo@oracle.com, cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ah47NNhuiClgGCdn@parvat>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MEVP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1fe::7) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f36585-e3c3-4041-6db6-08dec04d03db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	2XFt0VSikKHTJ4E6lk8jdB8iHi/1E0wAMBM/3iRMes/Km1GRQCJSZYQLPwkYdl6e5KMTTFwV2a16xtJYCtf5IQ/VACZIkGEeXjVftauRIEWJZbUAZyL5nv4AtNrdxATKnKxjY2dNgrt78uGaKJJBaQmw2VAjOkkBbvSWxG3TZ2Io9DysaHl8HJl15quN1XrYfqwsd/x6K1pGcF1WS7oaY0W4UV1rtMjLtqxoBcg/6WOU08rLW6IrEanws/otOg2EFk8rBcQRid0CGVTTPAS5NuoUQmXYU8nOZajHkOoVh7aqNA2J0HfBgUBJJK5CNVWpir5Bxt1OAeoBMaTSt6pxqPY0oV/qa7W1am77j6J+fBCWXbGc6i7+lk8AC6ppX9vRbZe/i8fSYUO7OuwDvfacIKnNPRi2lQOBra+DXlsRZN0Mo22mGBqYUMFcRvd65oD5UwEZZ2YpKT2CYK7qDuHAxTqk7qyFjrkAQWcQWTQ626+WFEnwDDlQ12ZgcNGL7uuM9ozrc1jmWvt+h1Kc9hhMu3YN6MLsVDk8Mj/jFEeW4W2EctkxHi9QD9QJZJSmwRPdHNEi78YXSIm0zxEem67Q7gsujBHJuBaTLFR+i/pEEf6/+ShKeOZqr0WOOqFgwZle+xteBHbiSsDrpXNJeRCEzDYcOHelX3myil+Pc8beqIJELCFfbm5NesJHj/TGANjJOa9waA0Ie7h3Icwb0BbzBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRy+oj9smaqa+RSHsx5yh+0v/BUlmSkU6O4fiQiTTjDyWfKth0IwxTt9Lj05?=
 =?us-ascii?Q?nQWCu5ewkx1aoxceNyr4+iNKXkRjGaEUuukRQrl/SMq79ziGKXG8yJRk6Zwx?=
 =?us-ascii?Q?WQk7oU/+phK20g7iXN9q8CQMjZyUCF9YgVF9iWslwtg+PzUWcjTQQH3R6Vkf?=
 =?us-ascii?Q?WqRSEAYsxyTg9RQkA6LneKSPQGH3ypALEkrv22I3QQiyzbMOAl4hjBeYw9Uq?=
 =?us-ascii?Q?cN9vkRi8byOMokj/4djo20t6ytG7Jt1oG39pOTcSPRr3VLxTyOecvFY3q32b?=
 =?us-ascii?Q?rjNhZbNKVyU3d68LZH9cwrVZMfI/tg13EEnyVEPoAimb8vIdmwL+9fkV+QH4?=
 =?us-ascii?Q?SLD0qINuol2yWZ8+8MtAtN9+mGn1cHdiDIO5Gg/KK7fool/ohzA8m6lipLdc?=
 =?us-ascii?Q?3yxFVBDg2pcsTuV6WJxPSZ+Kz4oMyUStdKtBhbms1eUd2LGADAFfKgukmCIz?=
 =?us-ascii?Q?NTW/8zhjgsXzwUzWxlnt499jNun3FtKHm/LDZow67T42Ja6c3rZK2rQ+EcFV?=
 =?us-ascii?Q?UU0hVvHR0n64YKDgCTsT2np8NaV6F4FOR05aihmPzMddmcLTsK3DvG04dYdK?=
 =?us-ascii?Q?C7c/GtsSgGrAgJuZXm0Wh2PlMGZvgGcaqkB65hm2XPiwpaTcB6lzuBsr2dh/?=
 =?us-ascii?Q?C9Lark7hUIcJ1bF5IcyRKHRvFkYpfIQH6Ua5ai1J7my+4BB5W2mPiogCzRCV?=
 =?us-ascii?Q?M5zbJW7Frk5E6cXiDoUeMgnkG7PW3aChp5pKqKP/d7vElblJzTDGz5d80DoB?=
 =?us-ascii?Q?Bii9xyZD/2wLq1meXvwREsSRL9Xw4PpqjTd+OrZviZrLxaXhhxPCGZ+Tt0rf?=
 =?us-ascii?Q?X+rU0mFWfmkbFgQh7cRdNkxdIzsqLY4A96yPxp/vvxPYscmlKSAkhn249AjB?=
 =?us-ascii?Q?s5F11QwmpZqJWc6rmoNo3XOCBJZLe2a6OdRp6aQVWPTTUX2EQcNSIAD9d8Nh?=
 =?us-ascii?Q?y8rsbuhW4WjUIFiuI1jEQZmJA+6z1GXSTq2O1jxci2U1z13vTfysyfZS2PvM?=
 =?us-ascii?Q?AW8T/ovSbGnA5aD5CnGL3Nieb2hfLf9eyqs19+BZKwLysmM/1rFSffQSnoww?=
 =?us-ascii?Q?QFcgKe8q0tXBtkc305jYP8JCVDgNR7JA2qqvjRuQ8wHnT+x/v3omciiXqcLK?=
 =?us-ascii?Q?547wDrI4mUGVTZvguNeNsKc0JwIxdFl+EgEqax8TCvMIAmR58LoGgvJ6Vq0D?=
 =?us-ascii?Q?dAjiN0D/owNb/x+HfshYvwQC9s8/MKb1PHPK0aXOEkuyoBOjbmM0iO/diqzd?=
 =?us-ascii?Q?l4M01lzmI9ODjhcrASNVkbMbvO2joGvg9jQb02RHB2Z/5dU9LXUxO06VQHx/?=
 =?us-ascii?Q?i5wIlZ/DEB9oCIOBb3WWwh/c1QGeZ6ewEzxlCHDA68gX1uIaDZITwwMTJFUI?=
 =?us-ascii?Q?Rl49ZTYBSNgdxi20bhKc9zKEW0/uEzONiinnxNaRDJqnIE9FvWvJeXnTzwIC?=
 =?us-ascii?Q?XKsXH9/o+NTh8RTra1FX2BH5zqrD53yX9yCL9lpYrcgQCE92P7KMzGLe2e/5?=
 =?us-ascii?Q?EHvJsSNOIkMGl7kQzRQR8fBXJPiUa+9ZchqBn+DiC8ffx1PKbFqJjI2BqLK4?=
 =?us-ascii?Q?IHdFAwG2CwkMls6cbcz+nHwZNoqP/w822LlWaI3pJ+22ovZ/aB82DtbmEYnv?=
 =?us-ascii?Q?j9Q0u9hQPvLJF3okdGAB5R95Gj0cBiu+FYd5LEYB6KM3CSJ/me7xKqoTciHe?=
 =?us-ascii?Q?NccegSSoz0WijKR9FY2HD+dhMaTaD/AhXTeS7EVfA15hkKX34omZ3T8VtSJ2?=
 =?us-ascii?Q?AxkL3/wNRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f36585-e3c3-4041-6db6-08dec04d03db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 02:16:54.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rm5RNc3JFvQG7eDLrFqsoQ8huOET9q6QPbS2jeBikNo0Paui4k/zjduAeJwslQ1WKq2sRQPlChPi/qBpAOw37w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16536-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0BC316272F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 09:50:06PM -0400, Gregory Price wrote:
> On Thu, May 21, 2026 at 04:23:28PM +1000, Balbir Singh wrote:
> > On Sun, Feb 22, 2026 at 03:48:15AM -0500, Gregory Price wrote:
> > > Topic type: MM
> > > 
> > > Presenter: Gregory Price <gourry@gourry.net>
> > > 
> > > This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> > > managed by the buddy allocator but excluded from normal allocations.
> > > 
> > > I present it with an end-to-end Compressed RAM service (mm/cram.c)
> > > that would otherwise not be possible (or would be considerably more
> > > difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
> > > 
> > 
> > Do we have updates/notes from the meeting?
> > 
> 
> I have been on leave since LSF, but I do have some notes posted:
> 
> https://lore.kernel.org/linux-mm/af9i7dkNvGGxPHzu@gourry-fedora-PF4VCD3F/
> https://lore.kernel.org/linux-mm/agYJcRgOHho8upVv@gourry-fedora-PF4VCD3F/
> 
> I will be trying to post an updated set stripped down without the GFP
> flag as a first pass w/o RFC tags and no UAPI implications so that
> device folks can play with this upstream.
> 
> I'm debating on whether to include OPS_MEMPOLICY in the initial version
> if only because it's not intuitive how it interacts with pagecache. That
> needs more time to bake.
>

It makes sense to look at it and then decide if it makes sense.

> > > 
> > > page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> > 
> > Do we want to provide kernel level control over allocation of private
> > pages, I assumed that only user space applications? I would assume
> > node affinity would be the way to do so, unless we have multiple
> > 
> 
> alloc_pages_node() is the kernel interface

I was think we wouldn't need explicit flags and that allocations would
happen from user space using __GFP_THISNODE to the node or via a nodemask
based on nodes of interest. Is there a reason to add this flag, a system
might have more than one source of N_MEMORY_PRIVATE?

> 
> > > 
> > > /* Ok but I want to do something useful with it */
> > > static const struct node_private_ops ops = {
> > >         .migrate_to     = my_migrate_to,
> > >         .folio_migrate  = my_folio_migrate,
> > >         .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> > > };
> > > node_private_set_ops(nid, &ops);
> > >
> > 
> > Could you explain this further? Why does OPS_MIGRATION
> > and OPS_MEMPOLICY needs to be set explictly?
> >
> 
> Both of these have been removed from the upcoming version, but in this
> RFC version i was testing OPS_MIGRATION as an explicit flag that meant
> "migrate.c can touch the folios" while OPS_MEMPOLICY meant "mempolicy.c
> can touch the folios".
> 
> As it turns out, OPS_MIGRATION is not a useful filter, as it doesn't
> actually filter anything (anything using OPS_MIGRATION would also need
> its own filter flag, so better to just drop it and do per-server
> opt-ins).
> 

Thanks,
Balbir


