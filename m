Return-Path: <cgroups+bounces-4557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C396403C
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 11:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602371C2482F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2518E033;
	Thu, 29 Aug 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKqvbj5j"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F818DF94;
	Thu, 29 Aug 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924058; cv=fail; b=DXWotUFT78OIBG0Gts9t6mN2UVho3cJ6Dvs7xhHUey3f77WfGqKdtICkoowNojgWFkjuSHPtXDH9Dtg1ZG7NzVWWgZLfTYvBTi9sC9Vyc3j4anJoGY/6A1Gnl3aHGRI0mLNCVdfJN8t8dSSM8IlGv5lndB0oFCrxl6itgy/Lugc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924058; c=relaxed/simple;
	bh=QpNP0wLhXxR3yaMSYKdnMJ92mePCr9sVZI2MRgQ4KOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VB49S5Ey5ljIrnOjmP1nPiiVp5ZahX7W0i/17myjnOlTX9lRmhYhkfT/BM/VZ8LNuJwIy9YBm7MbwR6KRX+u8XxtkDTYgIzRGqy3Q47AAIlnTp9/Kr5mJBrSgpYZ7zcykBXLExs0hRphP9DHRBl/sg6lLMZOBrW2H442qJMHdBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKqvbj5j; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724924057; x=1756460057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QpNP0wLhXxR3yaMSYKdnMJ92mePCr9sVZI2MRgQ4KOc=;
  b=HKqvbj5jmGZ/kxyAoRpoZTABkT/rO4zyyO+SN1IYG1IvdHsFaVRN/3K6
   QVQDFxI3rfUFhl0k4rKKexkiMN72GI7GLLPYjFG7AbOyhox2wB/GABzVF
   /B9MxlZF37xMjw3A4py2DzZjCjHOrX4rxgKsfQNx8e1llWRcN/gA2j5Ts
   ARkkHDrrEqbKeUp9AAr9g/mOuYP1RaINk0t4Fxrou98w+8SBdaZu/Dfis
   LXB6S9+R6NfRRWLMqlzdUg6zeQSTaFRxZ9iNY3aBCbwfnpeqay/NNP9Ha
   RTa1JtuUNmwUdc17VEsuLW2eP4pT/i0MMAt3y8LBMnx7LNXh0iISTHew3
   w==;
X-CSE-ConnectionGUID: vsPvcIvQSiykgWwXW8Dydw==
X-CSE-MsgGUID: Ny5Ux3kYTQWD9eAkOv5rng==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34659205"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34659205"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:34:16 -0700
X-CSE-ConnectionGUID: X+ivRsw+QzCprSuZ7HJZwg==
X-CSE-MsgGUID: 8Wwh/IFVTvCZurCpTkxz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94257248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 02:34:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 02:34:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 02:34:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 02:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuRs1ThXAaE0JQPmopGoeYWbOdNWeg45BGY/Nb9Ez5PTmE+X4/WZ2HnglvucNVLicpaHyP8lNBC+7Vr7GakzH+6Lf4ixpBQxUKaqHVnqmUFwqA2WhMI5s2ufwgDADlMzKLnrdkdDWF067c71/QmDNk2x27z5iCsuoaU4cydNn9UWEdn3/ja4fxY20io/9TMezcQEkFoWbeCJa32+kutPQ/1tQ+CR+qhbZhxh0vzTBbhU35885ox3epzPZ8HapkDR3mtFwGecvpeXnHJdt9O+8eOJM0NJwCkh4zDgeYVazxAzwpVk2hYziS09y3stcz7ZdJdzDTePsk2Tlj2+z9sg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpNP0wLhXxR3yaMSYKdnMJ92mePCr9sVZI2MRgQ4KOc=;
 b=OdmTFo7pT3ny8AiIe9rZJ9/DINpI9EmQXTPW8ZwfRmGxVeRi9Zwvp1zxip1uWO+VO4kOEsEYGYyePiVEqePCcp2FCigdwZH/BDXr+n27+PAXaBVVIfzRzFzFmwkLQQhMNZDEL4jZxzQEPl+VX8lY9lTMqXxmw3+0o7npHQD+cq3nToGvhCY56bbMgryZHkEBBoGXBhfjiMvkPgaP/ykkgGdWOjPpNcCg+dLh5YFOZoymtAwm/RaJqHWwBFkaHkBvXrF9TT9hY7vJZVeceuEfoBpcW3X27eamylu1o+LZagPoV5xldc7iY5sF3VM+N4ahFRIZwM6ohcNA4BTQwbhcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 09:34:09 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 09:34:09 +0000
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
Subject: Re: [PATCH v16 13/16] x86/sgx: implement direct reclamation for
 cgroups
