Return-Path: <cgroups+bounces-1867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167768683F1
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1031F229C9
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517313540C;
	Mon, 26 Feb 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2mIPVVQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199A130AEE;
	Mon, 26 Feb 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987584; cv=fail; b=nVWxOaFWvRfLKyWwc/00QjzugeCMwfchwqWZXccWSGHXTuV+F9OuBDxBw/qxwU7ot+AnYR9AsiPz2xaHD2yRcbJLfUsHw613pR8V7PDC7TrEId7WaXv40V58aCxFT0a810SD0NQLLQWQv7vQSuRXVHR0cccWcbS7wtBRRedz+6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987584; c=relaxed/simple;
	bh=e7SWonsgQBfKhIabvSD0c0O2W+KAmu5T+eG3Y8kS4YI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HjVaz+JTRMznoDOZ7AyvYuOPMc/S70q+5l7+g9ASeqnI53U36zSyyfTGZ2tI7dk2EZ/yYhmeP4W4q9j2RdrIwwXf2Q9NG4HZ45IVHx6a3VpHe6lEisoI85O+BBncvLH1O1aYJfKdO8Bv5g6qE8K7R7qRX84laNQv/q2wYS0B8jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2mIPVVQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708987583; x=1740523583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7SWonsgQBfKhIabvSD0c0O2W+KAmu5T+eG3Y8kS4YI=;
  b=j2mIPVVQq9bK7SxjHoerVus/KrNupE28IERlRaPkOZcaUCv2hGb9mkJh
   Lk9onq16VtnQT/RQTSDAWq1P2sfxSz1cPiHofVqk0TJG+EqOZgT3L/H3E
   vPbUQQ1tOCje/uJVLvo+5nJ8vSMk4TtTTv64vM3LIaB8rByWW2wOOr9Fh
   U+QJNofJoXAjKc91lMix0ACEgRo4xVvI3oI2EV3TadQr0dGMwZoy/x2rT
   C8SojRj4YCZZ3utk0+9gQk1POOufzFmIGjFgpUtAgXlgAlNr2YZuYgaUh
   h4G//Etf5vHUlPZ8KG24R1FvaJ2dmdbUf7cTi+nb68am+O+viQiDmCk3V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3174368"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3174368"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11447582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 14:46:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:46:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:46:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 14:46:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 14:46:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzI0ZaH38n+uRRgp3Y84H6jAxR9uepMqa/evvCaZV+A5EH8DhnO3A3OQVB2p6tIrctfb/GB4c1Gbx0gVB1fHd2aEtKSST68HljGManvJLB7RxCTPB3sfpLeeykUl8ZqrRQ27BlHkkPOJIAazG5cQW7GvAg8o8ySdD14znc2Ga3yrM4MIaVEKIEBrigQ9+JWh5wwvFZnCHms5YEQDLit+viEhS0s7y0chSO4W0uyE27nhW9Q/YFk7IfkALNt/D37kcw1FJQTTHX41W8sq3bsvHUkEDU5RPTZrJ0bW8Kdi2miHBDfbYZ8mK+yEs2o1i6qRn/TkGAspePzUjoODKwRIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHNwSCRRI5XeB+bBBZzUH0S/BK2sbWj3IlkKZ1TIf9M=;
 b=WgQrHASsusPd5Qcy5tWh+ESm/BZfWG/DFNC/JLH9ktnBYZgka508f1QzlSyf81umHQ/V1xpAK+Zsf9sASnnRfB+qQGy5zozTqgZ7wzNiAGIu9rg5NU2zxRZPvuFwqPWQ3kFrPata5WNJY3UiibbXB1cDTElTuhNx2LPyRDDkc+cS+kCVYnbz8Ay4eEyJmP+SKJBD/w0FEz6Js1LA2ZCAYDSGh5+trq8ILUNbdSRHXAZyngYlUVUAf2AXQwW1sAiPtyfJruLMTlb6B9t438qD06OrmM9j6gY4I52bPF9ErY/2/MQYTPS56g8WfNP3GjK9S43GJmaYjCSEe9M+jMljBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 22:46:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 22:46:16 +0000
