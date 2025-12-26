Return-Path: <cgroups+bounces-12748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E155CDEA3D
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 12:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFBE3009AA8
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DF287518;
	Fri, 26 Dec 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNM5AeqL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lLgYeuFj"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3A31AAB1;
	Fri, 26 Dec 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766748320; cv=fail; b=YffpN6noAmY+BNnGrywKMYKjMjxLKndX7e0R03tUVKc0oNOEvPiUlz4kE89fO20vDWJ63rojoOMpTgMjEH3tCeLWRbSp3+yMdeHlc0iT6vJr/piEw15D/Fm9uuta6JRawuPR1N3SQjd5ZAxWD4l+jrrVHXRRhRjKmwUNmc0w1u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766748320; c=relaxed/simple;
	bh=clHL8VaJFdgZjENAeF/7dJ6Et6s+mdJcBioUFmD7h7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pyaQeGTereZ2a3HmKgBy2469zgfsUZthNZBypOtTdGgD37Jkis1BGri8E7qu8WaY9Atdd4z+YxADzeoHEzH7fYVKswVbQ4sPVAW0UNmZoEmiFBiPs4qK7m3G+Rs/EDn1p3rqhukjUmdalGqhFGYaPDkTQ0JxiWNvOyiG07b/SjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNM5AeqL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lLgYeuFj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQ5qGY12951826;
	Fri, 26 Dec 2025 11:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EEOrdefnD5PWE26Jy8
	XFFnbngTIOYnsDsD7M4pjcH8I=; b=cNM5AeqLfVibMzsNkjW/LljpWRZUEuwCQA
	YZ7shxu2g9pXtvd5s4J6T2g/KLw5XQ0TyQHhvk35G13lES2E0eWqqGyjKazPtj1m
	6GO9957Fh574G7MVHiX4cBFnnRYH67kOZXlbuvj9VBJzHUcEg9udxtMD8oGx2YZM
	zBuKG2fmgrzzfPQAk5FdpG6bTvHdJs3zkDb5P31Uw4d9rJjK4mN1HLnLlipU1i7G
	z28VLtkcLXQiTQmpZQ9G/xmwJ9YQp0u+HDUaT51cMyLYqgAOyLeuTTP5+Nd3YyTy
	iEGFaxjDJI3qjNZt8JJjCG56StIdjXTCYEzD48GJg7+lnER4TlrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b8u408v7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 11:24:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQB29I7001865;
	Fri, 26 Dec 2025 11:24:29 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8anpbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 11:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyjVjB5FQj83/AAn7DQm4lFEG7vwa5gJeRvE4TCJfNlAn+Vca+2ZldaGXstOHZj6ACn8aLKw381AIZ7M2tdsHZQyDaiBrhcgf5kru5pU/rDNq6SZ1AZOQ3peH7UYy5/x79uR+woEaWzJmi0PkRIxfmhY5Tjo9JC6dZChQVW24g8RZsJl1Iw8zBb03Lx31OAFQAUoyr5qmYruh8vNHhDKSu13aA7kRNDKvxmWcAWXU9PTvFgzYtEhvzW/p3j6gXK9Q21J+RAKPijnz1Bs7jrkltsIysIwiey+UlBdjh9dg8SSK28k2SFu4uEBqjYzTX71Obfyoiv0NoLdh9yO8I9AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEOrdefnD5PWE26Jy8XFFnbngTIOYnsDsD7M4pjcH8I=;
 b=kEDy5ahaf2+XkGDD+QkZugXYd/yQsm44Z5/v5E0zoeZIz+mFP4NlgO6pZMtjn7tkIr2ioGV6fcpQlxNBWU2d1bV68nZnr1qv7YMAm0hDCzBJzSF0Fx3cJpJKBplAoi2o01qL950KvenvjxrQ6Ps0IwaCTCPqWoezpq+JOuF30OiINMqBsWq0GgLKv71eUA70DMweMQS0pAlZscnqEm47OG7no6h5JCsSRdA61GmnbKzzbm2RgYBEplaR2gY5AWqzd55xEwRN93t4D0RXmxGhqfQtMm9K0ZqWCzoXxXS72ivsCjHB60MHMfv9mmUF25d2iQW19JvjkS+qCreeJ3VJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEOrdefnD5PWE26Jy8XFFnbngTIOYnsDsD7M4pjcH8I=;
 b=lLgYeuFjWTN5n2WgIB198XuF5qb4NWWJXWudapQk4dSVB7konAvcvJ2QXVmXomAMkcfXfPRAKjpHKJW3hSugqfOh3UUZZlxpc37V+20R43iwwdYJ2rmSev17JSzR0SmLikvqIDccvEMMyP2j9mQSDZ0DvhGhQfJUnz/8v+4fqSE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Fri, 26 Dec
 2025 11:24:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 11:24:25 +0000
