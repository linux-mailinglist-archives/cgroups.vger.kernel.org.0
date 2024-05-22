Return-Path: <cgroups+bounces-2980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F618CC358
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A177A1F21285
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAE17556;
	Wed, 22 May 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pdx8U0Xa"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C078134AB;
	Wed, 22 May 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388693; cv=fail; b=ahucL93yfBYYeeQYPo2kb7uA87eZLaITPR2bxc7aTLP/wVBnfv204GkzNdIRNJFAQR9YtViGseUkaRddfKIHx82mAS7s+6LT6buhKXXayDTdnLrAfwMPzINklcas696T/TNkg7zwZcZnGkBiX7TNwF70NE+ZvORqzhgLxBWIDYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388693; c=relaxed/simple;
	bh=NaiDaKM3n2IX/Cw1nJrgTIRmkEf7UssXcbWEKjZPeWc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pqvdIhGdwFL/L6c5LbZ4IVeNW6vR/L5A0DyAkXe6+mhFT6yP/kJUyx1a8F8p7DRoURoc1TySCW9xCES/P/RLaxMXMltUjX+VZb1sEOrUpqeD+WcnqLUniH2dDpAMdci5FdnZRZPDdJtoCRxdbtEgHgz+S7+WNl14LQ8hL6jBZhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pdx8U0Xa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716388691; x=1747924691;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=NaiDaKM3n2IX/Cw1nJrgTIRmkEf7UssXcbWEKjZPeWc=;
  b=Pdx8U0XaBK8GzNAO2w9n9j3C8VwdBUeopBdvGH7dbJf+X61lI0bVFv7x
   m0DHAwTTpYMMSKgDzb2wyfEGJnOZNqzr3pzyoe3iIl6u5kNyMxTzvGQd9
   ZLB4HtgJPVnOgWelkMxWl34k0itRweICo0Sy9EwxR5vhWtpPWRD3B1tqc
   jJe4nrb7q2TmsfFDeVF0Y5LDaLO7+G+SDUIUsrXKC4lIBkeKcrojVwaCf
   Sy//oo9AX1TwiHcVh7BbT59z5q/wmN3GYBnqNeBw3kV4qOf8viePjtNoV
   LTAo5xRUTXnGFxR3m6KORMjsZnfaGCZek07w6MqSjQxy9fG8wAvl89AuG
   A==;
X-CSE-ConnectionGUID: +v/+Nad/RZCgaOo3X2cM3w==
X-CSE-MsgGUID: wbRTli9IRvqVoCWQSoAknQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30177140"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30177140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:38:09 -0700
X-CSE-ConnectionGUID: GkYbdPKbQI6Lsp29C67IJg==
X-CSE-MsgGUID: 8immf/OnQpGrvHQSIhqoHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="64149755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 07:38:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 07:38:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 07:38:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 07:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipluf/lnlw4vM4jvlMrjXxtGLotdmZPBVa2SD9XnYv9gkjFZbRouBHmJiQhlE+l7YT2cJWgXppJqg0m677snZmXBhz7KZMua3QirI5lTLsIJzw6JR55JBOmdfNfayvHrqyRGWJP7hD8TeSa9rwr7QJAt5j2K+4E6/HOCeLiBDmFfh+4E4kcFUJ0RjuiAM8PkRtFHWeJ2jBORRBrblcLF0i3LeDzLjgQQQs66NbfdeN4H9mSknj3UQNC2AFU7Rc1S0cI9lh0YJHzf8y1PwiA2J8oakDjNE4Se0o/nnkCjti6F/hpOJAGm5f80yltbNrnqFchY2gJVvpNjz3xiL7O9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNEcUWta3Fhyx6KWBGQzY6m/1zzAhJdVL34AqvDvZkE=;
 b=cMWVsMThhXoOALFVB3EqfUBCmX/ytnl7AeokilIVZGY9exGEVe+OPZ6OlROuCrnwJPy+PcFI+95S0NIzBoWvFblSkMKtGomqkfLYhsez+jXLhM3Ut8VTzs7AWpUs8f14lNudxx5bMlO/71pFscgGLaxnRsU7/l79DcOc+rYYp9fX0KZ/RsQ6mOhPWnAg42FHwYwxniKfEAqdwZ7qYrCD4D7x0OsJQlO2CiRUvWBkaLGO5W7bRyNNDIO69ekm/OQPB7glN8DAFcNDFaztI6Cn0JCjuBnQi5/I+fKwQE5t6WvATQ8y0tf8bd+6GusalzFGdliq04vODPb5LKpS6ysfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 14:38:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 14:38:04 +0000
