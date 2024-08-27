Return-Path: <cgroups+bounces-4525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D5961A8D
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F83284E6B
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A01D417F;
	Tue, 27 Aug 2024 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eR4+VJpu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8F13A258;
	Tue, 27 Aug 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801140; cv=fail; b=bL16S3JakDcE65eldFxkffJS9JVb0faTTkekqdybp32SxHVRAT8uyKFoDIz6ucCNK8UZBCDYe2HgTydjHD8kBF0X0b6kNINPYB3QUI9X2i26+6lGbhKI0QwbcokTDYZ1bFz+nhLI52+n+vSP/3ClwHS7zHPcLc1lMWIUHwROqdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801140; c=relaxed/simple;
	bh=2NQTqYxTTouheEcRRPa7uCYCOmmFIsEbHExnDSVlos8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SMxv1dAC+vZcJy26SU1ODyEEx6KT25tJzcCJ2jDp7sxTt3Mt6RipMu9ca86D0+9+YuIqbIFa3MoGeb1zpmQ18r1jZBIAQteTFk9b2wcS+ljFAXriST3deeB2gtVnymsZ8StquQ177aebGnZN7OqcfzQG9/aEKHYaD6fV/8lM0QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eR4+VJpu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724801139; x=1756337139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2NQTqYxTTouheEcRRPa7uCYCOmmFIsEbHExnDSVlos8=;
  b=eR4+VJpuiA0wgPwVX5ly3/fVJpGZHZz71K+IXc3+M8yENGDNHQF/0t4m
   Z7bBCRSbn43UWvqc41awQ/LrobQO21rLrdnLi9ZzTJjhQ3k2mmoBlC4Ip
   tgun9VHpYjl0NLvkEd3eGv1zX6gnxrgU5MRUvUYVS+yDNecCng2zNvdX2
   HtbGNKu4STr6asI9vVVXcKDJiGTA73XH/g8YNtPqyAMCa6vTUHlNQYDSF
   vsVdiKtDWeNhJKgh79+PGIRbQ2bgJKeArLirb5oXC9ISXgl9uL7BSJJE/
   +yPN9dt0H7rkzVZ0IqnQg+QXMdLvfk33FwLsZp2lxBQRHQCr2TZBA2V1n
   A==;
X-CSE-ConnectionGUID: hRjHukhETI6Sq/+OOnNSjA==
X-CSE-MsgGUID: grTytx5QRJ6TdI7kdN6llQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34715506"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34715506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:25:38 -0700
X-CSE-ConnectionGUID: 9phSXduzTEaXYLNiXOaHiA==
X-CSE-MsgGUID: ECq+16JLQGG/nU0gV5vxsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93822792"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:25:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:25:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:25:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj+df9ciIPdVvqV5i/Kl4MCqxpyGR+r+OhpoA6jzE13DMtFXUijXnlxtPqRarU4OaQqs3HYpdzOz720uccQJtjBxYbHtg3wPkjOpLt3PkKpgqL8kTvnoRVPt87R+XUm/cNNeyI1GpEH5qFuZWLn4eCmFOiB3fn4/iD0ktYlRh78zyVKwSDYOtQ1Xis/5L1CZERKR84/VgViLZdO61YB0pXrOvE7w1qeJAQXfX/+QStX0KpF88/6Fi3eLAjkVIbJGe7X2PM4YXhpzR+Uj0uZFmAGF/uD9VOKJ4XH7Hw1zttV6x1eefwPfPrfAThYNfkzeisvE8fPn0DFdmb/yRTJgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWL6Tpq0fr1dDy/dLsrCAED2SL4EtNPapPjJVrXyWwM=;
 b=DWtIJtN6YMraZ5WUPSd0Cq6KItb1thmelM+0B+zZs1/NN3WjuisE1O+FUxr77BqTyzCZQYKNd+P9us8QnpQXxBK+9LCQXyNLTaoZbQ1zt+uUMPIZ1qcNZjZa5oBNUaT0ONeIVypRtvMYzkNGQ5hGxO1i1AUaS/nMZKYGkZIUKsY2tS8FENO6rm8H2oi0x/kCu30tByxOr4NLqEEiNzPQdY4Hu4ZcmHcSrU5e/vWldhdI8W1Dr3cWLfUgr5+fLBU+e5cQcnigjF98VdcLDuQtAX2AjMSbwfhPZGTy8k4fdR5+7GGD5RZabaurQvK1YEIXu4Abd85BrHEwDM2yWAv43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 23:25:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:25:29 +0000
