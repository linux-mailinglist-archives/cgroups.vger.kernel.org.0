Return-Path: <cgroups+bounces-1864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6868683CF
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 23:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFBB1F25064
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838C134CE1;
	Mon, 26 Feb 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BykIzwx5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71F134CCD;
	Mon, 26 Feb 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986919; cv=fail; b=Cny6lyZ25cTfdrQnyHYmEsT6fIdzX1LV/Veb+W2AA1MFb1y595RgVbAaPvZHzxgRyy1mLVuk+uoGA7uRswyRquW4Mam6cAs6LUoTE1MMxE5BOl0ExaUMzR4P/+vGbbHyQw4wOfqYpyMjYy6sl0HpzXHsBi83Vb9g3V2uhWAFgmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986919; c=relaxed/simple;
	bh=l6YnQo2jsaDAUBzb76RszFBfoSnZZnDnJx58Y5vKTA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jpv5lSpugrmqBYDCBAPiYsl+r2mpIks/X+92ggYbfDT/eIxHMjAyAuuu0xMZPavOWwAtE01iHC8j+Z57f8GrFB+c2p6XGeeSNJXPi+QGhpbh0dYsDa3d2Qn69kL6H8u0sqQvWy0SFibrx9vUEij1sm413HcTpxNMFhvCfKR9+9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BykIzwx5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708986918; x=1740522918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l6YnQo2jsaDAUBzb76RszFBfoSnZZnDnJx58Y5vKTA8=;
  b=BykIzwx54RY3jbRRuaWcUH9i6ZCfl+doCbL/T+riZJdXyu0crNbnfYqt
   ZlbaWIsQx1m6ZPfwRkFMOGcid840I5fJuClyV3v92SLJizhsOg5ugH1+X
   vhRR7Xk4yQs6eLf1ho1ia9kmU5XZTT6yG9kMyfQ4kKKEtGV/ykITZxpSg
   qG3hTG2GdH4JgbL1iP+ivLVO1XySaXkB5AcsqSPXn5fREZAHN8V2Iiutj
   Cuu6e5osZM9LE+7oZSF/TfpuiH8CzF68+Ho89BREm30P4ELxFryeWVtsN
   GJaICUS/dWl/ncKpLh/bnnL7WO81jEVQ/xXfyJGk/KUjVop/yD5wKttAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3420532"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3420532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11559751"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 14:35:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:35:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:35:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 14:35:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 14:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We7O34LkvykAHXxfOFeINYzqt1k8a5JNvwiVx/AQl2kn+U+bg6jBkdY+aJBXvwCREFBgm0elqekZ5GyOzL2jQDy/nt1vfk9a2rm2ygwC3TliC+wHFxXX9/gyFw0xhE+lTXIbK3LJmnAR28crijh64azQx9xMHKC3nwJeN4HRU08yN9NGfpsQu6kkLYGNY8GwiIWBl212+Hh32PAJohWpPbUoSLxUfIG70ZzTSLxCF7WF18IjsJEonkWp/3O0qSu6rXnxbnwl+7gP7EJMlSIeZ1/x06Os6F3FPSwaEgp73ALV3c0blxQr3K1rkja4nXjPhhRpF4Hk5c8Yge9jLfZzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTyo2A9B64KVGjW/qWj+e54+RqdSIaYR+87Biv0eGKw=;
 b=mIYZx4GD5CTPUVUdDCCQR68bOwj5IoQ07SFhyQ8olhZxxDX+tftA08wcEO+xoo1e7W/+pUWJ8Kz6CKV/WCmUw0dHipLNRzBzrDfMA9w/dkEi58GAOx0bvnNkysWELZCJKY+iTpEHd4VhTSGTMzjTBOid/RRxxW2gMESpPJsDx6/jSzZYq1Q5s4V2AG3CIbOw6j2rPopdGGyKPIRAA666upeqopsvGG31Hu0Ln+AsSW66DThYhEsekKPGsetbcHUjD5hEaMSLrtgB699cQJbjMykuJSxrvmO/Jw+JKPOPixjlcofcJkkL/Lqv+oaVErpP8hg0T4AHh/WlL5IHQEDp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 22:35:10 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 22:35:10 +0000
