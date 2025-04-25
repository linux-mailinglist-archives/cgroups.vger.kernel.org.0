Return-Path: <cgroups+bounces-7825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5DA9BD30
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 05:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47604A7929
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35142A96;
	Fri, 25 Apr 2025 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K6O59jvT"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013041.outbound.protection.outlook.com [40.107.44.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226E4C6E;
	Fri, 25 Apr 2025 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551195; cv=fail; b=eLbb8j/I7rkL5lxzVpLhHejnAP0HUdV+MR1cnpT8jJkW0J3OQfJ/bWNxGk53xHIBRZBIq6dQ/VCZuAqTgJnTlFuH7GHQo0/Tge7p9UN95X/2wBUnmtW/iqXjOuuWaYq7iAlvB91apofqgZPG7dPUpbDOvJiSp3rDWa0uDZoJEss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551195; c=relaxed/simple;
	bh=dKNsrXuilq7LjEC8IwZVuncWmXHcZlK2swm6Y2GlY9k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uKX1/VjkRFqNNHgOk+/a8AQyLX524/XPpFXjZ04hvFk0l2ieJbTWo4QCXevcF3NSGQblVOcC42i6slmIvnQd07u4ktxUJVloVF6f72SvTHYKJA0C1nbTEF05RIHtnCuyJgDEY0gxBQ6Sr8rxHVkHNMBypx45dbG0wlHNiZqcrXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K6O59jvT; arc=fail smtp.client-ip=40.107.44.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzU28olKZHHmVkW8vYxmOG0elKR8neIkrbD0mPzWWsSwvcNxloZLqir5pJH/5Ae+XgRwyF/xVr4CwsRricIHt2s9+DBngFDK2hyIlG5T67NTryA9eha82ygK6MQXoPoVydHwgG+BG/8W7jJS1BuZHkBRtKof+N+QuYgJizEGNxIjdddZcQkOJsjkXSoTp+7Yd6MK4ZPvYv/vc4ZyJNvMfMkbAX5x3xrhDMshd/WvCWxSzKd1CM8Olq5O/bLy434noabgVSicQSM37Bb1udqkasHGQyo7+QFRtcjJjxjsMkqhNqPcgMFpi8+4S1AQA1JoQ+LAoAoGv2v350Pyefsdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/zWTx3tMaYxho2wJgGhFeGo/iT1h/wvLOwV4ALqQtE=;
 b=QNw2nlLJKP0lvBQOH5OMiAlkco/4SG9ST2rbyzc/g2IDltPYfKay3yM1XuVy9JkoTkgFxngsM5k5PtB9ND6wDCFrJOPBUNjRPiyJ4hOvd5XEbM4O9YSfsCfRHLxg8Gz8H9lSc8+BcKXUc2bnXYd47kdbyDeI/npQ5b6jRAwtPUJ4iNkLpo2148l5F2olfFv8FxPhFKiPJ74tpHgqqs3V7aovIPLaIETUaUIY+0AcP3BsFcj+PurevmbBONAZCMN5rWHd/7dwiuUzNFmkmpRRcgD4ELJ2c5UDUYwWMog4x7JGN2cyBRhzEjft69RramdQNWxo58nW1kgJ4X3sqhOngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/zWTx3tMaYxho2wJgGhFeGo/iT1h/wvLOwV4ALqQtE=;
 b=K6O59jvTDhb6Hbi8dWFIzi3qB2pr+Zt+cBUNKmehLxbLzGWm3jPuAHm6ThgZhMyWnvu8i87Hpmo1/mRbPxoEqPR2rODpITzGIWzPO3f+z2jf4BY3HGNERWnI8znrG4vkY1sdKxkQn8zzquqEcCHKBA64DOJL98wlX2AWFaPM9pRRw8WZInR/ivTH5C6CCw1d7Z1ygkf/TzENn3blQZ6QrPGOfNIj1UT46hbhd+T4k3usCnDGE2wuK8qS7Tx0p+Ypzta2XiPg+TO5izh34qnSMRzavYGqrTrixIwBlY8Mrxb444MwiQEK37XAjOIdFj6YJfSydZudh8RiXArGQLtSWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6604.apcprd06.prod.outlook.com (2603:1096:990:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Fri, 25 Apr
 2025 03:19:49 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 03:19:48 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Francesco Valla <francesco@valla.it>,
	Raul E Rangel <rrangel@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huan Yang <link@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 0/3] Use kmem_cache for memcg alloc
