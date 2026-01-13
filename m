Return-Path: <cgroups+bounces-13129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9FD16D2B
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A15430B2381
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3507369204;
	Tue, 13 Jan 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITM0xymN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wd/V/wUG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E03368295;
	Tue, 13 Jan 2026 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285197; cv=fail; b=K6f3UKDZHgEOEuV8lgvLaHchxMcJkUsPEJvATmgzxUym6cjYQtPteIM2rQB6dFWOnQkghSMBjtdUoUqD4He5619fiiOM1FNp05XYoUKG1/L+QME+ZKKQe/BJtjx/UQ6cHwJX6uh+9ST4+VPsmj4VsaiZHcSWzq/WaudvvvtOLcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285197; c=relaxed/simple;
	bh=B5J+Kvw3uTSTkX7TBkjveYgVldrv53q2pVKZdKJNZww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuNhuVKIyApw1PFXJCfm4DmrGIfiSeuwqX8C3X6eDaaX9fpeZHuBVNTXao2MEJIMVYmPr97qfXEscW9gjybeR81l0iPgbVeuMCAZ0/FWW2zAUE03PLLIx+rcGAggA0m9sGh1kHeA6M49vqoTYjfgw17+5/tT5wxuW/TrHUye1dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITM0xymN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wd/V/wUG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1hHuT2677746;
	Tue, 13 Jan 2026 06:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VSXF4WY+x3GbPBut42bRuKa7SMEue5CzGxaBtSfEHNo=; b=
	ITM0xymNN5b23hsidvC9Xy3rrw5850fqTZm+9ryQo4MRtcs2oKWZ/KwfcjJJNgdb
	0ne4jDxzZIZQh//rPdeUPceLBIIaXk8M6EYBJmsIe26bpNK7gInnpjPmRlpo8/tn
	IB0EBPcTn3XniZB4z0Anu7Off8Zn7U+IQq54SOH6cStFktLxeFv178e4mQcon2zN
	FZDBw6QYtEABLeemAKqW8eVazaRU2004AQlao5zDL5qGkgt2RnsTxlnwW/Kh0OzI
	t7B5qiWqRLMq0wisQG4Wc1P37NONjLlOyTjT28h5ZykrivvUvwlj93HPccFCsAAJ
	SG5u6zrwFB0jxCo11B/Vdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrgntwc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D41IPR035319;
	Tue, 13 Jan 2026 06:19:21 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78brs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skgM7Limw7yB7nu0+bxV6k9gywSKU/9tBnmfi/ttV5juuvtg/ZOCQksv5YuELiKjdrXBsVRUda6r8ssIgjY8NCrUMJSOLXFIwLTKH/KNNxq42mDWFWlqIknEispgfb/Ft4H8iIRWAHUrQ4qzYgdAFnzl2uvaYTb5ZvKdFavbiLPP/sJEHI7/r6boEIhSoA9UmrQfLbHqM4fiVDNk/ZyV6DHajXZHgZrdKlD1n5vEaTCOe7gcpDZUSVGkWWANesFXzGmpDm0CVthzfrSXGRxNuPnawIHQcC1Gl/zZ5PMSirWyFn6Tuibjxmb6l03me4p8MkliejXOAugDrHmpFIbJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSXF4WY+x3GbPBut42bRuKa7SMEue5CzGxaBtSfEHNo=;
 b=jeccwCZ3sleqs0vyLLvxom2+vrTESJnudh2Z5kyJA6iO7KZCEDL1594xvTAIP/wMYxORngeCnyg9qifp3g3iZ6J8wLh3zNxjtfoRq5nb0Znc/qMcgznMhBGS51kbBKUcsaoAKG1/Oyo/OCHIu9oAsd60rZXyOTJ6cjlWPfLqjut7NycMro65CYKKYzzWxc1TC8BW7hyHrX6rxbjjG6SLBJfGQxj3/bjmtZFWhTOZ0j3gwMe2sVYpcAbOpExDOwsxmI24Vtbubfmg8rqK4VEOJkaQ49yW3ccr/SgOx82sGIEkm3nRw3kGlo2blpMwjLQvCkmIAqLN98cESvh+emtF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSXF4WY+x3GbPBut42bRuKa7SMEue5CzGxaBtSfEHNo=;
 b=Wd/V/wUGv/PwIZ8Uj8RgFBB4+vZcz8pFFdb4M+e26PHI59vLTHBUbEQgJX9kfna9RirUsaw6MEqd24COJT4x3vRb8HhCSJsBQZtY3r2I5zy1jW1p7BkTMMoYSpSgVvtW7K3w0z3G6S/nDpYLgpdtvef65F9f0JasEAxwuXzT9LA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:18 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:18 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V6 7/9] mm/slab: save memory by allocating slabobj_ext array from leftover
