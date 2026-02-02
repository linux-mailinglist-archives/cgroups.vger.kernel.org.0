Return-Path: <cgroups+bounces-13586-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG0HOZgXgGma2gIAu9opvQ
	(envelope-from <cgroups+bounces-13586-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 04:18:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4BC8032
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 04:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D812F300C913
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175E223DFF;
	Mon,  2 Feb 2026 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9L1+xdy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4UMczzf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AC181334;
	Mon,  2 Feb 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002257; cv=fail; b=aPyqwGxirm99E1BlwaxLW9OvJFWIPUN1QYhkFTT5irJpPzvKml/e+JylXUj1om5ik67WABlQN0ncpdAyDKyoyfERgquiF9S9C6dOQE7RAq8TGZKT5jtWm0eoX+PURxo8byB6tPJrO8721WD7bhv/WZpgjE+IeqdCb5a8ZSFXVJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002257; c=relaxed/simple;
	bh=mmfqMClFe/tH5sjNhYwij7zUFTU3q6xxUkAQmoR0Enk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ez+YtHwc4+mgWo4x4lbJuMZMErJsifxWTzwGwVdzH9lvqPjb+2VXCqbuXVzdqtVLjWyHOxFwsixz76PtNFupW0CcpBAT3MhSMfMeN8k27sE4QS0UFn1hor4dDKqPEpiHu6IFALDnUZBttl1ORwp+jVkvOoyce6fEmHi80I/WOUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9L1+xdy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4UMczzf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6120qUfN136274;
	Mon, 2 Feb 2026 03:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rnOZM0ojkwbGDdeQuG
	3/ABdMe1CMEBwD6hcvzf3kRzs=; b=g9L1+xdyyC2eIsqqZlgEWgZ5CMW2vq/I33
	+MU3wKdzozFa8q5s40pEtfVxEJF1PKEK3N62XqNC3SnxMQrI3kEf32qn0KGxOQIJ
	8VldKlM876kEXFrsRWxw2TTN8vVyznkthRCkpMsbFpgY9/+Hl184i5/zT2KNp1UD
	oQRH7jFeRHgib5EZ8U2A94pM/yvF+C+KXvlbgN1NlQACyRLKo6kfV/Z1II0j9Bn5
	3ypEUB7s+vyOy76Tqc+8QIQzqUooApl16VlSQi2ejIibyJlG/zHM6WpEhb00NCMt
	NxCV55gvrbHFfdMcnBNBQ1yAtWrMvtrowYa6OxgjnHsg2G4+Gi/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arksbuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 03:15:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61209GHG037239;
	Mon, 2 Feb 2026 03:15:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1867udqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 03:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsIMDzh6nVVLgx0Gtt/lbciirYsJn0y5TSCRp4sV4ZeV7p8Ig+vDde5hXaAX/OeSDIKd3oKRzt6uPe8gZSG/iRrDELuIqmaJkAOak8VUU0Iq+gMq85VMewiJnfrsxOQknjlDW+vx4zEutPQGyvGsHWy6c5KAVHrngNaM4gyhHNJ+rp315ODUJTdC6NZA+rmSUuqoud1AMpdeaAgCTnBGH5bW0LcaY/66MqBqFGc1qQqlEmUIz3ap0Eo1KYmZjDpaxXJ3wBk2LrwtZKA21J+9ZOccNkVQL2VfXbPAfGWy+75lKvM2Ot0hrZ0SAxtDeurZfentoXsFUzLjuhAbjnldHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnOZM0ojkwbGDdeQuG3/ABdMe1CMEBwD6hcvzf3kRzs=;
 b=NbTEFOWGOn/4I/iO+gJuL2BLCEmwTPhRR5IJKMWotnQa1Q/UiIVmD50xCVYd7dwPMqQralfApEwcwycBCDiLXC8TN0H311a1uR/aFc3EBpOeG/Ydy3EHMP1O1Our1yMNhqT/ADL9NU5TUTFCyC7JBqtxbPhGTvB1kF/f6jW0OfYDlRU/lmiePiSetNyC3JqRAoPwDUI379P00815EF61Zn5rm5JO/0xjxPDms6q5zQiHdykSvx7aNTyylmYk1qwPxzyXQb0V7OtJFmAUekvXfBFjqA8mfnQHd3k/oHxfmkRkKs+ckcRltxS5kGjeXGTWy6HUg4g1wDwWeZLvSxdezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnOZM0ojkwbGDdeQuG3/ABdMe1CMEBwD6hcvzf3kRzs=;
 b=h4UMczzfqbLPYhlkT2CSgNzTTb6aY0CNx5c/XOabYHnsX2kBogTeq4DTgRKYWy8Gw46neXWHxgo4WFj/7BNIv/K6vb1Ukxu5/gXLLtz3Mx3ZC5GEFewdNPuQc1pZc/5nRHH3VdOIo/9RgekVGquLJXVJ+l4TQcm0r8MHj6LktsE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 03:15:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 03:15:15 +0000
Date: Mon, 2 Feb 2026 12:15:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
        hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 28/30] mm: memcontrol: prepare for reparenting
 state_local
