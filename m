Return-Path: <cgroups+bounces-7101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A5A6517E
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3761885E30
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A223E344;
	Mon, 17 Mar 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjzL1XeP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490321E098;
	Mon, 17 Mar 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218849; cv=fail; b=KQeR88U16ikNMITyRH0WIBr6th5qnJSNQoA4aYBBgrCLqqrhLTgekbrTw7xl+EHFj4fZR8Zel9Od6ysTOpm9R/nvxoT70gYCtCjl7CncwZDtuOjorEEHIyoicz6mEDfulqhYWX1/V7LxC5Xr2o14J7Pg8hqMJ0F33/lAX22lgbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218849; c=relaxed/simple;
	bh=vjUuhvc1Pr5t46UTEZ12Q/tqQ/5BxtAU+w4LJ/mDuZc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sOepq9a1QgkWZaHLnMsLdkDJpteZtPohW+WYIhtYnlszaVs3wJt1fj0xlx1qv+/c0VdsYnh5f1tpOCu3MGfBFaGgziVMzvEZUYb/Tga2m39CI2qvOCdUm38HaPvBjzCY22rjIST4DSm6f1iiv0xUVZIs65LrhH0T9THNZt/d/xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjzL1XeP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742218847; x=1773754847;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vjUuhvc1Pr5t46UTEZ12Q/tqQ/5BxtAU+w4LJ/mDuZc=;
  b=bjzL1XePfwkRGiAbcMmk/5lncLbR7XOzPf6J8tB81jdZV84+0/v+euyz
   JTXPtAsOFCw9r/0N4S8gAsvZskLWxL5QOHmj28wFYhZGvtYLN+QIJpZvV
   MArH+59uAN4N0hvLKifJ0030EE4D6fyCFraotI8KL9SstTJPfuHU+oNNZ
   xmEP1XCi8STRSqpbjptqVwJAehqtqQ0ynh7fuEIV2dHnLeAL9obxJBnst
   Ik0tXc+hVdfnFdxBufn6jshsltRxB0BW0x6OytastWFiLGZRtjXRf5+hp
   tuKbWV4d+OinoOw4UNHSMPT/dkqEcj9qOZOMkIGUJhYPPRDREwp9V6k5V
   g==;
X-CSE-ConnectionGUID: u54WnONVTS6zKFKw9nzbSg==
X-CSE-MsgGUID: G+becL5nRC+HvAAebzeulg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53938219"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="53938219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:40:46 -0700
X-CSE-ConnectionGUID: Ee38gqu4QlyxCAjU7386XA==
X-CSE-MsgGUID: 1Xi281kGRLSsZkc0igpEsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122449204"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 06:40:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 06:40:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 06:40:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 06:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2LMk3ryicebSE/c4BE3WAnzrPg5S7AAkO3ajVkT+5X1Tcnq7JTNI/11xJyhNNlkbWH+5ncNPWQC+HOBpDkfsOivT3r67ORdguETDvIvJ7qqQLgzra9dj1+vs/hFy1UIpwhF9lV0B87oDZC9Hqx3kRoIwiT44+91ya7zbSdTYp3+TtYe5iB1X+OZy1Z4f3hie8wHozdu57JIRrvHDrWiIkPMZd7j5iGNMzDvaTZUhPjHav1gOuIHk6SX6HFsAvIV0sgyfIPg167yN6KojBaOJuNht1rUiMk2x89tgK1eaz4QAgdK5KKv4UWF+WATv80SK263b3BbL6yE3TdlutqEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw/gHnKgW/efb/SSJbD8/frhc4/fTC0M2sFQZUHbu0w=;
 b=AgiokoxWaJOkDRw3mreyIhSzZKZR1UusSqT0qoVzeKBRHHnIvqPuDXKqnNDjJE2LZcfh5kU16Ec7aC0Y1NbM+ICDPifWo8H/Te9ZNA+uag4WVpKmAT6np1eUrJzdpS80ve/+ooHjPxkMZNkWXOMMBa8lvEJ18wg5B/3D+mgG3wTJkY2lConEpoRvE/6xgqWx0fYytpJBqQwQVcMIAR+qy4MeCqzSBNVoo8pIrqRUzj7E+Dh64zU1xB6S5dElMOSqAlxn+OCGaxuYhy34Rs3xhuCN9bpCc9YVcw52UXDwoYGLLE7nV6zLOzJ2F6yldYGb6Y4mXx/X1Ar9XawYHVoj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:40:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:40:29 +0000