Date: Tue, 13 Jan 2026 15:18:43 +0900
Message-ID: <20260113061845.159790-8-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0048.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 68722a1b-a77b-4b6c-3d59-08de526baec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f5iYX0M+Q7q6F28dS8h8NfzKwpi7qUu7TVzy9ihfzUu+FItyJ3tGOVy+Qfyk?=
 =?us-ascii?Q?3PdM3vpU2w6M2z3X5LRgejDqxmyCfqDgkBQwo7S8zvCGxyDfwRrvOqmHdC0F?=
 =?us-ascii?Q?WMhEID/S+i1Tmq00bhVUIxWPFYPoAqBDcEhVgqbfXMoQEwKu1LIkbmzvNFJA?=
 =?us-ascii?Q?4l5pNFPY89PFNuZOHmxog3GrwLeDtoL3SGchaDyNn6fCCQoXlnQo9J6/myKC?=
 =?us-ascii?Q?LWzyvxQN4cjV57SILyKXUZVsUggfnvyNQciO4p1qgN6L1mOZ+dUXLNZp7ucK?=
 =?us-ascii?Q?Pm5OvmPlfv9PaUq3LQ6twB/6I5VcbMbbATnnz3ki7zrE/l1syEhH7WEZoWML?=
 =?us-ascii?Q?ISsZ+HeES33NDhn6sFOWhkFKOtexI4myEjfpCw+PC/1a4FzeQwsCCWedgU33?=
 =?us-ascii?Q?wCeN8gl42maNwgj6Sb1GhGExCjhE1bSsKq2o8CTIwbEIOmD+UdkvEsbIwfPZ?=
 =?us-ascii?Q?PQceXkB2XN/rl3Uvke0SRK7NOpCoTrr/uc68qhhUoVyySn+9iRdaL8972N0Z?=
 =?us-ascii?Q?rLl9yTOZ9QMmgniCeVvncvey9mTbE1e33kNVIsc8WNEMBI+Y3I5N2jctomb9?=
 =?us-ascii?Q?hpYBhSZzoTcv95BiDQJ0hBNfVX3pIdH33mN1fpfDJv/YW6nPIVJq7QlB7dyj?=
 =?us-ascii?Q?DeDYeWzgKEH9nv+I1CFCZrZv/OKOIx6mLa4GIvwPVPfZ0I78ld2dlB8+svpa?=
 =?us-ascii?Q?LqVgekkGODH91gyK+nIsD4NdpgS/sHOM8j9QNKq1jSaxFb2noxDHB5xw5q0f?=
 =?us-ascii?Q?VoY4C1GVmFWiYRYAWDlILQp1RwBrjYgOrUL9tapoLPcml7MTxIG6oigx+n6e?=
 =?us-ascii?Q?l7ZErBPO/PqIs68E23s5OS8Df1CDpJ88uQhFDEmHIdJ0ICC4VJpVohUdVLDY?=
 =?us-ascii?Q?Id4eYd5G82JANO9dlMgFusA6Hi3DW4pPj94/3Xv0zc2+97qA4qxeHsI9S/Qn?=
 =?us-ascii?Q?DPSjn/zdzUxaSkEyBNqTbtp4t7CHu/3rNgiJT4ojkyxbOpWeuaamc3haM2cX?=
 =?us-ascii?Q?jIt/L+YWDSDO9YQe0cBBmn5mHj5cpzFTdOMnA7TtLKu8JGmXa5nrOtE7rOmO?=
 =?us-ascii?Q?+PG4Vx8QKOE5mJKUCYp/+1/FNk+cSPnHus/b5Yw1FtrJErm59/fViODDK2lm?=
 =?us-ascii?Q?kozhtG7HL3YdsViz90A86GX1XhbeVf4e7yi4Fp4YZpCNKQQnnLdLREzQMgCW?=
 =?us-ascii?Q?rc0jzNIqB6YLbS7UsSYpUCA4jeqoBN3598tDYC5arx6uaERHS6qPffFU4OOp?=
 =?us-ascii?Q?JfTiTn4j834TLRKjEqNGUCHQ1AT4dJY2WdDaTiU4iwCc54sHn32Q3dFMgJKO?=
 =?us-ascii?Q?nefqixYhIrSdxUFOVETDoaaQLaYioXpJiFTR3FoFxyLvwMRZVemyaZ2Fbz/X?=
 =?us-ascii?Q?qQmozIMdRnY7bWAAs6wN+DPJ3NtBf3fxXUVvsbiSA189cFggR0WQjScBWKUC?=
 =?us-ascii?Q?lOdsRkwwql67FJcXQ+Kn907WBcMZ3Y57BEiCIyhERhtSRkKvACbsCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLIAX6hPENF8ywjjVXzsLILjoGvEMT15lHh4QfKA+jXkkPFscUaToXfvQGDi?=
 =?us-ascii?Q?LUyd3LrTF2f0dt7+bYM+gjCwTcyu7Xt2ao5bMu4UuA2avJTEoTfTfT5TvNbT?=
 =?us-ascii?Q?8f9fRzXtnkSsm+V57HlJ9wTsy9CfnzWPH/fQ5kfei5S8P4BVxE+/kUKeUGiy?=
 =?us-ascii?Q?n0E/PEW57ov1zmhI6KO0htSwOAmqUqE85IyfIqc9iKCsi4W9lDTfvfgJ2fT1?=
 =?us-ascii?Q?e5PDP90JlgKP8haha3o0NAEIdaoP24ErrL3AenBBj1Z/LwLEITSg1/DSJlQ0?=
 =?us-ascii?Q?EzHnrx3MxYMlwf5UQdg/xrvBzz7XSr3K9srG0kkVafgLX1c8Ko8W04KVOJ8/?=
 =?us-ascii?Q?khaNH6UQQIYloCqwps33sZuWFoTrTIvBNdEMDjMV1A6OMJuFUzwmRSmsR5or?=
 =?us-ascii?Q?0ONib9dormfrPuzuFJ4u+7pG7Q2yoWndGRhUAKrNaNThKxFZqiektCmR/qvF?=
 =?us-ascii?Q?6EeRcPuIjH+U8kYAQ8kQMdeN57aZ3cNwSh45aw0hxFmMWYARsyP4jcnCa0te?=
 =?us-ascii?Q?r/s1X85jDSbjq4BITMVXY0MBzEADqlpehzibUqaksKB3NRoQrhW4txtjBLnJ?=
 =?us-ascii?Q?wCmOwrO3l5RQJUS/C9CpSZx2uGSpwqEhc8ZmOyBXFhMdlZMr/KjF/F/UA7FV?=
 =?us-ascii?Q?/f/Zi3JNlytzy/HZ4eQCjk+KLpQCsvfaq/2I5mDxKeN+dAtKekoRW2x6QDjI?=
 =?us-ascii?Q?o7pgJ1rcSBUt3vXUk/yh5WYGuCAH4KTT2fucXRoctAHUh70iDtjQ5ussvFm5?=
 =?us-ascii?Q?N4E+3SVt7ZIqIURXrbJdtcsRwHQWPJPWz0s2Q2O0oUyqR0CKgc2ZBMzui1Wl?=
 =?us-ascii?Q?82fRM+P2lbrJYlJLSC7xrU+Xte7Jov9qV3VxD7e+gyMjAbK60jioogbdnKH6?=
 =?us-ascii?Q?/m19LNrYaNQ28njwR8WQoZF7JwsXhBbkTQKrk7tdieuBkYSnyxabxO20DtRB?=
 =?us-ascii?Q?HOle/bGeb7CIWqHEkL6+efgNq/wdW2+oxkob+2ReCX+C2V3DrKtgCjsJJkPV?=
 =?us-ascii?Q?tnW/h4p6nFVDZbhOlia/cvuWY/qsztq5GltETtA1G8FY/3BPMz0p0jJ66jd+?=
 =?us-ascii?Q?SdAiZe27OtF0NGTZGBQKEQsr94AgG/JfUIXo62akuCrGinH1L4fWNkJ476VA?=
 =?us-ascii?Q?Ms01LRrgHbl+fvrOj2bdQSG8c0Dnp5dl7TJ18vSbqzsEDgc6iMAH0sB0m7wF?=
 =?us-ascii?Q?cR9pvpq3HyaF+QIuVkBJjIGxBGMDvVDrs3+2nMxKwwi7CCKlordRXU1Yf6KN?=
 =?us-ascii?Q?6MHKM6PSKdv70OA9tFK7D3b8xSbxxn6cfi0kmTBOQDRTbFeyMryuDWIf4FBa?=
 =?us-ascii?Q?477Vl662s8cR6LPqfs8NBTMOE55jOwzz/mJ9a/Wha8OQ/+fVX0eMLAg+gBG9?=
 =?us-ascii?Q?6FukVldn0E8kr90TvUvOM7r1w6zP1mCAem3oKqdXdXAX5XlfqBd4b8ZpNFmm?=
 =?us-ascii?Q?qaHyB94QQEX1YnEMf7hk5IJmFTCij04k6RJXsbJhITki4PnvCfhxuez+5M+3?=
 =?us-ascii?Q?0kwtnwqEaXCg2mmh0nhK1ealJ7dqxcaQWjBu3Z/ICDr2UyZ/AQ0SoWiQrQkM?=
 =?us-ascii?Q?9blA0PebYipn0jRDQ44fjATagM+DytNs0xmbJ7YynW8DlMfe3HRSLqumW+Nw?=
 =?us-ascii?Q?LiwyLQv1DZc1EWDt4RVEO6bvTN9r+1A5yQgQLtyw2upHAgFizprYMbSKj0NL?=
 =?us-ascii?Q?wJl5Q9kMg0q+/f+4KV4wIbbMs0V00LyE1njIZ2ldzwPRnLzeZaxTLn5HF6mY?=
 =?us-ascii?Q?2cdWoS1k8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lyY4oPrEq0nUSVv1Amq2A60xG13p12TFnkO0DMaax8kJXLQalBZE0rP3tIaPwm5Vw66xbt6q48vPaOUAQv9S1267bTGx8zIBAtBKwZ5B+mg3p6WjIH8nr1ryTiTAyY5LkI4uAdyTdfQzi+8PLI1EFcOL0XIFol1kU2hx1Wvy7IiMbL56NKYUsmE8R8Kkd8sGfwi5+Y/2t+SrB1nvW3zGNN3CxEGrHdG2KMjb973TrUjSo8Rk8662D5+9tqa+0hSkrz2o+gox9rWbE8QmWZwqcNg7nhH7gBUH0uqAGVMlODRtInhfbsKpDicj3zkUoZ9LpxfNB+pEGgm06X1Vk9LPrlbwx0RvHW7NTd7krvoCyIlH9r5/2MbPfRpjvrsAFDTd6rnl5fBuYcn52V1rpPnmIDLmYBM0UbTZSQWKY38fqvHmEzPYv6n+tNt8fYO4x8WySBvOZOCMpXU5JIQUxQlOOvnRCr65/EXhEC6g+HdS/I19v4jlGl/8vn1Gjwwjo+Hbfc//PJfY2sB/RJTqB6PhaJFmjIGreXvUyU9NKrUvA/PaP/j1CekNUmvBsZM7kb8HWebJkZujuyT7OV5FRY7fOcJMEQ8v/KTe35ZgL48L2hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68722a1b-a77b-4b6c-3d59-08de526baec6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:18.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCmvYXM7ZM2p4YXRJUi3kat8fktrGLhp/2PPY8DkEPABk0fAqGYEouUji0t3lpODF+Djf/0W01o9N2VuQUmzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130050
