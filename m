Return-Path: <cgroups+bounces-16145-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPR1JPykDmpxAwYAu9opvQ
	(envelope-from <cgroups+bounces-16145-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 08:23:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE759F603
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7A9930465D1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C53812E4;
	Thu, 21 May 2026 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVKFy9e1"
X-Original-To: cgroups@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FF2D3EC1;
	Thu, 21 May 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779344631; cv=fail; b=FzXPonyRJdM7/ol/oXk3vkqIDXW+75POk50M2OKqOjN1dA66xRuWS6rmPW14y4+YH9X2vZFIEq6ghsMhjsCq/mTW/jF7CU2Ca0yOUpEvTKTsT9Y2fviMML+LH4LGzlqziSz6itDmpEU31h5WBJb5b1paIreCTLiXRmCd8tR55Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779344631; c=relaxed/simple;
	bh=2kIJ09OE5ebrxtqhh07mWN+BDvoZDhcMKK9POhRtD5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKTvEkfhLPxeLa4tj+32JFyAlx9iBgOGfUY/iOKWy205BWC613M7T+XsP2puJBtQVcqgdtiCMln7vRofOD2oS92W8++zspqlwDI0/hv0PWlDrIgJMfEr6m1hh7kbLFF2NPZ/gv9pC29i3F3uK0ARFJFBxp7Xiv/C248wPDHcSvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVKFy9e1; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CINxPEV8+KWpGUu1cP+vYf+8vC0/sobhOwJS5d8VcLzxvPoWmb54+pVnbRAZ3YGUI9XLeOtoknISusj7CTNv923hsrhMMp1lx4MTb+W3EUCgl+vlaP8UB1rQB2ZPda+lYhApJx6k59a0Gr4bM8SwWkLNO5+lBCyUvKiEeAl4iYM5l74UhHJS6v09kMUkBRe+Lo0zrQtbNKva+i2ctx8rLud6vqky6UhljuCMq/XuSEwoqWk8MtkzCBzj9R7cnqM7h7c7eD94kaGSYv8CCdKe7la9tCHPWxHWBPXXUycLlP7gADIvkbGqvrfjWuWgUTHYCIee1qtXCMhkBnzMdLUK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlF3VWZvu9Puokyl4CmvwOEWj8cjg9IjRJmhYcALClg=;
 b=U56H2+b1vrpuEaIuH33K7LBVYIecjNetO+X1klX1QzkclJg5R23nnomouuV189wt+eDC5hBTQ/EEHs0R3d0mvYXPAj/NDQNVQTK6INVP00udIR25nt/oBFRnesiO4Bfj9GxFXyqgoI5c6XGQpK3Jopxa4H3Gil7soA50jk2Ez4luxFTlcIijMAXdM+XOPUM8dpPae77ZrhjP/kMwEI+8A8eipPwenf/JalMiFBKHfvLKv48szio+k8AXqGRtVBp3ZxFKqSjhFlGR3wqUFZjz2+u0ioK4kD04NzPBH7x7WHYiETUbEwwv3XEpr2pQp78xYVQAiEQcmJOM9i/Kt+HBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlF3VWZvu9Puokyl4CmvwOEWj8cjg9IjRJmhYcALClg=;
 b=lVKFy9e1kxUdaK/DI/21rlqpdN89WVOxqYeCJJ3PBcPl7Uu0JKEiX7PBMUsklXkD+Hl5er4Vq2NvNr+dZbKFlAK0Id244aK3oFe88BUDdUvN4UignkcYyZbfWlu4BrI9etYUx7qo95l4+hEzaOg4MVwSe6fzFIFkGsu2JTqI4LAaKTwpJNE1EC/NEsoE8gkMI3uCQVoabD+0XU2VcmeVZnO76m/6kMoTrbgBOgE/BYtcd4GxFR0ppDius7Xgpc2LR8U84Gx/6TcbyO/7Sd/+8RY9alGN1O89kIZGS/laPiN3iCmxeJG171cGk9ATNBbHeuu2AbyQmTLyyFPfsIBBsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 06:23:34 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:23:33 +0000
Date: Thu, 21 May 2026 16:23:28 +1000
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
Message-ID: <ag6XyvxR-NU5rGn-@parvat>
References: <20260222084842.1824063-1-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
X-ClientProxiedBy: MEWP282CA0189.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d6::14) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ec8808-837c-48cb-17dd-08deb7017bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	XaKjqcJrGp6BeWs6QxgEGIPL0SFbnxC994crffeuKbdgVNgTUQgmQ7avBNTxc8lpK5GOHcEcVlEC+BB1l5h+wsRUOp7KqvkXdIke4bcQtOFK9zTwka0GgY3OYN9VCGksAVl+ym2Pv/1rd6YNSX4KO7JFOpI+RHYyiPnzr/jBqKfFOgfC4/k/HYVyLAimW6xsO4cpyAVDjxMJS0kCMr5I/ucZhjvEn579WD4lymn0/nQojPwpcf7NtXROdwQ6ZOadU0Zk4FS7FxvGRlFBpHqf1be0uIjWgy6YmXxtM9D1oOlnZePNnjBxDfVY5euZp0QAjuKgW7p/6GqueRmQKy6BE+q3T1Txgok7DbtMe1opJpIaWeQ0SV3FQPMP/OLy8SGzOUpbD71Eoh+qN1AGo4dfhP+uk+/wY28gDx62pea0j6vmGsS/3PNXsD6u0htRwfNPeo0YHwU1NpT38XrHtGmXkAqmtVxbXaP7w74BemXlnLeOjBuRvAeQhvnA27YECHo7alBQs66W4RUaPSo9SJfQ3NCDGr1LSkSAB0V0zm0lH3XOb92FS8aTuApjv6bzifEtCy6iTDbWvxSSrDxVu5aqJQwL8bUNYwwayyPgWjpyAtgKPsQN7mGUst7P8ZU8qJIfCRPwWtQ4dkNW66aekcVmKNteCgjrnUfsgEKb6AcmEryYXmW4+B6d3ikrck6cPkHy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uqzAa/BNiOIpvCWjPBQmafm102FYCeqWfiso4teUhzOwU/z3SYWcTvk0m8BF?=
 =?us-ascii?Q?NFsLbPhS+sHFagLJDIwjwZsTVZ1Pqig9dAcq7FV4zkUtExqZaJBO1l/IEIRw?=
 =?us-ascii?Q?aggohfySPUSH6VNtSV7pH8Lt8IH3TAXBC6RxRJXhud/7OvqX9gRkyne76Zzg?=
 =?us-ascii?Q?GmikqViiZDzGRx34JqemampdQrJPNW7pP83QMHGZFLP1tUATZn3bgCMxTLLE?=
 =?us-ascii?Q?Iwsya6nMXgbccNLNfN8M+7CSK+QiM9I5pev12mteOphTJ5Fp5ezr0VWTXQNL?=
 =?us-ascii?Q?j8N1YGEDfuutcDescj/s2k3SwXZBL6AVbffZ/yhFFdqJkKk7pRfj38DOVyub?=
 =?us-ascii?Q?+QGCIjL471iI9q5Rw9pvQ576Kb5uGcsGzhtad649jHjVCVpgfUFPAfV6FhfS?=
 =?us-ascii?Q?F/DRC+mPYvZ2C9JBwnY6AxUyMXk4+QWlumM/LWa/QgnM8zlgh1wu32c8tJu+?=
 =?us-ascii?Q?SqahEV5i3YgKhuqYaTnocQS68SAcUvbHQJTL6UHZDESc7omCM9bAeSBVe/Qx?=
 =?us-ascii?Q?4qQM4gOrcAJhbFXNWbeXbidWr0abhlqs/s36uvzvXaqO6ydkDOHpFplRGtMh?=
 =?us-ascii?Q?dmzysFp51DDCXKXleBNWieALLUXxXY6IH9s7AthVFsfea1bIAHzIm8Urdedw?=
 =?us-ascii?Q?jUpGnkt8gIFVSSgnm3IaUWCwlnjCJfNZ/7sv9Jkd8uJ6IryZ4VXmAk5GJ2Lc?=
 =?us-ascii?Q?gBMpyja9z6+8iEFH4S4WHRppmyYwI2Z4MGV4tUN8tVgAdPEH9WC9fRTTC/9z?=
 =?us-ascii?Q?/m/cy+zqZhBTqyVmspBw8RsqwCcuyOafUyGeE88TqSTIJyETYeury2TIE+OH?=
 =?us-ascii?Q?w+aFCINMjA5cp2bASOvrnRo4xyvgELzMHmQpPM0yKmESwL7Lw4n/wm/JTlJG?=
 =?us-ascii?Q?rGWPKGO9H/7LQRz4xUX7kZZ4nt5yhuvvdFn47tQXItQla5cnnB2wrBCJEX0g?=
 =?us-ascii?Q?6mIjAjZtU3V9JqtmC/7DiTjOE6bpmsq+oIZ15XmoBv9bsX1TZouyd89qhiFh?=
 =?us-ascii?Q?nJrXoQ2sWEXo/P1r2czUzCzKHI5AYKQ2Pa6XEWrKsBiJDuOJFMV3KEZZoj/5?=
 =?us-ascii?Q?arThaSb0egVAoYvQ6Rb5YpAeCYwkWhSOxxWa+Q2cwyvh2YWMtUOHe9tYs6K1?=
 =?us-ascii?Q?R2MD8wNmmjN0vxS39NfQ+ZP9gbhH9tnYC6M6y/TYz6JCZQ51JmcTy0LoOWpk?=
 =?us-ascii?Q?0ITjZM9yEMXhDy2gcwM8aORkQoUS44G+BCVtLx5YHPDSB71Eg9uUNaf1aBXe?=
 =?us-ascii?Q?OZASchhO58uLILHTVZe9SdlhD4ahH8jjD3ppJlY9pL/YpjQjnOQzjtPOQ03u?=
 =?us-ascii?Q?kbIblhi+L3CLbu+DwdblHk67Byc7oq8qdS+2DKmt/hqiKX+/k1GSJaLVruVK?=
 =?us-ascii?Q?Q2tcvtImCtP+2KjpFftiP6NVpR3yfAuNdr5AqzvJyl0KAkq5ktgIeuAwUPuz?=
 =?us-ascii?Q?cK+4J7QNdMi+sR2di2ih/A3SpC9BtE+rgtbe7yVVKxBNnkeyiI4TBn8LjlV4?=
 =?us-ascii?Q?+iMqNL8e3ze6PSYWF+fwxRdFiYqSUdj+qdn51zshAsCtqOLg1jfTkjJeVhj8?=
 =?us-ascii?Q?XPgRWBPaDYCv+WXDgDJi9xSHktFujQhx4HpOJYEDXx7F595LqKxi2ceV9zz4?=
 =?us-ascii?Q?rOASwrknX6syqfnmqnusCemwKhGOu/4TenJ8l2nxr/a0wG0Fvv+3gkwF2Qcb?=
 =?us-ascii?Q?SpM1yEAAH71Ti+IbLVEHnzwBk4GPEpns6/h+v68MIp29DDWBSkDFNZlT2v/K?=
 =?us-ascii?Q?aI1jPYqPnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ec8808-837c-48cb-17dd-08deb7017bb8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:23:33.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObJKk3KvAvxxNAS2YAPS3ZjLaiJHDy2fYAupHgOw64XZdBQQ5RtlT+eVB4zbL49BPN86MwEfR5pQmLPkXrhaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16145-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0DDE759F603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Feb 22, 2026 at 03:48:15AM -0500, Gregory Price wrote:
