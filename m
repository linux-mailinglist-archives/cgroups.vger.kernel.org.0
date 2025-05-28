Return-Path: <cgroups+bounces-8368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB5FAC6104
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 07:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CB17BF04
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3461E832A;
	Wed, 28 May 2025 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb0fbPMx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506A6F06A
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408492; cv=fail; b=MTkf5xZxXGA4zxV83GGRn17M5cU7zFM9/Q+E7ygDu1hLJnLd/lHoI6AwFnIUT8QBKhff2qeGJVHZpYDeGRR1BCoSgf51ntCI+Yt9U7U4q2kXDhNupsSPMF89c07f4Rf5TpxuLqKnVkHZlmKxn8wwGncYI5+cmIsd7mX8DlDTfqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408492; c=relaxed/simple;
	bh=ZLhCICb8UoSsw3+CbFnxdaBOHsr1b7jXduoZtEsc1VE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LCll1bL0vsKBw3UPFNXE2Ssbol5Iy+UCi/4LdjWmXtidlWz586ugMg8Iq5RfsIdISngQYo/K+ACMzTG5QMjReqvJEtV9x9CLr7s12VycPb0RBpNqaFqcwTvDP/Zmb9YHW+fGKMsd/XxjKVnQ46YRS19CaFkXFhaNUVnSOrReVVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb0fbPMx; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748408491; x=1779944491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZLhCICb8UoSsw3+CbFnxdaBOHsr1b7jXduoZtEsc1VE=;
  b=Zb0fbPMxdB1Bpnsl9k1f4axab6aT2LCkU88pRfFCXv1hAIGq3nfGmTjk
   SHGU1DxoGTzUSnliH8ZnvdyHy/XET0itmJrvNmp2jhovJUJtQX5oezYJy
   /MWTCYeQkkGnWyXsYA/CLcmQYOsQHT4RX7cB+GQSwVpVZaex3dwss9xI2
   Mpz2TxC7vApX9agdxvDWUn3GjJjkTF8qy7QDq0/rWshKT7aoVi5viF9Ug
   FIlEWQyd2fKe6g3kN8S7Y5rIhfc+Wx1C/NrW9HihSYkIKWR+yLT1qOyvc
   xk5+8c/RXlrQruzRemg4TF1KmQtFb8TinzXMwGtk2tWRhrW1z1hqeg32T
   w==;
X-CSE-ConnectionGUID: 6dOfGPqBTcuV6xiXDifjYw==
X-CSE-MsgGUID: O9UwbCeaQraYlIU9vUkzTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="72953217"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="72953217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:01:29 -0700
X-CSE-ConnectionGUID: wA54XFcbR+6YiWBsx1+kBA==
X-CSE-MsgGUID: q7BeRyMUQ1qqgiBalzvAiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143562903"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:01:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 22:01:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 22:01:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.84)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 22:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ2osSSaJ6DixNA80DnIP+QGLqWw9+MSTlPJYjAipOko8vk8z2ko2cng9shHLtPzSGzXi6CA8kLVcF39lXsJSB1xpdkTw3Ypp/7FjUWipq2jcY6sjW8KUITFR2d8ZK+vILGG7cx+Yh87IW6GqPmU1K1oZ3rBPQ3UGFRE9egAadLgHgpk3lbrzw/pnHQCoUykphoqJRv53mN2XkF4SFYeJR6TG0EEK6J8lt6WrG+ICLpKyGCEJQl6otx7iLOkmdec9f2kksIPB8VWMt77KUXI0XxznQa5GSD+N8uuTAYR1awiGoQg2WMWCZba51MTHbN10nGNh1czoEIw9E0oKXvhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtdDtXswESKuUBsOLTW1cQ1WlsIoZotSwzdiF4T0EDE=;
 b=kJe+O681vpqRGAQm+y4ZMwngZrOHS8Cc2O8RSHw2PkMdFNKmsa4j5VZph6toV0Wne2H6Dvt+9oB7EUBLAiz1SVv9nujF/4JhKwZ2HbJQgNSmdYAE6m4mB87DWy+CQN3U8z0Rsm57gLl0EAQfUUbANVr3O/ALHQZcY9p9dPWzC6omyQH7oC3IBpWO8sWZQ+MzW5rECZ36giNc1Esqj0q1s4dm2DDMFDDUHu/2dfLhp7JVPOM++Ozez7GwPcSQcnRxxxR7X94SkZy1Gx4kQ7aICx8bg4D1oi+3WFnp5LPILg7PUF3Dd1ZEbbGkMV6So5lBDj9Dv2D4TcnDIqqhgpIvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 05:00:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 05:00:56 +0000
