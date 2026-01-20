Return-Path: <cgroups+bounces-13318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACBD3C2BA
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C6E606F75
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FC3A9D98;
	Tue, 20 Jan 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLn5eY98";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yw0WkX8Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D63A35AA;
	Tue, 20 Jan 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897393; cv=fail; b=mH8MyAJ7KwfPazb7dl45buaeaQhzLVtezLx2oIG7EHdM75h1+oM1/OQukOxasmqLK4TuvWcrn8GDOvG+VFkwuHR9jeOEp+hQtZk2Qz6C8Dd6Xp0cw9qK3kmfZ4/eDrT8Dle9Vaz2+At+Yo7c46bOEjwgAKZNN3VXqWMJIAfcygY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897393; c=relaxed/simple;
	bh=oIs612h24KScP/tRPGB9WOc++VwB4TwJk/vdjgANHiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=raDHZkwVp9yY9eNkuJoqqYBOhaAoOCj0i4Ny3jvK2Kv7GJ5SXdSyF+/rMLI7WVQwNTAScHZPC/T4Aa7k67JxUeZB2KgDgZcX9l6pLnbJc29SbFjgiR8JxgOiR0O+UKJFhe2jHduFIYfWz58aNgPDm4KAV4gIta/mwXuwSgYBkeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLn5eY98; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yw0WkX8Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7v8rb3430913;
	Tue, 20 Jan 2026 08:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BfYHl3Or6iuRiNrO+F
	sjAWkAcwtYBHxt/Yf++f8NuEw=; b=RLn5eY98j+Yh/fLMQMHlKRQAwLL2Q78YgT
	q+svgyD1lbDTLB6KOVwujX9UFxJB/MH71VNZl9VS7Jv5F4U7SkSPbCmBZa0lkhgd
	SPsEeXLmjs844a3luox3tcrKdkxyAQe7ydDH6zAgJTUvlc3I6vBDgqtTp8YhYJSD
	cDD5MwYlYY17sJxViIGCTrHBnf0+kGwQgki82K3kYJLyZV4VvwMYcIpIrGPn2RLX
	PsqXHYhMUrdahneJovu7gJWO7F2/yTcCiLs9RFN2flD7y/utefk1/VhsA+KCe3cb
	HcHaQSQJRuqAgYVd4Cq06DLq5gouP7knhwl8Ipsv15JWo8Ei81RA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5k5hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 08:21:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K6JdxO032191;
	Tue, 20 Jan 2026 08:21:32 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd2dv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 08:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGpW0T3tCmBDYZe/Ibj1meN3Qo4QEHRkkDDQQFdNynJ3ZC5SoTVl9jYQpoNinXCez/bTkfu5wJB9yfYI/AWvhA/tJinpzbdPQXQsy8GlILDgeozA0W2W28mluKRVuj+qVIrJKIpqfzJy2iBlYoW675XJ1tUZeu1XifYyEjp4pbDBYQogh78zSsBOrQhTjL+6Fw/gaBiSQjFQv4Crp0WjnA7jnD79LtYZ9kfS8dLjCzDfU6qOazyNuDfp7Hs40nLqQ0Ag/NQOo0tFfP2MF41apC82c2BlGepwEy5NL/V97It4D3xHmQfLEHb0ItJ92EmaB8Kft5ivJ+BjJiK04cAKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfYHl3Or6iuRiNrO+FsjAWkAcwtYBHxt/Yf++f8NuEw=;
 b=HfbDt4e5utsFdFLKThDBdaxTCJhHjDJ/9Ht0BmVKRBvkQZu/vpVXcKv1DJmhgzeQL41E3KXGnPflIVbsHc+MphkW3KaxuVnbl3KBGdMfSmdGs/K9xgbk6OQljLKSfO1213yIDn27Z2hn+6GEN9gWjYb+qPGP7RzeFHJTSrGe/6ne4Dwq39Lu995HmLu1Fk3l3XK5ghjorM2Lx/t+72a2ivE3tHZL58I0GWANdgcrDGKpdVLTRkRXxYMsEKH/TrjOXJEKYOgBOP5j3MBJfDEAXXFTdeMkoYMu/zXvKl+QW6dSVukk4BVQhAHs607tItNQbmqws7jxaIOrqRahBaNlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfYHl3Or6iuRiNrO+FsjAWkAcwtYBHxt/Yf++f8NuEw=;
 b=Yw0WkX8Qn3/L1myQqZxvDeLCtpPXPPNPuOBS1+K0m9vxsedSkyp3l6ZO/RS69ER7+8a6VSp3YjdSoWzA6ofcSwz756RrQkVhwudUu/Q0m1KcYaQrT7qr3KQiZMAUmZ+Bao0plcpMkhRQcSjocJk2RRk/ce2npQgG6V0OPn/ILpA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 08:21:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:21:29 +0000
