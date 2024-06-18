Return-Path: <cgroups+bounces-3230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AF90CA5C
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B713290701
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B01420B6;
	Tue, 18 Jun 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6g3OOJ1"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A11304A3;
	Tue, 18 Jun 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710314; cv=fail; b=muQzMqd4ByJ1kRjCCj/5JqsxNv6bJDi55/kk6IHzog6h/ds8X6ho8an9sFDEWXDeF2zhOReiFeEbOWo+rZk+JJQXrHSDekZMpOog6zz4cN+gP1yov0IKKYGYWRhbpDt/MuXd5a1JyeudqJTjSZ4+nMm56AN7iQhrTUuUECmhswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710314; c=relaxed/simple;
	bh=T/m9I8h0eSUjhBfRYuHb98bFobT6pmBflo8mQ+cWSvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iv+54Afl85GNumEfHjioH6LPWif3pXDk4yZ3bU5zvMDK6oB9NsZ7unnISmJJc2Z+fngahjl885E8YEHvO9tmsb980l3ggq0vweYZ4j3l9dBZzuGASswYHtrGgCFAa5qxva+Pw/s+F0fA7coXkr7N65a+PmJTgoAt6wXMNTRcNDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6g3OOJ1; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718710312; x=1750246312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T/m9I8h0eSUjhBfRYuHb98bFobT6pmBflo8mQ+cWSvU=;
  b=E6g3OOJ1CaBdi96FUvf8L6glbLWAB2YOSLZDBPKCgRomp+gt1c35uG3m
   bXYy6+sXIhmsUvHbzXceJL5ffIm3f+95lbN+3KeTCHURrpfh0x3CfmO/N
   euYJ9en42K3wy48MsxG+j4idEoQekkihxNerM0Pupurj+JSWoxW9Swiig
   pWBBhpOp6UcO8ogDogYBFAAhrSMEbNn/wz6FabPFfOVmK4BsGpA8w9LIW
   fNEyVX6Qg63MmsDew+i08BCu6muenbkX0k9jEruYWeLXqR87g5GOsRDr9
   ORLZJp+vnTcUXE8xXsm0Y72ZX1JDXyEaFfKcPMVGYvOTiAOaROmX7ouLk
   w==;
