Return-Path: <cgroups+bounces-1818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F08605B5
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 23:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7701F22564
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141B1BC47;
	Thu, 22 Feb 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaDflC77"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B217BBA;
	Thu, 22 Feb 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641101; cv=fail; b=tH1Zqos58d+A7kF35rb3Gr0n4A7KRsnPp/gRGWWnxamBXDtMQaCB/faM1L+GewH6QBgJNRni3268nKVLB+Yr7F5n97nwiFYlkof3j5pIuMGOlg6n0liV/vpKZg5cx8+g9s9xhqP0nOXv7AAb9Hdy9emloTWO628w7XJ9/1HPrVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641101; c=relaxed/simple;
	bh=JhAysoJue6TMV3NmpWg518woXCHbHYC7E0jkIvFSVF8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LID/SMMNxLNIV8zeO6XganOsV9umOhOOBCWUL6lxQfmhhB3+0bU1BAixGGylDYqATu1s7LfBwAaYW9DQAxNK5bNwub5jEBVX0NH0GRpFZ1NYvJgqaOXOt+lSPIvw3C3d7IRSNczLOQaEBVQ2n7ZkasDPH23+MKzPEknp5SAiLIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaDflC77; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708641098; x=1740177098;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JhAysoJue6TMV3NmpWg518woXCHbHYC7E0jkIvFSVF8=;
  b=XaDflC77KQxYENjKHW0Gd+1ObHahJMWjlDknJ6sf/Nwd6tIAk9OuJ3S+
   FAZt6mcNL57oeoEuTHUhtwfO469zspEJyByvXcS9wMcuU9slw8SW/C0S9
   KMHkLY2puXL99U8AMaZtrD41w9LczZTW+Sxfc57KjFGwf+T6D9A8PTanr
   PZgBO+Ka/Nc5IqH7ZPhEUbeADMLMkl6UXHfn9RJaih2W4vvon8xLof+Em
   flR+pb624y3uPaHZgJvSriM6qkCjBNG2sJTYvQPLO2IjfgOvVaiCXt4Cy
   ymC3ulV6UVD7MbH5MPpeOTAOC7au+vO2kVgSrQHL5ojGHJ/neWiU8fgFt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2778335"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2778335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913602891"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913602891"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 14:31:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:31:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 14:31:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 14:31:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdKc0zLYHlmStlSbLnpvfUt6OjtbZ6iRDeLh7eogZdo23m9XJAg7OL6bXFtCn5KvgZ8Wp6XgmfC4cUQ2zB0gUGcRqsPuTm+7gETtX0LSdSHQZc7lqW351j5l2tpKom42NGm+GCA2DxHwEOZMLKHn6x8Knq9JTBLlAckEfpf72P0+WpzhSf0ma0k6yDHkpCgqema47LBkMPbHFLzLEzuM8/LBNJNeqP7MD5Bh0g8mVgKvOeiWh8OT5+FozHb86zsDUScUQkMKLoyFDsBj+wpf0vYHhO40/tv2os7hqqHfqi1r5R748bx6rjDRMluy41D6m+ViPyeq7FesZUZXI0UIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48osVHW14dyUG7EI35rLMoyTvmSz+aDu8ePBsaP8LFU=;
 b=ErT7zECrMOszDed27cRiFbuRWTUSrGQ5J2kv5MLdSpGnTQ42oEC/F58kq0SQPzJmi/nKKHaaLYoF1R5lp5Aqcf8vF/YioYeSxjgH6mDwFxeBtu91ZoVMb2QKFIsVqRQ3CLLDtKQjTZLogIbg3/Cj1NCwDWV9fhFVIc2/IBrOD8ppzWnLTjrlAX71jk21feJCAkLx1nClK8TCImmXN2+nGFXv+ELKkY51/TiB1jjLe8NXMAYIvGCvbAlM9bEe6pkHFYG1gmPNXolhu9KN5o+FH4S7GdzPW31XcqPXo+4UPcK+P0wIASDPxdgutv4jD1TKkdgrbdjKe3mSEy55pTs0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 22:31:32 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 22:31:32 +0000