X-Authority-Analysis: v=2.4 cv=B/G0EetM c=1 sm=1 tr=0 ts=6965e3e9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ii5H1995EiaHVXO47u0A:9
X-Proofpoint-GUID: YMnwmAHO6ajR62Uj2oHz-PEQ2BX_Ca6t
X-Proofpoint-ORIG-GUID: YMnwmAHO6ajR62Uj2oHz-PEQ2BX_Ca6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfXxHmmbLqZ+EYd
 38XN6FiAIaCWEy2xTXdYNH44nM3C3SL3i2KtkJEggN+RiryDB4WjuXmGT7/jN1T3eFG7PBGqmEL
 DXYCuE9sVOuX6SVM48Rkxx1C5IO7YLtAyLDvKM0VoVgdTqYJcBeFu2H+i/Jit2o3nBCsS3iqhEp
 N0xJh/r269OoKT1zXE/eaxjjHLB+xlyrJdVuB3BFplwuaNYUChYnM1IJc97fO1cRkB9BQHyBnwO
 oB09h3ZBTmpoaXf/6QlClGAgbnPRni0ss6LS8bPPUquu9ltxFFgfmLEo3nLfh2QN5X+gUN6/p05
 BPJsqyTr/au7DmjV27NzH8RI9w1a4IlB9WFWF5MYDWjvpzqXD7hXwMiZsectZtcskpzvKNaqicb
 3oZRoJethxvnXU0hCQkLzledKvU7GTwN6TG4Cbv+EdGdY9kvyrQe2Gof3erlj9RICxoh5lGFf3h
 QLkOYKjyWZ/4R/0fRyg==