X-CSE-ConnectionGUID: 1KzTDcMDSD+I//Rm7Y7K/g==
X-CSE-MsgGUID: mQqoH0eUSqO0ng6NCrx0UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15544713"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15544713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:31:14 -0700
X-CSE-ConnectionGUID: cWfO2YxLSJqsub06sUKwkA==
X-CSE-MsgGUID: u4q5fXseRP6MwbQmScpMKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="45887799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 04:31:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 04:31:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 04:31:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 04:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk3EKA3n0RT3NI6lL1l96Wo7DtCzMzhRvsRHXAQAuCR4UDTGzN7ZeM751HC/NPTfZRbodLwWEslof9rzJpWEwgfZcaJpZjt4Y4qDZA/Nuymh3hUM+HbJNRaPIDrYZjljjgvQMgxMzL+EznqSRmZKCfYv4jkaWURzFhyNGu9l/us5QSugszGkLLkYOHtZgZ4egMskLdjShHpzr8UuQtHee2bVm16nB58A/4wyMm1uVKKldiyGKsRg/sEnFum8dCiMkQhGrLil5JJ/zy7h0gybKOaITz9I+H/zzMhdI+lWky/hmfhFrjWN8x7FKo13Ppk0DxkXgE4QWGDDGnmUYqw7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/m9I8h0eSUjhBfRYuHb98bFobT6pmBflo8mQ+cWSvU=;
 b=VkLVu9JEPCSqyK8i9H7hrz3j/9hI5i/vIRTw0c7h5YC0SNPz93wQrpXTEj1p3jdX82lA6iayViMZilASq0ztMopO0caoTH10N15bdl4MyywVthq1FiWEk/rrfys5Nk4VnssvNXxAGrTdO/9HxlnuyQqiOISKTaZch3xHDFcqNKMrWtqlQkcEhhquhHiHVxf9eYmXEtJXqv24VWWq0MsnrGzTeLvcYn1AKPXkTV/O89XmArp1Em+IsODzf1JJoMi+ZdzJ8QI/+KfGRW1vyNIM2V6r8FYceCh26WtnhYYibM+DOu9CoIMaQpPS8yE8bFFLjb25PbatIIRT1KcSdLH8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:31:09 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 11:31:09 +0000
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
Thread-Index: AQHawLVpCFAs5aGEAU+I+soWZvGHW7HNZJYA
Date: Tue, 18 Jun 2024 11:31:09 +0000
Message-ID: <aa686e57fad34041fb941f87c10fb017f048d29f.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-6-haitao.huang@linux.intel.com>
In-Reply-To: <20240617125321.36658-6-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4813:EE_
x-ms-office365-filtering-correlation-id: 8bbedff2-d10a-4271-3c3e-08dc8f8a26cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|921017|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Z051Q3hYRjlVb0NEVHo5dGNVK3RoL2pCcTNTeDNNMFdjVmhoeEtxNjUrK2xR?=
 =?utf-8?B?VVZ4cng0aTNsU0pRVzVONWFmdkcyekd6QlFCbFlJbnlCVndVRGZsWWJON3hY?=
 =?utf-8?B?dmZsV0sva04ycVV6QU5Uei9kRm4vU0FKSmZQNTZSdUdzckJsZmdnUEZadDh4?=
 =?utf-8?B?L1RCUlZwVGhCZHZ2STkwVmRITEhkLzNUdHdiMmJGdHJEWjVHZnNvZTNiVkhs?=
 =?utf-8?B?TExoSFIyclNrV09Pak9LRU1vcU54Z0REbnRITUVJWVVxdFJhM3M5eXMrMTdJ?=
 =?utf-8?B?Rjd1aXBNV3U3MTdSODlmOGtOWXZucnVjcUNuZEFtWG1hQXQ1cm5NbHJMZTVO?=
 =?utf-8?B?dUtQdTRISzR4RU9xMUpXbi9wQ0U4NDFBTWkreHo0SlNKZk51dUNrYllGdStw?=
 =?utf-8?B?MVo0dUpPUDZBZ3NGajlDN3lsRmptQnovYkRPK1NlRVFrWE41R2ZkZDV5Vnc3?=
 =?utf-8?B?L0w4TEwzYi8xd0ZZT3ErdXpZN2ZKMTFoOG1TY1JtWVdpc2lQR3dlK3ZzWHdG?=
 =?utf-8?B?YXJIVW5qVW14aDV5Vi9mV2VMcndJN0NaUGJWSkp2cnJQNnQ4ZTBvSnl4Nis1?=
 =?utf-8?B?bENFQ216NlRtcHIzblRZL3RqZWI0cWQyM3Y3MUFsdEE2WUZMNnJSb0NkOXVD?=
 =?utf-8?B?cFlxVGRDaVhPUFg0TzMzdzFVQ3ZiWVhxTmIwR3lzcGVGWGlIZXF5SitRaW8z?=
 =?utf-8?B?dkxtQjVLNmMxMnI2eGhpRWFaNXZNdnllcDRPTlNMYW56RnZJaDlkMlN4OHdh?=
 =?utf-8?B?SFFVV1RGTlhuYjdRaUhoTGRmMVROVXZDUkVDcFhXZ0NTZDBmN2VVMy9RNVlx?=
 =?utf-8?B?REdJSHJrOEoyUFRudFcwYnZNTm1QY2xWdzROVmU0V0tGY1JqZE9ReFBPcGxV?=
 =?utf-8?B?NG56T3djME1qMDZESzZJeUszemxjRXIrejFlS0tuRjJhTmo2Y3luRUgxTmh3?=
 =?utf-8?B?cU1WRUFSb3NqOGp2U3I1UzhVL2ptbnNmdWllRWU2R1NxZHhQRHN1UG1WMTFB?=
 =?utf-8?B?Sm02MG4zNzdzTEFmN2ZzMnNBQ1NZTWlRR0lmTnVPUlp1K3MxQ293UFVuZE80?=
 =?utf-8?B?aUhTUjNWQWE0Mk9jZnFUQ21VdlNrNUVGOTBha2dLVzB0d2szVU1TMjdDKzBl?=
 =?utf-8?B?dGNGOWZoZDdENUV4MzNKV29MLytvSjY2S0NkWUFqL2lGMnB6eDRaWTk2S3dy?=
 =?utf-8?B?ZHRKTi9TQmF6M2VvdkZsOUVPeW9PMGFFWlY1aE03TVppb2Nuem02eUF5UXFv?=
 =?utf-8?B?NG5XWW5TM051b1d0K3c0bmlBYkphMUErSm1nZG1BNVdjUzc5emtMOGZ3VDND?=
 =?utf-8?B?OUFhNlliQ1Z2SkNRZW80TUlUNGZEdEg2R3R5c3ZKVXdPdTd1dGJBeXE0WXI1?=
 =?utf-8?B?L1Jhd2RjRmZ4Wnl3QzFYSjV1cGk5T1g1NXNzUFl6UTR5TDV1Y09nRTczZEdC?=
 =?utf-8?B?WktkamZQekhhQzVZT1dPUklHckVHZUc5ZlZ5b0IrYkRtVVRMZ25WQUhRc01s?=
 =?utf-8?B?SVRnZDJ2MU9BMzhCM0FOMHBaaVRFbERZYzY4SzJZc3FtTVBCbnN1K1VyUklD?=
 =?utf-8?B?bXUzL2ZqeDloakdoVlZUZVBCRHJNbnlwWmE4Z2E5ZStyK3M5dlRCbEZneHZC?=
 =?utf-8?B?K3Z6RUw0cmpRWHd4ZjVCZ3RDNHZGUkhHejd5aXlQbmkwL3VhcGlDOEZDbk1n?=
 =?utf-8?B?NXJNaFc2WWFvRXNhdWhwYTZUS2lLYk1xbHF5dDR1SUVXeXdVWTZSUlFIQVdq?=
 =?utf-8?B?cDVVajlmRDJQejlrUElNbThsaTJlMDRMZm82NkpUdXpEWDM5eVFUR2tSTTNl?=
 =?utf-8?B?WEJWMzdRU0Z0UTlTU1RYOHhpYTNRZy9sMWNCMmp4c3lvVjNFcjZjb3o2aVFW?=
 =?utf-8?Q?rznbCqFgBLs4d?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm1kNGJiTzAyYm04Z085SDM0cjRHOHROQWtjT3dKcitiakJNQ053M0gyMGxp?=
 =?utf-8?B?cFIwVHB6VDh2L2tSeGd0a2t4N1prZUV1U0ZKU24xTjErUU5jeWYyeVVoZmFh?=
 =?utf-8?B?Rmw0ZnJ1Ym11MzNpc0YyVkxJTFV5RTNLVkh6anV4ZFlPdytCY2plSnkrdnhB?=
 =?utf-8?B?WWVoMitBTUFvTVg0VUlPTE9ERWlDNEJuNFh3TDJpbkpDOEZ0MEVxemJVOSsv?=
 =?utf-8?B?MWJSbjI0Smxpa0d1Z0hNeDRTbWszUTBsR0RrRVRITFo4TDJIekpQbDNOVWV5?=
 =?utf-8?B?cFBaUkxKYkdSZE9TTlc3bHNheFR6enplVHkxcjV1QUJBWS9LeGs1OFVKMjhK?=
 =?utf-8?B?RWxmbmxhdWFCTkxNbjlzY3BEcC9MeXFaYTRZRmh1L3ZvbkxodC9jZ0xSK1VY?=
 =?utf-8?B?KzAzajBJWTYrbE9ENDhHSVI2MTBWeHd0cFNlcHpHUmowMmo0dGFwL0Jha2xU?=
 =?utf-8?B?REp0V3hwdkw1a2NlS1QySTJrbmtDYmxmcy8rcmtJZWhBa3NTUGhQRTJ2bTQ2?=
 =?utf-8?B?NnhOcXkxSjdnWEJsbjdDMUk3TkkyMmpmYmtneWJ0Q3kyQ0M0YUJJTTBKVmxk?=
 =?utf-8?B?U3lNL0RPbHM2QUp4b3kyV1pZUWxIYytIVFl6c1NvOEFiTVJhYlJzdVZPVmZy?=
 =?utf-8?B?MlVjSVVJdWw3dE45M09HTWhTQ212WGdkYmNRQmZRNDlwd3pMNFVRVHJPQTJj?=
 =?utf-8?B?NjlHZnAvTHNlNjY5MUxaeW1JVG1mdklSRmxnOEJIRTU4MG1SY0djUGhESXRi?=
 =?utf-8?B?QUEwUm1BRHRILzZsMUMwVjVtS2hJUTFBRS9TWE9YZm1MNk8wbHNIbFhQcG5a?=
 =?utf-8?B?SWhldjdpbFh1THppSlN6NWplMkRJejBoSGlyVlh3OStIQTVIazFQZTJ4VHgx?=
 =?utf-8?B?TVdnSzdNcVNlVzNRdDgwdFBHdnVwNlFxWStMN0FKazhRcXBTeCtDa25WUmxw?=
 =?utf-8?B?VndlY0hFaGtSNlRWQ2Vrby9SRDdNYmNlaVBCalk3NVNpcHcvcExHcE1pTVpR?=
 =?utf-8?B?Z3VEbzlrRGp3bjZ4bkhYOVJyVG1mcWxscm9sVUp6RTNnSnkwNnFMK1JBMTNp?=
 =?utf-8?B?d1NXQ1ZwNG14bk1nRUdWMXdGY1ErMEpERGZ4MFk4ck1hRmtuS2FYRDROV0Ni?=
 =?utf-8?B?S3paclZISjZZQld5QkM4ZzZrWnRmNWdmK3dMNDZCNVRBMTd5SnNCZWZIc1lC?=
 =?utf-8?B?NnY2dXFKYjJ4QW1oQ3pWU1htUVdoYm9kQjJHN2RMMWRjTUxQK1UxT21YSHFo?=
 =?utf-8?B?bDY5aEF6aTJGK2JJOEs4d2hPR0VYQlpaYTNsaVlxcTA1VDkrYzV0cTAwMDJx?=
 =?utf-8?B?eUpCdmpGa1ovdUF1SkJSaDhiN3ZPL2UyRisxQnhkZUZ1QlliV2xSa0pjeVlJ?=
 =?utf-8?B?N0xSYnZCdGsxMjhVdHF0WEZNYlkyeXN4SXFFamRQN3g2L3VMaGN0YUxIbzJF?=
 =?utf-8?B?Yng0MnJ4d2w5QTRUOCtrNUZpR1ZOUTVudkN6TGFQdWd2WmNmLzNvVFBZN09r?=
 =?utf-8?B?eVBTalArWVlEdEhndnFWOEtkSWNyUUs4UUNGTlQzYXFjWXVXQnFxcWR4Yzlz?=
 =?utf-8?B?aUtSck5NSjNwcVhMVlhLRDRhTDAzc084ZGFxRFRjS0dLR0EwaFdGY1p1M2Iw?=
 =?utf-8?B?eEY2SDliOFVYVEd4OXBna0lDRzdhU1MwdU5TUFRLanJCOGZJd25sYit6cE9k?=
 =?utf-8?B?UDQ5bjdPQzlTQThSajQ3L3ZYdVdmQjQ3VXU5VWFPYWhIemFFOG1zTXlmb0lz?=
 =?utf-8?B?SGpLVm1RbHdhVEhwNEFBNmp0a2N3WVZtbjdjU2lmaTBFczNhT0NzZ0djODJo?=
 =?utf-8?B?ZlRrVUVKazZwWW95bDhuY3o2Z2JGL1ZSS0V6UUNQQUhXd0JJRW1QakFzMk9v?=
 =?utf-8?B?TGRIbEZLZ3QrYzE4Q2J6elNuRzJRdFJQTklGeVdBNEhTelRuN2hyVEVXbUxW?=
 =?utf-8?B?cVdRWWZ3dTJFYkRIZjBPRHZrOXFIa2k5WUFycEdJTUVLVG9oOWc1cXBQTW5y?=
 =?utf-8?B?elJSQTRhajc4MlNZVWZxRy8yN1hUNmZZbVBvVk5xUm52Y1NCVmxLaUI5RWVY?=
 =?utf-8?B?NjFSbWtIZE8rNVQwSVh1WVpoQ1lQNENIWU9yaExiQk5nWGFLdkxJMVdyYlB4?=
 =?utf-8?Q?njYhHTdeVHxzZYXNYNmEJ7iq7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214914132711DB4FAA8F0EC67D2630DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbedff2-d10a-4271-3c3e-08dc8f8a26cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 11:31:09.8569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGXdLojHvMAhkSqHhv6r131D1dwes8Ir6jPICR0PXrfxDWY0RbTR9dniurSwFAmhZeRRmZBtECOo+9G2Tdub3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com

