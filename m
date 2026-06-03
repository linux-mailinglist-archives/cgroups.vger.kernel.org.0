Return-Path: <cgroups+bounces-16593-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zPzEOq0H2qEowAAu9opvQ
	(envelope-from <cgroups+bounces-16593-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 07:00:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544A634334
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 07:00:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=baP6OAdj;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16593-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16593-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00898301B524
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC773033E6;
	Wed,  3 Jun 2026 05:00:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D369145B3F;
	Wed,  3 Jun 2026 05:00:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780462817; cv=fail; b=Bmt3tM2pCmUAhCouorRnA4ECzUTnvWaDkaVRAH+wIo51QSTzgeYY8ixaO/m0z0ai8YTA85Ec3mz5ukDLqg+qsEFGeWWEs/26/DjMOAmKUVyLidHWZ/kitHtxxcYHtffeF7DVU8u/+WqCo8XDqGd3KL4RtvD2O4LAGQpX8SVoeRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780462817; c=relaxed/simple;
	bh=aHIvLqjwl35Ieal2pD9PGWCp1Dq8uAdbxigAF0uLEMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3pIbe3lWATqRkyCa5qo/G/gPyPN6PR1V5LeMcwm9DVrh9onR0u3igZnh+UFzmPHtM6wvQyJb+AKzbFyUa2/DDOg/ldbjzJU58I+drzSQjRI50/A7zhh4gsipBlo/wSl8jNx9k4/kBjyVA4zITAKPHvF1I9p4sPW5046VHYE+H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baP6OAdj; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVT38OtQkpc9RepAN9aN6IxbQpKZ4XuL5ezYSC5+bvVVBz9xcaxk/Ly/1IDkIBYGiUlWtGuOgdD3hzroQHI7zrqCEKts+JFFc3fxHFIhHqh/zuCuOQb+O/KBwcA4+c34jIXSjl46FS8HMayWYis28sWkbJNzRnjEPkJgyY684LVFWlTxkj/F0U1Gov3MXaagHefDbP522Q6VfWj4n9sBxFhPAB2p3fpHxBrX1nJrnXfJe6KIYUweZ1DQmhZIywF/wifvBnRLGvhL224nsVqgY67I1Gop06GvFN3667eD6WWrE5DwAuHYphOTmBSBAeonA3ttQSQ63IRFNzHKZmCRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCW/QLLpRGGLbWCkWLPVcWArUftfeG7Y5hVWbTZSvvY=;
 b=XFgUiGNgaPsyVYiekus/pjceRLlB0maBViBN5mmV+2WmqTAncA9D/K0mjpuYAJQPsgsrzBcIHMQlZMX7YZ75bWtxMfLSN9i57bPseMF3UA2E7ZXv1dHIjqoYmGU3+295r4nzyPR/EOyPY9HpZsOHYKhVpJYHTQv5kkBcGwXctqC7rnm+KqT51PScv3n6GcXqMO1t6scEeSCypbspK1OBgk/RFIiiTgBFr81nIkQLmj7j4fc8/qiQ4lsc/Jev9qaMCkjh4D7hRBiJ2J2bcFJHLXOa0W2pG+eQNKi7ZeMHp9yf/W1phIKWRw+7BdHG7WjGl/V5ryeLPmB3LZAxuYnhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCW/QLLpRGGLbWCkWLPVcWArUftfeG7Y5hVWbTZSvvY=;
 b=baP6OAdjRhLxqqOyQHMF8AE15mY8ydh0chQu2gtD4zntM4diVpVliT9XodbzZi6v73NOZoBRrHoYcwuZL3TsIwYdIr1HeleA5teKCF7MMufP56y47OWhT9WFQUlBhoXHoUSnIzhdi6mjb8yhZpG7CPNbmw00kaChEjU95BOKPDJ1bi7T//uGcOD88cnVoyd2ociJO6+Za1ClZMvspConf7SvtFJ2Smpx8x6wBV076pS5qbk7i3hZRNacrHfsNf3kKDQQZ1TvbPfa3PtHIRie82tK3U1Ireq4Rx8zDbOq3Wx74gWpY4Oz9A4Rz8dtjkvIc5jCGp1vuW2akgD0mLnONQ==
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 05:00:07 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 05:00:06 +0000
Date: Wed, 3 Jun 2026 15:00:01 +1000
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
Message-ID: <ah-0CyZurn5D1ezY@parvat>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: ME0P300CA0035.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20b::25) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4913df85-93dd-48f0-fe32-08dec12cfa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099006|18002099003|22082099003|6133799003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	EUyxNe2YsJ7vMHWc70ED249CIGfTZgmJBAyswiljQTh9ZmMfFcqpd64KqlPaMFSEwbLv4jkLjZJoOysY/msHYxQzYSovMXO6DfVqoOSetjSralSLnHZ/HhjEITg1nqS9I//zzZnA2a6svhGvdCH5N7RYK0jkggs5NN2A2ssYLxTXJm6j94/dUhXqXONTSnu5FxnKcnaFUgpmUJyuQ18dQ4Ai9dI0APv5z50Kh1em3qba9nrOsr2VOD9qCo5J2YV8xe1WtrGiSYZy2vDipRY/wQkpawYQBuFLk+s/+3lIoOGePNDUtBwZ2j7YR/ZlfbTmVJqKZOQNddQMaDc1e+mYiZu2yZjGxAACcb5a92JITuPQo8EaBnlMOpAitdhZ3IxcuPeobIm6KsaLkYl6kIZYwrasnNd8zNPFrH7imhkT/c1rOW/ftcM/zRUf/A7yHZTE4QHcOgDMPODH2V9vu82iZytnh2TUgATcfJet/r2ukoo4emOwHi5zc0bb6TDBjygjyAi7ENlhCK7ZVGdCYrI5vsmMD+Z04ELFTrxyxWeo2wzs/OPmguavjpMt87x1EfS3Ps/IovvvrI602eMKqvVg0DaARdZ61WXNEfIoEreQvJdrV/taXI4gncIV7IhwRHg3IyZhdc/ywXjgYTznLv+0B/7IclJ3Z6otZbOBiyNODVaSXQcReA9DjfghhoBUJXX8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0XFHs81mfteDqi4BFNoxjlsNueccln1XjkKfSFyBJqye5l6k4dItEaMRzvm?=
 =?us-ascii?Q?c4jFhP35e73sMQA5Ro5E9FVeAlJmJ5TNeChl0CQe5YYoyGBw00ksoDx+mJvo?=
 =?us-ascii?Q?AET2ZvvnXR1M4EGTyo09inJvvFcVrxuFa+QzHqShExMSvEoIfpar3Z5t9HdB?=
 =?us-ascii?Q?tutB/Ctd+lYdS2NLzRgeXGWDj3/msJ4k6oVZZ7eNfwi7loA43NkfELoSf1+t?=
 =?us-ascii?Q?XRANMWbgpwcsY8aSinGbPrIvfQoRghOz89hlQKLgNu2+qxifz/Z+eV61uWVB?=
 =?us-ascii?Q?14jQrIhLHXbPYof04KpY6z6Z1eg4R1vwn9ysOr3WLILjPGgsT/ykXKSi8ER+?=
 =?us-ascii?Q?zCnlCSCM39+pMiBMDXf9QBobd8yKriwjuJ/EoCBnd4j13CZRMJMM3lJ4Gzk3?=
 =?us-ascii?Q?wNntsqilTUB7lUgKQOQ6+gyWdMpPy/Pj39tZ95WE1uPxnIcxSRao/emYR0Pk?=
 =?us-ascii?Q?DhkUyWU+Gt7SBR/Hm1RBXSn9/Aq3IP6b3y2jx+jkI1i/iN879ke5iEkBns3/?=
 =?us-ascii?Q?9Y+WOW/MskAW/LZH0XbBmWPoOW4inejGJ9/7Z1KqIGC4N0a4v650DFwGmF+U?=
 =?us-ascii?Q?KB/0w2xNVpZFLEjIVgnW5FzmLQZypdfghtVNOPRDN8gEV1rwenTG31+YKgaP?=
 =?us-ascii?Q?cchB+1nvCOkqqu1PGo0GO+C0PRo2yZpsqBk/pZlZtFKBfCArzvHaKsLvHBtc?=
 =?us-ascii?Q?RRX/4ZHVG2mya5a2PH7eZ9KZtxwsgikb7vr8nFhoCteHMyAb+sX7lOvWfJiO?=
 =?us-ascii?Q?y9yA83lekSeKCKkr9aMErCzg0sGKEmvPoTx+EFuz3+/HL9grX6bUAqqo1H/n?=
 =?us-ascii?Q?t3vnY+p8JaLEYx/stQdqGYBxb17AQjwsPexb9v4le/IKXoCVn56PwnZnqsiE?=
 =?us-ascii?Q?+gBi65EtC345eSKQ6SSkLlGiWWLKScc3AoZVbbU9VdcZOYnAo7I37n8Il9MT?=
 =?us-ascii?Q?oWllIJCbOaCrtPTlkSGNH5O2dIimdvyFDiU8v568kwJYQ+bEQ7xN4CMzuYXY?=
 =?us-ascii?Q?WERCJ8DrEHVOrXvwx6PUyyraycE/iisIcQGXcA78dN/vsdCy/aLHkj4b/HzP?=
 =?us-ascii?Q?mc8VgwECyTDyRMJ0gr1to5flLGg1dbj6sEO9tFtW67g2FaQ5HKlgMvBlJHqa?=
 =?us-ascii?Q?JTbsmCCQkpFXefWL/ZJgmIzNIhMJA4nG9aFld2y9o+h1iti2dSyWw1l1WVaa?=
 =?us-ascii?Q?HXleQoN+OgxfmmAYBN9zs0i2DeEb/5CX8TGDhYH3IHmGcl4X8AUBFIMFWzet?=
 =?us-ascii?Q?e1KUzv/FDb1brU9/IiS3/jg9AdlbVZEiTMYcQYItWI9at5VzXW+Fo7UYxqak?=
 =?us-ascii?Q?eVXNV7wHtRPmQsI5DbBcTGxurTGTv1V/ISFbwnaskl2p/5G07iSMbx6FZ9Ik?=
 =?us-ascii?Q?vrLTYSaV8mqsf4xvxdmRJSn1pPvANFihb5DoezJshU2TKVF5ZJF7U/zf6mBo?=
 =?us-ascii?Q?223EbJkrteJ7Y3e9QSYxudi40bpfifZt1RNNYsrtGvhY7w89NWygwH4qTXGi?=
 =?us-ascii?Q?ZkwGwVLb/tYSPwib0xs/yI3vhJe/iD5PheCIM8+W0uqXseFSdoZhWqB+/vXx?=
 =?us-ascii?Q?8UbolJHVr+ADKDiBiJO5ft+1gIpShUhM1rOhTcBhPn9hvVWztN4//squ3NGx?=
 =?us-ascii?Q?OrcL/raHK2954JfVqAZ2yBuATtWAZa3Xaz0nqQWuRmme8GvXqyuFbGGpgJZa?=
 =?us-ascii?Q?hDKDE5Pl7LaAISKxFgIxohWu/vZh4XZPUPCWOe19/raTQzZ1iHm9ATEqBQye?=
 =?us-ascii?Q?LGADBMoiyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4913df85-93dd-48f0-fe32-08dec12cfa7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:00:06.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ+GcgQQCHDt1JAI8jVUCLvmCnoQTUX/MGDKWAvB321YOidmmwAqnY8AV5segEqT7XLj9fXWzpws09C/YgRiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmusv
 illemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16593-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3544A634334

