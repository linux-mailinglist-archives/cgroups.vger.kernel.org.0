Return-Path: <cgroups+bounces-16834-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xIV5BgTvKWpLfwMAu9opvQ
	(envelope-from <cgroups+bounces-16834-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 01:11:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EF66D515
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 01:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kwB3HARn;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16834-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16834-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A0130C1491
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBE36D9EA;
	Wed, 10 Jun 2026 23:10:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F81DE4EF;
	Wed, 10 Jun 2026 23:10:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133031; cv=fail; b=Qx8pgVqt1rzbva7srN7cRu2/OrpVtaHtulX2+HQn1S2uxCpjzA3eD8eGkp58XxLzGx2MFAEkDlhXxAMhE2frKi0bBeNHdlY7bB4IVSZITg3fFClu8+3wMv+z22WweuwnPYv9krGklbn21197Bd83xTKEjiyQJiXNUefkReysmG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133031; c=relaxed/simple;
	bh=BnJ04MSE79FAn5DtWPwvs2P6o4sGMvtujra/t20Zsrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqcWcOiYaP6wxwKbOS/clAS1Pcjqx8ymDQMCmVv84n4CfzoaTRTEJiS2Q7XAHzSTXznZ3FeBvFD6Rc8iMf1yCkry5DRc+3Zl8X4WOFRcfs7qqypftRx3BpxKkXRO3cUr9yfha+UlY+pVPhuKgvK83bk9pobk/neOYWeZG+kx/Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kwB3HARn; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknDu3aRMVxIslYbAIUcFjYFhD76npJBLuMfEKJt5WJDM1WvTixjSYI3g6oEzMGGMfbjgruFvHXVD1643DFQ7bWQKVZBFeleXRZ4g4WWkZxRo7Ve3pI+7opDwnHrOtGwF9Py4uA1CpsX72/CDoUcqQkVyjmRf87BoLrXcCv+YbXbd04BCgTndQcjiJNjBkypXqhIGsuq+eoTrSA32bUX8+clDEnsRtJ4KsW24M/y2j036JvSLGbKb7a4+oNudESvi3cAO+nPybYWE0I2PkMea2n8VCjEMmk7M8fL+fIB99Q9RrBk0ebuSOQ4wl2eox6frJneeds5GB8IuL7wbp7dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZTOqMgmbq6t1RboSLXU3Z4LuPBK9MEs2D2gguG1dsk=;
 b=BiOJCbrQbVja09cBtIiVC3cA9yZAesgtmyqpzHZfU23cRaT+uJ/doqU84vcVtOov5NIx6mDiXClArVyWrYYzrrLYjf0e9EpApkNuJNv1Btwg+e2d7+MDk3FSi5Etvz3vqjz6uPDlw1cqQCYGdKuCKOSqSUYTAwOTIVpAJ3DpJaNJKOT2yfZfpfjTPy2Gf5vYVCtszhrnDgyVbiOACbFaVuqG144PngHvLtcZwaOUMSr/R/Pz1vNerk5/bTKQIydKUyuZ7ONH75W0gkRyBuk3NrXN1skREF9+R82d+1P12z0OBMjH2d34LKvACY9Xtc9It0HNdgS6XeYaauH+TZUj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZTOqMgmbq6t1RboSLXU3Z4LuPBK9MEs2D2gguG1dsk=;
 b=kwB3HARnXkzxDZ+GqrR+mJS1DL5x3B4Yh0C3ZfhSew9QYWW7B/I4GSfoXwJ78OKYHJI0f1TKnajhCjBbZtAAXdvjisTztle40H5Ye7UnBuL0cJQojGLiP/ALyvX4QIEI1ABvM8H9Eaiwi4Gxs0oCUO7r3URwJOMAr0/3M3u72+hulyaEhFZCYWYWr+hMl3wIRupyhTIRtn6W6A3qzhSDDXSWOkV40meFJq8QFOZNE56sn44znZKH8Fx/K2qPlBU6LURsmLTJOCrff7y3qvNiPcwyU2d/wWOLaxDIY8bJ4lVgmch57g75Vz97fXBTG6YKF0R30sR34lkqh4BzBjDmTw==
Received: from BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 23:10:16 +0000
Received: from BL0PR12MB4995.namprd12.prod.outlook.com
 ([fe80::dde:9068:4b1a:53e2]) by BL0PR12MB4995.namprd12.prod.outlook.com
 ([fe80::dde:9068:4b1a:53e2%4]) with mapi id 15.21.0092.014; Wed, 10 Jun 2026
 23:10:16 +0000
Date: Thu, 11 Jun 2026 09:09:55 +1000
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
Message-ID: <ainsAU6T58hGDdWY@parvat>
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
 <aiDVMgu0viTIml8H@parvat>
 <aiE5DZC8Io4SNI3H@gourry-fedora-PF4VCD3F>
 <aiFSZfRlFPd7qlIw@parvat>
 <aiFtJFqkpbZ9qFvM@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFtJFqkpbZ9qFvM@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MEVPR01CA0060.ausprd01.prod.outlook.com
 (2603:10c6:220:1fd::12) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4995:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 523ebde2-54da-4a5d-f682-08dec74565d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lW7F/PF/3npE2o8VU41xtDio0wnrf80UaqaXr1JkpEOAoy3mFAtu3+c6dRsUGRwrw32lcE/w1wRJvuHMHkSPr8/A2TqQ+/IlTeCB/R1esI2Aa2zmMbjgnxW16LEiQq1KzxdZOFXmMWxjCsXqeZHP+ORG0kgnoIDxBZQJqG/u1/7DyOirwFMp2gFDRcm65yVrHyAQUSgXl5PPracoTAbgnmBJu+GOgNEYUFafZEugLwP95EWz2EGjU86lS5Pa84a8C93Gh/qbEpMVMqFHgDQGSHl1md/OOxKneoH8xSKAL/6LkKqhRpQEWCMetdgaOP/TiQZR8wsi1o6tZ2xBqZ1N4h+/5Kx6emKio/Euws++sBrp8wukcQ03lnI8F4M032jYGT9yClL8pAJ1MTiWeWis1bu1cVEP0Wajl3kIkvAtvAZ+z6BqnCawb2JgA6oL5Ja7T3JSet6s0dUkDx80qy1sLpWwWmqvC5Q2S8PJ0gzvNwv53VhVoz3CfNBVy/TvRV+4Xj6XBGe3nam0TtYrBzqEw4TfEZnZlS7Oz0FzKOpwGiKqm12ndA1KgIT3Le0UWFmvo2J5d5L0dc0cip+R8IC5p3IRfo3BPA2TfUK8wlspS9uIAwPuz/Q/UkXcfpKkoXvjumyewEX0Uhi85PfcMMU4QTWfRD7UoEL0DjxcUtniayIZ0KIvGpPwHGKTmuIlNbN2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/nVMxMP610VSk5DkAjfgUV+0Ujbx25bvSiFf/Lq4wxqSE2i77DYDVuTGyNn?=
 =?us-ascii?Q?a3VY+T6VEb5v7aWC3+Nl41JxvzGOJ09ja7DXUSh31NcevTfuCS27nGWK6UMg?=
 =?us-ascii?Q?L4nsBt1dD5pCSvl/ol/JlIFyAojMp4DG7bS2eCJCjnMM5hnjaJTzEZZ4Sz7E?=
 =?us-ascii?Q?xo0ghQib1WelPh2xP4tk5zD/gdTC45PbV2bk26MfNh4rYqM9rd3LPbJNa7a8?=
 =?us-ascii?Q?i+TGuuS1T69vrqKfpmQmkTS5NJeGcE1wiM/NdPcvNjampunG9RXru2cGXZyr?=
 =?us-ascii?Q?X90ymolgOegBMvvzNJ7I+Jx5A4O6bIsQ4ZnwlrrnCWy2MjICYDeD1yW4/3Rs?=
 =?us-ascii?Q?/1NpZNPcaaQanTfuSbTqA32KJqyVgLgaIZJ2/w/GmsGh94whwtz60m8u0IDf?=
 =?us-ascii?Q?znivqCRdn8dbNOsPHiY3vDA0a3jAxjlEInhQMg/tkqxt3MyAvk9LlnRidWxr?=
 =?us-ascii?Q?Q3ss2dAYgohViHegNjCYYXisDP7LJ7SuZZqY43l+ZmLfVwp2dGkcCpOdi+fi?=
 =?us-ascii?Q?rM3T3exuPmLPhP8j1j+V/ED4vIXpVNk2Mt4wl1QVR+2miBo6M3gHDWcSEBN+?=
 =?us-ascii?Q?CjRLvo+xoac5rOtIgpQ80NkzacJz/DnV9p8pwQhEYvnb1y2SMTQ6LKhXVK5h?=
 =?us-ascii?Q?q2nZx+li74ntpRmC3AIbHJZfqfj9gN+LXwYJZAfHIe4XNBrci83aMR+ug8br?=
 =?us-ascii?Q?QEiEILlkfWQKnvYnPcTkmx1gnUa8i2Ms1PBB66onHV/1lU8dtCPJflEc3OKv?=
 =?us-ascii?Q?iNdwjOppftRYidgRimEsw7l3VtLTKpt5JSMnTTTCkFZWSuuJYsrqkXzc4j0+?=
 =?us-ascii?Q?Ih85D9iH5syRZA2LkthU9wiWTLCP0pKS4T2g95lPKqycjFaUb2/CyMxIAxle?=
 =?us-ascii?Q?c0Vm86fsgNRUb+YPwgWgCVGNZF2tdw/ISFYHfJ2tjxFeam+bpH9PprF3oVCp?=
 =?us-ascii?Q?eJErJ5Elv8nx/vbfGAlenEOi9gK79f8D/rEEpTK0q1dGV+/byRXBPT3RGFSL?=
 =?us-ascii?Q?hDozgp+yELYha7iUBMhF4DpN3+ecnYxM4SP6QWi4XEpLkuVTxKGqOlfpeMD3?=
 =?us-ascii?Q?iW/8YdhW0hhYg68eshmAgTmcmiEHjUgTauTvWtYGKiFj4k9w+v1HJ2B7XUce?=
 =?us-ascii?Q?A1t/Z6RsM1Cl/eaoiMG5OjXtIpDlzGbYZttIRTDb870EfbF6zQsY/BDVx2aW?=
 =?us-ascii?Q?JLhtkWOCec/HFPbpl8WQLzbEv8UKW+xzFbg5ks05EHbrz8MI2i+5GwjNaJLp?=
 =?us-ascii?Q?gVEK1f/bEzdUHEChUgTLknE/BN8z4+mSTOJjHof2xUgzKS8BxV4UDP3DgfeK?=
 =?us-ascii?Q?O7189eV2X03SW6CFxob1/de2cLkbxUbNBFL5ltlMsHM+KI2J9Q2rmjz4uvBR?=
 =?us-ascii?Q?fl602RfcoxinaVmgSvO5KCgchixwhysRQrE9KA7ALLDfcWWLcL5Z4O0jqN7G?=
 =?us-ascii?Q?cOSTgbIuVIJDihklOO4GreWmN3C5qWa6JSGlsreCiyJtnBKvZqufH/gFoaTH?=
 =?us-ascii?Q?b7VGUexerpDOjj5dmBaumAcrjGhouTFR00UO+t2hb8daOKvx/3aF9+EA5JQ2?=
 =?us-ascii?Q?ePH3UBBKet8/vmAdxoNsmJB7xOie5Uywy8F8PucOxjrLILx9XlYNH3zW0oM4?=
 =?us-ascii?Q?Ecu1vKb6IJX0Al+nGWuxZizxmPFVX9QsmSz8W+xbqH5lfc5Wu82CMTWJ/dXy?=
 =?us-ascii?Q?jnxRCz1l12eSnJmtcxgEDQkIvkLloRZ1iEAwK5Pg7Q7R56zmYlZSdNwj/wCO?=
 =?us-ascii?Q?7UQmn9vXhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523ebde2-54da-4a5d-f682-08dec74565d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 23:10:16.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWBAlI9D1uQ983qG39qtCUkMgpVVcBcmMSq7+G4p3WGky1Dq1BxV7mAFCF9n6Su/wszMq1pQNpDIEO0MBtNn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16834-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmusv
 illemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E2EF66D515

On Thu, Jun 04, 2026 at 01:18:44PM +0100, Gregory Price wrote:
> On Thu, Jun 04, 2026 at 08:35:19PM +1000, Balbir Singh wrote:
> > 
> > My concern is that __GFP_PRIVATE is too wide, I wonder if we'll have a
> > need to support N_MEMORY_PRIVATE may not be all homogeneous memory nodes.
> > Very similar to how not all ZONE_DEVICE memory is homogenous.
> >
> 
> Can you more precise about your definition of homogeneous here?
> 
> Are you saying not all memory on a private node will be homogeneous?
>    While possible, I would argue that you should not do this and
>    should instead prefer to use multiple nodes - 1 per memory class.
> 
> Are you saying not all private nodes will be homogenous?
>    I don't see the issue with this.

Yes, I meant, nodes might belong to different devices. These might not
want fallover allocations, for example __GFP_PRIVATE falling back to
unwanted nodes.

> 
> > > 
> > > Agreed, but also one which can be deferred and played with since it's
> > > all kernel-internal.  None of this should have UAPI implications, and we
> > > need need to accept that we're going to get it wrong on the first try.
> > > 
> > 
> > Agreed that we might get the design wrong, until we fix it up. I feel
> > that __GFP_PRIVATE should be an evolution of the design to that point.
> >
> 
> Possibly.  If we can't guarantee isolation without __GFP_PRIVATE, then
> we probably can't merge the baseline without it.
> 

I'll rethink about this, but I am concerned that __GFP_PRIVATE is too
broad, in fact it breaks isolation by allocating from any private
device. Again this is a function of how fallback lists are organized.

> > > Because pagecache pages are associated with potentially many VMAs.
> > > 
> > > The fault can be a soft fault or a hard fault.  On soft fault - the page
> > > was already present, and will simply fault into VMA without being
> > > migrated.
> > > 
> > 
> > Let's split this into two:
> > 
> > 1. unmapped page cache is never impacted by mempolicy and should not
> >    end up on private memory nodes
> > 2. For shared pages, mempolicy would be hard, but it would need to
> >    be on a set of nodes backed by private memory, depending on mbind()
> >    policy
> >
> ... snip ...
> > 
> > I'd need to think more about this. For now, my basic requirement would
> > be that unmapped page cache should not come from/to private nodes.
> > 
> 
> This does not fully describe the problem.
> 
> A file can be opened and cached as unmapped page cache, and then mapped
> at a later time - at which point the mapped copy would share the filemap
> page cache page.
> 
> Worse, because it's file-backed, you can have the memory faulted onto
> your remote node - reclaimed - and the faulted back in via the process
> accessing the file via unmapped operations (read/write), at which point
> you've had a silent migration occur.
> 
> Basically consider
> 
> Process A:
>    fd = open("myfile", ..., RO);
>    read(fd, ...);  /* mm/filemap.c fills page cache */
> 
> Process B:
>    fd = open("myfile", ...);
>    mem = mmap(fd, ...);
>    mbind(mem, ..., private_node);
>    for page in mem:
>        int tmp = mem[page]; /* fault into vma */
> 
> The result of Process A running first is Process B thinks it has faulted
> the memory onto private_node, but in reality it's taking soft faults and
> just getting the filemap folio mapped in.
> 
> If you wanted mbind() support from the start, we would have to limit
> applicability to anon memory only.
> 
> Shared anon memory is different, as there is a radix tree that deals
> with a shared mempolicy state.

Ack, need to think through this.

> 
> > 
> > I am open to this, I was coming from the blueprint approach of:
> > - Let's mimic N_MEMORY with N_MEMORY_PRIVATE and then pick and choose
> >   what features to change or make specific to the implementation
> >
> 
> N_MEMORY essentially states:
> 	"This is normal memory touch it however you like"
> 
> N_MEMORY_PRIVATE (_MANAGED, w/e) says
> 	"This is NOT normal memory, there are special rules here"
> 
> So, no, lets not mimic N_MEMORY.  This is a "closed by default" design,
> while N_MEMORY is an "open by default" design.  This design choice is
> explicit to make reasoning about these nodes feasible.
> 
> > > This is informed by a single use case / device.
> > > 
> > > There are users / devices that don't want any UAPI for their memory,
> > > but simply wish to re-utilize some subsection of mm/ (page_alloc,
> > > reclaim, etc).
> > > 
> > 
> > But then, why do they need NUMA nodes? Do we have a list of use cases?
> >
> 
> So far i have collected:
> 
> - Network accelerators carrying their own memory for message buffers
> - GPUs with semi-general-purpose working memory across coherent links
> - Acceptionally slow distributed memory that you do not want fallback
>   allocations to (so you want to deliberately tier what lands there)
> - Compressed memory (just another form of accelerator really) which
>   has *special access rules* (i.e. writes need to be controlled)
> 
> In most if not all of these cases, the right abstraction to reason about
> where memory *should come from* IS a NUMA node.
> 
> - the network stack can be taught to check if the target device has a
>   node with memory and prefer that node over local memory
> 
> - accelerators can be given private nodes to manage memory using
>   core mm/ components, without worrying that general kernel operation
>   will put unrelated memory on those nodes or do things like migrate
>   your pages out from under you (unless your driver/service requested
>   that).
> 
> the tiering application should be somewhat obvious / trivial.
> 
> > > 
> > > I am trying to test whether, lacking __GFP_PRIVATE, any normal runtime
> > > operations access private nodes removed from fallback lists are reached
> > > via something like the possible / online nodemask.
> > > 
> > > I remember, maybe a year ago, there were per-node allocations happening
> > > during hotplug and that's why I originally proposed __GFP_PRIVATE, but
> > > I'm trying to re-collect that data now.
> > > 
> > 
> > Thanks, I look forward to the next set of patches. Let me know if I
> > can help test what's on the list or if you want me to wait for the next
> > round
> >
> 
> Really I want to get the minimized set out the door so we can start
> breaking this up by feature (reclaim, mempolicy, etc), because trying to
> reason about it as a whole is infeasible - and I cannot be the single
> arbiter of every use case (I simply do not have sufficient context).
> 
> I'm reworking it all as we speak.
> 

Look forward to it

Balbir

