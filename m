Return-Path: <cgroups+bounces-1819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661D8605D2
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 23:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7731F25438
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 22:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2C818026;
	Thu, 22 Feb 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpYj/iaK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18017BBE;
	Thu, 22 Feb 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641913; cv=fail; b=Ce4weTcNkp3CLYNtEwECR79uqIodkxtWdHu9Z3S/W1jWgsC+rcBgQom0czjbiDPBnN2AtZkNwxW25MiGS3lohu693StACFFGWENt48ikIQQ+CBsL+KcmSdHlo1uQgM6T0zMwEvl8YSSd9l6C8TI1JrTistxMGEhiLFN4kU3QFjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641913; c=relaxed/simple;
	bh=io7F37V7V3D2nwogErjVOpY959m40quMdqVVVctXf3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSv5a3uddkRD3CUREFBn8+1pGqJdlSoOP+ky/+w3eMXi8Paz3LK8yruVgfa48rpUETqCbY4RNttoZr4iJE8nVkqq9qjqRFsm/sNhx+3mGG0/jbH2jitYphAZFXlqjB5qezfOTyj0ZSALQtmGsc2fC05pOshMDhIe6XHhotukNXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpYj/iaK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708641911; x=1740177911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=io7F37V7V3D2nwogErjVOpY959m40quMdqVVVctXf3s=;
  b=NpYj/iaKO10cJmkrJ7rGvImMroRVxMjn/giBplLzby6mE4WgHH9LQ9Me
   Ay2REtpYSHgmOwn1VV/WKSyHvihKLqavCMC1/8Bcdf8nvMVuBhS03L1aH
   RPZwkT5BUNVSoOBjfP6M+u052AAanVpjsPXREHuLggrMExQ+034WEki1K
   JXRcS+y2OXRaI/cX2DoxVsLJC/yKT9vnSv8YXsm+FmXAJ3laJ/cTV7Cq/
   201/AhowXdhwcqHkQXxrRrJuwzrDS0fh7henW/EZVdxIgJCZ1hq2bQcKs
   GCZLy6ShJgCWtsQ8BrxWtON/Cpqp3zV5lk+W+mVcryflxdL0Y7mRNOe70
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2765818"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2765818"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:45:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10250781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 14:45:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:45:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:45:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 14:45:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 14:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwYc3wCKbdILnN6Y6ZIih5FRs7UBEv0ctL5svEgLSKju/Iq7wQ2q1xVwomEvVwtBykWYYAl9GvgmWX1lyEQxZgjnstOlkdr+6YeRtzztyggMaz0/oJvydIZTcvbhRKpLNDRxQg4QzgDqqh6NRMTq++zA8DWAR7pUs6+DVyKqNhGrcb0/iflDAlmgQOI9lxbNpHimBuRXa/I4/URwpmdqJy7WJsvBG6UnY982N/39Mkx1aZk0H8Iw4IoCLYX2Gw44Vxio4TxGkKR/ItSeId2JfZDvuPoqva3NqV7uePmW5TKy1K/IrT7u2itifFnxGveOVn86CyCkEH3seMR3xsV8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xD18FjpLJotVSTcEWoC/j0i/PjDXsbP6WvLT1A7iak=;
 b=dtCBQ/K8aWWXp8kVGoEhbdTENJStvy8AapzrQXW90PHW6eXU5fsLrCYBYE5GpGrb14hRw/XPLiAphcGu3uT2RVbtWrjv3BOd8T+27CkjAf+LAIGu/bwfN8vfR5sK0PBwUOMqZIba7Kaj9cNiADBVjKwxBFeI5NEFlFbFWtaIpoBPvL+NYkKhTeNDVU41vYaLab+DKSTTIlUleeDQ9l/ShsIi1HqBoO/2UiICBfj0lVTWi6gKkM7qVhkONwYtvlzKFSgMW5zEQHeEjAZQsmEVg7k5Zui2N46rtlat4lLK3V6duFPYyvc13uQ6EiKo9HCyK1viHK0YeBpvixcWigyi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 22:45:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 22:45:00 +0000
