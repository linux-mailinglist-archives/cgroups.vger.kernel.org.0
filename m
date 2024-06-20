Return-Path: <cgroups+bounces-3246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D591017C
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA2281E32
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709E157A59;
	Thu, 20 Jun 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCeumOAa"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E52594;
	Thu, 20 Jun 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879423; cv=fail; b=NhkyxFZirt39TKh3hOXgga7fjnvcvy8TfK/HXZqCA924ScaJsz1puqsX9vGyk/cDGxLLoXm5kFaZHe8amOTaDiEvdmXeTMEt6fWKi+2uUAwErLausEiYgIiDxv/+OsC94uQ7gAFjf59rgS5yhC16EnmmEqh2BncL+5WOJTq8EoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879423; c=relaxed/simple;
	bh=AtmYZuzESsyTU7Fqu0qkY9q3Ll8JdzzXLkVndWWz1ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdXFW5EZlLQnq7l+2YNZ1vxjtAShwoFS4l9/EePo1TXfLJ+ZPJMkM4W4n1jsDC+aP5H6K6wADwew8yexWEnQlVlMBNwN9ag9p28bfJL5A6ZX5vbrjG1Ju0N/nVFFSVah7RlhU6YQVUm6tUGTXQmIBLZsFRpeS75JUIk8fJZ7zmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCeumOAa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718879421; x=1750415421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AtmYZuzESsyTU7Fqu0qkY9q3Ll8JdzzXLkVndWWz1ds=;
  b=WCeumOAabGwNfs3I61e16hoxni+g/5JH5boSXd9HGq+Ine2pK9grmzLm
   CxeA1x6/gSerNqiEy2G0TnWzkjQfNhK5kcUz/OtpXvGRgTFS3iIMntzko
   3cQ4RenrTWgcg8T/QEMjgzTk7jdbD0AO5vekW/mkap59EpklCLkDOm45s
   A71A+UruJjUP1dB4UlZ8mg+sCpqrJ5hVbBmPUtupo/xVJY57jMO2jZhrV
   hWp5x4jx3v4uaa2QbNyGGqEXaz+zrqmSG2cfV9WDfPWGCOtfWwvLfLBXw
   82vXsLoRCE6+8/3Puo/RWAK+qDvVpioj3lHOXrN5oMnBWLqor9tzWIPq3
   g==;
X-CSE-ConnectionGUID: ZSmwEbF2QOuAw/Q8sLiMGg==
X-CSE-MsgGUID: /0177ZdSTiuA9v3Iwz2oSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="19721965"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19721965"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 03:30:20 -0700
X-CSE-ConnectionGUID: Bh+YvFtUT3iBJBcRTioTdQ==
X-CSE-MsgGUID: kbpSRkLOQqaY8TVRm9i6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46558939"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 03:30:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 03:30:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 03:30:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 03:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFVcFEp+dUUgkXk8EWSEj9WSb9QN5h7xUSpE923L8PiuUtqJr9PRmv8+IEX0QnBlHb/v120tXFxHuIaCtLIZEtLxGO0F+UmX1aVMiUiWMXFE29bi29k8sMzA+VaDDecd9SoqHyBHrR/xR5IQP1MZA4KpM6wHMGoNKeyB8o13sopWEhUoL/zkx4WNWKuA1p5P5v1uylc5cXN5eFdwVUCU+qO+lV2Jhu5/8WXjgo2i+JWpB2ftIUxOyn9cCuzOZYxJbBDno9578PX1bAhdgGQSUUO+brloiYyjpkuoYEn4sq8+DMsWd9JX/ZzRI7T0xtacd3bykJM2p64KY0HvruqMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtmYZuzESsyTU7Fqu0qkY9q3Ll8JdzzXLkVndWWz1ds=;
 b=XevkKQbRXBpFsgaC+Dfqw+8naKQXj6lUSkXf2utNivCqN1QAv4eSjqB8MjA4gUQ/DKtkHoEzzk0ftlacv/F9Fw3CGxdAyscPM/JKl0gXNHeALSjBPtASUR1thsFSlUqMb5DMFlzvHTTuGpn5ZYi28OwWTjjvwvwDj4Qh6a83eiBlELnhpjrf7Xrmy8b69jLqpVaQnLd/RkNi0s3hiekN8dSl5PfRzxy3wXSHS8pyUtOgUne3sUmUVHwOkfdMC5G1Q6qCN1ZLCSMPOTSJami+m0YeL2VVtKAjyqv8jehmLfNIVyRzQTVuQbksQW5RzTvnRlNbq3gAVKX+D1qM4rDmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 10:30:16 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 10:30:16 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "chenridong@huawei.com" <chenridong@huawei.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Topic: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Index: AQHawLVstZrzD55ABEe7Fnrv4pe8t7HQeD2A
