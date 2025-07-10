Return-Path: <cgroups+bounces-8702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD735AFFC90
	for <lists+cgroups@lfdr.de>; Thu, 10 Jul 2025 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AB640FE9
	for <lists+cgroups@lfdr.de>; Thu, 10 Jul 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAD28BA86;
	Thu, 10 Jul 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIMnjzTv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD826B2D5;
	Thu, 10 Jul 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136850; cv=fail; b=aOvjfvXcL+Xs7FD+dbDDgz3X2XHUJXELPcRVLRAsKnSV+o0LsaxhQWA4Sy3hr7gF8rgjgJzaCDniHBQzAgiHNNxvj4Z2nMjtLL2SAZ40V3SqK439haa+iefbdYdEJoOQYxWP2oD1ujlNt8kjj9hIo9sVvSyRZ4cUamJrC03uYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136850; c=relaxed/simple;
	bh=tMPoC5tbcOMeRbC7FSOpKULnLbSDDb3DemMNBL+tBgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zd+TPEjQTZrnP54Cj1Rbh0SLPydqyFZ3VP0XSHhIHjOrLMXZbcBmXVQIcvx2c/IhgtAFH8/zlPY9TV8VITU11dRVHWUk1/jGIsyUmrxyDbn741Oz8M5Eg3YPVXmCsXQKrIqFX7d3OkqoTOzCC8NW8U+LmXbh6VXwIo98yQG+UFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIMnjzTv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752136848; x=1783672848;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tMPoC5tbcOMeRbC7FSOpKULnLbSDDb3DemMNBL+tBgI=;
  b=ZIMnjzTv/VRYZ25kRHPno4eDOw+J7kmKq/amWOeIeRy9cBdQRadWcNnE
   deXPDhIfdzY1aRdNjHvuFDKqg5eFebOraVLM3m+TzpF01XjGlNroaNzUp
   qM1N9RXpaMDrl6eWELQ0bOdHW0czDxLtDv7uRUoEXRroY1g+vjM5wzoWO
   11a6uJlO7WED9AlG6d6fWD/Xnrh9th5yQWIKAaGp0Hs9hehwkFs1vg9Mc
   gSv7w1uwQpsO23c5HGAnV2VHOG0NXbMqNioM/rRHlkRkOPJ6zzAF6dooF
   9q+AwGUthQaL1+4H/6maMXGJ1K4adyY85T6YnP+uwdb8+egaXAhSKmA/V
   A==;
X-CSE-ConnectionGUID: SzA3aV6vTiGKV4kMDCdLLA==
X-CSE-MsgGUID: mBI9BE1vQU+fZen2lBbSYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54504496"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54504496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:40:47 -0700
X-CSE-ConnectionGUID: NqNNkfPUTLad7FHAjQmYxw==
X-CSE-MsgGUID: /OE+FkEXQoaq2zDwXvNQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160342298"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:40:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:40:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:40:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcCmc4lwI7Sl7vR26U8iVznVVnS3dHlN1GULp2EjN+Djp/W95+NetqauW9LN5HeSPqsNT1OLMD7MqU849HJN6O0Ya6hA23cQlvLwiqWjyJwZr6qzPAEREY2tpFWDcRLhAvTiMJcamuxh0S1PzetbCMBXOJBksgK/f08otFZU3fcxFlifLVgvKxczE5HV2tJTsZMIKJbwOVrm1ERkYAoa8nXlwZVIchsfUVUOYgcn54IArs32VvvcO/jmSPR/oIyELdd0hQtxG1KzQRt8jthTOoOx2eIMGgRuziRHeVKZmepMFr06mMqK2p8HAZeaNtiPDJ8iVLytJkA9M3vRl2ZkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLlRJCXVukIh/RiPZN7+5ImZg4U01ktvPs2clBpS7G8=;
 b=e6psMp2fZG+7GoFsrZYAIFRj4AZZfLqgXSCsZ19ruaX7KIwz/nJinYeeUB0Jq5qn9gWFc6vasA++rnVYK1yYvsyp/kgmjRBMsMncJzES9OxQMo+6eD9jyzm3glBRzei8Ka63bfXpyDkSEz8naWPKTCGLNVmN/6tWNCze0LD7KfIKvNZs/i/cCiFrbERNEc+L8Mg5SvfkYOOllMszBCYY2/c/u3FD5eUYSig0LhjoL4RO0ZP46ckTg+kR4570fwJvEEBWrmpWhAO0NlZqowQkahcxKgQYUtMZxlfhGY6yNkO9Mizu72sRnYc7HTA319htzQtCdY7C/OUzYPnhlPNl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 08:40:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 08:40:40 +0000
