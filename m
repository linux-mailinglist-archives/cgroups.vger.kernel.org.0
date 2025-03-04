Return-Path: <cgroups+bounces-6799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F01A4D3A7
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 07:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1642F3AE4A5
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F91F4720;
	Tue,  4 Mar 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzyMxUOi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAF1F0E44;
	Tue,  4 Mar 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069149; cv=fail; b=MqKiOlT2qD8YAjla5F90XtiSGzGLA1TklSXkzn9zNIUpv6KusIM2aNtvffCqNvEhRk108hj471JffXw3XjNexTZRZUa91svKZwQVIXVR7E3UxCTNqtCzgpzyiV1z4JdZPIWlSH1KEvOg7cPf6aOWLQ6yF2WiGBrYSiSTvtNpFbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069149; c=relaxed/simple;
	bh=3hy+osoRWZSv7DJ80XimUJQszq4fSUlW1TubkMXqbCo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gh+aW2+wETEGXiGetX52zRW+Bk/frqQOlwn5/qtjP34LS2R5PkPdUKzyFQB7gZ6noFZXTbQoPduR7i5c4JUFB/4kJ3LkU0yUR8iu4K98wD3jEYNVaW6TlnsSxJnCx3l9k/hQEbeI1IijizbsbYbigbTtai+SD61gFUav4OaojeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzyMxUOi; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741069147; x=1772605147;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3hy+osoRWZSv7DJ80XimUJQszq4fSUlW1TubkMXqbCo=;
  b=FzyMxUOiA1souoNCr2dBo4jHKby/rcAzYq9F3MVUcdD4wIJ7onRiRqzr
   dZBcCVGIh4uKzWoBeHBOXmNAQH9ZoUPR6A5wqwNFb7zWsj+NuiFWKxvGV
   0cKtRfxapOJyGAMYZtSsGQH+pJPn+LYf8Gvrh3KUko5X/qO0KyQHn1SaX
   1ZjHiIZl3nP7Vl5XXYj+G81CQYWHzUKkrIp6N+Hj7vb4et1Nk7ML+bqLD
   3iO8saWixKvUkk46q3K/eYkuYg+oppDv00O0Jt25QaLeYRNxoZRnsrhFa
   OybhJVVv3QHtXhWS7SbOpVUlNGg+lv2er7u18mNPmFJccEFNx4lRdkylN
   w==;
X-CSE-ConnectionGUID: jeE/5MnwTBGpnfSk77fiYg==
X-CSE-MsgGUID: dlr15Az4SvKCXhWKIEtXbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52951684"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52951684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:19:07 -0800
X-CSE-ConnectionGUID: OhnMqKI2SJic82jC6R3bSQ==
X-CSE-MsgGUID: 5kNqi+1RTWa/9OgcfQpHDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123220030"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:19:08 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 22:19:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 22:19:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 22:19:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN/b3mGrHtIWD/I1ErEN65FFLnNvXW78BbxNFoytqbJnUgPDckweUc1KynrRLBbYR/6fSFKS2GUC9mZIpWNOEtTbrT9BcAuEm3f4Jqw/Y0pPyLup9Q2HSDEjfWhB9/GTxPNzcYxUuNCKqxKatsTnU5E1l3fUDZturnTvlt4wEA/k9YgukipnrICqj0cBGTU8pOpAfp1bvnpYdMfd+J4CyuLM8AVIQRQGe4tJU6UJzBssJRvMNyGmy6zBGqkYElT4WXyQ9UZUK/T5WCqUDqoRgvQQzKp7k6clE9ekgPSN0ghyU+UHLeA9M8kp35yZkTM9cVdc9+D1c04HXSCmIsY0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpMwBK7mIwttZ0a28CrbCYbRYf8S0v2PFnicy/HYzXo=;
 b=ptwhZjP6jIXZVeTD8XJReEDq/i2OxIfBh19naQiXnuLkbSTW8soVLRgTXtERzEDjpwo0iqPnJ8uZHHIZDBeRw9F0rhDNc0IjV+m+tLbyQ9mI45KMKbpXwklJmZQ1b9wdSMvcBx+tI48dN4Hmb6R+BCCaTlETcUnjoXyzmNWEYhQpmTbOfPmor3GQwdmqKf69eyWeGywOBox+JabHIPtEN/M/pbnV8b5l19On+B38gfOdnhqkQB735U1JLjWFn7RCNIPiv3uWm4mTzk6pxLkN9JxVfOCrOQGxqLHMn7N6RZPDSZy+9uSbVkkA8TimEw0KPpCPo0zJzRGK+6x4+8IhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:19:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 06:19:04 +0000
