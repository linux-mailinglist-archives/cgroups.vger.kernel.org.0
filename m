Return-Path: <cgroups+bounces-2714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64C8B5169
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 08:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61859B2098B
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F410A31;
	Mon, 29 Apr 2024 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRD3q6VS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954B10A09;
	Mon, 29 Apr 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372138; cv=fail; b=WhVVxKVbmfPSfwasOmSuikgJUgOExqtv+MF71dihE4tqIQkiP/c/QJPzs2kPvNugfW0cps2Y6Cd1cNYteniCa1AV+IPweF2GduH2jBhNaHi5TmhfkhnyfM7+yx04jQACDf4yGJhlX0DeDXNBmbbgkA2JJ/YDw5A8P3c0S9/41/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372138; c=relaxed/simple;
	bh=GNIOgk1K4aHY50xCJRjS5O+7/jZjleXRfzjlY74RLko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uoF2Jd5wd+L4xqL2lsanEvzAyp5KXVyUFXNFwZ+VxiGCDc2zrxaw5yXute3vxzVJpepILIZ5xGHUS7V0T3QYVAj2+nFrO5HRGCmswnHDVM7TN1v9LRBGw1+xyCgyB9FxMXFx8J3jv2TvD2f3XYLFmCgcGKNO1/YmgppNDNqG26Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRD3q6VS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714372136; x=1745908136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GNIOgk1K4aHY50xCJRjS5O+7/jZjleXRfzjlY74RLko=;
  b=VRD3q6VSlZHxPGj0BYR+xAr/u8rw3iS43bqVNVv6xYDxBiqNpInuKtYC
   g1R/+4ottUaoWlj0pmrfcnPCRKJsGvyTvz6xSe8/1Kpp4gLjwBRxCApKf
   DWz/Fuljr59XRnRz4paMpZu0mr95mwHh/jliJKuFEyM8tCI/fTRA33q3e
   lS+jilkHyVcL6vxsdW5uGOMxcZeR3FPz7Gajl6k3cbX63BHAGh6vsyxQP
   d+gXkma0i5vXXq3QufrKfaKEl+3vj4sVXgV0og9iMtfoVI3yFSFVhLEbM
   NMOW1/0JmvgjxCLBQpFI1TTWBZf15Jknb8wPfbjY4rG2uRP+EBNds+jeH
   Q==;
X-CSE-ConnectionGUID: vMwclg9NRwWAyprQST+KYg==
X-CSE-MsgGUID: hjHjgkruRf+jPvIstQrQPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="35413184"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="35413184"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 23:28:55 -0700
X-CSE-ConnectionGUID: C5O4z9iwS/Kj1+64O5J6BQ==
X-CSE-MsgGUID: hkbtnmkxQaODliiYD5aOrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26000435"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 23:28:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:28:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:28:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 23:28:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 23:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnXC8b34eq7YK4WiPSLo0X0MWsxrVwS6xbi42JRInCJgNMD9Kin6tPawvjOPIk+oItdLh5GYZ3gng8ugroLgMIqWaW6LH2dfxKGfNad9QNVnz7dmkHHN9GcGu2IOdel2Y4XMkzq1l1FnDBTXZV2WPbHnZBpgmwp5L2VY9aEWGlwVOY14ncVy12+fh2iC6WDgDdLbx1Qql9GoQPUhLho5PkjDjlR1jYz7kSuOns1nDxU9DM2BZk9urZItIX8gWErKzx+7CQegKwDX3JW9TZz5Z7Ivd4GZqWTim+AGx2HA4aAwpMeNGkKdsTRNxo6nLP+dV/8cS+U6Xg7Gqh6/S1Axvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LtfmZqU60qFO5Q7xgbSpx7G7fzPtw70Nf31Mqoxcgk=;
 b=nNQ868fXe+gEptX+/csSz8R5jazK6dGs+ZD3/PZ7s28h81w4X7WkJ+m0I/NA4ka6wad1O6ri5lzULTYOZ9Tn8mcYB7GE6clBDMpISDQTdqzvhvf89JmIuZaxXDV6PMkUe1iTYKp/5EFU0Lxq9xOj6EbHuZwh9gCT4yxoVqLLV/xQ9fRphxv3I36G8vSPgPgrDLhnYY1REOXoVvlVTdPmxnH1daZ3imi58RyzX+YoYcaETp+3WJbgOqh2L32abmpEw5aP9SsMgk5+2aX+059yxB0bybq/wxGUne2ftpx8qujPkaObpgZuHu3Tg4X4va6Qhzi8hDR43yz8l+3Bk/irqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS7PR11MB6061.namprd11.prod.outlook.com (2603:10b6:8:74::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 06:28:52 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:28:52 +0000
Date: Mon, 29 Apr 2024 14:29:09 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: David Vernet <void@manifault.com>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<cgroups@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 3/4] cgroup: Add test_cpucg_weight_overprovisioned()
 testcase
