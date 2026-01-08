Return-Path: <cgroups+bounces-12965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2900D015B0
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 08:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F7F300D167
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D132A3CC;
	Thu,  8 Jan 2026 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7fC4yJl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T5TyeopR"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B62206A7;
	Thu,  8 Jan 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856390; cv=fail; b=oRfic0R3+3ES6CSGs8VtyVyX5V7k9IF/3paMbKnT9BkD2SPwz8sO31xbAThR4g2OoOwxqnycZ3n+n7b/3UNA/mP6kPBHYaVjqK8lv86IBteWpBM4zlA0SAwQnSQYwpEak6jo+o5nmF2mY2ydRH1JTG7qsiNtATVyTeBY1sKi89c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856390; c=relaxed/simple;
	bh=s4y2FhlXp9BeGeMdrQPmnHxZ08Pi8SAjNjmsI37pQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgIi6VBR+Qn00N+TykIrAmHSeAaYMjUr3v4Bd90ELQYioxa2IpqO5ocfijn74IrKDJda5iW6kObwI+46N2VM7Eg1yKcST5q0RL4kFU/YlhJIV/oMKfVE2jdhVuKUYQDSlpk4ihxaQJ9YE2ivyMdPFtuGZny7aKLGzgIUav0xeK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S7fC4yJl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T5TyeopR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6083QDi53971193;
	Thu, 8 Jan 2026 07:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mq/r81iBTLqy6ZYupN
	HAvq8wt0cl6tyzr9UigKaF3ic=; b=S7fC4yJll8osJs55Ln96oCa/2UlD+vV5CA
	PX0yvNz1PUs4mYgeOBPfxD5NHbM//AmVZvOONlcS70N36/bYhmVycMki5eamxHfx
	uaE24pxpzlPd/NTKc2vrwFkjo3V/XNk8LqUaqIEPvq25xWwPJEFQkTVNO3+kXyhy
	iUpE9kYMPeMX4+DJ6Qum3oKfx65XroRRf1Tb5oakzT/MRU0aTnsIKBQ+D8gH4J7f
	XnvCYxJ4GTKViJkEjRrPKBD3IflwBr57Nv5ygRBVyXvcbS98fE8L8McyNuStMBQT
	lyHyCjnATQvOh7XreLfJC/z8uKDZMNeo3z9pNEBTD35N7hekXS+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj4ntr52p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:12:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60863M3J015445;
	Thu, 8 Jan 2026 07:12:33 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjags46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osUYseVMkWbYhuYJXII7ugONFcV3XyzYvPOH6o+pDswbcrOkjfiLnlFK4InZxIsxgErELYvJucVCVysw0AevgUu65XxpkerMsiQpdJ18+8X4waHFOfjogdvo284pcxBVT5AYxCPbQ5/UAkpOe7MNJgQUJDU4sn10M7v1d4r8UkIRH+nj9i0pT/APMRADeZKPqLQe8ODjjyP78XnTfL72iW+W8X5IjVxacjx+nG6amhfIfK83Q9lRy2I7FsfOsTVAt1QhLcvLLOYvHt6Vaa6InU3y/QmG2NA1hEBC3GfsVkeI49NBno00S3Sk9kyDMECbLZf4iQ6LHkv4lwRr/uVrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq/r81iBTLqy6ZYupNHAvq8wt0cl6tyzr9UigKaF3ic=;
 b=eOm5omCgoXynnOFf+tV5acuYp5qDtylgrXO/Vs6aYYgdyBMg0WInJZhTPsb3Ibz/3bGDwNQvsrdRlMyD/PNN7RvD4tmLN1C+VLNK97m+0DXEgrT9cfz22NBlpUrYwiefApL2O2VJt3y2smmjjvrNeIkT2lk2yVWzZXEqWMkf6FoEVDSfSjBi/G7k3yltY0X1S0mekcF7DCQCjpI1dNQjiLRTomgC5jr3ztrG+hymBus/q0c2G5eiUpfQ6zvbUTnXAkSzlESPwVgpx6Xfd+nSyNIxDT5T8XXvRvrvfS788zto3r0SJ2SRbavT5LzVsA4FwyuYwwGFm1XXt2j6iUSsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq/r81iBTLqy6ZYupNHAvq8wt0cl6tyzr9UigKaF3ic=;
 b=T5TyeopRTn3CRKOtY5DDSEnZYki2e7KHmaGwu2fqLjQNS0z0f85NzXURBnT32gBoIfnEpDU9fQQ6HHUTFND+usuV+3hdzVXzFrOEcb3Z6OyIW9Lhw1zxwqvjluyoUKloK5TlfIo4Rp7eg0qWcVRnMIRfA/t43R3SG3EIFCFOlsw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:12:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:12:24 +0000