Date: Tue, 4 Mar 2025 14:18:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Hannes Reinecke <hare@suse.de>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, <hch@lst.de>,
	<ming.lei@redhat.com>, <dlemoal@kernel.org>, <axboe@kernel.dk>,
	<gjoyce@ibm.com>, <oliver.sang@intel.com>
Subject: Re: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock
Message-ID: <202503041413.872983bd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-7-nilay@linux.ibm.com>
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: c57d82c5-c449-47a3-f3d3-08dd5ae47589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uve5lWy0k5sApnwQ8vCB8ajFlv8Ns3phlUshqUMTt++5v36l89X422HQxoCd?=
 =?us-ascii?Q?luya7gk56x4rWz9rdIaG7KApi3cmglXm2szYAOBRawJApDRXQz09rQgPPrMI?=
 =?us-ascii?Q?9QxfzsGxBOeOGULnrvHYGCq7/0JGsNJrKDmyDAeoH7qwy4RjLoRrHRHwzl3D?=
 =?us-ascii?Q?fpqtLpSpQhVqL6xUiGO2emCGf16YeVGJT0kn0Ehedy+u5iRdI20P6YdYHGxw?=
 =?us-ascii?Q?IvZd5Bu82Ae6i8sGWp5h8wEz9CrjriyTp4cSVB19plpsYhURgh40oPB9xyLr?=
 =?us-ascii?Q?8wZzXWQ3yxye4sR7tepXhptJ7zik0D9zsfmdNE1c5W0kpd1nY/0XwXCKBqfS?=
 =?us-ascii?Q?5FAqYVAkHLyvYcu1gm1gyJyZFLtXqaXUa5ZecCOhENww9RKwwKOK5N0yJ8Pn?=
 =?us-ascii?Q?Imkw6RiQ+8MpO//3tnCQKfE4dr0ehOoHIiaCZqwZylcAEG1IPgWpHyXettdU?=
 =?us-ascii?Q?GpHkul4WMIDgHcoigBBkG6Aj3K3lmjSkCQ9bBxMGD7wImIUdL8lDzZelFXNR?=
 =?us-ascii?Q?r3GJJ4AwRxpD/D4bQHxHH302XuxZpBhUKlQ7npTeeJIyRKas632bN9HiVQdx?=
 =?us-ascii?Q?sMBs/WwvORXSDYGy/ezF53wiBpRSSIDc4qKI98tN7tkrD/or2rPOfsvKq1V2?=
 =?us-ascii?Q?6HnSbp8xWBA8BLqkH3AC8UkIZQKFaP9ePrsr+dIGTGglmxCdtODDt3ORpYoN?=
 =?us-ascii?Q?HP0gBorVxc1r/xAy+B4PVZYdf7TcKEvAx4gqSD16iy8TmiNkLFoW8fUcxABW?=
 =?us-ascii?Q?yiE1tjGpNMa/XCkCEu2S2m5HqQpyobCTDmPKozjqrm1MG/z54BPhXzw3Evwp?=
 =?us-ascii?Q?BXZ9kHDqZrlF/ql3xP+3VOPowl/tGB+R/mAqcNR5gqm4fRKGzYCys5l0sIJ4?=
 =?us-ascii?Q?no7pflESDk1DCYk0csXw7na97bAR0SPAoni83IzFVVuQlsWQycIpZHlta076?=
 =?us-ascii?Q?GrDMzvdaYtjqqJw+EWK/5E5aG5nPB3Vcaol9FfB2UdGD79Mq0y7okGBBUtvT?=
 =?us-ascii?Q?4BBQlMSaN3MSRvjniisiknn3ERKQnlg88DSScfo4ay8+CjNpdHoNwJVdOoms?=
 =?us-ascii?Q?oCPOFOjuwUgVWavR+njoQpKBgZ3OhYwcOgGEChzyLnm8oQbB96DubhNuCof5?=
 =?us-ascii?Q?zM86Td9/UvVDJe88brGE8JKOjWg4ummzN51AnIthRk2oaO5Yr/wqhG0bfKMV?=
 =?us-ascii?Q?OS6I22ZJg4kBjExUnNlPO7NBprot0BEwVb8zNqxRwv/h5uwRXhVgAgZS9cvB?=
 =?us-ascii?Q?S/TzEZQsX1rOtLR5/gXWUkqUKN3dIVNCTJASkfL/L+W3dwYRX5+Vyj1Uj5c5?=
 =?us-ascii?Q?9AKMqd422kyHVvefmxQQwzqgPCgavXffDZeLEoomgIaOEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0mAOtjWgpmL0LPblIcPsN1EDSKB/8rynS43apLOSra1dCJqLxQJM+Oo6kAd?=
 =?us-ascii?Q?l5JAhDwZtDnoRtbIy84WY4uC5EzexXbSQcLZselqA2ydXeFsti5dkkXJTfrz?=
 =?us-ascii?Q?JZ48MFuvNf7gDP0zOU+wyToQOCShsQBuHPBtJIHy/48RF9OCaavGHdC2lZsw?=
 =?us-ascii?Q?oxNR+53GxuFbdEKCUj7++h9XjXqa4+XhwrgO4FGAYg+U+05CRMg+j/c1zuxA?=
 =?us-ascii?Q?RqZg5w7lX9K5RbXjkrQzMx2g+/I1fcYJRMzp457e6RVPKoUOxtcTCECyIouo?=
 =?us-ascii?Q?uhDY8DY0Le+ugrSkJdnvQLaTjVOMVmOanL0oUjqhzo6/a2v1LeIQGc8MZky9?=
 =?us-ascii?Q?BbNIeLSaGRy50q/qGqyGFnOXYYHvI1/bH9lJaB5t3mpJTkl5SkfL0Z3d3nTQ?=
 =?us-ascii?Q?v+v1GgtHI6qwpTMt+YsnovZQk88uOa3pqFnxIsdMdcOwJOG8PvEWuGz/ZcNv?=
 =?us-ascii?Q?WAtaWxNudhZ28uO6a3ZPr0MPHrb4hVQFiW8Csde4rUyULciC40ushL+sSyku?=
 =?us-ascii?Q?He7lLM0CMTGu75tqs3OtqwRPsqrusrR0pnZUaZUGJPJY2Rui44Tih3cNbHpy?=
 =?us-ascii?Q?5EQIyg/rdHUP7CBEfOnvZKm4MnQI2DOcdTXQnKfZbV/rdj6ViwOUXpPqlWfD?=
 =?us-ascii?Q?kODjhtRRGkKXS5wpRaDO0BdJ5vQaAsHrQCE2aqcf4KdOd1fA61hxA+meFK/S?=
 =?us-ascii?Q?kRPY9rzuoNk6Ma/A8RcfGMf1mmEnyv2SK3ZZ1caTbUaLvAhVXdcHptQkFL8w?=
 =?us-ascii?Q?cMai90J6rcmqIn0P72/65RsGPBfE/V/ylU1GUH5f+bFc27V5AUjYz02KcCvX?=
 =?us-ascii?Q?u82KYGkKxYOAuElfHTqZ3TRT3aBBDJC7jD0OQEr53T5jlnakqjm4BcvDosNw?=
 =?us-ascii?Q?s7DL9poc3HoyaLfsZZUNka35qwoh/HI52Z77hDcKDqd0cQBzhDqaXJkyMos8?=
 =?us-ascii?Q?7MjvcsUHhO/y/iv65ADi8XibnzZ/lbdbmSYzNWXBAVEh3kheifsbIVrYAdQ6?=
 =?us-ascii?Q?Wm4VXsp6k+BZ5rwbq+tWckbmw7tFe72U3ih/XxWq8o4pE/ezTZVxMyFI/ES9?=
 =?us-ascii?Q?hYCuc6qfMnR2n/pniPE25KWX0FxBtgfiBBKDNsKeDx6rWPgPjeG40tvOxbpu?=
 =?us-ascii?Q?IOFu6fbm1/SDkr/cYZbSBW5oe2TK2fid90wwy3PI2eXdeqiSonSct+Nrh8/Q?=
 =?us-ascii?Q?NSmsXQ+O/ZvZLXNKWQqjTrVjDykc8mMjoGS/sIwd0mZvfdWlo9XRSlhjj17B?=
 =?us-ascii?Q?fLW97S3pdv5gKSc96WdkOOdiPblKz0GWg1tGAWMMzX+bE8lk9yGwZbVCtPKR?=
 =?us-ascii?Q?Tzyfs6GPiL+vgwHRFuY+k5xLEiBgY4ac2CIHg89+BLwiTJXH/MD0dyNu4q2F?=
 =?us-ascii?Q?kR3UqXbvGjToj8F1o3XtdOimtSkfC5HTx4VbR7GqIXwbkPoeT4khV0D3Z4Ir?=
 =?us-ascii?Q?3sbc4w1v1we6ik8aEJsO1kiCRvh8266GYbqpGuDmqI6yWVdQQNaxQRtiBCnI?=
 =?us-ascii?Q?+tpIdg085h/5yJciz+/mZ5vkWzUxl/9fKOx+hQSooNtp9osm2oud4f3HnmSe?=
 =?us-ascii?Q?OIj8icAjhySsrdJj4sDnlBALZTuAQFiEGwfW8/RSdMIqLo9RZ0YvHinIW+Sm?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c57d82c5-c449-47a3-f3d3-08dd5ae47589
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:19:04.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY6F2IEn964ZdIf4iGffbJaRHzPEj0mWGUqmtUnbklgu0Z64g1wtUASjeu9cMs6DtMxcgwaIurOayM74u6D34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: 2951441c42530952368c2bae7190ea8779b2385f ("[PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock")
url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-acquire-q-limits_lock-while-reading-sysfs-attributes/20250226-204836
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250226124006.1593985-7-nilay@linux.ibm.com/
patch subject: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock

