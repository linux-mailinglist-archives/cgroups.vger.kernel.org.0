Return-Path: <cgroups+bounces-1418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B146185094F
	for <lists+cgroups@lfdr.de>; Sun, 11 Feb 2024 13:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA101F21923
	for <lists+cgroups@lfdr.de>; Sun, 11 Feb 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1D59162;
	Sun, 11 Feb 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="TX5JXrDY"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208B433A3
	for <cgroups@vger.kernel.org>; Sun, 11 Feb 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655784; cv=fail; b=chRPea2wJOlNqZQfXPzzQ4xC9nSr5LTXp6MlTHq+5IDPZ+wp1iksYaFICJ6PIXkkhnEzh2x8NDCriMDszSomcc+DoDa98YTi1/IiIHg/dS2j8xxb6XDPeT//opCg2Xzmg8cA3oNOEQMW+rJe4rfC8jax93V2IjkEU/lE8AZlIeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655784; c=relaxed/simple;
	bh=nXFarkePnBfF/GUGluoKrrOFwLMjnZjFJiEJpGWz2oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnB+kLy5HZhkP4hjupIKKf4bQGLTpxM9Aanu6MXHqfWzR9MMlGcCmp7khoh/PLjSX75y2gerzP5hdZp4OqJAdY+L485ciGTeCYc/aigGUhx8tH09P7WDHmgh96+V9yQBsG3RUaCumMlEqz1jbDzijf3owuIKnCL3rH4JKhAAh0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=TX5JXrDY; arc=fail smtp.client-ip=40.107.220.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOqmPtcg+ITnJvgOekzxJzf4Vvz7Yp9vo/BKVxYWWrAUZK6JB9KOA++Vi0knGz/LGD4wWvaTGt/DU0rt5IvaLW8GMUB0DFH+Wob/UoVh3jfzWhCf9Xi4IkT7TJLTtEpDfJwsS3/h8HbR8SdEu1TIjBnVP3/ubC/LwwuY2TaV2U7THp5OFPQvxEHv8XXIlORia4wM76p3EUHFGQfDvC0GKLuY4ifd2+mNqSjCvhPGwl6ioaCXrkAiejaPWm69/Q1PXBJNBsW1NPSbEsKtqlKw2tSVKC4SVt+fG97b6tifsn+rW/oamZQySS17NqCwwfQzQP0rnn1Ud+RLFo2TQlrXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4leeD0MjVCE2AlIayexQdxE8L44gKgbIx9qsHRVi79s=;
 b=ABi9N4BM7ROO20W/UXNk5QfSvmHuk5JotOCW5yX/O8Ho1sydvABrFeqrhOsU9HGZX1A20JACSEMUOa0XjPXVp7bZ4o5pHCiSsMngVMSB0HBZr2HpqkgEuH06GLLQDHu8R8/04lKO7OEvYhH0nKSZM2r1c9paEEoGI1KTrSkRTmnj46+ouJPcjWZ9tlqB6/UXaMSWz3/hpIXDO3ZLf25cQJLC+nJ2p/ayZJ4MNrzAwTV+glCCwANsyBpjJALB3svSbJTgx79NIkheOuCDeLv9DB8wEhEkujuIb1lF+OT+sKtPGaEQinSE3IR5lJmKfqHB00r3M9NY2xP6DZIyxJdP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4leeD0MjVCE2AlIayexQdxE8L44gKgbIx9qsHRVi79s=;
 b=TX5JXrDYVcFWmG8J40n2bKOcGDcL9ISZxg7/0gkvuZT1+K7d9YrTsfCXY+aE5FRKWDRk/4GT1YDjjJpAYiC747+zkuzlrJJRyfowEvwZ5fe1py660CMAAxlrlTo8ezqvoG85MeRQTGIwb+Mtb8/2a5M8wsz8aQrTHWVDtNIJM1XjhmbSc3hKTHEaB2faxLmIMavlF8ryQCl1pB2fzWHIMFEWVo/+xPn0OcDBSROD/265jZQQqAZdBTu/sjWeHeU1nQW7Y0ASooLPCAQfQ6PqTyZQJDwwxwTtmBSFhOJae9WO6pCxXF2lQZ6M6/4WyQ8fpxZqlBPVE954QCRZWXcn9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sun, 11 Feb
 2024 12:49:39 +0000
