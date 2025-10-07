Return-Path: <cgroups+bounces-10575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6974BC09DF
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 10:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831E1189EE0A
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889282D3756;
	Tue,  7 Oct 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUNbdvXy"
X-Original-To: cgroups@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8862288513;
	Tue,  7 Oct 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825557; cv=fail; b=p+PR9nzgA24PULkvCGEvmcf9P7N75hHIJlaBzsYU36prBfbIcyI0HLp3dYlaKe0Q/dDiLHHxV+auIFT+gfCnmVPHuoJrNoFDriawcvkuIFrUJWxOMB3DcG1cv/7FPHFE8xOEc5pZCvvOH7CRSDT+ZOe2Fu/H01JOrU7fhUx1WsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825557; c=relaxed/simple;
	bh=Rw3+PUuz6ky+tXy/gjCMjtc3MelllM7Urlt5ljViMxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTPA7RjtAZAdZT4nbsLDaLtva9tBp3+DRbP2namnIR2UieJbMfPddNIpX7jYf9qNeglAtW5w1ukekpTvn+fKUWLUSLMgj/i0+CiMiw+tRMroQWnw2DwMJr8ohhavckwBQCiSyv9YjKRWSa+tY+TnQqZiweBGcDmshJmqmlZAZ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUNbdvXy; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCsLnk/ZxRucqQtyUrHxZCA2AT4a3Gn3vnTcXllI72jw5N85Hf54gOW5WI93L6hknIHccgvorAIdzM70BJdciW/Uo8Cq/B+Srhc3u1YKO2F8CiKYmL5CjV3DVyfie8R5PDuGcMYq8OOBMTlTHP6vlBXNtxXktTYwQQ2YSNIx40bo6/Iv19NjOYCNSfLXOtNpZOCkqfaLJwyMAliPu6XU66Ly1ueKxagMxuPYz744FesIh48wZ0nTNJv6a6gs5E5KM57KBd6U/m5JY5ULhi6Yz3mvjJaOTEHSBCRAfp236zgU3ov4dAy2GeigkLEPIx4AOQH6WC4VOAVFu1/fmqSsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ/w+O27lW5NYoim7TUlb9V+ZBwOWgO1yQHhngSlyvA=;
 b=qmvrkCN63LPJs4aO0gSrmf0IwDaOliDM7QwGth42UkP9Zal2aHpVWCTWO99Eu9JyqoKMHYdijndv+HbbNX5nfE64BI/WMo3/Y5FIFtm6uUHzBMIF3FpsjECRAtllPyvrAX6zbuHWibZzuPRirMuF4JUEaiS2bCnbwF3Q+TGE6mUc4u4jmyfEJerFUXQVToe0uK9vhhCPQSwqL34VqomB/trmPb6NSv3TwOgk4W3EYRf1zFTopCF4grDCtpwq1EOtDLz93/HySwmOdr0XtFc0zRpalC3IM2KTqPeKMqrpKmQgtTKYvT1O0S0SdeWyUApY5BKlHhsd2OOUIrlgYGtfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ/w+O27lW5NYoim7TUlb9V+ZBwOWgO1yQHhngSlyvA=;
 b=VUNbdvXyHNZRzeUZswbsACFvs0r7NJ+Bf/b6uOOyvJc+U5XSdpxI+iWPHHZuwBFLIz0aTPBXEyBU40PjAgGBiCLlu6+HSehjVsAOHmiHfNOWXPG/gCo4YIBz69a5TGlBwc6XbrZ357q01hwEz/j1jmrprxBFlYhVUXoPxU5PilYooNgwLJtoAGwfvPFIhd2o0MsbBLncRelrlwGy8Rg2upjmbSG2trnDFDQwOQrHpRZFafjf0IrZWknxjebXLAhYlFBmzAuc758kdJ5jjSUy2HSw2XtIi0Mwkj2/W424RLzpoa6b4CJRoaeJkuXgT1Oz8+GgcfhyOpUabOJg1IkAxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:25:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:25:48 +0000