Date: Wed, 28 May 2025 13:00:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
	Klara Modin <klarasmodin@gmail.com>, <cgroups@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [cgroup]  731bdd9746:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202505281034.7ae1668d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe863b9-2570-495d-e760-08dd9da4a177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MhLSA5qqLL3qMl8MQNYVw0/ucDVHtYTbTVGxIti0vgkSy9R70du4XSmQnQ6w?=
 =?us-ascii?Q?JRNUPSkFiOwxAaoZgtdy9niN8pae1hnXTkc/lmvkSLdnmlZbb1qF41P80Ztu?=
 =?us-ascii?Q?/4oG3Z6kmodHa4ns9pP49MKoiqABON1rWWjZ3k0hQ7CGJdIZBxjVoOoWmGqk?=
 =?us-ascii?Q?2XBOwgghZ/KS9iSI0CRzxTK/hwwafxasZTwIcrhgrkacW4tTOWSPKCG+Qj6Y?=
 =?us-ascii?Q?F2sz35yx5hNOpQdig8gsDtKKcYqN0z+TUc5td5ZWaPrUawcCs+VjZPrvx2F3?=
 =?us-ascii?Q?9kHcgbTOCZUIpXpIldznGI+Vf5YBM7TljTkFvUOB6DJGLRTAXKhHlwUmi2+1?=
 =?us-ascii?Q?AuzR8m+S5DhDjkLb0zz1rBdp3ar2MQzh22c3Uc0BblGT0rg0ZvOlFEYQTjwF?=
 =?us-ascii?Q?7n+1nuKAqLWHCmpHxVVC2XwkA0hJ4zhbemRhJFbYA7ukc4jyI8xydGusqBDJ?=
 =?us-ascii?Q?VuFRLATF6LdvHyLtFcrO4DTLIoO0NLSB3KQz2P30qs8M0fBJyVwDcsi0qfN7?=
 =?us-ascii?Q?MkG2IMnaKwn4Ri5rFMkAY6EvW+zOy57zj2I1dq2vVR/u7i0y1nM9UvTYK3XO?=
 =?us-ascii?Q?kxsHY6dxFF/9XmNf+8Nj6Es2/17GKPiQALsKlwdysRgM60QY7rrmGvKoSbj0?=
 =?us-ascii?Q?2JBvdPJTnd98BXzTG2aP7Gt8BW4vPZU4tMYRWgw7I+ctXxEe/8bPlI9HtQLO?=
 =?us-ascii?Q?ySlDFKA9q7datsULMjBvdzFE/dGgctOnSbumFYPGkX+qtLkeQ3uH8Au3nRf6?=
 =?us-ascii?Q?7aZJiV1w+1pHXXBVAoaKe0M+L5/yuXLj41avlAT5vZDgvrpvgqeH7wXoT0r5?=
 =?us-ascii?Q?TWlWabBoj2aG7fIjzznuCXeWDHMGDBxOZAMudPC2k2sLe8OW8G2/pIhtuZIk?=
 =?us-ascii?Q?NIah1btSUfnF82R6rdnRtsPPLD5JhA9w6675HkTisRKhUSUedRLmzhN1R140?=
 =?us-ascii?Q?SxC2O+6MWSrNsNZf1kS9TETVDqyk/5XpYOVpHWC7AMLpHkBQ3EJ4RY3Agdyz?=
 =?us-ascii?Q?+0y+l3g0/aHD+b/rOxg3XbjRpNTfVjaK2OHDk/2YRSPP1pyQe3QO3UkAsv6K?=
 =?us-ascii?Q?8GNZMAXE47GWHwdD8UuMkMyKYl3xUaFYsHQezQHSkbIQvYz+doTNKa6yCM3W?=
 =?us-ascii?Q?cge21BEJSqFU1li7Q/tTPz7lQtsbBR9rdPKkJ2TxM8WyJPjwdzRb9aCrsEyW?=
 =?us-ascii?Q?ar9QfhjrpPHAkS41uB0/NjAl84zbnldUf5JQWamdZLy53FOK4gO3FwF0+JRF?=
 =?us-ascii?Q?l+k/SVUf2TOTyf/LBi/XVlks/TvfMcz0qUZP7jZR0Cw4S6p/I7RnFARzMEKm?=
 =?us-ascii?Q?tesTUi7uPFI6FyhPypfWraIFrx+UbkuIoAB3Cx9laCcLkzUuI8vLzibL8Oc3?=
 =?us-ascii?Q?wsANy/vodgKGmPtr9VjhU7doc3QE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTXi+3pLkrEusr1cpM7XZQS3n9MGUha5xsptiI5zQkHabNJ10D9CTq6CRRN3?=
 =?us-ascii?Q?cTkmZHINwLmt2LC+ZYh9rCDmajPFl6K2U2CEEz5sV5ciLgM0NsO6pE//1lmF?=
 =?us-ascii?Q?7tk0XFBUfwNOhg1vc1Jt2o1qRhTn3W/wAc3wr/fqetdYRGhhrXg3EFNhVzWW?=
 =?us-ascii?Q?HVus8r4qKAntTB4FjbtocZ3eVTbY8xEyMAn8eodzQfU/lcDNL0UJ69T105n5?=
 =?us-ascii?Q?j8ssGYu/hfn+xNMBMS4aHIXCrWQMLKThHcpbAmzoxEhkG0JZqMYaMlSY/Jzf?=
 =?us-ascii?Q?sO6ZUo09aoIM1+YOsqMesmKcgrnq/LiFB5eZJdSVVj73J6C3iJ1FgS4p8KEZ?=
 =?us-ascii?Q?22YodQ4ZUixCZEHLvU8Qqlr5L6x8HDrHLTGCt0BtwmBBgoma8mZVeEVUrvvA?=
 =?us-ascii?Q?0gouEXCig1I1rAolyNozFdCSr/gY/8ZgQfZEAEkEUfvf0N2NmfcfpeTl6qY9?=
 =?us-ascii?Q?wDe6Q6WjkZjOp5XLOI99nwKjy0zpplOq89X6pr+Ho+RG6xxCeqreU6EOC0Qy?=
 =?us-ascii?Q?MLiRQC89e1p7Xa7PG3epoRPlC+DlX9gaIjST2FO1gZGv8DMp/D9aXgyajvRI?=
 =?us-ascii?Q?ggtqP1dXF7JF8AqMVqpE9ITvGYZ/QuuH4Y8qaZPm/BLjhS1sgNUYCzf1OQ7k?=
 =?us-ascii?Q?IJ38klmOl5toGLONz5feu7rk1/2m2zCZIR5IGPImGx5B5QWWGUv50Xwm9bTv?=
 =?us-ascii?Q?oveE6SzEH6IR0N1nkFM/F6mDP6x0YQ1XuVqKKQ8cu7srlacaMuH2Z190jJjy?=
 =?us-ascii?Q?K8KRd+soIZlRQ44IuBaT7fU7vijnq1vljpmPr918Pw9pm7DhCTGN5luLMsks?=
 =?us-ascii?Q?cKmblyNCxBRH4RCvoNzYy6nmM/qCbdd53dg1qvAavYy6yjNkyb7Vgp/pFHig?=
 =?us-ascii?Q?U+vLMX2/d7ipOUd2xKuHaXmLlplnIEyLAvb3UgCxmjB72mIUwFeGezLN31Mj?=
 =?us-ascii?Q?nN1BsdWPSnp+k2FCZVUPooK8vzXMHhgYu81lfdnlg5o/LxzX/vUE2v6w1vC0?=
 =?us-ascii?Q?iV3mDt/wu/IpYf9U5P+ElRtzOGIhnNE3YZxHo7jipDie1HTuTPyaUwY9hw/2?=
 =?us-ascii?Q?hJ3JeVxqkzs5Tq2xED5GDwot+wlLt8Tmt0MS+l/jmWbes/pCYSbUWDj+gEXk?=
 =?us-ascii?Q?p9cq0cUZWQ4ojabqB+n2iFeBmWM9FNFOEkHDkaCap8yIs0ItQa9ABn6n1h3d?=
 =?us-ascii?Q?12myihx5gjEeqotv7VcRtf+ivB1tduRFz4ilZy4o18/KS6neNeGUmbaPVrq+?=
 =?us-ascii?Q?PZN3gAxrq8cMASEFfo3F2JatlBYjrdgOeXRGZJfbXqpmRGdet5CC916ICvde?=
 =?us-ascii?Q?KmsPLrbBOd4/nWpyS/nUYFD5f+Cy3l/Esfe0riedKrIFyHXjijFtf4r5Nlm8?=
 =?us-ascii?Q?Hp7306tIQO7XLZ4l+Msx7rtHduyUk6Opco/GwZl69wt7eBSVMy5q6PdfIy5K?=
 =?us-ascii?Q?RBuPP/cqH5M8yeiBsraHe98DNVpBI/4D8TJl1F7eQ/ueDekDtJXtAoEdYNj2?=
 =?us-ascii?Q?6L+mn/E2lTB0G39Iteu+w9akp4BZafnBz+Za1p/pVRdEN0X9oKNEdbIBJHWX?=
 =?us-ascii?Q?ggEJEGy15aC+wvJl9NcL5cYzkB8QVD1iG6m2PIFx/UPYFglGWN1C+0ecgs53?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe863b9-2570-495d-e760-08dd9da4a177
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:00:56.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQsZoPgqlMyGOL3wKnzpYPNF2NkSO6wDf/7TqTa/KK/IfGaI7u8ay3IUTWStJe1q7gAlsTabUqjsYBrxe9Y05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 731bdd97466a280d6bdd8eceeb13d9fab6f26cbd ("cgroup: avoid per-cpu allocation of size zero rstat cpu locks")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 176e917e010cb7dcc605f11d2bc33f304292482b]

