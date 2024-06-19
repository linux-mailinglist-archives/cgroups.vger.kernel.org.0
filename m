Return-Path: <cgroups+bounces-3236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD190E178
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 04:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFC1F223A6
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288E44C6C;
	Wed, 19 Jun 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LH5Du5Fa"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8213D57E;
	Wed, 19 Jun 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762415; cv=fail; b=anC2MTY3jtO5YzGDrwpvNMnx67/5hrlWqJKRYWTvRISfH5cLiKUJXAa/SKPRQwC41jgQfSzhw8J7jN/4zK4FffgvxIGgELiw/q43dVNhXcw24N6au/h6ELaTMBqep+t7en5z0I8OEvWTQdzUndRgm4btAavii4YQkFppcPnhCYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762415; c=relaxed/simple;
	bh=1fnUJMkZJmnT9bejU1poCYdZqZJs5FBN9z2ObVBDdRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tLJqqH5+P5ls5m0tla+VY5n8BixsZvLE5GSk8y3WDLUWLz6Cvy/IuofFaxRXv6IIDipEKwPUR0LcvXvHN+ugZwzZF4eJZDst/Na9n/NPgT0yPDBQOyqBxHSfq0bPG0zAHKz9ygYpYQG68Jre7m+ui2SnBp+JLlO+wnvK5rDSX0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LH5Du5Fa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718762413; x=1750298413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1fnUJMkZJmnT9bejU1poCYdZqZJs5FBN9z2ObVBDdRY=;
  b=LH5Du5FaBogqt2TRTIZsmXuWS+FL+v5dhTXuQSoZL5PdInrh+Pwt/QeY
   6eKY+MnCPS1WVDQVwY5XHQApw6BMTNS/B0NMt8K8p5IcH7h9VTIA2LtBQ
   JXBFjWMzB2Qrq4ODs/sgE9F7B6mP9Tl5Pt3JV9m9FCn1xVJ4Fs/CiEJjv
   wX0Eh8paxEKkV7oi5fEYAX10LbUx/LxveI45G3+oznJL+1AxMk+SAnXmA
   6hZCiLDexwRDSxRrmGz43gvgZIkIanpvwO5SJ2NHnwLKpCQEbs8N+ZL1S
   Coy0AvKjzc2xUDEhdThoxHFKkymsBIHIYZfi1C8nvC76AmIB1ntFyCLo+
   A==;