On Tue, Jun 02, 2026 at 09:57:48AM +0100, Gregory Price wrote:
> On Tue, Jun 02, 2026 at 12:16:50PM +1000, Balbir Singh wrote:
> > On Sun, May 24, 2026 at 09:50:06PM -0400, Gregory Price wrote:
> > > 
> > > I'm debating on whether to include OPS_MEMPOLICY in the initial version
> > > if only because it's not intuitive how it interacts with pagecache. That
> > > needs more time to bake.
> > >
> > 
> > It makes sense to look at it and then decide if it makes sense.
> >
> 
> I am thinking i will ship without any OPS flags at all for now and the
> have the introduction of ops as a separate series.
> 
> > > alloc_pages_node() is the kernel interface
> > 
> > I was think we wouldn't need explicit flags and that allocations would
> > happen from user space using __GFP_THISNODE to the node or via a nodemask
> > based on nodes of interest. Is there a reason to add this flag, a system
> > might have more than one source of N_MEMORY_PRIVATE?
> > 
> 
> There's a few things to unpack here.  I discussed this many times on
> list and at LSF, but to reiterate.
> 
> 1) __GFP_THISNODE is insufficient to enforce isolation and otherwise
>    not particularly useful.  Additionally, from userland, it's not
>    something you can actually set.

