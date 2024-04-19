Return-Path: <cgroups+bounces-2630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CD8AB731
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 00:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278C61C2096F
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6713D50C;
	Fri, 19 Apr 2024 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4NoBrxg"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4613D2B1;
	Fri, 19 Apr 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565327; cv=fail; b=XW+MLKu652XgSCIfXBn9PvELNNTf4OY2TdBqSxMQZGu2tC8S3jxfSWT+X7aSVHnhpU3iYfYgdAcelgx8vy3c6iFcV0/eQoRSqu9waooa8lNQXIzY7wytbiTw+qOItUQDLh0AmMAz07X5YDM5HABSvCOcfV+sjk4AXHQMJSkca0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565327; c=relaxed/simple;
	bh=9uSjk+zaUdUTUefGN2KOLgN2+NFtbqkJx9vPVuisAYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=od8GRWvDYpNxuqRmYFHvb57sTStBdB3pAGRgSY4fgKvortd3V1F7c28UVD6raLlFCeBt5lRa0MV6j/3dEhM7uBfunMpEm3CTTj4VyZeox8ej/mv0kuNUWLq+DDdy1V1f4khFWhIn+4HE1bcwqRl5LT+Wfn9eB3yPOo08leVYOgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4NoBrxg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713565325; x=1745101325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9uSjk+zaUdUTUefGN2KOLgN2+NFtbqkJx9vPVuisAYo=;
  b=E4NoBrxg7CZvyU9r3r77ArpumwQLHYkRc4LycWr8QR+eT6OnPtMB7GkW
   H4liItpWpLoI+X0G+XqbOr5yt47RY0uAE6ATTiUBlYjiIzhcyZUUzUJaO
   mNY5e0rAfDM6A9+AagKDWGr6/npNf0mHYoKd/Ex316ekxa+cXae7LLEGc
   5rXwg/MrpLuKALAm54zIiL3hJCqvTmZl0BzmSTkrEP9IaY12VYgzK7cNM
   FGlEYpb2dqKPDbdSiFmpXpomH8UsbqO33Lbt6BpjHXU3/5Yyz3Mjyr3m2
   0U64IW4eanDF4p3xRROHqbaODrO3xBZCSIqTanh30j64PIsBO/RDk9LJQ
   A==;
