Return-Path: <cgroups+bounces-11185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3939C0BCEE
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 06:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57B0E4E2EEF
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA72877C2;
	Mon, 27 Oct 2025 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzuxiqey"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A51FF1AD;
	Mon, 27 Oct 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542065; cv=fail; b=DRPCY1mPglyXy30kM+SuH9zZrcvaaQD4yQ8HaIxncth6hhXloSSHGd24EjEWk+NCe5PASC7u+HAUj1jzq0FWSpErCNkKu1Pfu3s8CfxILl+d92Zs7kdkq1A6O5wshs4dxCUpmG9m4UPTUSsY+SoMO1mDq7QKoQXcPKrTGJ8a62U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542065; c=relaxed/simple;
	bh=abHsTALfWlZqGKhFgoM3eI2zXf3BE4jVQtIecxH528I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PjxX1Mev/gnDdsyyeH8wE+lUNP+sbCBD5QJs7ofphBHPGyYDN6RyZZUyRfokIHZEBDWBC5dAr79lzq2k61o1khTE8wriZK/AGwe+Lk+Zvhu0iuIWr9ViY3gTOl1uGnTKJoDpI7dHtkb5Lwja8phZ0qcz1vopOlQLEoILPAy7wT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzuxiqey; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761542065; x=1793078065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=abHsTALfWlZqGKhFgoM3eI2zXf3BE4jVQtIecxH528I=;
  b=Mzuxiqey08ZYXB3MIJzZzZYmFlBnNc1VBOi5BMu3B8YxYm7EK9rLq7yi
   Glj3XN5tHaTHKwwTPHgiZQCKeLetuBR2Wm6dI7U97xIDlSwi92TA2Rdxy
   oS7p4WUObt2W2p9W4EvUiG2kPMrsdNypnSI2AU4XminE1NgTAGMtmo370
   XIiL5RAJtcCI1pnb3LrwQy+0uqJD2g7iyiI8HvtqDrHpu/JBlc1b5m9uq
   zaZwuSqhwgN2s9NV+z46rE+TROzpN8sb6M6kmtw2J1RLbBh/5Bckb78gC
   RNLFD+9bbLLSdxvNGDtpB/WjWIyYe2EuWCu2/ijwRTO0xjnW+bARkicPX
   g==;
X-CSE-ConnectionGUID: /XCHgyMwRHa7FcTs1/hhiw==
X-CSE-MsgGUID: tTafLf3bR7mQZVLrSP7GNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75060090"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="75060090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:14:24 -0700
X-CSE-ConnectionGUID: eg4UOMs8QR6L2bmUgxv+Zg==
X-CSE-MsgGUID: bR+sH+FtSDiTClySBMkdQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184127374"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 22:14:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:14:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 22:14:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 22:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qun6T+ZUck6k2WLZLrUaGkl7CJOaK+plGmG8jmSaCwYQIIErLVXvRQOpJ3Ys9sBH8g8ZniFmJaL2Xr9xwRO71KaLdTe2YqQUk2uZO24YQ4vROOFdl3nYWeelcLzclrAeUdADa0MGXIN7zkJT/xrtCmHluszY/IUSA7xeqk7eJEBRAXLYZODKlxVQ4gbwut8HKA64QfkASxTqQbvOhBP+dcIru2cC03vQo0tdKJHWF+EsdBdXi/6VJhyL/L+r1yNIkgRDVSq+9GOAKgjutIBjKnHx8keP3enbVb0U3Ggo0bPILEWShGpRsi181RuMTdU2ao3YXIm2QTHjxPi+xOp9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/KR/NXwcrxrG/SoLd4Q+L/LoY9o5RxG/P1pXkMjOA8=;
 b=BtMsm9S9VQFIvyX96zDxCMqYYf1rpbBpRbjMNneLRbBgLwIgHdu0UzVdJJEVFAtfn+g4SAfKrEnCRBv+YEn3BjwU5h8u/DK8hoTPzDw2IDC+ZdM7KkmWCMPqrXLZR4EbLQS5u0/MZJOY+LDrjHvXva2mEimFyz6jsM0Kir/bvelDMVz/dfowZ3XaNxCca5g8E5Og3Jdi6HMxRxsxZJH6AfPbDfQD5cfMTFQsMySdhjHmJSEXNJyRBF/XK2dvEd/VvAY3BTG7bGVRk7/Q6ek4yKiJ4aDaoa3iDRIFmcZPdvtjGDQt54CR+X3aMqwZDkwihXIWoGFhm99VZOJhFPU8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 05:14:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 05:14:19 +0000