Message-ID: <fcf55b3c-97df-40c8-bf88-1445f1847b93@intel.com>
Date: Wed, 28 Aug 2024 11:25:17 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/16] x86/sgx: Turn on per-cgroup EPC reclamation
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
 <20240821015404.6038-15-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240821015404.6038-15-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b683cf8-703a-4455-dcb7-08dcc6ef8a0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZRajFkbjVmdTV3eHhQcGFHc0JQSWZ1YlE2WFhNNSsycWhtblNDWmZMdXVu?=
 =?utf-8?B?V1Q2WC96dlVPcjRDclpXR01mYWUwVTdTWDhPZVNoclhFRCs5TjhnekdnOTli?=
 =?utf-8?B?WjdxR2VVaGRPcGljeWdoVTVZamRFOTcra3pSaGltV3RnM1hSQWhTK1poK29p?=
 =?utf-8?B?Z1JZT1dJekhrYUYzdThvVEVpL3VVZEpXdkt4ZHBUbFJtL0pPbjFBVFlCbVZp?=
 =?utf-8?B?dVpFWWdWTHRpNWhaUmc3TXBILy84L3NsSk5GODZDQUI0bC9pQnVYSENXNFRW?=
 =?utf-8?B?b2c4MzZhTHV4c0JQLzJJME16bC9ySzF6NzErY0xjK29adHh5ajZJNTFUWldx?=
 =?utf-8?B?dVVRdWNMaXU3WnpIdTNJcm9ib2tKOWFtckUvWDNSNURsTG1MVVh6MU5nZHpl?=
 =?utf-8?B?Ty9yTWdJYWxuN3phSFJZbGF4dlBiODM4RUF3NC9McHVsUHpYcDhWaG94L3Q4?=
 =?utf-8?B?V0dmMlVtbGNKeFNBUnhTOE8xdktnclZNeTlXZWlncUlJMTQrZk1HSEVVc3RP?=
 =?utf-8?B?eUxCNkdMMXMvZ1BsRDRQMG00eTNhWlNXVG5vaWFDMXBiSXduRUF6Njk2aG1B?=
 =?utf-8?B?TXhWaHd2OWFmVWJKcXNoOTVBRktod3VXS1RwTHVWMjhLcUVJT1dnL2ZJYW1z?=
 =?utf-8?B?UFdVWWZFL21EcytnZUdKVll2R1ZuZFNldUNGT29HRnhOQnNmc1JEdGV5L0JG?=
 =?utf-8?B?YlBpRU52ZjFKQ0NReWQxUzgzNDV5K1VyRDZ6b0srdUV5cmRKajF2dUVKUUVH?=
 =?utf-8?B?YjNQSXBWRDZHclFPK0UyaUI0Tkl6SGdlOWVzQUdJWjgrTWl2UVRYYm5UVDFM?=
 =?utf-8?B?bFFTK0R3TGtHWll1TjJMcnhtZGV1QlVvYmpiWUxaU2NVZWkxMTZaU3ppKyt2?=
 =?utf-8?B?NTZNVk9QcDd3OWdJeHQ3QWNQSlNjdjVxcDFuT1MvSTQ0WU85OGdxK0pGNWNN?=
 =?utf-8?B?SUl1bTV2YkQ3V05DQkdoS1hhbFgranZYRjhTa2srSUtTTVpneXlkVk0yTnNW?=
 =?utf-8?B?UDcyQ1ZZWk9TNTBtbmpOSGNCOUh1dGRVQnQ4bFZHOFRtaVM0RkQ3dHZyMTZN?=
 =?utf-8?B?RXNEK0hzOG9mU3h6dkw1YnNMdmtiZXh4aWxWRkR0N1ZkSWFzOXdIanorbCta?=
 =?utf-8?B?T3F3TDcweVZzdE9BK0VkbkY4QTNjRHZtSlFsMmpCcFZoL0tDalJzSFczQjV4?=
 =?utf-8?B?b3B3a1hmN29yQ1U2QTlpZ1hEbWFNZmZjaU5RRHk3ekEwYjRMd3k5QzI2T05H?=
 =?utf-8?B?VXNST2RNWTRDRGNYd3d4N2pDZVZNWUl0WS80TnhJdStRRWQwR0FwOE5pVC9X?=
 =?utf-8?B?czR6UlVSVmpRMyt1MExpTm1Vdm1IZnErRWNPYzhBa2JWT2U4MjNmdTdVclBS?=
 =?utf-8?B?NFBNVEJMRTVPLzhhekh0TFdzd0lxRmxEYVYwYXZJNzEzc3hnd3R0aXZBZzln?=
 =?utf-8?B?KzFUTkdYTFRnTmdBTEZnSjVPU1JhYXlISWY5QjZQTUlpMitYTmdTNnRFeUl4?=
 =?utf-8?B?OTUxcGlXK1ByN0kyV0VUazVJY3pIN0NuYklZQXUzRUpGWkNpb21KK3N3bTdK?=
 =?utf-8?B?blo0N2Y4TTd4TEtMM3VCRVpqUmdob2k0WTNyZkVZL2pUcDhRQjZLTHJ0ejF4?=
 =?utf-8?B?NlJpaFRpMHhYVXpqRGFGdUpOcER3M3dsbEQ5NHg3U3NadlhXMHlmY092OFpW?=
 =?utf-8?B?NlRHV0xncjVnVDVHZVlZT2UxNHRSeGQ0TVg2c3gxbVNlSXZFckd6KzNjdHQ3?=
 =?utf-8?B?TTc0KzJJV1hoVGV4MnRRRTRwbFFyYWdaUi84Qk82cmE5OEFTaitRYlZSMXow?=
 =?utf-8?B?RDJpTlYrNzhaeGxnT0lGQ2ZLZ1E5cEpyUWQ2eDg0TEMvT3J0Zk9DVFE1TWdC?=
 =?utf-8?Q?0j08K+tYnmB3P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTY2K1hGVU1oWVVHWVNFREdnYUg2VzVrRktCRzU5TlZTMUgrdVE5UUhuYnc1?=
 =?utf-8?B?TnNHVG5nZlptR3BmRnBwb0tvK1ZSN1hFNWxkVEtRWHZDSmdxM1Jnd3RiaTdk?=
 =?utf-8?B?MnowZ0dtdTVSS2ljQURHdHRJMGwzK0ladWxPbmV5bXdUcElXYVMrajJvUUxo?=
 =?utf-8?B?cEtqV280am1oS2JGa3VmcFRnMVBOREhBNENuNGNVTmFERmpSQlBjMjJQRXhm?=
 =?utf-8?B?NlRNeEwzNGQyeE5nZUdYWGl3bmlhZkZHd0p6YVgzQnlXbzlCR2VtL2psR0pH?=
 =?utf-8?B?aFAxNGlNdjdRUU1tWGdIKzM3Ni9Hd0lqSHdpakxhTmU4Sk9wRmM1QUIyZWhZ?=
 =?utf-8?B?VjJpS3hBWDg1aERCb2FJaVhONnU1UzJxMFJaeVRoZDBNSGhiVCtta2NrRE5M?=
 =?utf-8?B?MHAwTDgzMkNYWlI3NkNYWUxpbVY2QmlPZEUyaWlsaFR1SFNwU2tzVC90YmhB?=
 =?utf-8?B?aGN5Q2NHbTdBNnJmWjlCUy9iZzQ3TU4xa1FDZHByQlVpSjNTbUVnUTdVKzJ1?=
 =?utf-8?B?czlRRGVPbUczbUR5VUdaY0tLMVFQZ0FNcTRqbGpkOGRzQ0xyUUdWUlF4eGhO?=
 =?utf-8?B?djZ2TFVLVDIyeVcraTlnamFYaEJkR05zNTQ2cjY0djM4eFpZNytWTVdJcWlQ?=
 =?utf-8?B?cHlYdHRIVU1HYmJXdng3eGlrR2N2QUplWG85RFRDTWROS1B6QjhLbTVLcjI4?=
 =?utf-8?B?aHo4b0d2R2d2emxtVzFxRFN4dHJvWGhUcVZLNTlNclhSdXpkUG5GcHBhV25H?=
 =?utf-8?B?MU1sNXNnOHU5QzBvQVBmOFJYYUIvcDJzb2dEMUsrUVlScjZ1elBwK0hIVEdw?=
 =?utf-8?B?R2VQUXVUMWZ4WlJRbUhZU0puSWkrTHpmQVRxdHR6amVRb1RzcWc1b2Yya1R5?=
 =?utf-8?B?SVhsaVBMcUNEOTl4TGFKZmlhM3hEQUU2c0FFOEFFOStDM3htS3FaTm5QNUtE?=
 =?utf-8?B?UitOTXBQNk1KdGZGWFB2b2l6WW1NWnRzMmNxODJMZWs4UnJwMXMvTTZFZXdt?=
 =?utf-8?B?ZG9zdEowd1gweEZzeGJOUFZMMWtnVm1DcFNvaFZ2OXpYaml6dStrVm1VQWtO?=
 =?utf-8?B?T295S241R0M1N1ArQlF0WERoM0t0cncxZFM3UUNvUzBVbU1IeXEwTmxjUHlO?=
 =?utf-8?B?ekFXaFgrRlArMWhNcUU4Q3VJWTJmMGtZSEVKWG50NDVzZ29PbWlwbWpMY012?=
 =?utf-8?B?Rm5Wc3gwQ2phVEhNL1dhS2d6NDI4L1VtekJLeWFibWZVS0UvNzBPM2JpMDh2?=
 =?utf-8?B?NnJjR1ZTTHhTSkEySTJGS0FJRXF3S2ZFT3J5MFFSQTFXVFY4TnVyTVlnUUxB?=
 =?utf-8?B?Y3ZkOWcyS0NsZXkrYmZMbDAzQmh2bzdtVUZYOUl1TCs0WlNQV0tvQkZmdnpt?=
 =?utf-8?B?blVUczBHVVEwWWtrTFVOUFpGazNybE9TWkVhTHBwblJVL2cwR0o0eEkxa3Qv?=
 =?utf-8?B?eEdPYy9xdEV0MzNsc2svT2JEZTBQdGFoR1c2ZDltMzJYUkJaOFNQc09KVTl4?=
 =?utf-8?B?eUllcG9vMlFNQUhNWC8vakVKOUozeE5CY01IMytuR0FyeW1YbnpMTHArczVZ?=
 =?utf-8?B?eUVhZ1ZUNG90ZkhMcWxsQWZqSDd3M1QwM1E4WDZBSVdjQjQzQzQxTXZOVjRM?=
 =?utf-8?B?L2NpSGtLUmg1NlUvNUFtM3RycjJQQ2xMaHUxT084dFJWeW8rb1pFSE5rN3FD?=
 =?utf-8?B?QXUvWmVPY3grb2JZZmc4dnFrakdHQnEvUmdUcUZLZ3FaRTVwNkNXZm9LUGpo?=
 =?utf-8?B?aHNyeU9PczdIOFlaNVR1VzdyNkk1d05yd3VxbUdneTBhRHk2SmZKQ1dtbjV2?=
 =?utf-8?B?OS90bEZlTE1LTTlkY1paZkFmUnlJWDRvQmQwRm80SCtKOExrSE9VdmsyTkFn?=
 =?utf-8?B?WEpGcWVFekJ3SVExcE96UkpwUUQ3enRwcFhiR0gvbUJaWEhmNU1Sek9SUHJS?=
 =?utf-8?B?S0phOEw3TXZjNFphM1dlM1dkeEhVU0FTT2IzdFNWOWtNbUhFeWRUeDVMOHRy?=
 =?utf-8?B?RmhPazVNUVFWZ0kxelZueHZuVzg3VVNGWFJXVEZ5WVd5SGk5c0lIQWh0OTJ0?=
 =?utf-8?B?ckw3OTQ2OTJFSHFRUjhTdGtJQ1I0Rk5UbjlaUUJwMEZURUJqMVRxdkVxLzYv?=
 =?utf-8?Q?+UzLeBe22DFJfnPAtMJV2zkj2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b683cf8-703a-4455-dcb7-08dcc6ef8a0d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:25:29.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPCDec345R4b7woR550EEtNCUMj4NBQA9yHc0X5gcKoyfPyLskoS8L1i5p7wLybWRGpJysSB+ZwdjqVF7NMW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com



On 21/08/2024 1:54 pm, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Previous patches have implemented all infrastructure needed for
> per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
> pages are still tracked in the global LRU as sgx_epc_page_lru() always
> returns reference to the global LRU.
> 
> Change sgx_epc_page_lru() to return the LRU of the cgroup in which the
> given EPC page is allocated.
> 
> Update sgx_can_reclaim_global(), to check emptiness of LRUs of all
> cgroups, and update sgx_reclaim_pages_global(), to utilize
> sgx_cgroup_reclaim_pages_global(), when EPC cgroup is enabled.
> 
> With these changes, the global reclamation and per-cgroup reclamation
> both work properly with all pages tracked in per-cgroup LRUs.
> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Kai Huang <kai.huang@intel.com>

