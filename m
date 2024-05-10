Return-Path: <cgroups+bounces-2853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004078C1ED6
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1BA1F21397
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD1153BE2;
	Fri, 10 May 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYdpCYDS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578931DA53;
	Fri, 10 May 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325362; cv=fail; b=C9+rpiOa95UrwaFdTHq3azsDNASFFtIiKJphuvsrYGxduYDE+kqEne7mFtKYp/At8UcgqbGRP7NM1wBuIgYPdC6Hljhzh9I6YdkKRenpbQ/XQQFd59vpVlaGP+MpnQE79tjXmx1tIohcbPOdkfAx4qac5axfifBUp+58qYND6UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325362; c=relaxed/simple;
	bh=3MGcXH8PnBXQpGX81Zs56TChoQJ4Evw0kXh3qRSS2NI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bk71KSLwQ+6Gpm6EWZ/WSMDVOr80pa3C+t+FvVag6s8Tr+gKDQQluaRhQKvUqXgecaQtxQZaraa3vj9qITrkOkn2M7FhdmSX44cMJedzxS0VKzgkoSi1SwKocwvALBFwUHKgGda7WVq9nXGjswdB9FSYnkSi4IeZ3gZ2V+FsxWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYdpCYDS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325359; x=1746861359;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3MGcXH8PnBXQpGX81Zs56TChoQJ4Evw0kXh3qRSS2NI=;
  b=QYdpCYDSYrPWWqDMLA/ioXTH6U0OqWKBrXEzYg7QGp2wxfZv9S7MWa/C
   fmYQ+NMJfone0+Paav2bupUn2NQoqsuWAlAfVSBrRC+2Xssu7zUhSx21b
   eqFMcZ3eN1JpTSIfZRfK2hEDAFcqS7gFIzqfcz4sjgUY4ce9rvwvxijzE
   LLQItYpwN3BRcLYziRUeJAipqqpX3/7xR+yRA0Q9ryD61DeVMUi23irNO
   3Izt1bAJ7VBpme/TTAiHmcxynZoaiatExVuMMTRK/m+Ra6OqiNBHBEuC7
   NATrJD2Zb3GNaN2F5ju0b/6erM83g+CSQ3QpEbtWR8qFJ9zmAwxngnMJV
   w==;
X-CSE-ConnectionGUID: lYG6jkbgTtCT0PEZsAWUYw==
X-CSE-MsgGUID: x7JRuhxGShKrgLh+l1LKEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15099944"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15099944"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:15:59 -0700
X-CSE-ConnectionGUID: A3HFRt/dRHKZh3ZxBxSp0Q==
X-CSE-MsgGUID: oLsxs+yBQxGdcS7H/61MYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29513990"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 00:15:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:15:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 00:15:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 00:15:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y54Va8WMNGci8LHf68YamoiV19wvXTlWpkGwG9GnB7V7I71C8qxbfLNdYoJatnUQ67HPchoFrhcS5U+nv29hvh6ysIjCTQ/DnvOEs56LMUSUdWfp6pmtWZbcip7VLswx3kUlpuW66HSN1pvfuseOixbNjHVMQZezYA5n6kslKQgBOqZJZSn1ZR1Kl0E6dI/L1Q0YrTzGq8YJS2Coy7VW+OytTm3h1fgRQhi7yNarYEOHiGljaX5WoBl/G89BQDA8xmcUxdERZx8XDvyChY08JP+M9qTtHAJR2AbfuYgLlvd5UOA94mias3Fsl20sHma5urnCH5RbhcaSgHemnAzAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTvmvi9itryTFFRe2Qx8KhsLV81HzY/TXs1btCw9MXc=;
 b=VpP52C6/PdSsbYp0b857Up7VEEAlnXs/oVq1WynPgH0MuZRGDf5rWcHmVzKTXxSd1HX+i9sBF/aa2O9scQ7/oh0YwIiS++b91rHCJj7xfQEEoLC7o57ZDugMM0Gbaj4daadfaMFquRuEiG1ZC7QUKZjKVbAsHqK8OZBMLH8NBybbpTyuDjEvLjr4Mva1pdE+7Fp+1ukEARUz6N4/4iZ9l82zMWGtRuu0CutcDPR4XUPsTWzKqNp1r7oLhYJYpbwIl6wTCh2EJgfgmJzhUCYdWG2ZcgOJ22Lhdt6XSQBVf3BlZAuHhSEDdgW4ywunB9UfWG7uMfuOSCI/ZvaxQBnZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:15:55 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:15:55 +0000
