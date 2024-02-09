Return-Path: <cgroups+bounces-1410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2D84F7DE
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 15:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682372817AC
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E645BE4;
	Fri,  9 Feb 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="PtHKj5XR"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2097.outbound.protection.outlook.com [40.107.220.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0A69DEB
	for <cgroups@vger.kernel.org>; Fri,  9 Feb 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490113; cv=fail; b=dEVZgiVQlPxXjEQzR38pVZTQhKB4XY2/wdNrT0GQ0Ey1PlM9wpBYox04z5VHH7EUI7q3dC7H0ikFL2xvtUewyGJ6B1ExVfSswbK3u4nLy7vJVCt+n7wu/Z4TSw0igcEirHSPMvkmvtfsGjHyQV4cOKx36xa9zc/xUY9Am0bWyvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490113; c=relaxed/simple;
	bh=xn7KsuMzaUXBmQVGIwOcOgKyini71hrPnbNmGMd8ous=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=DY0a2nJ+SOFOXyTJrlkXc3QIQwBBYEUXTagSzjqbDVlhTGzxINZwAacKL5J7UTThE6VU1yIkSCmqrkFKPGfyqexCzWTezSyDtV/Afg3KlGwf7oeINeiiG0aEwTVDLd5KAdqnUR299I/zm+MOS4m1dyKPtuu6+CRF7ox3CsVqnxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=PtHKj5XR; arc=fail smtp.client-ip=40.107.220.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYvaWwsy8eFz7oTH59kTQVPa4obiJbeo/N9u0sot4kRTe2Wxkdqn6N608voU6LEX0Dk7tiq9NSeF90J68dr5JacrGkggo+r+AIzxp6WGPj/CRpuXj7ICMccsfYEMAqQV9w8OP4/qhGLwtZmOrlT8SnMJK1ljmHVXKP4r2YPK/HLj6TEXt+PquzsY50GXEXIsrQuaiF4yNqh6DH/cudsvz64ccVS5UKnvYdh43ZouZXVGXZxzESL9zjsUe0bjfnlmjZSLd0JZbHzPS4WJ/vrhF6RrACJtFV3Zf0tDSVQJ7Mm2FyScKkBFSm+l08wa9Mv6NkcOLBc2IMIVn73f+ssxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7tgU8u8u8Jlx0hIn7ShzbUsi95zo0CLfJDTGVJUiEk=;
 b=obwfYCcA4/tvKGC73IdAG4XPuOoNI6dLN1rrjenAP6DwOnHan1hteGhwMYIWr4tvUikmY76bcywE3SgwC6tIqnhyu0iISCi37CW/nR7FI8zoWvr8W5oJLHcl0Rk/WLoPiJmJaSxym7rhbGvfTzQ5RcieKTiGPoFUpUPhF283jMmajFPXT9pTSpwHf2Wfw2q3yw02rKtJGljpauyBFxDocwt3Ebrh1rfycdGXfPyy1ptVEwSXD42Lm2kyrQVIhe5lZob5UYov8DM7LkOLcQp8tht7hI4S5gp8x7KgBcASGy1Kx4mvV1xej69X+HYq7oHZAsVoeuwfZBhUnuKdvIW01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7tgU8u8u8Jlx0hIn7ShzbUsi95zo0CLfJDTGVJUiEk=;
 b=PtHKj5XRwoywrYNDAu9izixX6uNxR7AY3Sl/2xAmzhfhGMT3DANhE0NtEZzsc+GI1hKmT7cEUJBdc7uSAd4eaijWryoP/hh8xXobMKO6pPK9QCGUe+R7z/Nw7PWamDcKVaHHdO2YZ31NBwaQjfcxAI2gfDnSTV0MoCg6oOxT7+6mPU2L3SiCYRPlheUlGHbcgcUxKSe/RtO+A8dzR56RNNRVwh7Jx4xjvjZVaj5vNMZxxA1tGammYXHbQHxIqLsLMtv1ZUHjdS8GrXze/si4BW17jdAzHIoNuDdOcnMQSrInhSu7M2EkShOZoD/ugRn1PRj5HFgZwXnu6FHROZCW7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 14:48:27 +0000
Received: from CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3]) by CH2PR11MB4342.namprd11.prod.outlook.com
 ([fe80::b505:1895:94e1:91c3%5]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 14:48:27 +0000
Date: Fri, 9 Feb 2024 22:48:22 +0800
From: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
To: cgroups@vger.kernel.org
Subject: [PATCH] Port hierarchical_mem{ory,sw}_limit cgroup1->cgroup2
Message-ID: <ZcY7NmjkJMhGz8fP@host1.jankratochvil.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: VI1PR06CA0175.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::32) To CH2PR11MB4342.namprd11.prod.outlook.com
 (2603:10b6:610:3b::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1835cb71-56b7-4486-78d9-08dc297e2cca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	icRjZLcOTaZcVaqlEBxGre/iAjJ/BVqHQVnTJj8eV32huyyn1jvrUtcYrAqDdEwwLD1NMCZGGAd7fRG7QX7XyjK7eZd5ldb+LYBtzlCYPUcJfn5RcRyiLkBVgOq6BBMebIgrKLKPztlH6RxKG1JRab1j09SxYahEa5FK7hkDB9Hc+gBdvPjNh5Uak0q1XJbMfw/pCCTxJGftGs0xgyuPrl5EEeGq4l5Mghkoz0eVKTNzJ8TJqSmVj+tbxsA+ciNK5UrM5j0Lz1vXJ0VRhByoIdlrDYPrrd7jRTsIIbxgK3jMP3KraRc5AK2PQGD1igMYZIs4O3nymrXkkfRhUiOf3B6UonQeoA4mJgGziawU34SKJMZREziGe9j+FYA9mmJeqAnv55ktzYp+NobX/0WoXEH02V9nfiM64cPlT+vAtiObPRzokdofM2Ci1E7vJ9uiM3OCktfvvbBJwE0KzArfSyZ6hNJ4vPeO+WTlhGbPKXIUZvR33pE/m9u/ZggglGanN4kk7gIZCaYOaMuOpFH2//bjXbEeBPAf9/HXBupWB2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4342.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(6916009)(66556008)(66946007)(8936002)(66476007)(8676002)(2906002)(83380400001)(38100700002)(86362001)(6666004)(316002)(478600001)(41300700001)(966005)(6486002)(6506007)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mT17AyP9V8VU2rfBQsnIVbINTAPwyPIIoqrbtywN+7tB6MYCD/duAt4umdwR?=
 =?us-ascii?Q?ECUozq0DwyobPdUj7IFMUnX0oU60oQRsBrRFZ5SF7vPbduFjK5F8suLc+ynE?=
 =?us-ascii?Q?wLz/TvmRk8d9Q/r3UpQuwxctan8qi4sW26mC7hnwct7Yx2qFBMTqFLcMUMMU?=
 =?us-ascii?Q?ncHFWAHQndZ6PuiI9omkeXRJuBRqJ64XTDJsOakgPHKPyQH6a+p//x2Ui2+U?=
 =?us-ascii?Q?WspFleV1MlT1lNIRYgInDZWH7OjJJ+iBHb5AHIxRck3drxouLtr0UV6RACFC?=
 =?us-ascii?Q?rGpZ2+arpR9uuu3B9ZzXRWdLpPK/afHkj0CIFZnRm7t/qhVse+MUt5LCBjxs?=
 =?us-ascii?Q?UfgBkS7X4dYZ9EAXP52GesbygbU5c6w04AtwNn0o7cdwooESSkE3CgMsCbgj?=
 =?us-ascii?Q?FGRGfFUXgEtTYei1PgTAacfoTk+xmbo+PvwlC0cxUxt0CJtE3uRpfHFx8dNM?=
 =?us-ascii?Q?WTIvnaLKJWG3EGe9UVVqAR8nntrhW+70V8FFmUF9YSpEin4yNE2ufhrstmwS?=
 =?us-ascii?Q?Qn3ygnBuSLoGWFZhF9HRFXKJ26u3qPt5peT1JbT06rSweCM9slg/qqzIDphG?=
 =?us-ascii?Q?1920p/qPX1DjmsreLvrrLJJFy2I2MX4VKEghaccyhMvNUzWlS5S7KcB4/YJC?=
 =?us-ascii?Q?0ucY/Gl64Gw1bzd/GCOrBO7fg2KkDrt3o1aJAMwIiM5lAQOqJNAUCsgA5O3I?=
 =?us-ascii?Q?ur7jeuJcXGQfGQL6ndF0dLskFBPGS0JH0TN2Vfvnq54V8sKD/q28GNO6cpu7?=
 =?us-ascii?Q?RmamCFIZL+7RGMLFy2ekvt2FjtJPyiIUxrgIanCkxtJE384tv2wIOfjQ/frw?=
 =?us-ascii?Q?o6cfHvx3xI6BFdLt/7IYgWDqBsmeyuACvA9Mvjg3/+d/AJUFAAbFl4Hs/Bp8?=
 =?us-ascii?Q?Sqpx48wqacuNwEiEtNIu0J1paWOEaQg0MEcdr/nqcvs/8JLDWzi1fDt2HX9C?=
 =?us-ascii?Q?LGsIRP8GRcxJcd4FIaF9gcqQLyWZmR8kMI49hxopsItIUKZOR/U9fDP33rh0?=
 =?us-ascii?Q?HmPxAXpwjrm2HvwQdlgpgBvGVhvso3C8P7uVFY61BHlzKbZxqCBeSqafoY1T?=
 =?us-ascii?Q?XukNSi6qsAmkXj2iNWxX0RR4XoA9sh/qGeLimRe4xWi9/rsa9eCWALEA9PLl?=
 =?us-ascii?Q?J6s73i/+34GbopkGBF+ZaXTgBZKaPkmJ511TecQsUZiOZW+SWV4PHVcps6Xs?=
 =?us-ascii?Q?VjLEjpIkTFctipyLEQNGs6kwUHwY286pWiPgeUtz4QD1+cAkxc6Gp0WS3Veq?=
 =?us-ascii?Q?Jz7XjgRJYHTdUNTiE0KhQHnBL3Kt2VB0CaJoQujFFZOwcy26NePwMSA668lD?=
 =?us-ascii?Q?j2Cl1+IioSv3e1IlhwgBggEqbmHvtzvwmo4l5OrK7dATrTFi9bjUMxszw3Bt?=
 =?us-ascii?Q?LD7HR6OFpb55xm1XgDC/W6hSL0Q+1NnEY28WBkOx3wllibvaOsS2ezslYFg7?=
 =?us-ascii?Q?1u1FWdYTFvyhYKwB11UckIHvy9oKlc54HNXDtC8zkN+2NYZX0LTSLMcVy0Nz?=
 =?us-ascii?Q?TExFWta6R9wl4lnkQvyh0q0JXGZd23ZvIPBHwgBhqAXeK6XK+xIGnfwT3EfD?=
 =?us-ascii?Q?gALw+ND2mi3iuwW76HqB/ztQjYEzDk/R990JjzG9NL1ljxJV2JR37O6y3KAy?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835cb71-56b7-4486-78d9-08dc297e2cca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4342.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 14:48:27.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4k2tWEgvFkEd77+c3gg6ioTzbBun0uOhonFKDz7C/2VWuTJmS88hVsXcM20lxI+Lgkv/N6R1+DBk06vex+n+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748

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
cgroup1 code. I have added it to the end of "memory.stat" to prevent possible
compatibility problems with existing code parsing that file.


Jan Kratochvil


Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>

 mm/memcontrol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d0211..39f2a4a06 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1636,6 +1636,8 @@ static inline unsigned long memcg_page_state_local_output(
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
+	unsigned long memory, memsw;
+	struct mem_cgroup *mi;
 
 	/*
 	 * Provide statistics on the state of the memory subsystem as
@@ -1682,6 +1684,17 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 
+	/* Hierarchical information */
+	memory = memsw = PAGE_COUNTER_MAX;
+	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
+		memory = min(memory, READ_ONCE(mi->memory.max));
+		memsw = min(memsw, READ_ONCE(mi->memsw.max));
+	}
+	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
+		       (u64)memory * PAGE_SIZE);
+	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
+		       (u64)memsw * PAGE_SIZE);
+
 	/* The above should easily fit into one page */
 	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }

