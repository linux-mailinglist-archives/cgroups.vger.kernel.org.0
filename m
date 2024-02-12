Return-Path: <cgroups+bounces-1420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D62850D1A
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 05:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159471F24665
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E946BF;
	Mon, 12 Feb 2024 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="eRZAwcZV"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2090.outbound.protection.outlook.com [40.107.101.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CC4694;
	Mon, 12 Feb 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707711052; cv=fail; b=dpQ8ylVHEsWogePEOFppzK/tHW1qnWDHrKegB6UO8wN1BuJA5n/dycka9vLIMwysSzxLWK+KyfQHx6hdyji0lP1nK6uCuM3jWTA0N468Y0phHQZKbH4nKCCxQBGbQZ0vbaIrY9NzU0K5zRdRPb6mDGQF9BJSCISGj4YnzJ4n8D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707711052; c=relaxed/simple;
	bh=bYbm8h2MW6G+sqCrOsP+wYdqNAp1NxjMikagV0MMOMw=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=joO+avMZleVYNN61YxTc+l1Yp37ljZZno//czeb674qwmoRm1EEcek9ALIqplohhCLyBNEknzAG0UnOFLGWB9gq1LDjOdHhHUuNGdsLQm4x040J6rwnu9vozIFlqmdw+w3ELFMEBM/24sF0tpdXTEAZzBrxf2m5q0vn4YILddUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=eRZAwcZV; arc=fail smtp.client-ip=40.107.101.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCi+9OQ9C9CncNsKhDXFwx4NlzXCcHyq8QyiHoj7ritm6j9/FzdumR8/01dIiDAsCkHV0v/T7YnoXWkUC3JPRZwlvQCRvP+bFzMFZjQUWF6IZqvl+nfFHY/CNSHmH4rVuLg2Db9nCPvhuM+LBzDT2cjggSaflYEfqSfz6AtxIQ7TSW3DeVK/rT8HyMBiALsncUJAEF7IzvWZdN4brPfs2cpTmW9hPYIKWKQUQcIIaWOcYK5SGnyq2HgByulerRFrwuAHtDbI7BaJEDbYXVHImNVieVdseB6wT4mT6jxH4Hi5ydfdhX49fODStfsrWargRukB43VdyzwyDNlWTSJF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3uBIHwv+BfoHqYFROcBHHrXJVitym7MFHUUjXhjehg=;
 b=SGQJITmA/dRv1OkUDQ6o1jpJAqpnP1Clar8Ls/Bmon5Mul+mejCCXd8n2UTc7s9xQwzjUDLXmIzyrupCosbuJmXZMN3zxbFxqzZeL3refG4FAUaPlXRJWUpjkDb8giR/oPgYzTugGT1eYKT5bTtkfTTZL1sKSfq20Mung7TFElMhuMGjTVQttF4K657GR6Q+P5s5ZHIdYm1nYB+Hp8ApBp4NfgBzt3RpmK1KFzl6n23uHiXCI8ojxO7EEW6BCLmwPLqEbibRKmhHC44u/iD75Ha70M+wP2h4OhKR+leJKJi5BFPP1OseWkpVrb6zd5Hy9tpvQfKajP5p3S2xxwvWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3uBIHwv+BfoHqYFROcBHHrXJVitym7MFHUUjXhjehg=;
 b=eRZAwcZVYLY3u6k01MVW+2STybv0QRyLQPgrXqjZWInUSyP5je23+fzEnuSsj1RRBpvPtYPeEsDuMuvrFxRmMDeXx9bNz4GRUtCPh9AlP7gXoUF7OSn3MX8wzwCjun+slgf0rXXTZhpDK/FesE5j0gZdUOHQtGQzDzAECqP3Mp9KKtLv6FxcHK5vsD2YhnlAjzIGQTliNnoJk6AoKhoQl9Nph69Q+5AWECQ/MTUxl3tb8mBtq+wkuD6GkI8n4UWBBubX/vwrrB+UL6ym/sCj9laXRzzpGjnXPbDwNbzhS7mQr4PGIrXKaB8tqHrL7X4aVO2Ms72XRfZsq40h1e6L9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Mon, 12 Feb
 2024 04:10:44 +0000
Received: from CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3]) by CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3%5]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 04:10:44 +0000
Date: Mon, 12 Feb 2024 12:10:38 +0800
From: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, containers@lists.osdl.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] Port hierarchical_{memory,swap}_limit cgroup1->cgroup2
Message-ID: <ZcmaPqZ9HzoN0GFM@host1.jankratochvil.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: VI1PR10CA0102.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::31) To CH2PR11MB4342.namprd11.prod.outlook.com
 (2603:10b6:610:3b::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_|PH7PR11MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca32c8c-f966-483b-2ab5-08dc2b809534
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kc6ZF9NuOB5szM0OzwTB3mWbd/t9/H9doYRLWLbKIs7O5x7Kfez+o0FSJC//ATpzRJLgoj3H0Dpf1d7TNkk59XS0Q2aHDxsfg+61akMAaoLxL48bh4k080Z8lHYvDsgiTE8b/hJFozlXEZJHyYp9TFXYvJ/esrBZjL0jwEVN2HtuRO2CjrIvhZT2KD9vJ9i2X38syJ4FzulcirBqMw6KB7kuJQo0s7hUIQ3dLJxIgVVM2U8iY0DK1fv0WrnEzIVLHm9fDxDTKJjDGYfXvZzOr+N88gzURkLZrdM5TsighSHDwiLAsKhzWflzivM8aYxVDPQfk21HEUa21+YfwtyUQaUCG15lQjm+WveyR71DBS6Rxp12sB4GO0ePZ0aAnrl+IFAEGVBTZo+MG6ZIRFVZk6nC3gViKlX8A2pwaFwjvGf47a4O4DqFFA+CV+oMJkuvS6AxKJF+TDxAXimDxokk5FkoO1nc+3NR1m3e9aV/Q5/8TUIxZeGZ8G6XrsDq+WesQhi4iinq5bSkYIY5FQyqNRTLbrRREkh7c3aAskTUEOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4342.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39840400004)(346002)(451199024)(1800799012)(64100799003)(186009)(2906002)(8676002)(8936002)(5660300002)(38100700002)(83380400001)(86362001)(6506007)(66946007)(66476007)(6916009)(6666004)(66556008)(316002)(6486002)(478600001)(9686003)(6512007)(966005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0NPgBbkTK4CLtXIZZPaqlk9IhE5++Q0YCmtGlM7iIuOAuIIRniMIPyuvORa?=
 =?us-ascii?Q?iyCdUV2I341rEVWpWELw9vB8MkNfaC2pBDfTUcW17NmMcnlkE2O4k+RlmcOx?=
 =?us-ascii?Q?aSKk4nslfcFc/W2/Z5cZxrErbR93xYTLW80EBJJs9WBTTvdARcAJAtQaP9p2?=
 =?us-ascii?Q?UPn+CMcX6Noy43pE8HtSdlCgGnN4HVPaEr13H43GkKK91z9coOQnGkamande?=
 =?us-ascii?Q?pnv7TuRqy90339Q90euc4LJhyHx+boljvIlO/SN8lZ7OLgHVzSD/8IXhrYFX?=
 =?us-ascii?Q?k1vzqkLXrHG391l+WtmC/hm3JJkeG/84Zbn2SV2qbfdidz1nyX2eFtWJfU91?=
 =?us-ascii?Q?EvcMHAl+T2f1J5FAszUCLqKmwIvM2bKLSI3VA1rKLPZYY++UeTlKkfYLWkAk?=
 =?us-ascii?Q?74gudCMqcoK0CWKcQFXNHmicYRzsFeNd4sucD+FoGJBhrzAYG9M7VhC1uy3o?=
 =?us-ascii?Q?4Fq1OirKv57+mhQdsdxKk+1kgNSOfud5McIrvTHvbEjY7b3lUNwyPwCng1yN?=
 =?us-ascii?Q?f/BzbfxInWo17ZNG9a1r21yfBqvjSwqqmU6YYAz0PKI4aUHjloQ4itUXdHzC?=
 =?us-ascii?Q?KUQm0KCkmbyOG3Pc9ydg81WJQ5YicTivbruhosaP7R+ipD+tV6QHjb3s/qV2?=
 =?us-ascii?Q?HvXsYk3dHsf5dhak0+oYr+NHxGN+MDya4P4asY6Vu+SetDWl0afnoxWsmNh6?=
 =?us-ascii?Q?UMkhH234gcdYj31TJX6XpPkLcW7CXh3Xh/mYWyPizJ8+JVDc8F691yG5kBBx?=
 =?us-ascii?Q?PRoL6OB2dytED51NvOCQl57v84TdoEIy+6ihqb/v+bh3MmNUTr4PAHjPJQmh?=
 =?us-ascii?Q?7fkGPgWPdjeVGAjj/gCbdfnSWovUHyUotpby30t/5CoIgMdskSCBhSHNxEMh?=
 =?us-ascii?Q?NS55XTpcYpnG8HDXisRqIP93hUmbfXFrt4MiKInq+YmWtn5a/awS5Qb3XyXA?=
 =?us-ascii?Q?a56fgudtDKOQdrUHUX8UzmYmwUQ5vim/J2fFyzXNSl1jA03mx2DQ0hBnly9I?=
 =?us-ascii?Q?RPiuY2d/j0SiFgQUfPCR0n5aKs46TLXEdvNdIcyBA7EO9sIHQ1LEg7nNijkZ?=
 =?us-ascii?Q?iMQhiZh9QWgnAXQh4KoAqG0xyOvU8CCi4vxtT2xq1fg82jZbQPHZMSbYiPqu?=
 =?us-ascii?Q?NJ9vcKSj8LgJ6FUSef55akXUWZVQjs3xejeGeNgigNZS83D7n9vxxSbafGCH?=
 =?us-ascii?Q?fCi0UHZ/XUVYLwO5++646LUSESZpETudWvR3pkzbBdg+b2hbQ2lMrxfR+qwb?=
 =?us-ascii?Q?DG5/0xyNF0wCKHsJA9Rq3HfsYiMiqjoaAUWvfxO2yrWLfIKZiTCrV2o9rRWN?=
 =?us-ascii?Q?fDcw8JoKiBgTc+vMeq2KDIWsjV5HReFdu86q20ixmoBrHZ2rWbRFTx2WRvyw?=
 =?us-ascii?Q?Sr0+jNFwiOryuG5Q/ccQsvsiLtw1qCSpJSS9p/IvecYsfZHO5l/urehNWMXM?=
 =?us-ascii?Q?RMUdj8/L+WSF7YaStCcTfLKb3br9EM0LkeSmLKqcnznY9IL722fW0IArXJmH?=
 =?us-ascii?Q?TnEOP4l9fD3utAO58LE1/n1KGq+MtilqxP3RUGo+8QBwmcfim5c10FmirzWu?=
 =?us-ascii?Q?oh+EaMTxFVs59ChvvsfJCxMbCb3umFb8ti1nWYzm0y7wCIOzWs8bXztpI0Bz?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca32c8c-f966-483b-2ab5-08dc2b809534
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4342.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 04:10:44.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6Iid77jxILCwwFEg+YWqNg4e3b5Ev/fvYhk6NwEzML0wLGux5970HdMuTV6+uY6G9v7jHZ9SUzdfhvUzTDhKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859

Hello,

cgroup1 (by function memcg1_stat_format) already contains two lines
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

But for cgroup2 it has been missing so far, this is just a copy-paste of the
cgroup1 code while changing s/memsw/swap/ as that is what cgroup1 vs. cgroup2
tracks. I have added it to the end of "memory.stat" to prevent possible
compatibility problems with existing code parsing that file.


Jan Kratochvil


Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>

 mm/memcontrol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d0211..2631dd810 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1636,6 +1636,8 @@ static inline unsigned long memcg_page_state_local_output(
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
+	unsigned long memory, swap;
+	struct mem_cgroup *mi;
 
 	/*
 	 * Provide statistics on the state of the memory subsystem as
@@ -1682,6 +1684,17 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 
+	/* Hierarchical information */
+	memory = swap = PAGE_COUNTER_MAX;
+	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
+		memory = min(memory, READ_ONCE(mi->memory.max));
+		swap = min(swap, READ_ONCE(mi->swap.max));
+	}
+	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
+		       (u64)memory * PAGE_SIZE);
+	seq_buf_printf(s, "hierarchical_swap_limit %llu\n",
+		       (u64)swap * PAGE_SIZE);
+
 	/* The above should easily fit into one page */
 	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }

