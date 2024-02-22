Return-Path: <cgroups+bounces-1816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6C8604C8
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 22:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6872819FE
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A573F2D;
	Thu, 22 Feb 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCIaY0Sm"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25273F26;
	Thu, 22 Feb 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637187; cv=fail; b=dgD+DZRWWlA3UjqGpnzTb4XXxOy6K4rvE5A9eC1UO6vE6IN9Ip2Engdh96AJikKobRH0qBIQNajPl+nWUIMQRt4W978QpS22lJx91VnmqKbPv04CFRCdJU3y2MteKCNcoIjVFCsR5icEiDsLWWC0pzNrsRe3AUmnPlrA2RgrFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637187; c=relaxed/simple;
	bh=pMs2rbh6Gkp7M1U9+jy8Zmn8W0I4iqaiJj7SHp/SHTc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWl5cUOSQJvU15zejPMix+XtdM9Zu1LUgvR1fdAfG68KgBNqEJmzfuyUTcfk0k+GY7FgZO6q7bLKOCawZ3MPsHezSg6BVNn4UAmHs1mXWpCf0VjaUD0Z8mTQBA3dATECy7PA0H3CjliZU5eG6weD39GvRUn1TNGYicLf95fuApU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCIaY0Sm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708637186; x=1740173186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMs2rbh6Gkp7M1U9+jy8Zmn8W0I4iqaiJj7SHp/SHTc=;
  b=KCIaY0SmAF4NX8vI/sIKA2TSBItJetir0gHgfeilwFCqeCLkHjNs0BhZ
   Re/ZeAETQYiuBHwevRc3X1HrR8VEPCQPoFodHCuHLBySXvLNZ8B7n9Aud
   ViM3eUUeNGF1jdcH+r0beXEaBRPu4klobd5rbMEQI7FBUCAUIaDoEY+ED
   7bMJw4gj+JC1uPVeWxIFNRFvpdOZdo2SDv7HXdst7lmjZlw6GqdE7zXDD
   k++7ohqhzBw9sgqqPjuCwIBgq4KbYAuoy7M7PRPHYykdrB+qed8BkNw1G
   yRH2dHfp303zl+IxX36gPzZl/zX8/TUTyBzGoKpVtob+W7yigARGKgpDT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2814194"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2814194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 13:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10212988"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 13:26:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 13:26:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 13:26:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 13:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM7bkYOK6kaNmS/JjfwFHmGA+7jkYRbbup0vu2DRClyqso6Q+/Jgj7J2MWFkzbRoNcX1gXqOrqdO9eNPH4fw7NWr1gyQ2j2Jq3DmOokZO43atIh7F1drK/wktFR543snxzqJF8tel5I4UIXeX/PLG/LLGD4Nupcvo0QP0IiQWhu66h8nRFKMooRZ8g6/sHalbqm9H3A8qrA7OXuIdGt4Bs3vzy7fz4Jlik3yyjI5TW0uvYpsO2WpGlQJGyG/sIWm8A9QRWBAVlk3+D8HCf/7vLLbNIgV07hWeyMiTyHOHwwzinCjI8K3LvE51Ypaq+FZt2wvG4ZBO5ljpopwT8S9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkfTOR1UrQHhTjz2zm0hI1wsO8kRMvjn5hxVYd2gmTo=;
 b=AoDDBkLG2+3nJf9V4EOU02uNSDSXr9bGLTFPXQzyQVlvh55bMUk+wP4F+kwU23CQG20PbkgFyqYYvDLVzbAzNBzC5RPfa7Px2VZejCK4DpMHUaOjNb19XVi4jVIuatx0c7fXPrFaZzH/n8QsJSzq7O13goTDy1raeImNoDIBljug6aP6wYYxXTgvO03ZcSlNnmzJPgkPiH1KZ6hOZdhEakqVRQod0X+e3p7nQd7bH9a/UuOHN2xlI2EvrZ4AncOn1/gHnFwAnAU3urXyf306KK4/TtuSqtvbbVOIGeRk9yQ6M/2r9Vrt4pNdS//CyGNIBwLR3vZM/c13e9l00f1EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5355.namprd11.prod.outlook.com (2603:10b6:408:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 21:26:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 21:26:19 +0000