Date: Thu, 8 Jan 2026 16:12:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to
 ensure proper metadata align
Message-ID: <aV9Y0C0xIAyLBL8d@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-2-harry.yoo@oracle.com>
 <1372138e-5837-4634-81de-447a1ef0a5ad@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372138e-5837-4634-81de-447a1ef0a5ad@suse.cz>
X-ClientProxiedBy: SEWP216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: aef6a468-d2b2-4b4c-5c03-08de4e8545f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gONQ1a5U5NVj5oY7vlrA2EFdtUx8uh7/J/6c85yjUnDRUghkj4DLBWds0Ksf?=
 =?us-ascii?Q?IRDIhZRmIeStCsxqhMKd7CbOSmcolEuDupH2Ekx54L4au1IpcxPgP5OzRYuc?=
 =?us-ascii?Q?Z/YISp7YzDr2OAE39EbGfO+fqvi9hYt6R0tgrXLrBQfEPXcFgcDIsgYH2mQJ?=
 =?us-ascii?Q?4LSnfVAeaLrcUUXMk5zVjmwubSjnNrskV+RAnJUGRSK1DSqaru3HP7cB3GN2?=
 =?us-ascii?Q?QOD1RV0dLbWRxCijk1gyuo3ye5qA+6SUYU2Ci+1qsSEX/n+S7rAPbCBx4UfF?=
 =?us-ascii?Q?oggFMlTmSyQVuBeWLxtz9/2FZXwqDnar6g7T+m/nL3xU4NNBh0sNNzQl/OT3?=
 =?us-ascii?Q?V7v+InRrZXMNwrbllHIhCgn6dLsakcqYBPUrLAbffi2sd4V14GOXVN76wp63?=
 =?us-ascii?Q?TvP2NxDfnitDi7BEgAWXmVIzbgdP7nhGKHQwVD5WGlKVnq/WlR8kj33J8yoQ?=
 =?us-ascii?Q?/SZGa/jXY+3RmS262QDT9wx6JlB1qYwCozIDYLMqdWbRituVZ3ZGTXpRJCNC?=
 =?us-ascii?Q?FwqMGmeq4ds6vWR3kF13Any1ctsIbfWzVl69B/qYmuEgiB/TxBbclh2ISCTb?=
 =?us-ascii?Q?FUqvf7ILoiYR2yQKCzJmPdJMpE9fEa7juwfmUIjG/Uw/D2mLu1W3NOT9Wobn?=
 =?us-ascii?Q?tn5tgvgOmlIJ0dK9zDzRIIwNvXBYv4tcw3ikLOP1to0WNAChjspTZh4v3udR?=
 =?us-ascii?Q?VPdjyw3pwhqHmBjQl3gHfs0I1zfEREHh0AXOOWgR7g66zWN66w8ycrli03zV?=
 =?us-ascii?Q?2DshL7/CfYnqzfmg78mfglpb1VYUxZGwWy9N1vM+7/VeYxadUCrhp5mXnLhE?=
 =?us-ascii?Q?SGOZTHxBKX9pz5lRPaZ68bIOnokAaBDbsRVUe+vFPg8Hebb1OiMYP+7F4X1A?=
 =?us-ascii?Q?5U747JnbB5n7PCx5k9EeggUCzGGBGl3bmUBzEOX32id3VMpIfWMBfO7TIhjR?=
 =?us-ascii?Q?y24miQhHR9KRtO7S/OvBsDVIToOFCgGbJF3VfauGbm2HsUF5Bxibdh7d7FPv?=
 =?us-ascii?Q?PPHZihFRTnt7z3Uvqj9YJXeKZ3HsGILo4v4uNnjBQ7GfWoMiPwGR5yESolsM?=
 =?us-ascii?Q?Xb6vXWO1/rmVnwzzCo05FGFyHflZ1CoolHOkQr8HHvpFWtKsrlugkKmNJZvv?=
 =?us-ascii?Q?re8Zvd39p9PZisumO6Kfjy9c9HJIV/YHaXMuWwJihLD05wbpRjFphLvwYSk/?=
 =?us-ascii?Q?iL3DGEZwiMjWs2ZYx5Tn3EtN7bLnqrWbHzTRgPxQqlAeuKiGqiH54dRyue4L?=
 =?us-ascii?Q?zidCmy6eROA7Yf9WIg6dkIjXHerGOclzcssuPbyI69B5a1aFl3sMUmXacPsj?=
 =?us-ascii?Q?qSsYHuw6Kqy33PrkJ/QkVgMNQlE5/Np4oiJtT0uN2o2tLbvka4UxSdcEV077?=
 =?us-ascii?Q?IaFROhnbzMDDRlBrVZIh/FDG8mbDIe6FlshAC6caXSnMzI4sLeHVFWukcG3r?=
 =?us-ascii?Q?A+MOg1S2Zvq7QG+VUZg3oYo3fQTiDjJOrtrsiK2lFJLuxPTK9D/ZCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6nysjU0byD4727HeAw9iK1QtF06v4FWEeKYhXWSeUrjNg2yhfnWlI+A5i0M?=
 =?us-ascii?Q?koxjA79ZL9BrMnuFbmESGqckYRsj1+2jlncFTIZjeE+dsatOEqlr/bqWPf5R?=
 =?us-ascii?Q?RQy39JtatKLLv9fiBE72bw+xXfI6LTunLSdjV4xRTDcW/RpbMpryOFojnLJp?=
 =?us-ascii?Q?/ZVVjnhM0XAqKpxuCC2zbiz+3zB8OYKu4fBbT51D3H699KNdRULlXBV4T6W7?=
 =?us-ascii?Q?wafWUqTg4Sk8x7UCTVnGPkVmqIDKdUSRjqEm4bDRSG7OVC9uRw8ePfgw2q+G?=
 =?us-ascii?Q?u9spVJbUIaTZZxReK918A7MB6x1GSs6IA1MG2ukbxozpId2XhVlLEzG9hcHi?=
 =?us-ascii?Q?74BSw4pcvRbnOqoUXuu78XGNmfG70+6qNz4gCK8TPHVGc+fz9kriYkz3Z7la?=
 =?us-ascii?Q?cCrZh9/O5nQo883YS/v6cuDoxFdM/5kngE4HkBsEbJFjQOAfbS86xmevyPMz?=
 =?us-ascii?Q?njZqp54HDWIY1lCv4Zo3teMg/2R5f75jw5lr2NNGQqtgQKFHo5sgPoh8Kerx?=
 =?us-ascii?Q?gNIH/LWUHMhVis4X6JIf3/7Z/ikDgMB+BDt0uwHluBY5+DekSI0w6BN8h1U0?=
 =?us-ascii?Q?ocVgDqIujWUuBwuNI3f+MAHOVRpoqAbbgV8rqKY+js5Ef8MOLKN9dMlOezpZ?=
 =?us-ascii?Q?L9/GFT5zZM+KN8r1DHZNN+KHcOdN8e1F+fyPdDOGqgw+31dNPzr1lRbsTxcT?=
 =?us-ascii?Q?cWY/vfRwVi9bo3RrtNf6XU8f6O9e5jxlA/xBwvzGMkGtvfb+7zRrcX1kJwyU?=
 =?us-ascii?Q?94c6O00mIIZLAMMP5NmXZzNvcCKkgRZY2pkovh7AJ9kNUnYVWV/sR9eJkruf?=
 =?us-ascii?Q?OzRF4G8CxAtwoXqcDDN+36aunx0IAfbWf9zVDmgiEPOcVuYhijEQS1hNonQh?=
 =?us-ascii?Q?k8+xmk+7gUm1OnrMo+9ebL4J7T9T9NwdDg0XeAoG+6wvVNo95YbUrhZJtaLb?=
 =?us-ascii?Q?AYF3CWkZOsifHZXebkVootLiHZ4EqfgKWATxyvJphI7RhLs7JVSfOP8LFoeG?=
 =?us-ascii?Q?yMC+gcZqv394/jc/8BeAU0gFtDyI62KtPqdx85ND1KMDyd+d6pjie9birEAh?=
 =?us-ascii?Q?qG/m4uuHKJej+DA7OSRt6FNnBYw7FKwE/LPEKmBxTEZcfMtpgmQVaZYCAZxj?=
 =?us-ascii?Q?Li4YuYm1H1at05tJtCK8MMpMTZg9ihPYzTupbyCdArFJ5zu39IFGyZ2dyvCU?=
 =?us-ascii?Q?blQIxNGq/PtRa0C4DEeqM/AA2Jdd8nnFtyzKuQ0EYqlP4WKiXPDpbe56gjd4?=
 =?us-ascii?Q?oYW87V3Ar+IsxV2JeveatktWGdzEn/MXxgfmazLGGlh4pNVKCiw1mNuH3nAN?=
 =?us-ascii?Q?D8dah+7p8TS6/qB+EBP2m0wJHaKAG/1699rQsUM3Fvba4f/ga/CLIJDluPJD?=
 =?us-ascii?Q?Tt7HZa6Q3SQ0iM5G4xND4Fl7G+J+ZAQugx073/HPAmRmoQPgftPquQkw7eLw?=
 =?us-ascii?Q?ucT45Zy8mVEAE3JsvWDQuOyxTg5IHNj2k0MHwsepaCXBjD0CmK8zpHCBDTq2?=
 =?us-ascii?Q?o4JS1HLuXGN728r2ts7b2Hmke0+ZOLwS5QTmG4pyStqM74Onon/PPUTO7I8M?=
 =?us-ascii?Q?8h4U7VyKxNPDlf5HCScIdaS7tedrF3N2UmoTvI2YnvwE5y5RRk0n0au0S3B8?=
 =?us-ascii?Q?PLiYKiKsLXl7jzLyd2+IZC9Fk7hvHeiUMzfJMS7mVDNwBeXJvw4+CvIeAxfz?=
 =?us-ascii?Q?a1XWjvcTMNRpW6P+RMzQ/+qtra8H+x9PZxkozazLvxoCb5fZ1a2WLOkB6eEp?=
 =?us-ascii?Q?5ECiDXwA9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aDACcNesz4KoEX9wq9ScntDoK45sfqsFSmhnUYqaw4eZKPYKbtdCROxToJS1oQgzL1Edcw7NHOhY4IxZuJdI9ySkHSKHZoS0MIPj+2PIHlvqwreTdjX2tGH60KTwC1BPIxXne8UiA79QY6DYVC/LvdfgU49nMu/hfMllHWVLDudrKjUzVOxBA5ZBl5pYnMCf4HkLRBBxHZ8mHYimDr7FwdgvrDUk3JcSMWg1PL6B7MznOPge0DSHdIHyguKA/HifdaTubTaa/m9shLQoBPQKmvFPXd/i2PShYuzC2ytRBC3cJGzJmL3iq9InzqGDeIWpAreR6RilG4Q0uLmvkjMhNcP+XW5+UMwYwJzjv/yzXVlB7Lr4gdOnxa9tNFiwp8iNQgRf8k222Dc35SxUgIL/tyMLSu096BE+pS5LjuINa94s4bdn/FStYs5RhXkrOgXI15/P8gqz2/kcbTmG5RTCN91+LhimHOhLDLHb1oJJOmlSfs/WWB6lSYwHe+nV8Xg2Rq4b0QI5SM/tbCgR9kUI+w/fanjnfJ6hmTO+dPhE6QnedcTD0rIlTNi1u+GkbGnhvanXx0NeZPzi7vcCGNEj2bLb96JkHhd7PxFrVBTf8AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef6a468-d2b2-4b4c-5c03-08de4e8545f8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:12:24.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLBxGGF1MVvU8kZRM+latCc/K0xevWHYYmkqvJ0SR5TXBp9UaxQpvJ8pgr75X7xoMqUzCQxeTjJiUK0AVIUgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080046