Message-ID: <50ecd28c-4514-4ca9-8eb7-4cae24ba9d1d@intel.com>
Date: Fri, 23 Feb 2024 11:44:45 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Content-Language: en-US
To: Haitao Huang <haitao.huang@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org"
	<tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-14-haitao.huang@linux.intel.com>
 <87a85645ef1661e54ae6e56f1e47db25c3f8d7af.camel@intel.com>
 <op.2jjxqjiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jjxqjiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b36595e-c448-46a8-19ec-08dc33f7e6bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S75BMT8bPS5Xl//rhWurevjOv+mtnfIaia24m+nDNY6TMB4NHIvD+Oxg/XsXMulXuwnSVH7gAKiMgutzUQVVhVKK3vUAjBacrafdzOnApTPxm592ha4TF668tDIhk8ZgfE/9ldSv8unA2tjS4f/C40sSBd/j8r3czDJFcFuBOinS5rjTXhh4lW0iHj9wYqEAhGZOeKv5RFa1HBnHHGA0NBKNOGjLXQEufuyqk21Ki3dIOf+WYUhDbNdGtMFyMJLQ57Twc5pSWFjjQ4ZdSRkmgkmhPmMG1dtAjVkEbhlgefDZv1Bmp8fkSpCRLLHmkkjqgw+y0w2B9SQ/SQDDQXj2oF/dnXXFpnv10ClEEQTVIe/3t1x47zCpNKrVBJuTIaTUkFRY9r0gGm/qWCs6DNFkmt6RTIEBk2nNcZApQX0r2j+agxINVEhYGSdQAugZpWEbidIiuOre/zbqrvgC+Yx9+ekD4MtYUtt3gToR1Rw90/tJnS16QxOmdTWe/9WXA63d6bktUEmhPJ3PKGRjCJJRgibUvK5nMib905U5OQGShLaFElOD+lLQdE+MhoGDIULHS9A9EkQS2KRL+X4tqYM6LDIM2Md96RwlAya4MhIOQlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vzd1a2V3anNMV0xLK0ZxS2J2cUhCaFdrU0Jqb2FqZDQwUVEvU3M5ZjNiYS8r?=
 =?utf-8?B?bUhCL2dGQ3pQUEF5ZktqSHFCcHE3Tm9XdkhiT0VUZUtUdlBuSWZsWStyVFdy?=
 =?utf-8?B?NkQxTnlqWXJ4dm5Hclg4MnBzRXJ1em5laWNzd3R4dFp1T0d5dDltZGx5dnI1?=
 =?utf-8?B?a1gyak0vL0Rac0h3aVJ2TzA5aWFPMUp4TU5vSFI3TUNjVlZaVjd5OUN5Wkxl?=
 =?utf-8?B?Vk9TSkpSMENJMGRxSE95QW1HUkJRaUxJWFd3S2VNMDNlYXBrbkZQcWg5Skwv?=
 =?utf-8?B?OWN0aGExUzZ5ZWlLK0ZDVEZsMlFQZXh4T2hMMHRUY1pERnNOQklhUENLTko1?=
 =?utf-8?B?N2FCSGxlYXdIcW52WDRLRlc1ZDNJTzVINno3WW5LdGk0VmFjTDdTdWRaVFNT?=
 =?utf-8?B?aGlVWVNPa0huNUNhR0h2QTZTRWIwUmJyYzRzZ2p5RTRrY09PcE1wc2RwQTVT?=
 =?utf-8?B?NGRrWEd1cnpWOC8xK2xBZVgrQzZuak11MnJFTllBbTBjVXY0RWYyeUFiaXow?=
 =?utf-8?B?RU0xTkNQVnNNWk1NTHlvZDRabVB2SU1jeEhhOEk4L2MwUy9oa2k0UVRWbGRI?=
 =?utf-8?B?NE4xNXFhYloxLzkvV280UXhiMHBoNDRpTDhaZlY4c3M0MW9kSCtWQnJzYzBk?=
 =?utf-8?B?ME5ERWFKQlQ5dThtMVhVVzVEcUJPSlMvZkQrR2thdlNUM3VSZlVIZGNWTVhR?=
 =?utf-8?B?aWZCTE1KWVRObUhiSU5BeHlkUkR3aW9rV08vcjRYZWcwNUxTTWQwVmd6OE1l?=
 =?utf-8?B?am12d0VoaHNtNGRXSXJkRHoxOWJaU2R0TSsxdTlBdWFNOThFb09EUlRBREFr?=
 =?utf-8?B?VjlLNGd4c2xDbWorK3NCRFJua1FHaTNOaEhSenNlZURjV1NwV0Y0ODJ2UjM3?=
 =?utf-8?B?TEsyWnpOd3hlb0pONXowUSs1UU1Pa3RzeUs1SmVTYXZTQWZxSldxTk5aU3A1?=
 =?utf-8?B?WEd3NkNWS2VGcTM2M0JZbkIxMEl3UEtyN3JEd25YTk9qQU5WUmFlRHJtcUlE?=
 =?utf-8?B?TVdEaWZnYno3TEFpUDNaNW5UZkdkVmljY2VwM1FZNDBMTlhpT3IrWlY0N210?=
 =?utf-8?B?UHNYSWhiTXlKQ212Z0h2THJlMW1lejZ2TjBJMVJyM0RJc0gzVE0vYzRlTU94?=
 =?utf-8?B?aWM4RzkzQ1k4M2ZVM2NMaWNOdy9TQkl5bGVNUlVyaTF1Q1dIWG1IRkRpQzll?=
 =?utf-8?B?UG82UzJBdnNNMWgrSHA4MzErRXhwYi9majJMUGVqWDRFM1FsTGMwNTB1bFhE?=
 =?utf-8?B?MnNzUUxnc2Q4Tmw3WldsdkJ0VkZ2TG9HMFdzSGZPWGQ4TVFSdDhLV3hkTEcv?=
 =?utf-8?B?d0VpRGgrZlUxanMzVVcyRE94Rk5mdHR5NGFDNzVFQXlpY2U2Wm1oMWhWOXdU?=
 =?utf-8?B?N0c3OHE5UDdXWUdzalhENFJGK0xFOS9tK0RhRTFTSi84UUU0T1kwalRxVWhC?=
 =?utf-8?B?VFpmZnhqeHk4SFAzSHp2K1I3ZFBMUS9NZGNqWC82Z0lQSVFXRmJoaWNqRUVD?=
 =?utf-8?B?N3BQRnltOGhTSlZvcFQzcEJMeGh2elZhNEUvaVV4NDhVUytuSnk2MUkwUE1V?=
 =?utf-8?B?bUNhN245dVc4bldVdzdYaEFqYU1qSnQyVHZuWERtTXpQUDdQYUd3bFFLdERM?=
 =?utf-8?B?dlY2ZmhZWU43dGowWFFKcnVic0V5M2ZyVmtqdE96RUdmSnljVUUzY3JnRXor?=
 =?utf-8?B?Q2hMQ0QrM2xPZTJka2RMUk1peW5tNkFtVGx6K1EzdlozYTI2eVkyZURTam05?=
 =?utf-8?B?ZG5Xa1NvZUdENVY4dWtncTZEUTJCSGZiVEtUUjZOeFRqeVp1RUYyNmkwSEFi?=
 =?utf-8?B?RGRKNHJEUVNQQ1NRK3BxUHlQMWNnai9abkc1anQxRU56VHZ4dDhtYSs0R0ky?=
 =?utf-8?B?RWhmVkxtNEF0QlhoYUZadnJyOE93b1RZQ01jSlM2YkZNSWpTWnJMRytFU3NF?=
 =?utf-8?B?TjRYckExZlYxTGF4eUpXa0l4RzZ1WDFRSXkwVWtWaWo2TjE5M25PcHpCWG9E?=
 =?utf-8?B?cXE5SkZiRUZ0cFBBV2hGUnphbXo1cVNYMmNZZlp1ZUJZelBPZEYxNUc2bnhG?=
 =?utf-8?B?RjFnTFEyRUY5TVo1ZXNMNzIzRjFZU1FYRnZudDBXQktRV2F4TC96NEdVMTdt?=
 =?utf-8?Q?IToqCi5sofg/yhvsstwdXT6B2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36595e-c448-46a8-19ec-08dc33f7e6bc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:45:00.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amSY/pDV+VkmW3jy5pVOY7aXrdkJJpRFMz3i+O0EEjJ8d57+/3J1eLOQv2WTmmAwwK/4e6L9DI/Ls/yeS4DQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com



