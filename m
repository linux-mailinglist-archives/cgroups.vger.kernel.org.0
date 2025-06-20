Return-Path: <cgroups+bounces-8610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AAAE1A3E
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 13:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02EE5A545C
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C625EFB6;
	Fri, 20 Jun 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F6Xu2xeM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6AGKV6/"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004C1E47B7;
	Fri, 20 Jun 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420272; cv=fail; b=LSFcEls752B7Sq5P3NpWqEw71XxBGxq5sg7b4rrKrHRz0RVBXp5j7UdwS3NJk+xd9gtEChDJLuhIVlbpqIX3TzLOwFbcBauo1y/OKdGlzoga0kmBCvlTFmktLW5fSVA9skLlHtZ2Z9yz7pLt47hDQgHU8Wpr7O0ynG1ZswFxHis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420272; c=relaxed/simple;
	bh=iyHelMFcDn8L0iiZxLcBfRkMIelbyfdODZVniyXu8OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PvGHf7i+wA/Mmhwryno09CwbKFhN0ZBzbxkIVnMZ7C9CJtb2pHIUCiCPq8yYX9Nz+GKcmRaacjDR0T2hgu8Oyn+SBInqnA0oUAlh78drWt/FSrnX597kSJ/hplwjkai7JdTw3OGJ53x7OWE20W94m3WM0eKYMvXQ08mP25do0FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F6Xu2xeM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6AGKV6/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K7fe4Q031213;
	Fri, 20 Jun 2025 11:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qwxvo3uN6XBkmPjPU9
	kmBs/BHyntrkggWgsEpwfy/iQ=; b=F6Xu2xeMoobS1fo0voW7/PEcLr3klZOz1G
	ZPN9dhjRb2ahSpWtgsOnKTrWgFJWbz+bHlY94QNb7wxCnpNvZXMJYCIOKpMbeSXu
	m7LmXAFYdbkyhldrS2OidLgStb1g7tQoj39MXvq+B/+0q6PXaXMD6PSlcet7pgvP
	GVyVLHtafgnHXclmyvMBkHAm+Q87WaIOUcawg3q6Cgfcknl9CQsFYzJrvgcz9AKb
	mjyp5+SKBMN3WxgVHdVBbJD/cVyVE+NVo2E/n3p6snQTe7e2/LX1hg1sPl/B5Vca
	bq7FgFJTsM5s8XSg4QO3YNLZQ532sWWo0On9BZ8j8C4FvCHqC5JA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f3hft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 11:50:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KA5JiC018534;
	Fri, 20 Jun 2025 11:50:49 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013067.outbound.protection.outlook.com [52.101.44.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhcuh26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 11:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDNBaOzxzScFrHAre1UGO0nx+eY3xBwl1JfcK51AIJKqZUUVM/bKoHhW8M4BV63Lf+zGNHcWqkHsOROp/Ei2XQ0Fbd7uCyujc9B4WcnLVnu5itb6nVxw1vaSRgJ4j7vzWJolIVE93xiUQqPrvZtOoZBA+wyE02wXn1+se+5osxapErDaTUMOAEjCb3qgILkeIucEGOmCISSFWh76vwwX4BYFCbWJkz74jg6MVxNdkaK2EDVTg5BeIUMM07Fmvh8yQI18OQq4iY5nGdGtgyY7LEAxFOhMxkuYfg+lVgh9/Sv1qTrUoFUwuZsgpSo3qmY89uvdc7Lu1whJdbImkzhSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwxvo3uN6XBkmPjPU9kmBs/BHyntrkggWgsEpwfy/iQ=;
 b=MTSU/dADWrPbmjOkXpG0PNs1UTXb14qIsqhvegkcPMXbuUtrAs5nOJiJoTGmKGzdh3zyumhWI8EP54uiwMk9phdM5B4KuPitituzeA9s0c0MA+6xtPqcmiGfRS2M9xEmfk8mljL5blN71k4vPAJI2neW61dsEVLO24N6KTt26W32CG3TK1uZX0GZs4zevpHUtK4RpaxXZwxs2m9W0+DZ6zR3iQeWMzQ3ZvUkVg7u9qDQIqj2YSk4t5SQIvg8Nv/p5v4oyxcQclrON3I/LnboJy8Ddp82NS4kh8QwEMhJSrKy5rThaaI2ZwBd6ZLtCIc7v+f+lElDsV+OF4VhsDkPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwxvo3uN6XBkmPjPU9kmBs/BHyntrkggWgsEpwfy/iQ=;
 b=Y6AGKV6/ou3LDgm5XjvfcmTWNNAT048BDnlFc8MNyD4jhGJPz99z/FZKuNiWabZfvKE0AZdAAOXC3GiCQ73kIv7736wU0sc8cckyD48ES3ACeh16qurOu8kYScrNAwS9NvbBSJhOpNVOw0JBdm/FmpiZ1f4HBf7KKPXn3TDpNZg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB7467.namprd10.prod.outlook.com (2603:10b6:208:47f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 11:50:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 11:50:46 +0000
Date: Fri, 20 Jun 2025 12:50:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in folio_lruvec_lock
Message-ID: <a55beb72-4288-4356-9642-76ab35a2a07c@lucifer.local>
References: <6853fc57.a00a0220.137b3.0009.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6853fc57.a00a0220.137b3.0009.GAE@google.com>
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: b30f050d-d40e-4766-db86-08ddaff0b13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tf+Y0yRPES8Zq8995d+5XAduTcxzBKL3xxaLD24sfMhRcw6bcMEKaVCm7xBz?=
 =?us-ascii?Q?jRveL6bIUJbvHz9Ejwm0JYuK3rGcHPWw/TKGuieCbR3yyYVz7wXDe71dGpq7?=
 =?us-ascii?Q?pQiUVTWWukn2PPxAlsAiQC+Xwrq0/QUrmrtOXajqSfqzE0v3ldyBB1hBKb5T?=
 =?us-ascii?Q?WFGehaEWzLw5Fe3sTLLtBtO/4fHzw8m+nFnIVgeh+j8Y1WqBK9CPnuNy07my?=
 =?us-ascii?Q?GTDnZcpfxop5A4wTq2OewfUDLeAkmcvAFS+jjMY9KiXAZLx+NIztNQoS9N/8?=
 =?us-ascii?Q?z2VRB4I08hDhQ5B9mSHod1o15RQepncr7Qjm6zbLzI/QGKU9SK+KgH7+j6N6?=
 =?us-ascii?Q?iEVcxiZ5jz8FJn2iEO4r0NoTJVDDVaV79p3GxWF0qNKXZCa7+vpvF5EiM9iz?=
 =?us-ascii?Q?+A/Zlifyz9YOGo/HEN/zCUGBbC3WnzHBezYWHSRyZ/Lzir1G837CDs0IR+EY?=
 =?us-ascii?Q?w1RrX7oAfrEasJOPLqpcYnAO2R15q7tckAne952U6kJ2Us5UxNdRTqdisqee?=
 =?us-ascii?Q?NQNHhWfuDk2wUwBRq0JGj1Jv3O7Nck7rpK+tDsJ7LOGrdojfoCQnHM3Y5D6v?=
 =?us-ascii?Q?1x6Gh7lnvq/vhU5huFhyIvSzuB59TbvOBWcMW7p0Jsx8sKr7PRkmwZJS++CL?=
 =?us-ascii?Q?ltULscyjLTcSFz1mI1qgEGP3SkApRlVRkitb3856cyyxy7KWvldWbb/QT6Qg?=
 =?us-ascii?Q?y646v/bJSiDlf/dTACAnj9KCh03ErBTgR1dk+SRkq4FqqwWy4ehL5iSpEiKh?=
 =?us-ascii?Q?pvmiITEbkCuCGdkug+cheAHZprTqiTlKDIWaSD105ITLmVojXQCCQfgfCz3e?=
 =?us-ascii?Q?VjcBln5ooU6ihGcYHSgXvbwnwZJMqAmrCbvNqwNOd3eArtmnC1Onxe0R1GE5?=
 =?us-ascii?Q?DMI5A6yatWM0ef3RkAfWccbk7KP467hBh2fpDW+/U67H7oJhQ2PP9wCYRYcd?=
 =?us-ascii?Q?jUbhFOlVSCd3gCuALRc2QDeQZwn2+IIxkZaUq6hcvX8RkDGVY3shfWwWH2zE?=
 =?us-ascii?Q?DVPaZlhRaKuoC5KAmkAVkKQ7pcOR+92iY3Z+awU5767hsW5gPo/bS1fNi+3o?=
 =?us-ascii?Q?CGQSdMb5q8FGrpyFlxKd0t0I58+52pt+ygIHDSJf/HeKRCjkkWHEQVaaN259?=
 =?us-ascii?Q?3sBz04RbEZdCTgiDI3ODLCuEnRIT7s5lMH7qm4XNBcyqPAe50+4p7BKi7BrE?=
 =?us-ascii?Q?f1t4yS37NCLW2EB6Q/3lf/Ej5SFA//wxo+YbBFzApO/x0SDSUWkepsrVUdwr?=
 =?us-ascii?Q?so3VSLHpDx63ALIoXt3j4texqoT03LYIUme8/YRC8OR+CPqAOGaN5nek4GHX?=
 =?us-ascii?Q?3TnNnHyw4IVgPJHmmOaVjlin2t+XwUGEdzQ39Wr3SeBicazeghfgowXQYypf?=
 =?us-ascii?Q?icHmeRDX01C/3pi3emVuskNSLgtY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqXCzZuTC7YkIeVkkpam9d0zjkvmdwAVZYJFEAcgeZgLEz5MKUcGsLzNy17j?=
 =?us-ascii?Q?ItmM2VPyu0eny+El0Dl8JFPfU24LeyAN4duTaQGfqyw33zvkHkTGkM8vN2kZ?=
 =?us-ascii?Q?Znj51KZQgR/FI8Fy/D/VGR4bf6UUrX8XpSSTs3aj4aU0FzBRntYnbqkgGc27?=
 =?us-ascii?Q?lxHX4JXJuOYWKioFiG0VDQy/B5DHZ64PWT/FLVAjMdydkCUUPVP84Fe9fZ7+?=
 =?us-ascii?Q?LpnascaStDKRBjIdxY2EnFKfs11JeCg3xjh+dZ1jE2d0WmCDNAI2e5jmaECy?=
 =?us-ascii?Q?u9zX2iOf3UuMSNnTqcpEjwR/uzuSGT1oOZCFxAHMts/6bg9fSkNIfokb4mMS?=
 =?us-ascii?Q?AU0N2lnu2FCvP18q+Q54OF/+xF4E4KVyOu0VL5Tb46wJU6CeJfyB6FYQYYgw?=
 =?us-ascii?Q?KxoWbRUiryb62/xEEBnSOpyezT2EC1A6NCkbpZl3m8XV9oxg4iwlFsUUxvli?=
 =?us-ascii?Q?L7MJQ9q0G7l3p+XJVpeVwA6raVvQKDVMfSO+1RbaS19meEZW42Jcg7LHCiT6?=
 =?us-ascii?Q?nWodUvuDfyv/XHkrH2CaVw0JF2srC1eqsYQ99qZ6DskghF8I1cDl2inA31nT?=
 =?us-ascii?Q?MHipwswNfp+PcfP3BycARJQoh5cAHppdwPL8Kse78SyM5yXPEcszcW+/iPMd?=
 =?us-ascii?Q?wFo4gqCkp4xh94F/m+wlY24H1QuDWALKkrAEDXHeQoU4hpQZ4VyL2YnBr9nJ?=
 =?us-ascii?Q?Vzkhe710ux1ZIz+zpccC2nDYGsFE/R1KEscadgCOPBC785/Ul4pNOA8I7D7j?=
 =?us-ascii?Q?NbdeGcBQ5a1C7XLOcXczJYoQyB7VUTvbkHs7ln1mMaB25IVqQ5RqNwTgwv1o?=
 =?us-ascii?Q?DDrJQftiPoYDvIm+dSr6w1kt449znSkZyAEK2BIRkqguf3V+v16RHCSyN+MV?=
 =?us-ascii?Q?CNP9nXG+O7GXbeqnN25QDWp/D8Wtz9ri0iz/fV3qKEsExzTT5et+BCxRvEux?=
 =?us-ascii?Q?ftNBBa+Aoqaj0iGB7BITbvRd2QD/2CUvEC6iYFhkpBptrEbX7hXhd9HF+HmB?=
 =?us-ascii?Q?1ka6C764rcr6O6x0V9oAM52pSGDKS0pztwKYRsglYN88pm+p7l/TsIp7biV3?=
 =?us-ascii?Q?qu9NBir8OfhtcRxoO1TlrlPs8UuzL+qeh4asICKyjf8RhKpWQaGIIoe/ECMZ?=
 =?us-ascii?Q?ieye674CNaTQp1Bwknsu1ZdYhZp9LWi97HnCZCevGHP20ZhIuevnD1KLuOhH?=
 =?us-ascii?Q?JVIMc0bQ8XpzEhZYLT/g63CMdoaiPK8Rzlx1BlTyxs6J0KAgN4HFkmENM+cj?=
 =?us-ascii?Q?B8dptEYZzDuWEIbYWiTpuGKz7X/aE93hiw0g/XrokBG10A+nG2DTOjxU5m+Y?=
 =?us-ascii?Q?Ej3wsHpRxlftAN8J+Up/+k5zpkH/iUK/GsRqTGjvb2CSGCX4uiJAY6fW8sjr?=
 =?us-ascii?Q?jM0XLikGYEofRuB0NDr9rPHN7Xds/P+vlZZsLbPSkiPaIPc9g2nyGf5bPY73?=
 =?us-ascii?Q?zHdbrZl2rFaeGd8ngBSrfCa3JZxITcVj1fLbf0STcXN0CXcsTbibgvvc98ps?=
 =?us-ascii?Q?23Vfs1t886Y11QYC/FDhDeKDDGWbVKeE4xrr+z9kHnx0haqVn5ZjgQAKKGD2?=
 =?us-ascii?Q?dAqP0uqx1B7M9xCi06Bgmh5TEayJTySSH7Ph0SD93XFYM++AY0hW7Y2LQ5RD?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lNvQQnsHzCB0porZWG90blxJS9RUUaPkhYdoeuwJ71h7cmrz+Xse2kbxZmOrOjfjyjZrXvb8FgavY0c9EVBQiuIARCnmVH524itep+uTn/7K06T0m6sIp3SShSXJH3E+6hzjyMtVwO8JhSfa8amksqq2YPzqI+efQakGbtsJZxV+mBvyiKIYKOF3OnYd+OIGzJYJCNTYq2lY1mez+LfjlWsXbqYbi0kg/9wpzawBtRbLf/qqj+QpRxsGwZP+7ZXK2sqhj2DiM3Dion9Qx709DKmoQlKcs7pKtE2lgXWimNbg/TLgCD/ZpMO+nG6BjXWlrbV11Wlah5SlE2w2ueH7sE0D34fXbGBtWYxry+UNNUidCFJQp7Abc6Ch74KAuMrpDB9u8ErK+g2xt5yn2pSQC9u8FRw6b63xwIfLwwV/p1FBFtZqNkv3MvRkCAgY8cexPuBr28sSklQcD0lMFPpn9kDXgMhp7LmsmbKX2ZszZ3G/x1J3wYWccqQhGEzFY9B61d3F3EEAzbHddRRMRuCL2FR6eoOGuUEqVgKC1weTYH07HAr79HTumuT50Q/lvxgIMYUgwYnMoJrzPaxGTVIcRY1jkmUd5GX6sF9a3Ix8cNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30f050d-d40e-4766-db86-08ddaff0b13d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:50:46.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFom+69hcxvEOqFSsCLEoCY1gWCWbicfMHyWjfIc31lmeuoXbIAYT8vc1wBCJ8SrBOux4mB52xsVs4zL5t5GO0hq1xi25nmkiPb8Xa9fao4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NCBTYWx0ZWRfXyS+LwJ7APtqg LEyg1fJzvA9UYyahMM8FtKLl3ov3YS+eEXst1RnRBCXd16GUC3Q+c9hLYHnD386LbwvjBOluGCU mBPl24Sgnp3qWvGcJDUrXdrd/HsPt/PYOXWkUdH4B2kpiIif+oY2JHlKn/sXnnmy/Jhs9WoiQ7a
 yUgm0Ez4FdCTWv7m0/KcpnV6zTCELCGyNOKMFn3XpoXQS80vxHri5uNsim1s2u0ewZ/cDkQmLYa ev0f+vKBuMJIrlDGIzL7CMYUhmkkA6YOgZhOvZ58bAJoKxqpImhZ6QMExhO15Mv+cgO8buSYqsR SBlanJO81ZeSo1wl2mMVSgLlN5U5I9e/y2Q46YVP1VUe4iUsSyGxFcW2Vl13di0bFlLU58MItTr
 LpluRhGwLUQYtyAtVx+RtxhyUKfSK0fW6gK52eVTNmJycn6KbgVJIyEDoEAh6WURGrl4sXDy
X-Proofpoint-ORIG-GUID: 9wfZcX1Xxoxz6zK-an5noxdABEfMuCah
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68554b1a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=2hwOaHYHK4-fEpmzzBgA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=CjuIK1q_8ugA:10 a=vVHabExCe68A:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-GUID: 9wfZcX1Xxoxz6zK-an5noxdABEfMuCah

OK I think this might well be me, apologies. I definitely see a suspicious
looking bug. TL;DR - will fix, it's not upstream yet.

Thanks to Andrew for forwarding to me, that's some insight there!

So it looks like in [0] we are doing the KSM flag update _before_ the mmap()
hook, mistakenly, which is... not good.

This results in the correct checks not being applied to the VMA, because
e.g. VM_HUGETLB will not be set until after the .mmap() hook has been completed
(I'm working on converting the hooks to .mmap_prepare() but we're not there
yet...)

[0]:https://lore.kernel.org/all/3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com/

I will send a fix there.

Thanks, Lorenzo

On Thu, Jun 19, 2025 at 05:02:31AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bc6e0ba6c9ba Add linux-next specific files for 20250613
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1126090c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f7a2e4d17ed458f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a74a028d848147bc5931
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2430bb0465cc/disk-bc6e0ba6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/436a39deef0a/vmlinux-bc6e0ba6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e314ca5b1eb3/bzImage-bc6e0ba6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com
>
>  handle_mm_fault+0x740/0x8e0 mm/memory.c:6397

I mean this is:

		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);

Interestingly, I see in mem_cgroup_charge_hugetlb():

	/*
	 * Even memcg does not account for hugetlb, we still want to update
	 * system-level stats via lruvec_stat_mod_folio. Return 0, and skip
	 * charging the memcg.
	 */
	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
		goto out;

	if (charge_memcg(folio, memcg, gfp))
		ret = -ENOMEM;

So maybe somehow KSM is touching hugetlb (it shouldn't do...) which has an
uncharged folio...?

This aligns with us having set KSM flags at the wrong time on a hugetlb mapping.

>  faultin_page mm/gup.c:1186 [inline]
>  __get_user_pages+0x1aef/0x30b0 mm/gup.c:1488
>  populate_vma_page_range+0x29f/0x3a0 mm/gup.c:1922
>  __mm_populate+0x24c/0x380 mm/gup.c:2025
>  mm_populate include/linux/mm.h:3354 [inline]
>  vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
>  ksys_mmap_pgoff+0x587/0x760 mm/mmap.c:607
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page_owner free stack trace missing

I'm guessing this is the process stack of the repro (even though syzkaller can't repro :P)

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 38 at ./include/linux/memcontrol.h:732 folio_lruvec include/linux/memcontrol.h:732 [inline]

This is:

static inline struct lruvec *folio_lruvec(struct folio *folio)
{
	struct mem_cgroup *memcg = folio_memcg(folio);

	VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio); <---- here
	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
}