Message-ID: <aYAWtx9Qp4vWSoXN@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <iu27pt5nqs6myshw57e7dotld33v6lwuyouvquoqc2zmc5loi6@f23auf7hqbdp>
 <9b9057f8-4c4c-4067-b6ba-0791888c25e8@linux.dev>
 <aXrBiPlpEOOC3cMZ@hyeyoo>
 <6860146b-be12-4d5f-bec1-bbcec1dffbc6@linux.dev>
 <aXtRWdwwmi7G-Hlg@hyeyoo>
 <4535d53c-68aa-4c3d-b95e-6fbafdb83881@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4535d53c-68aa-4c3d-b95e-6fbafdb83881@linux.dev>
X-ClientProxiedBy: SE2P216CA0173.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 53090815-c835-4db6-3e5b-08de6209491d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gn+CC5rlA34hGR8dShwP0ZaLsubwqME2KMbObOHZZSxqWUCTEXE/tFjEhQSg?=
 =?us-ascii?Q?whH5pBkaEH5UH+KZDMHkD5D5ffWVI9NjalxExxp+G5kxKm5mbDkAj9PK4lOC?=
 =?us-ascii?Q?Uh8syEBUgm+ZVQV5f83HxF7z4ZIkwvnyA5WuC/HMtd7B2WHnigME1IuDV976?=
 =?us-ascii?Q?8JtYPWjKhqlt8uzOS2b8NdTZakcJ6n3ltl5kLyR3buILnDGbJFLf1i+VXM2k?=
 =?us-ascii?Q?TqIkBWduoysr9/Xsdde+CjWFJBaiqh8JBntDAbD88/DaVBqCx7F9Teeq1nJS?=
 =?us-ascii?Q?v4uUdk+IsmQZbwY8Zf1n8g8BS7FC5wUMnu5Pmub44W0jOkXI6KN09MpaPftl?=
 =?us-ascii?Q?38Q2gwbp+B6ehjP+vsHuHO7gG7DCeGPj9xobtLckUkksAUu0cskDLEOiIcxC?=
 =?us-ascii?Q?7ZSINpV+G7goHxPR7qoDHr0/mUsTH/Dxv0WA8vNViRuHFmEgsl6rIrKfcSU3?=
 =?us-ascii?Q?mF20+gTAW1L7C9ILR+pE/JI7HRoVfKvcZ0cHGRSvEpC6TFYR0NZbLiPk8o8X?=
 =?us-ascii?Q?JiHKmgT42raufjyzHoASRK+KUopDevVHlaE2K7o76uv3+pl3aIY5WcjD9ZZv?=
 =?us-ascii?Q?65QrS5f2zFSc1xPd2rIG/Lvc+HCCDRubqgdDOX2DV+8eaAqlVKd+FfArlXJH?=
 =?us-ascii?Q?7/TC/YmVmCthTArh+78kpSqeMn2hQtTchNwWFq6DxUpNCXXKUJme45NY0kpp?=
 =?us-ascii?Q?JkxVHlCMJ/JMTV1dwJ0JK/LwIPdHyoqvRnY0WFSuNGqOClMj+oqgViX3yV94?=
 =?us-ascii?Q?V7ZosvfsbR6zgHE/lI0eVckOo8ei0beMDDOT91o7ffhdDeNZOqa9Z7+VbKEX?=
 =?us-ascii?Q?3E93pBYh2HcqslD0wyGbs858N1wiQgzQNGqGGAi3ljlUMFkKhT089KzchB26?=
 =?us-ascii?Q?e/PAs1em1TAtAdlxMiVqBNsacESXEARBDT5ylh7mpMcHlX4iy5JtAyuccSAK?=
 =?us-ascii?Q?aIuVceX9zOfviTUBmMte16pLdFd2xPsuQBGTWmNCax2vVoCPvMwbMQlmLTUX?=
 =?us-ascii?Q?4OQgE7/KggAMwIYPWAcO/6DxffD/GJUWr7mKOFwp9DOHydREez5c2U3IWcWx?=
 =?us-ascii?Q?3XibKWE0bP45YSbkydxWpuqEWdpLMBH4KFrHJFbodMlU2+Wcp5eZL43npH1t?=
 =?us-ascii?Q?SNY23FjGCTT1hwKr8P6kXDyOvucbSfdaCbHQqXAE96Zeq5kxp1qrfqe0/HGG?=
 =?us-ascii?Q?TrSveGua+gUnskHTUdD74U90tJkuLBPWfCIbvlFCRkGVL9xqjNtLp9Jba4HR?=
 =?us-ascii?Q?UkVG0aXNt0Zwo40dkkAz/IpSfx6rlymPSYxEMKCzGjyybJ7n3Rv2rPzma8ck?=
 =?us-ascii?Q?l7jNSwLT7wtG9mLcfwalUSuk4ugByr/7kz8j+jqnHGNi2Yvq5Oc1ZXiJSZfC?=
 =?us-ascii?Q?oJ0G2sD7giaCXCYQAwBxZdKH27UxpV3OiXOkQUs2rdCpEvYQuKMyhKoUSNiI?=
 =?us-ascii?Q?sxUscYhANOWVNtZFa6EUW4RxtvLGM3fK3P1Q5Sv8Ek9UFCyrl7K0f4q1oaPI?=
 =?us-ascii?Q?bcFJ+jpv5scaKIZ4Y/CYtQ7dDEwIJRachJdEj7Ca/uiNC7i8g1/VvkRAhQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/KrvmlRvd0emG6WoEenttho4Osq6Zx3wQtZckT4UbTIhza4FDVBaK42UHVT?=
 =?us-ascii?Q?N4cj+XkBIlgtd8i0SeQp3ve5d23vHyABZ+lrWZRmBKcPrAci87lEdpSw5/Sq?=
 =?us-ascii?Q?d8sEOT0agx5+F9yMET/qNaff5MFeZG1xx9v41oZ1XDmguB+XeZCb/mW48FPA?=
 =?us-ascii?Q?Tll2Apw9xUuGwc66qoOvgmcuIIEHjIi9JcPklKMuLjJJoNRnAb1iJE0xUKo7?=
 =?us-ascii?Q?rWllup/jwq8GfnWC8mUUdtJTiw7H9UX4xhzhPnzOEDdqtmCOgsPsXI/GRzTd?=
 =?us-ascii?Q?iND/Dv10AhHKAkFD6BQxS3Zd8BQWi+bZ4QaDlZ4dJmkP0L6RR16WqA3Mon3g?=
 =?us-ascii?Q?hufKD/23SCb2NmK1j5ZkhgOAQjRcm0KRbndlePFvpQ+24CzDQCRiMJHt1n2N?=
 =?us-ascii?Q?j0fa9xUQGensbOVe6jbhThrv4bUJwERubB/Cp+vwx2/kIe2mn0LK2t6OtdGC?=
 =?us-ascii?Q?1k0qq23euikjwMazlkX2tEFvmzAf+a8F4FB3yL6a4G+Gd87pZl7Ox16yL1oB?=
 =?us-ascii?Q?re+CQ3N2P/FauO1tAeGOBv/5TBiVDusyKplDMeVCRonA3E51tTzEFYgirSmJ?=
 =?us-ascii?Q?PN/Q827JHiLELme4vohZ0lqtfDMjs6H7YV6oxOqHc+451vwtBEb5cpyF39kF?=
 =?us-ascii?Q?BleRn0FO3vJe4g+AKwZQ5OJNI+vLRXmMajlqXhWSnLhggFriXbH+YC3gFWMd?=
 =?us-ascii?Q?rdJJQBJRvYPTLVRlIfCUk/GZmauN2hVs/arWka+5UWsQ8jUISEL/Hv/p/iCJ?=
 =?us-ascii?Q?RIeJkf2pUSHzyppLarezRMOiTrCDXcGlcK8UpZfMewZOTUqN6hVSAlLv1yBy?=
 =?us-ascii?Q?NE/dpTaY68BfZ5lXiQ6A9kCeHrqUtgVzD5hGmGkz4y82nW1H1jFTOWhhxQlo?=
 =?us-ascii?Q?OmXnu4wlHA0jGuumbDS7iTtSwmCk3xIVfkdW50jVJt687XGp1VczbrIVye/B?=
 =?us-ascii?Q?FtuiLoeLA9xMR/HuOY+0iqWWWQWOijG4qfIrtXUDYqR1ojcc0m1bGcq3t21W?=
 =?us-ascii?Q?bdp3i9dGtU4Ch5i5J63IqThc/ClXCusBBsVWdMrVFOx5/HVZaUB4E580krkP?=
 =?us-ascii?Q?LyARvyvWhIVJZUm1RqaJATLaHZ4byTcPqDQCMPosfc6KFryT06qvu0SqXdML?=
 =?us-ascii?Q?Wt0L4io+nLmYzxBaGf4SkCVV7ebT+JQOGM6SxPLjH7rNYc42rH+iZU1FnHHq?=
 =?us-ascii?Q?gOV7LF5bsIxSyp+TM9nHu3guwf7haoLjmw6nBKQxkH7UX6qYfUwVo7RILHsZ?=
 =?us-ascii?Q?aih06WRNLE8GNRLnMhbfpJDElTG3MaAVWajB8c1AFLojKLhI73HUyG/U2ubv?=
 =?us-ascii?Q?r57BxNOH/oEtpMppm5u68YugN7kEzoYFps8KejU4HMWzdkbN3ig3PIqS5hbc?=
 =?us-ascii?Q?eHagciowL9PbpEQIUz5E7bMZppfZU3GQko8mzkd2KNGCBXwRmhI3LHLiSeSE?=
 =?us-ascii?Q?eipCZt9+EjkFv6rkIZ6m9Hx4MvKKid7fsVir32RQYtDFgk0XUKQmRVJ3pnav?=
 =?us-ascii?Q?9sHFdp4sZCrCdDGObpgzXldmkhp+tK+0ntVlIYaZKjUEVlhhB2YXW+CQ3agk?=
 =?us-ascii?Q?5hifDVhWuQaPagt+hhHP34u5C6Jw5+Myz9hqyI16YsZKYRwMCf2FC1TmXOe2?=
 =?us-ascii?Q?Z9ov/DvqcD7LCEAt+zxthAWYLi6d68jOGrXfdng3IpexbGoLrZS3N+vcrzrA?=
 =?us-ascii?Q?DCdqppuHYZemUU19z7MM6PyaXhgw+dhecbF4Ps4IGYelJr8vSGXGwMh4Nhbz?=
 =?us-ascii?Q?+3PLhurG6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7WsEGSnkGw9bHbMz7SJ50g/4Um8kBj3PzGFnr9ULEPS6HL1QONJwL6aeCIgnFP3mAULPUN3XIeIPlGj4jwrBE/o9D4HBENaN8MnElW8NNMa8/WWPNhD0kZKjEaXMPEBi2qLrjp0bmMk5Pkmb5Cd9bWZDjvhCP/w1QpFaHohCMdDEoeFsXDfNi5PokNifH1AUutJKZzwOsYoUADYnBpe79EvYSH6tYm2NohWPeWkqugQqCLXWUtQCWZZ8J+d0iRUWupWQfpJ2WhM+7JRHdeCopv4j4h5ji23nJxrqoYH/bPkfizFcY82vRCGAq4yped5D1C8UtUpfXy7yWFu4Fn/VNkuphkUx1Ka8tSBmbW7jRBbnxcC9hpgh5X5s8QMzaOonni1PYC/R0EMa4BnG2qv45qP5XFFRlEO0jOJ8VUUT7Xu2J793vPMCNvt83jv9q7wRxouQUU5WyzBvhhzorc8W5lYx09r0J0JseERb2+12XFtJZanNhMgE21fF3H7DmCcRv4NhNg/wwrNICRQJhxtD653QHwpKHHKmPpSAaKVsBvDJsotID6S7C7CO0e12dtJe01DWdC4IhmorFa0P+mtF3ssf1k6KEVkhAZhkM1GHP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53090815-c835-4db6-3e5b-08de6209491d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 03:15:15.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTAVDZHGi1vw2EiITVEfMPgRFFuvdx/kvaXvwNfeAG5+Xh+C8DOwC0qsXFVj+vfifAvV0tsDTxmGfHBz5uhWQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=897
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDAyNiBTYWx0ZWRfX2CgqVYF2R14/
 KeI2ny4C8jKqAMKEV3Pj7N1LKIPXg179AuXH1x1Ghk54VyoJKWXORcJraLgW5e3TZRR4FF/OWLH
 n+q0l27R+4Fhahpuc4pTBeGwtyK3uH0h5zvvVvCDCLnto6mnDv2epJfWV/0VVQj4HYBWC/1OWY4
 WMBP1h/Mp+aqORlVCwvFS/49q/PuMHxYAtNNX4Qfph+3L1o5c+KX4IPaY2EIIUE+8fUu45CeBd7
 biwGe+D7ZCeJlkQ1jhrMLTVL7Ra/zgzGf00KMW8pytxQcYh0xjT85fLbhEvqUNUMEvKqmz4znP6
 cXGLypkbgcBulCm11NotHRbJn0OmGZpMFYKby1qyICDbUMXLjUvxjhi8MjETHOrDFw/v0yYOtwQ
 CRi5TqE/fPNAmyJ5f0hQpGOAeNJ73MyUYDc7t2S/kSFU40VTeaa2FoB3ybnT5lp1f5sgEi3rzpY
 b7nEh/qMDmFVEPeLe+g==
