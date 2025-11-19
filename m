Return-Path: <cgroups+bounces-12083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA23C6D5DD
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95C404FCC8E
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DC31ED9C;
	Wed, 19 Nov 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mu1v/rCB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z4VjKpiz"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829131984D;
	Wed, 19 Nov 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539864; cv=fail; b=i3BCGtSrAdavHUsVsZ0QBU53UClRujqHi5lDU0kafCIS3aEnBo7SYjbmYJSa93+Ev3xF+VlmPM7GdnzNq6stULZe67nhr2kMZUMOanPGrAkNokFehIFrxQQzVQ46SKh+WHI5c3bjRDrQ7pCuXmD8n1ZlUEgvCvb6ak4d3TJvUrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539864; c=relaxed/simple;
	bh=edlqiLa4feKqOaeza3LGGH5kcoo3k0WC/mmeSgNDcEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYSb0JvLENnu92L3jIr+HgIA89Bs3NPVRkSewa0PJsIZ10TajIb0uQJj57WQ7dcoTSCR1/xlf1VJxZr8xC2LOq9li3puCHmkVVlEPmPAp8RiBzmuDkztLe3aNAXZeVdjWKCDjt5qfTKtIkU3EkJSnnKGS9RMaGz/bkRatbIxYTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mu1v/rCB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z4VjKpiz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7uedx010097;
	Wed, 19 Nov 2025 08:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=U1oTTdlzx81UKGuGGE
	m+ccXfHH1zikjERxvjSHHotBA=; b=mu1v/rCBSrcffI+c4V78JjuZdjszVgp7ca
	fMsQ1L57QSFDMnZl5VWUGraVslZbSYM3D2qmolR2zREKqaIfyZcBbj4e5NtimtaK
	C3aZYpl4RlkiAhrc2AD/r+hfoUA7S8IAKh0EP0ND5euKM6E/AlA9aaBEFnTG0Iav
	uasZ4Ttpe+CXxYdT/0crImbGn2HvO9IOYzMVsjsYj8OeJVqTCT/PcILnR34nTKTd
	/oc7Ztqm3TXc98JUhTScGgHq06M5AmRWMEYIxTKt2owZ+9toExRscopzwJwhJYcl
	kCgAZkkHiVbAXlAP96KBVWN1RFXUkBaG4tNT833m4/uSLMa/C2cQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpxgwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:10:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ5u36d009671;
	Wed, 19 Nov 2025 08:10:27 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyeac8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv2Cmbkx+XMwQvyXHOr+jLCz9wTgs81V0vUpveWlBg4JMpBgcTu9cCBLx30eLZfCidwI+0pknRlL6bCJYLtNMBIJC5YfTqrNNFnw10T0Gw3v4XZ6vEyKt6KwT3PwFzzN6INxoAYulap1TX75xTm4Av+H1t14FO+2J6BiZ9tJ/OM2CA7gUifGwYEUqHEcii+WdXL8a+ham+9O/i6C5k9HR5DGjVVfBlDstmVckjHu5QQoWaayE2jmlp9+i5Bo8E2fOP575la9ypDCcw832Y5h+qdVIY3lce3NTcW0cMuA2gSxkPTyKgUGmknkQ+d8MlADl85zGkMCpvWFR3oFWfoVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1oTTdlzx81UKGuGGEm+ccXfHH1zikjERxvjSHHotBA=;
 b=Fczokl39aeB7nXW2T/2p2Bhys7Spedv/czmDnsC8n/jE0acaOfLVglLbsxdNFbUhToW7UJaf60Kb0WXGVnsHPkAhZxLJNJguf5yHIqRe4wYJJezkzmgdGYqN9Sk22nQInWJXFDp3lTurKXCafXcVGEpL0Zrpk8Z9YXp+N121PUxHGuAZ4VJ0eN6U9xIZ8wb5tlbhi+/TstDopxPgeCoH6x9ibxGDMxPb7bNsJd088rDa4a1g5xfYob9w6q9J2OFtCPj8hiz7krFAFHE+95i7W9rEnPdXiLwxYwpZYcSDcOfJdG2sx42YTDz209ieWWIrYrFNI4EZmSLxdN9bxyQA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1oTTdlzx81UKGuGGEm+ccXfHH1zikjERxvjSHHotBA=;
 b=Z4VjKpizbCWF7QqG3wKvS3BDE7VtDd6N09eyNuCuUQcSIFGpW0WTDG6GH0ARwNAl8w0vNO0e8+L4nh9avocYO++m7b6ZNm+U7gu2EKrCA/Uzq/lDo7g/AWgNcCJB2+hv/wr8WrN/kh/kiYlNeyguce8m9rTzTFxkIt8zSxRu5rE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 19 Nov
 2025 08:10:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 08:10:22 +0000