X-CSE-ConnectionGUID: HQqwjybySGmMRGg43bZqUg==
X-CSE-MsgGUID: AyxDNoj8S1q8X5tVtr2mLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15392084"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15392084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 19:00:11 -0700
X-CSE-ConnectionGUID: IWnXB67kS3Sgz+CgCkvXnw==
X-CSE-MsgGUID: ns6o7zAFSaigwh6jgeQ8Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="42228276"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 19:00:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 19:00:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 19:00:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 19:00:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 19:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DemYXsd94MM7WFYQyPTftXG+3cJ/tX4SDAKVuMywL2K9d8bckXacrKSfzRl5hzZCjIRAcMq2xGFa9EJVbbtIjkj91TIu/SIPJ0tCFJAtkHZIR+P81KImS+hwJJoanX/ss9D6uNtNjpNXv3KkgSizgpQPMFucnSE+admEkLWkYXNHFFjA20mrJ3cF+FQPxK/IqasQXMv+d5KNvTDSySHGUhCszUCcs6CslIlYDi6QpPW4adT+1lsnizcWZ0dpz387aaBiPfAgFclLZa1fVJ6weGXOf22RMm72oLzZXizBLEnnRLVVGEkb/8cU5orQu9IROM+IUBAltR8+a2ld5Ujyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fnUJMkZJmnT9bejU1poCYdZqZJs5FBN9z2ObVBDdRY=;
 b=eOuEBL6XqI/8wIjaHZr1tXAPm3iJt3Tk1iYemQjUXUqhLIHzxu2d97xtfO0LOlJ9nJKIDvKipPJvW1/pcuxDbz/Uye2CaSw8M9OKsIqdwCeM+yzHIOmsa3HQp20dwe93MXKvhFq1N+YVkIqCnlsASxixXBc/ARr6uc+W9/GzQdRQy0nSqBIeSr5Fu++1FItnKquNGa2xlR6inIiQcBiq4DM1fPRe0IYo5bMrzTru25AzF/o7AxFeZMLumkpv0Y+hXxC/S3Biiy0zPBiqZY+KkizabnIgYgQzTTxD3dC6UeRi/afMbcg1g9fUU4vh5A3ghUluE/blPhrxsVrAXeln+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8300.namprd11.prod.outlook.com (2603:10b6:a03:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Wed, 19 Jun
 2024 02:00:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 02:00:01 +0000
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
Subject: Re: [PATCH v15 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v15 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHawLVpCFAs5aGEAU+I+soWZvGHW7HNZJYAgAAX1QCAAKz/AIAAAjcAgAArvAA=
Date: Wed, 19 Jun 2024 02:00:01 +0000
Message-ID: <34db1b542d9fe5f2a3bc0bbc3af85d4437b9ac73.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-6-haitao.huang@linux.intel.com>
	 <aa686e57fad34041fb941f87c10fb017f048d29f.camel@intel.com>
	 <op.2pkbj8lbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <b2ee67d2d1540c1eca1545a4121a4f9b34036e06.camel@intel.com>
	 <op.2pk4letowjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2pk4letowjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8300:EE_
x-ms-office365-filtering-correlation-id: 5560182a-b4c8-4f5c-4fce-08dc90038789
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?RHhIT1Jyd0d4ZlJ0dVdNWHJkS2U3ZmJtcDY3QXJESHpKZzhaRHlNd2Yrb2d0?=
 =?utf-8?B?bjduOXdJUEhRMk1OaGMxVWNhVlUvZEZYQnFXZzk3YXlqZVN4NGM4UkFQRkQv?=
 =?utf-8?B?aURkcHFSUnFYNDZHVzBZUW5zY0hOM2FLRDVzNlNIbCtjY3o5VTBGdVV0c1RE?=
 =?utf-8?B?N1djOXY0VERBNysySlNjTjg2SFJVdXZyT0haNGQ5bTZPSTJvUGVaQVNIOEM5?=
 =?utf-8?B?eStTTS9iSm1LK2tjdFJOSkRiWW85WFl5ZHNPZ0pGYWJ1MndDNWVjV2dFSXJO?=
 =?utf-8?B?L0pXL2NlT3VVYlJxMFJ1MG9teXUzK0dscWUxS2QvRGhrTDFaSmxCbGVRc0h5?=
 =?utf-8?B?QjhBVm0vaTlWc3NqcUpWSHFtWHhQbjBVQVhuK2g1ZFBtbW5ISzNsbGxHa3R5?=
 =?utf-8?B?cUdKSW02M0pnNTlXL3NQNFlFb2Y2RWRCcFJycjRUL0c1NUhVbGpYSG9BMGwv?=
 =?utf-8?B?NTJnNGpFNnBlUHZRZS9CVW5PdWIvQ2w0RFRZRThuSFQwQmU4eGk1SVF3Ymgy?=
 =?utf-8?B?ZjRrUmFaaGo0TjF3eHdUU0R3aXhraHVsV0FxTnRndWMzVmd5MTNNbzA4S0hj?=
 =?utf-8?B?RDlMVndyaWg0QU4rajFLVHEyZnpDN0kvUE9uZ0E1NWdUT1NpNVl4YkhDU3NI?=
 =?utf-8?B?NTg0R0ZmNG9HRXBXdVZvZ3lLN1dWUE02VUVXOGNrTlRTR3FGWjhqOGVSa3Av?=
 =?utf-8?B?RXFRa1ROZFpHL3U5SGVZWWdEYlU4bjJvNFJjTyt3UTJiT2lDRWQ2cWZvNTMr?=
 =?utf-8?B?RnZzcUNkSExSRWxyYXY2MW1oMFhrT3FSNVA2dGkzTWxQN3hSOW82NVZrc0Qv?=
 =?utf-8?B?S0ZlTktjcS8va1pESVdZRDNDTTk4R3RCRU9xN1ZaYmdxSlJMT1RBdnNSeXl3?=
 =?utf-8?B?citRZkxGWU15OHgxRDllKzV1OEtZQmVlQ0xqblBhYnFKSVY2czJHY0paQXdX?=
 =?utf-8?B?TUt0aU45RHN3bi9ZT1d0UTNzUFhXRFE5ZXNnd0JFZXFTOGtGN3NFWklOREJB?=
 =?utf-8?B?azlZL3daNkZLZEtOYzdYc1BOdnBKR0dyeDZiYmVTaFpsVm5JNmFuV3E4eTNo?=
 =?utf-8?B?TXAyQm1oQ0pyNGFLYlB0TlJCanZERk01dldNTjJlcXM4OFhDU1B0UmVvbkpK?=
 =?utf-8?B?MTlpNXpqREFTeWg5Wk1qQzlUbmVXbytneWxoZlRxUTNMWXhQQ05tQlJtcE9l?=
 =?utf-8?B?cG5ydXpJTDNiQld2Tzhka1pkY1lra3JtUWNINUFub0JKTE5qdXRHLzdpRUNC?=
 =?utf-8?B?V0o3T0JtYnZHaEV2NEovZ095ZXJxVk9ORms5dThFMFNJL1NSWUIrMTQxTG8x?=
 =?utf-8?B?SFVTQ1lTUzdGaUNTcUdxenR1czNMWmVPQzlMM0lOYUNnUGQ0WHR3WlpONEN3?=
 =?utf-8?B?VlVBV3RMeDR4SWY3c09WZkRXU25ENS9QNThXVWlZcDljK1k0VkhVN2NRQk9M?=
 =?utf-8?B?RUlWL0l1Y0J1NEd6OWJGZjB4MFc1RW9saWpiTmpOQStkWFlXRkhPWDBNODdP?=
 =?utf-8?B?ZEFrZk5YYm95SHprOUw1b1NDeHZlZVYwN1RlZktpcG1oVEhFczQyUmtkSGVL?=
 =?utf-8?B?ckN5V0wwMDdtYWVyZVY0aHpYRFAySHl5TW51MEhKcU41RlJadUdUejlyTEx0?=
 =?utf-8?B?RUF6ajZHbjllZU51VnFsWTdqSkJBcGh2YlZkWVp1eW1LYWlIN0MxQWtTUWpU?=
 =?utf-8?B?WDBaTXZWZGJXMmtub0hHbFdKSUhGTHp1TEZKRU4rYkE0UGVjVnlQK0dNRG9B?=
 =?utf-8?B?MFR4Y0xQYzcwcVpOY1N2UjFvZ0RwUXoxbk5sMGN6ckhPOXptTGZOWG1YYnFv?=
 =?utf-8?B?L3pnUGcxL2xPK0YrSzJnNVVwWGdGOTExM1l0WXFKUHJGUkMyQVdBUm9nRlQ1?=
 =?utf-8?Q?m3YuMVlgsc1qf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG1GY0FhYm1QTWtFcCtJNUNuYmZGS0JxV3pZY3c0MkxsYVFjdk5wVGNQUTJp?=
 =?utf-8?B?bkw2TnZpd2xaWVNHQnlMZ0t1TlV3MEViNzNIOHowOTMyRlJoeHlpb3h3VW5V?=
 =?utf-8?B?TGxyYkx0cWpkN011YXo2N2krY0RRYy9qTkZMOHJ2U3FibFIvNjhHY0c1RXN6?=
 =?utf-8?B?Ynh5a05PUEVKdHI1V3NMVVpmVUdKTEFvdmh5ZWlhTmgvOUpvb1MxU1RUcDUw?=
 =?utf-8?B?c1JYY0xiV1pPK3FYekIwNlhRTXVRVlI0dlJlalRrc09lcUdlb1R6eUEvNFRj?=
 =?utf-8?B?S2lmc2JsMWFVSldnUFIxU2pkWkpRTlpWUktwMVdHRHYybHlKQVJjeFRsZzBK?=
 =?utf-8?B?bVM3ZlNWbTd4Q1ZGclBCZlhUdVFZcE9walNFRVZwUEhQbVdIeXNBeENSKytX?=
 =?utf-8?B?Q2l5aXVuZUluNlF4VGIyWUhPUzBrQmNJeTN4b2FYZTgrTlJpbmZyZGdOVWRq?=
 =?utf-8?B?djY4TnFLLzI4bmEySlBjek1HdnBCaGpiU3o3V2kwOGxsbVJyL1c0VDgvU25n?=
 =?utf-8?B?cWxVbUtMNjM2bk1PYk1qUXZyeDZWWkNLSzdpRXNJSDdjRlFGbC95cFd0V3Yz?=
 =?utf-8?B?N1J1NVE4dXQ4V3NRMER3c1dOcW1ZajRNTEVFaXM3ZWhFWklTSXZoWXlGQmFF?=
 =?utf-8?B?eE83Y08xTklnYXdFQzY4NGtLM0NFYlJxSG02UXhFQTFKWjNUNGFCZmhYZlY4?=
 =?utf-8?B?aEZlM0RFWFNrb0RPdk5vTFlmZE1ROTFxQndnbnJMN0Y4RWE2NnViNDRwVWhW?=
 =?utf-8?B?d0g1TmVOcEE2MTY5ZHVkaVprNytreGQyZHRueUh0Y2IzbVJiV1NPMWJqMGJD?=
 =?utf-8?B?ODliTytoeUFEQ2VzTjRQY2ppTUQvaGI3YUY3VEJQek1SNTFMV0YyLzlhVXJj?=
 =?utf-8?B?dWd1TUFHQmRGcG5HVzlUOXBrZjhhQURqMjVJWGNRM0daTmtzRW04dGx0UFVl?=
 =?utf-8?B?MEtTZjBPa2FGbyt2bEk4aFZ6SkNxNENIYmM5bXpnTC8xVEoyNVI1aXZoYXpK?=
 =?utf-8?B?Rm9DaXp5RlgrMkpGSVM1ZDl5U3JrZ2lNNHZqSkdOT054TmN1T2JRUldBOFAy?=
 =?utf-8?B?ZHI5eVhUZVErZTJ6Vy92NWpoVHBHNFRMbWtFZElsQ2wrR3AxaS9meldJL0FQ?=
 =?utf-8?B?MThLcjBlemo5dVhZVVN0L2lHWUQ3Z1BPZzJzcFpLTDNpNGhKZzhEMjVNY3Vi?=
 =?utf-8?B?WlFlL1ZtSE5ZUGRHdGxjUlBPUHNhWkNnVmptWHpsRmd4R1hSaHRwQjdSUmF5?=
 =?utf-8?B?d3hzbE9LQS9YS3U5YXN0ZmY5UHF3NU5FQ0NrY2Q3bFBIVFNKWE9paGsyVnRi?=
 =?utf-8?B?TlQ0YzU3UDB6REVLNlUvRDRQNVQ3d1NvckZNTHNaQjdRdW9GNnBuMktTVGh3?=
 =?utf-8?B?YlFDdlJPTEFVZkI3UEYxWnJLeFVIWDhXQU5RaGFtZTlCZ3pJZ1orVTcvdzl0?=
 =?utf-8?B?dGN5WVJPMXZWTXVoZDh0MDFaUWJUVitwMXpmbFBNK0tRT1BqL0tZQ2d3RklI?=
 =?utf-8?B?TWZYNml6MGcrTkhJQ1YwRWF4S0RpVW9uL2JEcVNrb3V6SXhWd2lDMWh3K2Jk?=
 =?utf-8?B?UEJHemFKZHR0ZVFDZDZGUUhsMWJMSlJnVjlkVnZUVlFBSW9SaUFpQ0JXTGxk?=
 =?utf-8?B?dXJjd1hwYVZDSXlRVytTOWZ5Z0Q5ZnNIR2JoL0pMWllpVlNDQ2ZHVGVUSTEr?=
 =?utf-8?B?MWlSK083bDNLS0xxOGhuZkVZblo5eFdxVXdhZnR4eUcyNVNsdEN5aVNGYTM0?=
 =?utf-8?B?WGVBaVNkbDBTbnd4ekV1czRWZ0pva2s1RHFTMnJIcmdweThzb2tnMjA3cGFL?=
 =?utf-8?B?ck1kQjJtY2xUVmlSQk81NnVFZkVUcUE3ZVFMRVVxVWJBKzRDUWZ4T2tnQTlV?=
 =?utf-8?B?TXVMZWFsUDlFUjlnYUtVZTRCNUpKR0lHU0xOM1UybnJyeUkxTlRIU2o5OWZC?=
 =?utf-8?B?SlpTVU5sMWx5bW1UOTBvY3JiY3hNMGhnMGtqRG9NTEJWYjZhQ0tLRytEaERj?=
 =?utf-8?B?YWQ4WE9VUWdqK3Q0TmpSTFZhU2JoaExYbk1ReDRYL1h1N1dTRUdBZXIxMVJp?=
 =?utf-8?B?Njg0aURPR3I1KzRJaTBDTU42S0pyNXlkS3RHTWdVbS90ejl6aTFpN256TlZz?=
 =?utf-8?B?alUvMmtCQWZ2L1pIaVBCT3JlTGhWU2NHOTMydmlhSmVGQWtwaG5mK3lyVk9D?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211F89B2C308D14583B50882048EF303@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560182a-b4c8-4f5c-4fce-08dc90038789
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 02:00:01.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+1aVbazY/8/kjmYiL8Xj2vtZQD6l9pgzD93kHc9xE3E2ve3qLJXwepeAf+pND+Xbjv5Z+f2VOz2GWkX4/8x+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8300
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDE4OjIzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMTggSnVuIDIwMjQgMTg6MTU6MzcgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIDIwMjQtMDYtMTggYXQgMDc6NTYg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMTggSnVuIDIwMjQgMDY6
MzE6MDkgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+ICANCj4gPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IEBAIC05MjEsNyArOTU2LDggQEAgc3Rh
dGljIGludCBfX2luaXQgc2d4X2luaXQodm9pZCkNCj4gPiA+ID4gPiAgCWlmICghc2d4X3BhZ2Vf
Y2FjaGVfaW5pdCgpKQ0KPiA+ID4gPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IC0JaWYgKCFzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgpKSB7DQo+ID4gPiA+ID4g
KwlpZiAoIXNneF9wYWdlX3JlY2xhaW1lcl9pbml0KCkgfHwgIXNneF9jZ3JvdXBfaW5pdCgpKSB7
DQo+ID4gPiA+ID4gKwkJbWlzY19jZ19zZXRfY2FwYWNpdHkoTUlTQ19DR19SRVNfU0dYX0VQQywg
MCk7DQo+ID4gPiA+ID4gIAkJcmV0ID0gLUVOT01FTTsNCj4gPiA+ID4gPiAgCQlnb3RvIGVycl9w
YWdlX2NhY2hlOw0KPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBjb2RlIGNo
YW5nZSBpcyB3cm9uZyBkdWUgdG8gdHdvIHJlYXNvbnM6DQo+ID4gPiA+IA0KPiA+ID4gPiAxKSBJ
ZiBzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgpIHdhcyBzdWNjZXNzZnVsLCBidXQgc2d4X2Nncm91
cF9pbml0KCkNCj4gPiA+ID4gZmFpbGVkLCB5b3UgYWN0dWFsbHkgbmVlZCB0byAnZ290byBlcnJf
a3RocmVhZCcgYmVjYXVzZSB0aGUga3NneGQoKQ0KPiA+ID4gPiBrZXJuZWwNCj4gPiA+ID4gdGhy
ZWFkIGlzIGFscmVhZHkgY3JlYXRlZCBhbmQgaXMgcnVubmluZy4NCj4gPiA+ID4gDQo+ID4gPiA+
IDIpIFRoZXJlIGFyZSBvdGhlciBjYXNlcyBhZnRlciBoZXJlIHRoYXQgY2FuIGFsc28gcmVzdWx0
IGluICANCj4gPiA+IHNneF9pbml0KCkgdG8NCj4gPiA+ID4gZmFpbCBjb21wbGV0ZWx5LCBlLmcu
LCByZWdpc3RlcmluZyBzZ3hfZGV2X3Byb3Zpc2lvbiBtaWNzIGRldmljZS4gIFdlDQo+ID4gPiA+
IG5lZWQNCj4gPiA+ID4gdG8gcmVzZXQgdGhlIGNhcGFjaXR5IHRvIDAgZm9yIHRob3NlIGNhc2Vz
IGFzIHdlbGwuDQo+ID4gPiA+IA0KPiA+ID4gPiBBRkFJQ1QsIHlvdSBuZWVkIHNvbWV0aGluZyBs
aWtlOg0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L21haW4uYw0KPiA+ID4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiA+
ID4gPiBpbmRleCAyNzg5MmU1N2M0ZWYuLjQ2ZjljMjY5OTJhNyAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiA+ID4gPiBAQCAtOTMwLDYgKzkzMCwxMCBAQCBzdGF0
aWMgaW50IF9faW5pdCBzZ3hfaW5pdCh2b2lkKQ0KPiA+ID4gPiAgICAgICAgIGlmIChyZXQpDQo+
ID4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9rdGhyZWFkOw0KPiA+ID4gPiArICAgICAg
IHJldCA9IHNneF9jZ3JvdXBfaW5pdCgpOw0KPiA+ID4gPiArICAgICAgIGlmIChyZXQpDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9wcm92aXNpb247DQo+ID4gPiA+ICsNCj4gPiA+
ID4gICAgICAgICAvKg0KPiA+ID4gPiAgICAgICAgICAqIEFsd2F5cyB0cnkgdG8gaW5pdGlhbGl6
ZSB0aGUgbmF0aXZlICphbmQqIEtWTSBkcml2ZXJzLg0KPiA+ID4gPiAgICAgICAgICAqIFRoZSBL
Vk0gZHJpdmVyIGlzIGxlc3MgcGlja3kgdGhhbiB0aGUgbmF0aXZlIG9uZSBhbmQNCj4gPiA+ID4g
QEAgLTk0MSwxMCArOTQ1LDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZvaWQpDQo+
ID4gPiA+ICAgICAgICAgcmV0ID0gc2d4X2Rydl9pbml0KCk7DQo+ID4gPiA+ICAgICAgICBpZiAo
c2d4X3ZlcGNfaW5pdCgpICYmIHJldCkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gZXJy
X3Byb3Zpc2lvbjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2Nncm91cDsNCj4g
PiA+ID4gICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiArZXJyX2Nncm91cDoNCj4gPiA+ID4gKyAg
ICAgICAvKiBTR1ggRVBDIGNncm91cCBjbGVhbnVwICovDQo+ID4gPiA+ICBlcnJfcHJvdmlzaW9u
Og0KPiA+ID4gPiAgICAgICAgIG1pc2NfZGVyZWdpc3Rlcigmc2d4X2Rldl9wcm92aXNpb24pOw0K
PiA+ID4gPiBAQCAtOTUyLDYgKzk1OCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZv
aWQpDQo+ID4gPiA+ICAgICAgICAga3RocmVhZF9zdG9wKGtzZ3hkX3Rzayk7DQo+ID4gPiA+IGVy
cl9wYWdlX2NhY2hlOg0KPiA+ID4gPiArICAgICAgIG1pc2NfbWlzY19jZ19zZXRfY2FwYWNpdHko
TUlTQ19DR19SRVNfU0dYX0VQQywgMCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgc2d4X25yX2VwY19zZWN0aW9uczsgaSsrKSB7DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICB2ZnJlZShzZ3hfZXBjX3NlY3Rpb25zW2ldLnBhZ2VzKTsNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIG1lbXVubWFwKHNneF9lcGNfc2VjdGlvbnNbaV0udmlydF9hZGRyKTsNCj4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHB1dCB0aGUgc2d4X2Nncm91cF9pbml0KCkgYmVmb3Jl
IHNneF9kcnZfaW5pdCgpIGFuZCBzZ3hfdmVwY19pbml0KCksDQo+ID4gPiA+IG90aGVyd2lzZSB5
b3Ugd2lsbCBuZWVkIHNneF9kcnZfY2xlYW51cCgpIGFuZCBzZ3hfdmVwY19jbGVhbnVwKCkNCj4g
PiA+ID4gcmVzcGVjdGl2ZWx5IHdoZW4gc2d4X2Nncm91cF9pbml0KCkgZmFpbHMuDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBZZXMsIGdvb2QgY2F0Y2guDQo+ID4gPiANCj4gPiA+ID4gVGhpcyBs
b29rcyBhIGxpdHRsZSBiaXQgd2VpcmQgdG9vLCB0aG91Z2g6DQo+ID4gPiA+IA0KPiA+ID4gPiBD
YWxsaW5nIG1pc2NfbWlzY19jZ19zZXRfY2FwYWNpdHkoKSB0byByZXNldCBjYXBhY2l0eSB0byAw
IGlzIGRvbmUgYXQgIA0KPiA+ID4gZW5kDQo+ID4gPiA+IG9mIHNneF9pbml0KCkgZXJyb3IgcGF0
aCwgYmVjYXVzZSB0aGUgInNldCBjYXBhY2l0eSIgcGFydCBpcyBkb25lIGluDQo+ID4gPiA+IHNn
eF9lcGNfY2FjaGVfaW5pdCgpLg0KPiA+ID4gPiBCdXQgbG9naWNhbGx5LCBib3RoICJzZXQgY2Fw
YWNpdHkiIGFuZCAicmVzZXQgY2FwYWNpdHkgdG8gMCIgc2hvdWxkIGJlDQo+ID4gPiA+IFNHWA0K
PiA+ID4gPiBFUEMgY2dyb3VwIG9wZXJhdGlvbiwgc28gaXQncyBtb3JlIHJlYXNvbmFibGUgdG8g
ZG8gInNldCBjYXBhY2l0eSIgaW4NCj4gPiA+ID4gc2d4X2Nncm91cF9pbml0KCkgYW5kIGRvICJy
ZXNldCB0byAwIiBpbiB0aGUNCj4gPiA+ID4gDQo+ID4gPiA+IAkvKiBTR1ggRVBDIGNncm91cCBj
bGVhbnVwICovDQo+ID4gPiA+IA0KPiA+ID4gPiBhcyBzaG93biBhYm92ZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IEV2ZW50dWFsbHksIHlvdSB3aWxsIG5lZWQgdG8gZG8gRVBDIGNncm91cCBjbGVhbnVw
IGFueXdheSwgZS5nLiwgdG8gIA0KPiA+ID4gZnJlZQ0KPiA+ID4gPiB0aGUgd29ya3F1ZXVlLCBz
byBpdCdzIG9kZCB0byBoYXZlIHR3byBwbGFjZXMgdG8gaGFuZGxlIEVQQyBjZ3JvdXANCj4gPiA+
ID4gY2xlYW51cC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdW5kZXJzdGFuZCB0aGUgcmVhc29uICJz
ZXQgY2FwYWNpdHkiIHBhcnQgaXMgZG9uZSBpbg0KPiA+ID4gPiBzZ3hfcGFnZV9jYWNoZV9pbml0
KCkgbm93IGlzIGJlY2F1c2UgaW4gdGhhdCBmdW5jdGlvbiB5b3UgY2FuIGVhc2lseSAgDQo+ID4g
PiBnZXQNCj4gPiA+ID4gdGhlIGNhcGFjaXR5LiAgQnV0IHRoZSBmYWN0IGlzIEBzZ3hfbnVtYV9u
b2RlcyBhbHNvIHRyYWNrcyBFUEMgc2l6ZSAgDQo+ID4gPiBmb3INCj4gPiA+ID4gZWFjaCBub2Rl
LCBzbyB5b3UgY2FuIGFsc28gZ2V0IHRoZSB0b3RhbCBFUEMgc2l6ZSBmcm9tIEBzZ3hfbnVtYV9u
b2RlICANCj4gPiA+IGluDQo+ID4gPiA+IHNneF9jZ3JvdXBfaW5pdCgpIGFuZCBzZXQgY2FwYWNp
dHkgdGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0aGlzIGNhc2UsIHlvdSBjYW4gcHV0ICJy
ZXNldCBjYXBhY2l0eSB0byAwIiBhbmQgImZyZWUgd29ya3F1ZXVlIg0KPiA+ID4gPiB0b2dldGhl
ciBhcyB0aGUgIlNHWCBFUEMgY2dyb3VwIGNsZWFudXAiLCB3aGljaCBpcyB3YXkgbW9yZSBjbGVh
ciAgDQo+ID4gPiBJTUhPLg0KPiA+ID4gPiANCj4gPiA+IE9rYXksIHdpbGwgIGV4cG9zZSBAc2d4
X251bWFfbm9kZXMgdG8gZXBjX2Nncm91cC5jIGFuZCBkbyB0aGUgIA0KPiA+ID4gY2FsY3VsYXRp
b25zDQo+ID4gPiBpbiBzZ3hfY2dyb3VwX2luaXQoKS4NCj4gPiA+IA0KPiA+IA0KPiA+IExvb2tz
IHlvdSB3aWxsIGFsc28gbmVlZCB0byBleHBvc2UgQHNneF9udW1hX21hc2ssIHdoaWNoIGxvb2tz
IG92ZXJraWxsLg0KPiA+IA0KPiA+IE90aGVyIG9wdGlvbnM6DQo+ID4gDQo+ID4gMSkgRXhwb3Nl
IGEgZnVuY3Rpb24gdG8gcmV0dXJuIHRvdGFsIEVQQyBwYWdlcy9zaXplIGluICJzZ3guaCIuDQo+
ID4gDQo+ID4gMikgTW92ZSBvdXQgdGhlIG5ldyAnY2FwYWNpdHknIHZhcmlhYmxlIGluIHRoaXMg
cGF0Y2ggYXMgYSBnbG9iYWwgIA0KPiA+IHZhcmlhYmxlDQo+ID4gYW5kIGV4cG9zZSBpdCBpbiAi
c2d4LmgiIChwZXJoYXBzIHJlbmFtZSB0byAnc2d4X3RvdGFsX2VwY19wYWdlcy9zaXplJykuDQo+
ID4gDQo+ID4gMykgTWFrZSBzZ3hfY2dyb3VwX2luaXQoKSB0byB0YWtlIGFuIGFyZ3VtZW50IG9m
IHRvdGFsIEVQQyBwYWdlcy9zaXplLCAgDQo+ID4gYW5kDQo+ID4gcGFzcyBpdCBpbiBzZ3hfaW5p
dCgpLiAgDQo+ID4gRm9yIDMpIHRoZXJlIGFyZSBhbHNvIG9wdGlvbnMgdG8gZ2V0IHRvdGFsIEVQ
QyBwYWdlcy9zaXplOg0KPiA+IA0KPiA+IGEpIE1vdmUgb3V0IHRoZSBuZXcgJ2NhcGFjaXR5JyB2
YXJpYWJsZSBpbiB0aGlzIHBhdGNoIGFzIGEgc3RhdGljLg0KPiA+IA0KPiA+IGIpIEFkZCBhIGZ1
bmN0aW9uIHRvIGNhbGN1bGF0ZSB0b3RhbCBFUEMgcGFnZXMvc2l6ZSBmcm9tIHNneF9udW1hX25v
ZGVzLg0KPiA+IA0KPiA+IEhtbS4uIEkgdGhpbmsgd2UgY2FuIGp1c3QgdXNlIG9wdGlvbiAyKT8N
Cj4gPiANCj4gPiANCj4gSSB3YXMgIGFib3V0IGRvaW5nIHRoaXMgaW4gc2d4X2Nncm91cF9pbml0
KCk6DQo+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fcG9zc2libGVfbm9kZXMoKTsgaSsr
KQ0KPiAgICAgICAgICAgICAgICAgIGNhcGFjaXR5ICs9IHNneF9udW1hX25vZGVzW2ldLnNpemU7
DQo+IA0KPiBhbnkgY29uY2VybiB1c2luZyBudW1fcG9zc2libGVfbm9kZXMoKT8NCj4gDQo+IEkg
dGhpbmsgY2FzZSBoYW5kbGVkIGluIHNneF9wYWdlX2NhY2hlX2luaXQoKSBmb3IgYSBub2RlIHdp
dGggbm8gZXBjIChvciAgDQo+IG1hc2spLiBPbmx5IHJlcXVpcmVtZW50IGlzIHNneF9jZ3JvdXBf
aW5pdCgpIGNhbGxlZCBhZnRlciAgDQo+IHNneF9wYWdlX2NhY2hlX2luaXQoKS4NCj4gDQoNCkFs
bCBvdGhlciBjb2RlIHVzZXMgc2d4X251bWFfbWFzayB0byB0ZWxsIHdoZXRoZXIgYSBub2RlIGhh
cyBFUEMuICBJdA0Kd291bGQgYmUgZ3JlYXQgaWYgd2UgdXNlIHRoaXMgd2F5IGNvbnNpc3RlbnRs
eSBpbiBhbGwgU0dYIGNvZGUuDQoNCg==

