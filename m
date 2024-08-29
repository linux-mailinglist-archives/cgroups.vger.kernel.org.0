Return-Path: <cgroups+bounces-4556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B4963FE4
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6461C215C6
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B418C331;
	Thu, 29 Aug 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtksEwPY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769902B9CD;
	Thu, 29 Aug 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923542; cv=fail; b=K1rPaAXljhvPHNBUOZwGWMScev3n4xHSKhvxQjFSSG3DgGk9u4Nzfd5TeJuQwQNIGRejP5zVJWmz8dXuOJXMqVSzHD0bO0gm8fa1f3gCwHs/MAig6tNmQODsMzuKFWt9aVOv029kOdnTmh86ObH1d5I+DFXe+pq90cHeHVPG1ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923542; c=relaxed/simple;
	bh=EGG77Kwixe0YJRnPcG0+jYT0GJ39UYpHk3aCXjoM/EQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGwV5a7zbF5rYlqUgQMH1TeRa1umstBtizbsYqVTXHGB8PVcAIE6gU086bMfQkjqq+hKIcfxGYprRJWQSRknqaTpv28x7Pi7AGVAHGvxpPVP5sA1i9bcI+9h1KJjc3+N63nHJeCqmcOpAH0ig07Hv7WgwJV/gF/2VMf7BHnm6to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtksEwPY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724923540; x=1756459540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EGG77Kwixe0YJRnPcG0+jYT0GJ39UYpHk3aCXjoM/EQ=;
  b=WtksEwPYzC73AUm4cjvu7ZMkNhyzmJC44DRANzw24qb0v+4QziCbGu6H
   XvZrG+ZO5myreOS3k6l9ym7EZhktzbeED+jjNuw676M05kizl1KOkZBOd
   8zN3Xzy8Euw9jg9hI96oulXpT+AiM5sSdYPyIP6HSd0il7LWBRowmnzfA
   I5HPF6TQKxUFjKMgAvQO6Qq9XIZkZQw3PJx1rMMB2FtFdpad//NmxMx9y
   oH/80FIwRB/P15ySxu25uqo9NM1yQW5SkxioU0LQoXUMfVk88a7424Ozw
   8t3hkvQvkIRe/HTF7SBZZT06TOPJiTNBr/L+CND48uwo5PjNd4XvVQCjy
   g==;
X-CSE-ConnectionGUID: /sc8HPD1Sfed3uOfZxjlrA==
X-CSE-MsgGUID: dxW7n81DRp6QgJ0uV0s5Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23079696"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23079696"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:25:38 -0700
X-CSE-ConnectionGUID: 0iuI/9eTTUyJKW45SR3y7g==
X-CSE-MsgGUID: 4LwJ5+UzTyOL/RRpoESOyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="101039468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 02:25:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 02:25:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 02:25:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 02:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEY440TM/zR3f0UeCCVJnhUHjh/kVQ/bkjsb1gU2/xVH3PCMPTTDksxXMgJ9NJ5hgXm5/M1wm8LJBFjCv1BI7mgeyzTf7a0aPViCaKQJB4C6pvf+lrcEVahpD5DbafIV0OYWJE9K2sfXKCtyo++hWuUoabfozQDGjNZuypPQbxmLkgmSZwtyKCzBpPsX2hRfXZfwv72WaBFTwBovxyJFOIOe1YSEUEOc6Bkb6xXqO3KOV1xulW3qaj+yR74cdgD3/cACDjjfwkaxd3EPFv8u4gB1fEkgGORtvAkohIpjEvsHskd8MJ33QqiuSabuJ5o8Tl1aq8pbbwyTzKmfsb8cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGG77Kwixe0YJRnPcG0+jYT0GJ39UYpHk3aCXjoM/EQ=;
 b=CrL5OxuRS6A6bl9+1ga2/lKaAgaFxQ5BJCAh1gwtByyBQPTrSlVcUfH2IkChPX6fLz+nzwkWIRYn55/x+MBdjjIINsCuM9doyJM3SqNjvLJud+0NDMzWCGWunrbBL9O3fIdUEjuoP2CwBOOWZLVjnKwatgQ2Y+OwAFpGeZhdsUjrJGlTWmsnZJJfuBZEvHU6pBagMrpzm61jB4yP0QMZpdwpR5tkz53C6BFqBsmdg7iHblvS+JgcVe9PNey3JbbDGuz/8x1/vZsvF9LBe8P55gG/yBZlqzePxmk8Bo93KS0FbaI02sTdzkAYT/afpvYb3dqbnU9RbrNs+iguuM1t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 29 Aug
 2024 09:25:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 09:25:29 +0000
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
Subject: Re: [PATCH v16 02/16] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Topic: [PATCH v16 02/16] cgroup/misc: Add per resource callbacks for
 CSS events
