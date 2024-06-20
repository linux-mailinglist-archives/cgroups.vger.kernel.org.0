Return-Path: <cgroups+bounces-3260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD159115E7
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610721C21B48
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D1140378;
	Thu, 20 Jun 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrCWBCiT"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208F8288F;
	Thu, 20 Jun 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923957; cv=fail; b=fLsEvTXGOvgzFINXLAf/mXl4x+bnAJP3ZuWCe9D90V6/O29bFuOQNowAZSc8QsRJXbfWfr6c1BTOklUAR5W47NZKn8Dlo/nY9Em1WG5y4Rpx47NRwwUbmxxPlBePlJmk5jp4BxAT885PJ1LXjpNlV/rb5lBINSy0RmPp0Y396iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923957; c=relaxed/simple;
	bh=Q2P0+sKQXXTJMVD28BaHz8rfPaOGOP8pc1AcuQHSPE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pp/7QwYzqBmYTI5ie2Wk/tD+w1JZV50y/Dbub5sOv1fxNr6+JoIP+68dCNN/RQYKbZEdvZeIwhr+BJWCQ9yDmc8KA/pvejTN0J79LF8j0syOlfCBnNImXbvud7WgNuOlp6pp7evKWBLraVhsEdguC0+DG4xDeW9wnYDclnTfS7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrCWBCiT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923956; x=1750459956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q2P0+sKQXXTJMVD28BaHz8rfPaOGOP8pc1AcuQHSPE4=;
  b=nrCWBCiTuMaj0FhQfql0gErZKKu7LpmrfcOl9fcNFFJmiiQRxE3w8vF5
   Syv7CalLMav+GudOpZP447lnhG7vmrCxzMb50OiqNBaDgWXHgs7+Hvkiz
   kW+wdtDjmnN+hANZXiOwHz6neRuum0khfvOPtLB5ZLW8YCFrKGKSkXHkU
   CwwPmrW8ukxvEivTg1OlOuDHEkmbGJZDkToWZ4NxasHRBMnsV2Y+/hjwm
   rwKj14ZsueVFu44mcCYHkp1nmFti3pu2Ceiew1i78LhPCGW9MPbg/1+bP
   kEmJSrcbUPXHcCHH5UE7cQsilCYI1kUxBicrU/bBUzPO//1YnFrgVhr/0
   A==;
X-CSE-ConnectionGUID: MpH7UnNmQ7aqzhghYUM8Lw==
X-CSE-MsgGUID: 5HQEbXEXSRSOlXVqlj/dWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16083043"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16083043"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:52:36 -0700
X-CSE-ConnectionGUID: 0lW7JejNTTWD6+rp7zcirg==
X-CSE-MsgGUID: uHu9oWwbTZu/GuTniL2QBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="65642538"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:52:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:52:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:52:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3YCVZRfC+sz4Fy9DYOLbetsqrs40Uf26quJKDuVHsquoOmiDv0psEofai/O9p7NAJv7f482rE6qVTTEszl2kEvLXQFSbQp/a+W+qWXROYb6xSF6g4eyCGlvJLOLYe1fx0IPgb/pIS5LEfcS9F/QLkKiQqwvoDjHakP2huZbdgGOH82Ecv4iqNvTcxbV1BvSJbuBsnlThdHVaVcNKd+9t2oyrCs5zQlCPWuolAF6ouKHHYFzlsd/+5Mq+VRTeCP3oBGJ5eAA1ZcNIgja6mvdIKr1pTMnbrXddkBHAD2lBD1IT8owrtqBd2UIMPi2Qiz2tCgAzgeILJ70+CegzTZJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2P0+sKQXXTJMVD28BaHz8rfPaOGOP8pc1AcuQHSPE4=;
 b=IM7H9luWilz4cq8lK4Po+P8E4+phW7nzo3NuIpHYftCZv1AK+MOycR5iY2Q2aibZVk1lDCJX2cy/zHe/6g4vE80hlWBuiwXFC08Mm1VCmoIK16Vsz/tReQW27baH/57L3RtFsDK08t0VAF/fmzcDd7MdqTW9QfGUw9HqY+oXNdTznLnJGh/n8Wd0vAE1gx2irNhaEyM27cZxQiL4hNjP5fH1dtENc4bKkkWqcIECdXnyzZ1fzV/q3kIcPY0lr0dyKl7bH8mP6byq2QrUuuftdQsWwIzO0MQCZW16Dn4zcC6Z5Lu2sWXTczpec1kbxQOoRxwnSu3TNzU0RJt76CW9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 22:52:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 22:52:26 +0000
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
Subject: Re: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Topic: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Index: AQHawLVo9nYUca8jtkaZUluHas/j4rHQqiuAgAAryICAAHGnAA==
Date: Thu, 20 Jun 2024 22:52:26 +0000
Message-ID: <47c86959a6e18730b1dfacecbdad4bad991f7a5b.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-9-haitao.huang@linux.intel.com>
	 <ecaab6953b36adb278c98b01f5eb647ff0cc9aab.camel@intel.com>
	 <op.2pn9nlapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2pn9nlapwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4933:EE_
