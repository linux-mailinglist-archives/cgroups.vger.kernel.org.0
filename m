Return-Path: <cgroups+bounces-11771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568CC4A255
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 02:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4652C4EE350
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65B2561A7;
	Tue, 11 Nov 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sSFLJmyj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gtu3pGpD"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AA1C28E;
	Tue, 11 Nov 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822829; cv=fail; b=Bze9Q7NgISPvfRKRf18MfOcjjINslRBxkUiWuE8V1BvKW5rwMxcagbqNBgicbCs6//x7V26zJaXZm5QYx1Blh2toIL3dU3Zjz6aNMHXgYofEkGy0XK/8+Y18DwPX3FRM2s5aPuMlESMeaxzCcYmgPXHn5pzsxkUj0KL+POHHqhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822829; c=relaxed/simple;
	bh=tpIxhY3URZd2pb+lE4SZeOTl9s3qTbHRemTxI9N/IM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTVAmQWp7bjD+pL+b/uLQeI0FdvZ+ljA14fz22EAbgvP+FFGNTTRAJbGK9iUpv8ny6p/GzKLwX/eYvgdAiFQkZBZqF7vBC7F4y3ch9vuCneRFmONeP4RtsMe1cBRjLMge9vdXv/nf5Wo8UWvhXz/os5Mk79H6lqAy32PseZm1Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sSFLJmyj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gtu3pGpD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB0TNvU000315;
	Tue, 11 Nov 2025 01:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0mj3sFWy09ZIZ9CuU+
	yPg6vID0GQyqmUY5URyqmjQRU=; b=sSFLJmyjh6Ez3GuhM9oIGm94bzn7oPxuYd
	NXf1kfiDHO6cLTH4pwDw7O48EB/TAeXJrlVJTVg7tYIrBW4ePvFf4lSkhNrYQHVh
	ZarSi5ofYhbzj+iJCTbFXvf2XM3zrib6Q02kJwRAs6GUnhz/gb7YcdUgQN/BWpXu
	8rd9eI19obzRAxsy0gX8Jmx/fXcVB5je80dUDm1mntXdwy1mFZSQHRHP4cp3qvYR
	d6akW+tEYaE22M9eLUY2sMPS5Tv0Y+GE9/VWjOxwU0KDTYyO98OC7G+t/hRANZ9c
	98i89jroHRs1m0SmeLYBuODfR0tvYxzGqr281DWDOcvNgWu0bTXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abswx037k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:00:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB0WOZF039929;
	Tue, 11 Nov 2025 01:00:02 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8w0e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdirRGiyuV/TFPfKDmrELTjy/g8LvxAnFX1iTBJsa3CuMjq5teP4aqwNgtGgIJ1Ta/ZopcBgTmNytpW300MmUOo7rLE+kGWNVpotA8fu1Do7MeNKzwbkuveHC9Qi5a6Q2sSBIjUP2ez31qsnG0jpvgowBSz7xLuQQ4KTqgUqlEp5kydLVp+HZAXaImghHBs/R/Gqvo688HgEEIE3aIosAr2iYLcQkQHNGmEmv1WMYEjDqLFYCsoL/OYVBbnOFQviWP4gX/6BoMj6owWnygoZMwVUBuP1zMSdaHMa5xTD3fJJhvJrj4MXzveEwS5BzdCdfmRCRx3VZsZ/7c5J60sx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mj3sFWy09ZIZ9CuU+yPg6vID0GQyqmUY5URyqmjQRU=;
 b=oWU5mKPUcGXQ5Q0ILqkotvCejYL0NyGpMJ03b90Y8tSSIHud7qHlRr/8pUkljwDk+lRgOFudzv0yfRRiZwZhsSTgQ/XkwRq8SdbbikmrwWqkNPKSBbdRHNBITVAikewF9F0/hC/DNm32+aXWNNNLw/wZOMdVXMvXeX9SfpQg3nJHdUgpuL/Zj8sL7CafR+lSylRe6TUbG0c2JCQn+Qlshlxoph5wg/ejmOC1/GZ9AxejRmNXnOvbR3fd9GDpqKMqmVQDVUvYN+v91Yf0Yhm97QRhr2j0jJv3FW+O5plLkDIsDg95gJcC64lJTFlBk7DWZ6MJwgicAuFfu/pfzgiucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mj3sFWy09ZIZ9CuU+yPg6vID0GQyqmUY5URyqmjQRU=;
 b=Gtu3pGpDeakn24wy6XJsIGldy7JEW1ZUCKUUMA9BmxknRA6qp0iTDgqPyOTAvg0qlHmhWjzSKMGP6BnQBJ1gl94gCLRMXr/BRty8YqfYVafABnhr2h7XBbVfRHz4lxuGEGvjyx5kxJ0Uej77W3/JuP9AV3XK1nKZ1z+PUCNFPNY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB6384.namprd10.prod.outlook.com (2603:10b6:806:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:59:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:59:58 +0000
Date: Tue, 11 Nov 2025 09:59:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <aRKKfdN3B68wxFvN@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
X-ClientProxiedBy: SL2P216CA0204.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d7b601-a96b-4c0b-f8bf-08de20bda2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8vFu0LO1RXonPZGyh1bMD0kP/PwlrsRnJJTkY9IjLmyFRPScSyHCh+Df5Rsd?=
 =?us-ascii?Q?b3JfpGHN2otlRwq1ZPq5BB2VPQn+dSUYVMR4eAnR1tckLdKmr+sijkYFbw0r?=
 =?us-ascii?Q?xYWAEnVguYNR9rZ4+bWoSgE0gtfj1XYnIXhD8ez/ezBS4PLm+2lYfGmLB/kk?=
 =?us-ascii?Q?pyYf7tqNCgoWITZ4tJD1BRGDJ+s/nSiQye7YPr3MgQ4XUf2s7I6Lzphs4Xqf?=
 =?us-ascii?Q?/9cliiv19GYpfC7GrJeGStJoQPvURFevr2xT80eStzw/f/yIe90ybsscg58Q?=
 =?us-ascii?Q?NKIi2dp3aUfzeIMOM+lujiPUz2j0/r3bqT2bHFmSDbrRXLPgoyIIVJXexN10?=
 =?us-ascii?Q?4jiUcjEPMywWbYTY/qVYe7cxdqTmVFQ2Tjmccj13UR0EnOHwygt4YQ92YboF?=
 =?us-ascii?Q?vA8BDvbeOBc+O8e32SrSlcCjMvwy/5mrxI4kSMqQDDEOL3RhdLFPI5uefj4n?=
 =?us-ascii?Q?LaiHXcFxAyBBCG+VGs7Ky8hsB1VqCuc2mCkzhMBCbEvIQojOu2Ot2xtnpzpj?=
 =?us-ascii?Q?OwRImmFqsi9x17jzJ/42DvVPeLbJ6TfsCOEQRYI3nwFjwJRIBTWzoel0hG9H?=
 =?us-ascii?Q?f6qWo9xDMA4zqWZsYwj2f1qdobBjxQUG7cW7Cni1URRUod6dqqgVLwp+h/cR?=
 =?us-ascii?Q?rDG+ob6eTkj8Q0YBUQPGQIa5BLCN7eemZo9wUQCLU+eODmsFSzgLx7U3XCST?=
 =?us-ascii?Q?psLPF2l+h0wu2jMavvW6DHmVV/G0ogsEiOKZY7W3YMwSOz/vyPBmLX217xrL?=
 =?us-ascii?Q?pDzXnojKam2GSfRw+8aTqETsTRIPZFIxAZHVzXAL8exC59glq1qUzAhGKjab?=
 =?us-ascii?Q?1e8582j5zzuPLmm50dC4hagJEoWwL2U9KmSuFEiBM9Hmoy34uM5cNiOgMlDd?=
 =?us-ascii?Q?Svew7bfJgVmr19jDvsyTnWTdJFpsjmwgzMTjEaJYgmy7HMKE4GSBHtxmzpE4?=
 =?us-ascii?Q?zcYZwN9zr1fkQRFeSFYU2v00xc4QLVSSMbXQAVmsWBVgoQCKbm5sz966y8+i?=
 =?us-ascii?Q?0PbMpUoTtm3S+OTsTvjMVxEt8V10TVc/0cRfUBLrTv6jcLsZjWYzny5ofJKb?=
 =?us-ascii?Q?2bZzmjZyQhA3pYRaoX9BOkkU7FOi31LmWvGbY/DyAL6b/xy2a2NMCi4f0sBG?=
 =?us-ascii?Q?lD1/HtTrQqL5vdkBmVzZzvTbs0i+/KWOpP4ZXMECgsG6oUeR5G0OQ9YuOR0g?=
 =?us-ascii?Q?rI72NduYErHFrL3iCyQIr8zf3VChKKW+S1rOgnFgHWIJf46qn0eQiLNI/gs8?=
 =?us-ascii?Q?PPzxagRj+E67G+1wGhQyEx2iiDyS4CYyIY7FmqKtxOMaqaUzUmiN9oqiXNYS?=
 =?us-ascii?Q?AEaen2QHCEysL1b3ofxyBaNUkCkbdvHB0tQ0OTv+foZKoYpfPuKsF/tyn4PN?=
 =?us-ascii?Q?bS46GKI20g/BsTaBIRwDnC80MGp01JRcazD+YkDip7i/X1ZKuph4QDRZkdor?=
 =?us-ascii?Q?wLZ6F9jDk0tQdHRt+bkl9QTFbKr9igeX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05kEpyCNWUrRmk3tFGSXtBDjxQWsmiqtfUbm0YeQVT9+yg565ifoM2RlPTaR?=
 =?us-ascii?Q?MEikpefu04qc+4oH55ntzyzfUAlkP6dBAwVOm+HOjrDzS0zSisPWzKOjLlw4?=
 =?us-ascii?Q?jxoGOC1BEs8yfKt0qmE0KOoyBO/2A50RH9PHjGSH647Cgp5efmyFSXlOpu3+?=
 =?us-ascii?Q?GhsDx5zVylndyGbB/EbP7na8YiPizBMvHOJmRzZqpAtBInre9YEm7uZS7/fh?=
 =?us-ascii?Q?GyJDScz0aY5pJZni8dwtoZxd/rHFFml7i6QqRKkLwtt9BSTXBT0AD/UPEs2C?=
 =?us-ascii?Q?Q+DpVcq4bOPnJvRMjxFEmhyXveBwRGVti/SQNjDCk1xPaFv0AnoIFgjayaZq?=
 =?us-ascii?Q?ipUz/326T9EJeNx4gTmK+a5PjyReXu1PqGGXNM+yPzb1aBR0vSTQi8llwOcC?=
 =?us-ascii?Q?s0xPWM/fQhfFbG5UzWq+LtA99bBuCiV9LOBEEzP1gChsJFn7ar03QiCspw4b?=
 =?us-ascii?Q?SG8Sxpx0ou8ZyQMHFZE6hDy102gd9Ubyacl5gu698c0yu6PMvbAh0H31TZBS?=
 =?us-ascii?Q?Rc/fSqVyeziPt4jL0Mmc8tLnd0JjDvbLSg5aYYh+60MR3I+HVQaT7Pn6x8b4?=
 =?us-ascii?Q?dH0qdyXZywvWC/qQLVLjcOYesca+fqe+fuA9+GCyCofkjF0fI++C6AJzj53X?=
 =?us-ascii?Q?EtuGCVJB5bm7HEVfj9xW8Ta/oC7MJExUCByI3CyHORYaDYkzguxAwpjWSGhL?=
 =?us-ascii?Q?mnTt5IiJ5oTtr3ppcRELxe7JZZkaM7E4QB4z++HpS82BPSMvopjwJh7TZJK1?=
 =?us-ascii?Q?vl+IXQZ7OV3/1J8FhERBjZAkQznXK0/5dt2Bl387Uesz+LDpLU2+fq4Y4JwN?=
 =?us-ascii?Q?xrJVuaJ8u9BrRbvVD8hGivmUXG9KQyCIz5SbAk422kje0NgShJlE79QxhI5V?=
 =?us-ascii?Q?RtZIFgntB3KewGBvtExj6gicd8EEm0Z1RLzHWQ9BFlK4/dOkdI4dnT0fXfZP?=
 =?us-ascii?Q?7ybrSqEFKAiqApPpRwsd/EXnolFQGW6t3+uufBLB1ZC30lVNLXu904mErV+i?=
 =?us-ascii?Q?nPT+kEfhxLT47/NksemqrUW/LUg9FAs7nUinQtCwqU/EQ8uqcx2wV/F3K4LK?=
 =?us-ascii?Q?FoY21PiIora9ow39u1vAuUPEMKz7t5A1nTY8F96s+EXpZdgL2PlhzJL6U5K2?=
 =?us-ascii?Q?G4MA2q9GvQ3Pk6fFqISY/stJ7pn/GXLiF9z0KETXXWXUfzXlLU7gQ7ju5tYc?=
 =?us-ascii?Q?xEFRNGMWSt3B8xqpD62C0Rbw9cC88gvaTiJ/kvq6XD6aB+dRHa4QpDo+kyxT?=
 =?us-ascii?Q?1Pl0oomGgOwruxvz9ulaFh61oYex/HxALhptbEMBY7X76MkHxoMhcp0qes1X?=
 =?us-ascii?Q?n6kvaJ2HASTmE8a82uVhzyjHQCB1BOF40QsjKLvfu4koz7F3vw86anYONaPx?=
 =?us-ascii?Q?AFUkFWRDmh5z3uwRzYhrSdghrbhZUrY++Lgyn/8ILIt7fdamyr8ZD2KcWPTs?=
 =?us-ascii?Q?r/TqL9Pq9eaG1xgIaPNpRh80i1cVKLZXePTzYl9bwSY0xn3L3SbY3SC5jn9f?=
 =?us-ascii?Q?++zQSYPJl4GOg5ucXVLiu0ugieZ7xAdo0yMBc5IH08eSW4nPPPGHKz+FeiY+?=
 =?us-ascii?Q?uNosWEIqHPvQ6Q4kQQLh4nQjU9dEMHX6CpMaE1Iq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ybtIpjWreDXL3pDOqI7jKudEJ02CVYfAzPy5g7b0lNB5Wp+Ttcl+05SKabOvM5IRCqocsECc3Z/m3f1yq9ZyJeOFKk7AIC3Uw4PTfX54gPl8332/IFhdCsMDdsrD+Jmf3mMgVzRmZWu6Y+cTfqeE/4To5XUqIHo718ZOoGKeBs5gZBFwklevANl0XT4cJCj1Z/cGxdtix5CLHwnQXvd3PQAJB0toKBgc/T3c6QtP2uW1fEF9eLrOa301wXybe4bmjwZhVrqa7qYqefzf2b7EyTVKmcT/7dadbCGIV1qIMqUHEVL9LGgXk73VWrWSnyuDEEtQ3GKqv0p2aQUcqUwUmUA/wTmeaEmKj67VQzC5kBMbi/6RrmkbEcMDM785YPshD5brm/BznoIKqDoqX/euQnFJIQFHdF1LYeNr75Gra6VTYElNjxKQS+d9QhvOBHl3eb0nt1ur8WbAVVg+QoiHdQX0sp7EcMCbJ1W7DMFfPoXpez63ZnLQtK5Vs/vypdHUsOyylfqww5/MO/XX5G8SMDA9mtWwoFeE+xbcF97B3zyedIS+9hlZlsBdGtsFYXO9T0FMcDW6tzf1aac+/kuERgqqNp37VktPRlIC8451lIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d7b601-a96b-4c0b-f8bf-08de20bda2d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 00:59:58.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0b9Boykm1WXinWu+FvI7/TStD0sPQMo94/RYUSwuWNmHX+j2f8MKez3fvPwQmUx8fLs2gUX92wPMzpu2p7Y0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110003
X-Authority-Analysis: v=2.4 cv=L/sQguT8 c=1 sm=1 tr=0 ts=69128a93 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2Ihl8k3y6r3_0f3FCn4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: plIkdyrDP1jCdRbuKPJdszAk_JwqeuKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5OSBTYWx0ZWRfX7MAsQKaqWIDy
 TmC5fQsWr8Pt0dZAt1DgEfHiwKuXmO8cZwUhYwRboPueHX4V+nY78WD+jAaz6TxSqgudsCAdWMi
 R111IDk2ZDt90RgNZVkbLx4yckwq69sVocUpdqfq/9yUArlzQGc/MKuP9LzRqNLMjkSpoJscAJo
 zboEXE6mF1+Vv80Wn1o2RK4qgBNlyjoYXcN1gMGaqkmpOsLXgrR6E+yWR5LSIcXMBgRJ76/US7h
 yCKoTMu8YQwbC5HNSUyokXFEB8gNvUPXQn1r3B3b8HPt6B6QDGcVoRlGKu0z1Xv2g8JGiYcxTnP
 Hg2XVUxOg8hUF4DDZRscYPW7X3MYVMmTj3Hzg7tW4JW1reAEBTNRORrwW3VT6wULLBBa2u1A097
 lu+Yq9AGFjqcmQXflxmSzPoHrBqjdw==
X-Proofpoint-GUID: plIkdyrDP1jCdRbuKPJdszAk_JwqeuKw

On Mon, Nov 10, 2025 at 03:20:04PM -0800, Shakeel Butt wrote:
> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However for some stats which are also maintained
> at node level, it is using irq unsafe interface and thus requiring the
> users to still disables irqs or use interfaces which explicitly disables
> irqs. Let's move memcg code to use irq safe node level stats function
> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> (all major ones), so there will not be any performance penalty for its
> usage.

Are you or Qi planning a follow-up that converts spin_lock_irq() to
spin_lock() in places where they disabled IRQs was just to update vmstat?

Qi's zombie memcg series will depends on that work I guess..

-- 
Cheers,
Harry / Hyeonggon

> Shakeel Butt (4):
>   memcg: use mod_node_page_state to update stats
>   memcg: remove __mod_lruvec_kmem_state
>   memcg: remove __mod_lruvec_state
>   memcg: remove __lruvec_stat_mod_folio
> 
>  include/linux/memcontrol.h | 28 ++++------------------
>  include/linux/mm_inline.h  |  2 +-
>  include/linux/vmstat.h     | 48 ++------------------------------------
>  mm/filemap.c               | 20 ++++++++--------
>  mm/huge_memory.c           |  4 ++--
>  mm/khugepaged.c            |  8 +++----
>  mm/memcontrol.c            | 20 ++++++++--------
>  mm/migrate.c               | 20 ++++++++--------
>  mm/page-writeback.c        |  2 +-
>  mm/rmap.c                  |  4 ++--
>  mm/shmem.c                 |  6 ++---
>  mm/vmscan.c                |  4 ++--
>  mm/workingset.c            |  2 +-
>  13 files changed, 53 insertions(+), 115 deletions(-)
> 
> -- 
> 2.47.3
> 

