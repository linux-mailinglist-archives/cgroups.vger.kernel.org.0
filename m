Return-Path: <cgroups+bounces-2983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10218CCD50
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EE61C210BC
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120B13B582;
	Thu, 23 May 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG0XddrP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A6171C4
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450580; cv=fail; b=a/fR6b2YGV1AHxW6vGnMoYaKKvIQYT3fJq+4V2iQO+dW+yog9A+c9cxDlXesgpRAQZYOmvHES/IYoNTeXfJtb5BdPGwnLryxN3Mkj6RsM2O9/M1FLRm7OzLHYJPRP3yzbsaXJZh9RsFJjdgzMRlG+bCe91D42Ilgy5rdn4tNvco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450580; c=relaxed/simple;
	bh=yXeHvkppQ3K8hC4G3dvlJXSVjjBC6n/W0uPJFM3PRUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k95x/QJcLABayXvBNMk2TiteFolFIZqcAhS1qg2F1QRS/+6/jG6VMq30AyN6OtTlQC9tFlAb0L/Cwxm/G4jFt7z4oumnDPQI5KAQsi9nBznuGxyIN9+P0EHNVWIt7xI2gSXaKk4jGY799+/p7nxCQVe8I5uTdvXXvsh3BkyLWiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG0XddrP; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716450575; x=1747986575;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yXeHvkppQ3K8hC4G3dvlJXSVjjBC6n/W0uPJFM3PRUg=;
  b=QG0XddrP5/nhMs3D8CHpdRATUHxmTX9k+42gQM/sOMN8+nRruqjF8byY
   jAm+qFRt9Gn03NyTkjOm802BMCOTCqIrfKb+XBAYKWQt3zIyjpTifoZoV
   2UAguA7P9jC4m82yc7oM+1MLFj2YRgLPi9SHoG5MUGue8nnYfYmoMiZ+w
   XLc/S/AoUY8Gaga4qDpVWbHgAVGIkr7TqWWzv6MLb4W1LqPEs4BcJxdRf
   VTb6VTWfJSR0MHIZSGGyCMza7cMQazSVOm157/SlLI3aSN4UZJuLlf2i1
   a/QNDGfzeCtGeESlWkn9rIy38NMTN/LvGzLREYPPwdt/PjZiqGCMPOc3b
   g==;
X-CSE-ConnectionGUID: n7eWlkGjS4mjSTP0fDK+fA==
X-CSE-MsgGUID: PQE3q6LiSVyfLoFI3cKskw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23360268"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23360268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 00:48:57 -0700
X-CSE-ConnectionGUID: Ge48oahLQQCKF3sAPjBeEw==
X-CSE-MsgGUID: oszN+W21SyykPxtxl/Ru6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33684032"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 00:48:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 00:48:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 00:48:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 00:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKEc/BQAm8J4hiJSSi2Z2GbovU9iNRwabUIZuQxPkCEggqSNrmC6yQATV0xsSlotvdnFNhtMIG31YRucxo5fi7IOc0PJnrVVcLrCem3bTwjblVJk4du3STo5L+ea8PSOHqlj2orMZAHaZ3WfkXtVVp4zU6hkQegBT5qQ8jG9IyM/QgZ1QL2epU88dgcZ+S0K1cOmfIeY3IY0niwuAt/ZF+cv7XxlE7/VTQfVemu/lrMwUUXwSm5kBeCKq4YL6bzd3d/0W/2L7DDCHILxxZvVGZkWi47IN/rigPHTVCR2V2/5fY8a5f8WPVyaEUaYa4DnNZJFeeB1k7TWpMdBS7zsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMDKJ3jHKWKjIYs5F3ZMK9fAZsTEkzUdCQIu0p9ZG50=;
 b=M1/sIFE8/asrii60sC7sWTlhtR2epZymPJf2X2CDABclK9pC4YxU8Dv4gKqqkXARRthB2KsQKH1MrrRRIr+qI+vV0mtxtyepLEVx/04OgvA2p9WX6/rqJOQLsyjTXKx/5uAd3TAKz984R3oWtS2g62nFVtrsyCvbMtPfaFAA4d8OjqINYj8IdnGQff37Qa/TmyzUSBqodXTxHDWWjhG7F3qSee4NYfpdHEoa4jnRKXC9xyrdaZUBk/UJDoUnbKBoJ89fu5T+ykqFuSsKPfjOVC2nJTCJkU//onHT7+LpuQ29ZiMHC4aQjxBp9fkFG0x1cvTJe1gXp84NEidjVMdEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Thu, 23 May
 2024 07:48:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 07:48:53 +0000
Date: Thu, 23 May 2024 15:48:40 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
	<yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
Content-Type: multipart/mixed; boundary="3k7mPDL5IkKI8K4C"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed7bc93-8ec9-4930-28f9-08dc7afcca42
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvrvOb7OxebqlKqXn0CrCXCeL333rTh1vk8S9ro+5GD0Paz5ASc6AxH9nMEc?=
 =?us-ascii?Q?P4s/LVoHfhFY0QMl8LHAMYKDZHMYmyrqmQbH6EBImrIh0rG5KoZ6XmJOc92P?=
 =?us-ascii?Q?LUDCCWjSUhRQm25/6cdF8WtK7ewY8fLJBbgMeL2Ihv2+8EA60i2Svvpg1I1o?=
 =?us-ascii?Q?vFUh9nLs8304BHWGBioT8Fjsw/z33FdPH0MMK8pojVZRx2ipQErV7njj2QEc?=
 =?us-ascii?Q?18MmXG+d7xcHvPdE2mmXGGepnttM9ytNjlBK3jQ0Wxca7kodTG1T2YkiTvZc?=
 =?us-ascii?Q?BEU8n8QLXXMyYzZu6Km7/RKqwSmpgmpD5FREPaY5CuHjomVm3qLSi0EyfZKW?=
 =?us-ascii?Q?0zjEbnYibJwfTacBVieGJmlgE0j/dEx3lqaidpid5RZalTPoQJSPMbQ1YjTK?=
 =?us-ascii?Q?oz90CBeWsOL1HGMSrVZU3G4JrTdtBd8+WPhSMF2FRHjldPd0SPnTN3uL1uXY?=
 =?us-ascii?Q?53receD3PqV3aeIkTf5AvAU8bdIfKpWSZcNZlYFAFAq1Ix69438Bpiv0A93+?=
 =?us-ascii?Q?2X9zBCnMwIRqiuhoM4lLgkPhmfCmvNAqQAXh8EaPqNYEcE6QpwyD6yAu4EW+?=
 =?us-ascii?Q?eWG2tECIQkHnOMebbSPyF30mh1DF9H2O08yruAkhKKtHFKhD3kSyXweP9QTx?=
 =?us-ascii?Q?5qcH4D66EoFNqWRSIPRx3xKbkle/SdeaRH7LoTemagrywWNeJDQe6dj7eQx2?=
 =?us-ascii?Q?xI7RkANn6kjr6pHWvlu7DLACXJMIvuM+9Vc91xnuer0tMIwZ6MoA6Fu15iqx?=
 =?us-ascii?Q?lZJobrdNTW4v9IhhTQHLgT9NYy0BVsiaj+D13taJPQWpWZkDFlTVOCFSOH3C?=
 =?us-ascii?Q?IKYNhQio2VGbKqWruJ2thFaPwMRi8Ox8w9JycXbb6qpJMDBmiICIeV0sOW2I?=
 =?us-ascii?Q?y7raa4mHEOcRAY2AmvgXHyB199PneU9TiIBXtqGMqxHiCZdVk2TqOqgptE4x?=
 =?us-ascii?Q?fQc/PDUttFXxmvmrPOCvs5QMC34gNJeAhX12vQ+lwpXdJqRIfncCtecfhNHn?=
 =?us-ascii?Q?e6S8NWkg7xTdcHrYJiBd6oOKqeRZpuHZ0dEou5PfhkLYg++JoITlNpBvdl8f?=
 =?us-ascii?Q?5WI/rxHJ+XWVf1ZK/D7x8jeA8yEnT3bSJJHhTdjZ43tDGUK1n59TImoZv82Z?=
 =?us-ascii?Q?ewQBlWrOEo52hJJYdjLbnIDhoTc2oPOR18KvBTMzrZkW+0m3pTrL9qPmqU8x?=
 =?us-ascii?Q?s3/An8NswtSN4Reh2N29E7BvXsrWDc4WzIUKL2arew4loCuHuE9RF4MGr79f?=
 =?us-ascii?Q?1zUt4Vmu4jollaHhdGCedGswEjv1jU2ZQA2LSaa/OA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/87hlfjc7/bQy10w7lSwCA00Wvb1uqnKDRl6ywDkmSZn8fB4ZhB9LdCnYQT?=
 =?us-ascii?Q?0U86StDUk6O1RiPw9AFnDz4CtAV7zZ9V7CGgpz4rDNkMRCEPHhGKszcmAS84?=
 =?us-ascii?Q?wgYgFMRszkR89t+6eUqt+urt/OYEUrrDaPg9vaCiqrNjgOkIISkp+tWFJFQB?=
 =?us-ascii?Q?rz4pdOIjbBH269sYymDBFAoZzm9sJzCLvDzGIu1ntmHn/s3rdlCl5SUYzErc?=
 =?us-ascii?Q?YJW2qLicDDStWPm9otnSBUiQ4DXT1i+afeNMgEjuhxh9e7OuppITYWfLSgXd?=
 =?us-ascii?Q?e6K3iU5fhRCEiDdbP0POf7i7xZVj1NXeFE3GK9120TNEOgwYcbgDq1R8Vks3?=
 =?us-ascii?Q?mZkxhDr8GGmt9xwzzGQh2SfRI8XseXaE8F63tvf9Nrfo+8lyRu3gwcDTt8sC?=
 =?us-ascii?Q?ZZE3V5qvXaoqPZDtMKkmQZ/swLVwiHK5JPZWaPnZnjoyHD+sSrnWeBae7MO9?=
 =?us-ascii?Q?eWIMuq6mvKKqHCSMQyOIXWjIicCHjFAyFn/b+2UnyYraPN9hmGYydfMuLmFi?=
 =?us-ascii?Q?tbwGJ8Qz5bpwi3g4d3doz2hoM4BFMIALlCMTKE8642+MD/8yjt2bGzLoznVI?=
 =?us-ascii?Q?C3VAS1bGOtMPWMs3u+7+BFG4TGQYjcCUTZ3WdYirjrDUJuhJIVL2oYVekdVt?=
 =?us-ascii?Q?kR1CBq7L/ru4Fp2wjjIPjvUlSHoCWuLeSGiQdd/HTTy2vL4MpICFBEEh7Wds?=
 =?us-ascii?Q?z+kLe9JTfX1q6taTZTugPROM/eTw62Yq7KNJuVrQ3gb1oukTC+rCNaMHhVMX?=
 =?us-ascii?Q?BCAFxK10uq6rXRV28WytPfesuvrj3afzAmdjO8hPBc1X6i6YTcpTbJCkyi4L?=
 =?us-ascii?Q?DtOLv2thhw/iY4Ht44BdofQqJ67kCTKIghr/kxfg7rZFJeQfO3AnCnvdLrY+?=
 =?us-ascii?Q?FYT+DKuIo8vNiTRpDcZj6IjgaC+pipYvNS9xXuyAPiOK0GSGr1KxNDh064gn?=
 =?us-ascii?Q?S9Aa3siVfdgJr1SoEVgetlvLERyrg8v90WerX4RhRgME1CGmcm6JlgSLdZsW?=
 =?us-ascii?Q?Urp6zuGbe8x26lafyyHXe1o9stN9Jtc8qH4nq/32P5NJT4aaKqSCg/Z7aE2q?=
 =?us-ascii?Q?5gb0x2F1jtZ53bXNUvZdvxxYdDmFohiQBtA++9xCYO46bjXuyAAfCVDtci3a?=
 =?us-ascii?Q?T1XodJLlaedlLQnMaGd1lMbSlj1cd9uzdshtub0zaplBQFMDc5JV60m3TZ78?=
 =?us-ascii?Q?byRrIybwqaiDkWF7ydzUh1D1zJvgMHTL90JL+k95/GSswv9SOBAJ3SjT8lM6?=
 =?us-ascii?Q?RZa3LgKQSwI15zCHV7qeROY3OiC2pE6wnGv76xTs/Wkcwvo1wnlO41U/x6xn?=
 =?us-ascii?Q?0KiHMk2DNfcWSEQ0zANGuXJAg4uoFExtehoLpWyMpYu2+GPS6rEFMjfjruWB?=
 =?us-ascii?Q?TrzxQm89Krl0FSPC7Iic7xFE3zNEBrMLllo/AEeugxqkRFQqqAfb1U09Gc1x?=
 =?us-ascii?Q?iuQAf7gSwZnvQV6dQ/MM1g0ZBAMCLzl0k0sA/LCy6gmM/3mDvN6boOjUrtvD?=
 =?us-ascii?Q?PpqaleXOXlH6PhtXfNn47E3LkdOqz1V674IdxTwAEGqxIzPww5oXfOPFEojq?=
 =?us-ascii?Q?7zq1T/6ZL4JLMWWPtzOKTTuddCItZKOBJ/VJ0sfG1+Dr8WN1qdQubUEckFfQ?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed7bc93-8ec9-4930-28f9-08dc7afcca42
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:48:53.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byOhJVRQkh5mJMtsdnOMm32itmOhyB6p5lum5Vum8wQl6RTTAFB/WGX1PSkJ8sLheNpcwdStE3VL/M4YUnGr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com

