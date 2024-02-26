Return-Path: <cgroups+bounces-1866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5358683DF
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B471F2538E
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94AE13540F;
	Mon, 26 Feb 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgiFomFs"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7F1350E4;
	Mon, 26 Feb 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987143; cv=fail; b=JA2esL4z6VG65S/+it3cWDz051R60vjanr7MCdz7ST4s/tf6sqXFudbUnDut2vFz3Cn9qEsHLsCx0PLGTOHtwN58/ygJDenPLwCy9UJOHZdKOmShGRhPt7q/uNoqeB+voe8X84rFYryfj5IVJoVHsiiAZZ6X3zwrfiDO1X/2YSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987143; c=relaxed/simple;
	bh=PGEeG+NpdcUI3yXA0bZoSQlmqz19fYOONAsK1YxpmmQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M01/VraKUMh+HkMyLebUzXBhh3rwHWENWlbg4yx7gRKpU+YelkuR3w4n45VSBhVabdICifWtLNgzLfaRoTbso3RQDZ/UoljzUGMd9DcydUTlq7QESfqRkaNHaklhk5bu+TKcw4LIGy/pJ5zcTO6nrV01c5eLCHogw3K6JaaFIBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgiFomFs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708987142; x=1740523142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PGEeG+NpdcUI3yXA0bZoSQlmqz19fYOONAsK1YxpmmQ=;
  b=jgiFomFs+c83I1mUvThUYuZLnIp9NxHZ1xrM/BhkVS3nNDBuXW4dvWfw
   H4gSth5/qY6ofX1Uhkd5FbZ/M9VsYq3no2tDZjdsBSn35ZYp4jUqWVrLZ
   roMO5yHnnue2IBpXLe8TdsvDcmTvgq2ou9VM3P/Ns2hHaJEUznLNvI+fK
   y7I5VRlqnaOQ4DC/HyI9HuNz7gp7Vo7OUzCzmgXmtZJD4R+DNCUFSPlUL
   IktQcGemRpCAbmXelVqga7aP18TO12WGpyvJi8FUer9LmG8oV+jh5/nAW
   UHSr6dzAmXU/rgLxa8LelAO4UoNUMd1AY/0AgbG8GCaXhFpgUIBBiUijo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3432701"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3432701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11493756"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 14:39:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:39:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 14:39:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 14:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK6HNZsvYax+zFJIG+UFQfD0j6SGkKIqLJ2mINFYGNcxO9pqCQCO6WpqCjvHdpmHdaK1qMBt+bH8Jnb6XUzyOeAiOhWouj89vEi/rAYGcrRJ1ZBGxjImbYnyQBodfpry5l8lnhjnmepuw0C56GWRCeyV/PWVIuGHX58tDMh3R1DtE0nrp/55BRAlE5OLmQ69nJLqzHQCO4AX3TyNRsgVX5Am/bVvbjUmGgEbqi1EpAX7RE8kheEd6/VnnWYpMKhqajM/XiOr5LjCkhNT3HWg+oxlEWPshVisQBErMZkIPPYMJ02d4nqM+Lom4chqLYLPk7cOhhRwcLkDpzWXWsYmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnC6iHUOD58vjdcSCDSM3JbiCUN6BkY7TPrjSqvwQ6E=;
 b=R/lVuPZEk3kkxftYZjK6wd9XZOJhLSiv6KPVF2ffOZfYueEDQ5sPsgnDV98gTL6CXnp9b1xr83yhHOSN1sIK2Mmo2N0N7KrVHEwyeuzwS9V5skUE5mMieX3+3fx/e7c8V2edVwf2uNrVBzpx+WrhLQkPwYCK7glaiUH8Vo/l+wRpyMZrGA3SiSNTIx2l5ZHMjjuGED8zsVXJRg1RqezIGQIVPqFi0fnuqLItsjVudMhUSnKrf2cR8Ub2CKQxpzhu5RC3lElzBaOeP2PYHtJlfOHhK+pluAAmQcRgwiA+LwKCJ0jaV08t7d8BykXOsV1oCQXNP0091bA9knaGarBrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Mon, 26 Feb
 2024 22:38:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 22:38:58 +0000
