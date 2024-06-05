Return-Path: <cgroups+bounces-3109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97118FD9DF
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500AA1F22FA0
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BE415FA6B;
	Wed,  5 Jun 2024 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6yLO2Z8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2813A897;
	Wed,  5 Jun 2024 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626685; cv=fail; b=UYgSrmjUHRbS9xhjZ9/tDYSg6tDmrs7DNdT/58hvU78hkFOOZZiKSlfDbuXPAXheAGxomyTYxNumkcRA62/xE0I7N+Cs3A8XA1e2qycVawjNB6iRvFTrY9MyvXg5/9uLvtfL4YCgOpM1zt8bO+Fkd0fcMjbWY3YJDYa762Ukhrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626685; c=relaxed/simple;
	bh=94p861wg3+gU7/l4cMQ8BIIhtv8U7IRRjeUgPm3BeGM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdkSDSSFVifLKn4sVImI6C/gdCahsSGmFdNy6Quru0CJ6jmHkl3GYwU8/ANNfOQQcrsdLfCYJlxCxUQL17mPdq8oGuuhoJ9uiDnXv8oPKhyLSjv3u3d1WooCuOdUFG7pOpDKGfGY/Xz5UoimVD7PWpKvkv+wKGuoBInTykbrbUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6yLO2Z8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717626683; x=1749162683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94p861wg3+gU7/l4cMQ8BIIhtv8U7IRRjeUgPm3BeGM=;
  b=E6yLO2Z87DTRXTfpUVFYD//H2sZjQ13SIAir2b/vJAv8Ud6mep3Vm3Pw
   fYRuW4wZ21Gd5ta14mJ/SzXYioCLmJhq0sBtu6PJAGOK0IY46M2A7bgQV
   3YsMHK83S6ZcOcQmL3qKC8EIUfM0RT75v1Jf8X4XuIfy0zAckK7c1pzkz
   5SMm15EEN9oJ0SXWHB9tM21AiGZZa4yjuFwjc1LX0HU7TK9fFR9E1O6Lw
   ZG8pl3+EhQoGn1iACsYHMfU00k4h9wIa2ymG8sO1i72Osd4D/UPN0SngK
   sVLsXdEOCYNC7Qui7j1GOXU4I+p0EY+GBwJk8PN4S1j2rg7HK1IrYC3LM
   w==;
X-CSE-ConnectionGUID: NvCT14PhRq+PlFDCvTvxAw==
X-CSE-MsgGUID: hO4MOF3qQl2Mq9x22EyP9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="17203199"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="17203199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 15:30:27 -0700
X-CSE-ConnectionGUID: uPLWv5KaTS6KfN5Wxg8/ww==
X-CSE-MsgGUID: lay5yqjlTJmpBReXEeun1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37851381"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 15:30:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 15:30:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 15:30:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9aYyioxRCTEhdKeh8lOpxWn4CDB9N+tIjoNlvGUrS+HGLPaB0I+ToP4k4pBteU6ovmYNsAR41Tjbq3yrO1VOLjw6zCpUzqbw9OQ6Xe06QeUzmHFJ73GbtlQJIngsFLSsjA6cRtCt94dqCVw3uJk06LMNtBiHwbpgsY3UoZjU5G17QDTq5BnjA7NP+YKS4IGs+BYrNaZYHfpwoyGEcaGSUZwDHIxv77f+rUMB014tpqCXM8n7R/xpJShG+NBycvBzl1WYTKIP9Uk4EYRGEfBORA5TlcLTEIU6XvuRbAL7rGGto5iLCtGKq7I0LO0vRsa1iMw7xTkI95DehHXPNQolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+QCYgu80wuMPc3NGq85MVA+qSpDxhpCPWaJSQiWCjw=;
 b=HRoyuDLuNs6vYJ6jmB0Vvudfi7YnOAhKGf9j5eQjZBsmXIdeYXtpEQpb7imuP80CBGqFNzdbHOiw5A9nfMQFvHosQDNu0M1zkcdUkmIq4kMDnMzbh9VxBpdmhhF8jIJJH0Q3jr24u2tYO7raiKYDFwmQIwTEV1UzPJAcu0Ry8AwMHgZ9WEZJhLgZkBGxQjTcJ4rcwoUXY5z18CKZOx7q7wcVohE5MWqeQCiXp14Pn030Qu5Ja5eOZ25hIumpLvW3y+TczgBhUW44zM1/7Fc8QZSqpwA3Snldl8TVfpQmd8QIV4lyuwaYe3YrfJU8gkh0troFi876MqsgyTPP3bbakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 22:30:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 22:30:23 +0000
