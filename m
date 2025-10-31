Return-Path: <cgroups+bounces-11469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF2C26C2F
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4AE1352CF2
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957102F12B0;
	Fri, 31 Oct 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KR8TEn8u"
X-Original-To: cgroups@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F742ED870;
	Fri, 31 Oct 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939156; cv=fail; b=mMFjFSOvO5mIJBDDfNXCXK+attIcZ6539DYWU7epW++M8CtXgu+dYoWb3nVqBcJDVuShbLwOB9KtAigcTs9TFrDWFrBHgTnZWOF55W5Px0pUwv/nTzfj1ZsahllEqSe6SBe4T4+pwGPePDrmODWBc8gO6M5VmM23p/yvWZelGI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939156; c=relaxed/simple;
	bh=UrCr6+yoewRvbv2UZL6Ru86tR48Hrak11xpcueLtZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/Pa9koyPR20jXkhbgWx6Pd9bCoH9h0ofVRfRqVB2InArqN6SSNyQr8UE0/ovGUIxJ1rMOr+caB1zZF27dm+NkZ2bVg/wZdSyBp5mBKbcZ15RNbgLfECPuREJP6krFAkB4iPsDdxITCZ4647mbNrSnoxV7L0EZB/xNVoGOyj4W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KR8TEn8u; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJyE9b0XP9e1xvK7nv7XQzfqH6EA13OE10xGNcOHsgn3bI6f7axUhdvwwwxCxRcn4bJZ63+PVeNSskK9PhmIPs/2DrD86NS4WmGavfB1Zsn1N09NLbATmJ2ALaI7kS0lg2JzY/hY0NuV0fba3gUJ5o9lR0vzB5UU1kRuYlIaKVz9+9zZo7Q69nMdtw0IZ7pxY4ohLvgnq5paLqwFu7WFOPQw+Z9ZXYX4xKSVHXBc0FP7IaNDUwxIEcUdMcs1KrjhJ5xy2zP1yWCiaQLHl96BQcFx6RSXbrq2kpZRyBZbNACLsK9Seyq4SvmJjRY6cFyTiujVm6nnbFAQqkQfNEza8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn0M++OuyT6dI+ZvvICrvdl6nD7Hs7ETqy5nQw6Y1H8=;
 b=yr09TQjWTLytLzs3m0h+grYfr40gynJt01IDdI/frH4l/MwC1MvzAYsAZstu4GC7Qj4Nk4kI4dkB19urm2s8xo6AEIANDtqXS1m2ecUhw0JMuWyF2fh72s0pBm9OJ09g5/FZu7MHk9FRtXJZwPX0YjbtaBaOEtboS43OcSbL5d72tl0LkL7JJ/gOXoChi1SsrRzhmRroTW6I6YdvHb0PTUnmUGP1pHVT3FodNOQJ2EXv59lhpfXHrM7O3EoDEAZGDSd+76WDOwdnkjGjv5fFWsTl9Z7X/YPABy5amtpiE+tvhezSu8WPpDkw1iXq2vKssh5wT7yqkJSsmLWW2kgEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn0M++OuyT6dI+ZvvICrvdl6nD7Hs7ETqy5nQw6Y1H8=;
 b=KR8TEn8uij3PLuvcohYRJACrPX++Z5yHVeZCkqFizjORPbINwLwfauxLiftDeP0DxAVKJc1JP3oP+5m2P5mTZjQsimeJgTBCGaRwxOUsop5AAaO9ZpkVI4V0Tml0v+3BRX04spZG0Rz/4ytNrO8hGWEWWgzt0UjSrmCOwYwmqVFx2YoUjmVp0/7+9rkztm3sRnzqf9H59/HKXVnIXESQRJ60TI9lcb3O7MKDFu4IokcczuMlvL3yFFJ43Hg7NDzOVMXUcoZpyPD+wFkbL6lv5uktBeLdGjOGSb3U89zwgYtI8NRaH7OLtmW04UsKcM3N8nEruHDChLogLACueWriTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:32:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:32:23 +0000
Date: Fri, 31 Oct 2025 20:32:16 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/4] sched_ext: Fix cgroup exit ordering by moving
 sched_ext_free() to finish_task_switch()