Date: Fri, 25 Apr 2025 11:19:22 +0800
Message-ID: <20250425031935.76411-1-link@vivo.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3bb28e-8ace-4db2-b373-08dd83a8087b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAPiOvZgvTvW3Y9Qg7NP4LMytVCSIJDEe2Ci8iT8H6E20qOGvSY14bV1msrd?=
 =?us-ascii?Q?z83MYi510TMUgsktjafgbj14NwEwFkEUC7zP9y9TzdV5zTFEE3MwB6c7n9d4?=
 =?us-ascii?Q?rvs/A17CjOO3KUUJyYey33UlUkYwMu7c82BPhbHLmsOgy4Rrc20QYMdiFJa+?=
 =?us-ascii?Q?X/dWuUyJ1cmUG+IozZ8aiYTLrF2I+PgEZ3LU1+ugRYJPliPyVvJ9F81KiokQ?=
 =?us-ascii?Q?oryy0m+PopYO1yjhldtVFH2DHIs9W5Al8LgF8ZFtNP/eofaVAzDnVzzPomxu?=
 =?us-ascii?Q?lJde1yhdaQi4VgGu81eXUXtXFwYGGpFoUTAeFjk8GwUEGM2yD9L2YAGfnY5w?=
 =?us-ascii?Q?2h03zmhssGu67+UnP9FJqOQohTNLSszSC5ytjwaVIq1zMy6hj459EnDfthrH?=
 =?us-ascii?Q?D7H8+rC21qanxdXiNgWIS34wkg107D8KueTqR4EjKDerBu5jqVvkL3eIDYBN?=
 =?us-ascii?Q?FXZXarwCgmqblCtOFgSLYF8y1MROjQYaDxwL4hXku0xMuy0HZl/hq49rcAfb?=
 =?us-ascii?Q?VFpfIFdYrVXSMzCVblxoyFO9e29H2S75IsfVTVT9g6nVWZZw6bAEK3gHKVT3?=
 =?us-ascii?Q?uiqEo0ZrWj6hxuaJzZkZZAisxdi3lD2Kty+E8gY2A42rukRRrHHWGnCHWDZ9?=
 =?us-ascii?Q?RbKntbsml+uR/RRG+HzPbJUlj4LxdOIeDgvYoHc966lbJlLBiN1SGzTJgVYF?=
 =?us-ascii?Q?n3UxPpFllreEXOT0kfOjlpx0D1XEBJ6B7EquhjccxkNIFYLY5qvODa3lBeLt?=
 =?us-ascii?Q?PoNIGeR5sQL155KXNxA5A7UpdQQY6V0LlGPb9sX+20i0tm/7mG/VAnCZmiR6?=
 =?us-ascii?Q?FPwcKPQO/LJSkRB3ePo68hwJE+4W9tJL5CUZqLYgMPYIhhZ/7CKTMhZClXyP?=
 =?us-ascii?Q?8GlKEkHHkAh4ByolVTjh8qHOPjG0Oi3gJn0RDR4uDj0bGps+kDbVaT3bmRYO?=
 =?us-ascii?Q?D0EDufCEvp5pI+01piA5fTg4Ox41DXBUUAroeOwZrLq7a6nluZ5o/rPHgC5o?=
 =?us-ascii?Q?oihs41nTybVe6OerpFEOqnyQoMpzhI3H8TltjFlRxNFUJ6Yd6ALzvyr25Vxq?=
 =?us-ascii?Q?jooHQXKFHZKykFq7tkBhLB0KCw2PpIqWy1zrlgDm6/KbKFDCAioi0lTIrFaW?=
 =?us-ascii?Q?Mslu04DUvahHRCDC6gu93CPYQZCizUFx+xLdvUWkUc5sVHPQzriLeyTs+ngT?=
 =?us-ascii?Q?Mtjg3Tv64/9JwZbaerUzy5JhJERd5SKie8sOAqYj6IY+W2z5a8fzFXEzjnkg?=
 =?us-ascii?Q?qSyYhpkCEwfxkvtApDNVAqEl7Y0qj8m2DjC6cVLiYSvtWLfuXY9BmHyJo+2B?=
 =?us-ascii?Q?+q4tEj4e4ObFS9nUnL+5jZsERTaJ1iIQEWn2IaanqlT9SgPUQhUoWU0isX6X?=
 =?us-ascii?Q?Gh9B5m28ApSdxrjNGq8pHLFfIgvig+4tS4vgR3NjSWhFfMS3UjYmrc94M55o?=
 =?us-ascii?Q?PyKUkya04LaZ9OqhXFNxAUN5nmlt+adBsp3+7pQSqUopxpj4XM3gqX26l9J4?=
 =?us-ascii?Q?1aSuWx9Wx5I2q+unqb/MqASGWmzY+FljTvF0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wjj8bpRqAct367crGvCR840tA3gtLR2OrtX2qPwGbUuutodXW1sJFQhBsPCP?=
 =?us-ascii?Q?AAsUhZ1rHT53sMvkpeP7iitjYdLI72WzuMFev7PvHxs3GYQlWpGeoU+Pgr+d?=
 =?us-ascii?Q?fBAcU5ryumLnUvIgRwmTJ5L98GbJHGw+V9FtL0WsEDUJjJSDWLneYJvKfjc/?=
 =?us-ascii?Q?z62zJ9Vu2K6XCnqF2YQvFrdGu96Yz8oevCEXc7vNtDcap0lT16c3X4QCrfWO?=
 =?us-ascii?Q?b6VUQGubBJ8/MD9h9sqaDmVmcjUrqoCE+AKE8iwvNKdCNHap+MNsWLkLh8zX?=
 =?us-ascii?Q?JUTTQRgymDuodZ1LihCq6mrJYwbtWHoL4AgGUIeyAiNWPbS9GLFphSmqdFEt?=
 =?us-ascii?Q?NviLbpgp7p0y89k6cA1ZdPoyDkw87frxCMoWJXH7mKj8ZYvXR1kabu+W3YdE?=
 =?us-ascii?Q?x9HhEYagOH+uY0VdEa38rhn1R/WG1EbAHdseqE3YHmzlN3WNuSvDjeibeo8X?=
 =?us-ascii?Q?39l+QAocqsxBTkQyU2LHlKq0Hk0WqKsBY9nbZn6ymPR9W08yxvHBSPQ9WVnq?=
 =?us-ascii?Q?AJKzhUbWGQmjidkv8rJD0GgzF+KfnO0qkVZWH3ZGCt5TnRLkOpYwipPOEAO9?=
 =?us-ascii?Q?aCYU7mZzCiHtEPy/oy4/fB9fWxNxX+rRCFJWalPKLBdekMVebEPwFY5cxuLU?=
 =?us-ascii?Q?45jX24feVeLAtLp+iXxEJESIkK73tmVysEO8oJR2GK8+Wd4zr5+BVxdBKD3W?=
 =?us-ascii?Q?tggDoIMoesCOtIdfn9xKL3ApMgqcNMrypeTVayJeFpoTaQG8M02zkC8iVtXM?=
 =?us-ascii?Q?9KYaMfFKLIBpcluriYQxYodzf5dxnaxD4gvB+CEbUKQMjZSVE7GSyO0aEBzD?=
 =?us-ascii?Q?W0DuQ9gxnD4Ajn1748GbP4RqnpNlbGGdwGaXVXb9LiJk/PcJyZMndp/VgXOO?=
 =?us-ascii?Q?ZzYP9cYe/XZ0J3pkoFJKbdkkiSeRrqrvBZffEh4y/EZz5i3R7mt7kvPtz9my?=
 =?us-ascii?Q?Kb5i0qUjd6z77t2fntB4IVIDzjtaVRSUjtSyys/IJMU45smOA5HEvKplH2ep?=
 =?us-ascii?Q?pDJzTsUL97NBP/lolIVuNW2ydjjM8wcNscZsQLtFiNkzr8ZEctdazMNU8lr5?=
 =?us-ascii?Q?4Z4kvcTx6Gv2QADTqdbfLodla04XORfXANg87bdbEBk5vL3Kk0keKnqH+xeb?=
 =?us-ascii?Q?YjNvjIaH7zIhcLB9VojU50zgmYBGzo/c6OPedPlkl1Vs/B3ro6ZJBqmalmLE?=
 =?us-ascii?Q?JNCd8LW6nS0czTRe8IwOXZo0BcG0PgXCry2aUX6du6n/u/VgnORVbkuAwpHM?=
 =?us-ascii?Q?YXurq8ZiRPluT166VAOFMTsR9C+TvGRiGSb3ItCVhxCm+MnVzQBoWhYcdlK6?=
 =?us-ascii?Q?g6P3czIzdXUORviFx4ZGXQ8KlA80j9GRdoBdLtnbU39bvohOkoT1Ul+2GbKf?=
 =?us-ascii?Q?GbNoJwr0fryqk1Urwz8X/PhLtH5oozWX1krjYxNSkbRRL3KObFAlRgR8d8gG?=
 =?us-ascii?Q?Uopus8w96RQbR4IjSq3fQX6hPfI1XnWWSVbxCAJbDf4K7VHJcNTF51DOjAdo?=
 =?us-ascii?Q?xowVx5glXMOc6LCXV6Z+zZoBPb/44HbtbGdHja95DDMTMpddwt7xe6tRqnhe?=
 =?us-ascii?Q?yTJghgfD/f9EdfYcfpE/yi9Cjl82Zx7oX3xkxrBv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3bb28e-8ace-4db2-b373-08dd83a8087b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:19:47.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyv4pZViwv+mm96bOyp5o8buFKlmRNfo3GsWSutGsjSx+qFrdswyFrU7Dl66sJKXYw/6lpol6tgJP0aMYLTgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6604

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
  Patch2 - mem_cgroup kmem_cache - memcg_cachep
  Patch3 - mem_cgroup_per_node kmem_cache - memcg_pn_cachep

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

This patchset also move mem_cgroup_init ahead of cgroup_init() due to
cgroup_init() will allocate root_mem_cgroup, but each initcall invoke after
cgroup_init, so if each kmem_cache do not prepare, we need testing NULL before
use it.

ChangeLog:
 v2 -> v3:
   Move v2 patch3 ahead, reuse and move mem_cgroup_init ahead of cgroup_init.
 v1 -> v2:
   Patch1-2 simple change commit message.
   Patch3: Add mem_cgroup_init_early to help "memcg" prepare resources
           before cgroup_init().

v2: https://lore.kernel.org/all/20250424120937.96164-1-link@vivo.com/
v1: https://lore.kernel.org/all/20250423084306.65706-1-link@vivo.com/


Huan Yang (3):
  mm/memcg: move mem_cgroup_init() ahead of cgroup_init()
  mm/memcg: use kmem_cache when alloc memcg
  mm/memcg: use kmem_cache when alloc memcg pernode info

 include/linux/memcontrol.h |  3 +++
 init/main.c                |  2 ++
 mm/memcontrol.c            | 21 ++++++++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)


base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
--
2.48.1