Date: Fri, 26 Dec 2025 20:24:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        chenridong@huaweicloud.com, mkoutny@suse.com,
        akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
        apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aU5wYLrE2S1B9y_M@hyeyoo>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <aUunxoFxrx5hiIPy@hyeyoo>
 <23f6bad90dd7eb98a7fef00736b4aff21bbcad4d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f6bad90dd7eb98a7fef00736b4aff21bbcad4d@linux.dev>
X-ClientProxiedBy: SEWP216CA0044.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e509ee-b7ba-4253-76dc-08de44715311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9RocZre6PiB3sh64tY1BaK5mdEZhow7lmUpSTyz6pIpHL+gFfYkO18888pY?=
 =?us-ascii?Q?TaujqqyYRsn5pI7c49HzGv1Edg1m3JFYU2a65CJD7815nkw8NE4c9KsZf6wW?=
 =?us-ascii?Q?nGqV5MW6bypOHTfuL+kuidQ7m85hguCRt4YBJa1LMiospX6t6qU2jotr1UTw?=
 =?us-ascii?Q?Qprdw2wICvm32ahhvRHVaS/AclQML4RBKeZzH9HCM0KOJ15xhw93fpyoz0w9?=
 =?us-ascii?Q?eusOWx3ijESSrwiaNkmXBuNRuBTa1wuqhRFtS1eMp9xrwAH3iL024D8jf/De?=
 =?us-ascii?Q?JTkQ3fQz3fKuakWZWEvBKv+kOjQV7E1S0qvqbrEpMrDnyh7YSllCyBdNTVWh?=
 =?us-ascii?Q?HcmR5RJJAVHzrjHpxPEGGeRtE6uWyLkrNebKobqarGGO/FOrmmCIwxDNc9RH?=
 =?us-ascii?Q?i/Lq0dttK73AKn5s5xGJ3OtP9rj82Okjd2WHoq2Ed5s9CxHtB8h253c1B4/P?=
 =?us-ascii?Q?hKUAeKT6SNlnX/6lp3MuGjHe8Q7cuY4ZiTtEo3PJy81RZoOrwXNcTU6z6GKZ?=
 =?us-ascii?Q?e4oDk4uQ5yKVXS2g99sWWx/7+vzKVopESSdoNr1QAZlkSpd78ZZyOGJ0STqF?=
 =?us-ascii?Q?rdHf4Mfa6/Bw+3/kbTIAtHdLatvTGVs/SR3YRYW7Cqc+8BB5lOt4keeb4CEL?=
 =?us-ascii?Q?0vrnPGdYO69LNL2ZueGgjgPJzakXPQiCOGunCPv1tdnBfXJYLd72BnXGIWia?=
 =?us-ascii?Q?UU901mumpZqyqYs2IEYMsLe04ybqy6r9HshwBMr0gvrW1c/GD6P1YEHKyaPI?=
 =?us-ascii?Q?SAcSCe/x4jkBU5jmi326pZiGRpmGt8rGnmw+01LL5JrIyjCFacvPZ7qBlFvh?=
 =?us-ascii?Q?7et1aW2abmdhvmBhDUbc3BqdfoH/zZH0yW0pEhGd8OKgOd1DT5PFeujI2s7B?=
 =?us-ascii?Q?AfxzbM7SqGWjT7C9gGlHgdDA9myAaJkAKHe4mmseq9UwPSe+MUyoK7IgMisy?=
 =?us-ascii?Q?2CcsECWAifJB73d75iPiMVRUcy7RZ7rbm1cIPNmGAYl68zPsDNmnpg1zYn/X?=
 =?us-ascii?Q?I9/yUiyDn9K45jdXsiGES5j5gi4CxzhHgtkYtlPiJJu+JtcuPRxP/MyaFUCK?=
 =?us-ascii?Q?JiM3Cbg/PxkIZzhX69uCBV+Las9W6AAtPwgk3SRFlhcrgI1Z0kFD+l8Q4EHy?=
 =?us-ascii?Q?lezwsA+YQ50Z1o0cZgPG+ZJdYg26HyVwkWIMPndePEU/lTsVUP+CimqN7amI?=
 =?us-ascii?Q?nkGOCpPwHpXk6tJa8gGDh9CRe0PEFEgoOYjBosuiKgdiGkqaLpb1/WbCXu/U?=
 =?us-ascii?Q?5hofujP+vkyloz9yhiYGKv6QFztW/mLk1kBHz5Y2L2cbOC3vKv75JtyKcuqg?=
 =?us-ascii?Q?b/bke/wvFadrlVhFAEozUju7KKwbQD5UthiQA+cK/iz2VpZmMjto2QHWFYXm?=
 =?us-ascii?Q?HZO3oIW0comEwDzRijwb1Z4d3AR0U14hIs6N7HKSLIm6eEzXBgiYcRIFK3Np?=
 =?us-ascii?Q?kRe+NGB3ForBXxXRIJC6jw/ourBXIC3T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtWqR+9q1KRPd85ZKJBPlmSxhsyxEoU2NOiZgzjuHfwKO52rrtLWXkgQYEwf?=
 =?us-ascii?Q?k+LFyj7wRUE8Oyet5XrpaDe2y0MJNA5gB+3ulSADJpO3t/3N+KH8nYsQBJpP?=
 =?us-ascii?Q?+ROW4NJgYY2sHfC96Rl3SmgPgGYIPLiSEE/uuYtuQQva0mUSdyx6Q8eLOmb5?=
 =?us-ascii?Q?57+3djm5IYaEAWZtUBxlg3KSUOqhaXboPKQjUutgpnIQK0XUw6db6qVGT8X4?=
 =?us-ascii?Q?ipmIO7/XuGjDxuUnJNq4RGXcA6I8mRSx3FHIa8PZVnJJkWO59mawgupH0KJ5?=
 =?us-ascii?Q?HYZq9HFOCqHvqlddk1Ko0RCIdQe8vboW5byDI6wasrgZBXagGxzPVtVYsuj4?=
 =?us-ascii?Q?R4ISNLRuaaJPBEwFBb8rZb4RhuMkX74JlJwg645AU8awyHpo63jDgQ+Q8jUx?=
 =?us-ascii?Q?4P6uGQuH92Jth7rFTR37ZBClGyk8sE5FQifNlI7U2MJLX14cDOLKPfNTBhE4?=
 =?us-ascii?Q?Wvq4BUne8FSuwpq21/HyfwgVTn/HI454duehWrye2CeM33KRI9jkl446bnRC?=
 =?us-ascii?Q?/B9DOQkLaGkVJyu90SWz+FYQy5ycHDgeA8lV5ckftnxk7/gkwrtT1ggwiiVI?=
 =?us-ascii?Q?L+YNll4MMDmwFcnzSDVIO8yQkf9GGjiywDf0ODQBpf/lmopBC1VBOiOdDpAW?=
 =?us-ascii?Q?eNgQyquCWAqEwekrRVetWKL2TjJXNPVjLnyqWbHW/b8Vp//nxbGp5TTCN9xZ?=
 =?us-ascii?Q?Jf9x/tBYIEYS8FsnqZ660XMbAmuIKn7ua9E/FoSl1amNEXTBsYEnmOCabcVN?=
 =?us-ascii?Q?eI/UeqvSksUkENkcqVZTpBBnC9wzKsYle2KWuDnU0uTXhpoLsW9FVVh5zjUX?=
 =?us-ascii?Q?Scgi1utVgVpghr2VWRTMHm0rWsn2IKVr1/d3i602C0jsluDH4sKxrTx4I0tl?=
 =?us-ascii?Q?ibRPeDhgaz+qi+xwEyi8qsz8MURTg7PLn84QLap+D+pNAv7iYaL8+1eE2nWf?=
 =?us-ascii?Q?e3VCFNrd51yqjCjkBEycrvD/TMDUwijhWPqUdCVMkDpCSKRCD87eh7KzffTx?=
 =?us-ascii?Q?cN44qys9q9syOpX9RyA1tW5R9CEJ0MrL6T9BBA8Dxlnmf044GboJFGS5zSx8?=
 =?us-ascii?Q?dV7RD18zCLxfbgz2XOtXz4RAVLMcK12snjrbLWR/MQLhYD9Ru///rNnYyrox?=
 =?us-ascii?Q?qytHADV3OnlUlHOaGLuwwY1yweHtkenipLZPE4KmMWZeUgtNZSnYi3PVREvh?=
 =?us-ascii?Q?fo00ijIXk0yr8u0p3EmJQah8xR8lEC8Nc5mnk6SqwXWLGHLnq7Ust6jX81ro?=
 =?us-ascii?Q?ih9Po5BwnUkw+v2EqX5zczJdKJ7Gt91stb7EgVTH3Gln0WwG0lSrJTcB8CG6?=
 =?us-ascii?Q?loqGhz8VD9rsyFzt7lecRGSx6NkswmvyExz7njC/BWXXfXf1inXUUiMV7z4g?=
 =?us-ascii?Q?Elsc1f01aXvp51S0x2Qh6isE0cSI6ybIdBDBFe+QNqcmyNn8e1sNZFZNILtF?=
 =?us-ascii?Q?e1ce0kKzTwPP0GkHSyPnKadSI4M929FybZ6IrA8K+vVsR2QPwzXE66p1Kao/?=
 =?us-ascii?Q?esHCUmQfW5iVqhmnMZCDv7RcK6N/ANoYfJFaVaZ3l4WzVOvuu0qEVA/CjTAS?=
 =?us-ascii?Q?CiNmluBlzjtBt8AXAoEEYaPT8w3e8gO53W9VN6ErTTmMTmUuDvrZYafm0Z0P?=
 =?us-ascii?Q?XxOSqrjBlMWwd9APSpHphVBfNFwS1fZzue/UVClrPwmOVI025kg3FM8LN3qQ?=
 =?us-ascii?Q?7YOTO0Nj8iChyqbYjkuy3SLkcP4yArOOMc7Hl/5E/ApiXbYJjKSir5p+hvnR?=
 =?us-ascii?Q?kSgALKMS6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uW+xin6c8kmcvrkVl0MctDVt2NQm0A0Kps5HzcXLdJK0djX+POICvqWclbrUC8qmY8Qu6lVc++SHP2mbmGC69DB3oUAKgJHUp86t+zzr7kBECS3rGWCHXNZeBpb6q1ppy2lniSbkS5SbjSqcnmcX4w5kb/9TDAYaE5eoqG3iey/kr8M72gjpOT5ya3poKmyKrbAZew+zicTmWYjIqx4llijEWkw5u3tNENIjJVkoDL4CL3QlNe8qUUuU23qYvF9a3yRr9pEvcNxTvuogzm5zPMKJ1Tbmm4BxI1t6quanlQJkd8kmj17vnurKo0hUZHQePYGTKMJEjCfERLyl6loOlxl62UCYXkRK1x2mJOApXHWidwH1sKb2jAfqTcYoJs/2qF7iA5UqGw/TvUAU1uvUSSugkV8qHw38yIp/E7F9Pwum9eHDn3NDQncSJUaTQdr3ywpMLyve63YGXFPUdyHXVRdWxD5DiSsycQywhfm6mk/+Yp05UWaMBX6du6Iy3BsJXT45v2YHH+4w/HoFC9dFd+RaEtqsTtSZ/hO1q9cVjNtfxLRlFaeFkNKplqqvVgNCQglDbGZ3h5prPutu5eCiCCxbQ/0kA9yltdQEalXbhZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e509ee-b7ba-4253-76dc-08de44715311
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 11:24:25.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4scRQ0aQ9dfA06h7SAQpVXeuOoDo5ihT2WiAGo/IggF/2WgUpTqkjHe6SamImAP0hpnjiUAAiRIu4rBQUUMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_03,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512260106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDEwNiBTYWx0ZWRfX03rq9KFi44VX
 WD4VA7/+8doKtUTgTRekwdf2+gvHTEwpDsF4wZb+4dQTP0iODs/Wi3klhIeYRkafXZGKe8rpa8+
 qDTkLkFeoZ9f3j4XaK3s/MsjRnpuwZfjpIEQuS/flbIISqXnelAjz3dkYSkDYWD+Q8RyKK6+OSu
 R69JlXSEJ1TnYAO7J4NNgsnRRzDnOkyaU//F2VM7lzJNMa5R7ppiMO1wN3ckOu4b8TkwlGjgeG/
 j9xuxx9vlfTN8uufiKB/H4Ju97Z838SojcFOavpoAfKw3zAOsehSZpag97oPykwWZJw3G/B+sBg
 TtGWs9vLLs8KixbISIXVrEtEJXmyFSCZip7fSimcF0VhpGo3aqnZFsYenIR+FAk6QUmhcSatg43
 SuaZzLvC7cNGnKB24f7f2NHkn5LBMEW+wiuppLAeiVhGFcQrS2dyk6JiKgZ/ygQHBxu4gHZF4KP
 o37yZT/LKbvd3Vom7yw==