Date: Mon, 17 Mar 2025 21:40:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<dlemoal@kernel.org>, <axboe@kernel.dk>, <gjoyce@ibm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
Message-ID: <202503171650.cc082b66-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304102551.2533767-7-nilay@linux.ibm.com>
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1a3d60-4ab7-473f-83a5-08dd655947c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ij1rsmuvWusZppjsfchv8MXVN5UtbM6uePLRuFPsndqnUtrVGzjmVbMXtymY?=
 =?us-ascii?Q?lzNBI0KsfbZVS03zcGAQYTxxjuTCn4RvaNLKW8L/bPwkXbi4LyAjxZC73tJ+?=
 =?us-ascii?Q?9rsmmRd7N4LmJwrM8XocYrjZNEyi8P73Dn0BCFTZssZ8MVMnFzKZ8wibpILX?=
 =?us-ascii?Q?aBoV6B5GEmrLo2wvIV6b6QCxsoDAXj0RV8Cg2mmJmOXj/ivfuLYPpxeBnMwe?=
 =?us-ascii?Q?MtkCntUqdVI498O2nxgljA2M1nk+q6/REtIicgBd12DyQakqfO95RoipKp5b?=
 =?us-ascii?Q?lGSG1zqTwrfmLjyvkEPeu7wa/7y7K+GNIcsC8audrOcTP0QodhcKE3u0mrvV?=
 =?us-ascii?Q?fi7EG+DCiVteDEY2xtEbO+ZHFfcLi4fcd0AvtFw41S7+Pwgo7P/UxuuKGWEV?=
 =?us-ascii?Q?1iV9qKGMyCFMrN/ohEfo3xoMztcUNruFN5SK+poYCQEkZTNCOa5+lwQf++SU?=
 =?us-ascii?Q?VERNwYTKsAEgPPQJYrIurEmg8GJQcJPRbFvDsswVMhE9OD0zFZusMMEWj4/3?=
 =?us-ascii?Q?GtXQM3hoYK+nPR8OnMpT2+dRPdW68LhR2Rsr9KjCgjsRs8J53vjHw5MM/a0K?=
 =?us-ascii?Q?Sw11zL4hKCd7RMjQ2vm37Y8wgQD8++YXYA4VRTD+CpT4Z1Fh6NHcKH3X5aw+?=
 =?us-ascii?Q?BlEtalZdStWotdJTqfDEkLhglbx03jfDrK0M4RhR674fR9r/74Op4ItXOHpX?=
 =?us-ascii?Q?xnMj7aG2D7dyelju0X6wcgoQAKkV2J6x6bVMwp+IZ3shTxCgQTkOOyGNDW6M?=
 =?us-ascii?Q?+ZC5W/+V5VQ8BBShsMXTLSjpMb2i8xwO6sZebzr0QDyoLcMta/FaLzu06eVI?=
 =?us-ascii?Q?2HUJZwVbvnE6x5LXUrtoAEl0nCgGacSHxIPEMrovmE9Har1OgSW2OB3V03pl?=
 =?us-ascii?Q?oNlmBZXhrSPTsLJJ+KyM48Cv7/EVBABn3i1yl/JeNle1+8BXyNOUZwoo2wue?=
 =?us-ascii?Q?kaSeaY+SLsxKy+KrZlDf+wytTW6l1T/kxkvFPPqXyFssUbD9jJrpuTPEuvyH?=
 =?us-ascii?Q?cbiSbhGjNAtJXq5ZxEcWXbhytplOhjfhS1y7FIApE+3LlWU37ibqL+Bog4Ar?=
 =?us-ascii?Q?d1+L4/vDhxwcQSoJORrBpjsX8S6eZibme7QuutmNOajUw1cgAdxAfoGHKbJZ?=
 =?us-ascii?Q?ogTv7jQ38yW62JM1iiOyJFZ9RGBatt4/oyadeyIH421+/YtV3NujaM9f6l5/?=
 =?us-ascii?Q?ivINH6c4osZBguG9wZ4F1xE/bT8SP4wQ4R25kKF75+coJ2ox1pjyFJXObRF5?=
 =?us-ascii?Q?Fqc8mZyBlBYv7LYOM4T58pQrxAWGg6WF8lW0X7JHRmXD0bzSerCf1ifeEBlk?=
 =?us-ascii?Q?Ibfz1rFdOBRaO9XsNF+seAjsq+1FxEFEyTQwrYmjJRKZgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3VaAtFDUEBRVdjKccAsw9Q8creT2A9YHOa8DhXrNePTcBnsC7yMfxETwXyw?=
 =?us-ascii?Q?30ZHLMp6XJr7lxgaC6Ot6F2WJgXnE8op2BJVy1VYSvahqwyPURBCdKaGlGH/?=
 =?us-ascii?Q?P5z+Zqp3Bei1raKWqLE8oCjKN9eZP9vYVJDQbatWPPz6W7r3r99PVBVoP5ER?=
 =?us-ascii?Q?OCzTpfWmB1QmFc00aY4uFAZaiMQMvFx/BqNeTjoek0az7Uk+nX701W3DJoHh?=
 =?us-ascii?Q?+t6JKU1Dn66YOfx5/zHcq8z9r9wqlup0YhEcj4FHxbKAOlyllADyjnq8hZZ5?=
 =?us-ascii?Q?zymjkYKXiboh0+p7xGCVUCl+5o4DuWnHP6o4MPanKQpAecXSNB2LbT8mp6Yv?=
 =?us-ascii?Q?hv8uTZGX102Uu4nfNPB4fUiQjxS0d7gLqZ68SDS901Tam17Ujkl2pKa3E4YD?=
 =?us-ascii?Q?osA27moI1cEahwjhEVRMFiucVWIbSASpFcG+KjpjQ+Y1+J657b5JDs3qz9t6?=
 =?us-ascii?Q?sZUg5M8CgYBLMmJvfhXSkPGJ1cyuxOQrDdn3BOcBADrY43mWyU/0P0ZZeRH/?=
 =?us-ascii?Q?7kYLohMa5XOmihGMCyWPRFWg4UaVyKSLNvSdt1NYbr2y5QFpt+G43Vk4Ak8P?=
 =?us-ascii?Q?ksTnmQY/cNRS/eLVfzVmCXh6I3imrgngaWiHQMl/GF6QEGG1oIWYhOQItb63?=
 =?us-ascii?Q?T2amKcnufPuiyffcCqNoqghX/P9rvaWjIDwdvDXZadEeWQNGSthO0G1dgZ25?=
 =?us-ascii?Q?k8pMAhYMD0WNdeyXQI3ZifMDe9PRYsYTBJS/2DPiXt3pkP1/0GVw2lzLviWs?=
 =?us-ascii?Q?jouyN67ZF1t5h425/XoHbyA0g3WpvvBSuK6NiHF2DNEAfMPAEIVYsYTvT24U?=
 =?us-ascii?Q?U951UoxJOpkjYrfoBRJdEOO48Mt1PA0hSxbdH/XBZXfo6gd6fxZ4lXwxv5V4?=
 =?us-ascii?Q?6yh3GYoHGGOJ38TLsy79fHuAR7KA66F/CKHEuhfl68wyqKRuuzxY7H5quqzP?=
 =?us-ascii?Q?/IgH2p/K/PxWn+r2Skw9PJAiEFSn7YcSGnpknpbVBoAWyoyZsIAIaFh9+f5v?=
 =?us-ascii?Q?eg0bT/KAis3qp0fbIPP6Zftv8B+i4RjtCfNtV7lIn5lqgcUPAYBdgx4UwYVL?=
 =?us-ascii?Q?w4uJK4+4bNysW/Gl+YwOiCe/2WLtiKDdG4vPmlXW2Ms/9gDmNJyhBFDHoSbL?=
 =?us-ascii?Q?0jV56WMes9D8Ms9BQ0Ec7dtLG1qvWU8VuXhb4pEzoDH3Q+Dr/VCiNwE6npD8?=
 =?us-ascii?Q?bpI1LCLgQvz9kK+0Z93iBRAqVYA3Bjy8WlFjr6BwjM86Z2cCS3jcedmn8FMC?=
 =?us-ascii?Q?0pVwyge5RIUxbhncUcwed2g7RXbEpcmBiPsPnOpOcZf/Mqmq9zwqIdOSSE5W?=
 =?us-ascii?Q?doHJJlhdvfxxKS0Xr313k1EEGjvVe3Rl7oSZom6WzQZrxvt1fbpDyTCKWikR?=
 =?us-ascii?Q?ON903m/wFDJur010F1kuoQJwKPtdawiai3Ua4V62bibULOkcTnoAJcbkwGlP?=
 =?us-ascii?Q?FWHQV82+/jcfFsvb/vePM37CBupcJCtaeejE3cwhO74SMR4E/BuY/u8n99QF?=
 =?us-ascii?Q?cxa1OUV44zj8ZxasAXd2ZTb8rKnyBGxwlgy/TDd6pElL7AGgK3RxNMxnjvXF?=
 =?us-ascii?Q?eWuENn3iRAKKJ6N5iXYAxG//6ScGsy8a9woQTEbmazJDqrHVGdOWkF93Mxge?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1a3d60-4ab7-473f-83a5-08dd655947c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:40:28.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TLZm10K+7U5M33Db4gYJzWC9tKZ+XERR/7mSc952ASDYxj+lGSL1Ub/mYUwiiqn2VtVh5jkkHDszSC1w0j0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: f35c9ef2ba17842de59176b29df32999803bd9fa ("[PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock")