On 23/02/2024 5:36 am, Haitao Huang wrote:
> On Wed, 21 Feb 2024 05:23:00 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>>
>>> Previous patches have implemented all infrastructure needed for
>>> per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
>>> pages are still tracked in the global LRU as sgx_lru_list() returns hard
>>> coded reference to the global LRU.
>>>
>>> Change sgx_lru_list() to return the LRU of the cgroup in which the given
>>> EPC page is allocated.
>>>
>>> This makes all EPC pages tracked in per-cgroup LRUs and the global
>>> reclaimer (ksgxd) will not be able to reclaim any pages from the global
>>> LRU. However, in cases of over-committing, i.e., sum of cgroup limits
>>> greater than the total capacity, cgroups may never reclaim but the total
>>> usage can still be near the capacity. Therefore global reclamation is
>>> still needed in those cases and it should reclaim from the root cgroup.
>>>
>>> Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
>>> when cgroup is enabled, otherwise from the global LRU.
>>>
>>> Similarly, modify sgx_can_reclaim(), to check emptiness of LRUs of all
>>> cgroups when EPC cgroup is enabled, otherwise only check the global LRU.
>>>
>>> With these changes, the global reclamation and per-cgroup reclamation
>>> both work properly with all pages tracked in per-cgroup LRUs.
>>>
>>> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>>> ---
>>> V7:
>>> - Split this out from the big patch, #10 in V6. (Dave, Kai)
>>> ---
>>>  arch/x86/kernel/cpu/sgx/main.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/sgx/main.c 
>>> b/arch/x86/kernel/cpu/sgx/main.c
>>> index 6b0c26cac621..d4265a390ba9 100644
>>> --- a/arch/x86/kernel/cpu/sgx/main.c
>>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>>> @@ -34,12 +34,23 @@ static struct sgx_epc_lru_list sgx_global_lru;
>>>
>>>  static inline struct sgx_epc_lru_list *sgx_lru_list(struct 
>>> sgx_epc_page *epc_page)
>>>  {
>>> +#ifdef CONFIG_CGROUP_SGX_EPC
>>> +    if (epc_page->epc_cg)
>>> +        return &epc_page->epc_cg->lru;
>>> +
>>> +    /* This should not happen if kernel is configured correctly */
>>> +    WARN_ON_ONCE(1);
>>> +#endif
>>>      return &sgx_global_lru;
>>>  }
>>
>> How about when EPC cgroup is enabled, but one enclave doesn't belong 
>> to any EPC
>> cgroup?  Is it OK to track EPC pages for these enclaves to the root 
>> EPC cgroup's
>> LRU list together with other enclaves belongs to the root cgroup?
>>
>>
>> This should be a valid case, right?
> 
> There is no such case. Each page is in the root by default.
> 

Is it guaranteed by the (misc) cgroup design/implementation?  If so 
please add this information to the changelog and/or comments?  It helps 
non-cgroup expert like me to understand.

