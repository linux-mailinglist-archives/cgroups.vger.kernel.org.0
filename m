Return-Path: <cgroups+bounces-16631-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nhoMFVfYIGq28QAAu9opvQ
	(envelope-from <cgroups+bounces-16631-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 03:43:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C198E63C41C
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 03:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ibvvBfvT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16631-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16631-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23C8C3033AE3
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F0A27587D;
	Thu,  4 Jun 2026 01:43:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCA231A41;
	Thu,  4 Jun 2026 01:43:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537408; cv=fail; b=YDqmTn+oH8J2aF72HTdtL/9b99lNEJ5DYy+lJmvAZqcUj5x49xK5MXQKycm0LfJ2+wcKuIm5CZipB8sJoZglt/1upvvf72pc4OlvHj/31RYXhcG1+t1hgiX6EEQLk2uiORDT8+NpITbmsTqJ93mKqE7ZZJSo5j8MkPFSW+4SxH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537408; c=relaxed/simple;
	bh=lUwCNh+Zq29m/lRctKyH5Jq2EhDL7+1rZ66N+Y8nRbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rwc3p+Nxc2q6+6mgZiv623Yc/UBaewFNE1hG4RHX6anXPHmhul5WBGWhRUOLQrEugaxsCyrR7ioYrqC3Cb2Wj407SwNCNI5zdnkn+CiIV/KruGWPqQ8SPpo85Tr5srRp37+0ITVPEWLgIx/ku8UYv1QmMCmmNcfLI35HneLlxqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibvvBfvT; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyWyt4/VI9a+DkOgF4yFUxMyytPQKSLwigvicWZ1z1FhrAOTLIr/qDRy7CYEKDsXQizUVlmOtkH64yS/NQCxsLCpTOJl+dqgZdxcL5WBHs/wQnvgc+FXeMTgezvKG9u6tTYCy0uWWFh7Nz9RNdoUwi+yrmNr3/jp7FNw5ak/ZJBnbO7lp3n+MVEos+o5A11PRvpxgwNvl/XYgJMId56Vnqq29g5Z/k1qWw4Vd/MUE36f8S6EHi1ZDhHatuPqErytuVV5LnVpj+cKQhQepuPwOeniyxd6RhMZOtkKvd4AK/Y7YsS4qVAJ9o4R8n8JN7pwSggxO6yI77hYp/YuQC787w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nkZUkQQY75abwRcFAevjWlmiNxL2qEN2LxclDIQW/E=;
 b=G9Lvxon9Fu0E/B63O3VYAfqwsMIFqnydsaFLMW4TQXdySRE0dstT4Z3eCzEMGEC++7rLCtMxVOu0fKuQYbv04R1a72L6pSf4PlXCbgrmY+F0a//cf/abvEL3/APiGqkbRdgtoWRPWk6mcEl+b/q4WYpo9IPccH6NQxOzz1y12S9m4SpOYBmAymTda9bF+DXecYg8drXwEp14qu8yGc5RY/cb6FgdN34uulYxb2PBblDlyGnb0Bbnk/iBWFTWPAgQ8gWJM7i1MGDFEeIXtmqG330XtYKDtYEr5/ZTeJz9Q8MYBlsgIxVeVNRtdTvXlHD1WOKq1iL7QxHtKlAi/AoMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nkZUkQQY75abwRcFAevjWlmiNxL2qEN2LxclDIQW/E=;
 b=ibvvBfvTYKixNHi1/2CRJUVPxoSAV4P4OGmJ91U6vutChk6pichsld+CCiQanC9JAnKFatkqqzuDBwzvwAYG0BhRv6EocCGET/foUVQKc8cmlSQrpnxzLsBH+FWx2Sg+Bjew0dFw6M+SYlUP6eNC4w95L1Ait3MgwMOZpLlZRzin0flHWpKIgkiwkqEkmmcjmVFEDf9trvvuOy0P3Hqnd+13d/I8qI4lnNO+sl/AQMTEq84oQ9+999VtSB0mCFdnVwpptdExKXmWm4Xr6zGAFcKlnO2hJGuQoJR6yW+QHTSWX5cin7ZNht+ndoz5cYlI4itA5gPBOyBA0NccOwBXMQ==
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:43:19 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 01:43:19 +0000
Date: Thu, 4 Jun 2026 11:43:14 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, kernel-team@meta.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	longman@redhat.com, akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	pfalcato@suse.de, rientjes@google.com, shakeel.butt@linux.dev, riel@surriel.com, 
	harry.yoo@oracle.com, cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aiDVMgu0viTIml8H@parvat>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MEWPR01CA0107.ausprd01.prod.outlook.com
 (2603:10c6:220:1e0::15) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 33912cb6-9c6c-4dcf-cbdc-08dec1daa726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	A5hig0+gyLvGpAB+yMGRtSTET6gDMgqGuwA9v4L1joMkUQc+EomarQA040n550vPq+ygzs6caQblO9ulgnmLC469f01KRyU+lOsusqJxGEMOqH4I9DbumqYQlUFFyzpyiPoJ+cVosyqOMDQn86/9oHqUX/nvC3/x/64HT+4BUGtOD81w6ZJpSaNxKLIgDa8GNPC1ww00I5RA5PAnlF2uVvBa+h3JG0JDe9kZYTPzWPJlOJGTWgVEJWA7mWm395+OwvEI47EFFTN54Xlgo8p7yuLqakjaTzbItsDl9Jy9zyVJ91FP90TG7fDT/5k83h1awq4h3eBlKQ7d8mgVnLI8eI8lXdJjPwz6lxViJOfpTz7yV6xrw+ndkbZSoRA4VHHdkV77VRwQ0gjkp12qK2CSZC0cwiCyYq0edvMtzQjSkrNSRzGcLxuUXsZ7D/SvAnznT8fypt2FIMmlSFpAvLK8ulVvHDX/B0TTduR9+3cHUxIYnsr2R63CaLVpZYUW6wJf9XwB+2giBF9QvELdmTU984SD0m24wzn3+LDk0kq0QlaGVnJwHls0OZ1EFQszgy5a3Rjxd3OXVlIoJtVtHyQ0NGXQcaFuB0Mp93hFnGlxOrGv0IgI48F7bm1EOOzza2uCRtL7pTEdmT7oQZtgw6xDg9EDLV9cb6YWHKsXpcP+PZH11OK4oSdOx+BWkq2iluVR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obterRFykq57MBL/78g/C8QQr5Yj12YkEAm751+6P+4WJINl06btfe//MQ6N?=
 =?us-ascii?Q?86JifpIXgrctjkgmlLMtcQvcZyH5pphE7kC87rsOV0ea7a0Qu0O1rrFUnbeU?=
 =?us-ascii?Q?Ns1EF/NZlvT46g9AWfd8Q5MZ6hUfvHGGayDn1U1uyq2mLgNgRlioHMSlOsWr?=
 =?us-ascii?Q?KUkJgRV9FI0uKqNjv7sHJaemgZWmyeGk2P7Qz9aPAv+/E1f/aSzDSL75G5wM?=
 =?us-ascii?Q?rWNYWINOGEXuI54d2Wj67hmB9QU848urvjrTRcigZR2HrB5/IGTlkJFrBMVC?=
 =?us-ascii?Q?DGEYlGDViPvsAINp6KgRSfe6kSEckwQDiIpoynhTwWou19nX7KxqZkb95r8D?=
 =?us-ascii?Q?CwMVCVl5yhbcRmmXIeyk7iE+AMLnoG1V0ZVPfKaJiRytFksSAMWxzmaWlc5c?=
 =?us-ascii?Q?aTTSChFRZGOpcUHVaH46vcJS4YdpA5yXg4Fj7Lp2QGWHlsrzjQ8XnboTFJbk?=
 =?us-ascii?Q?ueaXXb8nEbTjZo6A/Dp3Tug1vz+y2SdvtyLcSZMJGTFvd6r1yksOEszjpXyE?=
 =?us-ascii?Q?Wzifnq8njemd6iIzzCXgQ3DysM3t4BleMHUwZb1mklk2753OZXxdv/c78RNf?=
 =?us-ascii?Q?TSlU/g1WjZ5WgkTmMWwd8MvNop1O/kllppCOw5jR6CLLhKsaTQ8eanU2aAC5?=
 =?us-ascii?Q?voyarK9PDHHur7CoUg9wp/U/ChOFN6ekvUin/yH3yElBWJ08g16iik1HcN7U?=
 =?us-ascii?Q?KGZ46q+VOWezJcnmd3j4H770xrog5vIzr/+4LmmUIyRueyG/5WTMh3AHG1kX?=
 =?us-ascii?Q?/JHhFVD6yHkupDoXzzH5PHegJInTG94Yra63nevXpsfgYXbkX6JlhQm7nloc?=
 =?us-ascii?Q?tc2R1EP6JxpLelc7HCWr47fWQMKzWlh5jMH7u0V+ZAzWQWesquETW78socqH?=
 =?us-ascii?Q?IZNHwkBmCmzYxU9jjKL5ydtwLLZVfduHHT8uRYQ3bB3VbmyY8IL/H22Kp4gb?=
 =?us-ascii?Q?P2/VufZz1xGeWXJLUeH6Z+utFC4VDQMuUxP4JuchGC4oR8Odqt2kGazrrJVQ?=
 =?us-ascii?Q?wTmezgjxOTz9m8OOQom8DCMN2mEBxUnGXWmdg+F9Z711KxHTU6HwhRlB99Ox?=
 =?us-ascii?Q?H/6B/shMdzGPDc/RUSj1bHz2k4Byc0VzKffIfibvNgLIQ8Oe8fBB3gIT+FVf?=
 =?us-ascii?Q?42gW2cQx1rDd6Z9Co9Q0TXk/nF3b0tR63VWk/lbLWi101jq40mLhoqCMGK2m?=
 =?us-ascii?Q?cKAw3shsJRywcZ2KboblLV1BTlub2cNysfbEnx+F0y76CCa8X76T86k56EcF?=
 =?us-ascii?Q?D0u9TzH1GAgNOPe4CKwbESeGul+NRw/ymHR1pNXg//t0AFUTdft2/nRLfoSB?=
 =?us-ascii?Q?2a1dBxbKiER8u/Q6G4m+U0wfJxd8XYFaTdwCt+Rkar8GDkp4JnaIsUDueu6a?=
 =?us-ascii?Q?SDTJgqKReQjRefI7iOKrO7R3dJgfXitBNASMkvKc6JEIksGJNABcnMW+rGeJ?=
 =?us-ascii?Q?/Ck8ERHuY3PqZUNFU1r0vplITbggP1pXsGIXVpMPQBy6+Av6UMA7R4s0rnM3?=
 =?us-ascii?Q?b8gpeYjSRnxGFhkEkmL2V/guEDw379g+bDY/uzw32EFe1isPjShodgI0uWuN?=
 =?us-ascii?Q?FPWydpi5TGORK00YUZBIEuHBloiTLW68SejsaOKR1VfsnfI4vKqJTwtE5Gyl?=
 =?us-ascii?Q?ezqwDLaBi0JECA8FpZOcTfHZxOQ7iO/fjPHUR9Gh15VBiUQ89pvTTpH9Ffr2?=
 =?us-ascii?Q?/S2iMabxWgKMwFbSZIsZFfrTxzgyHw3QLuB8+1O8UE/DgHfO5SqkG3KVyH4p?=
 =?us-ascii?Q?XJUGVA1LGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33912cb6-9c6c-4dcf-cbdc-08dec1daa726
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:43:18.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/sb409tFYo/7o1wndzo62ERdIKE5y95+FY+Ptk3CIuKznrUEb7rNsjPEc57mnHwc8ilfXEzUr8tEk0fRoi62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmusv
 illemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16631-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,vger.kernel.org:from_smtp,parvat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C198E63C41C

On Wed, Jun 03, 2026 at 08:02:09AM +0100, Gregory Price wrote:
> On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > On Tue, Jun 02, 2026 at 09:57:48AM +0100, Gregory Price wrote:
> > > On Tue, Jun 02, 2026 at 12:16:50PM +1000, Balbir Singh wrote:
> > > > 
> > > > I was think we wouldn't need explicit flags and that allocations would
> > > > happen from user space using __GFP_THISNODE to the node or via a nodemask
> > > > based on nodes of interest. Is there a reason to add this flag, a system
> > > > might have more than one source of N_MEMORY_PRIVATE?
> > > > 
> > > 
> > > There's a few things to unpack here.  I discussed this many times on
> > > list and at LSF, but to reiterate.
> > > 
> > > 1) __GFP_THISNODE is insufficient to enforce isolation and otherwise
> > >    not particularly useful.  Additionally, from userland, it's not
> > >    something you can actually set.
> > 
> > I was thinking mbind()/mempolicy() is how we get to it. It already
> > accepts a nodemask.
> >
> 
> First let me say:  I want to enable mbind access to these nodes.
> 
> But let me caveat:  I think that needs more time to develop, and
> in the meantime, we can enable the /dev/xxx pattern somewhat trivially.
> 
> First let me address a few things about mbind/mempolicy and how it
> interacts with page_alloc.c, I gave this overview at LSF but I don't
> remember if I posted it in any of my follow ups.
> 
> 
> 1) Fallback lists are filtered by nodemask, the nodemask does not replace
>    the fallback list.
> 
> Here is how the page allocator fallback lists and nodemasks interact:
> 
>    Fallbacks A:  A B 
>    Fallbacks B:  B A
>    Fallbacks C:  C A B   (Private)
>    Fallbacks D:  D B A   (Private)
> 

