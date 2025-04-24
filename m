Return-Path: <cgroups+bounces-7795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE089A9ACEE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029B6444E9C
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71522E402;
	Thu, 24 Apr 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FhgvXCfQ"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013018.outbound.protection.outlook.com [40.107.44.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598F23024D;
	Thu, 24 Apr 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496627; cv=fail; b=dx19grm3ruXXTFz5akz3SqstrzzrDSPT3Tfr1rVIAo2zsgVBmcS+UST8veiQbVVSOk2zOoNdwmwXWu6qfcnnsgDf86nZfP07suYosGwvgsYdXBjwTzaqN3zFj6LFvNalGWw8TPIw6pO78hcSX9mZOhnm5BnqLYg1hUXQYdSAnIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496627; c=relaxed/simple;
	bh=3+X2Dvn+e07qgn0K8emuxwwAbQF4Ji2Kl9rNAHxyCjk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mMO54xteV6Cvc+bdu6cRfPXOHdSJ3GzBeiIlN0tx7s7LxmIYBkLhYowDMkRFpE/ALPF5TDxdxHbIKUXWNL3j2bz3oX320aw8UDjVzE6ovYd7lMvuTREEo/x3H6V9SdXo5VE6rsRgAH3P8nN15/HiyLH6gc4NlolI1Ne1NfhMvkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FhgvXCfQ; arc=fail smtp.client-ip=40.107.44.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1QgTx1NCVlyR1Nk2XGqlIl+zwdU6BWfTCvMKEoySZW7S504HL4qDi1C2jzdqCpvpAUwewQHzlLmtQxHkJwulmDscMeM+uWCAhefIsiPKxckyuRpe6tswFtob+i/g1ejFSZAdnlRFCZeS+/9LuvGaPq2PealHPNLHdti4jcZTj+I2+dD6nnhKtP73tRPG3C+QpkMTJvsunOl2qkIPkCXkfHCP1OwpJy+8sZGKK0GAi9eDsXmHn7+gcEjvHMcEjOgdGstOOVG1haEzt1ApoET0NZh9WQNKA7k3TGLZnfXhjQaq0owY0MjyO6wm80BKIvNZIMWYu9ak3XeE/9lZEJWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43EBdA/Wg/r1X2G9Vh/IR8J/6j8T6H9iS10HEumv+Dw=;
 b=PZUHlCiek30WOtWBrXsD6GAkrQYaOg7KqMx/AaZ5i+IaG5HDn0RjgxzY5Fha+S3Yf+IZ4ze3vk5iDdxBFY5aRHqw50w4A/sppMia1AE6x1VS3+FzUqON6KWl18WKJ9xXykWCNSwhjiDyJBqb7vJ6ceOoTdtlhj6sGuP14c8el6Hl3FmcrRxLJn1z4Y23vdDwCOStCHOaCaHv1y+wDYgxSmctECVr67fgmk9u59lH4CZ3Ih8GLFDiBAYcbFNh3w7lbyLrcF1xMc5gcPoXLTprRdwB2EirMDO5r7rrur6fGYNOhJ/Ltsos1ssC/H2VyoRthzBAOi1No5IWh94WJQu2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43EBdA/Wg/r1X2G9Vh/IR8J/6j8T6H9iS10HEumv+Dw=;
 b=FhgvXCfQtyOGZg4zBV37Ec7TQVNDaWFEweIDN/Ak6MeIi0CVod6Lta3BEEOceODolGgKvGcRQ7UCi+RxFv/8rl93BX7Ja3DwGZC+LCM0wr7QaQVRbfDN+LHpjE4NGcsnoNC92e7zurVgNy57Y66gXCXchYyrSxliz75BXTIWE2XSyxZP9LJvZzCDkGJEEZD2rgbTPPXuKVXtX83qU/QxYsu+FFhquy4z5mLieiukZV5Qj6TmN+D6IYPsEGsxT7WWN+O3dGLX8S9AS0D4nDxZVyw/eWOZ7N5QI0Pa0nnhdFbxVsmAvUQqBHdRtG/GqJcZC9ZOKdpdCjRFDyOXaiFVjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 12:10:18 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 12:10:17 +0000
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
Subject: [PATCH v2 0/3] Use kmem_cache for memcg alloc
Date: Thu, 24 Apr 2025 20:09:26 +0800
Message-ID: <20250424120937.96164-1-link@vivo.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-Office365-Filtering-Correlation-Id: 8021f9cf-8c55-444b-3417-08dd8328f9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stpIJF7XR91e7LWWe3Qb6GCE71X1TB0z4ZPK4K4a+chp3XkCBlS7GC5hlmyR?=
 =?us-ascii?Q?LcqShDP7yGeBFDQLd1JHGbtGsld0iBmzwN0SJnRVngVCc8lOpgoGnN1zQq7M?=
 =?us-ascii?Q?0GS2dZLn0fd+84FSYp+eX57oaLW0llyNjK3v6zZEW1lAVFMt/IDfdDJoj5Sq?=
 =?us-ascii?Q?EbULcnjHxnVpCJ6uC0W/CnhWdLkWxEVFzmgZcSRcb5b641KFMz8vtqlSpGgg?=
 =?us-ascii?Q?4Y7wEzLKLWkfCGGYlXXYjuFr2mc162ASfj6E2rMqhSRrMLZj6XG4zo0xRnx/?=
 =?us-ascii?Q?EvNoKA3bjlQlOYz84gJVph5O4pLi81L59OU+ORmbu53gwoXNpNiAptpD1XUL?=
 =?us-ascii?Q?anRyEBb0ILeGpk2zRN8MCuLkA7Y3Fo1qtXad92J0Q41i8XS152X6tvRcFkHc?=
 =?us-ascii?Q?R+ek7K5WnIn5Ay2ZoSQgRCf7N9Czz97OljfI/y8evomxd5cTgbehMMG5aMD7?=
 =?us-ascii?Q?7OBPlOHEIuuO7TbS4h9e3O8sSwyCJOde75w/O5DbaKQvRbF/rCxhZIP/idA4?=
 =?us-ascii?Q?4RiZKxY/e6DuSM5dM77JJlVCM7cK07Y4bkMJnhyouEapONRehzs5MMq/kZmK?=
 =?us-ascii?Q?A4UzSB6vdujxZ/+WSgFnFOYgskJImrWAIJkaCANZTO/wvNoGO5+mI9MmqnaT?=
 =?us-ascii?Q?JxiNHYu3pxWhKQqatXJHfv+Y6NZpiNLb6qMie2+BoHOL9Rd9rlogKBXeX14Y?=
 =?us-ascii?Q?0fRrzIqoupIztWStyO+yXD/xpJkN6HRCndGk4YwWtSPshV6veqUWnoNhCVmB?=
 =?us-ascii?Q?W4q2IE6f5e/jRGpJkPbDPxSlPBCVQ+RfheDoPHwE4LGEz8aszA3Kxg12mmOz?=
 =?us-ascii?Q?4fPgHTsTeYas/sWFE8Q6rq/MwJcghn9imPc9P4zC/iZQ2PJ7YR6MCQL33zDA?=
 =?us-ascii?Q?X5Z2MbhsGDIE4bIu1GdQBbZ9oFyAYhDk6Q3kgLxyNW2tUWYs1xvY9sSiHJgm?=
 =?us-ascii?Q?rSb4UMeSAdoD4f5tZF50kUtvvl3fOJLK6QswkQy13ah5Svh5c0lSt3TPIP77?=
 =?us-ascii?Q?uwCNdp5S62fn95dI104BvdHPU7r5cTCfOFG7fjLcfIIJiP1hv0VrfveWi2xW?=
 =?us-ascii?Q?9JY+EDDC7LctRyBSbrvzHQ7Yr+V2D6IHiLi5hZPsheOFHX39cvX1dnUFsyy+?=
 =?us-ascii?Q?VyYHer0WhXMqW0B0KXPxlhk133f5BZNJOD5cbSg2iUw67EcezSB7xbjx9B08?=
 =?us-ascii?Q?wvpripSKooKlo7iQakXUmppIRBC0RLGbDxoXCkDhXpr3Vh66CpSTKoSI+HsB?=
 =?us-ascii?Q?eVjPfk7ij4Ix+wfcS2zRxTfa3fx/Cj3ioeoK4ijlmVpjuCt9dygiM0cq+4eG?=
 =?us-ascii?Q?DEZdjJawGBEodcugvVlVLOnwakzew29fwqk7dB8BXhtyJwtW3+7Od7HTLpt6?=
 =?us-ascii?Q?q5RzkUMazm27+xZZtfXUhaqitKBORdRQ0m6S57gjxsHd2yDv24EqiGgEm6Ia?=
 =?us-ascii?Q?jFd6KlIp8FibOJJoUfWt3GULxnlYBSnvJm31A9AaU2rpQhh25Q0fMe3+IPGl?=
 =?us-ascii?Q?y25k3NtsHgG47O0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ilQTRou6nd3wrZ9zusVR6rnmTiDj+1KOl9Grktfjo1cOALzNyegtfTHCktvc?=
 =?us-ascii?Q?jM7yyYDhR34lU/YIEtEDMVPf6xMq2ANEStX2DEKs5B1krlmrJ3BGPol7cy1i?=
 =?us-ascii?Q?PUUHEzgjEiOmfx6t80nuCwyz8XRM7Am1cqQN/U5ycabz9QBEtSU0dRr95Brp?=
 =?us-ascii?Q?wm5nvMKcMMfacDyVQw5nVQofx6M6oDnWkojFUy+6scbw0JEpXm/Pl8XCWiCj?=
 =?us-ascii?Q?RkoQKwkgbqFDaF78eSEPDK9nlcQuCTPgulNk1LNE9khgPABiVXbb8r91gjtz?=
 =?us-ascii?Q?UCTRkMUiHlWDDygpJxU+PTN9VXdwdnnTJK3uz8L/tHCK/5lO/zGIy6NSDU13?=
 =?us-ascii?Q?jOISBGi14dp4NjXujRBGfpObuAft7AiqkT5L8FufACGTfgPqR3I8eJGD+0il?=
 =?us-ascii?Q?DqHDJOeN3rSyHG0CaMgu2T023giLE1QhvWvTEpotnokKm2wuVVdTovTbo9gP?=
 =?us-ascii?Q?PAyY/RrWI5MiaCnln67aFW0zmGiJ4b+eEa2DOXwk1CN7w4T/fkfP61ZTN/g8?=
 =?us-ascii?Q?Vg5w/ZHTY1+J7UmMgGicVQLNHwYn4N+DSyC4eCQhP5mwC74VnsDw/z1Xuauw?=
 =?us-ascii?Q?z64qeSxNbXcgfQi1WzYrC8zcPl2ok9DmPuuYPQZa7u7/YFQbTPQrBcoMtNMD?=
 =?us-ascii?Q?+0Eu4nHuPkJhN0X4wh7AJR55GzoBceuErQH2WCSZI6Tla3GfV7Kmf4ytmrEF?=
 =?us-ascii?Q?qRLTnvw9Wv1NaiGqU4OMGpWoHBYO830GEhQYPn2xp5uLs8PgKXR3r1pRCG8L?=
 =?us-ascii?Q?c8NDUIvbwZDzrXD7enyoZOB5abRu9CfRoou0nBD32VbIkQPIzFwlparImxDb?=
 =?us-ascii?Q?VuUCVy9o98hYB1VWb4DubTTBgAZT2VHFjNkDwrDU0xDrg/5DhFOMwsuPqJNX?=
 =?us-ascii?Q?ujeSZ9spX2CL9p4pxsov/B5YgccqLgqtzUvIJFau3jsMNgkMJeoEvNKW4U3F?=
 =?us-ascii?Q?F5ZRtX4+4u9Vk8M8xHo2ir27OeXpYw0wH/mi8KDZGbGbVcTneE43Ol9MESOM?=
 =?us-ascii?Q?l41/Ridwpd3oIW7Lm3rVlUDOGPB0VAZVuzNv5mVUe3ZjbsvxxtgIxjInPLjL?=
 =?us-ascii?Q?gfGVBUydkKL1HOk1fhOqptCFjsOJNLxxYEHM05D8JbArGYYtThcJ2qWCcgLq?=
 =?us-ascii?Q?dRiVVKSm/rODSe3BqFc0Gsa0tpeOd1jYZMIXzWroxmy4NYMwTxPvpAqylAvD?=
 =?us-ascii?Q?7FQAIa5JyJUhzYl2wMWtr+W2fTzxyhUD1//q0PjClfZrHs7PTeahf3fmPGPV?=
 =?us-ascii?Q?aelcDMkcylzQGxAOfE98o7f05MzBWVtzBpx3/6bcUZ+4sJ6YjZ3lpVAXuAHl?=
 =?us-ascii?Q?wxjHxfnQsgYicVjYdqauLdbse5WlIHqSly63WXl/0xdFo1seMKmqDkdTFTAZ?=
 =?us-ascii?Q?iIe+fh5B4+u75G0DaRFeZRr+JAcjE6VS1ANBpRJreekn6XTXPW25xy84VWZN?=
 =?us-ascii?Q?p3g1wYxEdqV8YITqV4Zjc3CJncm5zSAdBxn0DrxAStiR5MKvfW9tEfhQ8O8n?=
 =?us-ascii?Q?Lk+05YTHK2LUAAeNSxNh2vxAPMKo7CWtuFPe699xTcfe0f/XU5PlA+O88Zwy?=
 =?us-ascii?Q?FuagRPUvxJNpaNqwFXcAihw8oj52SUnEZjQy8a5Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021f9cf-8c55-444b-3417-08dd8328f9f4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:10:17.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNT2EZF0D0+K8tN0UFrqMyef4qs53MGsYBCmm/FvOCIFMHAiOUQ/l8o5RFaQZiygdpoqPJ6r1kht4P1wecrU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

