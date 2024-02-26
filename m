Return-Path: <cgroups+bounces-1828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13786679D
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 02:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F39AB213A1
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C8D502;
	Mon, 26 Feb 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXh2ZSPb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61563B1;
	Mon, 26 Feb 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911534; cv=fail; b=oChwlokKqYu7zv8nOrPBlh691vWbzb7WgDNml4kchKnjPqd3F7oRcovlDAoDzPV0Gazp4/cxPdKVnlakUmaI0nurnGAIPHHb9/bR2vGcwnF27q6vWYmQufytlBeuXFEgpJmhCYQjSnnBxi7Zv+i3PNzf1UUv9u1iahcMS6/2j8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911534; c=relaxed/simple;
	bh=CbXO7TYThMJUx92Asl3qvyM/zh2kinv/CKA6wHb+AzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCNbgqCw8WP6Zt3tyPiA+6uWwPZNyw7RjaHKl6skKQ2bIH+DZoZbTR5JAwlZ+3vE1iBB9mQZynFMYS9hhtrs+Vw6Xe06ZwTgHwdoqfykdiXq7/E2gbQoz71cpueJest+ofPXXlMEU+HcGpyiNTk3cRARhX9grWxPMrW01UtHe3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXh2ZSPb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708911532; x=1740447532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CbXO7TYThMJUx92Asl3qvyM/zh2kinv/CKA6wHb+AzY=;
  b=NXh2ZSPbYfz1w6kY7EBiUz8wMSVYPU7C8NUnpr4uFAKmUbuJnUpOqYmJ
   57Il4u77f0ENyePslfoB1HOqOy9oHuF5s0NPR9y+9n0gMznSW/MGq4kfB
   cHSEGvk/VGPSmQ/I52TIO6p7E3kNkL011g8xk7dMy748HbIisG8GEgVY7
   LaDDM/naSZ5FyARExsLbQPA4EaplnckRYJ9de/F1nr/1Sa7hiCoMOnkAT
   8ppvOopJ/mPZQbNGwcvW/gabNr20LM36MjlhIUAW5xRJi1ZTFtGok+FHQ
   +9vnKFoxBxqM3EAhLaObaVEBXcNR1ijR8R30+VO5Jr69igEGPTJ6FizbJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3332006"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3332006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 17:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6709122"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2024 17:38:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 17:38:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 17:38:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 17:38:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 17:38:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScuYBSBHnryJK21DOaQt1OVyA465Ml/ydA3F8yudSbR+48tg053Ize25xdUIKnwkEVYa0h5BHFl5x55Eut1Kni21YkoVC7LY+OOdqGdIGTUok4WmvzgTe5+IbhTJKUYkceohaxYMGUOGK/o73ofTShcHF1Hsn8PPxfnNT0aaGvW19Q11BV6/D8i+QQjy97mlCKH9+9GASkW1fQZlAq2EqjB/Z0Agxyl7P6GQqebu7Lj8eGch91KIKQOKv4LuANSfqutyIrIP0E3clzK5JwIzzWwTSHIhLW7lw++G8eOmTXiUq3pj//sQd+hL2O0rC8cd39EoaTaJ37MxO5SbJ3MZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GALomHNP91eVdl3yvcutBAI/++aExngeco+QWYGvLb8=;
 b=fS70tHBlAsexdLTuiDedUHrEH4qs3dSaPMYZfoUMl3duWGO24YYIXdIBXmxJGD6FbsZ4OcCVxTPp/U+ouSRTSbrVNMidLmCn2PG5PQzESsUdV0mVg6uLFHUr4yCC9vKklguhupOlGjJFxqe/YyQJr8YEIVh3mT8XFdekZ4yDreXLYpAabRG/ST/O7a9doH3eF+xfxFgj+Hb2sOLfBWUFGH11tsQd3FsK3PmOX7cxAwSGzZnKNfrU/dKuIIF8ibeAJAUrCbUkoWWy8URIQBGJyaDzRfohIufGEYE6RD7zMDfzgJJaqSOd/SRWIwnbjcJsjtOKgFsK4JbjfYOFLHUXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.13; Mon, 26 Feb
 2024 01:38:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 01:38:47 +0000
