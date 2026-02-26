Return-Path: <cgroups+bounces-14409-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMgnG+2+n2lOdgQAu9opvQ
	(envelope-from <cgroups+bounces-14409-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 04:33:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9A1A093F
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 04:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00ED30D0248
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F706387587;
	Thu, 26 Feb 2026 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JY/H0VOU"
X-Original-To: cgroups@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FE3859F9;
	Thu, 26 Feb 2026 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076458; cv=fail; b=hd5F9YcFqhiWVaC2KpQYA8x7v6jbvpSGP5YZFtcCb5NXtCTkeO1m0tixO5trvgjWzwKeImiTatoDlTlXXCOoMZmiB016LfWJA2mz6xlvrK3f5J7JaGDgEPudArxhvlqFvEqx0muBTi+Up1tAgqPEoDL3WhEttJa4ufL3KhvsSMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076458; c=relaxed/simple;
	bh=vnplhg4D5nS0HjbDXNgvxI78kcxAmGuQVTwzeLiOVno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugh5Ti8pB72uABjzVQvRKF3Foh5scigEZA4ggnoJyHzOH3vy2kqaBAAOhcYrNa0pz2P462t7hk8qY1Dg4U0OpuKTvFsU3rFZe/DdZSrWrgh4Ge7Qmb6U0urKBYG/cHxG5U3MvA8kZmbdJmsRgYtE6853USwLAXrmVzQVe9Zsjhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JY/H0VOU; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtZII+eXMcr9T6W5oCKv8F7/NhAIQpsPYRd6jve178EJ07WbI54YrmIr1ahjBvPCrXyB5+n3BhyLt58YRVVzfJpoN9qKpV9aMzmC/sNomDnw+JPR0E2zwsm+DtcEle4S21vmPgjauqg9AT3dJog3pD4sLg5f3JmWw1CT6297nuJ/t7b/2D2eSdkeOgF2KbGwOYNB2CXvPhhRglS5liEcVUSkMYGONGrMWdlO2tRF80AmNlcPU4NmJ15UTAMJGiqDUfyBnR5qoyas6sLGeUlCv0VPJOfN0cn8vLueAlNu6EQJBZIFuT8kQG/F7Y4htpUhdfckkxk/fla0xXvvEZgncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08odPDTMVouyBzUro4htAZFAEVLPOdeU+1oTGv+2bHQ=;
 b=S2CZDGMuplrlU4TSx+wgU2pUz6dlcD6FEhlFrHqLsx4I9Mx9tSKt4Zx9k/7gB8HjvyeJaw4X9vne+iB84RxJElRT+VocJKE1Db9etQeCmH8nnkCbda/RL5nWw/Pu8hglBbNmVxBmxlQ7bEHKmAGGJ015iUk1XA24jndSBYIdFUeXwilz9i1iXQ2h9kazF154VuV3dFL1svdVT9jYxACLoldeKIU3WDgBjh4vy+LgLUEvlQxklrsAPmtTXC/0HyythceR06Ij1B67MtJb59eYnNIbqb4dopLffu1iaVsi0QvnI6wElBb2rwFAYvt1HJ4HD4A2se/6t3gqljYRLuUKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08odPDTMVouyBzUro4htAZFAEVLPOdeU+1oTGv+2bHQ=;
 b=JY/H0VOUqe274riznGAJa0e12MvDk3/euOhtEzZtb/8BIvCUBg7V8Ya0qOWGN9B9wrZhC+bQnMeXK81L9Bp1cz4NoESFSOBwedomFYwXlA+2eKuqEf/fT+R3KKi6tiMizft0AR2lhzx2uXYhVFD3ETNcaU1rEbg689diSicmePbvKYixeCc4p9gczFgg/MrDVd2Y7mXj7p1cMuDT++xbBPmUXNatnte+lNEjcRJcj/s+hzLpAoU3V4mxJ5hoc2hf9yOlB0vtdRQOwWUT2zXDao4HLfByKAn6LA/MEPdvVrdvvTnjMInzET4xaZa0BWOEHjecQAys0PTRkQ/m+cJgzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Thu, 26 Feb 2026 03:27:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 03:27:29 +0000
Date: Thu, 26 Feb 2026 14:27:24 +1100
From: Alistair Popple <apopple@nvidia.com>
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
	ying.huang@linux.alibaba.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	jackmanb@google.com, sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	muchun.song@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, jannh@google.com, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com, 
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org, 
	roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SY5P282CA0156.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: b76d4c9c-f38a-476e-709e-08de74e6f839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3122999024|7053199007;
X-Microsoft-Antispam-Message-Info:
	gU5EG9nT9sqezzwyfcsqTVbui6oL6hj904behaXZshG0avj0Q54nAWIlzwq4MsrdcjWKhFxMjpojVLsjy1k59fPO6dW+fD3cqI3MvCWRXjFQh8wXbswb3wIyuHEELTC5rJV1Sqv86ZC2YO1ewPXhFqJGpJokmB8AfF+yPmcdrowMBahKAFyxk8vp9ziMi+S7F6s+y4pb/f+Vy4OGbnavLvdYSe78g7FYKIVux/i7DUVEqO9t6774sObK5mL8+QIYH5JnWc7KMrH0NXty3LV22VDCWtWtVmq283m0ifG/HOTzRTQrEhyvr0f0gPco9PJvSBFK6e/bbv5QODLwCQhXzgIZA9UsFyx3HOeP6pJxvEYyxe/XBfg1HtCffvHgJBspGE3bzNPYcfZIzbtoi4O2dZHjJDBIeEA6JmMl2N+fk0P+QRQNlwxBbzi/DgzhC/fAlWcl1jRIemoHPr2MczmzW6C1lXthK/eAXlndzCjjsXKGbvcF7tPvp1NZ20uxN69/t6FEtcXc6U4qrpKb/DKUBm8DlwI4aEO3Fahapm3QsJzUd3dxtdm3qaqQlqkLs2CHN9wrdcDHaSMALWcJkePyJgMMVzl4Xdxx2wYbIYPhOvNtTTm+sYEkGMQlqUftD6Z8wvWrkTSk1oJLb6gtmU0JtsB+GlH4ObJ3Hg66gruU3oAhuZLZ3XF/Uw5LeXzbSir0nvyRWGDyyxDouIi8KuomHd3Gc5tnUUPuO/nRg/8JBN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3122999024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VCUih8GdWVkNmtx4j7uHDpf/wu8v9SUWVpt+uJxamleD0qvRRhv+DIb+t6Ru?=
 =?us-ascii?Q?1QMj+YkvpFjbYdJIo0sCzfmvR7wos23nMzrNfPqA+KOGuOV0P6/3KBPXk93J?=
 =?us-ascii?Q?emwMCteS/rB5iojf250iESzjoJQdqleiWZt6lIDggc9Si61PbZpZlzJ9tPdc?=
 =?us-ascii?Q?cwZJksAbWOEKQZkmKTk5/fRVXiuafGxL1az+/GDxYrXqvLZJNwtGvkrblZUB?=
 =?us-ascii?Q?lHZA/HZ8km+dnPkWR41Y7Ba3u7E6KnDA1g6hAj/CclA1R/NJsKGMbLCQ5jQq?=
 =?us-ascii?Q?m4kycGvOhZt9VExr4C9skxODoa1GwBlXvaMg2ADTqhvFitP6TBj9ZG71oNUo?=
 =?us-ascii?Q?C7wYCl5rVa1a0TejSEOASCkSctAZty6ndyOcNsBxmJy4Rph5g50QerpIw2aP?=
 =?us-ascii?Q?9T5DUHnUwNAmDBJ1iJtayz3pPeeW2bmwB3alxOZUUljNqW0JdR+WmOkaiQbX?=
 =?us-ascii?Q?0/eyIV3UN2Ycurbk+BE2/DV1/Zqnfl0SgkjZVY9APP9ewbEDAcHSmnsiEdAY?=
 =?us-ascii?Q?FoJfcodGScfM7NFNXnlZssXpkIl6gENLdi+Lc/hvO+RTIH65OsBhWzfecxgo?=
 =?us-ascii?Q?foDPKBty2A7MQbmrJhP0cBZihZ/xFzZxnYLQB5sCrJWfoI4WSHc20ceWa6Ff?=
 =?us-ascii?Q?NZbDYIlR2Rpw9GFSBFf3uvATMP1F9Ux1fb45J2M7LoQ3UpqO+jtMDfunV1c0?=
 =?us-ascii?Q?or7z6Y59t/upaDOUIp42HHD8Vb1oZWPCXKdydMA1P7CJl80FYjlB9CEmnB7K?=
 =?us-ascii?Q?O7kfiRUTrkc3z7AFhDoogdmHBIqi16U9DDYrna8zWKV3uQQFc97L1AWRQmJi?=
 =?us-ascii?Q?3IEbvfqTGSTP+c52KXOMgEHfrXPyjY7G8osOSGSWCK4VPUoEyGFT6dYkx1+v?=
 =?us-ascii?Q?nm6wPfKeXirMCvwCPKHBLpIVG3h87ukTdfHyKTyCrCwTxALLvTnIkeevGLun?=
 =?us-ascii?Q?FNVlvypsfHqnN79nDzDAmYeCevqLRIR4r55ejug6OLOScje66Dg+ORZGwbnH?=
 =?us-ascii?Q?l3uAzSAwppuYzxAXKfP0mzNeByHBeBVmQi3IY38gUF7OQNnGgOahVVUNvacd?=
 =?us-ascii?Q?i8fpnkCV7kjRWvp/fV/+KgUKApGuYNrqgp5nLHjUPmam/cvaTlR4G1YgG0MH?=
 =?us-ascii?Q?mgPT3xpiJrJrPQjq2rH0Bph4oCba73JCbFqVIrRjQjlhaPbaPH/f407GiARt?=
 =?us-ascii?Q?MokLss0lrhv+9hxpIeiXjlAXMzPeCqE5rLi7cIrBZb3VzcQXeCw5eiesQ3lT?=
 =?us-ascii?Q?WwSmtcgiMASUYcB4E6x3+Pr8tW8UbQZwMRFmgcCEyv1VhzDy1IK3ggV9QyMi?=
 =?us-ascii?Q?R80odJhmhxWaoJCvAxKPmsyaIG1tHn2vMIslcc0iroIGyIXDvb0fa6nezRJK?=
 =?us-ascii?Q?b3MQwPRTUBj8fyuykqBKl+pZ6juJQ/pG4gKQhhxoTzaoosWbpJxEDxBd3O5S?=
 =?us-ascii?Q?cNc9KuwhIno1Z8DwCihRPg2t3k1TVc/QXaG5EewZzIjfLXXaeP/4rlgtun89?=
 =?us-ascii?Q?VBVNEKfDDtorhB4TAMjBdOtc3DTyKbj3FT2DEdhUsLtOwGlvaljmokqPCeHR?=
 =?us-ascii?Q?a4QivalE+fnILW5dRHGb8e8su6zCFV9eljgARSmVfU0xnV3GYZmV9fiK0FMg?=
 =?us-ascii?Q?X/FXX7gbdysLqzRVRTTmnD0yRieAQiEcIWaf4/UQLLgRKsvMpq7wNhk0xT5K?=
 =?us-ascii?Q?kQ70egXM1gT93/Op+kZf9BHQmSBvN1+AJGAhaDr+2S0XlRUEwOXEblb7PKD1?=
 =?us-ascii?Q?2p0ySQiluw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d4c9c-f38a-476e-709e-08de74e6f839
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:27:29.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHho5pd9MSnEKg4od9jxRDnEVW6zaK8+nytzyolSa5+0nOJO6rBoWsRICn8kqEDBR4YE+1aXW05LPdi68OgT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14409-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[apopple@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.994];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE9A1A093F
X-Rspamd-Action: no action

On 2026-02-25 at 02:17 +1100, Gregory Price <gourry@gourry.net> wrote...
> On Tue, Feb 24, 2026 at 05:19:11PM +1100, Alistair Popple wrote:
> > On 2026-02-22 at 19:48 +1100, Gregory Price <gourry@gourry.net> wrote...
> > 
> > Based on our discussion at LPC I believe one of the primary motivators here was
> > to re-use the existing mm buddy allocator rather than writing your own. I remain
> > to be convinced that alone is justification enough for doing all this - DRM for
> > example already has quite a nice standalone buddy allocator (drm_buddy.c) that
> > could presumably be used, or adapted for use, by any device driver.
> >
> > The interesting part of this series (which I have skimmed but not read in
> > detail) is how device memory gets exposed to userspace - this is something that
> > existing ZONE_DEVICE implementations don't address, instead leaving it up to
> > drivers and associated userspace stacks to deal with allocation, migration, etc.
> > 
> 
> I agree that buddy-access alone is insufficient justification, it
> started off that way - but if you want mempolicy/NUMA UAPI access,
> it turns into "Re-use all of MM" - and that means using the buddy.
> 
> I also expected ZONE_DEVICE vs NODE_DATA to be the primary discussion,
> 
> I raise replacing it as a thought experiment, but not the proposal.
> 
> The idea that drm/ is going to switch to private nodes is outside the
> realm of reality, but part of that is because of years of infrastructure
> built on the assumption that re-using mm/ is infeasible.
> 
> But, lets talk about DEVICE_COHERENT
> 
> ---
> 
> DEVICE_COHERENT is the odd-man out among ZONE_DEVICE modes. The others
> use softleaf entries and don't allow direct mappings.

I think you have this around the wrong way - DEVICE_PRIVATE is the odd one out as
it is the one ZONE_DEVICE page type that uses softleaf entries and doesn't
allow direct mappings. Every other type of ZONE_DEVICE page allows for direct
mappings.

> (DEVICE_PRIVATE sort of does if you squint, but you can also view that
>  a bit like PROT_NONE or read-only controls to force migrations).
> 
> If you take DEVICE_COHERENT and:
> 
> - Move pgmap out of the struct page (page_ext, NODE_DATA, etc) to free
>   the LRU list_head
> - Put pages in the buddy (free lists, watermarks, managed_pages) or add
>   pgmap->device_alloc() at every allocation callsite / buddy hook
> - Add LRU support (aging, reclaim, compaction)
> - Add isolated gating (new GFP flag and adjusted zonelist filtering)
> - Add new dev_pagemap_ops callbacks for the various mm/ features
> - Audit evey folio_is_zone_device() to distinguish zone device modes
> 
> ... you've built N_MEMORY_PRIVATE inside ZONE_DEVICE. Except now
> page_zone(page) returns ZONE_DEVICE - so you inherit the wrong
> defaults at every existing ZONE_DEVICE check. 
> 
> Skip-sites become things to opt-out of instead of opting into.
> 
> You just end up with
> 
> if (folio_is_zone_device(folio))
>     if (folio_is_my_special_zone_device())
>     else ....
> 
> and this just generalizes to
> 
> if (folio_is_private_managed(folio))
>     folio_managed_my_hooked_operation()

I don't quite get this - couldn't you just as easily do:

if (folio_is_zone_device(folio))
     folio_device_my_hooked_operation()

Where folio_device_my_hooked_operation() is just:

if (pgmap->ops->my_hoooked_operation)
	pgmap->ops->my_hooked_operation();

> So you get the same code, but have added more complexity to ZONE_DEVICE.

Don't you still have to add code to hook every operation you care about for your
private managed nodes?

> I don't think that's needed if we just recognize ZONE is the wrong
> abstraction to be operating on.
> 
> Honestly, even ZONE_MOVABLE becomes pointless with N_MEMORY_PRIVATE
> if you disallow longterm pinning - because the managing service handles
> allocations (it has to inject GFP_PRIVATE to get access) or selectively
> enables the mm/ services it knows are safe (mempolicy).
> 
> Even if you allow longterm pinning, if your service controls what does
> the pinning it can still be reclaimable - just manually (killing
> processes) instead of letting hotplug do it via migration.
> 
> If your service only allocates movable pages - your ZONE_NORMAL is
> effectively ZONE_MOVABLE.  

This is interesting - it sounds like the conclusion of this is ZONE_* is just a
bad abstraction and should be replaced with something else maybe some like this?

And FWIW I'm not tied to the ZONE_DEVICE as being a good abstraction, it's just
what we seem to have today for determing page types. It almost sounds like what
we want is just a bunch of hooks that can be associated with a range of pages,
and then you just get rid of ZONE_DEVICE and instead install hooks appropriate
for each page a driver manages. I have to think more about that though, this
is just what popped into my head when you start saying ZONE_MOVABLE could also
disappear :-)