Message-ID: <Zi8+NT0tGNxgiu2q@xpf.sh.intel.com>
References: <20220422173349.3394844-1-void@manifault.com>
 <20220422173349.3394844-4-void@manifault.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220422173349.3394844-4-void@manifault.com>
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS7PR11MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: e27eb28d-37c4-4cd0-aada-08dc6815a377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+NLqjqdRJNp0+emlHJ7JgSd5bLJOaPnTK2FZKx6ByMwONlnuHIdu0LIGW7QZ?=
 =?us-ascii?Q?OEqUfxjfHSO4xdBJdHd76IZ0aVTit8uP4Q7mZfu5ZHRRwDhMk0kob6iR+Uv1?=
 =?us-ascii?Q?DkvgOtdLJu9Qfqa/QTRufDAZ2dTthxR80we4MuwS6IA2XBiACQFfFWWYYPet?=
 =?us-ascii?Q?vux4W/cwJkzEbA7wvOPAniKAD61Hxe7Ayw3jNmFBIJKB52TVDqfVzcL2UKX+?=
 =?us-ascii?Q?5VtUuLxvU0NtKzkJ4fIDMZZVEXmOrSpLQhMyhwRjBP4Az23W+/DSLDqW53yr?=
 =?us-ascii?Q?fgv1L4Rvp6dOdKVixJ8Xm8McGN42DxPy651J6WX8Bs84pvZt/wJUWXRrJjGf?=
 =?us-ascii?Q?EZwBCnHagwkOmPD6y+bawxZkgPSeawq0PyBBMyBJKuabSyIaHJPDny3c6F1D?=
 =?us-ascii?Q?6oq2COCjHphHwJTyGiALZCxU+sGhkXWyJ86JSlnqCZSndajzGXncEgIA/i2E?=
 =?us-ascii?Q?KLbwXEelM37+kHcB+1eBEbA3l9afs7OMb0Czi7bq/luqnUQoXg+ET9f82x/S?=
 =?us-ascii?Q?RZV0Ix4TgQjZ5h5pmpiyk2ArHLzQcVMcL3nogg7xTV68Ittd428yO1H+mqzJ?=
 =?us-ascii?Q?8I3ZH2RFP84VMkxTwBb9neynGyxDlK3VzWz2eRmEweJClpgumebexJf8trKY?=
 =?us-ascii?Q?zRfrt6Ju7AVNSNXlN4nJI0StkSXksLTXcEN0HoP41V1XNheB9hNB3JpBhNan?=
 =?us-ascii?Q?MBLS6tFRAkEcy3waweeywNEJ47HgG8BeSGAkZybxXzTChyzrxaNwmOU2EfUd?=
 =?us-ascii?Q?MyVJ2II4hDzIzxtfZqJN+M9A7ODi2hE+ciRskWfKa2YCuU2hIF2KZBG1YWDK?=
 =?us-ascii?Q?0A7iI4+qpIPXIw2tYllSgOKijmULYC3pxkg/DR3rNwOFHlka9dZE7TyrxHGw?=
 =?us-ascii?Q?EzOg8KAatadQTI8Ws4vnGJd6bzGxS+yd0bpeDxRtbEoaTdulwLMvOrPyOCwM?=
 =?us-ascii?Q?7Fd7mi4D9fMTZmZ5r8Xl9/jhK3YqXRylBUiOLpKlArTOQt6TKwMvS2GgxW84?=
 =?us-ascii?Q?s5319KEayBmbtH1twJiHMrf1qTgh9cXEN21q5i8DvF8hZ5567ZAm6BqifS5A?=
 =?us-ascii?Q?2HXlinV6AVcz2eefz0910HFJfSIU+pB4hNQtPAWs+3fmFEVLCxItzD80Tjsr?=
 =?us-ascii?Q?OvjzSUNTxKXTMke4nzFVsWI8PRUkU9yFNOdj6ucWjts2INsLE/PDjNgXGxI9?=
 =?us-ascii?Q?3CXtjmLbGiWVBsYw5aiaW2za0HLf9GDtMDr1pdekw4LRk7XSIe3fr9qqtN7v?=
 =?us-ascii?Q?jkOCfTf1/2rywSYxDkefbJtMVNVQ0+bgqIsexTWXMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WV4CScEYXOMnu5lnkaoOdgqHHn+7RERjRK/pQ0oybLC2E33v1uoXoC7NCarS?=
 =?us-ascii?Q?sn7Lzzvlwre1fvP7OOtFpvT6EIzXFvOaPRm6iTiMp2PKpDrfvTPMkZsyU3M6?=
 =?us-ascii?Q?wNwLhtwgjnq3nzOClhlLkaDlqU/HWNZNG00yaZjHxUP6Abfw0SJpEnxq+3kv?=
 =?us-ascii?Q?Qi20ub2l56zM/Jzj5noc/8R7D6nzI00yga4Tt+0PR0FOAu/a/8+AMCUNvWLY?=
 =?us-ascii?Q?6k97PQqubnNUx+F0Ww8cKFCdVwhG639NjmWncbFDcPPeEgOJRPQEQiQVPoCQ?=
 =?us-ascii?Q?m2KT7TIkZEtMQuwUPIryynFJEqEShT2AGCeKlScXXb5n1oabkJfo2PALLMYg?=
 =?us-ascii?Q?lkhC33gP3dsRPgVfscMmhzM1lHIZrZlpLcJoF1xGwabrGHXmiADk/1tXTomZ?=
 =?us-ascii?Q?rVisiPx7OgeGW/GxownmhO0o04m1ASqSyyY1VPE7tIiPJ5R5teAVCEj39u3Z?=
 =?us-ascii?Q?iCfsxMlnC9On8w5Ql9SKE09gYp+i7CHtY6CORNuQGQm3LuImwgEq3b3gTvfk?=
 =?us-ascii?Q?sOzYHZXI49TtwlwrzzEQz7lcCPS5+WLabQ+f/B1yoFqZX/LZWbEEeIvgmCoe?=
 =?us-ascii?Q?cFnjEN+RQ9zIOjLnai+nBT92XF0rrgd6MgTNK7oLG5LsGdYcr/5Ceujl4Zu2?=
 =?us-ascii?Q?iU1bR4i2AWCAMbCYMspCKLZ5+DFgYl83yWv0ubYukRHZGeScuvRM3eqLcQyI?=
 =?us-ascii?Q?SeqCygr+eaO1OTMCJt8IYpBir3HeyvUvtuiMqtkYd/goeURm51tJuXJItev5?=
 =?us-ascii?Q?9nmYIjhX+//LpNiItjaRd7M68FwUrstmd4zJVI4LFzQFv6SKabTQVxThggFx?=
 =?us-ascii?Q?wDB3JXfnQtgLT0WceGRiM7oaep3sUqTurOD+NbzQRwQxCxm2jHLTofWn2Jj0?=
 =?us-ascii?Q?vWBygL9rsqV3F5FDakhjCNGiWuSUftH+M82lL+EaZiOeendOsbrRf5uZ54I/?=
 =?us-ascii?Q?43T0E/odPERLUYBLVZMwM3u1OjXBUiqUpotgf5BU3mXHav/9tBBx1uf3C0+R?=
 =?us-ascii?Q?2Atz/yWcBwxx3UWlbahasPJryvnK9QfrmWHHohFs71ACOuDFWjHIc+j381eW?=
 =?us-ascii?Q?2mW0/ZXhmzoF+2zp+3BeviMGgq7ZG97wOnKyUD6y2SKtq9czp1+YLf5up0JV?=
 =?us-ascii?Q?jnS1DoAuvvfWbxNznUdn9jJ/qB1nKis3ESOgNhk3NsvbipZ6ykHhtV9HneoD?=
 =?us-ascii?Q?Ht5d35AYDXx8R2897DYzz1YwzMjlW19SrJe/+nlMXP9cf++h06NjRmgM6Lio?=
 =?us-ascii?Q?ZccJvTvouNnUc7SUgUhrDgHF0QjIemRqLK9F9tNJsJsogirIl3wWfusW6H2v?=
 =?us-ascii?Q?gvx8U3RCXc9Rba186qmUjck8jPy/+GZKkqjbWFsI0WGRRHJd8LqN2Tr7kaQR?=
 =?us-ascii?Q?Hq8dz1RHp37nmia+bFUdBzrKfUlR5N6jdexxA5Wjdg+e16QoxXiUxsWtcSBM?=
 =?us-ascii?Q?i/3RZcOyxp9CHONPi2HrKPeqHipNfwhI1b3M1pienZaF9b1xg4O+Kfes+R/o?=
 =?us-ascii?Q?n4yRAW5pd5ycXfQnpYo+AX12ratlGHgsQ7TsVGZYlMzYMM0nFWKRD8rmq8ce?=
 =?us-ascii?Q?Sx9f234CSXiF0aU3hsResMxCG2IE4EhuVDsAOrr7P1L7LspRx9k9S+4sjyCQ?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e27eb28d-37c4-4cd0-aada-08dc6815a377
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:28:52.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CoU2gib74JjchSf8OAjWxYbki51Q3BpZTv1eKiFxY/kufUW97DiO9se3kkOa3dT4rV8QYRmUdKT4/AxdBt3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6061
X-OriginatorOrg: intel.com

