Return-Path: <cgroups+bounces-4533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF018961AE5
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD34284C47
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5CE10E0;
	Wed, 28 Aug 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USPLoZJ3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140218D;
	Wed, 28 Aug 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803337; cv=fail; b=Py+USdhn8HgKzLnU+9gTR2GuD7SKJ27mPFzBk8uXYR3vQud87R9H5DBD4dNOG8LRHdsHu26BqWaSG01vI3rWeh+qes4cb5AiHMc/jhGuMIvskbfzCjH/iymYVe4e1OgoyO4UZ2aOuqNneb0qa5p2Fxj3zvKe3m77nrWxwI+8DWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803337; c=relaxed/simple;
	bh=tqTvaCA2OBNhtS4tbrY0ROWhkQAaArN1TM2/p496oQE=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJoapw7UMhxXA3nsA8CJNyDYUnDxAKxYlST6zQVmofYE9fcgxIdaxfQBayKkGPk/dKFAa57nLg0WNIv0tqtwKzflWHhSgMHEEMKMCoTq/Yk8QNN30FxYzEoGF52V5AQoVFBhbp9hTVkb5GgvXO7XcVbY5M1S77EWydo4ryLrW0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USPLoZJ3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724803335; x=1756339335;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqTvaCA2OBNhtS4tbrY0ROWhkQAaArN1TM2/p496oQE=;
  b=USPLoZJ35qSZTLJ/BoMUdqSJv4wzKKl+U5N0x0MgmWMB+UvD+Dkhn/U3
   gKZ3IOk0sGyRQjM2n+gZax0u7Ap0luRJk9SoGX9ZM2dH9OaTMv3L13/2U
   RRNg/iNcgM5g/gHP0DvkHYeNpIXBjkSWn2QpmugUGErfpQIUbS5ZRYBYv
   IqhWyjBbuArBeGGVqqM260iOKrydoSvolC+VPveIAs7OsO8vKb8NNjed9
   usChlKxpxGgJ7j6OHW8IpuoQl8k68lXvGLyTVjpgp+SHie5x1AYia/U+m
   mouZSZbUGv02KV2ACx9lAw0sLP839OdTBhv+lBH9kfFYpKLbgvvyHw2j/
   A==;
X-CSE-ConnectionGUID: R54eSdTQQv63gZQAdI6arw==
X-CSE-MsgGUID: WztAr5xwTA27Wyv0pQgwpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="26211529"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="26211529"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 17:02:14 -0700
X-CSE-ConnectionGUID: 9qKC3qcGRCK+SzkWSXERMQ==
X-CSE-MsgGUID: k0oObSYVTcCiqLMGuPuo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67737619"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 17:02:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 17:02:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 17:02:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 17:02:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 17:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3Zk+xk1MQeDR/pnPZieAIdrS30ri5bFDW8T9IzqG22UHT6YpXQmbLsz1wJm6MNzZE2h7xrnjxc4m3SSr2vNsD+U+JaVq+XF+JVw/lVmeI2vt+rTqGni1dbTNTXtUaCT/bpyfD8ZzR6lAia6ckt8xnmTgzIyIA4/DerZ2rQZ3ecRiigkUJXANbDiJGrRR57wrZj9xecgMe3YOKM/23WBxsVOc6PPtRxmr9jjZszhOYGWTtwqgBTTbab5vKDpQ9yuMEOKHNdrccEw7sbLY+l5LhOIXRhP/rymRL7Sfebdhgno28ax/UY0PSDfg6uI0HKgDl5BKH+6dMmtY+iGxJv29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WizPnerDbs319HXRc+t3rPlJIPHR9D+YilbVBCfiNcc=;
 b=nttAzsWYsVcs80UN628JBHHm5+JJFypY31eL5qsipvImhsb8lc0Mmzu7IdSVd22x9fQbOjccBuo0YpCc6SRWL/k5kKXSlRy0h7F9oanShrGtOBIWDPjVFVYdFO+89b9dqsmLbCwB17W5oVKTCwy4LwY3A4qMCgnVCMiSWHafFnRkHY6mbMON7Zhh8llDCb7qVlQc6JZX/9eUYRbQTdeOXUJWATqMFfTAHMqIRpxuYb7qllW6FKab6hCob/RIRZmd+hZ4+tnuMtGkEqmfv6slPZpEqO3fxZLH5q4qWR6yId/svsLZxw+b4f/RGxFB81ZrmDJ9T1k0Mkwj1nQk4h8dZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 28 Aug
 2024 00:02:10 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 00:02:10 +0000
