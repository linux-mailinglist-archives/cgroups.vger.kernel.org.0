Return-Path: <cgroups+bounces-2481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1768A5186
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A301F23C6B
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CB130AC3;
	Mon, 15 Apr 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRs6Omes"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0712B177;
	Mon, 15 Apr 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187356; cv=fail; b=YHkB3WXqUnaOBgDSjjNiaC6iXzdGzj1CPKe7lOph/cj1ZtXktgOVq8eL2g05leQXN/Wy/YKYROFIkNoPFfyb8CTVSx3c+sb6dxc1Riu3GkLSRImi8+w8IeI/j5TLtoHXbm9fojReqdOJT/s8XiCsFZBWSyTMyFlRhbwvSGUzkXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187356; c=relaxed/simple;
	bh=Fms2Bvds1b7NyTXibFim/mYRia+fAtZsJMLeL2ckKGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJQo/C6tYgE4m4gYrqJO2Of0WosZRNdQiE1uQOgx2xCw1fjGY8tZsIlZf7UCeJJFH2sRDplzvOT8jCUk0JCnd2A6BBFEaJ8BTXaTqE9IzkGVwXEnan1ho0JTudp8hljcVfJraBKB8nEnK8yteb4pjKS9U6WTfUX7wBPMrIh2OgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRs6Omes; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713187354; x=1744723354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fms2Bvds1b7NyTXibFim/mYRia+fAtZsJMLeL2ckKGY=;
  b=PRs6OmesLK4KOcF+Tw8ikM7guLnLlr0J3tjqgX+9m3OiqZcJCBEt83Ow
   G8LVakkBobZUMLu65SnIS+o7J25C4jCAPgbapN6aSVClnGH03L5MkVbG7
   ZVUdgXqK7R/yOdv5RoAbiPyE5FuK2hDNgqCyhR0LuxfdBR45AZsJ4bz34
   s5aExVo9UmCh42o2CpXD/YnZf6dT9U+09EM87fr1MWTuLaDMvOqcDD/4d
   eOgkZPuLx5rGDBDdXDNR4BgzstIw38ky0niNIRtNmCpIlVoWl86Ucpwpr
   2XFyd3EVT0OW4MqBaZqZREj0y8IG2ijW6bKh6NHLQMO7z1XXOmVhAaRC/
   w==;
X-CSE-ConnectionGUID: AHzrGY6NRpetkde2smS6+Q==
X-CSE-MsgGUID: qQ2EVG65SP2vTv9XnS6hkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8446215"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8446215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:22:33 -0700
X-CSE-ConnectionGUID: hpqHzu7ZRJ2pqcZDwXF6MQ==
X-CSE-MsgGUID: Q0E1N6QUSFS3EEDoFzAzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26463796"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 06:22:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:22:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 06:22:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 06:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfbszhp4UkLyPzBj3CprVkf1kHhsWi4WgJlGueuH5pfgBlyoO8AmZu/TRjMwiQR2x9hcqtuvdp5a4L8kKzuL2J39cfmGvDXoE88uIt3kwkLooRvzptqG7ffVFZczKoY9o3MCHImcJRTw6lT6nqsPoFCISDXHlv/X2oWTHblZpBnbKbO7MCW4kvnjwo3lDZ9YFWd+X3vf/csMHpgWrP5P09lYZJxpkj0QJSj4y/ZVqsxjIDrJtLJKPeg91/r0UAhPNnf/2Zhqrn4jG71TMRXTGvCDt11VGLY6DvqBjf1TTSFWDGSR6PZSnPI3AhhbbP4P8F7Ogul3rV4kYbL3EN9kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fms2Bvds1b7NyTXibFim/mYRia+fAtZsJMLeL2ckKGY=;
 b=Mw/C/IhQSq9L8CpV9vImVji/Q4Ei7vhIvk7z/9LDK7h7qx1L3G+QY29Wx98RJfbP7bsZ1kizMQuRl6hIuIxv6Y2CWZ+q6GpEp82MIjiyeyguxSyJWxXZ3r6YysTos3oMGCZyFOjVtl6GrGqESxuz4NeA31mRLu11hn63xJn8V4/sEYE2iy8g78y7SY+7zWEJXQTjFwgAEEANeG2K5/57ZiwBZGjpsAMT5yLsn3SyG4ifYkUDxuC4/SB/Wr2K2BfSGTUEmHG7xbj99pwiSZatAagppzgHapj71BF/edipFCj87bIYHpKmFm/FuW+3JRz0ap6uIqeRSjQvLZuDjkoREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Mon, 15 Apr
 2024 13:22:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 13:22:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v11 01/14] x86/sgx: Replace boolean parameters with enums
