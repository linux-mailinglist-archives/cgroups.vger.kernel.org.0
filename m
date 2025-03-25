Return-Path: <cgroups+bounces-7229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4AA6EA34
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 08:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D793A5CB9
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39420C019;
	Tue, 25 Mar 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsWsRfSV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1C79F5;
	Tue, 25 Mar 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742886530; cv=fail; b=HIg93q4n0kt05YZf2oB9zzDlcnKFxwR3kmAvTRfbh687eHvrrzO+ciAmN0iDqPD2hAnqfAeDt3T2qo7JQkGmEsly/rdPI2uu2FaEtfoWrjs0DkCvVI0w5GZBfn9B49QlGberE7ZiggAS7U+sd07M30l662OTzwB3UtFs9np9U/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742886530; c=relaxed/simple;
	bh=YQ6+AMUPXAW1O/GzQ6kjRcSfU9gHJ4A8BNKg75Ueyrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=femmvK+hYvxIRopMAChEx89nFBZs7IezsykQ0Qpaby/A4Af63L6KlbDi+hWYiKTBVsjIFOPM7DXESEkSsJbRCWc2spAZmP5ouMbnI6/IOJt0C8mwsxoN+i4HWdd4imRw5mRqras6SgelCNdTP6QU5oIKpoDkYh8xkjQSMarRPFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsWsRfSV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742886527; x=1774422527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YQ6+AMUPXAW1O/GzQ6kjRcSfU9gHJ4A8BNKg75Ueyrg=;
  b=JsWsRfSVe5ZFN5KSlv4Yfi8MyTYpienc+upbuwMuYmTyZCQ1YiF6exML
   4zP8P1e7W8m29EBKWBy9x/nwtxMOcWQn+mzEKV/xcoL5CERNqB5BzdaUW
   RVIlpJm1JIWF/VL1cqFnhiydtBSSiOU5oZj1B7fqECTBM4Xpo8wmyVlgE
   bxJpm5x+dJtnsvdxedysfHaOZ2SydiXgkZZbxelIa9otckpRiXjtQ8nnZ
   JKFi6paJW2UtDnqmgkZCS0695vaMYz4MbohL1qM42NoCbsrsPFeSJmQwS
   BaSwPc0m64L0sk9PWUil506kY7Nf1LZjuTkh46delvSuDBjWxwV2rqS6s
   Q==;
X-CSE-ConnectionGUID: VRqzuD0jS62rY9e1Zy4/8A==
X-CSE-MsgGUID: kV85AGAWQaO5Tvwx4nrWFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55113612"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="55113612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 00:08:47 -0700
X-CSE-ConnectionGUID: c0mutIktTpim557MKxLnaA==
X-CSE-MsgGUID: FW5TDB2cTDqfpdQJKT9VLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124811861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 00:08:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 00:08:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 00:08:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 00:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSM9LIY580tCk0H/AqtCKq/I9WgZlhTlgoY3qdZgkeApJY4KlEFs8lUs44S9cROMwd8TsEzQ0eNHvg+OdfQWFjZ+wrsmcjo0LJNjvN0JAVLlCOrafcwbYVghOua4sqBQgy8k5W55FEDoGULV3cQT82AK+zwRUEPRTAIbC03t7oFYsQaLWKbimeAMadukFxApdjNrymBp2RKJFm05NBbB3SjE/JP5sfYFoURUF2q3SShq2cScvn46ZyKW7yL8oR18t4qjSUDma26N5so4fapaaEpuzweHKHfsgEtnb4GW8s0WrC9cEiKrywR4RWeoNEI1lWx/1tb94ltKbKWvdIfCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDmMPnNPnoevEI1KuVkqbdwxkhSfPniDXDJpCcaUpMI=;
 b=rF9nW8mLK0SDZa+YEJ88+bXDDdPLouicucirrtMEgnKkQik2lzipmpL8wv36GsVw3o+FQbz+JfRGE++JRAYgU7XeD41TKrG8JakfEmBXF0WtFLiK+3QrQYFU26J8o4IKFX5S/INZB/bBUqgCAQD95e+JU1/CaOqOJ594m3Tf+VuoAVKSy248uMxsTFliVQ2SLXzvZkgs/MylPq6g0gxjiDgINA0PSt5m4oa/3Q5yvep9WdIO30+InKNFSHWdWk/k5pRUSZCo4z3fcwYQLQPhQZClJoi1WvGf+ioliVp9EGEmpV0Y3vgiFHUqB3ELuehtztCFjd7FWEaC5vWlmK4dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:08:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:08:30 +0000