The leftover space in a slab is always smaller than s->size, and
kmem caches for large objects that are not power-of-two sizes tend to have
a greater amount of leftover space per slab. In some cases, the leftover
space is larger than the size of the slabobj_ext array for the slab.

An excellent example of such a cache is ext4_inode_cache. On my system,
the object size is 1136, with a preferred order of 3, 28 objects per slab,
and 960 bytes of leftover space per slab.

Since the size of the slabobj_ext array is only 224 bytes (w/o mem
profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
fits within the leftover space.

Allocate the slabobj_exts array from this unused space instead of using
kcalloc() when it is large enough. The array is allocated from unused
space only when creating new slabs, and it doesn't try to utilize unused
space if alloc_slab_obj_exts() is called after slab creation because
implementing lazy allocation involves more expensive synchronization.

The implementation and evaluation of lazy allocation from unused space
is left as future-work. As pointed by Vlastimil Babka [1], it could be
beneficial when a slab cache without SLAB_ACCOUNT can be created, and
some of the allocations from the cache use __GFP_ACCOUNT. For example,
xarray does that.

To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
array only when either of them is enabled on slab allocation.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on ext4):
  Slab:            4747880 kB
  SReclaimable:    4169652 kB
  SUnreclaim:       578228 kB

After patch (creating ~2.64M directories on ext4):
  Slab:            4724020 kB
  SReclaimable:    4169188 kB
  SUnreclaim:       554832 kB (-22.84 MiB)