I was thinking mbind()/mempolicy() is how we get to it. It already
accepts a nodemask.

> 
>    for node in possible_nodes:
>        alloc_pages_node(private_node, __GFP_THISNODE)
> 
>    In fact it's the opposite semantic of what we want.
>    THISNODE says: "Do not fallback back to OTHER nodes".
> 

That's why we need to control the fallback nodes carefully for
N_MEMORY_PRIVATE

>    The semantic we want is "Do not allow allocations from private
>    nodes UNLESS we specifically request" (__GFP_PRIVATE).
> 
>    __GFP_THISNODE does not actually buy you anything here, AND it's
>    worse, in the scenario where a private node makes its way into the
>    preferred slot (via possible_nodes or some other nodemask), the
>    allocator cannot fall back to a node it can access.
> 
>    __GFP_THISNODE cannot be overloaded to do anything useful here.

Let me clarify, I meant to say, let's use a nodemask for allocation
and __GFP_THISNODE gets us to the node we desire, if that is the only
node. My earlier comment might not have been clear.

> 
> 2) We're trying not to expose *ANY* userland APIs for this, at all.
> 
>    The ultimate goal here should be one of two things:
> 
>    1) fd = open(/dev/xxx, ...);
>       mem = mmap(fd, ...);
>       mem[0] = 0xDEADBEEF; /* Fault device page into page table */
> 
>       In this case, the driver is responsible for doing the
>       alloc_pages_node() call.
> 
>    or
> 
>    2) mem = mmap(NULL, ..., ANON);
>       mbind(mem, ..., private_node);
>       mem[0] = 0xDEADBEEF; /* Fault device page into page table */
> 
>       in this case mempolicy.c is responsible for doing the
>       alloc_pages_node() call via the _mpol() alloc variants.
> 
> Addition OPT flags (reclaim, compaction, whatever), would
> (optionally) allow mm/ to operate on the device memory with, for
> example, mmu_notifier callbacks to tell the device to invalidate
> whatever it's caching about that page.
> 
> This would all be relatively transparent the userland, all userland
> "knows" is that it's getting memory from a device (/dev/xxx) or a
> node it's otherwise aware of hosting device memory somehow.
> 

Why not use mbind() API's? Do we want to gate allocation/privileges
via a /dev?

Balbir