Message-ID: <7cbf3583-a23e-4437-afc2-1faeb4a1f436@intel.com>
Date: Thu, 6 Jun 2024 10:30:10 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
To: Haitao Huang <haitao.huang@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
	<x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <sohil.mehta@intel.com>,
	<tim.c.chen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CY8PR11MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ced2f7-9a6c-4c91-7ad0-08dc85af16e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTd0dXkyL2p1LzVFendRTDN0NEduOXRGOVhkWXUrUS9NVTg1a0pmNE51VUg3?=
 =?utf-8?B?TnN0U3YvdHhmRzl1VWVRd21UR0VxWnFhUXA5M0wvWGxQQXN4TTlCaUwyM0Zp?=
 =?utf-8?B?QzNGYW1qQ044QjJheFVpdmZWZDJmZ1UxczA5YlVqeDBZMmovRGVyazA4YW0y?=
 =?utf-8?B?Z0ovQjZWVDFZQkYzTFV4cjdzdGJPR1NoMVZqcWZZR0xMbDJodzhJY29iaFgw?=
 =?utf-8?B?QmtxWUtkcW1vWENqZ3lmbW1QdWUvMWRFVDZwdzRBNlVRdFltMlg4SysrM003?=
 =?utf-8?B?Y0hzVzRSL3ZkQjZ2K3ppekFLWTFOSW8yUGtxRXRSVE5tVjl6eC9zcU9lalp1?=
 =?utf-8?B?THlIRFhRK2RQSTJHRGI4ZWdQdWtwdGNXZkpxSG42YU5pSVV3bFoyL1ZMeXBu?=
 =?utf-8?B?RzhOdmJ3elBPSlpyRW9nT3ZFQnVYRXlHY1ZqazBwUEQ1T1RDbytERWxnNkxI?=
 =?utf-8?B?djRJRWU0OHBpK2JIM3VZVkk1QmxTRWNtOUtDdUNmMnRUczVVMlcvN2daeUJt?=
 =?utf-8?B?czBEa2hQTXROV0tNZW5PcHI4aXcwZGU2RTRSTmM0ekZLNm5LV2l4NzNWMmI5?=
 =?utf-8?B?N3JweG5ieXV2L1FJYml6Vnh2MEdzQ2NKR3BFZzRpSVFJSXdoeXhPc3VCa1Qv?=
 =?utf-8?B?M2JpdmtHem5Da2VNVG1vSEVZc3g4WkJ2ay8yQUtoV0dWVU9DSWVxN1lwYW9B?=
 =?utf-8?B?eURDbkphQUlMMmhrWFZjSGEzQm85RWVXVW5VY2Q2eU1KelEvbTRvRnJGVHox?=
 =?utf-8?B?T3JQcnd2Wkg4SUFyb3pCQWNib2JBYkVJMEk5RW84dFY3MTcvc2JhK3lOQ2VI?=
 =?utf-8?B?R0VRVTBjWmhoRUE5RU9qbDV5V2tsZlhMdzdlcldYWkJ4RjFIL0xUM3JJUmh5?=
 =?utf-8?B?OFpUWnRhS2YwRStYd1QrSTRGaHNGc0h3ZUZWMk9vaWsxQURHaEdYM3JDaC9D?=
 =?utf-8?B?L0hHTWx1ZHRQeDdTem5CMWprVmlOSHFzdy9TelVoeDZTZnk2b255Z1JDWith?=
 =?utf-8?B?RzdQaHU3a1pNVW1uSHJicEhqYkJiaXU3NEdEakVseHBZTlZ4TW1KVE1JV1Ex?=
 =?utf-8?B?T2xmYVhHMTBSbFQ0VEdnUVhvemhuVGY3YjkyY0ZVTGVPOUlRRWZGY1ZaVCtl?=
 =?utf-8?B?UzYvQjdsUjZ3T3M1RkJObTMvaFFDbzE4Ym9nQWZ3OHlaWmtXRkQ1K25NMVo3?=
 =?utf-8?B?b213Nml5NnBpc2tqbE1sWUdYckRBTnJ1NjRxOUVBNDRnb0gzSVVhajRCSUV3?=
 =?utf-8?B?Z0V1M1ArTzVxeU1tckh3UFkwYjhEL25Rdm5zWE5zU05lVnRjdlllV2dSV1R4?=
 =?utf-8?B?WVRSNUtWRTA5M2Y5WW9vTmQwMSt0bmJpRjR2N3NOWVhkd3pIQVZ5UkMyb2RH?=
 =?utf-8?B?Z0V2ZUV1YWIzMFJmeE02UVdHMVY5OHd2TmhIeElYY2JLUGY5NWRlbnNkQkVu?=
 =?utf-8?B?enZSZk1QZ0l5YjF0eldPNVhjcmYxeExzWllFeEpCYUg5V0ttcktWQ0JiZStX?=
 =?utf-8?B?aDdNVXVERVNvb0VuVEcvNFMzT1JZb3hmb1BZTTlNSFBNRzV6b3ExQ3BNSS9H?=
 =?utf-8?B?SWYvMFdLSStJRmg5RUlLaUYvZGUyWWFIYUNuRDNyY2xCSTBHSkZWNTJTN3J3?=
 =?utf-8?B?TWxpMTI2RWdGQ0JuSm81WTg2S3lEWEZZZjB3aDVvMncydCt4NkpEZGtDcFVW?=
 =?utf-8?B?TXB3WDkxakxERSt6ZTNKVlNKbUgyZ2g2NXErVFEyMDh4b1E0YU9YSEpuLzFY?=
 =?utf-8?B?d3E2UXBvMDBlSGJUS04wVFEydE9oMlFjTEptVjd6M3FaWUk5SFMwYmczYkRh?=
 =?utf-8?Q?cJqtk0wkLP05htZNa6x9xncBZMMSi+REeai7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBqUzRvOVpBcXc1b0MrdDZyQmdVMG9aQ0F2enBSa2NSZzR1UXBxa3dCalps?=
 =?utf-8?B?a0JRVkZ1MzZwdDJuczNJeitJUC9PQTBZNkc3dmtaVi9rMGxHN0wzUmhZdndN?=
 =?utf-8?B?dHAwUWNrMGErTlU1ellHZk9mclNvMjZ0Zzh4YUFSOGlvc0h4OUVmM2ZXNFdH?=
 =?utf-8?B?QS83WTBVTHhqTDhXc0hkaUJmL2ZWY0RwWEUxWHZBS0N5R1FXOW1BUjVBSjd0?=
 =?utf-8?B?aDc0TEY1N1J6d2FKTFB5ME1SUnA4dWkrV3A4RXlmNFNIa2lLZjdYQXVYdU9R?=
 =?utf-8?B?bk9DT2xDRzJON2JwQ2syaHgveW1HZ2FDOG1kVXRwL3FJZ2t2UndIb3NzdElR?=
 =?utf-8?B?dS9oR3dua3V5bjIxOHRHYTlQSk1tUXhmUUYxNm81OE9NVzhSVHpudFZaVUpV?=
 =?utf-8?B?VEt3SGkxKy9Sa2pJTCtpSjlBWUxWRG9SR0JMdDZHNkVaTDkyMFhZZkRSY3g3?=
 =?utf-8?B?dmlJY2NPdktZM0hGbTFVWms4OTQvalNWZTJxUE53VGN4bEFSdDJ1ckFiKzUv?=
 =?utf-8?B?UzNPZ3VtSVdLQmxjSHBTRDhzM1JvcmNIQW5IVkNOcGN3UHNnMFpvZlhyRWRa?=
 =?utf-8?B?bkFmUTNSbW9mSEZCSzB6ekgvZk4yL3N5OGFXWFpteHU4V3l1U2MxZy9RUDVT?=
 =?utf-8?B?L0NwOXIrdmlHaDV0dnRieUI0NDd1OGo0SXBITnQwS1k2azVrWWV1MDRIZUJp?=
 =?utf-8?B?SVVzS29IUG9qS2tEKzc1S1d0NnhCeThLaVRmZXFPbEhxWXRyUGU0cW0wUEZv?=
 =?utf-8?B?a1kvM1NYY2RneE5Dbkc0MEpZTFhxZkxKMEhFUHUrTXNFYU5yN3pKTEtGekd5?=
 =?utf-8?B?VGJCelFZcW01Y2tPbFRyRTBLMzAzL29HTVM1TGdrdEtMdUpMR3J5ekhxSVNz?=
 =?utf-8?B?bGlYYUxadWFSNjI2TVBmNk9KMkdGck9rV1RZd2RhUmNJQkVCSFNMK2lvcTlt?=
 =?utf-8?B?UjB1MnUzNXpXNGN3T3dmVW5UY0JRY0tYRUNGbTRZbVVBK296SUs3QWJvRzB3?=
 =?utf-8?B?K2xOZzRXanA4K1JPK0QrNjVPMWdGOUxDRktjeFFQbnpRNURRNGsxaTRzS1Bk?=
 =?utf-8?B?emwvaEovQjh5dW9UdElYSlRGWDkzK2MwUmwzUUtLb1RKTFFjNGRnd3hCOXNY?=
 =?utf-8?B?R1A3MGhLS1Y2b3hNZlRZUitoUU8vWWFFSFdPbnppRlk0ZGJaVUIxSzdsc2gr?=
 =?utf-8?B?aEVCallRbWcxZkFMbVMvbkFWZlJwQWVCZ05zd2tpQ2lTdGR6b3lRNm55WnJl?=
 =?utf-8?B?bXZrbUJFQVRJZmMvVHFFaE82WTU4MDlvdDlsdTVxK0dDR1YrREtaY0RXQ2Zk?=
 =?utf-8?B?TlVUVGh0VFpTZGpCdzVWWEFQWFdNaVVZclg4bWJsQWIxcHM3N1J0eXNoRDd3?=
 =?utf-8?B?c0lNUXZrYVZsVDVZU1RLSWV1dUt2MFRuUFpQVGl0OXFDSFlEbndqNWExQjB6?=
 =?utf-8?B?Q2F2MndhclZYMENLSXMyaHVZaUtxalJvelFqbUJ4eStrT3JuU01zUnpWeFVu?=
 =?utf-8?B?dmtqVGlOdVVEVGE5V3A5Vllydm5TcWpiSGI2MWk3Nng2SVBaUVY4S1RHZFp3?=
 =?utf-8?B?MFF3ZFpYYzM5cmRxREd0eTJ3OWFTdlVBMmY0SjJsbkRsU0J0WTlCdkdQZEJv?=
 =?utf-8?B?dXowRXBWdUZXNTlHOUgzQ1ZaN205cTlmOVdtd0Noei9aNzlyTHFoTEE4MU9n?=
 =?utf-8?B?WTh4QzczOEp2eFdsRDhIZmxrdThSOWs0cm1jaDF4UVUwbnVmejVYUmk2bS9t?=
 =?utf-8?B?ZktHM2FJOURlQWRLU2JYWWR4Ty9SMEJUcnNtaUpGMEpwM1h3VnNMZnRnTGE5?=
 =?utf-8?B?YkRqejY2TVltYjh0M2ZxakUvZHRNcTdPNVU4aHdEZm8xWWJVclg0MDZTdkw5?=
 =?utf-8?B?Nlo1L1ZWUGx3Q1NKeStsNWMwdVJ4Z09VbFNDN2J0RTJ2WDBYK1J1S2ZDN1dY?=
 =?utf-8?B?THVVcW5zK1JOMEU5QmNhOElreHR2ZzNyNzBnL3B4bkIyTGlLdi9KeWZjTmtY?=
 =?utf-8?B?a3dxVjlvODFGdTFDRUVpa2tFODVVS2NpNThRZnMrbGNnaStvU21IOG9WdEtQ?=
 =?utf-8?B?TGZsOUNIWlMvL3VQcmtTSTU1VWVTeGovdEYwVW1wbTNheFZCOTg4S1Viamxy?=
 =?utf-8?Q?dObxX6xKTxYOr/KkMPmI6+HB+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ced2f7-9a6c-4c91-7ad0-08dc85af16e9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:30:23.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpBkyIoovjIUnmO4trvNkiWQPqPppWp2VizaAordjL6UmNB3SoFVesdV5MeGsQNNbv+a2xA/1ZEUuecUeN+yyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com