Do we want regular memory (N_MEMORY) in the fallback list of device private nodes?
The assumption is that we have ATS translation enabled? Assumiung A and
B are N_MEMORY here or am I misreading your illustraion?

> Lets say you pass:
> 
>    alloc_pages_node(C, ..., nodemask(A,C,D))
> 
> So we get
> 
>   Fallback(C,A,B) & nodemask(A,C,D) -> iterate(C,A)
> 
> If we wanted to change this behavior, realistically we'd be looking for
> a way to add specific nodes to certain fallback lists - rather than
> modify the nodemask interaction in some way.

Yes, that is what we did with CDM, control the fallback for
N_MEMORY_PRIVATE, but there is a design decision to be made here.

> 
> I think this is out of scope for the first iteration - so supporting
> anything other than mbind() from the start is just pointless.
> 
> The only feasible mempolicy you can apply is single-node bind, so
> realistically you can only support mbind.
> 
> 
> 2) full mempolicy support doesn't really make sense
> 
>    task mempolicy PROBABLY should never really touch private nodes,
>    while VMA policy certainly can.  Assuming we're able to support
>    multi-private-node masks, none of the non-bind mempolicies even
>    make sense for most private nodes (interleave? weighted interleave?)
> 

Yes, mostly, but is that baked into the design? If so, why?

