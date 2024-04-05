Return-Path: <cgroups+bounces-2330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5F899372
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA13B25681
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7B168C7;
	Fri,  5 Apr 2024 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQG8BCmC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7C200DB;
	Fri,  5 Apr 2024 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285723; cv=fail; b=oNTkRkf4GcDfvAP5pnF2WLXjhyx2GJYRgd+hgEKNXGxkhDT389GXY24iZD6bqjAZN8CAVpnbLNQ1e7/wB1oAX7I4Oi3Wa74PBCz6/1ezxdJlHI7On56cQKnw6A9u+EIz+zDSdSwiL+QcsaLjTUVeLOyaqVENBhtcwlfq/+Ei6z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285723; c=relaxed/simple;
	bh=WLnW3raYt3WNtu4p5zxT8WmkSyk5Y+POzfAokLucM0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpmYil5CXK5WhLUCAGrFlsixQCm/P7jycL4z8qJafvVemUn2Obj45iCCd55Asgkck5ciQF5nsZ/zCTonkMs6Dxw+NZoJTm9bvj5QqRtw2CIgH6OQFEAcJv2L5qPmagE9uvpSBE5VSdsXPDqufogxtZgFmBex75TlhDPY+cVQqU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQG8BCmC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712285723; x=1743821723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WLnW3raYt3WNtu4p5zxT8WmkSyk5Y+POzfAokLucM0s=;
  b=MQG8BCmClm4rRvrnvIc7mCCJDey/ks9Qp5iDE44T5p3NcIpNhsVJUNzB
   fuQ/cSOg1SXqNJvVqNWzErABf/o9jTqhsTv07x3Ve5QgeTorvbrinD8cW
   VGAQ+aQtc/qrldkiwXHxLGQGKKQYxAl+KsRoZ3hYrgl1gES18TSmF2sEW
   3AGO/RYN71zqpzrd4GaKD1bK/wuddgBcDkDxrzuUEJbymTbi46GRO+4GF
   OBrIA0zGKndmIA/XgyfDKvuAVg6xwE1vGxNPYInOD5DLDgXlEKzZB3Gt+
   ZYns+NRD2fQDvEK3nV2cGoWkGM+gF1SMTZKCVGOp9Y6yN2so/BI83CQY8
   Q==;
X-CSE-ConnectionGUID: HjQkGCI5T+Sw6E/BgUF3zA==
X-CSE-MsgGUID: xCmkoeDkTWKS+iy8yZJtxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18745220"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18745220"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 19:55:19 -0700
X-CSE-ConnectionGUID: WF+x126RQD+myDasKv39MA==
X-CSE-MsgGUID: iwwCRAe5SlekVomqk1MB8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19583969"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 19:55:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 19:55:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 19:55:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 19:55:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 19:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK3/xfsGQEOkWqfu3a4eWnqEeMTCS/4wWZAgJxWQ1memio1wsNyLYqXPwEP7hD1QJHFj7t6hHQdEiOEZVp0QAaBTLIwLF6BOk0u/2mlXrl0VYfx7v9SZzzCqtZebwPCF8gBRd61QpGnUTc/SN38btJBozM/hP43Dm/BNwi3K6R7RPgWJrQ9AvmnlYbxcsegpOtzCxYOgpf2Jab9zkCCCUlyCY08j2ttdr43eGk05oxPUTt7cPljjVZF/i4i6XO4xyE9oeG6Mk6MRJi8onT3AcBNKRNdLL86mfumeLE7Fcr7aFfesGT17x3eOFjIWpcBUJo5zGm7x3Vx1jx9MX71v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLnW3raYt3WNtu4p5zxT8WmkSyk5Y+POzfAokLucM0s=;
 b=k4DI9eevadU+T5rZR7SbalBLZC/EL3HStDx3OGA7iL+PFM/67lyrHaIE577yBtvRBztQ0uvh3RaUUulXjIudIfrf1gm1ndSXuyOvXKGMP17RgWfWLgduv3nEmTQ83YqVJozq3uyvOnpcHwh7ILso8r1sJxCzfOlfRxHMWbPYeb72NmMFbQYyWJvGrSxFhXNL+QDIz3Jykx/xyDCL4JhFoZ+MRVNbxr7ZBqvGaHLEmrgQJQL85CunE5QozBxL4O9A8a2jnq72HnDgPySqjcqWeiGio/6TmfMeYBLAdIabjT8pcU0EqOojycttMm77Kd8ypkKAvlOk95G1/iGe7/FjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Fri, 5 Apr
 2024 02:55:09 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 02:55:09 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHagKYLsFT4s142u0e+3dOpqX6L9LFNHJ0AgAvR+wCAABlwgA==
