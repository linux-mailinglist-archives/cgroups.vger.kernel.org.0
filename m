Return-Path: <cgroups+bounces-3189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7903908749
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA36C1C22CB9
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071E1922D1;
	Fri, 14 Jun 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlsw+HDz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F518C33A;
	Fri, 14 Jun 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357011; cv=fail; b=KgrC610LDgKd7TZaxvx8FaYg5MEWG+o/6CXpgIOK9V3Uua7352FovSfNh56girUGWbL40jdSOQ0byZd8AJT11N9zeLaoGxktQMhq5QB47KQ9H+mxQqqhtT/DdYwpISJMLBhCRMQIEFp1/oW9ml/ag839TzH6YXCz0WxM0XNHNW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357011; c=relaxed/simple;
	bh=uKOE6V2jUdLelpFyAftT+1lgxyCrWmYBTMecP0ccjas=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=U4prz+u/RZzFmBMy4PpTnLIHRp6itjVhkvrSF8xKgUR9l+aOlQBPNfxg/PnvRdmlsCoWsgzb1npJwOCG1Bm20+aiMZn5yOi7YMLOCly2A5kFhnVlZ70XrrUFpPuVsZIqnyy6xXIlfQkk4ztUWqteWFTlEIrYonjA2MeacKuywkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlsw+HDz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718357009; x=1749893009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uKOE6V2jUdLelpFyAftT+1lgxyCrWmYBTMecP0ccjas=;
  b=nlsw+HDz764B9/CeyoUnbDD3ppOKz+zUA9ExAtKsvkI2W+iD2qFIeKYu
   Y6qQLE74+YF1UInY0vsQWaHTwFeAMiRY1mjflDC9m40VTqDd/qyxW1USj
   05VKDxum71UKQS3x4McZbR9OBcRbpzayuCgOsmbYz1IG9n4UOfwFLQgeJ
   qUq+LMFQkkpfMDCggtWJMg7dKousdbqAqcJCGIApC2zxfErAqBqDwCyFz
   wqI9Bq6kqczIrru0pHOioi1Zl+GxdjQCtF2F0d69HEYaBL0d49x0/GElD
   fl1wwBstOgUu1WWtK2lxfZmY+i76Zqkt/bh2rIlleEKm1OJUCLlqARhpZ
   w==;
X-CSE-ConnectionGUID: Btm1q55WR8+voHlZ+lxhMA==
X-CSE-MsgGUID: dpdoRlyuSUqGYdiId742Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15205730"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15205730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:23:28 -0700
X-CSE-ConnectionGUID: oSznMaQfTIKSogRL4WfZDA==
X-CSE-MsgGUID: tPGPNLKWRbe8tsqd6/9GzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44820112"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 02:23:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 02:23:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 02:23:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 02:23:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 02:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwwEJUK83kWSenOJHHYI+7q9ID+AKOL3GDDuefqFbmKEvdc3Mc8VtXjK8OMRnrIQXITtnRYGW0dINo7DMptKPjslZKbzHkjS0EOK8RtvpqhIWkf+a45WqUXcsEcYjiNml68cWlGyyI3Cy8tIECKkbq7IL3OY6Mn6X1UhIuUJHRyYi5j7C8mu7eDR3Va3b0fLrxO6H01rTXQg3vdkm6JM/yYmhURCZiJ9d1lFI2mhO71v25aJHhTrnK2HREWvqGQF7aZ1nMTswjLqp0N2cbxsKgKPU3Xx6fXd46aElWwjG8lAk0ctcOD2XrqXE5gpek+HcXzT6F+LmHSxhrPgOEROCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAwC8R7YW3Gg6v4bEwDsUxiw6rxw/0yyW6J4dVAdhKE=;
 b=CX1NcRq95goeC3TaFzQ96XpDLQN6J/gKEXxukOiGI43jAredlIVDXulIb35VYecG4qmRGlu/J7EGNOTfRCPn0kkqN8+lDDJD9qe8AsX1KPESy7tlEtJ8BdOqZr82O8OACHjXkaExXWQrZtFJ4sFrEEH55NnFUvrB8kFtPlV8gsc6PQlJwegtWgdxlHnOVX2/SKlb93zuOP0eGUVP7vUabotWcE8JEP3oaQwBPbe9Ws8HAkmOfUG8Ml5gk/W833VlzXlUkHfTI3yni3coXwE6qsn2p3ZflhEuNGyMGgCeySYXzAoZS+M+RdyyObd3vhRVNcBFeEqU+4GqGdoku+MVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 09:23:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 09:23:24 +0000
Date: Fri, 14 Jun 2024 17:23:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Waiman Long <longman@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [cgroup/cpuset]  105f3fe918:
 kernel-selftests.cgroup.test_cpuset_prs.sh.fail
