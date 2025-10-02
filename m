Return-Path: <cgroups+bounces-10511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD8BB249F
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 03:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F8325650
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 01:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35139FD9;
	Thu,  2 Oct 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="We76dQCc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jG7ECp4j"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805434BA47;
	Thu,  2 Oct 2025 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369510; cv=fail; b=GMk1eY+8KbexV7FM4zg8BZ57dunnlEqYZTuAKtSY8J7MnP0Ceq+sk1ffa/0xBF2WanNxbGwj5/5Q7/Cm+bjIxb0DogsdeBLRMFuAxaycnnoF/ODW1EpGT3vkNG7qKq4Bhp1TQ1yOx7ow1n5WunYCQ1VtykXFN4UEq6R27buiJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369510; c=relaxed/simple;
	bh=/6CHsl3LX6+GJ2oHvw01iDeepyfur6Ac36qGScu7rfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DRSAPxGqt8Jybxj9UIbGWQnZMS48+VfewOxettXbF380vFsfpSkSzDC+KMuhtv2VnjeSink2huJLODQvGDnz7NiBCzH3AYKx5aoSDtpjFyCqm0C0Lfqcybpu4hdgw4QTME0K2V0SEOI3iG4Sd1/xH1pgspTG4kSXJBMcUDl+HHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=We76dQCc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jG7ECp4j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Lg0wZ016330;
	Thu, 2 Oct 2025 01:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xrYH7X/76kSvy9Beec
	rDyYi2zfK/7H8D5Gl9EDCZ1Co=; b=We76dQCcmjRAoQ0itiH8DHWLxdYR/t/FJM
	/KkTnouexJMsydiBkoZrTHcez/c2mhuotOg1h6iyCPi04GAC7Q3sIGzCTY+XSB4c
	iK1vAGFe/fvqf5C492PeNtY4oPiBh6oLUXKYCW6cAi5kOEBjWRCVw2qLOICX/s+a
	dtKCVf8FIeT4bBJnuDfdIP4b2fTmnbADHo5PDH5Uwacch4oe0RMBnEoo2yHGSR4j
	K4aDIfVgQ43X+L5x4Ecik0nrcsCGaOD13yIwfhQQo5f7vkYVj0wBLFT7P601l/qE
	qxt3RdCmE2qGr5fjZCcfRbgWyF9taOc69rtICvSD9ZH1nL7HDUUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bjkwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 01:44:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5920NOPm012207;
	Thu, 2 Oct 2025 01:44:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c9wmaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 01:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDLppblLkhoVU0p5T3bz7/828DAS/hELAZpgtRm7vpv7FYMVEzCnL3a3A1KNr86AUvBrmFT2M+WPMA0814+VcU/pLwpJySsFqHj/x4y5Hb2rCN13uqqD3dJNTOVI7k2YsihCizkaawS0N+Ak6+pnxleZ8/80kpCkY7zCcDbyCZEbzzX+V9IDki5Z+AI6xmAn8yJmqrJRBm2L64plpF5qBDsGH/ib1LKcpIVuB+dmi7mRxIryJHveUvrwkwaaJrLmEvSXwP+y9r2wKNNzFZPurQd4u2tKz31mVaZKZZp7Kaewnh7jUZgXMfIzYIatOY2aHakk/VagyqRF1E16kJPkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrYH7X/76kSvy9BeecrDyYi2zfK/7H8D5Gl9EDCZ1Co=;
 b=eJm6JEwhh6Ho2neFxbwyW76wOD5863g3TKOwhH3LnUEXT6DS8QzBlMNIzOi9RTUmny7yxG2i6vbfq1YcbqUrCVOMqsLtgdART0umhV64fwrD4c3KiuuqEtKv9loJ7tyAbWCWvIjI4eR/ohLTCmOLhchmNCwQFFVA2oWTXwILa8dBk42vmwFKPSGdzqnEHjyy3MHpYzgDBi+fLNQrjcmr+7KuNAeHNir91CeYyt0eZg1FaGSB0E3SZwjM33XB5G8TMIUD5sreScUOehgi3UnpeTUdGTG6zKCVgxa23/FymkOHwjZDFin9bd068gdV4qR+QI8WvVcZ5k4sBNdn4Zy2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrYH7X/76kSvy9BeecrDyYi2zfK/7H8D5Gl9EDCZ1Co=;
 b=jG7ECp4j1AUF0YFK45KSs1ztDaOOArueIrHhTekNo6usmYKxEjvEFRHHR9QFzhY1qnlH3nkxEmQitkjvOu2uDMLUJfdOWIgHscX520Fr1KeLTDHh3b4pQG0YF3EKvwvHqyP/n8kg7dRfPk/xIiHvOG+Rr1ukknaXVK9e1s/0Lo8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB7831.namprd10.prod.outlook.com (2603:10b6:806:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 01:44:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 01:44:29 +0000
Date: Thu, 2 Oct 2025 10:44:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
Message-ID: <aN3Y8j8yAfO1F5gZ@hyeyoo>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
 <f1aa2ffdb10fb8069ad2a7827c0707e83da5bcaf.1759056506.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1aa2ffdb10fb8069ad2a7827c0707e83da5bcaf.1759056506.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:100:2d::25) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 369a5b53-1889-41df-14d8-08de01553a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHoWHodbaQwd7v7zh3X/yjebgCcdKhJX2U+cZ4a/thtggAGbjYgbXgb29lSG?=
 =?us-ascii?Q?5JMcvLiyNKuO45iE4GuTt9cL8Oz0VFx7HLdGcoOnGCJesiGVFFYfZIqSOj1s?=
 =?us-ascii?Q?PmgveEjAui69ST1x8Xn6M7G7lMxSl7vCeE/Odeb+/9yaIhb4r5JT3PjBa9A1?=
 =?us-ascii?Q?ZKfyxgpTHBakV/GduvqK9kWcsPq/lHRvtudcOHLtsMFTCMmtbzjVh7f6tf4F?=
 =?us-ascii?Q?zjleyMv/EKjFEveVX+wVlcodm1citD4ipDxBGybh1IRzoCrK+QNxfQt4KZc+?=
 =?us-ascii?Q?+/Qp6LDpFFjisFEG4gvtyFZFovyX5J+smJPegXKFgikhElR5MYbyU/5zrxwL?=
 =?us-ascii?Q?tRP8vNezx06cKn6DJFFpB2O1PiSVo50QH7zpRRWrunfuJWWKz/ooZWMjeOm/?=
 =?us-ascii?Q?feGcV9ZDBtrYEuALGJ5Yw3ZHFZ7Df6j5W/eHHDdhe0q0YxzmYwF0ZQlnt5Yt?=
 =?us-ascii?Q?nEDGtxpKE95MgErkqgyQYTH1TUYqSZXUamsbr9cTAhmoS96m5wgmJg3Gpz+h?=
 =?us-ascii?Q?Z5E343yz6vQ6oCLwo/Z6Q4rC5jdBG+qE6csZndB+cAilYfn2fp0oI5tBlsYN?=
 =?us-ascii?Q?9e7MGTvkWoC8e4/AqfzE6/jRZGS74OvuJr7FRwXbp09urDabPhnJ94/Yor2s?=
 =?us-ascii?Q?kWHUppb3spea3jRmtNITGvPvtluuqrb+I574nN4iE0RAMaiIPPA8C0O4fQko?=
 =?us-ascii?Q?47WhvBugS6CEPFedJVEP1AJiXAJZAy9ktWrh29m1IHHKgvXN8iDGTD7G9kZj?=
 =?us-ascii?Q?eLGjILpt5c0lYFH/M/yaEmDaKKfFRYTXzWNv38z1eLL4SXG9R8U17OTEM7lL?=
 =?us-ascii?Q?z1xC0XAvJLnLrorE3H5svHpBdrlVFrCHvVqofzVKVJWFP+lPh9KoWcawSPeC?=
 =?us-ascii?Q?fphvT9RTbPIljHBmIavh4SkdzhLjZzhdl2EnTnRd5q1Gt8PoSpVrwXXdnqGM?=
 =?us-ascii?Q?5VyxuJYHZNFgUcL2EzpWwv938MZFEQso0VrHNKS6998ni+EKKVjW0dA6q/e5?=
 =?us-ascii?Q?bOIdbQZx59m2JkzxTg720z3eDw4eO+O7EPu+WvpRs/Sb0/WmarQO8oyr+l0p?=
 =?us-ascii?Q?cJ2fNA+n7VQS3h2OsiHbaJ+upRs6dBcrmPKmCJ9Snna8+GbmrTVwWulu3xor?=
 =?us-ascii?Q?yWfL2+E9exxX1hzWhMZkUTVdAqFxYqwe6OBfH0XvqcvL+5S/vpQZcI9i/HpA?=
 =?us-ascii?Q?8d3a+HEBD2N3vlAnbxdLSAPg4G3R7y7HkqXtpURTJ90vHWUAhi6Fb299DtgJ?=
 =?us-ascii?Q?gyrsJy6CGulr0oXcd9uLDkdq/0ZsOlodRbu0O/N6aBDaJMPokKZYQUU2IdOc?=
 =?us-ascii?Q?fDblnfHl9+d2Nt4hBrK1sEo7NuJnBY6iKHOjE6FExhim93VXYPjZrdnjkmmD?=
 =?us-ascii?Q?0/FIvX2RiNQi8gZssidrJn85b+hq8cQfjQNniNfCTiUupA0E88mW8YJbhpQF?=
 =?us-ascii?Q?ebFduWoqH3YEHoyiTyy/O/agw9UVGTEo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4lHmXk8LZ4EQcY1+uMZfXm1JzbOysYTpSt7Rcg1KNrAUtR+qyYGmoxBX1qy?=
 =?us-ascii?Q?U1aGeeB3wGDGPSf0iMSUkRPGxrOt7COQpMFJIpZwRTvG8i6WGKrV+cIFAE/D?=
 =?us-ascii?Q?9j9Z2TAW2rhdY4MrAUkGFvh++emH3czyXpPzJlaqHSEYEyQ6hRWhKLkon9vU?=
 =?us-ascii?Q?MtbvP7MFBPL+7e0ACqutnNnpXu1/z4vEhJxL+dhHKtLmWU/EZIxMk6CEbtUm?=
 =?us-ascii?Q?32anXd8NYVXdBOa92jLvd1sQYiy2x/iwhy7pQzEsdznedVmUh2WITD65ctN+?=
 =?us-ascii?Q?VHC9Uz6b8ndhZBFIlCjLlA0wLtx2c5YPuo12MFTe7zIsS4KrQByYpmRhKjxf?=
 =?us-ascii?Q?HgI6v9i0UI1Olb5o1qXdujwsj+DGfaVxDxTIO2SyUSF5T92waG9SB3B982tT?=
 =?us-ascii?Q?CunhUYHNCOzmrh6PkMjBD/W9soPX/xxCIWuC5Lgr1Nk2oWabQQa1E66sBQ4o?=
 =?us-ascii?Q?/WJMZuVvyEPpCu0Gzv6IWurBFoMkgiDH3R1P/O8FFznfiDg/jLvsctZvYAcu?=
 =?us-ascii?Q?P7J65ZND++m88Xiz53YM8uzocGiFihYosOMy6Wfn9O1lPrpRn9JNJ0z0BEMd?=
 =?us-ascii?Q?PD6r7cpAhVK/C/adUoNMCanszmWd/EYbtAGYqqUnINGFe6naoCNXz9PZTnYe?=
 =?us-ascii?Q?OWdTWOg5nbNOUovsH5JS43IOEXmCDtLUd6lyi/gNv3xgqANmHm+5+JGrYfDh?=
 =?us-ascii?Q?fDdRxziYk6el421DNfbKDF54+LeJn9oRGScOHMAdnpg8muneuDWAuGECKtoY?=
 =?us-ascii?Q?RLxAzOmmgiaLCMomeeSkzOMiFFT5RhR0GHEf12H3m+MUbR+mcJCIAecLgl1n?=
 =?us-ascii?Q?be2yaUSmTw+C8Rb8556zTAeXZ2is5g8gwxePiesD4NhKXDgbfPFtY7fZGQ8b?=
 =?us-ascii?Q?njgEiZ+ItZ645od9DURmAzDSm5db2P5YTc9sEGsNlwVlZ8tRz+B5Vmh7dPWp?=
 =?us-ascii?Q?7/CJp5hJfi9zmNlWA0rwR+vgZesyatPqM5iAonAqQrd+MlQrqFSaf8uzrbK3?=
 =?us-ascii?Q?WF+PV/0jGkmqLYbggbFeJfV39DrsrkamOxs060tD1RYIhi3mjN7thvEDGTft?=
 =?us-ascii?Q?njErFQn1Npkp292c+A8sHwrAa3bgnsxcHXbnfVFxxSpF2pglHSrcJ+wDZDwg?=
 =?us-ascii?Q?2UfcYPi2NLi3duB+Wpui/LNT86XHaO2Xo+mx8lwGFKNYedZLZyPlst/vKZYq?=
 =?us-ascii?Q?6Qo7LSbWQL4ni8N/57APapOfjjJWxVrZSg9fjixuHLZOUgkl3iEkKBTBFdZu?=
 =?us-ascii?Q?8bj1Hv8KTPbaglgFVjyhJ8LpH+AxmR0Zkwr/nX7oUfBCUN6zYNRs68jbiO1H?=
 =?us-ascii?Q?s7PelGx5D6F7fbDuAjTpPkv9M4htPcKhIDEKdDWRJFjz0bJPrpyb+MwoXRHi?=
 =?us-ascii?Q?BFQvgLaqxHnFbTi/uHO2pxQAz/orHXDNrj72cdNtPf/J0M+iqJKr7fxdWpHT?=
 =?us-ascii?Q?HQ4iF3lxfC11A1ULnW8uBe8/9kNsKu68Kp9JgVcI6WaXIy/KFFJLoL+IQWSv?=
 =?us-ascii?Q?A6sfVk4RCVK4YFXkUByHF9i8MkplNcsVFBXakfylTro7cP0j5Mci8szaM967?=
 =?us-ascii?Q?EGtcchm5NzZhb8UcIqJWypeCp94SDSCGLJb2cjL1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6XfYGAJxOtfGDPUtBLggzcJRj3hwqkQygM6zd0uyF3Z6tVw09tTljZwYcLv9F5dOyzKGVJqFcv0N2sSwP9BuaOdRyToYhzrmNvYBEsA+JYnrzlPjTLM62ZqADQT5PWaVVTEwPhjPjsPx3Nqf1SzW5vfqQOikb1dL3WeryPXYG5RQzgzPXGJiLOU2jOPjlfomyRlGazJH4/xIdf9omWiMfeLcng55RnklwI/ZtC2nvOzr+zMFvJLJPeNmHPH9NC3Q6icuhpjNcgsSLhXdAvnQ5GLZr6HhjPrQutJUqucHTI5hOKDQNJrDl6Q+umDtbbj5uKP8jAzEDnCX+WM5AL+v1xUH0F24JjsL4BF0fZdymZ63k+pkb1E+Wdi7Dq0sVetMF3rop5glRJPBWcm9X8+846IZRvEyT73GuXfjDU80dlDQj1sBYv6I12t86rWrqkQHXNTc3kmU0vFYdNTi+y8A7z+3BMVTHeVdhk4pMbmlUy89mnHW61+lryCqss/NF7nM/qxAJRN8WJJeUE2xevdUWJmahx0cKTtfSDuVpHG+K1ODAh/37N+EVeIgreIeE4aWme2scshm1LcugVsDlFWxFPnID0EpFugQXasMo65iPx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369a5b53-1889-41df-14d8-08de01553a3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 01:44:29.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QITKUFPBdm6HzWIDUH+kY0+rAYPc6Q3iFQ23LeSmaSNpBH2XPOdRa5e7CJ2hXzTQ7QE1B8tCrS8i5PH0kcpaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020013