The mem_cgroup_alloc function creates mem_cgroup struct and it's associated
structures including mem_cgroup_per_node.
Through detailed analysis on our test machine (Arm64, 16GB RAM, 6.6 kernel,
1 NUMA node, memcgv2 with nokmem,nosocket,cgroup_disable=pressure),
we can observe the memory allocation for these structures using the
following shell commands:
  # Enable tracing
  echo 1 > /sys/kernel/tracing/events/kmem/kmalloc/enable
  echo 1 > /sys/kernel/tracing/tracing_on
  cat /sys/kernel/tracing/trace_pipe | grep kmalloc | grep mem_cgroup

  # Trigger allocation if cgroup subtree do not enable memcg
  echo +memory > /sys/fs/cgroup/cgroup.subtree_control

Ftrace Output:
  # mem_cgroup struct allocation
  sh-6312    [000] ..... 58015.698365: kmalloc:
    call_site=mem_cgroup_css_alloc+0xd8/0x5b4
    ptr=000000003e4c3799 bytes_req=2312 bytes_alloc=4096
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false

  # mem_cgroup_per_node allocation
  sh-6312    [000] ..... 58015.698389: kmalloc:
    call_site=mem_cgroup_css_alloc+0x1d8/0x5b4
    ptr=00000000d798700c bytes_req=2896 bytes_alloc=4096
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=0 accounted=false