Date: Thu, 10 Jul 2025 16:40:30 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.de>, Ming Lei <ming.lei@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block] 245618f8e4: stress-ng.fpunch.fail
Message-ID: <aG98fj7phkM1PojW@xsang-OptiPlex-9020>
References: <202505221030.760980df-lkp@intel.com>
 <95753732-9714-42e0-8097-e2b4c3dd5820@linux.ibm.com>
 <aDe9y3Ef+TEacRr3@xsang-OptiPlex-9020>
 <f33af0f8-6d7b-479c-9d57-e5fd485d0f6e@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f33af0f8-6d7b-479c-9d57-e5fd485d0f6e@linux.ibm.com>
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 18891072-2d99-42e0-7956-08ddbf8d7375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4++X/dpzpceEFSoXwkXUI7F9RV3B427hZt4GyKxGVgYkFCnBsH8J5iHRwFaL?=
 =?us-ascii?Q?yEQPdy1GpTN2TmoDclvsJdmW9yljCbQA3NjKIqxTA5DfEAGn5MqV8hpDp0hg?=
 =?us-ascii?Q?m+7r07iFeSq08Kv1ZImf8eERQz2a8JzeFKkNBEzYTnvwaeA9l5IZ9okAaKmZ?=
 =?us-ascii?Q?ZLT0/ea/AErf1ty6QUm+Fa2DNyBn0J4Z2Vy/CJ1YBh/zlNKRISDTw5mI1YLN?=
 =?us-ascii?Q?dn7PaFkmfthMR5CjlTIYIgTXb7ePXpI4BIumpXPAxjskVGWbcELXk53H6Kfg?=
 =?us-ascii?Q?xMaZxkjVml/o8b/Ic3kohTircaXgpuW1me8sOcPjYODQm5KBO4Z1+XT1hISq?=
 =?us-ascii?Q?RLuowVjFb6xOVStk9opocnoZON/OGabKfdLAMceQKtlm4hs+Q7MrgCzS46Fo?=
 =?us-ascii?Q?OPtMrU0qJtPqgnEhAgF8mKejKa7MZSoEfEwJOii8cYf9Cp+ZyPkNjrfob28O?=
 =?us-ascii?Q?WoG5zzCDnfmOyW669Ees/Jp23goxr7d5OI2ujWqLQxrXA4eqZnzlrEYvHDT1?=
 =?us-ascii?Q?jlpbdkHaWyojDck/y1zLeINT39aei1StS+W9VC/UzbVL2GTP7mqxVD46ON1V?=
 =?us-ascii?Q?HRmfta4pXTg09j2t/mIk4fezgE246+sRCL6gonWYRcD6vOaGk2QpGk05cUwQ?=
 =?us-ascii?Q?BjadAR4IutiHIe3MO/MLEejAt6m6Go5vRPngN9i+9H2c9hWg5xs5vKR/RkkN?=
 =?us-ascii?Q?6IEz2gF9/c32YJvRUC4z5rvkOqYD9l2sG7dqZoAqFd4prakEZm6xIZmMq13y?=
 =?us-ascii?Q?+B2X/LOc4PBL60HSt0uTor3nYQQkAwxusRR1TiCj3UnsEBJQKNcjjpEpEp06?=
 =?us-ascii?Q?KyXjefm5tMyAPs0m7L5zQMiEzGZv9sd1LQ2f6D0wUPfJavsU4hhGZLgwTLxs?=
 =?us-ascii?Q?uy9/A8aSR01w7ivj9OBPSMUKmiGaCdp7ELOj5DnFx1nDdXByygw866t0WXBq?=
 =?us-ascii?Q?tyi84zDwTQC57p+yIs3Rv3xbeNWBFAQjR9qmvXxC0+xRFs6sixPnZpAEQqyM?=
 =?us-ascii?Q?5vYkCIE6wZM/XpntJJedpUK08wn+iR/vjvvmIZPlUHt3HbeP/6QGgifffHuz?=
 =?us-ascii?Q?73ZtSeGEJrOJmltsRCO6rV+2jGWMcljDgY2GAoBw4a8I9GnksYJVoXkODx84?=
 =?us-ascii?Q?iUWayEDpEG4BoQa0+WD/0P0S9DgOUgZ/c7E94Iia3fb4TMxcEiL49TKoW2JI?=
 =?us-ascii?Q?20c312X00iyEvHJnpowsr5xQ290Td3Qi2zadXrxeRL47DI5FvOuC/z5J/W/M?=
 =?us-ascii?Q?JmdBckrWQjqEPlhrrHnrS6rXyDo1BbRYnf9UpfFnoP/+j/zfgQH9pfcGqH4M?=
 =?us-ascii?Q?vw9ZBy6XlXK8HIUIFMncOPkZ0uvQfElkam71g+b56zT6NM4mcCNqA0sB8dbN?=
 =?us-ascii?Q?iFU4JM0IHyjztodtgGIwYT7vHXI2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hlvZBWiW0Jjy7mgTzJnSgbvOF5rdM3DGHIlp3KuwurG81+GkqwJYcDmz6Nm?=
 =?us-ascii?Q?S6tnAGlBC3MmpfYTzJ22v3YtHjBH7M6XV15rs2oM97rvKOTnF7OUgQ3vf8w4?=
 =?us-ascii?Q?MocTxp0zkeQIeupM2qgdL4q1YhEd8eQNOVzNpq+PrJQPqFU+x8R2jZOH49wy?=
 =?us-ascii?Q?qQ8KAveAlafldS25bbwksqgq4++K3L2q+yKafGRCAXxrKr3ceo7XDQRQDsBA?=
 =?us-ascii?Q?Vdt959h1poQco4rVoYHKaqWPbP2kE0okFki5Uu3a2N0EeLE+5syLVmkl1eFv?=
 =?us-ascii?Q?LkiU18ksIHWl6DAGvUGnpaNjBRiXqjgAIpb8niUOvOE7f7LnRvdxINxtcN0J?=
 =?us-ascii?Q?AFqToCkCmyLVZPmFct0kj2F+ssOMOQYKgPlYASRDh+f4vQZrFBs1YyzNdJHS?=
 =?us-ascii?Q?aNacmWD0o0n0Ehvla6iNqTGwvazsgkhIhO3oVKrrPR/ZL32mSowx7XlXblWP?=
 =?us-ascii?Q?21vwdIPmj+rCUxPr+FoIdCG6XKF3wMZ6lK9JuNZKHrVUdiL6ZRPnCeus2/ZF?=
 =?us-ascii?Q?khgq44OSqYt2oWA6YcAjHBkdwGkuBndweFMhU03c5ruDmqYGi9R1J6QQzbMz?=
 =?us-ascii?Q?93UgxCzblmIKO0D7gwktKtN21tQsUphsi9nsX4pfqCJiPsEj3jNs2twVuaex?=
 =?us-ascii?Q?TF0w4UcBvzJ6G24cMwb/xq1XEImW4x6dYcxqR23oHBbuq4AiZ+38jfY7GYfN?=
 =?us-ascii?Q?IOdW4x4FHA5Y2B8Qjj+l5h5bAZTpljmNspjmjgNzWL1jifLPcrexF0d4XgXh?=
 =?us-ascii?Q?ftve/s5i/2lia86qv1EsGf5x7m35QHGwJcc4IaiXvoZr/ApZz2j5C2l7U3/N?=
 =?us-ascii?Q?eOl+YVDEnjmEEMe5FVxe11eS+KSoXdnoiPizR6C6J9rpC7S9d30tCIdL10or?=
 =?us-ascii?Q?g1cXNwQ4Qs8wNqPevrz3SvA7yaYZIHCiGAfHDyp156PaUjgDZkXAZWIypmTc?=
 =?us-ascii?Q?ls9A3zgK3MMRIvjGcU5z2p1vSZtdD3t+mobQ2bbq/Z9s0ZKtxhjE1JsQUaEX?=
 =?us-ascii?Q?YTbjE8uaIRdTL323ZOxznbqnwhN88skyRiCkzjjqwO23roD/+MOnfKBelojM?=
 =?us-ascii?Q?kwn4J17DFjla0qwHB4L3zPocJw1N61En9xNffbWsfYr9Fzj2HD5P5W8ligWI?=
 =?us-ascii?Q?nizS0WIOnRtYeGI/ecJKPqf1d2n7Hg/dhATASGAHZZ0yDFgdNaPLcN7HHkgI?=
 =?us-ascii?Q?IIDaPd8SvF6uyb5wGpbLECZHGv/eQ++NB3hCR5vbJG9WUo0ppqG+PV3Otl5V?=
 =?us-ascii?Q?YbIj1bUbJoUx9dpPojimuY0cC6MJI0qieuvJVU+3MUzEoOXUpZxFL8cxh5w+?=
 =?us-ascii?Q?cTgSUMmonHY/7IAVpQszdJrTpQCQ9AShFYCF7fjKEFa1tC1rHcfD30+KmJ5f?=
 =?us-ascii?Q?YyDH086PvMtwEwht/ZC04KVW3TA4MTmI5g2mtLFI7wQEHLgQvSKflKFPJiOv?=
 =?us-ascii?Q?my4ufgPjjDfJNvVXYBFDjPYQXXAKmo2nXW1sJ4dFUdHjcMNouVaswWuvX/Sx?=
 =?us-ascii?Q?l8esGjYeU8nzp85sQD4h/6W61IGJks+DKyZdtL/KYf3DgEnaOloM05Yr+NfP?=
 =?us-ascii?Q?9xbmYopxmMHQaQkR4sJAkc/G5hFVQ7UyA3zKzEqiDKwMqjlpSODPG3WvMHNM?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18891072-2d99-42e0-7956-08ddbf8d7375
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:40:40.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQSlCOFWKISDW2G+3UEfVkaa4OvpVa04hpqCosy6L4NjT96Of57lUy8mu0e4ySmdem5+3EkXkXwbTSqBmeWRpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com