Meaning folio_memcg() is failing to find a memcg for the folio.

I'm not really that familiar with cgroup implementation but:

static inline struct mem_cgroup *folio_memcg(struct folio *folio)
{
	if (folio_memcg_kmem(folio))
		return obj_cgroup_memcg(__folio_objcg(folio));
	return __folio_memcg(folio);                           <--- seems this is what is returning NULL?
}

I guess it's __folio_memcg() that's returning NULL as apparently
obj_cgroup_memcg() should always return something non-NULL.

And this is:

static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
{
	unsigned long memcg_data = folio->memcg_data;
	...
	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
}

So if folio->memcg_data is NULL or NULL against the mask this will return NULL.


I see this is set to NULL (or rather 0) in mem_cgroup_migrate(), also in
__memcg_kmem_uncharge_page() (but is this kmem? No?), also uncharge_folio().


We also set the memcg after charge_memcg() -> commit_charge() so perhaps a
charge was expected that didn't happen somehow?

This again aligns with a mis-flagged hugetlb folio.

> WARNING: CPU: 0 PID: 38 at ./include/linux/memcontrol.h:732 folio_lruvec_lock+0x150/0x1a0 mm/memcontrol.c:1211

Ths is:

struct lruvec *folio_lruvec_lock(struct folio *folio)
{
	struct lruvec *lruvec = folio_lruvec(folio); <---- here