>    I haven't worked through all the implications of a task policy having
>    a private node attached, but the longer I think about it, the less it
>    makes sense to just support this outright.
> 
> 
> 3) Introducing mbind support is not just a simple nodemask on a VMA,
>    It also implies migration, cgroup/cpuset, and UAPI interactions.
> 
>    a) migration:
>       
>       mbind/mempolicy can and will engage migration when it is called
>       with certain flags.  Migration has subtle LRU interactions, but
>       the patch set I have at least allows this to work.
> 
>    b) cgroup/cpuset:
>    
>       cpuset.mems rebinding will cause private nodes to be quietly
>       rebound to non-private nodes within a nodemask.
> 
>    c) between A and B - we really want MPOL_F_STATIC to be required
>       for mbind to be applied to private node so that it is never
>       forcefully remapped.
> 
>       That's a UAPI semantic change specific for private nodes we
>       should really take time to consider.
> 
> 
> 4) File VMA interactions don't entirely make sense with mbind
> 
>    In theory you might want:
> 
>    fd = open("somefile", ...);
>    mem = mmap(fd, ...);
>    mbind(mem, ..., private_node);
>    for page in mem:
>       mem[page_off] /* fault file into private memory */
> 
>    In reality: This does not work the way you want.

Why not? Just curious about what you found?