X-Proofpoint-ORIG-GUID: zduffdN8Ap_LMtPL51GKh3If9F-7XYqJ
X-Proofpoint-GUID: zduffdN8Ap_LMtPL51GKh3If9F-7XYqJ
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=698016c8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=wxOlz8tp4pKKseulPKcA:9 a=CjuIK1q_8ugA:10 a=Ic--COEDtmgA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13586-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 46A4BC8032
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 03:22:20PM +0800, Qi Zheng wrote:
> On 1/29/26 8:23 PM, Harry Yoo wrote:
> > On Thu, Jan 29, 2026 at 04:50:39PM +0800, Qi Zheng wrote:
> > > On 1/29/26 10:10 AM, Harry Yoo wrote:
> > > > On Mon, Jan 19, 2026 at 11:34:53AM +0800, Qi Zheng wrote:
> > > > > On 1/18/26 11:20 AM, Shakeel Butt wrote:
> > > > > > On Wed, Jan 14, 2026 at 07:32:55PM +0800, Qi Zheng wrote:
> > > > > Since these two functions require memcg or lruvec, they are already
> > > > > within the critical section of the RCU lock.
> > > > 
> > > > What happens if someone grabbed a refcount and then release the rcu read
> > > > lock before percpu refkill and then call mod_memcg[_lruvec]_state()?
> > > > 
> > > > In this case, can we end up reparenting in the middle of non-hierarchical
> > > > stat update because they don't have RCU grace period?
> > > > 
> > > > Something like
> > > > 
> > > > T1				T2
> > > > 
> > > > 				- rcu_read_lock()
> > > > 				- get memcg refcnt
> > > > 				- rcu_read_unlock()
> > > > 
> > > > 				- call mod_memcg_state()
> > > > 				- CSS_IS_DYING is not set
> > > > - Set CSS_IS_DYING
> > > > - Trigger percpu refkill
> > > > 				
> > > > - Trigger offline_css()
> > > >     -> reparent non-hierarchical	- update non-hierarchical stats
> > > >        stats
> > > > 				- put memcg refcount
> > > 
> > > Good catch, I think you are right.
> > > 
> > > The rcu lock should be added to mod_memcg_state() and
> > > mod_memcg_lruvec_state().
> > 
> > Thanks for confirming!
> > 
> > Because it's quite confusing, let me ask few more questions...
> > 
> > Q1. Yosry mentioned [1] [2] that stat updates should be done in the same
> > RCU section that is used to grab a refcount of the cgroup.
> > 
> > But I don't think your work is relying on that. Instead, I guess, it's
> > relying on the CSS_DYING check from reader side to determine whether it
> 
> Only relying the CSS_DYING check is insufficient. Otherwise, the
> following race may occur:
> 
> T1				T2
> 
> 				memcg_is_dying is false
> Set CSS_IS_DYING
> reparent non-hierarchical	update non-hierarchical stats for child
> 
> So IIUC we should add rcu lock, then:

