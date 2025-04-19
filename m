Return-Path: <cgroups+bounces-7659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27520A9430F
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6420D7AADCE
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4C1D63C7;
	Sat, 19 Apr 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ydhj7kyw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799131D5141;
	Sat, 19 Apr 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061448; cv=fail; b=hkC6K+R9cL4iL9nHPEY/vihbIF1cs6epEOOcGwTMmLehEXqbJap+eTuCmErcJpcNA06haivcBlPQTw/ksKp7+HVDEwkg8GlhJ/AB265FlGompcwjdV3vm+RpbbFq5EjQXxFGvDVpaLKagX00kzM/Gl8HmbXYMC1VMPu155Ydml0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061448; c=relaxed/simple;
	bh=/y/srrGnTZhZ4t+KR7J028oRa8YxVCC5PJnQ5KMjx3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFi3yLgChEkvZfrUUCfLY9QrPK+Z/5CujbiYHbvNFEVm56rCMKa3HMmHLqhQZzZm7rnMXNLRlp9qGekmLG1+eIiOK2Fq9j7hII78wLZXvMh2Wx9mMRBTsvdQk2xRPhzcpPC0HXhlJhviuKVBnoLYAug3eIrANdfB5+8akmvHd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ydhj7kyw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745061446; x=1776597446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/y/srrGnTZhZ4t+KR7J028oRa8YxVCC5PJnQ5KMjx3s=;
  b=Ydhj7kywl+pDU32CtO80AAoVDNlK9VMlP2CfNSDVpQAM+32g/9OkR4xw
   5IF5K+u9J5HNqunrAzPZBXVOK0kKB91TY+LUtTOSFDjlrZ2Q9J4mehrqe
   Aahs3uN8nbWknzCFz/O1+F9K3tVvqcBmrWdQWgVMSymIfol6IZJffl5vF
   pBrfRZL26bKbnYlVN+KE2uuDpznt/LadkbFlGSOwuN52Vf24Ick5hrCVL
   gjAI4TVuQdQfh4M++hCz1l+7rzbqEYDcnh07tl2PP/eIXZJRmXolhM9Er
   PtlCGCX68sbNL18fc4dm1p/ZZDN9ZRf2hmKGQrj6aI1CY4dkQXWg7ED33
   w==;
X-CSE-ConnectionGUID: HD9FFng6QEy2WsJZd6Wh2A==
X-CSE-MsgGUID: q45mEKlaQO69LmLshPbBEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46680074"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="46680074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 04:17:26 -0700
X-CSE-ConnectionGUID: Sm/bZabAT5iTwgaFnPqM4A==
X-CSE-MsgGUID: XoGEF9R+Qv655hcoMEkcrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="136418390"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 04:17:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 19 Apr 2025 04:17:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 19 Apr 2025 04:17:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 19 Apr 2025 04:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHGERvZOPXxZsFWyb1ksQpZcF4qTC47gcpsysOA+Pa/4xwQCXCEcT3D7IlShE/Io7J2HyVNuM0E3yEAVVj+j/+87j08+3XoyiknL01GapD7O3U5tshHnoU8BadhtKR+nOgIs3L+x7tzQdvTHUB/wFznRw9NBAUVD4pCUlvARRiWllnJeXEkBO99DRFEhTXEMQ+dm+d2Tv1D+tppEHkrATrGJy2lMk10JGrvxLIuhjVZyeDvpVO4QB2G7QT9SF1M/y0YxN3iLfDtCf+RNBTH6oajfKSUWdyGhkVJrhZ5+JC9yFqmkHdShR3Myb+yayx6IGO2m6vVf1iAOtJkawRewBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/L4eit8JcrGWgXu5AjFeO38Wx5pkVXYqxC9GXLBuBY=;
 b=dRxjFtSia5ujKCvBeP4cBsPvA1QIW49VzKajs513uXDLhlEd4Dn2ypbloTJrT5hfX2mPsPKx/i17iEobtQk/wH8zqnWyqjKCBQ8/NqZoEwvxfgBMPB9Vuf89w32HxGgRS5iujZw66VTxCCDl1t+zElhgSGkDASy11Q2CaHO0cZMZQVDYLjm6FlrT4F8AbllRMRi+d7Q+K5fxbDU9xwgflDb5aG3sVjq7kjPRpXi0FR/+ji2whhfNmDHtefHQCMFzNWAEioCHaLRO59p240frULl/YaHKqI5ChWCzG7R2S2LIKjKmqYnbjvdTBYveXdggf3q7UIAB4QD50lKzWM6DyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.45; Sat, 19 Apr
 2025 11:16:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8632.030; Sat, 19 Apr 2025
 11:16:50 +0000