Date: Fri, 10 May 2024 15:15:49 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song
	<muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, "Frank van der
 Linden" <fvdl@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <202405101421.84a43285-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240503201835.2969707-3-roman.gushchin@linux.dev>
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a868c54-9a67-4a99-02e3-08dc70c1083c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k0msozhXcg9fBBgJuLYpS8VCeqaw5zm+7ZvKYoaImynl56VUAshVz350Fjmy?=
 =?us-ascii?Q?hffi7nzZsFkNzrqtM4kM/SAnh6dUY71MXYIpeO7CMLqqSO79OgpYYkA5diMP?=
 =?us-ascii?Q?99se45iPnAxmJyB29gVUsxqOxerS2YEAMbwOknXucl7Rfq96/jdu2AsmlUKA?=
 =?us-ascii?Q?vABRTOvxks0t/2sTX1HTucQ/+grDZXEuBLM8frEXmfH/9crNewSQqXVTGZ2D?=
 =?us-ascii?Q?Dp9FjN6Lbw3zB8TCgekBH0TntweWxLrAgZIjtWioI18O2aS9pNIt6cC8vGqx?=
 =?us-ascii?Q?HL11tTyn32jc8roGMVhtOKjB8Vxqu1Z+uMEzLCm4EEtSDFuirt1ngn7pp9sG?=
 =?us-ascii?Q?VHOD6+90ZpIFmxMGFTiEoHv7TQCcb81pOPv2EE2DESHi/pTzH56neGGJvycU?=
 =?us-ascii?Q?2WWGzMAZWBlBN31owUPehldB9dDDehXoj2QUXfMx+9wITpNm6uukHezduJU0?=
 =?us-ascii?Q?cQjOJbXu7UrFrVqp3Gyx/u0LGc8QRF3aWkvvAMfamqwTT9IAiazl1DAFi6lE?=
 =?us-ascii?Q?3+MKtxueM7hZOlDDOHjw6PJIXK7j0MWiba3xBYl1D/gfwO2XbxgwLEniR10t?=
 =?us-ascii?Q?RXdPGbxtX5I3mYl5tlFqdL57qLFZrtGQ/wi/bSzorcTpq6m0HO0RRe4EuQZQ?=
 =?us-ascii?Q?DdPrfv5F6cXnovofC3pThsR9atirc8zY4Sm49NJG5QNQJ/uapd29NYMCxegB?=
 =?us-ascii?Q?Kr4FJs8DsXMLWB9q5ugMhQ8LCvOQYoykr6QuN24TOFc3gBSI3VEyjgcAwG4n?=
 =?us-ascii?Q?ayI+vtjljTojFe4XnKCnV3EV0SrpfxlxRJTLAOgyd3OxJAz6fIKUMVtDv2IX?=
 =?us-ascii?Q?gxWWFGZ00LQsXmBdECH8HNkaylsdUaEYN9NEVxbO0Lp28l6PL4PQ7Zgutrh1?=
 =?us-ascii?Q?j+DLONtcW3ZfR1qWoh1VBn691SMlRlhUuNH5d39GXSkIIHnBviHcvfICWvxF?=
 =?us-ascii?Q?41Yz0aXhtAUbPSEBYCBUERlD0TjEB+syTEy9utxi/ObGw65OgA6Sr+A5dk7c?=
 =?us-ascii?Q?0XxmCBUGHn1hw0l4SQW1WLkguThE3nxCtDnYBrZKqBf4oYinw2VMRcvBFgv8?=
 =?us-ascii?Q?AkiKX8NKwIoaFIYdj/ye1hxzJ2HhaIEO3tYeJxJMVeahZ4n9EEv1nA97/Jbk?=
 =?us-ascii?Q?h7JIAuUYLG+LN4oQvbdOnVUcvI6Q+fgaSF1nfbr1oVqWjHkQYoApE7Yrxz0s?=
 =?us-ascii?Q?91GzNYdRzDi+klotHKsVlY6iCuTIahscDDEp7by0l0wEDCcNWfAeb8BU5q0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3lyi05gOnpPIWip7Enc6N1KFBw+TN8iH+OrHJt67N+zFwqlsa7Z86rnOudBe?=
 =?us-ascii?Q?vV7fwzxBcaIFGTPLlGSQzjYgAMALzXuv1+Q8a0UObmcbuLss9RZVjjqhsBAs?=
 =?us-ascii?Q?zMzuOjbIe2PsqN/IZ+6fqWDqTJBHAoCoNRdn1+4r5iwyNTGtJ/w2p7jum8gv?=
 =?us-ascii?Q?C2o+zB3CCRzc9jdzN2tXwwB/GBgvq6fZ/PegAdTOzFBQTeRaRXrGtWA5SV0P?=
 =?us-ascii?Q?rQeS+RlkB0lPL8JjLZBW5iX45ZVDgpsFZMEmCnIQuGBLnmlclEp/Z5c1SrBe?=
 =?us-ascii?Q?bajC5Yw6ywgQqmExLFpSteML0t4OyCYIkRcWLJSVEkeRK/wcvLkGAfl4rhIH?=
 =?us-ascii?Q?UHfLrMEc6xAAGYooxZJIKRTD1PvPYl8BzAilqDGzKrSRGz3/EniUQ5Kte5mp?=
 =?us-ascii?Q?oWg7VwHYwfQjJCyKErgP4tH7Hz11XyqexbgzpU09N7kS3An7t6+XFHg3B6aE?=
 =?us-ascii?Q?AkM6r2A8sDUG+8RxUgmZpdCpvxUdS1Tdbn4btTSFBTKRAjb8Ld/890X/7MIG?=
 =?us-ascii?Q?fUpM/rONqLEhlYYi7AeN1UFtFp565WJObYdZRWNHwsXpoX5xhcihgyZOAjcS?=
 =?us-ascii?Q?6ob5hAvkheyTOxyifcIKD8U4Ia+0kyEh3ZDRDS7Qig4iG+xpxYb72URPFbeK?=
 =?us-ascii?Q?OQBlkdr7sknj6wDGw91ctl5mf5dt52gcVV1OHyv2X0FsWD47krO8nw2Y3Nz7?=
 =?us-ascii?Q?MWRTjtjq1KD5nVjEM/PkFwFD7VaKrsCq+qMvVzK5jfxP6Hm7NIPv0q+GAVzo?=
 =?us-ascii?Q?7qPmaT2hZBGplf38flesUc/aCpTNtasQDbIrcholPcYEDNYmvreiZOmDRKjm?=
 =?us-ascii?Q?d2/kVS5glTcWTdXiRTRaUciaEyk5tOwSDX/ZAMJFd9CoyUitBhDyYlhtcf8J?=
 =?us-ascii?Q?gL3ivkauH6CsdngWDVBITpn84IUHMiJPMum82mxcP3u2lwRcMIbIsVMRC2I6?=
 =?us-ascii?Q?4ZC+WlmEm4Xseq2hlYYjiWMCqLuPHA8QavizDw8w8l1hnZNUq/gRIlsUIkdq?=
 =?us-ascii?Q?vZPmP8CyQBH3etmF1Pae53YYTTulOP+VZF7f+Bfc/KMkh/khsVOdVOfWznJT?=
 =?us-ascii?Q?yR6Jh3lkGfivWCfgJVbM8HlBHrTmxi+pEiNXWrG/boaggt8D7Yx6yt0bWHPs?=
 =?us-ascii?Q?K5jGJs2NXdgoxtp43GejbFyK29QjOsF2XO4MadZQQYKgCS7ecyOOiMLRDuTf?=
 =?us-ascii?Q?2fgbmWILvpU7wRKdsVNFdNbvxAlEnwNmYJOtKfD56JmyZGTLYUH+ykj7UZQF?=
 =?us-ascii?Q?9H8nRA0aMEDi6jAOF0o8lwKtUI3Lj6f56NCsRjpVqsGvOYTo3ft15zUeUC1E?=
 =?us-ascii?Q?hhDMuapqZ7wEME2hrPie2YpxkObf0/mAJA0qYyQ6bvzJmVISOEEtfbahL3Rh?=
 =?us-ascii?Q?RkLbd48puLG40h9J7R3I3mIxun1atsxCrA1SEPKl2UM1zygpfu+7KPH0L1aq?=
 =?us-ascii?Q?8bOlobu/QyR82syZMAOueuWPUofrF1afXOZjpjqs8EscOfwj3Wmsbxni0KfI?=
 =?us-ascii?Q?E8x+GjeyUIlQRQMw/YOBGkePHPL6TKb8nX5dbqgdcEFx8uGMZ1bpDxLNy0gC?=
 =?us-ascii?Q?HXa+Bdrhk95end2T9d0cwzp10dfvelne1cKbd+XK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a868c54-9a67-4a99-02e3-08dc70c1083c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:15:55.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTluqBB28vOPS1TJhrkOWVImNz9hCfGHCWY7aGYh/+CWndV7qlTE3e7F1B2N6DrpFQD3pupPXJe6wTly0PCsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com