Date: Fri, 5 Apr 2024 02:55:09 +0000
Message-ID: <ee00aaa815b91ecb24165ad3d4ef2481a4120d05.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-6-haitao.huang@linux.intel.com>
	 <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
	 <op.2lqd6eavwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lqd6eavwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV3PR11MB8508:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXjsLkEAXPwBSlIi/+CT9qu1T0gC1RTfzMdECWQs2UNfLduLiHWTv8stpTik6CGcqpMjA65bSL/keu30LIopvAw3iZIbc25j0PX2M4lDkHaQrNZnuXXfwZqlGidABIFW+Ho5i5mGzsgYyJjk2kL1xFd671Wq+gHt6/jCgu77yjOiBxcBR/6O78aJrAGxSnCvyjakAD4gjth4rT/Fe8IHgbEPM585x/0X7rG8HhdakFF2vesrN9NSjZe7Ri8GwMML8wUyWagXLVuovyjVC4k2ni0KATeX1cfPMgYRgeoWVJSQxTgTq1EsUD4idQuwukjiuWv+G/RtSI9hha9wRslZ52VY3isq85NzGz6HFl/yvgpjMy6ZH8ceivfVNWm6WZSUYJbC3fvPwvFy+pLg6LS77/LwtWUq7rfgosqf0cZm2vYf+6TtXeTKEGO9mw93yEb4lWNJvxlipI/rF44R9knaZJ6fbk/wfZbvfOWabVfkhMowokF9MSxMdgshFIUFbS+H+G0wfblYlefhaZqXlUnvVdoE/O/+NUieQNVz3zxgvY+GVzPxK0SQvypX7raBvCOQ+iG9FqPjGdtmKu85ioi5+FPUEgQXx1KAkCrNjkQCmUwcuxTmRvp7uRLzsAzR6o7LldoubJrLZGz4TXS2fapBPnxg1i+WfHvqavBk0piczxU++k+Y48JsDSLhuR7n2PTbHav3ahEjccOralKeTGlD6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bElFNmxsMnVjRHhXSU9qRzVLcGVpTHRvTEQvU2tJT2hseE9BUXNuUUZVeGZZ?=
 =?utf-8?B?dkJ4akVkekFsRW5ub0RKQnp4NFhKZXJCbzJ6eFlScGxWZHBtb3R5MmlIeDkv?=
 =?utf-8?B?RlpTZ1VOMHF3dVoxV1l5RURMbUpQUGRkalhIbnU4MDVEUzdINFNHVXREK1lk?=
 =?utf-8?B?N3FVaTNtR3JCR3oxeitRKzVnMzhqWDNJSGJJcXBvUU9zVkoxU3JoM0RQM1Fq?=
 =?utf-8?B?ZDJxaXNFQklESGNodlREcUtudXlKREhFSk83V1VIVzRVSkJOaEhNMXpudnZx?=
 =?utf-8?B?MWppTlNiTWFMMHRKYkxBM0Fab3d2d0ZhQk1EcHAxODFPVFIrK2lSdmJSZVlj?=
 =?utf-8?B?QkF0SENtU0NNZ0ZoYXNHREM0WUEweDJpRTdJdXlnNEI3WmdtRDZLVktHbE5t?=
 =?utf-8?B?VkRnMTN5TXVULzFESlJYTjljSlVxcTRjVlRFQlVjbmpPeFdHamI1UExuRWNB?=
 =?utf-8?B?THhLWE5OL3h1WU5kQ2prMkJWRG01Ukx0SnA1OElCbVloZVdZL0FocUJSTGxo?=
 =?utf-8?B?UmhIV3hXeGhPTzVJWUlQNFB6TDlmeDF6MlR6QVpZektaamVNc2thZWJhZEVB?=
 =?utf-8?B?WXZuM2VsNVIzaklRZjVpTXBkZmg3OUt4TjArYWVGNU5nVTFrSnh2VGU3a2I0?=
 =?utf-8?B?ZEVzYTIwK1dXQXgyYjRiMmJlZ2xTVk10Y0pyV3pPek9ONW9RbXBuL2ZGa1Ew?=
 =?utf-8?B?M090VTl1VDBGeElqMXphcmtYck5WVC9NN29FZlRmMHA1QUwwU2crTTNCL3FX?=
 =?utf-8?B?dG9odVNGeWlTRGV2WHNPdVBzUTZtZEFxQmRoYk1lemU2eFBiZHBNUE5jdVhX?=
 =?utf-8?B?dkpZczVFY08wajVzQTBkTFlMQllYYmdYc3gvck9OTGFteGRheEVEK3NxRE5H?=
 =?utf-8?B?Mmgzbjc3Y0hka3NEbEpWcUdCRlZpRGF4Nks0bG93WU5aN0dVb2trZkN1YW8y?=
 =?utf-8?B?Z1BmV2ZyLzNXbVA1M2srMHN6Y0dlN3NZaXNHUG8zaXlBemprQ3NsbjlNNDA4?=
 =?utf-8?B?dWlFR0h3cWM2VmVSaS9Cck85Z3d2bDZnT2V2USs2bFpkQURraWV6VzJYTThG?=
 =?utf-8?B?YlFuelJTWWtBOXhJY0NpNU91QVRCdDZ6aGJZbmVwY1g2SXloUU1xTmtkYmVI?=
 =?utf-8?B?UXdGRW16L0JUd1RHZ0ZUNlZqYUc4QTFBWXlUY0h5SElLSW5OVThaVTlJTlJH?=
 =?utf-8?B?NWdkQ1dHVzhmZW16ZFl6VGFlQVZGQnNBenZ2MjJKWC9xc3ZEZXhjRmgvd2dy?=
 =?utf-8?B?OFhvOUdlY2thWTAxenk2WTRFZkUwS1hBeUZLY3QwTHNmYlFjSll1NjlUTzBL?=
 =?utf-8?B?aVo2aERZVUZORGxreW5lOFJZbTVHaWpENWxDY3ZnbkVXamdac3NIRWFBNEpq?=
 =?utf-8?B?TzNRSi96TnN2dFd3WUtFU0tGTmVTRkdsSEJGaDZxWnFHeE1kMi9VemZ1cndQ?=
 =?utf-8?B?M0s2QkpwZVJidXVDUlZENTB2bXFjWlNyeGgvVkZpWS9jbkxwRkVkNG1HUmxW?=
 =?utf-8?B?YWl4bGFLOW9kYWRteGg3ZlFseWVOazk0K0Erb3hZVVZROVN1cWRnN2ZuZ2I2?=
 =?utf-8?B?WTVJZUd2bVVoV2hia3J2b2Rld1lpczYwRk9tL0pTdlNXK3VyMEhmN3RrMVRX?=
 =?utf-8?B?SmxPbDFhZGFSbkIrT2FTbmVIczRXMTlkOFFvNHVLVS9aN2N4Vk1VV01ROGgy?=
 =?utf-8?B?dWV0UUdtUXVRWXJ5cWpGNURPeXFiOWR0clF4Umw0VHBSdGFqODFjK0F4K0dG?=
 =?utf-8?B?TW83UitkekdyYW9JNFlhRHhzcnpHd2RtWGQ2NU0zRUJMcHBjbExzekhTTkkv?=
 =?utf-8?B?ODA3YVpWcVRPaU0rQmY4R1A5M3NkUVpUNmxTOWZlZ1E1YTY0aVNwKzZmdkU1?=
 =?utf-8?B?N2ozVkhsOVlVemQ1ZzYybGFwNi9lVUxmK2NhQTVHb2lpUW5XYkV0TVk4NElx?=
 =?utf-8?B?UGZod0RVSkJFT3hXMWlydkpoSS8yQU9WYk5hdkthakpRQ0dKQXFFQ1l1bWdV?=
 =?utf-8?B?b213aG51bjIzSnMxNC84YWxDUFZyRklsb3ZiZXRVRERTNmRuOFhIdlY1SHUw?=
 =?utf-8?B?Q2MwbGJaUi82K08yeDhvTXY1dnliejNWNk1hR0Z2ZGltZVRIZlZIKzRJNmlt?=
 =?utf-8?B?dW1POC94M05DSXRGWlJxRlhpOXZjQjk5M3QycnM5aEh2ampwVS9iRTBtckR5?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95F2C9B6770D034EBB44065D7588F2CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efeb9ae-90cd-4e46-f81f-08dc551bce7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 02:55:09.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4lrt6YU3Pf5s8LPEa1fEAikcMV+5mLXJddLLmJvYm/nYTSojXtYVpqCqHa9BSkHWqhrPpHc9gt84JXOPPLpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDIwOjI0IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gQWdhaW4sIElNSE8gaGF2aW5nIENPTkZJR19DR1JPVVBfU0dYX0VQQyBoZXJlIGlzIHVnbHks
IGJlY2F1c2UgaXTCoCANCj4gPiBkb2Vzbid0IGV2ZW4NCj4gPiBtYXRjaCB0aGUgdHJ5X2NoYXJn
ZSgpIGFib3ZlLCB3aGljaCBkb2Vzbid0IGhhdmUgdGhlwqAgDQo+ID4gQ09ORklHX0NHUk9VUF9T
R1hfRVBDLg0KPiA+IA0KPiA+IElmIHlvdSBhZGQgYSB3cmFwcGVyIGluICJlcGNfY2dyb3VwLmgi
DQo+ID4gDQo+IEFncmVlLiBidXQgaW4gc2d4Lmggc28gc2d4X2VwY19wYWdlIHN0cnVjdCBpcyBu
b3QgZXhwb3NlZCBpbiBlcGNfY2dyb3VwLmguDQoNCkkgYW0gZmluZSB3aXRoIGFueSBwbGFjZSB0
aGF0IHN1aXRzLg0K

