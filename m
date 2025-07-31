Return-Path: <cgroups+bounces-8955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5BB16CC6
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0494E18C67CF
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3A19597F;
	Thu, 31 Jul 2025 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eF6+Ftvt"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AD1E8348
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947137; cv=fail; b=G4cUXp3FZGA6Dtvv9uDIPYgSJk/H7ypdWkiDmpf0PlEjj9FaSAasMrPIN0OsL2tJCKWTLeqnohyZMqwSHkRvT2zuPtPx2TFXQDl8ponwQ8Lzy0rwDQ0/tI2UKCmYwcWs5DYVQQWBbLNGbtrcRsFaDWjVLUulRx/oj6UZGAcIZMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947137; c=relaxed/simple;
	bh=bVqQOk/BVs9d6kTIZJmuz8Atg7lwj/SLGjHbiMFW8zk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Pp2lYUaS0l4wnmRSdZLDHdd1qix5uHCP5+lijhkH2/9hJfODC5x9XtBgTFkFNQRwIl7+RIctSsa+zoGf7YeSKrQnF5EIwznbiS6p9tiRAyNmtmbjTv2sMe9G07lD7RKJlHg/o0AIbMyp+XAOyQ3dMtbl13hDyhY+TqUZzDKA9GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eF6+Ftvt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753947136; x=1785483136;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=bVqQOk/BVs9d6kTIZJmuz8Atg7lwj/SLGjHbiMFW8zk=;
  b=eF6+Ftvtm4wcfwJ/EzjAxyTtGCekmOGCM/p7v3OUZy80fuYAoh8CFq4n
   RzvUjkKzFwORZorR23f4DrHWssxHR185J4CzJ00pTNoNZ+svj54jUYbew
   IaGYHYjLa985H/2+O3KxOXzjIUdB91NdXru7k1Xou3G8WetW68OIVzUlB
   CukPGkngg/DstQsiR7aqahwzzdcNhQpMC6E4tw4xbSnWqzXMutYB45q7b
   swui+KkTZ7DqdW8ZCgwiKn6SOb/iBcFfo6v2KOWqD87JPkmVVJjGQa2NE
   iMHuXuR6vVbg5FK5V0wgcLjweraQ79AcVSLQRhkFJUCpAvEJbsZfbvbab
   w==;
X-CSE-ConnectionGUID: +ulHc15RT3ed3NwbrWEzpg==
X-CSE-MsgGUID: z+drkGQ9SjCs0B9PuMwIAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73850576"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="73850576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:32:11 -0700
X-CSE-ConnectionGUID: JgmLj4o1SeSGg04LQusapw==
X-CSE-MsgGUID: AgscTEtLRo6tQMRESoi+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163644208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:32:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:32:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:32:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 31 Jul 2025 00:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEqEGewYE9U6QMNMmDXTuMvYZuU2A/Tda1u54OS1c8BYeUxGKTbJGvUuhlDkQgov0ImuSAiaft5KzuptrF2r6l8MDEzDPL9W3R/e2umw0lDf8J3u4sJbWw5assuqTwDlSZtCvlsR1ZLVEMGkSwQdWvfhXcH0dmYrgsl5p6HhqYFd5jK7mg97Jm1AzQdc7uWDOVDXDquoXmuORWIgRvnx+nJuet7dmkJ+FOspB4LajTFOMagSIspV7Hxj8b8hfZxTKy92PqqHxKs1Bf8yuDNv//C9/m35SVcrCshtg28FzvPDl/4UaBH328flFAoLvH+Z5okaiG9ib2ewS4P3p0zvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOjmURaVQcveuuqqjRgNA2x9+ngrlaEw2uC36Lvtmdo=;
 b=bFJ6E35AU+ukj3bI8EAdlLlYWzzonkZdEp9D6BhUMlApOQ3J09sF7Oy62mJDdRmVs0RvedRDqvM57rZp+dNIplmAIVir7TdGoZV1vNrRf6xcdjA5BFP11NNzce6uhAlw7g4QsisvujizoF9NJaVUgD6eODXhtjbwvOo9tHb1v61JagR2vNutrHjWwfyqSRQR+yKeYos8tCbcVaR/NDttGcy53ZxQxqjyFV9Bb+kOX9zNxC1FZ1sPOYLYblFvWWmozggUurkIom+jAybFpzGwCKH3xmVXWV7/8mFPHXgvwa/lh7OTZbvJdcETmRJv97V4WoTffTnYedI910FNimyjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 31 Jul
 2025 07:31:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:31:55 +0000