Date: Tue, 25 Mar 2025 15:08:20 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<dlemoal@kernel.org>, <axboe@kernel.dk>, <gjoyce@ibm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
Message-ID: <Z+JWZFSz6ZRPFYIn@xsang-OptiPlex-9020>
References: <202503171650.cc082b66-lkp@intel.com>
 <95c6356c-da6d-4f66-8782-ada1f56315c2@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95c6356c-da6d-4f66-8782-ada1f56315c2@linux.ibm.com>
X-ClientProxiedBy: KU1PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:802:18::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1b99a-4df2-4df4-c7bd-08dd6b6bd925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OWvO4uXONlLVyoDE9vBsHRA63m0YB+k+9SSolAb+3oSCM/Eo93bLEhVRWXjZ?=
 =?us-ascii?Q?x5LtqW/tb5UmSuzdu7WUR/NtdDMqRG1GB6ZHxh3KnyfuDbIsYcqgCcvXtCdY?=
 =?us-ascii?Q?DnUHZ8LQD60NNqMxX2zKBf18tanOyBy1jIaDyP0B06PKSf2oOouyT0nxhAzt?=
 =?us-ascii?Q?KDHEiUvrPwnvjvPG43DIRiQcLjvK4lZuELIX1gCITUp6HmZcQQDufqxCa/k1?=
 =?us-ascii?Q?OCAQ3UYMTrnd/7CldDY+pqByPVojo66je8fDOeBkaL0hiqkgGJ2AO5gRZJXC?=
 =?us-ascii?Q?S33eEi7zilnuuinE6+KU7jnF6jVULd+TJ9RLVjhYeItWWRABSlHuqLy5BXE9?=
 =?us-ascii?Q?w69+LlmWJd/s3VN1CfaWhoSwd0d3nre3GWRV3QrFFhufpYlK94pkbfSRoNxs?=
 =?us-ascii?Q?seIIViLwikhMI6tGi1myNSmlI+LTFxtowNkhyZAHTzHhfAtstBAyxwNXdGtt?=
 =?us-ascii?Q?jhJld7p4xp7fP7poyGtBpDmbfES3pG97HqINaRQdb+IoAKD0H/ewrzI7dYbN?=
 =?us-ascii?Q?jAlup4M6gzBwxwJ6hyo4/wArO8nduJ1ad+eeWELKU1zJLNhXbR+EL0sem0zK?=
 =?us-ascii?Q?1K+zauU/2A1SVcl6MlX3TVp0S3+Sa9ZuqFKX87UjvpopMT1SIbnME4W/XkTN?=
 =?us-ascii?Q?hPS2djDzBcODYMiB74PGorLLG9/M3a/IEJKYwkjYzJy7s1ZcbMrZShd432p3?=
 =?us-ascii?Q?pXa/xby6e5ECVoezih42lOVcB9gSWpe8kZv4VnFHTH8igF6ZEE4PXAR/lklY?=
 =?us-ascii?Q?iPPVdC2lKKQtFSwUS0aMA0M4kHfjT4OMANPGg4UoiYuboKJxdnnQX/WSuxzV?=
 =?us-ascii?Q?GWFDDRKIYk2ECd39cTkB9pkUfb5LLQXwsC3g/eUio5Wh22jxhmnDR/wZxePi?=
 =?us-ascii?Q?Mj9+XxGsHTsZ4TlkzeEa8f31jv75Nbs6sH9KWeY5mnUsrZifl3Q2L9+H2Gz6?=
 =?us-ascii?Q?TrGTv7f4FhUU/fOGb2nz/zSVKwkExAWwfmR0PkLFcZGQqASb7tdXIrmSMBAi?=
 =?us-ascii?Q?dVyJULpDVxHikE/KWfZrhTO08NdAvUmNiFanoghxs8OSGD4HCDqQHQBgoIFB?=
 =?us-ascii?Q?QjZcLkV+oLMAIjXuvbXWDl8ZgCdUJu+2vx+M5WKAqKWTe2TD8sA4kdQt9Etn?=
 =?us-ascii?Q?awf1Z3hBm2aJVDpNr8/CyPmFywcnjKNSjccZR7yLlNmPRoVc8wBnj+QQGJ8E?=
 =?us-ascii?Q?6jbzQ+l6KiniqjrzSY5lhE537RU4owuY7DbmIpUiAV3PWn7W/c/epu4IaSmt?=
 =?us-ascii?Q?Nhsxi+s5KI3LvRJbkZyxadDu4cET7nXteLV2KiPhb1PHF0vTwgDZE5wGHh77?=
 =?us-ascii?Q?4LEmSwlYVEuXmu0qWdSeWntaIwXIkeVfXCC+IZdEHKvCHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnBlkOU/t+56k+VIqj+cmuHifE3eHLZbBozw6GXRINZpxTpqb9CoAnfiiAQq?=
 =?us-ascii?Q?S5laawS/dxg/odAn9VIM2oMtDt+/DvIzOGkfbw/0ZhOmBj6mq3pl2JYtgAk9?=
 =?us-ascii?Q?BfpfpepxD0vpYDjBIcxfVsjtsPlelDQC4FqU7ymldfe7FAorj0tOxRGvAkpP?=
 =?us-ascii?Q?eo6iNulphLNIK9FLkQgGkDfjsxbORNvuIUSzYmD0I/Vd1YkjBKsj3WmjHUiw?=
 =?us-ascii?Q?XdqYUwxxz8NJ3iI/M2XaYJYxgrOGcT74uwPu6Hac3Jbd4nl5ZOvEIKoeV8We?=
 =?us-ascii?Q?c83lzCMwLeOsLR41rYFX+fgknQ0vvUmof/cKJYVyIEuIaIQ7mRoyPeASchMy?=
 =?us-ascii?Q?G3h2AceaFppZpp1W746KJmMGQ/HQrCBdii42bkXRda2cg/W9zroD2hwoY32I?=
 =?us-ascii?Q?nJnuvwyPDeK13qvhZ0lTG8ACRtcFlIY1jEPS9HzZAg+6yOtr04ziExNAda56?=
 =?us-ascii?Q?qyyl26DWQlwuyclTbZKbfzarnBiqTOgi/na7Hn0hxTBNV+QkOwaRhV9T3g7E?=
 =?us-ascii?Q?p5EA3QbmKbWqzJ8geJdRrz1KXDuSGR1xPHtPSsnt96TAhyJ6pGIMJkIR03IB?=
 =?us-ascii?Q?NMlLcdZMVx/NDx8ub17uA/PyQtrhlSRAcfFnn75YOFgWn3k5gxL0qj24SsRF?=
 =?us-ascii?Q?iFPl+gqwU7Xp5U3UKmNBDMsACyDzH/HSEIOf9fQUGbjAJMHqeokQVAYa2Spl?=
 =?us-ascii?Q?ogGoFWiyXBbGF24oSw0smGs0jGU/IWbyA5OLGGesgdaKnqKP6QpVtlgstkBy?=
 =?us-ascii?Q?Y0jhOEYns5nsV974yEa6M8uCchtE2LPYtBPFvmpUSZm+tL9fcQNbgDtxWCbt?=
 =?us-ascii?Q?+tZC9D1AbNc6Skuo2qzmCu7hZ/N98fplM0va66xbKsQ/NidNbkhQpGq86jzk?=
 =?us-ascii?Q?dheVhwfqgfbeEF+OFKUW18JmBzjz15aN/WFgqB1MOGn7Q/TFjlzi+NVnfx3m?=
 =?us-ascii?Q?End5oeBHnoQySlzJax5K2tu6kFflqUeq7yjwgaw1sZzW0aL6CJZwXi6yEpy/?=
 =?us-ascii?Q?L3+5kuznXDaGqeE8mvY+o1z1loopX0iQjFkqzJMMqdw0QZqZaABgdnVA67zB?=
 =?us-ascii?Q?VU7eB3Fp+cz64cp37tQVb3SwWzCUYLttulYyCKIDtfC5Dabk2UkjmA/HCZZJ?=
 =?us-ascii?Q?t+QLf51J91qnbrSITIJkmQ58W8twULtpVj44ZJui/vnxKW8JAXu6FMDprEhJ?=
 =?us-ascii?Q?5YufpRUi8j4stky1ghTdGT3RckvagakBSiUdKByDj6PZHGfcf2nGtlukh9Vv?=
 =?us-ascii?Q?5viCknwkGlze0KH5ZFLWMAgCmQA3vQjrx5P0j5s6SfXCd7BDK1GtG+8ZCl2I?=
 =?us-ascii?Q?sWDpv0ptv88dHUVYWA6LR2hSffUuuTUzU+4NK2QwlHutce0gzwVYa3Gq9z4c?=
 =?us-ascii?Q?wGqrmDBvYYF4xQKU3XwRpmBCBz6U4s1VphoH4jypIJEBsh5ttTDyHPGKOOIJ?=
 =?us-ascii?Q?WfuOFgmobi6WHnNfWP1ZKR1RlFI7ytpR1fEr15wkp4w+Za8YpZLJC1Z7t0wO?=
 =?us-ascii?Q?F2voW2DvfOclX54Kf7Q+cT+QqOvu4stTZxCaTSm+ziF+NLYQgWlQCBIPLVth?=
 =?us-ascii?Q?SKfbeN5zkydmBUioVEaKv9uRlPVc1fGJEC954eqDGxzuDaZ9pksnXToDzabt?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1b99a-4df2-4df4-c7bd-08dd6b6bd925
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:08:30.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9bO+ybhyPY6NjAu7bmHhpsQoyMlKpmvXnDltLuYchXz+D4GaUMwYxQQgPgwVMYVep6s+OhrNA3ySv2j0EouXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com

