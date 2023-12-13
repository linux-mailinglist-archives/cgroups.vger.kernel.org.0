Return-Path: <cgroups+bounces-934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7544810F9F
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220E4B20C3E
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECA622F0D;
	Wed, 13 Dec 2023 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghhaJIgR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E4B0;
	Wed, 13 Dec 2023 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702466240; x=1734002240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=if0xs9WvK67+KkbGVdV7/9ExqSPCzWdoNl+pIcf755o=;
  b=ghhaJIgR6pOc+0iG62lyIGknXtJwzGkxbnpBQBBOHNgO3+LnaacXhZ7t
   YNzK/ocLcoxk8Vt5GeL2iACt0VFStVYZLe39LeQhH1amIbisQv0hNU7/D
   a7f5udVxESZJNtvjswTOr6yQP9y4tlaA60sB71wnXF1ldw2EfXK9tPRzc
   xGypISv94//R5KhtNmS46EBWEyHZfHCQsEoqxYtqLI22Do1z/ET/NBQi3
   6dmr+a/RV/UVAypxiHvCUbVzWrnkaz0lp5I31/MPvvz0TCSmvPCI478fq
   x7Sc+20nH15pwDtaIrlI9sjwMdaIgavsG3Ovb2UgrXD+Yc2c2XQjTVKWq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="394700654"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="394700654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802849836"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="802849836"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 03:17:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 03:17:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 03:17:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 03:17:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMAob246UhRbMk3ElPrEX960atLHm0JUEdD5PTZTiJQVqNvBsdkEi3gN+WBirJpfLZsroG9s3DSiWkO+OWsfelharp1WMRsS1mO5GwzkTiLrHVB68X9h2Sdyc7jFmQNNBdWTZeUvBHxbMD4As8YI/E1ad9Kk6Ou+b3YeoV9IBBvLAYE94C3MVklW+Bp235eqKBqMME8js2kJ8EyKMLCOHGC0R2F7+cC3Gos/8ijBWmn5zcklaZZ3ctQf5/092DM/9QQpBaZz+ka33ZUE9QpeUqh0LrbkCSmnlNS1vluuGuzxXcTMx/Lp6bLxgyESOE3MGo263bHe+C+6wrxMri/+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if0xs9WvK67+KkbGVdV7/9ExqSPCzWdoNl+pIcf755o=;
 b=jU+ssh26gIET3sZqN3ltzCJYefWE0cY0hJ1/gtOe29XfUWI21bzJrOPQbDJThCt11A1ILsOTPUxvHH66HSppqvxpsgkaOpuQIAAp4uUtN5S0o8xXB7TX5kAKILp29HBXSolaYvFRfcZMA61QowKOybHxcAZpdEgNKkql6mB9yPy2yVuB7s7LCuqbxsx7cjSieOuyx0Ftooyr0tJaIoG7wnrut5KwLMxK5Q5ntOs+yyvFoh6HB3udjNd4vQmc3uCZc3m8Ofx8zf/izNYh2bC8USxcZaHFCdtLhlgv9ITmN+lCcdGPXvB5Rvu7zl1+lnPQJ2wJgm5jiGS3FdMkrpJ7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 11:17:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 11:17:12 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
	<sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Topic: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Index: AQHaC13fVBhlQReaAU+BOIqG+a/nT7CCsVeAgApC3oCAASUwAIAXMJEAgAILHwA=
Date: Wed, 13 Dec 2023 11:17:11 +0000
Message-ID: <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-10-haitao.huang@linux.intel.com>
	 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
	 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
	 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4610:EE_