Date: Tue, 20 Jan 2026 17:21:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <aW86_5SOdtQQnVr7@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0153.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: cebc0681-ea37-4d38-2d4c-08de57fce97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZNYKHHxEGlAEN/sueFx6LzVOZyhNf3+xPkTbnj1T/0rgxWcnribOekSedb06?=
 =?us-ascii?Q?e/fRxCaJ+jZUSdHLYBmOjnqYC/GPvengMnJwK2Pb6Dw/iDvSD62B+bpbhVFa?=
 =?us-ascii?Q?Wk2/gg4cT+YFgzFVHKaugxzHmQHQTT1/g2zb25m7YgNOXWRF4/oz6FDyHTTd?=
 =?us-ascii?Q?MQQW14ux3+Zd5slt39VoLln+xytGOEOr6Zt04MlwjaHGq9jumkPspiX2gF1U?=
 =?us-ascii?Q?/znEq+9FICLVG9FURlCmd+nR3prxbzXsRJNi+CISGaC/apPtD3rEYg50xt3M?=
 =?us-ascii?Q?+SwKC5ospyeGWU0Sr0HsZkfbYgjRrUdydsbN6vdPUKUvGUwEoR7fJnZBfmy/?=
 =?us-ascii?Q?bw5NMGIDf21+5nci1Rd1Nd9d4OxbdqwmhO0dVF66JPGQoMcm1+Vum7L41Btw?=
 =?us-ascii?Q?TjFA+9e/9rh2F1dxROSgWyTEI1RWeZg8ZplyGXTs5YGIfDROOA8GxEHCrMJ5?=
 =?us-ascii?Q?iGBgaLDwLB2kMl9P8bmFss2RNZZ7CDT9aRwcQ5NvR4Fu1gE5LG3n2LvhYTUv?=
 =?us-ascii?Q?vEhj4to9tjMTSeXLI2YMAOIl3pB7uCZWnR4mr1eNnXqvpO5Nvtmv3Do7BfB7?=
 =?us-ascii?Q?gdhqzbBYUKnla5XWUS75jRAYjaOcs3Lg/ynsZ6Q7k25V+7NKheGskOcKrpnV?=
 =?us-ascii?Q?xyTup8e7WTOQWKo3tPncM8SDjOl+sY0PEqqFLtcV5iBQiOTZaEDH2qQMIxHu?=
 =?us-ascii?Q?neoYcfz0HpvOsBixU/zNq3BpprgfzXYAktcmk0MVizIlPpAVkjcyYXdICsgl?=
 =?us-ascii?Q?fTNT7J1zsledh8MNrHqhVYo0WpUFSDQcAsSmQ6t3GjZTerE9gjmhl+DLmmkY?=
 =?us-ascii?Q?hjB/KRHtwvqA5jAkFJp+7IYES8RSjOBLHVh2r97Ug3hDJriqBeGUDgjM9NyR?=
 =?us-ascii?Q?dIxsguPV/F6FrR8J8OkbBIDZOC5DH2XQLgRX3t1HxzRIdlLNWbTljCGE/z+V?=
 =?us-ascii?Q?ssrPUz/s5C+ywoRvg0y5+Pu0cI7JRB/wv8ylvV0zO60kDN//aDelGpkR4wIb?=
 =?us-ascii?Q?DkZEI2BJFehBOZYF2KjGkX+dYKPzLYkuUW8kTWAROuuSD7H1nv3vo8CqHhdI?=
 =?us-ascii?Q?iJ5LAl8tGq6jJrLiGB86Pclidjbd3M2OG2DmqoCDGnVglTYQqsUvfcK9C8Qp?=
 =?us-ascii?Q?tdEGayMDAKwZ2sEoKE+x9B1fGS82m5g8i8MnlipXgAm//C9jB/+/fSvgZ8L4?=
 =?us-ascii?Q?b+8oak3bGgvJvDbS6pVBcEjfuod+ZpQ3cP5Oj5EZXlE298rK7Zo48T8jEhaK?=
 =?us-ascii?Q?JgsROicMwVoyv5+DvY0EB5m4/PCqy/dRe5UBo1oR8PEyZQ7DGckFntsiGYPZ?=
 =?us-ascii?Q?NmsL4tZVie581K/iAD7xKx+6gcqCOWFhjzZpwD3o8UVw50UMT4H4vyLigVWa?=
 =?us-ascii?Q?wWIiqe0y9sZIzUJTZTutPEG1CNWNMvFxmJCkMOheq4VzWkhK+ju7fUZT4/Db?=
 =?us-ascii?Q?jzJoi8crjbityVHS2E5DgIe5LQvx3M6QUB+jaCNEwm/a1arMB4dNUzifLh29?=
 =?us-ascii?Q?qIzCEF4VUWost9/JW9OCT1tSvHLyu/vak7+gHa3tPHZ3IAYi0VV5ia+IAf96?=
 =?us-ascii?Q?tGiftTwb2fw2wfF7ODc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1bAP1VDg8DIhInHYTNMf35Yiz0qixe0GIx3ia/6Ni7HOBT7ijN0Xdr+gUIh?=
 =?us-ascii?Q?t/W8kyPFZPMKCGO2VlgiiW0UWY41rmZUBpbEwnodAUW+H4UZ4jXkoHVBXKn3?=
 =?us-ascii?Q?mXb0niOXsRa9g8mBPqLzGlKnZnlZdTimqjfbDrGvqhVwv9JUsipfn7kZeuTh?=
 =?us-ascii?Q?FREA7b/XdOGh3Tj0IROsQg3mr/BfiFZnULDVzLn+1NptGZTZb7bFHPDlC1CS?=
 =?us-ascii?Q?yFJdap1Ux50RxigIH7BJKCVEShe+A+kAbrGoLL1/46WP426VKH6BrsgEZ7gF?=
 =?us-ascii?Q?WTpmZDwCrsxdutfwHo8MyBMJ3cubEPoWtrKX3i9oBrcBAeJFyRqvZhamNs1y?=
 =?us-ascii?Q?W56Obx5jQhDVg5OwG3iYoEt2eILk4W5PdNduOtGzz+ru9v/sr1Ss5pxDBaGR?=
 =?us-ascii?Q?dVRN3gMz2V+Fdrffun/JN+cHYYQzZyvBrkOtMrNvtuFNoHbqmp5KkiWnqf2f?=
 =?us-ascii?Q?rQFQoCconh742aW4PVyTK/rd9twzH2aQCJ63QKUz7uj/UDcwt0cyPsPE9Zmd?=
 =?us-ascii?Q?j1hhIc9b/2aaVJH9wCtRg2yTGJCON51GrIVVEzpA5QhBeMHZg9bH3p70u6ja?=
 =?us-ascii?Q?brr78TT2MtgytAOYqAf1UZH5wHQDwtkjN/StQeBQaUH+DZ4CnLbvyq7+RFbn?=
 =?us-ascii?Q?ekh8tf8I4XutytjdI0FEzyFGk1ojgu6BvJNF0gM5GggzYgl7cFtiMW3h3TJ7?=
 =?us-ascii?Q?xTrkF48hDKCPw2QpyuuRS9z4xvsMeKIpSuFgcPclg1h6tiT/WmwLDIqRbdC9?=
 =?us-ascii?Q?fjSp0zqkLEFH/KuH7DSGjb5lp6Ku1GqroImJs0Z8nQYtAkbLdQ+3zDOGpuUC?=
 =?us-ascii?Q?aegbO017QAcSTwiLk/i4lx5KORoMRJZWHlIh8ZTvZEpNm16E4eSmFpzAg8bM?=
 =?us-ascii?Q?0R1zGf/xtvkXYgxGRsG5pTlSiDTTI9giZz+oevMwXHiSgwtktOo0GzPlq9Qi?=
 =?us-ascii?Q?QaNyw1QayZmWI/1O2grrCNw3+RoVq06yAZDMbVGMCivqDnaIWuQdUjEdUvqK?=
 =?us-ascii?Q?IL070/IEU5mBZeeuzIR4/HdIUFyN974tOb6ssTsZrJgwl6Ou3KW3DzUravT4?=
 =?us-ascii?Q?AQ/tYlssGNYK0c1UkabouwBAtHuZvicVxXzyU6MmrlxJ1mGG+lWXgChzgkF+?=
 =?us-ascii?Q?ss7Mido/QAnMSeU7Yxa0AZT8mBpNzZqFc9Y6CaGrp4XrvpjekGCTfniL+Lhb?=
 =?us-ascii?Q?U+Jfqm3d4gr6SjRdfe70ZRw0VBj1KYlqRBNC8K0PpQ2+aVsyakGuXRqwHIY/?=
 =?us-ascii?Q?EsfXQlWVHnVBx3wj72Fww5/gBsSyII3xGkBdtcxAy3kbqMy2t3UF5gsWrqPP?=
 =?us-ascii?Q?WgHQ7eclcBFNLVD2Hw1sxIJ9czZx5FRWengpxxI4jwyu8IHxNa2p9+i3loP/?=
 =?us-ascii?Q?9yhjFKSd3ob491Bvi0kn/Ejq6+q5N7Nxyiw5abygn3OT2fVywOz1dDVIqOrv?=
 =?us-ascii?Q?KSL4lbJEfnI24Q6tXAjxk7P/OUvPX/ScjPbDzEF4RIld0s2p/KTiAev1b+Cr?=
 =?us-ascii?Q?UReC377+j7iU8AKRsQvi2+GpQ54q8tUhgX/+skEpkPj8DMNq6nXt8Wfl4nox?=
 =?us-ascii?Q?LAXId8LBXhi1TB26EK1yyqQ4LUzPc9lQMdpDOBftmmMMBkDVjOGG6sNPKPPc?=
 =?us-ascii?Q?7vdRb8Ofec89yEQIJcUgNySyuNR4wuZAeAnvKyIrl7fbBIY1kFMJ5u4VHrhE?=
 =?us-ascii?Q?+RVX/ktrABTDMmfxJ9MPrURmhyEeSuUOX19AU2t9XVqCtvFopJ/REpxRrXSa?=
 =?us-ascii?Q?h+03rB6Sow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XcjmrYCG8snNl3HUT4g9ubLRIq8yRE5DMP3Z+TpTsBozAspVKJyMWYqBlCGErva6/9IX/xl56WExcoTadDGyQYN7FOhlFA4dSVe88zGLFnOdmOESeD9xpoJ6tiXmxcTrpTST3IZdpWKCUrvkIxL6m+RAJy+0nt4Cu3xsgo6hY1scy5a4KXZpyfX1obE2awjFzUBOiLNnHrRhUOtg36ogqLKBRdoetMuE7HE12gJH+RDfLuYCgocJnQzCNuSrcMbEwyQAoRORne8MzLaI3goIkns3vXdm5TNWZTLU/w8rQvQQ7YSLSJjRHwGispIcw9/z3TbYxAaKzLtFDfxzJ/nj0IOaXfbdnDe1qutXLWcKLSoWmL6AmBP1FJrH7r/52DPbkLHK548ARpU589C+n4KOVEhNCytADDL/D9yBQaZESifXMwfv0PbP3WHAEJR5ltY4D54h5AVV7dpvL8LISgisyYmFv0EbCZ15LWrf4X3ET3Q1zfrqW/4y1L4Q16h/dFPlwQmto9QrpbItTQ6VtngrOhg0pDQ9BhqFBQrWGDoo9Jqo/FfJYedB2Ed32wzqHBBBATUrxk/1Y1KskD/uO+dWe/SgYKEkOXM5kgz5Fprka+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc0681-ea37-4d38-2d4c-08de57fce97c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:21:29.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/8YBRGf0A6FPdOY5GyFfxCQgSJj17OK7+aBcu6qAkt7SHaWV9FyOXHOWurRxJ2z7Ab7guDuUBbZIE4OWBMjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2OSBTYWx0ZWRfX6cGjk665MKov
 pylElzjtplYWjX9tZB6jp0/UOeo9ZIppnKAt0Aj13jMv1sRwxe/FVeSzcF2yXw5juzZNiOMhr25
 I4TZS9iLX/th0NWg0Cz7YkjG71HQ5Owia7PjwKgljAoyRMo5fpP9daCEDZEfoB32x9yFyFw3Kr5
 CD10a9+XQAMUv1H75B2q26EwigNNoaKjOZgoSQgsosiHQNcSb2OBwquyqxCcGGrA1MCXnU9WGTN
 TutALSPAS2V11BL/ZMkdReEfCDyWylPz6P4xI47bsXb9QlpveRi5FgBw9H7+j8JicuPHjCQBLzd
 tBNqbkNogyJWULIM01lRycuTtkrQyUbR8+VC63qL+qRGfPu378TWA4jHEhLfuqegdrp304QiDB4
 YqJAhwWqF7aWwSksIcX9fvKe9xEDGp1flW2Fosqr+WDX9B5fHFbwBpV/+acSAtXpUhaxBlJJHJ5
 cUv73I5T/OgOCEpDPtUySeGvwGtrVIoAtYyRBpzg=