Message-ID: <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
Date: Fri, 23 Feb 2024 10:26:05 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Content-Language: en-US
To: Haitao Huang <haitao.huang@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org"
	<tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|BN9PR11MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 54923eac-8c89-4268-ede2-08dc33ece8e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1xw/S9+k5CNM6UvpcKrBxIWLRWh4DzbaKBcS8DHpmp679Sh5vc6C8jVHi5YpbSBbOFDcTEgxBpo1noLm2sF4Zg2GI06+vM8jqXyK14I0AJSlVN2AEAeWcgdBqYtLsqiD7jHM1BXZ92TBSXNwaePS16H4L/MK5Voo+lhD//F42ouFinHhCe0Zi+MmEGO6NLxPgkdrsySJz6+m1ajnIBNHaBgc+WQu5vAS2ykTtt8nM3x9njPcipR27ki+G/nb3QyD4SWK+vyTZSYXrk3ciobT5fM5qxMaHzIFKRi6DVbRL4uYEaOCD6FoRAcmJqH7sCYDyfXTEXL3d8aL5ePW+ZVlM/fihiFkA6rtgli/Pqhw3s83Ycdd+lrHHZFD+EO9DFIefLdz6F6pFx5LXqjQP02pPi6Y6nuKhWJpXELo3Xw2VhEPqHNHl+q7VGoFX8jiYEbH83R9sz2s5VIcIkxdIDwBimZud74fUI9WXcMO1mRgCecyX9u4cAGRP9iPy+2DXz3nxDFYHOWz2K5Zo46EY0R/pgGFvdGlnVpTnhk1TeNpM+FaQuQfcinq8JmqYkOq/j3Ur3c+h9/cSoH+mhiIfeUVIkAkheU1K7NYl/k+5UDSPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDhaTDM0WTllYzZxNjRrc24xM3p3OGVtSm0ra0lmSm9hcVRoY2JMZ013V3lm?=
 =?utf-8?B?WE0zM0k1S0RaazJadkcxTkYwdTgrbmpJYmJJVG5UbTRCSGV3bWpyeVFRcGlw?=
 =?utf-8?B?Q1hkeTlYUTRBVVVHWVIreFl2eUZhcGY0VDJycXozUFR6OXdxSVhFdlRqUU1L?=
 =?utf-8?B?TDBidFQ5YUVpWlZuVnZYQlQwNnR6dStpU1oxa2g1cEpVS09Dd2RnVzVCd2FN?=
 =?utf-8?B?ZmVYbjhBbU9mY2VuNlF2eUk5aHE5bTNVS1FyTyt4VEJBbFdaaFFaaEdXZ1V6?=
 =?utf-8?B?bkI5MGpaeGxWYzlmK3RyejUrRDNRODV0Zkd6NVRrRHU1cTBOOU44WEYzQ2V3?=
 =?utf-8?B?THh5VUxCVnNoVWNkd3JZYjFzMGtSRUJZcVdKOVNCYzBYWFI5NTJXOVRpOUg5?=
 =?utf-8?B?cEY3WVFlK2tBbmRJRXlhbnQ2T2RsV1B6dU5kR0FicmREM0hGR3JmcWd1YlJ6?=
 =?utf-8?B?bTA5VHBUUjRxQTRCTG51ME9YNTZHMWZhNzgrSEl5UUFtV3FDTnk2bU9wNkFi?=
 =?utf-8?B?TVhVM0xycEJyWFVVZkJwVHdpUVRxb1ZnOUNhWlRlUjF5L09uVzBCbTZSZnJl?=
 =?utf-8?B?emNOUGt6TW90VUg5TzdXUnpKc0dzNGlNRmhtWkU4UEE3blVQRklaYzU2VGpY?=
 =?utf-8?B?NUViSm5raDU2THFYWlc1aDJJNWp1Y0lidUk2OWhja0VGUHYvYzUzUmtFYXZY?=
 =?utf-8?B?WkNFN2R3U291YlpPdXkxNEZtMXZCUnh0eWJDSFkrMVcrNVE4TUpPZWp6SVll?=
 =?utf-8?B?RmsrdzdYQ1JTd21wZVd3aG9sb0ZMTHZnNWd1UkVpM1N3dFVqNG16L0p5bGRT?=
 =?utf-8?B?Q1dpa0FNZEhvMHo5dm5obE5XNlRWYUIwMjlIMEUvSHhJcUpXMjBCUHUyMEJp?=
 =?utf-8?B?VWovQk9CWmtRL2RsUEJsTmdCRzU3amRSejJTMUFscnpKbmFiQnJsQ21CajhF?=
 =?utf-8?B?MHhtcWR5MVgvVnc2TG5ISHNpUGxNMUoxSDMwdWMxS0RoRTZzakV5bW5sakp6?=
 =?utf-8?B?amFaZzd4N3hMcHErWlloWkt1UnVLWE5yb0FNaExhSis0ME5ueUJYeG1QY2Ix?=
 =?utf-8?B?OGVveDlFL00yNlRaY2FZOG5QamRKVUs3c281amVpUGpiWllabDdqS0VBYU1C?=
 =?utf-8?B?QUQ1S0Fvc01LaU9sUlRickcxNmZ4TWdCLzFIYVA3OFpJeTVFaHF2VEZSSGUv?=
 =?utf-8?B?VlhMWEZ4TlJta1lOb2pxQVhjRUVrclV3VG8zM2E3c3ZwNjU2RVJvUzZpa3o4?=
 =?utf-8?B?b2F0YlZEL1k4d0c5ZlpaYS9XRm9OTWxKa0wvWE5NWFgrSDRrWkU2YW9vOGd2?=
 =?utf-8?B?MHZCRGxNdDY3ZnN6bGVJQWNERytwSnljOHBTRFNiUE1EZllqQVNLZFY5UkpH?=
 =?utf-8?B?SVlvZFNueFZ3djF6NEg0TnpZdmllQnAzMXBLUDJzcFkwdTcwNVRvVlAyQ3F3?=
 =?utf-8?B?SC9zY2Z3c0FleFNUNkJpeVZER0ROMnZNMWwxSmtSYjIxUHQrVlV6emZOakVo?=
 =?utf-8?B?VTZqVUQrenB2Qm1xUmxUalduUjNLVVlTc3czYTR0d3N2YjREa0p1WXpjTFFX?=
 =?utf-8?B?U3NNTDk0eXJCZExYVXFOUC9CRmhuRkI4MzNZeUdobDRucW0xbGs4eUQyTlho?=
 =?utf-8?B?UTJMc2grNmdydStlRUdIZ1ZYV1FvaDgySmFNUW5CdENzTnUyQVRtay9BTnMw?=
 =?utf-8?B?cGdWSFQ2elNkYmRMQis1RVZUcTN1SERXMitiNWVXdjRhREVqNE1ENDNvdXVG?=
 =?utf-8?B?eEFORjRKcS9lbjdkQnNVeVE0ektnZVlwVll4NTVYaGp2a1g1QU8xSXpjVG5C?=
 =?utf-8?B?MHRPb0N1STlJU0IxVmV0dFFmTjB2R1IvM1o0MjRjMmUycFk5dXIvWDMvN0NL?=
 =?utf-8?B?R2c2WEhDOTRiWlFMWXNIa1BvTHN4dVJ6Vm0xREx0R1FCbU1BdVlSRGJyTWVV?=
 =?utf-8?B?aDBDUW00Q1lsZnZtSm84ZDg4NlhzVXVmMVJqa1lOV2ZibE01MVRxRTc0Wmsy?=
 =?utf-8?B?cTU3dFQ2QVFRTkdYWGpWQ3pEbU55enZYZjdGZDBXUnpCdWdCZWdndHpxWk1s?=
 =?utf-8?B?R2dPR2xabkFxS3FMM1l6QmNZWE1IUk5lTjNlamxtYVpVL1dUUGZ6KytRenRP?=
 =?utf-8?Q?/fGf9eGO9dzYxQIJf/GInugf3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54923eac-8c89-4268-ede2-08dc33ece8e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:26:19.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa+Fq12wQDtFgM8fNEwh4C2YSJQ3K1VFVZbpjj2ZR3q+eSImHyOOfVIe2E5vfvTC1ZbomRZqKH9/1Pvx3ZXeXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5355