Message-ID: <b4c7e743-55d7-4a76-baeb-871b0e8cf394@intel.com>
Date: Tue, 27 Feb 2024 11:34:58 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Haitao Huang
	<haitao.huang@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
 <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3f4c6d12-7e0f-44ca-920e-ec219904e0aa@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <3f4c6d12-7e0f-44ca-920e-ec219904e0aa@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e32bb0-e2f0-4fe4-d128-08dc371b30c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbmgUpdia2hC3kyRv+YMJMShB+Kde2XIHAeFKngIBgkM7Y4JI++mkRyn7Zuy+Jm7bFCOLojvNXF3hfibS5QlcVAxs6ynyKF7BSmoNyqZqrLovucVYD3QRrzGJshy+JkQAlcUpE7IcKqOiZeh9ulq3EDI9knR4ymxk07pumM0vcsGYQw24bhofHwqyYSMVCCBP2gLKy6mHOmY67orcZq7GpnmwRS99pRHdGQXV+tJtDFL03zQYInQcv+oKAuArRpTINc9AFV6k/QbLtTfqpUC2CAUM8C3/t7OO87eqK7FyrxjjUd5GkRZiFAgBHP4gdsBfx1165xmV2pkGu+qZYuBgnux2T88dud6qn2rGH2PMpfodHeoPpjcua6LK/uOtgXkQKlmDShFlULGFq6n4a8m2mXpn5cK8Pe+MvgI0cKvcqrqPs17nyIt2amoCfGfxVA6LBO2rIdG/xMh0e8GNc+fVLD76A7NPcbDVNan+bTaFq/XCjvH9VJORIa90HgnVPxPAAk2DqqwAwdof2avw3z79uEd/cSm9wkH744rG0Qq6Zp7pQ5ONL8IImsMQE7ihsEgJJS5m+4LdeSKd16G26R3UZuM9Vbxbni2F/+/zaxW0g8pbz0s95GNa7I+IWz/p3zGsaSX8VeIMt2B0ZzAAX1GbC5AgmyAhSZxwgRwd/sE9pI2BcIKu5CsR3itlK2fph1+qzSkbLl2XCo/LVfRKsP/uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhWTldtRmxMeEpYcDZSUi9OOFV6MnBlVmNYdzNTN1BBd1kxcHRaeDJCTTlm?=
 =?utf-8?B?K2wraUhzdlBvWXJuYnpxVXJiRkg0d3lEMkZPb3QydHFiM3M2MFB6cE5QQXQ3?=
 =?utf-8?B?NzBFbVZBTDlWczN2N2tVdm13VWMweEV2UzMvRmt6UWFYQ2cwK1V6djkrd1ly?=
 =?utf-8?B?WlE2dW5DNU93ZFNnOFhIZWpvWEF2dHRXWk9GcVFyd00zejlDQ3dzTEhHSm54?=
 =?utf-8?B?djVzaU9TUG1XQVdXa2RwS1g1U0FNRGpmdkpMY3NjYjEyaEpCOVpsYnVoWnRH?=
 =?utf-8?B?UU80VlBhVDVsWlpPaEp6ajh3eFZKQ1QrU1lsUW1ZYkhjM3c2cmo0empKZDdN?=
 =?utf-8?B?TWJiMGc4alAxYWI0SUd4OTArRTYwakdEZFg2aFZxS1d6THZFc1A4RmRJYzNZ?=
 =?utf-8?B?MmRCUE5BTE4rdVZTZzdHRXBjb2hTYUNSYVlpUXFTQVRwZnAwbHlIQm96d0tH?=
 =?utf-8?B?VTVydVRvR2FvbTlsa3NxSzJDZG1hQVI1Znc5Ri81WWFtd0RwQUZaOWF2U1d6?=
 =?utf-8?B?US9TdVdSTXVWK2IrSUVldE15eVAwZGZPNU0zZ1FGQmdVMDFoRDBxQ2QxYmtq?=
 =?utf-8?B?NllxN0tVQ3N1ZjNNZDZHeDdBOGt5UmU5OEJiS0pKZ3M0NG9jaU9xS0lua3dG?=
 =?utf-8?B?TWx2ekF3bmZtSmVxb080SXNMNGxYNWZMMFF6bndMdXRkSmJoK0RxN0tSWklt?=
 =?utf-8?B?TmdaYm9ONldoUGFzNGlFclBhWWozTGUvZjN0VmhvNmxWbllTUlk1Zno3Nit5?=
 =?utf-8?B?TzNKM3UycTZzWXl0MUhqa25RNU1GalVNN1dUUXN5aUdhaXFEYStSNndvVlo1?=
 =?utf-8?B?azVTcXR2VFVYdWhKN1Z1NVlQRFR1bXQxWldiWUVIQkk1QmsrTjRPL3ZJWFZ3?=
 =?utf-8?B?NkpWUGV4QnUwekVhNGY4c1ptaHIwR1F6Qm1mNnZVYTE0Q1ZvYVh0emlEdE5i?=
 =?utf-8?B?OWFEOEJvdTIvQWMyR3dUN2ZDdjVabFNrRXNLcVNrOTZDMjZoSlNWMnYwUGtP?=
 =?utf-8?B?V04zSXJSVThTQkwzcWhTU20wVGxvVWJKUGFNREw3dlJOcDZSSFRlcnVzaG5Q?=
 =?utf-8?B?Z0g2N1NhMnhpWnZHN1VvMU5iL0NoL0dVdDhmbW9ZbjZqQzgxL3hZd3J3Vzkw?=
 =?utf-8?B?MHlpOVVKa2JxT0I4RnpQdlJTQ1grQVUzMUhaMzNmYlZXMnpjc1RkWC9GU1Fy?=
 =?utf-8?B?UW9RMXpCWHhWVXYrWmo2UXRWNjhZZTd0VEI1UUNLZlB0Nk9SOFY3bW85VVlI?=
 =?utf-8?B?K0hDdG4zMFU3UFhlU2NPa2h4NVcrOUN4c3R0WW1SVTAreDVRa1FZNG1zUUZT?=
 =?utf-8?B?MUFrRXZmOFMrYW44NVZTL3F5RXJJWFAwQ2h1L2JBUExZNVVtWk40SzRaVXA0?=
 =?utf-8?B?d0hQa2lVVGc3WERlZzhtVTJrVCtYUmFOV0M0TE1hRHhXVTV2V3VBZnBBc3BT?=
 =?utf-8?B?T25reWx1ZWFEUmw0RU1mQkFZQ2toaFl5QTFXd0d5d3BubmphNUdmVlBVUUNF?=
 =?utf-8?B?RXpzc1B3S2VyUHkyMHVYOWoxQm51TFBKQm9DTmFZM1IzbU0rMlc1V2lMNUNu?=
 =?utf-8?B?aFhmYisyNzBVWS9XRDB4ckI5SEFqanpzZ01lL3o2dHkzOEVQc0FONWpOTjhW?=
 =?utf-8?B?Q092eVBGQmVibTVhbzNYeE43N2NlOExBQTQ0WjZxUit4clhwQ0RHZkRqRDVv?=
 =?utf-8?B?V09yS1JpZ0trOENnY05QYWRBdXVEVkR0RmN3NnZuOVlXLzM4aEwxdVdEbnNK?=
 =?utf-8?B?UnY1T1N4Q3phQVhnZEZsd3UvT2NTaGhBZkZyb2R6d0VpSVNFTnRCY0xkS212?=
 =?utf-8?B?cTJTZzAwYVRkNTFJREw4RklvMmZrcXcrdDRzZ1JCR1FqeC9HeDZzS1ZyOWlL?=
 =?utf-8?B?M0RYV2ZmcUlyR1cwZmpscHAxaFRYZ24wN0h0LzM2eThKL2ttSmxXRlhFM29V?=
 =?utf-8?B?WkhuT1FyZHFCMUMzVy81NHZZNzluWWxjcUF6YmZMYm5yZHdLTnUvU3NTdnRT?=
 =?utf-8?B?ME1GamZYWVFNUm85cjNwZnQ1bVpWSVpjTURKVm9NVEoxMGg2ajNKd3hEejVn?=
 =?utf-8?B?YnQrcWVSdzI1MXF4VFpZYi9IKzdFQjc1OWIvRnczQUZFKzgvaDh4eDBFUGpR?=
 =?utf-8?Q?hZeLPYeioIYUhuuYDbsuIoCuo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e32bb0-e2f0-4fe4-d128-08dc371b30c0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:35:10.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jg68Og6IJrAlGPSnpPj3i6CEwDb9gpBHfJCs5Kk4hZSS6k6Y8lALmHyQ6DZeaWxm58i0gi+uuL52RQINTcTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com


> 
> Kai, I think your examples sound a little bit contrived.  Have actual
> users expressed a strong intent for doing anything with this series
> other than limiting bad actors from eating all the EPC?
I am not sure about this.  I am also trying to get a full picture.

I asked because I didn't quite like the duplicated code change in 
try_charge() in this patch and in sgx_alloc_epc_page().  I think using 
per-group reclaim we can unify the code (I have even started to write 
the code) and I don't see the downside of doing so.

So I am trying to get the actual downside of doing per-cgroup reclaim or 
the full reason that we choose global reclaim.


