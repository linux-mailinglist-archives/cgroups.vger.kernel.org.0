Return-Path: <cgroups+bounces-2484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2388A522A
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF47B2121D
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1F74420;
	Mon, 15 Apr 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eI28/3TJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB417319C;
	Mon, 15 Apr 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188981; cv=fail; b=H8erBXfV9TNV6ExElEjQNhGmlVX+xybSNJILRb8Hw7d73qIzUzjtVTFfVNXexQuRD60U1RcEqcU5OMTyk5fghGaDAbW/cyV1tp0jgqHBHl12tDvsKRbEqezceHvdmWEZ48ejZBgUJBYHEZ8s7wuGpvqq+zZEn8Q6lc4ObJ3Zgv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188981; c=relaxed/simple;
	bh=CbGABrWQHPgBDigQOigLgqeVSkpRkskV42eQnfPAxMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHOku26hnd/YuCRuSheydkZm0zi4Kp6KCMT6fLJPxJEsuO4kxGNQ0pUge1LkIPojso9qR1c13OJYDWDdZterhUiafMYqWo/sZrHAosTtIuMjBvOHFhjl0uwm2VPryBQqlrwg/vJuYbcbRZexWpI0e85Lkv6O5erEpQf+piduth8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eI28/3TJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713188980; x=1744724980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CbGABrWQHPgBDigQOigLgqeVSkpRkskV42eQnfPAxMw=;
  b=eI28/3TJPWcOg0GcVsQpbDuczb2HB8HjtDviD0lPGxpmwVdWyxYnF72S
   uJL55tAN1GFPUtLk6O9hbvXfFj4m9XLN6HL21hKt/enZiXiRy1PfQkuQc
   Kq+gFMEdgZz93vMbHA+GU0iH+uqv5LrPs2IlyXrktQWevBGc9Siohc1wy
   +o/rky8Xy6HAkeHT1f3vh55HlYarxNqTkgS226/nhaieKVYId2NLSNnLX
   IAesCBYWDhyIWBG/VrPcyM0pUiv7HJ70+qCQWiJ6wjipNMOmHnGDqveSh
   Y2G2Nhzdqn6SIi+Aqi+T4qiJZkYtXOHTnIa+5gD4tTe6FUCs0h2uZzGpW
   Q==;
X-CSE-ConnectionGUID: QnliwC8YQyywItiNp1kw+g==
X-CSE-MsgGUID: lp/GMg1vTQKgMnkOKFB63A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="33964369"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="33964369"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:49:39 -0700
X-CSE-ConnectionGUID: mFoHyHAMR8GaZ4AyAD2ZPA==
X-CSE-MsgGUID: TVQ4J7f5QOOGjD4jn5G2IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21839092"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 06:49:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:49:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:49:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 06:49:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 06:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5kP5oTnCrsRTwVl8xusJ48Ep/vN3F14XsRUdVl4QuKTqdtK1/ihLKJ31kJsOBUxqMIgK8oFmddr4yAHKFhvCebhtItLiPBqSL6cxy6swJc8rfMNYywXKVHC3A2psepyeYUfztZFzIDrWdhzUA96D6GTyj/gTHTmcKf07ZaGenNhsR0jl+YdIS21evM4I17C5QV78yzi3pcV09sJo1ZZYiWYHZIQO8J/L4OmfPx45wgbfRNqxYN3NxpHYxz2P94G7JsG65vqV2x0XIgAD9KGnhhjHpo0y1CFb3WT1e6qmLzTmIIxerq+cKZ+kpjDdhYeIp3hhS8zZARnVevPzo53Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbGABrWQHPgBDigQOigLgqeVSkpRkskV42eQnfPAxMw=;
 b=MalxUuCX9W5rjKdvbK6JlLzjqOruEOrQ5bVGnS2s96l8OEiwOVbWopZ6AGTZaJQV3w/vBXBEq2ZspO6kdNOT726R5aJXhCdgTzG5336WYZTNxQaEz4lehVdgc63liv1j16o4ALvUWLVPOv2J9+COJyan1wm8yqyrzX9xnKYlBu+a507VU8HrjiM+cDsVIPHHSIOzgYzs00Hq91ImoscdbLBmwF1hHsrlRsvhI8OFL2hrvpV2F9cJGDx4600aTtzykFLZ3VCOnFJ52moD8HWqcRpChdIPTL3saowfxjpGn7nW+uX0e27xMb5EymT8xIhUA3qED5MH2PVQ68xv1n6HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 13:49:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 13:49:34 +0000
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
Subject: Re: [PATCH v11 04/14] cgroup/misc: Add SGX EPC resource type
Thread-Topic: [PATCH v11 04/14] cgroup/misc: Add SGX EPC resource type
Thread-Index: AQHai3SVelgOtIbdJk+bOlEWsfc+KbFpYI+A
Date: Mon, 15 Apr 2024 13:49:34 +0000
Message-ID: <45663e423b74c04b89746468a1ea58cf8c302e5d.camel@intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
	 <20240410182558.41467-5-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-5-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4873:EE_
