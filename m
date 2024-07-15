Return-Path: <cgroups+bounces-3676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD305931675
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E39B21AC6
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2418EA93;
	Mon, 15 Jul 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKuRxCVi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476118E775
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052896; cv=fail; b=EteqkSdLjFWWSqvn88cQwGPviExdT2ncrLBttriSRad506CZ2Dal9/N1gWp42FR97XrKxOeecV1JPup2+u7G1hlZ+5lyQPtdjM/MLpQM+t2h5TFF4MQDnWDNN93fwGIw1XEASX+yiaaxv7ryaIrZa5HfDAi+YM/Ooercjc1XB+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052896; c=relaxed/simple;
	bh=bCP6Cn997Qu23EsoK3oNPCO1X2GtZh6EkrUf95HoK00=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNZDtL3g5c4thpRKsOxLHXsl9JTxHRcfNwEJnaP5kd3xuu4zlPhCTdp0PDITKIs7b3ruvBDe8PxrWNmqiPgUAAyV58Z970uzHJRCnEGq0Rv5R+YQEtmmKaVOwY6ZxrwJQwTBFvevi+EeWfMUxXhJUbQ3PJoe+pApqJYQ9t1+GHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKuRxCVi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721052892; x=1752588892;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bCP6Cn997Qu23EsoK3oNPCO1X2GtZh6EkrUf95HoK00=;
  b=aKuRxCVijpSGAdutUp+Xy9S2eooV6Vj8F/JElkVRY51JEpp4LjtxPo+Y
   Dk4iZYSx6hJkcBNlEVHuL3nLpwt7W6H9t9vS6npRXUisV22dmTsAvfIBe
   8tvAvH+7YOZENCXHDsKDvtSdmiTBWxhYtczfJuylp6tBDXUp+zAnI4KBG
   AGuAp9+1zBN9Zsv4awUCEZG6JnIAbx7sgLA0NrBd9L3ZDOooK8WkCTq0x
   LDDsIYpJMlB6PIC5QMzLc8kKQPysD8XrUrmL6t+vODvZndSdUFq5UH0RM
   mzCOKkIOhOncJbdBi3rVDEoY8IBAz7Eii8V1G+SztKgLG/9tyL9wANzOj
   w==;
X-CSE-ConnectionGUID: HQAxAWcqRxisk8at15smrw==
X-CSE-MsgGUID: aw5Pfy5aSpK2J2zs+oYa5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29112817"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="29112817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 07:14:51 -0700
X-CSE-ConnectionGUID: 31b/dqFBT/mNmWC05/wlCA==
X-CSE-MsgGUID: gkm44kv6SYqIunWWZtNv+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="80725983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 07:14:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 07:14:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 07:14:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 07:14:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 07:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBpf616/WNHHbl78W6D/8uTSqXEOb+bdokw16wcQBoH6KfuZgKmTV7+8Xit8t0vIEjvBTy2J9rR+dNeFP0GEIGEk9TnKyiqn0DIMgequlo8hJgpbPY6AjaERsMh5j171FOo3n8IgrKr1X4IzAOU6b5EYiOppfYUUSJuPv2EOymai5rTVjzzfgCRW0PIqSRKiwFehr3rxH2ZsMyNNl0W35BrNOxi9etmaqThFKr0GOSMRTlJmePSRAPkMuH+2dp5opWLD5yfKFE5Sfykz83ETakyx0jeSddXRon/jwWW/sYEJD8aVczFXabUr66h9rCbGp7hEhS3YiV/fQ6/wM+WLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCFjbihQ2ABvwnr/hqqNJerde0Vrr8I86S5bfa2BM2A=;
 b=bFsCmacQw9eTt3Duytl5OJCyFhdKs1YghSiRYYEP+pLJiZq1EWgzBKEPoc4SM689dcp6uWOpDMIxgpaA34FJ7HbIDFpA4v5w5hwLvkbjgTsZnqGfc1UpN38glERk8oJyLxREufat1DMZxsOATUpem95x4DPwQFPe75J/g+TpgPYQnH/3IIfORRx9U2Yrfjiutg6Lbhs8t20IW1uYUW+YNr3XiwrQB8l1DCpwsl1ZRtwCgUexrTsZ2NnGB08+6ba7gCuPfYxMKuCrMwIz8P5MeJ8xwJwDpFd5mfisRemky1cOl5JE5jbRMvSGpY1o3Jjz8E6M2RH0bWgonY42kk5Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:14:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:14:44 +0000
Date: Mon, 15 Jul 2024 22:14:31 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpF-A9rl8TiuZJPZ@google.com>
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: dca52b50-9cbb-44bc-c7ca-08dca4d87927
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bKxqSo2CRxAV816nbudLlHm9dGKtIyfpvMhVtalUBP2GnSd8NM1tAWJ2SW?=
 =?iso-8859-1?Q?5xzt6CykbY1pztWwq1cvgh/MjZX8gTYH0jeBuJXnicwlIN8f0Bw4uaBm4l?=
 =?iso-8859-1?Q?IJTKfc0Eqqq8FP1wwSillJePgnAJBct0uWliPyqsIhLZhp5Rg1ve8G15Fa?=
 =?iso-8859-1?Q?NWM1yAd1GsNRHbO5aeOIuY/B44A2ZU25BweP3gTxMSOrX2rkQfq7IplU9P?=
 =?iso-8859-1?Q?IMhfhMPXyRZUllausuQlGGzQ7fIpOQomWcHnN/9gU12UqNYOHFVQNoCndE?=
 =?iso-8859-1?Q?9ODSHijyhJAJ7Zgh7fQw9+AFL4J6iUM8rqNJbl8JdJbTg9GwrIustGd0HA?=
 =?iso-8859-1?Q?xESf/ZIjfB58CSqMrfZBOJIS4SLxvGsqdql6z2eujhv5DtiesbV+TMjj1a?=
 =?iso-8859-1?Q?805mvzStbrU1P/YtWRXlWi83nCvu04d55yOr41NR5dguEJc9GQqoxaU6BV?=
 =?iso-8859-1?Q?PQFVmAxlYlem0c3BgDDoE06ACUecbUh37pX2nGGcl4tAKrhhMQgb6yOmY1?=
 =?iso-8859-1?Q?z1fbumGtwAWHOhN63gT3CNkeUpjqwHm+4DwppIps/P8u//n1HHQUUb+XSk?=
 =?iso-8859-1?Q?r0xO35Eyp9h5pKtAkntRL1xqil/4kNvoRROODrf823TcuBRkYqwNY9tayE?=
 =?iso-8859-1?Q?c66sxb9NpF/KrXMKQAi9VvTBmQFlOMvpBQC7/bQfKcKU2F73kXk1qMM9LG?=
 =?iso-8859-1?Q?i6xTC03wOLH/AFnVzx/1KFYNX7YRdBVDnKUKMFAdqmSputLc8RHJFJ2lnG?=
 =?iso-8859-1?Q?mEQnpyqGH1fhhCgcUmcHn7cIVWJRzQ80UvW8BX23NGJO4XDM28BjUXXVC/?=
 =?iso-8859-1?Q?Z8NvMZuxzPa5VbuTZoHL4G8FEYpoGdjET3Qk3sMY9JxUjI/qCm/zwIBo8/?=
 =?iso-8859-1?Q?CHyKFAoxHBrZb665Jy/6fA7sAuPyuLlfXAfrHlVoqfSZEizrvok+9Onhjf?=
 =?iso-8859-1?Q?7DumG3VGqoIaiU3f7w/UnsN7z6E5YNorQ5YQW9pmefLG88kCNTOrXH9q5L?=
 =?iso-8859-1?Q?/uPcWWT2x4UlkYwJ6wPU25n6vrYmhO9Qw5yT/WQK5ACxH5cxOGNuFuoJJe?=
 =?iso-8859-1?Q?GEe9Un8oNTtYBPhZG7rV7eD6ESrClrnzwnZL1qp/yaVf+F9I5HQJudzZIG?=
 =?iso-8859-1?Q?JYH6UcljnrCMgqqOD6D4hL4n0JV85mB0oW97BYJdw696JVC9mzFEfC1ywQ?=
 =?iso-8859-1?Q?fot9rwxXp5aHB0iAwtZ9Zj03l0whr+jfsfr+mHrNbiAqeFKQmDedoZRJVb?=
 =?iso-8859-1?Q?rGKAgtkCd1tc6FBQNwrpSWdOFoFkfFCkVwRl+VvCVT1Ba1NCX+vCUJuMJe?=
 =?iso-8859-1?Q?6U20p/4Cwe+uxitT89WcduOJGCeM3BTg+0nbt9y7Xy8F6mCcdxwW2tnk7W?=
 =?iso-8859-1?Q?kwMoMzNts9cv+Re2FUvI8rBJ5IG9W3TMJ4UF7FuSHbGfIZ76qVlto=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lDlI0WYO4GnsfchWNQfJ92EnXXwUP0vY+6lmXOwgwTHLZy2zruK8exVyIS?=
 =?iso-8859-1?Q?PjXkgpowZ4IWjEjMeyLHuN/cWNHEc0qXqwPoct7FYK8PqIAV+eQb2BnQip?=
 =?iso-8859-1?Q?d/a9vB4z+9GRN9DIwP9opMHmwRUUshFffbRGr7mhY1FiMHAOCv9+2SUWyn?=
 =?iso-8859-1?Q?nr6YqwU4EuggeEL2SH+gK2M0DvoT+M52kKwKnpPvHORvvQZHhmHHab31MX?=
 =?iso-8859-1?Q?AggrA/65e3vxGWA6rjcaIimfwp8neVlUbkwMaYwGSFmSyWA07XlZvNUxOu?=
 =?iso-8859-1?Q?0gbDqqXmysG9Slj5q+4fYGg2Ib/TXjsWyxUjSR1cL87b4mYuWYzEfZPdp5?=
 =?iso-8859-1?Q?KjOXRUc++aoHTDth1xu5ctmdGdCRyhQpqy8UYyySMJtjrTDoZYOYjsLzNG?=
 =?iso-8859-1?Q?i+xErpdesouI5hddtx52OLFMerb8mlTbKV6SZfBx8x090rD27ESBC2vs80?=
 =?iso-8859-1?Q?GO82T0tWbjd/wQ2lsCCY8PpZMCs1DX3Qleh36iIhe9N1Qwykn6ZJDEB5Ao?=
 =?iso-8859-1?Q?aHE1p1ZFq8Qywn3ANzNccQkfDdth1jgNh1AC9R3PE0honR4btgekhh4Y48?=
 =?iso-8859-1?Q?aAczmRVmEOYi7z7GJsgVHXaI42ZkONinGb2mSvnJde/937ME6A9KnXxitq?=
 =?iso-8859-1?Q?i4ETRKC7svSc0H8I8WF4hZV4bj2SkFodgkfnsOEADfoSck+d5vftJwgwMH?=
 =?iso-8859-1?Q?GQ5UjXEHo1tpMED3OdSzxqxl70aZLXWrsomZS41SvpCBxYYGJievMudrcC?=
 =?iso-8859-1?Q?EzS083qOzKQEmNTNQ3V3aDD8Jq/+qMAqrZ1cxEQTEPdg07EcqgSoTxMukz?=
 =?iso-8859-1?Q?NETrZfTacsbn26VVVZ3OB+KpzeZJdtY2h28X4lyJgkfOoVY/2Etn37z/9n?=
 =?iso-8859-1?Q?CEzre2LI5MD0rtnaypRH8XKc7uEOFe2RnjYemVFDdRzdCcvg43DJYLk6+y?=
 =?iso-8859-1?Q?G5B5Yl19mJj+a3EVqDzf6dPlrCzdheszalxB4BbSj5iGk58Dd9wx/ZYNkD?=
 =?iso-8859-1?Q?YBZjUbL5L5tlwEHwCRZw8/M/dSWoHrsG2ThTUhDY0sV2neiXZ8Htel9i0n?=
 =?iso-8859-1?Q?ezNSUAR0B4lmQNegRgSciBc0tVv+3awQqLi7ctLMZg0ZSntNMMQrnrcnPL?=
 =?iso-8859-1?Q?IE2E0JjoAQkX1UR0oo9gKfkxI/T2GNOVQnfsr75MH1pDRkJi2iQvUe/i+N?=
 =?iso-8859-1?Q?LXV4EC2xg/calfluRFHCEB8Xh435UZ5/uPUAN2oAv+k9xn1/wfk6G9GVMK?=
 =?iso-8859-1?Q?j+f/IJ/ZWllYngVAtk0okcvxBUtVLLEu0/mzi1gECmizrc3hfzcucHVAcD?=
 =?iso-8859-1?Q?Gcc4wHETo9owavVMvE38cdalCuy2Pmmx+5ZPXpaEHXoql1fEE1R7VYUs2D?=
 =?iso-8859-1?Q?P8HI/g53Gll8nJJFxw2I6otIN15o4dAPQ2IK2PcLujjcXscHc+DkZeScrK?=
 =?iso-8859-1?Q?FSpWeiJdoTk59OBcifncJVZbGov2WxaLPZ/STFlzMtU08YLz3pZG8cFFmE?=
 =?iso-8859-1?Q?8Y5bthNSDkFM2ak3GYo1kev698RFW/qSRa61fh1UwZQWi2Rgfhy8nfYEK8?=
 =?iso-8859-1?Q?OP21J7IXolNmXS++E6GEyYUE4iTgquwBudWY6VxmlV4f2kqKtn7BwNvFwy?=
 =?iso-8859-1?Q?gjcoDtZY+zLBanC1SIe2puVdXcnkkBd+HR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dca52b50-9cbb-44bc-c7ca-08dca4d87927
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:14:43.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmQxsMMyQg+Ay9cL2l2VCBHXNV+h8mZ8444NRD62G1eQy+S031VWIPji+oXHFhCi5EfV5lfzqbgcV1bHFEreRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
X-OriginatorOrg: intel.com