Date: Wed, 22 May 2024 22:37:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [cgroup/cpuset]  2125c0034c:
 stress-ng.cpu-online.ops_per_sec 17.8% improvement
Message-ID: <202405222215.d537a85f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 584a96d4-fc19-43ae-91ad-08dc7a6cca0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HazbhCaQbqvN9E0jbtv65yLwUoyo/EqlBH7rKVPvNtQC3n68NHW53O3ogf?=
 =?iso-8859-1?Q?daA7e9A8zgt/GaIq7S49xqjDYwB7owm+PgeP2L6RLOjRMJxHecMb6IVr5b?=
 =?iso-8859-1?Q?p3kUXX0jJ1F3rQD/s5/MpdhWrX3xuYf5Fuktk5iWK2vWO8XydLa14TRKUg?=
 =?iso-8859-1?Q?ommYT6CGHT5uSRJHAArTAblt/TIsG7WEab9aA/qcIlV8KVrZnosC+2X1sD?=
 =?iso-8859-1?Q?piVTmBbTNEEfXqd42LPHeKV6WiAri5ApKqzRgzCrYMfOW+wWMqcwJZ1NsP?=
 =?iso-8859-1?Q?xTF0T0KNrfdsoJOgS5LVEPfh4c5NrZcbLVAr/S4AyfPNP9lQxNVO/HGMSn?=
 =?iso-8859-1?Q?TQyJCAPwlCeLgBiBDDGMM/fhT2dYahMhljWrZ30ripl/wkWu/GxcYH8sLf?=
 =?iso-8859-1?Q?vByKohpXJdertnPet1SLVNE2Qi0fMhMC9Q3Feaq0yRoe1vfsgE22/aqrNo?=
 =?iso-8859-1?Q?gLlGWqayV0UPl28B2l03OCri8X7R9LlAs5R9RBhpH4ChYJA4jxhi5Mh0HN?=
 =?iso-8859-1?Q?OFZ4TryWErzoldMIBnJg0Z/HDoZkPLv46uEVORVRfKc9bxpiQFvlkFrtks?=
 =?iso-8859-1?Q?zQqCNWt2gZZrcscQG9a+2bj43ODhSCR2aZUKW79O5rWcGVR/5VTDhlm4bi?=
 =?iso-8859-1?Q?Ic0SOyrb01y3v7mifBnkhBIKOOC5Th1dz3rYSYyIlTHlLUIcVohfvtRlZt?=
 =?iso-8859-1?Q?uY9rxAeubW33xY/2jZQ0Ev1+oAE2bXT0iflffHRh1/lkhCDQmxW8rN0RSQ?=
 =?iso-8859-1?Q?mUg0L/cZOhYI7IU5NCHEVqjKiQ1gpZ5kGP3+CVkb5lY7QXWK10eY5kAQ2s?=
 =?iso-8859-1?Q?Hc6UVRpWQpAvhEXkdtKEqM2qkxUTt7ILkJ8SodCqyZNE2/gAxOn6bY2lhQ?=
 =?iso-8859-1?Q?FrmpP6tGvNlxd3KqlDd33zHdAse9kAaO+0348ZuphZtCJXs/fe1/3fUqQT?=
 =?iso-8859-1?Q?VbtfcsbU2q22aysqln5yYIUfw6YoFAElE7kOF50+x9zQ1iI8G5cAK+KqW4?=
 =?iso-8859-1?Q?bSD4qjSE3BVoMlodh/+LzuLqWt2/+cwtf5o+dsuHsUNWLKPQICT8XH2kYM?=
 =?iso-8859-1?Q?dpFAQdU+mBPHeUg0Jt0ZgCo63oqvpLDdnPSH8AUnpAlO5aA8rUgVJqBCyY?=
 =?iso-8859-1?Q?EFL+VnKFdaDfc8l5RAbN1b/QTHBla5ayBFMsf3+XyAh2j4AngXB2p2n+y5?=
 =?iso-8859-1?Q?Q2oljHPGsX7woYGT6RD9AStdZGg/9uuEFWyXPJtbB5sNosecOHae2GmoaB?=
 =?iso-8859-1?Q?B17twO667LHMAFjm3ey4+ysA88psGXK3xGa5rC96o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A8mxDFRrm+OzJh09AtKnQfhU6lpfYH5/PyWapV7LZ49N9+VM9X1pMF7RFG?=
 =?iso-8859-1?Q?MhjXHs0UHRXjN0XQ3aXXMB3Tu3UmY9IZxinHdYx/IV5PZpEmxc1uqJZHyQ?=
 =?iso-8859-1?Q?n71ZB56vyFt0m6QA5w/spy+JyveZtL3byxp7Ppgjo6scwoL2ElVo73qgdc?=
 =?iso-8859-1?Q?VeisOSNt8wXbgE0V0tELhfL/YHiCIbiN4HOG3jC2cYugsRAbbOCcYWhkeI?=
 =?iso-8859-1?Q?KoMO/2mEgNMVixZT+rtM+Rb41QA341MNlbp+MRbezgtiooijLjaM53eF9z?=
 =?iso-8859-1?Q?3O15ZtZuSEYBaYEXAEgqUz1oJXgqo9Z5V39Jl4ix8LqAHsTFVPKqCZrO2c?=
 =?iso-8859-1?Q?4N/cTbGPVOw2SO7NKh1zsT/e12poPZFKtaKdTEWm69e/dUyqlvaGEyuXj2?=
 =?iso-8859-1?Q?cMpa7xHxg1hQroIDNtEQVob52i+OFRF+lw5WbLH0nPnqh7n5+4MGi+TgLz?=
 =?iso-8859-1?Q?27ttk+00A/gn+YFvLBAR7ht9KxUvC2RYEnpl7YxkUwcMQdADfbuv+4ZkV3?=
 =?iso-8859-1?Q?MH5G8teMG0/mpLZv/zQbsN1n48IMx+AYRWwD0XyqZ3J53MVf0t4q9tOft1?=
 =?iso-8859-1?Q?bqBmK2mGX1VP2ciCxf5Yx7fYnb1pSspdva2jPd2fy58UFlWgTq6d2orzI2?=
 =?iso-8859-1?Q?/XEwiDsH/XIgToBO7z4AWWSRQQad7WEj+Iy1MmajkY+piB92TieVygZ/Wt?=
 =?iso-8859-1?Q?18pWxC2pd+XoAxjUzeuMpcSAxG6T9aD/P2DGqGd+UL43J35pmpmwdN86MI?=
 =?iso-8859-1?Q?2XMCqE/E/ZJ+tsR9A7BAPd0uuBBVZBisqKaybsJFwQqcEWjUBB99xOMAkG?=
 =?iso-8859-1?Q?MGIlGQ896EhSSM/ytUZdOPgPjTfzf40Fb79a9kjiKzor1kl/DkQsP5dJc/?=
 =?iso-8859-1?Q?dCp7eDHaUueb8z9yTXnFrnDI8Ml6WJoyJ9SKTY1t0+wcOJb3IMX+q+Fv9X?=
 =?iso-8859-1?Q?Pf7uyLtQNVSWmPRpIQAr1XJuJyHFHU8XfC//3WP78BE6TirDkxYXwKv5n1?=
 =?iso-8859-1?Q?VmotGCS06bLmbxkTjj1T2+OzBld9Lo71dQvtvvCUlQCgOOEJgEVw7zhjZT?=
 =?iso-8859-1?Q?lS9sfwBtnwk3phVYR3ZgqInlkQ5zkIJ12Vc+5f68OUKwSUuIKn62dLI3nr?=
 =?iso-8859-1?Q?g+zvPej1zi8OfnKE0165h+AuMa6kjSrM8TiUy4Lc5JqA27+DgxPOuKV+B9?=
 =?iso-8859-1?Q?Rbol4NVRPUYDZnt70chif9kO6jxW4pH55xK/TCbdXulV2+6XvrZXRODEv7?=
 =?iso-8859-1?Q?VjvG0ytan7ptHeEJVIb2aVL+GzUYc0X295med2zfLztz6CNCLdkpgLF/L+?=
 =?iso-8859-1?Q?DIBKtrQrSInTwejMfMZau4hwIDEfnaM8oXUqqOFkUx3BbOEeDAXloKywy2?=
 =?iso-8859-1?Q?42mJR2iDFBwkv0v+uRrxI0v4k23SueB6zxGVLrzPHpLDUSLhhpYx+TDzLl?=
 =?iso-8859-1?Q?aqfrdguMZUQxmKDD2XQaHkMf8PhkV2s/+a2ldU1FV8raZanIkbaCef4BB2?=
 =?iso-8859-1?Q?FMglL2zDI1KVoXNyvDGgcYCXRZO7psbrVFX2JZis0oEKC2f2AZ6rFrk10K?=
 =?iso-8859-1?Q?d1Hxv9fZbSCp6yIij/3+kDq3VnKxISLheEW6I51C0oThKBFRFlq9dzDoAx?=
 =?iso-8859-1?Q?QHHFxOpHQHOvs8QgWDHNHnqCFSaOFXBz2VMhRYdcIJFrwcznUgfiQ8sA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 584a96d4-fc19-43ae-91ad-08dc7a6cca0a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 14:38:04.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev81BIKOv7vTQXA+MxE54R9jj+p5edi3n54p/RSxrhyT5nkhQrw4N9Pn0tzXp+RvF7bbbmpR+P7LxitF+XZhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 17.8% improvement of stress-ng.cpu-online.ops_per_sec on:


commit: 2125c0034c5dfd61171b494bd309bb7637bff6eb ("cgroup/cpuset: Make cpuset hotplug processing synchronous")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: cpu-online
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.cpu-online.ops_per_sec 13.1% improvement                               |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=cpu-online                                                                             |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240522/202405222215.d537a85f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/cpu-online/stress-ng/60s

commit: 
  4793cb599b ("selftests: cgroup: skip test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate")
  2125c0034c ("cgroup/cpuset: Make cpuset hotplug processing synchronous")

4793cb599b1bdc3d 2125c0034c5dfd61171b494bd30 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.751e+09 ±  2%      -9.7%  2.483e+09 ±  2%  cpuidle..time
      4.07 ± 12%     -20.6%       3.23 ± 11%  vmstat.procs.r
      2.87            +0.5        3.34 ±  4%  mpstat.cpu.all.sys%
     16.83 ± 37%     -68.3%       5.33 ± 64%  mpstat.max_utilization.seconds
      1130 ± 23%     +72.3%       1948 ± 14%  numa-meminfo.node0.Active
      1119 ± 24%     +69.2%       1894 ± 15%  numa-meminfo.node0.Active(anon)
    280.28 ± 24%     +69.1%     474.04 ± 15%  numa-vmstat.node0.nr_active_anon
    280.28 ± 24%     +69.1%     474.03 ± 15%  numa-vmstat.node0.nr_zone_active_anon
      0.03 ± 63%    +202.3%       0.10 ± 65%  perf-stat.i.major-faults
      0.03 ± 62%    +200.9%       0.09 ± 65%  perf-stat.ps.major-faults
    171.45 ± 14%     -25.8%     127.20 ± 17%  sched_debug.cfs_rq:/.load_avg.avg
    116.43 ± 10%     -31.4%      79.84 ± 23%  sched_debug.cfs_rq:/.removed.load_avg.avg
    319.20 ±  4%     -16.3%     267.32 ± 10%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    111.20 ± 45%    +114.3%     238.25 ± 32%  stress-ng.cpu-online.millisecs_per_online_action
    516.50           +14.8%     593.00 ±  3%  stress-ng.cpu-online.ops
      7.72 ±  2%     +17.8%       9.09 ±  3%  stress-ng.cpu-online.ops_per_sec


***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/cpu-online/stress-ng/60s

commit: 
  4793cb599b ("selftests: cgroup: skip test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate")
  2125c0034c ("cgroup/cpuset: Make cpuset hotplug processing synchronous")

4793cb599b1bdc3d 2125c0034c5dfd61171b494bd30 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    -13.50           +34.6%     -18.17        sched_debug.cpu.nr_uninterruptible.min
     59969            +5.2%      63066        vmstat.system.cs
      0.54 ±  4%      +0.1        0.63 ±  2%  mpstat.cpu.all.irq%
      0.17 ±  3%      +0.0        0.18 ±  2%  mpstat.cpu.all.usr%
      1678 ±  5%     +13.9%       1912 ±  7%  perf-stat.i.cpu-migrations
      1660 ±  5%     +13.9%       1890 ±  7%  perf-stat.ps.cpu-migrations
    479.33 ±  4%      +7.5%     515.50        stress-ng.cpu-online.ops
      4.86 ±  4%     +13.1%       5.50 ±  3%  stress-ng.cpu-online.ops_per_sec



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