Message-ID: <f242cfb2-e8ab-49f3-9b8e-1236dd361b64@intel.com>
Date: Fri, 23 Feb 2024 11:31:18 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
Content-Language: en-US
To: Haitao Huang <haitao.huang@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
 <op.2jhbnui0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d4aacbea13f0ff03ad94c31a4735746aedd009ba.camel@intel.com>
 <op.2jjzsnz0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jjzsnz0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH7PR11MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b0f093-14aa-4928-e131-08dc33f6051c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBxbA2wTFfZ0L5cSPR7USRLXrB+vph4tiSlcLBpA+x4p2hK+wvdLuzGGtKJHajxp//o3VrSRG/1Bs7Ehe8d5ukULCLd7T4OyulacmipZ4EEfKEuUiUfyt+TgurbdKCRfBRAjgA9s9AFr2xzMoZr8E8kMebVSniudCEKC4Fjas/ZOybAArS2zzTubhG2FzQWLoCeCqg0OEHZ+mo21yLHzAGQZiLBa9qbd1ApzcW4ooZ1fKpEzcAxnWbXhKSJWWf6cf62B7tDaeE8PxkFv06/2teQpWFz0j/HlasMzYHCbGdHFG28LGF1iUwwjQ5JnQTEt/R4jdXf/3xRrFyRzuA8VqNPIKFW/SF8jNIDPjvsOiLNHxMqYOMuR8T1COyJmvAZ7UFwMriCCrrHoy3q5bO8jf8WrhV238hiR41yscpws2f0xGeKHqQuyQyh/0K0wWWFcT5kL5l4NVap7f6ViMWVXB7arRhHvXl4/72c8r0PPBk+4wrRCLhNQu8J2xnsC+4Nu3oc3gzekvzRxdLDCgACnIKsPGdfYMFEMbn0IzwrAS/n22GVTEMP4SK6LfZT5YRzlZ+BeafXtZmIq7KNI3krQ/6cZMbLxjxBwpzofieevUP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZMVnN6cTF4d2VHWWU4d1RLMkhlejlvcjVMN1Eyb1l1NXNyRlF3MmtocktI?=
 =?utf-8?B?VjhoT1VXczBlNWliUXhuYlpMbmVPMHlabkVBVVFoMFA5NzJ5ZEFXTU9yVGNO?=
 =?utf-8?B?cHYrRnJEMlpZeld1UTNYZ0c2Y0NPaFRyVnAyZmlTZHdWSDZEK0JmdXJNTWpi?=
 =?utf-8?B?VFBrZk5zWWNOVE5aVlVybmRXSnN0K1ZiNEsyTmxZMEtrYTJ1WTlBdTlpdDRw?=
 =?utf-8?B?MkZ5YjRnVXdwZDEvZW1vMmd3UjlhSk01STFQTld4SzNGR2NXSlUreEFjY28x?=
 =?utf-8?B?aE91VmgvWEVSbldUODhRSGFzaFA2WEJkSVJpMm5maVhhaENoS0t1STdKUGh1?=
 =?utf-8?B?YzNYNUk0bUpMYmxYUW96T3FDaHRLMjU3MFd4ZjZIT09MUGhqZmhLb01lYys1?=
 =?utf-8?B?MXpoT0k2amVkT2pxeldxM3BCWWpnVThtdWRMMytzWElCVDk4a0o1QlJNaGFM?=
 =?utf-8?B?dGVzaS9rbG1FNTVqTzdwWTZFbStMZnJ1TDRjK2ZnK1h6d3MxZHB3enRQL28x?=
 =?utf-8?B?VnVwTy85ZTB3UXh6Q2FpWDBzWXFxbWNGT0F3NWF6VjZMcHROMkVFS0NBNlhM?=
 =?utf-8?B?Q2FjOWwzVW53T0ZKWFdnc2lDY0ZxblBQWC8yd3IrWk1NczFBTUhIWEZ3L04w?=
 =?utf-8?B?cWYyMHI1ZkpUOVVUTlVJSmp6czF5dVJyaWRacWsrM08rSkRpRTZhNGVJbmRI?=
 =?utf-8?B?MDlvQ3NGWXZsbmMyUzJNaHlyVkh2S1UrWVdsZFlrb1JpeTB1VUNXN0FzWFJh?=
 =?utf-8?B?S2JJTXh3YzRzL1RaSEJ0T3BDd1lPYUNwUXdIRnpMRHpBaGV6eTI0OFNqLzhh?=
 =?utf-8?B?YlR3R1RsdXB6bXphREpjSHRueE1SS1k1QXREbG9RL05xNUc1WU9xbjVjbTN2?=
 =?utf-8?B?ZVZSQmlUV0RmZWZBd1FkbnJvUG05MldDWktUZkdvcWljL251YWpSSy92RjB1?=
 =?utf-8?B?OGFuZDU0clVwNTJiSDMza3FXaC91dEFVVllMVVMzdERSRURZK0RIQ3JiYk01?=
 =?utf-8?B?MCtKTTY2eTBlWnRCUWlmcmpGOGxrVDVjbGN6THFhRitEL093dGZhSzdGZ1Fn?=
 =?utf-8?B?dEc0SGRreXpxSW9DUHdHdm9URjlZVGxVejB1UDZxVC9JZlFpWm1qUGcwWll2?=
 =?utf-8?B?dzB3RmVOdWhmMUQwc0tBL1FXS1hRRFFPS1M1SW91UFIwNlY1d2drRmRUMGpz?=
 =?utf-8?B?RS9pQkg3SVNSZUNoYjlhRmdnYXBpYnZJSlJxMDJUM3dYNklhUDhqZ25Bb0x2?=
 =?utf-8?B?bndleGUvdzA1SHpNNTNyTytieVpUcDhFWVc2UjdOK2YxTDNiT21kd2tsR3lS?=
 =?utf-8?B?U29YYU1nMlR2KzhoSHBzSktsU2RyTXBzUEhnamUxREZjTktZOHFhWUtrSyta?=
 =?utf-8?B?TFJXa0p5WEpRNnBZZzBGTVJQVUFqaklEdkR2bHVLdWRTejZIbWNndy9Ob2pT?=
 =?utf-8?B?U2w5QlBNOFhSeUJzSjJUMDJiUDR1b0h1SXRFSVNxWFRSc1crd0tXb2hhM3VS?=
 =?utf-8?B?dk9rYlM3dDl5eTBwZWFBWjIzQjF0Tm80WXBXL21vYVZ5REZtWXBEQTBPL3BP?=
 =?utf-8?B?Vi9DaUZzc1d5NWsyMys3NnFldzdHNXZoakpXYk5iV0VDak0xdk9BN0s4Q0RK?=
 =?utf-8?B?LzdpNkNoazZTWVY0M3drcFNpUGRxNlp3WEg0eEcwenRwU2VzODcxVy9xK1Mx?=
 =?utf-8?B?SDloL2FNekcxYWVOcThMKytTWTFmUi9YN0kyaitQMjhTQ2Y2VHJjZHdaNmpv?=
 =?utf-8?B?T3hNUG54djI2aUUveWpNRVNiaE85aGpjNzdxWUVsczd3SWFZWGpJcnNhNC9O?=
 =?utf-8?B?M2x5VkhySDZxd2tPei9LVHE3MCt4Z0Y3TllNeEFyZFBhRUZNRnF3Q2VYdzB2?=
 =?utf-8?B?enVWdnpXODlEK2JyTEprR3E5QXA2L2JIUFNtTnlyL0ZnTkZiWjEzV1c0U05M?=
 =?utf-8?B?TkNwMzNtUllmaEYwOUljNGduVTIvWWcwVXVzTG1XeitqWUkvZUFVK20zWWlp?=
 =?utf-8?B?Wm9JNjl1OVBWTktlbmQ4TGF5TDRQSE9lSXMxQ3ZxeFdoWDl1NjZ2ZERkbzZT?=
 =?utf-8?B?RjFaeVZzSXlSQjVzTGsvNDlpQjA0Zm9qdTdxT2NJNGUxWE1BT2RoSzlCRlF5?=
 =?utf-8?Q?oS3EJQiBNpavpFGaJYtn/PAYw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b0f093-14aa-4928-e131-08dc33f6051c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:31:32.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M57GuI/RTPt5kIiJw6U+tXFqZOQ8EtWX8AVG/crV37qySGoSQ8iM7UWWlxbg6vOENJGbFkt6wxlI4Lx9AFNxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com



