Return-Path: <cgroups+bounces-16996-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tY6UGhcCMWpjaQUAu9opvQ
	(envelope-from <cgroups+bounces-16996-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 09:58:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C062068CFFC
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 09:58:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=santannapisa.it header.s=selector1 header.b=T9JZ16pJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16996-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16996-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=santannapisa.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD083064E1B
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE940BCAA;
	Tue, 16 Jun 2026 07:52:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021081.outbound.protection.outlook.com [52.101.65.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44532B9B6;
	Tue, 16 Jun 2026 07:52:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596377; cv=fail; b=rBP13tF3NhMX33FAjVDqf7Q9Xa6wtiUATZKb9UKYjTG9nKe/PRDf88gma40TWA7kO5XXLcgw+021SVgFqwZymXxHdnM4G5DhGlxDcCFNnH4eXBWCcYzQ7a0knnJLNm3YnuRpLMzbynisNnBdbh2XhTz4/L8r7wQqKko2YeYE3Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596377; c=relaxed/simple;
	bh=xW4bo556uw2l/arDAOEjxeqAZd0Oqk8d9/vXLp0Dkys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZK6OKvkKKbrV1MbXqkAq3RaJDyJMQTns+rwD70SBj9pGjvDu3/gAO1f286hfsCTmL/NHk8V1kMCOrzq5EeV3k9TYzcket5t+i4IZHMuBwTQMPn6gDg8/XIl+4bHhW7v5EIgyhngNCz6Z0t8Pn9RloUVU76Vo5rmJuquoGsvAtVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=T9JZ16pJ; arc=fail smtp.client-ip=52.101.65.81
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8A/6fNMQFvxa9AzV4v9RX+s130PU3UMn3mxk2uinZICyTalMZWZbYyfMHptR0Gyoj/TYksnx2t4QaQiZ9GP/bznw/18L6FoMwi+wlGf0dmOOWcISa6QWPKj3D7cZA6G8Z0kNocOs5PGBUrq9OBn3bIHqyCnPmb+UQCqBoUwJ7PCxpSN6JkYLWnFMDJPNHiGnt469XTOAhixD4eSi8up4ZY8w54S+JhcQKVHQjxbGxXxPjfcV/0R2SXQVyC4mq5997+6NrDZrWxBBZcH0orVkh3/ZmqQpTzjIfmsviN9nSzfD/iwoJsGkt5aqWcHKJxKF1m0umtmIQDgFInXHO6eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6Tdi9H5jSFsaM6AMDLMmhPoSqmRQVEosh5ATjIo630=;
 b=ZOGiGmyyyYRFA2CHDp21+2A13m5TVHFX11u5rFieOJuoCqgoJg2ZNYUGyG8fFz6ZqyAUORtJDXX82bZ91Z1kvddCrn49/6KJNO6mRLHaUkRI0djuMWlwA1dBMgVPVG8iRqMO3UvkhwcxpwNHdkH7YoWYa9D8zf/tY8HgJalkRE6yK8R968b9ksntxhJLkUPkZaqq0JelxdmSRug1fWzkKGS+/BgiLSQV/AQPNinAr+aRj8LH77PseTUOKW7mTECEEZ/AlD+kuDOpDAry/B8nuvWBrznrwMEu04D7zML3D5dkt2cYobw6RK2oxUk3wORfbaS84EmBXkWeotJhZcjPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6Tdi9H5jSFsaM6AMDLMmhPoSqmRQVEosh5ATjIo630=;
 b=T9JZ16pJ8IjA76+Iv7j6fb1WRJs6fjEu9PV/okOBpWyBuToz9EX5xq1ayU4iaIgne75HFIPaKZqLZpd/QQDdlbTXgzKa/vAsZjfS6I9dqiEJc9JVDNuE1ZMbj5wJeY4hAN/YUeMy6QG8kj3Al2X6IyibNZMIEIs0d5gOEg6bmaA=
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by DB4PR03MB9409.eurprd03.prod.outlook.com (2603:10a6:10:3fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:52:49 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:52:49 +0000
Date: Tue, 16 Jun 2026 09:52:43 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Tejun Heo <tj@kernel.org>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Yuri Andriaccio
 <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Message-ID: <20260616095243.68e3ab19@nowhere>
In-Reply-To: <bcedd13fc22cb7ba590791a4c1387ecc@kernel.org>
References: <20260608121546.69910-1-yurand2000@gmail.com>
	<bcedd13fc22cb7ba590791a4c1387ecc@kernel.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::12) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|DB4PR03MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: f740255a-abf5-4958-b6a9-08decb7c42b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|786006|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2e8Ry5wLgBIBvlg9xxZJxhAcqqrlqwysSeMqBhg003Spcg4nn4J7CH4IJohgklyQO4WhKsEHHKc8bLDACHbshdpOZsUnYD4OJ58pQOWOAKJQ7s8igOEAReyUgt5TfaXAh56l64hQsAcUr9QHUgaUrQJzNWRxmMblfXuqYEf5O+SHMugRNnjhihpGXSzK+Ne3IEmhiA2u5exK63VQ/Ci9nqs2DIOUJUwDU2uhtivskFu2g8D0XeYKD2vhf1L3ESqu/lXCdeGCHUBZBBisQxcTf0utZ81cLWCVPKvUhdl9ttJM9Cc0rmnbSuOdEAL+a5yWOIEep86g9zGkFFwAa7UX4KWyPU+psPdLhDHlcIMmmMmVoIrBp0EE4v9bnymi84qQaL0UKay5L2OMpGhYgri/H3U87fLP+Rq7WSJduZUtAvP8aoaUtJgbQ5Fjx/HtYsnsjydfJLhXwaIj58Dot7TF8w+qNhwqMnzMsKHK09JkisYnYGw1bT+uPRpzmhJScPiFTSPORZUGM+rzrAIgA0Aq3nNXiaGYtIibk+Q4Hg55yKxDxutw6Ln2v0RnbUjT9NEBwnid3FKmQLyScCIrmWRuUA25yf/8OVMZdJ1cHG2bINRWNN1fx/ExvZqnqII2qt9v+f0wO7eQsYvLwt28EEEN7cZu2YHglw7jkPN/jiAvS4CGulmmaUL6jYQEFldhA+Hq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(786006)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J2Pl6dXbss0zVMSvjnVgBWNXVIlZSChttkPdewSAvz6KiN4iOGFrIMFMemO1?=
 =?us-ascii?Q?qvf46Gq4xbRmnNRVwfSYW09MVaR2e5PWACUSc4CKR93cTO0KEEXADJl1LbEB?=
 =?us-ascii?Q?uR2RXFN693KbVYXKY66pwGVpOFm1n4LFcO1KpUNDRGxzcqO9/hnZSOGW4sEE?=
 =?us-ascii?Q?wcjEO5ZGoYMw9tDoSzKnRZN47jQgg1USlAXmfB3UJCIks7/yFjN1EH8IGgKZ?=
 =?us-ascii?Q?IOfoffsnEuWu2sozeFhIzxhpZ31b550YK4+ojRmqaD975gP2KT/yQ4UYRA/3?=
 =?us-ascii?Q?DxiOa4cRUDoKRXORY61QuI2MGj/+DWZmERhzuRFXbq/CvCHgQKyo5L4NLeEr?=
 =?us-ascii?Q?Rf5gFDWhlPSvEMguEKdogjLAzzB6UODl8AyUU2rpxAUGvJXTjGxTr65oUy7J?=
 =?us-ascii?Q?lWEvzjHBEe9+97KQerJOKw/rl7xH4M8aq2knRoSIgm/Uk/me1u5myHUloqlE?=
 =?us-ascii?Q?u0vQ8AUUKnQROx/zNhmPD4oPOxdvJifPEXC+ZLj0NtZXj8oZgWXEmVRiH8el?=
 =?us-ascii?Q?39GKf9158ldpuZS1HwzmDmreCQpxjC2Fh3mG2ysJijeFXkROfhnoy5B9mEWD?=
 =?us-ascii?Q?8glxx5ouzKDgZc9D/q7jh8fhQ/c9hmeN6K4izZVDfwTz9Xh5JEvPG6//ETes?=
 =?us-ascii?Q?V7Wa1+B6PO+lSQWAq6Ru/4ti97ZH2dFgkcruA9l5eADmLrqEgXd9shO1ylHo?=
 =?us-ascii?Q?eCVowcZh57FqcOwTCNnSpfDXasbXVteIe5MpB5H2ZVO0VmkmwNfZwc5Tyxnq?=
 =?us-ascii?Q?CATtMuI4lCcBDA/RMhqTmiw6XITm3i5sOAn8cDC2rBtypa9NUP3ocyOfSKnd?=
 =?us-ascii?Q?+tYD4Wozw5rsfEMmigku5Vqi3e9h9dLUIE5WDBpxFqaEsOUF/EQ/liRkC+JE?=
 =?us-ascii?Q?RZTEz7/qg44bqpeGMUaCZ4x1BrvdciW/WAGjrspDDi8ou4vpBHj+W+O/lR43?=
 =?us-ascii?Q?C0ovLdg+SqGnKMk2B3/+nvvdCq5TMt7WlqzLKfJvJX0toi7TVXTtMnvGLsST?=
 =?us-ascii?Q?KztxRyTTK0pNVI0hCjUwLyvWxf3d0O6m5rGiUtn9GrkvrzmkiKutaiVgO1zg?=
 =?us-ascii?Q?0ixyA+dLGxH9m1DTOrwZ/mDueXB1PgdXavHWJDs2LM2t3nJymIbGqI+4sDh0?=
 =?us-ascii?Q?+yDll5mWR0OQXKwewdJTpqHpI2jmbbycWNf0mh26iCXhHggjY7BBuoOLpLSn?=
 =?us-ascii?Q?TNEqL9VMiApFNkA9j6DzT8hnz2CJu4PdnyVTo8P3MQ+U+fYCiVvBrlc6m6DF?=
 =?us-ascii?Q?SFWSCOOJtS8d8DevaW6ILhJFKRxhghbect7cD4WyeCVrQnjOAkRidXl4MVUo?=
 =?us-ascii?Q?eNlvzUpU037p5Wk90KXloKY1G0yJ2uJ+jaUliBXJrgxqL4dZDpDFOWKhp8dN?=
 =?us-ascii?Q?+eS9y3dC6QtBvVNu3enI5zfiZ9ziq/UCNcddfSHwBf8ungTSMhe0SWr1JoCN?=
 =?us-ascii?Q?mLngvw8IFzxrepojS4WFRRIvMtA8GfblR3cM3IYy7Z5sZpTaXa/WeUAqZhxh?=
 =?us-ascii?Q?DTzKulUjOWnhzlDzjg7KedgOMP/sEXCTHB+qdpVdZqHAwA6rAXE1IOUHJVLa?=
 =?us-ascii?Q?AJGpKrffHmOB2GWqeqEosejLVGtN1kRsII0oPkbuAxbtaDFZD4DzgFvB0hY9?=
 =?us-ascii?Q?KGRhtLrbMJEdJeLOe+oceLl+hMgBYwHFI7ChN4KTj2wIBsSiqLgXBIb4Andl?=
 =?us-ascii?Q?sXqkLk3d+iUlFT5SKvbDb5Qmey2JSESjxGWb7KShyjUgzDJv+VoZeQ09ly6k?=
 =?us-ascii?Q?parIi0yguoA8kilaD9iMRFSV04+WJIs=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: f740255a-abf5-4958-b6a9-08decb7c42b0
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:52:48.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZcemElV/kkXj20aUagJivtdXEgX1v/CywU8Wj4lirg99UnPfUJp2xVvkNQvw1MWEBdLPcnDQ+0FHEjLGaza17lJryeFSjdUOiD2QkokrWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9409
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16996-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,cmpxchg.org,suse.com,vger.kernel.org,santannapisa.it];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:dkim,santannapisa.it:from_mime,vger.kernel.org:from_smtp,nowhere:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C062068CFFC

Hi,

On Mon, 15 Jun 2026 10:38:54 -1000
Tejun Heo <tj@kernel.org> wrote:
[...]
> 2. root's cpu.rt.max: sched_rt_runtime_us already caps total DL/RT
>    bandwidth and rt-cgroups admit against the same pool, so what does
>    reserving the cgroup share separately at root add? It's also a
> writable control on root, which we otherwise keep off root.

Well, /proc/sys/kernel/sched_rt_{runtime,period}_us control the total
fraction of CPU time that can be reserved for dl and rt tasks; here, we
need a way to reserve a part of this fraction for rt cgropus only. We
need this because "regular" dl entities (the ones serving dl tasks) are
"global" (can migrate between different CPU cores), whereas dl entities
serving rt cgroups are pinned to their own CPU cores.

Combining the admission tests for these two different kinds of dl
entities is not simple, so we reserve a fixed fraction of CPU time for
rt cgroups, and the remaining part of
sched_rt_runtime_us/sched_rt_period_us is left to dl tasks.

If there is a better interface we can use to achieve this goal, we are
happy to switch to it.


			Thanks,
				Luca