	spin_lock(&lruvec->lru_lock);
	lruvec_memcg_debug(lruvec, folio);

	return lruvec;
}

> Modules linked in:
> CPU: 0 UID: 0 PID: 38 Comm: ksmd Not tainted 6.16.0-rc1-next-20250613-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:folio_lruvec include/linux/memcontrol.h:732 [inline]
> RIP: 0010:folio_lruvec_lock+0x150/0x1a0 mm/memcontrol.c:1211
> Code: 7c 25 00 00 74 08 4c 89 ff e8 7c 66 f8 ff 4d 89 2f eb c4 48 89 df 48 c7 c6 60 4f 98 8b e8 58 9b dc ff c6 05 01 85 5f 0d 01 90 <0f> 0b 90 e9 d5 fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 4d
> RSP: 0018:ffffc90000ae7660 EFLAGS: 00010046
> RAX: b21d845e3554e000 RBX: ffffea0002108000 RCX: b21d845e3554e000
> RDX: 0000000000000002 RSI: ffffffff8db792e4 RDI: ffff88801de83c00
> RBP: ffffea0002108000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bfaa14 R12: ffffea0002108000
> R13: ffffea0002108008 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888125c41000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f475c15ef98 CR3: 000000005f95a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __split_unmapped_folio+0x42e/0x2cb0 mm/huge_memory.c:3487