Enjoy the memory savings!

Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz [1]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 14c58038a37e..e4a4e01de42f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -886,6 +886,97 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned long *)p;
 }
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+
+/*
+ * Check if memory cgroup or memory allocation profiling is enabled.
+ * If enabled, SLUB tries to reduce memory overhead of accounting
+ * slab objects. If neither is enabled when this function is called,
+ * the optimization is simply skipped to avoid affecting caches that do not
+ * need slabobj_ext metadata.
+ *
+ * However, this may disable optimization when memory cgroup or memory
+ * allocation profiling is used, but slabs are created too early
+ * even before those subsystems are initialized.
+ */
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+		return true;
+
+	if (mem_alloc_profiling_enabled())
+		return true;
+
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext) * slab->objects;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	unsigned long objext_offset;
+
+	objext_offset = s->size * slab->objects;
+	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
+	return objext_offset;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
+	unsigned long objext_size = obj_exts_size_in_slab(slab);
+
+	return objext_offset + objext_size <= slab_size(slab);
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	unsigned long obj_exts;
+	unsigned long start;
+	unsigned long end;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return false;
+
+	start = (unsigned long)slab_address(slab);
+	end = start + slab_size(slab);
+	return (obj_exts >= start) && (obj_exts < end);
+}
+#else
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return 0;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	return 0;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	return false;
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SLUB_DEBUG
 
 /*
@@ -1421,7 +1512,15 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	start = slab_address(slab);
 	length = slab_size(slab);
 	end = start + length;
-	remainder = length % s->size;
+
+	if (obj_exts_in_slab(s, slab)) {
+		remainder = length;
+		remainder -= obj_exts_offset_in_slab(s, slab);
+		remainder -= obj_exts_size_in_slab(slab);
+	} else {
+		remainder = length % s->size;
+	}
+
 	if (!remainder)
 		return;
 
@@ -2195,6 +2294,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
+	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+		slab->obj_exts = 0;
+		return;
+	}
+
 	/*
 	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
 	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
@@ -2210,6 +2314,35 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
+/*
+ * Try to allocate slabobj_ext array from unused space.
+ * This function must be called on a freshly allocated slab to prevent
+ * concurrency problems.
+ */
+static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
+{
+	void *addr;
+	unsigned long obj_exts;
+
+	if (!need_slab_obj_exts(s))
+		return;
+
+	if (obj_exts_fit_within_slab_leftover(s, slab)) {
+		addr = slab_address(slab) + obj_exts_offset_in_slab(s, slab);
+		addr = kasan_reset_tag(addr);
+		obj_exts = (unsigned long)addr;
+
+		get_slab_obj_exts(obj_exts);
+		memset(addr, 0, obj_exts_size_in_slab(slab));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	}
+}
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline void init_slab_obj_exts(struct slab *slab)
@@ -2226,6 +2359,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
+static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
+						       struct slab *slab)
+{
+}
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -3222,7 +3360,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
-	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+	if (memcg_kmem_online() &&
+			(s->flags & SLAB_ACCOUNT) &&
+			!slab_obj_exts(slab))
 		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
@@ -3286,9 +3426,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->objects = oo_objects(oo);
 	slab->inuse = 0;
 	slab->frozen = 0;
-	init_slab_obj_exts(slab);
-
-	account_slab(slab, oo_order(oo), s, flags);
 
 	slab->slab_cache = s;
 
@@ -3297,6 +3434,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	start = slab_address(slab);
 
 	setup_slab_debug(s, slab, start);
+	init_slab_obj_exts(slab);
+	/*
+	 * Poison the slab before initializing the slabobj_ext array
+	 * to prevent the array from being overwritten.
+	 */
+	alloc_slab_obj_exts_early(s, slab);
+	account_slab(slab, oo_order(oo), s, flags);
 
 	shuffle = shuffle_freelist(s, slab);
 
-- 
2.43.0


