Return-Path: <cgroups+bounces-4177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1394C817
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 03:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC0B219B5
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F28F54;
	Fri,  9 Aug 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUisiK8J"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4C8801
	for <cgroups@vger.kernel.org>; Fri,  9 Aug 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167429; cv=fail; b=SuAJ8LNR5NhhkVeEGMHx3UpweQ8T+HzCrSY0vHUGm+7UEhut6Q/gkITNdZ12O+NPfN3pjeDtkIJAnPqBjyBF6AAEU879XPysYXBmcPjmedi5wMcMUpynKcGcbLiB//Yqf3dXE2iBOwTZqGT8kn65ofZSyWzfo3vcWQJxA8ONQnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167429; c=relaxed/simple;
	bh=d+IOAv9KOEwcqCVOew72NfTpMkiVa2KR5N5SjIrBzk4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=frDlDFwVIyPcqj42iNWkZIi3hQa6TqT1W9YzgFNCn2nc9ns494wN2AOX1yddc0gJZnl/H2m0Qg+64fTBqpYZs/IU8g+y8bmvuYKm7fz147a2pX5D0c9mKu+Lu1mlYn9nU/2rt1AU9FQjoF7tp6Oy/6rvDT5kHjDPBFb1yUMF1aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUisiK8J; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723167427; x=1754703427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d+IOAv9KOEwcqCVOew72NfTpMkiVa2KR5N5SjIrBzk4=;
  b=OUisiK8J3A5uEjsRXz3xyd/E3DAdnZ2C0sADovIqJUXWAun7j8hFiyLa
   EGDOlKwCcIk6mxilWQcsBEvi3X5t28px6jTsJxNw/N0z5fNaaThIb9Q9I
   EkZvmrTGayZrbzXX6eOWUahQkoZjLpiNUdStSTVx7xq+ZY6zbMsk0VkAe
   AcQiuUnX+CSznG8Bhzzsd3yaaNApOfupD67jZkpJpRtv09osBpYTGIapD
   lZ5kQLWbGWfyRdoKx503e0z0dNs+W2iV3WLQM3GLZPw3+qEe3qUL9zJUT
   O8ejqbyo/6zFILMSMYnvNWK2gBEkPKRK3rRbrg+pBNNex8/Pw4BEGaqVr
   Q==;
X-CSE-ConnectionGUID: 1BWSM1zxR2Wdek70q++8rA==
X-CSE-MsgGUID: Ql6XtYuzRfW4vX3HKxsZIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21485212"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="21485212"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:37:06 -0700
X-CSE-ConnectionGUID: e5HioqhUTkOTraUXKD1KcA==
X-CSE-MsgGUID: eJlDst5TQG+F81+sCfHG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="88288003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 18:37:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:37:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:37:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 18:37:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 18:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQBxh6uBuCmc+DXN9FR8J9W4396MCaiqGSGH1zg40VbII9S3tGLT+Q96amTw9gnO1394vdbwOmlILUp0fqCx1sBQOVnyUAPcnGbKGVL+aso7Fis7/iZ5BEg9YrP/4nJr86ZqcqQmgmr0fg12wUaVorJfak/om4ELUBrBQzgDA8pN/o0W6BTqQyT6sb1q7aiiHvbca13NDn4qwo2vF+XeMN+oMFz5a5Vbe6xsDX2lYOsYGOeOCpuiolm7leZUE3BTCHjhaMj5zDpIawhmZs550t/msNiOjuhKV6/ztUKf0iUa0nxcaJqkT739chu9ji24eLbSwSIWWebUV/XgG0NQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kElBXF2blLpS+4vznvxwumPnF1/iQVStsnO8jHgnhFM=;
 b=fNL22LXo631sgRy1Vsg0W0fexgmawJy+NEsoQBrOnQ6Jk2qGxTrwDCEpA+JwE0opoo4nZEkRG31+mCZfBfmeBOGxe/9FfAlxNemuglpDkff1sBYs+o9Pu4/a+DZKboiYrELcnwC/lCIwq+jjdkUye5bhn2durt7GnNNSEobHpm5eIbIbCh+1jCrX/1QbXYx77P8jlbTD73jO98hoedT/NA9Et/e0j6P9n9MdXtY+TntOooPqI0ApIYGjDxKSc5xCog6GwpA+WHBmRoCo4Jy2WvBcSEKYuL/0mSHJq7rYhZTbFSvMdQEkBy0vI2rmg3nEhOxzmSBwYkjil7Sn0Q6DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Fri, 9 Aug
 2024 01:36:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 01:36:57 +0000