DQo+IEBAIC05MjEsNyArOTU2LDggQEAgc3RhdGljIGludCBfX2luaXQgc2d4X2luaXQodm9pZCkN
Cj4gIAlpZiAoIXNneF9wYWdlX2NhY2hlX2luaXQoKSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+
ICANCj4gLQlpZiAoIXNneF9wYWdlX3JlY2xhaW1lcl9pbml0KCkpIHsNCj4gKwlpZiAoIXNneF9w
YWdlX3JlY2xhaW1lcl9pbml0KCkgfHwgIXNneF9jZ3JvdXBfaW5pdCgpKSB7DQo+ICsJCW1pc2Nf
Y2dfc2V0X2NhcGFjaXR5KE1JU0NfQ0dfUkVTX1NHWF9FUEMsIDApOw0KPiAgCQlyZXQgPSAtRU5P
TUVNOw0KPiAgCQlnb3RvIGVycl9wYWdlX2NhY2hlOw0KPiAgCX0NCg0KVGhpcyBjb2RlIGNoYW5n
ZSBpcyB3cm9uZyBkdWUgdG8gdHdvIHJlYXNvbnM6DQoNCjEpIElmIHNneF9wYWdlX3JlY2xhaW1l
cl9pbml0KCkgd2FzIHN1Y2Nlc3NmdWwsIGJ1dCBzZ3hfY2dyb3VwX2luaXQoKQ0KZmFpbGVkLCB5
b3UgYWN0dWFsbHkgbmVlZCB0byAnZ290byBlcnJfa3RocmVhZCcgYmVjYXVzZSB0aGUga3NneGQo
KSBrZXJuZWwNCnRocmVhZCBpcyBhbHJlYWR5IGNyZWF0ZWQgYW5kIGlzIHJ1bm5pbmcuDQoNCjIp
IFRoZXJlIGFyZSBvdGhlciBjYXNlcyBhZnRlciBoZXJlIHRoYXQgY2FuIGFsc28gcmVzdWx0IGlu
IHNneF9pbml0KCkgdG8NCmZhaWwgY29tcGxldGVseSwgZS5nLiwgcmVnaXN0ZXJpbmcgc2d4X2Rl
dl9wcm92aXNpb24gbWljcyBkZXZpY2UuICBXZSBuZWVkDQp0byByZXNldCB0aGUgY2FwYWNpdHkg
dG8gMCBmb3IgdGhvc2UgY2FzZXMgYXMgd2VsbC4NCg0KQUZBSUNULCB5b3UgbmVlZCBzb21ldGhp
bmcgbGlrZToNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0K
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMNCmluZGV4IDI3ODkyZTU3YzRlZi4uNDZm
OWMyNjk5MmE3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMNCkBAIC05MzAsNiArOTMwLDEwIEBA
IHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZvaWQpDQogICAgICAgIGlmIChyZXQpDQogICAg
ICAgICAgICAgICAgZ290byBlcnJfa3RocmVhZDsNCiANCisgICAgICAgcmV0ID0gc2d4X2Nncm91
cF9pbml0KCk7DQorICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAgZ290byBlcnJfcHJv
dmlzaW9uOw0KKw0KICAgICAgICAvKg0KICAgICAgICAgKiBBbHdheXMgdHJ5IHRvIGluaXRpYWxp
emUgdGhlIG5hdGl2ZSAqYW5kKiBLVk0gZHJpdmVycy4NCiAgICAgICAgICogVGhlIEtWTSBkcml2
ZXIgaXMgbGVzcyBwaWNreSB0aGFuIHRoZSBuYXRpdmUgb25lIGFuZA0KQEAgLTk0MSwxMCArOTQ1
LDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZvaWQpDQogICAgICAgIHJldCA9IHNn
eF9kcnZfaW5pdCgpOw0KIA0KICAgICAgICBpZiAoc2d4X3ZlcGNfaW5pdCgpICYmIHJldCkNCi0g
ICAgICAgICAgICAgICBnb3RvIGVycl9wcm92aXNpb247DQorICAgICAgICAgICAgICAgZ290byBl
cnJfY2dyb3VwOw0KIA0KICAgICAgICByZXR1cm4gMDsNCiANCitlcnJfY2dyb3VwOg0KKyAgICAg
ICAvKiBTR1ggRVBDIGNncm91cCBjbGVhbnVwICovDQogZXJyX3Byb3Zpc2lvbjoNCiAgICAgICAg
bWlzY19kZXJlZ2lzdGVyKCZzZ3hfZGV2X3Byb3Zpc2lvbik7DQogDQpAQCAtOTUyLDYgKzk1OCw4
IEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZvaWQpDQogICAgICAgIGt0aHJlYWRfc3Rv
cChrc2d4ZF90c2spOw0KIA0KIGVycl9wYWdlX2NhY2hlOg0KKyAgICAgICBtaXNjX21pc2NfY2df
c2V0X2NhcGFjaXR5KE1JU0NfQ0dfUkVTX1NHWF9FUEMsIDApOw0KKw0KICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgc2d4X25yX2VwY19zZWN0aW9uczsgaSsrKSB7DQogICAgICAgICAgICAgICAgdmZy
ZWUoc2d4X2VwY19zZWN0aW9uc1tpXS5wYWdlcyk7DQogICAgICAgICAgICAgICAgbWVtdW5tYXAo
c2d4X2VwY19zZWN0aW9uc1tpXS52aXJ0X2FkZHIpOw0KDQoNCkkgcHV0IHRoZSBzZ3hfY2dyb3Vw
X2luaXQoKSBiZWZvcmUgc2d4X2Rydl9pbml0KCkgYW5kIHNneF92ZXBjX2luaXQoKSwNCm90aGVy
d2lzZSB5b3Ugd2lsbCBuZWVkIHNneF9kcnZfY2xlYW51cCgpIGFuZCBzZ3hfdmVwY19jbGVhbnVw
KCkNCnJlc3BlY3RpdmVseSB3aGVuIHNneF9jZ3JvdXBfaW5pdCgpIGZhaWxzLg0KDQpUaGlzIGxv
b2tzIGEgbGl0dGxlIGJpdCB3ZWlyZCB0b28sIHRob3VnaDoNCg0KQ2FsbGluZyBtaXNjX21pc2Nf
Y2dfc2V0X2NhcGFjaXR5KCkgdG8gcmVzZXQgY2FwYWNpdHkgdG8gMCBpcyBkb25lIGF0IGVuZA0K
b2Ygc2d4X2luaXQoKSBlcnJvciBwYXRoLCBiZWNhdXNlIHRoZSAic2V0IGNhcGFjaXR5IiBwYXJ0
IGlzIGRvbmUgaW4NCnNneF9lcGNfY2FjaGVfaW5pdCgpLiDCoA0KDQpCdXQgbG9naWNhbGx5LCBi
b3RoICJzZXQgY2FwYWNpdHkiIGFuZCAicmVzZXQgY2FwYWNpdHkgdG8gMCIgc2hvdWxkIGJlIFNH
WA0KRVBDIGNncm91cCBvcGVyYXRpb24sIHNvIGl0J3MgbW9yZSByZWFzb25hYmxlIHRvIGRvICJz
ZXQgY2FwYWNpdHkiIGluDQpzZ3hfY2dyb3VwX2luaXQoKSBhbmQgZG8gInJlc2V0IHRvIDAiIGlu
IHRoZQ0KDQoJLyogU0dYIEVQQyBjZ3JvdXAgY2xlYW51cCAqLw0KDQphcyBzaG93biBhYm92ZS4N
Cg0KRXZlbnR1YWxseSwgeW91IHdpbGwgbmVlZCB0byBkbyBFUEMgY2dyb3VwIGNsZWFudXAgYW55
d2F5LCBlLmcuLCB0byBmcmVlDQp0aGUgd29ya3F1ZXVlLCBzbyBpdCdzIG9kZCB0byBoYXZlIHR3
byBwbGFjZXMgdG8gaGFuZGxlIEVQQyBjZ3JvdXANCmNsZWFudXAuDQoNCkkgdW5kZXJzdGFuZCB0
aGUgcmVhc29uICJzZXQgY2FwYWNpdHkiIHBhcnQgaXMgZG9uZSBpbg0Kc2d4X3BhZ2VfY2FjaGVf
aW5pdCgpIG5vdyBpcyBiZWNhdXNlIGluIHRoYXQgZnVuY3Rpb24geW91IGNhbiBlYXNpbHkgZ2V0
DQp0aGUgY2FwYWNpdHkuICBCdXQgdGhlIGZhY3QgaXMgQHNneF9udW1hX25vZGVzIGFsc28gdHJh
Y2tzIEVQQyBzaXplIGZvcg0KZWFjaCBub2RlLCBzbyB5b3UgY2FuIGFsc28gZ2V0IHRoZSB0b3Rh
bCBFUEMgc2l6ZSBmcm9tIEBzZ3hfbnVtYV9ub2RlIGluDQpzZ3hfY2dyb3VwX2luaXQoKSBhbmQg
c2V0IGNhcGFjaXR5IHRoZXJlLg0KDQpJbiB0aGlzIGNhc2UsIHlvdSBjYW4gcHV0ICJyZXNldCBj
YXBhY2l0eSB0byAwIiBhbmQgImZyZWUgd29ya3F1ZXVlIg0KdG9nZXRoZXIgYXMgdGhlICJTR1gg
RVBDIGNncm91cCBjbGVhbnVwIiwgd2hpY2ggaXMgd2F5IG1vcmUgY2xlYXIgSU1ITy4NCg0K

