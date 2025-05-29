Return-Path: <cgroups+bounces-8381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99034AC7581
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 03:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F61F1C03FD3
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D921C195;
	Thu, 29 May 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzXEiTxq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452B1A4E9D;
	Thu, 29 May 2025 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483567; cv=fail; b=PUV1/VqhW7Eat3oDHJe7+sEmjW35pVRQsgVBiPKNSejOK/s6BwBwjD6tHafadyUrmABFSerBEKmsn5ZDcNpb4RzPPJ12cFcvhcb1GccRSmhldvgiq2kKgoza/rN2vIz1pXQalpHQH6lar8fSz3mf5Xz30k1b7L12pmJkCIm2nUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483567; c=relaxed/simple;
	bh=NFVpBPfRmW3pGzp65UCEcwiuObtiS5HNfpLuuww2HMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLwiMhbbFcvIPzZmzB12VZrSbK+5d53Uk0YBWzvlNWsvD4qsGb0JCwNaJ1V9KwGxdHADvccajbTww2JdcGXNYRDYirslvmryfM6jl7o6kjx6jCLZ2LE3L3hx0RJmuJWv87ZKoqe46SdAt5JNIFQjTxoKncDquWIuVyFg4QzxagE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzXEiTxq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748483565; x=1780019565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NFVpBPfRmW3pGzp65UCEcwiuObtiS5HNfpLuuww2HMs=;
  b=OzXEiTxqUfrQGA4BTDQlMtk8jra02kckvarJzzk13DX57klsXXURF2jg
   UHxilV+ccjtYDtHPQovsb/GJo6wSDuXhaWqmNQzG112DzoGXyCyGkApc0
   MFszEz1hegu1vltrVIzCb2wcrI1kr8RygVyfO5Tlp7qb/cVnLiicshBZd
   U9NV3OOjuGhby47NqIoheJk1IhM9yXstMd7i3uR964o1Oeyw0BE1CTTk6
   whpXjYif6K717Y38KPiL/njFp73Q0YDop+9hKab5h7r0SniiFrH5zbOf5
   aNhZ85mGiFK9TSKDFauFjCwIVmUB6PLJdpWc/qoeJzkU7Xu2pHLarikMj
   A==;
X-CSE-ConnectionGUID: wHsxnXbKR2ulbBF0g7MPAw==
X-CSE-MsgGUID: t1eC6tm1SqGuJdjSJjTQeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67949821"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="xz'341?scan'341,208,341";a="67949821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:52:43 -0700
X-CSE-ConnectionGUID: HiBB1713Q8mRiME4w9iuDQ==
X-CSE-MsgGUID: emv+JJDBSx+vHoWnOBiouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="xz'341?scan'341,208,341";a="180625149"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:52:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 18:52:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 18:52:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.40)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 18:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP9l3J/ZyTj8L2fvGMfXlFn4gHF8jGOFeoN5CSpnTrtcaJ0TLX13GmqbUsNktsuvmqjzZd7v4/K3yI9ESxIgs/jU1iDpwZUXa0nJoufUc286diUabqZFgG0d4v9pFSNq6CSN5iP/czdTFGd3aC3HNNvbQ93E6/+5TFkaoYnCfFvhdErKDr7CWAUuW0WQNSpihJJ8hhzd/Rg9awCwRO+NNG7tALzXyZwtGXGH6iXuG+iy27AKR7k8arqGhm5GE+qNbj/J7oBM90askuv1+4shFaG077UxXiLT402H0KfotZp3nXgkc0ODTUvzX4YcEb8LeFT0FtvJnMtzfgBvNwDhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwXKepmRzGDDCD6a51qjoeVEhBPNkdCzz0ANChWSc7g=;
 b=Ov3lH8zmPElUbFqhzuZ7EAiPz9jL+ciN6CYIJnrPrRwNNuc1rY8wqbDvhcCjItC7aUpFkIU0KKif3juJtPGGJbjqZNsMrEAUCxBStQluk3nWf4WtOARAo33mSEYL7ItMKSTHXEIGpaVyXtMCFvww2Yw62elZxGwIH/XZXhTcSMjCeR0u6lWJP/5zM2Ci7PO3MY/CFYMvhYWKMF/WgyXBr45IXpQUaG2eJllDLmUTmBpQ3v/aQtP6Dppq0FVfuRFJRx9Ol+Rd2FCuZAl/mzH166VRDFU6/7FzE6GpywM1sChG9l6MarCx2fSkKOQlP/B0+19kH72406Wm0Rx+tc/AuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 29 May
 2025 01:52:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 01:52:22 +0000
Date: Thu, 29 May 2025 09:52:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.de>, Ming Lei <ming.lei@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block] 245618f8e4: stress-ng.fpunch.fail
Message-ID: <aDe9y3Ef+TEacRr3@xsang-OptiPlex-9020>
References: <202505221030.760980df-lkp@intel.com>
 <95753732-9714-42e0-8097-e2b4c3dd5820@linux.ibm.com>