Date: Fri, 9 Aug 2024 09:36:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, "Kamalesh
 Babulal" <kamalesh.babulal@oracle.com>, Michal =?iso-8859-1?Q?Koutn=FD?=
	<mkoutny@suse.com>, <cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [cgroup]  ab03125268:
 WARNING:at_kernel/cgroup/cgroup.c:#css_release_work_fn
Message-ID: <202408090947.ec19afd3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 482b131b-fdaf-4570-ce9f-08dcb813c167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dsuNNW6VjBwXuHVypSka72UAHu573tQ99u55+emZTQKt4pHQsfEg+9n2Cd5j?=
 =?us-ascii?Q?zEa2GzExRWBdK71WMY41hi04Lf6Xj9POT+KeXHf28ExCkEWaN2iQJLt3CM4I?=
 =?us-ascii?Q?GFHO19AwNWpZm+DvEEnDaTRCtSrNC1lAvWJ8xZ1zYk25qbPK8ud2ZkNP205o?=
 =?us-ascii?Q?P8xIMM1VXECyL8l/IMQ2kOjcrge0AXVNPgQtKkoP3V8FuFaND7wi6HTyrlUd?=
 =?us-ascii?Q?Hm8lqMLs3uPKLhkJLTotBrbwYnLyM3vLTg29LFFidwwATlRBfwldDiTxJ9bQ?=
 =?us-ascii?Q?oXU56+wHAcEScTWnkD7OFyOPRmzhX0uzUZWQZ18KIXG41nIBkQYOqvNVqjgt?=
 =?us-ascii?Q?pVC67JNbAdVaRrxuso948FzTyPi/OAi61JRx5gosjabAiLBp2sEJSIjRGFiJ?=
 =?us-ascii?Q?R0gMYwTq5y7UVShnTCIikevkTNhZvBn0xDxXnJEigUu0htTz3xa9xhxSehCo?=
 =?us-ascii?Q?82/OuN6PUs2pVpefsGuJ3N83stwrihe1iNcnhLGNmn0h7pBlib3cjpeovL66?=
 =?us-ascii?Q?VX5mb4bQF6lOLRDQTijxc7Q/jh3YmIaAZGIA3s3hV3ydygK8ehAfFeICyrf2?=
 =?us-ascii?Q?LYZ8bCczH6DBpGYw5otRWA1fi3Tu8kLb3tvilYshOzP+9I16Fx5+ux7DF86+?=
 =?us-ascii?Q?/l2KBj+DdgwmHpDfqAJj6RbP24kq+SSsQ2thbSKy106FSXTil3V26whWm7mt?=
 =?us-ascii?Q?tDr2bn35wzY6dhonrGquYP91rvp7MJpWvebowy9jhnpFMakWoEJg6ydbsRiT?=
 =?us-ascii?Q?ZitSNewOlOAInjjKh4ZV7RQxxYIPgJqGrLeuTcN483RbO/zvcrvU9ZFYwvCr?=
 =?us-ascii?Q?3Z893nICoktlCsNlDUxutRTkTacUvqlZ1qOHrgxO1u3vcXKhY12MGtmE4SiL?=
 =?us-ascii?Q?GZVAlRJaC+Zxj9ySKKY184pV68yHPXtZEX/f/8EBB7aKiQF2IlISHGHOdPQe?=
 =?us-ascii?Q?BzfdwBHZJrw/owOcpJASaO68+ge35hDo+IW2T9Nm6vhG93Mdgi8doMxpmiYV?=
 =?us-ascii?Q?bv3nw+7X8sWOg/dgVzPbgUjX33mQ+QZQfAmaI3i36O2ZaGz3TfnlnBtsEIyc?=
 =?us-ascii?Q?5TUt4x6hT8jJ+C3tO3ZgjRFhM/IMayksBLxL7c1MTTMe/XVMNdjeSlVDMIFl?=
 =?us-ascii?Q?8GGckiYCf7TDAZQVw1f70eb/XPj/rs1gw2V/6dz841U+gm/jruX6szb4AINx?=
 =?us-ascii?Q?8ONqgXHvkfJ0upZ7SumeuQDuE9zPuQciqUVTF8wvw1B9bUCe8U8z8FXZqPOE?=
 =?us-ascii?Q?ElxAe7Py7tVza9DtEJFR0qZc4F8JtlZlKPweM1J+/x3esTf+0wBnV8g5KTSy?=
 =?us-ascii?Q?zls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmXD6AG8Tjl0j7TYlnpxJoBj9Jmj4LDNVPFhyVI4GKr9ZM24EHjkfvciI+rC?=
 =?us-ascii?Q?pAYu9tDrrK3+m0D0VgNf9EAobL6GEPzX4cczNUhvlvbv0fvnXQXTPwxG49uF?=
 =?us-ascii?Q?iE7D62WsI8NeopML0cNN8YzJZLjmUzD8tSpSPIS7vPHlxJqAWDci2q6RfeOi?=
 =?us-ascii?Q?cUURPSTrfd4T7/8zOcKLkjD1URQBjuYHr5TC8clp/efu3sQbJas15VH5GJH2?=
 =?us-ascii?Q?KDsbIGAbJH5Q7AOAAgezT6vz28AgFGGtDSceE37K59wGiYADV0uGedc8Tff2?=
 =?us-ascii?Q?DCu796niQlQvj2jGQPwhd8zwZ8pXgRU70RcuhtJ02AWLAnyO3BOmbYJj+N8M?=
 =?us-ascii?Q?RDk7N1aihSOtK9vgQCDkRmZyo2ckLVP5plFRgSS6YJ3stCUKZX0VsjApE5G6?=
 =?us-ascii?Q?BTrtPOZXpjPCfdKHq3QNoxWRfUmDQNNfPeL3qj1Q3QeKmjKJ0hVL4uppuVJC?=
 =?us-ascii?Q?USKBS+ASDZ8pT/PuHUEfGmegwG9UMc4DnNrXRxw2LPjXL3MdthqRGh9DrLPg?=
 =?us-ascii?Q?EmNdsyH9NdT0mQ40S7vRJyzJrnp9RRzXH4rRTABXWYuRaIHk0BQUM/NQAL1V?=
 =?us-ascii?Q?1OKOy2j47NLt1oKXHDug69mljm2aswzk33FGxs7Qed5BZzyQg4suJoGYCqlu?=
 =?us-ascii?Q?6yTd0G+dB6zF4+R4j49Pa595DpuWvoB4ULCGFBpzC0x9XsFb+k0a1vI3rTQM?=
 =?us-ascii?Q?KaZQ7HMlyAF4vmsY3GZoleJFaSLsSXLciV93BvIrhC0vHGDq26G1ZPF5vFNM?=
 =?us-ascii?Q?Tp+yRJa4cwxuvnzToFjQ55gfoFTCrWPTDd/P7EgLLpLWt8BBcwj60vvaDJ1P?=
 =?us-ascii?Q?jI9UdVDJ3vCaC4vd78IxJAQwrl/4zdpicbU9vdEfIWWPoqPYgC/1HGKi5FMO?=
 =?us-ascii?Q?JKeT+eDGrmFWecfkvdN3eqXyx9v2ZwvADJ4aBs4xMCFZjSycaCt1RCKW6qv0?=
 =?us-ascii?Q?wVOK4NwbUfCB7Gt2P/gtoslwl+cEUFs+qI34LE7BzU8K5ehgTnxV8jW9E/mT?=
 =?us-ascii?Q?6GME18mwl74rnPxHr0PbseAypWmgWhW/MWXSZIPjRRXrxI5ldeEKTmsjBe82?=
 =?us-ascii?Q?EfGCJymBrcbSlSqqjHHv7U44MiNFBXoZr17Jd+6ba42ctaDkOyb6fCVDyw1r?=
 =?us-ascii?Q?utBn6ff+6ThM6b5uMVkkiatcJ9b1c7t1+m2/Xj+2ss8hqYWKuX8fnB/RYwHf?=
 =?us-ascii?Q?/085KvYUJy0pEU3bmOABEBYt/52FJRfQTmP1L68SHHIHawfTf1vQTzhodU5E?=
 =?us-ascii?Q?B6ZaHQAJXXDHAL+UoNNt7xIXapwyvPAVqqBUYaCJECyYK8fgJqyVEwGFWCNn?=
 =?us-ascii?Q?fDH4uYV6v5CHktUYWS7fX0BvUGqVXNRQLam2mx3ZzFov3mZzwQYgmdpevM1l?=
 =?us-ascii?Q?8wgSXfobS6+v5VbCC0UjohuNAaGbJUs3LCvmWq30Vpy2prXqkcWCnmjdckkW?=
 =?us-ascii?Q?MRQSoHt6mJcke8xHaiKvD/io18K0jOnCSrrvknB91MKUkO/HnOCu9OfpNYVb?=
 =?us-ascii?Q?FRhxYNdq4pODN6VPZaFVOcOtyRvhVIw9BKmv3qUKWXJYjkjTs5WB7E2c969B?=
 =?us-ascii?Q?Pn85fqEsl3jxvn60KNn3s7mkL9IgMn0sIFAC3UnBbNjtZOCSlsHBgaMCzZAB?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b131b-fdaf-4570-ce9f-08dcb813c167
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 01:36:57.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+dQA5/BnWKnuNCWHHR4BJ9My5a4qtPJ5LqcsDX+dGudvaARP+wv1rxSsKrKloCzKlG8AK3m4WVJmz+Nr4BwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/cgroup/cgroup.c:#css_release_work_fn" on:

commit: ab03125268679e058e1e7b6612f6d12610761769 ("cgroup: Show # of subsystem CSSes in cgroup.stat")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 222a3380f92b8791d4eeedf7cd750513ff428adf]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: cgroup



compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408090947.ec19afd3-oliver.sang@intel.com


[  329.344633][   T27] ------------[ cut here ]------------
[ 329.352806][ T27] WARNING: CPU: 1 PID: 27 at kernel/cgroup/cgroup.c:5468 css_release_work_fn (kernel/cgroup/cgroup.c:5468) 
[  329.364374][   T27] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 psample btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod kvm_intel sg kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci intel_wmi_thunderbolt wmi_bmof libahci video drm_shmem_helper intel_cstate ppdev drm_kms_helper mei_me intel_ish_ipc i2c_i801 i2c_designware_platform intel_uncore parport_pc libata i2c_designware_core idma64 i2c_smbus mei acpi_power_meter intel_ishtp intel_pch_thermal ie31200_edac parport acpi_ipmi wmi ipmi_devintf pinctrl_cannonlake ipmi_msghandler acpi_tad acpi_pad binfmt_misc loop fuse drm dm_mod ip_tables sch_fq_codel
[  329.438923][   T27] CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Not tainted 6.11.0-rc1-00007-gab0312526867 #1
[  329.449669][   T27] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[  329.464003][   T27] Workqueue: cgroup_destroy css_release_work_fn
[ 329.471393][ T27] RIP: 0010:css_release_work_fn (kernel/cgroup/cgroup.c:5468) 
[ 329.478404][ T27] Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 73 04 00 00 8b 8d b0 00 00 00 85 c9 0f 84 b2 01 00 00 <0f> 0b 49 8d bc 24 10 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	fc                   	cld    
   3:	ff                   	(bad)  
   4:	df 48 89             	fisttps -0x77(%rax)
   7:	fa                   	cli    
   8:	48 c1 ea 03          	shr    $0x3,%rdx
   c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  10:	84 c0                	test   %al,%al
  12:	74 08                	je     0x1c
  14:	3c 03                	cmp    $0x3,%al
  16:	0f 8e 73 04 00 00    	jle    0x48f
  1c:	8b 8d b0 00 00 00    	mov    0xb0(%rbp),%ecx
  22:	85 c9                	test   %ecx,%ecx
  24:	0f 84 b2 01 00 00    	je     0x1dc
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
  33:	00 
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df 
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
   9:	00 
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df 
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[  329.499252][   T27] RSP: 0018:ffffc90000337c90 EFLAGS: 00010202
[  329.506527][   T27] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
[  329.515801][   T27] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88886dde0288
[  329.525032][   T27] RBP: ffff88885d2ee068 R08: ffffffff85688cbc R09: fffffbfff0f10188
[  329.534328][   T27] R10: ffffffff87880c47 R11: 0000000000000040 R12: ffff88886dde0000
[  329.543601][   T27] R13: 000000000000001b R14: ffffffff85688c20 R15: ffff888118c08020
[  329.552847][   T27] FS:  0000000000000000(0000) GS:ffff8887e3680000(0000) knlGS:0000000000000000
[  329.563170][   T27] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  329.571124][   T27] CR2: 000055f6ec637108 CR3: 000000087927e002 CR4: 00000000003706f0
[  329.580442][   T27] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  329.589740][   T27] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  329.599048][   T27] Call Trace:
[  329.603695][   T27]  <TASK>
[ 329.607990][ T27] ? __warn (kernel/panic.c:735) 
[ 329.613444][ T27] ? css_release_work_fn (kernel/cgroup/cgroup.c:5468) 
[ 329.620132][ T27] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 329.625961][ T27] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 329.631620][ T27] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 329.637638][ T27] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 329.644006][ T27] ? css_release_work_fn (kernel/cgroup/cgroup.c:5468) 
[ 329.650668][ T27] process_one_work (kernel/workqueue.c:3231) 
[ 329.656971][ T27] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5727) 
[ 329.663388][ T27] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
[ 329.670157][ T27] ? assign_work (kernel/workqueue.c:1202) 
[ 329.676137][ T27] ? lock_is_held_type (kernel/locking/lockdep.c:5500 kernel/locking/lockdep.c:5831) 
[ 329.682560][ T27] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3390) 
[ 329.688584][ T27] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 329.695127][ T27] kthread (kernel/kthread.c:389) 
[ 329.700585][ T27] ? __pfx_kthread (kernel/kthread.c:342) 
[ 329.706591][ T27] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 329.712434][ T27] ? __pfx_kthread (kernel/kthread.c:342) 
[ 329.718451][ T27] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  329.724624][   T27]  </TASK>
[  329.729125][   T27] irq event stamp: 179927
[ 329.734853][ T27] hardirqs last enabled at (179941): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 329.745845][ T27] hardirqs last disabled at (179954): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 329.756837][ T27] softirqs last enabled at (179968): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 329.767923][ T27] softirqs last disabled at (179963): __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637) 
[  329.778925][   T27] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240809/202408090947.ec19afd3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


