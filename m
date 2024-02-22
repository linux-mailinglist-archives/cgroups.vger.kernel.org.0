Return-Path: <cgroups+bounces-1817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B935786059A
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 23:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B2BB236D1
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 22:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20712D21F;
	Thu, 22 Feb 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOjkahQV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8932C84;
	Thu, 22 Feb 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640710; cv=fail; b=TCGDwO5KYdb+YGyQoUhXzSlz1+qbTOeuIxxVZ/kLZZoj52mvb4at7Mk5sLIKTQ9qd3Cp/fchxH40b/Kf14VKR3przqv8c02m/2TTzi3vKEVylDY/TVNwO0X7DMqL7YRXhio4lJL5aw8cCTtnSj/gLiGeGiuA8WkzCDOXbl3+CZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640710; c=relaxed/simple;
	bh=LYsqsyWwYB90zTGGa0PT1jsiLncFVhXNAZtQ68jFrSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqpmIf5lW8EuHICtVi4xsqpy05m3oo6TkEfw5lYkjCW97fVRbI3HlelAmzlnxMmcz6VBri88/F+dnu9RydjyPO0CXJ31bp7umlZMtXf7nzn70zqe/F/3S13YsrZMmN1N8/YALJfJHagOA5cIqrwgeGCP05N9lUvUtTQpDshiJgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOjkahQV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708640709; x=1740176709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LYsqsyWwYB90zTGGa0PT1jsiLncFVhXNAZtQ68jFrSU=;
  b=GOjkahQVT2diwQnHNpiuOw3619KF9EWtCKTibS3xKaUadPtgqE9QNltk
   rXues+uj3xBceEcf2RnaE4uzCBIVZeHanTeqQxKyul11I029rhGiHcTlK
   +q/DeWgpgCp3i7uGAqI29qzXDaCz/Jdu0ZaAYBCL5/FnvkvKLdCHrVlk1
   lfZpXkftFLVgvwDCR6bximzcSTYSA6w1LjEi6gKta/um0NGyvI2n4aKvy
   DerEbknhL00uTzzwish/abkU7dcfLmX4zJbC6qxruFxbjcFal+nocKr+G
   DprrxxHWEoxTi/ry7yQLsrZyRupcOqFdacT6oiQeMyqiOlDeFt6ATBvLb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14040382"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14040382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36451914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 14:25:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:25:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:25:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 14:25:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 14:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZYjxyIcVh8Xz5x60y4CzZdkywFzO4wuQtlin8+y/Y6p8FZ8cZ8JxL0AYdlTRTEMZzi6CQL6xx75ezdTlKof2Rzrs1ceDi6j8sa7783xSB2yLjyOKf02AfS/VGl0+9qYnWfBSYsazEWudeXQHw73Y2hMZqhaE+3Udnck7n2Z8ZLtc2LfT06Qrhlpww0MyAriHu1JGwcJbJH7vGJoUuT7DFWEPnVWTkJsliWbmEi8OtTm4PfhS+jiyk90cNphhDMwx+6PsohnnkTqP+ZAa7odmEqvL5P4b88q9wdmj3VnFYCvURc3JLim1IevUYTNrZMD+2GVdjq5yz01XW4GeDVRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsDCFnQatGsnDCtDrlIOWJ9v7e+KSJOCKPu1BAsLCXU=;
 b=X7oYkjVuish2PdBxSnWt94phld8DV4OHZ18TuQIyjkroLHXrGhN8Hcl3yi5yuW++By2TlNOKJ/iCwZvfmoKWsp7oY/d2f2JjAQ+c8Xx2eoM1kuILLPlTwDp8WfHfpCcZ4odOZJ5tUlI9373sXYLhjMyjpb1xkWzgQMt9nEhK56vH7mBRZdYu/ysPfoyh27J//oAyu2NmoWM27v2tw9Sx86xUw5uKlQSc3I+9HmJJuphV17sbCYn5ptZvis/QI110u81MLHPvTcJCksm2IcJ7TNpC/BaDq4R8DAD4YZEwY9wpEHIWhNYwuCgoUOGzsUMpR9hC238z2JlL2+iqLFqhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 22:25:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 22:25:02 +0000