hi, Nilay,

On Tue, Mar 18, 2025 at 07:13:20PM +0530, Nilay Shroff wrote:
> 
> 
> On 3/17/25 7:10 PM, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> > 
> > commit: f35c9ef2ba17842de59176b29df32999803bd9fa ("[PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock")
> > url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-acquire-q-limits_lock-while-reading-sysfs-attributes/20250304-182738
> > base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> > patch link: https://lore.kernel.org/all/20250304102551.2533767-7-nilay@linux.ibm.com/
> > patch subject: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
> > 
> > in testcase: fio-basic
> > version: fio-x86_64-3.38-1_20250308
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	nr_task: 100%
> > 	test_size: 128G
> > 	rw: randwrite
> > 	bs: 4M
> > 	ioengine: posixaio
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com
> > 
> > 
> > [  991.017071][  T472] INFO: task umount:12320 blocked for more than 491 seconds.
> > [  991.024314][  T472]       Tainted: G        W          6.14.0-rc5-00192-gf35c9ef2ba17 #1
> > [  991.032414][  T472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  991.040948][  T472] task:umount          state:D stack:0     pid:12320 tgid:12320 ppid:12317  task_flags:0x400100 flags:0x00004002
> > [  991.052695][  T472] Call Trace:
> > [  991.055849][  T472]  <TASK>
> > [ 991.058658][ T472] __schedule (kernel/sched/core.c:5378 kernel/sched/core.c:6765) 
> > [ 991.062856][ T472] schedule (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/linux/thread_info.h:192 include/linux/thread_info.h:208 include/linux/sched.h:2149 kernel/sched/core.c:6844 kernel/sched/core.c:6857) 
> > [ 991.066706][ T472] wb_wait_for_completion (fs/fs-writeback.c:216 fs/fs-writeback.c:213) 
> > [ 991.071773][ T472] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
> > [ 991.077702][ T472] __writeback_inodes_sb_nr (fs/fs-writeback.c:2736) 
> > [ 991.082936][ T472] sync_filesystem (fs/sync.c:55 fs/sync.c:30) 
> > [ 991.087390][ T472] generic_shutdown_super (fs/super.c:622) 
> > [ 991.092538][ T472] kill_anon_super (fs/super.c:434 fs/super.c:1238) 
> > [ 991.096991][ T472] btrfs_kill_super (fs/btrfs/super.c:2101) btrfs 
> > [ 991.102280][ T472] deactivate_locked_super (fs/super.c:473) 
> > [ 991.107678][ T472] cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414) 
> > [ 991.112082][ T472] task_work_run (kernel/task_work.c:227 (discriminator 1)) 
> > [ 991.116534][ T472] syscall_exit_to_user_mode (include/linux/resume_user_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kernel/entry/common.c:207 kernel/entry/common.c:218) 
> > [ 991.122197][ T472] do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 991.126731][ T472] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 991.131430][ T472] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcontrol.c:857) 
> > [ 991.136738][ T472] ? handle_mm_fault (arch/x86/include/asm/irqflags.h:154 include/linux/memcontrol.h:970 include/linux/memcontrol.h:993 include/linux/memcontrol.h:1000 mm/memory.c:6077 mm/memory.c:6238) 
> > [ 991.141606][ T472] ? do_user_addr_fault (include/linux/mm.h:743 arch/x86/mm/fault.c:1339) 
> > [ 991.146823][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> > [ 991.151517][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> > [ 991.156203][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> > [ 991.160881][ T472] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> > [  991.166777][  T472] RIP: 0033:0x7f415ea2aa77
> > [  991.171197][  T472] RSP: 002b:00007ffe0db2fd98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> > [  991.179611][  T472] RAX: 0000000000000000 RBX: 000055cc64b55048 RCX: 00007f415ea2aa77
> > [  991.187586][  T472] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055cc64b55160
> > [  991.195555][  T472] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
> > [  991.203514][  T472] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f415eb65264
> > [  991.211476][  T472] R13: 000055cc64b55160 R14: 0000000000000000 R15: 000055cc64b54f30
> > [  991.219431][  T472]  </TASK>
> > [ 1008.358661][T12320] BTRFS info (device sda1): last unmount of filesystem 8b972718-96ad-4a66-b549-8be29321e91a
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250317/202503171650.cc082b66-lkp@intel.com
> > 
> I attempted to reproduce the above issue multiple times using the provided 
> reproducer but was unable to do so. However, during further investigation, 
> I discovered a  lockdep warning related to a circular buffer. The patch in
> question introduces q->elevator_lock to protect writes to the sysfs attribute
> wbt_lat_usec and the cgroup attribute io.cost.qos. However, write to these
> attributes also acquire q->rq_qos_mutex, which may lead to a potential lock
> ordering issue reported by lockdep. Unfortunately, blktest doesn't have any
> testcase testing writes to these attributes. I think we should have one and
> so will submit a blktest. 
> 
> The lockdep warning reports an incorrect locking order between q->elevator_lock
> and q->rq_qos_mutex, which might cause the observed symptom reported. Notably, 
> I saw that the LKP test case did not have lockdep enabled, which may have 
> allowed this issue to manifest much earlier rather than being detected later 
> while unmounting the file system.
> 
> Anyways, we have to fix the circular locking dependency between q->elevator_lock 
> and q->rq_qos_mutex. I will prepare a patch to address this and submit it upstream, 
> tagging you in the commit.
> 
> On another, if you're able to recreate this issue then whenever this issue manifests
> would you please help run the below command and collect dmesg output:
> # echo w > /proc/sysrq-trigger

sorry for late.

above need some changes in our auto flow. instead of collect this information,
we noticed you've already had a fix patch-set in
https://lore.kernel.org/all/20250319105518.468941-1-nilay@linux.ibm.com/
we applied them upon previous patch-set
(https://lore.kernel.org/all/20250304102551.2533767-1-nilay@linux.ibm.com/)

and confirmed the issue gone. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> Thanks,
> --Nilay
> 