--3k7mPDL5IkKI8K4C
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Shakeel,

On Tue, May 21, 2024 at 09:18:19PM -0700, Shakeel Butt wrote:
> On Tue, May 21, 2024 at 10:43:16AM +0800, Oliver Sang wrote:
> > hi, Shakeel,
> > 
> [...]
> > 
> > we reported regression on a 2-node Skylake server. so I found a 1-node Skylake
> > desktop (we don't have 1 node server) to check.
> > 
> 
> Please try the following patch on both single node and dual node
> machines:


the regression is partially recovered by applying your patch.
(but one even more regression case as below)

details:

since you mentioned the whole patch-set behavior last time, I applied the
patch upon
  a94032b35e5f9 memcg: use proper type for mod_memcg_state

below fd2296741e2686ed6ecd05187e4 = a94032b35e5f9 + patch


for the regression in our original report, test machine is:

model: Skylake
nr_node: 2
nr_cpu: 104
memory: 192G

regression partially recovered:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     91713           -13.0%      79833            -4.5%      87614        will-it-scale.per_process_ops

detail data is in part [1] in attachment.


in later threads, we also reported similar regression on other platforms.

on:
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

regression partially recovered but not so obvious as above:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    240373           -12.9%     209394           -10.1%     215996        will-it-scale.per_process_ops

detail data is in part [2] in attachment.


on:
model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 512G
brand: Intel(R) Xeon(R) Platinum 8480CTDX


regression NOT recovered, even a little worse:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     78072            -5.6%      73683            -6.5%      72975        will-it-scale.per_process_ops

detail data is in part [3] in attachment.


for single node machine, we reported last time no regression on:

model: Skylake
nr_node: 1
nr_cpu: 36
memory: 32G
brand: Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz

we confirmed it's not impacted by this new patch, either:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-d08/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    136040            -0.1%     135881            -0.1%     135953        will-it-scale.per_process_ops

if you need detail data for this comparison, please let us know.


BTW, after last update, we found another single node machine which can reproduce
the regression in our original report:

model: Cascade Lake
nr_node: 1
nr_cpu: 36
memory: 128G
brand: Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz

the regression is also partially recovered now:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-csl-d02/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    187483           -19.4%     151162           -12.1%     164714        will-it-scale.per_process_ops

detail data is in part [4] in attachment.

> 
> 
> From 00a84b489b9e18abd1b8ec575ea31afacaf0734b Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Tue, 21 May 2024 20:27:11 -0700
> Subject: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
> 
> At the moment the fields of mem_cgroup_per_node which get read on the
> performance critical path share the cacheline with the fields which
> might get updated. This cause contention of that cacheline for
> concurrent readers. Let's move all the read only pointers at the start
> of the struct, followed by memcg-v1 only fields and at the end fields
> which get updated often.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..16efd9737be9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -96,23 +96,25 @@ struct mem_cgroup_reclaim_iter {
>   * per-node information in memory controller.
>   */
>  struct mem_cgroup_per_node {
> -	struct lruvec		lruvec;
> +	/* Keep the read-only fields at the start */
> +	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
> +						/* use container_of	   */
>  
>  	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
>  	struct lruvec_stats			*lruvec_stats;
> -
> -	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> -
> -	struct mem_cgroup_reclaim_iter	iter;
> -
>  	struct shrinker_info __rcu	*shrinker_info;
>  
> +	/* memcg-v1 only stuff in middle */
> +
>  	struct rb_node		tree_node;	/* RB tree node */
>  	unsigned long		usage_in_excess;/* Set to the value by which */
>  						/* the soft limit is exceeded*/
>  	bool			on_tree;
> -	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
> -						/* use container_of	   */
> +
> +	/* Fields which get updated often at the end. */
> +	struct lruvec		lruvec;
> +	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> +	struct mem_cgroup_reclaim_iter	iter;
>  };
>  
>  struct mem_cgroup_threshold {
> -- 
> 2.43.0
> 
> 

--3k7mPDL5IkKI8K4C
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="detail-comparison"
Content-Transfer-Encoding: 8bit

[1]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
 1.646e+08            +7.6%  1.772e+08 ± 14%     +34.5%  2.215e+08 ± 20%  cpuidle..time
     41.99 ± 16%     -24.4%      31.73 ± 16%     -25.2%      31.39 ± 12%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     34.17            -0.9%      33.87            -0.2%      34.12        boot-time.boot
      3182            -1.0%       3151            -0.2%       3176        boot-time.idle
     21099 ±  5%     -16.5%      17627 ±  2%      -7.4%      19540 ±  3%  perf-c2c.DRAM.local
      4025 ±  2%     +31.3%       5285 ±  4%     -14.7%       3432 ±  2%  perf-c2c.HITM.local
      0.44 ± 24%      +0.1        0.58            +0.2        0.65 ± 20%  mpstat.cpu.all.idle%
      0.01 ± 23%      +0.0        0.01 ±  9%      +0.0        0.02 ±  6%  mpstat.cpu.all.soft%
      7.14            -0.9        6.23            -0.3        6.79        mpstat.cpu.all.usr%
   9538291           -13.0%    8302761            -4.5%    9111939        will-it-scale.104.processes
     91713           -13.0%      79833            -4.5%      87614        will-it-scale.per_process_ops
   9538291           -13.0%    8302761            -4.5%    9111939        will-it-scale.workload
 1.438e+09           -12.9%  1.253e+09            -4.2%  1.378e+09        numa-numastat.node0.local_node
  1.44e+09           -12.9%  1.254e+09            -4.2%   1.38e+09        numa-numastat.node0.numa_hit
 1.453e+09           -13.1%  1.263e+09            -4.9%  1.382e+09        numa-numastat.node1.local_node
 1.454e+09           -12.9%  1.265e+09            -4.8%  1.384e+09        numa-numastat.node1.numa_hit
  1.44e+09           -12.9%  1.254e+09            -4.2%   1.38e+09        numa-vmstat.node0.numa_hit
 1.438e+09           -12.9%  1.253e+09            -4.2%  1.378e+09        numa-vmstat.node0.numa_local
 1.454e+09           -12.9%  1.265e+09            -4.8%  1.384e+09        numa-vmstat.node1.numa_hit
 1.453e+09           -13.1%  1.263e+09            -4.9%  1.382e+09        numa-vmstat.node1.numa_local
 2.894e+09           -12.9%   2.52e+09            -4.5%  2.764e+09        proc-vmstat.numa_hit
 2.891e+09           -13.0%  2.516e+09            -4.5%   2.76e+09        proc-vmstat.numa_local
  2.88e+09           -12.9%  2.509e+09            -4.5%  2.752e+09        proc-vmstat.pgalloc_normal
 2.869e+09           -12.9%  2.499e+09            -4.5%  2.741e+09        proc-vmstat.pgfault
  2.88e+09           -12.9%  2.509e+09            -4.5%  2.751e+09        proc-vmstat.pgfree
     17.51            -3.2%      16.95            -1.5%      17.23        perf-stat.i.MPKI
 9.457e+09            -9.7%  8.542e+09            -3.1%  9.165e+09        perf-stat.i.branch-instructions
  45022022            -9.0%   40951240            -2.6%   43850606        perf-stat.i.branch-misses
     84.38            -5.7       78.65            -3.2       81.15        perf-stat.i.cache-miss-rate%
 8.353e+08           -12.9%  7.271e+08            -4.6%  7.969e+08        perf-stat.i.cache-misses
 9.877e+08            -6.6%  9.224e+08            -0.8%  9.799e+08        perf-stat.i.cache-references
      6.06           +11.3%       6.75            +3.2%       6.26        perf-stat.i.cpi
    136.25            -1.1%     134.73            -0.1%     136.12        perf-stat.i.cpu-migrations
    348.56           +14.9%     400.65            +4.9%     365.77        perf-stat.i.cycles-between-cache-misses
 4.763e+10           -10.1%  4.285e+10            -3.1%  4.617e+10        perf-stat.i.instructions
      0.17            -9.9%       0.15            -3.2%       0.16        perf-stat.i.ipc
    182.56           -12.9%     158.99            -4.5%     174.33        perf-stat.i.metric.K/sec
   9494393           -12.9%    8270117            -4.5%    9066901        perf-stat.i.minor-faults
   9494393           -12.9%    8270117            -4.5%    9066902        perf-stat.i.page-faults
     17.54            -3.2%      16.98            -1.6%      17.27        perf-stat.overall.MPKI
     84.57            -5.7       78.84            -3.2       81.34        perf-stat.overall.cache-miss-rate%
      6.07           +11.2%       6.76            +3.2%       6.27        perf-stat.overall.cpi
    346.33           +14.9%     397.97            +4.8%     362.97        perf-stat.overall.cycles-between-cache-misses
      0.16           -10.1%       0.15            -3.1%       0.16        perf-stat.overall.ipc
   1503802            +3.5%    1555989            +1.7%    1528933        perf-stat.overall.path-length
 9.424e+09            -9.7%  8.509e+09            -3.1%  9.133e+09        perf-stat.ps.branch-instructions
  44739120            -9.2%   40645392            -2.6%   43568159        perf-stat.ps.branch-misses
 8.326e+08           -13.0%  7.247e+08            -4.6%  7.945e+08        perf-stat.ps.cache-misses
 9.846e+08            -6.6%  9.193e+08            -0.8%  9.768e+08        perf-stat.ps.cache-references
    134.98            -1.1%     133.49            -0.1%     134.89        perf-stat.ps.cpu-migrations
 4.747e+10           -10.1%  4.268e+10            -3.1%  4.601e+10        perf-stat.ps.instructions
   9463902           -12.9%    8241837            -4.5%    9037920        perf-stat.ps.minor-faults
   9463902           -12.9%    8241837            -4.5%    9037920        perf-stat.ps.page-faults
 1.434e+13            -9.9%  1.292e+13            -2.9%  1.393e+13        perf-stat.total.instructions
     64.15            -2.5       61.69            -0.9       63.21        perf-profile.calltrace.cycles-pp.testcase
     58.30            -1.9       56.36            -0.7       57.58        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     52.64            -1.3       51.29            -0.5       52.17        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     52.50            -1.3       51.18            -0.5       52.05        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     50.81            -1.0       49.86            -0.2       50.64        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      9.27            -0.9        8.36            -0.4        8.83 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     49.86            -0.8       49.02            -0.1       49.76        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     49.21            -0.8       48.45            -0.1       49.14        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.60 ±  4%      -0.6        0.00            -0.2        0.35 ± 70%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      3.24            -0.5        2.73            -0.3        2.98        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.15            -0.5        4.65            -0.2        4.94        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      0.82            -0.3        0.53            -0.3        0.56        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.68            -0.3        1.43            -0.2        1.51        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      1.50 ±  2%      -0.2        1.26 ±  3%      -0.1        1.42        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.52            -0.2        2.27            -0.1        2.40        perf-profile.calltrace.cycles-pp.error_entry.testcase
      1.85            -0.2        1.68            -0.1        1.78 ±  2%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.55            -0.1        1.42            -0.1        1.49 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      1.07            -0.1        0.95            -0.1        1.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.68            -0.1        0.56 ±  2%      -0.1        0.61        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.55            -0.1        0.42 ± 44%      -0.0        0.53 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      0.90            -0.1        0.80            -0.0        0.86        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.89            -0.1        0.84            -0.0        0.88        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      1.23            -0.0        1.21            +0.0        1.27        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.15            -0.0        1.13            +0.0        1.19        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.96            +0.0        0.96            +0.1        1.01        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      0.73 ±  2%      +0.0        0.75            +0.1        0.79        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      1.00            +0.1        1.06            +0.1        1.08        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.85            +0.2        4.09            +0.1        3.95        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.85            +0.2        4.09            +0.1        3.95        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      3.85            +0.2        4.09            +0.1        3.96        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.82            +0.2        4.07            +0.1        3.92        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      3.68            +0.3        3.93            +0.1        3.80        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.83            +0.3        1.12 ±  2%      +0.3        1.14        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.00            +0.6        0.56 ±  3%      +0.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
     31.81            +0.6       32.44            +0.4       32.22        perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     31.69            +0.6       32.33            +0.4       32.11        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     30.47            +0.6       31.11            +0.4       30.90        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     30.48            +0.6       31.13            +0.4       30.91        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     30.44            +0.7       31.09            +0.4       30.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      0.00            +0.7        0.68 ±  2%      +0.6        0.63        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
     35.03            +0.7       35.76            +0.6       35.66        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     32.87            +0.9       33.79            +0.7       33.58        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     29.54            +2.3       31.84            +0.9       30.39        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     29.54            +2.3       31.84            +0.9       30.39        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     29.53            +2.3       31.83            +0.9       30.39        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     30.66            +2.3       32.98            +0.9       31.57        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     30.66            +2.3       32.98            +0.9       31.57        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     30.66            +2.3       32.98            +0.9       31.57        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     30.66            +2.3       32.98            +0.9       31.57        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     29.26            +2.4       31.64            +0.9       30.16        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     28.41            +2.4       30.83            +1.0       29.39        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.__munmap
     34.55            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     34.55            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.11            +1.0       35.56        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     31.41            +2.8       34.25            +1.1       32.55        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     31.38            +2.9       34.24            +1.1       32.53        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     31.42            +2.9       34.28            +1.1       32.56        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     65.26            -2.6       62.67            -1.0       64.26        perf-profile.children.cycles-pp.testcase
     56.09            -1.7       54.39            -0.6       55.47        perf-profile.children.cycles-pp.asm_exc_page_fault
     52.66            -1.3       51.31            -0.5       52.19        perf-profile.children.cycles-pp.exc_page_fault
     52.52            -1.3       51.20            -0.5       52.07        perf-profile.children.cycles-pp.do_user_addr_fault
     50.83            -1.0       49.88            -0.2       50.66        perf-profile.children.cycles-pp.handle_mm_fault
      9.35            -0.9        8.44            -0.4        8.91 ±  2%  perf-profile.children.cycles-pp.copy_page
     49.87            -0.8       49.03            -0.1       49.77        perf-profile.children.cycles-pp.__handle_mm_fault
     49.23            -0.8       48.47            -0.1       49.16        perf-profile.children.cycles-pp.do_fault
      3.27            -0.5        2.76            -0.3        3.01        perf-profile.children.cycles-pp.folio_prealloc
      5.15            -0.5        4.65            -0.2        4.94        perf-profile.children.cycles-pp.__irqentry_text_end
      0.82            -0.3        0.53            -0.3        0.57        perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.52 ±  2%      -0.3        1.26 ±  3%      -0.1        1.43        perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.69            -0.2        1.44            -0.2        1.52        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.54            -0.2        2.29            -0.1        2.43        perf-profile.children.cycles-pp.error_entry
      0.57            -0.2        0.33            -0.2        0.34        perf-profile.children.cycles-pp.mas_walk
      1.87            -0.2        1.70            -0.1        1.80 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.60 ±  4%      -0.2        0.44 ±  6%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.57            -0.1        1.43            -0.1        1.51 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.12            -0.1        0.99            -0.1        1.04        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.70            -0.1        0.57 ±  2%      -0.1        0.62        perf-profile.children.cycles-pp.lru_add_fn
      0.95            -0.1        0.82 ±  5%      +0.3        1.22 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.16            -0.1        1.04            -0.0        1.11        perf-profile.children.cycles-pp.native_irq_return_iret
      0.94            -0.1        0.84            -0.0        0.90        perf-profile.children.cycles-pp.sync_regs
      0.43            -0.1        0.34 ±  2%      -0.0        0.39        perf-profile.children.cycles-pp.free_unref_folios
      0.96            -0.1        0.87            -0.0        0.92        perf-profile.children.cycles-pp.__perf_sw_event
      0.44            -0.1        0.36            -0.1        0.39        perf-profile.children.cycles-pp.get_vma_policy
      0.21 ±  3%      -0.1        0.13 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp._compound_head
      0.75            -0.1        0.68            -0.0        0.72        perf-profile.children.cycles-pp.___perf_sw_event
      0.94            -0.1        0.88            -0.0        0.92        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.44 ±  5%      -0.1        0.37 ±  7%      -0.0        0.42 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      0.31            -0.1        0.24 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.41 ±  4%      -0.1        0.35 ±  7%      -0.0        0.40 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.57            -0.0        0.52            -0.0        0.55 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.17 ±  2%      -0.0        0.12 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      0.19 ±  3%      -0.0        0.15 ±  8%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.15 ±  2%      -0.0        0.12 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.32 ±  3%      -0.0        0.29 ±  2%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.13 ±  3%      -0.0        0.10 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.13 ±  2%      -0.0        0.10 ±  4%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.10 ±  3%      -0.0        0.07 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.08            -0.0        0.05            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.policy_nodemask
      1.24            -0.0        1.21            +0.0        1.28        perf-profile.children.cycles-pp.__do_fault
      0.36            -0.0        0.33            -0.0        0.34        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.39            -0.0        0.37            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.17 ±  2%      -0.0        0.15            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.32            -0.0        0.30            -0.0        0.31        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.15            -0.0        1.13            +0.0        1.19        perf-profile.children.cycles-pp.shmem_fault
      0.09            -0.0        0.07            -0.0        0.08        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.16            -0.0        0.14            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.handle_pte_fault
      0.12 ±  3%      -0.0        0.10 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.uncharge_folio
      0.16 ±  2%      -0.0        0.14 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.shmem_get_policy
      0.29            -0.0        0.27            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.08            -0.0        0.06 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.16 ±  4%      -0.0        0.14 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map
      0.25            -0.0        0.24            -0.0        0.24        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30            -0.0        0.28 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.20 ±  2%      -0.0        0.18 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.09 ±  4%      -0.0        0.08            -0.0        0.09        perf-profile.children.cycles-pp.down_read_trylock
      0.12 ±  3%      -0.0        0.11            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.99            -0.0        0.99            +0.1        1.04 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.04 ± 44%      +0.0        0.06 ±  7%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.kthread
      0.04 ± 44%      +0.0        0.06 ±  7%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.ret_from_fork
      0.04 ± 44%      +0.0        0.06 ±  7%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.73            +0.0        0.75            +0.1        0.79        perf-profile.children.cycles-pp.filemap_get_entry
      0.00            +0.1        0.05            +0.0        0.01 ±223%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.02            +0.1        1.07            +0.1        1.10        perf-profile.children.cycles-pp.zap_present_ptes
      0.47            +0.2        0.68 ±  2%      +0.2        0.64        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      3.87            +0.2        4.11            +0.1        3.97        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.17            +0.6        1.75 ±  2%      +0.5        1.67        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
     31.81            +0.6       32.44            +0.4       32.22        perf-profile.children.cycles-pp.folio_add_lru_vma
     31.77            +0.6       32.42            +0.4       32.19        perf-profile.children.cycles-pp.folio_batch_move_lru
     35.04            +0.7       35.77            +0.6       35.67        perf-profile.children.cycles-pp.finish_fault
     32.88            +0.9       33.80            +0.7       33.59        perf-profile.children.cycles-pp.set_pte_range
     29.54            +2.3       31.84            +0.9       30.39        perf-profile.children.cycles-pp.tlb_flush_mmu
     30.66            +2.3       32.98            +0.9       31.57        perf-profile.children.cycles-pp.zap_pte_range
     30.66            +2.3       32.98            +0.9       31.58        perf-profile.children.cycles-pp.unmap_page_range
     30.66            +2.3       32.98            +0.9       31.58        perf-profile.children.cycles-pp.unmap_vmas
     30.66            +2.3       32.98            +0.9       31.58        perf-profile.children.cycles-pp.zap_pmd_range
     33.41            +2.5       35.95            +1.0       34.36        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     33.40            +2.5       35.94            +1.0       34.36        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.children.cycles-pp.__x64_sys_munmap
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.children.cycles-pp.__vm_munmap
     34.56            +2.6       37.12            +1.0       35.58        perf-profile.children.cycles-pp.do_vmi_munmap
     34.56            +2.6       37.12            +1.0       35.57        perf-profile.children.cycles-pp.__munmap
     34.56            +2.6       37.12            +1.0       35.58        perf-profile.children.cycles-pp.do_vmi_align_munmap
     34.56            +2.6       37.12            +1.0       35.58        perf-profile.children.cycles-pp.unmap_region
     34.67            +2.6       37.24            +1.0       35.68        perf-profile.children.cycles-pp.do_syscall_64
     34.67            +2.6       37.24            +1.0       35.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     33.22            +2.6       35.83            +1.0       34.21        perf-profile.children.cycles-pp.folios_put_refs
     32.12            +2.7       34.80            +1.1       33.22        perf-profile.children.cycles-pp.__page_cache_release
     61.97            +3.5       65.47            +1.6       63.54        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     61.98            +3.5       65.50            +1.6       63.56        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     61.94            +3.5       65.48            +1.6       63.51        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      9.32            -0.9        8.41            -0.4        8.88 ±  2%  perf-profile.self.cycles-pp.copy_page
      5.15            -0.5        4.65            -0.2        4.94        perf-profile.self.cycles-pp.__irqentry_text_end
      2.58            -0.3        2.30            -0.1        2.46        perf-profile.self.cycles-pp.testcase
      2.53            -0.2        2.28            -0.1        2.42        perf-profile.self.cycles-pp.error_entry
      0.56            -0.2        0.32 ±  2%      -0.2        0.34        perf-profile.self.cycles-pp.mas_walk
      0.60 ±  4%      -0.2        0.43 ±  5%      -0.1        0.51 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.54            -0.1        1.42            -0.1        1.49 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.15            -0.1        1.04            -0.0        1.11        perf-profile.self.cycles-pp.native_irq_return_iret
      0.94            -0.1        0.84            -0.0        0.90        perf-profile.self.cycles-pp.sync_regs
      0.85            -0.1        0.75 ±  5%      +0.3        1.13 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.20 ±  3%      -0.1        0.12 ±  3%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp._compound_head
      0.27 ±  3%      -0.1        0.19 ±  2%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.26            -0.1        0.19 ±  3%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.66            -0.1        0.59            -0.0        0.63        perf-profile.self.cycles-pp.___perf_sw_event
      0.28 ±  2%      -0.1        0.22 ±  3%      -0.0        0.25        perf-profile.self.cycles-pp.zap_present_ptes
      0.32            -0.1        0.27 ±  4%      -0.0        0.28        perf-profile.self.cycles-pp.lru_add_fn
      0.37 ±  5%      -0.1        0.32 ±  6%      -0.0        0.36 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.26            -0.1        0.20            -0.0        0.21        perf-profile.self.cycles-pp.get_vma_policy
      0.47            -0.1        0.42            -0.0        0.44 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.16            -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.20            -0.0        0.16 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.free_unref_folios
      0.30            -0.0        0.25            -0.0        0.26        perf-profile.self.cycles-pp.handle_mm_fault
      0.16 ±  4%      -0.0        0.12 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.10 ±  4%      -0.0        0.07            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.16 ±  2%      -0.0        0.12 ±  7%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.10 ±  4%      -0.0        0.07 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.11            -0.0        0.08            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.09 ±  5%      -0.0        0.06 ±  7%      -0.0        0.08        perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.11            -0.0        0.08 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.12 ±  4%      -0.0        0.09            -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.31 ±  2%      -0.0        0.29 ±  2%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.14 ±  2%      -0.0        0.12 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.21            -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.09            -0.0        0.07 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.21            -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__perf_sw_event
      0.17 ±  2%      -0.0        0.15            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.28            -0.0        0.26 ±  2%      -0.0        0.27        perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.22 ±  2%      -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.12            -0.0        0.10            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.08            -0.0        0.06 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.folio_unlock
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.16 ±  3%      -0.0        0.14 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.shmem_get_policy
      0.10 ±  3%      -0.0        0.08 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.set_pte_range
      0.16 ±  2%      -0.0        0.15 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.10 ±  3%      -0.0        0.09            -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.exc_page_fault
      0.12 ±  3%      -0.0        0.11            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.09            -0.0        0.08            +0.0        0.09        perf-profile.self.cycles-pp.down_read_trylock
      0.38 ±  2%      +0.0        0.42            +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.26            +0.1        0.36            -0.0        0.23        perf-profile.self.cycles-pp.folios_put_refs
      0.33            +0.1        0.45 ±  4%      +0.1        0.40        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.40 ±  5%      +0.6        0.99            +0.2        0.59        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
     61.94            +3.5       65.48            +1.6       63.51        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


[2]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    194.40 ±  9%     -13.9%     167.40 ±  2%     -10.0%     175.00 ±  4%  perf-c2c.HITM.remote
      0.27 ±  3%      -0.0        0.24 ±  2%      -0.0        0.25 ±  2%  mpstat.cpu.all.irq%
      3.83            -0.6        3.21            -0.5        3.37 ±  2%  mpstat.cpu.all.usr%
  15383898           -12.9%   13401271           -10.1%   13823802        will-it-scale.64.processes
    240373           -12.9%     209394           -10.1%     215996        will-it-scale.per_process_ops
  15383898           -12.9%   13401271           -10.1%   13823802        will-it-scale.workload
 2.359e+09           -12.8%  2.057e+09           -10.2%  2.118e+09 ±  2%  numa-numastat.node0.local_node
 2.359e+09           -12.8%  2.057e+09           -10.2%  2.118e+09 ±  2%  numa-numastat.node0.numa_hit
 2.346e+09           -13.2%  2.035e+09 ±  2%     -10.3%  2.105e+09        numa-numastat.node1.local_node
 2.345e+09           -13.2%  2.036e+09 ±  2%     -10.2%  2.105e+09        numa-numastat.node1.numa_hit
  2.36e+09           -12.9%  2.056e+09           -10.2%  2.118e+09 ±  2%  numa-vmstat.node0.numa_hit
  2.36e+09           -12.9%  2.056e+09           -10.3%  2.118e+09 ±  2%  numa-vmstat.node0.numa_local
 2.346e+09           -13.3%  2.035e+09 ±  2%     -10.3%  2.105e+09        numa-vmstat.node1.numa_hit
 2.347e+09           -13.3%  2.034e+09 ±  2%     -10.3%  2.105e+09        numa-vmstat.node1.numa_local
      7.86 ±  5%     -29.5%       5.54 ± 34%     -37.0%       4.95 ± 30%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     22.93 ±  4%     -18.5%      18.68 ± 15%     -21.7%      17.96 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      7.86 ±  5%     -30.0%       5.50 ± 34%     -37.0%       4.95 ± 30%  sched_debug.cfs_rq:/.removed.util_avg.avg
     22.93 ±  4%     -19.9%      18.35 ± 14%     -21.7%      17.96 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    149.50 ± 33%     -70.9%      43.57 ±125%     -58.2%      62.42 ± 67%  sched_debug.cfs_rq:/.util_est.min
      1930 ±  4%     -10.5%       1729 ± 16%     -14.9%       1643 ±  6%  sched_debug.cpu.nr_switches.min
   1137116            -1.8%    1116759            -1.8%    1116590        proc-vmstat.nr_anon_pages
      4575            +1.7%       4654            +1.7%       4652        proc-vmstat.nr_page_table_pages
 4.705e+09           -13.0%  4.093e+09           -10.2%  4.224e+09        proc-vmstat.numa_hit
 4.706e+09           -13.0%  4.092e+09           -10.3%  4.223e+09        proc-vmstat.numa_local
 4.645e+09           -12.8%   4.05e+09           -10.1%  4.177e+09        proc-vmstat.pgalloc_normal
 4.631e+09           -12.8%  4.038e+09           -10.1%  4.164e+09        proc-vmstat.pgfault
 4.643e+09           -12.8%  4.049e+09           -10.1%  4.176e+09        proc-vmstat.pgfree
     21.14            -9.9%      19.05            -7.4%      19.58        perf-stat.i.MPKI
 1.468e+10            -7.9%  1.351e+10            -6.2%  1.378e+10        perf-stat.i.branch-instructions
  14349180            -6.2%   13464962            -5.2%   13596701        perf-stat.i.branch-misses
     69.58            -4.6       64.96            -3.2       66.40        perf-stat.i.cache-miss-rate%
  1.57e+09           -17.8%  1.291e+09           -13.6%  1.356e+09 ±  2%  perf-stat.i.cache-misses
 2.252e+09           -11.9%  1.985e+09            -9.4%  2.039e+09        perf-stat.i.cache-references
      3.00           +10.6%       3.32            +8.1%       3.25        perf-stat.i.cpi
     99.00            -0.9%      98.13            -1.1%      97.87        perf-stat.i.cpu-migrations
    143.06           +22.4%     175.18           +16.4%     166.58 ±  2%  perf-stat.i.cycles-between-cache-misses
 7.403e+10            -8.7%   6.76e+10            -6.7%   6.91e+10        perf-stat.i.instructions
      0.34            -9.7%       0.30            -7.6%       0.31        perf-stat.i.ipc
    478.41           -12.7%     417.50           -10.0%     430.74        perf-stat.i.metric.K/sec
  15310132           -12.7%   13361235           -10.0%   13784853        perf-stat.i.minor-faults
  15310132           -12.7%   13361235           -10.0%   13784853        perf-stat.i.page-faults
     21.21           -28.3%      15.20 ± 50%      -7.5%      19.62        perf-stat.overall.MPKI
      0.10            -0.0        0.08 ± 50%      +0.0        0.10        perf-stat.overall.branch-miss-rate%
     69.71           -17.9       51.83 ± 50%      -3.2       66.46        perf-stat.overall.cache-miss-rate%
      3.01           -11.4%       2.67 ± 50%      +8.0%       3.25        perf-stat.overall.cpi
    141.98            -1.2%     140.33 ± 50%     +16.8%     165.83 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.33           -27.7%       0.24 ± 50%      -7.4%       0.31        perf-stat.overall.ipc
   1453908           -16.2%    1218410 ± 50%      +3.6%    1506867        perf-stat.overall.path-length
 1.463e+10           -26.4%  1.077e+10 ± 50%      -6.2%  1.373e+10        perf-stat.ps.branch-instructions
  14253731           -25.1%   10681742 ± 50%      -5.2%   13506212        perf-stat.ps.branch-misses
 1.565e+09           -34.6%  1.023e+09 ± 50%     -13.6%  1.351e+09 ±  2%  perf-stat.ps.cache-misses
 2.245e+09           -29.6%  1.579e+09 ± 50%      -9.4%  2.032e+09        perf-stat.ps.cache-references
 7.378e+10           -27.0%  5.385e+10 ± 50%      -6.7%  6.886e+10        perf-stat.ps.instructions
  15260342           -30.3%   10633461 ± 50%     -10.0%   13738637        perf-stat.ps.minor-faults
  15260342           -30.3%   10633461 ± 50%     -10.0%   13738637        perf-stat.ps.page-faults
 2.237e+13           -27.2%  1.629e+13 ± 50%      -6.9%  2.083e+13        perf-stat.total.instructions
     75.68            -5.4       70.26            -5.0       70.73        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     72.31            -5.1       67.25            -4.7       67.66        perf-profile.calltrace.cycles-pp.testcase
     63.50            -3.9       59.64            -3.7       59.78        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     63.32            -3.8       59.48            -3.7       59.63        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     61.04            -3.6       57.49            -3.5       57.55        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     21.29            -3.5       17.77 ±  2%      -2.8       18.48 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     59.53            -3.3       56.21            -3.3       56.24        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     58.35            -3.2       55.17            -3.2       55.16        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      5.31            -0.8        4.50            -0.7        4.64        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.97            -0.8        4.21            -0.6        4.35        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      4.40            -0.6        3.78 ±  2%      -0.4        3.96 ±  3%  perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.57            -0.6        0.00            -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.63            -0.3        2.29            -0.3        2.36        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      1.82            -0.3        1.49            -0.3        1.55        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.21            -0.3        1.90            -0.2        1.97        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.01            -0.3        1.73 ±  2%      -0.2        1.84 ±  5%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      1.80            -0.3        1.54            -0.2        1.59        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      1.55            -0.2        1.33            -0.2        1.36        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      1.74            -0.2        1.52 ±  2%      -0.2        1.57        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.63 ±  2%      -0.2        0.41 ± 50%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.60            -0.2        1.39 ±  2%      -0.2        1.44        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.29            -0.2        1.11 ±  3%      -0.1        1.19 ±  6%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      1.42            -0.2        1.24 ±  2%      -0.1        1.28 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      1.12            -0.2        0.95 ±  2%      -0.1        0.98        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      1.50            -0.1        1.36 ±  3%      -0.2        1.33 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.72 ±  2%      -0.1        0.60 ±  3%      -0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.98            -0.1        0.87 ±  2%      -0.1        0.90 ±  2%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.92            -0.1        0.81 ±  3%      -0.1        0.84 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.74            -0.1        0.64            -0.1        0.66        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.66            -0.1        0.56 ±  2%      -0.1        0.59        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.64            -0.1        0.56 ±  2%      -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      1.15            -0.1        1.07            -0.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.66            -0.1        0.58 ±  2%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.71            +0.6        3.31 ±  2%      +0.5        3.23        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.71            +0.6        3.31 ±  2%      +0.5        3.23        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.71            +0.6        3.31 ±  2%      +0.5        3.22        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      2.65            +0.6        3.26 ±  2%      +0.5        3.17        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      2.44            +0.6        3.07 ±  2%      +0.5        2.98        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
     24.39            +2.1       26.54 ±  3%      +1.0       25.41 ±  4%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     22.46            +2.3       24.81 ±  4%      +1.2       23.70 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     22.25            +2.4       24.63 ±  4%      +1.3       23.52 ±  5%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     20.38            +2.5       22.84 ±  4%      +1.3       21.71 ±  5%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     20.37            +2.5       22.83 ±  4%      +1.3       21.70 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     20.30            +2.5       22.77 ±  4%      +1.3       21.63 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     22.58            +4.7       27.28 ±  2%      +4.3       26.91        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     20.59            +5.1       25.64 ±  2%      +4.6       25.21        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     20.59            +5.1       25.64 ±  2%      +4.6       25.20        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     20.56            +5.1       25.62 ±  2%      +4.6       25.18        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     20.07            +5.2       25.23 ±  3%      +4.7       24.78        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     18.73            +5.3       24.01 ±  3%      +4.8       23.55        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     25.34            +5.3       30.64 ±  2%      +4.8       30.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +5.3       30.64 ±  2%      +4.8       30.19        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +5.3       30.64 ±  2%      +4.8       30.19        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +5.3       30.64 ±  2%      +4.8       30.19        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +5.3       30.65 ±  2%      +4.9       30.19        perf-profile.calltrace.cycles-pp.__munmap
     25.34            +5.3       30.64 ±  2%      +4.9       30.19        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.33            +5.3       30.64 ±  2%      +4.9       30.18        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     25.33            +5.3       30.64 ±  2%      +4.9       30.19        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     20.36            +5.9       26.30 ±  3%      +5.4       25.74        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     20.35            +5.9       26.29 ±  3%      +5.4       25.73        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     20.28            +6.0       26.24 ±  3%      +5.4       25.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     74.49            -5.3       69.18            -4.9       69.64        perf-profile.children.cycles-pp.testcase
     71.15            -4.8       66.30            -4.5       66.66        perf-profile.children.cycles-pp.asm_exc_page_fault
     63.55            -3.9       59.68            -3.7       59.82        perf-profile.children.cycles-pp.exc_page_fault
     63.38            -3.8       59.54            -3.7       59.68        perf-profile.children.cycles-pp.do_user_addr_fault
     61.10            -3.6       57.54            -3.5       57.61        perf-profile.children.cycles-pp.handle_mm_fault
     21.32            -3.5       17.80 ±  2%      -2.8       18.51 ±  2%  perf-profile.children.cycles-pp.copy_page
     59.57            -3.3       56.24            -3.3       56.27        perf-profile.children.cycles-pp.__handle_mm_fault
     58.44            -3.2       55.25            -3.2       55.25        perf-profile.children.cycles-pp.do_fault
      5.36            -0.8        4.54            -0.7        4.69        perf-profile.children.cycles-pp.__pte_offset_map_lock
      5.02            -0.8        4.25            -0.6        4.38        perf-profile.children.cycles-pp._raw_spin_lock
      4.45            -0.6        3.82 ±  2%      -0.4        4.00 ±  3%  perf-profile.children.cycles-pp.folio_prealloc
      2.64            -0.3        2.30            -0.3        2.37        perf-profile.children.cycles-pp.sync_regs
      1.89            -0.3        1.55            -0.3        1.62        perf-profile.children.cycles-pp.zap_present_ptes
      2.42            -0.3        2.09 ±  2%      -0.3        2.16 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.24            -0.3        1.93            -0.2        2.00        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.07            -0.3        1.77 ±  2%      -0.2        1.88 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.89            -0.3        1.62            -0.2        1.67        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.64            -0.2        1.41            -0.2        1.45        perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.42            -0.2        1.19 ±  2%      -0.2        1.23 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      1.77            -0.2        1.54 ±  2%      -0.2        1.60        perf-profile.children.cycles-pp.__do_fault
      1.62            -0.2        1.41 ±  2%      -0.2        1.46 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      1.25            -0.2        1.05 ±  2%      -0.2        1.08 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      2.04            -0.2        1.83 ±  3%      -0.2        1.82 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.32            -0.2        1.13 ±  2%      -0.1        1.21 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      1.47            -0.2        1.29 ±  2%      -0.1        1.34 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      1.17            -0.2        1.00 ±  2%      -0.1        1.03        perf-profile.children.cycles-pp.get_page_from_freelist
      0.84            -0.2        0.69 ±  2%      -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.61            -0.2        0.46 ±  2%      -0.1        0.48        perf-profile.children.cycles-pp._compound_head
      0.65            -0.1        0.53 ±  2%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      1.02            -0.1        0.90 ±  2%      -0.1        0.93 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.94            -0.1        0.82 ±  3%      -0.1        0.85 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      1.13 ±  2%      -0.1        1.03 ±  3%      -0.1        1.02 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.76            -0.1        0.66            -0.1        0.68        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.20            -0.1        1.11            -0.1        1.12        perf-profile.children.cycles-pp.lru_add_fn
      0.69            -0.1        0.60 ±  2%      -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.47            -0.1        0.38            -0.1        0.40        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.59            -0.1        0.50            -0.1        0.52        perf-profile.children.cycles-pp.free_unref_folios
      0.63 ±  3%      -0.1        0.55 ±  3%      -0.0        0.59 ±  7%  perf-profile.children.cycles-pp.__count_memcg_events
      0.67            -0.1        0.59 ±  2%      -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.54            -0.1        0.47 ±  3%      -0.1        0.49 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.27 ±  3%      -0.1        0.21            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      0.32            -0.1        0.26            -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.22 ±  3%      -0.1        0.17 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.38            -0.0        0.33            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.31            -0.0        0.26            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.31 ±  2%      -0.0        0.27 ±  3%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.get_vma_policy
      0.30            -0.0        0.26 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.handle_pte_fault
      0.28            -0.0        0.25            -0.0        0.26        perf-profile.children.cycles-pp.error_entry
      0.22            -0.0        0.19 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.free_unref_page_commit
      0.28 ±  2%      -0.0        0.25 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.32 ±  2%      -0.0        0.29 ±  2%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.26 ±  2%      -0.0        0.23 ±  5%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.22 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.22 ±  2%      -0.0        0.19 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.14 ±  2%      -0.0        0.11            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.14 ±  3%      -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.perf_exclude_event
      0.18            -0.0        0.15 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.26 ±  3%      -0.0        0.23 ±  5%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.26 ±  3%      -0.0        0.23            -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.25 ±  3%      -0.0        0.22            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.18 ±  2%      -0.0        0.15 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.16 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.uncharge_folio
      0.19 ±  2%      -0.0        0.17 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.17 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.folio_unlock
      0.19 ±  2%      -0.0        0.17 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.down_read_trylock
      0.16            -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.folio_put
      0.14 ±  2%      -0.0        0.12 ±  6%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.11 ±  3%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.xas_start
      0.13 ±  3%      -0.0        0.11 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.18 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.18 ±  2%      -0.0        0.16 ±  2%      -0.0        0.17        perf-profile.children.cycles-pp.up_read
      0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.14            -0.0        0.12 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.policy_nodemask
      0.08            -0.0        0.06 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.memcg_check_events
      0.13 ±  3%      -0.0        0.11            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.access_error
      0.12 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.perf_swevent_event
      0.09 ±  4%      -0.0        0.08            -0.0        0.08        perf-profile.children.cycles-pp.__irqentry_text_end
      0.06            -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.pte_alloc_one
      0.05            +0.0        0.06            +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.perf_mmap__push
      0.19 ±  2%      +0.2        0.35 ±  4%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      2.72            +0.6        3.32 ±  2%      +0.5        3.24        perf-profile.children.cycles-pp.tlb_finish_mmu
     24.44            +2.1       26.58 ±  3%      +1.0       25.45 ±  4%  perf-profile.children.cycles-pp.set_pte_range
     22.47            +2.3       24.81 ±  4%      +1.2       23.71 ±  4%  perf-profile.children.cycles-pp.folio_add_lru_vma
     22.31            +2.4       24.70 ±  4%      +1.3       23.58 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.children.cycles-pp.unmap_page_range
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.children.cycles-pp.unmap_vmas
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.children.cycles-pp.zap_pmd_range
     22.59            +4.7       27.29 ±  2%      +4.3       26.92        perf-profile.children.cycles-pp.zap_pte_range
     20.59            +5.1       25.64 ±  2%      +4.6       25.21        perf-profile.children.cycles-pp.tlb_flush_mmu
     25.34            +5.3       30.64 ±  2%      +4.9       30.19        perf-profile.children.cycles-pp.__vm_munmap
     25.34            +5.3       30.64 ±  2%      +4.9       30.19        perf-profile.children.cycles-pp.__x64_sys_munmap
     25.34            +5.3       30.65 ±  2%      +4.9       30.19        perf-profile.children.cycles-pp.__munmap
     25.34            +5.3       30.65 ±  2%      +4.9       30.20        perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.34            +5.3       30.65 ±  2%      +4.9       30.20        perf-profile.children.cycles-pp.do_vmi_munmap
     25.46            +5.3       30.77 ±  2%      +4.9       30.32        perf-profile.children.cycles-pp.do_syscall_64
     25.33            +5.3       30.64 ±  2%      +4.9       30.19        perf-profile.children.cycles-pp.unmap_region
     25.46            +5.3       30.77 ±  2%      +4.9       30.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.30            +5.7       28.96 ±  2%      +5.1       28.44        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     23.29            +5.7       28.95 ±  2%      +5.1       28.43        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     23.00            +5.7       28.73 ±  2%      +5.2       28.20        perf-profile.children.cycles-pp.folios_put_refs
     21.22            +5.9       27.13 ±  3%      +5.4       26.57        perf-profile.children.cycles-pp.__page_cache_release
     40.79            +8.4       49.20            +6.7       47.50 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     40.78            +8.4       49.19            +6.7       47.49 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     40.64            +8.4       49.09            +6.7       47.38 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     21.23            -3.5       17.73 ±  2%      -2.8       18.43 ±  2%  perf-profile.self.cycles-pp.copy_page
      4.99            -0.8        4.22            -0.6        4.36        perf-profile.self.cycles-pp._raw_spin_lock
      5.21            -0.7        4.53            -0.5        4.68        perf-profile.self.cycles-pp.testcase
      2.63            -0.3        2.29            -0.3        2.37 ±  2%  perf-profile.self.cycles-pp.sync_regs
      2.42            -0.3        2.09 ±  2%      -0.3        2.16 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.00            -0.2        0.83 ±  2%      -0.1        0.87 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.58 ±  2%      -0.1        0.43 ±  3%      -0.1        0.46        perf-profile.self.cycles-pp._compound_head
      0.93 ±  2%      -0.1        0.80 ±  3%      -0.1        0.84 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.61            -0.1        0.50 ±  3%      -0.1        0.51 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.51            -0.1        0.40 ±  2%      -0.1        0.42        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.80            -0.1        0.70 ±  2%      -0.1        0.72        perf-profile.self.cycles-pp.__handle_mm_fault
      0.61 ±  2%      -0.1        0.51            -0.1        0.54        perf-profile.self.cycles-pp.lru_add_fn
      0.47            -0.1        0.39 ±  2%      -0.1        0.41        perf-profile.self.cycles-pp.get_page_from_freelist
      0.93 ±  2%      -0.1        0.86 ±  3%      -0.1        0.85 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.45            -0.1        0.38            -0.1        0.40        perf-profile.self.cycles-pp.zap_present_ptes
      0.65            -0.1        0.58 ±  2%      -0.1        0.60 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.89 ±  2%      -0.1        0.83 ±  3%      -0.1        0.83 ±  2%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.44            -0.1        0.39            -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.52 ±  3%      -0.1        0.46 ±  5%      -0.0        0.49 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
      0.46            -0.1        0.41 ±  3%      -0.0        0.41 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.44            -0.1        0.38 ±  3%      -0.0        0.40 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.32            -0.0        0.27            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.34 ±  3%      -0.0        0.29 ±  3%      -0.0        0.29 ±  2%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.39            -0.0        0.35 ±  3%      -0.0        0.36 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.20 ±  4%      -0.0        0.15 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.27 ±  3%      -0.0        0.22 ±  2%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.rmqueue
      0.29            -0.0        0.25            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.27            -0.0        0.23 ±  2%      -0.0        0.24        perf-profile.self.cycles-pp.free_unref_folios
      0.24            -0.0        0.20            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.26            -0.0        0.22 ±  4%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.30            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.23 ±  3%      -0.0        0.20 ±  3%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.22            -0.0        0.19 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.19 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.13 ±  3%      -0.0        0.10 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.25            -0.0        0.22 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.error_entry
      0.23 ±  2%      -0.0        0.20 ±  2%      -0.0        0.21        perf-profile.self.cycles-pp.do_fault
      0.21 ±  2%      -0.0        0.19 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.19 ±  2%      -0.0        0.16 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.folio_add_lru_vma
      0.18            -0.0        0.15 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.15 ±  2%      -0.0        0.13 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.uncharge_folio
      0.12 ±  3%      -0.0        0.10            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.perf_exclude_event
      0.19 ±  2%      -0.0        0.17 ±  3%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.get_vma_policy
      0.24            -0.0        0.22            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.14 ±  2%      -0.0        0.12            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.11 ±  3%      -0.0        0.09 ±  5%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.11 ±  3%      -0.0        0.09            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.15 ±  2%      -0.0        0.13 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  4%      -0.0        0.15            -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.15 ±  2%      -0.0        0.13            -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.folio_put
      0.18            -0.0        0.16 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.down_read_trylock
      0.21 ±  3%      -0.0        0.19 ±  4%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.finish_fault
      0.17 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15        perf-profile.self.cycles-pp.__perf_sw_event
      0.19 ±  2%      -0.0        0.17 ±  2%      -0.0        0.18        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.16 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.22 ±  3%      -0.0        0.20 ±  4%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map
      0.16 ±  2%      -0.0        0.15 ±  5%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.shmem_fault
      0.17 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.up_read
      0.10            -0.0        0.08 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.11            -0.0        0.09 ±  5%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.perf_swevent_event
      0.10 ±  3%      -0.0        0.09 ±  5%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.11            -0.0        0.09 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.10 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.10 ±  4%      -0.0        0.08 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__do_fault
      0.12 ±  3%      -0.0        0.10 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.exc_page_fault
      0.12 ±  3%      -0.0        0.11 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.12 ±  3%      -0.0        0.10 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.access_error
      0.09 ±  5%      -0.0        0.08            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.policy_nodemask
      0.12 ±  4%      -0.0        0.10 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.09            -0.0        0.08 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.10            -0.0        0.09            -0.0        0.09        perf-profile.self.cycles-pp.folio_prealloc
      0.09            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.__cond_resched
      0.06            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.vm_normal_page
      0.38 ±  2%      +0.1        0.44            +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.18 ±  2%      +0.2        0.34 ±  4%      +0.1        0.29 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
     40.64            +8.4       49.08            +6.7       47.38 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


[3]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   1727628 ± 22%     -24.1%    1310525 ±  7%      -5.3%    1636459 ± 30%  sched_debug.cpu.avg_idle.max
      6058 ± 41%     -47.9%       3156 ± 43%      +1.0%       6121 ± 61%  sched_debug.cpu.max_idle_balance_cost.stddev
     35617 ±  5%      -9.1%      32375 ± 21%     -26.2%      26270 ± 25%  numa-vmstat.node0.nr_slab_reclaimable
   4024866            +3.4%    4163009 ±  7%      +8.7%    4374953 ±  7%  numa-vmstat.node1.nr_file_pages
     19132 ± 10%     +17.3%      22446 ± 30%     +49.4%      28587 ± 23%  numa-vmstat.node1.nr_slab_reclaimable
  17488267            -5.6%   16505101            -6.5%   16346741        will-it-scale.224.processes
     78072            -5.6%      73683            -6.5%      72975        will-it-scale.per_process_ops
  17488267            -5.6%   16505101            -6.5%   16346741        will-it-scale.workload
    142458 ±  5%      -9.1%     129506 ± 21%     -26.2%     105066 ± 25%  numa-meminfo.node0.KReclaimable
    142458 ±  5%      -9.1%     129506 ± 21%     -26.2%     105066 ± 25%  numa-meminfo.node0.SReclaimable
  16107004            +3.3%   16635393 ±  7%      +8.6%   17491995 ±  7%  numa-meminfo.node1.FilePages
     76509 ± 10%     +17.4%      89791 ± 30%     +49.4%     114321 ± 23%  numa-meminfo.node1.KReclaimable
     76509 ± 10%     +17.4%      89791 ± 30%     +49.4%     114321 ± 23%  numa-meminfo.node1.SReclaimable
 5.296e+09            -5.6%  4.998e+09            -6.5%  4.949e+09        proc-vmstat.numa_hit
 5.291e+09            -5.6%  4.995e+09            -6.5%  4.947e+09        proc-vmstat.numa_local
 5.285e+09            -5.6%  4.989e+09            -6.5%  4.941e+09        proc-vmstat.pgalloc_normal
 5.264e+09            -5.6%  4.969e+09            -6.5%  4.921e+09        proc-vmstat.pgfault
 5.283e+09            -5.6%  4.989e+09            -6.5%  4.941e+09        proc-vmstat.pgfree
     20.16            -2.9%      19.58            -3.3%      19.50        perf-stat.i.MPKI
 2.501e+10            -2.4%   2.44e+10            -2.9%  2.428e+10        perf-stat.i.branch-instructions
  18042153            -2.8%   17539874            -3.8%   17362741        perf-stat.i.branch-misses
 2.382e+09            -5.6%  2.249e+09            -6.5%  2.228e+09        perf-stat.i.cache-misses
 2.561e+09            -5.3%  2.424e+09            -6.5%  2.394e+09        perf-stat.i.cache-references
      5.49            +2.8%       5.64            +3.3%       5.67        perf-stat.i.cpi
    274.25            +5.4%     289.07            +6.4%     291.86        perf-stat.i.cycles-between-cache-misses
 1.177e+11            -2.7%  1.145e+11            -3.2%  1.139e+11        perf-stat.i.instructions
      0.19            -2.7%       0.18            -3.2%       0.18        perf-stat.i.ipc
    155.11            -5.5%     146.59            -6.5%     145.09        perf-stat.i.metric.K/sec
  17405977            -5.5%   16441964            -6.5%   16274188        perf-stat.i.minor-faults
  17405978            -5.5%   16441964            -6.5%   16274188        perf-stat.i.page-faults
      4.41 ± 50%     +28.5%       5.66           +29.1%       5.69        perf-stat.overall.cpi
    217.50 ± 50%     +32.4%     287.87           +33.6%     290.48        perf-stat.overall.cycles-between-cache-misses
   1623235 ± 50%     +29.0%    2093187           +29.6%    2103156        perf-stat.overall.path-length
      5.48            -0.4        5.11            -0.4        5.11        perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     57.55            -0.3       57.20            -0.1       57.48        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     56.14            -0.2       55.90            +0.0       56.16        perf-profile.calltrace.cycles-pp.testcase
      1.86            -0.2        1.71            -0.1        1.73        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.77            -0.1        1.63            -0.1        1.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      1.17            -0.1        1.10            -0.1        1.08        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     51.87            -0.0       51.82            +0.2       52.11        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.96            -0.0        0.91            -0.1        0.91        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.71            -0.0        0.67            -0.0        0.66        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.60            -0.0        0.57            -0.0        0.56        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
     51.39            -0.0       51.37            +0.3       51.67        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     51.03            +0.0       51.03            +0.3       51.33        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.86            +0.0        4.91            +0.0        4.90        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      4.87            +0.0        4.91            +0.0        4.90        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      4.86            +0.0        4.91            +0.0        4.90        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      4.85            +0.0        4.90            +0.0        4.88        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      4.77            +0.1        4.82            +0.0        4.81        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     37.73            +0.3       38.01            +0.0       37.74        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     37.27            +0.3       37.57            +0.0       37.30        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     37.28            +0.3       37.58            +0.0       37.31        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     37.28            +0.3       37.58            +0.0       37.31        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     37.15            +0.3       37.46            +0.0       37.20        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.72            +0.3       37.04            +0.1       36.79        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     42.65            +0.3       42.97            +0.0       42.69        perf-profile.calltrace.cycles-pp.__munmap
     42.65            +0.3       42.97            +0.0       42.69        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.97            +0.0       42.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     41.26            +0.4       41.63            +0.1       41.38        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     41.26            +0.4       41.64            +0.1       41.38        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     41.23            +0.4       41.61            +0.1       41.36        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     43.64            +0.5       44.12            +0.8       44.42        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     41.57            +0.6       42.22            +0.9       42.50        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     40.93            +0.7       41.59            +1.0       41.90        perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     40.84            +0.7       41.50            +1.0       41.81        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     40.19            +0.7       40.89            +1.0       41.19        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     40.19            +0.7       40.89            +1.0       41.19        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     40.16            +0.7       40.87            +1.0       41.16        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      5.49            -0.4        5.12            -0.4        5.12        perf-profile.children.cycles-pp.copy_page
     57.05            -0.3       56.75            -0.0       57.02        perf-profile.children.cycles-pp.testcase
     55.66            -0.2       55.41            +0.0       55.70        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.88            -0.2        1.73            -0.1        1.75        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.79            -0.1        1.64            -0.1        1.66        perf-profile.children.cycles-pp._raw_spin_lock
      1.19            -0.1        1.11            -0.1        1.10        perf-profile.children.cycles-pp.folio_prealloc
      0.96            -0.1        0.91            -0.1        0.91        perf-profile.children.cycles-pp.sync_regs
     51.89            -0.0       51.84            +0.2       52.13        perf-profile.children.cycles-pp.handle_mm_fault
      0.73            -0.0        0.68            -0.0        0.68        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      1.02            -0.0        0.98            -0.1        0.96        perf-profile.children.cycles-pp.native_irq_return_iret
      0.63            -0.0        0.59            -0.0        0.59        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.55            -0.0        0.51            -0.0        0.51        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.51            -0.0        0.48            -0.0        0.48        perf-profile.children.cycles-pp.__do_fault
      0.46            -0.0        0.43            -0.0        0.44        perf-profile.children.cycles-pp.shmem_fault
      0.41            -0.0        0.39            -0.0        0.38        perf-profile.children.cycles-pp.get_page_from_freelist
      0.51            -0.0        0.48            -0.0        0.50        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.36            -0.0        0.34            -0.0        0.34        perf-profile.children.cycles-pp.___perf_sw_event
      0.42            -0.0        0.39            -0.0        0.39        perf-profile.children.cycles-pp.__perf_sw_event
      0.42            -0.0        0.40            -0.0        0.40        perf-profile.children.cycles-pp.zap_present_ptes
      0.26            -0.0        0.24            -0.0        0.24        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.38            -0.0        0.36            -0.0        0.36        perf-profile.children.cycles-pp.lru_add_fn
      0.25 ±  2%      -0.0        0.23            -0.0        0.24        perf-profile.children.cycles-pp.filemap_get_entry
      0.21 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.21            -0.0        0.19 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     51.40            -0.0       51.39            +0.3       51.68        perf-profile.children.cycles-pp.__handle_mm_fault
      0.23 ±  2%      -0.0        0.21            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.39            -0.0        0.38            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.16 ±  2%      -0.0        0.15 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.11            -0.0        0.10            -0.0        0.10 ±  5%  perf-profile.children.cycles-pp._compound_head
      0.17 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.16            -0.0        0.15            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.27            -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.11            -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.update_process_times
      0.09            -0.0        0.08            -0.0        0.08        perf-profile.children.cycles-pp.scheduler_tick
      0.06            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.task_tick_fair
      0.12            -0.0        0.11            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.15            -0.0        0.14            -0.0        0.14        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.11 ±  4%      -0.0        0.10            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
     51.07            -0.0       51.06            +0.3       51.36        perf-profile.children.cycles-pp.do_fault
      0.08            -0.0        0.08 ±  6%      -0.0        0.07        perf-profile.children.cycles-pp.page_counter_uncharge
      0.06            -0.0        0.06 ±  6%      +0.0        0.07        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.15 ±  2%      +0.0        0.16 ±  6%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
      0.07            +0.0        0.08            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.folio_add_lru
      0.09 ±  4%      +0.0        0.10 ±  3%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.shmem_write_begin
      4.88            +0.0        4.93            +0.0        4.91        perf-profile.children.cycles-pp.tlb_finish_mmu
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.children.cycles-pp.unmap_page_range
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.children.cycles-pp.unmap_vmas
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.children.cycles-pp.zap_pmd_range
     37.74            +0.3       38.01            -0.0       37.74        perf-profile.children.cycles-pp.zap_pte_range
     37.28            +0.3       37.58            +0.0       37.31        perf-profile.children.cycles-pp.tlb_flush_mmu
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.children.cycles-pp.__x64_sys_munmap
     42.65            +0.3       42.97            +0.0       42.68        perf-profile.children.cycles-pp.__vm_munmap
     42.65            +0.3       42.97            +0.0       42.69        perf-profile.children.cycles-pp.__munmap
     42.65            +0.3       42.98            +0.0       42.69        perf-profile.children.cycles-pp.do_vmi_align_munmap
     42.65            +0.3       42.98            +0.0       42.69        perf-profile.children.cycles-pp.do_vmi_munmap
     42.86            +0.3       43.18            +0.1       42.91        perf-profile.children.cycles-pp.do_syscall_64
     42.65            +0.3       42.97            +0.0       42.69        perf-profile.children.cycles-pp.unmap_region
     42.86            +0.3       43.19            +0.1       42.91        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.15            +0.3       42.50            +0.1       42.22        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     42.12            +0.3       42.46            +0.1       42.19        perf-profile.children.cycles-pp.folios_put_refs
     42.15            +0.3       42.50            +0.1       42.22        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     41.51            +0.4       41.89            +0.1       41.63        perf-profile.children.cycles-pp.__page_cache_release
     43.66            +0.5       44.15            +0.8       44.45        perf-profile.children.cycles-pp.finish_fault
     41.59            +0.6       42.24            +0.9       42.52        perf-profile.children.cycles-pp.set_pte_range
     40.94            +0.7       41.59            +1.0       41.90        perf-profile.children.cycles-pp.folio_add_lru_vma
     40.99            +0.7       41.66            +1.0       41.97        perf-profile.children.cycles-pp.folio_batch_move_lru
     81.57            +1.1       82.65            +1.1       82.68        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     81.59            +1.1       82.68            +1.1       82.72        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     81.60            +1.1       82.68            +1.1       82.72        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      5.47            -0.4        5.10            -0.4        5.11        perf-profile.self.cycles-pp.copy_page
      1.77            -0.1        1.63            -0.1        1.64        perf-profile.self.cycles-pp._raw_spin_lock
      2.19            -0.1        2.07            -0.1        2.06        perf-profile.self.cycles-pp.testcase
      0.96            -0.0        0.91            -0.1        0.90        perf-profile.self.cycles-pp.sync_regs
      1.02            -0.0        0.98            -0.1        0.96        perf-profile.self.cycles-pp.native_irq_return_iret
      0.28            -0.0        0.26            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.19 ±  2%      -0.0        0.17            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.20            -0.0        0.19 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.12 ±  4%      -0.0        0.10            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.filemap_get_entry
      0.11 ±  3%      -0.0        0.10            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.21            -0.0        0.20            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.16            -0.0        0.15            -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.mas_walk
      0.09            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.06            -0.0        0.05            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.down_read_trylock
      0.18            -0.0        0.17 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.lru_add_fn
      0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp._compound_head
     81.57            +1.1       82.65            +1.1       82.68        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


[4]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-csl-d02/page_fault2/will-it-scale

59142d87ab03b8ff a94032b35e5f97dc1023030d929 fd2296741e2686ed6ecd05187e4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     13383           -14.7%      11416           -10.2%      12023        perf-c2c.DRAM.local
    878.00 ±  4%     +39.1%       1221 ±  6%     +11.3%     977.00 ±  4%  perf-c2c.HITM.local
      0.54 ±  3%      -0.1        0.43 ±  2%      -0.1        0.47 ±  2%  mpstat.cpu.all.irq%
      0.04 ±  6%      -0.0        0.03            +0.0        0.04 ± 11%  mpstat.cpu.all.soft%
      8.44 ±  2%      -1.1        7.32            -0.9        7.53        mpstat.cpu.all.usr%
     59743 ± 11%     -22.9%      46054 ±  7%     -15.0%      50754 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     59744 ± 11%     -22.9%      46054 ±  7%     -15.0%      50754 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      3843 ±  4%     -28.8%       2737 ±  8%     -14.2%       3296 ± 10%  sched_debug.cpu.nr_switches.min
   6749425           -19.4%    5441878           -12.1%    5929733        will-it-scale.36.processes
    187483           -19.4%     151162           -12.1%     164714        will-it-scale.per_process_ops
   6749425           -19.4%    5441878           -12.1%    5929733        will-it-scale.workload
    734606            -2.1%     718878            -1.8%     721386        proc-vmstat.nr_anon_pages
      9660            -4.0%       9278            -2.9%       9383        proc-vmstat.nr_mapped
      2999            +3.2%       3095            +2.3%       3069        proc-vmstat.nr_page_table_pages
 2.043e+09           -19.3%  1.649e+09           -12.0%  1.799e+09        proc-vmstat.numa_hit
 2.049e+09           -19.3%  1.653e+09           -12.0%  1.803e+09        proc-vmstat.numa_local
 2.036e+09           -19.2%  1.644e+09           -12.0%  1.791e+09        proc-vmstat.pgalloc_normal
 2.029e+09           -19.3%  1.639e+09           -12.0%  1.785e+09        proc-vmstat.pgfault
 2.035e+09           -19.2%  1.644e+09           -12.0%  1.791e+09        proc-vmstat.pgfree
     21123 ±  2%      +3.4%      21833            +3.9%      21942        proc-vmstat.pgreuse
     17.45            -8.6%      15.96            -6.0%      16.41        perf-stat.i.MPKI
 6.199e+09           -10.2%  5.567e+09            -5.5%  5.856e+09        perf-stat.i.branch-instructions
      0.26            -0.0        0.25            -0.0        0.25        perf-stat.i.branch-miss-rate%
  16660671           -10.6%   14902193            -7.3%   15444974        perf-stat.i.branch-misses
     87.85            -2.9       84.90            -2.8       85.02        perf-stat.i.cache-miss-rate%
 5.476e+08           -19.5%  4.407e+08           -12.3%  4.805e+08        perf-stat.i.cache-misses
 6.227e+08           -16.7%  5.186e+08            -9.3%  5.647e+08        perf-stat.i.cache-references
      4.35           +14.1%       4.96            +7.6%       4.68        perf-stat.i.cpi
     61.84 ±  2%     -16.2%      51.79           -14.1%      53.13        perf-stat.i.cpu-migrations
    251.09           +24.4%     312.35           +14.2%     286.75        perf-stat.i.cycles-between-cache-misses
 3.137e+10           -11.8%  2.768e+10            -6.6%  2.931e+10        perf-stat.i.instructions
      0.23           -11.7%       0.21            -6.5%       0.22        perf-stat.i.ipc
    373.37           -19.3%     301.36           -12.0%     328.39        perf-stat.i.metric.K/sec
   6720929           -19.3%    5424836           -12.0%    5911373        perf-stat.i.minor-faults
   6720929           -19.3%    5424836           -12.0%    5911373        perf-stat.i.page-faults
     17.45            -8.8%      15.92            -6.1%      16.39        perf-stat.overall.MPKI
      0.27            -0.0        0.27            -0.0        0.26        perf-stat.overall.branch-miss-rate%
     87.94            -3.0       84.96            -2.9       85.08        perf-stat.overall.cache-miss-rate%
      4.35           +13.4%       4.93            +7.1%       4.65        perf-stat.overall.cpi
    249.03           +24.3%     309.56           +14.0%     283.85        perf-stat.overall.cycles-between-cache-misses
      0.23           -11.8%       0.20            -6.6%       0.21        perf-stat.overall.ipc
   1400364            +9.4%    1532615            +6.5%    1491568        perf-stat.overall.path-length
 6.178e+09           -10.2%  5.548e+09            -5.5%  5.835e+09        perf-stat.ps.branch-instructions
  16578081           -10.7%   14811244            -7.4%   15346617        perf-stat.ps.branch-misses
 5.458e+08           -19.5%  4.392e+08           -12.3%  4.788e+08        perf-stat.ps.cache-misses
 6.206e+08           -16.7%  5.169e+08            -9.3%  5.628e+08        perf-stat.ps.cache-references
     61.60 ±  2%     -16.3%      51.58           -14.2%      52.85        perf-stat.ps.cpu-migrations
 3.127e+10           -11.8%  2.758e+10            -6.6%  2.921e+10        perf-stat.ps.instructions
   6698560           -19.3%    5406176           -12.1%    5890997        perf-stat.ps.minor-faults
   6698560           -19.3%    5406177           -12.1%    5890998        perf-stat.ps.page-faults
 9.451e+12           -11.8%   8.34e+12            -6.4%  8.845e+12        perf-stat.total.instructions
     78.09           -11.0       67.12            -7.4       70.68        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     84.87 ±  2%     -10.3       74.55            -6.9       77.97        perf-profile.calltrace.cycles-pp.testcase
     68.48 ±  2%      -9.3       59.13            -6.2       62.28        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     68.26 ±  2%      -9.3       58.94            -6.2       62.08        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     65.58 ±  2%      -8.7       56.90            -5.7       59.92        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     64.14 ±  2%      -8.5       55.61            -5.6       58.59        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     63.24 ±  2%      -8.4       54.84            -5.5       57.78        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     40.12 ±  4%      -4.1       36.02            -2.9       37.23        perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     15.19 ±  3%      -3.5       11.73            -1.9       13.28        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      9.10 ±  8%      -3.1        6.01 ±  2%      -1.9        7.16 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      8.89 ±  8%      -3.1        5.83 ±  3%      -1.9        6.96 ±  3%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     10.98 ±  6%      -3.0        7.97 ±  2%      -1.6        9.38 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      7.41 ± 10%      -2.9        4.49 ±  4%      -1.9        5.50 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
      7.42 ± 10%      -2.9        4.51 ±  4%      -1.9        5.52 ±  4%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      7.35 ± 10%      -2.9        4.44 ±  4%      -1.9        5.45 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      2.14 ± 15%      -1.4        0.70 ±  6%      -1.2        0.93 ±  3%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      3.15 ± 11%      -1.3        1.84            -1.2        1.96        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.60 ±  3%      -0.4        3.16            -0.3        3.28        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.88            -0.4        3.46            -0.4        3.50        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.29            -0.4        0.87            -0.4        0.92        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      3.09 ±  3%      -0.4        2.68            -0.3        2.81        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      0.96            -0.3        0.62 ±  2%      -0.3        0.65        perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.45 ±  3%      -0.3        3.12            -0.2        3.24        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.31 ±  3%      -0.3        3.00            -0.2        3.11        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.09 ±  3%      -0.3        2.80            -0.2        2.90        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      2.42            -0.3        2.16            -0.3        2.14        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.72 ±  4%      -0.2        2.50            -0.1        2.58        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      1.55 ±  2%      -0.2        1.33            -0.2        1.38        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.87            -0.2        0.72            -0.1        0.79        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      1.39 ±  3%      -0.1        1.25 ±  3%      -0.1        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.81            -0.1        0.70 ±  2%      -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.74            -0.1        1.63            -0.1        1.62        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.85 ±  2%      -0.1        0.74 ±  3%      -0.1        0.78        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.71            -0.1        0.62            -0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.01 ±  4%      -0.1        0.93 ±  2%      -0.1        0.94        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.72 ±  2%      -0.1        0.64 ±  3%      -0.0        0.67        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.56            -0.1        1.50            -0.1        1.48        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      0.35 ± 81%      +0.1        0.44 ± 50%      +0.3        0.68 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault
      0.77 ±  2%      +0.1        0.87 ±  2%      +0.0        0.80 ±  2%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      1.47 ±  2%      +0.2        1.63 ±  6%      +0.4        1.90 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.62 ±  5%      +0.2        0.84 ±  2%      +0.1        0.69 ±  2%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.7        0.68 ±  3%      +0.4        0.35 ± 70%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      1.66 ± 12%      +1.2        2.86            +0.8        2.50        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.66 ± 12%      +1.2        2.86            +0.8        2.49        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      1.66 ± 12%      +1.2        2.86            +0.8        2.49        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.51 ± 15%      +1.3        2.80            +0.9        2.41        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      1.31 ± 18%      +1.3        2.64 ±  2%      +0.9        2.25        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     16.09 ±  9%      +9.5       25.62 ±  2%      +6.4       22.49        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     17.82 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.calltrace.cycles-pp.__munmap
     17.81 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     17.81 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.81 ± 10%     +10.7       28.53            +7.2       25.02        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     17.82 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     17.82 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     17.81 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     17.79 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     12.80 ± 15%     +10.9       23.68 ±  2%      +7.6       20.42        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     12.78 ± 15%     +10.9       23.68 ±  2%      +7.6       20.41        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     12.77 ± 15%     +10.9       23.67 ±  2%      +7.6       20.40        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     11.49 ± 18%     +11.7       23.22 ±  2%      +8.3       19.79        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     10.49 ± 20%     +11.9       22.36 ±  2%      +8.4       18.90        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     11.02 ± 22%     +13.4       24.43 ±  2%      +9.4       20.44        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     11.03 ± 22%     +13.4       24.46 ±  2%      +9.4       20.46        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     10.97 ± 22%     +13.4       24.41 ±  2%      +9.4       20.40        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     81.97 ±  2%     -10.7       71.28            -7.2       74.78        perf-profile.children.cycles-pp.testcase
     74.32 ±  2%     -10.3       64.01            -6.9       67.40        perf-profile.children.cycles-pp.asm_exc_page_fault
     68.51 ±  2%      -9.4       59.15            -6.2       62.30        perf-profile.children.cycles-pp.exc_page_fault
     68.29 ±  2%      -9.3       58.97            -6.2       62.11        perf-profile.children.cycles-pp.do_user_addr_fault
     65.61 ±  2%      -8.7       56.92            -5.7       59.95        perf-profile.children.cycles-pp.handle_mm_fault
     64.16 ±  2%      -8.5       55.63            -5.6       58.60        perf-profile.children.cycles-pp.__handle_mm_fault
     63.27 ±  2%      -8.4       54.87            -5.5       57.82        perf-profile.children.cycles-pp.do_fault
     40.21 ±  4%      -4.1       36.11            -2.9       37.33        perf-profile.children.cycles-pp.copy_page
     15.21 ±  3%      -3.5       11.75            -1.9       13.30        perf-profile.children.cycles-pp.finish_fault
      9.10 ±  8%      -3.1        6.02 ±  2%      -1.9        7.16 ±  3%  perf-profile.children.cycles-pp.folio_add_lru_vma
      8.91 ±  8%      -3.0        5.87 ±  3%      -1.9        6.99 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
     10.99 ±  6%      -3.0        7.98 ±  2%      -1.6        9.40 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      2.16 ± 15%      -1.4        0.71 ±  6%      -1.2        0.94 ±  4%  perf-profile.children.cycles-pp._compound_head
      3.17 ± 11%      -1.3        1.85            -1.2        1.98        perf-profile.children.cycles-pp.zap_present_ptes
      3.63 ±  3%      -0.5        3.17            -0.3        3.30        perf-profile.children.cycles-pp.__pte_offset_map_lock
      3.14 ±  3%      -0.4        2.71            -0.3        2.85        perf-profile.children.cycles-pp._raw_spin_lock
      1.30            -0.4        0.88            -0.4        0.93        perf-profile.children.cycles-pp.lock_vma_under_rcu
      3.90            -0.4        3.49            -0.4        3.53        perf-profile.children.cycles-pp.folio_prealloc
      0.97            -0.3        0.62 ±  2%      -0.3        0.66        perf-profile.children.cycles-pp.mas_walk
      3.46 ±  3%      -0.3        3.13            -0.2        3.25        perf-profile.children.cycles-pp.__do_fault
      3.31 ±  3%      -0.3        3.00            -0.2        3.12        perf-profile.children.cycles-pp.shmem_fault
      6.74 ±  4%      -0.3        6.44            -0.2        6.53        perf-profile.children.cycles-pp.native_irq_return_iret
      3.10 ±  3%      -0.3        2.82            -0.2        2.92        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      2.43            -0.3        2.17            -0.3        2.15        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      1.60 ±  2%      -0.2        1.37            -0.2        1.42        perf-profile.children.cycles-pp.sync_regs
      2.73 ±  4%      -0.2        2.51            -0.1        2.58        perf-profile.children.cycles-pp.filemap_get_entry
      1.66            -0.2        1.44 ±  2%      -0.1        1.51        perf-profile.children.cycles-pp.__perf_sw_event
      0.64 ±  4%      -0.2        0.44 ±  2%      -0.1        0.53        perf-profile.children.cycles-pp.free_unref_folios
      1.45            -0.2        1.28 ±  2%      -0.1        1.33        perf-profile.children.cycles-pp.___perf_sw_event
      0.88            -0.2        0.73            -0.1        0.80        perf-profile.children.cycles-pp.lru_add_fn
      1.40 ±  3%      -0.1        1.26 ±  3%      -0.1        1.31 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.23 ±  9%      -0.1        1.09 ±  8%      +0.2        1.41 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.83            -0.1        1.71            -0.1        1.69        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.58 ±  7%      -0.1        0.47 ±  5%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.69 ±  3%      -0.1        0.59            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.33 ±  5%      -0.1        0.22 ±  2%      -0.1        0.27        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.51 ±  5%      -0.1        0.42 ±  7%      -0.1        0.46 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.53            -0.1        0.44 ±  3%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.get_vma_policy
      1.02 ±  4%      -0.1        0.93 ±  3%      -0.1        0.94        perf-profile.children.cycles-pp.xas_load
      0.58 ±  3%      -0.1        0.50 ±  2%      -0.0        0.54 ±  5%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.57 ±  6%      -0.1        0.50 ±  3%      -0.0        0.53 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.48 ±  7%      -0.1        0.40 ±  4%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.23 ±  5%      -0.1        0.16 ±  4%      -0.0        0.19        perf-profile.children.cycles-pp.free_unref_page_commit
      0.43 ±  7%      -0.1        0.36 ±  3%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.43 ±  6%      -0.1        0.36 ±  3%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.16 ±  4%      -0.1        0.10            -0.0        0.12        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.15 ±  9%      -0.1        0.09 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.uncharge_batch
      0.30 ±  6%      -0.1        0.24 ±  4%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.37 ±  7%      -0.1        0.31 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.27 ±  8%      -0.1        0.22 ±  4%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.update_process_times
      1.64            -0.1        1.59            -0.1        1.56        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.30 ±  9%      -0.0        0.25 ± 28%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.16 ±  6%      -0.0        0.12 ±  3%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.25            -0.0        0.20            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
      0.11 ± 11%      -0.0        0.07 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.page_counter_uncharge
      0.20 ±  5%      -0.0        0.16 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.22 ±  3%      -0.0        0.19 ±  4%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.error_entry
      0.10 ±  3%      -0.0        0.07 ±  7%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.policy_nodemask
      0.16 ±  3%      -0.0        0.12 ±  3%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.15 ±  5%      -0.0        0.12 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.uncharge_folio
      0.22 ±  3%      -0.0        0.19 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.17 ±  9%      -0.0        0.14 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  5%      -0.0        0.16 ±  5%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.up_read
      0.19 ±  2%      -0.0        0.16 ±  7%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.shmem_get_policy
      0.14 ±  4%      -0.0        0.12 ±  4%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.13 ±  6%      -0.0        0.10 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.folio_put
      0.08 ± 11%      -0.0        0.06 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.12 ±  6%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.29 ±  3%      -0.0        0.27 ±  4%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.12 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.folio_unlock
      0.79 ±  2%      +0.1        0.90 ±  2%      +0.0        0.83 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.24 ±  3%      +0.2        0.41 ±  6%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.10 ±  5%      +0.2        0.29 ±  9%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.62 ±  4%      +0.2        0.84 ±  2%      +0.1        0.70 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.89 ±  2%      +0.4        2.34 ±  5%      +0.5        2.43 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.67 ± 12%      +1.2        2.87            +0.8        2.50        perf-profile.children.cycles-pp.tlb_finish_mmu
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.children.cycles-pp.unmap_vmas
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.children.cycles-pp.unmap_page_range
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.children.cycles-pp.zap_pmd_range
     16.10 ±  9%      +9.5       25.63 ±  2%      +6.4       22.50        perf-profile.children.cycles-pp.zap_pte_range
     18.48 ± 17%     +10.5       29.01            +7.5       26.01        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     17.97 ±  9%     +10.7       28.66            +7.2       25.16        perf-profile.children.cycles-pp.do_syscall_64
     17.97 ±  9%     +10.7       28.66            +7.2       25.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     18.49 ± 17%     +10.7       29.20            +7.6       26.12        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     17.82 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.children.cycles-pp.__munmap
     17.81 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.children.cycles-pp.__vm_munmap
     17.81 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.children.cycles-pp.__x64_sys_munmap
     17.82 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.children.cycles-pp.do_vmi_munmap
     17.81 ± 10%     +10.7       28.54 ±  2%      +7.2       25.03        perf-profile.children.cycles-pp.do_vmi_align_munmap
     17.80 ± 10%     +10.7       28.53 ±  2%      +7.2       25.02        perf-profile.children.cycles-pp.unmap_region
     18.38 ± 17%     +10.8       29.13            +7.7       26.03        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.80 ± 15%     +10.9       23.68 ±  2%      +7.6       20.42        perf-profile.children.cycles-pp.tlb_flush_mmu
     14.44 ± 15%     +12.1       26.54 ±  2%      +8.5       22.91        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     14.43 ± 15%     +12.1       26.54 ±  2%      +8.5       22.90        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     13.19 ± 17%     +13.0       26.17 ±  2%      +9.2       22.36        perf-profile.children.cycles-pp.folios_put_refs
     11.81 ± 20%     +13.2       25.01 ±  2%      +9.4       21.17        perf-profile.children.cycles-pp.__page_cache_release
     39.99 ±  4%      -4.1       35.92            -2.9       37.12        perf-profile.self.cycles-pp.copy_page
      2.14 ± 15%      -1.4        0.70 ±  5%      -1.2        0.93 ±  4%  perf-profile.self.cycles-pp._compound_head
      1.39 ± 13%      -0.9        0.48 ±  3%      -0.7        0.67 ±  4%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      4.45            -0.7        3.74            -0.5        3.92        perf-profile.self.cycles-pp.testcase
      3.12 ±  3%      -0.4        2.69            -0.3        2.83        perf-profile.self.cycles-pp._raw_spin_lock
      0.96            -0.3        0.61 ±  2%      -0.3        0.64        perf-profile.self.cycles-pp.mas_walk
      6.74 ±  4%      -0.3        6.44            -0.2        6.53        perf-profile.self.cycles-pp.native_irq_return_iret
      1.59 ±  2%      -0.2        1.36            -0.2        1.42        perf-profile.self.cycles-pp.sync_regs
      1.22 ±  2%      -0.2        1.04 ±  2%      -0.1        1.10        perf-profile.self.cycles-pp.___perf_sw_event
      1.71 ±  4%      -0.1        1.57            -0.1        1.64        perf-profile.self.cycles-pp.filemap_get_entry
      1.06 ± 10%      -0.1        0.94 ± 10%      +0.2        1.25 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.48 ±  9%      -0.1        0.38 ±  6%      -0.0        0.44 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.63            -0.1        0.54            -0.1        0.56        perf-profile.self.cycles-pp.__handle_mm_fault
      0.44            -0.1        0.35            -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.29            -0.1        0.21 ±  3%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.__page_cache_release
      0.36 ±  3%      -0.1        0.28 ±  2%      -0.1        0.31 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.57 ±  3%      -0.1        0.49 ±  2%      -0.0        0.53 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.25 ±  3%      -0.1        0.18 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.free_unref_folios
      0.23 ±  2%      -0.1        0.16 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.85 ±  4%      -0.1        0.78 ±  2%      -0.1        0.80        perf-profile.self.cycles-pp.xas_load
      0.28 ±  3%      -0.1        0.21 ±  3%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.19 ±  2%      -0.1        0.13 ±  8%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.set_pte_range
      0.30 ±  2%      -0.1        0.24 ±  3%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.29 ±  2%      -0.1        0.23 ±  6%      -0.1        0.24 ±  7%  perf-profile.self.cycles-pp.get_vma_policy
      0.15 ±  2%      -0.1        0.09            -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.16 ±  5%      -0.1        0.10 ±  4%      -0.0        0.12        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.32 ±  5%      -0.1        0.26 ±  4%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.28 ±  4%      -0.1        0.23 ±  6%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.rmqueue
      0.26            -0.0        0.21 ±  3%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.07 ±  5%      -0.0        0.02 ±122%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.policy_nodemask
      0.19 ±  6%      -0.0        0.14            -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.16 ±  5%      -0.0        0.11 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.32 ±  3%      -0.0        0.28            -0.0        0.29 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.15 ±  2%      -0.0        0.10 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.20 ±  6%      -0.0        0.16 ±  5%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__perf_sw_event
      0.19 ±  2%      -0.0        0.14 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.12            -0.0        0.08 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  9%      -0.0        0.23 ± 32%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.19 ±  5%      -0.0        0.15 ±  3%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.10 ± 11%      -0.0        0.06 ± 10%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.15 ±  6%      -0.0        0.12 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      0.21 ±  4%      -0.0        0.17 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.error_entry
      0.09 ±  4%      -0.0        0.06 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.18            -0.0        0.15 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.exc_page_fault
      0.22 ±  3%      -0.0        0.19 ±  3%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.22 ±  4%      -0.0        0.19 ±  4%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.shmem_fault
      0.18 ±  6%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.up_read
      0.11 ±  4%      -0.0        0.09            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.13 ±  6%      -0.0        0.10 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.folio_put
      0.29            -0.0        0.26 ±  4%      -0.0        0.27 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.14 ±  2%      -0.0        0.12 ±  4%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.12 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.folio_unlock
      0.18 ±  4%      -0.0        0.16 ±  7%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.shmem_get_policy
      0.07 ±  7%      -0.0        0.05 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__do_fault
      0.08 ±  5%      -0.0        0.07            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.handle_pte_fault
      0.08            -0.0        0.07 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.40            -0.0        0.39 ±  4%      -0.0        0.38 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.38 ±  3%      +0.1        0.44 ±  3%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.39 ±  3%      +0.1        0.46            -0.0        0.35 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.61 ± 13%      +0.5        1.15 ±  3%      +0.4        0.97 ±  3%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
     18.38 ± 17%     +10.8       29.13            +7.7       26.03        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
--3k7mPDL5IkKI8K4C--

