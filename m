Return-Path: <cgroups+bounces-4508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767839608BD
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049531F23C9E
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6F19F499;
	Tue, 27 Aug 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJEkfvOc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673719D8BF;
	Tue, 27 Aug 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758383; cv=fail; b=G46iNGNvxQOTQ7cnHnveG71IvdTSkz6GqFZYjbkScNYWrtsLUkfC+r7Z/2/PLGCtvZyoe/CgQgDRNWdEQhS3TSaxkv8phyUV7YlxG0l5DTQ9W0+bGuZQ6GkKdKZghWiS9PIeB2dNJ7COJlKuPoGgXiWMkZ+NJKpUFLC2SJJHv4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758383; c=relaxed/simple;
	bh=uWoD0VR03DyfGii5+Pk5sc4BoDsgKwYku3YdEOEwHYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G7vgXtUonKE9yipVQjUWlsPGfHZNXiSh4f0IvHKdwZOinmPn6CjB9EfsjwvbJ63b/XUJY/V4RfErQ9TZYCy2CTD/CoE02gvY2hrfqaaAq68AN+wEEduOb+Ae4Zl8yMC2UYbiU1wX15UH+ugWxaorVEq/ShF33boV4acmD4qgH8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJEkfvOc; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758382; x=1756294382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uWoD0VR03DyfGii5+Pk5sc4BoDsgKwYku3YdEOEwHYc=;
  b=AJEkfvOcfTqNBl9etaZB+17WfvgmLZXAlYlWuyq5seUT0zIfA44X0hBQ
   Q5Za4kZ4iH3YAJrjs5nzXr0SPvpHDJRq/yfgimFbcQQv2Oo+IMIYYm0t/
   v/vlQ/wDkU96ZaGl6tnEFIVI9beE7v0MGKEEuAjaCE7fdchhGDXmt9BIL
   wajpYZp+aCttCisA5cev5tDERUUYEVcUeu4oU4LBIOBVLuh5wX0vUgpIi
   r8DVSnmh3lGXlrPDJSljbw7+WhmB9ByeBAwVXqqKBhjoHC7Ao0cEjORrw
   HhkT3dexhX6B7259JhpyG7jl7xDRFI3PaIW7hcvcdlljqS9oMKiQKKcvN
   g==;
X-CSE-ConnectionGUID: uJjkpwPQQA+ngpnXBnSlTQ==
X-CSE-MsgGUID: HKKoIRDJRkqKkfxCkN/8ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23354382"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23354382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:33:02 -0700
X-CSE-ConnectionGUID: TDZP8cMxQtukBHo3GIFtFg==
X-CSE-MsgGUID: QCz0gZcRSlOdE5HdNiBOXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67662207"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:33:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:33:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpHRtfgkUKeR/zsjwiHw+tEKL5kXfdR0UyUUoagXoRkQ4IfWM9nJ0lvUG9fLVKToNkYMU7XJGUFGqE1Ly9gDTjMT6ZoZWsyqyQ7zH/loeEj3F52BZky2Lq+bXldmugxV9ltDAo/5Egl3NccjM08tNuJs/lZ6Kta8ukV3ijEeGHZs7sAr77s0RRcj0WiM5hAAMnyZDOit4exv2aVG4FmmqdaHKtsMdKB2oHu6R9dbcPyxjCUafe87/eJPhmC27o4TThF1OxCE2OdAsc7Eo01aM42BxvhQeM3+Fjl3d03icOZYacNDFfIGgaymm5rAKdt1JGiVlmGMoNer6Qg6o2QRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWoD0VR03DyfGii5+Pk5sc4BoDsgKwYku3YdEOEwHYc=;
 b=FgH+4VKmDtzUwVj7a1M8fzysMiBkoEQXsIW1R1gZX6zajsCki9JyrErHltU8SmSHVlisCGnosvoWVkk4WZf7sXT2kQYBv2ksur9HGCAhOX7ukfE6bw8UMMkBE7jiGNscoynCmnPZl719U0M2Xy6S3Q3Qn9sxnSEDJ4HWGpVc0/KxwbnlJdYaZGEwWcD8PffJolV55J6/YwZ7hdeQSAXyM6oquY8ectBzNO35tDunVKJ0TR1/QVhrd3HI7e+qzgj7dtUd+CvgTOIFBiCvf2ugs+3Cdsri23SONIoLrU/+ndgX6oy2ARwdKhSRlwc/6TCj33H6HqIkjgp55bh62Eq6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 11:32:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:32:52 +0000
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
Subject: Re: [PATCH v16 12/16] x86/sgx: Revise global reclamation for EPC
 cgroups