Message-ID: <202406141712.dbbaa8fd-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: ca861020-f0d3-446d-2515-08dc8c53a3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K80ylcv3M4fz8fA7/0MIi9HAgHvfpTbM+wWtunBuP2jiIcufMBRNM2oB2E5I?=
 =?us-ascii?Q?xhnDvBYHFF1/Hyu084NWmRAL9uM9VOpcuGL4Vza1vQdsndevPTNdGTD1thtl?=
 =?us-ascii?Q?Zm4Za5b+guOrH9ElQ0CpGQE1Z0f5Mf/YoH13iJUUzBvHNc+jAnJwL5qZrKnf?=
 =?us-ascii?Q?5B/cMMyYShkX6B15afuS7fOH8XU4qU9Kd+Bg42KcuWXEB64nzP15puE8OK2S?=
 =?us-ascii?Q?HfgDAnYYcpfGp/2KD6Dw6ETvN/xe9jfeBwFza00rKMeUj75rOlvEuqfRjaIu?=
 =?us-ascii?Q?S7LGLDflGoHMnGpw3SZ1f/txFrtxD3CfFZejXpirR/csswNxD2MCf8QaUnfw?=
 =?us-ascii?Q?XygY4Ogz2JtAAl/j6Ou2KBQFj+shTbcTl6WreYxJMX/sTSjb2PLt4bLoSMPO?=
 =?us-ascii?Q?F3QYlcbW4AYbY1YiN/vL+DzETFkHSi6N936/ZGOnM8mNMdogtH3aGNXrJcY4?=
 =?us-ascii?Q?xPgbl5Of1Tw631RvSVkgu76XKZQTFxfJeARYnXFvbNfbJGnxyGjdwq/y80fv?=
 =?us-ascii?Q?FH2uQ86ol8JrT2LBoK/t39KN/VWY8Yu+6IvQ1YRfA3M67zU6SxdP3Z5AeB4s?=
 =?us-ascii?Q?tNdLWjIFqWskYxgfwc7Y2kXglnihNeAJ38UPFlnoIgqibJBVp84Fo7/DXsDK?=
 =?us-ascii?Q?E8dZQBs4IUCtzxI0WP1POkXSwgqiIwu9/8jOvuwkab+XCNIs+rEBTBkWobU2?=
 =?us-ascii?Q?01dvl85pzfqYK9Nz1o7TM1V6P/0zVtDiPToYvoW/b1rTQ7LVvYA4jLStBh0b?=
 =?us-ascii?Q?lsvRlOMjc6iaKFFwg+XvUbd7nCLYqCxrjQqYKmG02h4m+v25B8Aj7SkGnSp8?=
 =?us-ascii?Q?X++jemrxSz2CexsNGuOENYzIXqhCECukRLvsSjl9jSpf436/Ub521C0AjmW9?=
 =?us-ascii?Q?xkYBFAw3dhjCD19j0dKGCQGD+IC2X49y1ZkBIGtR/v3Lbe/LE+/zyxNLhIak?=
 =?us-ascii?Q?0zGCY3Sm45NmctrkSeRVedzfleTJmljrYce1CVHYHj1icOxPqfcdLovY+649?=
 =?us-ascii?Q?dJSz6/GdB2eSBwax3/jDAWH8gXQ4V3w0lBKyLftc774M1Cl/4h3T2Q+09fSW?=
 =?us-ascii?Q?lpl45aVJ22rUVtssDt5/W/YN8s9rRypct+jqiA6D3MRtgJIiiU1bla91Bf1d?=
 =?us-ascii?Q?B0vPyK0eEMs242gM32e87sPi2MfcnSfdb3fOs1RQn0cZoP5v375WLX84Lo7G?=
 =?us-ascii?Q?kR3aFre62u+546cYJByLuz8AUJFHHA3Kt9QQI4R4OYuRO1ML/MnhOAtTJDTq?=
 =?us-ascii?Q?q/POugmisf2ZHbxoHPR2c9w2qq9AItjBxNYuDKs4/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ew8BYOMEv1NXbu53S/O9ZwCw8YEJ/iwZDiCwUvxbbpfvTfHeItsPYJzBwD+?=
 =?us-ascii?Q?v1uWTmJ198ErchaYyXmN2J9umHFXH1RblaywGgG+5Me7HtzAIr/vDHAv1NeH?=
 =?us-ascii?Q?GN4XAO53HYH1n6A5uCBa6nJbLy6xLlwiPXSTBAtqEdDhV+ySpmcojLmZvf62?=
 =?us-ascii?Q?WVp4tDIGCk65p9HVnobZBTX/a8soqxvtVW9tXZiEfl4jmnsv57lbWR/0ckia?=
 =?us-ascii?Q?11pkc4JGJplfIPV3eJA2V8V97i8u9xYR3KxIc92vwoV6hVKQSUucby1uKAc9?=
 =?us-ascii?Q?KRZuCCtP9Iz9pwvXrwX3OMvHKYwX3ea1pwpaqBvpRfom7v5xg381MW78iDaB?=
 =?us-ascii?Q?wY109ZIOSKQV1Cjfh+cBpaeQlwxfDS46ySh85kmp574pdS1FISHi+Dln85st?=
 =?us-ascii?Q?EC3XYQ9Nepyl7NwBJkZ5VcfcuayBMMFYA4uG7ARWPjrCkh+fjOJTtEzxIH/I?=
 =?us-ascii?Q?TDCjL5uVJ/hhUKYwYnFFptvKjVgb1Mjl3dBbzgqFoU+oUUcOI7rMvtIgzrvf?=
 =?us-ascii?Q?Pzfqyxhx0cGpcgFme4uMhk09AeICSZbsT4dMl8MJXrSgXqQtkFwUn0dx5xmp?=
 =?us-ascii?Q?U7lNQINBm0AYJMKBnrmDyS8AVP3CFaB9FgD0OYsYDC/EU5oAT7fDfJVy+/yV?=
 =?us-ascii?Q?snav/akBbzjAhMKuxJo+m57oNWqE/1tyJZ3wF0xipBa+PHpxlFpIamcP5QCQ?=
 =?us-ascii?Q?wMwuiTfpSl1uCyqhDAAaypAAt5D5y2MMAFHN8Gf2mhThb76NJFExmo4vzAh1?=
 =?us-ascii?Q?13Ov1q3ZcKzBAuBy+xTOBZx3OPMMEUsrOip00LEGSM3fA7PuLNtUc8j0FNy5?=
 =?us-ascii?Q?uD4IZVwDamgUCz5eSbv9wqY5yCALVzGfc4CDncyvO5sPWoGbALD2kXvshK7W?=
 =?us-ascii?Q?/BG34qyrhfPCAFPhBCsO3KAbxVBfhmXdra4QOdk2HvVzPJj9NG826YcKjW6F?=
 =?us-ascii?Q?c8E/hYc4kvcMmRjGfTu8bQgFpw7Sl9Fy1C6m7fSbn6S9a9j7qhvs+ZtirGT3?=
 =?us-ascii?Q?eatEaWlYqo98WMBvqR4NiFf3quY46sU3NcaNVgOJKZ7kgObLGNBTOviATASf?=
 =?us-ascii?Q?FNPkye2uZAZ6KmJt5bOcwv2qkTCX3BVfhhNm7JaBjU5axj/t8Lixw+1q4dNL?=
 =?us-ascii?Q?Z2SlYkuO/aAcZMaZcr+eIANT5/T+/7kxEfrVfM//5ARV2w3DutmqzCL2eggF?=
 =?us-ascii?Q?HzfMi/E0YBweQWGoT6OeS7l4yXUFZm4fcIbhn2PW9MRs4fP4qDcyO1mP0iuZ?=
 =?us-ascii?Q?3Ifrlhd9cvzxzjIaun4+Cbqsyr+xV3Q4jVAzWDEElzdYi0xPPaBWX98I6DV5?=
 =?us-ascii?Q?vwt1q0eI5fxIhxLjn5UbJe2m1gwXZkad/Cp7FooChJSpGPW7aFIXqRiy5g3P?=
 =?us-ascii?Q?W6Q7jVfJCcR2d+RgERp4bFareWMooKcA4fsF7ZpTi8m9SnqPyPnx5v9JbIrP?=
 =?us-ascii?Q?aq7VRDlzFKaX3qTc2shTZ18vmsD9SmgvTAbmAgnXjUwsO1aPedZxs7MhRHAS?=
 =?us-ascii?Q?NQW1UU9oitcH/m8AqPOzcXd/eRvSERlY1CTedkVwv9i/M3oBQFNLQYVsN2ik?=
 =?us-ascii?Q?5l0pUrMPGMpg3ftw6j9SLv+Km2e2dvV5TcS+4CrV111S+sHF/Pfx4sh9osoA?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca861020-f0d3-446d-2515-08dc8c53a3e6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:23:24.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPE8HMKrIhC/08NFwS5xqdxm4aVWXGTaLOBcmdKZwk7H7C4xERrxPg/m4jx1effXuhG7+9oH5SZQ7oCz3Rw5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.cgroup.test_cpuset_prs.sh.fail" on:

commit: 105f3fe9188b37752c25d154870ceca352c9213f ("cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      2ccbdf43d5e758f8493a95252073cf9078a5fea5]
[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: cgroup



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406141712.dbbaa8fd-oliver.sang@intel.com



# timeout set to 300
# selftests: cgroup: test_cpuset_prs.sh
# Running state transition test ...
# ./test_cpuset_prs.sh: line 106: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 107: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 729: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 729: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 729: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 729: echo: write error: Input/output error
# ./test_cpuset_prs.sh: line 729: echo: write error: Input/output error
# Effective cpus changed to 0-1,4-7 after test 4!
not ok 10 selftests: cgroup: test_cpuset_prs.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240614/202406141712.dbbaa8fd-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