Message-ID: <022a37e1-7d51-4d64-bb07-91bce848186c@intel.com>
Date: Tue, 27 Feb 2024 11:46:02 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Haitao Huang
	<haitao.huang@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <d9b0df06-da68-4729-8aac-2a77e890e152@intel.com>
 <op.2jrquskiwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3f4c6d12-7e0f-44ca-920e-ec219904e0aa@intel.com>
 <b4c7e743-55d7-4a76-baeb-871b0e8cf394@intel.com>
 <ddec5892-b748-425e-acea-4757bdeecb8b@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <ddec5892-b748-425e-acea-4757bdeecb8b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0378.namprd04.prod.outlook.com
 (2603:10b6:303:81::23) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM6PR11MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5f5c7b-9bb4-4296-1d44-08dc371cbe06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cF1r3hk5Ei5sAU43O7tsa61u/SmRfhCy3aFbXW8/eoIXHUJNE1epyw7Jz0egbws7S+1iXE/fbhgHNo3ZpODTKBu6OtX9XAVu4O/Mwzz0ovUVBFhh1GRCzzPYAuqTPEEeINNhq8CfwVQTDHrAi1dZ2wKbUWQtj9t2Sxb1hod3OONV02LnvVCRgYdf/wBClNHTKGyi8NzFCCE5z0p8SFCr7EaleD15pPhj+2VKYMNsuEMOt68IZ3OAkH3RdNizp/va+8qk48UzipvJHEbPG4X6WYfb70mp1J3jlRcfMDUEuSSS4nkgEwi3sCrY/4zOAAj9Yl3NozyF+v8pwgRdxmkC48s8aogd/Lg2muBB+44zSCau3GgJ5HnfupnClotIdhR+suOPioM6HQPviH07+Uq8T5AR3vThGtGpaZt9MrR4j9UlIEpdjvVdLm4sTa9VwUERvanNlO1cLcsl5Bpoxr13RZamcn/zVPhS3ufQjDAbHUeMQrxn5ZSFZAy4rYmFy8g2kVXc9HkI6ISU0olCjEndku5cetqA9L5y8d+Ol1/oOLFoa0XzWnuaFdZH7TmFw3JfUV2dPglj+ah1E1kRvHBIvsVVVOyHWCyHjqONGe7G3A33Yv840K3PHJJgYwz6Ycd/vtdTtQteXUdI8zwc1ErXKAP66pGHGq8ZD5H+EXcklP81FL/aJcUuEyjjckuOgW5uSwbD645xWqjf2+gNosu+Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHhDWXV1K3R5SEZxWmlTTUJFNkw4azJXUmo5Z09jM0pibmk4eVB4UTJaS0sz?=
 =?utf-8?B?dElpLzhaVGd2Y1hYaHk1T1BCS0FadkNRTzk4MktpL21HYVJObks5Q3JPZGlt?=
 =?utf-8?B?SG42UlRGWE9VRmlLYnhTVk9SOWU4RS9QeUswWFBFRS9IaGsvTjFuS09iZ0RX?=
 =?utf-8?B?Rmk3azE4bCtNQWFSL2FDNjJrZk9pT2dEd0VjNXFFSGlWSlR0WGFIenJReGp1?=
 =?utf-8?B?VUN0UnZHLzZjb2RFcFVIVjUwYzlFeWVydG4yODNXb3VteG93Y05YcWx2ZE5Y?=
 =?utf-8?B?TnRleVNrNXQ0UHVGU05aeWhvMFNBdThsUVBKV3Z0V3dBdDFHTUZBSDlDNi9U?=
 =?utf-8?B?RFI5M3JjL1pUeEpxaU94QXkyVnR3dWdLRlJYdXdGMEFpS1dTMjV1ZnZrb3k2?=
 =?utf-8?B?ZXJJcUdDdTYrUW5FWEQwRlZnVHNvODRtSFJaRG43d25iQ0pOaFJpOFdhdjdu?=
 =?utf-8?B?QzdUeXRjb3dCSXh3Qlc4amdWd0pSRE9RbmYvekhHeUJ0SzMwWElTVlRHK084?=
 =?utf-8?B?MTNIeC80REtWbit0bURKdU1XVlR6UTZ0bDBnaG5EV3o5RmlRaURMQmxjR3Vh?=
 =?utf-8?B?M1puU1pBTkNod2ZSSUVLOUxwUTZ2L1pUNURnRlc4QXNuckM5alA5aUZJd3lS?=
 =?utf-8?B?UCttNkp1OEpvTXJPTVU3RlNrd2xGbUpJcGhhQksvcHdNQ3JhVG1LNmQyV2Rj?=
 =?utf-8?B?TituR3dyZHhLdGhWZHR6UmJkRWtIUUw4b2pRM1VURVVNVFFnNEpIb2JwU0or?=
 =?utf-8?B?M0tmN0JUMFRuamprV0R5Uy8xV2RlWUJYM29BTUVKbUJ1MXhKVTZham5jbUda?=
 =?utf-8?B?QzNpR0xSYyt5NTlRbUdyNkdsNkZJa05XOHdWZ0QzRE12ZUJtWHU3L3FkWHhZ?=
 =?utf-8?B?MDVBOEF1OFh4V1ZJNjhBaCs1eXU4OW94MW4xREdJbXBOT1NwZTBWWkRjb2hH?=
 =?utf-8?B?RktsbFlJOUNqOEZ3WDhhbGVQZlc0TWJJTVFMZDFjeEZDTTd2U096bGYyUXk2?=
 =?utf-8?B?RnJ6Ukl0QjVnaG9kRDd5ZTRwY3lsZ0g0N3dLWU5ySUtkK2c2MktKaFpxNGFj?=
 =?utf-8?B?VlpoQ0JJMk5zVW0rMEFwaXZwbGNnWGhheHlON3gzSkx0bVBFTk9FejlPZ2ZO?=
 =?utf-8?B?QVNUenpWbUljNFJ1elJ4LzJ3Z1pxSzQ0UzErN1dJakV4NGxTa0dYaVhVUXNH?=
 =?utf-8?B?czdoWlBYYy9oYUhUZlIvU0hDTCtEVFpTWXNHMzVaQlZ1RFd6NnNOTmtyczZL?=
 =?utf-8?B?VlE0RHhFb0p6YUlGSVJmM3BDMTF0K2ZJZUdUbGR4OUhKaXMzakRIMGExNnNi?=
 =?utf-8?B?VDJGSzdKZFV3dzNOWnRrUS9zaThUemFLelNxN3E4MXlZRTR6Z1BGY213ZkU0?=
 =?utf-8?B?akRMbjF0RVFneDA2dW9lZ0VMVHdqdElycUJ0amZkSVJiZ2lrdUUxNGo4eWpL?=
 =?utf-8?B?Zkx0ZlFnRGFXQWF0clgyTTJ3M3VIV3pKNmEvUnYyMDZRbHZ3RWlQaWk2cktO?=
 =?utf-8?B?WDgwekhJenBBYjliQlllUExGS21iWFNuVE5nNDUycGdLVEFMVWVGcWppY0pq?=
 =?utf-8?B?TzFGVEN0K00yVEZnWnQ2SUNoWkRkS3pHdVhuaEFUbXB3bFpDb3prM2E0Umxp?=
 =?utf-8?B?UW9qb1NhU01qd1FFVC9WVi84aEpKeVpETlpyNjdrMXhvUHdHSEZDdUo1SUQ3?=
 =?utf-8?B?bTBYVzVrUGFBWWUrakJ2UTdVTkNtZGx1WXVSTzhpVlRheTc4VEZwRndBTk5U?=
 =?utf-8?B?TXEwcFBPRk9zU2t2U1ptSjRnZXE3dDFzbG5LbnlPY0xXK1g1cmlJTDh6eStP?=
 =?utf-8?B?KzZaWVNXQXdQbE1JNEMwZEtZUFZqT3NZVmN4alpFekdVOXRIQkcvaWhONjNk?=
 =?utf-8?B?KzkxVk4zY3d3YUlkYXkrVkRPSmd4ZFdid0tHemM2bDFsS0JWSElTVzhUdldH?=
 =?utf-8?B?VURaeXp4YnZSeDcwUGNFeE9pTmwxMVVaNHk0MmtHWFo2bDBQMTBUNGxhTGlW?=
 =?utf-8?B?ZUFmOUdONjQvcm5KVkRjbHQ4LzNHSEZYblhaSTFLMUFXYS9NVkQ3ZStDWG9j?=
 =?utf-8?B?Zk5NYnhtdDdnL29Bc1NtVlVhaDlNY25rWnlOOGNSbDMwc3FvV01TU294Zzdr?=
 =?utf-8?Q?4MpUF4rUwzWARLP22oPrYAu6A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5f5c7b-9bb4-4296-1d44-08dc371cbe06
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:46:16.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAmOTtUs2f1pYepWz2bW3KpYgJNiVqHI+YW/0IGikzzGDiFK4r6yojh0pz+VUOamABzZxrEBx0FPKVcA7R8blA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com



On 27/02/2024 11:38 am, Dave Hansen wrote:
> On 2/26/24 14:34, Huang, Kai wrote:
>> So I am trying to get the actual downside of doing per-cgroup reclaim or
>> the full reason that we choose global reclaim.
> 
> Take the most extreme example:
> 
> 	while (hit_global_sgx_limit())
> 		reclaim_from_this(cgroup);
> 
> You eventually end up with all of 'cgroup's pages gone and handed out to
> other users on the system who stole them all.  Other users might cause
> you to go over the global limit.  *They* should be paying part of the
> cost, not just you and your cgroup.

Yeah likely we will need another layer of logic to decide when to do 
global reclaim.  I agree that is downside and is unnecessary for this 
patchset.

Thanks for the comments.