Hello,

kernel test robot noticed "WARNING:at_mm/page_counter.c:#page_counter_cancel" on:

commit: 214583b2262ef6157ee9834fa23a7da8f2292dd2 ("[PATCH v1 2/4] mm: memcg: merge multiple page_counters into a single structure")
url: https://github.com/intel-lab-lkp/linux/commits/Roman-Gushchin/mm-memcg-convert-enum-res_type-to-mem_counter_type/20240504-042046
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240503201835.2969707-3-roman.gushchin@linux.dev/
patch subject: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a single structure

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240504
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-03

compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405101421.84a43285-lkp@intel.com


kern  :warn  : [  551.565920] ------------[ cut here ]------------
kern  :warn  : [  551.573137] page_counter underflow: -512 nr_pages=512
kern :warn : [  551.585841] WARNING: CPU: 0 PID: 6724 at mm/page_counter.c:58 page_counter_cancel (mm/page_counter.c:58 (discriminator 1)) 
kern  :warn  : [  551.810031] CPU: 0 PID: 6724 Comm: memfd_create03 Tainted: G S                 6.9.0-rc4-00574-g214583b2262e #1
kern  :warn  : [  551.820871] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern :warn : [  551.829368] RIP: 0010:page_counter_cancel (mm/page_counter.c:58 (discriminator 1)) 
kern :warn : [ 551.835103] Code: 3c 02 00 75 4f 49 c7 04 24 00 00 00 00 31 f6 e9 71 ff ff ff 48 89 ea 48 c7 c7 a0 88 f6 83 c6 05 06 21 d6 03 01 e8 84 d9 72 ff <0f> 0b eb ad 48 89 34 24 e8 d7 94 fb ff 48 8b 34 24 e9 67 ff ff ff
All code
========
   0:	3c 02                	cmp    $0x2,%al
   2:	00 75 4f             	add    %dh,0x4f(%rbp)
   5:	49 c7 04 24 00 00 00 	movq   $0x0,(%r12)
   c:	00 
   d:	31 f6                	xor    %esi,%esi
   f:	e9 71 ff ff ff       	jmp    0xffffffffffffff85
  14:	48 89 ea             	mov    %rbp,%rdx
  17:	48 c7 c7 a0 88 f6 83 	mov    $0xffffffff83f688a0,%rdi
  1e:	c6 05 06 21 d6 03 01 	movb   $0x1,0x3d62106(%rip)        # 0x3d6212b
  25:	e8 84 d9 72 ff       	call   0xffffffffff72d9ae
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb ad                	jmp    0xffffffffffffffdb
  2e:	48 89 34 24          	mov    %rsi,(%rsp)
  32:	e8 d7 94 fb ff       	call   0xfffffffffffb950e
  37:	48 8b 34 24          	mov    (%rsp),%rsi
  3b:	e9 67 ff ff ff       	jmp    0xffffffffffffffa7

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb ad                	jmp    0xffffffffffffffb1
   4:	48 89 34 24          	mov    %rsi,(%rsp)
   8:	e8 d7 94 fb ff       	call   0xfffffffffffb94e4
   d:	48 8b 34 24          	mov    (%rsp),%rsi
  11:	e9 67 ff ff ff       	jmp    0xffffffffffffff7d