Thread-Topic: [PATCH v16 13/16] x86/sgx: implement direct reclamation for
 cgroups
Thread-Index: AQHa820SQT9mtRsaLkSmlgfKJARr37I70joAgAI0HIA=
Date: Thu, 29 Aug 2024 09:34:09 +0000
Message-ID: <cfd5b871796b65e604dfe2c29e69377fb769ea97.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-14-haitao.huang@linux.intel.com>
	 <6562ecf0-c9e4-44ce-9bb0-91cf96b3f866@intel.com>
In-Reply-To: <6562ecf0-c9e4-44ce-9bb0-91cf96b3f866@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: 05de26d9-de56-45de-9a7d-08dcc80dbc24
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEVlQk1UZlZxVXFkN1h6YkZTQ1c0b1dNQXpFcGtjc3lWa20yenJ4WU54cW9C?=
 =?utf-8?B?NHdUN3BZVjVYRkJsb21hMGFiV0t2V0c5SHhpWFJkeUZZand3YU1hem9WOUs3?=
 =?utf-8?B?QnpXTGFnM1d0WGNxNjFObFo1cWNlazBwdThQaFFIejR6TXRlK0hVY21pK1Nw?=
 =?utf-8?B?SkcwNXNyMG9OWUhHdndRMDZYdGVvbnZFOUYxVDlVVGZPNmxZWENwVnVWdFY4?=
 =?utf-8?B?TEtvcDFLdStORmxZK3o3OTRRZE8vY2wvYm1WUGUxb3JkK05rZjI0RzhYODJY?=
 =?utf-8?B?elB4cHJIa0hDZTA2ZVFiRmN6b0VZYXpzREZPZFZBdDJISFFhcUhLR2JZZUxj?=
 =?utf-8?B?c2V4OGh3bkEvSVFncExIb3Jabmw3UDdldmUxNmpVMlJhRFlYSy9STWZWandj?=
 =?utf-8?B?ZFBhNXRhYXVhVUx5U05TR3pGSXdaOTZMNmcyNGVwMHJFa2xuZ1ladkRLVXhu?=
 =?utf-8?B?Rk10U0k1R3BUK2xjTk1UVEdudEZqZG41MUdiRWdkdUtQbGFKYXQvL3N0dzc4?=
 =?utf-8?B?WjJkNWxBN0tqMXgvOTJmMWYzdi9kbUhZSVY3N05rVUJnQW9SODEzRzd5UGtp?=
 =?utf-8?B?c0J3aDlKcDhSSnBxV0FpL0diMU1LaUFjQ3ZQbU02U3pyOFE4RGtCbUxiSDUr?=
 =?utf-8?B?b3EyRTd0bSs2YkNlanVocjZ2Y2luaisrOGZnZHMvbk8vNUszaUpmYkdYUnR2?=
 =?utf-8?B?NG81ZEZ4NzJZdjJKUkJ3SVVRcksrV050OWV3bDNHU1hjWFJ0ME12dThPOEhz?=
 =?utf-8?B?L2F1ME0xTXJEZnl6UnhDWUd0cllGZ0RsZDdKQVhsV05Dbjdzekw4UEhSNWdT?=
 =?utf-8?B?Ukx6MUtFSC9KTmlseUhLZmE1T1JkRGgyYXBtR2s2UWRLY2E2QkFyQ2VPeitN?=
 =?utf-8?B?LzNjYmxsdG1qYUlvczlBL3I0ank4QnlVMTBxS2hpNmRaNk9jVkx4U2h0ci9R?=
 =?utf-8?B?UmZrb0x0Zkx6Y29qa3Y1WDZaWittQmloSDFWQ3dQR0k2NFUyMXVUbW96dTB3?=
 =?utf-8?B?WFU1cUdjRXA5Zm9nNTEvM1BKb0NuWXhSdzBqOG9YcFA3NlFuVkYyR1ZZRGlX?=
 =?utf-8?B?SG05d1ViR2FKbUtyQnhoU2RsRm1pWkJGaHQybkY5OXdLZ0JMVEFVVmlibzFU?=
 =?utf-8?B?TFV1R1ZpWVMxQWRkdFRwaDlEN1cvVGc5R1R6SzZscmMvQlhBNUpBREU2OVkv?=
 =?utf-8?B?R1pmUEpzLzZXNFV6bG5MZjJ0VFJOZTNNTk8rZ3NkT2V6YjhkMHZVejZxblU4?=
 =?utf-8?B?T0NTcFpuYnVTT2ZIeXN5TC9aZGc3WEhHM29kRnV1ZDFrQTM2UytJdG4xNDFE?=
 =?utf-8?B?aEZvV0k1cUlySUVGcGhQdEVDVXhmYnNRVkthRTNkYVNRaE1VTVBBU3FVa1dR?=
 =?utf-8?B?eUZmUGFDbGg3TlhINFBBSWU4ekVoRXRSMGxKejBLVVhqYXNhQ3RucXoybHhO?=
 =?utf-8?B?Q244RERlbDlQczdoM0RuTzZaRUw1bUF5REwxT1ltWGJQY0NhekFYVjdDRmlk?=
 =?utf-8?B?QzJncVRFT1U3RkloY21ndmdLdklSbFhuWmtvK3NqbTIzV25SaVZoUGpYdjlE?=
 =?utf-8?B?UFpjTmVJaXJmY001dnpwSzdhSmVsNGNKbkh4STR1LzAveWIwRW9NQ0lZTXhs?=
 =?utf-8?B?akxNaFdUZnpkakI2bUpTRDFrWUx6L3MxU0hnVXlTSlJVODlUTWt4a1J1Y0Vj?=
 =?utf-8?B?b0dvUUVrcHJiUkllYk5ibU5aOVpjRzErZ3o2blMvUkFUQXo4TVBidm1sclFE?=
 =?utf-8?B?cWI2YkFNeVI4NDRZQkxiS2FZeGpCd0lhQzJ5UDJOYmpJSC9rYXdEbnp3RmNw?=
 =?utf-8?B?NTcxWDJXTjlTeS9QdTFRQ3pteklGeHRhOFNBN2VvZWF0eEExU1p4aUx0Njl6?=
 =?utf-8?B?WmQvdkJwQkVzYUlRYXcrNkczM0xFczZ2aUFXNmVWT2w3OVk4ZnRrTzhqWHdx?=
 =?utf-8?Q?bVaL0Eimlq0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhLbENEZ09tUXY4bU9tN2dPNmFqd001Zmg5QVJST216MENlRVFVOEUxS1NB?=
 =?utf-8?B?VkNaS0dRV0NOcXlyL01Ha1JtYzA5QitkY1JnWkR4Y1MwWWdJVmR6M1U0elF0?=
 =?utf-8?B?NlNYaWNZVUw1T1Fka3ZxU01CRXQ4djlaVjc2NGRMZGtud0ZwdS9lc1diMnZp?=
 =?utf-8?B?aXRaM1RlcXZyRzNWMGtwR3BqdDBxSVN5b2x4Wm5kNEprVVA4d28zdllDbExZ?=
 =?utf-8?B?T0s0MEZ6R0ROSDRQZDdsZWNDRm1hSXBGTzJSVzdnOWdkYllSMVAvd0VQK042?=
 =?utf-8?B?MlczNEIzb01HTkR1R3Zudm9rTTZGa2g2NHkxTFNtRmJvUW1mQ2lpT1ZmcmpR?=
 =?utf-8?B?SzR2MWhQd1k2bFE5Z3Q1VFcyNzhCSlRFRGprMjZtWnM1a0JKUnp4NzdSUnZC?=
 =?utf-8?B?K3A4eW5MSnpWWU9vOEpWaEIrN2U0RlBjQjZwY1FWQ2M4MTZDOTRYTlFxd083?=
 =?utf-8?B?ZVpmdDN6YjRsTUVhQUJVa21lZ2F0alY3VjBDUXNQY2JCTTFtbW1rNCtJamln?=
 =?utf-8?B?c1M0MldBYUVka1gwaWdlSmxqcFlSQ1FuQTk2YzVFeFdteEdXcldFYWQzSkVM?=
 =?utf-8?B?aHhabDRrQ1pDdHAzbTF3eldYM3dYei9VMTJTWE1JVk5jb3BwMjQzbjlsNlJT?=
 =?utf-8?B?bWdPN1VlYm5zanRpR3pNbWxaZC84bTQ0RDY2cE9IOWRWSUpXZVprblJkNjlt?=
 =?utf-8?B?elYwdlhleDlKVkJzQk1MaVNmQk1FU1daaWpLSTdrNjhUZFgzVkhiRnJOSGRz?=
 =?utf-8?B?ZkN6cFlQZ3dZYjR6QzlOK2doT3p4YkNLZjI0L1R2WVdlOGlqYWhMOXY5UUpQ?=
 =?utf-8?B?ZnlYUXFpU1RmRTY4V2R3NFV4MTVhU245dVdJWUxEZ1FHSVUrdkhaenZFUjBK?=
 =?utf-8?B?ODc4K3o0OVhhUWtxcndIOFBrZkVyKytpZ2g4bExwcEtmUDFObTViTHgxbXd2?=
 =?utf-8?B?SDRwS1lVM2ZPdWNoQU90QUJpMzJkL3JWV2ZuajVheXZkYmdabVJmL2xWelgw?=
 =?utf-8?B?cExmdm9UajhxSCtwa2FmYzhFakQzeVNPdHNHUlQxYzhKdDVxazJrOUV0a2Z1?=
 =?utf-8?B?WkhUNWFXeVUwMm56cjZHRU1FSW11dU1jc0ZhdVgvMGRKTlE2aVN1aEtqV2xS?=
 =?utf-8?B?RXUvcXVKSExPaDByK2I3NzFobXRQeG5YVEVqd2dyRE5wTWJXM1BhM2d1N2t4?=
 =?utf-8?B?ZWs3SWJiSTZlV0xIWHBxa1pWR0Q4MXdlSjdkclZEMTI3RTFLblc2SjYza1NN?=
 =?utf-8?B?dHhGdFZuaHZBWXlYTXhsQTBlOVFJZU9SVHowWmpsMWNCMUlaVFpLczNINE55?=
 =?utf-8?B?dHdObTFpdmRqYkMwZU1odFBDZWs4eDBPNUdicVdXeEJQaW1Vb09qejhBZHlh?=
 =?utf-8?B?WmJHVkFuQVlQaFgxdlFzYThnRGZidHI5Y1hNcFc2STk0b2tDcFl0WXVwM1lX?=
 =?utf-8?B?VGZGbTlMVDR5eEhRZ2k4ckV5bE5IeGdnL0pSdEtWWUNDbHE0T0paZCtPbzBp?=
 =?utf-8?B?ODhNTlJCM204SDFOS0xXNElrcEJQck4xcDJUellybnRWOEx1cUtncldCLzRz?=
 =?utf-8?B?WGhpM1NyTGxOUXZZNFlTUXdWS08vMFErRWZtMnJrcFJ2b2pmZk5mWlJ4YmFp?=
 =?utf-8?B?M3YxRk1jUll0Yml5QVFhUk9hYUQ2SzZqZ052VFByUFEwUmtDUkVtRUVxNW9k?=
 =?utf-8?B?VkhteWJmd3Nud1g5MmgvMWtRamRNdVM5Zks1NDVZZWEwMzR4bVpyR1U5RG9I?=
 =?utf-8?B?VGtlUFNPa3kreS9ZT2k2VTZSWDkrMjJMS1Q0YkpVaXZ1aVhRMCs2Vi9OeXlJ?=
 =?utf-8?B?Tkh5WE9TSTFEWmhEaS9zQjFSTndVNUFYZzd4U3NGbjJzZ3Jhbjd0SmloVHVC?=
 =?utf-8?B?ZGsvMkhKYmpzUllyNkt6TjdWTTZGU0xtZFJqaXIvK2JaaldOTm5laUE0ZVBt?=
 =?utf-8?B?QlZyVFVtNjFZUWdaR2g4VjR0aGZWV3lpOUx0WFp6NkxNM21JTDFDb09JUVFJ?=
 =?utf-8?B?K2x1QjhwZTRJMUlMQUlnL2NoSXVHczhGQzFWcXdPSlIvRWlFOThrUzNIUjdH?=
 =?utf-8?B?dWNrZ3Jic0pnV0c5US9oY0xEbHBScXJ2clZIczRUMWcxVUt3MzdZbHA0eFdu?=
 =?utf-8?Q?aQFJX9n2fMXZvHyLgns3npl4x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDD76A130F9A33429329848A4794F169@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05de26d9-de56-45de-9a7d-08dcc80dbc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 09:34:09.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssU0GJIMUoZvf3lksOEuGrDvPQq8okvAhEfU/4zDV0E9zpURCG43mJtf9FGtmHETN5rWNu0Zkj1vaWEHcBJrCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
X-OriginatorOrg: intel.com

DQo+IA0KPiAuLi4gZmVlbCBmcmVlIHRvIGFkZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBLYWkgSHVh
bmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+IA0KPiANCg0KT25lIG1vcmUgbml0cGlja2luZyBh
Ym91dCBwYXRjaCB0aXRsZToNCg0KImltcGxlbWVudCIgLT4gIkltcGxlbWVudCINCg==