Message-ID: <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
Date: Mon, 26 Feb 2024 14:38:26 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
To: Haitao Huang <haitao.huang@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
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
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|BN9PR11MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cddcc2-7082-4110-7dc9-08dc366bad20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcQe/jzu1tHSrd5ZgTalkzdHEbC75jlZ10UXlkCBMC4Pdv3Fw5PmwCf3qA1thprXP0YJsnKxNGkUBeKGxziQP3O4CKW4wShKt4sWin4k9mZLH25QorY8KOeb8TjJviIxid+tl5lSsBRqmpENyqA0yLwTDICLxI2rM8VTgDcGRkta7rVOGtwvMS/dcaZoD8WZ5ReIL8MnGMyFcr4lIfn/1+Gt19/pXvPgc5IWXWpoelBkOJhjloA+bwaNiBm3c/E6szgyiF4+t5A6rOHLvUjiKMsaayOIKC+1PJxmhDWHfTz6OeleTagEo+V7uaieyCygvf6lvsOQP+kVi6bTC3Me+ORumwGMXCdGUp1q3D53Y+k25m8+dEDFJZc96L+o785ExIKx8KGnaYoFI0FY4OzhVCZOoc/oGKbi83WzpLjCPvE2EJV/wMGhuyaqJL4JqydldYLOpCaMt1ovSGbTtIY23K/Oh1pgjl+NZt8KUJGJ71RBehp8MfyombE+7SN0PvoG7B5w0HGflLK+DgkoViTOSKZbHZBLWttzkKfAd7HKVz9YuXBey7r0zposKr6EKd3/nSwv5oZsDQuorw3L8JEy5dG+82huie9wuPapw5n3h4vZcQYZ75RZpLbhJz4c0cQlB+ZwXAYtZgTmQ9A4xAljPJrIQrInxVXW7IFQkfRC6HNwrdfFF+JTG2mSltN6DreQG3pO5VJZrreKaQswRV8K3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RrRi9oMml1cFgwRUt5QlZaNDRFWU9HYVdVamxjZnd3TmZqejNWNVZuaGtO?=
 =?utf-8?B?eDZpa0QxZHY1VVU4bDlSaGd5Y01sSFRsaWsvZ29Oa2FDclAxZTRzc0V3TERX?=
 =?utf-8?B?dDNJY2FNUENOeWtTcGdPWUNPdUF1YnV4eFdDVVFPVHJpZ1BiSGplOEp2bWk0?=
 =?utf-8?B?cUh4UWF6bHJ4ZTlCUTRqNzlVUHBza3hVYzRSaHJYMnB2MWNpdyt3UTZZbXUz?=
 =?utf-8?B?eHR2dGtqQU9KRlJHRE9MZFRtVXE0T20rNmxNaHYwOVVsZlM0YUlSNXd0eXl6?=
 =?utf-8?B?ZGk1N1dNZ25rSng0VzlDbWNBRTNrMVdUVWE5TTRhblhPNERweHBIWUhReGRX?=
 =?utf-8?B?SWFhb0ZJVXV1R1JkZVJuZ1h6eVZFZFhhK3lKQyt0ODBLVTZTRnkrK3ZhV0Ew?=
 =?utf-8?B?NWxkd2JqWE4rcVMzdEtaSVUwRzZkYVF6dktyNzNRdVU5c0xldSt4VlVtb0dE?=
 =?utf-8?B?Y0MvTkJNQjg1Z3ExN3dKRU1rN0puSEZSQ0NxZHA3aTNDdVp3L0JEMHZXVUk2?=
 =?utf-8?B?N1VmRlVyTmhkMUFiS1lqaWM0Nk9EV2ZxWDRDdWJvZktWdE9teXdKdTA5TXhX?=
 =?utf-8?B?andDcG1EQkkzdnBuSkhuVzNEdDlCYlVpMHRiaGVUODUzYytPdlpNK2Q2S21y?=
 =?utf-8?B?VTNZakhwWnNLQzNRdnJzdlZXczk5UzZXNmd0OHhORWVPd3M1RzkyMzlhOEFP?=
 =?utf-8?B?eSs4TEJmNGVQVkFBbXFnRld5cFRCeVQwYklhMnM1WlBTK1hRRkljUEwrMlhG?=
 =?utf-8?B?Ti9wNy8weDVBRTNkUWduT1JiclVmQ1lQbHNqa0I1cUFIanJFNmNYWG0xSStk?=
 =?utf-8?B?RkVXRUhHSzRaQ0F2dVdwdEduMkgwRktjMFNFRVl1RmFMV3pBSi9uN09xQW5M?=
 =?utf-8?B?ODR5R216YVp3eC9VczNsM1k4aUZud1BKTDZXbnIrSmsvVEEvV1YwaEZoSG1N?=
 =?utf-8?B?dkt5VGk3MUIwc1JFUVNDZVhCV2VheXdvTlhDQVZxY1hDVnB5NXpsMlJEZTZO?=
 =?utf-8?B?Qm40b2t0Yk9YbTVCb3g0cklEcnpQVEdleGYwV0ZPaHd0YXB3K2drNmxpRHFn?=
 =?utf-8?B?T2g3bExJbjViQkVuNVFUL2JxOGhWYkFPZHdXN3ViZGRkZDZzdnJ2cVViN2ZW?=
 =?utf-8?B?RUtXcDNsRWtaVy9mMHRrL3dIZXpZckdCMXl2QmxGYldUeHRZbnhSWnArNDM0?=
 =?utf-8?B?Z09RTDVLZCtmUnl0T3BmNERROVUwaFdDc2NCYXVFZzBNVkFRdC9jTzl3Mlky?=
 =?utf-8?B?TXFmS0Jna2tXOTVxdTZsL2lBTHgvSVg5bHI2TmM3T3J5WHMwWHlkZiswWnpq?=
 =?utf-8?B?T3hKWXgxR29KdU85TGVMaERSZmNyU3lpRG1SZ1k1N0RqY3VzdnNFNW40dldr?=
 =?utf-8?B?ZUxmUnEwMytRWXdaZG1HUVlybnZNYVBCMElYbitlWGx0SFlhM0MvU1NlaUEr?=
 =?utf-8?B?NEE0QW1tc2VpRzBsd20wTC93NUNsbng5UVVjRnl4cGlsOWQ5bFdaUXE1aWVC?=
 =?utf-8?B?OVdRYXA4blJHbko0Z1FFbXZDUW1jV2UwWkJTelRoWVluQ3I3emhMNVN1YmUx?=
 =?utf-8?B?VGJFN1Q3OS9GMzZQNWRuYUVTQWczamJJZDkvL3ozckd6akdVMFJpWFEwL1dt?=
 =?utf-8?B?VHJWanF1dEcraUV5b3FwbUdYTDFtc3pzTkxGL2ppemNENGIrcUkvckhodzdF?=
 =?utf-8?B?Mm93clZXMUoybXd4Y3BXYTN3TGdydHVFOWs1Z3lZVFk2eTlVL2pDOC85Qm0y?=
 =?utf-8?B?NFV2NWxtU2dtMTV3UDJ3Z1RXc29jbkVqaktKbXcvWnVZM29rdGhNWWg0WWJa?=
 =?utf-8?B?SjFOZnpxRUFMVkswZ0MxZmFIWjdjMnY5OFNaWFBDUFpLek1iV28yeG5FSGw0?=
 =?utf-8?B?eXptR2NqZzdLS0s1RzVNVlVDQnZ2azcrRE15WFpMMmNOMnpoZU96TDArTXRp?=
 =?utf-8?B?blNmSmh6czdXTDJtajE4ekx1azQwL1ZQRTZyT2Q2WDU0UnRXNzFZUnBhQy9r?=
 =?utf-8?B?Y2tJSzdJc1lzUmRyK3VXZUVHR21CMnZmWkRSdUs4REc4NnErYURQQi91cHNM?=
 =?utf-8?B?SWJHbk01Z0JXbG9Pcll5cERTTU9tMGJDWS9XTkJmTlZONGZjUkUzWTNoSVFa?=
 =?utf-8?Q?juG+t3/YpOVvjq7Oe3Aqf6YdL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cddcc2-7082-4110-7dc9-08dc366bad20
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 01:38:47.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6bhsmxRYsZcHHjysOXrsSBmrFlGJODD+H4nsBLlJVRdIrxmExdMR4lAZAGUqpKeNTwbgoSixDidGwujAy1+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com