Message-ID: <aaaa54ed-7fd7-404c-853f-90f2e32ae004@intel.com>
Date: Fri, 23 Feb 2024 11:24:47 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
Content-Language: en-US
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
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
 <op.2jhao6nzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <bf21f955c1b56ef836ad03bc42d522b6d020edbf.camel@intel.com>
 <op.2jj67xqlwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jj67xqlwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2995344a-aacd-4102-1fb0-08dc33f51c52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhEpFWNVlO31DG9g6dH+ka2kowmrWgRwGTUkXs8SA5ZzNx+AmLImXh9Fn6vbDzG59uTnQf2xL5O/OKEhUHSEnaivZVuk2/4qM7bdyPFujCtrewyMCZhgSBvnlr+ty8cgO6yIuGKxkW8SuA9bLvSc30A19d/psDQarLSGZA36Z2ny9KJpTI/ZpaZkIIBSxvnHB0m27T3VtTeCuTHqLSNA3W9SYyRYuohIJDQU7+Es9SpHQdxr9LWQruhOj23GedJwcKZFokKARsvqU9zSL/9MNr1iP3+nzU48Zu1+7Kkdmt02RIRHG0u3uDXEu1/frVoKlNZ2KIzPacVISkMWEKxIRLlksMD4BpUZ+RJNGnKrVNXfjmQVIZgdniHiDw0+E7C+2JXymLxKPU2FHUVAvLbFOBOLTKVDKxeQf+D6+ERRZwL49nZA49fQM9ert2KitDGR5xcTZfV0k0u4EL6DllkH4C1YlpVUOfea8LIrMqxtn1BpJ3BsRkXmgMYK4Pannd8znn8euZf6cX9uYtT0Y6HaoFP0HDLO7bWGWLc406rmffINzI9QFoNgUrFBB3eq3qf1Eh/HmoJOQZE2Vupd1CDnZfp0IV1ED/PndZzupUfwCN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui91TFh2aHBtY3dIMloxRVI4aUg1bndxYUVoZG9FK1VnNXE1RGhHZlowUUlZ?=
 =?utf-8?B?OHA3MG9POFo0NVZ3Qy9wcjNZMjBQS0dINTNYOVBlUDFENkdEUmg4Tk14N3R1?=
 =?utf-8?B?TEZ1MzZxVDdEWmpRcC9iamtHaVIrQW5jNy9sQVR0YXFvTXkweWFMQ29DaUxY?=
 =?utf-8?B?MVpBcG5OanVSSWNLVXhVMnI5eDNwVm9MaVlzeE1mTVMzdTc3ei9NS2RxS2F6?=
 =?utf-8?B?bkEwUGRCS3RqT2oydTJpN3ZLeUx4YzlXUXJwR0s5dncrRmczb3BFSXI2NkJM?=
 =?utf-8?B?K2E0RVNOLytpN1FsUkxtZzRxdlZ2c2VDeUlQbDV6Rjd4azNyTkZWL0JtU0tW?=
 =?utf-8?B?S241eW4ybVFnZlY2L2dYZHMwMi9DcmhwSUU5TmVnbEl4YmIwZVpUaThEMEh6?=
 =?utf-8?B?YjhEYXhLRDBTeWtocVl4V09DSXE4WGVvRVBuY1pJZ2ZkYTdRS0RlV2dLSnFJ?=
 =?utf-8?B?d01ueERod0owY0hZS0tHc0lOL0tDczVxVVNMVmhxcnhoaGVjM2xVOURSYVli?=
 =?utf-8?B?S214czd3Ujl0cHVHMGxGb0krZzBjWVhLeWpHZ0ZWYmdRbk9JSGIyMG1VeW01?=
 =?utf-8?B?d3RmY0MxVkJJREpxdCsrNjVOcGVFaGhnclBoaUlyb2NSZ3RtT0pGMEVZdHor?=
 =?utf-8?B?ODQzR20rZUlaQkJEYlIxUW1EVndsWDRqMU5iTCs5QytMMzVORkhwcE5HcFI2?=
 =?utf-8?B?d3BxNEYvRmFxR1BKcmpvdjZzSTBuWkJWN1lwbGZ2ak1DVWdDdi9pSmk4RmZz?=
 =?utf-8?B?UmNxUHlvQWFuVXd3UGNxdExWOTNJUmRZanNzenNvYXhRQkJtMTlMWVY4T2hi?=
 =?utf-8?B?NkNGTjlEMFRqNHdaQkk3dy9oVHZDWXp4cmJtTTVDMlU2blc5dUNZYWZpQTF6?=
 =?utf-8?B?SmRKbE4rNWRKbVcvOG4vTTk4VFFuWXJrclk3b1pHUTFTdWxTSHBLQU96eTM5?=
 =?utf-8?B?bmdreGhGRFBNY0l5bkorN0VzVVRZWWtuRDVJVm00OTBmcGxDTWhpY0JhbDFJ?=
 =?utf-8?B?ajdDMkQ4OCtJcUR1QktHdHN5YXVURzI3aHlKK1hJeU1nbkVVVldiNFE5WUMr?=
 =?utf-8?B?bXhNVHI4M3p5Wjhta05MRFdCclA2Z0FnWmkxUGE4OUd6bkV5Rjl3YnMvVVRZ?=
 =?utf-8?B?bzZBdFQ3YUJwOVMwR2FFYnFTWVNMcHhSRnpVVVU1azhrQjVlZ0FtdUs1dzcv?=
 =?utf-8?B?bWIwemo4N0pqeTVOZTZPWUNzQThDS1djRGhSVytmdk8yMTBVVVh1QTZkaHM4?=
 =?utf-8?B?UVBNeW5XN1FCMDFNUGcydFBrNU55OGJ6aFhqMlRiU3JUOFlCOVE4eGtVVTV3?=
 =?utf-8?B?UG1uQUNyc2pUR1NuZ0Z5SmdKQTE0MUF3czVjWGFPNktxUUdtY0NpUkY4QmYy?=
 =?utf-8?B?MDNFTTFpa21Hd2xqRFZiWkVlWlNXa1Z4Q0p3azJHeUVGOFhuUjhKNXRUZzdq?=
 =?utf-8?B?WW81dFN1OVB4c1pHb1pYenp2YUV4TjAyeE53MTdIQ0MyK210ait4bVVJMXlB?=
 =?utf-8?B?Q2dXWEx2Q0lMRzJIZG9qNUVxd3FxOTlvV3Vtd1M4aTlCTGpsQitHNmVGYkVJ?=
 =?utf-8?B?eTVhZ0I4a2pWRklhVGtTc2x4M3dGMFA2ZERkQzlQa2RxK01pc1A2bW9BRk9l?=
 =?utf-8?B?MU13SWRhQlR4RFhnQkY5M3hJR1RWUWFkaEYrZFdZS1dneDc0MTh5UEtwNWY4?=
 =?utf-8?B?ekhleXZ6Q2hhZWpsaEh1VThWbkhGcWZsWWNPRUhCQlBhSVNIemhic09pek5H?=
 =?utf-8?B?U0tDd29vTjVCTzh2OXYxSEhNMXJoaFNhSnVXbTB0Z3p5Mi9ZalB3U0dhSVlj?=
 =?utf-8?B?U1FTR3Jac0NjaW4wNFlSM1NReFhvSHM2Mk4xczU3VVpzalNaSVBKcGU3ZC9O?=
 =?utf-8?B?b1JyMkVjNGdkVlhRaGF0WDZ3U01qRGRTemZ5QzgxYlkzN2FwQTR3NnhoY0Vq?=
 =?utf-8?B?cmdqMmsrNXRGaTFrclYycEJLam5DM1c5aE5yeXM2dUdlWEsrazZ0bGpRVEZx?=
 =?utf-8?B?UXkvZ2NaVTY5Zm1HRVJmMDVVTGZsZEN5N2pTajVyQW90anRoMSs5VG1zN2lH?=
 =?utf-8?B?MThYMDRzakFXd2c4Y3J0WmNOVlE3YjVjZ0RRRVZHV01rdnBtT1puTnJHSHoz?=
 =?utf-8?Q?A+IIYSTEJ4+Gutllo1N0omACb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2995344a-aacd-4102-1fb0-08dc33f51c52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:25:02.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VAv8Xjs8S4ERCv2NmS1xIlCBr/p6BJ6dfMPosRXsPASvTllW6bC+9kXkJkgT4P8oZqwXl9LIOX9QnH+2e9ZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com