X-Authority-Analysis: v=2.4 cv=JJk2csKb c=1 sm=1 tr=0 ts=694e706d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pacgBuMZb9ZTfUoTjBwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: VtGkTESlbB-i_6edWu7FntlrLzZvlg8L
X-Proofpoint-GUID: VtGkTESlbB-i_6edWu7FntlrLzZvlg8L

On Wed, Dec 24, 2025 at 02:51:12PM +0000, Yosry Ahmed wrote:
> December 24, 2025 at 12:43 AM, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> 
> 
> > 
> > On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
> > 
> > > 
> > > I think there might be a problem with non-hierarchical stats on cgroup
> > >  v1, I brought it up previously [*]. I am not sure if this was addressed
> > >  but I couldn't immediately find anything.
> > > 
> > Hi, Yosry. Thanks for bringing this up!
> > 
> > > 
> > > In short, if memory is charged to a dying cgroup at the time of
> > >  reparenting, when the memory gets uncharged the stats updates will occur
> > >  at the parent. This will update both hierarchical and non-hierarchical
> > >  stats of the parent, which would corrupt the parent's non-hierarchical
> > >  stats (because those counters were never incremented when the memory was
> > >  charged).
> > > 
> > Hmm, I wonder if this only applies to LRU pages.
> > 
> > In theory we should have this problem for NR_SLAB{UN,}RECLAIMABLE_B
> > because we already reparent objcgs, or am I missing something?
> 
> We do, but we don't expose these stats in cgroup v1, and we don't expose non-hierarchical stats in cgroup v2.

Oops, right.
I was missing that. Thanks!

-- 
Cheers,
Harry / Hyeonggon