Message-ID: <244cb537-7d43-4795-9cb6-fc10234c68a1@intel.com>
Date: Sat, 19 Apr 2025 19:16:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: Libo Chen <libo.chen@oracle.com>
CC: <kprateek.nayak@amd.com>, <raghavendra.kt@amd.com>,
	<tim.c.chen@intel.com>, <vineethr@linux.ibm.com>, <chris.hyser@oracle.com>,
	<daniel.m.jordan@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<mkoutny@suse.com>, <Dhaval.Giani@amd.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <mgorman@suse.de>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <llong@redhat.com>,
	<akpm@linux-foundation.org>, <tj@kernel.org>, <juri.lelli@redhat.com>,
	<peterz@infradead.org>, <yu.chen.surf@foxmail.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-2-libo.chen@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250417191543.1781862-2-libo.chen@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: a9776988-2bb4-41b7-c3d3-08dd7f33ae74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjB3U1hlUTNNcjVKaTB5cnBaU3RSaVRsSnhqUUFOZDZ6NC95bzl2SmRCWk5F?=
 =?utf-8?B?OThkZDBIS1UyYlpCOGNobVYzMXVEOElJS0JmQXNNa2FMeU0vQUU2T2dFTnBE?=
 =?utf-8?B?bng3bm1QdkowK1RxaEovalJtV2pFci9yRVBGREVuSFl6UjdmMEJzd0Q0MmRW?=
 =?utf-8?B?NVgyRWdxUW9jeUp2M25QdWpvc3B2QkRiU0NFdmE5ZEo5QTJva1RxVytoWENp?=
 =?utf-8?B?bzlZS2VqOVhoTVgwS2JkU2FZZmEwV3Z3SmFIL3BXbnhrSGg3Qlp6WFdvbkhh?=
 =?utf-8?B?L2VqczJSUnVYdVp2a2xuN1lFbzZTak50VmViSDdkRTE1ak1ydHExR2NTakVi?=
 =?utf-8?B?cmMxQ1JVS1hETDV5TC9Cc2l6WGtRd2tTWkFkZHlzQUtnTTB6OWtJUy9TS2NZ?=
 =?utf-8?B?aDc5TzR0U2RTREV1Qzd5bnZQeGo3YTBrZ3oyd29GeUFUOWlnaVpHbGJ6ZGZE?=
 =?utf-8?B?VndTUEFtNUNrWkY4N3ZoQXhjdjNkQ3VWQ1lnMkNmRGNrWEFRZE1uMnJDbTkw?=
 =?utf-8?B?RjY5YndrVUtjQngweHhsK3lMRFJiMkxBTzZxTkZaN0hSakxLaklxTXhod2RN?=
 =?utf-8?B?YWRzNnJQOE1yWnJyM2dnSC9ra1U3ZnViVnhhMG5Dc2Q1TkI3QXRZV3hpTitO?=
 =?utf-8?B?T25GTXBXdjVFNitoaXVydnY5d29jRXlCY2JYejJ4ams3MEgzcUNiQk5vK0wv?=
 =?utf-8?B?SFVCOENHVFpNYU1IVzdhQXZiUC9tYUMzbWVVZkdFS05yc1VsaHBBQ1JWRXdZ?=
 =?utf-8?B?ZC9qcWR5QlN1bzRxVGdUdEl0MGxGSmRIWG1ickVEeUo3Nkl0U1Y1WTJJOVJy?=
 =?utf-8?B?TWswQTNESDJua3YyQWtFMUtIL3lydkNyNWxYcUo5Tit0RGU0OFJIWmxncEZy?=
 =?utf-8?B?RUhvYjdEdmJReUg3cXhCSkgxdjNUL0RMWkVpbjU3YUV5aGRqanZudlJVbENZ?=
 =?utf-8?B?RmRoWjkySnlkb2cvRitTNzlaNWFBZHhwM1VyTGZuOWxiSWwrR1Rhc2JjcTF5?=
 =?utf-8?B?QklaYUJBdExEanJGZjJBSktJbXFQS2VWUWhlKzZJKzJpeXZjcmg5bWV0SlM0?=
 =?utf-8?B?Ynh1bDFPZ29GWExGWUF4UDc5N2hyVTRGdzQwK2lFL0RWWTFndTUzdnB5anJ3?=
 =?utf-8?B?OFFjVG9NalVCM1h1NHlaejR4STFCbnhQRVEvd1ZLdmYzK0tjeVgyYzgzTWNl?=
 =?utf-8?B?VXh3TVYvN2E4L0lFVm00S0dQRWZjeHBDREYxaTM4d2ZLc1BWaG9td2M2L2JE?=
 =?utf-8?B?d0tQTmFEdUo5ZEtvclRaMUtuc0ZZbk1rYUEvQUlTOWkzcXFkKzEzWFRqaXc2?=
 =?utf-8?B?b3J4NXQwMlNuK21oMXBJc2JpbU11SFovVkxyalRCWjdnNmNkaWViWllzRDAw?=
 =?utf-8?B?MmUzQkI5TWVNQWFLTU1kM3RlZWIzUFhUWjZ5cXRtRXd3RFBYK3VhNHZkMUhZ?=
 =?utf-8?B?VjYraHhrVTJodkdBRWJIVmdHWkJPZjRHaHA0dlY2QjlJMkRLWXJQZUR6WUZU?=
 =?utf-8?B?U3hHdWxnNWhnOG1CMlI4amF1dHduL2lZUmtjMS9CZUU1Zm1rRmFsaFNyTkZx?=
 =?utf-8?B?L3ZmcmI1SVNhenRQQnFCQ0EzTGxOMWdhK0FjTVdZcE5FbDZhQmtCd1BOTmFp?=
 =?utf-8?B?SG5nZWVkTGMyUFFhSFY4UHBuVnRRYlJKbW1TcnBPSnBMS0kyTFEvZzgrMnN5?=
 =?utf-8?B?eERUOEl6Zk9DM0p6MUxSMVF0c2k3TE1xY3JPam43cGpMeG1wR3NwcG9qS3FZ?=
 =?utf-8?B?Kzc0WDNZZS9uK1pZKzBSWXo2WGRsTGVTMnJZVzhhZmIxYXJkOXpkU0V4cGpN?=
 =?utf-8?B?empsVnFVcjZKelltelZoWWRaOUM0SHdMVTdPelBDcFg3WGhjNjRtd3dtekNZ?=
 =?utf-8?B?ekRPWTkyK3hNczh5Q1drekxoZVRuY0MvaC9VaDNISXZ2N1B2dWl6U2pHQ0cy?=
 =?utf-8?Q?vSkLZWUYijU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThoU2RYcFVVdWxqdXJRNkZ2S3JrZy9ZSVExL0VhNW14NnJDcDVqcXR1OGZW?=
 =?utf-8?B?Nmw3YWVTWTVabFNVLyt3MmZBRnhYWWV5dXUwTVJHSkkzd093dVBvOGdXT0ov?=
 =?utf-8?B?SkYwSVhCL2RUWUNodlhCRUw5QjVIdGd2VnRMMktIZGtDUjJnSnFsTGRQV1g0?=
 =?utf-8?B?TkNKcG9NdGc1LzIvN3NMcjdSYVJhMFdhSWt1R0M3SlBya0JmV1FGcHJha1N3?=
 =?utf-8?B?K2w4RzlzUEMwbWUyTHQ0RGVOTXRHcU1qN3RVSXdWcEUrbmt0S2JCd1FBUHZP?=
 =?utf-8?B?MFVKYjJDMXd5bUI2Q1UyVWhRanNNaWY2azFiZWxZazFvTmdkUVJOejN0OFpr?=
 =?utf-8?B?L1QxZksxZTNjK2dZK2lJaHhZaWVNZTR2eGpwYWs5cWllQUhBQys0TDJRU0RW?=
 =?utf-8?B?UWJ6WW5tdUp6djhIZEFndUFReW44cmdVaUlzNU1FUUE0ZmpZR21RZTJSQmx3?=
 =?utf-8?B?OXZRRmFEbGUrcjgzZDJEckZnMGVzWmltR1FPejdYa2ZTQnVPYm02TVVpK0ty?=
 =?utf-8?B?WktPRnQzZ0dnaHZKakI0VVluSjVRWFViNVNRN3lyN3ExODVCNFMzVm0wU0F0?=
 =?utf-8?B?cEswb1BTRkhOWHNVWlF3amhKUTZUenRWWm5zdlRlSS8vc0FPSGVhZ0grMlMx?=
 =?utf-8?B?VWo0RDlLeFQyRGNVZXlRUnZ6TSttd0xEOUVyejBldUwxMHBYdFd0ZFU0SWh2?=
 =?utf-8?B?WGcxd3VGcUN4eGo4QndpQlFVYlNTMnBGOG1tTm01VkxoeEcwWE41TURSeXU0?=
 =?utf-8?B?WktXRWNJQldld1ZLQUNmRlF0b1FiUWQ1TEJ2Mm9UVGR6ZFgyU0lNdWdmRnk0?=
 =?utf-8?B?MUx4ZlBwZ1c2bmtpRnE2KzdxVGF5eS8yOFlRcWR0NnAramM1SXB0VFdIUmR6?=
 =?utf-8?B?eHJlQnB5OUhyYWh6NzZNL0FjMWR4ZTZXMWhhS0s5MjJWczYxOUlkSWxCMmZ6?=
 =?utf-8?B?TE52SkRaeUpPUktZMzkyVWJsUUhyYkZXdVp6azdKZzQ4SmZkYzBCSmt4a21J?=
 =?utf-8?B?c0ZtRVB3UGJWcTVlcE1JdWo4MFpad05nZjFOclBGZmloS3c4WXk0eVhiWlU5?=
 =?utf-8?B?aVAwR0V1M09NUTJsdU9SdTA3ZjRPMWFXOUVHdUJQNFlHWFVsNmpmaVJRclNF?=
 =?utf-8?B?WHVHVzR2NVYzN3lvRFVmUlRERWlsQUYvcVltaUFKSkJ3SWdRQmJMUDRQbW1H?=
 =?utf-8?B?N1E2T0pLMjRjUzZ5bS8vS2hJNktqYTgvVDQrbHFJaU9RUFUwYnRrOGVVcVpN?=
 =?utf-8?B?YjhZS3o5WEhhWm9ZVElodnVjeVVSVzdZYmVCSi9xQWVLbnQzMHpOaG5icW4r?=
 =?utf-8?B?dmVDUEtJQWtoTmhiRERXdVNIZ2FKNEl6WHZ1aDc3b0FLSGhzVXRmakxFTVBW?=
 =?utf-8?B?V3pwUHR4R2VldGJya3IvZ2N4MnI0WXRXeEZCT1Y2VGpnaitOSXltNGlYN2Nj?=
 =?utf-8?B?RlB1MHlUVW9KUktDT2w5Z3R4dmNnRmFzTGJSYnU1V1pDR1NXSzF0WlVldldo?=
 =?utf-8?B?T1dXTlE5Yk5uUkQwYXBIRWN2Mk5QMFBVVUdCMlJOVVNqeWdEUkkvNjRZUmJE?=
 =?utf-8?B?NkhyY0FUQ2R2UnNHaGN5ZjB1U2FnUXJ3WjE2VUdJREhJb1VEaldhVFlTSXV1?=
 =?utf-8?B?QUtyZmFDbDlJQi96RFFaR2V4cUxESGM2UjQxcHJ0ME1NU3JXanlEN3p5Sjlq?=
 =?utf-8?B?OGNRZzNUSHRHSXZxVXBSeGxJdW9Da0NIR3JIMlNpT01XVmZOOXR1c2VZRkFQ?=
 =?utf-8?B?ZlIvcWRIdFp3b2NVU1RkcjUxWWo3YnBhd2JHWHZGTTBlSjNRS09FRkFzNEEw?=
 =?utf-8?B?QnBmS2h0Q1lYVjluR05XSTRSTndxdGtldmtFenRqSVUza3NCbFcvT2xIb1R4?=
 =?utf-8?B?djJ2SHhBR1BzM2VMVVRnOHZSbUhTVE03SEZOYU14R0VzeGxGUGloNlRaQ1lt?=
 =?utf-8?B?VVB2T012U1JwYk1MY2p4Y3JWZU1JQjBqUmQ2UElmdnlvZngzK1JjM1lPbU1X?=
 =?utf-8?B?cjNRbHlIMHZwZEVDbHJmbjNXNHRLUWlaazE1OElpb3FVQkZER0MxYThFZkNE?=
 =?utf-8?B?UFViK0ViZGFNbVhDVk9lV0dsN090NVJUL0xucnQxUCtwQ0lhWlNib0FRb0o0?=
 =?utf-8?Q?tIPMVM32aLqk6zNuoDgy3Xq9f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9776988-2bb4-41b7-c3d3-08dd7f33ae74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 11:16:50.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtucDtfQwVDV2zTPcUHqcNv77kp6V3zXBt9xrJxkXLyr0qttZVZ7W13L013H9ubz+MC4tctsJrcAHMDqQC0znw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com