Date: Thu, 20 Jun 2024 10:30:16 +0000
Message-ID: <103f18636f0d65e3bcb0ca5f1008c0c7df0bdfd7.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240617125321.36658-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: 8dbbf491-514b-4c71-068a-08dc9113f9f5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|921017|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?c2Q5SE1oVURmZDlSNTNqWUkxRXcyd1M5L3BHNFNteUFWQ25WemZoZGVWUTBD?=
 =?utf-8?B?V2Q1UndRVng2RVV3VWJ0c1VCaXM4YzNMWkxjU0RtdWY5ajdiYmxndloxUXdl?=
 =?utf-8?B?a21UcWVlOFVPZFhIVWdnQnJBV2VhbGtqeUszYTBpSFQ5YnhvMEZXdFVGNXd1?=
 =?utf-8?B?cGQ4aDlkb210WStSQVhIUHpuYlBVTXVTOXZTeXVoc0d0OVpnK2V0WlgzeGJF?=
 =?utf-8?B?a25nb20wWTArNXZWMzFnNkhjc2RkMWtSMjNibGZpMGk2bUNyNTZKM1RxOGR4?=
 =?utf-8?B?bVV1MkJLcXRnTWpxUHJJYjVuYlBpL043MmZyZnVrNlhvblFLSmZDWnExTkph?=
 =?utf-8?B?UWd4anB2Sks2cDBtN1d6RjZXVURFV1lhU3dSS0JyaWt6dGxqNjFjZ3dQWHBs?=
 =?utf-8?B?eTQyL0lQMTlkNTIvdFYrYVFYSmdNK3oxZVB5VUlSTTR1cTkyYmVidzhVUTFT?=
 =?utf-8?B?cUJSOVo3OFRHZlY0Y2xKcWd0NElhZVk2QXoxVWVyUDlmNk5qVEE5VHNjNDNk?=
 =?utf-8?B?QXhKOVBKN3B4WDR5SWZjTnRkZGlsaG5oZEEvNG1UbzljSGszOFNrelRjNmox?=
 =?utf-8?B?c0NDYzVhQUc2UEdoeUFrb2ZGNjQxdnhTZ292N1NKNU45UTdUY1VwbnB0aU9G?=
 =?utf-8?B?M0Y5dlJCSS9mbjN3bDNMYWVJd1BJODRnUmc1UUpVNVZMSmQ2Q0xDSzJCQks4?=
 =?utf-8?B?MTJ0bFVMeUVtaHVLdWlvaDlXV2lXQmJwUDllUE1hSmt4WUYxOUlXNGZxN01z?=
 =?utf-8?B?QmJLa2FySDhJYy92ZldOZXE5T2xTMFNzb2dLN0N4MDhoNFZDY3Y3amVOUWZh?=
 =?utf-8?B?Uk5sdDRBblFLeVhzYU41ZXM2RC8za2hEY0ZPSk04TWwrSXhBdXJ0QkUvOGtp?=
 =?utf-8?B?ZGRydHgrRWlEaUlybEJmNmg5Uk5zS0ZtQjlQWVA1TEVpWkJUeXpuTlMzU0tV?=
 =?utf-8?B?NUQzUmljZG1uZldrYm5SYm1rVnk0eEprUjVMamx5TGwrckxsR2FsdXE1ekJa?=
 =?utf-8?B?ZXRIc3c5YVFqN3B3QnNySm5JK1BKbFFyM21CSW5xbHR2MHVmRVRjcENNRzhS?=
 =?utf-8?B?aUVPY0xtVEY4bml2YkRKblNHZUZCMmtwV0Z1RnoyVDhpUXJRK3dmSkxCNFF3?=
 =?utf-8?B?TkRJQVVWQU02UUczcFN3cW01aldzNnV2Q0diYjF6cmV6MWdYdmUxZi93SlFI?=
 =?utf-8?B?aDVLNjhhVTJaK1hCeW9CUEJ0eTA0VXlhN283eUNjdHQxRFpLOEM2SWlwYjNX?=
 =?utf-8?B?T2J1RnZHTjlOOTFqVWNtMzFmaFU4S0FmOENyS2IvZTJSdFNBQUN4U3Nxak4y?=
 =?utf-8?B?TlYvNlZ1cmQ0VnRPZGJqUXRGTVRyT0JPWFE1TzlQeHFjeVFFVWM3VXNPUjd4?=
 =?utf-8?B?STVhWU1PdDdYbW9zVEZKMzVJMVVkOTdYQnlGN2JwdFEvdmFKV3hKaktTL3ZQ?=
 =?utf-8?B?NE9tcEpzTVlIbVJkSWZOSGM2SFFVZ3YrdW16OVZwTkVRc2VyZVV4VlFXOFBX?=
 =?utf-8?B?SHE3ZXVIb1B1WFRyNGg5MHAwdGFiQW10MEdNMVoxTkQyalBoUXhVZFRkcnlr?=
 =?utf-8?B?YlhRRlJud00xWStoVHd4ajlGMXlza2ttSjNOZFpra2E1cndFTUJ1Wlp0WXZ0?=
 =?utf-8?B?eTFxNU1zTGw0VWMxZGFteFI3NWRMQmxUdFl1M0xiSUlsY2RsNzFnbG50YUsw?=
 =?utf-8?B?cGtnYytkZ0R0NXUvbm9ETE9WZkJoMWdnTUxPYjFaRU5jWXQ5NnNrQVN4cmpG?=
 =?utf-8?B?bEd1SG53UVdyMkI5Q1R0dzFLdEhjWmt1cG9Qc0ZyWVJtVE1scDJ4cFBKOUJs?=
 =?utf-8?B?L2JLa2hOTndNNGJRcllCajRmTU9GaGVnMXhxQmsrTE40QUE2QVEwbVN5SzdV?=
 =?utf-8?Q?Ji0AnL22oWvdN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U25wYVJSUldPaHpLRjdtaFZ2b015Z0VSbE5LTlo3SW9lL1FyZHMxUllXRXYw?=
 =?utf-8?B?Q0t1QkMzMGc5M204YnlKUlMweXZiMzAxK014VkoyTkJxTVJYT2pFa3dvbDRR?=
 =?utf-8?B?WkhzVXNET3RkVTVzYTRVeVJMLzF2bDlQc3NRSUxmcUtOcGNwRHM5ZHdBanE1?=
 =?utf-8?B?dVFYNmtiTjVSOFY4Y3paek1YZEF3Q2NpNU52eGVWQ2o4SERzS3J6ZC9WS005?=
 =?utf-8?B?V3FiamlyancvYUFqZ25IV05UY1hYVE5XTFJPWGdvbDd1Y2hybkwvT1Y4ZWUr?=
 =?utf-8?B?cmRxRGk3TnZib09xU2hISXJpdVpxSjgzZnFOL1BHNDBDbG00MHNaU1oxTlRj?=
 =?utf-8?B?eUZVZGg0b3F1aHNvczRvTndIWVpXVGNRakY3VUJDeCtZOFVrMHI0SHVpeWNu?=
 =?utf-8?B?c3cxNml2WWV2b0lpa1dkZHJXU080TGJLbEliZEYxT1I4U0FLaEdiQkprcFlT?=
 =?utf-8?B?VXRQWi9KbVV5dFUvTDdNSUlyd0FldlFrSDNnTXVKODFmMzJXS0RmcEJLMEdD?=
 =?utf-8?B?cm1hWnZBZDM0d0xwZFF4NDczSWttYStwM3orQWx6NjVwNGdEa0lyRkxkMi9n?=
 =?utf-8?B?ZTBDM3p0SGNxd1lWQklmdklNTVRHWlI5ZkpZOXlqNEVJb3FOcXZETm5GUlFI?=
 =?utf-8?B?N2pQQ28vc0NQN1BGczg2eEVxNjdZeTByU09YUkliTzJNM2Jrd0RPcUxIek5V?=
 =?utf-8?B?Mk9DUFZSS09DR0xtUEFXZEN4L3dIOFJ1ZkE2dWFmYXcxMjVJTjFlM3BLakcy?=
 =?utf-8?B?TVNvaWVCbTZNSktjUjJWbEI4WXllSFZ3OFlzODdCNjRpdmRaZ2huV08reE4z?=
 =?utf-8?B?YjdZamFxTDF6YXU4cDk5VEQwdkVGa01yMVBOSWROajNiTWNtN1RtWE5NekQw?=
 =?utf-8?B?M3IyRTJidlZXMjBLQ0x0Y0tlV1NLMW5KcUdmd1hmdkpxMmdCUU1ETHhteVR5?=
 =?utf-8?B?ZzFCT1FjQUpmMXNCRFErV1d0aG9uTDlabmxUNVVqYW9RZ29RRDhqMURqTTEw?=
 =?utf-8?B?VEgzMTdhVUhTWG5vZng0VUhhTEVYdHVrSnVPOStOMERoUTBMNEU3cWRiNThH?=
 =?utf-8?B?VWxOMktOTlR4NEVlcTFIdGUxalFaWEI3QmNsSCtob2VKc21WRzlmaEsxNWlE?=
 =?utf-8?B?MERNc0xlRzluVE03eWxuVkJacUUrMGNLc1RQblNaNlo4dlRoUTRuNjQ0MUoz?=
 =?utf-8?B?NkgyUmRlV2NScUZ5T1lCb3NCR3hiZ2lUeXJXM09tS0F5Z1NTckVibWorZDhi?=
 =?utf-8?B?WmFvVU5iOHl1b0VNdzBJRG9DdytMM2l2eWJQUkhLZnVudEhXSGZQTlBwdnNI?=
 =?utf-8?B?UkU5M1RKZldBOCt6QzZPbVlHa2tTcHVDUkFYNEdtWlpmWE5PMlgzQ3NpVFZQ?=
 =?utf-8?B?MlpOdDE0TXRMMmdiay9YckhrK1M0QVJnUXJoMWJNZENFL2dCekovOURtUTRF?=
 =?utf-8?B?TGV4U1poeU5VenFmdlgybXMzd0E4M2hIcHNOVWZ1eEI2c0FsdFlVc0NOM0lC?=
 =?utf-8?B?Tis0S0JDVG9qajN1U1NIRHJadWZ4U1lRUWhmaGJ0T3p1czFac3M2YWg4LzZt?=
 =?utf-8?B?a0lwbFRvTHV1OG83L2VTbUFOeUZFS3dWTHlSYk1JN3dpclpKekZ4dnBDVWdq?=
 =?utf-8?B?NEFSUkZaYjRjakFZd1RsUG1EWlJSSjBpTWxiUDdQeC90R0pwU2hDTGZJSkl2?=
 =?utf-8?B?NmdaT0FGY0tEamFDWHNhaTFEc2RtNlFkTVpwbEs2Vmw0RGJWTTZ4WFJWcWM3?=
 =?utf-8?B?YlRVNWxQckg0dXgyRFRwZUJpYTJKOEhheGkvZmhsenB2YjVaY1dLU2hwNmxI?=
 =?utf-8?B?cjR5MEF5OVRsWnpGak5SSi96U0QwQ0xzWUR3ZnQrbG1uM2hDZzVGdzRDMUZL?=
 =?utf-8?B?UitDT21GbFZIVmNrTTQ3aWpLS2Vod21RZGFxTXRmdmRIUDJRT2tidkVyYlAv?=
 =?utf-8?B?eW4yZEFIZUE2clFNRTBSRnVFZXNJaVVNa0VRSEJzTzBOUURQMVFZOVFJa25K?=
 =?utf-8?B?MlZGa2JISlE1SXgvOXMvMGNiZE5hQXBuVDZTeW8yT05uaFhvVGxtcnl1d0Iv?=
 =?utf-8?B?L0ZTbklBMlJ1ckFQK3NzNW1LT0dZT1EybThBbmhxMEJseDZlSVJXVW9DQVN5?=
 =?utf-8?Q?PtI5tRPg1XdlM1AeKVxqMEpi/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <900BAE44C285BF429861B7BACDE23C65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbbf491-514b-4c71-068a-08dc9113f9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 10:30:16.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcImdGA/OvGAqphB9hTPfGsZLI4dttLuMAYvfxYT9eQiWx2eeLFdM/TjnxZf3PKlavJLh/bmcQop0DHypYY67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com