Message-ID: <420b53a7-90fd-48fb-9f08-d28fc936e0f8@intel.com>
Date: Tue, 27 Feb 2024 11:38:44 +1300
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
 <op.2jrpgcufwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <010f5c8e-6e63-4b37-82d7-ba755f989755@intel.com>
 <a2d633da-6ab8-49d0-bca5-1e9eb7c3fc9a@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <a2d633da-6ab8-49d0-bca5-1e9eb7c3fc9a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b8f212-dd9f-4e37-cbdd-08dc371bb86f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uFl1yy4x607kWrsiaGTORCEj8WUUQ9gZCO37b34vlPl/DvKywohS086X+XVKziakQq3tX+NyhAt7VgcDFP+5S7CoeLPIegopPHKYj7YhEqVIxOO4aY2HqLlYrLIXKFwGFKPl3MBoRAeYEEgGvR5iQam4/SZNwCXZV7Phm3EXFWZYxQiz8ZOnMhsmr/ZZ9Y/FEWre0gD+d4FmkLEEuDTpCbRmBWWGvZzqceZb6oeRsXN/GtQV6r5K3ele766VouLJQ+SQJopaJWgeOHFxZLvHDkFEurA9XZ4Sm6RQJfIYSh4VXnmYXboTqWuMHt2iNc2IputZ1HIG1Yn1nY1ueEb7WlsN5WGg0I5X318cGVjTe+ftHND4MLuEP85Puvs7QBtbMRNI7t1Rv5ubKoxxx5cCzgSk0QzDGbpUI1dRo4uoczxSNdX+bD4Mn4OF+rXgRID/cEaVuoVZlHyZGjpnOScH0WkF+PqkZWkkx9BtEke0l7c0bBbsW7Oeee3+47lkZGiGbOKy740s4jeJWoyTQggpfsVvRzI4XeLyxdav7zT9bI3tTCNA61vr5LAWmr2k8RYozFjAD/YmUlwNndFgjLFivkVWgqRnrW84pdpJw1mH7CnKQipo9bgkJHvdXW7ob43Dvmfr6IJ50MZyPdQ+gS0z840mwlq+j4dQJ6IdmGzmrVtm7zrvC3h4ErekcJIa+IGcApd2mAU0sRNRy0T6V+6xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRiMnhkbk9CMVo4bS9JNGQwK2lodXFTaHVFOGdHYWovZEhGTitOeStzTXdE?=
 =?utf-8?B?L1QzYkxNY2lEZnMyQmpNY3djcTE2amdrdnBaWVJYMHpKTVRkcGxXUm4vdmpx?=
 =?utf-8?B?aWdTU3NFVmR2R1FReVlVUW44bUlnOXExZ1VWQWs3SXpDM05ZNzZ3bkRiY3lX?=
 =?utf-8?B?Sk1QM2J4NGRZZFFPbzJsbVBkeTQ1bmQ2Zko4dXRhblRjVUE5Q01KUE43UzV1?=
 =?utf-8?B?VCt1YUlpdVRBZ3BDeDJoZThaeFk0RUxDQW9DR0JtY3lmcGhyRFpTMjA0UENX?=
 =?utf-8?B?QkN4dmdlV2c0VHBLeHVsWjJLditVbndvT1p5Z0p0YXZmWHlvWjBqMWU2MnFV?=
 =?utf-8?B?b0FNanN2ejJzZXdUS2JINGc0QWlYLzFCcGZjM05tMlc0NnFZOXJ1SFNuVWNa?=
 =?utf-8?B?UUJ6OXM0MnFDN2lFSjlodEcrVjgwaFlZdngyeWRyUEZrTXVmL1RzUGIrVm40?=
 =?utf-8?B?M1NxaC96NS8vVDJsRXR2NlE3Q1dVUnBKM0lUeHpXa294S1pFWER4UXA0Y0Fj?=
 =?utf-8?B?aGpzU2ZBZjg2TEo0MFlQRllVR2tscXNVSkgwRnJrdnh3WFlPcGdKVk1XZ09G?=
 =?utf-8?B?a0Vkc2JBUU1HcSsrYUVEUkFja205bDRXR1BialF6Y212TVV6Y1FRajMvMnlm?=
 =?utf-8?B?Smg4aytzVVNNV3poSnEzcS82UXcxU2Fnb0prK3BBVW1LWHd4S3MyTTkwRlFS?=
 =?utf-8?B?QVlLWW9nN0dTbTVLZ2ZSV09qQ3VHZzMvQnhwc0dpWDk4eUd2UTAzZmI3WmE4?=
 =?utf-8?B?UW9sWlVLTU41aGczVFo4dlppSDc2REwxQUhETVZrb2JpUU1GSHJ6dTVwSytx?=
 =?utf-8?B?NGZEc0pkVCtmUEpwUFMzNzE2OXUwdHdYd1VTd2FiOUFlcURvSDJ0YWtMUXlM?=
 =?utf-8?B?cnArb1FubEErcVY4bTFVRm9HWmJrSlI2VlNMTkJzdWgxZnJJVE1oaUFtNWlC?=
 =?utf-8?B?UTcxQk9NcFROZG94di95ZzM5SDVjdUY5SjVrMUhhM3g0THpNd3VIV29McTI2?=
 =?utf-8?B?RWxwK2psREg4QnU4WXlBT1RLc2NxOEFscUN0dzErQ0t0OW8yS0RGNFpSQkdz?=
 =?utf-8?B?RDNVRVhrb1Y4YVlHTndJT1locDVPL2xFbzExZlhDdVU0aTZhVHhrS0JiZm1Q?=
 =?utf-8?B?RXA1cXNDeEJyd0gzQk0rcWFjakxaOUpCanhBRVBIVW83dXNBcDhEdHltZVlj?=
 =?utf-8?B?K2gzTUtQdGpuYUZKblNTbERITCtGSzMyTEdwbEhZT1k4Mjh6eUhRQmw5ZkIv?=
 =?utf-8?B?eFd2REVlN3Uya2MzNmxVdzY0bUhxWDBla1RoSHJab3VFdG41SnFsTG1DZUNi?=
 =?utf-8?B?UWJPT1BwOXFKczZXL2ladTZSbHA3QlZwNEM3Yi9iNjIrRG80cms4RTlCTnFs?=
 =?utf-8?B?YVNvV3V2dXRoOXl1azNYR1ZFREQxOU1vN2puOVFRZWlGV0dRY1BORFQ5cEs5?=
 =?utf-8?B?M1RvRlZ0VFJDNkFhN3MwNmdWRHUrNFV6bkxwZmpCRzMzQkVTalBHN1l2S0JE?=
 =?utf-8?B?VEJlR1VyVlVBdFpDdUlrNDN4ajNIZWJVOUwrY3o4eDQ5TThyWk1qQWRoanhk?=
 =?utf-8?B?ZVhDS0Y2VWJIT044aEpiaXBGZk4yVXR2RW1OdHc1Q2FiRHhBUWtSYkpBVGNy?=
 =?utf-8?B?Ky9RTFZVVGFzdUE3UFBaU0hYM0UrZU5yNlFzYWI5TG5Rc3JZUTFES0pXUllj?=
 =?utf-8?B?OXc2RThJUVdIbVNkaGdWTjdqZkJwK0ZlQlJiZUlEZ3hWQXRvVXU4Qk9pVkJ2?=
 =?utf-8?B?a3dVQUhsYzJXY3N2NXcyTG4yWG1zK1VwUnJwMllnODdSSVg4dnNlVTQ4bXNa?=
 =?utf-8?B?ZFpHQUtyd2Y4UzF4d1N2b3FZQlFGN29LdlJ0eEhJRHI5U1R3dGZlSFJKNCs2?=
 =?utf-8?B?SGlhWXBmNUhEMWVQVm02dkN6dlVXRml5S01wOUZzV3FGTmVkbUFReVVGNkNM?=
 =?utf-8?B?N3JTbzdjWk1oMGkyWHNPK1FnbUdTaGJmaFJxTTgrMEkyM3hERUZRdFhXaHBE?=
 =?utf-8?B?L2tCamVSVWVMMmc1VVpwUCtzM0hqMXNIYUErYWV1dGUyQWMyMm10OEs1WmVB?=
 =?utf-8?B?cUNCQWQ2M3BPTDUxWi9QQ0ZDL0dSOE04cVRNa3Y1MHM3SWY1RjBUbGU3Nmpa?=
 =?utf-8?Q?SLore3OMv2Fn0qtDqEml0yM+v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b8f212-dd9f-4e37-cbdd-08dc371bb86f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:38:57.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pedJp9OPuyyusjGwhf1ZPZSfF226uI0wxGyftOtcxHqCmoCXeJDpoQpLuX3DPLfuluP/BxifimmFYMKWBvB5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com



On 27/02/2024 11:31 am, Dave Hansen wrote:
> On 2/26/24 14:24, Huang, Kai wrote:
>> What is the downside of doing per-group reclaim when try_charge()
>> succeeds for the enclave but failed to allocate EPC page?
>>
>> Could you give an complete answer why you choose to use global reclaim
>> for the above case?
> 
> There are literally two different limits at play.  There's the limit
> that the cgroup imposes and then the actual physical limit.
> 
> Hitting the cgroup limit induces cgroup reclaim.
> 
> Hitting the physical limit induces global reclaim.
> 
> Maybe I'm just being dense, but I fail to understand why you would want
> to entangle those two different concepts more than absolutely necessary.

OK.  Yes I agree doing per-cgroup reclaim when hitting physical limit 
would bring another layer of consideration of when to do global reclaim, 
which is not necessary now.