Hi David Vernet,

Greeting!

On 2022-04-22 at 10:33:52 -0700, David Vernet wrote:
> test_cpu.c includes testcases that validate the cgroup cpu controller.
> This patch adds a new testcase called test_cpucg_weight_overprovisioned()
> that verifies the expected behavior of creating multiple processes with
> different cpu.weight, on a system that is overprovisioned.
> 
> So as to avoid code duplication, this patch also updates cpu_hog_func_param
> to take a new hog_clock_type enum which informs how time is counted in
> hog_cpus_timed() (either process time or wall clock time).
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c |  12 ++
>  tools/testing/selftests/cgroup/cgroup_util.h |   1 +
>  tools/testing/selftests/cgroup/test_cpu.c    | 135 ++++++++++++++++++-
>  3 files changed, 145 insertions(+), 3 deletions(-)
> 

Related commit in kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6376b22cd0a3455a534b6921b816ffab68ddc48f
Kernel: v6.4 ~ v6.9-rc5

I found test_cpu "test_cpucg_weight_overprovisioned" was failed on
SPR(Sapphire Rapids) x86 server sometimes:
"
# ./test_cpu
ok 1 test_cpucg_subtree_control
ok 2 test_cpucg_stats
not ok 3 test_cpucg_weight_overprovisioned
ok 4 test_cpucg_weight_underprovisioned
ok 5 test_cpucg_nested_weight_overprovisioned
ok 6 test_cpucg_nested_weight_underprovisioned
ok 7 test_cpucg_max
ok 8 test_cpucg_max_nested
"