> 
>    I went digging and we need a few mild extensions to allow
>    migration on mbind to work for pagecache pages, and the fault
>    path does not necessarily respect the vma mempolicy always.
> 
>    You also start getting into the question of "what happens when
>    the node is out of memory and you don't have reclaim support?".

Yes, we should discuss reclaim support, I think we should allow for
reclaim. It allows you to overcommit private memory the way we can
with regular memory.

>    The OOM implications jump out at you pretty aggressively.
> 
>    Moreover other tasks can force the page cache pages to be moved
>    as well.  So the programming model here just kind of sucks.
> 
>    Works great for anon memory though :]
> 
> For all these reasons, I think the be mbind/mempolicy support with
> private nodes needs to be brought in with follow up work - not
> introduced as part of the baseline set.
> 

I am not opposed to the follow up work, but I feel mbind() should
be the fundamental work and user space API.

> > > 
> > >    for node in possible_nodes:
> > >        alloc_pages_node(private_node, __GFP_THISNODE)
> > > 
> > >    In fact it's the opposite semantic of what we want.
> > >    THISNODE says: "Do not fallback back to OTHER nodes".
> > > 
> > 
> > That's why we need to control the fallback nodes carefully for
> > N_MEMORY_PRIVATE
> >
> 
> My point is that __GFP_THISNODE is not actually useful.
> 
> If we go by nodemask, submitting a single-node nodemask is the
> equivalent of an empty fallback list.
> 
> If we gate access to a private node by __GFP_THISNODE... this is the
> same as just providing a single-node nodelist (putting aside the OOM
> implications for a moment).
> 
> And it doesn't even buy you any new filtering ability against existing
> nodemask iterators that may already utilize __GFP_THISNODE.  i.e.
> 
>    for node in online_nodes:
>        alloc_pages_node(node, __GFP_THISNODE, ...)
>        /* Alloc per-node resources */
> 
>    This pattern is undesirable, but completely valid.
> 
> So overloading/requiring __GFP_THISNODE is just not useful.
> 
> I will follow up soon with a new version that limits the private node
> interface to just nodemask and fallback list controls.
> 
> I need to test a few more things related to removing normal nodes from
> private node fallbacks before I feel comfortable shipping without
> __GFP_PRIVATE.
> 
> > >    The semantic we want is "Do not allow allocations from private
> > >    nodes UNLESS we specifically request" (__GFP_PRIVATE).
> > > 
> > >    __GFP_THISNODE does not actually buy you anything here, AND it's
> > >    worse, in the scenario where a private node makes its way into the
> > >    preferred slot (via possible_nodes or some other nodemask), the
> > >    allocator cannot fall back to a node it can access.
> > > 
> > >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> > 
> > Let me clarify, I meant to say, let's use a nodemask for allocation
> > and __GFP_THISNODE gets us to the node we desire, if that is the only
> > node. My earlier comment might not have been clear.
> >
> 
> My point was that __GFP_THISNODE is pointless and reduces to providing a
> single node nodemask anyway.
> 
> The contention over __GFP_PRIVATE is a bit ideological - do we want:
> 
>   1) A hard guarantee that allocations to a private node are controlled
>      (__GFP_PRIVATE implies the caller knows what it's doing)
> 
>   or
> 
>   2) A soft guarantee (fallback list isolation only), and needing to
>      deal with undesired behavior that's "not technically a bug"
>      associated with existing users of global nodemasks (possible,
>      online, etc).
> 
> I am arguing for #1 - the community has argued for #2 and "fixing
> existing nodemask users".  I think we can ship #2 and pivot to #1 if we
> find fixing existing users is infeasible or too much of a maintenance
> burden.

Again happy to discuss this, I'd like to make sure we agree on the
design. I am wondering if there is any experimental data to choose
between 1 and 2.

> 
> > 
> > Why not use mbind() API's? Do we want to gate allocation/privileges
> > via a /dev?
> >
> 
> We want to eventually enable it, but we really need to treat these
> extensions as a separate step from the base so that the UAPI
> implications are given proper scrutiny.
> 
> In the short term, /dev/xxx and driver-local/service-local control
> of a node is still very useful.
> 
> For example, for my compressed memory work, I have found that if
> implemented as a swap backend - the kernel can manage the node without
> any UAPI implications at all :].
> 
> A driver managing memory on a private node could do the same.
> 
> ~Gregory


Thanks for the detailed answers, happy to iterate and experiment on
the design with you, my opinions come from way back when we tried
to do CDM (in it's first iteration)

Balbir