> In some cases we use ZONE_MOVABLE to prevent the kernel from allocating
> memory onto devices (like CXL).  This means struct page is forced to
> take up DRAM or use memmap_on_memory - meaning you lose high-value
> capacity or sacrifice contiguity (less huge page support).

One of the other reasons is to prevent long term pinning. But I think that's a
conversation that warrants a whole separate thread.

> This entire problem can evaporate if you can just use ZONE_NORMAL.
> 
> There are a lot of benefits to just re-using the buddy like this.
> 
> Zones are the wrong abstraction and cause more problems.
> 
> > >   free_folio           - mirrors ZONE_DEVICE's
> > >   folio_split          - mirrors ZONE_DEVICE's
> > >   migrate_to           - ... same as ZONE_DEVICE
> > >   handle_fault         - mirrors the ZONE_DEVICE ...
> > >   memory_failure       - parallels memory_failure_dev_pagemap(),
> > 
> > One does not have to squint too hard to see that the above is not so different
> > from what ZONE_DEVICE provides today via dev_pagemap_ops(). So I think I think
> > it would be worth outlining why the existing ZONE_DEVICE mechanism can't be
> > extended to provide these kind of services.
> > 
> > This seems to add a bunch of code just to use NODE_DATA instead of page->pgmap,
> > without really explaining why just extending dev_pagemap_ops wouldn't work. The
> > obvious reason is that if you want to support things like reclaim, compaction,
> > etc. these pages need to be on the LRU, which is a little bit hard when that
> > field is also used by the pgmap pointer for ZONE_DEVICE pages.
> > 
> 
> You don't have to squint because it was deliberate :]