in testcase: boot

config: x86_64-randconfig-074-20250228
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------+------------+------------+
|                                        | 96ec4f2440 | 2951441c42 |
+----------------------------------------+------------+------------+
| sysfs:cannot_create_duplicate_filename | 0          | 12         |
+----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503041413.872983bd-lkp@intel.com


[   14.648633][    T1] Non-volatile memory driver v1.3
[   14.649743][    T1] telclk_interrupt = 0xf non-mcpbl0010 hw.
[   14.650659][    T1] usbcore: registered new interface driver xillyusb
[   14.658940][    T1] zram: Added device: zram0
[   14.659758][   T11] Floppy drive(s): fd0 is 2.88M AMI BIOS
[   14.662273][    T1] sysfs: cannot create duplicate filename '/devices/virtual/block/nullb0/queue/wbt_lat_usec'
[   14.663506][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.14.0-rc3-00270-g2951441c4253 #1 adcfde6e4f1dd47f52d455fb462243a4f271be2a
[   14.664847][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   14.665952][    T1] Call Trace:
[   14.666355][    T1]  <TASK>
[ 14.666473][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1)) 
[ 14.666473][ T1] dump_stack (kbuild/src/consumer/lib/dump_stack.c:130) 
[ 14.666473][ T1] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32) 
[ 14.666473][ T1] sysfs_add_file_mode_ns (kbuild/src/consumer/fs/sysfs/file.c:318) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250304/202503041413.872983bd-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