Date: Tue, 7 Oct 2025 10:25:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
Message-ID: <aOTOgazXTC9CCSL2@gpd4>
References: <20251006104402.946760805@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104402.946760805@infradead.org>
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: eae28ea2-8eda-492b-df0c-08de057b1e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IeV3KdM/JovjVuACPlO8fQPtnE45Mpy0jidkcu/oQjDsS44hjYo3mpDdnrCC?=
 =?us-ascii?Q?owS+OQaC4PleODSzC7uSc8hTLzbtAcWcYRZmINI9iI7m9be2qeDzaRjZSLhF?=
 =?us-ascii?Q?3DmXyPV4tLRQs+bgcrbpMiRzBmK3aNsNyHe7nR+F9fSKOB0UOq1O5EgYrSrI?=
 =?us-ascii?Q?Tdpmg0s6XPUaCgGc4EbDnrroEw4qjpe+d7ZErEV2thPzysinFaq2PwxIuFwX?=
 =?us-ascii?Q?iqQbnxRzmQyCAuXLna+8OUW2LFZCkbzyDmknv+/R9YwTyOo2Nk9Q3foRDBrB?=
 =?us-ascii?Q?4X75RiUNljv4AuJWevmTX0DXT1L31qXw5YhHtp4kPB3v+qcBaswab/KIJ2eE?=
 =?us-ascii?Q?nKMuVNSjF4lISsyvuX2hgW99uaJbcgY/9H7VCjGMmVu4wL2rCDeipyYL2SAF?=
 =?us-ascii?Q?YtZs92crGVPEvUG8ANft3xSufAFC1F5X6ulPJDXbCWB4Li/Sx2JEVeUbAKI9?=
 =?us-ascii?Q?ML8w4rJZ6C3Wg7hlnkkHaQZ1VQGnc1boSt1D9Hbg2RkxGMU2J82RY95Eo8qb?=
 =?us-ascii?Q?Uaol5HFr5XmPi5bIlC5oaI6nSPxN8FewK8s5jl+Z9z+Vlsk0yUc/wxkZeHp1?=
 =?us-ascii?Q?3ZmufFENnYRhPTRf0jS4ACxtDWFQei/tq7DSBEkXpSaj/dZT8gUcfVSFZJiT?=
 =?us-ascii?Q?eYy4H2B7cDZ4760G54+BSTKqMscOKHd1ToE267P32j0KQMe64CbGZojLHEFJ?=
 =?us-ascii?Q?YWipy8MndXIpPS7NDvgSOkGQ1d71z4mb8LT49jAr6b2ORhEbExpoKcz4aEiA?=
 =?us-ascii?Q?mTcABdtVioU16njFzKsziQ0S59hjZjo/cKMnXVFQ4S3x4knwAmi2N/Tu+R9a?=
 =?us-ascii?Q?2e/c+NauuxhPkXbW6lDuQ9HRhOZU8RGwEmPGbDNfCgnvwhhr+TjjBCYFf5fn?=
 =?us-ascii?Q?XJri87H93p9b4sPmhBm8VKYfTO3Qosjlo6TOZ7bUuxIgs/5x/HvfapcQyXQr?=
 =?us-ascii?Q?1Kixnev5mzc1titrfrNEKwXUAQp/QCAqHpQc/OAKxDOCkVZNadVwv8hhJIe0?=
 =?us-ascii?Q?lbddOE3cVY0VxgSB8hjNKfelNlJFuCrbbVxx+IYe1g9xVYbs2T1b6+/GEr36?=
 =?us-ascii?Q?H47yzuHnOIkEJalWhR91ZVKaujivZg11TYfzb/dPu2+NOH1S4W9ZzB05q1Fs?=
 =?us-ascii?Q?QRM9ATfKEhVJ1i1aCq9eD7ESKhI0Bq3QC+e3GmziODR2T9Ek9OsP8oteq8Kq?=
 =?us-ascii?Q?fNDMGe/isZdZFFWyo8hcLZt620EOhzqO+JDKnSm/kkB2nmbthaJdQcpMK1lF?=
 =?us-ascii?Q?dgeFtIaidbaNrhzQ2iE2j1b2/bZ8zDL7bztjv5Ldy20mZphONi3sTINKakqb?=
 =?us-ascii?Q?lji12cgT3fJEZw6MVEjYSjTXo7i2661DsSC3du70Uf21rShW2VEa0yJsUqZA?=
 =?us-ascii?Q?SY8IA7B6TMRF/aa0pDJCNPZ0Zi3+qPt/NQbX2Ui5p7RPUsUOGd1WKg4VLk9t?=
 =?us-ascii?Q?QhSsCRjKvFquA57NwuH2/UAXbjxE1Tvx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q/YXZpD/wZ0c8vsVHoHoOFH42CS/adQPYFkOtbIAWXAmDlw/l2uMhm6J9oBn?=
 =?us-ascii?Q?U2UwzPh7Mamibeb+en1grjOCn4l2m91cm3L5ucIu5GWBmP7K8O2RZpa9Lj1V?=
 =?us-ascii?Q?j30uOuLISua0cDalBwReMcW0Q5xtcF2L4v6EcTTm2KzUvQ8PGNAXixgw7j9J?=
 =?us-ascii?Q?m8GT/iHT8xqyDYU6jMc4ibcBbn29d/DS6Bqgum5GK0EXc3U3/gq2+BpZycQO?=
 =?us-ascii?Q?/18tarL2uTRDBRohEoa2sjhuFMWnKjYl47paa1NSiPU+k3O7+QBzlZcO7tx3?=
 =?us-ascii?Q?4Xlo5Jeze1zDZAEeqeeEPVD8IoEXzWxB5pTNV6EwvNDnlrjgOhHPGWBWIYOx?=
 =?us-ascii?Q?mewRte/Ktgr86aIBsp3ojEiCqtW7QoVFUvQCDbdKTF+SXDqVSKtYhKPNnqRl?=
 =?us-ascii?Q?zi4NmDJ4vUSYd6GLGlkdHzxi1ooSwdW6vGmSzog7uQ0HukJXIYSsyKgyLRgZ?=
 =?us-ascii?Q?+gGXBtDW1zzULfCb0J/mrgKFLG59Pl6ZaUda62NEb6TrDOu8pRMNeQg2Ifco?=
 =?us-ascii?Q?z0iyioEWeNjVlKUwxtv2fQb6cIvhOXLROgFvn7OOejpG8Lv/DmHjakmawPLq?=
 =?us-ascii?Q?2wisRt1Tn6fkl+rYJ9M1lym9+7r3DtZdh1u1RTQFUGPCJsD2V6PL0258YKR5?=
 =?us-ascii?Q?BjpaoUgc5bxgQJs3vYIdl41yb9Mu/5+WS1JBN3wvR1DZpJLFsTJakpamx19L?=
 =?us-ascii?Q?iI9ko+vCKH5uY9qKcryjV4+Qb971b042e97gdB4IFelLXR4Smbv/e0awTiO3?=
 =?us-ascii?Q?G27igjel0bzwHpe4Davq2FBIFzbu2f3aGt/FuSUj4jRJn1Y1ZRGUswyK0wKJ?=
 =?us-ascii?Q?WIbx3rl9aiqG4IHR/cR5eaZ857v4UhLOgH8wvhOO35ztAxaiXHu1bNJkLz0H?=
 =?us-ascii?Q?mYCjYXmMVzyiWhubDdT+fjpGJkKZR6nGom9uu0JrKs3aFJ7TWpItchCImrUk?=
 =?us-ascii?Q?OpxMfIdumQItrZKHK8C3td2T6uxLtfCjxMQv3lxr+f/612VqJrw079bjIoUT?=
 =?us-ascii?Q?kFG61fUb9wr9i0PrIhrWe0AfOvwCKBQHkn/rxNQyC6YWv2j5Ys1rEC4TCkZl?=
 =?us-ascii?Q?EebNeYw6If6SKjzImiOa/rkrjse0NO69Vpm6zHHTErQwGdl9RqNkliC86ikh?=
 =?us-ascii?Q?vRHEk4qdUmIw8zPrexwQS7sj2swOIrwnN1ySSpvVW2locoDXw+gti3dHELcE?=
 =?us-ascii?Q?cJ2lfDg+M8zxgraCn9dtknMrKBEe1lebutkoFxKXDPWBBrh/oRRFbLxCVM8b?=
 =?us-ascii?Q?CSf9kvx2AqTB6MZxhVq5zKaq0oGgWDCMF3Bh35V3wTHs2HWX8cVs2psLSnIL?=
 =?us-ascii?Q?I2ornM0IGpAbh59f/WKUXE6YWPcAWuE/cpJuzSR2CB5hDE86N3saj0/ZHngw?=
 =?us-ascii?Q?69gZhj3lGJEcWR/J4J8rlqfq6rItIqpTY6lMIs37zXABL/pxrwyU7qIQtvZK?=
 =?us-ascii?Q?HbpDuHXoXCUnLEIlYiQ5YHv9UWqu0iz9nef9x+1o5qNf/Vl/yFlSAl+6rvib?=
 =?us-ascii?Q?P5g9nYmqYIaF3AHVERJanY1yrfLHUd6J1Ci7kWJjyZpG5BEtrQGa1W2VVNXj?=
 =?us-ascii?Q?6sjStEohqz6Oy3kdv3U47lXQuehFGznbHb9B2e8o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae28ea2-8eda-492b-df0c-08de057b1e8c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:25:48.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCyzoxYaZfRik0beWCM6424F8V1uCnoGTkSCz7FE6mNIy3r/mZYmdb5IQnOpI+kog+hEsxNPYoP7JAde7uqooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