Nice.

> The callback similarity is the feature - they're the same logical
> operations.  The difference is the direction of the defaults.
> 
> Extending ZONE_DEVICE into these areas requires the same set of hooks,
> plus distinguishing "old ZONE_DEVICE" from "new ZONE_DEVICE".
> 
> Where there are new injection sites, it's because ZONE_DEVICE opts
> out of ever touching that code in some other silently implied way.

Yeah, I hate that aspect of ZONE_DEVICE. There are far too many places where we
"prove" you can't have a ZONE_DEVICE page because of ad-hoc "reasons". Usually
they take the form of it's not on the LRU, or it's not an anonymous page and
this isn't DAX, etc.

> For example, reclaim/compaction doesn't run because ZONE_DEVICE doesn't
> add to managed_pages (among other reasons).

And people can't even agree on the reasons. I would argue the primary reason is
reclaim/compaction doesn't run because it can't even find the pages due to them
not being on the LRU. But everyone is equally correct.

> You'd have to go figure out how to hack those things into ZONE_DEVICE 
> *and then* opt every *other* ZONE_DEVICE mode *back out*.
> 
> So you still end up with something like this anyway:
> 
> static inline bool folio_managed_handle_fault(struct folio *folio,
>                                               struct vm_fault *vmf,
>                                               enum pgtable_level level,
>                                               vm_fault_t *ret)
> {
>         /* Zone device pages use swap entries; handled in do_swap_page */
>         if (folio_is_zone_device(folio))
>                 return false;
> 
>         if (folio_is_private_node(folio))
> 		...
>         return false;
> }
> 
> 
> > example page_ext could be used.  Or I hear struct page may go away in place of
> > folios any day now, so maybe that gives us space for both :-)
> > 
> 
> If NUMA is the interface we want, then NODE_DATA is the right direction
> regardless of struct page's future or what zone it lives in.
> 
> There's no reason to keep per-page pgmap w/ device-to-node mappings.