X-Proofpoint-GUID: 2n0hsAP9h24iDfM9E7UlRJOt0z2UH2xk
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68ddd902 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8
 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=xKkjNArHlgNR859EpXQA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:12090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX4ywbOzd9do3/
 sGP+/pX/SEvU1e5dT328CO+pqbop7cWZSf9mTbCOWA9OVBLPknUSlQT27SIeTIbPPtso643Tg8K
 QumjCCmKqrRofV94Z2yYwRQiLcL2NpoklJ3Ti9K+P00BscXwpUXXSAlOj5J3bb8JZBtEjGfqZmh
 aO/n3eWBYZLG4UlcyQOBo6beW4Rnn7sYsjX0A8m5PTfYUpilYf6C5INbqKBtlWixwpsGVy87VnU
 JkKT7pQKbBykPWRmvHul9TOupXAdATPwNFspYetb1qGMc30l/zGSwCaNC5mW17Hv4qaxZEnFjIE
 R5X0nYdnrMlRwUspGulKiYfQ2OV6azOhgfgcmAr7eir42rduGP0x8Q8QL8zG/2cdEoRU7u07+Mg
 GKzjLmrbzV2If3bTkMxxJi1EdM/Gk/wg4K0g2J76X0G+H6UgyAQ=
X-Proofpoint-ORIG-GUID: 2n0hsAP9h24iDfM9E7UlRJOt0z2UH2xk

On Sun, Sep 28, 2025 at 07:17:00PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In future memcg removal, the binding between a folio and a memcg may
> change, making the split lock within the memcg unstable when held.
> 
> A new approach is required to reparent the split queue to its parent. This
> patch starts introducing a unified way to acquire the split lock for
> future work.
> 
> It's a code-only refactoring with no functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