On 24/02/2024 6:00 am, Haitao Huang wrote:
> On Fri, 23 Feb 2024 04:18:18 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>>> >
>>> Right. When code reaches to here, we already passed reclaim per cgroup.
>>
>> Yes if try_charge() failed we must do pre-cgroup reclaim.
>>
>>> The cgroup may not at or reach limit but system has run out of physical
>>> EPC.
>>>
>>
>> But after try_charge() we can still choose to reclaim from the current 
>> group,
>> but not necessarily have to be global, right?  I am not sure whether I am
>> missing something, but could you elaborate why we should choose to 
>> reclaim from
>> the global?
>>
> 
> Once try_charge is done and returns zero that means the cgroup usage is 
> charged and it's not over usage limit. So you really can't reclaim from 
> that cgroup if allocation failed. The only  thing you can do is to 
> reclaim globally.

Sorry I still cannot establish the logic here.

Let's say the sum of all cgroups are greater than the physical EPC, and 
elclave(s) in each cgroup could potentially fault w/o reaching cgroup's 
limit.

In this case, when enclave(s) in one cgroup faults, why we cannot 
reclaim from the current cgroup, but have to reclaim from global?

Is there any real downside of the former, or you just want to follow the 
reclaim logic w/o cgroup at all?

IIUC, there's at least one advantage of reclaim from the current group, 
that faults of enclave(s) in one group won't impact other enclaves in 
other cgroups.  E.g., in this way other enclaves in other groups may 
never need to trigger faults.

Or perhaps I am missing anything?