Thread-Topic: [PATCH v11 01/14] x86/sgx: Replace boolean parameters with enums
Thread-Index: AQHai3SMurlHdvVUVki8FrkwPeBQrrFpWP4A
Date: Mon, 15 Apr 2024 13:22:29 +0000
Message-ID: <a912d401461662987e6e55b6a12518da17a3d25e.camel@intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
	 <20240410182558.41467-2-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-2-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4776:EE_
x-ms-office365-filtering-correlation-id: 6654d56b-a783-470b-edde-08dc5d4f19f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGpshYRe1IKA/qDm/8mkervue2ApzTYOkz1q5we9bs9VP6RvvmMN/KhLdLRxNflwNqtjG6odep/Zb9R9q52N1r0xQiUyHUJZVS7ld3yxfjKKoQLqh+GWj/1+pbAk4vy/c9IniebxkFCe9Hf+ZYeGaRwF6csKDIDBpFBpszgiCOuTbHP4//UxpplmPlQprBKicodN4F1PV7wa4+ibkRQn4UdfXpQjRt1hQu7p5m0wCexTM0BAatO1mv6MH6yqdoXDYR/wrr0N0cb/jf483zBfJHDMd9uBVmwqzkN++v51IlqlIEaFFpozRtZgOLUvAQDd0iSAcJiD++gsMbsbg+VKCbatEHzTc0/DZy9w379K2zmlwIxke7SomsEeGQS7QFAKVPdKpI3hoZwQauJc0HOB3539uiEg78RZQufIXwkR40XCBwjtp2jyJgRRigAWTB4R4DeDfEIS6EuONwaaVRNX8O7TXyxqPLHxIGV7fKbp8qfoRR3o97snDTOnWROsFltM0NyAvw6Vd8UX0EOLcIIG5VA97aJNeX+aw51PHbzPVF7Ay22k8StkfG2auNkD35u5AagMnr5Tor5hNoHc1yaz4zfAbPd8PFNDOZR7Twrpx0Sn8odf670/A4CPy4HBuCKhLEuT5LDu3V4FAytNR8WSRVmqXOXHYzPvq17h/Zqbo235kEi4IxlggYwgWI+d5TtIvTauduleJo7gJVRjE5nQ5KFRGjZb33Gfv/C7tXj083w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJ5ZUxJRzNackRmczVDeU5hazdndy91R0NINTdTUHM5QzFTZFhINExKeHZV?=
 =?utf-8?B?REoyLy9Hd05wMkF4aTRoVUNGS2o5eDFOa1RhMmx5SDJvNDA2T2NmTFFhRlBp?=
 =?utf-8?B?cDlqTWhIRDhUbnRZV09TdXU4YkdCWU1wY09NS01mVGtuWmNnN2RLbitUdHFT?=
 =?utf-8?B?ZVQ3VW85eDJ3eGpSd0pNbThTRE9HMWxoYU1aVnhkQStRMXlsMkdBZWFtU1l5?=
 =?utf-8?B?dEdjdWtNTEMybFdCYjJFOHRBS3plWmRJQldsam0wTkVOZS9RS3YwNkppT1Bs?=
 =?utf-8?B?c0ljYjRRTjZFSjB5OWhEVlliZW1vYnBac3BqY3VKbmJBM25Lakt0ZWV4Y1h2?=
 =?utf-8?B?SXh4cnVlZys3eVFtRFRTc3o0Wms0bHlxb05JMzJFUWJETGJyM0xpOHBQTDhJ?=
 =?utf-8?B?UDlmQ3dsejhzV0VkZVlXcktORmdBcTk4aVo4VlpVUmV1QSs1Wnlaa0UraERJ?=
 =?utf-8?B?KzdUMTU1NUk4KzlFSEV0dTQzcmdZMVArNms2azY4VitlNEZVVWMzSVVLNlEy?=
 =?utf-8?B?OXlIemNyNFNEcXYxUDBLRTM1WmF1eFMzT2MrOVR3Qm5zUWp6V0ttR0VLcVdx?=
 =?utf-8?B?LzF4VUltMFN0b3dpOXdmamdDZjRnbTVIa2RWRHI3M05DSGliblZwYU0xei93?=
 =?utf-8?B?SUFUUmVmVkJwSlZ5MWo4MWRNbnpGWHZTaHI1T25sL3RXQ3FKK1BPVmV2VitJ?=
 =?utf-8?B?NzFiZHd1WWhjK1hOVVArNTJla1lqNHRPQmJ2bmV6aUw1aVRKdUxQRHoxV2o2?=
 =?utf-8?B?cXhQOWNmOXA1d21DVmx2bWxxMTgyc1lPanV3OFNicVU5YmJQdm5DSW96THh2?=
 =?utf-8?B?dmdDUDlJWXNyM1l2VmxweWwrQTMzS1N6YXZsM3l6TDhVNUo3SnhmbEhiWnNN?=
 =?utf-8?B?T2dtU3hhSHJmVGJnUDdzSFZEZW9palFuS2R0TWNlUW54alI2SUhsbitIS3lZ?=
 =?utf-8?B?UDJPNVVSQUNNNjNKVG1vNklNRmZaeFE2a1dxWldMaVBuK0Rpd0JLUXRTeDJE?=
 =?utf-8?B?M2E1dmVnZU8rYllhaG9IRFpRM2pUeEtaN2E1MzhPVktRa0lZdEQyM0UyRDFi?=
 =?utf-8?B?U29FNnIvUHgxS3BmblBXVWRCeUlxZEJBM3BQaDlqV0VyajlIRDVodGN1dk9y?=
 =?utf-8?B?SzBXajVoVnZadEtCZ0RxZ2k1SzRrK3FFTGRra3c3dDhPTWNlbWh5U3Q0RzlS?=
 =?utf-8?B?RkxnU0M4WldEN1RMeno4aTVuOXBuL3dIWmtjMDliKzRsbFBsaXhpNUMxckVB?=
 =?utf-8?B?ZmRPWDF0K0xRNXVFenFXSG9tVlByaEFzaTQ1S0FYK0NFcFdydVZ6YnVIdlNr?=
 =?utf-8?B?WUV4L0VxMUVldC9CY25pNmpIUW9scXVHTk5GVFd0b3RRRGhKMXJ3eUxzNU9I?=
 =?utf-8?B?SWM3QzBsV0tFTDJiNllEYTh4eTVsRkJYSXFxeHZCRG9RSjJwbzVBY2N3djl2?=
 =?utf-8?B?eUFOWjhaejhTTWdSa1h4OG5uZmV3K0lSVWRORi8wTzlseG1rQTNSck5COUZv?=
 =?utf-8?B?SWRlSHNCZU5EK1puU0h6bmJpUlRPYUxpOCtZZWY1QzJXWE1MdktnTU9USElD?=
 =?utf-8?B?QWlrK21lbWJITjNhekRxcElsTmUwM3V2ZUV1RnM2NUNMY2FzMENEdFRRT3hF?=
 =?utf-8?B?UUl5d25xdTF2a0hWWnpQcTBsbzZrQnJVMG4vYm5YbHp4bWZLdEwybjRzQURQ?=
 =?utf-8?B?YWpGdmVVZ3kxaW1VbkhXVWhmQktmR1BFUEM4VjRSclFvN1NsSnozZEtHTnRX?=
 =?utf-8?B?S09LL2F2cGNDMTVFL1hmK3haUWp4dFJNbksvdWJVSkdGZ3RaTFFvcmdKclJu?=
 =?utf-8?B?REZEaTdkcjJjNWc4Ry9GWUVYN2hpZFVDTWUySlQrQ3Z6YjI3QVFjSjRaeWNL?=
 =?utf-8?B?ZUovcldVYTU1bWVlU3cySnJyVWtyTDlRVTRyQkNxMTVra2pKa0l6QzZNc0ww?=
 =?utf-8?B?c0Y1cllnRldQZW9kUTdsZzlTM3QwZFJKajNtVTBQNDliR3l0S1ZTRzlKN3Rw?=
 =?utf-8?B?Rkc1UFR5b0lyY1ZKc091MERXbnVHUld0d3BRR3NJcEVrZE1wdXQ3eVRMNGhX?=
 =?utf-8?B?ZHhrRmhVZ0Jld2xVQXRWNnRQZXd6NjJlVVp0NEt1c3o5RnF3bGkxT2M4N3Zn?=
 =?utf-8?B?d1Y0U1E5RXpHUTcxVE9yM1ZHWTByY0RZVTRqdDlFYkhnSllFVFJxSDFiWU5E?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ECE8CF5FDCEC045896800F2488C867D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6654d56b-a783-470b-edde-08dc5d4f19f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:22:29.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmuDfJZb4UvtSMujg5TDA6xt9igh70z/xQWe4GVdA3Y657rOa4pBT+dejAnb/wXcQ4vy+YL/H2Ek95eKtLwZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDExOjI1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFJlcGxhY2UgYm9vbGVhbiBwYXJhbWV0ZXJzIGZvciAncmVjbGFpbScgaW4gdGhlIGZ1bmN0aW9u
DQo+IHNneF9hbGxvY19lcGNfcGFnZSgpIGFuZCBpdHMgY2FsbGVycyB3aXRoIGFuIGVudW0uDQo+
IA0KPiBBbHNvIG9wcG9ydHVuaXN0aWNhbGx5IHJlbW92ZSBub24tc3RhdGljIGRlY2xhcmF0aW9u
IG9mDQo+IF9fc2d4X2FsbG9jX2VwY19wYWdlKCkgYW5kIGEgdHlwbw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBTdWdn
ZXN0ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IFN1Z2dlc3Rl
ZC1ieTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gDQoNClJldmlld2Vk
LWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