X-OriginatorOrg: intel.com



On 23/02/2024 6:09 am, Haitao Huang wrote:
> On Wed, 21 Feb 2024 05:06:02 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>>
>>> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
>>> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool 
>>> reclaim)
>>>  {
>>> -    return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, 
>>> PAGE_SIZE);
>>> +    for (;;) {
>>> +        if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>>> +                    PAGE_SIZE))
>>> +            break;
>>> +
>>> +        if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>>> +            return -ENOMEM;
>>> +
>>> +        if (signal_pending(current))
>>> +            return -ERESTARTSYS;
>>> +
>>> +        if (!reclaim) {
>>> +            queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>>> +            return -EBUSY;
>>> +        }
>>> +
>>> +        if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
>>> +            /* All pages were too young to reclaim, try again a 
>>> little later */
>>> +            schedule();
>>> +    }
>>> +
>>> +    return 0;
>>>  }
>>>
>>
>> Seems this code change is 90% similar to the existing code in the
>> sgx_alloc_epc_page():
>>
>>     ...
>>     for ( ; ; ) {
>>                 page = __sgx_alloc_epc_page();
>>                 if (!IS_ERR(page)) {
>>                         page->owner = owner;
>>                         break;
>>                 }
>>
>>                 if (list_empty(&sgx_active_page_list))
>>                         return ERR_PTR(-ENOMEM);
>>
>>                 if (!reclaim) {
>>                         page = ERR_PTR(-EBUSY);
>>                         break;
>>                 }
>>
>>                 if (signal_pending(current)) {
>>                         page = ERR_PTR(-ERESTARTSYS);
>>                         break;
>>                 }
>>
>>                 sgx_reclaim_pages();
>>                 cond_resched();
>>         }
>>     ...
>>
>> Is it better to move the logic/code change in try_charge() out to
>> sgx_alloc_epc_page() to unify them?
>>
>> IIUC, the logic is quite similar: When you either failed to allocate 
>> one page,
>> or failed to charge one page, you try to reclaim EPC page(s) from the 
>> current
>> EPC cgroup, either directly or indirectly.
>>
>> No?
> 
> Only these lines are the same:
>                  if (!reclaim) {
>                          page = ERR_PTR(-EBUSY);
>                          break;
>                  }
> 
>                  if (signal_pending(current)) {
>                          page = ERR_PTR(-ERESTARTSYS);
>                          break;
>                  }
> 
> In sgx_alloc_epc_page() we do global reclamation but here we do 
> per-cgroup reclamation. 

But why?  If we failed to allocate, shouldn't we try to reclaim from the 
_current_ EPC cgroup instead of global?  E.g., I thought one enclave in 
one EPC cgroup requesting insane amount of EPC shouldn't impact enclaves 
inside other cgroups?

That's why the logic of other lines is different
> though they look similar due to similar function names. For the global 
> reclamation we need consider case in that cgroup is not enabled. 
> Similarly list_empty(&sgx_active_page_list) would have to be changed to 
> check root cgroup if cgroups enabled otherwise check global LRU.  The 
> (!reclaim) case is also different.  

W/o getting clear on my above question, so far I am not convinced why 
such difference cannot be hide inside wrapper function(s).

So I don't see an obvious good way
> to abstract those to get meaningful savings.
> 
> Thanks
> Haitao