Content-Type: multipart/mixed; boundary="nmxAhTm+iS3xjgoO"
Content-Disposition: inline
In-Reply-To: <95753732-9714-42e0-8097-e2b4c3dd5820@linux.ibm.com>
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0804a174-0092-472e-f4f2-08dd9e537397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9t6ZMXX+usGiJFTcla/CuepAfVp2cwF/pdhrWz4kOxiR+FBT7VrLq+fqO2EJ?=
 =?us-ascii?Q?sGUveCdBgdJ66jE9JhvWashN7ghMV+7Es/RmwhuY3VGNZukciHgp/LlkwYG4?=
 =?us-ascii?Q?AVRnhxC8uIVwvKWs6vr6yWaCMZj8R8KEWsGbl6vQJ+5jr6QcrS149jgdFCmi?=
 =?us-ascii?Q?zGrNdgW+Fhyki+KpPVPLPRK8HzzCaBSvpJEkzIQ0yjKYPV5SOVyySdcbV514?=
 =?us-ascii?Q?4lw6Y6/m6OSj4hRk5m7UhLpgRZXxeLTuWCwQhqzM43JRfSCcoQLSqjkKZZVg?=
 =?us-ascii?Q?uXNyheVxV+SieFAsm5LqJB4c46myQiNgt4dME0Zk0IENFWxRnl5J7YSciBnW?=
 =?us-ascii?Q?mgqqDd+7KSSfQD/iHfzxEHKvMIyqDpPOf3IQhvN6ERT/Yie5fgjWdH9QDbvf?=
 =?us-ascii?Q?vC40RQH8te8+HzRSq/B/Y63V1Zzc1qQc2FSdQhRSS5KItoIRSbQXA1O0gyYd?=
 =?us-ascii?Q?6mPjEduMtecNafSUvF2Vtu4jvs/MnK5pENCHpjs0v+lYCue753DzbTAzjdgN?=
 =?us-ascii?Q?XOgbcRkaEZhBD5/BfX4375xYGEQdiu4T7b3ulCkVZ/sIS5PRYqVf7r3wheuq?=
 =?us-ascii?Q?8qOnF6GPFJWcIT9Ys3FKcHnpDIwOrgqdGYU93ssW9pdhjQOSH1El68HbJsMg?=
 =?us-ascii?Q?zQVhlzQRmcFrJD2avSuvFNytz4fu2iRtaOqorCNjkM36kw3lJ41AFwZQK+e4?=
 =?us-ascii?Q?7XII//MATUoSNbEIz01SK1PXR7sRH4XFrg1dF+AGGJYhnwcVDEOgVj0FxN9F?=
 =?us-ascii?Q?/4a27Iw3xkN2ifo5XZAfrv5j+DrlHgy4/FGpgGiPEFwvc0eAExBF9RNKEHNo?=
 =?us-ascii?Q?4yJR2QYOHRG5bHRgVAT9yXbRIImNu2eguB/5WemKBrMvk0dVdwEBuYq7Pyt9?=
 =?us-ascii?Q?rEuzP9XQIgvBRp+YYZxklDrnfRvhfyTzFjSzdSKE0ZDO8XlB3P11nO/WS/az?=
 =?us-ascii?Q?A/xNRGokn61+dBntyM6kl5znsb0SAsBUZsxTGThninK5mfNQI/A++oaIJMeK?=
 =?us-ascii?Q?uFYnuUyELmA62KElvv9jNWk08obVBLOt1oYSHYm9ZGdTAdfn13vcI+3iRtl9?=
 =?us-ascii?Q?WeuBM0ve1J7yn1yo98brSGwiJSAQ3H+jDo5ztA3IseWkEop3oeTtvnlcAOFh?=
 =?us-ascii?Q?Iz0CDbhnyQtgC3nJrzeXiZw7rXl/I4MdhBp38fTcf7nzMQP+TodQ9fbDIroq?=
 =?us-ascii?Q?xWn5fo0CerTqlvqx6K83DPKUUdgT5kklh/47/ITNKfIqDg6iaKxsDty126O3?=
 =?us-ascii?Q?dueebpm2nxQwq1aobk7A+c6aJU6NgN8MtKendfFjSdyc5c9s5jH8wwSnXj8W?=
 =?us-ascii?Q?P94KhwKNmvaB2itXkWk7GlR2eCCbQVoefuxvxHFnCy3UbBiOidkR8+t/6GrS?=
 =?us-ascii?Q?0d3B59hiZyp8HUrWjTnqv3lRLHIu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FkN92mBz2tG89fLG0bv+X/6rEXX8vuj3uTyZOt9D0CscL8umk260aUamfKCS?=
 =?us-ascii?Q?Z7OJbuZzgemoxVq+PGK9O5wqP7YN6lZFWIXMUDnTT1ad88P/gd/NdaoISPoC?=
 =?us-ascii?Q?cATWBM0xwDRQkrI1sEFwl7kWmW/KpUTcWaYOT5e9cMz4Cj+dqJYUxXZaMRM9?=
 =?us-ascii?Q?gTf2Egnze22x3QUqk2Cvk3yz+NjDVVJNby5kd8ZHvZFz7ip/ujnd4AYtdnFU?=
 =?us-ascii?Q?eBJI1uFPz0jVe+OhsyJi+ZWkbe0059dJUMDV3ydVghhVkEsXHlucQh1fkV9f?=
 =?us-ascii?Q?CR3XAJoeAf5nNswee/Oe17iN03mitKvXGJX6yHDW6xMIjVHHt+51z75+jR9B?=
 =?us-ascii?Q?arrDG7DR56M+g+EcTBkOq0g7H5DYexXGsafNNgDk8sDl4n3f63yPmemh2fzf?=
 =?us-ascii?Q?4SJhRQnEiA2wlEkQF+eEQZJf9CweftBWcqip6Yj1gYLoJfjvJJfTYJ1xFLeU?=
 =?us-ascii?Q?v/AZK3J7Zpvh5Ka5rNMQfdsg2VMDyTP6CINQHHxd7EsWTTdhGZeMQYIqeXfM?=
 =?us-ascii?Q?H8pOCEM8MtuSdZjwnj3hisSVjQvIR9hBvDyraqoUMU3OpZeZJFZlvkZZvNOc?=
 =?us-ascii?Q?7UrfUxdT8Edyt3S8zZE0n2WbYHhXrPWDSxH8gLatfkjGbollTXmsaBVTfk87?=
 =?us-ascii?Q?hxi7OPY1XyIhYUswTe0kZzjzGRCB0PKPNStLctrQht5Vm4DUxsoCZIAjacqD?=
 =?us-ascii?Q?vXz/bwYMSwC9N0HEoq2ceSGRR5FRwnVc+X9hE5nAYOsqCoUqgjg90vWeGAQl?=
 =?us-ascii?Q?nlqI+BqZTfaRFSTjLlaKVU2ZUU+yXy/1O4eyKc4mtGWOSwEGBTvv0TEhcCVw?=
 =?us-ascii?Q?7EXM+OYdGWzYo6SLP21P8+YdgHl0Q8WMI/FMnLJRCV/eKadcs4nA4HFSUOcb?=
 =?us-ascii?Q?FjsCOMsBLT84mnmg8I94WGnLSI1EqDIqU+Fo5fAtnWe+zHrc2yxD74WVFSCc?=
 =?us-ascii?Q?6Uq7qq1/V2RZvPNjEvDNcPR4aWJwGDCLzVFf+cSpNzfE1s3fs/raN2yk1lKE?=
 =?us-ascii?Q?lp6guuE1n+fgLwy76SXKsirfw22FO4JWe09Ab6hDsA2jjodwKYRkrDrSPzj6?=
 =?us-ascii?Q?Tjtgf7nWti14LylA7ptZzpGsrRoNOlVrIfh/xS37jMBv/DqB/bg4L6M+Cs1j?=
 =?us-ascii?Q?YvW3j4cI2NmjS+HIsHSuLJoEJnwuEOdxcXYiTNlI/BbNfpYN52YIxqYxa+Jw?=
 =?us-ascii?Q?UGDxIB/MY3b02BiduURZHtrpORMDEL6Pyd7XFxdjh4F2ldm2Opv6eX1fnGAo?=
 =?us-ascii?Q?lBtM/XsTbYlDN0KfWFpcUSpnxTAzAXq+PPDobo6zkRt0Ar6mjxoGSBetzXPx?=
 =?us-ascii?Q?n3cTNBOCoixMeOWuher3801ABFeK+37Y35KEPtd7f1kkJqAAglccbk+2PxJJ?=
 =?us-ascii?Q?1PJ+ZFpoGWGodTNYKl7qm3ceLvK8HGwMN1h9Px2EgT+jd9+o15QgexVBcz1O?=
 =?us-ascii?Q?m1J6forcRhYsBg8uzn8as5MSY+adJIShnAG+oXwoz5maZPq0oZLsKv1p7DBi?=
 =?us-ascii?Q?MURzRXRb+fNYvqISoBcLKpCNlVOz1gqCE7QVnpgRQbuJC2IYliQ4ibOLXp8H?=
 =?us-ascii?Q?+WAMK5AIgya2WnadJHKS9FG8vAPpJoedFeaKU0u0DHaKLNdEE5sFJy7SPwFP?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0804a174-0092-472e-f4f2-08dd9e537397
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 01:52:22.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/sGgsmQpWnoZviqRaqTXRY3jqbJSF5CGAankcjBBxbQ4uq4nMO2V6aCvwS3UgigzpEPSt/93rQHRm0ZHuU1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

--nmxAhTm+iS3xjgoO
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Nilay,

sorry for late.

On Thu, May 22, 2025 at 06:07:21PM +0530, Nilay Shroff wrote:
> 

[...]

> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202505221030.760980df-lkp@intel.com
> > 
> > 2025-03-20 08:33:52 mkdir -p /mnt/stress-ng
> > 2025-03-20 08:33:52 mount /dev/sdc1 /mnt/stress-ng
> > 2025-03-20 08:33:52 cd /mnt/stress-ng
> >   File: "/mnt/stress-ng"
> >     ID: 82100000000 Namelen: 255     Type: xfs
> > Block size: 4096       Fundamental block size: 4096
> > Blocks: Total: 78604800   Free: 78518242   Available: 78518242
> > Inodes: Total: 157286400  Free: 157286397
> > 2025-03-20 08:33:52 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128
> > stress-ng: info:  [4680] setting to a 1 min run per stressor
> > stress-ng: info:  [4680] dispatching hogs: 128 fpunch
> > stress-ng: info:  [4680] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
> > stress-ng: warn:  [4680] metrics-check: all bogo-op counters are zero, data may be incorrect
> > stress-ng: metrc: [4680] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> > stress-ng: metrc: [4680]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
> > stress-ng: metrc: [4680] fpunch                0    557.92      0.40     19.56         0.00           0.00         0.03          3180
> > stress-ng: metrc: [4680] miscellaneous metrics:
> > stress-ng: metrc: [4680] fpunch              2049.12 extents per file (geometric mean of 128 instances)
> > stress-ng: info:  [4680] for a 620.45s run time:
> > stress-ng: info:  [4680]   79418.05s available CPU time
> > stress-ng: info:  [4680]       0.40s user time   (  0.00%)
> > stress-ng: info:  [4680]      19.59s system time (  0.02%)
> > stress-ng: info:  [4680]      19.99s total time  (  0.03%)
> > stress-ng: info:  [4680] load average: 250.69 349.62 213.80
> > stress-ng: info:  [4680] skipped: 0
> > stress-ng: info:  [4680] passed: 128: fpunch (128)
> > stress-ng: info:  [4680] failed: 0
> > stress-ng: info:  [4680] metrics untrustworthy: 0
> > stress-ng: info:  [4680] successful run completed in 10 mins, 20.45 secs
> > 

[...]

> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250522/202505221030.760980df-lkp@intel.com
> > 
> 
> I tried reproducing this issue but I couldn't recreate it. Is it possible
> for you to run this test on your setup using stress-ng option "--iostat 1"
> as shown below ?
> 
> # stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1
> 
> If you can run test with above option then please collect logs and share it.
> That might help to further debug this.

the log is attached as stress-ng-245618f8e4.
also attached the dmesg-245618f8e4.xz.

another log from parent is attached as stress-ng-3efe7571c3.

> 
> Thanks,
> --Nilay
> 

--nmxAhTm+iS3xjgoO
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="stress-ng-3efe7571c3"

2025-05-28 08:28:57 mkdir -p /mnt/stress-ng
2025-05-28 08:28:57 mount /dev/sdd1 /mnt/stress-ng
2025-05-28 08:28:57 cd /mnt/stress-ng
  File: "/mnt/stress-ng"
    ID: 83100000000 Namelen: 255     Type: xfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 78604800   Free: 78518242   Available: 78518242
Inodes: Total: 157286400  Free: 157286397
2025-05-28 08:28:57 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1
stress-ng: info:  [4693] setting to a 1 min run per stressor
stress-ng: info:  [4693] dispatching hogs: 128 fpunch
stress-ng: info:  [4693] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: info:  [4694] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4694] iostat:       0     9224    31656        0     2291     7218        0
stress-ng: info:  [4694] iostat:       0        0    35688        0        0     7774        0
stress-ng: info:  [4694] iostat:       0        0    33008        0        0     7139        0
stress-ng: info:  [4694] iostat:       0        0    34384        0        0     7532        0
stress-ng: info:  [4694] iostat:       0        0    31388        0        0     6875        0
stress-ng: info:  [4694] iostat:       0        0    35068        0        0     7565        0
stress-ng: info:  [4694] iostat:       0        0    35344        0        0     7611        0
stress-ng: info:  [4694] iostat:       0        0    34588        0        0     7577        0
stress-ng: info:  [4694] iostat:       0        0    33992        0        0     7356        0
stress-ng: info:  [4694] iostat:       0        0    35236        0        0     7671        0
stress-ng: info:  [4694] iostat:       0        0    36612        0        0     7959        0
stress-ng: info:  [4694] iostat:       0        0    31496        0        0     6923        0
stress-ng: info:  [4694] iostat:       0        0    32492        0        0     7083        0
stress-ng: info:  [4694] iostat:       0        0    34208        0        0     7417        0
stress-ng: info:  [4694] iostat:       0        0    35736        0        0     7693        0
stress-ng: info:  [4694] iostat:       0        0    30032        0        0     6639        0
stress-ng: info:  [4694] iostat:       0        0    30728        0        0     6913        0
stress-ng: info:  [4694] iostat:       0        0    31784        0        0     7133        0
stress-ng: info:  [4694] iostat:       0        0    35504        0        0     7782        0
stress-ng: info:  [4694] iostat:       0        0    34576        0        0     7624        0
stress-ng: info:  [4694] iostat:       0        0    31760        0        0     7082        0
stress-ng: info:  [4694] iostat:       0        0    36208        0        0     7837        0
stress-ng: info:  [4694] iostat:       0        0    36324        0        0     7830        0
stress-ng: info:  [4694] iostat:       0       16    33700        0        4     7415        0
stress-ng: info:  [4694] iostat:       0        0    33504        0        0     7270        0
stress-ng: info:  [4694] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4694] iostat:       0        0    30888        0        0     6675        0
stress-ng: info:  [4694] iostat:       0       28    30928        0        7     6721        0
stress-ng: info:  [4694] iostat:       0       32    31392        0        8     6845        0
stress-ng: info:  [4694] iostat:       0       84    26952        0       21     5864        0
stress-ng: info:  [4694] iostat:       0        0    33064        0        0     6379        0
stress-ng: info:  [4694] iostat:       0      100    23328        0       25     5079        0
stress-ng: info:  [4694] iostat:       0      592    13208        0      148     2852        0
stress-ng: info:  [4694] iostat:       0      924    10704        0      231     2301        0
stress-ng: info:  [4694] iostat:       0     1164     7980        0      291     1742        0
stress-ng: info:  [4694] iostat:       0     1272     6024        0      318     1327        0
stress-ng: info:  [4694] iostat:       0     1464     5344        0      366     1222        0
stress-ng: info:  [4694] iostat:       0     1528     4756        0      382     1132        0
stress-ng: info:  [4694] iostat:       0     1248     2964        0      312      689        0
stress-ng: info:  [4694] iostat:       0     1808     3700        0      452      884        0
stress-ng: info:  [4694] iostat:       0     1404     2312        0      351      560        0
stress-ng: info:  [4694] iostat:       0     1636     2280        0      407      558        0
stress-ng: info:  [4694] iostat:       0      948     5788        0      237      404        0
stress-ng: info:  [4694] iostat:       0     1632     3640        0      408      536        0
stress-ng: info:  [4694] iostat:       0     1720     2084        0      428      515        0
stress-ng: info:  [4694] iostat:       0     1952     2464        0      488      614        0
stress-ng: info:  [4694] iostat:       0     1388     1588        0      347      397        0
stress-ng: info:  [4694] iostat:       0     1416     1604        0      354      401        0
stress-ng: info:  [4694] iostat:       0     1264     1408        0      316      351        0
stress-ng: info:  [4694] iostat:       0     1344     1356        0      336      339        0
stress-ng: info:  [4694] iostat:       0     1280     1276        0      320      318        0
stress-ng: info:  [4694] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4694] iostat:       0     1892     1908        0      473      477        0
stress-ng: info:  [4694] iostat:       0     2020     1944        0      505      484        0
stress-ng: info:  [4694] iostat:       0     1644     1580        0      411      395        0
stress-ng: info:  [4694] iostat:       0     1660     1644        0      415      410        0
stress-ng: info:  [4694] iostat:       0     1508     1520        0      377      380        0
stress-ng: info:  [4694] iostat:       0     1276     1304        0      319      326        0
stress-ng: info:  [4694] iostat:       0     1808     1808        0      452      451        0
stress-ng: info:  [4694] iostat:       0     1796     1760        0      449      437        0
stress-ng: info:  [4694] iostat:       0     1360     1364        0      340      340        0
stress-ng: info:  [4694] iostat:       0     1240     3932        0      310      316        0
stress-ng: metrc: [4693] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [4693]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [4693] fpunch             1156     60.17      0.12     34.06        19.21          33.83         0.44          3196
stress-ng: metrc: [4693] miscellaneous metrics:
stress-ng: metrc: [4693] fpunch              2051.98 extents per file (geometric mean of 128 instances)
stress-ng: info:  [4693] for a 60.84s run time:
stress-ng: info:  [4693]    7787.90s available CPU time
stress-ng: info:  [4693]       0.11s user time   (  0.00%)
stress-ng: info:  [4693]      34.08s system time (  0.44%)
stress-ng: info:  [4693]      34.19s total time  (  0.44%)
stress-ng: info:  [4693] load average: 325.30 93.66 32.22
stress-ng: info:  [4693] skipped: 0
stress-ng: info:  [4693] passed: 128: fpunch (128)
stress-ng: info:  [4693] failed: 0
stress-ng: info:  [4693] metrics untrustworthy: 0
stress-ng: info:  [4693] successful run completed in 1 min