Date: Thu, 31 Jul 2025 15:31:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Tejun Heo <tj@kernel.org>, "JP
 Kobryn" <inwardvessel@gmail.com>, <cgroups@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [cgroup]  36df6e3dbd:
 will-it-scale.per_process_ops 2.9% improvement
Message-ID: <202507310831.cf3e212e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: cb70ad25-6a00-4b43-8825-08ddd0045306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZV6qOr7Odo8JnDC08nt3Z07IYJSOXOHXACWNirXNv/Rmg4+o+ognIgMwsr?=
 =?iso-8859-1?Q?lMnNEGZGwwcoSVSv2SrvLl8So0ADbFlIvHa5fbllswMAqC5XwAfNQD6iwk?=
 =?iso-8859-1?Q?bn4gGy+A0dF1IJ3+ut0AindrE0BWCqfDj36zwPT7QeLAs0As+pq4++Y6B6?=
 =?iso-8859-1?Q?aukwm2jeenZ/XtoOvSmeXS5v/Et9nZ5DTG/ncmEX7CucMSKPBe4iQlDMsj?=
 =?iso-8859-1?Q?hBVLPjwuirMQn52VIfLHpxlfUTqv8Tt3fel4vwUZrkDfW9nyYg2KH2eULw?=
 =?iso-8859-1?Q?gjDR8fmXyIuAN4qJLzkSI2+IgCFG7au6NaEalhEtu4UQjXwcnBbqG7rTWD?=
 =?iso-8859-1?Q?3QPn+LGSCYHVl3R5v+u42r4macduyEVQce5l6M/7SPhFU/K5VLkNdukcNi?=
 =?iso-8859-1?Q?DGxGx3su/XnLPbZgD45mav/71fmO0wYG5z2U0FQ2vrzLlS7UtWeRgxdW6u?=
 =?iso-8859-1?Q?WTLUOrw8XIxonHTkgkyhVBWeCGeV+DIu1m0Dku9tOYNmyDi+FZxMjhwAnN?=
 =?iso-8859-1?Q?0nIwUv1JuBNhyRTYwVMCSwN9z9+5AnIGivohzbxpRQvzY5UBs3o+Hn9zPp?=
 =?iso-8859-1?Q?v/bCNCqsGunr0YPbrwUQdFKpEADyCCPySUhu77viQMpZDLZGdFcujIkxLp?=
 =?iso-8859-1?Q?vVUXWg3OwCi8qvlXfygDJU/JgGrfCAKxKdXmWlegl/ZCIpQ395Zasx0WXs?=
 =?iso-8859-1?Q?62FYRkS9OMSwfnAgZqpitAlOTS9cZru7chSCqamDz5UaMxlOU44GN19b5a?=
 =?iso-8859-1?Q?TWpc73OMs9vadGxrIAzQ3Khv+PwoJUWPkKAsNUmsD1+bKkfAYE3ChttnAa?=
 =?iso-8859-1?Q?v8CpsU8DSRL80+33c8t17lPogpbOt+R6un5bjxPreul7mCty+2NFR705qT?=
 =?iso-8859-1?Q?KibCrB8wFiWxgXGU64mjiLQtE0QGfc5SdqhGE3W/14TY/f75K1T/M1BZbS?=
 =?iso-8859-1?Q?GEB+32SxDJ38tBHuKQvzGaoLSAI07DhOdT34MYTmeHTRF88V0YsEG3JBFf?=
 =?iso-8859-1?Q?srMfID5AUq3Q0/E00E3A3NW+I1aCVgUG8Kdf6rmFJjJCYNM+GwiLbDpapw?=
 =?iso-8859-1?Q?X7Ln+DzR0II65F/lmQABcMZXwDj6UYSQVjnnj7CythVLg2GjCiEGPGWeOp?=
 =?iso-8859-1?Q?g/t13cz1oogd9xBuWzTw9YgFSjzvIRFgjo3EAtRS7ekeYjLCTipqjjCshH?=
 =?iso-8859-1?Q?/YDcN2HdxYMgEk+s1L5vOARyxhA/9iXi/vu5H08SWyJpZ4SISZS//Sh/ko?=
 =?iso-8859-1?Q?7NDlbk6ysZMS3uJss0uVGit0m8mJinGK1ycRgrUjthArUOzdG0h2I84GE3?=
 =?iso-8859-1?Q?WbyVvvjfSJoUkuwvB4jYf1VfYGLv3HsBmODZ7lq/dAnZJ8E8HkWkngvVw5?=
 =?iso-8859-1?Q?OIPz+VX2PNHNZp3dWXH981qECMYyWn8qy9wWO3Qt/EOlAFLzangHHpPLER?=
 =?iso-8859-1?Q?iJ/nbhoVYS2d4igA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Tr6Hc99Jux4x4HF32jZfJ/dT0aqpO12ySZkgsrhGCeRX3KLyXTP8w1kDf+?=
 =?iso-8859-1?Q?WTXQXJfddgzVe22Un7WM4MFNVS9pX/WLiRw3yiug8NcKy1k/2meSp3rEAU?=
 =?iso-8859-1?Q?mqkE1WK/3/Hkx6WjKOjTyrIlEP3H5ITyzdscFG+dV1CnDxlSwAwWYnCyke?=
 =?iso-8859-1?Q?u3bEetZTX6JpPEQihY6MUrdwKyBtRgzAYc5C3R2A9HqVtLa9QndWl6DJJe?=
 =?iso-8859-1?Q?ZRRdyIFeIXmfGUojdhgn1zYj4FAy6opcl7+RQOKFPUoPuLC9CNmGhTBeZ3?=
 =?iso-8859-1?Q?p99uQIIYu7hekHaOKdiUYV+pUeUrJDFVXrErl/V5qARFHmdzHH8yeMPv7E?=
 =?iso-8859-1?Q?9FnywBoDkywO+VEtdhM0rcFtxy1rm9/PTORDDDeMZxBIukNbGyG9609CQi?=
 =?iso-8859-1?Q?aZVuLjLob6cXob8wsINu6eK7N2W2S4wodbQVEk7wfQkLo/XrHv7wmHhD99?=
 =?iso-8859-1?Q?kXSSWlZTayB9663Dp4e1HZvkMCbWNk0McKJbvotkoEP+XhyutmDirRQ5fB?=
 =?iso-8859-1?Q?zU6ftRg6/+Su7g4gET1kwfTT9rzoQuDgQZci+oYRZrUTh+RvBF8EMFblOy?=
 =?iso-8859-1?Q?iWR2riHY+W5PpuzTv34zhsH23dABIabcC2OIIz5C/hlgcQkGvDePRWsFtU?=
 =?iso-8859-1?Q?x6n3VZpZ8DDogNDpxKsO3HEFjLVRJovzBlhUHJ4HF2wedKonzwkmHPRAOa?=
 =?iso-8859-1?Q?ilFoYZXs0YpAcpEwlqBGTKEhc81XOdBSfwDHA/0hzcuByRO2wkUsgOFZp6?=
 =?iso-8859-1?Q?S7obUfO0NSkbhV8S6mtqnZqu9OYQ2rUKosOOhq2OSPsr6jIPdLWyqNg88l?=
 =?iso-8859-1?Q?0atx1Lf6W57tk0iru4pFxEfdzmynTgxnAFNttXR434/QeAJ+W9A3i4CYSw?=
 =?iso-8859-1?Q?Vhbr2xc/WmhDZ6/KoZpnMQCDF7xC+yPKlbRxv6aSQZXwxmPZwUrsa7+mKd?=
 =?iso-8859-1?Q?l7QPMUsTD/mXDLtmpKfEk09AC6EC+NBpLEE4VQaUD3rVB/3sNLHlRbAjFM?=
 =?iso-8859-1?Q?3vY2Jiwnwu7cqqm9gdNWY2n95EftyyH29xLRqwGPSLMtaVeFSR1PHNwmoT?=
 =?iso-8859-1?Q?oaCa38z4oyfUsv+ZjgdqF3otoRcTyKsF80+9OK1riF0pNVgs9N8O9UsTu1?=
 =?iso-8859-1?Q?ZTPAXOpisl2cIHTNqb1iuKprdzR0KlnrO1d63XjhePurGnYOMYJmU1Whlk?=
 =?iso-8859-1?Q?QY1os8GiET2v2EPHH9npNAdJl/U4DB/AhW8F08Q7Ih0Qnmd//uZLdrC8/B?=
 =?iso-8859-1?Q?fUbz/9lV8aNnKd7k5EAZI6F5wnd0uhhRmDLdf3ksUDEa5Co7u7NJVwnYIV?=
 =?iso-8859-1?Q?PrSOUCBdolf/mfVTTD7aS8RO8s8Ygqz8SUVH1B44NBR6cfG8t2Jr0txBFd?=
 =?iso-8859-1?Q?S6CnxA3F6IesDfhwXDQqz9r7kFjpvqluzj+U6AKtV15pwXlQAjAdDLqoYW?=
 =?iso-8859-1?Q?oL/4HTNU02Y2Q1uUBXEAxw0z0mqpDQ1Pc8CP6R52CC0s73f4Hhsp65qBel?=
 =?iso-8859-1?Q?BLUqeQpGIdCC74sIogSMAQd9Mf5DsBXEiT15I68PC1km2yZqCdGgo8uOH9?=
 =?iso-8859-1?Q?/BIheqe7I3uU9TXuCBrdl9eIreNu6kxheEJa67vawn0nM8p7WABy4bYvmo?=
 =?iso-8859-1?Q?x4zylqQ/klif1BzBXZ/PW+dDxrC01Fo2cp4Ai3MSpe2DncvB+uqYcU/Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb70ad25-6a00-4b43-8825-08ddd0045306
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:31:55.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zyTgnx1TVEnrWlqFVvIK000fPoD2m8jui2phhA1dO6lCbiadk8XQhVKGYbg57q4JpWAh9avR43L5e6IkwZsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.9% improvement of will-it-scale.per_process_ops on:


commit: 36df6e3dbd7e7b074e55fec080012184e2fa3a46 ("cgroup: make css_rstat_updated nmi safe")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_task: 100%
	mode: process
	test: tlb_flush2
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250731/202507310831.cf3e212e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp3/tlb_flush2/will-it-scale

commit: 
  1257b8786a ("cgroup: support to enable nmi-safe css_rstat_updated")
  36df6e3dbd ("cgroup: make css_rstat_updated nmi safe")

1257b8786ac689a2 36df6e3dbd7e7b074e55fec0800 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.78 ±  2%      +0.3        3.11        mpstat.cpu.all.usr%
    522283 ± 32%     +29.1%     674402 ±  5%  sched_debug.cpu.avg_idle.min
  11822911            +2.9%   12170263        will-it-scale.192.processes
     61577            +2.9%      63386        will-it-scale.per_process_ops
  11822911            +2.9%   12170263        will-it-scale.workload
      2.98 ± 11%     -25.3%       2.23 ± 31%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4312 ± 11%     +13.1%       4878        perf-sched.total_wait_and_delay.max.ms
      4312 ± 11%     +13.1%       4878        perf-sched.total_wait_time.max.ms
    320.37 ±104%    +191.2%     932.90 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    365.55 ± 83%    +155.2%     932.79 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2.98 ± 11%     -32.0%       2.03 ± 32%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     18415            +2.9%      18955        proc-vmstat.nr_kernel_stack
 1.791e+09            +3.1%  1.848e+09        proc-vmstat.nr_unaccepted
  3.59e+09            +3.0%  3.697e+09        proc-vmstat.numa_interleave
 3.589e+09            +3.0%  3.697e+09        proc-vmstat.pgalloc_dma32
  7.12e+09            +3.0%  7.334e+09        proc-vmstat.pglazyfree
 3.589e+09            +3.0%  3.696e+09        proc-vmstat.pgskip_device
 2.716e+10            +1.7%  2.761e+10        perf-stat.i.branch-instructions
      0.15            +0.0        0.15        perf-stat.i.branch-miss-rate%
  38117449            +3.6%   39497918        perf-stat.i.branch-misses
      4.20            -1.1%       4.16        perf-stat.i.cpi
      0.24            +1.1%       0.24        perf-stat.i.ipc
    245.58            +3.0%     252.83        perf-stat.i.metric.K/sec
  23582407            +2.9%   24272602        perf-stat.i.minor-faults
  23582407            +2.9%   24272602        perf-stat.i.page-faults
      0.14            +0.0        0.14        perf-stat.overall.branch-miss-rate%
      4.21            -1.1%       4.16        perf-stat.overall.cpi
   3359915            -1.8%    3300246        perf-stat.overall.path-length
 2.706e+10            +1.7%  2.752e+10        perf-stat.ps.branch-instructions
  37940559            +3.7%   39340939        perf-stat.ps.branch-misses
  23496794            +2.9%   24189927        perf-stat.ps.minor-faults
  23496794            +2.9%   24189927        perf-stat.ps.page-faults
 3.972e+13            +1.1%  4.016e+13        perf-stat.total.instructions
     58.13            -1.6       56.50        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     58.24            -1.6       56.62        perf-profile.calltrace.cycles-pp.folio_add_lru.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     59.95            -1.5       58.46        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     60.58            -1.4       59.16        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     61.08            -1.4       59.69        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     62.15            -1.3       60.87        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     62.26            -1.3       60.99        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     28.72            -1.1       27.64        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     28.74            -1.1       27.66        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.do_anonymous_page
     28.74            -1.1       27.66        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.do_anonymous_page.__handle_mm_fault
     66.84            -0.9       65.93        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     67.47            -0.8       66.62        perf-profile.calltrace.cycles-pp.testcase
     28.90            -0.6       28.27        perf-profile.calltrace.cycles-pp.folios_put_refs.folio_batch_move_lru.folio_add_lru.do_anonymous_page.__handle_mm_fault
      0.54 ±  4%      +0.1        0.59        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
      0.60 ±  4%      +0.1        0.66        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.68 ±  3%      +0.1        0.74        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.84 ±  4%      +0.1        0.92        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single_batched.madvise_dontneed_free.madvise_vma_behavior.madvise_do_behavior
      0.94 ±  4%      +0.1        1.03        perf-profile.calltrace.cycles-pp.zap_page_range_single_batched.madvise_dontneed_free.madvise_vma_behavior.madvise_do_behavior.do_madvise
      1.00 ±  4%      +0.1        1.10        perf-profile.calltrace.cycles-pp.madvise_dontneed_free.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise
      0.92 ±  3%      +0.1        1.02        perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.06 ±  4%      +0.1        1.16        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.48 ±  4%      +0.2        1.64        perf-profile.calltrace.cycles-pp.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      +0.3        0.55        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.60 ±  6%      +0.3        0.95        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.do_madvise.__x64_sys_madvise
      0.77 ±  5%      +0.4        1.14        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.do_madvise.__x64_sys_madvise.do_syscall_64
      0.08 ±223%      +0.5        0.59        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.do_madvise
     32.13 ±  2%      +0.8       32.98        perf-profile.calltrace.cycles-pp.__madvise
     58.20            -1.6       56.57        perf-profile.children.cycles-pp.folio_batch_move_lru
     58.30            -1.6       56.68        perf-profile.children.cycles-pp.folio_add_lru
     59.98            -1.5       58.50        perf-profile.children.cycles-pp.do_anonymous_page
     60.60            -1.4       59.18        perf-profile.children.cycles-pp.__handle_mm_fault
     61.12            -1.4       59.73        perf-profile.children.cycles-pp.handle_mm_fault
     62.19            -1.3       60.90        perf-profile.children.cycles-pp.do_user_addr_fault
     62.28            -1.3       61.01        perf-profile.children.cycles-pp.exc_page_fault
     67.07            -0.9       66.15        perf-profile.children.cycles-pp.asm_exc_page_fault
      0.14 ±  5%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.css_rstat_updated
      0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.handle_internal_command
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.main
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.run_builtin
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__cmd_record
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.11            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_mmap__push
      0.10 ±  3%      +0.0        0.11        perf-profile.children.cycles-pp.access_error
      0.11 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.update_process_times
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      0.19 ±  3%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.30 ±  5%      +0.0        0.34        perf-profile.children.cycles-pp.find_vma_prev
      0.45 ±  4%      +0.0        0.49        perf-profile.children.cycles-pp.get_page_from_freelist
      0.26 ±  9%      +0.0        0.31        perf-profile.children.cycles-pp.lru_gen_add_folio
      0.41 ±  3%      +0.0        0.45        perf-profile.children.cycles-pp.mas_walk
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.get_vma_policy
      0.52 ±  4%      +0.1        0.57        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.56 ±  4%      +0.1        0.61        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.63 ±  3%      +0.1        0.69        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.68 ±  3%      +0.1        0.75        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.38 ±  9%      +0.1        0.44        perf-profile.children.cycles-pp.lru_add
      0.96 ±  4%      +0.1        1.04        perf-profile.children.cycles-pp.unmap_page_range
      0.94 ±  4%      +0.1        1.04        perf-profile.children.cycles-pp.zap_page_range_single_batched
      0.94 ±  4%      +0.1        1.04        perf-profile.children.cycles-pp.alloc_anon_folio
      1.01 ±  4%      +0.1        1.11        perf-profile.children.cycles-pp.madvise_dontneed_free
      1.06 ±  4%      +0.1        1.17        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.01 ±223%      +0.1        0.12        perf-profile.children.cycles-pp.mm_needs_global_asid
      0.47 ±  5%      +0.1        0.59        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.49 ±  4%      +0.2        1.64        perf-profile.children.cycles-pp.madvise_do_behavior
      0.62 ±  5%      +0.4        0.97        perf-profile.children.cycles-pp.flush_tlb_func
      0.79 ±  6%      +0.4        1.17        perf-profile.children.cycles-pp.flush_tlb_mm_range
     32.30 ±  2%      +0.9       33.16        perf-profile.children.cycles-pp.__madvise
      0.21 ± 10%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.13 ±  6%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.css_rstat_updated
      0.05            +0.0        0.06        perf-profile.self.cycles-pp._raw_spin_trylock
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.zap_page_range_single_batched
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.find_vma_prev
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.unmap_page_range
      0.12 ±  6%      +0.0        0.14        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.10 ±  8%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.lru_add
      0.21 ±  3%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.handle_mm_fault
      0.18 ±  9%      +0.0        0.21        perf-profile.self.cycles-pp.lru_gen_add_folio
      0.39 ±  3%      +0.0        0.44        perf-profile.self.cycles-pp.mas_walk
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.mm_needs_global_asid
      0.46 ±  5%      +0.1        0.58        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.11 ±  7%      +0.2        0.27        perf-profile.self.cycles-pp.flush_tlb_func




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