Thread-Topic: [PATCH v16 12/16] x86/sgx: Revise global reclamation for EPC
 cgroups
Thread-Index: AQHa820flyr87Kr4x0WbqhOs+F6QDrI7AtcA
Date: Tue, 27 Aug 2024 11:32:52 +0000
Message-ID: <99793ef7988905a15720c4955590a143313e6af6.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: 94ca15f8-b157-4049-d2a4-08dcc68bfce1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?REZneGsvWjJINm1PZUZPQVJXckZjMmNYTW1VZWNBNEVsYjY0UkVpUVNKVzc0?=
 =?utf-8?B?cCsxbkZZTjdPTnpnS2w4NWdHcEI1Q0VUZ2kvTnFGdXA1My9rU0ppYy9jQ0ps?=
 =?utf-8?B?WFFyUW02WkdRdXFhTkw4YjdXU00vdndzbzlFVjVqbm9oUzZpeUpoaWVpMWVM?=
 =?utf-8?B?NVlMY2RheHpYRHdNSlI0UjlLSC9QUVI2VEdHZERWYzZ4RzhWQ2g2cjZLNXhD?=
 =?utf-8?B?TFIybERUaFB6NWt4bVEzRWt0WGFOL3gwdXRRQWNEKzFvcXZkSnV1UTZPR3pT?=
 =?utf-8?B?ekJpN2t6VXJlYU1RT1psa3BhS3NLT3ZmeFRxS3hFNFpxeE8xUmkzNm1SblJw?=
 =?utf-8?B?cDl5TnNVa1ZQYTFtOFFvdFoxOFNKK1NrUUpkNWZiQXdJRmF5OEY0STY4WHlH?=
 =?utf-8?B?WXBZTzliWVFUaHc4VVVmRGVVYzhQUVVOQkhVc2R1OEdJZ3dZL1BNdkZJNEFy?=
 =?utf-8?B?MGl3Sk8zY3FuYWZ1UklKaHBmbEtNZ2xWSmRzNEhuNlFyempOZFFnVDhMVWF5?=
 =?utf-8?B?bGNEK1VsbHFSZjNranptMXl3Mmt0UlprSklpQTdGT2M4OEh3WGNVTmZlYnA0?=
 =?utf-8?B?Sjl6RS9ac3VGRlJ2a1MvUktuRTNrZ3Rsd2IwTmtZcHY0QkozdkJwbHFEM2Jw?=
 =?utf-8?B?MG9FcCtJSk1Fa3pSSUhMMTBQVU1YYXFyM0VZWGUyUzFDMTREbXVqb1RlRGZZ?=
 =?utf-8?B?VGwwSDhsamJIb3V5K2U4ZFpiVWVFd0FnZkduVkVmQjBlTTE0QnJTVUVZWDNz?=
 =?utf-8?B?K1FEVzhNVTlqUFp4NzJPdDBiNWM5STh6S1FobUpOVFdYV1ViNE41ckIvODlS?=
 =?utf-8?B?ajB2MDd3UlFnNWg0YUtPeVhPUXYvTjEvREkvU0I0M0QwWjlVQ0xqWW9qeVhY?=
 =?utf-8?B?Q2dtWTd3bG9haGZoUnJFL2tBblA1YWJhTFhKODV3NnMrdUQ2QmtnVGRCOGVG?=
 =?utf-8?B?NkZjaERBeGZ1d05XeW45VmxmRHAxZitIRjJhQ2pSYkp3dm5VS0RyUVZTbHQr?=
 =?utf-8?B?eHYxZTdEcVN5Uk9JWUtUUExuZE5QRlp2MGlYN0tOVXRkNVF0MzBVSU1xSVhw?=
 =?utf-8?B?eE1TRjF6dmxKRTlmRTJhQlVJMGpVdm1IN0VxT1lvcE9DQkdaclE0OGYyT1ly?=
 =?utf-8?B?NFgveGhVRTdFVHdJcE5aUFI3MG53YW9vcklVVGhEcGhHZU11cTltL1RmZHhr?=
 =?utf-8?B?Y2lRNkF6cjB5S0psNk5qQU5WN3hvSHRjZG92bm1NL05FVUJ1RVpubkVqL0lz?=
 =?utf-8?B?ZXVyNDgyWFZYZHNSRVkvaUZHYUVxYjlKZFB5eWZicjUybDBsYnBVSnlKM0VM?=
 =?utf-8?B?Q0kzcTc2aVZTTWJ3YTcxQytYMFpSazNyR1U0ZUkwNUtTWjdocEVaL0Mva0hy?=
 =?utf-8?B?WHphTzlqSzdkdjdXOU5RV0ZLZCt6S2NzbUFuMkNtamFHWlcvblFlcGVsYjQx?=
 =?utf-8?B?TEkzeHk2VENVa2IvSmhpdm5nL1pRWk5FUm1LQjA2cU5qYWFoN1R3VE9CYlFv?=
 =?utf-8?B?Y2M1R2p5a1NXNHB1TDZRRmNuYloyL3dsMG1FcGkyQ3MvdDB1YVNTcHR3eXJP?=
 =?utf-8?B?R3BaRmhibnllRksxNmRwNDQra3B0bFVjaFhscnJhSzlwRzNxN3dzTWd2SzZa?=
 =?utf-8?B?Zjh5dmF2Q29SUjFGaFFXVklwUk1jMCs4ZU5INkNYMkpsOGZGSXVtYUEvbGdx?=
 =?utf-8?B?Zi80ZVduWnk0TWVBYlEzbEhOa2JGZ2dhN3NxUHBIL2IyQVIwSXI5aXByM0hG?=
 =?utf-8?B?Mkx6WGt6c3IrUERaOEpkVzBYR2NSNkxCTW45OGc1QkxRNzAvUnJ2OHE4SU5t?=
 =?utf-8?B?cHpRR0crMnk1SDFTRDdoUmNvVzFPOXNibjBpVWhqcnBXUUZPVDNRb2RkNTY1?=
 =?utf-8?B?bFlSWWxlb1BhMld6MFMzMnpSSTlzWkRuRDg0MXBHeERwSlJnb21rUklFU1dk?=
 =?utf-8?Q?PFtyrb6Sdkk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVwc1lvUnQ4WThZY1pDeUt2Z01SU3p1aHV2V2pVU2diSE1tcjR3a2JWRWJT?=
 =?utf-8?B?ZTVxY0Z6dTdDYW9kNmZkSmExbmIxZmhsNURJaUI3UTZHb0tFcVVGcktWdFZz?=
 =?utf-8?B?RW9yNlczelI4QktZYTJBV2lkU09UdW84NklDYlg0OEVJZzhTWkg4a1V6ZG5E?=
 =?utf-8?B?Zk5TWURyR3c5dUZhUnUrU1VqS0NaYWNzSlY1Y2txeFkxcVZac1dRbitHZHVF?=
 =?utf-8?B?MWFrVFlkMDVRbjlUalBnZzRGSDJ5ZWJ3bWh3c1dRMkE2NjhmTHZXRU9Qd3Rk?=
 =?utf-8?B?TlRYb3VPcXBGR01aOGR5eFRKOUIyZ2hmNzlzd29ZaEFoVHJMaDdobXNNZVZk?=
 =?utf-8?B?aFNRQ2VxWnhMSnJHa2xLeFZDSVlReFljZ3EvckhXS0pTbE5LMFJqM0d2WlZ5?=
 =?utf-8?B?eHA1UDhsN3NHaVRPb0FTSmtYaUhQRHcrRGhNNUdqL1R4cTdyOUFDYlVmRjZ4?=
 =?utf-8?B?VTRRY2Jtc1BMLytTRGllT1hpSExaYmVOc2o2Yk5tOFdHUllDR0R3anFIdHow?=
 =?utf-8?B?UTljdHlaVmxrcGI3cG83Zmdqa2xFNytBVG1ZVk1MTC80b3F0Snh1YnoyMnlT?=
 =?utf-8?B?K2FnT3J4MmozUWxEbmVOK0licmo3amZxWjZCVFdrbVRZcmtQV0NKVWpCVnUv?=
 =?utf-8?B?dFNXVW1Yd3BpTUZOcWNYZjN5QUh5L1hrQlhOUTN0dWJQa1QwNXVvSDBRamlK?=
 =?utf-8?B?UnF3a2x1VWw3TGx0RFdEM3pJeEVkWHlyNkRpYkVmMk9IdjNNVm1CMktpeElB?=
 =?utf-8?B?QnJUc0NjaTAvMVJ6TUQ1RGMreHFKZjM0aE9NUy9VUFZUaGZoaDhlRXZzelVk?=
 =?utf-8?B?WjJLT1JXMi9zS3JaSDlGOE9iRWthSS92ZkE0YnZVdW9PdHZDUjlCOGIrZmlj?=
 =?utf-8?B?T0JzZENRVGx4YVRnWmFzcmY5d2dCSFRDVGRUL0NkaGNURTU0b2gwOHhkaDdO?=
 =?utf-8?B?Y21FR3M4L0pTTVlyRTRWczA4RllTVTM0bnRuMHJMaHRBL3dhY2FQc2VpM3Nn?=
 =?utf-8?B?RDhqcUtvRzZxRmNUTnRndk1KZ3hrT25pcklTVDBvWGdmTHhYSDRFTmJjVDNP?=
 =?utf-8?B?elRZYXVJbjZnTmE0My8xUmg4Szc5UVN5Zng0MnkwQXBNQzV1a1F2UCs4Sldt?=
 =?utf-8?B?R0NOenB1QUhSVzdYcDZEeURlS2F4dmFhZWxObFQvK3BEZVk3WjI3aEhVZndY?=
 =?utf-8?B?QkVhSGZmWjV4MnhRU29pTzc1akxIZ3MvMU90ZUtiYm1LamdpeUhKdkNLcjdz?=
 =?utf-8?B?a1FhR3BWZHc4ME1VQmZyL0xyUVdVbkF5Y0U4Y1NuYnpmL3pjNU1vL3BvK0ta?=
 =?utf-8?B?N0ZuVFhyeDBXZEJJdHdXWE5ORkZ6aERpek8xd0g1TjhEd0JOeVYrUG5QTnhK?=
 =?utf-8?B?TWZVbVUwMUxPN2V1eXMzTjZYZTA2eFZUaDZsVUFtL0dTWVJZVzVCd0pidDFq?=
 =?utf-8?B?WEpDT2JGUlVWaDNJVmJUY3d5RWJ5ZU5mN1YrMWViVS9XK3plR3pZb1FrV3M0?=
 =?utf-8?B?Q2pkTi9pVVJ4bklDWkVxNVlaa2lVWjdLSmpITmlYdkdZLzcxT3pkeGdWNHN2?=
 =?utf-8?B?N2h0MmRYK3BUbXpNcFd6bW8vMEczQ3hZWmpnSlVRQ0wwYmU1TmZ5dThYK3R2?=
 =?utf-8?B?R0JBbjVaVUlhNW5leEpSd0NZdHlqRDNHVHROSXQrTERJVXUwRUgwZTNIU3dq?=
 =?utf-8?B?aS8vQ3lyR0tjYVIrUEY5WmdGVnhIOUdFODZXUG1peWxYdGtYQ3M5V2luc2Q4?=
 =?utf-8?B?M3J5cXBxMnUwMDZTUHkwcDM0bHZkdFA0TkRYbW1nRVh1OXlIUkVPaGdxWHF5?=
 =?utf-8?B?WTNsSWhXL1ZIaXZaYU9FN2lpbUZjVnlkRmxjZjRrWWlEZ0lRZEtid2tLaTNJ?=
 =?utf-8?B?RHA2N0RKV1JJeW9KZ2NIeEY3M0R1empZdFZwcDhPdVZGcGFyejgwZTF4U3Zo?=
 =?utf-8?B?NHJjUDRUeElDRXRobnVMMU5CZnFDZU9jWnpXRk1RV2pzYXpzcWl3ZUtSaFNU?=
 =?utf-8?B?QytNZEVOMlgvY08yWDJtRmVYWFZWWnJzdWFIc1A0akU5N2diMFZEWE1NTGVM?=
 =?utf-8?B?RTJ1RzBFTExiTStmRTQ5WS9pcWhqMzdEc09vak5pSFhMRGN5bURqR3RWNWQ1?=
 =?utf-8?Q?IV9oYIzQXmTeydpSnGCoLG+uj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF162CB848A3E4449FB8E1FA240C4EDE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ca15f8-b157-4049-d2a4-08dcc68bfce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:32:52.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBCqbAawTKnhyomVkLaun3spIRsk9rce4LqkYrWJ7hDhVBh0tQIKzKrmeGR+vURO3RxRSxAiGvymW6elINW7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjU0IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFdpdGggRVBDIGNncm91cHMsIHRoZSBnbG9iYWwgcmVjbGFtYXRpb24gZnVuY3Rpb24sDQo+IHNn