hi, Roman Gushchin,

On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > 
> > 
> > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Hello,
> 
> thank you for the report!
> 
> I'd expect that the regression should be fixed by the commit
> "mm: memcg: add cache line padding to mem_cgroup_per_node".
> 
> Can you, please, confirm that it's not the case?
> 
> Thank you!

in our this aim7 test, we found the performance partially recovered by
"mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_rr/aim7

commit:
  94b7e5bf09 ("mm: memcg: put memcg1-specific struct mem_cgroup's members under CONFIG_MEMCG_V1")
  98c9daf5ae ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
  9fa001cf3b ("mm: memcg: drop obsolete cache line padding in struct mem_cgroup")
  6df13230b6 ("mm: memcg: add cache line padding to mem_cgroup_per_node")

94b7e5bf09b08aa4 98c9daf5ae6be008f78c07b744b 9fa001cf3bb0598aad09d15b289 6df13230b612af81ce04f20bb37
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     76.42           +15.1%      87.99 ±  3%     +15.4%      88.18 ±  3%      +3.1%      78.77        uptime.boot
     53.28 ±  2%     -27.5%      38.65 ±  2%     -27.0%      38.88 ±  3%      -9.1%      48.45 ±  2%  iostat.cpu.idle
     44.58 ±  2%     +33.6%      59.58           +33.1%      59.35 ±  2%     +11.2%      49.57 ±  2%  iostat.cpu.system
      2.13           -17.0%       1.77           -17.0%       1.77            -7.1%       1.98        iostat.cpu.user
     49.85 ±  2%     -14.7       35.17 ±  2%     -14.2       35.64 ±  4%      -5.2       44.66 ±  3%  mpstat.cpu.all.idle%
      0.15 ±  7%      +0.0        0.15 ±  3%      -0.0        0.15 ±  3%      -0.0        0.13 ±  4%  mpstat.cpu.all.irq%
     47.74 ±  2%     +15.1       62.82           +14.6       62.36 ±  2%      +5.4       53.14 ±  2%  mpstat.cpu.all.sys%
      2.23            -0.4        1.82            -0.4        1.82            -0.2        2.04        mpstat.cpu.all.usr%
      4752 ± 13%     -18.1%       3890 ± 11%      +3.2%       4905 ± 18%      -9.0%       4322 ± 19%  sched_debug.cpu.avg_idle.min
      0.00 ± 32%     -49.2%       0.00 ±171%     -43.2%       0.00 ± 81%     -62.3%       0.00 ± 99%  sched_debug.rt_rq:.rt_time.avg
      0.19 ± 32%     -49.2%       0.10 ±171%     -43.2%       0.11 ± 81%     -62.3%       0.07 ± 99%  sched_debug.rt_rq:.rt_time.max
      0.02 ± 32%     -49.2%       0.01 ±171%     -43.2%       0.01 ± 81%     -62.3%       0.01 ± 99%  sched_debug.rt_rq:.rt_time.stddev
     53.29 ±  2%     -27.4%      38.70 ±  2%     -27.0%      38.92 ±  3%      -9.4%      48.28 ±  2%  vmstat.cpu.id
     65.83 ±  4%     +59.1%     104.76 ±  3%     +55.5%     102.35 ±  3%     +19.0%      78.35 ±  3%  vmstat.procs.r
      8385 ±  4%     +34.6%      11284 ±  3%     +33.9%      11228 ±  5%     +20.5%      10101 ±  8%  vmstat.system.cs
    245966 ±  2%      +8.1%     265964            +8.1%     265934 ±  2%     +19.3%     293498 ±  2%  vmstat.system.in
    778685           -29.4%     549435           -29.4%     549581           -10.3%     698378        aim7.jobs-per-min
     23.31           +41.4%      32.96           +41.3%      32.94           +11.4%      25.96        aim7.time.elapsed_time
     23.31           +41.4%      32.96           +41.3%      32.94           +11.4%      25.96        aim7.time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +343.2%     212238 ±  4%    +117.1%     103949 ±  7%  aim7.time.involuntary_context_switches
      6674           +26.7%       8455           +26.6%       8447           +10.5%       7372        aim7.time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +81.4%       2740           +23.8%       1869        aim7.time.system_time
     19454 ±  3%      +9.1%      21223 ±  3%      +8.3%      21069 ±  3%      -3.5%      18782 ±  4%  aim7.time.voluntary_context_switches
     23.31           +41.4%      32.96           +41.3%      32.94           +11.4%      25.96        time.elapsed_time
     23.31           +41.4%      32.96           +41.3%      32.94           +11.4%      25.96        time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +343.2%     212238 ±  4%    +117.1%     103949 ±  7%  time.involuntary_context_switches
      6674           +26.7%       8455           +26.6%       8447           +10.5%       7372        time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +81.4%       2740           +23.8%       1869        time.system_time
     45.72            -4.9%      43.47            -4.7%      43.58            -1.7%      44.96        time.user_time
     19454 ±  3%      +9.1%      21223 ±  3%      +8.3%      21069 ±  3%      -3.5%      18782 ±  4%  time.voluntary_context_switches
     49345 ±  6%    +108.4%     102820 ± 10%     +97.2%      97294 ±  5%     +32.3%      65261 ±  5%  meminfo.Active
     22670 ± 11%    +182.6%      64065 ± 15%    +157.0%      58258 ±  7%     +57.3%      35667 ± 11%  meminfo.Active(anon)
     26674 ±  4%     +45.3%      38754 ±  4%     +46.3%      39035 ±  6%     +10.9%      29594 ±  5%  meminfo.Active(file)
     33695           +18.6%      39973 ±  3%     +18.7%      40010 ±  3%      +3.8%      34971        meminfo.AnonHugePages
    561012 ±  8%     +14.6%     642770 ±  5%     +18.1%     662691 ±  2%      -2.1%     548999 ±  7%  meminfo.Dirty
   1360098 ±  3%     +14.0%    1551107 ±  2%     +16.2%    1580651            +1.6%    1381539 ±  3%  meminfo.Inactive
    803759           +15.0%     924519           +16.2%     933975            +4.7%     841839        meminfo.Inactive(anon)
     66977 ±  3%    +115.7%     144485 ±  7%    +114.7%     143809 ±  5%     +21.0%      81015 ±  3%  meminfo.Mapped
     78152 ±  9%    +188.4%     225431 ±  5%    +192.1%     228311 ±  3%     +64.5%     128567 ±  5%  meminfo.Shmem
     15327 ±  8%     +52.6%      23389 ± 11%     +52.3%      23342 ±  7%     +29.5%      19853 ± 14%  numa-meminfo.node0.Active
     13455 ±  9%     +46.0%      19642 ± 10%     +44.0%      19375 ±  8%     +18.7%      15975 ± 13%  numa-meminfo.node0.Active(file)
     19657 ± 14%    +111.2%      41510 ± 18%    +132.9%      45776 ± 24%     +76.5%      34690 ± 37%  numa-meminfo.node0.Mapped
      6081 ± 16%     +84.9%      11247 ± 42%    +108.9%      12705 ± 44%     +38.8%       8442 ± 13%  numa-meminfo.node0.Shmem
     33647 ±  8%    +134.3%      78825 ± 15%    +115.1%      72392 ±  4%     +35.8%      45703 ±  9%  numa-meminfo.node1.Active
     20790 ± 14%    +188.7%      60020 ± 18%    +155.6%      53149 ±  8%     +52.8%      31760 ± 14%  numa-meminfo.node1.Active(anon)
     12857 ±  7%     +46.3%      18805 ±  9%     +49.7%      19243 ±  7%      +8.4%      13942 ±  8%  numa-meminfo.node1.Active(file)
    285023 ±  5%     +10.9%     316178 ±  5%     +15.2%     328281 ±  6%      -6.1%     267619 ± 11%  numa-meminfo.node1.Dirty
    485228 ± 23%     +85.5%     899983 ± 21%     +90.5%     924573 ± 26%     +85.5%     900160 ± 25%  numa-meminfo.node1.Inactive
    202089 ± 50%    +192.9%     591917 ± 32%    +198.6%     603355 ± 41%    +215.8%     638153 ± 34%  numa-meminfo.node1.Inactive(anon)
    283138 ±  6%      +8.8%     308066 ±  5%     +13.4%     321217 ±  6%      -7.5%     262007 ± 11%  numa-meminfo.node1.Inactive(file)
     47991 ±  7%    +112.0%     101755 ±  8%     +93.7%      92947 ± 18%      -2.6%      46748 ± 32%  numa-meminfo.node1.Mapped
     72431 ±  8%    +194.1%     213055 ±  4%    +191.3%     210966 ±  2%     +65.2%     119653 ±  5%  numa-meminfo.node1.Shmem
    467.96 ± 53%     +99.5%     933.35 ± 29%    +112.2%     993.04 ± 29%    +107.2%     969.49 ± 31%  numa-vmstat.node0.nr_active_anon
      3290 ± 10%     +50.9%       4965 ± 10%     +48.6%       4889 ±  6%     +20.2%       3956 ±  7%  numa-vmstat.node0.nr_active_file
      4793 ± 17%    +113.8%      10249 ± 20%    +142.6%      11627 ± 25%     +84.1%       8827 ± 36%  numa-vmstat.node0.nr_mapped
      1519 ± 16%     +72.6%       2622 ± 33%    +109.2%       3179 ± 44%     +38.8%       2110 ± 13%  numa-vmstat.node0.nr_shmem
    467.96 ± 53%     +99.4%     933.32 ± 29%    +112.2%     993.04 ± 29%    +107.2%     969.49 ± 31%  numa-vmstat.node0.nr_zone_active_anon
      3294 ±  9%     +50.9%       4970 ± 10%     +48.4%       4889 ±  6%     +20.4%       3967 ±  7%  numa-vmstat.node0.nr_zone_active_file
      4955 ± 11%    +202.3%      14980 ± 18%    +173.1%      13536 ±  7%     +61.8%       8017 ± 16%  numa-vmstat.node1.nr_active_anon
      3376 ±  8%     +40.1%       4729 ±  7%     +40.5%       4742 ±  6%      +7.0%       3611 ± 13%  numa-vmstat.node1.nr_active_file
     72003 ±  5%      +9.4%      78780 ±  5%     +12.1%      80713 ±  5%      -7.1%      66888 ± 12%  numa-vmstat.node1.nr_dirty
     50152 ± 51%    +194.6%     147731 ± 32%    +201.7%     151300 ± 41%    +218.6%     159767 ± 34%  numa-vmstat.node1.nr_inactive_anon
     12101 ±  7%    +109.5%      25357 ±  8%     +98.5%      24026 ± 16%      -1.6%      11908 ± 33%  numa-vmstat.node1.nr_mapped
     17201 ±  7%    +208.3%      53026 ±  4%    +211.7%      53610 ±  2%     +75.7%      30214 ±  8%  numa-vmstat.node1.nr_shmem
      4955 ± 11%    +202.3%      14980 ± 18%    +173.1%      13536 ±  7%     +61.8%       8017 ± 16%  numa-vmstat.node1.nr_zone_active_anon
      3352 ±  8%     +41.1%       4729 ±  7%     +41.8%       4753 ±  6%      +7.8%       3612 ± 13%  numa-vmstat.node1.nr_zone_active_file
     50150 ± 51%    +194.6%     147730 ± 32%    +201.7%     151301 ± 41%    +218.6%     159766 ± 34%  numa-vmstat.node1.nr_zone_inactive_anon
     72002 ±  5%      +9.4%      78787 ±  5%     +12.1%      80711 ±  5%      -7.1%      66896 ± 12%  numa-vmstat.node1.nr_zone_write_pending
      5776 ± 11%    +175.1%      15893 ± 16%    +147.7%      14310 ±  6%     +55.0%       8953 ± 11%  proc-vmstat.nr_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +47.0%       9695 ±  4%     +12.6%       7424 ±  5%  proc-vmstat.nr_active_file
    187950            +2.0%     191760            +2.2%     192015            +0.1%     188193        proc-vmstat.nr_anon_pages
    139601 ±  8%     +15.0%     160546 ±  5%     +18.9%     165920 ±  2%      -2.1%     136650 ±  8%  proc-vmstat.nr_dirty
    945653            +6.0%    1002646            +6.6%    1008161            +1.0%     955008        proc-vmstat.nr_file_pages
    201118           +14.8%     230842           +15.8%     232804            +4.7%     210479        proc-vmstat.nr_inactive_anon
     17214 ±  3%    +108.2%      35836 ±  6%    +103.7%      35070 ±  6%     +20.0%      20660 ±  3%  proc-vmstat.nr_mapped
     19951 ±  8%    +180.4%      55933 ±  4%    +180.9%      56052 ±  4%     +61.5%      32218 ±  5%  proc-vmstat.nr_shmem
     40267            +2.7%      41335            +3.2%      41567            -0.7%      39991        proc-vmstat.nr_slab_reclaimable
     86277            +1.8%      87792            +1.7%      87706            +0.1%      86326        proc-vmstat.nr_slab_unreclaimable
      5776 ± 11%    +175.1%      15893 ± 16%    +147.7%      14310 ±  6%     +55.0%       8953 ± 11%  proc-vmstat.nr_zone_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +47.0%       9695 ±  4%     +12.6%       7424 ±  5%  proc-vmstat.nr_zone_active_file
    201118           +14.8%     230842           +15.8%     232804            +4.7%     210479        proc-vmstat.nr_zone_inactive_anon
    139600 ±  8%     +15.0%     160546 ±  5%     +18.9%     165919 ±  2%      -2.1%     136650 ±  8%  proc-vmstat.nr_zone_write_pending
    312.12 ±241%   +1618.1%       5362 ±125%   +1397.7%       4674 ±166%    +521.3%       1939 ±171%  proc-vmstat.numa_pages_migrated
    369792           +19.6%     442285 ±  3%     +16.6%     431187 ±  3%      +2.9%     380386        proc-vmstat.pgfault
    312.12 ±241%   +1618.1%       5362 ±125%   +1397.7%       4674 ±166%    +521.3%       1939 ±171%  proc-vmstat.pgmigrate_success
      2426 ±  2%     +29.2%       3135 ±  3%     +31.4%       3189 ±  2%     +16.3%       2821 ±  3%  proc-vmstat.pgpgout
      1515            +3.8%       1572            +3.4%       1566            +1.3%       1535        proc-vmstat.unevictable_pgs_culled
      0.63 ±  3%     +36.5%       0.85 ±  2%     +35.9%       0.85 ±  3%     +19.4%       0.75 ±  2%  perf-stat.i.MPKI
 1.885e+10           -23.7%  1.437e+10           -22.8%  1.455e+10            -7.4%  1.745e+10 ±  2%  perf-stat.i.branch-instructions
      2.78 ±  2%      -0.5        2.29 ±  4%      -0.5        2.31 ±  5%      -0.2        2.55 ±  4%  perf-stat.i.branch-miss-rate%
  67232899           -17.4%   55553782 ±  3%     -17.1%   55749070 ±  3%      -5.8%   63348903        perf-stat.i.branch-misses
     13.70 ±  3%      +2.5       16.17 ±  3%      +2.5       16.24 ±  2%      +1.1       14.84 ±  2%  perf-stat.i.cache-miss-rate%
  72591570 ±  2%      +0.6%   73035167            +1.8%   73898780 ±  3%     +10.8%   80408900 ±  3%  perf-stat.i.cache-misses
 5.483e+08           -24.9%  4.118e+08           -23.7%  4.181e+08 ±  2%      -5.7%   5.17e+08 ±  2%  perf-stat.i.cache-references
      8605 ±  4%     +34.7%      11593 ±  4%     +34.2%      11552 ±  4%     +23.4%      10618 ±  7%  perf-stat.i.context-switches
      1.35           +65.4%       2.22 ±  3%     +64.8%       2.22 ±  2%     +20.9%       1.63        perf-stat.i.cpi
 1.616e+11           +22.1%  1.973e+11           +23.4%  1.994e+11           +10.5%  1.785e+11 ±  2%  perf-stat.i.cpu-cycles
      2387 ±  4%     +13.8%       2717 ±  4%     +12.0%       2673 ±  3%      +0.6%       2402 ±  3%  perf-stat.i.cycles-between-cache-misses
 8.537e+10           -24.8%  6.416e+10           -23.9%  6.494e+10            -8.0%  7.852e+10 ±  2%  perf-stat.i.instructions
      0.96           -22.2%       0.75 ±  2%     -21.7%       0.75 ±  3%      -9.4%       0.87        perf-stat.i.ipc
     13455           -15.4%      11379 ±  3%     -15.5%      11364 ±  2%      -7.6%      12438        perf-stat.i.minor-faults
     13489           -15.5%      11396 ±  3%     -15.6%      11378 ±  2%      -7.6%      12465        perf-stat.i.page-faults
      0.85 ±  3%     +34.8%       1.15           +34.7%       1.15           +20.2%       1.02 ±  3%  perf-stat.overall.MPKI
      0.34            +0.0        0.36 ±  2%      +0.0        0.36 ±  4%      +0.0        0.35        perf-stat.overall.branch-miss-rate%
     13.23 ±  3%      +4.6       17.78            +4.5       17.71            +2.3       15.52 ±  2%  perf-stat.overall.cache-miss-rate%
      1.90           +62.8%       3.08           +62.5%       3.08           +20.1%       2.28        perf-stat.overall.cpi
      2231 ±  3%     +20.6%       2690 ±  2%     +20.6%       2689 ±  2%      -0.2%       2227 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.53           -38.5%       0.32           -38.5%       0.32           -16.7%       0.44        perf-stat.overall.ipc
  1.86e+10           -23.0%  1.433e+10           -22.3%  1.446e+10 ±  3%      -7.6%  1.719e+10        perf-stat.ps.branch-instructions
  64095803           -19.1%   51843320 ±  2%     -18.9%   52013238 ±  3%      -5.7%   60421424        perf-stat.ps.branch-misses
  71639076 ±  2%      +2.3%   73304464 ±  2%      +3.1%   73894713 ±  4%     +10.4%   79092736 ±  3%  perf-stat.ps.cache-misses
 5.417e+08           -23.9%  4.124e+08           -23.0%  4.171e+08 ±  3%      -5.9%  5.096e+08 ±  2%  perf-stat.ps.cache-references
      8220 ±  4%     +33.3%      10962 ±  4%     +33.2%      10952 ±  4%     +23.9%      10184 ±  8%  perf-stat.ps.context-switches
 1.597e+11           +23.5%  1.972e+11 ±  2%     +24.3%  1.986e+11 ±  3%     +10.2%  1.761e+11 ±  2%  perf-stat.ps.cpu-cycles
 8.426e+10           -24.1%  6.394e+10           -23.5%  6.449e+10 ±  3%      -8.2%  7.737e+10 ±  2%  perf-stat.ps.instructions
     12730           -18.7%      10354 ±  3%     -18.3%      10405 ±  3%      -7.2%      11811        perf-stat.ps.minor-faults
     12762           -18.8%      10369 ±  3%     -18.4%      10417 ±  3%      -7.3%      11836        perf-stat.ps.page-faults
      4.35 ± 10%      -4.4        0.00            -4.4        0.00            -3.5        0.81 ± 20%  perf-profile.calltrace.cycles-pp.unlink
      4.35 ± 10%      -4.3        0.00            -4.3        0.00            -3.5        0.81 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.35 ± 10%      -4.3        0.00            -4.3        0.00            -3.5        0.81 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -4.3        0.00            -3.5        0.80 ± 19%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -4.3        0.00            -3.5        0.80 ± 20%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.14 ± 10%      -4.1        0.00            -4.1        0.00            -3.5        0.65 ± 24%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14 ± 10%      -4.1        0.00            -4.1        0.00            -3.5        0.65 ± 24%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      4.14 ± 10%      -4.1        0.00            -4.1        0.00            -3.6        0.58 ± 45%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      3.99 ± 11%      -4.0        0.00            -4.0        0.00            -3.6        0.40 ± 83%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      3.53 ±  6%      -3.4        0.10 ±212%      -3.5        0.07 ±264%      -2.4        1.12 ± 17%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      3.53 ±  6%      -3.4        0.10 ±212%      -3.5        0.07 ±264%      -2.4        1.12 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      3.52 ±  6%      -3.4        0.10 ±212%      -3.5        0.07 ±264%      -2.4        1.12 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      3.30 ±  7%      -3.3        0.00            -3.3        0.00            -2.3        0.98 ± 19%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      3.93 ±  6%      -3.2        0.69 ±  8%      -3.3        0.65 ±  9%      -2.5        1.44 ± 13%  perf-profile.calltrace.cycles-pp.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -3.3        0.64 ± 10%      -2.5        1.44 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -3.3        0.64 ± 10%      -2.5        1.44 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -3.3        0.64 ± 10%      -2.5        1.43 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -3.3        0.64 ± 10%      -2.5        1.43 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.91 ±  6%      -3.2        0.68 ±  8%      -3.3        0.63 ± 10%      -2.5        1.42 ± 13%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      3.91 ±  6%      -3.2        0.68 ±  8%      -3.3        0.63 ±  9%      -2.5        1.42 ± 13%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  6%      -3.2        0.65 ±  9%      -3.3        0.61 ± 10%      -2.5        1.39 ± 14%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      3.66            -1.7        1.99 ±  2%      -1.6        2.02            -0.6        3.06        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      3.31            -1.5        1.77 ±  2%      -1.5        1.78            -0.6        2.73        perf-profile.calltrace.cycles-pp.llseek
      2.87            -1.3        1.62 ±  2%      -1.2        1.63            -0.5        2.33        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.25            -1.0        1.29 ±  2%      -1.0        1.30            -0.4        1.83        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.17            -0.9        1.25 ±  2%      -0.9        1.26            -0.4        1.76        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      0.86 ±  4%      -0.9        0.00            -0.9        0.00            -0.2        0.62 ±  4%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.filemap_read.vfs_read
      0.79            -0.8        0.00            -0.8        0.00            -0.1        0.74        perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.93            -0.8        1.14 ±  2%      -0.8        1.14            -0.3        1.66        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.76            -0.8        0.00            -0.8        0.00            -0.2        0.58        perf-profile.calltrace.cycles-pp.file_modified.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      1.99            -0.8        1.23 ±  2%      -0.8        1.24            -0.4        1.63        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.74            -0.7        0.00            -0.7        0.00            -0.2        0.58        perf-profile.calltrace.cycles-pp.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.79            -0.7        1.07 ±  2%      -0.7        1.07            -0.2        1.55        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      0.72 ±  2%      -0.7        0.00            -0.7        0.00            -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.69            -0.7        0.00            -0.7        0.00            -0.2        0.54        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.68            -0.7        0.00            -0.7        0.00            -0.2        0.53        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.34            -0.7        0.68 ±  3%      -0.7        0.67            -0.3        1.05        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.65 ±  2%      -0.7        0.00            -0.7        0.00            -0.1        0.52        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.30            -0.6        0.66 ±  3%      -0.6        0.65            -0.3        1.02        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.22            -0.6        0.65 ±  2%      -0.6        0.65            -0.2        0.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.17            -0.5        0.63 ±  2%      -0.5        0.65            -0.2        1.00        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.21            -0.5        0.67 ±  2%      -0.5        0.67 ±  2%      -0.3        0.91        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write
      0.96            -0.5        0.43 ± 47%      -0.4        0.54            -0.1        0.83        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      1.08            -0.5        0.57 ±  3%      -0.5        0.56            -0.2        0.86        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.08            -0.5        0.57 ±  2%      -0.5        0.57            -0.2        0.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.20            -0.5        0.70 ±  3%      -0.5        0.70            -0.2        1.02        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.05            -0.5        0.56 ±  2%      -0.5        0.56            -0.2        0.85        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.91            -0.5        0.42 ± 47%      -0.4        0.52 ±  2%      -0.2        0.67        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end
      1.15            -0.5        0.68 ±  2%      -0.5        0.68            -0.2        0.99        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.02            -0.5        0.55 ±  2%      -0.5        0.56            -0.2        0.86        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      1.30            -0.5        0.83 ±  2%      -0.5        0.83            -0.2        1.05        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.98            -0.5        0.53 ±  2%      -0.4        0.54            -0.2        0.82        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.4        0.66 ±  2%      -0.3        0.80 ±  3%  perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     30.65            -0.4       30.25            -0.4       30.21            +0.7       31.31        perf-profile.calltrace.cycles-pp.read
      0.98            -0.3        0.69 ±  2%      -1.0        0.00            -0.4        0.61        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      2.39            +0.2        2.61            +0.2        2.62            +0.1        2.47        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      2.42            +0.2        2.64            +0.2        2.65            +0.1        2.50        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.39            +0.2        2.61            +0.2        2.62            +0.1        2.48        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      2.42            +0.2        2.64            +0.2        2.65            +0.1        2.50        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.2        2.61            +0.2        2.62            +0.1        2.47        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      2.44            +0.4        2.89            +0.5        2.91            +0.2        2.62        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.5        2.84            +0.5        2.86            +0.2        2.56        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.38            +0.5        2.84            +0.5        2.86            +0.2        2.56        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      2.38            +0.5        2.84            +0.5        2.85            +0.2        2.56        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
     28.52            +0.6       29.11            +0.5       29.06            +1.0       29.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     28.38            +0.7       29.04            +0.6       28.99            +1.0       29.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.86            +0.7        5.54            +0.7        5.56            +0.3        5.13        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     27.89            +0.9       28.77            +0.8       28.72            +1.1       29.02        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.47            +1.1       28.54            +1.0       28.49            +1.2       28.67        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.90            +1.9       27.78            +1.8       27.72            +1.5       27.42        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.26            +4.0       34.31            +3.9       34.16            +3.9       34.16        perf-profile.calltrace.cycles-pp.write
     21.06            +4.1       25.14            +4.0       25.05            +2.3       23.39        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
     19.70            +4.6       24.33            +4.6       24.25            +2.7       22.38        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     19.63            +4.7       24.29            +4.6       24.21            +2.7       22.32        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
     18.85            +4.7       23.52            +4.6       23.44            +2.7       21.52        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     18.84            +4.7       23.51            +4.6       23.44            +2.7       21.52        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     18.83            +4.7       23.51            +4.6       23.43            +2.7       21.51        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     28.38            +5.0       33.33            +4.8       33.17            +4.3       32.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.23            +5.0       33.25            +4.9       33.09            +4.3       32.53        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.72            +5.3       32.99            +5.1       32.83            +4.4       32.13        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.25            +5.5       32.74            +5.3       32.58            +4.5       31.75        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.87            +5.6       31.48            +5.8       31.70            +2.2       28.03        perf-profile.calltrace.cycles-pp.__close
     25.86            +5.6       31.47            +5.8       31.70            +2.2       28.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47            +5.8       31.70            +2.2       28.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.46            +5.8       31.69            +2.2       28.01        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.84            +5.6       31.45            +5.8       31.68            +2.2       28.00        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.82            +5.6       31.44            +5.8       31.67            +2.2       27.99        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.81            +5.6       31.44            +5.9       31.67            +2.2       27.98        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     25.79            +5.6       31.43            +5.9       31.66            +2.2       27.96        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
     25.78            +5.6       31.42            +5.9       31.65            +2.2       27.95        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
     25.63            +5.7       31.33            +5.9       31.56            +2.2       27.83        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
     17.98            +6.1       24.07            +6.3       24.28            +2.4       20.42        perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     17.57            +6.2       23.81            +6.4       24.02            +2.5       20.06        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict
     17.33            +6.3       23.66            +6.5       23.87            +2.5       19.86        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range
     17.34            +6.3       23.66            +6.5       23.87            +2.5       19.86        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode
     17.32            +6.3       23.65            +6.5       23.86            +2.5       19.85        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     25.47            +6.5       31.92            +6.3       31.77            +4.9       30.41        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.72 ±  2%      +7.3       31.06            +7.2       30.91            +5.3       29.06        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     17.89 ±  3%     +10.1       27.95            +9.9       27.79            +6.5       24.39        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     13.68 ±  4%     +12.1       25.73           +11.9       25.55            +7.3       20.95        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     11.76 ±  5%     +13.0       24.76           +12.8       24.57            +7.7       19.42        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      9.80 ±  6%     +13.4       23.16           +13.4       23.18            +8.1       17.87        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      9.81 ±  6%     +13.4       23.17           +13.4       23.18            +8.1       17.87        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      9.79 ±  6%     +13.4       23.16           +13.4       23.18            +8.1       17.86        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     10.38 ±  6%     +13.5       23.85           +13.5       23.87            +8.1       18.48        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     10.32 ±  6%     +13.5       23.82           +13.5       23.84            +8.1       18.43        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      8.04 ±  8%      -7.2        0.84 ±  9%      -7.2        0.80 ± 10%      -6.0        2.06 ± 17%  perf-profile.children.cycles-pp.down_write
      7.67 ±  8%      -7.0        0.65 ± 12%      -7.1        0.62 ± 14%      -5.9        1.77 ± 19%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      7.66 ±  8%      -7.0        0.64 ± 12%      -7.0        0.61 ± 14%      -5.9        1.76 ± 19%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.28 ±  9%      -6.8        0.53 ± 14%      -6.8        0.50 ± 16%      -5.7        1.54 ± 21%  perf-profile.children.cycles-pp.osq_lock
      4.35 ± 10%      -4.1        0.30 ±  8%      -4.0        0.31 ± 10%      -3.5        0.81 ± 19%  perf-profile.children.cycles-pp.unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -4.0        0.30 ±  9%      -3.5        0.80 ± 19%  perf-profile.children.cycles-pp.__x64_sys_unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -4.0        0.30 ±  9%      -3.5        0.80 ± 20%  perf-profile.children.cycles-pp.do_unlinkat
      3.97 ±  6%      -3.3        0.71 ±  8%      -3.3        0.67 ±  9%      -2.5        1.47 ± 13%  perf-profile.children.cycles-pp.do_sys_openat2
      3.95 ±  6%      -3.2        0.70 ±  8%      -3.3        0.66 ±  9%      -2.5        1.45 ± 13%  perf-profile.children.cycles-pp.path_openat
      3.95 ±  6%      -3.2        0.70 ±  8%      -3.3        0.66 ±  9%      -2.5        1.45 ± 13%  perf-profile.children.cycles-pp.do_filp_open
      3.93 ±  6%      -3.2        0.69 ±  8%      -3.3        0.65 ±  9%      -2.5        1.44 ± 13%  perf-profile.children.cycles-pp.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -3.3        0.64 ± 10%      -2.5        1.43 ± 13%  perf-profile.children.cycles-pp.__x64_sys_creat
      3.87 ±  6%      -3.2        0.66 ±  8%      -3.3        0.61 ± 10%      -2.5        1.39 ± 14%  perf-profile.children.cycles-pp.open_last_lookups
      3.70            -1.7        1.98 ±  2%      -1.7        1.99            -0.7        3.05        perf-profile.children.cycles-pp.llseek
      3.68            -1.7        2.00 ±  2%      -1.6        2.03            -0.6        3.08        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.12            -1.4        1.67 ±  2%      -1.4        1.69            -0.5        2.57        perf-profile.children.cycles-pp.clear_bhb_loop
      2.90            -1.3        1.64 ±  2%      -1.2        1.65            -0.5        2.36        perf-profile.children.cycles-pp.ext4_da_write_end
      2.29            -1.0        1.31 ±  2%      -1.0        1.32            -0.4        1.85        perf-profile.children.cycles-pp.block_write_end
      2.20            -0.9        1.26 ±  2%      -0.9        1.27            -0.4        1.78        perf-profile.children.cycles-pp.__block_commit_write
      1.95            -0.8        1.15 ±  2%      -0.8        1.15            -0.3        1.68        perf-profile.children.cycles-pp.copy_page_to_iter
      1.99            -0.8        1.24 ±  2%      -0.8        1.24            -0.4        1.64        perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.80            -0.7        1.08 ±  2%      -0.7        1.08            -0.2        1.56        perf-profile.children.cycles-pp._copy_to_iter
      1.54            -0.7        0.82 ±  2%      -0.7        0.82            -0.3        1.27        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.34            -0.7        0.68 ±  3%      -0.7        0.68            -0.3        1.06        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.32            -0.7        0.67 ±  3%      -0.7        0.66            -0.3        1.04        perf-profile.children.cycles-pp.ext4_da_map_blocks
     31.04            -0.6       30.46            -0.6       30.42            +0.6       31.63        perf-profile.children.cycles-pp.read
      1.19            -0.6        0.64 ±  2%      -0.5        0.66            -0.2        1.01        perf-profile.children.cycles-pp.filemap_get_pages
      1.18            -0.5        0.63 ±  2%      -0.5        0.64            -0.2        0.97        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.22            -0.5        0.68 ±  2%      -0.5        0.68            -0.3        0.92        perf-profile.children.cycles-pp.mark_buffer_dirty
      1.20            -0.5        0.70 ±  2%      -0.5        0.70            -0.2        1.02        perf-profile.children.cycles-pp.zero_user_segments
      1.20            -0.5        0.71 ±  2%      -0.5        0.71            -0.2        1.03        perf-profile.children.cycles-pp.memset_orig
      1.07            -0.5        0.58 ±  2%      -0.5        0.57            -0.2        0.87        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.95            -0.5        0.46 ±  3%      -0.5        0.47 ±  3%      -0.2        0.78 ±  4%  perf-profile.children.cycles-pp.rw_verify_area
      1.32            -0.5        0.84 ±  2%      -0.5        0.84            -0.3        1.06        perf-profile.children.cycles-pp.try_to_free_buffers
      0.98            -0.5        0.53 ±  2%      -0.4        0.56            -0.1        0.85        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.98 ±  2%      -0.4        0.53 ±  3%      -0.4        0.53 ±  2%      -0.2        0.80        perf-profile.children.cycles-pp.__fdget_pos
      0.77 ±  2%      -0.4        0.34 ±  3%      -0.4        0.34            -0.2        0.58 ±  4%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.4        0.67 ±  2%      -0.3        0.80 ±  3%  perf-profile.children.cycles-pp.workingset_activation
      0.80            -0.4        0.37 ±  2%      -0.4        0.37            -0.2        0.60        perf-profile.children.cycles-pp.file_modified
      0.86 ±  4%      -0.4        0.46 ±  3%      -0.4        0.45 ±  2%      -0.2        0.62 ±  3%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.77 ±  2%      -0.4        0.37 ±  3%      -0.4        0.38 ±  3%      -0.1        0.64 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.92            -0.4        0.52 ±  2%      -0.4        0.52 ±  2%      -0.2        0.68        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.80            -0.4        0.42 ±  2%      -0.4        0.42            -0.1        0.65        perf-profile.children.cycles-pp.xas_load
      0.74            -0.4        0.37 ±  3%      -0.4        0.37            -0.2        0.58        perf-profile.children.cycles-pp.folio_alloc_noprof
      0.70            -0.4        0.33 ±  3%      -0.4        0.33            -0.2        0.54        perf-profile.children.cycles-pp.touch_atime
      0.60 ±  2%      -0.4        0.24 ±  4%      -0.4        0.24 ±  3%      -0.2        0.42        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.71            -0.4        0.35 ±  3%      -0.4        0.35            -0.2        0.55        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.80            -0.4        0.45 ±  2%      -0.3        0.48 ±  2%      -0.1        0.74        perf-profile.children.cycles-pp.create_empty_buffers
      0.68 ±  2%      -0.3        0.36 ±  3%      -0.3        0.36            -0.1        0.54        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.62            -0.3        0.30 ±  3%      -0.3        0.30            -0.1        0.48        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.59 ±  2%      -0.3        0.28 ±  3%      -0.3        0.28 ±  4%      -0.1        0.48 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.62            -0.3        0.32 ±  3%      -0.3        0.32 ±  2%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.64            -0.3        0.34 ±  3%      -0.3        0.34            -0.1        0.52        perf-profile.children.cycles-pp.ksys_lseek
      1.01            -0.3        0.71 ±  2%      -0.5        0.50 ±  2%      -0.4        0.62        perf-profile.children.cycles-pp.__filemap_add_folio
      0.62            -0.3        0.32 ±  3%      -0.3        0.32            -0.1        0.51        perf-profile.children.cycles-pp.filemap_get_entry
      0.57            -0.3        0.28 ±  3%      -0.3        0.28            -0.1        0.45        perf-profile.children.cycles-pp.atime_needs_update
      0.69            -0.3        0.40 ±  2%      -0.3        0.40 ±  3%      -0.2        0.50        perf-profile.children.cycles-pp.folio_account_dirtied
      0.61            -0.3        0.32 ±  2%      -0.3        0.33 ±  2%      -0.1        0.50 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  2%      -0.3        0.32 ±  3%      -0.3        0.32 ±  2%      -0.1        0.48        perf-profile.children.cycles-pp.fault_in_readable
      0.62            -0.3        0.35 ±  2%      -0.2        0.39 ±  2%      -0.0        0.59        perf-profile.children.cycles-pp.folio_alloc_buffers
      0.58            -0.3        0.32 ±  2%      -0.3        0.32            -0.1        0.48        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      -0.3        0.11 ±  4%      -0.3        0.10 ±  4%      -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.40 ±  6%      -0.3        0.14 ±  3%      -0.3        0.13 ±  4%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.51 ±  3%      -0.2        0.27 ±  3%      -0.3        0.26 ±  3%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.disk_rr
      0.59            -0.2        0.34 ±  2%      -0.2        0.34            -0.1        0.49        perf-profile.children.cycles-pp.kmem_cache_free
      0.46            -0.2        0.22 ±  2%      -0.2        0.22            -0.1        0.36        perf-profile.children.cycles-pp.get_page_from_freelist
      0.55 ±  2%      -0.2        0.31 ±  3%      -0.2        0.34            -0.0        0.52        perf-profile.children.cycles-pp.alloc_buffer_head
      0.53            -0.2        0.30 ±  2%      -0.2        0.34            -0.0        0.51        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.36 ±  6%      -0.2        0.14 ±  5%      -0.2        0.14 ±  4%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.36 ±  3%      -0.2        0.14 ±  4%      -0.2        0.14            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.40            -0.2        0.20 ±  2%      -0.2        0.21 ±  2%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44            -0.2        0.25 ±  3%      -0.2        0.22 ±  2%      -0.1        0.34        perf-profile.children.cycles-pp.xas_store
      0.39            -0.2        0.19 ±  3%      -0.2        0.19 ±  2%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.52            -0.2        0.33 ±  2%      -0.2        0.33 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.29 ±  4%      -0.2        0.10 ±  6%      -0.2        0.10 ±  4%      -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.generic_update_time
      0.36 ±  2%      -0.2        0.18 ±  4%      -0.2        0.18 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.57 ±  2%      -0.2        0.40 ±  3%      -0.2        0.41            -0.1        0.44        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.34 ±  2%      -0.2        0.18 ±  3%      -0.2        0.19            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.25 ±  4%      -0.2        0.09 ±  5%      -0.2        0.09            -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.33            -0.2        0.17 ±  2%      -0.2        0.16 ±  2%      -0.1        0.25        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.34            -0.2        0.18 ±  2%      -0.2        0.18 ±  2%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.22 ±  5%      -0.2        0.06 ±  9%      -0.2        0.06            -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.21 ±  5%      -0.2        0.06 ±  8%      -0.2        0.05 ±  8%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.start_this_handle
      0.31            -0.1        0.17 ±  3%      -0.1        0.17 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.40            -0.1        0.25 ±  2%      -0.1        0.25            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ±  2%      -0.1        0.17 ±  3%      -0.1        0.20 ±  2%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.31 ±  2%      -0.1        0.18 ±  2%      -0.1        0.18            -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.block_invalidate_folio
      0.29 ±  2%      -0.1        0.16 ±  2%      -0.1        0.16 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.49            -0.1        0.36 ±  3%      -0.1        0.36            -0.1        0.38        perf-profile.children.cycles-pp.folio_account_cleaned
      0.32            -0.1        0.19 ±  2%      -0.1        0.18 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.27            -0.1        0.14 ±  2%      -0.1        0.14            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.generic_write_checks
      0.26 ±  3%      -0.1        0.13 ±  3%      -0.1        0.14 ±  3%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  2%      -0.1        0.13 ±  4%      -0.1        0.13 ±  2%      -0.1        0.20        perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.27 ±  2%      -0.1        0.14 ±  4%      -0.1        0.14            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.up_write
      0.27            -0.1        0.14 ±  3%      -0.1        0.14 ±  2%      -0.0        0.22        perf-profile.children.cycles-pp.xas_start
      0.35 ±  2%      -0.1        0.22            -0.1        0.22            -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.17 ±  4%      -0.1        0.06 ±  6%      -0.1        0.06 ±  5%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.23            -0.1        0.12 ±  3%      -0.1        0.12 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.folio_unlock
      0.22 ±  2%      -0.1        0.12 ±  3%      -0.1        0.12 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.current_time
      0.27            -0.1        0.16 ±  3%      -0.1        0.16 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.27 ±  2%      -0.1        0.17 ±  3%      -0.1        0.17            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18            -0.1        0.08 ±  5%      -0.1        0.08 ±  5%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.21 ±  2%      -0.1        0.12 ±  4%      -0.1        0.11 ±  4%      -0.0        0.17        perf-profile.children.cycles-pp.__slab_free
      0.26 ±  3%      -0.1        0.16 ±  2%      -0.1        0.16 ±  2%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.93 ±  2%      -0.1        0.84 ±  3%      -0.1        0.83 ±  2%      -0.2        0.72 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.18 ±  2%      -0.1        0.09 ±  3%      -0.1        0.09 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  2%      -0.1        0.10 ±  5%      -0.1        0.10 ±  5%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.20            -0.1        0.11 ±  2%      -0.1        0.11 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.21            -0.1        0.12 ±  2%      -0.1        0.12 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.18            -0.1        0.09 ±  4%      -0.1        0.09            -0.0        0.14        perf-profile.children.cycles-pp.rmqueue
      0.20 ±  2%      -0.1        0.12 ±  4%      -0.1        0.12 ±  3%      -0.0        0.17        perf-profile.children.cycles-pp.find_lock_entries
      0.17 ±  5%      -0.1        0.08 ±  5%      -0.1        0.08 ±  5%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.19 ±  2%      -0.1        0.10 ±  4%      -0.1        0.10            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.17            -0.1        0.09 ±  4%      -0.1        0.09 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.08            -0.1        0.00            -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.21 ±  2%      -0.1        0.13 ±  3%      -0.1        0.13 ±  2%      -0.1        0.16        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  5%      -0.1        0.00            -0.1        0.00            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      0.08 ±  5%      -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.children.cycles-pp.rcu_core
      0.17            -0.1        0.09 ±  4%      -0.1        0.09 ±  5%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.free_unref_folios
      0.08 ±  5%      -0.1        0.01 ±212%      -0.0        0.04 ± 37%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±  3%      -0.1        0.01 ±163%      -0.1        0.01 ±173%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.generic_file_llseek_size
      0.08 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      0.20 ±  3%      -0.1        0.13 ±  3%      -0.1        0.13 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.16 ±  2%      -0.1        0.09 ±  4%      -0.1        0.09 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.08 ±  4%      -0.1        0.00 ±316%      -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.xas_create
      0.09 ±  5%      -0.1        0.01 ±163%      -0.1        0.00            -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.19            -0.1        0.12 ±  4%      -0.1        0.11 ±  4%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.14 ±  3%      -0.1        0.07 ±  6%      -0.1        0.07 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__es_insert_extent
      0.16 ±  3%      -0.1        0.08 ±  5%      -0.1        0.09 ±  5%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.__ext4_unlink
      0.14 ±  4%      -0.1        0.07            -0.1        0.07            -0.0        0.11 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ±  4%      -0.1        0.00            -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.__es_remove_extent
      0.07 ±  4%      -0.1        0.00            -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.read@plt
      0.14 ±  2%      -0.1        0.07            -0.1        0.07 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.16 ±  3%      -0.1        0.09 ±  5%      -0.1        0.09 ±  5%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.ext4_unlink
      0.08 ±  6%      -0.1        0.00 ±316%      -0.1        0.00            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.xas_clear_mark
      0.08 ±  5%      -0.1        0.01 ±163%      -0.1        0.02 ±129%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.folio_mapping
      0.07            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp.node_page_state
      0.07            -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.18 ±  2%      -0.1        0.12 ±  4%      -0.1        0.12 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.update_process_times
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.1        0.08            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.12 ±  5%      -0.1        0.05 ±  8%      -0.1        0.05 ±  9%      -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.07 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp.folio_wait_stable
      0.07 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp.free_unref_page_commit
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.13            -0.1        0.07 ±  7%      -0.1        0.07 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.12 ±  4%      -0.1        0.06 ±  7%      -0.1        0.06 ±  6%      -0.0        0.10        perf-profile.children.cycles-pp.__xa_set_mark
      0.12 ±  2%      -0.1        0.06            -0.1        0.06 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.13 ±  3%      -0.1        0.07 ±  7%      -0.1        0.06 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ext4_llseek
      0.07            -0.1        0.01 ±212%      -0.1        0.01 ±264%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp._raw_spin_trylock
      0.06            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp.bdev_getblk
      0.06            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.06            -0.1        0.00            -0.1        0.01 ±264%      -0.0        0.04 ± 37%  perf-profile.children.cycles-pp.add_dirent_to_buf
      0.15 ±  2%      -0.1        0.09 ±  4%      -0.1        0.09 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.12            -0.1        0.06 ±  6%      -0.1        0.06            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.amd_clear_divider
      0.12 ±  2%      -0.1        0.06 ±  6%      -0.1        0.06            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.11 ±  5%      -0.1        0.06 ±  6%      -0.1        0.06 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inode_to_bdi
      0.09 ±  5%      -0.1        0.04 ± 47%      -0.0        0.04 ± 37%      -0.0        0.07        perf-profile.children.cycles-pp.handle_softirqs
      0.50            -0.1        0.45 ±  3%      -0.0        0.46            +0.0        0.55        perf-profile.children.cycles-pp.folio_activate_fn
      0.11 ±  2%      -0.1        0.06            -0.1        0.06            -0.0        0.09        perf-profile.children.cycles-pp.__ext4_new_inode
      0.12 ±  2%      -0.1        0.07            -0.1        0.07            -0.0        0.10        perf-profile.children.cycles-pp.try_charge_memcg
      0.11 ±  4%      -0.1        0.06 ±  4%      -0.1        0.06            -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.timestamp_truncate
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.0        0.07 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.1        0.07 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.drop_buffers
      0.13 ±  3%      -0.0        0.08 ±  3%      -0.0        0.08 ±  8%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.11 ±  3%      -0.0        0.06 ±  6%      -0.0        0.06            -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.12 ±  8%      -0.0        0.08 ±  6%      -0.0        0.08 ±  7%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.12            -0.0        0.08 ±  5%      -0.0        0.08 ±  7%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.13 ±  3%      -0.0        0.09            -0.0        0.09            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.10 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.09            -0.0        0.05            -0.0        0.05            -0.0        0.07        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.08 ±  4%      -0.0        0.04 ± 47%      -0.0        0.04 ± 37%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.17            -0.0        0.13 ±  3%      -0.0        0.13 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.09 ±  4%      -0.0        0.05 ±  9%      -0.0        0.05 ±  9%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.ext4_lookup
      0.09 ±  4%      -0.0        0.06            -0.0        0.06 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  3%      -0.0        0.06 ±  8%      -0.0        0.05 ±  9%      -0.0        0.07        perf-profile.children.cycles-pp.ext4_add_nondir
      0.24 ±  2%      -0.0        0.22 ±  2%      -0.2        0.00            -0.2        0.06        perf-profile.children.cycles-pp.xas_find_conflict
      0.08 ±  4%      -0.0        0.05            -0.0        0.04 ± 37%      -0.0        0.06        perf-profile.children.cycles-pp.ext4_add_entry
      0.08 ±  5%      -0.0        0.05            -0.0        0.04 ± 57%      -0.0        0.06        perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.13 ±  3%      -0.0        0.11 ±  5%      -0.0        0.11            -0.0        0.11        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07            -0.0        0.05 ± 31%      -0.0        0.04 ± 38%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.ext4_search_dir
      0.26 ±  3%      -0.0        0.24 ±  8%      -0.0        0.24 ±  2%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.26 ±  3%      -0.0        0.24 ±  8%      -0.0        0.24 ±  2%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.do_group_exit
      0.26 ±  3%      -0.0        0.24 ±  9%      -0.0        0.25 ±  4%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.do_exit
      0.24 ±  4%      -0.0        0.24 ±  8%      -0.0        0.24 ±  2%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.exit_mm
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.0        0.25 ±  2%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__mmput
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.0        0.25 ±  2%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.exit_mmap
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.0        0.22 ±  3%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.0        0.22 ±  3%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.0        0.22 ±  3%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.34 ±  2%      +0.0        0.37            +0.0        0.36            -0.0        0.32        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.1        0.05 ±  5%      +0.1        0.05            +0.1        0.05        perf-profile.children.cycles-pp.lru_add_drain
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.1        0.15 ±  2%      +0.0        0.11        perf-profile.children.cycles-pp.__cmd_record
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.1        0.15 ±  2%      +0.0        0.11        perf-profile.children.cycles-pp.cmd_record
      0.08 ±  4%      +0.1        0.14 ±  4%      +0.1        0.14 ±  2%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.1        0.15 ±  2%      +0.0        0.11 ±  2%  perf-profile.children.cycles-pp.main
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.1        0.15 ±  2%      +0.0        0.11 ±  2%  perf-profile.children.cycles-pp.run_builtin
      0.08 ±  6%      +0.1        0.14 ±  4%      +0.1        0.14 ±  2%      +0.0        0.10        perf-profile.children.cycles-pp.perf_mmap__push
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.1        0.13 ±  3%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.record__pushfn
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.1        0.14 ±  3%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.writen
      0.06            +0.1        0.13 ±  5%      +0.1        0.13            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.10 ±  4%      +0.1        0.11 ±  4%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.11 ±  6%      +0.1        0.11            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.11 ±  6%      +0.1        0.11            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.shmem_write_begin
      2.45            +0.2        2.70            +0.3        2.70            +0.1        2.55        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.86            +0.7        5.54            +0.7        5.56            +0.3        5.13        perf-profile.children.cycles-pp.__folio_batch_release
     27.93            +0.9       28.79            +0.8       28.74            +1.1       29.05        perf-profile.children.cycles-pp.ksys_read
     27.50            +1.1       28.56            +1.0       28.51            +1.2       28.70        perf-profile.children.cycles-pp.vfs_read
     25.97            +1.8       27.81            +1.8       27.76            +1.5       27.48        perf-profile.children.cycles-pp.filemap_read
     92.83            +3.3       96.09            +3.3       96.08            +1.3       94.11        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.42            +3.5       95.88            +3.4       95.87            +1.4       93.79        perf-profile.children.cycles-pp.do_syscall_64
     30.73            +3.9       34.66            +3.8       34.50            +3.8       34.58        perf-profile.children.cycles-pp.write
     21.08            +4.1       25.15            +4.0       25.07            +2.3       23.40        perf-profile.children.cycles-pp.folio_mark_accessed
     19.70            +4.6       24.33            +4.6       24.25            +2.7       22.38        perf-profile.children.cycles-pp.folio_activate
     27.83            +5.3       33.14            +5.2       32.98            +4.4       32.25        perf-profile.children.cycles-pp.ksys_write
     27.36            +5.5       32.89            +5.4       32.73            +4.5       31.87        perf-profile.children.cycles-pp.vfs_write
     25.87            +5.6       31.48            +5.8       31.71            +2.2       28.03        perf-profile.children.cycles-pp.__close
     25.86            +5.6       31.46            +5.8       31.69            +2.2       28.01        perf-profile.children.cycles-pp.__x64_sys_close
     25.84            +5.6       31.46            +5.8       31.68            +2.2       28.00        perf-profile.children.cycles-pp.__fput
     25.83            +5.6       31.45            +5.8       31.68            +2.2       27.99        perf-profile.children.cycles-pp.dput
     25.82            +5.6       31.44            +5.9       31.67            +2.2       27.98        perf-profile.children.cycles-pp.__dentry_kill
     25.79            +5.6       31.43            +5.9       31.66            +2.2       27.96        perf-profile.children.cycles-pp.evict
     25.78            +5.6       31.42            +5.9       31.65            +2.2       27.95        perf-profile.children.cycles-pp.ext4_evict_inode
     25.64            +5.7       31.34            +5.9       31.57            +2.2       27.83        perf-profile.children.cycles-pp.truncate_inode_pages_range
     18.31            +6.0       24.35            +6.3       24.56            +2.5       20.82        perf-profile.children.cycles-pp.folios_put_refs
     17.78            +6.3       24.04            +6.5       24.25            +2.6       20.37        perf-profile.children.cycles-pp.__page_cache_release
     25.54            +6.4       31.96            +6.3       31.81            +4.9       30.47        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     23.87 ±  2%      +7.4       31.23            +7.2       31.09            +5.3       29.21        perf-profile.children.cycles-pp.generic_perform_write
     17.93 ±  3%     +10.0       27.97            +9.9       27.81            +6.5       24.43        perf-profile.children.cycles-pp.ext4_da_write_begin
     13.75 ±  4%     +12.0       25.77           +11.8       25.58            +7.3       21.00        perf-profile.children.cycles-pp.__filemap_get_folio
     11.78 ±  5%     +13.0       24.77           +12.8       24.57            +7.7       19.43        perf-profile.children.cycles-pp.filemap_add_folio
     10.41 ±  6%     +13.5       23.96           +13.6       23.98            +8.1       18.54        perf-profile.children.cycles-pp.folio_add_lru
     34.89 ±  2%     +18.9       53.82           +18.9       53.79           +11.1       46.00        perf-profile.children.cycles-pp.folio_batch_move_lru
     51.11           +25.1       76.23           +25.3       76.40           +13.7       64.78        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     51.02           +25.2       76.18           +25.3       76.36           +13.7       64.70        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     50.98           +25.3       76.24           +25.4       76.41           +13.7       64.69        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.25 ±  9%      -6.7        0.53 ± 14%      -6.8        0.50 ± 16%      -5.7        1.54 ± 21%  perf-profile.self.cycles-pp.osq_lock
      3.09            -1.4        1.65 ±  2%      -1.4        1.67            -0.5        2.55        perf-profile.self.cycles-pp.clear_bhb_loop
      1.79            -0.7        1.07 ±  2%      -0.7        1.07            -0.2        1.54        perf-profile.self.cycles-pp._copy_to_iter
      1.14            -0.5        0.61 ±  2%      -0.5        0.62            -0.2        0.94        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.20            -0.5        0.70 ±  2%      -0.5        0.70            -0.2        1.02        perf-profile.self.cycles-pp.memset_orig
      1.06            -0.5        0.57 ±  2%      -0.5        0.56 ±  2%      -0.2        0.86        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.97            -0.5        0.51 ±  2%      -0.5        0.51            -0.2        0.79        perf-profile.self.cycles-pp.filemap_read
      0.94 ±  2%      -0.4        0.51 ±  3%      -0.4        0.51            -0.2        0.78        perf-profile.self.cycles-pp.__fdget_pos
      0.86 ±  4%      -0.4        0.45 ±  3%      -0.4        0.44 ±  2%      -0.2        0.62 ±  4%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.75 ±  2%      -0.4        0.38 ±  3%      -0.4        0.38 ±  2%      -0.2        0.59        perf-profile.self.cycles-pp.vfs_write
      0.89            -0.3        0.55 ±  2%      -0.3        0.55            -0.1        0.80        perf-profile.self.cycles-pp.__block_commit_write
      0.54 ±  3%      -0.3        0.21 ±  4%      -0.3        0.22 ±  3%      -0.2        0.38        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  3%      -0.3        0.20 ±  3%      -0.3        0.20 ±  2%      -0.1        0.37 ±  6%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.63            -0.3        0.33 ±  2%      -0.3        0.33            -0.1        0.52        perf-profile.self.cycles-pp.vfs_read
      0.57            -0.3        0.29 ±  2%      -0.3        0.30            -0.1        0.46        perf-profile.self.cycles-pp.do_syscall_64
      0.61            -0.3        0.33 ±  2%      -0.3        0.36            -0.1        0.54        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.58 ±  2%      -0.3        0.31 ±  3%      -0.3        0.31 ±  2%      -0.1        0.46        perf-profile.self.cycles-pp.fault_in_readable
      0.37 ±  3%      -0.3        0.10 ±  4%      -0.3        0.10 ±  6%      -0.2        0.22 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.56            -0.3        0.29 ±  3%      -0.3        0.29            -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.38 ±  6%      -0.3        0.13 ±  4%      -0.3        0.12 ±  6%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.48 ±  2%      -0.2        0.24 ±  4%      -0.2        0.24 ±  2%      -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.35 ±  5%      -0.2        0.13 ±  5%      -0.2        0.13 ±  4%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.46 ±  2%      -0.2        0.24 ±  2%      -0.2        0.24 ±  2%      -0.1        0.36 ±  3%  perf-profile.self.cycles-pp.write
      0.45 ±  2%      -0.2        0.23 ±  6%      -0.2        0.23 ±  4%      -0.1        0.35 ±  4%  perf-profile.self.cycles-pp.disk_rr
      0.39 ±  3%      -0.2        0.18 ±  4%      -0.2        0.18 ±  6%      -0.1        0.33 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.36 ±  4%      -0.2        0.15 ±  4%      -0.2        0.15 ±  3%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.44            -0.2        0.23 ±  2%      -0.2        0.24 ±  2%      -0.1        0.37        perf-profile.self.cycles-pp.ext4_da_write_end
      0.44            -0.2        0.23 ±  2%      -0.2        0.24 ±  2%      -0.1        0.36        perf-profile.self.cycles-pp.__filemap_get_folio
      0.42            -0.2        0.21 ±  2%      -0.2        0.22            -0.1        0.34        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.42 ±  2%      -0.2        0.22 ±  3%      -0.2        0.22 ±  2%      -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      0.40            -0.2        0.20 ±  2%      -0.2        0.21            -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  2%      -0.2        0.24 ±  3%      -0.2        0.23 ±  2%      -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.read
      0.40 ±  2%      -0.2        0.21 ±  3%      -0.2        0.21            -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41            -0.2        0.22 ±  3%      -0.2        0.22            -0.1        0.34        perf-profile.self.cycles-pp.llseek
      0.33            -0.2        0.17 ±  2%      -0.2        0.16 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.33 ±  2%      -0.2        0.17 ±  3%      -0.2        0.17            -0.1        0.26        perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      -0.2        0.13 ±  3%      -0.2        0.13            -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.30 ±  2%      -0.1        0.16 ±  3%      -0.1        0.16 ±  2%      -0.1        0.24        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.30            -0.1        0.16 ±  4%      -0.1        0.16 ±  3%      -0.1        0.25        perf-profile.self.cycles-pp.filemap_get_entry
      0.30            -0.1        0.16 ±  3%      -0.1        0.16 ±  2%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            -0.1        0.14 ±  4%      -0.1        0.14 ±  2%      -0.1        0.22        perf-profile.self.cycles-pp.folio_mark_accessed
      0.27            -0.1        0.14 ±  2%      -0.1        0.14            -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.12 ±  5%      -0.1        0.00            -0.1        0.00            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.start_this_handle
      0.26            -0.1        0.14 ±  3%      -0.1        0.13 ±  3%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.25            -0.1        0.13 ±  3%      -0.1        0.13 ±  3%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.down_write
      0.25            -0.1        0.14 ±  2%      -0.1        0.14 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.27 ±  2%      -0.1        0.16 ±  2%      -0.1        0.16 ±  3%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.block_invalidate_folio
      0.24 ±  2%      -0.1        0.12 ±  3%      -0.1        0.12 ±  3%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.up_write
      0.16 ±  4%      -0.1        0.06 ±  7%      -0.1        0.06 ±  7%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.20 ±  2%      -0.1        0.10            -0.1        0.10            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.21 ±  2%      -0.1        0.11            -0.1        0.11            -0.0        0.17        perf-profile.self.cycles-pp.folio_unlock
      0.23            -0.1        0.13 ±  3%      -0.1        0.11 ±  2%      -0.1        0.17        perf-profile.self.cycles-pp.xas_store
      0.21 ±  2%      -0.1        0.11            -0.1        0.11 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.xas_start
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.filemap_get_pages
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  4%      -0.1        0.10 ±  4%      -0.1        0.10 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22            -0.1        0.12 ±  3%      -0.1        0.12 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.folios_put_refs
      0.20 ±  2%      -0.1        0.11 ±  3%      -0.1        0.11            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.18            -0.1        0.09 ±  3%      -0.1        0.08 ±  5%      -0.0        0.13        perf-profile.self.cycles-pp.__filemap_add_folio
      0.17 ±  2%      -0.1        0.09 ±  4%      -0.1        0.09 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.18 ±  2%      -0.1        0.09 ±  5%      -0.1        0.09            -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.08 ±  4%      -0.1        0.00            -0.1        0.00            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.08 ±  7%      -0.1        0.00            -0.1        0.02 ±100%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.08            -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.__es_insert_extent
      0.08            -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.ext4_es_insert_delayed_block
      0.08            -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.rmqueue
      0.08 ±  8%      -0.1        0.00            -0.1        0.01 ±264%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.inode_to_bdi
      0.17            -0.1        0.09 ±  4%      -0.1        0.09            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.08 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.05 ±  9%  perf-profile.self.cycles-pp._raw_read_lock
      0.08 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.generic_file_llseek_size
      0.16 ±  3%      -0.1        0.08 ±  3%      -0.1        0.08            -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.15            -0.1        0.07 ±  6%      -0.1        0.08 ±  5%      -0.0        0.12        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.1        0.09 ±  3%      -0.1        0.08 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.__mark_inode_dirty
      0.07 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.generic_file_read_iter
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.1        0.08            -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.current_time
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.1        0.08            -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.ksys_write
      0.15 ±  6%      -0.1        0.07 ±  6%      -0.1        0.07 ±  4%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ±  2%      -0.1        0.08            -0.1        0.08            -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.generic_write_checks
      0.15 ±  4%      -0.1        0.08 ±  6%      -0.0        0.10 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.1        0.08 ±  6%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.1        0.08            -0.0        0.12        perf-profile.self.cycles-pp.ksys_read
      0.07 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.07 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.ext4_generic_write_checks
      0.07 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.08            -0.1        0.01 ±163%      -0.1        0.02 ±100%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.free_unref_folios
      0.18 ±  2%      -0.1        0.11 ±  3%      -0.1        0.11 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.13            -0.1        0.06 ±  7%      -0.1        0.07 ±  7%      -0.0        0.10        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  3%      -0.1        0.06 ±  4%      -0.1        0.06 ±  7%      -0.0        0.10        perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.folio_activate
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.xas_clear_mark
      0.15 ±  2%      -0.1        0.09 ±  5%      -0.1        0.09            -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.find_lock_entries
      0.14            -0.1        0.08 ±  6%      -0.1        0.08 ±  4%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  7%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.amd_clear_divider
      0.13 ±  5%      -0.1        0.07 ±  7%      -0.1        0.08 ±  8%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.06 ±  6%      -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.try_to_free_buffers
      0.12 ±  2%      -0.1        0.06            -0.1        0.06            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.node_dirty_ok
      0.06            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.06            -0.1        0.00            -0.1        0.00            -0.0        0.05        perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.12            -0.1        0.06 ±  6%      -0.1        0.06            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ksys_lseek
      0.09            -0.1        0.03 ± 75%      -0.1        0.03 ± 77%      -0.0        0.07        perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.12            -0.1        0.06 ±  7%      -0.1        0.06 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.create_empty_buffers
      0.12 ±  4%      -0.1        0.06            -0.1        0.06 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.__dquot_alloc_space
      0.10 ±  3%      -0.1        0.05 ± 31%      -0.1        0.04 ± 57%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.12 ±  4%      -0.1        0.06 ±  4%      -0.1        0.06            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.09            -0.1        0.04 ± 61%      -0.1        0.02 ±100%      -0.0        0.07        perf-profile.self.cycles-pp.file_modified
      0.11 ±  4%      -0.1        0.05 ±  8%      -0.1        0.05            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ext4_llseek
      0.10 ±  4%      -0.1        0.05            -0.1        0.05 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.11 ±  4%      -0.1        0.06 ±  8%      -0.1        0.06 ±  9%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.10 ±  5%      -0.1        0.05            -0.1        0.05            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.file_remove_privs_flags
      0.10 ±  5%      -0.1        0.05            -0.1        0.05            -0.0        0.08        perf-profile.self.cycles-pp.block_write_end
      0.10            -0.1        0.05            -0.1        0.05            -0.0        0.08        perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      -0.0        0.07 ±  6%      -0.0        0.07 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.07 ±  5%      -0.0        0.07            -0.0        0.10        perf-profile.self.cycles-pp.drop_buffers
      0.10 ±  5%      -0.0        0.05            -0.0        0.05            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ±  5%      -0.0        0.05 ±  5%      -0.0        0.05            -0.0        0.08        perf-profile.self.cycles-pp.folio_account_cleaned
      0.10 ±  4%      -0.0        0.06 ±  8%      -0.0        0.05 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ±  9%      -0.0        0.07 ±  8%      -0.0        0.07 ±  9%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.07            -0.0        0.07            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  5%      -0.0        0.06 ±  4%      -0.0        0.06 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__page_cache_release
      0.23 ±  3%      -0.0        0.21 ±  2%      -0.2        0.00            -0.2        0.05        perf-profile.self.cycles-pp.xas_find_conflict
      0.23 ±  2%      -0.0        0.22 ±  3%      -0.0        0.22 ±  4%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.workingset_activation
      0.25 ±  2%      +0.0        0.28 ±  4%      +0.0        0.28            +0.0        0.30        perf-profile.self.cycles-pp.folio_activate_fn
      0.17 ±  3%      +0.1        0.26            +0.1        0.25 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.lru_add_fn
      0.51 ±  2%      +0.1        0.63 ±  3%      +0.1        0.63 ±  2%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.30 ±  5%      +0.2        0.51 ±  2%      +0.2        0.50            +0.0        0.34 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
     50.97           +25.3       76.24           +25.4       76.41           +13.7       64.69        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