Right, RCU here is used to enforce ordering between reparenting
non-hierarchical stats and stat updates for child.

> T1				T2
> 
> 				rcu_read_lock
> 				memcg_is_dying is false
> 
> Set CSS_IS_DYING
> 				update non-hierarchical stats for child
> 				rcu_read_unlock
> 
> synchronize_rcu or rcu work
> --> reparent non-hierarchical
> 
> > should update stats of the child or parent memcg, right?
> > 
> > -> That being said, when rcu_read_lock() is called _after_ stats are
> >     reparented, the reader must observe that the CSS_DYING flag is set.
> > 
> > [1] https://lore.kernel.org/all/utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz
> > [2] https://lore.kernel.org/all/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn
> > 
> > Q2. When a reader checks CSS_DYING flag, how is the flag change
> > guaranteed to be visible to the reader without any lock, memory barrier,
> > or atomic ops involved?
> 
> The main situation requiring CSS_DYING check is as follow:
> 
> T1				T2
> 
> Set CSS_IS_DYING
> 
> synchronize_rcu or rcu work
> --> reparent non-hierarchical
> 				rcu_read_lock()
> 				memcg_is_dying is true
> 				update non-hierarchical stats for parent
> 
> Referring to the "Memory-Barrier Guarantees" section in [1],