On 23/02/2024 9:12 am, Haitao Huang wrote:
> On Wed, 21 Feb 2024 04:48:58 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>> On Wed, 2024-02-21 at 00:23 -0600, Haitao Huang wrote:
>>> StartHi Kai
>>> On Tue, 20 Feb 2024 03:52:39 -0600, Huang, Kai <kai.huang@intel.com> 
>>> wrote:
>>> [...]
>>> >
>>> > So you introduced the work/workqueue here but there's no place which
>>> > actually
>>> > queues the work.  IMHO you can either:
>>> >
>>> > 1) move relevant code change here; or
>>> > 2) focus on introducing core functions to reclaim certain pages from a
>>> > given EPC
>>> > cgroup w/o workqueue and introduce the work/workqueue in later patch.
>>> >
>>> > Makes sense?
>>> >
>>>
>>> Starting in v7, I was trying to split the big patch, #10 in v6 as you 
>>> and
>>> others suggested. My thought process was to put infrastructure needed 
>>> for
>>> per-cgroup reclaim in the front, then turn on per-cgroup reclaim in [v9
>>> 13/15] in the end.
>>
>> That's reasonable for sure.
>>
> 
> Thanks for the confirmation :-)
> 
>>>
>>> Before that, all reclaimables are tracked in the global LRU so really
>>> there is no "reclaim certain pages from a  given EPC cgroup w/o 
>>> workqueue"
>>> or reclaim through workqueue before that point, as suggested in #2. This
>>> patch puts down the implementation for both flows but neither used 
>>> yet, as
>>> stated in the commit message.
>>
>> I know it's not used yet.  The point is how to split patches to make 
>> them more
>> self-contain and easy to review.
> 
> I would think this patch already self-contained in that all are 
> implementation of cgroup reclamation building blocks utilized later. But 
> I'll try to follow your suggestions below to split further (would prefer 
> not to merge in general unless there is strong reasons).
> 
>>
>> For #2, sorry for not being explicit -- I meant it seems it's more 
>> reasonable to
>> split in this way:
>>
>> Patch 1)
>>   a). change to sgx_reclaim_pages();
> 
> I'll still prefer this to be a separate patch. It is self-contained IMHO.
> We were splitting the original patch because it was too big. I don't 
> want to merge back unless there is a strong reason.
> 
>>   b). introduce sgx_epc_cgroup_reclaim_pages();
> 
> Ok.