Message-ID: <41ac0f4d-064c-4ece-9c23-3618f1a7bdf5@intel.com>
Date: Wed, 28 Aug 2024 12:01:57 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/16] x86/sgx: Implement basic EPC misc cgroup
 functionality
From: "Huang, Kai" <kai.huang@intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
	<dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
	<chenridong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-6-haitao.huang@linux.intel.com>
 <f25c789f-e7af-4a6e-8c49-f5e9bbc386d0@intel.com>
Content-Language: en-US
In-Reply-To: <f25c789f-e7af-4a6e-8c49-f5e9bbc386d0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|LV3PR11MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: f76bdad0-6a45-4391-90fd-08dcc6f4a97e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNDMzFHc2Zhb2wxMGVoUjB0NkQyeDI3cWxadlhubHl2QzMwZmRkR0hGZlJS?=
 =?utf-8?B?c0o5QmhodzZHWnVFTm4zaFhGdVF1N1BDV0l4dWIvaGkxZ0U1S1ovRXVRZjgy?=
 =?utf-8?B?Y21ibUlOckpYN25xNUJ2ZGpJekNXWXFrSDQvZ0Myd0R6ZTJOTVE3UCtRd2px?=
 =?utf-8?B?VFN4R25qUk00NTZjOTNNUnIwVWdIcjMxQjFJZlNnU0xXSDhNMnozbURXQlFR?=
 =?utf-8?B?RXNJTkowVmxDQkV0c1pKRkZtRTdhb1ZpT0JQSGhwTjQra013SUJlY1VRN0NY?=
 =?utf-8?B?TVB3OGpHVjRucjAxcHhpNzlxTjBhK3JJYWZWZ0lRd1UyVWZ2dGtFQ1F5cnFG?=
 =?utf-8?B?dEtXYTVNZjdXQWJCdHhBbEJEaVhCd0grUklRT3htdlNBaDJGL1o3NnZvTGVO?=
 =?utf-8?B?RUtidE8zK0xPWkFoQUVUUkwrclB2Z2o1ZVoxRkw3K3Y2bHFZeUhaK3FBajFU?=
 =?utf-8?B?R0ljRm5hTDhlb0lPZGZmcjhXWVVqRmhlQ2ZHUCtJQXdjLzhNTmNJU3YvYWJU?=
 =?utf-8?B?LzNXRXV1NklRTXpFNEFwS01xY0ZGb1ptWTlVT0syUjVRQmp6elI4MXh1TE93?=
 =?utf-8?B?T05CTTJyaGNGRTZ1QXJxM0t6ZHFsSmlnMXY5Rms3MDJqVFh6MFVuT2kwRVV1?=
 =?utf-8?B?QVJKQWhNRlFaWTVxMEd6V1pDa1RYTGVZdFZKSm1LajUxWWIrd05NN1RmN3RY?=
 =?utf-8?B?bnUxeG51ek9xN202cWphTVFjZ1p0RUs3YmZPZlFPWXlQTWhLeXlNcmx6Q3o1?=
 =?utf-8?B?Y0JjRDc3UkpGMjNPRmU2R1diSzFwNURTR1BzYk5Wb1hib1UzSUhxYjVCc2lW?=
 =?utf-8?B?bTB4cWpHN21ETDJKUzBtSkl2WkpWamlIdFlQNjVnb3czSWhBb09jMlVWcllR?=
 =?utf-8?B?N3hqQjNzUkhYSmxpRWxsa3FqL003TU1HcCsxMUt5TnN2bCtINk9UeXEwWVRO?=
 =?utf-8?B?R0hvUmVxVjdmSC84enNYMm45Wjc2bmNtdDNzWlVFQnM0VGt2dTl4MVg3amhv?=
 =?utf-8?B?dURCU3NBck40a3YxSzZIQ21TalFKVHVxSDVBU0VBTWJxbzMvVFpCSlk4MllT?=
 =?utf-8?B?dUtCRUJwSW9DSW8yaXdrRjhjdGFBbTk0MGJYaFpLd1Yrb1RXYkZoTFlWZ3Yr?=
 =?utf-8?B?T3NrbUxHMC9vMHN3RnFKdGFlOXZWZFdmYllsSk8vQXpOblNCdVg3YWx4bHBK?=
 =?utf-8?B?eE1xRzNaSVVWQ3psYkV3R0JldmZtcG05VmowSC9GckFxNER2VlFjeGQvMGRx?=
 =?utf-8?B?c1ppeEFjaVhpWVljZUpvcDdBVW1UWm1qWk1OcFZkNkVFeUtYM3FxVkNwN2pj?=
 =?utf-8?B?ZmxaVjgzZjlJSlQ0QlBMSXFmSFJJZjRHTm8zNkdCNG54OHpwZ0Z2Mk9CL1k0?=
 =?utf-8?B?c01URWJPNEEvOUVrUjlwbUZhS3NsOGxsZlhiNGRWMFNySHlCdWR5c0pOSGdV?=
 =?utf-8?B?YWRFZisvOWtUamdSL3E2OWM4RGo0dlpQVExHUTVnZnZqUmJwZlJnS3k2bVdH?=
 =?utf-8?B?STVjUU40bWcwNUl4YWVYNmNjaXZVRW9tNTUzektrMDBOVTBnV1lZeWxITGZX?=
 =?utf-8?B?Z3RCcDRESnJpMHR6by9hMEkwQ0pHaUpmYXdETFdMREJqR0JLUFRiVDZrNFRx?=
 =?utf-8?B?bFFCdWdIcEhiejVQMDFjNDBMZUVxVzJtcHk5Qk1zdlgxOVhFbzhBcmlLYy96?=
 =?utf-8?B?V1BQdDA1ZlhLQWVMcVgzazFZcXdGb1NQaGcyVng5VnFORE5WakhmbmxRQjJv?=
 =?utf-8?B?V0NkQ2x3SWUyVGluY0JPamM4YVlpMlF6dUNkOGljOHMzeXpNUitDdTVEelFJ?=
 =?utf-8?B?eVQvTDQ1OUd1Uk9tZFk2YXA1MFF6K3NFVlJ1YTA3RmdPNzhDUVdZTmEwQWk1?=
 =?utf-8?Q?LOs5r9VD1TNM5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5OZkN2dTFDaGt4TmlhZVlZNkxGQ1JGV3BwUWFIQ25iL2xtTVE2WnBJdElh?=
 =?utf-8?B?RXA1ZVcvMzNmbnQwV0JhMUhRdVdwTWRIaEhmS1F1UjFFNkV5QjJYOEJRbWMx?=
 =?utf-8?B?L3BXaFhNSnhIWnBQOVdpbU8wRjlFWVV0SzdISVR1UUU4V0IrM2VSdFhYMFk3?=
 =?utf-8?B?Q29XdjN1OGtQeXJrdWcyU2NVZCtIbXhmemJ6eW5QWmVFU0RZbG0xUTh4RE8r?=
 =?utf-8?B?NGtVNkNaVzRtclRaZThpNjJUd2I4c0sramN0T01FVWlielpzcUFlS0pqVU1X?=
 =?utf-8?B?NXRwZk5RUFFGYXV4aXViTVhXZUtkOXArSEhnRzVlRDNpRFd1MndmdHNpQkxK?=
 =?utf-8?B?emVUQnhtYi9US3VSaU5YMHJWNytCTWNYYlZtT0ZiaU1SY1pnVktZUEp3Rkg3?=
 =?utf-8?B?L3ZraEVERW16STR0NDRudzFPNDBjQk5nNDJkUGx6RHZVWWJ5eXExVDJGNXdJ?=
 =?utf-8?B?dWh0d2VNdWpQWk1kcjNPZTVsYTJCam1OeERhY28wdmxaNHRYZDZWS2M4YjhY?=
 =?utf-8?B?RjF0QXB3eXhoRkpwZC9ROFBLNkJrUjkrZ1Qxd2xRRU9SM1JEZ3FUc0ZjNVp0?=
 =?utf-8?B?ZjZsNlNWU1hGU2d4RnIydTZzVTdRRnBPbC9yeS9MaHg2bW1rNnU5NjYrZ3R5?=
 =?utf-8?B?VkpZOVh3WXBRTllIdzFwd3NOUjVqeUdOOUdBVFJDdWhQNTBPWWtBNWJhNlpZ?=
 =?utf-8?B?Z3M5UmV6YUMra0xNZGcwMU8wTFFtOHpqUStvTUZuUndzWjRqeURFdkxpSWtE?=
 =?utf-8?B?aktTMmdZbThDb1JZNzhNbk92VU1TTU01MlFnNFQxZ3U0WG1UcFRtNDlZZDVU?=
 =?utf-8?B?VHZaQWZ6U0gwYjE0djNnak5PTkZTUkZpdXVDUXczcnFTZ3YxT2Rjc2NyVVEw?=
 =?utf-8?B?N2FCcStYVGRIVlM2QWJ2WXgwTUNLZUdFbmpBWjZja2o5bTFEdUtwdUVDUGIx?=
 =?utf-8?B?U3JUMVV0WC84VEZaRkI2WDJ0RitmZ1BPRk5HSnU0UHVrWTUzb2x6NlYzajFG?=
 =?utf-8?B?bG4xSElqeEV4ZzBmMmtmTFQzcFp6U0JuaW9HQWpLa0lPQWFNZHZTSSttN2Ex?=
 =?utf-8?B?Y2oycUs0QVluUFlJVmZiZ2N1RDNubmI3Y3BETGpMSjROZDNtU2lldWJFSTFD?=
 =?utf-8?B?VEk3L2pDU1NmdzJGZVA4UXJKMUloUHhURUFncytVbWx4MnNFWW4ydk5FSUFw?=
 =?utf-8?B?QTBNelowWm1XTzNBcFNrTzMrS2oyZnQ1aUNpTDkwaThJZG1ua0NJVE9UcjlE?=
 =?utf-8?B?REY2NHg4bmZDLzl6RSt3aFhTcjhoaS9nOGh4OFpDVDU2aWxGSVdYUStjZHpN?=
 =?utf-8?B?c0VNZExGRThBL3Z2djNZTHR1NUEvcDYyM2RQVjFpUnFWbW9DdHJyV1dXdFlD?=
 =?utf-8?B?d2tTeXh1N2ExTjZHOXZnNUtXMEZMVWpEYWhLTnFJekI0NUhrVVVZTkNqVWov?=
 =?utf-8?B?QkQ0UEdiVE9ta1dxa1hkNVVvZFBqWkluVXcrMHpyTkhlNlZnd256a3R2N0ln?=
 =?utf-8?B?dkV4UGY4VEFzMmc1TkNCY1kzeDFSMFpYWG4xZXdUemY3bVYrbjkxRHMzYmtq?=
 =?utf-8?B?QUlWYitCdlZ2QjRUOHIwSEdrVWNET0FHUjBrMlZCNlF1b2FDbStHaWxNVmJ2?=
 =?utf-8?B?NVEwVjY3YnVNRWIzOStaeGlIejFwLzlhQ25IUDVNeDhiNUpZUWhrSnRDdzBm?=
 =?utf-8?B?YkQwSGR5TEl6dTFzVUR6UWhsQ3loRFFmbEp3TEZZRmMwV0ZOSzhuN2t6VTVU?=
 =?utf-8?B?Y0pJcndVaXV1S3Z2RWQwaGxRNEtYYWZUZUVPZFhjOVZhWWtJZElLMWJnVjlV?=
 =?utf-8?B?UEJiY0pXQURyeTdFcDk3Zk4vMloyd1JyOTBnVUo4MW9TWm9zNG5WK0Q1LzJr?=
 =?utf-8?B?L24zOWdwNzRQR3R6QjNzNXBjaWtTSVN5MHJlQnlmOFljaEQ5Zk0wYkR1TVAv?=
 =?utf-8?B?Nm84bEdRWnEvb3hxQzN6Tlhyekk0Si9ZbGJFeDl3b2ZCVjZBRmUvK3MzRFBv?=
 =?utf-8?B?VjhGR0RMUUlxWkNMdERaK0d5VDRXTTJPd2I5aTlNVHBxc3Z6YmlPZ1MrU2g4?=
 =?utf-8?B?WktnZE5VT1ZkVWlDWUhxRE9uZWVBc3c2SjFsZS9YU1ZJak9nM1lub1BKME5x?=
 =?utf-8?Q?dw/+1N/iXY/Vkizh/cOAL3gWQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f76bdad0-6a45-4391-90fd-08dcc6f4a97e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 00:02:09.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8INuxTsK3XaBPgL0AmnbDYTIOl+mgG7ysnGkkHQ0EQDSwHx7Z2QRF26lqIlFszVxeD8UBMiiOzbpkIeVEf+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com