Today I learned a little bit about RCU's requirements :)

> synchronize_rcu() can guarantee that T2 can see CSS_IS_DYING. Right?

Right. It is fair to assume that a read-side critical section either

1) ends before synchronize_rcu(), in this case, the reader might see
   CSS_DYING flag or not, but it doesn't matter because this reader
   ends before reparenting the stats.

2) starts after synchronize_rcu() starts, in this case, all stores
   before the grace period starts must be propagated to all CPUs before
   the critical section starts. Thus, such a reader is guaranteed
   to see the CSS_DYING flag set.

Linux Kernel Memory Model [2] explicitly explains 1) and 2):
> RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
> rests on two concepts: grace periods and read-side critical sections.
> 
> A grace period is the span of time occupied by a call to
> synchronize_rcu().  A read-side critical section (or just critical
> section, for short) is a region of code delimited by rcu_read_lock()
> at the start and rcu_read_unlock() at the end.  Critical sections can
> be nested, although we won't make use of this fact.
> 
> As far as memory models are concerned, RCU's main feature is its
> Grace-Period Guarantee, which states that a critical section can never
> span a full grace period.  In more detail, the Guarantee says:
> 
>         For any critical section C and any grace period G, at least
>         one of the following statements must hold:
> 
> (1)     C ends before G does, and in addition, every store that
>         propagates to C's CPU before the end of C must propagate to
>         every CPU before G ends.
> 
> (2)     G starts before C does, and in addition, every store that
>         propagates to G's CPU before the start of G must propagate
>         to every CPU before C starts.

	  ^ this

[2] https://docs.kernel.org/dev-tools/lkmm/docs/explanation.html

> [1]. https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.rst
> Qi

-- 
Cheers,
Harry / Hyeonggon