x-ms-office365-filtering-correlation-id: 9e5a6614-159c-41c4-97b1-08dbfbcd0dc0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBPrNS9/4Utd03eUZ0/mq43P7J2NvkY5SUP8Yl5r4V8zDbDZPYUfqxR4onr/EMO/K67dLbZNBth3oVHkE1mU4EsVnxrumX256S3vp21okQggwz/6HQO5cQpKHQqpgetISCo3uI5ihQCPFAPgqLnZ0gPa4m39W3LGovJXkGE+hEIuARl2FqgwzUKDrwFsomAGwp0a46xvQbuHaRyta1Jg/9GZ++QXXjBxaF8uelWEl9mRMHbZ2WK/skZxadHxfIDv+k2FfsfqiUIlqAI3Z5i5IdfxYLilMsZxJM3vCnFzWhkg9GevAjMi9e13b7LyKc8vdzBc/oJUc5rr+PqKFYsYoZ5ZLClEIUtLZvLGg98fumydr7yiFGF/Y5iJtq3A77ZtzK8afIyK15KbDObgrpMAT1zXirP+UfkDBUCPmmv2rnxgTcWg6/HLU+QKX9IVSMcJAf/+sxUBcRIyytasN/enjNwwI6XBDkQXPH02Fh3rbbN11WvJxIjhymfO9q6TzSPkZcitstzfLQkEeVxdE8n5p6KZ9JIDVB2SqnVC3XAcxqrkP/y/Bz8KjBqyMIgjDXGkClMXGKlM2Zl+f393KUPKlyIgHzxLB3hF10tqGI6Dp/pBqUF0ep2emoJ0Zsc1mtMrVYkF5OBnzKe6lMUwgihmNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(921008)(38070700009)(91956017)(76116006)(66946007)(66556008)(54906003)(66476007)(64756008)(66446008)(82960400001)(36756003)(86362001)(122000001)(38100700002)(26005)(83380400001)(6512007)(2616005)(6506007)(4326008)(6486002)(2906002)(4001150100001)(316002)(110136005)(478600001)(71200400001)(5660300002)(7416002)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk43RWxVMk1oMkFPSmJCTmtNQkJKdlFEUFB6SEhoaHFHaW1CSGVmUkhKYUlZ?=
 =?utf-8?B?MTJJczlPUWV3bGxXbURPRmIrL1djY2Z5TnB0MGhqUkxNbTAwZUZqMGFZNWNJ?=
 =?utf-8?B?cU00UUpINUdacWgxMGdwdnRQOTNIRXVZUjRDOHRoeTRIZlJBK0xCNjBnRndI?=
 =?utf-8?B?SzIwRHNQdi9CcXVkT1YvRWxBMFVvdFQreitndDhtY3EvMDZESDllYkRTczFT?=
 =?utf-8?B?TzI2MTRVUnFoRFp3Y3NuSUovU3YrQ1pTK1pYazFINVJrUmxGc1lhaXVwZEIx?=
 =?utf-8?B?dGdycXVmODR3S0M1MTdRRWVvV3o4OUZwdk1wRjhya2tVRzlXM2hheEh2bTJX?=
 =?utf-8?B?ekhiK0YvNTBvTnVBTXIyT0gwL2E5VVQ5MXVTWWpRQlNXcVRCVVAreDFCek9x?=
 =?utf-8?B?MHIwWSt0ZFdEK1hESFNXdmpEQnJpVnJwaVF1UjFKSitCZ24vbnFjVFdJVFJv?=
 =?utf-8?B?Z1k5alJZQ2E5UUxjc2hhaUNtL3lUYXJlSE5zQ054K1dWTER2UGo2elRXNG0y?=
 =?utf-8?B?SXkxWGhRN2wxZlN3RWp3d0RSRjY1dnluY1pOK1FCUndRWlpxMHh6MHZMenAw?=
 =?utf-8?B?YWJjNzZVWGtPL0Z5SmdxYXFqMWNzOWxkWkF6WmUyWmtYSGRnTmNoMXNLU0N5?=
 =?utf-8?B?Nm1GenhkbzFKWTlac085MnRhSUdmR2R3eXZ6c0p0M0tyeHJqR1Ezb3lzMStG?=
 =?utf-8?B?TWp6dVZoZXhHRFBWaEhQZW1Cc0VxSHNqS0xlazlNZWthQUFwSnhlQ050N0tv?=
 =?utf-8?B?ZVlERlRKd0FhY0wrdks5cWNoTjJYMVpZaDFPcXllckpXZThHZWhEV2dvOFBo?=
 =?utf-8?B?d3QyMVVDSEJuMFN2aHdIMHdmZXp6dEc1NzIrNnlPUDdaWDNGZE53a3M0eW4z?=
 =?utf-8?B?aEFrY3RtOWtaS1JRUURuQW5qL3pLbllEbmNaeGVUYWJFeUFKd2t2WUhrV3VI?=
 =?utf-8?B?bzFqVWRXSDJxRW16LzN5R1BSNVpzeWpJaW1zcnpJVS9SUmFrakNyK3VOK2th?=
 =?utf-8?B?YTY5bXZROWhzUnI5b2twYm5lTkhERHJiS1NhWXdtOU9WbXhUWHQwanZ2ZHRs?=
 =?utf-8?B?QWNaL21mYkFaeGVHQUdMckZSWWlqYU9VZk1wMU0vY0J5U3d1SkNVZllFV1FZ?=
 =?utf-8?B?K2FSYU5aeFp4ZEZHT2EvZ3R5UC95OWMvRzQveUgvelhaTUY0YTFUSmtIOVN5?=
 =?utf-8?B?UFE0a1RJUUtaUDNEOGVmUjQvWFVLdXJ1SU5mNVFGRkhyN25kRTdEU1ArWVR1?=
 =?utf-8?B?STAxOWVobWJ4WkNuQ1ZQU3NGVEU1NjJPakFXRTQwalZ3ZTJDVUFRaytVc09G?=
 =?utf-8?B?d0JUazF4TGZMamh6NENZZ09ZQUU5YUQ4dTF1OFE1U0dZdWZXOEw2dlJmTXFK?=
 =?utf-8?B?aEh6bVFuM1J5NlhyTG9mOWZsWjdYUGRoMUFZRUhKWi9JaEEvcmUwZFc2akpU?=
 =?utf-8?B?MDFDcmhFRU4xVkZsS0JYSVphd2pSUkRsNzl4ZzdYbUQzQXJMRVI5OWdTdnlJ?=
 =?utf-8?B?UGZrbnRDdmZJUFE1akE1N1ZrQWZ5dlpQWnZkM2w3dUVubVI0bklkYTZPUXhy?=
 =?utf-8?B?d21ERHpXQ2p0ZTk2VlVPQWdYTU5GV09DTHpUZU9nQ3ZCMUdBaDk3ZmVmSS9k?=
 =?utf-8?B?UVd5aDJWNW8wbjYvelg5RW5OSGw5Ky9aKzhoS0IvcWp4eFViK0VQYitoYkRN?=
 =?utf-8?B?K1FxUHdmc3RkOS9LT0VUTDF1cEtob2FNUVBMZTlZMkV6VWNZZkVFeXJWdURm?=
 =?utf-8?B?cFJWVUNZOGRiV1JJeXBBcHA5TUd5QXNNc01DUk1mL2RHU250T1VJQmlOd1Rm?=
 =?utf-8?B?NmlLNWppeklhK0lVWVNlUFJEZzN3TndOcmdOZnN6cmlYdkppNWV2bUtqS0tS?=
 =?utf-8?B?Z3IxVEthQ0oydUtVSVNBa3VpMXlwTzFwdFIrelN5U2Vza1JqRDlVRjNuM1hN?=
 =?utf-8?B?V2JTS01nS2pkbGcvckthRWxKdUMxMVFJK1lWaksrSlAzN3BKbnFGcUhyK2J0?=
 =?utf-8?B?RTYzTStldy91YmpEUnNlVndrYmUwSnovcGJ2Q1BJWWU4SjR1TlBDNmE4OW9Q?=
 =?utf-8?B?bjlQakJJRzQ2TVBtQkduRDNqaVRDZEo5MkVEVlVwL24vSWRxby9aSmJkWjBO?=
 =?utf-8?B?YnhBMk0rWGtkdk9ZUjBBeG1WR0dTZVlsTmRIU213b21zeDlJc29iSlpyeEd4?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3225F3C46CD1C140849551B4AA948899@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a6614-159c-41c4-97b1-08dbfbcd0dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 11:17:12.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XE0c8DU7b17J6lmkc03liJqdys5qUrgHAEyTGBDOJVz9sTNIXcGxs0XY5r0S5l1+lv2xMdOW/FRSAUFQiGHTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTEyLTExIGF0IDIyOjA0IC0wNjAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEhpIEthaQ0KPiANCj4gT24gTW9uLCAyNyBOb3YgMjAyMyAwMzo1NzowMyAtMDYwMCwgSHVhbmcs