Thread-Index: AQHa820M+aXPyhARP0at8Tp1xHkKkrI+A+kA
Date: Thu, 29 Aug 2024 09:25:28 +0000
Message-ID: <2a06b55315aa1fbe694acecafc28115bc60876dd.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-3-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-3-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5123:EE_
x-ms-office365-filtering-correlation-id: 802613c7-ff63-4d0a-f6cf-08dcc80c85d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?a1phTjMyT0V0eDd5WVRGNHZObURsS3ZCMVkzOUwvd3hXM3k3UVNwc1J5Qm9y?=
 =?utf-8?B?TDFlRWlxMUJyd0dJOXlVcVRuNUs5K0lKM0liVFgvRHFkRlF2ZjY5cVUyd0ZZ?=
 =?utf-8?B?eW1KSTZYUTQzSDZoaEc0dStBbEdZRUtFNUUyeTdwcUlyWWR0ZUxmZ3hpa3lK?=
 =?utf-8?B?QUNTOGF3OXJlbDlQZ1pzR0hMdmhPU1hDSWYrb2RkeXpqUTlrV2sxWVZuUjBR?=
 =?utf-8?B?bEIzOUJvdzg1TytZeTQ1OGZ2WEpoeUtzZEYvc2QwMkJWQzJJYVdqWFdjMS9K?=
 =?utf-8?B?OEVLRXo3M1dFUWJFdVlJanRXQjVOTXVEVEVTN1FZc3Mvb1YycERTaWNtaHNh?=
 =?utf-8?B?OTJ4aFgyR3YzSFlHRTN5d2NlT3VFMVF2T0hWbEJZMFNKWC92ejJGRFpzMTVD?=
 =?utf-8?B?NnpYZWNqUlZQY01ad0Y0YVBNbkYzQzhkY3BXRWZQd2MzbjFIUEpzZmovR3BM?=
 =?utf-8?B?dkRWRThNNlRlUlBzdG9mT0JBbzFoMlMyRmlxamptZXlpSHNvRVJCemJBVGV2?=
 =?utf-8?B?WVV0Q042MFpweEQ3V09TTTc0bUE0dDBpakZURmNvRGxMbWhLMG84VzhWdXA2?=
 =?utf-8?B?M1Yxc0d0ZU1lWXlmNHR5YSttaE5Yd3pDMjNTUGkwcXpiSjZzeFgwMWNwWVJp?=
 =?utf-8?B?QmNUSmtKaU1DT2RaUmZDRXF2ckNDTG1TYUI1Nk92Z2t1bExYYTloekdZaUU1?=
 =?utf-8?B?SlFPWXBuMU9UR01zVXBNUkNQMU1jUi84OTc4TlB3SEFHdXJUNUZBaFdSUUtm?=
 =?utf-8?B?clIzYnQwMm1QTk1INWdlUk5ka2JGam1INVkyVnFSRmJ0K1R6eFN0b2IwNmhQ?=
 =?utf-8?B?MmJuc2JMWHQzR25TTXJKVGxOSzdoUWExRDVoemQrellnUC9FSWRhdjVNM1NV?=
 =?utf-8?B?REY4amNuZVE2dVRzT1EzMzN1UkFHd1hiQlRpRlRnSzR1UWZXdm1aNVNMbzBS?=
 =?utf-8?B?WVJqa0RGcUZVZTNFYitKbVVOWUtpeCtxbDZhQXVsNmFoQjUzM1pEdUlwSCtH?=
 =?utf-8?B?MnFrT2xscDA2RlRRZVIxOWFrRThPeVlKTjZkd1FsRGdBSFc0L21MWjFndGx4?=
 =?utf-8?B?OERkQjE0WURQZ2JKejNEbzdmL2U1cmhTM1NscExnOVZTaHZJRDQ5VElGbUxO?=
 =?utf-8?B?Nk1JSHZEUVRJOTZ3RXZySVIyUVlCT1dOdDg3ejhKSnp2cWN0QnlzVnZHZC9P?=
 =?utf-8?B?Z0tnQmFOMVBxQ0ZYN1pBSkViMWJwKzhIOENDYk5NbnVpTWw5akRuaEVjUk9h?=
 =?utf-8?B?RTIzaVlVZFB4bmw3a3l5ZGtpTnlSdXBHOTd6dlo1R1hwb3Y5dEowRE9mYitS?=
 =?utf-8?B?M2ZPejZGaXR5eGVmOW1PSC9WMDlKR2R5eTk3NG9ZaDhjOXJlOE1FcmQxRVdZ?=
 =?utf-8?B?VTY0dnpnWmlDcVpkczhDd3RKc3hYRkw1aStVenpVbGZzTnJRdHpkbUdtdDN3?=
 =?utf-8?B?WVVla1ladkRRb0R1TnlMZHROckJDd0xkYm9BLytmWUFYU1BXRVJTL0l2dS85?=
 =?utf-8?B?RzgzMDRqUGkxZnlSR2lKWTZYS1hucXI4SzBkTkozZTlKK09pM1BzNitzVWtp?=
 =?utf-8?B?dTh1ZlNBMVFpdU1NTlRuSXVzTnEyRGJLV00zVkhMVHhZcDlUMjJOWGh1UWpZ?=
 =?utf-8?B?bFB4SXVUcHZIOVlQQng4OExhZnMxbWNLbXVWQWlhalRUUXUrMC9xdkJtS3Bi?=
 =?utf-8?B?U2s0citQS2NxcmFEdkZkNVFXM3hpNm5ZNlJ3QWc5MlpBczRiZlIrWVhFOXBW?=
 =?utf-8?B?OHY0ZFNHSk1KZEZUZG1aUGQvUVZXc0dlUGZyNHoxOW1menpSZm0rRkxYYWpD?=
 =?utf-8?B?QkxxOXJxc1RsMHp4Q1lDZWFDQWg1bVpMWW1oampTNVY4MUt2SHV1STVXWjAr?=
 =?utf-8?B?R2hqMzByOHEvSEd3cHZ4RXNIMy9iSmV4MEpuWk9NNllGTUh0QUs1dS9jOXdG?=
 =?utf-8?Q?QkGg8evXrhY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFZUNnQzTUN1alNGQjdkRGNRR2hlME9rdXVzelkvU1JkK3hPOGVZY0VUVWRv?=
 =?utf-8?B?NFF1ZnhIQVpBMnQ3eXFyWEkrdUlsSUd1cGRsYm5EYUNadXhHQUFaRkdYQnF1?=
 =?utf-8?B?OUh0bVlKM25BMWl5em5NSXdENjhiVENwUkp3SVQ3MTJXZ2FMamZ6OTJIcmly?=
 =?utf-8?B?OUQ3QVpKWFdmeFRiNk45bG5PR2MydmlZWDVCbGJsWjVvTUgxTzNWUE1sZ0Zj?=
 =?utf-8?B?bWJOaEhGVHBRZ0JHRTRQNjluKzJhZHNFWUpoVjBubGlYbUtxOFVjWVU3MzJa?=
 =?utf-8?B?a2F4Yk1EbFJ5dFRrUW9UajhWVnVsaytzUEJOM1NSWTQ1bVpIMDc3M1JUWXcr?=
 =?utf-8?B?T0NVb2sxMWJOT29sblVZck5DV3NBQXp3SERsSDRiblBuYmFtTVptTjhDejBB?=
 =?utf-8?B?Zi9ZejlrMnF6Vkg2NnpTVFZjMlpzU2FtZ2w0TXVZVUlubEdMS2FGQjBCNS8v?=
 =?utf-8?B?M3gvT0w2UGlEdHA3WEl2dkpPQmNXdk1EN2kwb04zSStSSWNSQkp2d2RxeHYv?=
 =?utf-8?B?ZE1tekM1aThER2o1SjRxVGVnL2RQVS85M3pPaEVCWUdNcWxhMW1LODRVQWpj?=
 =?utf-8?B?amE1TGJabXppVVo0WGRQVHNFUUZwRHdpNjNPTkdjT3hFSmZJRGkwTVZ2V0NO?=
 =?utf-8?B?Q2ZCbVNLYzY3TDl5ZTQ5b3dtY1NRajlCNDZ1MEJwZURCQkhpY2tyQUJzQTVM?=
 =?utf-8?B?YWZsL3plVmtXc1p3M1J0ZGhta20yQXdrMUlUK0IvRHF5N25DVGlNcjB2TW1E?=
 =?utf-8?B?YlNiMWtsWElWdHRjdm1VcjRaVlBna0VuUWVNMXRQclJIOXZFWjkrM1psOEFW?=
 =?utf-8?B?dzVTT2kvNmZHcFRmK2dhdXJaSGpvUXpTNkxyU1hHTjRSMlF0VGpZZDZucFZ4?=
 =?utf-8?B?YzlsejRLRkVMMTdmcmM4N0F5bStQUmF2TVV6YzBZQldrLzV1dDQ3b2JYMXd2?=
 =?utf-8?B?ZmlZRTUwWllPSFJ5RUpMYVhHWjl0UDdOUkhIYTBsaWtTS1pVNXZTMXRGTXFY?=
 =?utf-8?B?NUpZL1NPRzNQTWw4dWdoeXRJeTl2cjVhalo0M1M0cGYxVTY4NU8yRHhqRnVs?=
 =?utf-8?B?cHlOQkEvaFhoUDlIZzFJVWpBN3ZkbnZjdVF3bXllY1ZtZzNDTllsWkdDblBZ?=
 =?utf-8?B?RnRUWWFUQW1CYlVQUGk3RnFMbGRrYmdNeFdEN3dGWGd5d3dIdngvRmdjd0dz?=
 =?utf-8?B?NktaMkozbnlJYkw5S1crYklKa1MxVDM2U2JUUUVrd1R3bFhuZlRaRjdkRWo4?=
 =?utf-8?B?ZGxaSk12RnFzNTdBY2s2YnpsMjdIKzZWOUN1VkxTQlh1cnU4UElsOFFzSDh0?=
 =?utf-8?B?cjVJQkwzTmRmWWRLaG10azFzUk1vNzVyeEhoYUk3RHZJYmdtdnRvcTZjS1M3?=
 =?utf-8?B?NWgveW9mYWR4alhwTE1pTGR5MnNDR2VPNFE5UlJBMnlpQitWT0NaTUFGVVJj?=
 =?utf-8?B?dmdyN1lrZng3dWNIVnBjRlpGS1U4cUlGU0ptV2RSUFlZeUlXcHpKcXZGWnJU?=
 =?utf-8?B?bmx5VXExa0tNb0JxeU5OM0FaeloySjV3QTRhRHM3ejJncFhaTE1kSG5USUlH?=
 =?utf-8?B?M0dLR1l6by9mOUR1c1d5bS9ocjV4M2tCbnpsSXFmYXNLdGhzdFBrdUNhb2t1?=
 =?utf-8?B?dEtmQ1VCVTVlL0NnMCtnWndkeC9kMnhNa0hVZ0w3cmdIdzlwM2JnTFd6RmIw?=
 =?utf-8?B?a0pZV0t2UndINTU0dlBUcDluT2JxSWRjbzhzeVlnU3Nwc2VEYkVHaVY1bE8x?=
 =?utf-8?B?emZZQzB6c3BWbnE0MkF5UWFFc0dWb29iV2xTSmxHdlpNdXdzanF0eko0QkNr?=
 =?utf-8?B?UkJyZWtlTmtZNTN6VEJGeXMrL0ZqczJoZ2xkOUJPMUJXd0hvOTdaemNCbnpm?=
 =?utf-8?B?WTVHSzMxb2xCbUttb1ZpS25nV3pMSExLSWZWYWVaanozUStZN3ViWXEzaVVo?=
 =?utf-8?B?QlN2azBYcnJWYlpGR3l6SVU4S0dWZlExWUY3N0t0OFFLZERMalVUa2x4WU1k?=
 =?utf-8?B?VStscUlwN3VJeUtjeFdwTTlvRUtUeURvOEpKVkZ6NFptWmh3WFlxdVJvdzU3?=
 =?utf-8?B?TGxkM1V0NWdLVGlYTnVyalRlY0UrVGdRek5kYkQyaENNRjZCSVREVkxId3F2?=
 =?utf-8?Q?9pTkaHK3Qpc7XLxvqSw5spDa9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6453B9AA96DF3942B401423A4B78AD14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802613c7-ff63-4d0a-f6cf-08dcc80c85d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 09:25:28.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFC1W8UseU5wa7OxsalCQSeWVA7j0ImDD9DzkHFTPBpArokawhmxXZ3sTPUSIHpMx9CxKU6uercybJ5mp8HuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjUzIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IMKgLyoqDQo+IMKgICogbWlzY19jZ19hbGxvYygpIC0gQWxsb2NhdGUgbWlzYyBjZ3JvdXAuDQo+