in testcase: boot

config: x86_64-randconfig-123-20250522
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | dc9f08bac2 | 731bdd9746 |
+------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address    | 0          | 6          |
| Oops                                           | 0          | 6          |
| RIP:lockdep_init_map_type                      | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505281034.7ae1668d-lkp@intel.com


[    3.888181][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000028
[    3.888838][    T0] #PF: supervisor write access in kernel mode
[    3.889345][    T0] #PF: error_code(0x0002) - not-present page
[    3.889345][    T0] PGD 0 P4D 0
[    3.889345][    T0] Oops: Oops: 0002 [#1] KASAN PTI
[    3.889345][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-11173-g731bdd97466a #1 PREEMPT(undef)
[ 3.889345][ T0] RIP: 0010:lockdep_init_map_type (kernel/locking/lockdep.c:4945) 
[ 3.889345][ T0] Code: 5b c3 cc cc cc cc cc 48 89 df e8 e2 6f d0 ff eb e5 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 50 <48> c7 47 10 00 00 00 00 48 c7 47 08 00 00 00 00 c7 47 24 00 00 00
All code
========
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 e2 6f d0 ff       	call   0xffffffffffd06ff1
   f:	eb e5                	jmp    0xfffffffffffffff6
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	f3 0f 1e fa          	endbr64
  25:	55                   	push   %rbp
  26:	41 56                	push   %r14
  28:	53                   	push   %rbx
  29:	50                   	push   %rax
  2a:*	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)		<-- trapping instruction
  31:	00 
  32:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  39:	00 
  3a:	c7                   	.byte 0xc7
  3b:	47 24 00             	rex.RXB and $0x0,%al
	...

Code starting with the faulting instruction
===========================================
   0:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
   7:	00 
   8:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
   f:	00 
  10:	c7                   	.byte 0xc7
  11:	47 24 00             	rex.RXB and $0x0,%al
	...
[    3.889345][    T0] RSP: 0000:ffffffff86207dc8 EFLAGS: 00010246
[    3.889345][    T0] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[    3.889345][    T0] RDX: ffffffff89125900 RSI: ffffffff84a8a080 RDI: 0000000000000018
[    3.889345][    T0] RBP: 0000000000000002 R08: 0000000000000002 R09: 0000000000000000
[    3.889345][    T0] R10: 0000000000000000 R11: ffffed1024080701 R12: dffffc0000000000
[    3.889345][    T0] R13: dffffc0000000000 R14: ffffffff89125900 R15: ffffffff84a8a080
[    3.889345][    T0] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    3.889345][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.889345][    T0] CR2: 0000000000000028 CR3: 000000000629a000 CR4: 00000000000406b0
[    3.889345][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.889345][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.889345][    T0] Call Trace:
[    3.889345][    T0]  <TASK>
[ 3.889345][ T0] __raw_spin_lock_init (include/linux/lockdep.h:135 include/linux/lockdep.h:142 kernel/locking/spinlock_debug.c:25) 
[ 3.889345][ T0] ss_rstat_init (kernel/cgroup/rstat.c:532) 
[ 3.889345][ T0] cgroup_init_subsys (kernel/cgroup/cgroup.c:6091) 
[ 3.889345][ T0] cgroup_init (kernel/cgroup/cgroup.c:?) 
[ 3.889345][ T0] start_kernel (init/main.c:1094) 
[ 3.889345][ T0] x86_64_start_reservations (??:?) 
[ 3.889345][ T0] x86_64_start_kernel (??:?) 
[ 3.889345][ T0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[    3.889345][    T0]  </TASK>
[    3.889345][    T0] Modules linked in:
[    3.889345][    T0] CR2: 0000000000000028
[    3.889345][    T0] ---[ end trace 0000000000000000 ]---
[ 3.889345][ T0] RIP: 0010:lockdep_init_map_type (kernel/locking/lockdep.c:4945) 
[ 3.889345][ T0] Code: 5b c3 cc cc cc cc cc 48 89 df e8 e2 6f d0 ff eb e5 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 50 <48> c7 47 10 00 00 00 00 48 c7 47 08 00 00 00 00 c7 47 24 00 00 00
All code
========
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 e2 6f d0 ff       	call   0xffffffffffd06ff1
   f:	eb e5                	jmp    0xfffffffffffffff6
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	f3 0f 1e fa          	endbr64
  25:	55                   	push   %rbp
  26:	41 56                	push   %r14
  28:	53                   	push   %rbx
  29:	50                   	push   %rax
  2a:*	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)		<-- trapping instruction
  31:	00 
  32:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  39:	00 
  3a:	c7                   	.byte 0xc7
  3b:	47 24 00             	rex.RXB and $0x0,%al
	...

Code starting with the faulting instruction
===========================================
   0:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
   7:	00 
   8:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
   f:	00 
  10:	c7                   	.byte 0xc7
  11:	47 24 00             	rex.RXB and $0x0,%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250528/202505281034.7ae1668d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