If I got you right, I believe you want to have a cgroup variant function 
following the same behaviour of the one for global reclaim, i.e., the 
_current_ sgx_reclaim_pages(), which always tries to scan and reclaim 
SGX_NR_TO_SCAN pages each time.

And this cgroup variant function, sgx_epc_cgroup_reclaim_pages(), tries 
to scan and reclaim SGX_NR_TO_SCAN pages each time "_across_ the cgroup 
and all the descendants".

And you want to implement sgx_epc_cgroup_reclaim_pages() in this way due 
to WHATEVER reasons.

In that case, the change to sgx_reclaim_pages() and the introduce of 
sgx_epc_cgroup_reclaim_pages() should really be together because they 
are completely tied together in terms of implementation.

In this way you can just explain clearly in _ONE_ patch why you choose 
this implementation, and for reviewer it's also easier to review because 
we can just discuss in one patch.

Makes sense?

> 
>>   c). introduce sgx_epc_cgroup_reclaim_work_func() (use a better 
>> name),     which just takes an EPC cgroup as input w/o involving any 
>> work/workqueue.
> 
> This is for the workqueue use only. So I think it'd be better be with 
> patch #2 below?

There are multiple levels of logic here IMHO:

   1. a) and b) above focus on "each reclaim" a given EPC cgroup
   2. c) is about a loop of above to bring given cgroup's usage to limit
   3. workqueue is one (probably best) way to do c) in async way
   4. the logic where 1) (direct reclaim) and 3) (indirect) are triggered

To me, it's clear 1) should be in one patch as stated above.

Also, to me 3) and 4) are better to be together since they give you a 
clear view on how the direct/indirect reclaim are triggered.

2) could be flexible depending on how you see it.  If you prefer viewing 
it from low-level implementation of reclaiming pages from cgroup, then 
it's also OK to be together with 1).  If you want to treat it as a part 
of _async_ way of bring down usage to limit, then _MAYBE_ it's also OK 
to be with 3) and 4).

But to me 2) can be together with 1) or even a separate patch because 
it's still kinda of low-level reclaiming details.  3) and 4) shouldn't 
contain such detail but should focus on how direct/indirect reclaim is done.

[...]

> 
> To be honest, the part I'm feeling most confusing is this 
> self-contained-ness. It seems depend on how you look at things.

Completely understand.  But I think our discussion should be helpful to 
both of us and others.