This is:

static int __split_unmapped_folio(struct folio *folio, int new_order,
		struct page *split_at, struct page *lock_at,
		struct list_head *list, pgoff_t end,
		struct xa_state *xas, struct address_space *mapping,
		bool uniform_split)
{
	...
	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
	lruvec = folio_lruvec_lock(folio);  <--- here
	...
}

So we're splitting an unmapped folio that is locked, non-LRU and frozen
(refcount == 0)

Interstingly, __split_folio_to_order() sets (new_)folio->memcg_data, but this is
called _after_ this folio_lurvec_lock().

>  __folio_split+0xf78/0x1300 mm/huge_memory.c:3891

This is:

		ret = __split_unmapped_folio(folio, new_order,
				split_at, lock_at, list, end, &xas, mapping,
				uniform_split);

>  cmp_and_merge_page mm/ksm.c:2358 [inline]

So we have tried to merge two pages:

		kfolio = try_to_merge_two_pages(rmap_item, page,
						tree_rmap_item, tree_page);

But failed:

		/*
		 * If both pages we tried to merge belong to the same compound
		 * page, then we actually ended up increasing the reference
		 * count of the same compound page twice, and split_huge_page
		 * failed.
		 * Here we set a flag if that happened, and we use it later to
		 * try split_huge_page again. Since we call put_page right
		 * afterwards, the reference count will be correct and
		 * split_huge_page should succeed.
		 */
		split = PageTransCompound(page)
			&& compound_head(page) == compound_head(tree_page);

		if (kfolio) {
			...
		} else if (split) {
			/*
			 * We are here if we tried to merge two pages and
			 * failed because they both belonged to the same
			 * compound page. We will split the page now, but no
			 * merging will take place.
			 * We do not want to add the cost of a full lock; if
			 * the page is locked, it is better to skip it and
			 * perhaps try again later.
			 */
			if (!trylock_page(page))
				return;
			split_huge_page(page); <---- this is where the failure occurs.
			unlock_page(page);
		}

>  ksm_do_scan+0x499b/0x6530 mm/ksm.c:2665
>  ksm_scan_thread+0x10b/0x4b0 mm/ksm.c:2687
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
>