IEthaSA8a2FpLmh1YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIE1vbiwgMjAyMy0x
MS0yNyBhdCAwMDoyNyArMDgwMCwgSGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAy
MCBOb3YgMjAyMyAxMTo0NTo0NiArMDgwMCwgSHVhbmcsIEthaSA8a2FpLmh1YW5nQGludGVsLmNv
bT4gIA0KPiA+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gT24gTW9uLCAyMDIzLTEwLTMwIGF0
IDExOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogU2VhbiBD
aHJpc3RvcGhlcnNvbiA8c2Vhbi5qLmNocmlzdG9waGVyc29uQGludGVsLmNvbT4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUbyBwcmVwYXJlIGZvciBwZXItY2dyb3VwIHJlY2xhbWF0aW9uLCBzZXBh
cmF0ZSB0aGUgdG9wLWxldmVsICANCj4gPiA+IHJlY2xhaW0NCj4gPiA+ID4gPiBmdW5jdGlvbiwg
c2d4X3JlY2xhaW1fZXBjX3BhZ2VzKCksIGludG8gdHdvIHNlcGFyYXRlIGZ1bmN0aW9uczoNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiAtIHNneF9pc29sYXRlX2VwY19wYWdlcygpIHNjYW5zIGFuZCBp
c29sYXRlcyByZWNsYWltYWJsZSBwYWdlcyBmcm9tICANCj4gPiA+IGENCj4gPiA+ID4gPiBnaXZl
biBMUlUgbGlzdC4NCj4gPiA+ID4gPiAtIHNneF9kb19lcGNfcmVjbGFtYXRpb24oKSBwZXJmb3Jt
cyB0aGUgcmVhbCByZWNsYW1hdGlvbiBmb3IgdGhlDQo+ID4gPiA+ID4gYWxyZWFkeSBpc29sYXRl
ZCBwYWdlcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDcmVhdGUgYSBuZXcgZnVuY3Rpb24sIHNn
eF9yZWNsYWltX2VwY19wYWdlc19nbG9iYWwoKSwgY2FsbGluZyAgDQo+ID4gPiB0aG9zZSB0d28N
Cj4gPiA+ID4gPiBpbiBzdWNjZXNzaW9uLCB0byByZXBsYWNlIHRoZSBvcmlnaW5hbCBzZ3hfcmVj
bGFpbV9lcGNfcGFnZXMoKS4gVGhlDQo+ID4gPiA+ID4gYWJvdmUgdHdvIGZ1bmN0aW9ucyB3aWxs
IHNlcnZlIGFzIGJ1aWxkaW5nIGJsb2NrcyBmb3IgdGhlICANCj4gPiA+IHJlY2xhbWF0aW9uDQo+
ID4gPiA+ID4gZmxvd3MgaW4gbGF0ZXIgRVBDIGNncm91cCBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBzZ3hfZG9fZXBjX3JlY2xhbWF0aW9uKCkgcmV0dXJucyB0aGUgbnVt
YmVyIG9mIHJlY2xhaW1lZCBwYWdlcy4gVGhlICANCj4gPiA+IEVQQw0KPiA+ID4gPiA+IGNncm91
cCB3aWxsIHVzZSB0aGUgcmVzdWx0IHRvIHRyYWNrIHJlY2xhaW1pbmcgcHJvZ3Jlc3MuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gc2d4X2lzb2xhdGVfZXBjX3BhZ2VzKCkgcmV0dXJucyB0aGUgYWRk
aXRpb25hbCBudW1iZXIgb2YgcGFnZXMgdG8gIA0KPiA+ID4gc2Nhbg0KPiA+ID4gPiA+IGZvciBj
dXJyZW50IGVwb2NoIG9mIHJlY2xhbWF0aW9uLiBUaGUgRVBDIGNncm91cCB3aWxsIHVzZSB0aGUg
IA0KPiA+ID4gcmVzdWx0IHRvDQo+ID4gPiA+ID4gZGV0ZXJtaW5lIGlmIG1vcmUgc2Nhbm5pbmcg
dG8gYmUgZG9uZSBpbiBMUlVzIGluIGl0cyBjaGlsZHJlbiAgDQo+ID4gPiBncm91cHMuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGlzIGNoYW5nZWxvZyBzYXlzIG5vdGhpbmcgYWJvdXQgIndoeSIsIGJ1
dCBvbmx5IG1lbnRpb25zIHRoZQ0KPiA+ID4gPiAiaW1wbGVtZW50YXRpb24iLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gRm9yIGluc3RhbmNlLCBhc3N1bWluZyB3ZSBuZWVkIHRvIHJlY2xhaW0gQG5wYWdl
c190b19yZWNsYWltIGZyb20gdGhlDQo+ID4gPiA+IEBlcGNfY2dycF90b19yZWNsYWltIGFuZCBp
dHMgZGVzY2VuZGFudHMsIHdoeSBjYW5ub3Qgd2UgZG86DQo+ID4gPiA+IA0KPiA+ID4gPiAJZm9y
X2VhY2hfY2dyb3VwX2FuZF9kZXNjZW5kYW50cygmZXBjX2NncnBfdG9fcmVjbGFpbSwgJmVwY19j
Z3JwKSB7DQo+ID4gPiA+IAkJaWYgKG5wYWdlc190b19yZWNsYWltIDw9IDApDQo+ID4gPiA+IAkJ
CXJldHVybjsNCj4gPiA+ID4gDQo+ID4gPiA+IAkJbnBhZ2VzX3RvX3JlY2xhaW0gLT0gc2d4X3Jl
Y2xhaW1fcGFnZXNfbHJ1KCZlcGNfY2dycC0+bHJ1LA0KPiA+ID4gPiAJCQkJCW5wYWdlc190b19y
ZWNsYWltKTsNCj4gPiA+ID4gCX0NCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGFueSBkaWZm
ZXJlbmNlIHRvIGhhdmUgImlzb2xhdGUiICsgInJlY2xhaW0iPw0KPiA+ID4gPiANCj4gPiA+IA0K
PiA+ID4gVGhpcyBpcyB0byBvcHRpbWl6ZSAicmVjbGFpbSIuIFNlZSBob3cgZXRyYWNrIHdhcyBk
b25lIGluIHNneF9lbmNsX2V3Yi4NCj4gPiA+IEhlcmUgd2UganVzdCBmb2xsb3cgdGhlIHNhbWUg
ZGVzaWduIGFzIGtzZ3hkIGZvciBlYWNoIHJlY2xhbWF0aW9uIGN5Y2xlLg0KPiA+IA0KPiA+IEkg
ZG9uJ3Qgc2VlIGhvdyBkaWQgeW91ICJmb2xsb3ciIGtzZ3hkLiAgSWYgSSBhbSBndWVzc2luZyBj
b3JyZWN0bHksIHlvdSAgDQo+ID4gYXJlDQo+ID4gYWZyYWlkIG9mIHRoZXJlIG1pZ2h0IGJlIGxl
c3MgdGhhbiAxNiBwYWdlcyBpbiBhIGdpdmVuIEVQQyBjZ3JvdXAsIHRodXMgIA0KPiA+IHcvbw0K
PiA+IHNwbGl0dGluZyBpbnRvICJpc29sYXRlIiArICJyZWNsYWltIiB5b3UgbWlnaHQgZmVlZCB0
aGUgInJlY2xhaW0iIGxlc3MgIA0KPiA+IHRoYW4gMTYNCj4gPiBwYWdlcywgd2hpY2ggbWlnaHQg
Y2F1c2Ugc29tZSBwZXJmb3JtYW5jZSBkZWdyYWRlPw0KPiA+IA0KPiA+IEJ1dCBpcyB0aGlzIGEg
Y29tbW9uIGNhc2U/ICBTaG91bGQgd2UgZXZlbiB3b3JyeSBhYm91dCB0aGlzPw0KPiA+IA0KPiA+
IEkgc3VwcG9zZSBmb3Igc3VjaCBuZXcgZmVhdHVyZSB3ZSBzaG91bGQgYnJpbmcgZnVuY3Rpb25h
bGl0eSBmaXJzdCBhbmQgIA0KPiA+IHRoZW4NCj4gPiBvcHRpbWl6YXRpb24gaWYgeW91IGhhdmUg
cmVhbCBwZXJmb3JtYW5jZSBkYXRhIHRvIHNob3cuDQo+ID4gDQo+IFRoZSBjb25jZXJuIGlzIG5v
dCBhYm91dCAicmVjbGFpbSBsZXNzIHRoYW4gMTYiLg0KPiBJIG1lYW4gdGhpcyBpcyBqdXN0IHJl
ZmFjdG9yaW5nIHdpdGggZXhhY3RseSB0aGUgc2FtZSBkZXNpZ24gb2Yga3NneGQgIA0KPiBwcmVz
ZXJ2ZWQswqANCj4gDQoNCkkgbGl0ZXJhbGx5IGhhdmUgbm8gaWRlYSB3aGF0IHlvdSBhcmUgdGFs
a2luZyBhYm91dCBoZXJlLiAga3NneGQoKSBqdXN0IGNhbGxzDQpzZ3hfcmVjbGFpbV9wYWdlcygp
LCB3aGljaCB0cmllcyB0byByZWNsYWltIDE2IHBhZ2VzIGF0IG9uY2UuDQoNCj4gaW4gdGhhdCB3
ZSBmaXJzdCBpc29sYXRlIGFzIG1hbnkgY2FuZGlkYXRlIEVQQyBwYWdlcyAodXAgIHRvICANCj4g
MTYsIGlnbm9yZSB0aGUgdW5uZWVkZWQgU0dYX05SX1RPX1NDQU5fTUFYIGZvciBub3cpLCB0aGVu
IGRvZXMgdGhlIGV3YiBpbiAgDQo+IG9uZSBzaG90IHdpdGhvdXQgYW55dGhpbmcgZWxzZSBkb25l
IGluIGJldHdlZW4uwqANCj4gDQoNCkFzc3VtaW5nIHlvdSBhcmUgcmVmZXJyaW5nIHRoZSBpbXBs
ZW1lbnRhdGlvbiBvZiBzZ3hfcmVjbGFpbV9wYWdlcygpLCBhbmQNCmFzc3VtaW5nIHRoZSAiaXNv
bGF0ZSIgeW91IG1lYW4gcmVtb3ZpbmcgRVBDIHBhZ2VzIGZyb20gdGhlIGxpc3QgKHdoaWNoIGlz
DQpleGFjdGx5IHdoYXQgdGhlIHNneF9pc29sYXRlX2VwY19wYWdlcygpIGluIHRoaXMgcGF0Y2gg
ZG9lcyksIHdoYXQgaGFwcGVucyB0bw0KdGhlIGxvb3BzIG9mICJiYWNraW5nIHN0b3JlIGFsbG9j
YXRpb24iIGFuZCAiRUJMT0NLIiwgYmVmb3JlIHRoZSBsb29wIG9mIEVXQj/CoA0KRWF0ZW4gYnkg
eW91Pw0KDQoNCj4gQXMgZGVzY3JpYmVkIGluIG9yaWdpbmFsICANCj4gY29tbWVudHMgZm9yIHRo
ZSBmdW5jdGlvbiBzZ3hfcmVjbGFpbV9wYWdlcyBhbmQgc2d4X2VuY2xfZXdiLCB0aGlzIGlzIHRv
ICANCj4gZmluaXNoIGFsbCBld2IgcXVpY2tseSB3aGlsZSBtaW5pbWl6aW5nIGltcGFjdCBvZiBJ
UEkuDQo+IA0KPiBUaGUgd2F5IHlvdSBwcm9wb3NlZCB3aWxsIHdvcmsgYnV0IGFsdGVycyB0aGUg
Y3VycmVudCBkZXNpZ24gYW5kIGJlaGF2aW9yICANCj4gaWYgY2dyb3VwcyBpcyBlbmFibGVkIGFu
ZCBFUENzIG9mIGFuIGVuY2xhdmUgYXJlIHRyYWNrZWQgYWNyb3NzIG11bHRpcGxlICANCj4gTFJV
cyB3aXRoaW4gdGhlIGRlc2NlbmRhbnQgY2dyb3VwcywgaW4gdGhhdCB5b3Ugd2lsbCBoYXZlIGlz
b2xhdGlvbiBsb29wLCAgDQo+IGJhY2tpbmcgc3RvcmUgYWxsb2NhdGlvbiBsb29wLCBlYmxvY2sg
bG9vcCBpbnRlcmxlYXZlZCB3aXRoIHRoZSBld2IgbG9vcC4NCj4gDQoNCkkgaGF2ZSBubyBpZGVh
IHdoYXQgeW91IGFyZSB0YWxraW5nIGFib3V0Lg0KDQpUaGUgcG9pbnQgaXMsIHdpdGggb3Igdy9v
IHRoaXMgcGF0Y2gsIHlvdSBjYW4gb25seSByZWNsYWltIDE2IEVQQyBwYWdlcyBpbiBvbmUNCmZ1
bmN0aW9uIGNhbGwgKGFzIHlvdSBoYXZlIHNhaWQgeW91IGFyZSBnb2luZyB0byByZW1vdmUgU0dY
X05SX1RPX1NDQU5fTUFYLA0Kd2hpY2ggaXMgYSBjaXBoZXIgdG8gYm90aCBvZiB1cykuICBUaGUg
b25seSBkaWZmZXJlbmNlIEkgY2FuIHNlZSBpcywgd2l0aCB0aGlzDQpwYXRjaCwgeW91IGNhbiBo
YXZlIG11bHRpcGxlIGNhbGxzIG9mICJpc29sYXRlIiBhbmQgdGhlbiBjYWxsIHRoZSAiZG9fcmVj
bGFpbSINCm9uY2UuDQoNCkJ1dCB3aGF0J3MgdGhlIGdvb2Qgb2YgaGF2aW5nIHRoZSAiaXNvbGF0
ZSIgaWYgdGhlICJkb19yZWNsYWltIiBjYW4gb25seSByZWNsYWltDQoxNiBwYWdlcyBhbnl3YXk/
DQoNCkJhY2sgdG8gbXkgbGFzdCByZXBseSwgYXJlIHlvdSBhZnJhaWQgb2YgYW55IExSVSBoYXMg
bGVzcyB0aGFuIDE2IHBhZ2VzIHRvDQoiaXNvbGF0ZSIsIHRoZXJlZm9yZSB5b3UgbmVlZCB0byBs
b29wIExSVXMgb2YgZGVzY2VuZGFudHMgdG8gZ2V0IDE2PyAgQ2F1c2UgSQ0KcmVhbGx5IGNhbm5v
dCB0aGluayBvZiBhbnkgb3RoZXIgcmVhc29uIHdoeSB5b3UgYXJlIGRvaW5nIHRoaXMuDQoNCg0K
PiA+IA0KDQo=