> Topic type: MM
> 
> Presenter: Gregory Price <gourry@gourry.net>
> 
> This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> managed by the buddy allocator but excluded from normal allocations.
> 
> I present it with an end-to-end Compressed RAM service (mm/cram.c)
> that would otherwise not be possible (or would be considerably more
> difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
> 

Do we have updates/notes from the meeting?

> 
> TL;DR
> ===
> 
> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> explicit holes in that isolation to do useful things we couldn't do
> before without re-implementing entire portions of mm/ in a driver.
> 
> 
> /* This is my memory. There are many like it, but this one is mine. */
> rc = add_private_memory_driver_managed(nid, start, size, name, flags,
>                                        online_type, private_context);
> 
> page = alloc_pages_node(nid, __GFP_PRIVATE, 0);

Do we want to provide kernel level control over allocation of private
pages, I assumed that only user space applications? I would assume
node affinity would be the way to do so, unless we have multiple

> 
> /* Ok but I want to do something useful with it */
> static const struct node_private_ops ops = {
>         .migrate_to     = my_migrate_to,
>         .folio_migrate  = my_folio_migrate,
>         .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> };
> node_private_set_ops(nid, &ops);
>

Could you explain this further? Why does OPS_MIGRATION
and OPS_MEMPOLICY needs to be set explictly?

> /* And now I can use mempolicy with my memory */
> buf = mmap(...);
> mbind(buf, len, mode, private_node, ...);
> buf[0] = 0xdeadbeef;  /* Faults onto private node */
> 
> /* And to be clear, no one else gets my memory */
> buf2 = malloc(4096);  /* Standard allocation */
> buf2[0] = 0xdeadbeef; /* Can never land on private node */
> 
> /* But i can choose to migrate it to the private node */
> move_pages(0, 1, &buf, &private_node, NULL, ...);
> 
> /* And more fun things like this */
> 
> 
> Patchwork
> ===
> A fully working branch based on cxl/next can be found here:
> https://github.com/gourryinverse/linux/tree/private_compression
> 
> A QEMU device which can inject high/low interrupts can be found here:
> https://github.com/gourryinverse/qemu/tree/compressed_cxl_clean
> 
> The additional patches on these branches are CXL and DAX driver
> housecleaning only tangentially relevant to this RFC, so i've
> omitted them for the sake of trying to keep it somewhat clean
> here.  Those patches should (hopefully) be going upstream anyway.
> 
> Patches 1-22: Core Private Node Infrastructure
> 
>   Patch  1:      Introduce N_MEMORY_PRIVATE scaffolding
>   Patch  2:      Introduce __GFP_PRIVATE
>   Patch  3:      Apply allocation isolation mechanisms
>   Patch  4:      Add N_MEMORY nodes to private fallback lists
>   Patches 5-9:   Filter operations not yet supported
>   Patch 10:      free_folio callback
>   Patch 11:      split_folio callback
>   Patches 12-20: mm/ service opt-ins:
>                    Migration, Mempolicy, Demotion, Write Protect,
>                    Reclaim, OOM, NUMA Balancing, Compaction,
>                    LongTerm Pinning
>   Patch 21:      memory_failure callback
>   Patch 22:      Memory hotplug plumbing for private nodes
> 
> Patch 23: mm/cram -- Compressed RAM Management
> 
> Patches 24-27: CXL Driver examples
>   Sysram Regions with Private node support
>   Basic Driver Example: (MIGRATION | MEMPOLICY)
>   Compression Driver Example (Generic)
> 
> 
> Background
> ===
> 
> Today, drivers that want mm-like services on non-general-purpose
> memory either use ZONE_DEVICE (self-managed memory) or hotplug into
> N_MEMORY and accept the risk of uncontrolled allocation.
> 
> Neither option provides what we really want - the ability to:
> 	1) selectively participate in mm/ subsystems, while
> 	2) isolating that memory from general purpose use.
> 
> Some device-attached memory cannot be managed as fully general-purpose
> system RAM.  CXL devices with inline compression, for example, may
> corrupt data or crash the machine if the compression ratio drops
> below a threshold -- we simply run out of physical memory.
> 
> This is a hard problem to solve: how does an operating system deal
> with a device that basically lies about how much capacity it has?
> 
> (We'll discuss that in the CRAM section)
> 
> 
> Core Proposal: N_MEMORY_PRIVATE
> ===
> 
> Introduce N_MEMORY_PRIVATE, a NUMA node state for memory managed by
> the buddy allocator, but excluded from normal allocation paths.
> 
> Private nodes:
> 
>   - Are filtered from zonelist fallback: all existing callers to
>     get_page_from_freelist cannot reach these nodes through any
>     normal fallback mechanism.
> 
>   - Filter allocation requests on __GFP_PRIVATE
>     	numa_zone_allowed() excludes them otherwise. 
> 
>     Applies to systems with and without cpusets.
> 
>     GFP_PRIVATE is (__GFP_PRIVATE | __GFP_THISNODE).
> 
>     Services use it when they need to allocate specifically from
>     a private node (e.g., CRAM allocating a destination folio).
> 
>     No existing allocator path sets __GFP_PRIVATE, so private nodes
>     are unreachable by default.
> 
>   - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
>     no struct page metadata limitations.
> 
>   - Use a node-scoped metadata structure to accomplish filtering
>     and callback support.
> 
>   - May participate in the buddy allocator, reclaim, compaction,
>     and LRU like normal memory, gated by an opt-in set of flags.
> 
> The key abstraction is node_private_ops: a per-node callback table
> registered by a driver or service.  
> 
> Each callback is individually gated by an NP_OPS_* capability flag.
> 
> A driver opts in only to the mm/ operations it needs.
> 
> It is similar to ZONE_DEVICE's pgmap at a node granularity.
> 
> In fact...
> 
> 
> Re-use of ZONE_DEVICE Hooks
> ===
> 
> The callback insertion points deliberately mirror existing ZONE_DEVICE
> hooks to minimize the surface area of the mechanism.
> 
> I believe this could subsume most DEVICE_COHERENT users, and greatly
> simplify the device-managed memory development process (no more
> per-driver allocator and migration code).
> 
> (Also it's just "So Fresh, So Clean").
> 
> The base set of callbacks introduced include:
> 
>   free_folio           - mirrors ZONE_DEVICE's
>                          free_zone_device_page() hook in
>                          __folio_put() / folios_put_refs()
> 
>   folio_split          - mirrors ZONE_DEVICE's
>   			 called when a huge page is split up
> 
>   migrate_to           - demote_folio_list() custom demotion (same
>                          site as ZONE_DEVICE demotion rejection)
> 
>   folio_migrate        - called when private node folio is moved to
>                          another location (e.g. compaction)
> 
>   handle_fault         - mirrors the ZONE_DEVICE fault dispatch in
>                          handle_pte_fault() (do_wp_page path)
> 
>   reclaim_policy       - called by reclaim to let a driver own the
>                          boost lifecycle (driver can driver node reclaim)
> 
>   memory_failure       - parallels memory_failure_dev_pagemap(),
>                          but for online pages that enter the normal
>                          hwpoison path
> 
> At skip sites (mlock, madvise, KSM, user migration), a unified
> folio_is_private_managed() predicate covers both ZONE_DEVICE and
> N_MEMORY_PRIVATE folios, consolidating existing zone_device checks
> with private node checks rather than adding new ones.
> 
>   static inline bool folio_is_private_managed(struct folio *folio)
>   {
>           return folio_is_zone_device(folio) ||
>                  folio_is_private_node(folio);
>   }
> 
> Most integration points become a one-line swap:
> 
>   -     if (folio_is_zone_device(folio))
>   +     if (unlikely(folio_is_private_managed(folio)))
> 
> 
> Where a one-line integration is insufficient, the integration is
> kept as clean as possible with zone_device, rather than simply
> adding more call-sites on top of it:
> 
> static inline bool folio_managed_handle_fault(struct folio *folio,
>   struct vm_fault *vmf, vm_fault_t *ret)
> {
>   /* Zone device pages use swap entries; handled in do_swap_page */
>   if (folio_is_zone_device(folio))
>     return false;
> 
>   if (folio_is_private_node(folio)) {
>     const struct node_private_ops *ops = folio_node_private_ops(folio);
> 
>     if (ops && ops->handle_fault) {
>       *ret = ops->handle_fault(vmf);
>       return true;
>     }
>   }
>   return false;
> }
> 
> 
> 
> Flag-gated behavior (NP_OPS_*) controls:
> ===
> 
> We use OPS flags to denote what mm/ services we want to allow on our
> private node.   I've plumbed these through so far:
> 
>   NP_OPS_MIGRATION       - Node supports migration
>   NP_OPS_MEMPOLICY       - Node supports mempolicy actions
>   NP_OPS_DEMOTION        - Node appears in demotion target lists
>   NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
>   NP_OPS_RECLAIM         - Node supports reclaim
>   NP_OPS_NUMA_BALANCING  - Node supports numa balancing
>   NP_OPS_COMPACTION      - Node supports compaction
>   NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
>   NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
>                            as normal system ram storage, so it should
> 			   be considered in OOM pressure calculations.
> 
> I wasn't quite sure how to classify ksm, khugepaged, madvise, and
> mlock - so i have omitted those for now.
> 
> Most hooks are straightforward.
> 
> Including a node as a demotion-eligible target was as simple as:
> 
> static void establish_demotion_targets(void)
> {
>   ..... snip .....
>   /*
>    * Include private nodes that have opted in to demotion
>    * via NP_OPS_DEMOTION.  A node might have custom migrate
>    */
>   all_memory = node_states[N_MEMORY];
>   for_each_node_state(node, N_MEMORY_PRIVATE) {
>       if (node_private_has_flag(node, NP_OPS_DEMOTION))
>       node_set(node, all_memory);
>   }
>   ..... snip .....
> }
> 
> The Migration and Mempolicy support are the two most complex pieces,
> and most useful things are built on top of Migration (meaning the
> remaining implementations are usually simple).
> 
> 
> Private Node Hotplug Lifecycle
> ===
> 
> Registration follows a strict order enforced by
> add_private_memory_driver_managed():
> 
>   1. Driver calls add_private_memory_driver_managed(nid, start,
>      size, resource_name, mhp_flags, online_type, &np).
> 
>   2. node_private_register(nid, &np) stores the driver's
>      node_private in pgdat and sets pgdat->private.  N_MEMORY and
>      N_MEMORY_PRIVATE are mutually exclusive -- registration fails
>      with -EBUSY if the node already has N_MEMORY set.
> 
>      Only one driver may register per private node.
> 
>   3. Memory is hotplugged via __add_memory_driver_managed().
> 
>      When online_pages() runs, it checks pgdat->private and sets
>      N_MEMORY_PRIVATE instead of N_MEMORY.  
> 
>      Zonelist construction gives private nodes a self-only NOFALLBACK
>      list and an N_MEMORY fallback list (so kernel/slab allocations on
>      behalf of private node work can fall back to DRAM).
> 
>   4. kswapd and kcompactd are NOT started for private nodes.  The
>      owning service is responsible for driving reclaim if needed
>      (e.g., CRAM uses watermark_boost to wake kswapd on demand).
> 
> Teardown is the reverse:
> 
>   1. Driver calls offline_and_remove_private_memory(nid, start,
>      size).
> 
>   2. offline_pages() offlines the memory.  When the last block is
>      offlined, N_MEMORY_PRIVATE is cleared automatically.
> 
>   3. node_private_unregister() clears pgdat->node_private and
>      drops the refcount.  It refuses to unregister (-EBUSY) if
>      N_MEMORY_PRIVATE is still set (other memory ranges remain).
> 
> The driver is responsible for ensuring memory is hot-unpluggable
> before teardown.  The service must ensure all memory is cleaned
> up before hot-unplug - or the service must support migration (so
> memory_hotplug.c can evacuate the memory itself).
> 
> In the CRAM example, the service supports migration, so memory
> hot-unplug can remove memory without any special infrastructure.
> 
> 
> Application: Compressed RAM (mm/cram)
> ===
> 
> Compressed RAM has a serious design issue:  Its capacity a lie.
> 
> A compression device reports more capacity than it physically has.
> If workloads write faster than the OS can reclaim from the device,
> we run out of real backing store and corrupt data or crash.
> 
> I call this problem: "Trying to Out Run A Bear"
> 
> I.e. This is only stable as long as we stay ahead of the pressure.
> 
> We don't want to design a system where stability depends on outrunning
> a bear - I am slow and do not know where to acquire bear spray.
> 
>   Fun fact:   Grizzly bears have a top-speed of 56-64 km/h.
>   Unfun Fact: Humans typically top out at ~24 km/h.
> 
> This MVP takes a conservative position:
> 
>    all compressed memory is mapped read-only.
> 
>   - Folios reach the private node only via reclaim (demotion)
>   - migrate_to implements custom demotion with backpressure.
>   - fixup_migration_pte write-protects PTEs on arrival.
>   - wrprotect hooks prevent silent upgrades
>   - handle_fault promotes folios back to DRAM on write.
>   - free_folio scrubs stale data before buddy free.
> 
> Because pages are read-only, writes can never cause runaway
> compression ratio loss behind the allocator's back.  Every write
> goes through handle_fault, which promotes the folio to DRAM first.
> 
> The device only ever sees net compression (demotion in) and explicit
> decompression (promotion out via fault or reclaim), and has a much
> wider timeframe to respond to poor compression scenarios.
> 
> That means there's no bear to out run. The bears are safely asleep in
> their bear den, and even if they show up we have a bear-proof cage.
> 
> The backpressure system is our bear-proof cage: the driver reports real
> device utilization (generalized via watermark_boost on the private
> node's zone), and CRAM throttles demotion when capacity is tight.
> 
> If compression ratios are bad, we stop demoting pages and start
> evicting pages aggressively.
> 
> The service as designed is ~350 functional lines of code because it
> re-uses mm/ services:
> 
>   - Existing reclaim/vmscan code handles demotion.
>   - Existing migration code handles migration to/from.
>   - Existing page fault handling dispatches faults.
> 
> The driver contains all the CXL nastiness core developers don't want
> anything to do with - No vendor logic touches mm/ internals.
> 
> 
> 
> Future CRAM : Loosening the read-only constraint
> ===
> 
> The read-only model is safe but conservative.  For workloads where
> compressed pages are occasionally written, the promotion fault adds
> latency.  A future optimization could allow a tunable fraction of
> compressed pages to be mapped writable, accepting some risk of
> write-driven decompression in exchange for lower overhead.
> 
> The private node ops make this straightforward:
> 
>   - Adjust fixup_migration_pte to selectively skip
>     write-protection.
>   - Use the backpressure system to either revoke writable mappings,
>     deny additional demotions, or evict when device pressure rises.
> 
> This comes at a mild memory overhead: 32MB of DRAM per 1TB of CRAM.
> (1 bit per 4KB page).
> 
> This is not proposed here, but it should be somewhat trivial.
> 
> 
> Discussion Topics
> ===
> 0. Obviously I've included the set as an RFC, please rip it apart.
> 
> 1. Is N_MEMORY_PRIVATE the right isolation abstraction, or should
>    this extend ZONE_DEVICE?  Prior feedback pushed away from new
>    ZONE logic, but this will likely be debated further.
> 
>    My comments on this:
> 
>    ZONE_DEVICE requires re-implementing every service you want to
>    provide to your device memory, including basic allocation.
> 
>    Private nodes use real struct pages with no metadata
>    limitations, participate in the buddy allocator, and get NUMA
>    topology for free.
> 
> 2. Can this subsume ZONE_DEVICE COHERENT users?  The architecture
>    was designed with this in mind, but it is only a thought experiment.
> 
> 3. Is a dedicated mm/ service (cram) the right place for compressed
>    memory management, or should this be purely driver-side until
>    more devices exist?
> 
>    I wrote it this way because I forsee more "innovation" in the
>    compressed RAM space given current... uh... "Market Conditions".
> 
>    I don't see CRAM being CXL-specific, though the only solutions I've
>    seen have been CXL.  Nothing is stopping someone from soldering such
>    memory directly to a PCB.
> 
> 5. Where is your hardware-backed data that shows this works?
> 
>    I should have some by conference time.
> 
> Thanks for reading
> Gregory (Gourry)
> 
> 
> Gregory Price (27):
>   numa: introduce N_MEMORY_PRIVATE node state
>   mm,cpuset: gate allocations from N_MEMORY_PRIVATE behind __GFP_PRIVATE
>   mm/page_alloc: add numa_zone_allowed() and wire it up
>   mm/page_alloc: Add private node handling to build_zonelists
>   mm: introduce folio_is_private_managed() unified predicate
>   mm/mlock: skip mlock for managed-memory folios
>   mm/madvise: skip madvise for managed-memory folios
>   mm/ksm: skip KSM for managed-memory folios
>   mm/khugepaged: skip private node folios when trying to collapse.
>   mm/swap: add free_folio callback for folio release cleanup
>   mm/huge_memory.c: add private node folio split notification callback
>   mm/migrate: NP_OPS_MIGRATION - support private node user migration
>   mm/mempolicy: NP_OPS_MEMPOLICY - support private node mempolicy
>   mm/memory-tiers: NP_OPS_DEMOTION - support private node demotion
>   mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades
>   mm: NP_OPS_RECLAIM - private node reclaim participation
>   mm/oom: NP_OPS_OOM_ELIGIBLE - private node OOM participation
>   mm/memory: NP_OPS_NUMA_BALANCING - private node NUMA balancing
>   mm/compaction: NP_OPS_COMPACTION - private node compaction support
>   mm/gup: NP_OPS_LONGTERM_PIN - private node longterm pin support
>   mm/memory-failure: add memory_failure callback to node_private_ops
>   mm/memory_hotplug: add add_private_memory_driver_managed()
>   mm/cram: add compressed ram memory management subsystem
>   cxl/core: Add cxl_sysram region type
>   cxl/core: Add private node support to cxl_sysram
>   cxl: add cxl_mempolicy sample PCI driver
>   cxl: add cxl_compression PCI driver
> 
>  drivers/base/node.c                           |  250 +++-
>  drivers/cxl/Kconfig                           |    2 +
>  drivers/cxl/Makefile                          |    2 +
>  drivers/cxl/core/Makefile                     |    1 +
>  drivers/cxl/core/core.h                       |    4 +
>  drivers/cxl/core/port.c                       |    2 +
>  drivers/cxl/core/region_sysram.c              |  381 ++++++
>  drivers/cxl/cxl.h                             |   53 +
>  drivers/cxl/type3_drivers/Kconfig             |    3 +
>  drivers/cxl/type3_drivers/Makefile            |    3 +
>  .../cxl/type3_drivers/cxl_compression/Kconfig |   20 +
>  .../type3_drivers/cxl_compression/Makefile    |    4 +
>  .../cxl_compression/compression.c             | 1025 +++++++++++++++++
>  .../cxl/type3_drivers/cxl_mempolicy/Kconfig   |   16 +
>  .../cxl/type3_drivers/cxl_mempolicy/Makefile  |    4 +
>  .../type3_drivers/cxl_mempolicy/mempolicy.c   |  297 +++++
>  include/linux/cpuset.h                        |    9 -
>  include/linux/cram.h                          |   66 ++
>  include/linux/gfp_types.h                     |   15 +-
>  include/linux/memory-tiers.h                  |    9 +
>  include/linux/memory_hotplug.h                |   11 +
>  include/linux/migrate.h                       |   17 +-
>  include/linux/mm.h                            |   22 +
>  include/linux/mmzone.h                        |   16 +
>  include/linux/node_private.h                  |  532 +++++++++
>  include/linux/nodemask.h                      |    1 +
>  include/trace/events/mmflags.h                |    4 +-
>  include/uapi/linux/mempolicy.h                |    1 +
>  kernel/cgroup/cpuset.c                        |   49 +-
>  mm/Kconfig                                    |   10 +
>  mm/Makefile                                   |    1 +
>  mm/compaction.c                               |   32 +-
>  mm/cram.c                                     |  508 ++++++++
>  mm/damon/paddr.c                              |    3 +
>  mm/huge_memory.c                              |   23 +-
>  mm/hugetlb.c                                  |    2 +-
>  mm/internal.h                                 |  226 +++-
>  mm/khugepaged.c                               |    7 +-
>  mm/ksm.c                                      |    9 +-
>  mm/madvise.c                                  |    5 +-
>  mm/memory-failure.c                           |   15 +
>  mm/memory-tiers.c                             |   46 +-
>  mm/memory.c                                   |   26 +
>  mm/memory_hotplug.c                           |  122 +-
>  mm/mempolicy.c                                |   69 +-
>  mm/migrate.c                                  |   63 +-
>  mm/mlock.c                                    |    5 +-
>  mm/mprotect.c                                 |    4 +-
>  mm/oom_kill.c                                 |   52 +-
>  mm/page_alloc.c                               |   79 +-
>  mm/rmap.c                                     |    4 +-
>  mm/slub.c                                     |    3 +-
>  mm/swap.c                                     |   21 +-
>  mm/vmscan.c                                   |   55 +-
>  54 files changed, 4057 insertions(+), 152 deletions(-)
>  create mode 100644 drivers/cxl/core/region_sysram.c
>  create mode 100644 drivers/cxl/type3_drivers/Kconfig
>  create mode 100644 drivers/cxl/type3_drivers/Makefile
>  create mode 100644 drivers/cxl/type3_drivers/cxl_compression/Kconfig
>  create mode 100644 drivers/cxl/type3_drivers/cxl_compression/Makefile
>  create mode 100644 drivers/cxl/type3_drivers/cxl_compression/compression.c
>  create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
>  create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
>  create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c
>  create mode 100644 include/linux/cram.h
>  create mode 100644 include/linux/node_private.h
>  create mode 100644 mm/cram.c
> 
> -- 
> 2.53.0
> 
> 

Balbir

