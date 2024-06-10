Return-Path: <cgroups+bounces-3148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB43902BD4
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358462820CD
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2024 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F11509A4;
	Mon, 10 Jun 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGcYrch5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A45466B;
	Mon, 10 Jun 2024 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059213; cv=fail; b=Jc4rcMlSg7W3AzGUp9DUMpFrWeKDBHhBt5cV3f57tAE3mMNnYfXDT1h00O+sDJm0NewzY1qeFpbbe6r2xbppdK+ejKCHNt9X2KY8gZAhotn2kWR1asWuz/xuaICnEaiv3XyTqWa+2bWFNq6lDZP74A7zoQXzNm3yWHE1UnjM20I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059213; c=relaxed/simple;
	bh=/v2gCVMrNdH8/cLNxENmgB+FwLj0zakg6l9KeaAACyE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kc4fe/pAfCjIy2yUXsHa1Xg1UNIiVl8JHhZFH1Efq2g1eMxvg9pZqctpzMq889u13SdhcTPjMdLv7/EiyNdZ5ktYMbIBLLGReS/Hj6BjMVKzhGcq3LW25iAZ/AJsN8Vzllw0lRleX7Ah7vyWyYFslLcDXxjR4sgcU4BHHGa9/kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGcYrch5; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718059212; x=1749595212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/v2gCVMrNdH8/cLNxENmgB+FwLj0zakg6l9KeaAACyE=;
  b=kGcYrch5y3GvUftZfiuiGOwoMT8EOW9Z5WXNMmvePKqdOwsvuM3b8xlf
   Y/53tEP6chDEDC8siV9Hnhz3qL1NhNLXk3Mcx1KeswrnpFfO9kLSOA+KS
   rRdVKcdqebG/wdD64KA+YkxsOUKSWtDMN1t/B3yBMmopQNw6TLofWlNMm
   oymLNkIULgxloo40M/jmE+BD0GiZlnxbB/6C6Oqb3t+Pz+RqGo6udMCjC
   7SDE3VR6xNgCBK/oJdeO3zAAo61MP8STgtkmKsShBbE5fQajosH8JN4At
   0ocv8IWA20xREdJweLtk/ZulsP24CuvvqarYa05ol8WkfMQkdDRZlLv54
   Q==;
X-CSE-ConnectionGUID: Mn3mW+BrTsaSf4EJHEd7eQ==
X-CSE-MsgGUID: ryy+CqUFTty3Eq5zKDONvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14868728"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14868728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 15:40:11 -0700
X-CSE-ConnectionGUID: G0qeyBnGQsS7gjJwoiCJWQ==
X-CSE-MsgGUID: xMjH8Z3ZSracve2jiHb/NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="76662529"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 15:40:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 15:40:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 15:40:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 15:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNHnu/s/Hbo/r/U365A/UH9H4D8ZdxBV0yaHfudiL1alehLe0ur8Fz5oGY4FKVHmmX50dzCxmNyonl8g7v5bp3XgxqffXjXJ4eQnfP+9YCPuh04QRKHxH3xX5CvZifcseHfUdsB48egegG2Nyit3oXASqM5JE5f7R2p/uasAEG1LfI4Dmlgo8oKBe6UCWDEqJ7WaUi/PmmLGkb3g2Nzbw0yyE1DXpJTdT1wEhnnO4PEfP7Zkbjg1rPiQmKeCgaZnVysrts2GfHdKvg11Qqk2iXCcVPFF6cltWOsqYPk3S/KU7UMJDuK8u7Zz1VV77YhGSHFl7EUtfmDV3e21GDgUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9klRS68hYTi9ZjLbNbV/fqb/g0egZGySaewRlLwL+Co=;
 b=N97pB+ReJjAnZZXFLd1EWwnu6kyOH14oGJ094AAnMJ0AGp+HI72bnjHXuuzl1JpL8F+GwMBHONk8VlbTHk+89G9BV5BhODgJyXwmi0KwEnYxJW+8pgy0PqSMglFGHcTbGFwweWaQuy2swNvxK5t38jcsWioogfMkZpnFiN///LJALa8f1h1DzL3SeE2BJkLwbpBVkA3o+RBXkyAWSMvdSP4J6FRySwTf1n/IZt3MMHSDl7q/Vt6v74GsHWhkutnYMkOIa3SxsHEgYNCUoLKmu6Mcl7K8bXvnaHiBJ+sxf75W+8GUgEU2SEMqCDjiRa3WVfJExfclN7MVUlvfGd2IYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 22:40:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 22:40:07 +0000