Date: Mon, 27 Oct 2025 13:14:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tejun Heo
	<tj@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	<cgroups@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched]  b079d93796:
 WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread
Message-ID: <202510271206.24495a68-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: PSBPR02CA0017.apcprd02.prod.outlook.com (2603:1096:301::27)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 671b69e2-7044-4e02-d94e-08de1517ae8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?27GagQ0ojde3ivCkwNsDi2aWijFHuRlq/gL+BpGKJJ5t85dySk/h+hNZtZLf?=
 =?us-ascii?Q?A2Y+46Cu3paB9smLGZuaTnOw8+OdW4oIqfeKtoe+Th/lMyym0vh6rk/7tWHt?=
 =?us-ascii?Q?KqKx4SDxkmFyxAl5VqrqdHcthAFgBgsU3vMGDBNRSmnkKG51TYwiUWLJMaBb?=
 =?us-ascii?Q?dAsioOYm5735Qw34D8AtHC4HtMh7DDzcA5wiyO40Xd+ufOfgDzXuFRHpph95?=
 =?us-ascii?Q?MWMoXocfk467CDyrnFGcCSEipR1SU4ZX6ceWkBj2KKlWpOji7yo0cxg/OHDV?=
 =?us-ascii?Q?4GDO9XZahuD4vVe0WAolvLkGpdR2eTkBEQ2lRqAVDuyTmq1DwZVYbAf2plAA?=
 =?us-ascii?Q?Jizb878ku8pyQOUnPcT2VtmQc4MBPTn31D8GBaY5U4ChhquFYcFljrhhzRrl?=
 =?us-ascii?Q?PAW4lYRFY8OhrehgHIQSVD4M8OKBpjAyHQiW91snmiUhLB/GWZvO43X28kR5?=
 =?us-ascii?Q?ELRQyIEpQJ9ucJ6A7KMfhRESNmCG01Y5gc9FU+aB1SIxRndp6coosC/e+l7p?=
 =?us-ascii?Q?HMPVtH73YYkHRWJ8D6hajh+rpbUo+clkrxr3I5rGI3CUXHRb/a4/8Nm1TIT6?=
 =?us-ascii?Q?DUFD3r0Jpf9cRh7QVzyTsjW76mwU2E9fhF02TV4J9F4uH8sGi4PZflM9PczA?=
 =?us-ascii?Q?KCQcBLPtcyn7E5rDgWTO2ABzvEaXidIOVM8g0qA6XR+WKng9S0xVrvnqAWWV?=
 =?us-ascii?Q?qo/EBeLvn67bhaglxWOUVffy1TmrW8g8/viQ1+kz15S2wZtCz/e8WVLI4EgE?=
 =?us-ascii?Q?ReYcO+IEqZhlLTk90FXu2A0kyr7x0BEE2yJFzpmfiMcknRSBjLFIEaV0MmAC?=
 =?us-ascii?Q?HShhepUuald4KJRS9S2oCgBl/ghQK5/DPfC88ahN1afkihDFbyC4XgfAa4J8?=
 =?us-ascii?Q?aJpkQwlAGyOHKPpAtdHTVx+aOb0ODKbOKxZW86TtmwW3dsImGmF9zpbapfqu?=
 =?us-ascii?Q?5cs1FIkuUybBGDyLXrJFrV2//qV3wq+CzTz4SaOFbuqpx9hJvrOwRcZcH+rq?=
 =?us-ascii?Q?X2qLZEIX8Vqude+Iag/k4//6SmX5H8/L7EugITDlH9a0Z0e8AXZi2i/i3z6L?=
 =?us-ascii?Q?HeO0uAphudV2anqDPwTbYmg1kHJPYHbxGb8UaMG1NvdNjTPjJPmBXoYcGyp9?=
 =?us-ascii?Q?ZlwTglWa0dRj/DdYZC3N89bGiHL3jKaU+mQ4wxFBxYibiXqLHUDJEygf29cP?=
 =?us-ascii?Q?FpRTTKHeJ/xPeEDDySzBg5KAEXboE4Z3C07P639sUWiT6iXuVLQxzmc8UULg?=
 =?us-ascii?Q?7oB+HO/VwPxD2GpMNOvhpenI6b1UPW3yX5bkkiqL/bMAoIUn4Bot0uj8OXp7?=
 =?us-ascii?Q?9RfkyzkbvL/1t04kK/Pf8DmUSDcSrsI9pxFSiZHx0WvQZz7sDFhmbBEuuHWA?=
 =?us-ascii?Q?+BeyWOUOeEe6NESU/BT+wNufqR8KDpBbDAxlyeA1wCqY4OjddV+hME/4jSoP?=
 =?us-ascii?Q?evPIzftbGujOy5PFi8g02/YaIa1swSuZvrpqIzsSsYbVHVu5nQVzMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJg1WTruEUhB/jtg0LkTyYDz/useaPlxpi4Vl5MELelTUVJFCSLjcXG+wb5b?=
 =?us-ascii?Q?KDeBlBRLynPzzu7/1B1cdWXWbTlBFGBTcNfoXM2aGfLLni5N7yBkWnr0UmE8?=
 =?us-ascii?Q?/gFNMoil4gC1dCt6BDW4gCz8okD9cmE53l+t+RD9RdnDfURt13LUm6tu0/Vc?=
 =?us-ascii?Q?WtKn1A/h/hEz9DFQe1xF/JSD/oiLxzMjBzxYeZBUMHqfomDL2juTQcajaMk5?=
 =?us-ascii?Q?c0l77yXaw2tsoZlxFdjZ/ZVgo9tx0f+jQrpMoBJ9SdVmgtTekRpjiCvlifqX?=
 =?us-ascii?Q?zIdPhTm3FY+5XT2nDxkKvjDNbQgUE1siRFldx9hlLgTeVbnPuFAEXkdkz5/3?=
 =?us-ascii?Q?79V/cfmgBSPFfZeeVgOG5zGtgLtLyM7ty4Ne6dyRAhPvWBdp05qMGU3PvScq?=
 =?us-ascii?Q?tDWR1Iy2P0DOMgDkGL79+fPCZ04pI90ZVGMFEvotbsMCyu+nkF+NVVJhA97w?=
 =?us-ascii?Q?pH9tZmhL8YG0U3w9ZC/W47gXbsKOzBiSZCvgUM+LajBe8tXeIYxdWAPHIcXw?=
 =?us-ascii?Q?YtJuoc6leQFk2mNYYNF6Vhwib3we51CZDMCCyVBJW/EkKb4861b8C2hYIXCR?=
 =?us-ascii?Q?sKRVAGbPKaQXTvqENpv/Sla78n0JWeVmpsiJq5oAYxLqPKZyd87uTwnJSyVy?=
 =?us-ascii?Q?9M2mtNTWKyQytHR9KC4a6gjqMALLXwhCFSJuwirVNe/qJOWh83mzV6zuLBhy?=
 =?us-ascii?Q?zshtXNNGmTgjukEvlO+cJz6Y0vgRtvLmG13nPcNpSQkUkYvH5vX5hRSQSVtE?=
 =?us-ascii?Q?184TzNe47pihkynrYyMKJ/YyD9k0FVwNKKSxq74Ob6qtI9OqhB04STMH/psV?=
 =?us-ascii?Q?6pSGDTVXjFDtygpWjgjnIYFfx917M6fxIVfeQzaPVul6DzcEkd0+UJNrNmzg?=
 =?us-ascii?Q?h4WIzRAIP4a63EicBQsBZ4iIJXZLVGd9wLA4ttJmQ6MGELpHWxhI/rFqP4kq?=
 =?us-ascii?Q?jdcZiR7w5DMyO3lRWwPmUmAlBGIe9c/NMP8wxZgjejWhaA91+5Lwu42SDs0p?=
 =?us-ascii?Q?jTW24SotvSXROE2/iUfwRwFoI9FZXTQLBZ6/0dywuIMkVD6NBRXl/D0dHx65?=
 =?us-ascii?Q?rdXINvXVHh0zIfzydEYL/bptoyoknFYMkHmDR2cpOzvYVFsV//w2zm18hznb?=
 =?us-ascii?Q?3zS9Tz51MDyMZMk6ByV9OsBCVii7dFkBqr8eUvhyjU4rMD9sli1HSCoK/BN2?=
 =?us-ascii?Q?SSKxPZWzByv/WRzGcBN42J7jdG8hefop9gk6oDKIVKpedzbqFp8W0gx2w5Ri?=
 =?us-ascii?Q?MFQ2Ut8Ir5S1bWfC5J+ncP7NKL3IzWeKxN3MDCYQ1a/TPvW3CC3+iCulpqVw?=
 =?us-ascii?Q?3mMrXB0y0NSZWNomOA/kp00hQnC9i63epLCYq1G9FrGHK+s/YT4TQzg3aHGp?=
 =?us-ascii?Q?8ocZHOaqZugmqrecIa6qJnx/Us/EoVBAFBkf2Yeb6mwpU85uhpYKOL9G8cVX?=
 =?us-ascii?Q?Rzl9rSjNr8qlB4CDQGbAsZRCyUgKh96aRu0nTq1BGwpOn5aso3SyIHYC5kAe?=
 =?us-ascii?Q?hmQjSNfzNkZffRQ3wNvVLq8uEVRqgzb8N5OIv5mRT1NijXe3HICm3J9ITZSq?=
 =?us-ascii?Q?d8NFvNL/TIXK5xNoQ9JDmo4iWEpXr9awYeY0hYo6mt1fqYjqLFnqrrcUD918?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 671b69e2-7044-4e02-d94e-08de1517ae8c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 05:14:19.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umUpX49kAgXDPmsAkMy4gOQXOWWF2qnjoI6W0GW1n0Dty/TaT6qhhOjVMF8KV9JCoPxdqCfwnwJeZ295fdyCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com