If I changed the "struct child children[3] = {NULL};" to
"struct child children[1] = {NULL};", test_cpu case
"test_cpucg_weight_overprovisioned" will not failed on SPR.
I'm not familar with cgroup and does above change make sence, could you
take a look for the test_cpu failed sometimes issue if you have time.

Best Regards,
Thanks a lot!


> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 0cf7e90c0052..b690fdc8b4cd 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -190,6 +190,18 @@ int cg_write(const char *cgroup, const char *control, char *buf)
>  	return -1;
>  }
>  
> +int cg_write_numeric(const char *cgroup, const char *control, long value)
> +{
> +	char buf[64];
> +	int ret;
> +
> +	ret = sprintf(buf, "%lu", value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return cg_write(cgroup, control, buf);
> +}
> +
>  int cg_find_unified_root(char *root, size_t len)
>  {
>  	char buf[10 * PAGE_SIZE];
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index 1df13dc8b8aa..0f79156697cf 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -35,6 +35,7 @@ extern long cg_read_long(const char *cgroup, const char *control);
>  long cg_read_key_long(const char *cgroup, const char *control, const char *key);
>  extern long cg_read_lc(const char *cgroup, const char *control);
>  extern int cg_write(const char *cgroup, const char *control, char *buf);
> +int cg_write_numeric(const char *cgroup, const char *control, long value);
>  extern int cg_run(const char *cgroup,
>  		  int (*fn)(const char *cgroup, void *arg),
>  		  void *arg);
> diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
> index 3bd61964a262..8d901c06c79d 100644
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c
> @@ -2,6 +2,8 @@
>  
>  #define _GNU_SOURCE
>  #include <linux/limits.h>
> +#include <sys/sysinfo.h>
> +#include <sys/wait.h>
>  #include <errno.h>
>  #include <pthread.h>
>  #include <stdio.h>
> @@ -10,9 +12,17 @@
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
>  
> +enum hog_clock_type {
> +	// Count elapsed time using the CLOCK_PROCESS_CPUTIME_ID clock.
> +	CPU_HOG_CLOCK_PROCESS,
> +	// Count elapsed time using system wallclock time.
> +	CPU_HOG_CLOCK_WALL,
> +};
> +
>  struct cpu_hog_func_param {
>  	int nprocs;
>  	struct timespec ts;
> +	enum hog_clock_type clock_type;
>  };
>  
>  /*
> @@ -118,8 +128,13 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
>  		(struct cpu_hog_func_param *)arg;
>  	struct timespec ts_run = param->ts;
>  	struct timespec ts_remaining = ts_run;
> +	struct timespec ts_start;
>  	int i, ret;
>  
> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts_start);
> +	if (ret != 0)
> +		return ret;
> +
>  	for (i = 0; i < param->nprocs; i++) {
>  		pthread_t tid;
>  
> @@ -135,9 +150,19 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
>  		if (ret && errno != EINTR)
>  			return ret;
>  
> -		ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts_total);
> -		if (ret != 0)
> -			return ret;
> +		if (param->clock_type == CPU_HOG_CLOCK_PROCESS) {
> +			ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts_total);
> +			if (ret != 0)
> +				return ret;
> +		} else {
> +			struct timespec ts_current;
> +
> +			ret = clock_gettime(CLOCK_MONOTONIC, &ts_current);
> +			if (ret != 0)
> +				return ret;
> +
> +			ts_total = timespec_sub(&ts_current, &ts_start);
> +		}
>  
>  		ts_remaining = timespec_sub(&ts_run, &ts_total);
>  	}
> @@ -176,6 +201,7 @@ static int test_cpucg_stats(const char *root)
>  			.tv_sec = usage_seconds,
>  			.tv_nsec = 0,
>  		},
> +		.clock_type = CPU_HOG_CLOCK_PROCESS,
>  	};
>  	if (cg_run(cpucg, hog_cpus_timed, (void *)&param))
>  		goto cleanup;
> @@ -197,6 +223,108 @@ static int test_cpucg_stats(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * First, this test creates the following hierarchy:
> + * A
> + * A/B     cpu.weight = 50
> + * A/C     cpu.weight = 100
> + * A/D     cpu.weight = 150
> + *
> + * A separate process is then created for each child cgroup which spawns as
> + * many threads as there are cores, and hogs each CPU as much as possible
> + * for some time interval.
> + *
> + * Once all of the children have exited, we verify that each child cgroup
> + * was given proportional runtime as informed by their cpu.weight.
> + */
> +static int test_cpucg_weight_overprovisioned(const char *root)
> +{
> +	struct child {
> +		char *cgroup;
> +		pid_t pid;
> +		long usage;
> +	};
> +	int ret = KSFT_FAIL, i;
> +	char *parent = NULL;
> +	struct child children[3] = {NULL};
> +	long usage_seconds = 10;
> +
> +	parent = cg_name(root, "cpucg_test_0");
> +	if (!parent)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "cgroup.subtree_control", "+cpu"))
> +		goto cleanup;
> +
> +	for (i = 0; i < ARRAY_SIZE(children); i++) {
> +		children[i].cgroup = cg_name_indexed(parent, "cpucg_child", i);
> +		if (!children[i].cgroup)
> +			goto cleanup;
> +
> +		if (cg_create(children[i].cgroup))
> +			goto cleanup;
> +
> +		if (cg_write_numeric(children[i].cgroup, "cpu.weight",
> +					50 * (i + 1)))
> +			goto cleanup;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(children); i++) {
> +		struct cpu_hog_func_param param = {
> +			.nprocs = get_nprocs(),
> +			.ts = {
> +				.tv_sec = usage_seconds,
> +				.tv_nsec = 0,
> +			},
> +			.clock_type = CPU_HOG_CLOCK_WALL,
> +		};
> +		pid_t pid = cg_run_nowait(children[i].cgroup, hog_cpus_timed,
> +				(void *)&param);
> +		if (pid <= 0)
> +			goto cleanup;
> +		children[i].pid = pid;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(children); i++) {
> +		int retcode;
> +
> +		waitpid(children[i].pid, &retcode, 0);
> +		if (!WIFEXITED(retcode))
> +			goto cleanup;
> +		if (WEXITSTATUS(retcode))
> +			goto cleanup;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(children); i++)
> +		children[i].usage = cg_read_key_long(children[i].cgroup,
> +				"cpu.stat", "usage_usec");
> +
> +	for (i = 0; i < ARRAY_SIZE(children) - 1; i++) {
> +		long delta;
> +
> +		if (children[i + 1].usage <= children[i].usage)
> +			goto cleanup;
> +
> +		delta = children[i + 1].usage - children[i].usage;
> +		if (!values_close(delta, children[0].usage, 35))
> +			goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +cleanup:
> +	for (i = 0; i < ARRAY_SIZE(children); i++) {
> +		cg_destroy(children[i].cgroup);
> +		free(children[i].cgroup);
> +	}
> +	cg_destroy(parent);
> +	free(parent);
> +
> +	return ret;
> +}
> +
>  #define T(x) { x, #x }
>  struct cpucg_test {
>  	int (*fn)(const char *root);
> @@ -204,6 +332,7 @@ struct cpucg_test {
>  } tests[] = {
>  	T(test_cpucg_subtree_control),
>  	T(test_cpucg_stats),
> +	T(test_cpucg_weight_overprovisioned),
>  };
>  #undef T
>  
> -- 
> 2.30.2
> 