kern  :warn  : [  551.854617] RSP: 0018:ffffc9000817fb58 EFLAGS: 00010286
kern  :warn  : [  551.860610] RAX: 0000000000000000 RBX: ffff8881001c4100 RCX: ffffffff8239a90e
kern  :warn  : [  551.868499] RDX: 1ffff11030706a6c RSI: 0000000000000008 RDI: ffff888183835360
kern  :warn  : [  551.876394] RBP: 0000000000000200 R08: 0000000000000001 R09: fffff5200102ff23
kern  :warn  : [  551.884295] R10: ffffc9000817f91f R11: 205d363233542020 R12: ffff8881001c4100
kern  :warn  : [  551.892184] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff869a1de8
kern  :warn  : [  551.900067] FS:  00007f45c0bc1740(0000) GS:ffff888183800000(0000) knlGS:0000000000000000
kern  :warn  : [  551.908910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  551.915420] CR2: 00007f45c0c73900 CR3: 0000000206448002 CR4: 00000000001706f0
kern  :warn  : [  551.923304] Call Trace:
kern  :warn  : [  551.926508]  <TASK>
kern :warn : [  551.929366] ? __warn (kernel/panic.c:694) 
kern :warn : [  551.933354] ? page_counter_cancel (mm/page_counter.c:58 (discriminator 1)) 
kern :warn : [  551.938467] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  551.942892] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
kern :warn : [  551.947142] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  551.951741] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [  551.956684] ? llist_add_batch (lib/llist.c:33 (discriminator 14)) 
kern :warn : [  551.961451] ? page_counter_cancel (mm/page_counter.c:58 (discriminator 1)) 
kern :warn : [  551.966564] ? page_counter_cancel (mm/page_counter.c:58 (discriminator 1)) 
kern :warn : [  551.971674] page_counter_uncharge (mm/page_counter.c:168 (discriminator 3)) 
kern :warn : [  551.976706] hugetlb_cgroup_uncharge_counter (mm/hugetlb_cgroup.c:392) 
kern :warn : [  551.982684] hugetlb_vm_op_close (mm/hugetlb.c:5222) 
kern :warn : [  551.987713] remove_vma (mm/mmap.c:142) 
kern :warn : [  551.991870] do_vmi_align_munmap (mm/mmap.c:2336 mm/mmap.c:2685) 
kern :warn : [  551.996897] ? __pfx_do_vmi_align_munmap (mm/mmap.c:2561) 
kern :warn : [  552.002446] do_vmi_munmap (mm/mmap.c:2757) 
kern :warn : [  552.006948] __vm_munmap (mm/mmap.c:3036) 
kern :warn : [  552.011288] ? __pfx___vm_munmap (mm/mmap.c:3027) 
kern :warn : [  552.016138] ? __pfx_ksys_write (fs/read_write.c:633) 
kern :warn : [  552.020914] __x64_sys_munmap (mm/mmap.c:3050) 
kern :warn : [  552.025509] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
kern :warn : [  552.029924] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [  552.035733] RIP: 0033:0x7f45c0cc58f7
kern :warn : [ 552.040067] Code: 00 00 00 48 8b 15 09 05 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 04 0d 00 f7 d8 64 89 01 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	15 09 05 0d 00       	adc    $0xd0509,%eax
   a:	f7 d8                	neg    %eax
   c:	64 89 02             	mov    %eax,%fs:(%rdx)
   f:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  16:	c3                   	ret
  17:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1e:	00 00 00 
  21:	66 90                	xchg   %ax,%ax
  23:	b8 0b 00 00 00       	mov    $0xb,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d d9 04 0d 00 	mov    0xd04d9(%rip),%rcx        # 0xd0513
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d d9 04 0d 00 	mov    0xd04d9(%rip),%rcx        # 0xd04e9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240510/202405101421.84a43285-lkp@intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