Hello,


as we understand, this commit is not the root cause of the
possible_recursive_locking_detected issue.
but due to the renaming, the detail stats change from form (1) to (2).

we failed to bisect to real first bad commit for
"possible_recursive_locking_detected" issue. so just make out this report FYI
that there is this issue caused by related code.


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-062-20251022/clang-20/300s/cpuhotplug/tasks-tracing


abfc01077df66593 b079d93796528053cde322f2ca8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6            0%           6:6     dmesg.WARNING:possible_recursive_locking_detected
          6:6         -100%            :6     dmesg.WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:do_set_cpus_allowed_but_task_is_already_holding_lock:at:cpu_stopper_thread          <-------- (1)
           :6          100%           6:6     dmesg.WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread       <-------- (2)



kernel test robot noticed "WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread" on:

commit: b079d93796528053cde322f2ca838c2d21c297e7 ("sched: Rename do_set_cpus_allowed()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master 72fb0170ef1f45addf726319c52a0562b6913707]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks-tracing



config: i386-randconfig-062-20251022
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510271206.24495a68-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251027/202510271206.24495a68-lkp@intel.com


[  116.814009][   T21] 
[  116.814488][   T21] ============================================
[  116.815227][   T21] WARNING: possible recursive locking detected
[  116.815957][   T21] 6.18.0-rc1-00014-gb079d9379652 #1 Tainted: G S                 
[  116.816878][   T21] --------------------------------------------
[  116.817602][   T21] migration/1/21 is trying to acquire lock:
[  116.818301][   T21] ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: set_cpus_allowed_force+0x3c/0xc0
[  116.820432][   T21] 
[  116.820432][   T21] but task is already holding lock:
[  116.821314][   T21] ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: cpu_stopper_thread+0x93/0x170
[  116.822291][   T21] 
[  116.822291][   T21] other info that might help us debug this:
[  116.826420][   T21]  Possible unsafe locking scenario:
[  116.826420][   T21] 
[  116.836196][   T21]        CPU0
[  116.836895][   T21]        ----
[  116.837592][   T21]   lock(&rq->__lock);
[  116.838388][   T21]   lock(&rq->__lock);
[  116.839558][   T21] 
[  116.839558][   T21]  *** DEADLOCK ***
[  116.839558][   T21] 
[  116.841003][   T21]  May be due to missing lock nesting notation
[  116.841003][   T21] 
[  116.842427][   T21] 2 locks held by migration/1/21:
[  116.843393][   T21]  #0: b92d06dc (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0x28/0x2b0
[  116.845044][   T21]  #1: ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: cpu_stopper_thread+0x93/0x170
[  116.846669][   T21] 
[  116.846669][   T21] stack backtrace:
[  116.847890][   T21] CPU: 1 UID: 0 PID: 21 Comm: migration/1 Tainted: G S                  6.18.0-rc1-00014-gb079d9379652 #1 NONE  6d63d2e836521c1c681a07c673117fb98e4815ab
[  116.847897][   T21] Tainted: [S]=CPU_OUT_OF_SPEC
[  116.847898][   T21] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  116.847901][   T21] Stopper: __balance_push_cpu_stop+0x0/0x2b0 <- finish_lock_switch+0x7d/0xd0
[  116.847909][   T21] Call Trace:
[  116.847914][   T21]  ? dump_stack_lvl+0xa4/0xdc
[  116.847919][   T21]  ? print_deadlock_bug+0x2df/0x300
[  116.847925][   T21]  ? __lock_acquire+0x268c/0x2ce0
[  116.847929][   T21]  ? __lock_acquire+0x601/0x2ce0
[  116.847933][   T21]  ? __lock_acquire+0x601/0x2ce0
[  116.847939][   T21]  ? lock_acquire+0xc3/0x1f0
[  116.847943][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
[  116.847947][   T21]  ? lock_acquire+0xc3/0x1f0
[  116.847952][   T21]  ? __task_rq_lock+0x73/0x1d0
[  116.847955][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
[  116.847959][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
[  116.847962][   T21]  ? __balance_push_cpu_stop+0x136/0x2b0
[  116.847966][   T21]  ? select_fallback_rq+0x148/0x230
[  116.847970][   T21]  ? __balance_push_cpu_stop+0x163/0x2b0
[  116.847974][   T21]  ? cpu_stopper_thread+0x93/0x170
[  116.847978][   T21]  ? raw_spin_rq_lock_nested+0xb0/0xb0
[  116.847982][   T21]  ? smpboot_thread_fn+0x11b/0x260
[  116.847986][   T21]  ? kthread+0x2ef/0x330
[  116.847992][   T21]  ? trace_hardirqs_on+0x76/0xe0
[  116.847996][   T21]  ? kthreadd+0x2a0/0x2a0
[  116.847999][   T21]  ? __smpboot_create_thread+0x1c0/0x1c0
[  116.848003][   T21]  ? schedule_tail+0xa6/0x100
[  116.848006][   T21]  ? kthreadd+0x2a0/0x2a0
[  116.848009][   T21]  ? kthreadd+0x2a0/0x2a0
[  116.848012][   T21]  ? ret_from_fork+0x1cd/0x290
[  116.848017][   T21]  ? kthreadd+0x2a0/0x2a0
[  116.848020][   T21]  ? ret_from_fork_asm+0x12/0x18
[  116.848023][   T21]  ? entry_INT80_32+0xf0/0xf0


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