Hi Libo,

On 4/18/2025 3:15 AM, Libo Chen wrote:
> When the memory of the current task is pinned to one NUMA node by cgroup,
> there is no point in continuing the rest of VMA scanning and hinting page
> faults as they will just be overhead. With this change, there will be no
> more unnecessary PTE updates or page faults in this scenario.
> 
> We have seen up to a 6x improvement on a typical java workload running on
> VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
> AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
> platform, we have seen 20% improvment in a microbench that creates a
> 30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
> pages in a fixed number of loops.
> 
> Signed-off-by: Libo Chen <libo.chen@oracle.com>

I think this is a promising change that we can perform fine-grain NUMA
balance control on a per-cgroup basis rather than system-wide NUMA
balance for every task, which is costly.

> ---
>   kernel/sched/fair.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e43993a4e5807..c9903b1b39487 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3329,6 +3329,13 @@ static void task_numa_work(struct callback_head *work)
>   	if (p->flags & PF_EXITING)
>   		return;
>   
> +	/*
> +	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
> +	 * no page can be migrated.
> +	 */
> +	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1)
> +		return;
> +

I found that you had a proposal in V1 to address Peter's concern[1]:
Allow the task to be migrated to its preferred Node, even if the task's
memory policy is restricted to 1 Node. In your previous proposal, only 
if the task's cpumask is bound to the same Node as its memory policy 
node, the NUMA balance scanning is skipped, because a cgroup usually 
binds its tasks and memory allocation policy to the same node. Not sure 
if that could be turned into:

If the task's memory policy node's CPU mask is a subset of the task's 
cpumask, the NUMA balance scan is allowed.

For example,
Suppose p's memory is only allocated on node0, which contains CPU2, CPU3.
1. If p's CPU affinity is CPU0, CPU1, there is no need to do NUMA 
balancing scanning, because CPU0,1 are not in p's legitimate cpumask.
2. If p's CPU affinity is CPU3, there is no need to do NUMA balancing 
scanning. p is already on its preferred node.
3. But if p's CPU affinity is CPU2, CPU3, CPU6, the NUMA balancing scan 
should be allowed. Because it is possible to migrate p from CPU6 to 
either CPU2 or CPU3.

What I'm thinking of is something as follows(untested):
if (cpusets_enabled() &&
     nodes_weight(cpuset_current_mems_allowed) == 1 &&
     !cpumask_subset(cpumask_of_node(cpuset_current_mems_allowed),
		    p->cpus_ptr))
	return;


I tested your patch on top of the latest sched/core,
binding task CPU affinity to Node1 and memory allocation node on
Node1:
echo "8-15" > /sys/fs/cgroup/mytest/cpuset.cpus
echo "1" > /sys/fs/cgroup/mytest/cpuset.mems
cgexec -g cpuset:mytest ./run-mmtests.sh --no-monitor --config 
config-numa skip_scan

And it works as expected:
# bpftrace numa_trace.bt

@sched_skip_cpuset_numa: 133


thanks,
Chenyu

[1] 
https://lore.kernel.org/lkml/cde7af54-5481-499e-8a42-0111f555f2b1@oracle.com/


>   	if (!mm->numa_next_scan) {
>   		mm->numa_next_scan = now +
>   			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);