url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-acquire-q-limits_lock-while-reading-sysfs-attributes/20250304-182738
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250304102551.2533767-7-nilay@linux.ibm.com/
patch subject: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock

in testcase: fio-basic
version: fio-x86_64-3.38-1_20250308
with following parameters:

	runtime: 300s
	disk: 1HDD
	fs: btrfs
	nr_task: 100%
	test_size: 128G
	rw: randwrite
	bs: 4M
	ioengine: posixaio
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com


[  991.017071][  T472] INFO: task umount:12320 blocked for more than 491 seconds.
[  991.024314][  T472]       Tainted: G        W          6.14.0-rc5-00192-gf35c9ef2ba17 #1
[  991.032414][  T472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  991.040948][  T472] task:umount          state:D stack:0     pid:12320 tgid:12320 ppid:12317  task_flags:0x400100 flags:0x00004002
[  991.052695][  T472] Call Trace:
[  991.055849][  T472]  <TASK>
[ 991.058658][ T472] __schedule (kernel/sched/core.c:5378 kernel/sched/core.c:6765) 
[ 991.062856][ T472] schedule (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/linux/thread_info.h:192 include/linux/thread_info.h:208 include/linux/sched.h:2149 kernel/sched/core.c:6844 kernel/sched/core.c:6857) 
[ 991.066706][ T472] wb_wait_for_completion (fs/fs-writeback.c:216 fs/fs-writeback.c:213) 
[ 991.071773][ T472] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
[ 991.077702][ T472] __writeback_inodes_sb_nr (fs/fs-writeback.c:2736) 
[ 991.082936][ T472] sync_filesystem (fs/sync.c:55 fs/sync.c:30) 
[ 991.087390][ T472] generic_shutdown_super (fs/super.c:622) 
[ 991.092538][ T472] kill_anon_super (fs/super.c:434 fs/super.c:1238) 
[ 991.096991][ T472] btrfs_kill_super (fs/btrfs/super.c:2101) btrfs 
[ 991.102280][ T472] deactivate_locked_super (fs/super.c:473) 
[ 991.107678][ T472] cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414) 
[ 991.112082][ T472] task_work_run (kernel/task_work.c:227 (discriminator 1)) 
[ 991.116534][ T472] syscall_exit_to_user_mode (include/linux/resume_user_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 991.122197][ T472] do_syscall_64 (arch/x86/entry/common.c:102) 
[ 991.126731][ T472] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 991.131430][ T472] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcontrol.c:857) 
[ 991.136738][ T472] ? handle_mm_fault (arch/x86/include/asm/irqflags.h:154 include/linux/memcontrol.h:970 include/linux/memcontrol.h:993 include/linux/memcontrol.h:1000 mm/memory.c:6077 mm/memory.c:6238) 
[ 991.141606][ T472] ? do_user_addr_fault (include/linux/mm.h:743 arch/x86/mm/fault.c:1339) 
[ 991.146823][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
[ 991.151517][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
[ 991.156203][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
[ 991.160881][ T472] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  991.166777][  T472] RIP: 0033:0x7f415ea2aa77
[  991.171197][  T472] RSP: 002b:00007ffe0db2fd98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  991.179611][  T472] RAX: 0000000000000000 RBX: 000055cc64b55048 RCX: 00007f415ea2aa77
[  991.187586][  T472] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055cc64b55160
[  991.195555][  T472] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
[  991.203514][  T472] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f415eb65264
[  991.211476][  T472] R13: 000055cc64b55160 R14: 0000000000000000 R15: 000055cc64b54f30
[  991.219431][  T472]  </TASK>
[ 1008.358661][T12320] BTRFS info (device sda1): last unmount of filesystem 8b972718-96ad-4a66-b549-8be29321e91a


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250317/202503171650.cc082b66-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