x-ms-office365-filtering-correlation-id: e52d283c-37c2-429f-31d4-08dc917ba809
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|7416011|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?MUYrNVJVOHh2OXZGckRpZExvcHRDeFU3cUcraWpaRmNKbWh4aE9oZEtIYW42?=
 =?utf-8?B?RGdSZlBGWHpGTkRYemUxNnE4VitRRzRObG1kQkFVWU5OSzJmYnVxRUxoVU4r?=
 =?utf-8?B?cVVRQWRoK3pGc0o2cE54QnllajFDaTBrS0tyc2FkWDhJaUM3QVZ4TkM3NmZS?=
 =?utf-8?B?TWhRUng3S3grY1l5U3RsQTdhWDN5ZnNsR2dhN1VucnZKUFhSRmloMk4rdWhH?=
 =?utf-8?B?VFBZYVlyTDU5TWl1Y3YzQ0J2M3duSlBUaUtqeXFZYzZjZ1NHSlRKWHBaZkRP?=
 =?utf-8?B?MFJXM0dKSHB3SndaTjJKU1RSRVVDbEg0eUFoeTU2U3VybU5CQTlDVUl1ejVw?=
 =?utf-8?B?Z28yYng5L1NhaXhxUlpmazdBVXVEUFJyWjIrSEt3YldwUkNlVVJEaVJSd0xB?=
 =?utf-8?B?bHFkRTZxODcrZVRxeUI2NUdGUGYrTEJpdkhSSElXZ2ExQ2xrOWNvV1Y4amtz?=
 =?utf-8?B?L2FFZ1JNN0I3cElJazMzWi9xUGUwQXNqYjNELzk3OHRMLzNwWFlhb0lLdUVo?=
 =?utf-8?B?ek5BTlM1czUySXA0a2RjQXhBMTdvcjN2STI4VkIycC80cEtpV3V4OUxaWHZz?=
 =?utf-8?B?bFBQVzU3VGVTQ2VNRWJaaDFRSE9td0R2MXVNUngvbHY5cXRJeTduS3RQb2Jp?=
 =?utf-8?B?K3R5OXJuREZSeXRqbVlUZ0ZHTWNTYVp6RmFON2hQd2FidzRybkNIN3htQnVk?=
 =?utf-8?B?SkxXUEF3UVZsa2d2ejFzQ2V5c0dSeFBkS2pPcXdNM0NTVGxTbmlkZVNWV3Br?=
 =?utf-8?B?Zm1QNEZQQkFoVDRhVlhHcEJmbGN2Q0xnK2RxOHpRR2l2c0pUMDhVVDBkcnZz?=
 =?utf-8?B?TEg3NWlObmFqWDRSTFVGY0pid0pPSW5qNmVVd3ZEeUdDRWlYbnNBUkhBNGUy?=
 =?utf-8?B?TGVuc0RsRVhkb2F3c1Fyd2dEZHpuc3JDVHNiMmJFaktxSFQwYnl4Z2x0MGtF?=
 =?utf-8?B?cWM1SWZLdWNUQ2lLVnVhWk9ITzlBOXdsRS9TSjV4UVpEU1BMQ0k5VEdjQ05j?=
 =?utf-8?B?b3N4VGRqRDAvaUlUb0RpaDBWM0w5VDUvaG45ZkRrNDBmbVFuVGU3Wk1icnBD?=
 =?utf-8?B?b0x5Y2d3ckZRVzB2Ry9tZ0tuVmI3NkJDOFkxd0JMWGxZbjh5blBCQzFWT2Iv?=
 =?utf-8?B?aWFzelJQaStteTBkNWpZbDNoVHpKSWlvWnFCS2hYaWRteUVRSy9NS1JzL2lN?=
 =?utf-8?B?bnhlbm1udUNkWGxvNm0wbjVEOVpuWEErTGdDaHdiZjkzRHh3R3VrY1Vtalpi?=
 =?utf-8?B?OW1sYThxV3NyajU4UmtLYlhvSWpKM2Z5MnVEZmZRQ1NuTVdjTk52YTB1NmZr?=
 =?utf-8?B?dCtIR0RLQkdQRTdVWFZWTzY1R1R5RU9HNHdCQ0o2dlhQaFJMemhrNGZnbTlt?=
 =?utf-8?B?eE5hcHJXNkhCVjgyL2trTTJkek9lc0RxdjY1b1VBQWpCNUQ5OXF1M01mUTJJ?=
 =?utf-8?B?NU1hdFhiOXJQaTV3RXR2NUpvN2FtYnNDVFYxRWZmME4rY01uN1U0eVZpWGhy?=
 =?utf-8?B?c0QyVzM5QXNuclpBSmRQSUFIUEFHVTFHUmt1Sk02TStVYTdZMldBeHdJa1pi?=
 =?utf-8?B?WW1GcEgrNDNraXBmd1B3ZkZSOEpnci8xU1lzaTc3QWF4SkN2VWZxRDlxTDk3?=
 =?utf-8?B?dzlKQ2VaSzhkOTBEbCtTUi9FWTlVbENucTZOdVB0UThKRmplZDI0ZHpoOVQ5?=
 =?utf-8?B?alJTb1J1QVVGemxmcU03NU1Ea1djdXZDTHJwblZJMGhSTlhDd2h3cXA5eVEv?=
 =?utf-8?B?V0tYVE9penhKbXhVQ2szRXZVeWx0RHQ3blEvZXFJWGJKeTZ0Y292T285c1R6?=
 =?utf-8?B?c0ZGMHdJQzZCWU44OEFBdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU5tdXhyZHFiUUFSNDB2aW1FNHYrSjZRdTJxakZEZmZIbDdqQlRwQmo4WHpS?=
 =?utf-8?B?Qm5La2xFeDhNUmUwSU9DTkNsM2ZXMDk0dmFBaGNadGZITklacmxMWUxvRG1C?=
 =?utf-8?B?OURyZFM0OXMyZ1FZNTFaTG9XVmxZL3MwaW1JV28zTGRpeTh4TzRXYkQyUnQ2?=
 =?utf-8?B?ZTFHVVVWOHpMNGhoblVBTy9ydG44M3J5QThnd3RJOG1SUWxKaUVyWjZHUVAr?=
 =?utf-8?B?MEsyUUdtMzBGSjM5N2lUNWxJVFJ6clFweWZTcWZXTVJLTmhDYmRwUkJRT05Y?=
 =?utf-8?B?bjhoZjlVUmRJNENkQ3hERUxHQ29SZm5xRDg3MVhacU1DQkJpdi9mbVNzL3pX?=
 =?utf-8?B?QkRaK0IrZytpV3RQdSt3STZVMDdqRk1YdnphVEY1TFVPZlpSQ25OdnFSRDE4?=
 =?utf-8?B?U2NObnRtV3lDSzBiTU5HaE52Qm9jcHkxeXlSYnJRUjJ3eXVsNlJkRGRvaG1O?=
 =?utf-8?B?T1JYemZPK2gyR1Y4ZGwxY1oxWXE4Q2JxQXRHV0pXdXFFOFFVN1dXVUFBOHUr?=
 =?utf-8?B?emdkMGl5SE9ydnIzOStZazVsY1pDdzdURzdnbUZ2NDRpeS9VSGVTZG9GdDV0?=
 =?utf-8?B?c3p2a0tQSGFtaDZyRGx2ak1WOTZ3K1o3K2JDTDd6SXZTVEFJVDEwcmpZcDYx?=
 =?utf-8?B?dHVIVmNuTnJMVzI1UnRQZHphdHMrVXd3YjY3Z0NJVkIvMUpDdWFTR0FxbkZ5?=
 =?utf-8?B?akY0R3VLSFlJOFFxNUMxRUk5Tk04b0J5V09jZUlGN091WFRlQ25hUGlqL21H?=
 =?utf-8?B?VHc4a2pET1llOEJzZ0plT3d5V2oyT3lLQi9sUnhDbjk5SWJPc3F5T3J1eDQ5?=
 =?utf-8?B?bGlKV3B2S0s2bzZrOFZGQU5XMDU4NS9GUCtLb1lkckM2RTRLbWxESVBsNnFk?=
 =?utf-8?B?Z2EraGl0UTNwZTBwZG1Xbmw5L3U3M3lDSGJXY2M1dDMxMTRpbmZiUVpJV3ZV?=
 =?utf-8?B?Ukhpb3VzSjVpZVNBaWJBNDMrZXNORTJXdExrTlBGdDR6Z3VPOVIzalZxM0tV?=
 =?utf-8?B?SFo0Q3dZWFByenRETm9zNU9PM2FCTU9NS0hBUHJUM0VEYXplNjdXcFhUQTFn?=
 =?utf-8?B?V3lFRGNjMmgwOUxmY2h5dXhxVFVRQzhIZUk3Vm1sRzBycDBvaGpNSWNRaUoy?=
 =?utf-8?B?cHMzTVd5MTlYb1JKY0loTXdXWDZISnBpSnRHWlV2d004YlkwbXpkbXRwb1Ax?=
 =?utf-8?B?TkVkQWVtUmlUQndSZGZBOWVqY251TnNOK3hra0kvYUFTWGxxVDQremVqR0ZO?=
 =?utf-8?B?VWNrRHNRYnJDdnFBYlhPQ2JFS1MzaE9Ycy9ORWcwa0Zja091OU5lcFkyUi9Z?=
 =?utf-8?B?aGhlVFdBaEFQdXRQVVphRG9aQ1NzUHI1RUZTT1IyeEpXZ1N2blowRTY2UG9u?=
 =?utf-8?B?cWZxTHRmdURvTkpJS2tzR0xubEdOenZSR3BhdXVKaVB1ajA1b1lhRktuUldt?=
 =?utf-8?B?SUVUR1FGSCtZcFBPRU8yMEZ6VUdYdnFYS0lWOWtFOWtuNmtHREhBQ1RMRzNn?=
 =?utf-8?B?VHVzWGlBR0ZXVXdyVGs3dHhvMys0WUN6SU9OMURsRWhQanAvdTJsSU9zdlBR?=
 =?utf-8?B?a1hCdnBoTGkxdjl6dlR2dGMyVTRhZ1E1M3RIMTBYa2hKME9BVHlFZXlMTzVu?=
 =?utf-8?B?SnBYTG9jR3kyYWlpRkhwdm1ZbTFpWUJGc1ovQ2R1ejdSWERGMGwxdnp1clhz?=
 =?utf-8?B?YTlVMmFMNHprZmgwS1NPMDl0TThrOE1Pc29mSi9NQmM1WXpjUW94T2I5SkFk?=
 =?utf-8?B?aVgwWDBKODRlZStVRmhyYUlNZ2tKcXFJVW15YVYvSXQ5NVhSUzRYQ3E3Mkw0?=
 =?utf-8?B?M1dVUnBrLzlUOUU2OHN6dHREeHU2T3YzZFNUMVhHdERoLzFiejI0RjhqZS9O?=
 =?utf-8?B?MUJnYnplNk9yOVFHVEorUEEwN2hKVm1XdXFxNldsUGRvSFVLVWc0aU9FT0x1?=
 =?utf-8?B?Sis3VEROazd1MFcrUFBCQ1NaUVZDU3pJbHcwdElMaHpzMm9JaE1FV0d2Z0pp?=
 =?utf-8?B?M1VDT2UzalM3SkNucXJzMEMzbkpMSm53dDVSdVRzZXJhL25sNXRPelRqckhT?=
 =?utf-8?B?WnRnWk5lVlRjOSs4UFJBNWlyd0krTC90aW5hSFAxdk9UR0VOUEY1dmlXblpG?=
 =?utf-8?Q?9JT6B+ws1n+RPoX6cujudyYMo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7054DDE69F99214AA42215F265516064@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52d283c-37c2-429f-31d4-08dc917ba809
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 22:52:26.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDa9cRJlDYQkUT/yYZPcbsLiyTqqkeafqef6hsjfd5ni0+jHJ1QoXvZhZcfzl0c/nefZEoeKxDPNsA3HBLfVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com