hi, Nilay,

really sorry for long delay. we are blocked by other issues for a long time.

for this report, the test machine is redeployed for other usages, and I tried
the same stress-ng fpunch test on another Ice Lake server, cannot reproduce the
issue again on 245618f8e4 or latest mainline.

seems the previous test machine has some problem. sorry for our env problem.


On Fri, May 30, 2025 at 07:31:28PM +0530, Nilay Shroff wrote:
> 
> 
> On 5/29/25 7:22 AM, Oliver Sang wrote:
> > hi, Nilay,
> > 
> > sorry for late.
> No worries... 
> 
> [...]
> >>>
> >>> The kernel config and materials to reproduce are available at:
> >>> https://download.01.org/0day-ci/archive/20250522/202505221030.760980df-lkp@intel.com
> >>>
> >>
> >> I tried reproducing this issue but I couldn't recreate it. Is it possible
> >> for you to run this test on your setup using stress-ng option "--iostat 1"
> >> as shown below ?
> >>
> >> # stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1
> >>
> >> If you can run test with above option then please collect logs and share it.
> >> That might help to further debug this.
> > 
> > the log is attached as stress-ng-245618f8e4.
> > also attached the dmesg-245618f8e4.xz.
> > 
> > another log from parent is attached as stress-ng-3efe7571c3.
> > 
> Thanks for trying out --iostat option and sharing logs. I looked through logs and it seems 
> that (my guess) in case of failures (i.e. bogo ops reported as 0) disk read operations are
> either blocked or never completed. However it might be useful to further debug this. 
> Unfortunately, I tried hard but failed to recreate on my setup, so need your help. 
> 
> I have few follow up questions:
> 1. Are you able to recreate this issue even on the recent upstream kernel?
> 2. Did you try formatting the disk using ext4 instead of xfs?
> 
> Anyways, is it possible to rerun test with following options to further analyze it?
> # stress-ng --timeout 60 --times --metrics --verify --no-rand-seed --fpunch 128 --verbose --klog-check --stressor-time --status 1
> 
> Above options shall help generate verbose output as well as log why stressors are not exiting 
> after timeout of 60 seconds. Moreover, it'd be helpful if you can also repeat the test specifying 
> "--fpunch 1". Just wanted to see whether limiting stressors to only 1 recreate the issue. 
> 
> Thanks,
> --Nilay
> 
> 

