Return-Path: <cgroups+bounces-17654-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dCn2J4s5UWoLBAMAu9opvQ
	(envelope-from <cgroups+bounces-17654-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 20:27:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223373D5C4
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 20:27:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=q6U3jtVG;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17654-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17654-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5A130166F6
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D037AA70;
	Fri, 10 Jul 2026 18:24:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF63379C21;
	Fri, 10 Jul 2026 18:24:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707897; cv=fail; b=MGnL1lgnflKauPHsTniLb2p51Wah6J/ZmtnEZvZ7iX1CwD8WclxXS52zfH/OTluRFNbl53gqiAZ/i/wK3/Qbvz8NrEcmI/1CB4rWSKNe0oYvD8PXtbuU3Cq0cGjGSA05HIvokXD8O0kpWDmZ0ivpY02gliQX1cnBIvCuGzKjzyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707897; c=relaxed/simple;
	bh=A2QFpzaN6BCA5IblaWFD/FdKb/9Sp7iHtAQ/DbGUFDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PksqqRoZSmTWuYNUJTYGxEBRkn3iIY0iElcHw/JE2KV4+lCuQOPQJSNiIy1s/Q6MAhL4mmp6B3Xk/eABylqUU+qR8AxD6Wdy8+HbKh/VFG0WnQu0SddqUIlrPD8suMfFVaylX+Ia8mZ717Q+C7UVWzQ8D5kGNwQZv/WGhY+uThk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6U3jtVG; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRzLhg61+Zaz15UJWj47ql7z2xdvzr0rbptJX+lmZjawU44gFnmAixR4nNYDZZkkr2fom77RZUdo8Kh1domCkHyZEnGe/ZrZD4jpWqWAD1uNzcNYcBQoRYbDFfkvJZLSp0jXvGOloKXu77vTGRXkhto1CHiRm8n6+49wS5SK639czPsDX4kaK5QjnmZAuh8xa//8iD4HDxPJQqj6t58HmOreR/wp3zJ//6fH4E6meUM5zNUswfZpbBFxLBsZQnRsgmH6XPy8A4pPYythPnFpV+iFPvzg7hwoPpxGr+Id/vTL81Lno3VB1LqHtb6A3JntntcQRVRCFbD2C4Qu2kileg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xIcvpWct9zxlY7/ROfyY3jU/sOM+uBayo/403Sjs9g=;
 b=PikUzj3333FBnpwQ5KL1KAMaFsMFOqJOdiwMNmZ5WtQ9lgE1ZKSvOf3/ioeRvQJeUbNU7jtWbpyQPOMbDSG5B0zudS7lG8yvuvjqiG/rjiCnKYMYdDd8z0TqFvnKq8+iybPBxdzdU6I4IHXDdsjIj+FhsKk/+zBgVQr73IR3rA7wI1TZNE7WRk92Xy0QFt2yn+4jU1FwgKz4G9iTGY2ecUp8aUZF7qC2wmOApRLd928uLOZFJvbFz/xuABzrouugQNlyhpQ1nCEy3ArHG7FQWETNF39uIFiZhCuCCmbO2Gfh6jhUdog53EQZz3rBnC41Vwg3HTqKUrBGFP0XkLUq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xIcvpWct9zxlY7/ROfyY3jU/sOM+uBayo/403Sjs9g=;
 b=q6U3jtVGieTFMwDupJOTdVnQehzwr0BdEHPI4o7W1kXZPAacLD1Oee3yWzuE/TBgE7RoR9cAig3+WyvkNB+J67/Z4Xq5ZCRwa5A7fK5uwsJkCkETkPX5qVUy6+U1l5umZ48hOtEzuRuG6F0LBK1PSGqhcq887l3R2xctV5HI6SiGnFycPpQBXGfTMJ8/lHbow7LZ+gIZY+IOSbPNwkOqqpr5Wk+u4p1c6CrxLzzhdff1JrLTcL7S7a/HhH9ubDEeq9fWLwcbarQuz+t+WQ5IIQR0Xt82/aQ7SV9Misnf/clv34fGiqWkLYFiblNd1GooGFiZVDWy6UAihbX2I7agog==
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Fri, 10 Jul
 2026 18:24:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 18:24:45 +0000
Date: Fri, 10 Jul 2026 20:24:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>, sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Message-ID: <alE46Lxq-gFyJcxZ@gpd4>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <alEv8QosliGUfUNZ@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEv8QosliGUfUNZ@gpd4>
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9f0696-93fe-4bf2-8a76-08dedeb08448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	cm/kzsY86oMJNBOB3/M6KpncbZ4NgbufVm4kPJBT5c5wBsICaUK+B+US4Zx48j3zko2uDwvcvECQbcOG1ileFCL4usf7mhIdqTP8vgtQHY6YhJ2merZdD05ez0G0FQ3JeBWgLTAVBNlnJ3wBtKYaFg3EwM3y4/2S/2BTZoZ6naQZC29eK8KuH+dh7ni73z1hwYDCP3xE2CqZedLj7BinAmL5eVstrkL22Fo371Wko40nxu0nUXGTXxKjY3LetKNJ5cxLMcpTM4TeXGzp8tgr+zdtb07byc7M7eCoYq8sk4Gkqb2DdSVZN0eQXr56q5AC/Z25cAYUlpENqpeXGbreo11SsD84gcs3p+PgKicuhcyVJ2OE7APrjj0Xo2sym5dxzo+2eZ3zSZqdljcvw2F3vivLhtSxdKCgonN995FIcBM+ol8mXgrF8fsVVF+vsqfadqRTiVliUAm4XdvgHfV+MmKhgdbFmCIaerCuwrG1ioX3GGw7DR5Angk7VshhidxZm0kbL5FXs5lkH3V5gDaXVTEvzPfb7yWJtKY0++zePO5JIgYAQoOi2fJRvvO1NxEGu6XoX+6Lwl0aUEGIgTqG+nzu7XdSs4rlelZ3tw+gAgRmMj6QCEL4t2NoABO2NbDq3DvC4okP2W5CSM14VgRKShImIfTgpEqxJeL2sK/xnFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkrYi4PFYQoREmkv8mXBFs4ihdyU3GS/fokoehb5O/Bv+w7NpmJWnjSwK119?=
 =?us-ascii?Q?ZVDA3vWaHeGFW0/Sgn+8H7Oq583MR6GqalFqsRcye7VyD4RSOF1v4kZqRMq0?=
 =?us-ascii?Q?csKBwdPKeUIGrAzZi7Qo/kAdDNxkq1kq4xw4jtGbTZ+4sdmtga/8xiaC72F8?=
 =?us-ascii?Q?mSbpZFjT0oVjFfKiAPPD5lq9bbQH+uDEEP3I9BJ/5yuSr/GtGLDG3hqGspSY?=
 =?us-ascii?Q?izAUSNpOPRsNUbnwRRQWIncMJZ8fp2lH0Jp/N2wiWTZlhgxXq4hfxcYQXwl+?=
 =?us-ascii?Q?nqEQioVxS9IKlpxH7P4tVpc+EhAGtGHMRqZp6znmN/UQg+yXimqPW46mcVV9?=
 =?us-ascii?Q?d0MjGPO0C0LHfl7k73bY+VeCP+B31BdiSXWfqi8n0fKiSBEcL7B/x33vf3ZR?=
 =?us-ascii?Q?vagjG/AQJuIEMMkclLdurFGg6un0aCwZN8vV6/57iVqd/S3gJ1MMcCU0ZTc1?=
 =?us-ascii?Q?H0jxEGe5MEwaVgPLHU+GN7IRe5xeTACUCG2lLb6D47DOxHNeyGCzPEB2jvWZ?=
 =?us-ascii?Q?QBok7rS55iImGp92KS1bWSu9Ae9RCi9qY90rF9isUg1NU3QgyJ8wVvRiGw2E?=
 =?us-ascii?Q?cPRkgTEM7acQm3R+YOf06w6UunVgRvZYvFcxRxn0QXe4knt2hFFX3aByKhyX?=
 =?us-ascii?Q?ZsS6fKnggS8BsN9NHQOOAKZA1rQJPO8f6tCNZdh9F/3rGc8SZcOyaY8rIzIY?=
 =?us-ascii?Q?v6hzHdefvc6wXC5NRd15Ni0eqFWqgAjkwfjs24L6HOA3eePpLZ9kvqUmI7sI?=
 =?us-ascii?Q?UMBZ2GBkUmmSzJpg0h1OO46uobwFvGW86qfllSG29iIfXyF2rNhKaA8qQbJT?=
 =?us-ascii?Q?JV/ZlNGe9WV4Yj5hKOTI/eW3WfcZ5ozsYkn3k1vzhfgvGcuyzB8c4reNSwDp?=
 =?us-ascii?Q?SPFfENpOw41RjKeCjgHLFEEh4Wy+hxq02+She5wtOlidXvNmyyS/gfxtJC+0?=
 =?us-ascii?Q?ChsBkp4gnEBnlMIuiGvyAsTSxADz+UB/DNOoq8xxr49d42R9FAfga9xaDwNF?=
 =?us-ascii?Q?pyu6pcHjDo101XsicMRRZs6nu5lYDv6v3ZzYRFIKUSXpHgZuRqmBL+WjXzkI?=
 =?us-ascii?Q?fPbBYQ12zPgK3jZuJ/5pgZmO5PcSbBskSXEAewL8wAfEb8X9AnUyA/FoN96i?=
 =?us-ascii?Q?AX+/8MaZLVQ9Wkz4EiCYdyYhbOFcP+R0jc9CKSmjuaJV10R7u5U/2DxkY8P/?=
 =?us-ascii?Q?3CI1x3TbsY8Rny5h1EGHr1S/oFAUoDYWti7r1SdYT9V5SbwdKG13G9SVof5P?=
 =?us-ascii?Q?V6xjbJHuS4Uayk3qvMvomxS49yDWQrLVa/ZwUr9iHKC0/adTGP64NH7Eakap?=
 =?us-ascii?Q?W9pq6MMETB7ZZOIwQVrDjxVzgxp5/3a8HT0kEVnBK5HliyLN19n+lHvAATVy?=
 =?us-ascii?Q?ws+qKbhI8hUUk8t4HhKvGRfldpK6QD7yCYw5BBNuh6k2gb26Uu/IPQc+Jvbv?=
 =?us-ascii?Q?XCMadTZ/8YKOEi45H/IWlItB8SxQ4fTG+opDYSKoUQVWHt1vbVMHzYbrW7y5?=
 =?us-ascii?Q?HWq4b7hduGZ7gBC6TIbVd4unQESzWVin/P820wSOhCq9815TdhjdYHumKc5i?=
 =?us-ascii?Q?IiuMous49m63dDRyxID4GLi4LbI7/gjFrViT1ywEtMubeMLPlTSliEVrOQxf?=
 =?us-ascii?Q?Bh1PNmoyvXvpBR8w7MNMrzPBxETK+TpqxTCI0Nfh7hNk9VqqKp71Gyrh9bHK?=
 =?us-ascii?Q?EbYTCCh5Tz9nDk5IlNmeXwKWxUAkvxPTJciP/XeOpyXWxN/vrVIn9ydpXOXH?=
 =?us-ascii?Q?t+HzoAxIzw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9f0696-93fe-4bf2-8a76-08dedeb08448
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 18:24:45.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKv7aJh3Nxxf1ztbKMIbsj4EYacQsmnzq64qXvMRkqIyT36Dm/mGZ3EynvOSordvv2yIhbXzCXKGca/+PpB68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17654-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:tj@kernel.org,m:void@manifault.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:mfleming@cloudflare.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,manifault.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,lists.linux.dev,vger.kernel.org,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:email,nvidia.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4223373D5C4

On Fri, Jul 10, 2026 at 07:46:39PM +0200, Andrea Righi wrote:
> Hi Matt,
> 
> On Fri, Jul 10, 2026 at 11:04:41AM +0100, Matt Fleming wrote:
> > From: Matt Fleming <mfleming@cloudflare.com>
> > 
> > scx_root_enable_workfn() currently takes scx_fork_rwsem for writing
> > before acquiring cgroup_mutex. Since commit a5b98009f16d ("sched/psi:
> > fix race between file release and pressure write"), pressure_write()
> > holds cgroup_mutex across psi_trigger_create(), which may call
> > kthread_create() for the psimon kthread. kthreadd's fork then enters
> > scx_pre_fork() and waits for the read side of scx_fork_rwsem.
> > 
> > This results in a deadlock. The enable worker holds scx_fork_rwsem and
> > waits for cgroup_mutex, while the PSI writer holds cgroup_mutex and
> > waits for psimon creation to complete. Any concurrent fork blocks on
> > scx_pre_fork() behind the enable worker.
> > 
> > The hung-task detector captured all three sides of the deadlock:
> > 
> >   scx_enable_help:
> >     __mutex_lock
> >     scx_enable_workfn
> >     kthread_worker_fn
> > 
> >   systemd:
> >     wait_for_completion_killable
> >     __kthread_create_on_node
> >     kthread_create_on_node
> >     psi_trigger_create
> >     pressure_write
> >     kernfs_fop_write_iter
> > 
> >   python3:
> >     percpu_rwsem_wait
> >     __percpu_down_read
> >     scx_pre_fork
> >     sched_fork
> >     copy_process
> >     kernel_clone
> > 
> > It also identified systemd as the likely owner of the mutex on which
> > scx_enable_help was blocked.
> > 
> > We reproduced this on a 128-CPU AMD EPYC 7713 by enabling scx_lavd
> > concurrently with writes to cgroup PSI trigger files. Unrelated tasks
> > piled up in scx_pre_fork() and process creation on the box stopped.
> > 
> > Fix the inversion by acquiring cgroup_mutex before scx_fork_rwsem in
> > scx_root_enable_workfn() and releasing them in reverse order, while
> > preserving the existing exclusion around cgroup and task initialisation.
> > 
> > Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> 
> This seems to introduce the following (running the sched_ext kselftests):
> 
> [   28.963575] ======================================================
> [   28.963670] WARNING: possible circular locking dependency detected
> [   28.963752] 7.1.0-virtme #1 Not tainted
> [   28.963804] ------------------------------------------------------
> [   28.963887] sched_ext_helpe/2619 is trying to acquire lock:
> [   28.963954] ffffffff83685240 (scx_cgroup_ops_rwsem){+.+.}-{0:0}, at: scx_root_disable+0x45d/0x840
> [   28.964071]
> [   28.964071] but task is already holding lock:
> [   28.964151] ffffffff83682910 (scx_fork_rwsem){++++}-{0:0}, at: scx_root_disable+0x160/0x840
> [   28.964260]
> [   28.964260] which lock already depends on the new lock.

Looking more at this, I think we should fix the PSI path instead, sched_ext
locking order is consistently using:

  scx_fork_rwsem -> scx_cgroup_ops_rwsem -> cgroup_mutex

Maybe we can rework pressure_write() to pin the cgroup and file context, then
drop both cgroup_mutex and kernfs active protection before creating the PSI
kthread?

Thanks,
-Andrea

> [   28.964260]
> [   28.964355]
> [   28.964355] the existing dependency chain (in reverse order) is:
> [   28.964455]
> [   28.964455] -> #2 (scx_fork_rwsem){++++}-{0:0}:
> [   28.964539]        percpu_down_write+0x49/0x150
> [   28.964610]        scx_root_enable_workfn+0x5d0/0xd30
> [   28.964679]        kthread_worker_fn+0x121/0x360
> [   28.964749]        kthread+0x10c/0x140
> [   28.964802]        ret_from_fork+0x189/0x330
> [   28.964872]        ret_from_fork_asm+0x1a/0x30
> [   28.964941]
> [   28.964941] -> #1 (cgroup_mutex){+.+.}-{4:4}:
> [   28.965025]        __mutex_lock+0xbe/0xd80
> [   28.965070]        scx_root_enable_workfn+0x5c4/0xd30
> [   28.965138]        kthread_worker_fn+0x121/0x360
> [   28.965210]        kthread+0x10c/0x140
> [   28.965263]        ret_from_fork+0x189/0x330
> [   28.965331]        ret_from_fork_asm+0x1a/0x30
> [   28.965402]
> [   28.965402] -> #0 (scx_cgroup_ops_rwsem){+.+.}-{0:0}:
> [   28.965485]        __lock_acquire+0x14c5/0x2a40
> [   28.965554]        lock_acquire+0xd3/0x280
> [   28.965608]        percpu_down_write+0x49/0x150
> [   28.965677]        scx_root_disable+0x45d/0x840
> [   28.965745]        kthread_worker_fn+0x121/0x360
> [   28.965815]        kthread+0x10c/0x140
> [   28.965867]        ret_from_fork+0x189/0x330
> [   28.965935]        ret_from_fork_asm+0x1a/0x30
> [   28.966002]
> [   28.966002] other info that might help us debug this:
> [   28.966002]
> [   28.966097] Chain exists of:
> [   28.966097]   scx_cgroup_ops_rwsem --> cgroup_mutex --> scx_fork_rwsem
> [   28.966097]
> [   28.966233]  Possible unsafe locking scenario:
> [   28.966233]
> [   28.966314]        CPU0                    CPU1
> [   28.966379]        ----                    ----
> [   28.966444]   lock(scx_fork_rwsem);
> [   28.966496]                                lock(cgroup_mutex);
> [   28.966579]                                lock(scx_fork_rwsem);
> [   28.966661]   lock(scx_cgroup_ops_rwsem);
> [   28.966713]
> [   28.966713]  *** DEADLOCK ***
> [   28.966713]
> [   28.966794] 2 locks held by sched_ext_helpe/2619:
> [   28.966861]  #0: ffffffff83682818 (scx_enable_mutex){+.+.}-{4:4}, at: scx_root_disable+0xba/0x840
> [   28.966974]  #1: ffffffff83682910 (scx_fork_rwsem){++++}-{0:0}, at: scx_root_disable+0x160/0x840
> [   28.967090]
> [   28.967090] stack backtrace:
> [   28.967158] CPU: 8 UID: 0 PID: 2619 Comm: sched_ext_helpe Not tainted 7.1.0-virtme #1 PREEMPT(full)
> [   28.967164] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   28.967166] Call Trace:
> [   28.967169]  <TASK>
> [   28.967172]  dump_stack_lvl+0x6d/0xa0
> [   28.967175]  print_circular_bug+0x2e1/0x300
> [   28.967179]  check_noncircular+0x144/0x170
> [   28.967182]  __lock_acquire+0x14c5/0x2a40
> [   28.967202]  ? scx_root_disable+0x45d/0x840
> [   28.967204]  lock_acquire+0xd3/0x280
> [   28.967207]  ? scx_root_disable+0x45d/0x840
> [   28.967209]  percpu_down_write+0x49/0x150
> [   28.967212]  ? scx_root_disable+0x45d/0x840
> [   28.967213]  scx_root_disable+0x45d/0x840
> [   28.967219]  ? kthread_worker_fn+0x51/0x360
> [   28.967221]  kthread_worker_fn+0x121/0x360
> [   28.967223]  ? __pfx_scx_disable_workfn+0x10/0x10
> [   28.967224]  ? __pfx_kthread_worker_fn+0x10/0x10
> [   28.967227]  kthread+0x10c/0x140
> [   28.967228]  ? __pfx_kthread+0x10/0x10
> [   28.967229]  ret_from_fork+0x189/0x330
> [   28.967231]  ? __pfx_kthread+0x10/0x10
> [   28.967232]  ret_from_fork_asm+0x1a/0x30
> [   28.967235]  </TASK>
> 
> Thanks,
> -Andrea
> 
> > ---
> >  kernel/sched/ext/ext.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 691d53fe0f64..ba89eafe7964 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	/*
> >  	 * Lock out forks, cgroup on/offlining and moves before opening the
> >  	 * floodgate so that they don't wander into the operations prematurely.
> > +	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
> > +	 * operations may create kthreads while holding cgroup_mutex.
> >  	 */
> > +	scx_cgroup_lock();
> >  	percpu_down_write(&scx_fork_rwsem);
> >  
> >  	WARN_ON_ONCE(scx_init_task_enabled);
> > @@ -7216,7 +7219,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	 * while tasks are being initialized so that scx_cgroup_can_attach()
> >  	 * never sees uninitialized tasks.
> >  	 */
> > -	scx_cgroup_lock();
> >  	set_cgroup_sched(sch_cgroup(sch), sch);
> >  	ret = scx_cgroup_init(sch);
> >  	if (ret)
> > @@ -7283,8 +7285,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  		put_task_struct(p);
> >  	}
> >  	scx_task_iter_stop(&sti);
> > -	scx_cgroup_unlock();
> >  	percpu_up_write(&scx_fork_rwsem);
> > +	scx_cgroup_unlock();
> >  
> >  	/*
> >  	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
> > @@ -7369,8 +7371,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	return;
> >  
> >  err_disable_unlock_all:
> > -	scx_cgroup_unlock();
> >  	percpu_up_write(&scx_fork_rwsem);
> > +	scx_cgroup_unlock();
> >  	/* we'll soon enter disable path, keep bypass on */
> >  err_disable:
> >  	mutex_unlock(&scx_enable_mutex);
> > -- 
> > 2.43.0
> > 