X-CSE-ConnectionGUID: BlQouGaaS8qmHoe7rZ0yEw==
X-CSE-MsgGUID: NubOaQVzRIOx8Q0PxwaBIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9301203"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9301203"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 15:22:05 -0700
X-CSE-ConnectionGUID: FFYq2HrPQfu5TQdpxJMQIA==
X-CSE-MsgGUID: O+E+Y8csRFOVTDstL6U7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="28114152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 15:21:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 15:21:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 15:21:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 15:21:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS3PxZnCY/KhbJZTeqCzhczLBmOB1oA0/FaloeSh4CRiy6gXPcKYT6EWILJdUMGzh0EkCIcaNn2kJ9q/zHeZBXmusB9TwVDzNBH+a4CxOBddS/ZIeK2HZSxg/QuZl+W5bmGLCqpiwxW/0TH18cJqEs+4PoROb5qIySRJY8lvlWEexWCOasIO3kLLppr3axRRAthsjB4lfnmdigf0vY+M2d0Lj1TAP2E42THFG916ajjXOjtdFO0E4zCz8itolFm2scep1WwJp73q1EyQj/qxVGoBcrSaYiISlimZGCwCsE3x1TUULXdC9M8E+21R7uDRzMDd10AIwHafo4sCjte4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uSjk+zaUdUTUefGN2KOLgN2+NFtbqkJx9vPVuisAYo=;
 b=b1SCAZqDJBx9DGaaCvDXkOfPGLkuLBowz8AeTGTa7fGSZ5ukebglWfT/029oJ7NANuvz9+HjEYFLH45k36MDl6S1kC+2FrngTqlDCqfkBb6KbGzE3VAnVjzcZjYUJbXwf4G46l0QvnzjhCCjTLccK+fT/SBklc/JfHPTAJvkFrjXxrDrf17Obl+JjbIY10vi5+ioHQMxf97PK6l4tmTCtDmqX2nvrWRpQFx7t6P16LYceu6Vxy8+pnVVDXXJOm4AWaETHMV4WCE0CVaxeQ8wbV1gaAVIznJQqAQaNo4jI0gDhK4ennQ6Zv+VY41zs+CqjPmDCsZXksmpL6ILGJ3pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Fri, 19 Apr
 2024 22:21:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 22:21:50 +0000
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
Subject: Re: [PATCH v12 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v12 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaj60F0e1WaPTcaUmrs6AIHx8jurFq4smAgAPA7ICAAA2RgIABOm4AgABE4IA=
Date: Fri, 19 Apr 2024 22:21:50 +0000
Message-ID: <3aa246ceac2e67bc8e06fcf6a0aad6878ab209f5.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-6-haitao.huang@linux.intel.com>
	 <a5e009636c5144622e0a910a459cd9d05976715e.camel@intel.com>
	 <op.2mf3ykfswjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <d401e7a1-44fa-44b6-9c6e-c0abdabd5111@intel.com>
	 <op.2mhmbqapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mhmbqapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB7660:EE_
x-ms-office365-filtering-correlation-id: 601cbd93-83d7-400a-fb12-08dc60bf1bd4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkE6VEr5CI+eEusIJjiVDCkaW+aJ2rTm5CmPl6XnN0T7fimkniaGZ7boYKrWLdrita1bElnzMfTLWqOCDOB76AWc4/ITVwaO+0DTvduLtrUPgj+k6cO2BdyXuIEdUJdjDikqjpQaicqtKNV8BJ/tLyRXkAOJQabevX6SK9JiCqxj2loD3y1DAabPCouxPwbJtSBC3vZivfwEWDBTQToqmjRNr62MSOzu4kiod/zyuxu99R1YvsCLbPdFd6P+BDTKkFmmAzvWPv6lpggFwP4Mi27c3lSp3lPIs/u5/XjV0BHBOf9t2xyrRfSz5fts4tDyOK6eJNVpufHGCk5tMEb1uhppS/ulSWTzA091hvrS7HPE+b8govVWhJXFD1ITt1Rpje30otxnCpxcgutcQwu5kMfeoUx4+zz6S7Bix0W1GfxkmQ5eQcR9C2n0XWwqZ9xQo6XK+FxhUUolDO3DDz2yfXudc5EHNSj5B4dddklXwvj8cDUeN4lMsTqao7WpyLcfFG0N9MKU1spQW93gwbafj/+UkhEN6E3uUrNAHCkB/cnvDvfCNfhXAM1j5pdCwG2g4Dp//0au/ToptNG8IC2OkYT+DwDJ9SrbBNZF1GOnYx8cMLvfs9J15AyEK6gzgg34Rq1nv+fdB96RCC0/YvcKgW2qHFrzLw0LjuNEo7KrnpAHuaaAzCiyANXRJGMBsuZog3sCpPnL1LLSn5E7qtBRgEcwJIWQ/FsnZbHfS/Gbptk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qlpoa0ZPS1dGQ0FLd1J1VW9BaExzT2RHRUl5WWZiMGVYclpwTUF6Tnlhbysr?=
 =?utf-8?B?VFZ3NXo1cndOankvZEtuRE9sQVZ5RjdMMW1ISFNCdVpkRGE5N3gvWG5HNjMz?=
 =?utf-8?B?ZnV0bC94T2QvWXg1RFoyNlVnbWFZdU5OczcyUFRUTTFZeTl1RFAvcWxsTmYv?=
 =?utf-8?B?SFpSR21DOFF5dkVYeXo2TmpGWUNDMmdSZUtXU25IWXBNcHFadUZUWkZLV1NQ?=
 =?utf-8?B?UXhaOWoweDdmQnYrTVE2QmlJS1VvVCtnRXc4MVBjWXJMbXYyMVV4ekNSMzBy?=
 =?utf-8?B?TG4xc2Y1S3A2eWRXYVpIeWtjTVRkYUpjSGRuZXVGZ2pOeE5tRWRWRDljaHhr?=
 =?utf-8?B?RFY4T1Avd2I4bTNTUGtRejY4a3pSeVF2TGZlZnBDeCtFSk5RRXNJb1RyUld3?=
 =?utf-8?B?TlI0TVZsR3dhOGRYamNZZnV6QVFKOG1mRG01MjB5alAxK2ZzSHZaSjExQUZs?=
 =?utf-8?B?SHlzOGhLTFlGRzVLRWEzUk5BRy9JejMybVU2S0lhVlNQTUhCYkFVRStlSWJB?=
 =?utf-8?B?OTAyTGNMczF6bWp6K0ViYktLN3ZGU0NGNmxYM3gyU0RsTTJtTlRaRm1CSnBi?=
 =?utf-8?B?dlRDRGV5SkNPRForeUZxdFoyNUU2SFNML3k0NWpXZk9KWmYwRUdENEtRM3NF?=
 =?utf-8?B?TUZIVHpZeVcyMjM0UERJcHZIcEJBN1pOYkp6N05DbklVc3RVbzRERDdsWWdL?=
 =?utf-8?B?VXZhY1VjODByaVA1OXVvYXBLcUJiaVhheFhhZUVmYkFZRXZJWVkvWHFQdUxk?=
 =?utf-8?B?ckpRNGhheXdpWWlPbDlLR290TlMveTNEK2lMN1VvRE1MOU5VUHQydytQSmxu?=
 =?utf-8?B?NEJMK3VwSjRIeXRPRGJsTkhrRTNuczRSNi9LcGpEamtPeUJKelZXOHhtdXhX?=
 =?utf-8?B?RDhCR3JIS1NYVGs5MXN6STBidGFiUkVLNWYrM0pJYkFxNW83bnhlQmJES3NL?=
 =?utf-8?B?ZUh2elpwMlQxOGExOGlBZ01uMzVsQWZsZlpWazdPZEdYSGw0N2NFaldZekhR?=
 =?utf-8?B?OFByRFpmWldZL2ZmRDV1U0xpYjc0UjFIRkY0WXdhQ2I2M0ZvMWxUajBKTEtk?=
 =?utf-8?B?VkhpNUJwWlVzNkFRY1RlV1R2MmJrWjFadVY2S01uNFdJaHpmWUx2d0JIdU5R?=
 =?utf-8?B?a2ozcFhYRGdmd2RacG56ZnlGYXFvYmV1MXdkZlNnYXoyOE5kTGhqLzVFa0dh?=
 =?utf-8?B?MWhxUDhzdUtkamQycnl0bEFoVVBWRERENjhCWXhkb2dzSFlnT0dxR2p5Qm82?=
 =?utf-8?B?eTk3T09MZ0FFbmFJSTFLQTlSZTZ4UkhHcTEwYUhSTDhUUnk4NWxvWjJPVm9p?=
 =?utf-8?B?emJRL1ExSWlaUzRPbzlPc2tZb2RGMHpaYjZOTUJkNG9rZkJWOVk0N2FXc0pB?=
 =?utf-8?B?NVN2OG5OS1ZySkdtand6c1c5NklYOW53Q1BVeTlseHVRcEVaaDBBNWVEVms5?=
 =?utf-8?B?Z3NSOGxMU0RPd0lXMXVRc3lwamRXc0tlQ1BOYTV4WUxYdDZnb3lUbkptVjhZ?=
 =?utf-8?B?SDd1bU45ZlJyckxxeVgyWUFtdmRMSlMrWkpmQ3NLL3U1MUh0eXpoMys3d0Zi?=
 =?utf-8?B?RDB1RmlycGNxdkZsL0tiTGo5bWl1QkdaNUVqbTV1YnZuRVcxaHExeFd5RCtR?=
 =?utf-8?B?R0lUR1l2TTRkcCtITVVXMGhwQjJ0Y2RJZnRIaUpscTYySzkrcjI1cmNHSHc3?=
 =?utf-8?B?L3p5KzN3ZUlnaU9HcmtMQ0xqWFRjZG5zTkZoek1BU2t0NkphV0VxVktEd3FK?=
 =?utf-8?B?T1BxZmFxU3d2WSsrMi9ld1ozSDJBUFR0RXFTS1NyRUtER3VIZUxVa0x5NzY1?=
 =?utf-8?B?TmlOdmx3ZU5OSWd2MEJadzVVNUJrNkZQTnhUdEhHVEZwYll1VnRvZitHZ0t5?=
 =?utf-8?B?bFhaQks4UDVvSjF3TkZ0L0FqUkZnWm9vSEh0ZHpXdW9VOE5OVWt1UWtUNW43?=
 =?utf-8?B?VWZGNENCZEVOUlpXcTcvN0RDa1g0YlVQQmhFWk5KWERsT2IzU1VOeWtvaUlj?=
 =?utf-8?B?N3pweFVwZzROY3haUElQZVp6Q1BwNFF4djF4bVRtNVVRZmdnMEdkZndweXpz?=
 =?utf-8?B?SGc0SFA4dnYvZnpDNjgwNGpwUmJBNUdSSG8vRlg5d1JheE44a081dDk4UUQv?=
 =?utf-8?B?dFVLTUcvRDFXMXV2eTRxN1BYemQrTjU3VitaTzBqK1NETmJxM1BINkZHZyth?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CABF338EB3F95C469A2C05EA0166D5CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cbd93-83d7-400a-fb12-08dc60bf1bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 22:21:50.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTNMstrbdlV//0Xi6FZOWThEKE/nnPAEXm11vd66fDneJML6KvKyi5MZKjO/v0iqYSf3iEr6CGFEcXrQNUpJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com

DQoNCj4gRG9jdW1lbnRhdGlvbiBvZiB0YXNrX2dldF9jc3MoKSBzYXlzIGl0IGFsd2F5cyAgDQo+
IHJldHVybnMgYSB2YWxpZCBjc3MuIFRoaXMgZnVuY3Rpb24gaXMgdXNlZCBieSBnZXRfY3VycmVu
dF9taXNjX2NnKCkgdG8gZ2V0ICANCj4gdGhlIGNzcyByZWZlcm5jZS4NCj4gDQo+IA0KPiAvKioN
Cj4gICAqIHRhc2tfZ2V0X2NzcyAtIGZpbmQgYW5kIGdldCB0aGUgY3NzIGZvciAodGFzaywgc3Vi
c3lzKQ0KPiAgICogQHRhc2s6IHRoZSB0YXJnZXQgdGFzaw0KPiAgICogQHN1YnN5c19pZDogdGhl
IHRhcmdldCBzdWJzeXN0ZW0gSUQNCj4gICAqDQo+ICAgKiBGaW5kIHRoZSBjc3MgZm9yIHRoZSAo
QHRhc2ssIEBzdWJzeXNfaWQpIGNvbWJpbmF0aW9uLCBpbmNyZW1lbnQgYQ0KPiAgICogcmVmZXJl
bmNlIG9uIGFuZCByZXR1cm4gaXQuICBUaGlzIGZ1bmN0aW9uIGlzIGd1YXJhbnRlZWQgdG8gcmV0
dXJuIGENCj4gICAqIHZhbGlkIGNzcy4gIFRoZSByZXR1cm5lZCBjc3MgbWF5IGFscmVhZHkgaGF2
ZSBiZWVuIG9mZmxpbmVkLg0KPiAgICovDQo+IHN0YXRpYyBpbmxpbmUgc3RydWN0IGNncm91cF9z
dWJzeXNfc3RhdGUgKg0KPiB0YXNrX2dldF9jc3Moc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBp
bnQgc3Vic3lzX2lkKQ0KDQpBaCwgSSBtaXNzZWQgdGhpcyBjb21tZW50Lg0KDQpUaGlzIGNvbmZp
cm1zIG15IGNvZGUgcmVhZGluZyB0b28uDQoNCj4gDQo+IA0KPiBJZiB5b3UgbG9vayBhdCB0aGUg
Y29kZSBvZiB0aGlzIGZ1bmN0aW9uLCB5b3Ugd2lsbCBzZWUgaXQgZG9lcyBub3QgY2hlY2sgIA0K
PiBOVUxMIGVpdGhlciBmb3IgdGFza19jc3MoKS4NCj4gDQo+IFNvIEkgdGhpbmsgd2UgYXJlIHBy
ZXR0eSBzdXJlIGhlcmUgaXQncyBjb25maXJtZWQgYnkgdGhpcyBkb2N1bWVudGF0aW9uICANCj4g
YW5kIHRlc3RpbmcuDQoNClllYWggYWdyZWVkLiAgVGhhbmtzLg0KDQo=

