Return-Path: <cgroups+bounces-1707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DB85B74C
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 10:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EFBB21BCE
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D95FDA7;
	Tue, 20 Feb 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHc5iGAF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEB5FB9E;
	Tue, 20 Feb 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421220; cv=fail; b=ozFV5qbuhzeGM7VMxEM5WsjN+80QaA4cshaX24j5wCZAsDQDgmOCSGl43ZsMZ20jPlya+RXBZatupRBTWl2cuiOfYywMRNaKKVay9eGs4Bt+NIR3alyRG3pMdfeKhl+rGQ2iTq35Nmh8WQthlAy4QVkQE2AkGxnw96+QZvfkN8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421220; c=relaxed/simple;
	bh=ebkZLqh5VxTj59Cc1QgXI/4dFGqKknMvCd36fRAbobk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHeUG7kSSn0swZQ62tTgmD237YzB0BrARE3pZaSoFPShb/QVAfZOjBmDYY6FffKudKeAkpFUWwncXIuCYSlBzOeuwf6huvxvTVWKUDoL84EXYnPPcrvKVG8Hm60oGUPMFwycub/7olw2rya9ioC3awyVwPku+mTSUtWP7shCdOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHc5iGAF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708421218; x=1739957218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ebkZLqh5VxTj59Cc1QgXI/4dFGqKknMvCd36fRAbobk=;
  b=dHc5iGAFNIiUc2xubmclKCzqz0zPcFlToOmSyc7KzywnPtoLnNpdKUQA
   lW5aUxoCUxsyuJb9oaX+1WJFrflyzmCKpTQFg7Z50vbb404C+aBn+Hq3n
   +e3BfmVr2n7lqEe3fxFMFKP0XNEzj1EQl9ApxmSa3Rt8kEsL3VS0ppumX
   dE34uw113HqaAwHrIsim0txnzKrqsXVaeSmZpSgmCdTFLr7mgI79NXl9o
   RWzxvhMjpVpuYL0u9kFio8W8rbYNieb87NlmZCP+1tG15bxwxS8kZmbgm
   Eb3pos50bTT819n7LUC+uOy5hLBlHuA35wXuieBPSx40Ww9AkKuU9ZfGZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2658434"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2658434"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35750201"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 01:26:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:26:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:26:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 01:26:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 01:26:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNUF4oZ8ekbNJLc+Pg8wjFVX8zHmhBsP5UnyVJtwV8o1HbxgzDvEfScX89fYGM4XwPOIzHNT6a80CQJm1u8gNGZFpdGpi90WuifzkQup7l0U2i2TdO3cE0xRMNN/x/9bp7tP9liZTj5omxvtZ0SX+V7rrNBAjRS1MiUWRoyr5GBoQZzO0ihtfUsMoAG0N/SXZR2sqlzSJ5M9jgy/hoYHlrLweSCVa1FcWRXcwXw6IyuqUl4FkiAlR5bpInSnNszXrI38xXpU2F1zqZK9IZBwZ5FPhOkDhjhAoAZMAGekQDF5+zpXeM8Qv+Beb3dBP2LMiO57UKvgJG68R0PVZRlTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebkZLqh5VxTj59Cc1QgXI/4dFGqKknMvCd36fRAbobk=;
 b=WgoQeA2J+4bnsIz/Ylumx6Y+MmYgmafkme2ydRa1yqzmZE0bNdV7cFmNAxnmwzjCHzbb0AYrYbKM6cb0nAbuIcd0W1ddF0BLr8tNq2dsqYh3vIdE8abN2aYe060zoDeABQAhtPVY4AgwZ7XdquwHpaUbKY1iOqaVrM2ufa65iL0eEGd9N/l7ugXAFzNuvkUZCRQ2HzUENMQUudMoMa+mzV5izQ2VGPF5K1TowUXmZ8LW9IRxs8WSy7a8in1dvRxxKlRuyzlO+wTofG+ZiAqP5dBfoO2syFv+bPDbe8QjqK5DMi1642xc3kA33WbjXHuE5gqXkcv+wU8ynPQgmRlRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:26:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 09:26:53 +0000
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
Subject: Re: [PATCH v9 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
Thread-Topic: [PATCH v9 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
Thread-Index: AQHaWH7QFjWuGpm7Zkqwd5h4/0V4ebETDN8A
Date: Tue, 20 Feb 2024 09:26:52 +0000
Message-ID: <69fdc5b1cddad49d3be92e6bcaf35449d95d742e.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-8-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-8-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB7701:EE_
x-ms-office365-filtering-correlation-id: 467d216e-252c-438c-c7bf-08dc31f61304
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljBPWSiXNkDvQmppp3UbqI5T6exRicEk2fpPrHB2krGowI+4wRm6PM9TVcmvYQqEHSTy9DkNNBJJy3z1pH8ZtYU+Eg2hGHQrpoy3yZS8jXIoAUWO5MZtK8yjuTxCPhIAKu9k6/h6cRRpfbHIMBQ7D3tjZKTkzU0ilkLxIQYPeUGq6lLPTTIus/Skf9DKKGhNq6uOwRYay/9N4GCbLgBrDR7Pym2MFIKChOVG73Po7R7gzXNsudPhu+L4/5mkFf70/ieVCL0PhdmcvQRmxbr0VH0lLrk5MqF9fLVQ7yth4o8OXpka8c8ojbF6KRFpes2S0keimkhjKAi+ctIOw8oP/YWhGcrRUd0tUQVqntjvPtqiKO3CdV6SasOAvy3WyoWjX5bwYhLGfzh0SG12Bh9VT0ME7DmHEb2qF6LTmZzWjsZ6/6PTi1iogXYXspszT9pRm6R4IjE51Ro2pc31XMyxpLfg0MnS/M0ide2PFlnFpc8saRi5Ep3Lj83bJZqcjgnSmM/Wm6SUVCqrDznc7j5g+yNhxnOjO3OBSBasPZvAzG+p+RcMkMhqjodE0LNOiGpXAwR+Lr9XNYTy5jdlMg1ACVjgyl1PcgFxpBi6mISP54SsR0QuLDnNpSjDAhIQxMm778AhatCQq4VuyfWAwyKnXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU1HZlVoR0ZxY1JhTVJYalZBOXA2Qk9pVzZkUmM0OTk0a3g3cHJMdm1WRmd2?=
 =?utf-8?B?SVk5ajE1TWE3YU5HWUJiOGFTZ3FaYjF3MS9wNkhjeVNWdDhDVGJoRHViclE4?=
 =?utf-8?B?emdGRHdodUtkV0RYV25FVFl2cDNJSFhrVS95anUxanRpVTlZT0tzUWJueWJT?=
 =?utf-8?B?VDdiQzdaTVhON0h6NXluKzNpbUVWc3JMUHovUjRaK1hCbnhrVS92YXV2WHhN?=
 =?utf-8?B?SWhjRjlpSG9IbGdPcUt0Skk3RWF4SWhXelJkcUduQTN1QzFCbnIyN2FWbHda?=
 =?utf-8?B?Z0o1NnRDOVNNNVZOa3JOM1ZxaUlESm8zTGdkMGlybDNJQUtsdkJHR3NDTFhL?=
 =?utf-8?B?N0U0UWhMaG5LaXNCNStIR1VBUXM0RktZQXp0N1AxblVCRXJCQmNLWFR4MEhv?=
 =?utf-8?B?cm5CUUR4UlhzTm9sSGprNWZtVTJOV1dRSGhCUkhZWlFtM3FBNmNjU3BoaFll?=
 =?utf-8?B?V1J0ZW1VYnBUc2dXeEZjWmRUaHlVN0tnbXl4ZDcvSU54bXNWWWJDWCtTTGtv?=
 =?utf-8?B?ZEsya1RYSUVVSks4ZDhxL0czbFJRemwvd256aWlub054S1RDSGVrSkQweFZv?=
 =?utf-8?B?c2U5aklBL3gwZ2dZNVc4V2hlN1N5L0NBelczZlpEeERtdm1LdTBSTVVJOXVa?=
 =?utf-8?B?R2RpSEFRSVg4YlJSZS9JY3FQaDlmanQ4aGZGT0hoU3Y4SkdtSTVOUVB4eXBM?=
 =?utf-8?B?M3FMSGV4NGwyY1ptOWZuVU9XQ1U1TU5vQ09yUG1SSFlOMkNoWUNxOXVQTGhV?=
 =?utf-8?B?Q2p0dmZXL0x0YXhqU3ArMVhwbytvdXdCV0Y5OW9YcWRBZEsxYXFuQWdZaEth?=
 =?utf-8?B?WHhqUXpTWTZkR3IrdG01bGlsZHhaR1hoNnliMHhrdEYyVjB6MEU2ZWV3R0Fo?=
 =?utf-8?B?T2I4V3BTSDl1MFl1MUcxa0dHcFlYNm80TUg5MEFMMm9WdUhlbU1xYVBnN1RK?=
 =?utf-8?B?MGQydDRham9Ob1Y4R0p6cm9BOUtDZVg0WWpYUUJWREszanVodmNITktsMVly?=
 =?utf-8?B?T2VCdnp0aEplSUdoRm5PM2NqSTUyVWRrRzdrR3A1bVBrWFN2RHhsRUtQSDB5?=
 =?utf-8?B?VDdYeFZVWXQ5RWVmR0FTMVhXTnk4dTJOaVVFbmFwTDNWTy9RcWRiSGhuMVkv?=
 =?utf-8?B?YVR3L3FBOXpTdjBialE3NHpRN2t6aTZpS0lyeFJFTmtGV29jQk84R0lsOEh6?=
 =?utf-8?B?YnBhRHdydDRaZkhxNGNFTnBGbS9GVU5XSHA2ZmtqZEZjbFVNYTJCYlg2WEx0?=
 =?utf-8?B?bWE0N1VIVjJaTnJMWkZvcjJzcnVnckxZbTdLMFV6ZjVVQUFINFhkNkdFNUpZ?=
 =?utf-8?B?Q3F4ZFk1R0l5N2lCSGJFV3A1SStnU0xXRkNSYU9zUFo2dDVTdEZuQ2p5RmxB?=
 =?utf-8?B?OEtpYVExTHA1SVZTRnIwVkt1VVpnemE2YVFRODBiV0NodFJRbElPbURCRUw2?=
 =?utf-8?B?QXJqdVRkZXR5SU9BZ0h4bWFtWU9EdGkrVFkxdzRYV0g5NmN5SUcxMy9hdGJ1?=
 =?utf-8?B?MWVvR0ptWTdSc0ZIalpLMWdmcW5zVW5HaVFDZjRObFRCNFR2d0FhVXhsS09l?=
 =?utf-8?B?TDlhcnZxVlJQY1A4dXJFYUxnWkhPRCtCZnptcHRtVEk0RlFYcS9BREdqMGE0?=
 =?utf-8?B?aWNCeDBPZVAzS1FwNnp3Tjg4QXhEZXZHdGRaRjZIeUdkMEVtSThOVy9jcmUw?=
 =?utf-8?B?S05vb0tkeEp0b3JBYkdJMjluZ3AxTDUrZXFKRTlhZXhjakdSMU0yRUZCU2E5?=
 =?utf-8?B?Q3V2YjlkeHdSOHJoUEV2VHd5QzJYR0tnUUtvbUZPTGorOTdMT0h6NnRCUis2?=
 =?utf-8?B?S1BhVmpKWXBUa2Y0MnNXNzF6amt4czJMdGdSYkVva2FRTTRQZGUvcE5tRnN4?=
 =?utf-8?B?SW1DRExyRFQyL3k2R3VYZmszVjZVMVM1SXl0MExPUWR0cnc1Mk0yQmtMcGsx?=
 =?utf-8?B?VDl2emduQ3FubGkwSkt0WVl0dFBrR3lQSU05YXBKR29nN29ZeDNiQzk0TkdP?=
 =?utf-8?B?WktnYzJQdUZlQVhDOEoyc2RvUUNIbHE2enVmdzJJb3M1dnMzZU5Da0Y5WkZ5?=
 =?utf-8?B?aHNoQkRWWjNFRjJBS240VEFTVkplNlZzUSszeCtjbnBjV0hXUVZYZWRJRldO?=
 =?utf-8?B?NTduM3BlVmNDK3l2ci8yVEorQVpPQVl2S2d3SHNseU1pYTZzdjYyUDFkUFF5?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A44EFBAF7CD2B64E899C562541918774@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467d216e-252c-438c-c7bf-08dc31f61304
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 09:26:52.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMaRrjbJpehbD99MvHGz7gPpBY6rbd8AgXWD63n9nqZfNRHtt20gcq1nj0HBweihGZwB3QS5FmqRlFXjh0yzgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjA2IC0wODAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBFYWNoIEVQQyBjZ3JvdXAgd2lsbCBoYXZlIGFuIExSVSBzdHJ1Y3R1cmUgdG8g
dHJhY2sgcmVjbGFpbWFibGUgRVBDIHBhZ2VzLg0KPiBXaGVuIGEgY2dyb3VwIHVzYWdlIHJlYWNo
ZXMgaXRzIGxpbWl0LCB0aGUgY2dyb3VwIG5lZWRzIHRvIHJlY2xhaW0gcGFnZXMNCj4gZnJvbSBp
dHMgTFJVIG9yIExSVXMgb2YgaXRzIGRlc2NlbmRhbnRzIHRvIG1ha2Ugcm9vbSBmb3IgYW55IG5l
dw0KPiBhbGxvY2F0aW9ucy4NCj4gDQo+IFRvIHByZXBhcmUgZm9yIHJlY2xhbWF0aW9uIHBlciBj
Z3JvdXAsIGV4cG9zZSB0aGUgdG9wIGxldmVsIHJlY2xhbWF0aW9uDQo+IGZ1bmN0aW9uLCBzZ3hf
cmVjbGFpbV9wYWdlcygpLCBpbiBoZWFkZXIgZmlsZSBmb3IgcmV1c2UuIEFkZCBhIHBhcmFtZXRl
cg0KPiB0byB0aGUgZnVuY3Rpb24gdG8gcGFzcyBpbiBhbiBMUlUgc28gY2dyb3VwcyBjYW4gcGFz
cyBpbiBkaWZmZXJlbnQNCj4gdHJhY2tpbmcgTFJVcyBsYXRlci4gwqANCj4gDQoNClsuLi5dDQoN
Cj4gQWRkIGFub3RoZXIgcGFyYW1ldGVyIGZvciBwYXNzaW5nIGluIHRoZSBudW1iZXIgb2YNCj4g
cGFnZXMgdG8gc2NhbiBhbmQgbWFrZSB0aGUgZnVuY3Rpb24gcmV0dXJuIHRoZSBudW1iZXIgb2Yg
cGFnZXMgcmVjbGFpbWVkDQo+IGFzIGEgY2dyb3VwIHJlY2xhaW1lciBtYXkgbmVlZCB0byB0cmFj
ayByZWNsYW1hdGlvbiBwcm9ncmVzcyBmcm9tIGl0cw0KPiBkZXNjZW5kYW50cywgY2hhbmdlIG51
bWJlciBvZiBwYWdlcyB0byBzY2FuIGluIHN1YnNlcXVlbnQgY2FsbHMuDQoNCkZpcnN0bHksIHNv
cnJ5IGZvciBsYXRlIHJlcGx5IGFzIEkgd2FzIGF3YXkuICANCg0KRnJvbSB0aGUgY2hhbmdlbG9n
LCBpdCdzIHVuZGVyc3RhbmRhYmxlIHlvdSB3YW50IHRvIG1ha2UgdGhpcyBmdW5jdGlvbiByZXR1
cm4NCnBhZ2VzIHRoYXQgYXJlIGFjdHVhbGx5IHJlY2xhaW1lZCwgYW5kIHBlcmhhcHMgaXQncyBh
bHNvIE9LIHRvIHBhc3MgdGhlIG51bWJlcg0Kb2YgcGFnZXMgdG8gc2Nhbi4NCg0KQnV0IHRoaXMg
ZG9lc24ndCBleHBsYWluIHdoeSB5b3UgbmVlZCB0byBtYWtlIEBucl90b19zY2FuIGFzIGEgcG9p
bnRlciwgd2hpbGUNCnlvdSBhcmUgcmV0dXJuaW5nIHRoZSBudW1iZXIgb2YgcGFnZXMgdGhhdCBh
cmUgYWN0dWFsbHkgcmVjbGFpbWVkPw0KDQpBbmQgLi4uDQoNClsuLi5dDQoNCj4gLS8qDQo+IC0g
KiBUYWtlIGEgZml4ZWQgbnVtYmVyIG9mIHBhZ2VzIGZyb20gdGhlIGhlYWQgb2YgdGhlIGFjdGl2
ZSBwYWdlIHBvb2wgYW5kDQo+IC0gKiByZWNsYWltIHRoZW0gdG8gdGhlIGVuY2xhdmUncyBwcml2
YXRlIHNobWVtIGZpbGVzLiBTa2lwIHRoZSBwYWdlcywgd2hpY2ggaGF2ZQ0KPiAtICogYmVlbiBh
Y2Nlc3NlZCBzaW5jZSB0aGUgbGFzdCBzY2FuLiBNb3ZlIHRob3NlIHBhZ2VzIHRvIHRoZSB0YWls
IG9mIGFjdGl2ZQ0KPiAtICogcGFnZSBwb29sIHNvIHRoYXQgdGhlIHBhZ2VzIGdldCBzY2FubmVk
IGluIExSVSBsaWtlIGZhc2hpb24uDQo+ICsvKioNCj4gKyAqIHNneF9yZWNsYWltX3BhZ2VzKCkg
LSBSZWNsYWltIGEgZml4ZWQgbnVtYmVyIG9mIHBhZ2VzIGZyb20gYW4gTFJVDQo+ICsgKg0KPiAr
ICogVGFrZSBhIGZpeGVkIG51bWJlciBvZiBwYWdlcyBmcm9tIHRoZSBoZWFkIG9mIGEgZ2l2ZW4g
TFJVIGFuZCByZWNsYWltIHRoZW0gdG8NCj4gKyAqIHRoZSBlbmNsYXZlJ3MgcHJpdmF0ZSBzaG1l
bSBmaWxlcy4gU2tpcCB0aGUgcGFnZXMsIHdoaWNoIGhhdmUgYmVlbiBhY2Nlc3NlZA0KPiArICog
c2luY2UgdGhlIGxhc3Qgc2Nhbi4gTW92ZSB0aG9zZSBwYWdlcyB0byB0aGUgdGFpbCBvZiB0aGUg
bGlzdCBzbyB0aGF0IHRoZQ0KPiArICogcGFnZXMgZ2V0IHNjYW5uZWQgaW4gTFJVIGxpa2UgZmFz
aGlvbi4NCj4gICAqDQo+ICAgKiBCYXRjaCBwcm9jZXNzIGEgY2h1bmsgb2YgcGFnZXMgKGF0IHRo
ZSBtb21lbnQgMTYpIGluIG9yZGVyIHRvIGRlZ3JhZGUgYW1vdW50DQoNCi4uLiB0aGVyZSdzIG5v
IGNvbW1lbnQgdG8gZXhwbGFpbiBzdWNoIGRlc2lnbiBlaXRoZXIgKEBucl90b19zY2FuIGFzIGEg
cG9pbnRlcikuDQoNCkJ0dywgd2l0aCB0aGlzIGNoYW5nZSwgc2VlbXMgIlRha2UgYSBmaXhlZCBu
dW1iZXIgb2YgcGFnZXMgLi4uIiBhbmQgImF0IHRoZQ0KbW9tZW50IDE2IiBhcmUgbm90IGFjY3Vy
YXRlIGFueSBtb3JlLg0KDQo+ICAgKiBvZiBJUEkncyBhbmQgRVRSQUNLJ3MgcG90ZW50aWFsbHkg
cmVxdWlyZWQuIHNneF9lbmNsX2V3YigpIGRvZXMgZGVncmFkZSBhIGJpdA0KPiBAQCAtMjk4LDgg
KzMwMCwxMyBAQCBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbWVyX3dyaXRlKHN0cnVjdCBzZ3hfZXBj
X3BhZ2UgKmVwY19wYWdlLA0KPiAgICogKyBFV0IpIGJ1dCBub3Qgc3VmZmljaWVudGx5LiBSZWNs
YWltaW5nIG9uZSBwYWdlIGF0IGEgdGltZSB3b3VsZCBhbHNvIGJlDQo+ICAgKiBwcm9ibGVtYXRp
YyBhcyBpdCB3b3VsZCBpbmNyZWFzZSB0aGUgbG9jayBjb250ZW50aW9uIHRvbyBtdWNoLCB3aGlj
aCB3b3VsZA0KPiAgICogaGFsdCBmb3J3YXJkIHByb2dyZXNzLg0KPiArICoNCj4gKyAqIEBscnU6
CVRoZSBMUlUgZnJvbSB3aGljaCBwYWdlcyBhcmUgcmVjbGFpbWVkLg0KPiArICogQG5yX3RvX3Nj
YW46IFBvaW50ZXIgdG8gdGhlIHRhcmdldCBudW1iZXIgb2YgcGFnZXMgdG8gc2NhbiwgbXVzdCBi
ZSBsZXNzIHRoYW4NCj4gKyAqCQlTR1hfTlJfVE9fU0NBTi4NCj4gKyAqIFJldHVybjoJTnVtYmVy
IG9mIHBhZ2VzIHJlY2xhaW1lZC4NCj4gICAqLw0KPiAtc3RhdGljIHZvaWQgc2d4X3JlY2xhaW1f
cGFnZXModm9pZCkNCj4gK3Vuc2lnbmVkIGludCBzZ3hfcmVjbGFpbV9wYWdlcyhzdHJ1Y3Qgc2d4
X2VwY19scnVfbGlzdCAqbHJ1LCB1bnNpZ25lZCBpbnQgKm5yX3RvX3NjYW4pDQo+ICB7DQo+ICAJ
c3RydWN0IHNneF9lcGNfcGFnZSAqY2h1bmtbU0dYX05SX1RPX1NDQU5dOw0KPiAgCXN0cnVjdCBz
Z3hfYmFja2luZyBiYWNraW5nW1NHWF9OUl9UT19TQ0FOXTsNCj4gQEAgLTMxMCwxMCArMzE3LDEw
IEBAIHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzKHZvaWQpDQo+ICAJaW50IHJldDsNCj4g
IAlpbnQgaTsNCj4gIA0KPiAtCXNwaW5fbG9jaygmc2d4X2dsb2JhbF9scnUubG9jayk7DQo+IC0J
Zm9yIChpID0gMDsgaSA8IFNHWF9OUl9UT19TQ0FOOyBpKyspIHsNCj4gLQkJZXBjX3BhZ2UgPSBs
aXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnNneF9nbG9iYWxfbHJ1LnJlY2xhaW1hYmxlLA0KPiAt
CQkJCQkJICAgIHN0cnVjdCBzZ3hfZXBjX3BhZ2UsIGxpc3QpOw0KPiArCXNwaW5fbG9jaygmbHJ1
LT5sb2NrKTsNCj4gKw0KPiArCWZvciAoOyAqbnJfdG9fc2NhbiA+IDA7IC0tKCpucl90b19zY2Fu
KSkgew0KPiArCQllcGNfcGFnZSA9IGxpc3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmbHJ1LT5yZWNs
YWltYWJsZSwgc3RydWN0IHNneF9lcGNfcGFnZSwgbGlzdCk7DQo+ICAJCWlmICghZXBjX3BhZ2Up
DQo+ICAJCQlicmVhazsNCj4gIA0KPiBAQCAtMzI4LDcgKzMzNSw4IEBAIHN0YXRpYyB2b2lkIHNn
eF9yZWNsYWltX3BhZ2VzKHZvaWQpDQo+ICAJCQkgKi8NCj4gIAkJCWVwY19wYWdlLT5mbGFncyAm
PSB+U0dYX0VQQ19QQUdFX1JFQ0xBSU1FUl9UUkFDS0VEOw0KPiAgCX0NCj4gLQlzcGluX3VubG9j
aygmc2d4X2dsb2JhbF9scnUubG9jayk7DQo+ICsNCj4gKwlzcGluX3VubG9jaygmbHJ1LT5sb2Nr
KTsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBjbnQ7IGkrKykgew0KPiAgCQllcGNfcGFnZSA9
IGNodW5rW2ldOw0KPiBAQCAtMzUxLDkgKzM1OSw5IEBAIHN0YXRpYyB2b2lkIHNneF9yZWNsYWlt
X3BhZ2VzKHZvaWQpDQo+ICAJCWNvbnRpbnVlOw0KPiAgDQo+ICBza2lwOg0KPiAtCQlzcGluX2xv
Y2soJnNneF9nbG9iYWxfbHJ1LmxvY2spOw0KPiAtCQlsaXN0X2FkZF90YWlsKCZlcGNfcGFnZS0+
bGlzdCwgJnNneF9nbG9iYWxfbHJ1LnJlY2xhaW1hYmxlKTsNCj4gLQkJc3Bpbl91bmxvY2soJnNn
eF9nbG9iYWxfbHJ1LmxvY2spOw0KPiArCQlzcGluX2xvY2soJmxydS0+bG9jayk7DQo+ICsJCWxp
c3RfYWRkX3RhaWwoJmVwY19wYWdlLT5saXN0LCAmbHJ1LT5yZWNsYWltYWJsZSk7DQo+ICsJCXNw
aW5fdW5sb2NrKCZscnUtPmxvY2spOw0KPiAgDQo+ICAJCWtyZWZfcHV0KCZlbmNsX3BhZ2UtPmVu
Y2wtPnJlZmNvdW50LCBzZ3hfZW5jbF9yZWxlYXNlKTsNCj4gIA0KPiBAQCAtMzY2LDYgKzM3NCw3
IEBAIHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzKHZvaWQpDQo+ICAJCQlzZ3hfcmVjbGFp
bWVyX2Jsb2NrKGVwY19wYWdlKTsNCj4gIAl9DQo+ICANCj4gKwlyZXQgPSAwOw0KPiAgCWZvciAo
aSA9IDA7IGkgPCBjbnQ7IGkrKykgew0KPiAgCQllcGNfcGFnZSA9IGNodW5rW2ldOw0KPiAgCQlp
ZiAoIWVwY19wYWdlKQ0KPiBAQCAtMzc4LDcgKzM4NywxMCBAQCBzdGF0aWMgdm9pZCBzZ3hfcmVj
bGFpbV9wYWdlcyh2b2lkKQ0KPiAgCQllcGNfcGFnZS0+ZmxhZ3MgJj0gflNHWF9FUENfUEFHRV9S
RUNMQUlNRVJfVFJBQ0tFRDsNCj4gIA0KPiAgCQlzZ3hfZnJlZV9lcGNfcGFnZShlcGNfcGFnZSk7
DQo+ICsJCXJldCsrOw0KPiAgCX0NCj4gKw0KPiArCXJldHVybiAodW5zaWduZWQgaW50KXJldDsN
Cj4gIH0NCj4gIA0KDQpIZXJlIGJhc2ljYWxseSB0aGUgQG5yX3RvX3NjYW4gaXMgcmVkdWNlZCBi
eSB0aGUgbnVtYmVyIG9mIHBhZ2VzIHRoYXQgYXJlDQppc29sYXRlZCBmb3IgaXNvbGF0aW9uLCBi
dXQgdGhlc2UgcGFnZXMgbWF5IG5vdCBiZSBhY3R1YWxseSByZWNsYWltZWQsIGUuZy4sIGR1ZQ0K
dG8gYWdpbmcuDQoNCkNvdWxkIHlvdSBjbGFyaWZ5IHRoZSByZWFzb24gb2Ygc3VjaCBjaG9pY2Ug
aW4gdGhpcyBwYXRjaCwgcHJlZmVyYWJsZSB1c2luZyBhDQpjb21tZW50IChhbmQvb3IgaW4gY2hh
bmdlbG9nIGlmIGJldHRlcik/DQoNCkluIHY4J3MgcmVwbHkgeW91IG1lbnRpb25lZCB0aGlzIGlz
IGR1ZSB0byAidGhlIHVuY2VydGFpbnR5IG9mIGhvdyBsb25nIGl0IHRha2VzDQp0byByZWNsYWlt
IHBhZ2VzIiBhbmQgc29tZSBvdGhlciByZWFzb25zLCBidXQgSSBhbSBub3Qgc3VyZSB3aGV0aGVy
IHRoYXQNCmp1c3RpZnkuDQoNCkFuZCBBRkFJQ1QgaXQgYWxzbyBkZXBlbmRzIG9uIGhvdyB0aGlz
IGZ1bmN0aW9uIGlzIGNhbGxlZC4gIFBsZWFzZSBhbHNvIHNlZSBteQ0KcmVwbHkgdG8geW91ciBu
ZXh0IHBhdGNoICh3aGVyZSBpdCBpcyBjYWxsZWQpLg0KDQpUaGF0IGJlaW5nIHNhaWQsIGRvZXMg
aXQgbWFrZSBtb3JlIHNlbnNlIGlmIHlvdSBjYW4ganVzdCBtZXJnZSB0aGlzIHBhdGNoIHRvDQp5
b3VyIG5leHQgcGF0Y2ggZm9yIGJldHRlciByZXZpZXc/DQo=