Message-ID: <eb36980a-2a81-426b-82fb-7f598f7a0037@intel.com>
Date: Tue, 11 Jun 2024 10:39:53 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
To: Haitao Huang <haitao.huang@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
	<kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
	<chrisyan@microsoft.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
 <op.2ox4ccz7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2ox4ccz7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MW4PR11MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: e23735e3-4a9e-4b26-4ba3-08dc899e45fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODNrY0NDQ3E2M1NOdS81eXYrazdtdFpoYVJTZmU0WG9SU3l3bTcvZmpGc2k1?=
 =?utf-8?B?VnNrNzhPYXdKY2JGb3BleCtXd1BSOC83N0VrMHZDcUwvejJpU0RUd01OMDJ1?=
 =?utf-8?B?RHVmV1lFMlRCckhhVG5RT1o1TzE4NnYzMUZRY0RqNVBCZzNWeFFiOVF4c3Y5?=
 =?utf-8?B?bWNVSHNrMHlLZFNLMWE2YjBhdEV4em51OG5oV0s1OU44dXVVSmZLRFlGb1E4?=
 =?utf-8?B?cW5meFNMbC9OUXBBTEIxeWhNWUVWemtDbE9hR0g3bXprV0lrWFRSUU9rYWov?=
 =?utf-8?B?aVdnaW1HTndFM213b3dLQ3NaNWVUakZHWUIvWG8xaTE2Vi9sdndGY2RKTEcz?=
 =?utf-8?B?dDFEcjFyYVpOZk5uZTNYSlNtSjNFdGFzdWpBUnUzVHZZUWxTdkwySm5rNG5P?=
 =?utf-8?B?cUJibll1R0FUNDA0bG9ZcGhRZXNzOHhrRHlXRWhuOEpzRVk2eHFXNkNDTGdq?=
 =?utf-8?B?MytCT0JzV0tUOXdRWkJHZS9OdTNGNkF2dnV1cmVZVk85b2xCQ0tXMEtMZXpH?=
 =?utf-8?B?V04vd3JhOUpsbkIwQ0gwTVJlelRkVklCajNZUmZRd2JpV3Z3WlZ3L25DVE53?=
 =?utf-8?B?SjIwVzhJaFlCanlNQTZHd3gyWm8xQVZzMyswSjF6c0hNRDEva0lPQTFiU2t5?=
 =?utf-8?B?ZjJERFV1d09JSFV3RGNGODAxRzdvUU5uSUx0YndTcGdhaEN1c01jN3F2c01G?=
 =?utf-8?B?cUNPSlJlNUNyVy9wNDhJdXVzcUd0Q2ljM2tuelNGdHk5anE0L01hcjkySGVm?=
 =?utf-8?B?QUxvVlgxWHZUK1EyaS9vU2I1ak5NVE5YZjRlWGlCVVBNZFJFMWtzVnI0b2ti?=
 =?utf-8?B?MkRYZVpHNzhOZEhJL1c0L2VtL3oranU5NWptUkphY1UxaVRENi85U29EdHVs?=
 =?utf-8?B?NDZwZDROc0ZKaUlRdGgxcVVtQUtaenFTTklET0dkekQ5a1RCQXZhRUdudW1t?=
 =?utf-8?B?RXI2UkJvanhpSlNuOHAxVWwxbnduYTVjd1QrSUZOamJscFNHOWI3YlAzT3RH?=
 =?utf-8?B?dE1pakRqN1VnZm5hdksvZzdBMmh3YWFhSWZQRWpMUFd5Tk9mcnMrVnR6V0F6?=
 =?utf-8?B?cTVPa0dueGZidWVtckRUUU5Mc09OYTMxdjNyOVd5UW9zM2hkWkVydG9JV21U?=
 =?utf-8?B?QUZzaHJDbDQ3MWVpRWZpRCtlalk3T3llM1hKSlY5eXEvTTR2RGladi8zNGZk?=
 =?utf-8?B?VkE2QVBnS0Jtd0pGVmViVmgvc2ZNTVVKUldmSXVkOHRHSHE5M3BoYVJDeWJR?=
 =?utf-8?B?Z1pWNHJDeEVQUUNCZGdybkJhNEZTVWtuRFVZcG9kVUIvU3BVSmFCTTJjQTl2?=
 =?utf-8?B?bERGUDJJUTlRQ3N3RnpCMWZzWEthbEtmZmZBaDFyZTR6OEdmRDFOMnVaWWRR?=
 =?utf-8?B?K3JXRlNCV3lkeWIvR2MvUlgrL0RUaHdaYzBqSUJrSVJrQ0JDNE0vL2VSWm8w?=
 =?utf-8?B?NjhUTzd3bmx5T3ZIRUdwa28wdkovSG1nMTJYM28yaGF3a0hRNDYrd0NqVkFX?=
 =?utf-8?B?RFBmM2pRa2kxTkRsWnVQemVxZzZhRnIwR1o2SzZkNGIrSEIzSkZxYStaQlB4?=
 =?utf-8?B?RExpQjZUVVJ6elZGTEJKek5va1ZGVXcvWXVXUTgxQ0FJY1NEL0duSDdBUlh6?=
 =?utf-8?B?cmRQR2NGd2diZkE4Z3F3dnI4QlZWVTRYUERTcWtzR01pd25oc2xhMEN6SFU2?=
 =?utf-8?B?VUZROFVmOUFna21iZnFzRXgxRTFtOVhzdEcrQ3lpV2RKWklBajNDWXQ0ZkdK?=
 =?utf-8?B?SjVUS25DYzlrOVRETFZad0gwNWlUcXBERVhwUDBOK0ZKZkEvdXlEUUEzeEV6?=
 =?utf-8?Q?Dm93cbxDXFSdU5JKbX3s2W3hQXgh3o+gn8Br4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BHWDhGcFdPMjZoeG5BRVJmOWVhQkdlM2F3VXFGNHhHSjdkbXlJWElhdmN0?=
 =?utf-8?B?M0ZqeS9PQmlhZmNHb1ovOHgwQWdnanlNWUlzUFBMMjErU2I0eThrTVYrWCtP?=
 =?utf-8?B?UFpIRTNYVUU0TTU3R0dTWlRQRmltUmRBVzBrUGcxdFpjdUE3dEY1Z1VBNTFX?=
 =?utf-8?B?UU9OUGpJeEZpZitFMUdqT3hhWFlHbmJrb2tXK0dZanlPZHNHdmd4YU92VWhX?=
 =?utf-8?B?d3V1WU9mTlpDMElQc0U0L3ZUZm00Y1VZSmIrNFdaM3EzR2d3VE1lMFdDZW1q?=
 =?utf-8?B?RDJTNkxKZFY1T3pibFRxY21LWmN0YUNiVFBMNFdzN2YxL0ovNWFHVGZRRzVD?=
 =?utf-8?B?MjFTeUgyUnU2V2VQVStqNi9Ua1NEc1BTWXRteFcydkhFRGNLRk5rUC91cGVa?=
 =?utf-8?B?MlVIM08zdXYrZktPc0I2RXR5NjRLK2N0dThmcHZacS9sWmpFcE5KTFRVanJL?=
 =?utf-8?B?c2xROEVLUVZnS0JCOW5vRlhZOUo2SHphdTBNYjJjTy9PUzBIOS9RV2J1eXp0?=
 =?utf-8?B?RWVJMWNyNm8vUVYzSVRxMTVJL2NSU2cwVENmVkY3eWs2dHliU1VzM3l0NWVa?=
 =?utf-8?B?d2h0Z0loK3Y4WkNNenVCZzRkQzI4NVdsdXdOcS8rY2NGV3VKcXFvdUROYkkv?=
 =?utf-8?B?ME9PVmk5L3pWbzVTZitKRkNpek5rOTRzdmdkZk9WRVZtT0ZTNG5laGlyaXlD?=
 =?utf-8?B?YWF0TXU4MHpuVk1CRFI2anRqdjBQY3BzT2lmSjMxK3IvWEYrQ3ViUTViSHI5?=
 =?utf-8?B?OGQzckRHSXNrTG14UkwzZCtRNEpFeEtXM0lGaXhyUHAvVDNzVzlmY0pKeGpi?=
 =?utf-8?B?TFFVWU1kVnpsb1JnVlhWUlRrb3d5d3FTSnVDOEdjY2dBNmN5ODhyUTNERjg3?=
 =?utf-8?B?bi9Vc1ROOXVDVlM4R2hIN2txSEptaFJ3bXpmbTRsdHNBeG1SNW9Fbnh6dStB?=
 =?utf-8?B?M2VHVWh6NTRnQW9FTTU1aHJUaHdHeXVnQi9Ndm9MdzhMVVYxQXg5eThaVnFr?=
 =?utf-8?B?YUhiYzRVVlhoeFltWmtXZHlVemIrU01INGszeDFDM0YvRFc4Slh6K2E4NlRV?=
 =?utf-8?B?bkpSdTY1TzZodlhkMnlLY2lzQldHZ25TV0ZYQllaYUgxZDFCeWQ2N1d0ZVVw?=
 =?utf-8?B?UnFOaTNBZlkya2IvTDNYNWo1cWZCR2pDYXFuV1g3YTRpOUFFb1FXRTNuM3hk?=
 =?utf-8?B?anRtOFhMajFVMGpmWWxadXA1YzkrNnhXbW91bGo5WWFzUEVkSHQ3ODdPZ3Fk?=
 =?utf-8?B?eFY0bnF0RU1SRzh3bmNhVm1NQVA4ZjVvMzF5NFY4UTdEa2pha0FVa3FaNUhT?=
 =?utf-8?B?SWwwVUNQK2k4MXNBcloyVi9PT25jL3VOOEVRcGQ5WXNtRzlldGhsc3hGOGUv?=
 =?utf-8?B?eUpQWGUybEFQV1ZYQzFKRGQ0TFR1Tjhyd0g0RmhGVHBXMi8vYlRPYlNxMHpO?=
 =?utf-8?B?RVhuU1V1bytVZjJ0SDlaOTEzeXhvL0I5b2ppblFKTnBYMnMvZjZjQUEzRDRM?=
 =?utf-8?B?SXBSRENKMTNoWTZJbXd3dVRwK0tqOVl6b0dZK1VjQjJqUUx0cExHMGpQZVZ6?=
 =?utf-8?B?RFAwUnhyNUNuZ3Z5YkQ3SjBLTStINjhlSS9tb0RtVS9Rd3dyWWNSbjg1ck5Y?=
 =?utf-8?B?MHJrczZEQi9WZWp1ejZrYnNrd3F2clpmaUJlckl1S2hjWE83V0pCMGZmOUE1?=
 =?utf-8?B?Znc3ZWRxMHJZaloyZmF6MHNZUDdtZDA1UXFGVmhmMVJxc2xoL09iOHhNbnk4?=
 =?utf-8?B?T2V4T3dONk1QUkR6eFp6R2dVSThwRDJhVXFoNElTVW92ckJwbFhuditTb1FE?=
 =?utf-8?B?cVNyWTBhWDZybzJwaHViOUc5WWpnTXpMMmRteFFZZzV3L1V2STk2c1RzdHlJ?=
 =?utf-8?B?ZUU0SlB2b1pLUk8xck5hVUNTM09PTG54MkZNS0ZvMm5peHE0N1A5S0pLQkdk?=
 =?utf-8?B?TGdNbjI5WFhuakw5Uzc2SWpzRno2OE42dWxIbEk5YTlWRnVEVzU1bFVoZmp5?=
 =?utf-8?B?R3VqRXRvTWhNODdBTkJTZVljWGZVdXNBTjJHcUE5OWlpa2FRaXpIYnRUZlpU?=
 =?utf-8?B?Zno1OTNpWHRMK2Zwakx3VXJySnk3TzNHSTRVYmJucEVRM3ZmUXVoc2QrV0lU?=
 =?utf-8?Q?TXGfluJu2DW+Y6Y6sy+umtw4t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e23735e3-4a9e-4b26-4ba3-08dc899e45fe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 22:40:07.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1drV8yHTKfeti6Stu4LLkpK32dFDaaDuMfrzZxH721k19co/jlvxymxFZHGp9FyK8sns4mUxvOS9mEZ6NiSfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
X-OriginatorOrg: intel.com


> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -1045,7 +1045,7 @@ static int __init sgx_init(void)
>        if (!sgx_page_cache_init())
>            return -ENOMEM;
> 
> -    if (!sgx_page_reclaimer_init()) {
> +    if (!sgx_page_reclaimer_init() || !sgx_cgroup_init()) {
>            ret = -ENOMEM;
>            goto err_page_cache;
>        }

Does it make more sense to move the sgx_cgroup_init() to the 
sgx_drv_init()?  The SGX cgroup only works for the driver side anyway. 
In this case, if something went wrong in sgx_cgroup_init(), the 
sgx_vepc_init() could still have a chance to work.

And IIUC we need to reset the "capacity" to 0 if sgx_cgroup_init() 
fails, no matter it is called inside sgx_drv_init() or sgx_init(), 
otherwise the "epc" would appear in the cgroup hierarchy as a misc 
cgroup resource.

Another option is to defer setting the capacity to the point where we 
have made sure sgx_drv_init() and sgx_cgroup_init() cannot fail.

Btw, I plan to review the rest from late of this week or next week 
because this week I have some other staff needs to be finished first.