--nmxAhTm+iS3xjgoO
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="stress-ng-245618f8e4"

2025-05-28 08:15:55 mkdir -p /mnt/stress-ng
2025-05-28 08:15:55 mount /dev/sdd1 /mnt/stress-ng
2025-05-28 08:15:55 cd /mnt/stress-ng
  File: "/mnt/stress-ng"
    ID: 83100000000 Namelen: 255     Type: xfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 78604800   Free: 78518242   Available: 78518242
Inodes: Total: 157286400  Free: 157286397
2025-05-28 08:15:55 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1
stress-ng: info:  [4680] setting to a 1 min run per stressor
stress-ng: info:  [4680] dispatching hogs: 128 fpunch
stress-ng: info:  [4680] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0     9276    22196        0     2163     4719        0
stress-ng: info:  [4682] iostat:       0       40    18372        0        9     3843        0
stress-ng: info:  [4682] iostat:       0        0    18688        0        0     3896        0
stress-ng: info:  [4682] iostat:       0        0    20924        0        0     4316        0
stress-ng: info:  [4682] iostat:       0        0     2752        0        0      588        0
stress-ng: info:  [4682] iostat:       0        0      296        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      296        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      164        0        0       36        0
stress-ng: info:  [4682] iostat:       0        0     2196        0        0      429        0
stress-ng: info:  [4682] iostat:       0        0    20536        0        0     4113        0
stress-ng: info:  [4682] iostat:       0        0    19496        0        0     4059        0
stress-ng: info:  [4682] iostat:       0        0     1836        0        0      401        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0      180        0        0       40        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0     7628        0        0     1542        0
stress-ng: info:  [4682] iostat:       0        0    10432        0        0     2119        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      264        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      952        0        0      199        0
stress-ng: info:  [4682] iostat:       0        0      760        0        0      169        0
stress-ng: info:  [4682] iostat:       0        0      684        0        0      150        0
stress-ng: info:  [4682] iostat:       0        0      556        0        0      121        0
stress-ng: info:  [4682] iostat:       0        0     3804        0        0      788        0
stress-ng: info:  [4682] iostat:       0        0    12196        0        0     2594        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      596        0        0      130        0
stress-ng: info:  [4682] iostat:       0        0      372        0        0       87        0
stress-ng: info:  [4682] iostat:       0        0     1080        0        0      221        0
stress-ng: info:  [4682] iostat:       0        0      412        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      888        0        0      137        0
stress-ng: info:  [4682] iostat:       0        0      592        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0     3556        0        0      631        0
stress-ng: info:  [4682] iostat:       0        0      212        0        0       48        0
stress-ng: info:  [4682] iostat:       0        0      256        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0      260        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       61        0
stress-ng: info:  [4682] iostat:       0        0     3292        0        0      654        0
stress-ng: info:  [4682] iostat:       0        0    11580        0        0     2268        0
stress-ng: info:  [4682] iostat:       0        0      524        0        0      114        0
stress-ng: info:  [4682] iostat:       0        0      740        0        0      150        0
stress-ng: info:  [4682] iostat:       0        0     1748        0        0      379        0
stress-ng: info:  [4682] iostat:       0        0      696        0        0      144        0
stress-ng: info:  [4682] iostat:       0        0      584        0        0      126        0
stress-ng: info:  [4682] iostat:       0        0      732        0        0      155        0
stress-ng: info:  [4682] iostat:       0        0      468        0        0      103        0
stress-ng: info:  [4682] iostat:       0        0    15108        0        0     3163        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      224        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0      240        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0      228        0        0       46        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      764        0        0      155        0
stress-ng: info:  [4682] iostat:       0        0      228        0        0       47        0
stress-ng: info:  [4682] iostat:       0        0      428        0        0       93        0
stress-ng: info:  [4682] iostat:       0        0      292        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      256        0        0       53        0
stress-ng: info:  [4682] iostat:       0        0     8264        0        0     1656        0
stress-ng: info:  [4682] iostat:       0        0      864        0        0      109        0
stress-ng: info:  [4682] iostat:       0        0      168        0        0       38        0
stress-ng: info:  [4682] iostat:       0        0      412        0        0       86        0
stress-ng: info:  [4682] iostat:       0        0     5484        0        0      944        0
stress-ng: info:  [4682] iostat:       0        0    14428        0        0     2498        0
stress-ng: info:  [4682] iostat:       0        0      688        0        0      122        0
stress-ng: info:  [4682] iostat:       0        0      188        0        0       43        0
stress-ng: info:  [4682] iostat:       0        0      352        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0     4452        0        0      784        0
stress-ng: info:  [4682] iostat:       0        0    14364        0        0     2392        0
stress-ng: info:  [4682] iostat:       0        0      292        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      248        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      404        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0     1204        0        0      265        0
stress-ng: info:  [4682] iostat:       0        0      852        0        0      181        0
stress-ng: info:  [4682] iostat:       0        0      596        0        0      132        0
stress-ng: info:  [4682] iostat:       0        0     1684        0        0      364        0
stress-ng: info:  [4682] iostat:       0        0     7248        0        0     1481        0
stress-ng: info:  [4682] iostat:       0        0      484        0        0      104        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      304        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      596        0        0      132        0
stress-ng: info:  [4682] iostat:       0        0     5504        0        0     1099        0
stress-ng: info:  [4682] iostat:       0        0      684        0        0       75        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0       93        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      988        0        0      171        0
stress-ng: info:  [4682] iostat:       0        0     1440        0        0      181        0
stress-ng: info:  [4682] iostat:       0        0      292        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0    18332        0        0     3465        0
stress-ng: info:  [4682] iostat:       0        0    14380        0        0     2998        0
stress-ng: info:  [4682] iostat:       0        0      652        0        0      148        0
stress-ng: info:  [4682] iostat:       0        0      240        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0     6816        0        0     1163        0
stress-ng: info:  [4682] iostat:       0        0    15716        0        0     2803        0
stress-ng: info:  [4682] iostat:       0        0    14956        0        0     2787        0
stress-ng: info:  [4682] iostat:       0        0      396        0        0       87        0
stress-ng: info:  [4682] iostat:       0        0      288        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      460        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0    11004        0        0     2076        0
stress-ng: info:  [4682] iostat:       0        0    13168        0        0     2765        0
stress-ng: info:  [4682] iostat:       0        0      256        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0      288        0        0       66        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      392        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0     5640        0        0     1164        0
stress-ng: info:  [4682] iostat:       0        0     1968        0        0      408        0
stress-ng: info:  [4682] iostat:       0        0      364        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       56        0
stress-ng: info:  [4682] iostat:       0        0     5540        0        0     1145        0
stress-ng: info:  [4682] iostat:       0        0    14612        0        0     2779        0
stress-ng: info:  [4682] iostat:       0        0      912        0        0       91        0
stress-ng: info:  [4682] iostat:       0        0      380        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      356        0        0       81        0
stress-ng: info:  [4682] iostat:       0        0     8276        0        0     1498        0
stress-ng: info:  [4682] iostat:       0        0     3824        0        0      575        0
stress-ng: info:  [4682] iostat:       0        0      668        0        0       91        0
stress-ng: info:  [4682] iostat:       0        0      640        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0     8180        0        0     1376        0
stress-ng: info:  [4682] iostat:       0        0      564        0        0       96        0
stress-ng: info:  [4682] iostat:       0        0      612        0        0      102        0
stress-ng: info:  [4682] iostat:       0        0     1064        0        0      188        0
stress-ng: info:  [4682] iostat:       0        0    15204        0        0     2861        0
stress-ng: info:  [4682] iostat:       0        0      592        0        0      125        0
stress-ng: info:  [4682] iostat:       0        0      260        0        0       46        0
stress-ng: info:  [4682] iostat:       0        0      436        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0     4804        0        0      950        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      404        0        0       87        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0      788        0        0      118        0
stress-ng: info:  [4682] iostat:       0        0     1148        0        0      205        0
stress-ng: info:  [4682] iostat:       0        0     1392        0        0      161        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0     7828        0        0     1659        0
stress-ng: info:  [4682] iostat:       0        0      408        0        0       90        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0     8712        0        0     1823        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      552        0        0      117        0
stress-ng: info:  [4682] iostat:       0        0     9336        0        0     1980        0
stress-ng: info:  [4682] iostat:       0        0    10048        0        0     2133        0
stress-ng: info:  [4682] iostat:       0        0      284        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      408        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      392        0        0       86        0
stress-ng: info:  [4682] iostat:       0        0    13184        0        0     2759        0
stress-ng: info:  [4682] iostat:       0        0      392        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      292        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      440        0        0       96        0
stress-ng: info:  [4682] iostat:       0        0     3352        0        0      684        0
stress-ng: info:  [4682] iostat:       0        0      416        0        0       89        0
stress-ng: info:  [4682] iostat:       0        0      408        0        0       86        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      396        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0     8368        0        0     1428        0
stress-ng: info:  [4682] iostat:       0        0     6764        0        0     1161        0
stress-ng: info:  [4682] iostat:       0        0      540        0        0      105        0
stress-ng: info:  [4682] iostat:       0        0      360        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0     7964        0        0     1523        0
stress-ng: info:  [4682] iostat:       0        0     1312        0        0      231        0
stress-ng: info:  [4682] iostat:       0        0      752        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0     6312        0        0     1055        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0      104        0
stress-ng: info:  [4682] iostat:       0        0     6364        0        0     1165        0
stress-ng: info:  [4682] iostat:       0        0    11932        0        0     2242        0
stress-ng: info:  [4682] iostat:       0        0      500        0        0      110        0
stress-ng: info:  [4682] iostat:       0        0      548        0        0      114        0
stress-ng: info:  [4682] iostat:       0        0     3584        0        0      618        0
stress-ng: info:  [4682] iostat:       0        0    17372        0        0     3538        0
stress-ng: info:  [4682] iostat:       0        0    16208        0        0     3242        0
stress-ng: info:  [4682] iostat:       0        0      496        0        0      109        0
stress-ng: info:  [4682] iostat:       0        0      316        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0     7720        0        0     1479        0
stress-ng: info:  [4682] iostat:       0        0     2976        0        0      480        0
stress-ng: info:  [4682] iostat:       0        0      248        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0     4396        0        0      818        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      592        0        0      130        0
stress-ng: info:  [4682] iostat:       0        0      672        0        0      142        0
stress-ng: info:  [4682] iostat:       0        0     3360        0        0      721        0
stress-ng: info:  [4682] iostat:       0        0     4376        0        0      894        0
stress-ng: info:  [4682] iostat:       0        0      688        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0      828        0        0      115        0
stress-ng: info:  [4682] iostat:       0        0      536        0        0       92        0
stress-ng: info:  [4682] iostat:       0        0     4624        0        0      874        0
stress-ng: info:  [4682] iostat:       0        0     2328        0        0      345        0
stress-ng: info:  [4682] iostat:       0        0      560        0        0      109        0
stress-ng: info:  [4682] iostat:       0        0      184        0        0       39        0
stress-ng: info:  [4682] iostat:       0        0      376        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      760        0        0      158        0
stress-ng: info:  [4682] iostat:       0        0      400        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      612        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0     1268        0        0      165        0
stress-ng: info:  [4682] iostat:       0        0     7372        0        0     1392        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      316        0        0       73        0
stress-ng: info:  [4682] iostat:       0        0      304        0        0       60        0
stress-ng: info:  [4682] iostat:       0        0      440        0        0       94        0
stress-ng: info:  [4682] iostat:       0        0     9220        0        0     1776        0
stress-ng: info:  [4682] iostat:       0        0      688        0        0      156        0
stress-ng: info:  [4682] iostat:       0        0      596        0        0      134        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0    10144        0        0     2156        0
stress-ng: info:  [4682] iostat:       0        0      608        0        0      127        0
stress-ng: info:  [4682] iostat:       0        0      400        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0      680        0        0      137        0
stress-ng: info:  [4682] iostat:       0        4    14916        0        1     3065        0
stress-ng: info:  [4682] iostat:       0        0      556        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      448        0        0       45        0
stress-ng: info:  [4682] iostat:       0        0      596        0        0       74        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       49        0
stress-ng: info:  [4682] iostat:       0        0     1396        0        0      251        0
stress-ng: info:  [4682] iostat:       0        0    11976        0        0     2310        0
stress-ng: info:  [4682] iostat:       0        0     9668        0        0     1636        0
stress-ng: info:  [4682] iostat:       0        0      296        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      232        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      260        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      460        0        0      105        0
stress-ng: info:  [4682] iostat:       0        0      160        0        0       40        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       81        0
stress-ng: info:  [4682] iostat:       0        0     3628        0        0      627        0
stress-ng: info:  [4682] iostat:       0        0     3808        0        0      762        0
stress-ng: info:  [4682] iostat:       0        0      540        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0      516        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0      228        0        0       53        0
stress-ng: info:  [4682] iostat:       0        0      680        0        0      107        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      528        0        0      102        0
stress-ng: info:  [4682] iostat:       0        0      664        0        0      140        0
stress-ng: info:  [4682] iostat:       0        0      212        0        0       49        0
stress-ng: info:  [4682] iostat:       0        0      572        0        0      133        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      248        0        0       54        0
stress-ng: info:  [4682] iostat:       0        0      452        0        0      100        0
stress-ng: info:  [4682] iostat:       0        0     6028        0        0     1171        0
stress-ng: info:  [4682] iostat:       0        0      452        0        0       96        0
stress-ng: info:  [4682] iostat:       0        0      200        0        0       44        0
stress-ng: info:  [4682] iostat:       0        0      304        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      376        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0      580        0        0      113        0
stress-ng: info:  [4682] iostat:       0        0      520        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0      520        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      396        0        0       37        0
stress-ng: info:  [4682] iostat:       0        0      520        0        0      113        0
stress-ng: info:  [4682] iostat:       0        0      304        0        0       75        0
stress-ng: info:  [4682] iostat:       0        0      520        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0      256        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0     9284        0        0     1906        0
stress-ng: info:  [4682] iostat:       0        0     3176        0        0      633        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       69        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       70        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      416        0        0       92        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       70        0
stress-ng: info:  [4682] iostat:       0        0      612        0        0      141        0
stress-ng: info:  [4682] iostat:       0        4    11588        0        1     2451        0
stress-ng: info:  [4682] iostat:       0        0      548        0        0      119        0
stress-ng: info:  [4682] iostat:       0        0      648        0        0      131        0
stress-ng: info:  [4682] iostat:       0        0      488        0        0      104        0
stress-ng: info:  [4682] iostat:       0        0    11372        0        0     2354        0
stress-ng: info:  [4682] iostat:       0        0      436        0        0       96        0
stress-ng: info:  [4682] iostat:       0        0      360        0        0       72        0
stress-ng: info:  [4682] iostat:       0        0      340        0        0       70        0
stress-ng: info:  [4682] iostat:       0        0     3084        0        0      644        0
stress-ng: info:  [4682] iostat:       0        0     1408        0        0      294        0
stress-ng: info:  [4682] iostat:       0        0      528        0        0      109        0
stress-ng: info:  [4682] iostat:       0        0      320        0        0       72        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      436        0        0       91        0
stress-ng: info:  [4682] iostat:       0        0     7688        0        0     1388        0
stress-ng: info:  [4682] iostat:       0        0      416        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0      268        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0      276        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       70        0
stress-ng: info:  [4682] iostat:       0        0      204        0        0       47        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      232        0        0       54        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0     2328        0        0      558        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0      552        0        0      134        0
stress-ng: info:  [4682] iostat:       0        0      216        0        0       54        0
stress-ng: info:  [4682] iostat:       0        0     4192        0        0      970        0
stress-ng: info:  [4682] iostat:       0        0     1480        0        0      340        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       56        0
stress-ng: info:  [4682] iostat:       0        0      428        0        0      105        0
stress-ng: info:  [4682] iostat:       0        0     1076        0        0      248        0
stress-ng: info:  [4682] iostat:       0        0      428        0        0      102        0
stress-ng: info:  [4682] iostat:       0        0      232        0        0       54        0
stress-ng: info:  [4682] iostat:       0        0      284        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0     2780        0        0      651        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      184        0        0       44        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       54        0
stress-ng: info:  [4682] iostat:       0        0      420        0        0       94        0
stress-ng: info:  [4682] iostat:       0        0      396        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0      468        0        0      111        0
stress-ng: info:  [4682] iostat:       0        0      376        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0     2792        0        0      593        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0     3192        0        0      480        0
stress-ng: info:  [4682] iostat:       0        0     2716        0        0      566        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      288        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      388        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      324        0        0       70        0
stress-ng: info:  [4682] iostat:       0        0     6536        0        0     1335        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       51        0
stress-ng: info:  [4682] iostat:       0        0      304        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0      456        0        0      110        0
stress-ng: info:  [4682] iostat:       0        0      544        0        0       71        0
stress-ng: info:  [4682] iostat:       0        0      228        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0      604        0        0      148        0
stress-ng: info:  [4682] iostat:       0        0      572        0        0      116        0
stress-ng: info:  [4682] iostat:       0        0      584        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0     1136        0        0      176        0
stress-ng: info:  [4682] iostat:       0        0      448        0        0       95        0
stress-ng: info:  [4682] iostat:       0        0      716        0        0      106        0
stress-ng: info:  [4682] iostat:       0        0      764        0        0      113        0
stress-ng: info:  [4682] iostat:       0        0      964        0        0      180        0
stress-ng: info:  [4682] iostat:       0        0      580        0        0      138        0
stress-ng: info:  [4682] iostat:       0        0      364        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0      412        0        0      100        0
stress-ng: info:  [4682] iostat:       0        0      100        0        0       25        0
stress-ng: info:  [4682] iostat:       0        0      852        0        0      206        0
stress-ng: info:  [4682] iostat:       0        0      752        0        0      184        0
stress-ng: info:  [4682] iostat:       0        0      804        0        0      197        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      328        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0     1276        0        0      184        0
stress-ng: info:  [4682] iostat:       0        0      564        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      916        0        0      200        0
stress-ng: info:  [4682] iostat:       0        0      208        0        0       44        0
stress-ng: info:  [4682] iostat:       0        0     1296        0        0      171        0
stress-ng: info:  [4682] iostat:       0        0      444        0        0      103        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0      111        0
stress-ng: info:  [4682] iostat:       0        0      156        0        0       38        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       69        0
stress-ng: info:  [4682] iostat:       0        0      648        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0     4848        0        0     1000        0
stress-ng: info:  [4682] iostat:       0        0      324        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      260        0        0       48        0
stress-ng: info:  [4682] iostat:       0        0      536        0        0      105        0
stress-ng: info:  [4682] iostat:       0        0      656        0        0      143        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0       96        0
stress-ng: info:  [4682] iostat:       0        0      744        0        0      153        0
stress-ng: info:  [4682] iostat:       0        0     3708        0        0      740        0
stress-ng: info:  [4682] iostat:       0        0     4940        0        0      988        0
stress-ng: info:  [4682] iostat:       0        0      512        0        0      118        0
stress-ng: info:  [4682] iostat:       0        0      700        0        0      132        0
stress-ng: info:  [4682] iostat:       0        0      680        0        0      144        0
stress-ng: info:  [4682] iostat:       0        0      364        0        0       77        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      316        0        0       72        0
stress-ng: info:  [4682] iostat:       0        0      384        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0     1644        0        0      329        0
stress-ng: info:  [4682] iostat:       0        0    13644        0        0     2826        0
stress-ng: info:  [4682] iostat:       0        0      704        0        0      148        0
stress-ng: info:  [4682] iostat:       0        0      852        0        0      177        0
stress-ng: info:  [4682] iostat:       0        0      824        0        0      169        0
stress-ng: info:  [4682] iostat:       0        0      736        0        0      162        0
stress-ng: info:  [4682] iostat:       0        0      744        0        0      153        0
stress-ng: info:  [4682] iostat:       0        0     1008        0        0      104        0
stress-ng: info:  [4682] iostat:       0        0      792        0        0      115        0
stress-ng: info:  [4682] iostat:       0        0      796        0        0      119        0
stress-ng: info:  [4682] iostat:       0        0      416        0        0       93        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0     1536        0        0      336        0
stress-ng: info:  [4682] iostat:       0        0     2132        0        0      489        0
stress-ng: info:  [4682] iostat:       0        0      220        0        0       40        0
stress-ng: info:  [4682] iostat:       0        0      396        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0      432        0        0       43        0
stress-ng: info:  [4682] iostat:       0        0      400        0        0       90        0
stress-ng: info:  [4682] iostat:       0        0      212        0        0       49        0
stress-ng: info:  [4682] iostat:       0        0      904        0        0      169        0
stress-ng: info:  [4682] iostat:       0        0     3364        0        0      785        0
stress-ng: info:  [4682] iostat:       0        0      284        0        0       66        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      168        0        0       37        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0     1084        0        0      239        0
stress-ng: info:  [4682] iostat:       0        0      540        0        0      121        0
stress-ng: info:  [4682] iostat:       0        0      216        0        0       51        0
stress-ng: info:  [4682] iostat:       0        0      268        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      140        0        0       31        0
stress-ng: info:  [4682] iostat:       0        0     1000        0        0      217        0
stress-ng: info:  [4682] iostat:       0        0     3872        0        0      797        0
stress-ng: info:  [4682] iostat:       0        0     8128        0        0     1610        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       73        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       56        0
stress-ng: info:  [4682] iostat:       0        0      380        0        0       90        0
stress-ng: info:  [4682] iostat:       0        0     1508        0        0      353        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      408        0        0       95        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      352        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      352        0        0       81        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      324        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0      352        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      176        0        0       40        0
stress-ng: info:  [4682] iostat:       0        0      144        0        0       32        0
stress-ng: info:  [4682] iostat:       0        0      192        0        0       48        0
stress-ng: info:  [4682] iostat:       0        0      208        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      620        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      248        0        0       62        0
stress-ng: info:  [4682] iostat:       0        0      532        0        0       69        0
stress-ng: info:  [4682] iostat:       0        0      368        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      692        0        0       91        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       61        0
stress-ng: info:  [4682] iostat:       0        0      400        0        0       86        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       75        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      300        0        0       74        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0      352        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      320        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      312        0        0       78        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      312        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      344        0        0       80        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0      316        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0      320        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      316        0        0       76        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       81        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       78        0
stress-ng: info:  [4682] iostat:       0        0      200        0        0       43        0
stress-ng: info:  [4682] iostat:       0        0      140        0        0       34        0
stress-ng: info:  [4682] iostat:       0        0      248        0        0       60        0
stress-ng: info:  [4682] iostat:       0        0      136        0        0       34        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       70        0
stress-ng: info:  [4682] iostat:       0        0      324        0        0       72        0
stress-ng: info:  [4682] iostat:       0        0      192        0        0       48        0
stress-ng: info:  [4682] iostat:       0        0      140        0        0       33        0
stress-ng: info:  [4682] iostat:       0        0      268        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0      396        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      452        0        0       90        0
stress-ng: info:  [4682] iostat:       0        0      316        0        0       71        0
stress-ng: info:  [4682] iostat:       0        0      592        0        0       81        0
stress-ng: info:  [4682] iostat:       0        0      348        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0      340        0        0       80        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      128        0        0       32        0
stress-ng: info:  [4682] iostat:       0        0      188        0        0       43        0
stress-ng: info:  [4682] iostat:       0        0      428        0        0       39        0
stress-ng: info:  [4682] iostat:       0        0      376        0        0       30        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      284        0        0       51        0
stress-ng: info:  [4682] iostat:       0        0      392        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0      304        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      624        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0      452        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      424        0        0       36        0
stress-ng: info:  [4682] iostat:       0        0      184        0        0       37        0
stress-ng: info:  [4682] iostat:       0        0     2692        0        0      517        0
stress-ng: info:  [4682] iostat:       0        0      672        0        0       87        0
stress-ng: info:  [4682] iostat:       0        0      868        0        0       81        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       69        0
stress-ng: info:  [4682] iostat:       0        0      680        0        0      149        0
stress-ng: info:  [4682] iostat:       0        0      496        0        0      112        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0     2528        0        0      599        0
stress-ng: info:  [4682] iostat:       0        0     1348        0        0      332        0
stress-ng: info:  [4682] iostat:       0        0      200        0        0       49        0
stress-ng: info:  [4682] iostat:       0        0      180        0        0       41        0
stress-ng: info:  [4682] iostat:       0        0      124        0        0       30        0
stress-ng: info:  [4682] iostat:       0        0      168        0        0       42        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      180        0        0       43        0
stress-ng: info:  [4682] iostat:       0        0     3808        0        0      886        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       60        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       63        0
stress-ng: info:  [4682] iostat:       0        0      552        0        0      135        0
stress-ng: info:  [4682] iostat:       0        0      360        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      736        0        0      167        0
stress-ng: info:  [4682] iostat:       0        0      868        0        0      184        0
stress-ng: info:  [4682] iostat:       0        0      848        0        0      179        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       57        0
stress-ng: info:  [4682] iostat:       0        0      196        0        0       44        0
stress-ng: info:  [4682] iostat:       0        0      200        0        0       42        0
stress-ng: info:  [4682] iostat:       0        0     1276        0        0      273        0
stress-ng: info:  [4682] iostat:       0        0      436        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      544        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      648        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      600        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0     4492        0        0      937        0
stress-ng: info:  [4682] iostat:       0        0     4088        0        0      870        0
stress-ng: info:  [4682] iostat:       0        0      708        0        0       89        0
stress-ng: info:  [4682] iostat:       0        0      600        0        0       82        0
stress-ng: info:  [4682] iostat:       0        0     4268        0        0      818        0
stress-ng: info:  [4682] iostat:       0        0     4396        0        0      927        0
stress-ng: info:  [4682] iostat:       0        0      812        0        0      174        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      644        0        0      143        0
stress-ng: info:  [4682] iostat:       0        0     2772        0        0      573        0
stress-ng: info:  [4682] iostat:       0        0     4872        0        0     1020        0
stress-ng: info:  [4682] iostat:       0        0      832        0        0      176        0
stress-ng: info:  [4682] iostat:       0        0      512        0        0      118        0
stress-ng: info:  [4682] iostat:       0        0      492        0        0      115        0
stress-ng: info:  [4682] iostat:       0        0     7256        0        0     1453        0
stress-ng: info:  [4682] iostat:       0        0     1404        0        0      207        0
stress-ng: info:  [4682] iostat:       0        0     1408        0        0      200        0
stress-ng: info:  [4682] iostat:       0        0     1056        0        0      201        0
stress-ng: info:  [4682] iostat:       0        0     5932        0        0     1023        0
stress-ng: info:  [4682] iostat:       0        0      732        0        0      172        0
stress-ng: info:  [4682] iostat:       0        0      884        0        0      145        0
stress-ng: info:  [4682] iostat:       0        0      552        0        0      114        0
stress-ng: info:  [4682] iostat:       0        0     2268        0        0      456        0
stress-ng: info:  [4682] iostat:       0        0      168        0        0       42        0
stress-ng: info:  [4682] iostat:       0        0      360        0        0       85        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      508        0        0       46        0
stress-ng: info:  [4682] iostat:       0        0     4960        0        0      870        0
stress-ng: info:  [4682] iostat:       0        0      340        0        0       83        0
stress-ng: info:  [4682] iostat:       0        0      216        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      328        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0     6420        0        0     1210        0
stress-ng: info:  [4682] iostat:       0        0      560        0        0       75        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      164        0        0       37        0
stress-ng: info:  [4682] iostat:       0        0      308        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      564        0        0      123        0
stress-ng: info:  [4682] iostat:       0        0      748        0        0      159        0
stress-ng: info:  [4682] iostat:       0        0      216        0        0       46        0
stress-ng: info:  [4682] iostat:       0        0     1056        0        0      120        0
stress-ng: info:  [4682] iostat:       0        0      332        0        0       49        0
stress-ng: info:  [4682] iostat:       0        0     2380        0        0      557        0
stress-ng: info:  [4682] iostat:       0        0      292        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      156        0        0       31        0
stress-ng: info:  [4682] iostat:       0        0      400        0        0       93        0
stress-ng: info:  [4682] iostat:       0        0      456        0        0      101        0
stress-ng: info:  [4682] iostat:       0        0     5448        0        0     1225        0
stress-ng: info:  [4682] iostat:       0        0     3408        0        0      708        0
stress-ng: info:  [4682] iostat:       0        0      184        0        0       44        0
stress-ng: info:  [4682] iostat:       0        0      472        0        0       39        0
stress-ng: info:  [4682] iostat:       0        0      680        0        0       88        0
stress-ng: info:  [4682] iostat:       0        0      436        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0     4468        0        0     1032        0
stress-ng: info:  [4682] iostat:       0        0      120        0        0       29        0
stress-ng: info:  [4682] iostat:       0        0      272        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0     3548        0        0      841        0
stress-ng: info:  [4682] iostat:       0        0      220        0        0       55        0
stress-ng: info:  [4682] iostat:       0        0      232        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0      264        0        0       59        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      208        0        0       48        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       68        0
stress-ng: info:  [4682] iostat:       0        0      100        0        0       25        0
stress-ng: info:  [4682] iostat:       0        0      212        0        0       47        0
stress-ng: info:  [4682] iostat:       0        0      800        0        0      128        0
stress-ng: info:  [4682] iostat:       0        0      244        0        0       52        0
stress-ng: info:  [4682] iostat:       0        0      644        0        0      135        0
stress-ng: info:  [4682] iostat:       0        0      428        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0     1192        0        0      128        0
stress-ng: info:  [4682] iostat:       0        0      276        0        0       51        0
stress-ng: info:  [4682] iostat:       0        0     2104        0        0      276        0
stress-ng: info:  [4682] iostat:       0        0      320        0        0       32        0
stress-ng: info:  [4682] iostat:       0        0      420        0        0       45        0
stress-ng: info:  [4682] iostat:       0        0     3532        0        0      184        0
stress-ng: info:  [4682] iostat:       0        0      208        0        0       46        0
stress-ng: info:  [4682] iostat:       0        0     2076        0        0      381        0
stress-ng: info:  [4682] iostat:       0        0      372        0        0       34        0
stress-ng: info:  [4682] iostat:       0        0      124        0        0       30        0
stress-ng: info:  [4682] iostat:       0        0      356        0        0       79        0
stress-ng: info:  [4682] iostat:       0        0      264        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      884        0        0       84        0
stress-ng: info:  [4682] iostat:       0        0      468        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0     1020        0        0      179        0
stress-ng: info:  [4682] iostat:       0        0     5312        0        0      939        0
stress-ng: info:  [4682] iostat:       0        0      228        0        0       51        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0      244        0        0       58        0
stress-ng: info:  [4682] iostat:       0        0      496        0        0       61        0
stress-ng: info:  [4682] iostat:       0        0      556        0        0       67        0
stress-ng: info:  [4682] iostat:       0        0     5764        0        0     1125        0
stress-ng: info:  [4682] iostat:       0        0      276        0        0       64        0
stress-ng: info:  [4682] iostat:       0        0      628        0        0       98        0
stress-ng: info:  [4682] iostat:       0        0      236        0        0       51        0
stress-ng: info:  [4682] iostat:       0        0      424        0        0       73        0
stress-ng: info:  [4682] iostat:       0        0     1196        0        0      169        0
stress-ng: info:  [4682] iostat:       0        0      520        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      264        0        0       56        0
stress-ng: info:  [4682] iostat:       0        0      208        0        0       47        0
stress-ng: info:  [4682] iostat:       0        0      752        0        0      164        0
stress-ng: info:  [4682] iostat:       0        0      340        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      840        0        0      139        0
stress-ng: info:  [4682] iostat:       0        0      336        0        0       65        0
stress-ng: info:  [4682] iostat:       0        0      536        0        0       66        0
stress-ng: info:  [4682] iostat:       0        0      628        0        0      145        0
stress-ng: info:  [4682] iostat:       0        0      900        0        0      131        0
stress-ng: info:  [4682] iostat:       0        0      552        0        0      102        0
stress-ng: info:  [4682] iostat:       0        0      528        0        0       61        0
stress-ng: info:  [4682] iostat:       0        0      280        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0     2004        0        0      366        0
stress-ng: info:  [4682] iostat:       0        0      600        0        0      124        0
stress-ng: info:  [4682] iostat:       0        0      812        0        0       98        0
stress-ng: info:  [4682] iostat: Inflght   Rd K/s   Wr K/s Dscd K/s     Rd/s     Wr/s   Dscd/s
stress-ng: info:  [4682] iostat:       0        0     1268        0        0      168        0
stress-ng: info:  [4682] iostat:       0        0      184        0        0       45        0
stress-ng: info:  [4682] iostat:       0        0      964        0        0      118        0
stress-ng: info:  [4682] iostat:       0        0     1308        0        0      244        0
stress-ng: info:  [4682] iostat:       0        0      192        0        0       45        0
stress-ng: info:  [4682] iostat:       0        0     1664        0        0      222        0
stress-ng: info:  [4682] iostat:       0        0      672        0        0       59        0
stress-ng: info:  [4682] iostat:       0        0      460        0        0       77        0
stress-ng: info:  [4682] iostat:       0        0      496        0        0       54        0
stress-ng: info:  [4682] iostat:       0        0     1696        0        0      262        0
stress-ng: info:  [4682] iostat:       0        0     1436        0        0      214        0
stress-ng: info:  [4682] iostat:       0        0      476        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0      740        0        0      116        0
stress-ng: info:  [4682] iostat:       0        0     2900        0        0      185        0
stress-ng: info:  [4682] iostat:       0        0     1028        0        0      225        0
stress-ng: info:  [4682] iostat:       0        0     1144        0        0      157        0
stress-ng: info:  [4682] iostat:       0        0      200        0        0       50        0
stress-ng: info:  [4682] iostat:       0        0     1600        0        0      246        0
stress-ng: warn:  [4680] metrics-check: all bogo-op counters are zero, data may be incorrect
stress-ng: metrc: [4680] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [4680]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [4680] fpunch                0    558.55      0.36     18.96         0.00           0.00         0.03          3192
stress-ng: metrc: [4680] miscellaneous metrics:
stress-ng: metrc: [4680] fpunch              2049.04 extents per file (geometric mean of 128 instances)
stress-ng: info:  [4680] for a 618.87s run time:
stress-ng: info:  [4680]   79215.33s available CPU time
stress-ng: info:  [4680]       0.36s user time   (  0.00%)
stress-ng: info:  [4680]      18.99s system time (  0.02%)
stress-ng: info:  [4680]      19.35s total time  (  0.02%)
stress-ng: info:  [4680] load average: 297.48 362.87 215.33
stress-ng: info:  [4680] skipped: 0
stress-ng: info:  [4680] passed: 128: fpunch (128)
stress-ng: info:  [4680] failed: 0
stress-ng: info:  [4680] metrics untrustworthy: 0
stress-ng: info:  [4680] successful run completed in 10 mins, 18.87 secs

--nmxAhTm+iS3xjgoO
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-245618f8e4.xz"
Content-Transfer-Encoding: base64

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
EeYrxbyxxGf7AgAAAAAEWVo=

--nmxAhTm+iS3xjgoO--