Date: Wed, 19 Nov 2025 17:10:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 08/26] buffer: prevent memory cgroup release in
 folio_alloc_buffers()
Message-ID: <aR17Zlqcs7YjUWle@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <f62ef59c751a710b0e1adff07876c02942664a7b.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62ef59c751a710b0e1adff07876c02942664a7b.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: ed210f00-f8c8-4367-5a44-08de27431657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BWnS/Ixvvg7svrYsVfFYYbCJiXHxplElR2DnZWWFS78OY9H0oR0ahsuNkqc?=
 =?us-ascii?Q?YTe8mterIyhfwTs7h1i/vgW2Z8wlfLh3keDt7pk7HP6MKlnNY0tnFIuOW1av?=
 =?us-ascii?Q?gbwhiiiCrbRThmRZdxKl+gn7lwC6icb7YIvgDQ3iQ4/AtqlWwS12ZQCWxocY?=
 =?us-ascii?Q?8PzAhBZRsMcax2Pq1KeraUdeyzUvpF8oqZRFgKGT3iCeRkkXrwh7+9UlB7nb?=
 =?us-ascii?Q?1iM5f1OTVVRq7yhwCctR89/6BVU5VdcVLQMwAWSi7RhB6vV7e+sZqSj06imD?=
 =?us-ascii?Q?Lni/0kqLN/4wdH6L43s0lyXGzBItkACgKXXzHRq4+hCjnCdyyqKGf6njFbrb?=
 =?us-ascii?Q?Wkr2Dl/QBkUEvs9O5aMJpE21P0LsYMLqZV0Dnhpn9CASCLQd2FKF+S2IxK3m?=
 =?us-ascii?Q?MYfRxjIcBJqcc5d9Gpax8lZySuNkqa5ZU0kartVsbEbtldNXGWYbmWdAK48s?=
 =?us-ascii?Q?O/7A2mAk5R17aDESS7FNOPAkyMPXycbuMgf8Z78IkgBETgWJ8W/qE5FqZ8ou?=
 =?us-ascii?Q?sdZineXas7kiP4s9KagHHhyVNnBGxq9hnUgRWxWd0pNJ5J6pP4BWTkw8iy0I?=
 =?us-ascii?Q?2Nz+KeAk/NgB9r0V692OeNAIGFV0Zj3SrZKaZp7l14nT7l7k3/OVW/2cZNjj?=
 =?us-ascii?Q?2mizYnM3t8Th5pDOrZxTBTZJPcDByY9PL/t7ulNklK0Ne7SnL8D3HXQbiCNB?=
 =?us-ascii?Q?iYbDr0pGCowKTFmM/saGtcLcyMykCg8PsounjDOdow0BpYpIy3xA5PNXahMx?=
 =?us-ascii?Q?iDUghSNde6ibdPMoC1bOpWpsI28ZEtaNWFjH0zcRHSyTr0R5hxRWASF02ygM?=
 =?us-ascii?Q?oiah6dHC2n3CUtLuP7U0+/jjO9MNqxwv/z4cNj7wvD2wEHeFlVk/4v06EnTS?=
 =?us-ascii?Q?OwOM/rcUZXCQ1o6mGZSwYKSH4c+i1bTCCgtGRm/JhRID7FP8XwvFhCOAdZ66?=
 =?us-ascii?Q?p8SHWaMnOiPnuabJgj3ew9/FnutHjRv63lDSFaIc5kguCm6mRDBaszQXLQLe?=
 =?us-ascii?Q?j4wDavt9DzTnHvc1EwBJAgqsTK/H04LN/dli6WL+dEvN7y30i9Jii73mohXH?=
 =?us-ascii?Q?PQE6/g5w+sB7odkz8gcpGsVmqODqKhicVpSSWu+Nes89YmcCtN7CGxfw/hma?=
 =?us-ascii?Q?NSDMJ32Ws9MMYk/fRZd5FSA0gAdUwkiDef83B+vvIQel6YUPiC8oxXx1MeFU?=
 =?us-ascii?Q?4Lg2ilb+oQMqiOCSZ1hhV1CCybzeaz7Aa3LKOehqBUrnXysdbaALGxhHRZOd?=
 =?us-ascii?Q?PdVm2G9QHdOphmkJKDUvYV+8wAFKYA+uVzcxm1AhQltMpGLM7iaZkXGx4Crk?=
 =?us-ascii?Q?upF18ufIpusYW79qg0tbtTuHA+BHk5xEu6Bo4PhUcB1AVw+Hs3WkwhyzeMwb?=
 =?us-ascii?Q?palrzP2mqmnshrLtW+vNdRIpkDh2c3KQRLFZOi8yB8jQHiivzktM+6ENydru?=
 =?us-ascii?Q?GhtekRhlfN83mJxjmyLgIa98YtFIgcJ9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJhxkSUD4T1hsVGPgTI3gdsXD67Rbz/Msl+Y+6Gq/WRxoW+FB4vhfgW+khK9?=
 =?us-ascii?Q?37KQzTPqyS2LJIfW9Tev98/7FlOeRV5iTymDCHqVXbWBcEn/6U8jFu7HREH4?=
 =?us-ascii?Q?kkNBud8MHZylYKytlgLs3Uw4gi3rWGx3j9v2s5DzgsCgcWzWJiGGpii3yz4i?=
 =?us-ascii?Q?qqL58IOqV7kXutI8BMNMkAYGxcPrBeG3GJsp24P5MOC+cxx851KbOniKKgtR?=
 =?us-ascii?Q?xHWoKrg6TftDMThXuO0IrNri9pP5yg8nZdc3oTkJGzeG3F/kx/YHxFoRg3jp?=
 =?us-ascii?Q?RYwu01I6KpHFIg2jz4PzDtARyNuYU2N4cUGTNWRbHGmwCSjqHK9+PCTsURjU?=
 =?us-ascii?Q?II66nPDc0sFTn7UCRznEQMxZCQcv8tjn9x+/2IYGJVyYaPL75i29KpFWVvTs?=
 =?us-ascii?Q?SZwlxjwUmzajM/k868HxO+SG+8kNuIDaJZpN3cXvfyaj9RKfSVyi5+JUaFs3?=
 =?us-ascii?Q?koqUdjOL0cKQ9s3WKBQw20qkZMeQ+oLmN+duvIHBo065eLecDyn2/oqDxZ0W?=
 =?us-ascii?Q?DvEjGgWfZ3hYb/ER3irc2jHWtdDm5jVP5yssaME5SaSEfKVj+ZeOSOI/gsQh?=
 =?us-ascii?Q?yOhFd0610ZZbRSDRIWX6NsTcFBC8VKvf+Q8I5AslwU4dxxHF60B8H33/SD23?=
 =?us-ascii?Q?6xOoe0l/mGcGP7QZRMQyAnGSEtKV7g0ZK+S+316FgxTGoQ5IRWi15zdkCepZ?=
 =?us-ascii?Q?HTeF0H6Uj05NFL+9Q9EZTfGXqGon7VTCnC/jJBP+bVYH1PxV06FfR6qH0aRz?=
 =?us-ascii?Q?6goE18k+Ny1zaSIyAyp9LDIM+kEfgAQ2a/U2zhKYvBb1zPQJIoJJ0eeBFpT3?=
 =?us-ascii?Q?Ir0jTvJBcziJ8J4dpxvt2TjbhsZkI9QNqAgcRl0s+tKOzIeIcN7p2k7o9xJe?=
 =?us-ascii?Q?eTuyNGfiTlMTyT/W/QDsaUvJtjEANBoXxQ4FjBkXgUhThwms2o7zH2ZcxjtE?=
 =?us-ascii?Q?rb1aBJnoqVAYJSnDFo4zG8W/nLzl/eFVlBYM3hNQomXC2KUCH82RfyeU0/bk?=
 =?us-ascii?Q?/BjKquVy8VTM1FpFm/2gtZsCtx9NffknhAwwe/mo29PtiI7WC2b6pziano0Q?=
 =?us-ascii?Q?psiAgooxjD3e4v7U1OPDaeZFmNugxYx6TPoFJNmod4nsQujmS+1JGcH+ZM/w?=
 =?us-ascii?Q?cCZRrBghS3QDFTUG3QhvN6uHRmJALWeR5aJYRs7HONctEzCy3V5nPc3CSJ76?=
 =?us-ascii?Q?IQvixYm9XdWcIDBIIJMUxPffUxQVwgC++12gMd6PrEkuQLyRu7OT6DrsX6mZ?=
 =?us-ascii?Q?Taft3bdiMz+fTGAGODOWdPBFM8z/r96PGey7iC8uvATx0qQW8cvyQ+5kCxly?=
 =?us-ascii?Q?5I5PlfF1JpL30isYBas7Uce7E6SUOp6tcLoVn0NN7aFyu1ku3oVe1JLiNDti?=
 =?us-ascii?Q?cymb8l7FEqNIZUeuzy5fFagNwBaFbq8s2INeLmPQWkL0k41OKl6RQfoMM6hV?=
 =?us-ascii?Q?wkHOYpKmWB6kuboK4kDEWo0kJqQ34ALE5LY9Wd8s0kLn9FhEA4Ey/EaBsdRV?=
 =?us-ascii?Q?5tKaItKMqifYcSd73tYDiR5iZBDb0zhBXVjGwDJ7itAaMYgKy/iufh4nMoNO?=
 =?us-ascii?Q?z9GeQVveALE5rZcyy7eEUp8JfNqV3QkR0HLf6bs7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F0Lx4ATS+HU0/T4U91aGXJONWrYOk23/PuKJVrY3Irb7YmCgHWW3a9XbMd6/iGD2XnEyJQj02ztgHLX1eeToUJwwL3PiN0KCLg960+QJqXUWjXrdtl2LT/dMyUH7xdFYcqljNYRoYbYb0aqrTWgLTDccJreEvF9AqxLt8Kl3gACWFgJ8DT8XKI4k3MZ1Mf9GT8IcNMHFUau3HfpqSgiPpQfQVzEPj6lBwXTOQrnQRjTg+cUtqZlQFEAEpzPK6sy6XZ1S+TVBsh1L7Eiv1ykk45A04FWTW9p91hs57BWDz9Jjsf2hQJILjW01RJ+9Q7Gf61YSJ/PW/bhEHlQEueNZCDGlOcl/HB+uYZsHj+iV4IpyA0Vw3rQX1wZd2JPvrVReQkf7Ga8pyeGOJKjqEzwrGiLfgS3NV8vL30risQgSOlob2DWu1dIG6vYhD9WswCuafR9/o6xk/b4biIigVuvp3LuweVRs7YDAne6bL1HBWHMcXCci6meCdCJT6wtRRJeqb778JsHWy43s7xL1nVT1vzEWEHXm1UETPhiip+SCGPO93+irz06Ik8DpVOEOMRv88BHHJ4torRLOJuBLSXHdistQmiG3MzCOiuMPARURIj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed210f00-f8c8-4367-5a44-08de27431657
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:10:22.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o97qXW94RKBYsc9yrPxBuXdiax5ipiqCzu5sqmJxmccEWZEjPdJkwF0PnGbWKwFYJ0m9f2snUtOciMrLbWg5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=880 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/Qm/pIR6GjKy
 uryO3T4uH1bvDV3fgyvGaICtjJRQ+1AZZeKZ8q2rhuRS5vyl7RA40phJofaIXef4hRwKHYWA/jr
 UWJpgVXDpNarxh1JPX8SuCTbKJXk5gahV/YWVJrvDRTnQ6lMH0Qalf4w0PLUnoEgh1u+yS094RF
 pNvIURccwSdMtj+tRLux+ZTz21pEy8twMSoBuXDMHI9r6t40d/DnxFXidnD1NujuDadiA2RdgQC
 sSlV///XeDYpQC5CWoLXt93ppurSquB6GolEUfZSBG5hFtpwa3I/bwTaeTjPtVmarx4cBmd0aet
 PNNOVmpNBOhuKvinjGqKT9giKHfuqHKshbShX49nWm9KuGd9hwlBbA0NKKfMNcrwGBp3HNuIgfp
 mWEegkfzqg44osiY748xyk/75A5sWbZU0pYxuYGcgzEUaNqYLJk=
X-Proofpoint-ORIG-GUID: 4UHoVp_dbbaEyL4WKchv0x4SBQ8YQKtl
X-Proofpoint-GUID: 4UHoVp_dbbaEyL4WKchv0x4SBQ8YQKtl
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691d7b74 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=PmEukNHKjE6N8xRxkosA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 cc=ntf awl=host:13643

On Tue, Oct 28, 2025 at 09:58:21PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the function get_mem_cgroup_from_folio() is
> employed to safeguard against the release of the memory cgroup.
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