X-Proofpoint-ORIG-GUID: xPD1flT1Eie5ZdqZsNwoDmvS7lFNSA48
X-Proofpoint-GUID: xPD1flT1Eie5ZdqZsNwoDmvS7lFNSA48
X-Authority-Analysis: v=2.4 cv=P6I3RyAu c=1 sm=1 tr=0 ts=695f58e2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=XzvEJp04kgGFTt9QLVwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0NiBTYWx0ZWRfX7JjpELxiAfAJ
 tDPkSJ4zLARJ/tPjGuozqs7qqMDyAuFy1rnGGWqiRJ/3h3aLjsEQZyydBSgdOTdId+gH67NW+xv
 Zg38ToZc2cxSobleU8IL/9lAJrGx0MF/0uDOe0HeBuzxx1jT6JloqawMmw5Xk6/vgi35/Hhfh4q
 aKlR9IGOUXGTZnMn5zz4gNCwUHWo/wFK3AvkN7sILWq1WX89IoEgPHJYn/fsHlfNLgIDWngzauX
 t6uCjJSI53apQH11NnzopMoWLvUTLCZqzfrTTocBLp/MqgWpCCx7Z7U1wICx+Bk7qdZOautUad5
 jY4l9gw9/MqQdm8w0aX4xPI/74KL+M210+kxSTHqtFsh5As6k2btrqjD79+WBrQQTyyfvr29c2p
 8BRTsVTese8evOXl8pzOQcrf0H7Jy4DxY04xB+So5JL6a22AZMPcO3Lpx2WJKQ/PehsZvsrqfSM
 sViAZXAoLQPpS9eDB6A==