Hi Peter,

On Mon, Oct 06, 2025 at 12:44:02PM +0200, Peter Zijlstra wrote:
> 
> Hi,
> 
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
> 
> I would like to queue them into sched/core after the merge window.

They all look sane changes to me. I've also stress-tested this quite a bit,
even with the sched_ext dl_server patch set applied, and everything appears
to work well.

Therefore, from a sched_ext perspective:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks!
-Andrea

> 
> 
> Also in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
> 
> ---
>  include/linux/cleanup.h  |   5 +
>  include/linux/sched.h    |   4 +-
>  kernel/cgroup/cpuset.c   |   2 +-
>  kernel/kthread.c         |  15 +--
>  kernel/sched/core.c      | 327 ++++++++++++++++++-----------------------------
>  kernel/sched/deadline.c  |  20 +--
>  kernel/sched/ext.c       |  47 +++----
>  kernel/sched/fair.c      |  15 ++-
>  kernel/sched/idle.c      |   9 +-
>  kernel/sched/rt.c        |   7 +-
>  kernel/sched/sched.h     | 198 ++++++++++++++++++++--------
>  kernel/sched/stats.h     |   2 +-
>  kernel/sched/stop_task.c |   9 +-
>  kernel/sched/syscalls.c  |  84 ++++--------
>  14 files changed, 373 insertions(+), 371 deletions(-)
> 
> 