In reality I suspect that's already the case today. I'm not sure we need
per-page pgmap.

> You can have one driver manage multiple devices with the same numa node
> if it uses the same owner context (PFN already differentiates devices).
> 
> The existing code allows for this.
> 
> > The above also looks pretty similar to the existing ZONE_DEVICE methods for
> > doing this which is another reason to argue for just building up the feature set
> > of the existing boondoggle rather than adding another thingymebob.
> >
> > It seems the key thing we are looking for is:
> > 
> > 1) A userspace API to allocate/manage device memory (ie. move_pages(), mbind(),
> > etc.)
> > 
> > 2) Allowing reclaim/LRU list processing of device memory.
> > 
> > From my perspective both of these are interesting and I look forward to the
> > discussion (hopefully I can make it to LSFMM). Mostly I'm interested in the
> > implementation as this does on the surface seem to sprinkle around and duplicate
> > a lot of hooks similar to what ZONE_DEVICE already provides.
> > 
> 
> On (1): ZONE_DEVICE NUMA UAPI is harder than it looks from the surface

Ok, I will admit I've only been hovering on the surface so need to give this
some more thought. Everything you've written below makes sense and is definitely
food for thought. Thanks.

 - Alistair

> Much of the kernel mm/ infrastructure is written on top of the buddy and
> expects N_MEMORY to be the sole arbiter of "Where to Acquire Pages".
> 
> Mempolicy depends on:
>    - Buddy support or a new alloc hook around the buddy
> 
>    - Migration support (mbind() after allocation migrates)
>      - Migration also deeply assumes buddy and LRU support
> 
>    - Changing validations on node states
>      - mempolicy checks N_MEMORY membership, so you have to hack
>        N_MEMORY onto ZONE_DEVICE
>        (or teach it about a new node state... N_MEMORY_PRIVATE)
> 
> 
> Getting mempolicy to work with N_MEMORY_PRIVATE amounts to adding 2
> lines of code in vma_alloc_folio_noprof:
> 
> struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>                                      struct vm_area_struct *vma,
> 				     unsigned long addr)
> {
>         if (pol->flags & MPOL_F_PRIVATE)
>                 gfp |= __GFP_PRIVATE;
> 
>         folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
> 	/* Woo! I faulted a DEVICE PAGE! */
> }
> 
> But this requires the pages to be managed by the buddy.
> 
> The rest of the mempolicy support is around keeping sane nodemasks when
> things like cpuset.mems rebinds occur and validating you don't end up
> with private nodes that don't support mempolicy in your nodemask.
> 
> You have to do all of this anyway, but with the added bonus of fighting
> with the overloaded nature of ZONE_DEVICE at every step.
> 
> ==========
> 
> On (2): Assume you solve LRU. 
> 
> Zone Device has no free lists, managed_pages, or watermarks.
> 
> kswapd can't run, compaction has no targets, vmscan's pressure model
> doesn't function.  These all come for free when the pages are
> buddy-managed on a real zone.  Why re-invent the wheel?
> 
> ==========
> 
> So you really have two options here:
> 
> a) Put pages in the buddy, or
> 
> b) Add pgmap->device_alloc() callbacks at every allocation site that
>    could target a node:
>      - vma_alloc_folio
>      - alloc_migration_target
>      - alloc_demote_folio
>      - alloc_pages_node
>      - alloc_contig_pages
>      - list goes on
> 
> Or more likely - hooking get_page_from_freelist.  Which at that
> point... just use the buddy?  You're already deep in the hot path.
> 
> > 
> > For basic allocation I agree this is the case. But there's no reason some device
> > allocator library couldn't be written. Or in fact as pointed out above reuse the
> > already existing one in drm_buddy.c.  So would be interested to hear arguments
> > for why allocation has to be done by the mm allocator and/or why an allocation
> > library wouldn't work here given DRM already has them.
> > 
> 
> Using the buddy underpins the rest of mm/ services we want to re-use.
> 
> That's basically it.  Otherwise you have to inject hooks into every
> surface that touches the buddy...
> 
> ... or in the buddy (get_page_from_freelist), at which point why not
> just use the buddy?
> 
> ~Gregory