x-ms-office365-filtering-correlation-id: 88ed7c73-6960-4907-75b5-08dc5d52e235
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01UfLclE94++0iYKHa/6naOjqGCnoUpUt4ntRZrUz+caUMJIHzHOeyQicutREmHq6NJVHP7S3W/BHkoXg9sVbfU+3J4wfr+N+a1SGpygAAjY2QgnmWXtLn0Znl4r3ces80hRtwT0fFDTDEpUUKVHvOKlI4+QHGVjVA94C3MNOLUHMlZ8HrGPjDiXXsrze3UvZz2M0bdRWMk22iqzz3TlkXGXJ7vkz8wjWOVVDWdQOoz2xg7nh6OSKZGTlKjXCuiGvSbp5sgSrm7Jg04hKJjBmZlsmGx1UmI5bnB6MQ8hSyUdlRCeYdp8Pd+9YXrFjEUtt4rAuQvaWNilWG3Au1aHGFo0DsfajhV8WVuXN/MbRiMWTD6rVrhNBb3aK/cNm1ZuiClESFTMD/6XvdGGXMLcNZYORW/NU7pQJCi/BAYdG4vqvWD/GZU/dMZxAzweoISS/+Q80dEtoVUGVros6NZr0XDV5CreoTmheePc5spEo/2ijRTn4ZduJkBfh6xg+gGHyXEH3XT6l1WH+c+hN8YF6pXEXnEqY0QzxyAU9tcHzaZ/kbhihau0VASh+8AiP5S71X8Vt/XnuO0kh6r8Ew0NPn/C4vxjDr0W/Pg1R/cJWJ6ywsoXz7vTv3dhiT/FzeI2PaCZJIvRQXBRiHjpcsL8pNEqryi+kv7S6zhlxrrRHKIRp9MvqbCyHQkR39GISp8qCHPvPFl14dvcqnRCfpASB18DLSb/GqeMdVphrWUjFTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzNNd1lJSmdxNkhyVlFtc1BlNnpmMnBQK3ZQZ1N1emNGZGZPaEJ5MmV4Nm95?=
 =?utf-8?B?ck92ZGJsMkw0QlY0bkhFOHg1MVd2dVZOYkNrOFZJVWhEaGVVVlBNMWRlbk52?=
 =?utf-8?B?NTVRTVhkWTdSSmVUbyttdHVDL1d3SFFsOTM4YWw4ZU5TNjdHcUFCb2pURktj?=
 =?utf-8?B?eVlKTUhUaWNKcHNIVTF4R3RWemkwYkZLMWtPOWwrZXJQOFB5ME5hLzROOGoy?=
 =?utf-8?B?Y1ExUVBTbXpnZGJkaVFNWXR2SGsrMnN3ZWFnckpXaUZjSEJmd2Zhdnd2VEdr?=
 =?utf-8?B?cmRRQXBqenZKdDNGY3M4eC9Mc3o5ajA4QVozSmlaYVBodVBGdy96cjd4TVUy?=
 =?utf-8?B?eUFiR1JKSWxWTTZQU0RtVWxOaldZMTVwZDhRWXh0aGtza3cza2ZnamZjM1Fs?=
 =?utf-8?B?ZDA2TzFzY3ErTE53RzBSdVAzMjB5eTJPTkRvaDdZSHBvZ0lVRUV5b3RmWGJm?=
 =?utf-8?B?MEtnTUVHY2FkK1ZvZEtJcUQyQjEyTk9PV0ROYTUrb2FLcStKOFZTdXh0Q29k?=
 =?utf-8?B?NlYvM2FYMTNDOC9ObG5oWVhmMVFHVFJQSWlYdFlKZnZCSVd2U1FFOVlSNlY2?=
 =?utf-8?B?SEVJUWhJTElKb1VGZGhqQ0NiWEY4VHhEK3pWZUZXZ0YrQjVyczAxOFB5N1pP?=
 =?utf-8?B?K3ZJa28xdExmVUpZRVlLRy9Fc1A4YnJlSll0QzRDSDd3aG55TzBzTDJSdDEx?=
 =?utf-8?B?YVFUMG5makxTTHpINnhhRGJmRUQraGVWVHdrdjcwMVFNN1lMV3AycGo5MVNQ?=
 =?utf-8?B?QlIxVVhodTlIQVluN3dTQUZqS2sxZmJwS0tsMG5aOXFBOEtKakNIRDdBYU9G?=
 =?utf-8?B?bGZUaHYzMFo5SUdMcFF0N1k1b3RpdDIzdHlGVS93WXd5RTZrRW9GR3ZvaVFY?=
 =?utf-8?B?alVlbG9YdXFnTlBySkl2QkFjMkxZUUJCcEtIYnQ3S2NuUnJJWXNROUw4VHVx?=
 =?utf-8?B?emk4K255RnZBZUZLK2RZdDEwN2dOT0JQVnJsOHFIWWtFVlJPWVhZM29tVnpT?=
 =?utf-8?B?RGs0TGJDMFY2azQybkI0U0VwWHFMbHg1VnFDSEY1bExqdnl3cDl4T2hoMjNt?=
 =?utf-8?B?ZlNtV1J1SE9aWFJ4K0txbmZKQUR5aytJY1ROc2I5eUp0VWZLY2w3Y2JBNkkr?=
 =?utf-8?B?V3IzL1N4MTIyQkV4bWkwM1JxUXFxdUNyOEJ4a25QSTFDaTFjMWJRSm95VE5N?=
 =?utf-8?B?VnFxVElucERjRERrWDY5dmZ6Z1hvbzk5MHlLYkZjVjNQcmZ2WUR2NDNWbE5y?=
 =?utf-8?B?Wm5va200VU1tWWszeHVvQndwUlFjeVByZkxGR0trZ0lvaXB4Mzl2cXNycGhs?=
 =?utf-8?B?RE9vS1RGQ01rSjJsa01TNjJLa2QwOEpPN1gxdzJ2YU5nM043TmE5aHJNbkg0?=
 =?utf-8?B?ZXgrMFUwR1FwOVEvVW0xUWVXblVvRnc3Y3lQZzUyUThsOWF5Mk1CNHU2UTlF?=
 =?utf-8?B?Umh2SWFsMFVqRm9pYWQ4STRUd0tXUFhyZVRxNjZLa2FzSGwvRi9OdC9vdEs1?=
 =?utf-8?B?T3JTWTRpdWczQmVoQ3dUOHhoeDVlb3pBVDByQ0lnaWxNNE12RzJxeUZaYTA2?=
 =?utf-8?B?TzI4NFMrcmRaVDBNYlpiYlNIYjhxYUIvR2R5Z1JXVEcrdnM5aVFmb1NiR3l0?=
 =?utf-8?B?NWwrdGZLSldwMGRhaE44VEdYUERHRVY5ckFWRTlhcFkyVFBOZzQwd0hzOFE3?=
 =?utf-8?B?bUNVUzdMQnFkelVldXMxQTg1OEloOFZNUHhHLzQzT1ZTT3VVaEFXaVZvY0tj?=
 =?utf-8?B?M25PSEFKUlNLUGNpaHF0MThDV3o5UG04c1B5SEJRbTRLN1BuTEVnTlM5ZEk5?=
 =?utf-8?B?amxSZjh1ZDNEcUNrZG1RUmg4c3BGMlMrQmd1ci82TU1rb0hmSVFxS2FUV0Iy?=
 =?utf-8?B?b05BbnNDU295YWphOHpPbDhET09MUUluY1BOTmpZSVAvNXZqRmJ0YmxNczU4?=
 =?utf-8?B?SVd6eWRzdFhhWkFieDJzUzh2UXhYd2tRTERIOURUUE5hKzhzNDRPQkhsTWwv?=
 =?utf-8?B?OWNGNWdiOFNKNTQyR0IvRzFNcjhCK0NyaVRWelg2TW1CRmV0STh5TmgxMVMx?=
 =?utf-8?B?US9WSjZ6YlFJcjlZbUlTYmF6OU95ZWFGL2xuaVdyM0dCNzhxRTF2UlRhWmF2?=
 =?utf-8?B?bXlwMndXa2xzVzNJYmJ5MEV2VUhpRVVMOUxITGc1cXA3VEZGQU1ZNmU5Rnlz?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D916D4499195C34F96D314D239C79031@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ed7c73-6960-4907-75b5-08dc5d52e235
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:49:34.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62nDuyUdRsCB+MdixPG2i6+whRC1O3uUiF1xvuAeIXa/F/g6rmoFlqQU2M/eIntH1dNrKf0BEYCO9zHw9VjVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDExOjI1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IEFkZCBTR1ggRVBDIG1lbW9yeSwgTUlTQ19DR19SRVNfU0dYX0VQQywgdG8gYmUgYSB2
YWxpZCByZXNvdXJjZSB0eXBlDQo+IGZvciB0aGUgbWlzYyBjb250cm9sbGVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGtyaXN0ZW5AbGludXguaW50ZWwu
Y29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4
LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdA
bGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29A
a2VybmVsLm9yZz4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQo=