eF9yZWNsYWltX3BhZ2VzX2dsb2JhbCgpLCBjYW4gbm8gbG9uZ2VyIGFwcGx5IHRvIHRoZSBnbG9i
YWwgTFJVIGFzDQo+IHBhZ2VzIGFyZSBub3cgaW4gcGVyLWNncm91cCBMUlVzLg0KPiANCj4gQ3Jl
YXRlIGEgd3JhcHBlciwgc2d4X2Nncm91cF9yZWNsYWltX2dsb2JhbCgpIHRvIGludm9rZQ0KPiBz
Z3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSBwYXNzaW5nIGluIHRoZSByb290IGNncm91cC7CoA0K
PiANCg0KWy4uLl0NCg0KPiBDYWxsIHRoaXMgd3JhcHBlcg0KPiBmcm9tIHNneF9yZWNsYWltX3Bh
Z2VzX2dsb2JhbCgpIHdoZW4gY2dyb3VwIGlzIGVuYWJsZWQuwqANCj4gDQoNClRoaXMgaXMgbm90
IGRvbmUgaW4gdGhpcyBwYXRjaC4NCg0KPiBUaGUgd3JhcHBlciB3aWxsDQo+IHNjYW4gYW5kIGF0
dGVtcHQgdG8gcmVjbGFpbSBTR1hfTlJfVE9fU0NBTiBwYWdlcyBqdXN0IGxpa2UgdGhlIGN1cnJl
bnQNCj4gZ2xvYmFsIHJlY2xhaW0uDQo+IA0KPiBOb3RlIHRoaXMgc2ltcGxlIGltcGxlbWVudGF0
aW9uIGRvZXNuJ3QgX2V4YWN0bHlfIG1pbWljIHRoZSBjdXJyZW50DQo+IGdsb2JhbCBFUEMgcmVj
bGFpbSAod2hpY2ggYWx3YXlzIHRyaWVzIHRvIGRvIHRoZSBhY3R1YWwgcmVjbGFpbSBpbiBiYXRj
aA0KPiBvZiBTR1hfTlJfVE9fU0NBTiBwYWdlcyk6IGluIHJhcmUgY2FzZXMgd2hlbiBMUlVzIGhh
dmUgbGVzcyB0aGFuDQo+IFNHWF9OUl9UT19TQ0FOIHJlY2xhaW1hYmxlIHBhZ2VzLCB0aGUgYWN0
dWFsIHJlY2xhaW0gb2YgRVBDIHBhZ2VzIHdpbGwNCj4gYmUgc3BsaXQgaW50byBzbWFsbGVyIGJh
dGNoZXMgX2Fjcm9zc18gbXVsdGlwbGUgTFJVcyB3aXRoIGVhY2ggYmVpbmcNCj4gc21hbGxlciB0
aGFuIFNHWF9OUl9UT19TQ0FOIHBhZ2VzLg0KPiANCj4gQSBtb3JlIHByZWNpc2Ugd2F5IHRvIG1p
bWljIHRoZSBjdXJyZW50IGdsb2JhbCBFUEMgcmVjbGFpbSB3b3VsZCBiZSB0bw0KPiBoYXZlIGEg
bmV3IGZ1bmN0aW9uIHRvIG9ubHkgInNjYW4iIChvciAiaXNvbGF0ZSIpIFNHWF9OUl9UT19TQ0FO
IHBhZ2VzDQo+IF9hY3Jvc3NfIHRoZSBnaXZlbiBFUEMgY2dyb3VwIF9BTkRfIGl0cyBkZXNjZW5k
YW50cywgYW5kIHRoZW4gZG8gdGhlDQo+IGFjdHVhbCByZWNsYWltIGluIG9uZSBiYXRjaC4gIEJ1
dCB0aGlzIGlzIHVubmVjZXNzYXJpbHkgY29tcGxpY2F0ZWQgYXQNCj4gdGhpcyBzdGFnZSB0byBh
ZGRyZXNzIHN1Y2ggcmFyZSBjYXNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFu
ZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJu
ZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMgfCAxMiArKysrKysrKysrKysNCj4gIGFyY2gveDg2L2tl
cm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaCB8ICAzICsrKw0KPiAgYXJjaC94ODYva2VybmVsL2Nw
dS9zZ3gvbWFpbi5jICAgICAgIHwgIDcgKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gv
ZXBjX2Nncm91cC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5jDQo+IGlu
ZGV4IGFlNjVjYWM4NThmOC4uMjNhNjE2ODllMGQ5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9z
Z3gvZXBjX2Nncm91cC5jDQo+IEBAIC0yNDAsNiArMjQwLDE4IEBAIHN0YXRpYyBib29sIHNneF9j
Z3JvdXBfc2hvdWxkX3JlY2xhaW0oc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZykNCj4gIAlyZXR1
cm4gKGN1ciA+PSBtYXgpOw0KPiAgfQ0KPiAgDQo+ICsvKioNCj4gKyAqIHNneF9jZ3JvdXBfcmVj
bGFpbV9wYWdlc19nbG9iYWwoKSAtIFBlcmZvcm0gb25lIHJvdW5kIG9mIGdsb2JhbCByZWNsYW1h
dGlvbi4NCj4gKyAqDQo+ICsgKiBAY2hhcmdlX21tOglUaGUgbW0gdG8gYmUgY2hhcmdlZCBmb3Ig
dGhlIGJhY2tpbmcgc3RvcmUgb2YgcmVjbGFpbWVkIHBhZ2VzLg0KPiArICoNCj4gKyAqIFRyeSB0
byBzY2FuIGFuZCBhdHRlbXB0IHJlY2xhbWF0aW9uIGZyb20gcm9vdCBjZ3JvdXAgZm9yICVTR1hf
TlJfVE9fU0NBTiBwYWdlcy4NCj4gKyAqLw0KPiArdm9pZCBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFn
ZXNfZ2xvYmFsKHN0cnVjdCBtbV9zdHJ1Y3QgKmNoYXJnZV9tbSkNCj4gK3sNCj4gKwlzZ3hfY2dy
b3VwX3JlY2xhaW1fcGFnZXMoJnNneF9jZ19yb290LCBjaGFyZ2VfbW0sIFNHWF9OUl9UT19TQ0FO
KTsNCj4gK30NCj4gKw0KPiANCg0KWy4uLl0NCg0KPiAgDQo+ICBzdGF0aWMgdm9pZCBzZ3hfcmVj
bGFpbV9wYWdlc19nbG9iYWwoc3RydWN0IG1tX3N0cnVjdCAqY2hhcmdlX21tKQ0KPiAgew0KPiAr
CS8qDQo+ICsJICogTm93IGFsbCBFUEMgcGFnZXMgYXJlIHN0aWxsIHRyYWNrZWQgaW4gdGhlIEBz
Z3hfZ2xvYmFsX2xydS4NCj4gKwkgKiBTdGlsbCByZWNsYWltIGZyb20gaXQuDQo+ICsJICoNCj4g
KwkgKiBXaGVuIEVQQyBwYWdlcyBhcmUgdHJhY2tlZCBpbiB0aGUgYWN0dWFsIHBlci1jZ3JvdXAg
TFJVcywNCj4gKwkgKiBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXNfZ2xvYmFsKCkgd2lsbCBiZSBj
YWxsZWQuDQo+ICsJICovDQo+ICAJc2d4X3JlY2xhaW1fcGFnZXMoJnNneF9nbG9iYWxfbHJ1LCBj
aGFyZ2VfbW0pOw0KPiAgfQ0KPiAgDQoNCkkgZGlkbid0IHJlYWxpemUgdGhlIG9ubHkgZnVuY3Rp
b25hbCBjaGFuZ2Ugb2YgdGhpcyBwYXRjaCBpcyB0byBhZGQgYSBuZXcNCmhlbHBlciBzZ3hfY2dy
b3VwX3JlY2xhaW1fcGFnZXNfZ2xvYmFsKCkgKGhtbS4uLiBpdCdzIG5vdCBldmVuIGEgZnVuY3Rp
b25hbA0KY2hhbmdlIGJlY2F1c2UgdGhlIGhlbHBlciBpc24ndCBjYWxsZWQpLg0KDQpJdCBtaWdo
dCBtYWtlIHNlbnNlIHRvIGhhdmUgdGhpcyBhcyBhIHNlcGFyYXRlIHBhdGNoIHdpdGggdGhlIGNv
bW1lbnQgb2YNCnNneF9jYW5fcmVjbGFpbV9nbG9iYWwoKSBiZWluZyBtb3ZlZCBoZXJlLCBmcm9t
IHRoZSBwZXJzcGVjdGl2ZSB0aGF0IHRoaXMNCnBhdGNoIG9ubHkgYWRkcyB0aGUgYnVpbGRpbmcg
YmxvY2sgdG8gZG8gZ2xvYmFsIHJlY2xhaW0gZnJvbSBwZXItY2dyb3VwIExSVXMNCmJ1dCBkb2Vz
bid0IGFjdHVhbGx5IHR1cm4gdGhhdCBvbi4NCg0KQnV0IGdpdmVuIHRoaXMgcGF0Y2ggb25seSBh
ZGRzIGEgaGVscGVyIGl0IG1pZ2h0IGFsc28gbWFrZSBzZW5zZSB0byBqdXN0IG1lcmdlDQp0aGlz
IHdpdGggdGhlIHBhdGNoICJ4ODYvc2d4OiBUdXJuIG9uIHBlci1jZ3JvdXAgRVBDIHJlY2xhbWF0
aW9uIi4NCg0KSSBoYXZlIG5vIGhhcmQgb3BpbmlvbiBvbiB0aGlzLiAgTWF5YmUgd2UgY2FuIGtl
ZXAgdGhlIGN1cnJlbnQgd2F5IHVubGVzcw0Kb3RoZXIgcGVvcGxlIGNvbW1lbnQgaW4uDQoNCkJ0
dywgSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5IHlvdSBwbGFjZWQgdGhpcyBwYXRjaCBoZXJlLiAg
SXQgc2hvdWxkIGJlIHBsYWNlZA0KcmlnaHQgYmVmb3JlIHRoZSBwYXRjaCAieDg2L3NneDogVHVy
biBvbiBwZXItY2dyb3VwIEVQQyByZWNsYW1hdGlvbiIgKGlmIHdlDQp3YW50IHRvIG1ha2UgdGhp
cyBhcyBhIHNlcGFyYXRlIHBhdGNoKS4NCg0KT3IsIHRoZSBwYXRjaCAieDg2L3NneDogaW1wbGVt
ZW50IGRpcmVjdCByZWNsYW1hdGlvbiBmb3IgY2dyb3VwcyIgc2hvdWxkIGJlDQptb3ZlZCB0byBh
biBlYXJsaWVyIHBsYWNlIGFmdGVyIHBhdGNoICJ4ODYvc2d4OiBJbXBsZW1lbnQgYXN5bmMgcmVj
bGFtYXRpb24NCmZvciBjZ3JvdXAiLg0KDQo=