>> Reorg:
>>
>> void sgx_cgroup_init(void)
>> {
>>     struct workqueue_struct *wq;
>>
>>     /* eagerly allocate the workqueue: */
>>     wq = alloc_workqueue("sgx_cg_wq", wq_unbound | wq_freezable, 
>> wq_unbound_max_active);
>>     if (!wq) {
>>         pr_warn("sgx_cg_wq creation failed\n");
>>         return;
> 
> sgx_cgroup_try_charge() expects sgx_cg_wq, so it would break unless we 
> check and return 0 which was the initially implemented in v12. But then 
> Kai had some concern on that we expose all the interface files to allow 
> user to set limits but we don't enforce. To keep it simple we settled 
> down back to BUG_ON(). 

[...]

> This would only happen rarely and user can add 
> command-line to disable SGX if s/he really wants to start kernel in this 
> case, just can't do SGX.

Just to be clear that I don't like BUG_ON() either.  It's inevitable you 
will get attention because of using it.

This is a compromise that you don't want to reset "capacity" to 0 when 
alloc_workqueue() fails.

There are existing code where BUG_ON() is used during the kernel early 
boot code when memory allocation fails (e.g., see cgroup_init_subsys()), 
so it might be acceptable to use BUG_ON() here, but it's up to 
maintainers to decide whether it is OK.

[...]

>> With "--strict" flag I also catched these:
>>
>> CHECK: spinlock_t definition without comment
>> #1308: FILE: arch/x86/kernel/cpu/sgx/sgx.h:122:
>> +    spinlock_t lock;
>>
> Yes I had a comment but Kai thought it was too obvious and I can't think 
> of a better one that's not obvious so I removed:
> 
> https://lore.kernel.org/linux-sgx/9ffb02a3344807f2c173fe8c7cb000cd6c7843b6.camel@intel.com/
>
To be clear, my reply was really about the comment itself isn't useful, 
but didn't say we shouldn't use a comment here.

> 
>> CHECK: multiple assignments should be avoided
>> #444: FILE: kernel/cgroup/misc.c:450:
>> +        parent_cg = cg = &root_cg;
>>
> 
> This was also suggested by Kai a few versions back:
> https://lore.kernel.org/linux-sgx/8f08f0b0f2b04b90d7cdb7b628f16f9080687c43.camel@intel.com/
> 

I didn't know checkpatch complains this.  Feel free to revert back as it 
is trivial to me.