On 23/02/2024 6:20 am, Haitao Huang wrote:
> On Wed, 21 Feb 2024 05:00:27 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>> On Wed, 2024-02-21 at 00:44 -0600, Haitao Huang wrote:
>>> [...]
>>> >
>>> > Here the @nr_to_scan is reduced by the number of pages that are
>>> > isolated, but
>>> > not actually reclaimed (which is reflected by @cnt).
>>> >
>>> > IIUC, looks you want to make this function do "each cycle" as what you
>>> > mentioned
>>> > in the v8 [1]:
>>> >
>>> >     I tested with that approach and found we can only target number of
>>> > pages
>>> >     attempted to reclaim not pages actually reclaimed due to the
>>> > uncertainty
>>> >     of how long it takes to reclaim pages. Besides targeting number of
>>> >     scanned pages for each cycle is also what the ksgxd does.
>>> >
>>> >     If we target actual number of pages, sometimes it just takes 
>>> too long.
>>> > I
>>> >     saw more timeouts with the default time limit when running 
>>> parallel
>>> >     selftests.
>>> >
>>> > I am not sure what does "sometimes it just takes too long" mean, but
>>> > what I am
>>> > thinking is you are trying to do some perfect but yet complicated code
>>> > here.
>>>
>>> I think what I observed was that the try_charge() would block too long
>>> before getting chance of schedule() to yield, causing more timeouts than
>>> necessary.
>>> I'll do some re-test to be sure.
>>
>> Looks this is a valid information that can be used to justify whatever 
>> you are
>> implementing in the EPC cgroup reclaiming function(s).
>>
> I'll add some comments. Was assuming this is just following the old 
> design as ksgxd.
> There were some comments at the beginning of 
> sgx_epc_cgrooup_reclaim_page().
>          /*
>           * Attempting to reclaim only a few pages will often fail and is
>           * inefficient, while reclaiming a huge number of pages can 
> result in
>           * soft lockups due to holding various locks for an extended 
> duration.
>           */
>          unsigned int nr_to_scan = SGX_NR_TO_SCAN;
> 
> I think it can be improved to emphasize we only "attempt" to finish 
> scanning fixed number of pages for reclamation, not enforce number of 
> pages successfully reclaimed.

Not sure need to be this comment, but at somewhere just state you are 
trying to follow the ksgxd() (the current sgx_reclaim_pages()), but 
trying to do it "_across_ given cgroup and all the descendants".

That's the reason you made @nr_to_scan as a pointer.

And also some text to explain why to follow ksgxd() -- not wanting to 
block longer due to loop over descendants etc -- so we can focus on 
discussing whether such justification is reasonable.