On Wed, Jan 07, 2026 at 12:43:17PM +0100, Vlastimil Babka wrote:
> On 1/5/26 09:02, Harry Yoo wrote:
> > When both KASAN and SLAB_STORE_USER are enabled, accesses to
> > struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
> > This occurs because orig_size is currently defined as unsigned int,
> > which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
> > placed after orig_size, it may end up at a 4-byte boundary rather than
> > the required 8-byte boundary on 64-bit systems.
> 
> Oops.
> 
> > Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> > are assumed to require 64-bit accesses to be 64-bit aligned.
> > See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> > "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
> > 
> > Change orig_size from unsigned int to unsigned long to ensure proper
> > alignment for any subsequent metadata. This should not waste additional
> > memory because kmalloc objects are already aligned to at least
> > ARCH_KMALLOC_MINALIGN.
> 
> I'll add:
> 
> Closes: https://lore.kernel.org/all/aPrLF0OUK651M4dk@hyeyoo/
> 
> since that's useful context and discussion.

Looks good to me.

> > Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> As the problem was introduced in 6.1, doesn't seem urgent to push as 6.19 rc
> fix, so keeping it as part of the series

Yeah, no need to hurry.

> (where it's a necessary prerequisity per the Closes: link above)

Technically it's not a necessary prerequisite anymore because the series
doesn't unpoison slabobj_ext anymore, but later patches depend on it
because of the change in object layout.

> and stable backporting later seems indeed sufficient. Thanks.

backporting later sounds reasonable.

Thanks!

-- 
Cheers,
Harry / Hyeonggon