X-Proofpoint-GUID: 8QtRc0FT0nOmivcni2smPMxY2dmpFZaf
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696f3b0d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=vnbn0GdLyxwCu2Ke3TIA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: 8QtRc0FT0nOmivcni2smPMxY2dmpFZaf

On Wed, Jan 14, 2026 at 07:32:51PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The following diagram illustrates how to ensure the safety of the folio
> lruvec lock when LRU folios undergo reparenting.
> 
> In the folio_lruvec_lock(folio) function:
> ```
>     rcu_read_lock();
> retry:
>     lruvec = folio_lruvec(folio);
>     /* There is a possibility of folio reparenting at this point. */
>     spin_lock(&lruvec->lru_lock);
>     if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>         /*
>          * The wrong lruvec lock was acquired, and a retry is required.
>          * This is because the folio resides on the parent memcg lruvec
>          * list.
>          */
>         spin_unlock(&lruvec->lru_lock);
>         goto retry;
>     }
> 
>     /* Reaching here indicates that folio_memcg() is stable. */
> ```
> 
> In the memcg_reparent_objcgs(memcg) function:
> ```
>     spin_lock(&lruvec->lru_lock);
>     spin_lock(&lruvec_parent->lru_lock);
>     /* Transfer folios from the lruvec list to the parent's. */
>     spin_unlock(&lruvec_parent->lru_lock);
>     spin_unlock(&lruvec->lru_lock);
> ```
> 
> After acquiring the lruvec lock, it is necessary to verify whether
> the folio has been reparented. If reparenting has occurred, the new
> lruvec lock must be reacquired. During the LRU folio reparenting
> process, the lruvec lock will also be acquired (this will be
> implemented in a subsequent patch). Therefore, folio_memcg() remains
> unchanged while the lruvec lock is held.
> 
> Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
> after the lruvec lock is acquired, the lruvec_memcg_debug() check is
> redundant. Hence, it is removed.
> 
> This patch serves as a preparation for the reparenting of LRU folios.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h | 45 +++++++++++++++++++----------
>  include/linux/swap.h       |  1 +
>  mm/compaction.c            | 29 +++++++++++++++----
>  mm/memcontrol.c            | 59 +++++++++++++++++++++-----------------
>  mm/swap.c                  |  4 +++
>  5 files changed, 91 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4b6f20dc694ba..26c3c0e375f58 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -742,7 +742,15 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>   * folio_lruvec - return lruvec for isolating/putting an LRU folio
>   * @folio: Pointer to the folio.
>   *
> - * This function relies on folio->mem_cgroup being stable.
> + * Call with rcu_read_lock() held to ensure the lifetime of the returned lruvec.
> + * Note that this alone will NOT guarantee the stability of the folio->lruvec
> + * association; the folio can be reparented to an ancestor if this races with
> + * cgroup deletion.
> + *
> + * Use folio_lruvec_lock() to ensure both lifetime and stability of the binding.
> + * Once a lruvec is locked, folio_lruvec() can be called on other folios, and
> + * their binding is stable if the returned lruvec matches the one the caller has
> + * locked. Useful for lock batching.
>   */
>  static inline struct lruvec *folio_lruvec(struct folio *folio)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 548e67dbf2386..a1573600d4188 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> diff --git a/mm/swap.c b/mm/swap.c
> index cb1148a92d8ec..7e53479ca1732 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -284,9 +286,11 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
>  		}
>  
>  		spin_unlock_irq(&lruvec->lru_lock);
> +		rcu_read_unlock();
>  		lruvec = parent_lruvec(lruvec);

It looks bit weird to call parent_lruvec(lruvec) outside RCU read lock
because the reason why it holds RCU read lock is to prevent release of
memory cgroup and its lruvec.

I guess this isn't broken (for now) because all callers of
lru_note_cost_unlock_irq() are holding a reference to the memcg?

>  		if (!lruvec)
>  			break;
> +		rcu_read_lock();
>  		spin_lock_irq(&lruvec->lru_lock);
>  	}
>  }

-- 
Cheers,
Harry / Hyeonggon