Received: from CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3]) by CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3%5]) with mapi id 15.20.7270.033; Sun, 11 Feb 2024
 12:49:38 +0000
Date: Sun, 11 Feb 2024 20:49:32 +0800
From: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org
Subject: [PATCH v2] Port hierarchical_{memory,swap}_limit cgroup1->cgroup2
Message-ID: <ZcjCXH8HJvshxUGb@host1.jankratochvil.net>
References: <ZcY7NmjkJMhGz8fP@host1.jankratochvil.net>
 <284aefe1-fe85-48e9-b0f1-25e28be77198@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284aefe1-fe85-48e9-b0f1-25e28be77198@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: VI1PR06CA0195.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::16) To CH2PR11MB4342.namprd11.prod.outlook.com
 (2603:10b6:610:3b::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: def24952-a927-4272-b251-08dc2affe85e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJJEqKwf2qxLDmtk0IMlAnYLAfogjUIs9OgW1PqZcOzm3OBe5mYzHlcsfqhpD6/+lHQtCaupV1UGayckk48NCEWZL7LdzbgGd6FthOCL6ROQXRKxzulnAejcYBO5qTrRjVZjNiNYk9OrrVhKNaL6h6vvXvSau9SipNOJZilDAR35yd0hXqTfIMiQsYhYAaYu1ve4c0HvJ+5lE0q58crfUTsI0Sa2Hg7VuhhoeKJHqV/Ow8PIMVHK0ckrl53RT2MvrMcPTL7isIvm8aKiVsVjdR/4faj8PbQCwlc6cx7UmcbNjyvc4DofctMUs5NdfTkCzls0Eb0LNno+Dy9CVDMj7+nhcnRUt/7bYrPVtxygSJ0UZZi8DPEnT3SsRCrw4qUcgqjPpkmWxEigDPssOeRcMeFesl+hziO9ZaUGk36wEO/aLTHq+TlnoqZj516OOoCeEt8XaCKBncnwsCRo/Vi88J51Pz3p2+dHavCfh/xG3NB1q6GHS8lICRObRlIzb3NgAk8vVhsx00/0Sdn2RRVocsHp8ouqqayESj62uSJt/VwyIx+xTKSYZVh7oE5eY0dH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4342.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(346002)(396003)(366004)(136003)(186009)(1800799012)(64100799003)(451199024)(86362001)(478600001)(6486002)(6512007)(6506007)(9686003)(83380400001)(41300700001)(66556008)(8936002)(8676002)(6916009)(4326008)(66946007)(316002)(6666004)(5660300002)(38100700002)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9OAfYG/tGOjM/DLMiqgN/3k4Mvumtsc1Fb9CMlt+echrjBLrQ4waB3vCa0w?=
 =?us-ascii?Q?OJJQGRkMi/ZUVvFWZjy8XdCyanteMpye0lvTBkS2QiOJNUe7kRh/UV7v+o0l?=
 =?us-ascii?Q?mKNp3LwDVhP82gnEokLCB75GYrdPl0VlrDGcXruzuXncqTjQXRN6OtIlvuFq?=
 =?us-ascii?Q?QyaU95yYLvyuDHPzLGXFMmQdzcJOwxzmjtC7GP9dM1cxM5k4HDW4sYk6+0xY?=
 =?us-ascii?Q?HnqD8L5x1fGcNbmJAPXnKlmmCtQsakkjmEOfUjdYxJ7GnTDCWmA2DgfC3J+u?=
 =?us-ascii?Q?1VoCOIJWi4y0j6O8pDRMbo4WO7KrwC5EiGqpOD/2J0XNHJMVyW9pcy2M56lB?=
 =?us-ascii?Q?l/kmdCGABal+VjISKJzJNqp/Q9V36La4VuKsAg1Vjzrg4CB+XrzzBsq187Hv?=
 =?us-ascii?Q?GQr4TV+1/928Qk9JEgptO0j9EZHl+32NUjvcNMgXjXBNPfEL2jWFFYStMZTK?=
 =?us-ascii?Q?JSR5PiZqYqjiIMXrVJQtduBjH3N8tCFfVOkNQdCDJOa/tAhROBXiKn78bNWj?=
 =?us-ascii?Q?UCyOa9DBs5exmxBZUmt1cwTpE7XCRS2esN60TNqd+Jk2KsvWIPA12PZ6u0bJ?=
 =?us-ascii?Q?l80dfck0i1G4cQ0NhDkY7CfKlPak9JWGbo0Ss3AteNTGJZo89wx5qluE8G71?=
 =?us-ascii?Q?q52Y7vozsHlngT8WoYihBtjEY/EtL6WOMwp61c2YkP9WGQiAOyJ9ZGguQllJ?=
 =?us-ascii?Q?RZLJJhTJ5sQ/keWIAGWjsO9rufMB/eZtRSPIRggb4z9xJOosJJA/qekiTTpx?=
 =?us-ascii?Q?3Z52RbPlLrxSEV5jtbwWhnK1ujEn/B5vvM3139E0ZZnDuoexjSQAQuNcWQdD?=
 =?us-ascii?Q?Oby9XM3sq+gaVcIld22KOQb6unoZ7bpM7QivlW31t3bqn1FSXsQrJJrbdPYs?=
 =?us-ascii?Q?AYsDXfNzxDIuY9h+F3cEtz4nkHxZtGKvcwUdzmIfQe1jONBU1LZ1udJqtZid?=
 =?us-ascii?Q?m2XP0mPuiemXIVng2Z2EDLrTTNdBhS541JHAzBfmmqPz4RWjFhMtSU43McFQ?=
 =?us-ascii?Q?65ivg0vMOqXG9oDtSR5dGYQR1gKwBRsetHbATDWt8cPPNXC70AQBSu8RcS3u?=
 =?us-ascii?Q?DmwpVGXOD2KGmEFddHl19UFIKvBD1vUrK5pJ1qq68dIhGU35fKouNRos5Lx7?=
 =?us-ascii?Q?88JNW+yh2lr8DWjH/HGMKguduTbP3Ha8l2aqEanq2kBlUo3WojXuZ7ae6RJP?=
 =?us-ascii?Q?8syy5UxxhjIYQea3uWIb8Fi2qcO3DMSCEhe/eEI2LctGLaiaOSUejQodFLmt?=
 =?us-ascii?Q?IgdcrgRVZz8vs6DVnF2julEBP7ES0/E7MkmWG20Em1GAtBCXxlRAqwSuBQOh?=
 =?us-ascii?Q?K8m8B/Rj8xr9cqc1/Y4brDOX6NJnLY/IAKXz8pDWAF5azycN0TxPdmCdhe9A?=
 =?us-ascii?Q?ZcSn0BNrRxf6B9i0g2njHEJr/1rVU/ENTe7M9i2gJMYq9nCj1emodLu5BZHr?=
 =?us-ascii?Q?wpF3cssKIVLwcGftgcSGJRGoyG9IWo1Vnt/4RVzxCuJ/OYYsWkgSrDniwhH4?=
 =?us-ascii?Q?ontOGoEPfs8yE6zXDZegx9irBLYAX+72m5o9AqoLq7tVO5iKAJKzPtG1F9vz?=
 =?us-ascii?Q?QBLor5djbmGW66rzEjgSmt3yCRGMNnFNgEGr9x+3i9w9ERaacSchX4bMtTCy?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def24952-a927-4272-b251-08dc2affe85e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4342.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 12:49:38.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrgl08PgEwpi9zTdMZOncZSCtQEcq6SkgZtGEsW9V29cD/RtPWSEQ7Ons+jE7D1ba3rOKRZ4vDH85C8Owu2fEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714

Hello Waiman,

On Fri, 09 Feb 2024 23:51:54 +0800, Waiman Long wrote:
> I don't think we use mi->memsw in cgroup v2, only memory and swap should
> be used.

you are right, thanks:

struct mem_cgroup {
...
	union {
		struct page_counter swap;       /* v2 only */
		struct page_counter memsw;      /* v1 only */
	};


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

