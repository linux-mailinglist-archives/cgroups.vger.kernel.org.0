Return-Path: <cgroups+bounces-15848-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM5uJuUoA2qw1AEAu9opvQ
	(envelope-from <cgroups+bounces-15848-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 15:19:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5BA520FEB
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3E83124ABD
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3E350A35;
	Tue, 12 May 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VP5fKzYK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4197306768;
	Tue, 12 May 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590642; cv=fail; b=iNA8je7yaNrytqEn0HYPmoNFPGadqoX9vjaB8E6kBDUbx2NyoHue7ElgwlBdGRcO0VuCfzuM64etaJlQ9Cu9JYsOhsRnrmk9IVLYgsi/ufO4ELVFBp5kgza6brQQC+Im/xp33WrXvo6jb2RYQmmpkr64hHF+UAhc/gT3ZwJl7oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590642; c=relaxed/simple;
	bh=WG5U7XHz3m7tmpgCgv460TReip5iHrh6rEuRDZxwv48=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=s4eeXMt9y7ucb022IsazdZ9SKv4aar+4JCOalL5+j8LFTu7YhlboF/xJju9AZ3bECZ4VfOZ+9XqUq4Tm3noBlCfZs2r8dDOcy4fjYgrkzXCwIEcsLagNWxBXJ3fm2GxLLmYv5pKGEx4Q2P5YIrX4Fm/vl5r66lM6i8TpKpx0awA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VP5fKzYK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778590636; x=1810126636;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WG5U7XHz3m7tmpgCgv460TReip5iHrh6rEuRDZxwv48=;
  b=VP5fKzYK8d6WO5UnrYSQpjhHOZK9DGhzDVx32mGhjP55c8N3syUDUpCL
   zI2iZZyE5OYQvo42bbIdC5u3uCERK8M8xzWlUm/eiGV/m1rBT+71m6AAQ
   XSxG6x1gWbts85zxy8dscxobEnZA0AAoD7e/0KjiG6n8/Sdpf7D1iZUoB
   68cijwY8BKFgw/v9qbMDerduAaXEmTptIVMwVIqmVkkbcmrYj2BabN4ai
   D1VsqWz6GAcwcBOhBHHY+OzOfrge8W1QCj2MifxM2r1EvzkyBkx+pWaZg
   xIBwu4DjV+ECsbAclAaRKECqfD+tjcwV+jbkr7FtTvT3KWZzkRV+GrpQ4
   A==;
X-CSE-ConnectionGUID: fcRkGB+QSWK8RJcJyoLXhQ==
X-CSE-MsgGUID: qsQEwvE+TKuWYMncFqKkIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78644030"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78644030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:57:14 -0700
X-CSE-ConnectionGUID: lcmWAqm9Qy+Oj2zgA4RS+Q==
X-CSE-MsgGUID: BxYy+6oYTOexDhEV0FLoWw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:57:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 05:57:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 05:57:12 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 05:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HietUk5tO0We1VE3p9MBHU4pjhwOP7OIE7UShmz9tMzSC88/km6Ubz6qtWEuRm7wOpJHEOUDs38dDkTHnjL3A83xVyp7STRF6Vb23vhJkGhMsPWQSH1qWVgpe7yBGS2PlvDenEM2aGzZ59YPSAFm6OGYza9afuCtkI3HGnHhGo/UbGWxkFL6X1UC0VE2uGlALnBnn5Y+Uqc4g/+orFTgL3w+UuGgVl5jaqshbf9p1/RoOTOt34SbYR4fqv4j5s96dZ6+YRZrqK4qywgrom/KOZTIYHnyne73vyef4Ux9gsZM/Vg5rYN42KCkA39awj3mktKXVlMFOYWFFbJyOOhGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YVokMUnpldaPiTslIccYWoUCIQDBRn5GV35SH81sMA=;
 b=QbqE/RTudqFWVylgZSzAxeHXPQP7fmcb48GxAf5SK2YeP1vSYh7DTx8Gtn3wqRP9rBfaLkw66/+UH/3twhl5QayTf+YbN+VBomr0E8CcChmVZvHthfzRdhOC8l9cZYJEpZN3Mt3jyVdBFYl68aDr4sE/TsLHNlck6kZREkYrt1lHxbwHKNGze5C4BnLX1co/MylQy+eKHTEiogPA3QhrDeoDK8GnkBshlOQGz701CT6oMGC9SQ9OuWQUH3Rf4Ic7jZbnroYvr5NNP1wUxb6WV34LnpZRcapJSygfnyokD6WMlpChwj4zVNLiD6jvU7FYzZKK9vIFJvN5ObwZWdaf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CYYPR11MB8305.namprd11.prod.outlook.com (2603:10b6:930:c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 12:57:05 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9891.019; Tue, 12 May 2026
 12:57:04 +0000
Date: Tue, 12 May 2026 20:56:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, David Carlier
	<devnexen@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Allen Pais
	<apais@linux.microsoft.com>, Axel Rasmussen <axelrasmussen@google.com>,
	Baoquan He <bhe@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>, "Chen
 Ridong" <chenridong@huawei.com>, David Hildenbrand <david@kernel.org>, "Hamza
 Mahfooz" <hamzamahfooz@linux.microsoft.com>, Harry Yoo
	<harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, Imran Khan
	<imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, Kamalesh
 Babulal <kamalesh.babulal@oracle.com>, Lance Yang <lance.yang@linux.dev>,
	"Liam Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>,
	"Michal Hocko" <mhocko@suse.com>, Michal =?iso-8859-1?Q?Koutn=FD?=
	<mkoutny@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, "Muchun Song" <songmuchun@bytedance.com>, Nhat Pham
	<nphamcs@gmail.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, Suren
 Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, "Wei Xu" <weixugc@google.com>, Yosry
 Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>, Zi Yan
	<ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  01b9da291c: stress-ng.switch.ops_per_sec 67.7%
 regression
Message-ID: <202605121641.b6a60cb0-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CYYPR11MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e9aa93-f06c-462c-7c65-08deb025f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3023799003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: eziEpWTQ/EXFTXmcW28ULMZd3Y/sHNWV8pwDZArJamUTml9Nst53Zj9FKoEKC7IWtS4hLOc3wbByOnYQkEUG1jgGpWcXhTog9xwkp35RwEmedQ2tKE6x4bRTqKF2aqonYSLftAvXnbI6UeXb8ae0bSmoN3cQRudqYaecQnkXLRkFoUM2D8/9z6vWbycvLNfiN1EZpQQWgxulCjuiLC+JhFmtl29zog4ruf03YvcbUOoqoi9Cl6k3kInokVFu7+GQ9jxZ9h41SziNXuUpd8M/HAI8Oj/yqTBUnFBEFWE2QZIArGxF6rXKSkJNw382Am/cBGXajSzRMiADixclfjlYATTLe2pLHggGBdPqI3uuw3miLM59UH+2O8nJa9RzgLnAaQoJPWOrhoOw1oLUD7P663NUQW2FAFyRbUoHK6nFbo7MTdl56Coh5BkIx0hWbRqufMNLZMwr6kguv56zDbOHktE2X9Ivl0trUR4G3ucqBRxrJODIuCI1XAP3a50pbnuFm0KBxfEZYkBIhHyHOZjU84XwFvNVNZdN2ZiZCiEBnpk77X1ovGw2ksdjRgdtDR6rWz4v9cnkKT1WGlyRzTmQp+/ltF8NRTvc44svbUy3VjRSiPK7RxMtwe2S797dD+zbXZFSDT/Twihyh1R/Ntl41Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QQX3egUxyLsRdEaT71wC7TDwqLjvaehINYuXWza2rGMAydkH3FPxvKTUZC?=
 =?iso-8859-1?Q?vtNqpFmTJEggdZ7hsWq9+yW/zjSBCk7iHYHJYFo1jQfVCI9bjoRVkuES83?=
 =?iso-8859-1?Q?Xv3h8qBbyE+YKzlNB4O4oOEwh2lPUymjCTVIed0kLSLE63ZvwbNm/GJMZL?=
 =?iso-8859-1?Q?pZZbP8T5ksVVBA9HcxNgIY+XXVkw/207vDVx4Pyb//wzMR37LnJrMR9hjx?=
 =?iso-8859-1?Q?xAeN/AQ+748EIs4mBfrbywg2fAjoGyee0Mb9rSHY1WXdOEC27wy/YvC3xI?=
 =?iso-8859-1?Q?P0tkBQjrTYLzl82Ntf0gs7zDdoZOAKWrNIDKhYQ0Q5wM3nX8cY1yJXKWAN?=
 =?iso-8859-1?Q?YtVHq4XOFLdcCWDonnr7IERA7UJqjiz7mgT+WvEdIQEV6H/F3b1S/vl6et?=
 =?iso-8859-1?Q?ZU33RQlqdhWdc7Thb9XxMoYTVSnO5vYaWYpmI3rWABlP4e134IieSpxWCv?=
 =?iso-8859-1?Q?T1I9713GADiBkKHb0TXnhI7ratqrVk4x8tfCWhP3j784sCAhSPW2R/iHuR?=
 =?iso-8859-1?Q?Lze3VB6RwSwdI2c6Kc6dqAiUrESruEmT9sNNZtOjQrv/6p5gNmt0qsgbNZ?=
 =?iso-8859-1?Q?4/rkQYnDWxllrQJADOCQRMk9r9nPf8yKh2xVeae+g0nsKAHyuNFcltb3kT?=
 =?iso-8859-1?Q?r9V/HCfq7cLADysgMl5QsOmHTfp6JPpOVXLtwANac7zgJhiWVfw3+iT4Ph?=
 =?iso-8859-1?Q?1z4bLmGk9Y2vRvn/oCRUBkGkIwoZUAjJhXtkVB8ns0IPda5S6xjuRKjfEJ?=
 =?iso-8859-1?Q?Kc7bcs4QECuwBzIDbzBJwkeo9TxbfclcBKR7DJPsL9ZLzYzUvZPNur7mBS?=
 =?iso-8859-1?Q?Pz7qm9p8sdY2h8+fHEV9sKgcTOg5G9pVtjPFffNVGp7dw2qbTztop0NOXd?=
 =?iso-8859-1?Q?V1RHvQUN482VP/cgpmqfNAp5lOJuZOanmujdmEbEE9AG/H+EFanFDWNyny?=
 =?iso-8859-1?Q?BV73/VVrqOj9+FBiqyCkMvCQvLtNhCI6OiGCVoB8bzc+SqblNncRqJ3+ZH?=
 =?iso-8859-1?Q?YuxZvP4MFSToWQMiOH+HcrXbvXmJPFJYb/mSd7rBz2YSVEL7moOazvas0A?=
 =?iso-8859-1?Q?wj8kV1/34Y2y0TJxSLrhfE+6mBsjRdt33tLhJI9YNYpCjd/uE6hoS+/2ht?=
 =?iso-8859-1?Q?yDHgLXtad1fNjjlLiwHyZKs3K0gcUAyx3EFckWx3KLxYqyQiNFwXUGAFmr?=
 =?iso-8859-1?Q?WgZpd9EQehkC02gtuRpIHES2Yh2mcrOizdBUeFTdoypzHI43ODqp092ZRM?=
 =?iso-8859-1?Q?Dnol9t2FYEQU7U1MbbUwWwWASjIAClTxb1LCss3T2odk/1QJek47dQvCBF?=
 =?iso-8859-1?Q?6kTi+5b8+38kFQVZadn66tLgu1m4MsW/E7qiFpGHStw/BixC8GdL0vYtVJ?=
 =?iso-8859-1?Q?F1HOE4oBto9vsKeKWWo/b4fUAuTSIVFqaU14EoADGMK8rP+l4hho4kCfG4?=
 =?iso-8859-1?Q?EhJABbkz8ulcMHkjQ/U151PvRAa6IJoeU+7381+TKBwwv1ErhKPt37ARYt?=
 =?iso-8859-1?Q?F6318Ts55zcfNi0oGTExkFGYJph3zdCH2QxZrkBGc6bmWXqony/3lDq5Qn?=
 =?iso-8859-1?Q?AhFjY0ed77RrV/MnU8kfpllEGC/+18Hdjd6aXf3wgKidV6nNBzQYZVWTm4?=
 =?iso-8859-1?Q?JCjX8QeDlQAMC0JIjOhrnBvGPFIR491siOHSts6bxT7BF/j/VMZdsgqflk?=
 =?iso-8859-1?Q?/4Wx5JNaHxbsTu9wZ1dGUCvv1AwQPifWBBwzmSen8GVWi+pZKaYJ0ZXzsc?=
 =?iso-8859-1?Q?3d6K2vwW16N0nEc+anHN2sRCk52A5vkSjKEEGVLDrwzpJiYu8PF1x/952t?=
 =?iso-8859-1?Q?g7ZO32a4Wg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Dsj0Z/6CPMBguyaT6FGlPz5eXsXX4IE5rHpBqYKCozj8mfaLs3STWXwszOESgbMIgH1AOABt0usdvzsPnO9FR2osYK11p+tsM9v0NSe4THIWAO3ICBxtT59ZnCb/c91OzFI0opandYRdIUOZppOVkKrDbdPYTgfoNRwJAKA/uI5lC+egzv3WResMyFnMGceduyR4zRqw6B1icIlPhZGeVIdErmgpyIG+TVzO0f1vF7BRLIO/JyKz7AdtCtC2wj2WHdWhWu3R9u4H5mF8t9ZavUU+XJPp5VkIB/Bxttgnv4rDW2ci+vnTTtMsXaCw3ahg89PmR0M952EY07Of0BTmmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e9aa93-f06c-462c-7c65-08deb025f75e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 12:57:04.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jstAfB+EmiBen/RYJn61OoYYquW9MsbAMtPTkKKGctmdtYfFIaqTF6ajVFqTWCMToXwLdtupFSOeZy6cTSByIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8305
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8E5BA520FEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[40];
	TAGGED_FROM(0.00)[bounces-15848-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.dev,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,average.ms:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:


commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      66edb901bf874d9e0787326ba12d3548b2da8700]
[still regression on linux-next/master b9303e6bff706758c167af686b5315ad00233bf8]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: switch
	method: mq
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  3.8% regression |
| test parameters  | cpufreq_governor=performance                     |
|                  | nr_task=100%                                     |
|                  | runtime=300s                                     |
|                  | test=spawn                                       |
+------------------+--------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260512/202605121641.b6a60cb0-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s

commit: 
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")

8285917d6f383aef 01b9da291c4969354807b52956f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5849          +210.2%      18145 ±  3%  stress-ng.switch.nanosecs_per_context_switch_mq_method
 2.296e+09           -67.7%  7.408e+08 ±  3%  stress-ng.switch.ops
  38288993           -67.7%   12355813 ±  3%  stress-ng.switch.ops_per_sec
  93416932           -68.6%   29310048 ±  3%  stress-ng.time.involuntary_context_switches
     15845           +11.0%      17584        stress-ng.time.percent_of_cpu_this_job_got
      8556           +18.2%      10115        stress-ng.time.system_time
    963.36           -53.5%     447.72 ±  3%  stress-ng.time.user_time
 1.518e+09           -69.7%  4.607e+08 ±  2%  stress-ng.time.voluntary_context_switches
      1124 ± 17%     +34.3%       1509 ±  8%  perf-c2c.HITM.remote
  2.55e+09           -12.3%  2.236e+09 ±  3%  cpuidle..time
  8.29e+08           -71.8%  2.337e+08 ±  2%  cpuidle..usage
   4102960 ±  5%     -19.0%    3324393 ±  4%  numa-numastat.node1.local_node
   4218983 ±  3%     -18.7%    3430325 ±  3%  numa-numastat.node1.numa_hit
  14184409 ±  2%     -16.4%   11860068        vmstat.memory.cache
  39204964           -69.7%   11868752 ±  2%  vmstat.system.cs
   1808848           -38.5%    1111830        vmstat.system.in
     22.48            -4.4       18.08        mpstat.cpu.all.idle%
      1.13            -0.4        0.73        mpstat.cpu.all.irq%
      0.10            -0.0        0.09        mpstat.cpu.all.soft%
     67.98            +9.1       77.06        mpstat.cpu.all.sys%
      8.32            -4.3        4.04 ±  2%  mpstat.cpu.all.usr%
     17.33 ±  2%     +15.4%      20.00 ±  4%  mpstat.max_utilization.seconds
  10552401 ±  4%     -23.3%    8092823        numa-meminfo.node1.Active
  10552392 ±  4%     -23.3%    8092820        numa-meminfo.node1.Active(anon)
  12454155 ± 15%     -34.9%    8106052        numa-meminfo.node1.FilePages
    559046 ±  8%     -19.2%     451929 ±  2%  numa-meminfo.node1.Mapped
  14688311 ± 13%     -30.0%   10285394 ±  2%  numa-meminfo.node1.MemUsed
  10028979 ±  3%     -22.4%    7783864        numa-meminfo.node1.Shmem
   2638537 ±  4%     -23.3%    2022639        numa-vmstat.node1.nr_active_anon
   3113944 ± 15%     -34.9%    2025946        numa-vmstat.node1.nr_file_pages
    139848 ±  9%     -19.3%     112912 ±  2%  numa-vmstat.node1.nr_mapped
   2507650 ±  3%     -22.4%    1945399        numa-vmstat.node1.nr_shmem
   2638531 ±  4%     -23.3%    2022634        numa-vmstat.node1.nr_zone_active_anon
   4219206 ±  3%     -18.7%    3430093 ±  3%  numa-vmstat.node1.numa_hit
   4103183 ±  4%     -19.0%    3324161 ±  4%  numa-vmstat.node1.numa_local
  10939677 ±  2%     -21.0%    8641166        meminfo.Active
  10939661 ±  2%     -21.0%    8641149        meminfo.Active(anon)
  13917673 ±  2%     -16.4%   11633722        meminfo.Cached
  14400924 ±  2%     -16.0%   12102150        meminfo.Committed_AS
   8394752 ±  5%     +16.7%    9796949 ±  8%  meminfo.DirectMap2M
    617671           -12.0%     543559        meminfo.Mapped
  18364992           -12.5%   16065468        meminfo.Memused
  10124702 ±  2%     -22.6%    7839682        meminfo.Shmem
  18393665           -12.5%   16100473        meminfo.max_used_kB
     10.59            -7.6        2.97 ±  8%  turbostat.C1%
      0.85 ±  3%      +9.1        9.96 ±  2%  turbostat.C1E%
      1.29 ±  6%     +19.4%       1.54 ±  2%  turbostat.CPU%c1
     48.67 ±  2%     -15.1%      41.33 ±  3%  turbostat.CoreTmp
      0.56           -60.7%       0.22 ±  3%  turbostat.IPC
 1.153e+08           -38.7%   70680365        turbostat.IRQ
  10242404           -14.8%    8723704        turbostat.NMI
     88.65           -84.0        4.67 ± 33%  turbostat.PKG_%
      3.82            -3.8        0.04 ± 10%  turbostat.POLL%
     48.67 ±  2%     -13.7%      42.00 ±  3%  turbostat.PkgTmp
    683.77           -13.1%     594.00        turbostat.PkgWatt
     18.74            -3.3%      18.13        turbostat.RAMWatt
   2735312 ±  2%     -21.0%    2160742        proc-vmstat.nr_active_anon
    204708            -1.6%     201435        proc-vmstat.nr_anon_pages
   3479812 ±  2%     -16.4%    2908863        proc-vmstat.nr_file_pages
    154477           -12.0%     135959        proc-vmstat.nr_mapped
   2531568 ±  2%     -22.6%    1960353        proc-vmstat.nr_shmem
     42010            -3.5%      40543        proc-vmstat.nr_slab_reclaimable
   2735312 ±  2%     -21.0%    2160742        proc-vmstat.nr_zone_active_anon
    210167 ±  5%     -11.5%     185950 ± 11%  proc-vmstat.numa_hint_faults
   4730338 ±  2%     -18.2%    3871343        proc-vmstat.numa_hit
   4498551 ±  2%     -19.1%    3639783        proc-vmstat.numa_local
   4808959 ±  2%     -17.8%    3954157        proc-vmstat.pgalloc_normal
    806619            -5.1%     765525 ±  2%  proc-vmstat.pgfault
     34098 ±  3%     -14.8%      29054        proc-vmstat.pgreuse
      0.11           +59.9%       0.17 ±  3%  perf-stat.i.MPKI
 6.653e+10           -61.7%  2.546e+10 ±  2%  perf-stat.i.branch-instructions
      0.76            +0.1        0.89        perf-stat.i.branch-miss-rate%
 4.685e+08           -59.7%  1.888e+08 ±  2%  perf-stat.i.branch-misses
      1.12            +0.6        1.76 ±  3%  perf-stat.i.cache-miss-rate%
  35553724 ±  3%     -40.4%   21188697        perf-stat.i.cache-misses
 4.194e+09           -68.3%  1.331e+09 ±  2%  perf-stat.i.cache-references
  40710745           -69.6%   12395879 ±  2%  perf-stat.i.context-switches
      1.84          +189.1%       5.31 ±  2%  perf-stat.i.cpi
 5.965e+11            -2.0%  5.848e+11        perf-stat.i.cpu-cycles
   8813175           -64.5%    3125097 ±  2%  perf-stat.i.cpu-migrations
     24447 ±  3%     +68.5%      41184 ±  2%  perf-stat.i.cycles-between-cache-misses
 3.374e+11           -61.8%  1.287e+11 ±  2%  perf-stat.i.instructions
      0.57           -60.8%       0.22 ±  2%  perf-stat.i.ipc
    221.10           -68.6%      69.32 ±  2%  perf-stat.i.metric.K/sec
     11782 ±  3%      -6.1%      11068 ±  3%  perf-stat.i.minor-faults
     11782 ±  3%      -6.1%      11068 ±  3%  perf-stat.i.page-faults
      0.10 ±  2%     +59.2%       0.17 ±  3%  perf-stat.overall.MPKI
      0.71            +0.0        0.75        perf-stat.overall.branch-miss-rate%
      0.83 ±  3%      +0.7        1.56 ±  3%  perf-stat.overall.cache-miss-rate%
      1.78          +162.2%       4.67 ±  2%  perf-stat.overall.cpi
     17181 ±  3%     +64.6%      28283        perf-stat.overall.cycles-between-cache-misses
      0.56           -61.8%       0.21 ±  2%  perf-stat.overall.ipc
 6.388e+10           -62.3%  2.409e+10 ±  2%  perf-stat.ps.branch-instructions
 4.538e+08           -60.0%  1.817e+08 ±  2%  perf-stat.ps.branch-misses
  33674051 ±  3%     -40.1%   20155290        perf-stat.ps.cache-misses
 4.077e+09           -68.2%  1.296e+09 ±  2%  perf-stat.ps.cache-references
  39570629           -69.5%   12072702 ±  2%  perf-stat.ps.context-switches
  5.78e+11            -1.4%    5.7e+11        perf-stat.ps.cpu-cycles
   8584979           -64.5%    3051930 ±  2%  perf-stat.ps.cpu-migrations
 3.243e+11           -62.4%   1.22e+11 ±  2%  perf-stat.ps.instructions
     11022 ±  4%      -6.5%      10300 ±  3%  perf-stat.ps.minor-faults
     11022 ±  4%      -6.5%      10300 ±  3%  perf-stat.ps.page-faults
 1.941e+13           -61.9%  7.405e+12 ±  3%  perf-stat.total.instructions
     18451            +9.9%      20272        sched_debug.cfs_rq:/.avg_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.68 ±  2%     -12.9%       0.59 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.62 ±  6%     -12.9%       0.54 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      8469           +12.7%       9544 ±  2%  sched_debug.cfs_rq:/.left_deadline.stddev
      8467           +12.7%       9542 ±  2%  sched_debug.cfs_rq:/.left_vruntime.stddev
   3513124 ± 25%     -30.0%    2459550 ± 10%  sched_debug.cfs_rq:/.load.max
    588329 ±  5%     -11.2%     522578 ±  5%  sched_debug.cfs_rq:/.load.stddev
     50699 ± 17%     -19.8%      40655 ±  7%  sched_debug.cfs_rq:/.load_avg.max
      0.68 ±  2%     -12.9%       0.59 ±  3%  sched_debug.cfs_rq:/.nr_queued.stddev
     38.80 ± 32%    +108.5%      80.90 ± 16%  sched_debug.cfs_rq:/.removed.load_avg.avg
    857.83 ± 12%     +61.0%       1381 ± 12%  sched_debug.cfs_rq:/.removed.load_avg.max
    152.02 ± 18%     +57.2%     239.02 ± 11%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     26.08 ± 28%    +143.0%      63.37 ± 14%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    547.00 ± 13%     +88.7%       1032 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     94.86 ± 17%     +84.3%     174.82 ±  9%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      9.09 ± 52%    +253.3%      32.11 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.avg
    275.17 ±  3%    +130.3%     633.67 ±  9%  sched_debug.cfs_rq:/.removed.util_avg.max
     44.90 ± 30%    +126.4%     101.66 ± 11%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      8467           +12.7%       9542 ±  2%  sched_debug.cfs_rq:/.right_vruntime.stddev
    659.63 ±  3%     +13.0%     745.47        sched_debug.cfs_rq:/.runnable_avg.avg
    271.34 ±  2%     +31.2%     355.98 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ± 26%    +110.4%       0.00 ± 45%  sched_debug.cfs_rq:/.spread.avg
      0.01 ± 13%    +174.3%       0.02 ± 25%  sched_debug.cfs_rq:/.spread.max
      0.00 ±  7%    +146.2%       0.00 ± 27%  sched_debug.cfs_rq:/.spread.stddev
    431.00           +14.5%     493.62        sched_debug.cfs_rq:/.util_avg.avg
      1061 ±  3%     +26.4%       1341 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    151.53 ±  5%     +50.1%     227.46 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    206.96           +17.5%     243.18 ±  3%  sched_debug.cfs_rq:/.util_est.avg
     18451            +9.9%      20272        sched_debug.cfs_rq:/.zero_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%  sched_debug.cfs_rq:/.zero_vruntime.stddev
      2345           +33.6%       3133 ±  5%  sched_debug.cpu.avg_idle.min
     13.18 ±  2%     +39.8%      18.42 ±  6%  sched_debug.cpu.clock.stddev
      3961           +14.6%       4541        sched_debug.cpu.curr->pid.avg
      3213           -15.4%       2718        sched_debug.cpu.curr->pid.stddev
      0.00 ± 29%    +157.3%       0.00 ± 35%  sched_debug.cpu.next_balance.stddev
      0.70           -15.8%       0.59 ±  3%  sched_debug.cpu.nr_running.stddev
   5474800           -69.7%    1660250 ±  2%  sched_debug.cpu.nr_switches.avg
   5648642           -65.5%    1946319 ±  5%  sched_debug.cpu.nr_switches.max
   2229198 ±  8%     -67.1%     734011 ± 20%  sched_debug.cpu.nr_switches.min
    297592 ±  6%     -25.9%     220513 ± 18%  sched_debug.cpu.nr_switches.stddev
     23.75           -10.9       12.88        perf-profile.calltrace.cycles-pp.common_startup_64
     23.65           -10.8       12.82        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     23.62           -10.8       12.81        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     23.51           -10.8       12.76        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.93            -7.0        5.94 ±  4%  perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.78            -6.9        5.89 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
     11.30            -5.2        6.07 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.17            -5.2        6.02 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      9.89            -4.8        5.08 ±  4%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
     12.41            -4.4        7.96        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.19            -4.4        4.77 ±  4%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     11.29            -4.0        7.29        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     11.38            -4.0        7.40        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.04            -3.9        4.13 ±  4%  perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      6.91            -3.8        3.08 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      6.76            -3.8        3.00 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive
      8.71            -3.7        5.00        perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.71            -3.4        2.26 ±  4%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.12            -3.4        4.72        perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      7.76            -3.2        4.55        perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend
      8.39            -3.1        5.26        perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.47            -3.1        4.35        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend
      4.92            -2.9        2.00 ±  4%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      7.79            -2.8        4.97        perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      7.48            -2.7        4.79        perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive
      7.17            -2.6        4.60        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive
      5.54            -2.3        3.24 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      5.41            -2.2        3.16 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend
      3.88            -2.2        1.67 ±  4%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.04            -2.2        1.88        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.44            -2.2        1.28 ±  3%  perf-profile.calltrace.cycles-pp.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84            -2.0        1.80        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      4.83            -2.0        2.85        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      4.71            -1.9        2.78        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock
      4.39            -1.8        2.58        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      2.37            -1.5        0.84 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.66            -1.4        1.26 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.73            -1.4        1.33 ±  4%  perf-profile.calltrace.cycles-pp.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.50            -1.3        2.17        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      2.37            -1.3        1.06 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.10            -1.1        3.03        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      2.20            -1.1        1.13 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.20            -1.1        1.15 ±  4%  perf-profile.calltrace.cycles-pp.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74            -1.0        0.73 ±  3%  perf-profile.calltrace.cycles-pp.msg_get.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32            -1.0        0.37 ± 70%  perf-profile.calltrace.cycles-pp.do_perf_trace_sched_wakeup_template.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive
      1.93            -0.9        0.99 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.34            -0.8        0.54 ±  5%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      1.52            -0.8        0.73 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      1.05            -0.7        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__switch_to
      1.57            -0.7        0.90 ±  6%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.56            -0.3        2.28        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock
      5.87            +0.9        6.78        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.9        0.91 ± 30%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
     35.80            +3.5       39.29        perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.59            +3.6       39.21        perf-profile.calltrace.cycles-pp.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.4        4.37 ±  3%  perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg
      0.00            +4.4        4.39 ±  4%  perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg
      0.00            +8.0        8.01 ±  4%  perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend
      0.00            +8.3        8.29 ±  4%  perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive
     28.51           +13.5       41.99        perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.23           +13.5       41.71        perf-profile.calltrace.cycles-pp.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.69           +13.7       84.35        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.44           +13.8       84.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.99           +20.2       23.24 ±  2%  perf-profile.calltrace.cycles-pp.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79           +20.4       23.15 ±  2%  perf-profile.calltrace.cycles-pp.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.43           +20.6       22.98 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive
      2.26           +26.0       28.23 ±  2%  perf-profile.calltrace.cycles-pp.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99           +26.8       27.80 ±  2%  perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      0.65           +27.0       27.62 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend
     24.25           -12.2       12.02 ±  4%  perf-profile.children.cycles-pp.wake_up_q
     24.00           -12.1       11.93 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
     23.75           -10.9       12.88        perf-profile.children.cycles-pp.common_startup_64
     23.75           -10.9       12.88        perf-profile.children.cycles-pp.cpu_startup_entry
     23.68           -10.8       12.85        perf-profile.children.cycles-pp.do_idle
     23.65           -10.8       12.82        perf-profile.children.cycles-pp.start_secondary
     19.65            -8.3       11.33        perf-profile.children.cycles-pp.__schedule
     17.14            -6.9       10.28        perf-profile.children.cycles-pp.wq_sleep
     16.24            -6.4        9.82        perf-profile.children.cycles-pp.schedule
     15.92            -6.2        9.69        perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
     12.46            -6.1        6.32 ±  4%  perf-profile.children.cycles-pp.select_task_rq
     12.19            -6.0        6.17 ±  4%  perf-profile.children.cycles-pp.select_task_rq_fair
      9.91            -4.8        5.09 ±  4%  perf-profile.children.cycles-pp.select_idle_sibling
      9.27            -4.5        4.80 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
     12.49            -4.5        8.03        perf-profile.children.cycles-pp.cpuidle_idle_call
     11.41            -4.0        7.39        perf-profile.children.cycles-pp.cpuidle_enter_state
     11.44            -4.0        7.43        perf-profile.children.cycles-pp.cpuidle_enter
      8.17            -4.0        4.18 ±  4%  perf-profile.children.cycles-pp.select_idle_core
      5.76            -3.5        2.28 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.47            -3.1        2.35 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      4.30            -2.4        1.94 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      4.08            -2.2        1.90        perf-profile.children.cycles-pp.schedule_idle
      3.47            -2.2        1.30 ±  2%  perf-profile.children.cycles-pp.store_msg
      5.87            -2.1        3.78        perf-profile.children.cycles-pp.__pick_next_task
      4.84            -2.0        2.86        perf-profile.children.cycles-pp.try_to_block_task
      4.73            -1.9        2.79        perf-profile.children.cycles-pp.dequeue_entities
      4.73            -1.9        2.82        perf-profile.children.cycles-pp.dequeue_task_fair
      4.04            -1.8        2.26        perf-profile.children.cycles-pp._raw_spin_lock
      3.72            -1.7        2.03 ±  4%  perf-profile.children.cycles-pp.enqueue_task
      2.40            -1.6        0.85 ±  3%  perf-profile.children.cycles-pp._copy_to_user
      3.39            -1.5        1.86 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.56            -1.5        1.04 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      2.54            -1.5        1.03 ±  5%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      2.76            -1.4        1.34 ±  4%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      3.75            -1.4        2.34        perf-profile.children.cycles-pp.dequeue_entity
      2.32            -1.4        0.95 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.72            -1.3        1.38 ±  2%  perf-profile.children.cycles-pp.update_curr
      2.38            -1.3        1.06 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      4.24            -1.2        2.99        perf-profile.children.cycles-pp.pick_next_task_fair
      2.21            -1.1        1.15 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      1.76            -1.0        0.73 ±  3%  perf-profile.children.cycles-pp.msg_get
      1.67            -1.0        0.65 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.47            -1.0        1.47 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.39            -1.0        1.42        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      2.29            -1.0        1.32        perf-profile.children.cycles-pp.update_load_avg
      1.60            -1.0        0.64        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.51            -0.9        0.57 ±  5%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.84            -0.9        0.93 ±  6%  perf-profile.children.cycles-pp.wake_affine
      1.49            -0.9        0.59        perf-profile.children.cycles-pp.__check_object_size
      1.61            -0.9        0.72 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.73            -0.9        0.87 ±  2%  perf-profile.children.cycles-pp.update_se
      1.51            -0.9        0.65 ±  2%  perf-profile.children.cycles-pp.wakeup_preempt
      2.00            -0.8        1.15 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      1.26            -0.8        0.42 ±  3%  perf-profile.children.cycles-pp.__wake_up
      1.31            -0.7        0.58 ±  5%  perf-profile.children.cycles-pp.set_task_cpu
      1.15            -0.7        0.45 ±  3%  perf-profile.children.cycles-pp.msg_insert
      1.04            -0.7        0.35 ±  5%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      1.57            -0.7        0.90 ±  5%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.00            -0.7        0.34 ±  7%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.95            -0.7        0.29 ±  4%  perf-profile.children.cycles-pp.llist_reverse_order
      1.14            -0.6        0.50 ±  5%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.11            -0.6        0.51        perf-profile.children.cycles-pp.set_next_entity
      0.95            -0.6        0.39 ±  2%  perf-profile.children.cycles-pp.__update_idle_core
      1.04            -0.6        0.49 ±  2%  perf-profile.children.cycles-pp.pick_task_fair
      1.15            -0.6        0.60 ±  7%  perf-profile.children.cycles-pp.task_h_load
      0.84            -0.5        0.30 ±  5%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      1.06            -0.5        0.52        perf-profile.children.cycles-pp.set_next_task_idle
      1.04            -0.5        0.51        perf-profile.children.cycles-pp._find_next_bit
      1.28            -0.5        0.75        perf-profile.children.cycles-pp.__switch_to
      1.38            -0.5        0.85        perf-profile.children.cycles-pp.update_cfs_rq_load_avg
      0.85            -0.5        0.34 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.77 ±  4%      -0.5        0.25        perf-profile.children.cycles-pp.__bitmap_andnot
      0.88            -0.5        0.41 ±  6%  perf-profile.children.cycles-pp.update_entity_lag
      0.94            -0.5        0.48        perf-profile.children.cycles-pp.prepare_task_switch
      0.74            -0.4        0.31 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.75            -0.4        0.32 ±  5%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.80            -0.4        0.40        perf-profile.children.cycles-pp.wakeup_preempt_fair
      0.55            -0.4        0.16 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.57            -0.4        0.18 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.55            -0.4        0.17        perf-profile.children.cycles-pp.os_xsave
      0.58            -0.4        0.20        perf-profile.children.cycles-pp.sched_clock_cpu
      1.18            -0.4        0.81        perf-profile.children.cycles-pp.___task_rq_lock
      1.39            -0.4        1.01        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.51 ±  3%      -0.4        0.14 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.56            -0.4        0.19 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.51            -0.3        0.17 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.56            -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.simple_inode_init_ts
      0.89            -0.3        0.56        perf-profile.children.cycles-pp.put_prev_entity
      0.53 ±  3%      -0.3        0.21 ±  2%  perf-profile.children.cycles-pp.__put_user_4
      0.68 ± 12%      -0.3        0.36 ±  4%  perf-profile.children.cycles-pp.stress_switch_mq
      0.52            -0.3        0.20        perf-profile.children.cycles-pp.set_next_task_fair
      0.55            -0.3        0.24 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.51            -0.3        0.21 ±  3%  perf-profile.children.cycles-pp.inode_set_ctime_current
      0.56            -0.3        0.26 ±  3%  perf-profile.children.cycles-pp.fdget
      0.52            -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.mm_cid_switch_to
      0.54            -0.3        0.25 ±  3%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.79            -0.3        0.51        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.37            -0.3        0.11 ±  7%  perf-profile.children.cycles-pp.__resched_curr
      0.57            -0.2        0.32        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.35            -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
      0.62            -0.2        0.39 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.34            -0.2        0.11        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.58            -0.2        0.36        perf-profile.children.cycles-pp.__enqueue_entity
      0.46            -0.2        0.24        perf-profile.children.cycles-pp.__pick_eevdf
      0.52            -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.perf_tp_event
      0.35            -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.56            -0.2        0.36        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.33            -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.31 ±  2%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.58            -0.2        0.40        perf-profile.children.cycles-pp.menu_select
      0.32 ±  5%      -0.2        0.13        perf-profile.children.cycles-pp.__check_heap_object
      0.31            -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.place_entity
      0.32            -0.2        0.14        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.36            -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.29            -0.2        0.11        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.33            -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.35            -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.ktime_get
      0.25            -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.37            -0.2        0.20 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.23            -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.22            -0.2        0.07        perf-profile.children.cycles-pp.read_tsc
      0.21            -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.25            -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.strnlen
      0.32            -0.1        0.18        perf-profile.children.cycles-pp.__dequeue_entity
      0.23 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.23 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.53            -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.30 ±  3%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.20            -0.1        0.07        perf-profile.children.cycles-pp.__account_obj_stock
      0.31 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.41 ±  2%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.41            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28 ±  2%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.33            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.19 ±  2%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.wake_q_add_safe
      0.23 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.18            -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.56            -0.1        0.46        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.15            -0.1        0.05        perf-profile.children.cycles-pp._raw_spin_unlock
      0.17            -0.1        0.08        perf-profile.children.cycles-pp.security_msg_msg_free
      0.15            -0.1        0.06        perf-profile.children.cycles-pp.inode_set_ctime_to_ts
      0.16 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.dl_server_update
      0.13            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.timestamp_truncate
      0.15 ±  3%      -0.1        0.08        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.13 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.13 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.migrate_disable_switch
      0.12 ±  6%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.11 ±  4%      -0.1        0.05        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14            -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.10            -0.1        0.05        perf-profile.children.cycles-pp.ct_kernel_exit
      0.11            -0.1        0.06        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.10 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.rest_init
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.start_kernel
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.08 ± 10%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.mq_timedreceive
      0.15            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.vruntime_eligible
      0.13            -0.0        0.09        perf-profile.children.cycles-pp.put_prev_task_fair
      0.09            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.choose_new_asid
      0.13            -0.0        0.11        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.__set_next_task_fair
      0.76            -0.0        0.74        perf-profile.children.cycles-pp.finish_task_switch
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.propagate_entity_load_avg
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.clockevents_program_event
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.handle_softirqs
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.perf_swevent_event
      0.48            +0.0        0.49        perf-profile.children.cycles-pp.process_simple
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sched_update_worker
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.07 ± 11%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mq_timedsend
      0.15 ±  3%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__sched_balance_update_blocked_averages
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.detach_tasks
      0.00            +0.1        0.06 ± 29%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.06 ± 29%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.record__pushfn
      0.04 ± 71%      +0.1        0.12 ± 35%  perf-profile.children.cycles-pp.perf_mmap__push
      0.54 ±  2%      +0.1        0.62 ±  7%  perf-profile.children.cycles-pp.cmd_record
      0.04 ± 71%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.handle_internal_command
      0.04 ± 71%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.main
      0.04 ± 70%      +0.1        0.13 ± 32%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.04 ± 71%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.run_builtin
      0.10 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.do_perf_trace_sched_switch
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ct_idle_enter
      0.13 ±  3%      +0.2        0.29 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.21 ±  6%      +0.6        0.78 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.40 ±  3%      +0.7        1.08 ±  4%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.27 ±  6%      +0.7        0.97 ±  4%  perf-profile.children.cycles-pp.sched_balance_rq
      5.90            +0.9        6.81        perf-profile.children.cycles-pp.intel_idle
     35.82            +3.5       39.30        perf-profile.children.cycles-pp.__x64_sys_mq_timedreceive
     35.70            +3.5       39.25        perf-profile.children.cycles-pp.do_mq_timedreceive
      0.00            +8.8        8.78 ±  3%  perf-profile.children.cycles-pp.drain_obj_stock
     28.34           +13.4       41.76        perf-profile.children.cycles-pp.do_mq_timedsend
     28.52           +13.5       41.99        perf-profile.children.cycles-pp.__x64_sys_mq_timedsend
     70.76           +13.7       84.45        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.56           +13.8       84.39        perf-profile.children.cycles-pp.do_syscall_64
      0.08           +16.2       16.31 ±  4%  perf-profile.children.cycles-pp.__refill_obj_stock
      3.22           +20.1       23.33 ±  2%  perf-profile.children.cycles-pp.kfree
      3.01           +20.2       23.25 ±  2%  perf-profile.children.cycles-pp.free_msg
      2.46           +20.5       23.00 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.31           +25.9       28.25 ±  2%  perf-profile.children.cycles-pp.load_msg
      1.00           +26.8       27.81 ±  2%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.68           +27.0       27.65 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      6.79            -3.2        3.63 ±  5%  perf-profile.self.cycles-pp.select_idle_core
      3.07            -1.7        1.33 ±  4%  perf-profile.self.cycles-pp.do_mq_timedreceive
      2.90            -1.6        1.31 ±  3%  perf-profile.self.cycles-pp.__schedule
      2.37            -1.5        0.84 ±  3%  perf-profile.self.cycles-pp._copy_to_user
      2.73            -1.5        1.22 ±  3%  perf-profile.self.cycles-pp.do_mq_timedsend
      2.63            -1.4        1.25 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.64            -1.0        0.64 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.46            -0.9        0.55 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.54            -0.9        0.67 ±  6%  perf-profile.self.cycles-pp.update_rq_clock_task
      1.48            -0.9        0.62 ±  3%  perf-profile.self.cycles-pp.msg_get
      1.36            -0.8        0.58 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      1.11            -0.7        0.44 ±  4%  perf-profile.self.cycles-pp.msg_insert
      1.56            -0.7        0.90 ±  6%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.95            -0.7        0.29 ±  5%  perf-profile.self.cycles-pp.llist_reverse_order
      1.00            -0.7        0.34 ±  7%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      1.19            -0.6        0.59 ±  3%  perf-profile.self.cycles-pp.wq_sleep
      0.92            -0.6        0.36 ±  6%  perf-profile.self.cycles-pp.do_perf_trace_sched_wakeup_template
      0.90            -0.6        0.34 ±  2%  perf-profile.self.cycles-pp.__update_idle_core
      1.15            -0.5        0.60 ±  7%  perf-profile.self.cycles-pp.task_h_load
      0.83            -0.5        0.30 ±  5%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.97            -0.5        0.44 ±  2%  perf-profile.self.cycles-pp.dequeue_entities
      0.84            -0.5        0.34 ±  3%  perf-profile.self.cycles-pp.cpuacct_charge
      0.96            -0.5        0.47 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      1.23            -0.5        0.74        perf-profile.self.cycles-pp.__switch_to
      0.73 ±  4%      -0.5        0.24 ±  3%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.69            -0.5        0.20 ±  4%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.94            -0.5        0.47        perf-profile.self.cycles-pp._find_next_bit
      0.77            -0.4        0.36 ±  6%  perf-profile.self.cycles-pp.update_entity_lag
      0.76            -0.4        0.36 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.67            -0.4        0.27 ±  5%  perf-profile.self.cycles-pp.__smp_call_single_queue
      0.70            -0.4        0.31 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.55            -0.4        0.17 ±  2%  perf-profile.self.cycles-pp.os_xsave
      0.56            -0.4        0.18 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.63            -0.4        0.25        perf-profile.self.cycles-pp.switch_fpu_return
      1.38            -0.4        1.01        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.53            -0.4        0.16        perf-profile.self.cycles-pp.native_sched_clock
      0.69            -0.4        0.33 ±  5%  perf-profile.self.cycles-pp.wake_affine
      0.67            -0.4        0.30 ±  2%  perf-profile.self.cycles-pp.kfree
      0.75            -0.4        0.39 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.67            -0.4        0.31 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.53            -0.4        0.18 ±  2%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.49 ±  2%      -0.4        0.14 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.63            -0.3        0.28 ±  3%  perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
      0.58            -0.3        0.23 ±  4%  perf-profile.self.cycles-pp.select_idle_sibling
      0.58            -0.3        0.24 ±  7%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.64            -0.3        0.31        perf-profile.self.cycles-pp.prepare_task_switch
      0.82            -0.3        0.49 ±  3%  perf-profile.self.cycles-pp.select_idle_cpu
      0.52 ±  3%      -0.3        0.21 ±  2%  perf-profile.self.cycles-pp.__put_user_4
      0.63 ± 11%      -0.3        0.32 ±  5%  perf-profile.self.cycles-pp.stress_switch_mq
      0.54            -0.3        0.24 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.54            -0.3        0.25 ±  3%  perf-profile.self.cycles-pp.fdget
      0.51            -0.3        0.22 ±  4%  perf-profile.self.cycles-pp.mm_cid_switch_to
      0.44            -0.3        0.15 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.43            -0.3        0.15 ±  5%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.49            -0.3        0.23 ±  6%  perf-profile.self.cycles-pp.enqueue_task
      0.59            -0.2        0.34 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.73            -0.2        0.48        perf-profile.self.cycles-pp.update_cfs_rq_load_avg
      0.35            -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.__resched_curr
      0.40            -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.__pick_next_task
      0.36            -0.2        0.12 ±  3%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.34            -0.2        0.11        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.57            -0.2        0.36        perf-profile.self.cycles-pp.__enqueue_entity
      0.51            -0.2        0.31        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.34            -0.2        0.14 ±  5%  perf-profile.self.cycles-pp.wakeup_preempt
      0.34            -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.39            -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.do_idle
      0.31 ±  5%      -0.2        0.11        perf-profile.self.cycles-pp.__check_heap_object
      0.37            -0.2        0.17 ±  2%  perf-profile.self.cycles-pp.check_heap_object
      0.51            -0.2        0.32        perf-profile.self.cycles-pp.schedule
      0.36            -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.__pick_eevdf
      0.29 ±  2%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.61            -0.2        0.43        perf-profile.self.cycles-pp.dequeue_entity
      0.30            -0.2        0.12        perf-profile.self.cycles-pp.__update_load_avg_se
      0.27            -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.25            -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.26            -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.place_entity
      0.45            -0.2        0.30 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.44            -0.2        0.29 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.24            -0.2        0.09        perf-profile.self.cycles-pp.wake_up_q
      0.24            -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.22 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.32            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.21 ±  2%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.read_tsc
      0.20            -0.1        0.06        perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.36            -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
      0.28            -0.1        0.14        perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.24            -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.strnlen
      0.21            -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.load_msg
      0.33            -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.44            -0.1        0.33        perf-profile.self.cycles-pp.menu_select
      0.41            -0.1        0.29        perf-profile.self.cycles-pp.update_se
      0.17 ±  2%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.27            -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.select_task_rq
      0.23 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.19            -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.20 ±  2%      -0.1        0.09        perf-profile.self.cycles-pp.check_stack_object
      0.18 ±  2%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.wake_q_add_safe
      0.18            -0.1        0.07        perf-profile.self.cycles-pp.__account_obj_stock
      0.21 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__kmalloc_cache_noprof
      0.24            -0.1        0.14        perf-profile.self.cycles-pp.__dequeue_entity
      0.19            -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.pick_task_fair
      0.14 ±  3%      -0.1        0.05        perf-profile.self.cycles-pp.inode_set_ctime_current
      0.16 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.15            -0.1        0.06        perf-profile.self.cycles-pp.avg_vruntime
      0.16            -0.1        0.07        perf-profile.self.cycles-pp.schedule_idle
      0.15            -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.dl_server_update
      0.15            -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.12 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_mq_timedreceive
      0.12            -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.migrate_disable_switch
      0.13            -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.___task_rq_lock
      0.09 ±  5%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.inode_set_ctime_to_ts
      0.22            -0.1        0.16        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.12            -0.1        0.06        perf-profile.self.cycles-pp.store_msg
      0.12            -0.1        0.06        perf-profile.self.cycles-pp.wakeup_preempt_fair
      0.11 ±  4%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.11            -0.1        0.05        perf-profile.self.cycles-pp.timestamp_truncate
      0.12 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.do_perf_trace_sched_stat_runtime
      0.11 ±  4%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.13 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.update_curr_dl_se
      0.15            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.09            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.vruntime_eligible
      0.14 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.ktime_get
      0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__set_next_task_fair
      0.15 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.put_prev_entity
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.set_next_task_idle
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.perf_swevent_event
      0.07 ±  7%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.mq_timedsend
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ct_idle_enter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.sched_update_worker
      0.12            +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.x64_sys_call
      0.38 ±  2%      +0.1        0.46        perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  5%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.do_perf_trace_sched_switch
      0.18 ±  5%      +0.5        0.71 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      5.89            +0.9        6.81        perf-profile.self.cycles-pp.intel_idle
      0.07            +7.4        7.48 ±  4%  perf-profile.self.cycles-pp.__refill_obj_stock
      0.00            +8.7        8.70 ±  3%  perf-profile.self.cycles-pp.drain_obj_stock
      2.25           +12.4       14.61        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.53           +19.0       19.48        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook


***************************************************************************************************

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/300s/lkp-icl-2sp9/spawn/unixbench

commit: 
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")

8285917d6f383aef 01b9da291c4969354807b52956f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12631            -3.8%      12146        unixbench.score
    159157            -3.8%     153044        unixbench.throughput
  19807234            -4.8%   18852799        unixbench.time.involuntary_context_switches
 1.413e+09            -3.9%  1.357e+09        unixbench.time.minor_page_faults
      8608            +2.8%       8852        unixbench.time.system_time
      6616            -2.4%       6458        unixbench.time.user_time
  94616535            -4.1%   90778327        unixbench.time.voluntary_context_switches
  52575303            -3.9%   50543226        unixbench.workload
   1110579            +8.8%    1208410 ±  2%  meminfo.AnonPages
    210425           -12.6%     183972 ±  5%  meminfo.DirectMap4k
      0.05 ±  4%      +0.0        0.06 ±  2%  mpstat.cpu.all.iowait%
      1.51            +0.4        1.93        mpstat.cpu.all.soft%
    557785 ± 44%     +49.6%     834357 ± 25%  numa-meminfo.node0.AnonPages.max
    736507 ±  5%      +8.1%     796466 ±  3%  numa-meminfo.node1.Mapped
 6.802e+08            -5.2%  6.446e+08        numa-numastat.node0.local_node
 6.804e+08            -5.3%  6.445e+08        numa-numastat.node0.numa_hit
      0.04            +7.1%       0.05        perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.04            +7.1%       0.05        perf-sched.total_sch_delay.average.ms
     23.64            -0.9       22.72        turbostat.C1%
     22.97 ± 10%      -5.2       17.74 ±  5%  turbostat.PKG_%
 6.804e+08            -5.3%  6.445e+08        numa-vmstat.node0.numa_hit
 6.802e+08            -5.2%  6.446e+08        numa-vmstat.node0.numa_local
    184186 ±  5%      +8.2%     199205 ±  3%  numa-vmstat.node1.nr_mapped
      0.03 ± 67%    +680.5%       0.22 ± 62%  vmstat.procs.b
    564221            -3.9%     542439        vmstat.system.cs
    380977            -2.6%     371055        vmstat.system.in
    769143            +1.6%     781758        proc-vmstat.nr_active_anon
    277665            +8.8%     302174 ±  2%  proc-vmstat.nr_anon_pages
     30969            -3.5%      29900        proc-vmstat.nr_page_table_pages
    491673            -2.4%     479782        proc-vmstat.nr_shmem
     57770            -1.0%      57209        proc-vmstat.nr_slab_unreclaimable
    769143            +1.6%     781758        proc-vmstat.nr_zone_active_anon
    252183 ± 14%     +35.3%     341208 ± 18%  proc-vmstat.numa_hint_faults
 1.254e+09            -3.8%  1.207e+09        proc-vmstat.numa_hit
 1.254e+09            -3.8%  1.207e+09        proc-vmstat.numa_local
    317222 ± 15%     +38.4%     438924 ± 20%  proc-vmstat.numa_pte_updates
 1.338e+09            -3.8%  1.287e+09        proc-vmstat.pgalloc_normal
 1.415e+09            -3.9%  1.359e+09        proc-vmstat.pgfault
 1.337e+09            -3.8%  1.286e+09        proc-vmstat.pgfree
 1.598e+08            -4.1%  1.533e+08        proc-vmstat.pgreuse
    482323 ±  4%     +17.7%     567902 ±  7%  sched_debug.cfs_rq:/.left_deadline.avg
   1301805 ±  3%     +10.2%    1435059 ±  3%  sched_debug.cfs_rq:/.left_deadline.stddev
    482320 ±  4%     +17.7%     567899 ±  7%  sched_debug.cfs_rq:/.left_vruntime.avg
   1301796 ±  3%     +10.2%    1435050 ±  3%  sched_debug.cfs_rq:/.left_vruntime.stddev
    135389 ±  2%     +23.4%     167033 ±  6%  sched_debug.cfs_rq:/.load.avg
    327477           +12.0%     366681 ±  5%  sched_debug.cfs_rq:/.load.stddev
    482320 ±  4%     +17.7%     567899 ±  7%  sched_debug.cfs_rq:/.right_vruntime.avg
   1301796 ±  3%     +10.2%    1435050 ±  3%  sched_debug.cfs_rq:/.right_vruntime.stddev
      0.02 ±  9%    +262.4%       0.06 ± 56%  sched_debug.cfs_rq:/.spread.avg
      0.92 ± 28%    +264.8%       3.37 ± 57%  sched_debug.cfs_rq:/.spread.max
      0.12 ± 21%    +260.0%       0.43 ± 57%  sched_debug.cfs_rq:/.spread.stddev
    405099 ±  2%      +6.3%     430541 ±  4%  sched_debug.cpu.avg_idle.max
   1430164            -4.9%    1359536        sched_debug.cpu.nr_switches.max
     90912 ±  2%     -12.6%      79477 ±  9%  sched_debug.cpu.nr_switches.stddev
 1.418e+10            -2.4%  1.385e+10        perf-stat.i.branch-instructions
  88090016            -2.4%   86013654        perf-stat.i.branch-misses
     27.32            +0.5       27.79        perf-stat.i.cache-miss-rate%
 3.981e+08            -2.5%  3.882e+08        perf-stat.i.cache-misses
 1.414e+09            -3.9%  1.359e+09        perf-stat.i.cache-references
    570181            -3.7%     548874        perf-stat.i.context-switches
      2.41            +4.0%       2.50        perf-stat.i.cpi
  1.81e+11            +1.2%  1.833e+11        perf-stat.i.cpu-cycles
    109140            -4.5%     104200        perf-stat.i.cpu-migrations
 7.268e+10            -2.4%  7.092e+10        perf-stat.i.instructions
    143.18            -3.7%     137.84        perf-stat.i.metric.K/sec
   4249150            -3.6%    4095509        perf-stat.i.minor-faults
   4249372            -3.6%    4095721        perf-stat.i.page-faults
     27.38            +0.5       27.93        perf-stat.overall.cache-miss-rate%
      2.41            +4.1%       2.51        perf-stat.overall.cpi
    456.68            +3.6%     473.23        perf-stat.overall.cycles-between-cache-misses
      0.41            -3.9%       0.40        perf-stat.overall.ipc
    468146            +1.0%     472826        perf-stat.overall.path-length
 1.426e+10            -2.6%   1.39e+10        perf-stat.ps.branch-instructions
  85809605            -2.2%   83901451        perf-stat.ps.branch-misses
 3.912e+08            -2.3%  3.822e+08        perf-stat.ps.cache-misses
 1.429e+09            -4.2%  1.368e+09        perf-stat.ps.cache-references
    567141            -3.8%     545697        perf-stat.ps.context-switches
    106475            -4.1%     102109        perf-stat.ps.cpu-migrations
 7.401e+10            -2.7%  7.198e+10        perf-stat.ps.instructions
   4240337            -3.8%    4081092        perf-stat.ps.minor-faults
   4240545            -3.8%    4081293        perf-stat.ps.page-faults
 2.461e+13            -2.9%   2.39e+13        perf-stat.total.instructions
     18.76            -1.1       17.70        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     17.73            -1.0       16.72        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     17.66            -1.0       16.66        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     16.03 ±  2%      -0.9       15.10 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.61 ±  2%      -0.9       14.70 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     10.73 ±  2%      -0.8        9.96 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     10.75 ±  2%      -0.8        9.98 ±  3%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     10.38 ±  3%      -0.7        9.64 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.53            -0.6        0.92        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      3.01            -0.1        2.86        perf-profile.calltrace.cycles-pp.common_startup_64
      2.96            -0.1        2.81        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.96            -0.1        2.82        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      2.96            -0.1        2.82        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      2.82            -0.1        2.70        perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      1.72 ±  2%      -0.1        1.60 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.41 ±  2%      -0.1        1.29 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault.do_fault
      1.83            -0.1        1.72        perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.82            -0.1        1.71        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.do_syscall_64
      2.13            -0.1        2.04        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.96            -0.1        1.87        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.94            -0.1        1.85        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.29            -0.1        1.20        perf-profile.calltrace.cycles-pp.do_wp_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.87            -0.1        1.79        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.86            -0.1        1.78        perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.86            -0.1        1.78        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.43            -0.1        1.35        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      2.09            -0.1        2.01        perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm
      1.08 ±  2%      -0.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.__percpu_counter_init_many.mm_init.dup_mm.copy_process.kernel_clone
      1.26            -0.1        1.20        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      1.16            -0.1        1.10        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.88 ±  2%      -0.1        0.82        perf-profile.calltrace.cycles-pp.lru_add_drain.do_wp_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.87            -0.1        0.82        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.do_wp_page.__handle_mm_fault.handle_mm_fault
      0.91 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.dup_mm.copy_process
      0.86            -0.1        0.80        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.do_wp_page.__handle_mm_fault
      1.10            -0.1        1.05        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.25            -0.1        1.20        perf-profile.calltrace.cycles-pp.__vma_start_write.dup_mmap.dup_mm.copy_process.kernel_clone
      2.11            -0.1        2.06        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            -0.1        0.67        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.87            -0.0        0.82        perf-profile.calltrace.cycles-pp.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.14            -0.0        1.10        perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      0.85            -0.0        0.80 ±  2%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.79            -0.0        0.74        perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.__schedule.schedule.do_wait
      0.71            -0.0        0.66        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.88            -0.0        0.83        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_wait.kernel_wait4
      1.00            -0.0        0.96        perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.81            -0.0        0.76        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault
      0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2.05            -0.0        2.01        perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.82            -0.0        0.78        perf-profile.calltrace.cycles-pp.__vmalloc_node_noprof.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      0.82            -0.0        0.78        perf-profile.calltrace.cycles-pp.__vmalloc_node_range_noprof.__vmalloc_node_noprof.alloc_thread_stack_node.dup_task_struct.copy_process
      3.37            -0.0        3.33        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.65            -0.0        0.61        perf-profile.calltrace.cycles-pp.sched_move_task.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.10            -0.0        1.07        perf-profile.calltrace.cycles-pp.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.61            -0.0        0.58        perf-profile.calltrace.cycles-pp.__vma_start_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.56            -0.0        0.52        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.57            -0.0        0.54        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.do_notify_parent.exit_notify.do_exit.do_group_exit
      0.55            -0.0        0.51        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.do_notify_parent.exit_notify.do_exit
      0.88            -0.0        0.85        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__put_user_4.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.61            -0.0        0.58        perf-profile.calltrace.cycles-pp.__vma_start_exclude_readers.__vma_start_write.dup_mmap.dup_mm.copy_process
      0.61            -0.0        0.58        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.66            -0.0        0.63        perf-profile.calltrace.cycles-pp.do_notify_parent.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      0.71            -0.0        0.68        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__put_user_4.schedule_tail.ret_from_fork
      1.67            -0.0        1.65        perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      0.76            -0.0        0.73        perf-profile.calltrace.cycles-pp.__put_user_4.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.55            -0.0        0.52        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof.alloc_thread_stack_node.dup_task_struct
      0.54            -0.0        0.51        perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      0.81            -0.0        0.78        perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      0.70            -0.0        0.67        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__put_user_4.schedule_tail
      0.96            -0.0        0.94        perf-profile.calltrace.cycles-pp.alloc_pages_noprof.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range
      0.67            -0.0        0.66        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc.copy_p4d_range
      1.07            +0.0        1.09        perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2.04            +0.0        2.07        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.74            +0.0        0.77        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.dup_mmap.dup_mm.copy_process
      0.63            +0.0        0.67        perf-profile.calltrace.cycles-pp.__pud_alloc.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.76            +0.0        0.79        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.dup_mmap.dup_mm.copy_process.kernel_clone
      0.73            +0.0        0.76        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.dup_mmap.dup_mm
      1.10            +0.0        1.15        perf-profile.calltrace.cycles-pp.tear_down_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.06            +0.1        1.12        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.76            +0.1        0.84        perf-profile.calltrace.cycles-pp.kmem_cache_free.tear_down_vmas.exit_mmap.__mmput.exit_mm
      0.63            +0.1        0.75        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.72            +0.1        0.84        perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.64            +0.1        0.77        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm.copy_process
      4.77 ±  2%      +0.4        5.18 ±  2%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait.do_wait
      4.43 ±  2%      +0.4        4.84 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait
      0.20 ±141%      +0.4        0.62 ± 11%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.20 ±141%      +0.4        0.63 ± 11%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.21 ±141%      +0.4        0.64 ± 11%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.cmd_record
      4.85 ±  2%      +0.5        5.30 ±  2%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.53 ±  2%      +0.5        4.99 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone
      5.04 ±  2%      +0.5        5.53 ±  2%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      4.71 ±  2%      +0.5        5.21 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.tear_down_vmas.exit_mmap.__mmput
      6.04 ±  2%      +0.5        6.56 ±  2%  perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.do_syscall_64
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap
      5.87 ±  2%      +0.5        6.40 ±  2%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.98 ±  2%      +0.5        6.52 ±  2%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      8.83 ±  2%      +0.8        9.60 ±  2%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4.do_syscall_64
      8.28 ±  2%      +0.8        9.06 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4
     17.04 ±  2%      +1.2       18.22        perf-profile.calltrace.cycles-pp.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.99 ±  2%      +1.2       18.17        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.10 ±  2%      +1.3       16.39 ±  2%  perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.62            +1.3       72.94        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.65            +1.3       72.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     20.02            -1.1       18.89        perf-profile.children.cycles-pp.asm_exc_page_fault
     18.66            -1.0       17.61        perf-profile.children.cycles-pp.exc_page_fault
     18.57            -1.0       17.52        perf-profile.children.cycles-pp.do_user_addr_fault
     16.63 ±  2%      -1.0       15.67 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     16.14 ±  2%      -0.9       15.22 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
     10.73 ±  3%      -0.8        9.96 ±  3%  perf-profile.children.cycles-pp.do_read_fault
     10.75 ±  3%      -0.8        9.98 ±  3%  perf-profile.children.cycles-pp.do_fault
     10.44 ±  3%      -0.7        9.70 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      3.64            -0.2        3.44        perf-profile.children.cycles-pp.__schedule
      2.34            -0.2        2.14        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.01            -0.2        2.86        perf-profile.children.cycles-pp.do_idle
      3.01            -0.1        2.86        perf-profile.children.cycles-pp.common_startup_64
      3.01            -0.1        2.86        perf-profile.children.cycles-pp.cpu_startup_entry
      2.96            -0.1        2.82        perf-profile.children.cycles-pp.start_secondary
      2.83            -0.1        2.71        perf-profile.children.cycles-pp.mm_init
      1.76            -0.1        1.64 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      1.44 ±  2%      -0.1        1.32 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      1.96            -0.1        1.85        perf-profile.children.cycles-pp.schedule
      2.22            -0.1        2.11 ±  2%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      2.17            -0.1        2.07        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.25            -0.1        2.15        perf-profile.children.cycles-pp.get_page_from_freelist
      1.81            -0.1        1.71        perf-profile.children.cycles-pp.__mmdrop
      2.20            -0.1        2.10        perf-profile.children.cycles-pp.finish_task_switch
      1.98            -0.1        1.88        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.00            -0.1        1.90        perf-profile.children.cycles-pp.cpuidle_enter
      1.91            -0.1        1.82        perf-profile.children.cycles-pp.acpi_idle_enter
      1.65            -0.1        1.56        perf-profile.children.cycles-pp.select_task_rq_fair
      1.87            -0.1        1.78        perf-profile.children.cycles-pp.__vma_start_write
      1.89            -0.1        1.80        perf-profile.children.cycles-pp.pv_native_safe_halt
      1.89            -0.1        1.81        perf-profile.children.cycles-pp.acpi_idle_do_entry
      1.34            -0.1        1.25        perf-profile.children.cycles-pp.do_wp_page
      1.22            -0.1        1.14        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.89            -0.1        1.81        perf-profile.children.cycles-pp.acpi_safe_halt
      3.56            -0.1        3.48        perf-profile.children.cycles-pp.alloc_pages_mpol
      1.19            -0.1        1.11        perf-profile.children.cycles-pp.folio_batch_move_lru
      2.09            -0.1        2.01        perf-profile.children.cycles-pp.schedule_tail
      1.08 ±  2%      -0.1        1.01        perf-profile.children.cycles-pp.__percpu_counter_init_many
      1.10            -0.1        1.03        perf-profile.children.cycles-pp.its_return_thunk
      3.45            -0.1        3.38        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.64            -0.1        0.57        perf-profile.children.cycles-pp.__slab_free
      0.88            -0.1        0.81        perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.89            -0.1        0.82        perf-profile.children.cycles-pp.refill_objects
      1.27            -0.1        1.20        perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.89            -0.1        0.82        perf-profile.children.cycles-pp.__refill_objects_node
      1.32 ±  2%      -0.1        1.26        perf-profile.children.cycles-pp.__pick_next_task
      1.25 ±  2%      -0.1        1.18        perf-profile.children.cycles-pp.pick_next_task_fair
      3.17            -0.1        3.11        perf-profile.children.cycles-pp.alloc_pages_noprof
      1.19            -0.1        1.13        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.88 ±  2%      -0.1        0.82        perf-profile.children.cycles-pp.lru_add_drain
      1.03            -0.1        0.97        perf-profile.children.cycles-pp.memset_orig
      0.87            -0.1        0.82        perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.00 ±  2%      -0.1        0.94 ±  2%  perf-profile.children.cycles-pp.__page_cache_release
      0.86 ±  2%      -0.1        0.80        perf-profile.children.cycles-pp.dequeue_task_fair
      1.11            -0.1        1.06        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.95            -0.1        0.89 ±  2%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.84 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.dequeue_entities
      0.68            -0.1        0.63        perf-profile.children.cycles-pp.free_frozen_page_commit
      0.81            -0.1        0.76        perf-profile.children.cycles-pp.rmqueue
      0.86            -0.0        0.81        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.67 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.dequeue_entity
      0.73            -0.0        0.68        perf-profile.children.cycles-pp.schedule_idle
      0.92            -0.0        0.87 ±  2%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      1.26            -0.0        1.21        perf-profile.children.cycles-pp.kernel_init_pages
      0.89            -0.0        0.85        perf-profile.children.cycles-pp.native_irq_return_iret
      0.40            -0.0        0.36        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.99            -0.0        0.95        perf-profile.children.cycles-pp.__vma_start_exclude_readers
      1.14            -0.0        1.10        perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.28 ±  7%      -0.0        0.24 ±  7%  perf-profile.children.cycles-pp.callchain_cursor_reset
      2.11            -0.0        2.06        perf-profile.children.cycles-pp.wake_up_new_task
      0.97            -0.0        0.93        perf-profile.children.cycles-pp.__put_user_4
      0.48            -0.0        0.44        perf-profile.children.cycles-pp.try_charge_memcg
      0.82            -0.0        0.78        perf-profile.children.cycles-pp.__vmalloc_node_noprof
      2.06            -0.0        2.02        perf-profile.children.cycles-pp.copy_pte_range
      0.13            -0.0        0.09        perf-profile.children.cycles-pp.trylock_stock
      0.55            -0.0        0.51        perf-profile.children.cycles-pp.free_pcppages_bulk
      0.55            -0.0        0.52 ±  2%  perf-profile.children.cycles-pp.free_percpu
      0.81 ±  2%      -0.0        0.78        perf-profile.children.cycles-pp.sync_regs
      0.82            -0.0        0.78        perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.65            -0.0        0.61        perf-profile.children.cycles-pp.sched_move_task
      0.61            -0.0        0.57        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.51            -0.0        0.48        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.68            -0.0        0.64        perf-profile.children.cycles-pp.copy_present_ptes
      0.51            -0.0        0.48        perf-profile.children.cycles-pp.delayed_vfree_work
      0.73            -0.0        0.70        perf-profile.children.cycles-pp.enqueue_task
      0.56            -0.0        0.52        perf-profile.children.cycles-pp.process_one_work
      0.49            -0.0        0.46        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.__wake_up_common
      0.70            -0.0        0.66        perf-profile.children.cycles-pp.enqueue_task_fair
      3.37            -0.0        3.33        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.67            -0.0        0.63        perf-profile.children.cycles-pp.do_notify_parent
      0.17 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.49            -0.0        0.46        perf-profile.children.cycles-pp.vfree
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.try_to_wake_up
      0.70            -0.0        0.66        perf-profile.children.cycles-pp.pte_offset_map_lock
      0.61            -0.0        0.58        perf-profile.children.cycles-pp.worker_thread
      0.54            -0.0        0.51        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.___free_pages
      0.44            -0.0        0.41        perf-profile.children.cycles-pp.mas_find
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.48 ±  2%      -0.0        0.45        perf-profile.children.cycles-pp.try_to_block_task
      0.45            -0.0        0.42        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.38            -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.percpu_counter_destroy_many
      0.23 ±  4%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.20 ±  4%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.47            -0.0        0.44        perf-profile.children.cycles-pp.__mod_memcg_state
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.ptep_clear_flush
      0.37            -0.0        0.35        perf-profile.children.cycles-pp.__folio_batch_add_and_move
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.rseq_set_ids_get_csaddr
      0.49            -0.0        0.47        perf-profile.children.cycles-pp.update_load_avg
      0.53            -0.0        0.50        perf-profile.children.cycles-pp.enqueue_entity
      0.28 ±  2%      -0.0        0.26        perf-profile.children.cycles-pp.lru_gen_del_folio
      0.55            -0.0        0.52        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.55            -0.0        0.52        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.46            -0.0        0.43        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      1.67            -0.0        1.65        perf-profile.children.cycles-pp.dup_task_struct
      0.35            -0.0        0.32        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.24 ±  3%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.43            -0.0        0.41        perf-profile.children.cycles-pp.__perf_sw_event
      0.33            -0.0        0.31        perf-profile.children.cycles-pp.mas_next_slot
      0.36            -0.0        0.34        perf-profile.children.cycles-pp.ttwu_do_activate
      0.36            -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.38 ±  2%      -0.0        0.36        perf-profile.children.cycles-pp.sched_change_begin
      0.36            -0.0        0.34        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.42            -0.0        0.40        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.26            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__rseq_handle_slowpath
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.mas_walk
      0.27            -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.remove_vm_area
      0.44            -0.0        0.42        perf-profile.children.cycles-pp.vm_area_alloc_pages
      0.24            -0.0        0.22 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.27            -0.0        0.26        perf-profile.children.cycles-pp.perf_event_task
      0.40            -0.0        0.39        perf-profile.children.cycles-pp.flush_tlb_func
      0.29            -0.0        0.28        perf-profile.children.cycles-pp.handle_pte_fault
      0.29            -0.0        0.28        perf-profile.children.cycles-pp.mas_store
      0.31            -0.0        0.30        perf-profile.children.cycles-pp.lru_add
      0.23 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.28            -0.0        0.26        perf-profile.children.cycles-pp.__pi_memcpy
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.free_unref_folios
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.map_symbol__copy
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.update_cfs_rq_load_avg
      0.20            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.16            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.07            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.put_cred_rcu
      0.23            -0.0        0.22        perf-profile.children.cycles-pp.select_task_rq
      0.19            -0.0        0.18        perf-profile.children.cycles-pp._find_next_or_bit
      0.20            -0.0        0.19        perf-profile.children.cycles-pp.add_device_randomness
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.filp_close
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.free_swap_cache
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.___task_rq_lock
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.__mt_destroy
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.14            -0.0        0.13        perf-profile.children.cycles-pp._find_next_and_bit
      0.09            -0.0        0.08        perf-profile.children.cycles-pp._raw_spin_unlock
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.cgroup_task_dead
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.exit_fs
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.select_idle_sibling
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.get_free_pages_noprof
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.mod_node_page_state
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.set_task_cpu
      0.21            -0.0        0.20        perf-profile.children.cycles-pp.memcpy_and_pad
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.memcg_charge_kernel_stack
      0.11 ±  4%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.pgd_free
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.exit_task_stack_account
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      1.07            +0.0        1.09        perf-profile.children.cycles-pp.__pte_alloc
      1.30            +0.0        1.32        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.03            +0.0        1.05        perf-profile.children.cycles-pp.pte_alloc_one
      0.49            +0.0        0.50        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      2.05            +0.0        2.08        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.64            +0.0        0.67        perf-profile.children.cycles-pp.__pud_alloc
      0.75            +0.0        0.78        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.74            +0.0        0.78        perf-profile.children.cycles-pp.smp_call_function_many_cond
      1.12            +0.1        1.17        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      1.11            +0.1        1.16        perf-profile.children.cycles-pp.tear_down_vmas
      0.26            +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__exit_signal
      1.92            +0.1        1.97        perf-profile.children.cycles-pp._raw_spin_lock
      1.06            +0.1        1.12        perf-profile.children.cycles-pp.kthread
      0.27            +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__put_task_struct
      0.48            +0.1        0.54        perf-profile.children.cycles-pp.__account_obj_stock
      0.10            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.lru_gen_del_mm
      0.10 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.lru_gen_add_mm
      0.44            +0.1        0.54        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.43            +0.1        0.52        perf-profile.children.cycles-pp.run_ksoftirqd
      0.07 ±  7%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.put_pid
      0.73            +0.1        0.86        perf-profile.children.cycles-pp.vm_area_dup
      0.30 ±  2%      +0.1        0.43        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.84            +0.1        0.98        perf-profile.children.cycles-pp.__free_frozen_pages
      0.23 ±  3%      +0.1        0.37 ±  2%  perf-profile.children.cycles-pp.__folio_mod_stat
      0.46 ± 24%      +0.2        0.64 ± 11%  perf-profile.children.cycles-pp.process_simple
      0.45 ± 24%      +0.2        0.63 ± 11%  perf-profile.children.cycles-pp.ordered_events__queue
      0.45 ± 26%      +0.2        0.62 ± 11%  perf-profile.children.cycles-pp.queue_event
      2.28            +0.2        2.46        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.15 ±  3%      +0.2        0.35 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.00            +0.2        0.23 ±  6%  perf-profile.children.cycles-pp.drain_obj_stock
      0.59 ±  2%      +0.3        0.87 ±  2%  perf-profile.children.cycles-pp._raw_write_unlock_irq
      1.13            +0.3        1.41        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.13            +0.4        0.53 ±  3%  perf-profile.children.cycles-pp.__refill_obj_stock
      1.09            +0.4        1.53        perf-profile.children.cycles-pp.tlb_remove_table_rcu
      6.04 ±  2%      +0.5        6.56 ±  2%  perf-profile.children.cycles-pp.wait_task_zombie
      5.87 ±  2%      +0.5        6.40 ±  2%  perf-profile.children.cycles-pp.release_task
      5.98 ±  2%      +0.5        6.52 ±  2%  perf-profile.children.cycles-pp.exit_notify
      2.17            +0.6        2.77        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.11            +0.6        2.71        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.77            +0.6        2.37        perf-profile.children.cycles-pp.__irq_exit_rcu
      2.18            +0.6        2.82        perf-profile.children.cycles-pp.kmem_cache_free
      2.18            +0.7        2.88        perf-profile.children.cycles-pp.handle_softirqs
      2.06            +0.7        2.76        perf-profile.children.cycles-pp.rcu_core
      2.03            +0.7        2.74        perf-profile.children.cycles-pp.rcu_do_batch
      1.21            +0.7        1.95        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.64 ±  2%      +0.8        1.39        perf-profile.children.cycles-pp.lruvec_stat_mod_folio
      8.83 ±  2%      +0.8        9.60 ±  2%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
     17.04 ±  2%      +1.2       18.22        perf-profile.children.cycles-pp.kernel_wait4
     16.99 ±  2%      +1.2       18.17        perf-profile.children.cycles-pp.do_wait
     15.10 ±  2%      +1.3       16.39 ±  2%  perf-profile.children.cycles-pp.__do_wait
     71.84            +1.3       73.15        perf-profile.children.cycles-pp.do_syscall_64
     71.88            +1.3       73.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.66 ±  2%      +1.4       16.02 ±  2%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
     23.80 ±  2%      +2.1       25.86 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.60 ±  3%      -0.5        6.10 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.53 ±  2%      -0.1        1.38 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      1.40 ±  2%      -0.1        1.28 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      1.19            -0.1        1.12        perf-profile.self.cycles-pp.pv_native_safe_halt
      1.00            -0.1        0.93        perf-profile.self.cycles-pp.memset_orig
      0.83            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.__refill_objects_node
      1.00            -0.1        0.95        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.42            -0.1        0.36        perf-profile.self.cycles-pp.try_charge_memcg
      0.54            -0.1        0.49        perf-profile.self.cycles-pp.__slab_free
      0.95            -0.1        0.90        perf-profile.self.cycles-pp.down_write
      0.39            -0.1        0.34        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.90            -0.1        0.85        perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.60            -0.0        0.55        perf-profile.self.cycles-pp.its_return_thunk
      0.93            -0.0        0.88        perf-profile.self.cycles-pp.__vma_start_exclude_readers
      1.23            -0.0        1.18        perf-profile.self.cycles-pp.kernel_init_pages
      0.89            -0.0        0.85        perf-profile.self.cycles-pp.native_irq_return_iret
      0.78            -0.0        0.74        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.86            -0.0        0.81 ±  2%  perf-profile.self.cycles-pp.__vma_start_write
      0.81            -0.0        0.77        perf-profile.self.cycles-pp.sync_regs
      0.65            -0.0        0.61        perf-profile.self.cycles-pp.copy_present_ptes
      0.61            -0.0        0.57        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.91            -0.0        0.88        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.48            -0.0        1.45        perf-profile.self.cycles-pp._raw_spin_lock
      0.41            -0.0        0.38        perf-profile.self.cycles-pp.do_wp_page
      0.16            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.___free_pages
      0.43            -0.0        0.40        perf-profile.self.cycles-pp.__mod_memcg_state
      0.33            -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.tlb_remove_table_rcu
      0.19 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.52            -0.0        0.50        perf-profile.self.cycles-pp.anon_vma_fork
      0.33            -0.0        0.30        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.24            -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.21 ±  2%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.19 ±  4%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.53            -0.0        0.51        perf-profile.self.cycles-pp.zap_pte_range
      0.27            -0.0        0.25        perf-profile.self.cycles-pp.mas_next_slot
      0.22 ±  3%      -0.0        0.20        perf-profile.self.cycles-pp.lru_gen_del_folio
      0.26            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.33            -0.0        0.32        perf-profile.self.cycles-pp.mas_walk
      0.25            -0.0        0.23        perf-profile.self.cycles-pp.anon_vma_clone
      0.22 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.27            -0.0        0.26        perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.27            -0.0        0.25        perf-profile.self.cycles-pp.__pi_memcpy
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__put_user_4
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.26            -0.0        0.25        perf-profile.self.cycles-pp.do_user_addr_fault
      0.14            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.16            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.16            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.mas_store
      0.20            -0.0        0.19        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.19            -0.0        0.18        perf-profile.self.cycles-pp.handle_mm_fault
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.error_entry
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.prepare_creds
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.__perf_sw_event
      0.07            -0.0        0.06        perf-profile.self.cycles-pp._raw_spin_unlock
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.dup_fd
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.free_unref_folios
      0.17            -0.0        0.16        perf-profile.self.cycles-pp.get_page_from_freelist
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.lru_add
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.lru_gen_add_folio
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.ptep_clear_flush
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.tear_down_vmas
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.update_curr
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__percpu_counter_init_many
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.enqueue_task_fair
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.exit_task_stack_account
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.flush_tlb_func
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.pidfs_add_pid
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.rseq_set_ids_get_csaddr
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.update_cfs_rq_load_avg
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.vm_area_init_from
      0.15            -0.0        0.14        perf-profile.self.cycles-pp.acct_collect
      0.23 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.pcpu_alloc_noprof
      0.68            +0.0        0.72        perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.__mmput
      0.40            +0.1        0.46        perf-profile.self.cycles-pp.__account_obj_stock
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.lru_gen_add_mm
      0.02 ±141%      +0.1        0.09        perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.32            +0.1        0.44        perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.09            +0.2        0.26 ±  4%  perf-profile.self.cycles-pp.__refill_obj_stock
      0.44 ± 25%      +0.2        0.62 ± 11%  perf-profile.self.cycles-pp.queue_event
      0.06            +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.__memcg_kmem_uncharge_page
      0.00            +0.2        0.22 ±  4%  perf-profile.self.cycles-pp.drain_obj_stock
      0.75            +0.3        1.01        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.87            +0.3        1.17        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.29 ±  5%      +0.8        1.06        perf-profile.self.cycles-pp.lruvec_stat_mod_folio
     23.65 ±  2%      +2.0       25.66 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