IMKgICogQHBhcmVudF9jc3M6IFBhcmVudCBjZ3JvdXAuDQo+IEBAIC00NTEsMjAgKzUxOSwyNSBA
QCBzdGF0aWMgc3RydWN0IGNmdHlwZSBtaXNjX2NnX2ZpbGVzW10gPSB7DQo+IMKgc3RhdGljIHN0
cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICoNCj4gwqBtaXNjX2NnX2FsbG9jKHN0cnVjdCBjZ3Jv
dXBfc3Vic3lzX3N0YXRlICpwYXJlbnRfY3NzKQ0KPiDCoHsNCj4gLQllbnVtIG1pc2NfcmVzX3R5
cGUgaTsNCj4gLQlzdHJ1Y3QgbWlzY19jZyAqY2c7DQo+ICsJc3RydWN0IG1pc2NfY2cgKnBhcmVu
dF9jZywgKmNnOw0KPiArCWludCByZXQ7DQo+IMKgDQo+IMKgCWlmICghcGFyZW50X2Nzcykgew0K
PiArCQlwYXJlbnRfY2cgPSAmcm9vdF9jZzsNCj4gwqAJCWNnID0gJnJvb3RfY2c7DQo+IMKgCX0g
ZWxzZSB7DQo+IMKgCQljZyA9IGt6YWxsb2Moc2l6ZW9mKCpjZyksIEdGUF9LRVJORUwpOw0KPiDC
oAkJaWYgKCFjZykNCj4gwqAJCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKwkJcGFyZW50
X2NnID0gY3NzX21pc2MocGFyZW50X2Nzcyk7DQo+IMKgCX0NCj4gwqANCj4gLQlmb3IgKGkgPSAw
OyBpIDwgTUlTQ19DR19SRVNfVFlQRVM7IGkrKykgew0KPiAtCQlXUklURV9PTkNFKGNnLT5yZXNb
aV0ubWF4LCBNQVhfTlVNKTsNCj4gLQkJYXRvbWljNjRfc2V0KCZjZy0+cmVzW2ldLnVzYWdlLCAw
KTsNCj4gKwlyZXQgPSBfbWlzY19jZ19yZXNfYWxsb2MoY2cpOw0KPiArCWlmIChyZXQpIHsNCj4g
KwkJaWYgKGxpa2VseShwYXJlbnRfY3NzKSkNCj4gKwkJCWtmcmVlKGNnKTsNCj4gKw0KPiArCQly
ZXR1cm4gRVJSX1BUUihyZXQpOw0KPiDCoAl9DQo+IMKgDQo+IMKgCXJldHVybiAmY2ctPmNzczsN
Cg0KV2hhdCdzIHRoZSBwdXJwb3NlIG9mIEBwYXJlbnRfY2c/DQoNCiMgbWFrZSBrZXJuZWwvY2dy
b3VwLyBXPTENCi4uLg0Ka2VybmVsL2Nncm91cC9taXNjLmM6IEluIGZ1bmN0aW9uIOKAmG1pc2Nf
Y2dfYWxsb2PigJk6DQprZXJuZWwvY2dyb3VwL21pc2MuYzo1MjI6MjU6IHdhcm5pbmc6IHZhcmlh
YmxlIOKAmHBhcmVudF9jZ+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstDQpXdW51c2VkLWJ1dC1zZXQt
dmFyaWFibGVdDQogIDUyMiB8ICAgICAgICAgc3RydWN0IG1pc2NfY2cgKnBhcmVudF9jZywgKmNn
Ow0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn4NCg0K