PiA+IA0KPiA+ID4gSW4gb3RoZXIgY2FzZXMsIHRoZSBjYWxsZXIgbWF5IGludm9rZSB0aGlzIGZ1
bmN0aW9uIGluIGENCj4gPiA+IGxvb3AgdG8gZW5zdXJlIGVub3VnaCBwYWdlcyByZWNsYWltZWQg
Zm9yIGl0cyB1c2FnZS4gVG8gZW5zdXJlIGFsbA0KPiA+ID4gZGVzY2VuZGFudCBncm91cHMgc2Nh
bm5lZCBpbiBhIHJvdW5kLXJvYmluIGZhc2hpb24gaW4gdGhvc2UgY2FzZXMsDQo+ID4gPiBzZ3hf
Y2dyb3VwX3JlY2xhaW1fcGFnZXMoKSB0YWtlcyBpbiBhIHN0YXJ0aW5nIGNncm91cCBhbmQgcmV0
dXJucyB0aGUNCj4gPiA+IG5leHQgY2dyb3VwIHRoYXQgdGhlIGNhbGxlciBjYW4gcGFzcyBpbiBh
cyB0aGUgbmV3IHN0YXJ0aW5nIGNncm91cCBmb3IgYQ0KPiA+ID4gc3Vic2VxdWVudCBjYWxsLg0K
PiA+IA0KPiA+IA0KPiA+IEFGQUlDVCB0aGlzIHBhcnQgaXMgbmV3LCBhbmQgSSBiZWxpZXZlIHRo
aXMgInJvdW5kLXJvYmluIiB0aGluZyBpcyBqdXN0DQo+ID4gZm9yIHRoZSAiZ2xvYmFsIHJlY2xh
aW0iPyAgT3IgaXMgaXQgYWxzbyBmb3IgcGVyLWNncm91cCByZWNsYWltIHdoZXJlICANCj4gPiBt
b3JlDQo+ID4gdGhhbiBTR1hfTlJfVE9fU0NBTiBwYWdlcyBuZWVkcyB0byBiZSByZWNsYWltZWQ/
DQo+ID4gDQo+ID4gSSB3aXNoIHRoZSBjaGFuZ2Vsb2cgc2hvdWxkIGp1c3QgcG9pbnQgb3V0IHdo
YXQgY29uc3VtZXJzIHdpbGwgdXNlIHRoaXMNCj4gPiBuZXcgc2d4X2Nncm91cF9yZWNsYWltX3Bh
Z2VzKCksIGxpa2U6DQo+ID4gDQo+ID4gVGhlIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpIHdp
bGwgYmUgdXNlZCBpbiB0aHJlZSBjYXNlczoNCj4gPiANCj4gPiAgMSkgZGlyZWN0L3N5bmMgcGVy
LWNncm91cCByZWNsYWltIGluIHRyeV9jaGFyZ2UoKQ0KPiA+ICAyKSBpbmRpcmVjdC9hc3luYyBw
ZXItY2dyb3VwIHJlY2xhaW0gdHJpZ2dlcmVkIGluIHRyeV9jaGFyZ2UoKQ0KPiA+ICAzKSBnbG9i
YWwgcmVjbGFpbQ0KPiA+IA0KPiA+IEFuZCB0aGVuIGRlc2NyaWJlIGhvdyB3aWxsIHRoZXkgdXNl
IHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpOg0KPiA+IA0KPiA+IEJvdGggMSkgYW5kIDIpIGNh
biByZXN1bHQgaW4gbmVlZGluZyB0byByZWNsYWltIG1vcmUgdGhhbiBTR1hfTlJfVE9fU0NBTg0K
PiA+IHBhZ2VzLCBpbiB3aGljaCBjYXNlIHdlIHNob3VsZCA8ZmlsbCBpbiBob3cgdG8gcmVjbGFp
bT4uDQo+ID4gDQo+ID4gRm9yIDMpLCB0aGUgbmV3IGdsb2JhbCByZWNsYWltIHNob3VsZCB0cnkg
dG90IG1hdGNoIHRoZSBleGlzdGluZyBnbG9iYWwNCj4gPiByZWNsYWltIGJlaGF2aW91ciwgdGhh
dCBpcyB0byB0cnkgdG8gdHJlYXQgYWxsIEVQQyBwYWdlcyBlcXVhbGx5Lg0KPiA+IDxjb250aW51
ZSB0byBleHBsYWluIGhvdyBjYW4gc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKCkgYWNoaWV2ZSB0
aGlzLj4NCj4gPiANCj4gPiBXaXRoIGFib3ZlIGNvbnRleHQsIHdlIGNhbiBqdXN0aWZ5IHdoeSB0
byBtYWtlIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpDQo+ID4gaW4gdGhpcyBmb3JtLg0KPiA+
IA0KPiBUaGlzIG5ldyBwYXJ0IGlzIG9ubHkgdG8gYWRkcmVzcyB0aGUgaXNzdWUgeW91IHJhaXNl
ZCBpbiB0aGlzIHRocmVhZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9vcC4ybmRz
eWRneXdqdmptaUBoaHVhbjI2LW1vYmwuYW1yLmNvcnAuaW50ZWwuY29tLw0KPiANCj4gUmVhbGx5
IGl0IGhhcyBub3RoaW5nIHRvIGRvIHdoZXRoZXIgZ2xvYmFsLCBkaXJlY3QvYXN5bmMsIHBlci1j
Z3JvdXAgIA0KPiBjb250ZXh0cy4gVGhleSBhbGwgc2hvdWxkIHVzZSB0aGUgZnVuY3Rpb24gdGhl
IHNhbWUgd2F5LiBUaGlzIHBhcmFncmFwaCAgDQo+IGRlc2NyaWJlcyB0aGUgZGVzaWduIGFuZA0K
PiBJIHRob3VnaHQgdGhlIGFib3ZlIG5ldyBzdGF0ZW1lbnRzIGp1c3RpZnkgdGhlIHJlYXNvbiB3
ZSByZXR1cm4gJ25leHQnIHNvICANCj4gaXQgY2FuIHJlY2xhaW0gaW50byBkZXNjZWRhbnQgaW4g
cm91bmQtcm9iaW4gZmFzaGlvbj8gIE5vIHN1cmUgd2UgbmVlZCBnZXQgIA0KPiBpbnRvIGRldGFp
bHMgb2YgZGlmZmVyZW50IHVzYWdlcyBvZiB0aGUgZnVuY3Rpb25zIHdoaWNoIGFyZSBpbiBjb2Rl
ICANCj4gYWN0dWFsbHk/DQoNClBsZWFzZSBjbGVhcmx5IGRlZmluZSB0aGUgYmVoYXZpb3VyIG9m
ICJwZXItY2dyb3VwIHJlY2xhaW0iIGZpcnN0Lg0KDQpJIGNhbiB1bmRlcnN0YW5kICJnbG9iYWwg
cmVjbGFpbSIgbWVhbnMgd2UgZXNzZW50aWFsbHkgd2FudCB0byB0cmVhdHMgYWxsDQpFUEMgcGFn
ZXMgZXF1YWxseS4gIEJ1dCBpdCdzIG5vdCBvYnZpb3VzIHRvIG1lIHdoYXQgaXMgdGhlIGRlc2ly
ZWQNCmJlaGF2aW91ciBvZiAicGVyLWNncm91cCByZWNsYWltIiwgZXNwZWNpYWxseSB3aGVuIHRo
ZSBiZWhhdmlvdXIgaXMNCmRpZmZlcmVudCBiZXR3ZWVuIHRoaXMgdmVyc2lvbiBhbmQgdGhlIHBy
ZXZpb3VzIHZlcnNpb25zIChzZWUgYmVsb3cpLg0KPiANCg0KWy4uLl0NCg0KPiA+IEFuZCB3aGVu
IHRoZXJlIGFyZSBtb3JlIHRoYW4gU0dYX05SX1RPX1NDQU4gcGFnZXMgdGhhdCBuZWVkIHRvIHJl
Y2xhaW0sDQo+ID4gdGhlIGFib3ZlIC4uLg0KPiANCj4gTm90ZSwgYWxsIHNneF9jZ3JvdXBfcmVj
bGFpbV9wYWdlcygpIGd1YXJhbnRlZXMgaXMgc2Nhbm5pbmcgU0dYX05SX1RPX1NDQU4gIA0KPiBw
YWdlcy4NCj4gPiANCj4gPiAJZm9yICg7Oykgew0KPiA+IAkJY2dfbmV4dCA9IHNneF9jZ3JvdXBf
cmVjbGFpbV9wYWdlcyhzZ3hfY2ctPmNnLCBjZ19uZXh0KTsNCj4gPiAJfQ0KPiA+IA0KPiA+IC4u
LiBhY3R1YWxseSB0cmllcyB0byByZWNsYWltIHRob3NlIHBhZ2VzIGZyb20gQHNneF9jZyBfQU5E
XyBpdCdzDQo+ID4gZGVzY2VuZGFudHMsIGFuZCB0cmllcyB0byBkbyBpdCBfRVFVQUxMWV8uDQo+
ID4gDQo+ID4gSXMgdGhpcyBkZXNpcmVkLCBvciBzaG91bGQgd2UgYWx3YXlzIHRyeSB0byByZWNs
YWltIGZyb20gdGhlIEBzZ3hfY2cNCj4gPiBmaXJzdCwgYnV0IG9ubHkgbW92ZXMgdG8gdGhlIGRl
c2VuZGFudHMgd2hlbiB0aGUgQHNneF9jZyBzaG91bGRuJ3QgYmUNCj4gPiByZWNsYWltZWQgYW55
bW9yZT8NCj4gPiANCj4gDQo+IHdlIHN0aWxsIHJlY2xhaW0gaW4gc2d4X2NnIGluIGZpcnN0IHNj
YW4gYW5kIGF0dGVtcHQgb2YgcmVjbGFpbWluZyBmb3IgIA0KPiBTR1hfTlJfVE9TX0NBTiBwYWdl
cywgYnV0IGlmIGl0IHR1cm5zIG91dCB0aGF0IGRpZCBub3Qgc2F0aXNmeSBjYWxsZXIgIA0KPiBu
ZWVkcywgdGhlbiBjYWxsZXIgZ29lcyBvbiB0byByZWNsYWltIGZyb20gZGVzY2VuZGFudHMgYnkg
cGFzc2luZyBpbiAgDQo+ICduZXh0JyBhcyBzdGFydGluZyBwb2ludC4NCg0KQnV0IHdoeT8NCiAN
Cj4gDQo+ID4gQW55d2F5LCBpdCdzIGRpZmZlcmVudCBmcm9tIHRoZSBwcmV2aW91cyBiZWhhdmlv
dXIuDQo+ID4gDQo+IEFnYWluLCB0aGlzIGlzIHRvIGZpeCB0aGUgaXNzdWUgeW91IHJhaXNlZC4g
SSBjb25zaWRlciBpdCBpbXByb3ZlZCAgDQo+IGJlaGF2aW9yIDotKQ0KDQpQbGVhc2UgY2xlYXJs
eSBkZWZpbmUgdGhlIF9FWFBFQ1RFRF8gaGViYXZpb3VyIG9mICJwZXItY2dyb3VwIHJlY2xhaW0i
DQpmaXJzdC4NCj4gDQoNCldlIGhhdmUgdHdvIGNob2ljZXM6IA0KDQoxKSBBbHdheXMgdHJ5IHRv
IHJlY2xhaW0gZGVzaXJlZCBudW1iZXIgb2YgcGFnZXMgZnJvbSB0aGUgZ2l2ZW4gY2dyb3VwLA0K
YnV0IG9ubHkgbW92ZXMgdG8gcmVjbGFpbSBmcm9tIGRlc2NlbmRhbnRzIHdoZW4gdGhlcmUncyBs
ZXNzIHRoYW4NClNHWF9OUl9UT19TQ0FOIHBhZ2VzIGxlZnQ7DQoNCjIpIEFsd2F5cyB0cnkgdG8g
cmVjbGFpbSBkZXNpcmVkIG51bWJlciBvZiBwYWdlcyBfRVFVQUxMWV8gZnJvbSB0aGUgZ2l2ZW4N
CmNncm91cCBfQU5EXyBpdHMgZGVzY2VuZGFudHMgKGluIGdyYW51bGFyaXR5IG9mIHJlY2xhaW1p
bmcgU0dYX05SX1RPX1NDQU4NCnBhZ2VzIGVhY2ggdGltZSkuDQoNClRoZSAxKSB3YXMgdGhlIG9s
ZCBiZWhhdm91ciBpbiB0aGUgcHJldmlvdXMgdmVyc2lvbnMsIDIpIGlzIHRoZSBuZXcNCmJlaGF2
aW91ciBpbiB0aGlzIHZlcnNpb24uDQoNCkkgYW0gbm90IGFnYWluc3QgYW55IG9wdGlvbiwgYnV0
IHRoZSBwYXRjaCBuZWVkcyB0byBiZSBjbGVhciBvbiB3aGljaA0Kb3B0aW9uIHRvIGNob29zZSBh
bmQgd2h5IGl0IGlzIGRlc2lyZWQvYmV0dGVyLg0K