On 28/08/2024 11:11 am, Huang, Kai wrote:
>> +static void sgx_cgroup_misc_init(struct misc_cg *cg, struct 
>> sgx_cgroup *sgx_cg)
>> +{
>> +    cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
>> +    sgx_cg->cg = cg;
>> +}
>> +
> 
> [...]
> 
>> +int __init sgx_cgroup_init(void)
>> +{
>> +    sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
>> +
>> +    return 0;
>> +} > +
>> +/**
>> + * Register capacity and ops for SGX cgroup.
>> + * Only called at the end of sgx_init() when SGX is ready to handle 
>> the ops
>> + * callbacks.
>> + */
>> +void __init sgx_cgroup_register(void)
>> +{
>> +    unsigned int nid = first_node(sgx_numa_mask);
>> +    unsigned int first = nid;
>> +    u64 capacity = 0;
>> +
>> +    misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
>> +
>> +    /* sgx_numa_mask is not empty when this is called */
>> +    do {
>> +        capacity += sgx_numa_nodes[nid].size;
>> +        nid = next_node_in(nid, sgx_numa_mask);
>> +    } while (nid != first);
>> +    misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
>> +}
> 
> [...]
> 
>> @@ -930,6 +961,9 @@ static int __init sgx_init(void)
>>       if (ret)
>>           goto err_kthread;
>> +    ret = sgx_cgroup_init();
>> +    if (ret)
>> +        goto err_provision;
>>       /*
>>        * Always try to initialize the native *and* KVM drivers.
>>        * The KVM driver is less picky than the native one and
>> @@ -943,6 +977,8 @@ static int __init sgx_init(void)
>>       if (sgx_vepc_init() && ret)
>>           goto err_provision;
> 
> In sgx_cgroup_init():
> 
>      sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
> 
> .. also cannot fail.
> 
> I think it should be moved to the sgx_cgroup_register().  Otherwise, if 
> any step after sgx_cgroup_init() fails, there's no unwind for the above 
> operation.
> 
> The consequence is the misc_cg_root()->res[EPC].priv will remain 
> pointing to the SGX root cgroup.
> 
> It shouldn't cause any real issue for now, but it's weird to have that 
> set, and can potentially cause problem in the future.
> 
>> +    sgx_cgroup_register();
>> +
>>       return 0;
>>   err_provision:
> 
> So, I think we should do:
> 
> 1) Rename sgx_cgroup_register() -> sgx_cgroup_init(), and move the
> 
>      sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
> 
> to it.  All operations in the (new) sgx_cgroup_init() won't fail.
> 
> 2) Remove (existing) sgx_cgroup_init() form this patch, but introduce it 
> in the patch "x86/sgx: Implement async reclamation for cgroup" and 
> rename it to sgx_cgroup_prepare() or something.  It just allocates 
> workqueue inside.  And sgx_cgroup_deinit() -> sgx_cgroup_cleanup().
> 
> Makes sense?
> 
> 

With the above addressed, and the k-doc warning fixed:

Reviewed-by: Kai Huang <kai.huang@intel.com>