Message-ID: <aQUOwC0qHvifqmuA@gpd4>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-5-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edafcaa-926f-4c2a-4f1d-08de18b4375d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JLeem/n495ctyVradmgVbAfeC5zGNmw5609MFVBpE8MGkfEN9n3VRFMSLHEB?=
 =?us-ascii?Q?zk8lpWXDUKyKodrvD6pzfUm/6CbjVNgkpxnqOciK/LoCRnRyIwjSCIIc91kK?=
 =?us-ascii?Q?SLWyjmyjdEMZWk+WmfpLLr6uaf1jZN2yGR3oEB6+OIUCg/iQWJgTArlH/HjI?=
 =?us-ascii?Q?MrOq6GgWkGjEGTy1L+pLY5orJPkqLa8Cnfrh8rg9+UF2/IbF0C9jCWIgvtJL?=
 =?us-ascii?Q?1s/n1a5VfphwTbvWij/HBJvQ+BSwIK23jgT5MIbX/9qrCEYYIVY42Dl5Kcs3?=
 =?us-ascii?Q?9ap8jhJRlj8+oOHHwDZ1DoGsmKljQgoFraDgog6NGi2fRD9+dKE3NYqHotTf?=
 =?us-ascii?Q?mG7Q1NUwHrt6ekewpgtC3imSg/0lAgEnZaQbDJt3PU2IMBIshkiNVk40knJz?=
 =?us-ascii?Q?dJZSCOyG7kLFswnpq9V4K/eHY8ztSmMls4aO+xBmFyZT/72h6Mhrk2zLg3AX?=
 =?us-ascii?Q?FIrP9B1saPZJIxIl6JuRqVOYTdcMeZN/G95qVUWnqXQUsDAHuiAK6TTo5Z6j?=
 =?us-ascii?Q?Q6PDgKQlVOTTRzSk4teUkIvGE+RwX/nFveNNkfCG0z1oklafGO5NhTvJAr+o?=
 =?us-ascii?Q?xCRPQJhldXZAzYBMs3AJOzfjiCEHcsLxYWKtJUbramF6EGl+657+fNbqprPA?=
 =?us-ascii?Q?nFp+jqFd18nYMJeovoO1LHaf1tI78CJPViQ3fpAaLUA39uAxdE4S3z9yVQi0?=
 =?us-ascii?Q?UJORpQb0g9yaA8DK8qJfJly0HXon1VPsv4k/Z6EkCcNk98oGYzME6eSzR41Q?=
 =?us-ascii?Q?w/aTDm+3tpA22R5sWgCVCjr9CmCXgJeDV81GoTFxIVr4UM877j1+mFS8B6z3?=
 =?us-ascii?Q?D3wcFrgal81wvamGTiSjlPWB0dngdegeewINSwr8nB0vIba8/AxRUWimM8hq?=
 =?us-ascii?Q?+vGua3iQ5/4NSf/zvqwOTfLXupR/oft1dyrEirpiM1SLtAGP1G4myz2rFgwY?=
 =?us-ascii?Q?+9T4mW+YD2KHq62fnraJokjRLRSvAswOunuLBRIhYEdGzcBeysRgIX69ONnh?=
 =?us-ascii?Q?hbmv4mNu3+Ab3qUkgflwmaadGXk3tXnW3P8F9YsfN0rGi4Muvx832J3GO19C?=
 =?us-ascii?Q?ljDZjfQbWzJM5uhZt1j4MbUpZ5K8MOOGVcV95yT495pV/NiW+sqqwUkhAYZE?=
 =?us-ascii?Q?2o6z198IOfx9W484Yb6ZfqFQ4NrMUhOzkGsqHTNlpfH3o316hWUskPKylj1j?=
 =?us-ascii?Q?lKq1aZM4IvUUhquSiUmuukLUrmuJb8Cc2mxDEM8tBGQc2d7U9p31REbnG6u3?=
 =?us-ascii?Q?Hy6ekBV61KcMVRozB3aB7xm0SKjES8lYPAnzEvgOydk8xlYBRLhsSSzDy3r5?=
 =?us-ascii?Q?FbH+utVHL2/6I2hcs5oPRIDWZaPJJxbb3iXDKWuC0RsFDfu8+McCTl8uo6K2?=
 =?us-ascii?Q?cgWRCH0zKBVbBpz9y5SqiM/EU7MAxS+akhBclhFMdJ6TIgnuagHLUGDZsjHq?=
 =?us-ascii?Q?qImx/pnZAxn1Xg4Fjzfl4Y1vOAfl/leI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JYlPC+2O6pMjyfGvcFMsrVSIYOGGh7lzqNgQeDyatPm8R3V//E48MS7R7ngH?=
 =?us-ascii?Q?MQRgeNyuKtxt29e554ZZc5VeP3wbAxxxkWzKOecrU03XAZM79zDLI+reJGeu?=
 =?us-ascii?Q?Ujvho+LnYU0sfzJiZlT9YdRWu3V7KCBoTG5CaCjBJKUxTH6eztkmuXj2C/3X?=
 =?us-ascii?Q?0E/SHiAYIN6/oR1/bQWTbhxuxQ6rWn/Ygv4iPwcQJfRYyLk/GBC4pSltbhAC?=
 =?us-ascii?Q?EGEb+QKVmhgaWYQVpjs0mdueYFPWpZip6HYwAYm+hA7AYTLHI51uJQPn72pX?=
 =?us-ascii?Q?9zXolv4Q4j9/EnqqQeH8RHtkOT/DeRzeMo1M6eNHg9xjvNkFlDkcAlJmtevG?=
 =?us-ascii?Q?TN/R6xMHZu+U5cCtbTHsdXIRZpUSwnlYWl1FA/zCopeqc28NcRD4BisIoCCD?=
 =?us-ascii?Q?4gVdflR3diSNxPX9VdoReg1UfBZNZK940IubQXcyqFuRU+gb8XusgQQanlgY?=
 =?us-ascii?Q?xF7YNFqv0NhpMHdXYFRC0V2LSRxKLzOh8YR/TvsdUADz2Lu1VnJFmsCgVVmd?=
 =?us-ascii?Q?bp0kzl1dsp8D0Bg7Dp4Vt3uoNzPhIS9RZzft2OpycKIfBAQe54wm5GkHHlPM?=
 =?us-ascii?Q?4f2pw0bWFI6jI+9yeApUx3fosXnfkQ2gROeBmv09VYCimPtHNNF9Qev6vck0?=
 =?us-ascii?Q?MGt0eO5WZ/Ih4utSXRUxMR/nHtLbQIDEJk8kaCYM6vf9iR9sb/WWFv7GPGt8?=
 =?us-ascii?Q?F+j6u+X2PoNSjvOVNUoFWRQdPOouN39oRbMgl48lSGhtsXtyIBdDfUTdAzYH?=
 =?us-ascii?Q?Flqlk6UEvAzW+3ahf37CO5WlSkh9MOX4SaP8/ye8c24Yd/Eaw/2glScoCUyD?=
 =?us-ascii?Q?oQH5gsoNuDQrEAUeGfCdXjMgy8Ra7Pn5mzk+YVa3OPnOkEOmM26qssO/pJ4E?=
 =?us-ascii?Q?GPcy8GQFMTCZJCsFjNxsg94RpMEQcdrvLgGV9ve2MepidGBXtJG7NZm/xrWq?=
 =?us-ascii?Q?DZEb4d73SmF/SPk/RxUUUcYzOu1Koqp56qWQPZin/gkjYzMCiyxuVHJiMxJf?=
 =?us-ascii?Q?hFDLwwfyO8K6cjmS/HbARDJsH35sybtTO7MVneDgZZ+qvG9qvOVlRo6l/ioY?=
 =?us-ascii?Q?TyzQ27qkrUsoMfDLAv8qF9KmxaRxPE0eM3ugv3rw5E4um3XFCJO9tGwpWu7e?=
 =?us-ascii?Q?ladRooa/8N/ZdWkV/D/t5gi2UUiuS5g6Ln5PaDqpGKlgr+rE7oVEaduG5MWP?=
 =?us-ascii?Q?ls2MlMO4TEFUxhoz305QHoM6RAKfZSjDjUhSa5i5PIK4r/EpAN1+jgb8GTQ2?=
 =?us-ascii?Q?pz4Ad3Mv6+Ukox9OC6qaKAFOp/KstSDmn3kigomeLJbBZDcKYf5/weJPWOIf?=
 =?us-ascii?Q?s4Dfmjg0a4EtLUJfYtpgjiFgbgk74Qtb579+B/Qr/zIgl8GkVK/HKvCln3p4?=
 =?us-ascii?Q?srvPPgfQj71dDM/5p+tLRLQ0jZ6krG1jU1L+ny/BZC/79rTdaovjOZcB1Alg?=
 =?us-ascii?Q?9+SDpUJKDamWMmMQuHONDx7kRsI2fbc3q0mtM7jVtnpL42b6b3y0V9Fx8e+m?=
 =?us-ascii?Q?H6HZz1X+b2mGBMN2r3meLxvbROMZeu6K2Fz5t/BPl6js88xqZavW7vayXVXr?=
 =?us-ascii?Q?OS3gLK8c5r4VB74tBRtFVQdBa/yTqyC15HKYjrWf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edafcaa-926f-4c2a-4f1d-08de18b4375d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:32:23.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbOzGvb9wDu3U1xsSb/ysTO5Rh77qhzvuJ9GkCfxRXiX5tePgejd/VmBgA7gZNmVAvRG/Ilx7dUz26W+gJWlMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