Key Observations:
  1. Both structures use kmalloc with requested sizes between 2KB-4KB
  2. Allocation alignment forces 4KB slab usage due to pre-defined sizes
     (64B, 128B,..., 2KB, 4KB, 8KB)
  3. Memory waste per memcg instance:
      Base struct: 4096 - 2312 = 1784 bytes
      Per-node struct: 4096 - 2896 = 1200 bytes
      Total waste: 2984 bytes (1-node system)
      NUMA scaling: (1200 + 8) * nr_node_ids bytes
So, it's a little waste.

This patchset introduces dedicated kmem_cache:
  Patch1 - mem_cgroup kmem_cache - memcg_cachep
  Patch2 - mem_cgroup_per_node kmem_cache - memcg_pn_cachep

The benefits of this change can be observed with the following tracing
commands:
  # Enable tracing
  echo 1 > /sys/kernel/tracing/events/kmem/kmem_cache_alloc/enable
  echo 1 > /sys/kernel/tracing/tracing_on
  cat /sys/kernel/tracing/trace_pipe | grep kmem_cache_alloc | grep mem_cgroup
  # In another terminal:
  echo +memory > /sys/fs/cgroup/cgroup.subtree_control


The output might now look like this:

  # mem_cgroup struct allocation
  sh-9827     [000] .....   289.513598: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=00000000695c1806
    bytes_req=2312 bytes_alloc=2368 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false
  # mem_cgroup_per_node allocation
  sh-9827     [000] .....   289.513602: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=000000002989e63a
    bytes_req=2896 bytes_alloc=2944 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false