DQpPbiAxOC8wNi8yMDI0IDEyOjUzIGFtLCBIdWFuZywgSGFpdGFvIHdyb3RlOg0KPiBGcm9tOiBL
cmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBQ
cmV2aW91cyBwYXRjaGVzIGhhdmUgaW1wbGVtZW50ZWQgYWxsIGluZnJhc3RydWN0dXJlIG5lZWRl
ZCBmb3INCj4gcGVyLWNncm91cCBFUEMgcGFnZSB0cmFja2luZyBhbmQgcmVjbGFpbWluZy4gQnV0
IGFsbCByZWNsYWltYWJsZSBFUEMNCj4gcGFnZXMgYXJlIHN0aWxsIHRyYWNrZWQgaW4gdGhlIGds
b2JhbCBMUlUgYXMgc2d4X2VwY19wYWdlX2xydSgpIGFsd2F5cw0KPiByZXR1cm5zIHJlZmVyZW5j
ZSB0byB0aGUgZ2xvYmFsIExSVS4NCj4gDQo+IENoYW5nZSBzZ3hfZXBjX3BhZ2VfbHJ1KCkgdG8g
cmV0dXJuIHRoZSBMUlUgb2YgdGhlIGNncm91cCBpbiB3aGljaCB0aGUNCj4gZ2l2ZW4gRVBDIHBh
Z2UgaXMgYWxsb2NhdGVkLg0KPiANCj4gVGhpcyBtYWtlcyBhbGwgRVBDIHBhZ2VzIHRyYWNrZWQg
aW4gcGVyLWNncm91cCBMUlVzIGFuZCB0aGUgZ2xvYmFsDQo+IHJlY2xhaW1lciAoa3NneGQpIHdp
bGwgbm90IGJlIGFibGUgdG8gcmVjbGFpbSBhbnkgcGFnZXMgZnJvbSB0aGUgZ2xvYmFsDQo+IExS
VS4gSG93ZXZlciwgaW4gY2FzZXMgb2Ygb3Zlci1jb21taXR0aW5nLCBpLmUuLCB0aGUgc3VtIG9m
IGNncm91cA0KPiBsaW1pdHMgZ3JlYXRlciB0aGFuIHRoZSB0b3RhbCBjYXBhY2l0eSwgY2dyb3Vw
cyBtYXkgbmV2ZXIgcmVjbGFpbSBidXQNCj4gdGhlIHRvdGFsIHVzYWdlIGNhbiBzdGlsbCBiZSBu
ZWFyIHRoZSBjYXBhY2l0eS4gVGhlcmVmb3JlIGEgZ2xvYmFsDQo+IHJlY2xhbWF0aW9uIGlzIHN0
aWxsIG5lZWRlZCBpbiB0aG9zZSBjYXNlcyBhbmQgaXQgc2hvdWxkIGJlIHBlcmZvcm1lZA0KPiBm
cm9tIHRoZSByb290IGNncm91cC4NCj4gDQo+IE1vZGlmeSBzZ3hfcmVjbGFpbV9wYWdlc19nbG9i
YWwoKSwgdG8gcmVjbGFpbSBmcm9tIHRoZSByb290IEVQQyBjZ3JvdXANCj4gd2hlbiBjZ3JvdXAg
aXMgZW5hYmxlZC4gU2ltaWxhciB0byBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSwgcmV0dXJu
DQo+IHRoZSBuZXh0IGNncm91cCBzbyBjYWxsZXJzIGNhbiB1c2UgaXQgYXMgdGhlIG5ldyBzdGFy
dGluZyBub2RlIGZvciBuZXh0DQo+IHJvdW5kIG9mIHJlY2xhbWF0aW9uIGlmIG5lZWRlZC4NCj4g
DQo+IEFsc28gdXBkYXRlIHNneF9jYW5fcmVjbGFpbV9nbG9iYWwoKSwgdG8gY2hlY2sgZW1wdGlu
ZXNzIG9mIExSVXMgb2YgYWxsDQo+IGNncm91cHMgd2hlbiBFUEMgY2dyb3VwIGlzIGVuYWJsZWQs
IG90aGVyd2lzZSBvbmx5IGNoZWNrIHRoZSBnbG9iYWwgTFJVLg0KPiANCj4gRmluYWxseSwgY2hh
bmdlIHNneF9yZWNsYWltX2RpcmVjdCgpLCB0byBjaGVjayBhbmQgZW5zdXJlIHRoZXJlIGFyZSBm
cmVlDQo+IHBhZ2VzIGF0IGNncm91cCBsZXZlbCBzbyBmb3J3YXJkIHByb2dyZXNzIGNhbiBiZSBt
YWRlIGJ5IHRoZSBjYWxsZXIuDQoNClJlYWRpbmcgYWJvdmUsIGl0J3Mgbm90IGNsZWFyIGhvdyB0
aGUgX25ld18gZ2xvYmFsIHJlY2xhaW0gd29ya3Mgd2l0aA0KbXVsdGlwbGUgTFJVcy4NCg0KRS5n
LiwgdGhlIGN1cnJlbnQgZ2xvYmFsIHJlY2xhaW0gZXNzZW50aWFsbHkgdHJlYXRzIGFsbCBFUEMg
cGFnZXMgZXF1YWxseQ0Kd2hlbiBzY2FubmluZyB0aG9zZSBwYWdlcy4gIEZyb20gdGhlIGFib3Zl
LCBJIGRvbid0IHNlZSBob3cgdGhpcyBpcw0KYWNoaWV2ZWQgaW4gdGhlIG5ldyBnbG9iYWwgcmVj
bGFpbS4NCg0KVGhlIGNoYW5nZWxvZyBzaG91bGQ6DQoNCjEpIGRlc2NyaWJlIHRoZSBob3cgZG9l
cyBleGlzdGluZyBnbG9iYWwgcmVjbGFpbSB3b3JrLCBhbmQgdGhlbiBkZXNjcmliZQ0KaG93IHRv
IGFjaGlldmUgdGhlIHNhbWUgYmVhaHZpb3VyIGluIHRoZSBuZXcgZ2xvYmFsIHJlY2xhaW0gd2hp
Y2ggd29ya3MNCndpdGggbXVsdGlwbGUgTFJVczsNCg0KMikgSWYgdGhlcmUncyBhbnkgYmVoYXZp
b3VyIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgImV4aXN0aW5nIiB2cyB0aGUgIm5ldyINCmdsb2Jh
bCByZWNsYWltLCB0aGUgY2hhbmdlbG9nIHNob3VsZCBwb2ludCBvdXQgdGhlIGRpZmZlcmVuY2Us
IGFuZCBleHBsYWluDQp3aHkgc3VjaCBkaWZmZXJlbmNlIGlzIE9LLg0KDQo+IA0KPiBXaXRoIHRo
ZXNlIGNoYW5nZXMsIHRoZSBnbG9iYWwgcmVjbGFtYXRpb24gYW5kIHBlci1jZ3JvdXAgcmVjbGFt
YXRpb24NCj4gYm90aCB3b3JrIHByb3Blcmx5IHdpdGggYWxsIHBhZ2VzIHRyYWNrZWQgaW4gcGVy
LWNncm91cCBMUlVzLg0KPiANCg0KWy4uLl0NCg0KPiAgIA0KPiAtc3RhdGljIHZvaWQgc2d4X3Jl
Y2xhaW1fcGFnZXNfZ2xvYmFsKHN0cnVjdCBtbV9zdHJ1Y3QgKmNoYXJnZV9tbSkNCj4gK3N0YXRp
YyBzdHJ1Y3QgbWlzY19jZyAqc2d4X3JlY2xhaW1fcGFnZXNfZ2xvYmFsKHN0cnVjdCBtaXNjX2Nn
ICpuZXh0X2NnLA0KPiArCQkJCQkJc3RydWN0IG1tX3N0cnVjdCAqY2hhcmdlX21tKQ0KPiAgIHsN
Cj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfQ0dST1VQX01JU0MpKQ0KPiArCQlyZXR1cm4gc2d4
X2Nncm91cF9yZWNsYWltX3BhZ2VzKG1pc2NfY2dfcm9vdCgpLCBuZXh0X2NnLCBjaGFyZ2VfbW0p
Ow0KPiArDQo+ICAgCXNneF9yZWNsYWltX3BhZ2VzKCZzZ3hfZ2xvYmFsX2xydSwgY2hhcmdlX21t
KTsNCj4gKwlyZXR1cm4gTlVMTDsNCj4gICB9DQo+ICAgDQo+ICAgLyoNCj4gQEAgLTQxNCwxMiAr
NDQzLDM1IEBAIHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbChzdHJ1Y3QgbW1f
c3RydWN0ICpjaGFyZ2VfbW0pDQo+ICAgICovDQo+ICAgdm9pZCBzZ3hfcmVjbGFpbV9kaXJlY3Qo
dm9pZCkNCj4gICB7DQo+ICsJc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZyA9IHNneF9nZXRfY3Vy
cmVudF9jZygpOw0KPiArCXN0cnVjdCBtaXNjX2NnICpjZyA9IG1pc2NfZnJvbV9zZ3goc2d4X2Nn
KTsNCg0KRnJvbSBiZWxvdyBAc2d4X2NnIGNvdWxkIGJlIE5VTEwuICBJdCdzIG5vdCBpbW1lZGlh
dGVseSBjbGVhciB3aGV0aGVyIGNhbGxpbmcgDQptaXNjX2Zyb21fc2d4KHNneF9jZykgdW5jb25k
aXRpb25hbGx5IGlzIHNhZmUgaGVyZS4NCg0KTGVhdmUgdGhlIGluaXRpYWl6YXRpb24gb2YgQGNn
IHRvIGEgbGF0ZXIgcGhhc2Ugd2hlcmUgQHNneF9jZyBpcw0KZ3VhcmFudGVlZCBub3QgYmVpbmcg
TlVMTCwgb3IgaW5pdGlhbGl6ZSBAY2cgdG8gTlVMTCBoZXJlIGFuZCB1cGRhdGUgbGF0ZXIuDQoN
Cj4gKwlzdHJ1Y3QgbWlzY19jZyAqbmV4dF9jZyA9IE5VTEw7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IE1ha2Ugc3VyZSB0aGVyZSBhcmUgc29tZSBmcmVlIHBhZ2VzIGF0IGJvdGggY2dyb3VwIGFuZCBn
bG9iYWwgbGV2ZWxzLg0KPiArCSAqIEluIGJvdGggY2FzZXMsIG9ubHkgbWFrZSBvbmUgYXR0ZW1w
dCBvZiByZWNsYW1hdGlvbiB0byBhdm9pZCBsZW5ndGh5DQo+ICsJICogYmxvY2sgb24gdGhlIGNh
bGxlci4NCj4gKwkgKi8NCj4gKwlpZiAoc2d4X2NnICYmIHNneF9jZ3JvdXBfc2hvdWxkX3JlY2xh
aW0oc2d4X2NnKSkNCj4gKwkJbmV4dF9jZyA9IHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcyhjZywg
bmV4dF9jZywgY3VycmVudC0+bW0pOw0KDQpJIGRvbid0IHF1aXRlIGZvbGxvdyB0aGUgbG9naWMu
DQoNCkZpcnN0IG9mIGFsbCwgc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKCkgaXNuJ3QgY2FsbGVk
IGluIGEgbG9vcCwgc28gd2h5DQpub3QganVzdCBkbzoNCg0KCW5leHRfY2cgPSBzZ3hfY2dyb3Vw
X3JlY2xhaW1fcGFnZXMoY2csIE5VTEwsIGN1cnJlbnQtPm1tKTsNCg0KQW5kIHdoYXQgaXMgdGhl
IHBvaW50IG9mIHNldCBAbmV4dF9jZyBoZXJlLCBzaW5jZSAuLi4NCg0KDQo+ICsNCj4gKwlpZiAo
bmV4dF9jZyAhPSBjZykNCj4gKwkJcHV0X21pc2NfY2cobmV4dF9jZyk7DQo+ICsNCj4gKwluZXh0
X2NnID0gTlVMTDsNCg0KLi4uIGhlcmUgQG5leHRfY2cgaXMgcmVzZXQgdG8gTlVMTCA/DQoNCkxv
b2tzIHRoZSBvbmx5IHJlYXNvbiBpcyB5b3UgbmVlZCB0byBkbyAuLi4NCg0KCXB1dF9taXNjX2Nn
KG5leHRfY2cpOw0KDQouLi4gYWJvdmU/DQoNClRoaXMgcGllY2Ugb2YgY29kZSBhcHBlYXJzIHJl
cGVhdGVkbHkgaW4gdGhpcyBmaWxlLiAgSXMgdGhlcmUgYW55IHdheSB3ZQ0KY2FuIGdldCByaWQg
b2YgaXQ/DQoNCj4gICAJaWYgKHNneF9zaG91bGRfcmVjbGFpbV9nbG9iYWwoU0dYX05SX0xPV19Q
QUdFUykpDQo+IC0JCXNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbChjdXJyZW50LT5tbSk7DQo+ICsJ
CW5leHRfY2cgPSBzZ3hfcmVjbGFpbV9wYWdlc19nbG9iYWwobmV4dF9jZywgY3VycmVudC0+bW0p
Ow0KDQpBbmQgdGhpcyBkb2Vzbid0IHNlZW1zICJnbG9iYWwgcmVjbGFpbSIgYXQgYWxsPw0KDQpC
ZWNhdXNlIGl0IGVzc2VudGlhbGx5IGVxdWFscyB0bzoNCg0KCW5leHRfY2cgPSBzZ3hfcmVjbGFp
bV9wYWdlc19nbG9iYWwoTlVMTCwgY3VycmVudC0+bW0pOw0KDQp3aGljaCBhbHdheXMgcmVjbGFp
bXMgZnJvbSB0aGUgUk9PVC4NCg0KU28gZWFjaCBjYWxsIHRvIHNneF9yZWNsYWltX2RpcmVjdCgp
IHdpbGwgYWx3YXlzIHJlY2xhaW0gZnJvbSB0aGUgUk9PVCAtLQ0KYW55IG90aGVyIExSVXMgaW4g
dGhlIGhpZXJhcmNoeSB3aWxsIHVubGlrZWx5IHRvIGdldCBhbnkgY2hhbmNlIHRvIGJlDQpyZWNs
YWltZWQuDQoNCj4gKw0KPiArCWlmIChuZXh0X2NnICE9IG1pc2NfY2dfcm9vdCgpKQ0KPiArCQlw
dXRfbWlzY19jZyhuZXh0X2NnKTsNCj4gKw0KPiArCXNneF9wdXRfY2coc2d4X2NnKTsNCj4gICB9
DQo+ICAgDQo+ICAgc3RhdGljIGludCBrc2d4ZCh2b2lkICpwKQ0KPiAgIHsNCj4gKwlzdHJ1Y3Qg
bWlzY19jZyAqbmV4dF9jZyA9IE5VTEw7DQo+ICsNCj4gICAJc2V0X2ZyZWV6YWJsZSgpOw0KPiAg
IA0KPiAgIAkvKg0KPiBAQCAtNDM3LDExICs0ODksMTUgQEAgc3RhdGljIGludCBrc2d4ZCh2b2lk
ICpwKQ0KPiAgIAkJCQkgICAgIGt0aHJlYWRfc2hvdWxkX3N0b3AoKSB8fA0KPiAgIAkJCQkgICAg
IHNneF9zaG91bGRfcmVjbGFpbV9nbG9iYWwoU0dYX05SX0hJR0hfUEFHRVMpKTsNCj4gICANCj4g
LQkJaWYgKHNneF9zaG91bGRfcmVjbGFpbV9nbG9iYWwoU0dYX05SX0hJR0hfUEFHRVMpKQ0KPiAr
CQl3aGlsZSAoIWt0aHJlYWRfc2hvdWxkX3N0b3AoKSAmJiBzZ3hfc2hvdWxkX3JlY2xhaW1fZ2xv
YmFsKFNHWF9OUl9ISUdIX1BBR0VTKSkgew0KPiAgIAkJCS8qIEluZGlyZWN0IHJlY2xhaW0sIG5v
IG1tIHRvIGNoYXJnZSwgc28gTlVMTDogKi8NCj4gLQkJCXNneF9yZWNsYWltX3BhZ2VzX2dsb2Jh
bChOVUxMKTsNCj4gKwkJCW5leHRfY2cgPSBzZ3hfcmVjbGFpbV9wYWdlc19nbG9iYWwobmV4dF9j
ZywgTlVMTCk7DQo+ICsJCQljb25kX3Jlc2NoZWQoKTsNCg0KU2hvdWxkIHRoZSAncHV0X21pc2Nf
Y2cobmV4dF9jZyknIGJlIGRvbmUgd2l0aGluIHRoZSB3aGlsZSgpIGxvb3AgYnV0IG5vdA0KYmVs
b3c/DQo+ICsJCX0NCj4gICANCj4gLQkJY29uZF9yZXNjaGVkKCk7DQo+ICsJCWlmIChuZXh0X2Nn
ICE9IG1pc2NfY2dfcm9vdCgpKQ0KPiArCQkJcHV0X21pc2NfY2cobmV4dF9jZyk7DQo+ICsJCW5l
eHRfY2cgPSBOVUxMOw0KDQpBZ2FpbiwgaXQgZG9lc24ndCBzZWVtcyAiZ2xvYmFsIHJlY2xhaW0i
IGhlcmUsIHNpbmNlIHlvdSBhbHdheXMgcmVzdGFydA0KZnJvbSB0aGUgUk9PVCBvbmNlIHRoZSB0
YXJnZXQgcGFnZXMgaGF2ZSBiZWVuIHJlY2xhaW1lZC4NCg0KQUZBSUNUIGl0J3MgY29tcGxldGVs
eSBkaWZmZXJlbnQgZnJvbSB0aGUgZXhpc3RpbmcgZ2xvYmFsIHJlY2xhaW0uDQoNCj4gICAJfQ0K
PiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gQEAgLTU4Myw2ICs2MzksNyBAQCBpbnQgc2d4X3VubWFy
a19wYWdlX3JlY2xhaW1hYmxlKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKnBhZ2UpDQo+ICAgICovDQo+
ICAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2FsbG9jX2VwY19wYWdlKHZvaWQgKm93bmVyLCBl
bnVtIHNneF9yZWNsYWltIHJlY2xhaW0pDQo+ICAgew0KPiArCXN0cnVjdCBtaXNjX2NnICpuZXh0
X2NnID0gTlVMTDsNCj4gICAJc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZzsNCj4gICAJc3RydWN0
IHNneF9lcGNfcGFnZSAqcGFnZTsNCj4gICAJaW50IHJldDsNCj4gQEAgLTYxNiwxMCArNjczLDE5
IEBAIHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKnNneF9hbGxvY19lcGNfcGFnZSh2b2lkICpvd25lciwg
ZW51bSBzZ3hfcmVjbGFpbSByZWNsYWltKQ0KPiAgIAkJCWJyZWFrOw0KPiAgIAkJfQ0KPiAgIA0K
PiAtCQlzZ3hfcmVjbGFpbV9wYWdlc19nbG9iYWwoY3VycmVudC0+bW0pOw0KPiArCQkvKg0KPiAr
CQkgKiBBdCB0aGlzIHBvaW50LCB0aGUgdXNhZ2Ugd2l0aGluIHRoaXMgY2dyb3VwIGlzIHVuZGVy
IGl0cw0KPiArCQkgKiBsaW1pdCBidXQgdGhlcmUgaXMgbm8gcGh5c2ljYWwgcGFnZSBsZWZ0IGZv
ciBhbGxvY2F0aW9uLg0KPiArCQkgKiBQZXJmb3JtIGEgZ2xvYmFsIHJlY2xhaW0gdG8gZ2V0IHNv
bWUgcGFnZXMgcmVsZWFzZWQgZnJvbSBhbnkNCj4gKwkJICogY2dyb3VwIHdpdGggcmVjbGFpbWFi
bGUgcGFnZXMuDQo+ICsJCSAqLw0KPiArCQluZXh0X2NnID0gc2d4X3JlY2xhaW1fcGFnZXNfZ2xv
YmFsKG5leHRfY2csIGN1cnJlbnQtPm1tKTsNCj4gICAJCWNvbmRfcmVzY2hlZCgpOw0KPiAgIAl9
DQoNCkRpdHRvIElJVUMuDQoNCg0KDQo=