Hi Tejun,

On Tue, Oct 28, 2025 at 08:19:18PM -1000, Tejun Heo wrote:
> sched_ext_free() was called from __put_task_struct() when the last reference
> to the task is dropped, which could be long after the task has finished
> running. This causes cgroup-related problems:
> 
> - ops.task_init() can be called on a cgroup which didn't get ops.cgroup_init()'d
>   during scheduler load.

s/task_init/init_task/

Also, it took me a bit to understand this point, maybe we could add
something like this to make it more clear:

 - ops.init_task() can be called on a cgroup which didn't get ops.cgroup_init()'d
   during scheduler load, because the cgroup might be destroyed/unlinked
   while the zombie task is still lingering on the scx_tasks list.

> 
> - ops.cgroup_exit() could be called before ops.exit_task() is called on all
>   member tasks, leading to incorrect exit ordering.
> 
> Fix by moving it to finish_task_switch() to be called right after the final
> context switch away from the dying task, matching when sched_class->task_dead()
> is called. Rename it to sched_ext_dead() to match the new calling context.
> 
> By calling sched_ext_dead() before cgroup_task_dead(), we ensure that:
> 
> - Tasks visible on scx_tasks list have valid cgroups during scheduler load,
>   as cgroup_mutex prevents cgroup destruction while the task is still linked.
> 
> - All member tasks have ops.exit_task() called and are removed from scx_tasks
>   before the cgroup can be destroyed and trigger ops.cgroup_exit().
> 
> This fix is made possible by the cgroup_task_dead() split in the previous patch.
> 
> This also makes more sense resource-wise as there's no point in keeping
> scheduler side resources around for dead tasks.
> 
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Apart from the minor comment in the description above, everything else
looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h | 4 ++--
>  kernel/fork.c             | 1 -
>  kernel/sched/core.c       | 6 ++++++
>  kernel/sched/ext.c        | 2 +-
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d82b7a9b0658..d7dd77be571f 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -207,14 +207,14 @@ struct sched_ext_entity {
>  	struct list_head	tasks_node;
>  };
>  
> -void sched_ext_free(struct task_struct *p);
> +void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
>  bool scx_rcu_cpu_stall(void);
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> -static inline void sched_ext_free(struct task_struct *p) {}
> +static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_rcu_cpu_stall(void) { return false; }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 960c39c9c264..5ae37909a813 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -736,7 +736,6 @@ void __put_task_struct(struct task_struct *tsk)
>  	WARN_ON(tsk == current);
>  
>  	unwind_task_free(tsk);
> -	sched_ext_free(tsk);
>  	io_uring_free(tsk);
>  	cgroup_task_free(tsk);
>  	task_numa_free(tsk, true);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 40f12e37f60f..d4dbffb27a66 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
>  
> +		/*
> +		 * sched_ext_dead() must come before cgroup_task_dead() to
> +		 * prevent cgroups from being removed while its member tasks are
> +		 * visible to SCX schedulers.
> +		 */
> +		sched_ext_dead(prev);
>  		cgroup_task_dead(prev);
>  
>  		/* Task is done with its stack. */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..840bc76210c8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2926,7 +2926,7 @@ void scx_cancel_fork(struct task_struct *p)
>  	percpu_up_read(&scx_fork_rwsem);
>  }
>  
> -void sched_ext_free(struct task_struct *p)
> +void sched_ext_dead(struct task_struct *p)
>  {
>  	unsigned long flags;
>  
> -- 
> 2.51.1
> 