This indicates that the `mem_cgroup` struct now requests 2312 bytes
and is allocated 2368 bytes, while `mem_cgroup_per_node` requests 2896 bytes
and is allocated 2944 bytes.
The slight increase in allocated size is due to `SLAB_HWCACHE_ALIGN` in the
`kmem_cache`.

Without `SLAB_HWCACHE_ALIGN`, the allocation might appear as:

  # mem_cgroup struct allocation
  sh-9269     [003] .....    80.396366: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=000000005b12b475
    bytes_req=2312 bytes_alloc=2312 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false

  # mem_cgroup_per_node allocation
  sh-9269     [003] .....    80.396411: kmem_cache_alloc:
    call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=00000000f347adc6
    bytes_req=2896 bytes_alloc=2896 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false

While the `bytes_alloc` now matches the `bytes_req`, this patchset defaults
to using `SLAB_HWCACHE_ALIGN` as it is generally considered more beneficial
for performance. Please let me know if there are any issues or if I've
misunderstood anything.

Patch3 - introduce the mem_cgroup_early_init() function to pre-allocate
         essential resources before cgroup_init() create the root_mem_cgroup.
         Currently is create memcg_cachep and memcg_pn_cachep, so keep
         this struct alloc cleanly.

ChangeLog:

 v1 -> v2:
   Patch1-2 simple change commit message.
   Patch3: Add mem_cgroup_init_early to help "memcg" prepare resources
           before cgroup_init().

v1: https://lore.kernel.org/all/20250423084306.65706-1-link@vivo.com/

Huan Yang (3):
  mm/memcg: use kmem_cache when alloc memcg
  mm/memcg: use kmem_cache when alloc memcg pernode info
  mm/memcg: introduce mem_cgroup_early_init

 include/linux/memcontrol.h |  5 +++++
 init/main.c                |  2 ++
 mm/memcontrol.c            | 29 +++++++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)


base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
--
2.48.1


