Return-Path: <cgroups+bounces-11707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF4C4508C
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 06:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CC13AE633
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18492D663D;
	Mon, 10 Nov 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQERsYcW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sGQDrgz+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62562E8DE6;
	Mon, 10 Nov 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762753510; cv=fail; b=iWiGTugj04KKw9tpY+YNTdB2Xh8CPlyGDNAfTLFyuLP5TGtLxGZaeGjFkk20cREsng1q9m/7cj45csCCchwnlGoeZ+iEI+N2MFPvMNS2S1m3KxunUuf6bC+hyaO9kFUkQw5J8pRY7fHa6zFTyBNHwU2+ZFvkc+BZ59epG0gNe40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762753510; c=relaxed/simple;
	bh=h+CrOH24M8ZzhWFFTBw0UIoN4/tFMRuJrBWsOAkkroU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RC2sF4VdPtnfcNAx/TrTgCginf4Ry6C4B4JJ8DlYKhwRXNEW4FABSDBlMP51Gj+zCyyemG5mv8RXGWRNDG02xAkMM32edi/4umf9+t7MPl7iuF3q8xyQ0o2EowkVmbUJb1hl9NGQwqGWlhl2I4AhexEL7pwkpg84IuQrtZ74nXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQERsYcW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sGQDrgz+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA5Qrh2009057;
	Mon, 10 Nov 2025 05:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fZEphYdvH379W6y+2O
	+OMuF+VGwpnrGZ/UviXgBRG4U=; b=MQERsYcWg+oWCnYEp6y9rV5opvkby/NVVH
	IAtq7tMcQuOm3VBYel1m1npUdwdBP9OMRuC87pg5unKTZYVK6izlYjuOYPsQqFXC
	vU8EfVDODm+WpnTRmzd5pthOj2v82Ngkew6u/qYXB2uRU3joKHyU2zvV7nDXrHBz
	b23HMXHNoqs06qwyq3uFqjkZcXUMoE7JUE4ESh7SD+Q4LuD7J6uLgyn2wMR32BKC
	w3gRBx1oWvCM5nGIsDOrIh7M8OJVoqRqVL3M4urGx9qv9unug/HX9Hyv9nfKIgzX
	2nM/t8IjDJFG2BosZ4oxhc9fBRvMRH2gmnvh99o+sV+j6W0fhQaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab0qv8j57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 05:43:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA52REE007534;
	Mon, 10 Nov 2025 05:43:35 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va87evc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 05:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veRMb9jL3zpQ+PZGq+CGSvJ87W2qeTItVwA/doQ7l1oQzlUFsj7bwxO7bcEMtWCrgryg/zrG+HpJgt26ltw3N7Yv2iU5qMQ4plmMVB9aEs0sE5GgWNLzYldwAZjFfOjFpq78Imn7m1gEq9M8v6NAtjtgHv9UhTh3X8luLOoOkYFKUoBgvClbaGZ+rdycr+E+6yKp7AjavNuUT4InHRcvIPNFerFNl02D4dydN7BjcyWdlANx7SyZgKv+9bjFfyZrKxwn+94yhmE9akpswqdqsdsOoXcOsI7DTprhfvWSHgupbvKzSBfbkYylsf+WA5lqGRyEw0DfQBL2OcU8ufHEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZEphYdvH379W6y+2O+OMuF+VGwpnrGZ/UviXgBRG4U=;
 b=M229DYVadeGRFZwM7eFV7fHiGXii9UWFk8oWQkWUKfdf4ZEpHslQDox/zXa6BF3unrMB54Fj0EJXvlVxhLqCPidT8cdwb4djI7iYOrs+Ps91IVCqcT1R6JQoEWJR7l/dBwuv7o/crYBzMaayBePMRJ14xM16wO3EYRlGByJdk90QEjbRcW6W7JUC6s0S31Ixwia6n4CDz4cw2zYCQzBdoBtzq6x7kPoXczEw916jeviLB8TbipP3WAaeLkg8rxWMx94C24z+Nh9syGhG4jbeJJzjR+4RWFdM+uHM4Uh1sahIqTJdmrvDeCMdhsxsvBNZfLOLd1VCAZhLnm0RIlitXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZEphYdvH379W6y+2O+OMuF+VGwpnrGZ/UviXgBRG4U=;
 b=sGQDrgz+YplsjcdObLEOYGuqSHaG5coxVcg/E/L46NfwVyDhRHK+Twqj26mEU/lsfFDLeuf2B5ZYoUrG1fWB5Pxw+CKFmNL5VlgxLYw7gqTyWMKroyXbh/Q+JUL9tg2Nw9OSWjZwZj6maOObtSOAPeAieF+lOKeJ1pEBv9g4hIU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7848.namprd10.prod.outlook.com (2603:10b6:408:1f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:43:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 05:43:33 +0000
Date: Mon, 10 Nov 2025 14:43:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
        hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aRF7eYlBKmG3hEFF@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
X-ClientProxiedBy: SL2P216CA0170.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d580c24-b0c3-4ac4-7cda-08de201c1593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXe4c0wUMmywUg+p7JAdR6dIN1YRa413lA3UK3xJrZsjauobPnLviILdJn7f?=
 =?us-ascii?Q?sktocmB079ZbT4HYMwT7pzFyluO3AKlxlY+ivUeCGzM1G9iI0/sPPPNty6Ah?=
 =?us-ascii?Q?puWInIKtAyyJYj9oYO90xZ9sX3rOJJArU3rj/tMfKmY4gvCLRjveYfuwYvK/?=
 =?us-ascii?Q?oQehtYs4c9wHtvJZhaZ5Tl9Csplu1JoDwfH90n9swSZfI6kW9zotqVaM5Ovn?=
 =?us-ascii?Q?QDXnlFm33oTvsUlgr95PZCYG2s55+t2YIl5GroNyraPgg55K7bzIOckauboT?=
 =?us-ascii?Q?gHKy6lp/2lb6bfbnXhK1SySJeyh8hJacU6gZvnG8ZCVnBi2FeZWgjUi3tHb1?=
 =?us-ascii?Q?ZVB0g3gYGRdo+/nqr+f9KFLt3cw3vsoqPC4kuQiL0dAHuVmQ3pCpGyC6VyOM?=
 =?us-ascii?Q?gQfASSMl5aNqc03Ka/tEOEUpavLsY/bJ9eJmLEhwN4X1Ika0nLmu0Ij9TDRZ?=
 =?us-ascii?Q?nxyQUx5362V7+LqROPB0Pr4yxKH9N3C7Z1ShXZh51Uut0YekfmZ0sY3kHIID?=
 =?us-ascii?Q?HuLmu4SzuQAGoXufgvfC+JyCTyZA2cF1Ubo/FRVTcaLLuwibtz/mF5mHMw2d?=
 =?us-ascii?Q?g+6TZLIniWp5d0tlZxKIOSFcqI83ZA6ItbPLWD452ES/eUxwXNzw4w9DMfB7?=
 =?us-ascii?Q?AiW0txjlFEtSUBEka7uYn3Pk0mdcn9jlyhTtML6taeX4o3v9PFq+re2vLHGh?=
 =?us-ascii?Q?oYTAbYwa776MT3t5eoa1IkbSdEPAKw1qH+2ZG8z32M1SD61OJkicxPwhb9fr?=
 =?us-ascii?Q?D1VMAzYS75k7wheF/EJEa6uGJIA52IBW9NQFrEfLqMlvCttQ92J5XXL5WZh2?=
 =?us-ascii?Q?Qsr+oiE6kS85QNYZ1kjnR1eB12Ra9ke053v4cgeWMJGCad8vFV9IMKv5OwJW?=
 =?us-ascii?Q?mw1m1IM1NFzV9TJVw6x0qCuIAbdz8x182HwQo6JgEBZIo/5Kq7N00bo2Zp/n?=
 =?us-ascii?Q?BZ+X6HaZckjSEUnccW47gUM5eaJzQuSbE60R6R2lHEPOIaBXuQx4uW4S9piU?=
 =?us-ascii?Q?9VJ2ebzi5/GinIDqamvvELnX8dmRz6tbZob44lrhGTlduin+Q7zJCxlYN7cv?=
 =?us-ascii?Q?DGifGf8usXfeKykT90uN3kuDX2MB24E5Ow4sv7aeXVwjRkMIfk8ffDYnfcLi?=
 =?us-ascii?Q?y6W+xyv3ILXJpan5GlH1i5kRmykmFkGnc5UsUyqLOb5DqFXiUtC6bIqD98O9?=
 =?us-ascii?Q?fsb4+xAvxE04m7JheeoMF7w9/w+UwEhMCDehqtP6CrsIJlcGNBzzHffA6Oq9?=
 =?us-ascii?Q?dSHy9tmoDUxdVuSSc7J5p+iyP53niJifpM+4I7FcD+ydsuctYAKJKzbcJz9N?=
 =?us-ascii?Q?RqP3KqeZhe3Cwf5EjZPChzHAawti26Hz7lcmWyT4Q9oXVIul41maTc6JclJq?=
 =?us-ascii?Q?pmou4zFPtOlwaoDkcUdMrtX1Le5mmx1BJmfVKeZOWo4PMIq5yAVWyMzsq7M1?=
 =?us-ascii?Q?aLYOBE21EI1ip0llDO6iE2ZtGlnseitk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Luo1RioyeSYt+bo0m9vfcOLOmbEHAOY8k6aZ4y6lyGAfmB8MCeB6pEvxrMh2?=
 =?us-ascii?Q?bKjaERpUseU2Rcx3jJ7bl31sqtURCYN9qgqggzgI21aUjyrZEOuaFXUGmq3i?=
 =?us-ascii?Q?dpmJ00XjjUeeEDFO7zwJE6lVeaelXrPmLm3sej5/SneoWggUZtiHyLLKEEs0?=
 =?us-ascii?Q?SxCPdYaFGxB7MKBJDxx7p1wPo29fdw+XS8FzFgZKU33iakbYh67Q1eks0m6I?=
 =?us-ascii?Q?HDpU3MgzlflHu7smcqW9usP0yS4OEMTWw6WIIpNvxD2mHUUioJyYLVHdd7H/?=
 =?us-ascii?Q?QG9RTzlfRRUseeBf/X32IBDJS4141ojgAeibXi8qMnoKDb9RSqyuXD8+CF3U?=
 =?us-ascii?Q?VcYnOooPwTLr5QSohfGzeSeepp2NGbVNFZ58w3a1dKWYjzSqu9/z2ob/bYnD?=
 =?us-ascii?Q?c8YCHn9VJ9nLzc/W47euVYxovIquHoGJSffZOtiAuKRFjz2fhWd2nJ0I37BH?=
 =?us-ascii?Q?RSj16Nxq80Gza9dYYQDZbXNW4s7Daadi5nZ6X/jD11vSNOw9NE6IBiumjo+v?=
 =?us-ascii?Q?r7WtLHIPaeVVLMwd761duXfP/ZVDpXgReQ8c6dr3E8T+fUzPIrEdJYOt+wtY?=
 =?us-ascii?Q?YWqR3b8T0g4kLy0OqL6DeGgHSAKVm5upMVGRiIcg4Pvp4pQRyCL6BJj3b9fX?=
 =?us-ascii?Q?LWxdBR2oPRXDrRxh8JmxsM6MP5tHFBzZFsB1iEnzVaONjTc47GKlIO+e2Dao?=
 =?us-ascii?Q?1ZtjsUmtzpCIEvtkdYMnluz+UuZCMZ17fgOCNr2cYZbAE5UGtam6079mWLwQ?=
 =?us-ascii?Q?6sa9F4TsgRo+IhhtK1422oqedcyg8HLwB208QJemWPmP7gqBnkIYb1DFY6v5?=
 =?us-ascii?Q?qWRzZogLsBNhSIU0gsIt9fCVHlfN5WrRXanh4cY6kqrAvg4UMvdjocIQfVVJ?=
 =?us-ascii?Q?Ktb0EiqDU+1AGSiZOdakf3b8M50Yyo2z4BrmEtzsIZ86VMpUVO+YLSN8Mjmm?=
 =?us-ascii?Q?6yEVoGGYSaR/XXZbhcGGp3if4IirvQPuX+LdjIUqsFGbzCoiom+disYsc2WH?=
 =?us-ascii?Q?GHu5NdvnsAVFwbNlQcCuIGjQJaFiWNKvmykutpJ7fe0jOw7bD2u8vBRKh60a?=
 =?us-ascii?Q?0dVMz9zjIujWH+lGPzjIlGxBj+uBjw2AV7BOJf6eWe771gYdLzqLmPzW1aSf?=
 =?us-ascii?Q?/Xj51sGbE2ppfxphbgAZkXUsZhrt4lRwrRjcS1ItPgqw5Z2QB2KNJ5J+Vm8b?=
 =?us-ascii?Q?l9+jx5Q6NTK5Ft/KdoigNd9kw0T5QsYRKtycAuAqcP87+QM2YBPv8t/Ktrii?=
 =?us-ascii?Q?ULiBFhkyXlZ3+bX8ajvr2Unhsj/BdPTvm8Bfxraox0kbbRumNT7H+V3aMPa4?=
 =?us-ascii?Q?WZerDM5hTyKzYD2ScqMDmYw/1Gkj5b15bIhgEqnxA10r+Oq3hdHYCp+IQbF/?=
 =?us-ascii?Q?nccZRvZaqGaSvVzrPG+31ownDFrTltoA4GZDES2hQMAxe4QjoNgpSKn2gGq7?=
 =?us-ascii?Q?xM8kzyYrf+Lhk6NcYmbLVJzz52iXYnlHfP7TikdSJAdRCs6HV4xQo/0FEF8I?=
 =?us-ascii?Q?Z8AgUtNFNujoHKwPu5ZXRaGc3tGH15Gu7H09n9sdSlJex7vxx/WjU4fs/omJ?=
 =?us-ascii?Q?6wfRL3vb8DeBUHSm5Ix1uMab6NTmiHlUYQD8hvu4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZlMwfJKXFGteaWgI7Q4DgKNhZw0+8xFC2U5vZImHNPZUHsc4xnqpkxPWi6mSn+ZIWnORJog45I5Jsp0KZOL0/K58CfyCPjZC8puxiMMWSF0DYGNHwRyBfkIb9Hs/TBmDfpVhmtMYeyKhSPY/bgsinsza32qURWY5XVKEL4YWbi3ymCcZO9Z3TPCCbWj8et51bpm0pSSsbcKZWQZpF7z1eORb+K7MoClKQ/00WPttuvh27/2kM19RTKaFVnaEe4+tmeGDHQuKddi5mdwwC/Mnqjq1B67bfVDP1qZDfh6RkRvEFESkemD9NHPETjUcdEz5NYCVnpFk5umEE6KEg5GlntFppShWhq70+N/MRpmdXWRywCeahx6urqgT7gEXe7weB6b9hkz7On6TeTzMiFPv4v4QOJvzkmdGZIFLAfqPq4nEHAGNp1EZaxW31VFWDM1IM8GT6mFeuR8w8i8vDubMlEDNKpQjFZz0gNag5TD1ul95Pu+FmRNpIlFbleH1sWK7AOE2CSIWzz3fOhfqFuw2pggviFW3IH11hpwskbbg2nDXPdQrpVjKKLpvYOUl8tTKUyY6zmiioUgXyKjX8oAC9n5ySL8KpIzsRWP7TVn6kNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d580c24-b0c3-4ac4-7cda-08de201c1593
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:43:32.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX7v0dJW8WzmOvajH5fV8tM5B0H1KdqAiVjSslCzdfjXQJ0KfMr3vP7k+GG/vLMyg3fzq4F4CbUDSNe+jTtMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=773 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100048
X-Authority-Analysis: v=2.4 cv=GagaXAXL c=1 sm=1 tr=0 ts=69117b88 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M_ZqdjHjPgEKiPzJVg4A:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: aqet1d515HvxLaRsTBGw3mL9zRwi4Z84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE2OSBTYWx0ZWRfX5cBZ1d14BItR
 Llpj0e/gdU0HB+iAtDHKDXCsIXai/iVSATRSe4dr0B5h/Bh8Z9ed/2E5ZazhkrdacTVaNFxjFd6
 k30GuvFTlSZQXKKSo5gDTt8ypL5fYQREgzIxubjyhjopEQ+YgqY7J6tZjKeQ11K7pnqd/etZOCZ
 Iwx6JOyQ/LcPfkBHCj8rPEOZqWCyqxTzF/a35BwS3CalrOEPHIsSjSZ8t3HjfXV/bs1h3Asl9/c
 94OMXgHr6w5RQELwJ6NdBFHcwvYyNzzK0RDCwadrafZV21e7RGs2oV28+hTa955k9rGud2heyDw
 OM+pgoq49UD133TtkZpVqxg/x7QzP1J/4+8wAzoE47UgouyiZ2vO00GekpCr1+D8kJsQN+XrtB3
 GbejPyQPJtsBhfWdZVj00KGk4lWxIg==
X-Proofpoint-ORIG-GUID: aqet1d515HvxLaRsTBGw3mL9zRwi4Z84

On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
> 
> 
> On 11/10/25 10:13 AM, Harry Yoo wrote:
> > On Fri, Nov 07, 2025 at 10:32:52PM -0800, Shakeel Butt wrote:
> > > On Fri, Nov 07, 2025 at 10:20:57PM +0900, Harry Yoo wrote:
> > > > 
> > > > Although it's mentioned in the locking documentation, I'm afraid that
> > > > local_lock is not the right interface to use here. Preemption will be
> > > > disabled anyway (on both PREEMPT_RT and !PREEMPT_RT) when the stats are
> > > > updated (in __mod_node_page_state()).
> > > > 
> > > > Here we just want to disable IRQ only on !PREEMPT_RT (to update
> > > > the stats safely).
> > > 
> > > I don't think there is a need to disable IRQs. There are three stats
> > > update functions called in that hunk.
> > > 
> > > 1) __mod_lruvec_state
> > > 2) __count_vm_events
> > > 3) count_memcg_events
> > > 
> > > count_memcg_events() can be called with IRQs. __count_vm_events can be
> > > replaced with count_vm_events.
> > 
> > Right.
> > 
> > > For __mod_lruvec_state, the
> > > __mod_node_page_state() inside needs preemption disabled.
> > 
> > The function __mod_node_page_state() disables preemption.
> > And there's a comment in __mod_zone_page_state():
> > 
> > > /*
> > >   * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
> > >   * atomicity is provided by IRQs being disabled -- either explicitly
> > >   * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
> > >   * CPU migrations and preemption potentially corrupts a counter so
> > >   * disable preemption.
> > >   */
> > > preempt_disable_nested();
> > 
> > We're relying on IRQs being disabled on !PREEMPT_RT.
> 
> So it's possible for us to update vmstat within an interrupt context,
> right?

Yes, for instance when freeing memory in an interrupt context we can
update vmstat and that's why we disable interrupts now.

> There is also a comment above __mod_zone_page_state():
> 
> /*
>  * For use when we know that interrupts are disabled,
>  * or when we know that preemption is disabled and that
>  * particular counter cannot be updated from interrupt context.
>  */

Yeah we don't have to disable IRQs when we already know it's disabled.

> BTW, the comment inside __mod_node_page_state() should be:
> 
> /* See __mod_zone_page_state */
> 
> instead of
> 
> /* See __mod_node_page_state */
> 
> Will fix it.

Right :) Thanks!

> > Maybe we could make it safe against re-entrant IRQ handlers by using
> > read-modify-write operations?
> 
> Isn't it because of the RMW operation that we need to use IRQ to
> guarantee atomicity? Or have I misunderstood something?

I meant using atomic operations instead of disabling IRQs, like, by
using this_cpu_add() or cmpxchg() instead.

-- 
Cheers,
Harry / Hyeonggon

