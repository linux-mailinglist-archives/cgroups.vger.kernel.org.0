Return-Path: <cgroups+bounces-3547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112592827A
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 09:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB31C226CF
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F0143C41;
	Fri,  5 Jul 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfOts9gG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9C13C81C
	for <cgroups@vger.kernel.org>; Fri,  5 Jul 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163422; cv=fail; b=o+weSBwuPR1dSeoLYGxlcnIlo0Nh7tcHsCyX/vFg5kWTFNzPsPx8hub5gD0c2PL3eOmztxMneK3Z+QuKCcZkGqbBjbTT8MXb2o3iiE6QpCVlnhJJJKrQHqkd9rScOaAKb8rWMIr2zRk/vX47VYPZqJdRkoaq0izx56s6s2Rfpw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163422; c=relaxed/simple;
	bh=qLtWn0lBG+5YfhzeZIca4RARQO2EqTKB28lwIJPj4aQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NThPM96sihJaoIxK9fCLMuOJ7FQ18qRN/8oJ2Ql/iV1KkGkHTssYl4cuKZpIM7kfLyO3RsiPqGJnVEE340rfdcTT4GU3IM1xr5n8Jb6OYPzLqWBMt7ryufGJrZRCOF9QnljkOLk66hY+EimZq1zgKflnjk2Fnqlw1+8DutzaZeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfOts9gG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720163410; x=1751699410;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=qLtWn0lBG+5YfhzeZIca4RARQO2EqTKB28lwIJPj4aQ=;
  b=hfOts9gGP8uvmdE1RDjUm32iJGM0+tOuPwn/9mz5j6GYQ3+dE+j2xXDL
   qryUSx6UQtbrY3RZYMn10PD0KpDmEANt5laZmbAzT7QEYmvrkDCgEirYc
   yvQ5/YUcU2+lDj+dnFjrUAS0mzq4ZRvwZh54CYFN2AVgRQ1fqSheeJH5W
   eLX1s/WNyLrEhlx4kSJkgSXZX3mWkUPYoVKWIp57MB3iryMNgdxj/0ckV
   Q/WcJ379LW+9BlAAaAgnFeKmOL3ebNzlQX+/3/Sqqh+2jdFYVSR3YEKUt
   tPGpi2Hhym/Y6eoC1XZEPi+hm4iaCgYPRFP5+5JlWVdPhUnUW7E/z5ATu
   A==;
X-CSE-ConnectionGUID: HCYQGameTHyFx534I4IHXg==
X-CSE-MsgGUID: 4O0Tx6joS2+F1S8atKbkiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20350712"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="20350712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 00:10:07 -0700
X-CSE-ConnectionGUID: U6q4AQ9wR5eIFtzIn4aybg==
X-CSE-MsgGUID: GeLPNdjKSVK8slNoWuo66Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46810975"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 00:10:07 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 00:10:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 00:10:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 00:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvqKZnuIMQ7KQA/A7DW2FLtZo6DaF0W0KCCWxLkqI0FN0oY7CCisEcZZpBD3Q78JTDs+UIYfFWsCDcWgi4iC/c0JzGyNmW+VAZuQSOdex/y4y5x/iJHMalcMlHjs7ben8Yr5xe/QNO/hZc/gABntax5mAjD+g0QLHtDpfXbB9lREDoK1rZaA4ALwW7e0ALSOaxIPUSbUv0s12HCW6n65l+NQgDsY2k8lYNkrpcH6HeHbgrrrtGcmYp+Tn36rU3wCz2P/GjsLVP6ThOqoUtu1/hrWm03CHdp4OMyhrS8fordoXDZodLzG/vMvahtgyszAxVgZwo71Q0hmBMX6NRQS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJidkztjSfXxiNt0XRUQYIraUhDwdIXBePd0Br5+hrk=;
 b=kLpDYooXWp3vDyESUqo+UZDT1irrU7TDXjo1u/UBVFy4dteEk/TicVjH9zLnhF2Xw5F5nuG/PTlwVS1wtgQ/le5susrz1FZkZLtInfGRG7uJOGj6KxBHl1Dmu44z4qic2mhc4KQbfLQBbMk9Pv6cGB7854oJlg1KogGHTjNK4c0qcjwEW8r5z6TTuaTUk18jHhlK8ydjLgjnrqYoMxSCNH7X91vqM+vp1JkplzB1zG1sK9aoT7xx2SAYdu/oKwB3/lCyLREfs2RTI9Rc9hFp6QosQhyXprOSAfZPyuYip7tm43vE5x5nvDNLcsE9uh0tLtbCdGQb137dJJFyA2koJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Fri, 5 Jul
 2024 07:09:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 07:09:59 +0000
Date: Fri, 5 Jul 2024 15:09:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Vishal Moola <vishal.moola@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Lance Yang <ioworker0@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  5893446d01:  vm-scalability.throughput
 3.5% improvement
Message-ID: <202407051414.1566be8e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a966d1-ebb4-479b-7538-08dc9cc17ad0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zddDD/FJEmZi0d9Uz4FBQjtJRXqNTu+cxhM16nqxe8EJEoviImgE1nSJJK?=
 =?iso-8859-1?Q?pWQlOG+kiamCe8F1giqWA/mddKceG/CwEwrLOnbBB77+GEcaBGv6QTSyy+?=
 =?iso-8859-1?Q?nOWmcBfeKp/WSspOmSoGUWm1ASjShWzP0fB7tpqrYo9O6zTLrHuA/rfIGo?=
 =?iso-8859-1?Q?FpQ0BntXzl0GIU+ltqDmwohyRBHhLuVDkrKwIxruYdrwMMAE5fSMO5G5mx?=
 =?iso-8859-1?Q?Z7XJS6ay0Nvv1tUCJ1slJ1aGYtXuCmUJOP3chEWcrR0STnJWG9iUVY6hYs?=
 =?iso-8859-1?Q?Rsbo7kgE/Xuhl85QRXmw+Fg4sCNvCy7g6JAD2So25+Hi6Bpbhm49S/fBT+?=
 =?iso-8859-1?Q?exso/RMj28bIm/TRCVvZutHW3L73dwD3BzPUCQ7CK61K1vPzPo0ZokTC7J?=
 =?iso-8859-1?Q?VaV9azuI242CUbxObykLhGXt1O+aA/sMDcXW8sQ/9MMNlJd91p37uavoRC?=
 =?iso-8859-1?Q?/UXp8qp7ZyyAn82VB2tuogjiNq59oJndpv4t6Uu4XAiHrv7ZxfAz+9ErBO?=
 =?iso-8859-1?Q?HBfQQZv0YHrMN/q2pePT9C+9lXJAq0wA9/wf/P6H4cXZrA/Oa4av8Cdjo/?=
 =?iso-8859-1?Q?BdVExHfYpod4dO49Vbl93H44weBj7yJd5nS7uNwVi/HIT6XMGZiu2z4XVG?=
 =?iso-8859-1?Q?g4vnFxKCzZbz+0Onuqb5sergbMwkw3IBhLSJcdHsq+oEiTOoK4me5snWyL?=
 =?iso-8859-1?Q?HKRBd8tXDr1NMZiBH9zd47Nwn+6KnvxD1R7AdGiaONtDxjTi+O3sYX8rvp?=
 =?iso-8859-1?Q?g9sscs3MIZIeNx+4kIGjCBzqZLTOmu8kPYdSXKxbAXakIxCfLFVaUFyoAz?=
 =?iso-8859-1?Q?GbqZfxJVeFcR1Q/JH3tIHmokQvNOS70nw/d7G6Ge0rP+B3SA6V+DThSjXu?=
 =?iso-8859-1?Q?2nb3bxPQFZ2C9chSKqXMNholrVSuxnzfWDW6Lf1CR7lfV4tCN+Hf6upK52?=
 =?iso-8859-1?Q?VjsPRC3xoTySDvFuBb2/q7ZTJ1piMbJLZTUpoy3EQo+d+Oed1oCeuxhltW?=
 =?iso-8859-1?Q?NkB+v0sbHsXTNQ6J2iLjBFaTD/wikrQZ7Ypu3qDrJzz2lAp3CY+E2E/6Zp?=
 =?iso-8859-1?Q?RztXmV+2rbs1UXr+HO/Bvxr5qoMrEzfbvHex7IASkKdFRh6EOHHJHFRjPx?=
 =?iso-8859-1?Q?lB1PGjYErG66VojpDKNgxTWkPvnWJ/EsUTkbTDRo4RB97/LWTiPZKrMnpX?=
 =?iso-8859-1?Q?jIbyzeHfKcD5ijiRWmkDbYPDHpEAgweB8IIMysPumfT6FfW6VzZCwt8iai?=
 =?iso-8859-1?Q?t4mUZ8oENVRTyNx8C55dUcJNGk2WOfaWUx7vmjMpKSapVBDedeSErPcij/?=
 =?iso-8859-1?Q?bOzINH2hNkCibQu6oKymRD23JpOLyX9XWuS5vxv1mFXTyy2mKib7KmKKKf?=
 =?iso-8859-1?Q?Ril9JQF9XF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kkMcIHpNQ42L28gulzq5NRi1Q+Fii60SurYN74s7WNsVz+iabecIQDyFr9?=
 =?iso-8859-1?Q?Fo7sXdCwjb61hSd9BQT+l8k1m5gEUjGuJt7NHtQXCxwBywtCZvzFiSlMXT?=
 =?iso-8859-1?Q?WGL2Qnk36AbW3RoZA/f+RbgxmCxioxBqDJU77pjnQMPc295983BhbnMwK8?=
 =?iso-8859-1?Q?tVvm7v8Add2nGbKAVSmjI7qHwVvaCfpzM9UU/RTf11O5E7MCRnUziWIqZc?=
 =?iso-8859-1?Q?keML/516jHilThECDwwwXBwS8PfLdaE9sJxOJGeIc+PB5c620v11mhIV59?=
 =?iso-8859-1?Q?DGOE4HmocSvqwDPPWW0cve1Sem0/r4Ls6Lt6D1ltbK5Tgk2tbZbAGrPoR/?=
 =?iso-8859-1?Q?RhwJ74izZofineIJ9uVB/pHxVp4GAMly7QJPacheh5QSkHBsGAqIKlyur/?=
 =?iso-8859-1?Q?RXV2WUHZSmkhGaCGlj/BzZVGevelvF/95stj/sj/hrbqUlsoJeagKKxYOO?=
 =?iso-8859-1?Q?GoheRmzMscXV7egiA92Jvlh31BxLlYP83cFu9SPPvNtKwqtd11utELIYST?=
 =?iso-8859-1?Q?WdwQD6d87QK47cpIHRF4mu/PatVTlax/72OM0fMkfTaCqDGtS/crB+LzXc?=
 =?iso-8859-1?Q?9sSlSoBlYqyUORFukFJSAj9x0SBgAhfXRmHoOKFbjJYjYmaHXBjHix4VeF?=
 =?iso-8859-1?Q?FEq9pJX5XmP5MHsrLaRzeG3mEsp7hrV3IEkIDw+VWtgEICD+zRANXPHdyY?=
 =?iso-8859-1?Q?x3eVEQy9WOpsnci5RSh28qh/YOBf/9iE2LF1WWJISAV8LBptMToj1S3WQq?=
 =?iso-8859-1?Q?1uAAhY+8ZfDbECFI1Dl6uWNOnODwYdktczcu8D1lkK4915pp8KHwX33QfO?=
 =?iso-8859-1?Q?9sPyfD5pFM22V6sDwIIHWjFN7NsZ+NDMEGXTgwFAE6vPpFIdB2mqgHL4+u?=
 =?iso-8859-1?Q?+tn5LPIqnDA28uZJFL3vlaKaN1vtoHVKI1O67RNA2MC7xV/7AA1RbwOtoG?=
 =?iso-8859-1?Q?9XE3RqlDh/6SkrkcHxEl9qxvR+WpDKC6hoy21WdsAXNbDgYGS+H+SIeDYB?=
 =?iso-8859-1?Q?l3yrIpduYBGTGbuS+OyXnukNp04YZJBzZO11muhFMQUnXstkdiGC5Hd3QY?=
 =?iso-8859-1?Q?AS9xLmm9BueiJ/WDChCDrNoJr767YHQik9omvmzE9AMKQwsAEQmPiaMvCd?=
 =?iso-8859-1?Q?wD3r4k2CteHfLrGDS236IIpTIoGNukkYRySym+f8YEiVuVYHZzq44Lzhpl?=
 =?iso-8859-1?Q?5W1Y1tgjyScRvqWuzfHga/fwDJ5Tonrb7pzjx2srpK4XXFpwyLR4rU+m0H?=
 =?iso-8859-1?Q?1tmtSrUQftPGxMc1eNB5YD2H6gEuciCXk0Lt+tqjnxTUz6a3ZybeYjkjGc?=
 =?iso-8859-1?Q?4Ma2ZYbNySwkrMFTfVevddgh4Zra5U4HGKaeBMYvF7dutFqpvZOmMY/8yb?=
 =?iso-8859-1?Q?hCWked7rIgePO30H8yu/AwzhT1BE1v6iC79YqIFagwDXP09audc21ViWmS?=
 =?iso-8859-1?Q?ZLolsunkdmv4IL0O9svCB/PPp15sZOW0LgpDUhDBu63kkSsFYBRmPQNmcP?=
 =?iso-8859-1?Q?XYa/Gn9BSpteHdhQaRI+YJLu581hJz2g+xoW9+JS1Wsfs+dQzlsFEg4HSb?=
 =?iso-8859-1?Q?NlsvM2cGKZ18o04uIf8tZk0Zkh7wZeCXraiMIc35vTca9Su6litlt0Rrss?=
 =?iso-8859-1?Q?G+bV0C24vorHlA0aFJEutZDi4CciNRcRCxo3Bqyxn5LNhzEtNtql1jsw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a966d1-ebb4-479b-7538-08dc9cc17ad0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:09:59.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xMu0M/IH247kLpo7l8FMO7U3xvyBH/mY7epmWZXz26uvql8rhzsRn8dPc9cT912pYgDY5Twmowxzeksv/6tzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.5% improvement of vm-scalability.throughput on:


commit: 5893446d01d40f79d4c1ad73ee2db55aaeddbf02 ("mm: refactor folio_undo_large_rmappable()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: vm-scalability
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	runtime: 300s
	size: 128G
	test: truncate-seq
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240705/202407051414.1566be8e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/128G/lkp-csl-2sp3/truncate-seq/vm-scalability

commit: 
  4f35bac79c ("mm/swap: reduce swap cache search space")
  5893446d01 ("mm: refactor folio_undo_large_rmappable()")

4f35bac79c0da77c 5893446d01d40f79d4c1ad73ee2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9821244 ±  8%     -11.9%    8653289 ± 11%  numa-vmstat.node0.nr_file_pages
      2.36 ± 21%      -0.9        1.43 ± 43%  perf-profile.calltrace.cycles-pp._Fork
      2.36 ± 21%      -0.9        1.43 ± 43%  perf-profile.children.cycles-pp._Fork
 3.317e+08            +3.5%  3.432e+08        vm-scalability.median
 3.317e+08            +3.5%  3.432e+08        vm-scalability.throughput
   4916288            +0.7%    4950852        vm-scalability.median_fault
      2.43 ± 25%      +0.4        2.81 ± 16%  vm-scalability.median_fault_stddev%
      1.92 ± 83%      +0.6        2.47 ± 55%  vm-scalability.median_stddev%
      1.92 ± 83%      +0.6        2.47 ± 55%  vm-scalability.stddev%
      2.43 ± 25%      +0.4        2.81 ± 16%  vm-scalability.stddev_fault%
   4916288            +0.7%    4950852        vm-scalability.throughput_fault
    109.44            -0.8%     108.62        vm-scalability.time.elapsed_time
    109.44            -0.8%     108.62        vm-scalability.time.elapsed_time.max
      1596 ± 52%     -43.0%     910.00 ± 90%  vm-scalability.time.file_system_inputs
      1668            -1.0%       1651 ±  3%  vm-scalability.time.involuntary_context_switches
      3190            -0.4%       3176        vm-scalability.time.maximum_resident_set_size
    151627            -0.0%     151620        vm-scalability.time.minor_page_faults
      4096            +0.0%       4096        vm-scalability.time.page_size
     99.00            +0.0%      99.00        vm-scalability.time.percent_of_cpu_this_job_got
    106.53            -0.8%     105.72        vm-scalability.time.system_time
      2.08            +0.6%       2.09        vm-scalability.time.user_time
      3771            -0.3%       3760        vm-scalability.time.voluntary_context_switches
 5.267e+08            +0.0%  5.267e+08        vm-scalability.workload


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


<below more details following above table FYI>

  1.05e+10            +2.7%  1.078e+10 ±  3%  cpuidle..time
   1017628 ±  2%      -3.3%     983876        cpuidle..usage
    157.94 ±  2%      +2.8%     162.43 ±  3%  uptime.boot
     14522 ±  3%      +3.0%      14955 ±  4%  uptime.idle
     43.33 ±  6%      +1.8%      44.12 ±  5%  boot-time.boot
     24.32            -0.4%      24.22        boot-time.dhcp
      3692 ±  7%      +2.1%       3768 ±  6%  boot-time.idle
     10.50 ± 44%     -14.3%       9.00 ± 33%  perf-c2c.DRAM.local
     23.83 ± 41%     -22.4%      18.50 ± 19%  perf-c2c.DRAM.remote
     29.50 ± 39%     -22.6%      22.83 ± 49%  perf-c2c.HITM.local
      9.17 ± 69%      +3.6%       9.50 ± 35%  perf-c2c.HITM.remote
     38.67 ± 36%     -16.4%      32.33 ± 35%  perf-c2c.HITM.total
     98.51            +0.1       98.57        mpstat.cpu.all.idle%
      0.00 ± 42%      -0.0        0.00 ± 34%  mpstat.cpu.all.iowait%
      0.02 ± 11%      -0.0        0.02 ±  4%  mpstat.cpu.all.irq%
      0.01 ±  6%      -0.0        0.01 ±  4%  mpstat.cpu.all.soft%
      1.13            -0.0        1.09 ±  3%  mpstat.cpu.all.sys%
      0.32 ± 10%      -0.0        0.31 ± 11%  mpstat.cpu.all.usr%
      1.00           +16.7%       1.17 ± 31%  mpstat.max_utilization.seconds
      4.86 ± 16%     -10.4%       4.35        mpstat.max_utilization_pct
    109.44            -0.8%     108.62        time.elapsed_time
    109.44            -0.8%     108.62        time.elapsed_time.max
      1596 ± 52%     -43.0%     910.00 ± 90%  time.file_system_inputs
      1668            -1.0%       1651 ±  3%  time.involuntary_context_switches
      3190            -0.4%       3176        time.maximum_resident_set_size
    151627            -0.0%     151620        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
     99.00            +0.0%      99.00        time.percent_of_cpu_this_job_got
    106.53            -0.8%     105.72        time.system_time
      2.08            +0.6%       2.09        time.user_time
      3771            -0.3%       3760        time.voluntary_context_switches
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    928870 ± 15%     -16.9%     772054 ± 19%  numa-numastat.node0.local_node
    649948 ± 18%     -19.3%     524218 ± 29%  numa-numastat.node0.numa_foreign
   1003328 ± 14%     -18.3%     819705 ± 17%  numa-numastat.node0.numa_hit
    353034 ± 30%     +37.5%     485518 ± 30%  numa-numastat.node0.numa_miss
    427511 ± 24%     +24.7%     533053 ± 28%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    662445 ± 24%     +23.2%     816027 ± 19%  numa-numastat.node1.local_node
    353034 ± 30%     +37.5%     485433 ± 30%  numa-numastat.node1.numa_foreign
    687384 ± 23%     +26.3%     867857 ± 17%  numa-numastat.node1.numa_hit
    649948 ± 18%     -19.3%     524218 ± 29%  numa-numastat.node1.numa_miss
    674878 ± 17%     -14.6%     576049 ± 27%  numa-numastat.node1.other_node
     98.65            +0.1%      98.70        vmstat.cpu.id
      1.06            -3.4%       1.02 ±  3%  vmstat.cpu.sy
      0.29 ± 12%      -3.0%       0.28 ± 12%  vmstat.cpu.us
     19.83            -2.7%      19.31 ±  3%  vmstat.io.bi
     19.69            -2.7%      19.16 ±  3%  vmstat.io.bo
      4.00            +0.0%       4.00        vmstat.memory.buff
   3157423            +0.0%    3157465        vmstat.memory.cache
 1.269e+08            +0.0%  1.269e+08        vmstat.memory.free
      0.00 ±141%    +100.0%       0.01 ±112%  vmstat.procs.b
      2.70 ±  3%      -2.2%       2.64 ±  3%  vmstat.procs.r
      2050            -0.2%       2046 ±  2%  vmstat.system.cs
     10065 ±  2%      -4.6%       9602 ±  3%  vmstat.system.in
     10572 ± 11%      -6.9%       9845 ± 10%  meminfo.Active
     10376 ± 11%      -7.0%       9654 ± 10%  meminfo.Active(anon)
    195.75            -2.6%     190.71 ±  2%  meminfo.Active(file)
     96118 ± 12%      -2.4%      93851 ± 20%  meminfo.AnonHugePages
    646855            -0.4%     644540        meminfo.AnonPages
      1044            -3.1%       1012 ±  3%  meminfo.Buffers
  71293285            -2.3%   69659124 ±  3%  meminfo.Cached
  65838168            +0.0%   65838168        meminfo.CommitLimit
    859242            -0.9%     851224        meminfo.Committed_AS
 6.526e+08            +0.1%  6.531e+08        meminfo.DirectMap1G
  11628090 ±  9%      -4.2%   11139709 ± 11%  meminfo.DirectMap2M
    290662 ± 12%     -12.4%     254699 ± 11%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
  68862463            -2.4%   67226673 ±  3%  meminfo.Inactive
    710371            -0.6%     706117        meminfo.Inactive(anon)
  68152091            -2.4%   66520555 ±  3%  meminfo.Inactive(file)
     97909            +0.3%      98185        meminfo.KReclaimable
     18941            -0.6%      18821        meminfo.KernelStack
     32742            -0.7%      32497        meminfo.Mapped
 1.257e+08            -0.0%  1.257e+08        meminfo.MemAvailable
  58346015            +2.8%   59968769 ±  3%  meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
  73330324            -2.2%   71707570 ±  3%  meminfo.Memused
      6925 ±  4%      -3.8%       6660 ±  3%  meminfo.PageTables
     42216            +1.1%      42663        meminfo.Percpu
     97909            +0.3%      98185        meminfo.SReclaimable
    216034            -0.5%     214968        meminfo.SUnreclaim
     77372            -3.4%      74728 ±  3%  meminfo.Shmem
    313943            -0.3%     313154        meminfo.Slab
   3067744            +0.0%    3067753        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    163090            -0.1%     162951        meminfo.VmallocUsed
 1.156e+08            +1.1%  1.168e+08        meminfo.max_used_kB
     48.92 ±  3%      -1.7%      48.06 ±  5%  perf-stat.i.MPKI
 5.008e+08 ±  7%      -3.6%  4.829e+08 ±  6%  perf-stat.i.branch-instructions
      2.16 ±  7%      +0.0        2.20 ±  9%  perf-stat.i.branch-miss-rate%
  21175597 ± 11%      -4.5%   20216297 ± 12%  perf-stat.i.branch-misses
     78.72            -2.3       76.41 ±  3%  perf-stat.i.cache-miss-rate%
  93025416            -2.3%   90922249 ±  3%  perf-stat.i.cache-misses
 1.176e+08            -1.8%  1.155e+08 ±  3%  perf-stat.i.cache-references
      1901            -0.6%       1890        perf-stat.i.context-switches
      2.58 ±  2%      +0.0%       2.58 ±  2%  perf-stat.i.cpi
     96015            +0.0%      96029        perf-stat.i.cpu-clock
 5.598e+09 ±  2%      -3.2%  5.421e+09 ±  4%  perf-stat.i.cpu-cycles
    116.35            +0.7%     117.11        perf-stat.i.cpu-migrations
     65.36 ±  3%     +37.7%      90.00 ± 33%  perf-stat.i.cycles-between-cache-misses
 2.937e+09 ±  6%      -3.4%  2.837e+09 ±  5%  perf-stat.i.instructions
      0.46 ±  3%      -0.0%       0.46 ±  3%  perf-stat.i.ipc
      0.04 ± 65%      +3.2%       0.04 ± 68%  perf-stat.i.major-faults
      1.36 ± 70%     -74.7%       0.35 ±223%  perf-stat.i.metric.K/sec
      4447 ±  4%      +2.8%       4572        perf-stat.i.minor-faults
      4447 ±  4%      +2.8%       4572        perf-stat.i.page-faults
     96015            +0.0%      96029        perf-stat.i.task-clock
     31.80 ±  7%      +0.5%      31.97 ±  4%  perf-stat.overall.MPKI
      4.21 ±  4%      -0.0        4.18 ±  6%  perf-stat.overall.branch-miss-rate%
     79.10            -0.4       78.74        perf-stat.overall.cache-miss-rate%
      1.91 ±  3%      -0.1%       1.91 ±  3%  perf-stat.overall.cpi
     60.21 ±  3%      -0.7%      59.78 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.52 ±  3%      +0.0%       0.52 ±  3%  perf-stat.overall.ipc
    611.47 ±  6%      -0.5%     608.58 ±  5%  perf-stat.overall.path-length
 4.963e+08 ±  7%      -3.0%  4.816e+08 ±  6%  perf-stat.ps.branch-instructions
  20983247 ± 11%      -3.7%   20202224 ± 12%  perf-stat.ps.branch-misses
  92187888            -2.2%   90139246 ±  3%  perf-stat.ps.cache-misses
 1.166e+08            -1.8%  1.145e+08 ±  3%  perf-stat.ps.cache-references
      1883            -0.5%       1873        perf-stat.ps.context-switches
     95133            +0.0%      95151        perf-stat.ps.cpu-clock
 5.549e+09 ±  2%      -2.9%  5.389e+09 ±  4%  perf-stat.ps.cpu-cycles
    115.26            +0.8%     116.22        perf-stat.ps.cpu-migrations
 2.911e+09 ±  6%      -2.9%  2.826e+09 ±  5%  perf-stat.ps.instructions
      0.04 ± 64%      +5.4%       0.04 ± 66%  perf-stat.ps.major-faults
      4397 ±  4%      +2.9%       4523        perf-stat.ps.minor-faults
      4397 ±  4%      +2.9%       4523        perf-stat.ps.page-faults
     95133            +0.0%      95151        perf-stat.ps.task-clock
 3.221e+11 ±  6%      -0.5%  3.205e+11 ±  5%  perf-stat.total.instructions
      5545 ± 45%     -35.0%       3607 ± 33%  numa-meminfo.node0.Active
      5402 ± 46%     -35.1%       3508 ± 34%  numa-meminfo.node0.Active(anon)
    143.57 ± 35%     -31.3%      98.68 ± 53%  numa-meminfo.node0.Active(file)
     46423 ± 81%     +40.2%      65069 ± 65%  numa-meminfo.node0.AnonHugePages
    330448 ± 72%     +14.5%     378412 ± 69%  numa-meminfo.node0.AnonPages
    357386 ± 70%      +8.7%     388601 ± 66%  numa-meminfo.node0.AnonPages.max
  39271978 ±  8%     -11.6%   34721073 ± 11%  numa-meminfo.node0.FilePages
  37773980 ± 12%     -11.5%   33441614 ± 10%  numa-meminfo.node0.Inactive
    383307 ± 59%      +1.5%     389192 ± 69%  numa-meminfo.node0.Inactive(anon)
  37390673 ± 11%     -11.6%   33052420 ± 10%  numa-meminfo.node0.Inactive(file)
     64175 ± 27%     -12.9%      55890 ± 48%  numa-meminfo.node0.KReclaimable
     10126 ±  6%      -3.5%       9771 ±  3%  numa-meminfo.node0.KernelStack
     26007 ± 19%     -24.9%      19534 ± 68%  numa-meminfo.node0.Mapped
  25330556 ± 13%     +17.8%   29839021 ± 13%  numa-meminfo.node0.MemFree
  65673568            +0.0%   65673568        numa-meminfo.node0.MemTotal
  40343011 ±  8%     -11.2%   35834546 ± 10%  numa-meminfo.node0.MemUsed
      3783 ± 18%      -4.0%       3632 ± 13%  numa-meminfo.node0.PageTables
     64175 ± 27%     -12.9%      55890 ± 48%  numa-meminfo.node0.SReclaimable
    131826 ±  7%      -3.6%     127117 ± 10%  numa-meminfo.node0.SUnreclaim
     61527 ± 40%     -71.5%      17561 ±125%  numa-meminfo.node0.Shmem
    196002 ±  8%      -6.6%     183008 ± 18%  numa-meminfo.node0.Slab
   1822708 ± 62%      -9.3%    1654051 ± 81%  numa-meminfo.node0.Unevictable
      5040 ± 48%     +24.4%       6272 ± 19%  numa-meminfo.node1.Active
      4988 ± 48%     +23.9%       6180 ± 20%  numa-meminfo.node1.Active(anon)
     51.78 ±101%     +78.1%      92.23 ± 61%  numa-meminfo.node1.Active(file)
     49716 ± 95%     -42.1%      28796 ±142%  numa-meminfo.node1.AnonHugePages
    316433 ± 75%     -15.9%     266145 ± 99%  numa-meminfo.node1.AnonPages
    375916 ± 61%     -19.9%     301258 ± 96%  numa-meminfo.node1.AnonPages.max
  31901845 ±  9%      +9.1%   34798716 ± 13%  numa-meminfo.node1.FilePages
  30967974 ± 13%      +8.6%   33644669 ± 14%  numa-meminfo.node1.Inactive
    326884 ± 69%      -3.0%     316925 ± 86%  numa-meminfo.node1.Inactive(anon)
  30641090 ± 13%      +8.8%   33327743 ± 14%  numa-meminfo.node1.Inactive(file)
     33724 ± 54%     +25.4%      42293 ± 63%  numa-meminfo.node1.KReclaimable
      8783 ±  6%      +2.8%       9024 ±  4%  numa-meminfo.node1.KernelStack
      6794 ± 75%     +91.2%      12991 ±102%  numa-meminfo.node1.Mapped
  33136018 ±  9%      -8.6%   30270316 ± 15%  numa-meminfo.node1.MemFree
  66002772            +0.0%   66002772        numa-meminfo.node1.MemTotal
  32866753 ±  9%      +8.7%   35732455 ± 13%  numa-meminfo.node1.MemUsed
      3141 ± 17%      -3.5%       3031 ± 19%  numa-meminfo.node1.PageTables
     33724 ± 54%     +25.4%      42293 ± 63%  numa-meminfo.node1.SReclaimable
     84194 ± 11%      +4.3%      87840 ± 15%  numa-meminfo.node1.SUnreclaim
     15658 ±161%    +265.2%      57182 ± 40%  numa-meminfo.node1.Shmem
    117918 ± 15%     +10.4%     130134 ± 24%  numa-meminfo.node1.Slab
   1245035 ± 92%     +13.5%    1413701 ± 94%  numa-meminfo.node1.Unevictable
      1350 ± 45%     -34.8%     880.84 ± 34%  numa-vmstat.node0.nr_active_anon
     35.86 ± 35%     -31.3%      24.62 ± 53%  numa-vmstat.node0.nr_active_file
     82614 ± 72%     +14.5%      94609 ± 69%  numa-vmstat.node0.nr_anon_pages
     22.69 ± 81%     +40.0%      31.77 ± 65%  numa-vmstat.node0.nr_anon_transparent_hugepages
   9821244 ±  8%     -11.9%    8653289 ± 11%  numa-vmstat.node0.nr_file_pages
   6329431 ± 13%     +18.3%    7486685 ± 13%  numa-vmstat.node0.nr_free_pages
     95829 ± 59%      +1.5%      97299 ± 69%  numa-vmstat.node0.nr_inactive_anon
   9350915 ± 12%     -11.9%    8236133 ± 11%  numa-vmstat.node0.nr_inactive_file
      0.00 ±223%    -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
      0.06 ±141%    +490.5%       0.37 ±201%  numa-vmstat.node0.nr_isolated_file
     10112 ±  6%      -3.5%       9763 ±  3%  numa-vmstat.node0.nr_kernel_stack
      6649 ± 19%     -24.4%       5024 ± 68%  numa-vmstat.node0.nr_mapped
    945.10 ± 18%      -4.0%     907.55 ± 13%  numa-vmstat.node0.nr_page_table_pages
     15385 ± 40%     -71.5%       4390 ±125%  numa-vmstat.node0.nr_shmem
     16039 ± 27%     -12.9%      13972 ± 48%  numa-vmstat.node0.nr_slab_reclaimable
     32955 ±  7%      -3.6%      31778 ± 10%  numa-vmstat.node0.nr_slab_unreclaimable
    455677 ± 62%      -9.3%     413512 ± 81%  numa-vmstat.node0.nr_unevictable
      1351 ± 45%     -34.8%     880.97 ± 34%  numa-vmstat.node0.nr_zone_active_anon
     35.86 ± 35%     -31.3%      24.62 ± 53%  numa-vmstat.node0.nr_zone_active_file
     95839 ± 59%      +1.5%      97305 ± 69%  numa-vmstat.node0.nr_zone_inactive_anon
   9350912 ± 12%     -11.9%    8236147 ± 11%  numa-vmstat.node0.nr_zone_inactive_file
    455677 ± 62%      -9.3%     413512 ± 81%  numa-vmstat.node0.nr_zone_unevictable
    649948 ± 18%     -19.3%     524218 ± 29%  numa-vmstat.node0.numa_foreign
   1002926 ± 14%     -18.3%     819100 ± 17%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
    928469 ± 15%     -16.9%     771448 ± 19%  numa-vmstat.node0.numa_local
    353034 ± 30%     +37.5%     485518 ± 30%  numa-vmstat.node0.numa_miss
    427511 ± 24%     +24.7%     533053 ± 28%  numa-vmstat.node0.numa_other
     26.51 ± 76%     -16.9%      22.03 ± 51%  numa-vmstat.node0.workingset_nodes
      1251 ± 48%     +23.2%       1542 ± 20%  numa-vmstat.node1.nr_active_anon
     12.94 ±101%     +77.9%      23.02 ± 61%  numa-vmstat.node1.nr_active_file
     79115 ± 74%     -15.9%      66543 ± 99%  numa-vmstat.node1.nr_anon_pages
     24.32 ± 95%     -42.2%      14.07 ±142%  numa-vmstat.node1.nr_anon_transparent_hugepages
   7970070 ±  8%      +9.0%    8685869 ± 13%  numa-vmstat.node1.nr_file_pages
      0.00       +6.7e+101%       0.67 ±165%  numa-vmstat.node1.nr_foll_pin_acquired
      0.00       +6.7e+101%       0.67 ±165%  numa-vmstat.node1.nr_foll_pin_released
   8289439 ±  8%      -8.5%    7581337 ± 15%  numa-vmstat.node1.nr_free_pages
     81721 ± 68%      -3.1%      79211 ± 86%  numa-vmstat.node1.nr_inactive_anon
   7654882 ± 13%      +8.7%    8318154 ± 14%  numa-vmstat.node1.nr_inactive_file
      0.11 ±223%      +0.0%       0.11 ±223%  numa-vmstat.node1.nr_isolated_file
      8748 ±  6%      +3.0%       9010 ±  4%  numa-vmstat.node1.nr_kernel_stack
      1760 ± 72%     +90.7%       3357 ±101%  numa-vmstat.node1.nr_mapped
    780.09 ± 17%      -3.0%     756.43 ± 19%  numa-vmstat.node1.nr_page_table_pages
      3915 ±161%    +264.4%      14267 ± 40%  numa-vmstat.node1.nr_shmem
      8431 ± 54%     +25.4%      10571 ± 63%  numa-vmstat.node1.nr_slab_reclaimable
     21050 ± 11%      +4.3%      21959 ± 15%  numa-vmstat.node1.nr_slab_unreclaimable
    311258 ± 92%     +13.5%     353425 ± 94%  numa-vmstat.node1.nr_unevictable
      1251 ± 48%     +23.2%       1542 ± 20%  numa-vmstat.node1.nr_zone_active_anon
     12.94 ±101%     +77.9%      23.02 ± 61%  numa-vmstat.node1.nr_zone_active_file
     81721 ± 68%      -3.1%      79210 ± 86%  numa-vmstat.node1.nr_zone_inactive_anon
   7654883 ± 13%      +8.7%    8318157 ± 14%  numa-vmstat.node1.nr_zone_inactive_file
    311258 ± 92%     +13.5%     353425 ± 94%  numa-vmstat.node1.nr_zone_unevictable
    353034 ± 30%     +37.5%     485433 ± 30%  numa-vmstat.node1.numa_foreign
    686468 ± 23%     +26.3%     867189 ± 17%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
    661530 ± 24%     +23.3%     815360 ± 19%  numa-vmstat.node1.numa_local
    649948 ± 18%     -19.3%     524218 ± 29%  numa-vmstat.node1.numa_miss
    674878 ± 17%     -14.6%     576049 ± 27%  numa-vmstat.node1.numa_other
     34.78 ± 79%      +4.6%      36.38 ± 63%  numa-vmstat.node1.workingset_nodes
      1.83 ±106%     -45.5%       1.00 ±141%  proc-vmstat.allocstall_movable
   8268386 ± 61%     -11.5%    7321578 ± 67%  proc-vmstat.compact_daemon_free_scanned
    729459 ± 79%      -8.3%     668767 ± 92%  proc-vmstat.compact_daemon_migrate_scanned
     68.83 ± 33%     -13.6%      59.50 ± 34%  proc-vmstat.compact_daemon_wake
      1.67 ±132%     -50.0%       0.83 ±145%  proc-vmstat.compact_fail
   9579026 ± 47%     -23.5%    7323637 ± 67%  proc-vmstat.compact_free_scanned
     50504 ± 48%     -30.1%      35290 ± 57%  proc-vmstat.compact_isolated
   2491013 ±143%     -73.1%     669890 ± 91%  proc-vmstat.compact_migrate_scanned
     16.33 ±164%     -91.8%       1.33 ±119%  proc-vmstat.compact_stall
     14.67 ±170%     -96.6%       0.50 ±100%  proc-vmstat.compact_success
     95.71 ± 18%     -17.1%      79.32 ± 17%  proc-vmstat.direct_map_level2_splits
      3.16 ± 49%      -0.0%       3.16 ± 52%  proc-vmstat.direct_map_level3_splits
    111.33 ± 70%     -21.3%      87.67 ± 72%  proc-vmstat.kswapd_high_wmark_hit_quickly
    335.33 ± 27%      -2.7%     326.17 ± 18%  proc-vmstat.kswapd_low_wmark_hit_quickly
      2598 ± 11%      -6.8%       2422 ± 10%  proc-vmstat.nr_active_anon
     48.80            -2.3%      47.69 ±  2%  proc-vmstat.nr_active_file
    161719            -0.4%     161135        proc-vmstat.nr_anon_pages
     46.96 ± 12%      -2.4%      45.84 ± 20%  proc-vmstat.nr_anon_transparent_hugepages
   3142633            -0.0%    3142425        proc-vmstat.nr_dirty_background_threshold
   6292950            -0.0%    6292533        proc-vmstat.nr_dirty_threshold
  17800424            -2.4%   17371255 ±  3%  proc-vmstat.nr_file_pages
      0.00       +6.7e+101%       0.67 ±165%  proc-vmstat.nr_foll_pin_acquired
      0.00       +6.7e+101%       0.67 ±165%  proc-vmstat.nr_foll_pin_released
  14609712            +2.9%   15036060 ±  3%  proc-vmstat.nr_free_pages
    177546            -0.6%     176524        proc-vmstat.nr_inactive_anon
  17014913            -2.5%   16586357 ±  3%  proc-vmstat.nr_inactive_file
      0.00 ±223%  +46911.8%       0.71 ±223%  proc-vmstat.nr_isolated_anon
      0.06 ±141%    +612.6%       0.45 ±164%  proc-vmstat.nr_isolated_file
     18899            -0.6%      18793        proc-vmstat.nr_kernel_stack
      8400            -0.4%       8370        proc-vmstat.nr_mapped
      1732 ±  4%      -3.8%       1666 ±  3%  proc-vmstat.nr_page_table_pages
     19296            -3.2%      18686 ±  3%  proc-vmstat.nr_shmem
     24473            +0.3%      24544        proc-vmstat.nr_slab_reclaimable
     54005            -0.5%      53737        proc-vmstat.nr_slab_unreclaimable
    766936            +0.0%     766938        proc-vmstat.nr_unevictable
      2598 ± 11%      -6.8%       2422 ± 10%  proc-vmstat.nr_zone_active_anon
     48.80            -2.3%      47.69 ±  2%  proc-vmstat.nr_zone_active_file
    177554            -0.6%     176531        proc-vmstat.nr_zone_inactive_anon
  17014922            -2.5%   16586362 ±  3%  proc-vmstat.nr_zone_inactive_file
    766936            +0.0%     766938        proc-vmstat.nr_zone_unevictable
   1002982 ±  3%      +0.7%    1009651 ±  3%  proc-vmstat.numa_foreign
    799.00 ±155%    +583.9%       5464 ± 96%  proc-vmstat.numa_hint_faults
    666.50 ±187%    +680.7%       5203 ±100%  proc-vmstat.numa_hint_faults_local
   1692714            -0.2%    1689677 ±  2%  proc-vmstat.numa_hit
     38.17 ± 79%     +36.7%      52.17 ± 43%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   1593302            -0.2%    1590196 ±  2%  proc-vmstat.numa_local
   1002982 ±  3%      +0.7%    1009736 ±  3%  proc-vmstat.numa_miss
   1102390 ±  2%      +0.6%    1109102 ±  3%  proc-vmstat.numa_other
      2578 ±197%     -26.4%       1898 ±164%  proc-vmstat.numa_pages_migrated
     37520 ±105%     +70.3%      63884 ± 44%  proc-vmstat.numa_pte_updates
    514.50 ±  8%      -7.0%     478.67 ±  9%  proc-vmstat.pageoutrun
      3172 ±  3%      +0.7%       3196 ±  2%  proc-vmstat.pgactivate
     88121 ± 23%      +1.2%      89154 ± 28%  proc-vmstat.pgalloc_dma
   1722586 ± 23%     +15.4%    1988021 ± 22%  proc-vmstat.pgalloc_dma32
 1.306e+08            -0.2%  1.303e+08        proc-vmstat.pgalloc_normal
    559450            +1.9%     570292 ±  2%  proc-vmstat.pgfault
    708544 ±  4%      -3.9%     681155 ±  3%  proc-vmstat.pgfree
    306.67 ±171%     -56.5%     133.50 ±164%  proc-vmstat.pgmigrate_fail
     27107 ± 45%     -29.4%      19145 ± 67%  proc-vmstat.pgmigrate_success
      2227            +0.0%       2227        proc-vmstat.pgpgin
      2201            -0.4%       2191        proc-vmstat.pgpgout
     24760            +1.1%      25034        proc-vmstat.pgreuse
      3904 ±153%    -100.0%       0.00        proc-vmstat.pgscan_direct
 4.469e+08 ± 24%      +8.7%  4.859e+08 ± 26%  proc-vmstat.pgscan_file
      3746 ±100%     -32.0%       2548 ±141%  proc-vmstat.pgscan_khugepaged
 4.469e+08 ± 24%      +8.7%  4.859e+08 ± 26%  proc-vmstat.pgscan_kswapd
  11528459 ± 23%      +6.8%   12313012 ± 31%  proc-vmstat.pgskip_dma32
 4.289e+08 ± 24%      +8.8%  4.668e+08 ± 27%  proc-vmstat.pgskip_normal
      3904 ±153%    -100.0%       0.00        proc-vmstat.pgsteal_direct
   6470458 ± 18%      +4.1%    6735173 ± 15%  proc-vmstat.pgsteal_file
      3746 ±100%     -32.0%       2548 ±141%  proc-vmstat.pgsteal_khugepaged
   6462807 ± 18%      +4.2%    6732625 ± 15%  proc-vmstat.pgsteal_kswapd
     29087 ±  6%      -2.2%      28458 ±  3%  proc-vmstat.slabs_scanned
     71.33 ± 21%      -5.8%      67.17 ± 35%  proc-vmstat.thp_collapse_alloc
      0.33 ±141%      +0.0%       0.33 ±141%  proc-vmstat.thp_collapse_alloc_failed
      0.00          -100.0%       0.00        proc-vmstat.thp_fault_alloc
      0.00       +1.7e+101%       0.17 ±223%  proc-vmstat.thp_migration_fail
      4.83 ±205%     -31.0%       3.33 ±184%  proc-vmstat.thp_migration_success
      0.00          -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    240.00            +0.0%     240.00        proc-vmstat.unevictable_pgs_culled
     61.18 ± 59%      -3.9%      58.81 ± 44%  proc-vmstat.workingset_nodes
    849.81 ±  9%      +1.0%     858.50 ±  7%  slabinfo.Acpi-State.active_objs
     16.66 ±  9%      +1.0%      16.83 ±  7%  slabinfo.Acpi-State.active_slabs
    849.81 ±  9%      +1.0%     858.50 ±  7%  slabinfo.Acpi-State.num_objs
     16.66 ±  9%      +1.0%      16.83 ±  7%  slabinfo.Acpi-State.num_slabs
     18.00            +0.0%      18.00        slabinfo.DCCP.active_objs
      1.00            +0.0%       1.00        slabinfo.DCCP.active_slabs
     18.00            +0.0%      18.00        slabinfo.DCCP.num_objs
      1.00            +0.0%       1.00        slabinfo.DCCP.num_slabs
     17.00            +0.0%      17.00        slabinfo.DCCPv6.active_objs
      1.00            +0.0%       1.00        slabinfo.DCCPv6.active_slabs
     17.00            +0.0%      17.00        slabinfo.DCCPv6.num_objs
      1.00            +0.0%       1.00        slabinfo.DCCPv6.num_slabs
      1007 ±  9%      -1.8%     989.15 ±  4%  slabinfo.PING.active_objs
     31.48 ±  9%      -1.8%      30.91 ±  4%  slabinfo.PING.active_slabs
      1007 ±  9%      -1.8%     989.15 ±  4%  slabinfo.PING.num_objs
     31.48 ±  9%      -1.8%      30.91 ±  4%  slabinfo.PING.num_slabs
     98.67 ±  6%      -2.7%      96.00        slabinfo.RAW.active_objs
      3.08 ±  6%      -2.7%       3.00        slabinfo.RAW.active_slabs
     98.67 ±  6%      -2.7%      96.00        slabinfo.RAW.num_objs
      3.08 ±  6%      -2.7%       3.00        slabinfo.RAW.num_slabs
     78.00            -2.8%      75.83 ±  6%  slabinfo.RAWv6.active_objs
      3.00            -2.8%       2.92 ±  6%  slabinfo.RAWv6.active_slabs
     78.00            -2.8%      75.83 ±  6%  slabinfo.RAWv6.num_objs
      3.00            -2.8%       2.92 ±  6%  slabinfo.RAWv6.num_slabs
     19.54            +1.0%      19.73        slabinfo.TCP.active_objs
      1.50            +1.0%       1.52        slabinfo.TCP.active_slabs
     19.54            +1.0%      19.73        slabinfo.TCP.num_objs
      1.50            +1.0%       1.52        slabinfo.TCP.num_slabs
     12.00            +0.0%      12.00        slabinfo.TCPv6.active_objs
      1.00            +0.0%       1.00        slabinfo.TCPv6.active_slabs
     12.00            +0.0%      12.00        slabinfo.TCPv6.num_objs
      1.00            +0.0%       1.00        slabinfo.TCPv6.num_slabs
     46.00 ±  9%      -4.3%      44.00 ± 12%  slabinfo.UDPv6.active_objs
      1.92 ±  9%      -4.3%       1.83 ± 12%  slabinfo.UDPv6.active_slabs
     46.00 ±  9%      -4.3%      44.00 ± 12%  slabinfo.UDPv6.num_objs
      1.92 ±  9%      -4.3%       1.83 ± 12%  slabinfo.UDPv6.num_slabs
      8362 ±  4%      -0.6%       8316 ±  4%  slabinfo.anon_vma.active_objs
    218.11 ±  4%      -0.8%     216.32 ±  4%  slabinfo.anon_vma.active_slabs
      8506 ±  4%      -0.8%       8436 ±  4%  slabinfo.anon_vma.num_objs
    218.11 ±  4%      -0.8%     216.32 ±  4%  slabinfo.anon_vma.num_slabs
     10719 ±  6%      -4.7%      10219 ±  3%  slabinfo.anon_vma_chain.active_objs
    177.50 ±  7%      -6.6%     165.82 ±  5%  slabinfo.anon_vma_chain.active_slabs
     11360 ±  7%      -6.6%      10612 ±  5%  slabinfo.anon_vma_chain.num_objs
    177.50 ±  7%      -6.6%     165.82 ±  5%  slabinfo.anon_vma_chain.num_slabs
    118.18 ±  3%      +5.6%     124.82 ±  7%  slabinfo.bdev_cache.active_objs
      5.91 ±  3%      +5.6%       6.24 ±  7%  slabinfo.bdev_cache.active_slabs
    118.18 ±  3%      +5.6%     124.82 ±  7%  slabinfo.bdev_cache.num_objs
      5.91 ±  3%      +5.6%       6.24 ±  7%  slabinfo.bdev_cache.num_slabs
    186.19 ±  6%      +2.9%     191.53 ±  4%  slabinfo.bio-120.active_objs
      5.82 ±  6%      +2.9%       5.99 ±  4%  slabinfo.bio-120.active_slabs
    186.19 ±  6%      +2.9%     191.53 ±  4%  slabinfo.bio-120.num_objs
      5.82 ±  6%      +2.9%       5.99 ±  4%  slabinfo.bio-120.num_slabs
    554.21 ±  6%     +16.4%     645.35 ± 11%  slabinfo.bio-184.active_objs
     13.20 ±  6%     +16.4%      15.37 ± 11%  slabinfo.bio-184.active_slabs
    554.21 ±  6%     +16.4%     645.35 ± 11%  slabinfo.bio-184.num_objs
     13.20 ±  6%     +16.4%      15.37 ± 11%  slabinfo.bio-184.num_slabs
     16.00            +0.0%      16.00        slabinfo.bio-240.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-240.active_slabs
     16.00            +0.0%      16.00        slabinfo.bio-240.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-240.num_slabs
     16.00            +0.0%      16.00        slabinfo.bio-248.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-248.active_slabs
     16.00            +0.0%      16.00        slabinfo.bio-248.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-248.num_slabs
     25.50            +0.0%      25.50        slabinfo.bio-296.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-296.active_slabs
     25.50            +0.0%      25.50        slabinfo.bio-296.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-296.num_slabs
     49.00 ± 20%      -7.1%      45.50 ± 17%  slabinfo.bio-360.active_objs
      1.17 ± 20%      -7.1%       1.08 ± 17%  slabinfo.bio-360.active_slabs
     49.00 ± 20%      -7.1%      45.50 ± 17%  slabinfo.bio-360.num_objs
      1.17 ± 20%      -7.1%       1.08 ± 17%  slabinfo.bio-360.num_slabs
     21.00            +0.0%      21.00        slabinfo.bio-376.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-376.active_slabs
     21.00            +0.0%      21.00        slabinfo.bio-376.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-376.num_slabs
     18.00            +0.0%      18.00        slabinfo.bio-432.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-432.active_slabs
     18.00            +0.0%      18.00        slabinfo.bio-432.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-432.num_slabs
     85.00            +0.0%      85.00        slabinfo.bio_post_read_ctx.active_objs
      1.00            +0.0%       1.00        slabinfo.bio_post_read_ctx.active_slabs
     85.00            +0.0%      85.00        slabinfo.bio_post_read_ctx.num_objs
      1.00            +0.0%       1.00        slabinfo.bio_post_read_ctx.num_slabs
     38.67 ± 18%     +20.7%      46.67 ± 20%  slabinfo.biovec-128.active_objs
      2.42 ± 18%     +20.7%       2.92 ± 20%  slabinfo.biovec-128.active_slabs
     38.67 ± 18%     +20.7%      46.67 ± 20%  slabinfo.biovec-128.num_objs
      2.42 ± 18%     +20.7%       2.92 ± 20%  slabinfo.biovec-128.num_slabs
     31.27 ±  4%      +2.1%      31.93        slabinfo.biovec-max.active_objs
      3.91 ±  4%      +2.1%       3.99        slabinfo.biovec-max.active_slabs
     31.27 ±  4%      +2.1%      31.93        slabinfo.biovec-max.num_objs
      3.91 ±  4%      +2.1%       3.99        slabinfo.biovec-max.num_slabs
     22.67 ± 35%     -12.5%      19.83 ± 31%  slabinfo.btrfs_extent_buffer.active_objs
      0.67 ± 35%     -12.5%       0.58 ± 31%  slabinfo.btrfs_extent_buffer.active_slabs
     22.67 ± 35%     -12.5%      19.83 ± 31%  slabinfo.btrfs_extent_buffer.num_objs
      0.67 ± 35%     -12.5%       0.58 ± 31%  slabinfo.btrfs_extent_buffer.num_slabs
     19.50            +0.0%      19.50        slabinfo.btrfs_free_space.active_objs
      0.50            +0.0%       0.50        slabinfo.btrfs_free_space.active_slabs
     19.50            +0.0%      19.50        slabinfo.btrfs_free_space.num_objs
      0.50            +0.0%       0.50        slabinfo.btrfs_free_space.num_slabs
     57.50 ±  9%      +4.3%      60.00        slabinfo.btrfs_inode.active_objs
      1.92 ±  9%      +4.3%       2.00        slabinfo.btrfs_inode.active_slabs
     57.50 ±  9%      +4.3%      60.00        slabinfo.btrfs_inode.num_objs
      1.92 ±  9%      +4.3%       2.00        slabinfo.btrfs_inode.num_slabs
    196.30 ±  7%      -2.9%     190.70 ± 12%  slabinfo.btrfs_path.active_objs
      5.45 ±  7%      -2.9%       5.30 ± 12%  slabinfo.btrfs_path.active_slabs
    196.30 ±  7%      -2.9%     190.70 ± 12%  slabinfo.btrfs_path.num_objs
      5.45 ±  7%      -2.9%       5.30 ± 12%  slabinfo.btrfs_path.num_slabs
    172.25 ± 10%      +5.7%     182.00 ±  7%  slabinfo.buffer_head.active_objs
      4.42 ± 10%      +5.7%       4.67 ±  7%  slabinfo.buffer_head.active_slabs
    172.25 ± 10%      +5.7%     182.00 ±  7%  slabinfo.buffer_head.num_objs
      4.42 ± 10%      +5.7%       4.67 ±  7%  slabinfo.buffer_head.num_slabs
     23.00           +50.0%      34.50 ± 33%  slabinfo.configfs_dir_cache.active_objs
      0.50           +50.0%       0.75 ± 33%  slabinfo.configfs_dir_cache.active_slabs
     23.00           +50.0%      34.50 ± 33%  slabinfo.configfs_dir_cache.num_objs
      0.50           +50.0%       0.75 ± 33%  slabinfo.configfs_dir_cache.num_slabs
      3091 ±  4%      -2.9%       3002        slabinfo.cred.active_objs
     73.61 ±  4%      -2.9%      71.49        slabinfo.cred.active_slabs
      3091 ±  4%      -2.9%       3002        slabinfo.cred.num_objs
     73.61 ±  4%      -2.9%      71.49        slabinfo.cred.num_slabs
     58.50            -5.6%      55.25 ± 13%  slabinfo.dax_cache.active_objs
      1.50            -5.6%       1.42 ± 13%  slabinfo.dax_cache.active_slabs
     58.50            -5.6%      55.25 ± 13%  slabinfo.dax_cache.num_objs
      1.50            -5.6%       1.42 ± 13%  slabinfo.dax_cache.num_slabs
     44931            +0.3%      45088        slabinfo.dentry.active_objs
      1179 ±  3%      +0.1%       1180        slabinfo.dentry.active_slabs
     49551 ±  3%      +0.1%      49581        slabinfo.dentry.num_objs
      1179 ±  3%      +0.1%       1180        slabinfo.dentry.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.active_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-128.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.num_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-128.num_slabs
      7.50            +0.0%       7.50        slabinfo.dmaengine-unmap-256.active_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-256.active_slabs
      7.50            +0.0%       7.50        slabinfo.dmaengine-unmap-256.num_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-256.num_slabs
      7238 ±  7%      -1.3%       7141 ± 11%  slabinfo.ep_head.active_objs
     28.27 ±  7%      -1.3%      27.90 ± 11%  slabinfo.ep_head.active_slabs
      7238 ±  7%      -1.3%       7141 ± 11%  slabinfo.ep_head.num_objs
     28.27 ±  7%      -1.3%      27.90 ± 11%  slabinfo.ep_head.num_slabs
    941.28 ±  8%      +8.3%       1018 ±  4%  slabinfo.file_lock_cache.active_objs
     22.41 ±  8%      +8.3%      24.26 ±  4%  slabinfo.file_lock_cache.active_slabs
    941.28 ±  8%      +8.3%       1018 ±  4%  slabinfo.file_lock_cache.num_objs
     22.41 ±  8%      +8.3%      24.26 ±  4%  slabinfo.file_lock_cache.num_slabs
      2175            -0.9%       2156 ±  2%  slabinfo.files_cache.active_objs
     47.29            -0.9%      46.89 ±  2%  slabinfo.files_cache.active_slabs
      2175            -0.9%       2156 ±  2%  slabinfo.files_cache.num_objs
     47.29            -0.9%      46.89 ±  2%  slabinfo.files_cache.num_slabs
      4502 ±  3%      -3.5%       4342 ±  4%  slabinfo.filp.active_objs
    141.59 ±  3%      -3.7%     136.40 ±  4%  slabinfo.filp.active_slabs
      4530 ±  3%      -3.7%       4364 ±  4%  slabinfo.filp.num_objs
    141.59 ±  3%      -3.7%     136.40 ±  4%  slabinfo.filp.num_slabs
      0.95 ±223%    -100.0%       0.00        slabinfo.fscache_cookie_jar.active_objs
      0.02 ±223%    -100.0%       0.00        slabinfo.fscache_cookie_jar.active_slabs
      0.95 ±223%    -100.0%       0.00        slabinfo.fscache_cookie_jar.num_objs
      0.02 ±223%    -100.0%       0.00        slabinfo.fscache_cookie_jar.num_slabs
      5074 ±  2%      +1.2%       5133 ±  2%  slabinfo.ftrace_event_field.active_objs
     69.52 ±  2%      +1.2%      70.33 ±  2%  slabinfo.ftrace_event_field.active_slabs
      5074 ±  2%      +1.2%       5133 ±  2%  slabinfo.ftrace_event_field.num_objs
     69.52 ±  2%      +1.2%      70.33 ±  2%  slabinfo.ftrace_event_field.num_slabs
     51.00            +0.0%      51.00        slabinfo.hugetlbfs_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     51.00            +0.0%      51.00        slabinfo.hugetlbfs_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     34406            -0.8%      34122        slabinfo.inode_cache.active_objs
    708.39            +0.0%     708.65        slabinfo.inode_cache.active_slabs
     36127            +0.0%      36141        slabinfo.inode_cache.num_objs
    708.39            +0.0%     708.65        slabinfo.inode_cache.num_slabs
    242.09 ± 13%     +15.4%     279.44 ±  8%  slabinfo.iommu_iova_magazine.active_objs
      7.57 ± 13%     +15.4%       8.73 ±  8%  slabinfo.iommu_iova_magazine.active_slabs
    242.09 ± 13%     +15.4%     279.44 ±  8%  slabinfo.iommu_iova_magazine.num_objs
      7.57 ± 13%     +15.4%       8.73 ±  8%  slabinfo.iommu_iova_magazine.num_slabs
     41.76            +4.1%      43.46 ±  4%  slabinfo.ip6-frags.active_objs
      0.95            +4.1%       0.99 ±  4%  slabinfo.ip6-frags.active_slabs
     41.76            +4.1%      43.46 ±  4%  slabinfo.ip6-frags.num_objs
      0.95            +4.1%       0.99 ±  4%  slabinfo.ip6-frags.num_slabs
     97.33 ± 17%      +0.0%      97.33 ± 17%  slabinfo.ip_fib_alias.active_objs
      1.33 ± 17%      +0.0%       1.33 ± 17%  slabinfo.ip_fib_alias.active_slabs
     97.33 ± 17%      +0.0%      97.33 ± 17%  slabinfo.ip_fib_alias.num_objs
      1.33 ± 17%      +0.0%       1.33 ± 17%  slabinfo.ip_fib_alias.num_slabs
    113.33 ± 17%      +0.0%     113.33 ± 17%  slabinfo.ip_fib_trie.active_objs
      1.33 ± 17%      +0.0%       1.33 ± 17%  slabinfo.ip_fib_trie.active_slabs
    113.33 ± 17%      +0.0%     113.33 ± 17%  slabinfo.ip_fib_trie.num_objs
      1.33 ± 17%      +0.0%       1.33 ± 17%  slabinfo.ip_fib_trie.num_slabs
     44643            -0.0%      44639        slabinfo.kernfs_node_cache.active_objs
    744.06            -0.0%     743.98        slabinfo.kernfs_node_cache.active_slabs
     44643            -0.0%      44639        slabinfo.kernfs_node_cache.num_objs
    744.06            -0.0%     743.98        slabinfo.kernfs_node_cache.num_slabs
      2120 ± 11%      -7.5%       1962 ± 26%  slabinfo.khugepaged_mm_slot.active_objs
     20.79 ± 11%      -7.5%      19.24 ± 26%  slabinfo.khugepaged_mm_slot.active_slabs
      2120 ± 11%      -7.5%       1962 ± 26%  slabinfo.khugepaged_mm_slot.num_objs
     20.79 ± 11%      -7.5%      19.24 ± 26%  slabinfo.khugepaged_mm_slot.num_slabs
      2947            +0.5%       2963        slabinfo.kmalloc-128.active_objs
     92.33            +0.4%      92.73        slabinfo.kmalloc-128.active_slabs
      2954            +0.4%       2967        slabinfo.kmalloc-128.num_objs
     92.33            +0.4%      92.73        slabinfo.kmalloc-128.num_slabs
     19368            -1.8%      19024        slabinfo.kmalloc-16.active_objs
     76.94            -2.1%      75.33        slabinfo.kmalloc-16.active_slabs
     19696            -2.1%      19285        slabinfo.kmalloc-16.num_objs
     76.94            -2.1%      75.33        slabinfo.kmalloc-16.num_slabs
      3088 ±  2%      +0.3%       3097        slabinfo.kmalloc-192.active_objs
     74.00 ±  2%      +0.2%      74.15        slabinfo.kmalloc-192.active_slabs
      3107 ±  2%      +0.2%       3114        slabinfo.kmalloc-192.num_objs
     74.00 ±  2%      +0.2%      74.15        slabinfo.kmalloc-192.num_slabs
      2769            +1.1%       2798        slabinfo.kmalloc-1k.active_objs
     87.24            +0.9%      88.03        slabinfo.kmalloc-1k.active_slabs
      2791            +0.9%       2816        slabinfo.kmalloc-1k.num_objs
     87.24            +0.9%      88.03        slabinfo.kmalloc-1k.num_slabs
      2974            -0.2%       2970        slabinfo.kmalloc-256.active_objs
     93.57            -0.0%      93.56        slabinfo.kmalloc-256.active_slabs
      2994            -0.0%       2993        slabinfo.kmalloc-256.num_objs
     93.57            -0.0%      93.56        slabinfo.kmalloc-256.num_slabs
      1913            -0.1%       1910        slabinfo.kmalloc-2k.active_objs
    120.85            -0.2%     120.58        slabinfo.kmalloc-2k.active_slabs
      1933            -0.2%       1929        slabinfo.kmalloc-2k.num_objs
    120.85            -0.2%     120.58        slabinfo.kmalloc-2k.num_slabs
    160114            -2.3%     156511 ±  2%  slabinfo.kmalloc-32.active_objs
      1251            -2.2%       1224 ±  2%  slabinfo.kmalloc-32.active_slabs
    160244            -2.2%     156708 ±  2%  slabinfo.kmalloc-32.num_objs
      1251            -2.2%       1224 ±  2%  slabinfo.kmalloc-32.num_slabs
    825.92            -0.2%     823.94        slabinfo.kmalloc-4k.active_objs
    103.24            -0.2%     103.04        slabinfo.kmalloc-4k.active_slabs
    825.92            -0.2%     824.30        slabinfo.kmalloc-4k.num_objs
    103.24            -0.2%     103.04        slabinfo.kmalloc-4k.num_slabs
      6624            +0.4%       6653        slabinfo.kmalloc-512.active_objs
    211.36            +0.0%     211.37        slabinfo.kmalloc-512.active_slabs
      6763            +0.0%       6763        slabinfo.kmalloc-512.num_objs
    211.36            +0.0%     211.37        slabinfo.kmalloc-512.num_slabs
     26707            -0.6%      26549        slabinfo.kmalloc-64.active_objs
    417.60            -0.6%     415.29        slabinfo.kmalloc-64.active_slabs
     26726            -0.6%      26578        slabinfo.kmalloc-64.num_objs
    417.60            -0.6%     415.29        slabinfo.kmalloc-64.num_slabs
     26836            -0.3%      26756        slabinfo.kmalloc-8.active_objs
     52.42            -0.2%      52.33        slabinfo.kmalloc-8.active_slabs
     26836            -0.2%      26794        slabinfo.kmalloc-8.num_objs
     52.42            -0.2%      52.33        slabinfo.kmalloc-8.num_slabs
    423.30            -0.0%     423.20        slabinfo.kmalloc-8k.active_objs
    105.89            -0.0%     105.89        slabinfo.kmalloc-8k.active_slabs
    423.56            -0.0%     423.56        slabinfo.kmalloc-8k.num_objs
    105.89            -0.0%     105.89        slabinfo.kmalloc-8k.num_slabs
      6526 ±  4%      +0.7%       6572 ±  5%  slabinfo.kmalloc-96.active_objs
    161.44 ±  3%      +0.7%     162.57 ±  4%  slabinfo.kmalloc-96.active_slabs
      6780 ±  3%      +0.7%       6828 ±  4%  slabinfo.kmalloc-96.num_objs
    161.44 ±  3%      +0.7%     162.57 ±  4%  slabinfo.kmalloc-96.num_slabs
    456.00 ±  7%      +1.2%     461.33 ±  4%  slabinfo.kmalloc-cg-128.active_objs
     14.25 ±  7%      +1.2%      14.42 ±  4%  slabinfo.kmalloc-cg-128.active_slabs
    456.00 ±  7%      +1.2%     461.33 ±  4%  slabinfo.kmalloc-cg-128.num_objs
     14.25 ±  7%      +1.2%      14.42 ±  4%  slabinfo.kmalloc-cg-128.num_slabs
      2729 ±  6%      +3.1%       2814 ±  5%  slabinfo.kmalloc-cg-16.active_objs
     10.66 ±  6%      +3.1%      11.00 ±  5%  slabinfo.kmalloc-cg-16.active_slabs
      2729 ±  6%      +3.1%       2814 ±  5%  slabinfo.kmalloc-cg-16.num_objs
     10.66 ±  6%      +3.1%      11.00 ±  5%  slabinfo.kmalloc-cg-16.num_slabs
      2071            -2.6%       2016 ±  2%  slabinfo.kmalloc-cg-192.active_objs
     49.32            -2.6%      48.02 ±  2%  slabinfo.kmalloc-cg-192.active_slabs
      2071            -2.6%       2016 ±  2%  slabinfo.kmalloc-cg-192.num_objs
     49.32            -2.6%      48.02 ±  2%  slabinfo.kmalloc-cg-192.num_slabs
      1641            +2.9%       1689 ±  2%  slabinfo.kmalloc-cg-1k.active_objs
     51.30            +2.9%      52.79 ±  2%  slabinfo.kmalloc-cg-1k.active_slabs
      1641            +2.9%       1689 ±  2%  slabinfo.kmalloc-cg-1k.num_objs
     51.30            +2.9%      52.79 ±  2%  slabinfo.kmalloc-cg-1k.num_slabs
    306.67 ±  4%      +0.1%     306.83 ±  3%  slabinfo.kmalloc-cg-256.active_objs
      9.58 ±  4%      +0.9%       9.67 ±  3%  slabinfo.kmalloc-cg-256.active_slabs
    306.67 ±  4%      +0.9%     309.33 ±  3%  slabinfo.kmalloc-cg-256.num_objs
      9.58 ±  4%      +0.9%       9.67 ±  3%  slabinfo.kmalloc-cg-256.num_slabs
    399.64 ±  4%      +1.3%     404.90 ±  2%  slabinfo.kmalloc-cg-2k.active_objs
     24.98 ±  4%      +1.3%      25.31 ±  2%  slabinfo.kmalloc-cg-2k.active_slabs
    399.64 ±  4%      +1.3%     404.90 ±  2%  slabinfo.kmalloc-cg-2k.num_objs
     24.98 ±  4%      +1.3%      25.31 ±  2%  slabinfo.kmalloc-cg-2k.num_slabs
      5989            +0.7%       6032        slabinfo.kmalloc-cg-32.active_objs
     46.79            +0.7%      47.13        slabinfo.kmalloc-cg-32.active_slabs
      5989            +0.7%       6032        slabinfo.kmalloc-cg-32.num_objs
     46.79            +0.7%      47.13        slabinfo.kmalloc-cg-32.num_slabs
    450.67            -0.7%     447.33        slabinfo.kmalloc-cg-4k.active_objs
     56.33            -0.7%      55.92        slabinfo.kmalloc-cg-4k.active_slabs
    450.67            -0.7%     447.33        slabinfo.kmalloc-cg-4k.num_objs
     56.33            -0.7%      55.92        slabinfo.kmalloc-cg-4k.num_slabs
      1539            +1.3%       1560        slabinfo.kmalloc-cg-512.active_objs
     48.11            +1.3%      48.75        slabinfo.kmalloc-cg-512.active_slabs
      1539            +1.3%       1560        slabinfo.kmalloc-cg-512.num_objs
     48.11            +1.3%      48.75        slabinfo.kmalloc-cg-512.num_slabs
      1256 ±  8%      -4.7%       1197 ±  8%  slabinfo.kmalloc-cg-64.active_objs
     19.63 ±  8%      -4.7%      18.71 ±  8%  slabinfo.kmalloc-cg-64.active_slabs
      1256 ±  8%      -4.7%       1197 ±  8%  slabinfo.kmalloc-cg-64.num_objs
     19.63 ±  8%      -4.7%      18.71 ±  8%  slabinfo.kmalloc-cg-64.num_slabs
     24726            -0.1%      24704        slabinfo.kmalloc-cg-8.active_objs
     48.29            -0.1%      48.25        slabinfo.kmalloc-cg-8.active_slabs
     24726            -0.1%      24704        slabinfo.kmalloc-cg-8.num_objs
     48.29            -0.1%      48.25        slabinfo.kmalloc-cg-8.num_slabs
     17.35 ±  7%      +5.8%      18.36 ±  4%  slabinfo.kmalloc-cg-8k.active_objs
      4.34 ±  7%      +5.8%       4.59 ±  4%  slabinfo.kmalloc-cg-8k.active_slabs
     17.35 ±  7%      +5.8%      18.36 ±  4%  slabinfo.kmalloc-cg-8k.num_objs
      4.34 ±  7%      +5.8%       4.59 ±  4%  slabinfo.kmalloc-cg-8k.num_slabs
      1628 ±  3%      +0.8%       1640        slabinfo.kmalloc-cg-96.active_objs
     38.76 ±  3%      +0.8%      39.06        slabinfo.kmalloc-cg-96.active_slabs
      1628 ±  3%      +0.8%       1640        slabinfo.kmalloc-cg-96.num_objs
     38.76 ±  3%      +0.8%      39.06        slabinfo.kmalloc-cg-96.num_slabs
    131.30 ± 14%      +4.1%     136.73 ±  9%  slabinfo.kmalloc-rcl-128.active_objs
      4.10 ± 14%      +4.1%       4.27 ±  9%  slabinfo.kmalloc-rcl-128.active_slabs
    131.30 ± 14%      +4.1%     136.73 ±  9%  slabinfo.kmalloc-rcl-128.num_objs
      4.10 ± 14%      +4.1%       4.27 ±  9%  slabinfo.kmalloc-rcl-128.num_slabs
     87.50 ± 16%     +12.0%      98.00 ± 10%  slabinfo.kmalloc-rcl-192.active_objs
      2.08 ± 16%     +12.0%       2.33 ± 10%  slabinfo.kmalloc-rcl-192.active_slabs
     87.50 ± 16%     +12.0%      98.00 ± 10%  slabinfo.kmalloc-rcl-192.num_objs
      2.08 ± 16%     +12.0%       2.33 ± 10%  slabinfo.kmalloc-rcl-192.num_slabs
      2512 ±  6%      -0.4%       2501 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
     39.25 ±  6%      -0.4%      39.08 ±  5%  slabinfo.kmalloc-rcl-64.active_slabs
      2512 ±  6%      -0.4%       2501 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
     39.25 ±  6%      -0.4%      39.08 ±  5%  slabinfo.kmalloc-rcl-64.num_slabs
      1165            -0.6%       1158 ±  5%  slabinfo.kmalloc-rcl-96.active_objs
     27.75            -0.6%      27.59 ±  5%  slabinfo.kmalloc-rcl-96.active_slabs
      1165            -0.6%       1158 ±  5%  slabinfo.kmalloc-rcl-96.num_objs
     27.75            -0.6%      27.59 ±  5%  slabinfo.kmalloc-rcl-96.num_slabs
    308.90 ±  2%      +1.7%     314.19 ±  2%  slabinfo.kmem_cache.active_objs
      9.65 ±  2%      +1.7%       9.82 ±  2%  slabinfo.kmem_cache.active_slabs
    308.90 ±  2%      +1.7%     314.19 ±  2%  slabinfo.kmem_cache.num_objs
      9.65 ±  2%      +1.7%       9.82 ±  2%  slabinfo.kmem_cache.num_slabs
    656.19 ±  2%      +0.8%     661.53 ±  3%  slabinfo.kmem_cache_node.active_objs
     10.64 ±  2%      +0.8%      10.73 ±  3%  slabinfo.kmem_cache_node.active_slabs
    681.23 ±  2%      +0.8%     686.58 ±  3%  slabinfo.kmem_cache_node.num_objs
     10.64 ±  2%      +0.8%      10.73 ±  3%  slabinfo.kmem_cache_node.num_slabs
      9952 ±  2%      -1.7%       9784 ±  4%  slabinfo.lsm_file_cache.active_objs
     59.11 ±  2%      -1.7%      58.11 ±  4%  slabinfo.lsm_file_cache.active_slabs
     10048 ±  2%      -1.7%       9878 ±  4%  slabinfo.lsm_file_cache.num_objs
     59.11 ±  2%      -1.7%      58.11 ±  4%  slabinfo.lsm_file_cache.num_slabs
     40511 ±  2%      -0.4%      40357        slabinfo.lsm_inode_cache.active_objs
    659.91 ±  2%      +0.0%     659.96        slabinfo.lsm_inode_cache.active_slabs
     42234 ±  2%      +0.0%      42237        slabinfo.lsm_inode_cache.num_objs
    659.91 ±  2%      +0.0%     659.96        slabinfo.lsm_inode_cache.num_slabs
      5852 ±  2%      +0.3%       5872 ±  2%  slabinfo.maple_node.active_objs
    191.93 ±  3%      -1.2%     189.56 ±  2%  slabinfo.maple_node.active_slabs
      6141 ±  3%      -1.2%       6065 ±  2%  slabinfo.maple_node.num_objs
    191.93 ±  3%      -1.2%     189.56 ±  2%  slabinfo.maple_node.num_slabs
      1224            -1.3%       1207        slabinfo.mm_struct.active_objs
     51.01            -1.3%      50.33        slabinfo.mm_struct.active_slabs
      1224            -1.3%       1207        slabinfo.mm_struct.num_objs
     51.01            -1.3%      50.33        slabinfo.mm_struct.num_slabs
    584.00 ± 12%      +2.4%     597.95 ±  5%  slabinfo.mnt_cache.active_objs
     13.90 ± 12%      +2.4%      14.24 ±  5%  slabinfo.mnt_cache.active_slabs
    584.00 ± 12%      +2.4%     597.95 ±  5%  slabinfo.mnt_cache.num_objs
     13.90 ± 12%      +2.4%      14.24 ±  5%  slabinfo.mnt_cache.num_slabs
     17.00            +0.0%      17.00        slabinfo.mqueue_inode_cache.active_objs
      0.50            +0.0%       0.50        slabinfo.mqueue_inode_cache.active_slabs
     17.00            +0.0%      17.00        slabinfo.mqueue_inode_cache.num_objs
      0.50            +0.0%       0.50        slabinfo.mqueue_inode_cache.num_slabs
    384.00            +0.0%     384.00        slabinfo.names_cache.active_objs
     48.00            +0.0%      48.00        slabinfo.names_cache.active_slabs
    384.00            +0.0%     384.00        slabinfo.names_cache.num_objs
     48.00            +0.0%      48.00        slabinfo.names_cache.num_slabs
      3.50            +0.0%       3.50        slabinfo.net_namespace.active_objs
      0.50            +0.0%       0.50        slabinfo.net_namespace.active_slabs
      3.50            +0.0%       3.50        slabinfo.net_namespace.num_objs
      0.50            +0.0%       0.50        slabinfo.net_namespace.num_slabs
     23.00            +0.0%      23.00        slabinfo.nfs_commit_data.active_objs
      0.50            +0.0%       0.50        slabinfo.nfs_commit_data.active_slabs
     23.00            +0.0%      23.00        slabinfo.nfs_commit_data.num_objs
      0.50            +0.0%       0.50        slabinfo.nfs_commit_data.num_slabs
     17.00            +0.0%      17.00        slabinfo.nfs_read_data.active_objs
      0.50            +0.0%       0.50        slabinfo.nfs_read_data.active_slabs
     17.00            +0.0%      17.00        slabinfo.nfs_read_data.num_objs
      0.50            +0.0%       0.50        slabinfo.nfs_read_data.num_slabs
    201.04 ± 13%      +8.5%     218.11 ±  6%  slabinfo.nsproxy.active_objs
      3.59 ± 13%      +8.5%       3.89 ±  6%  slabinfo.nsproxy.active_slabs
    201.04 ± 13%      +8.5%     218.11 ±  6%  slabinfo.nsproxy.num_objs
      3.59 ± 13%      +8.5%       3.89 ±  6%  slabinfo.nsproxy.num_slabs
    706.46 ±  9%      -5.8%     665.23 ±  7%  slabinfo.numa_policy.active_objs
     11.77 ±  9%      -5.8%      11.09 ±  7%  slabinfo.numa_policy.active_slabs
    706.46 ±  9%      -5.8%     665.23 ±  7%  slabinfo.numa_policy.num_objs
     11.77 ±  9%      -5.8%      11.09 ±  7%  slabinfo.numa_policy.num_slabs
      2122            -0.3%       2116        slabinfo.perf_event.active_objs
     82.43            +0.1%      82.49        slabinfo.perf_event.active_slabs
      2143            +0.1%       2144        slabinfo.perf_event.num_objs
     82.43            +0.1%      82.49        slabinfo.perf_event.num_slabs
      2452 ±  2%      -2.2%       2399 ±  2%  slabinfo.pid.active_objs
     77.23 ±  2%      -2.7%      75.18 ±  3%  slabinfo.pid.active_slabs
      2471 ±  2%      -2.7%       2405 ±  3%  slabinfo.pid.num_objs
     77.23 ±  2%      -2.7%      75.18 ±  3%  slabinfo.pid.num_slabs
      4674            +0.5%       4695        slabinfo.pool_workqueue.active_objs
    146.46            +0.5%     147.14        slabinfo.pool_workqueue.active_slabs
      4686            +0.5%       4708        slabinfo.pool_workqueue.num_objs
    146.46            +0.5%     147.14        slabinfo.pool_workqueue.num_slabs
    106.52 ± 15%      -0.7%     105.79 ± 18%  slabinfo.posix_timers_cache.active_objs
      3.33 ± 15%      -0.7%       3.31 ± 18%  slabinfo.posix_timers_cache.active_slabs
    106.52 ± 15%      -0.7%     105.79 ± 18%  slabinfo.posix_timers_cache.num_objs
      3.33 ± 15%      -0.7%       3.31 ± 18%  slabinfo.posix_timers_cache.num_slabs
      1948            +1.5%       1977        slabinfo.proc_dir_entry.active_objs
     46.41            +1.4%      47.08        slabinfo.proc_dir_entry.active_slabs
      1949            +1.4%       1977        slabinfo.proc_dir_entry.num_objs
     46.41            +1.4%      47.08        slabinfo.proc_dir_entry.num_slabs
      5141 ±  8%      +4.1%       5353 ±  4%  slabinfo.proc_inode_cache.active_objs
    113.77 ±  8%      +4.2%     118.59 ±  4%  slabinfo.proc_inode_cache.active_slabs
      5233 ±  8%      +4.2%       5455 ±  4%  slabinfo.proc_inode_cache.num_objs
    113.77 ±  8%      +4.2%     118.59 ±  4%  slabinfo.proc_inode_cache.num_slabs
     18396            -0.5%      18306        slabinfo.radix_tree_node.active_objs
    329.83            -0.4%     328.54        slabinfo.radix_tree_node.active_slabs
     18470            -0.4%      18398        slabinfo.radix_tree_node.num_objs
    329.83            -0.4%     328.54        slabinfo.radix_tree_node.num_slabs
    154.32 ±  4%      -0.0%     154.28 ±  4%  slabinfo.request_queue.active_objs
      4.41 ±  4%      +0.0%       4.41 ±  4%  slabinfo.request_queue.active_slabs
    154.32 ±  4%      +0.0%     154.32 ±  4%  slabinfo.request_queue.num_objs
      4.41 ±  4%      +0.0%       4.41 ±  4%  slabinfo.request_queue.num_slabs
     23.00            +0.0%      23.00        slabinfo.rpc_inode_cache.active_objs
      0.50            +0.0%       0.50        slabinfo.rpc_inode_cache.active_slabs
     23.00            +0.0%      23.00        slabinfo.rpc_inode_cache.num_objs
      0.50            +0.0%       0.50        slabinfo.rpc_inode_cache.num_slabs
    464.00            +0.0%     464.00        slabinfo.scsi_sense_cache.active_objs
     14.50            +0.0%      14.50        slabinfo.scsi_sense_cache.active_slabs
    464.00            +0.0%     464.00        slabinfo.scsi_sense_cache.num_objs
     14.50            +0.0%      14.50        slabinfo.scsi_sense_cache.num_slabs
      1632            -0.0%       1631        slabinfo.seq_file.active_objs
     48.00            -0.0%      48.00        slabinfo.seq_file.active_slabs
      1632            -0.0%       1631        slabinfo.seq_file.num_objs
     48.00            -0.0%      48.00        slabinfo.seq_file.num_slabs
     14665            +0.2%      14689        slabinfo.shared_policy_node.active_objs
    172.54            +0.2%     172.82        slabinfo.shared_policy_node.active_slabs
     14665            +0.2%      14689        slabinfo.shared_policy_node.num_objs
    172.54            +0.2%     172.82        slabinfo.shared_policy_node.num_slabs
      2472 ±  2%      +0.0%       2472 ±  3%  slabinfo.shmem_inode_cache.active_objs
     57.65 ±  2%      -0.1%      57.57 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      2479 ±  2%      -0.1%       2475 ±  3%  slabinfo.shmem_inode_cache.num_objs
     57.65 ±  2%      -0.1%      57.57 ±  3%  slabinfo.shmem_inode_cache.num_slabs
      1232            -1.1%       1219        slabinfo.sighand_cache.active_objs
     82.80            -1.4%      81.60        slabinfo.sighand_cache.active_slabs
      1241            -1.4%       1224        slabinfo.sighand_cache.num_objs
     82.80            -1.4%      81.60        slabinfo.sighand_cache.num_slabs
      2106 ±  2%      -3.3%       2036 ±  2%  slabinfo.signal_cache.active_objs
     76.16 ±  2%      -3.7%      73.34 ±  3%  slabinfo.signal_cache.active_slabs
      2132 ±  2%      -3.7%       2053 ±  3%  slabinfo.signal_cache.num_objs
     76.16 ±  2%      -3.7%      73.34 ±  3%  slabinfo.signal_cache.num_slabs
      2443            -0.6%       2427        slabinfo.sigqueue.active_objs
     47.90            -0.6%      47.60        slabinfo.sigqueue.active_slabs
      2443            -0.6%       2427        slabinfo.sigqueue.num_objs
     47.90            -0.6%      47.60        slabinfo.sigqueue.num_slabs
    256.00            +0.0%     256.00        slabinfo.skbuff_ext_cache.active_objs
     13.00            +0.0%      13.00        slabinfo.skbuff_ext_cache.active_slabs
    416.00            +0.0%     416.00        slabinfo.skbuff_ext_cache.num_objs
     13.00            +0.0%      13.00        slabinfo.skbuff_ext_cache.num_slabs
      2008            +1.0%       2029 ±  2%  slabinfo.skbuff_head_cache.active_objs
     63.86            +1.5%      64.83        slabinfo.skbuff_head_cache.active_slabs
      2043            +1.5%       2074        slabinfo.skbuff_head_cache.num_objs
     63.86            +1.5%      64.83        slabinfo.skbuff_head_cache.num_slabs
      2667 ±  3%      -0.6%       2652        slabinfo.skbuff_small_head.active_objs
     52.30 ±  3%      -0.6%      52.00        slabinfo.skbuff_small_head.active_slabs
      2667 ±  3%      -0.6%       2652        slabinfo.skbuff_small_head.num_objs
     52.30 ±  3%      -0.6%      52.00        slabinfo.skbuff_small_head.num_slabs
      1551 ±  6%      +1.9%       1581 ±  2%  slabinfo.sock_inode_cache.active_objs
     39.79 ±  6%      +1.9%      40.56 ±  2%  slabinfo.sock_inode_cache.active_slabs
      1551 ±  6%      +1.9%       1581 ±  2%  slabinfo.sock_inode_cache.num_objs
     39.79 ±  6%      +1.9%      40.56 ±  2%  slabinfo.sock_inode_cache.num_slabs
    730.92 ± 10%      +2.9%     752.17 ±  9%  slabinfo.task_group.active_objs
     14.33 ± 10%      +2.9%      14.75 ±  9%  slabinfo.task_group.active_slabs
    730.92 ± 10%      +2.9%     752.17 ±  9%  slabinfo.task_group.num_objs
     14.33 ± 10%      +2.9%      14.75 ±  9%  slabinfo.task_group.num_slabs
    913.66            -0.9%     905.14        slabinfo.task_struct.active_objs
    457.94            -1.0%     453.50        slabinfo.task_struct.active_slabs
    915.87            -1.0%     907.00        slabinfo.task_struct.num_objs
    457.94            -1.0%     453.50        slabinfo.task_struct.num_slabs
    599.20 ± 17%     -13.6%     517.72 ± 21%  slabinfo.taskstats.active_objs
     16.19 ± 17%     -13.6%      13.99 ± 21%  slabinfo.taskstats.active_slabs
    599.20 ± 17%     -13.6%     517.72 ± 21%  slabinfo.taskstats.num_objs
     16.19 ± 17%     -13.6%      13.99 ± 21%  slabinfo.taskstats.num_slabs
      1536            +0.2%       1540        slabinfo.trace_event_file.active_objs
     36.59            +0.2%      36.68        slabinfo.trace_event_file.active_slabs
      1536            +0.2%       1540        slabinfo.trace_event_file.num_objs
     36.59            +0.2%      36.68        slabinfo.trace_event_file.num_slabs
    589.15 ±  2%      -0.4%     586.71        slabinfo.tracefs_inode_cache.active_objs
     12.02 ±  2%      -0.4%      11.97        slabinfo.tracefs_inode_cache.active_slabs
    589.15 ±  2%      -0.4%     586.71        slabinfo.tracefs_inode_cache.num_objs
     12.02 ±  2%      -0.4%      11.97        slabinfo.tracefs_inode_cache.num_slabs
     16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.active_objs
      0.50            +0.0%       0.50        slabinfo.tw_sock_TCP.active_slabs
     16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.num_objs
      0.50            +0.0%       0.50        slabinfo.tw_sock_TCP.num_slabs
     51.00            +0.0%      51.00        slabinfo.user_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.user_namespace.active_slabs
     51.00            +0.0%      51.00        slabinfo.user_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.user_namespace.num_slabs
     37.00            +0.0%      37.00        slabinfo.uts_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.uts_namespace.active_slabs
     37.00            +0.0%      37.00        slabinfo.uts_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.uts_namespace.num_slabs
     10913 ±  2%      -0.7%      10835 ±  3%  slabinfo.vm_area_struct.active_objs
    240.93 ±  3%      -1.0%     238.61 ±  4%  slabinfo.vm_area_struct.active_slabs
     11082 ±  3%      -1.0%      10975 ±  4%  slabinfo.vm_area_struct.num_objs
    240.93 ±  3%      -1.0%     238.61 ±  4%  slabinfo.vm_area_struct.num_slabs
     14976 ±  3%      -1.9%      14686 ±  4%  slabinfo.vma_lock.active_objs
    154.91 ±  6%      -4.0%     148.64 ±  6%  slabinfo.vma_lock.active_slabs
     15800 ±  6%      -4.0%      15161 ±  6%  slabinfo.vma_lock.num_objs
    154.91 ±  6%      -4.0%     148.64 ±  6%  slabinfo.vma_lock.num_slabs
    104602            +0.0%     104610        slabinfo.vmap_area.active_objs
      1869            +0.0%       1869        slabinfo.vmap_area.active_slabs
    104664            +0.0%     104673        slabinfo.vmap_area.num_objs
      1869            +0.0%       1869        slabinfo.vmap_area.num_slabs
    101.76 ± 17%      -2.7%      99.05 ± 15%  slabinfo.xfs_bnobt_cur.active_objs
      2.83 ± 17%      -2.7%       2.75 ± 15%  slabinfo.xfs_bnobt_cur.active_slabs
    101.76 ± 17%      -2.7%      99.05 ± 15%  slabinfo.xfs_bnobt_cur.num_objs
      2.83 ± 17%      -2.7%       2.75 ± 15%  slabinfo.xfs_bnobt_cur.num_slabs
    151.22 ± 22%      -6.3%     141.64 ± 10%  slabinfo.xfs_buf.active_objs
      3.60 ± 22%      -6.3%       3.37 ± 10%  slabinfo.xfs_buf.active_slabs
    151.22 ± 22%      -6.3%     141.64 ± 10%  slabinfo.xfs_buf.num_objs
      3.60 ± 22%      -6.3%       3.37 ± 10%  slabinfo.xfs_buf.num_slabs
     26.62 ±  6%     +20.4%      32.04 ± 20%  slabinfo.xfs_efd_item.active_objs
      0.72 ±  6%     +20.4%       0.87 ± 20%  slabinfo.xfs_efd_item.active_slabs
     26.62 ±  6%     +20.4%      32.04 ± 20%  slabinfo.xfs_efd_item.num_objs
      0.72 ±  6%     +20.4%       0.87 ± 20%  slabinfo.xfs_efd_item.num_slabs
    318.02 ±  6%      -6.8%     296.48 ± 21%  slabinfo.xfs_ili.active_objs
      7.95 ±  6%      -6.8%       7.41 ± 21%  slabinfo.xfs_ili.active_slabs
    318.02 ±  6%      -6.8%     296.48 ± 21%  slabinfo.xfs_ili.num_objs
      7.95 ±  6%      -6.8%       7.41 ± 21%  slabinfo.xfs_ili.num_slabs
    400.23 ±  5%      -5.2%     379.52 ± 13%  slabinfo.xfs_inobt_cur.active_objs
     10.26 ±  5%      -5.2%       9.73 ± 13%  slabinfo.xfs_inobt_cur.active_slabs
    400.23 ±  5%      -5.2%     379.52 ± 13%  slabinfo.xfs_inobt_cur.num_objs
     10.26 ±  5%      -5.2%       9.73 ± 13%  slabinfo.xfs_inobt_cur.num_slabs
    270.98 ±  5%      -7.4%     251.05 ± 21%  slabinfo.xfs_inode.active_objs
      8.47 ±  5%      -7.4%       7.85 ± 21%  slabinfo.xfs_inode.active_slabs
    270.98 ±  5%      -7.4%     251.05 ± 21%  slabinfo.xfs_inode.num_objs
      8.47 ±  5%      -7.4%       7.85 ± 21%  slabinfo.xfs_inode.num_slabs
    507.94 ±  8%      -4.9%     482.85 ± 11%  slabinfo.xfs_trans.active_objs
     14.51 ±  8%      -4.9%      13.80 ± 11%  slabinfo.xfs_trans.active_slabs
    507.94 ±  8%      -4.9%     482.85 ± 11%  slabinfo.xfs_trans.num_objs
     14.51 ±  8%      -4.9%      13.80 ± 11%  slabinfo.xfs_trans.num_slabs
     12.65 ±108%      -5.4        7.28 ± 18%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.calltrace.cycles-pp.main
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.calltrace.cycles-pp.run_builtin.main
      5.12 ±144%      -3.3        1.84 ± 81%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.main
      5.12 ±144%      -3.3        1.84 ± 81%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.main
      5.12 ±144%      -3.3        1.84 ± 81%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.main
      2.95 ±223%      -3.0        0.00        perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      2.95 ±223%      -3.0        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      2.95 ±223%      -3.0        0.00        perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      2.95 ±223%      -3.0        0.00        perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.95 ±223%      -3.0        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      3.40 ±211%      -2.9        0.54 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.perf_c2c__record
      3.40 ±211%      -2.9        0.54 ±223%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.perf_c2c__record.run_builtin
      2.95 ±223%      -2.8        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.95 ±223%      -2.8        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      2.95 ±223%      -2.8        0.14 ±223%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.95 ±223%      -2.8        0.14 ±223%  perf-profile.calltrace.cycles-pp.write
      9.70 ± 74%      -2.6        7.14 ± 15%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      9.70 ± 74%      -2.6        7.14 ± 15%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.51 ±223%      -2.5        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      1.77 ±223%      -1.8        0.00        perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      3.88 ± 50%      -1.6        2.24 ± 56%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.62 ±223%      -1.6        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      3.75 ± 53%      -1.5        2.24 ± 56%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write
      2.93 ±103%      -1.3        1.61 ±138%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.14 ± 44%      -1.1        2.02 ± 58%  perf-profile.calltrace.cycles-pp.open64
      1.50 ± 59%      -1.1        0.40 ±151%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50 ± 59%      -1.1        0.40 ±151%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92 ±103%      -1.1        0.82 ±100%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
      2.83 ± 49%      -1.1        1.75 ± 60%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.83 ± 49%      -1.1        1.75 ± 60%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.83 ± 49%      -1.1        1.75 ± 60%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.83 ± 49%      -1.1        1.75 ± 60%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      1.77 ± 94%      -1.0        0.82 ±100%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      2.36 ± 21%      -0.9        1.43 ± 43%  perf-profile.calltrace.cycles-pp._Fork
      1.22 ± 58%      -0.9        0.31 ±143%  perf-profile.calltrace.cycles-pp.__irqentry_text_end
      1.97 ± 46%      -0.9        1.07 ±109%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ± 46%      -0.9        1.07 ±109%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.56 ± 91%      -0.9        0.68 ± 81%  perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record
      1.56 ± 91%      -0.9        0.68 ± 81%  perf-profile.calltrace.cycles-pp.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record
      1.56 ± 91%      -0.9        0.68 ± 81%  perf-profile.calltrace.cycles-pp.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record
      1.02 ±125%      -0.9        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.92 ±103%      -0.8        1.09 ± 70%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      8.70 ± 14%      -0.8        7.91 ± 15%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main
      8.70 ± 14%      -0.8        7.91 ± 15%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main
      1.21 ± 74%      -0.8        0.42 ±154%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      1.36 ± 83%      -0.8        0.58 ±107%  perf-profile.calltrace.cycles-pp.__evlist__disable.__cmd_record.cmd_record.run_builtin.main
      3.76 ± 38%      -0.8        3.00 ± 50%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.76 ± 38%      -0.8        3.00 ± 50%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      1.02 ±125%      -0.8        0.26 ±141%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.74 ± 45%      -0.7        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.74 ± 45%      -0.7        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.74 ±223%      -0.7        0.00        perf-profile.calltrace.cycles-pp.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock
      0.74 ±223%      -0.7        0.00        perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.87 ±114%      -0.7        0.14 ±223%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.72 ±179%      -0.7        0.00        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      1.21 ± 74%      -0.7        0.56 ±114%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.19 ± 73%      -0.6        0.56 ±110%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.05 ± 58%      -0.6        0.42 ±154%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.05 ± 58%      -0.6        0.42 ±154%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.74 ± 85%      -0.6        0.14 ±223%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.74 ±132%      -0.6        0.14 ±223%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      0.60 ±117%      -0.6        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel.lookup_open
      0.60 ±141%      -0.6        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.60 ± 71%      -0.6        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.59 ±223%      -0.6        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all
      0.72 ± 78%      -0.6        0.14 ±223%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.24 ± 83%      -0.6        0.68 ± 81%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu
      1.24 ± 83%      -0.6        0.68 ± 81%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable
      1.24 ± 83%      -0.6        0.68 ± 81%  perf-profile.calltrace.cycles-pp.perf_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.37 ± 66%      -0.6        0.81 ± 99%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl
      1.07 ± 83%      -0.5        0.55 ± 70%  perf-profile.calltrace.cycles-pp.arch_show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      1.36 ± 52%      -0.5        0.84 ±115%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.76 ±126%      -0.5        0.28 ±141%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record.run_builtin
      1.03 ± 77%      -0.5        0.55 ±113%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.88 ±100%      -0.5        0.41 ±155%  perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.60 ± 71%      -0.5        0.14 ±223%  perf-profile.calltrace.cycles-pp.seq_printf.arch_show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      8.42 ± 30%      -0.5        7.96 ± 30%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.46 ±100%      -0.5        0.00        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.46 ±100%      -0.5        0.00        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.46 ±100%      -0.5        0.00        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.46 ±100%      -0.5        0.00        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task
      0.46 ±100%      -0.5        0.00        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ±154%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__d_alloc.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      0.46 ±154%      -0.5        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel.__lookup_slow
      0.59 ±115%      -0.5        0.14 ±223%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      0.90 ± 57%      -0.4        0.44 ±101%  perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_flush_all.console_unlock
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.fast_imageblit.sys_imageblit.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll.lf
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_flush_all
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_flush_all.console_unlock.vprintk_emit
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.sys_imageblit.drm_fbdev_generic_defio_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.vt_console_print.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      0.58 ±107%      -0.4        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.idle_cpu.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head
      0.44 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.calltrace.cycles-pp.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.43 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__output_copy.perf_output_copy.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event
      0.43 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.43 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.43 ±100%      -0.4        0.00        perf-profile.calltrace.cycles-pp.perf_output_copy.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap
      0.43 ±156%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.calltrace.cycles-pp.execve
      1.72 ± 92%      -0.4        1.30 ± 52%  perf-profile.calltrace.cycles-pp.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record.run_builtin
      1.08 ± 77%      -0.4        0.68 ± 81%  perf-profile.calltrace.cycles-pp._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.35 ± 64%      -0.4        0.98 ±116%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48 ± 58%      -0.4        1.11 ± 72%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      1.50 ± 56%      -0.4        1.15 ± 68%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.50 ± 56%      -0.4        1.15 ± 68%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.50 ± 56%      -0.4        1.15 ± 68%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      8.72 ± 28%      -0.3        8.37 ± 27%  perf-profile.calltrace.cycles-pp.read
      0.74 ± 85%      -0.3        0.41 ±100%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      0.74 ± 85%      -0.3        0.41 ±100%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      1.03 ± 77%      -0.3        0.69 ±130%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      1.17 ± 55%      -0.3        0.84 ± 83%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.78 ± 68%      -0.3        2.44 ± 46%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.42 ± 30%      -0.3        8.09 ± 27%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.33 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc
      0.33 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.clear_bhb_loop.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable
      0.33 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.memcg_check_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.46 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ± 71%      -0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.bitmap_string.vsnprintf.seq_printf.cpuset_task_status_allowed.proc_pid_status
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.cpuset_task_status_allowed.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.seq_printf.cpuset_task_status_allowed.proc_pid_status.proc_single_show.seq_read_iter
      0.32 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.cpuset_task_status_allowed.proc_pid_status.proc_single_show
      0.45 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_evsel__disable_cpu.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.45 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable.__cmd_record.cmd_record
      0.31 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.31 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.affinity__set.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record
      0.31 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__consume
      0.45 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.30 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.seq_read_iter.seq_read.vfs_read.ksys_read
      0.30 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter.seq_read.vfs_read
      0.30 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.30 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.irqentry_enter.exc_page_fault.asm_exc_page_fault.__libc_fork
      0.43 ±100%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.30 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.30 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_wr_store_entry.mas_store_prealloc.mmap_region.do_mmap
      0.58 ±107%      -0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.58 ±107%      -0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.pipe_read
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.69 ±168%      -0.3        0.40 ±149%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.29 ±142%      -0.3        0.00        perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.43 ±100%      -0.3        0.14 ±223%  perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.28 ±142%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof
      0.28 ±142%      -0.3        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.28 ±142%      -0.3        0.00        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
      0.28 ±142%      -0.3        0.00        perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof
      0.56 ±141%      -0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault.do_read_fault
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault.do_read_fault.do_fault
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_lookupat.filename_lookup
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.pte_alloc_one.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__d_alloc.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.28 ±141%      -0.3        0.00        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.10 ±128%      -0.3        0.83 ±100%  perf-profile.calltrace.cycles-pp.mutex_unlock._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp._IO_file_finish
      0.26 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.format_decode.vsnprintf.seq_printf.arch_show_interrupts.seq_read_iter
      1.14 ± 84%      -0.2        0.90 ± 86%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.48 ± 58%      -0.2        1.25 ± 65%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.21 ± 56%      -0.2        0.99 ± 86%  perf-profile.calltrace.cycles-pp.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      0.64 ±167%      -0.2        0.42 ±154%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.generic_exec_single.smp_call_function_single.event_function_call.perf_event_release_kernel
      0.64 ±167%      -0.2        0.42 ±154%  perf-profile.calltrace.cycles-pp.generic_exec_single.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release
      0.64 ±167%      -0.2        0.42 ±154%  perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.generic_exec_single.smp_call_function_single.event_function_call
      1.50 ± 56%      -0.2        1.28 ± 61%  perf-profile.calltrace.cycles-pp.fstatat64
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.47 ±100%      -0.2        0.28 ±223%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_ctx_enable.event_function.remote_function.generic_exec_single
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.event_function.remote_function.generic_exec_single.smp_call_function_single.event_function_call
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl.__x64_sys_ioctl
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.generic_exec_single.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.perf_ctx_enable.event_function.remote_function.generic_exec_single.smp_call_function_single
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.perf_event_for_each_child._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.remote_function.generic_exec_single.smp_call_function_single.event_function_call.perf_event_for_each_child
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl
      0.72 ±106%      -0.2        0.54 ±109%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.72 ±106%      -0.2        0.54 ±109%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.72 ±106%      -0.2        0.54 ±109%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      8.42 ± 30%      -0.2        8.23 ± 26%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.42 ± 30%      -0.2        8.23 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.32 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
      1.20 ± 70%      -0.2        1.01 ± 74%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.45 ±151%      -0.2        0.27 ±141%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_binary.search_binary_handler
      0.45 ±151%      -0.2        0.27 ±141%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_binary
      0.45 ±151%      -0.2        0.27 ±141%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_binary.search_binary_handler.exec_binprm
      0.32 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_arg_page.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.45 ±100%      -0.2        0.28 ±141%  perf-profile.calltrace.cycles-pp.wait4
      0.32 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.42 ± 26%      -0.2        4.25 ± 36%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.42 ± 26%      -0.2        4.25 ± 36%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault.do_fault
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.affinity__set.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record
      0.72 ±107%      -0.2        0.55 ± 70%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.31 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.arch_show_interrupts.seq_read_iter.proc_reg_read_iter
      1.60 ± 50%      -0.2        1.43 ± 43%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ±100%      -0.2        0.27 ±141%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.schedule
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.___pud_free_tlb.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__dup2
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__lookup_mnt.step_into.link_path_walk.path_openat.do_filp_open
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__mmdrop.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__output_copy.perf_output_copy.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.complete_all.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.atomic_dec_and_mutex_lock.x86_release_hardware.hw_perf_event_destroy._free_event.perf_event_release_kernel
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.complete_all.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__dup2
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.expand_downwards.get_arg_page.copy_strings.do_execveat_common.__x64_sys_execve
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.free_percpu.percpu_counter_destroy_many.__mmdrop.exec_mmap.begin_new_exec
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.from_kuid_munged.task_state.proc_pid_status.proc_single_show.seq_read_iter
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kfree.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.map_id_up.from_kuid_munged.task_state.proc_pid_status.proc_single_show
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.free_percpu.percpu_counter_destroy_many.__mmdrop.exec_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.percpu_counter_destroy_many.__mmdrop.exec_mmap.begin_new_exec.load_elf_binary
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.expand_downwards.get_arg_page.copy_strings.do_execveat_common
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.expand_downwards.get_arg_page.copy_strings
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.expand_downwards
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mprotect_fixup
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_evsel__ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable.__cmd_record
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.expand_downwards.get_arg_page
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_output_copy.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exec_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.x86_release_hardware.hw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable.__cmd_record
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.read
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.43 ±147%      -0.2        0.26 ±141%  perf-profile.calltrace.cycles-pp.__close_nocancel
      0.30 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.mutex_unlock.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__d_add.simple_lookup.__lookup_slow.walk_component.link_path_walk
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.__put_anon_vma
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__rb_erase_color.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__dentry_kill.dput.__fput
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.complete_signal.__send_signal_locked
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__open64_nocancel
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.folios_put_refs.folio_batch_move_lru
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__tlb_remove_folio_pages_size.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_add.simple_lookup.__lookup_slow.walk_component
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault._Fork
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__open64_nocancel
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.folios_put_refs.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_notify_parent.exit_notify.do_exit
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_lru_add.dput.path_put.vfs_statx.vfs_fstatat
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._Fork
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault._Fork
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.folio_mark_accessed.follow_page_pte.follow_page_mask.__get_user_pages.get_user_pages_remote
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.folios_put_refs.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.follow_page_mask.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.follow_page_pte.follow_page_mask.__get_user_pages.get_user_pages_remote.get_arg_page
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.generic_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._Fork
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__open64_nocancel
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.folios_put_refs
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.__dentry_kill.dput.__fput.task_work_run
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.list_lru_add.d_lru_add.dput.path_put.vfs_statx
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.complete_signal
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.do_open.path_openat.do_filp_open
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mnt_get_write_access.touch_atime.generic_file_mmap.mmap_region.do_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.__put_anon_vma.unlink_anon_vmas
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.nr_iowait_cpu.tick_nohz_stop_idle.tick_nohz_idle_exit.do_idle.cpu_startup_entry
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.simple_lookup.__lookup_slow.walk_component.link_path_walk.path_openat
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__open64_nocancel
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.folios_put_refs.folio_batch_move_lru.folio_add_lru
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.tick_nohz_stop_idle.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.touch_atime.generic_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_notify_parent.exit_notify
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.tsc_verify_tsc_adjust.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.complete_signal.__send_signal_locked.do_notify_parent
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.up_read.do_wp_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.wakeup_preempt.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.follow_page_pte.follow_page_mask.__get_user_pages
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.follow_page_pte.follow_page_mask
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.xa_load.list_lru_add.d_lru_add.dput.path_put
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.xas_load.xa_load.list_lru_add.d_lru_add.dput
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__get_user_8.rseq_get_rseq_cs.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.complete_walk.do_open
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter.proc_reg_read_iter.vfs_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__rb_erase_color.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.alloc_slab_obj_exts.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof.proc_alloc_inode
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof.proc_alloc_inode.alloc_inode
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__rb_erase_color.vma_prepare.__split_vma.vma_modify
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.deactivate_slab.___slab_alloc.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.dput.path_put.exit_fs.do_exit.do_group_exit
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.filldir64.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sysconf
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__rb_erase_color.vma_prepare
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.path_put.exit_fs.do_exit
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.number.bitmap_string.vsnprintf.seq_printf.cpuset_task_status_allowed
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.path_put.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.dup_mm.copy_process
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__consume
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pgd_alloc.mm_init.dup_mm.copy_process.kernel_clone
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pgd_ctor.pgd_alloc.mm_init.dup_mm.copy_process
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.procps_pids_get
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.ring_buffer_write_tail.perf_mmap__consume
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rseq_get_rseq_cs.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__rb_erase_color.vma_prepare.__split_vma
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.task_cputime.thread_group_cputime.thread_group_cputime_adjusted.wait_task_zombie.__do_wait
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.thread_group_cputime.thread_group_cputime_adjusted.wait_task_zombie.__do_wait.do_wait
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.thread_group_cputime_adjusted.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vdso_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.30 ±223%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__cleanup_sighand.__exit_signal.release_task.wait_task_zombie.__do_wait
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_lookupat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__exit_signal.release_task.wait_task_zombie.__do_wait.do_wait
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__free_pages.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__libc_fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.path_openat.do_filp_open.do_sys_openat2
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.alloc_inode.iget_locked.kernfs_get_inode
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__note_gp_changes.note_gp_changes.rcu_core.handle_softirqs.irq_exit_rcu
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__seq_puts.render_cap_t.proc_pid_status.proc_single_show.seq_read_iter
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._find_next_bit.arch_show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._find_next_zero_bit.pcpu_alloc_area.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.alloc_inode.iget_locked.kernfs_get_inode.kernfs_iop_lookup.lookup_open
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault._IO_link_in
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._IO_link_in
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.event_function.remote_function.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault._IO_link_in
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm._Fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._IO_link_in
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_user_addr_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_user_addr_fault.exc_page_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kernfs_dir_pos.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kernfs_put.kernfs_dir_pos.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.alloc_inode.iget_locked.kernfs_get_inode.kernfs_iop_lookup
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.memset_orig.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter.seq_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mutex_lock.seq_read_iter.seq_read.vfs_read.ksys_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pcpu_alloc_area.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.alloc_bprm
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.alloc_bprm.do_execveat_common
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pid_nr_ns.do_task_stat.proc_single_show.seq_read_iter.seq_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.putname.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rcu_accelerate_cbs.__note_gp_changes.note_gp_changes.rcu_core.handle_softirqs
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rcu_segcblist_accelerate.rcu_accelerate_cbs.__note_gp_changes.note_gp_changes.rcu_core
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.remote_function.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.render_cap_t.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm._Fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork_asm._Fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm._Fork
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.strlen.__seq_puts.render_cap_t.proc_pid_status.proc_single_show
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one
      0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.alloc_inode.new_inode.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable.__cmd_record
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.new_inode.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.calltrace.cycles-pp.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups.path_openat
      0.28 ±141%      -0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kernfs_iop_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__check_heap_object.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__close_nocancel.setlocale
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_openat
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__fput_sync.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__hrtimer_next_event_base.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__init_rwsem.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmalloc_trace_noprof.single_open.do_dentry_open.do_open
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__vm_enough_memory.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel.setlocale
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel.setlocale
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel.setlocale
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.wait4
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.error_entry.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kmalloc_trace_noprof.single_open.do_dentry_open.do_open.path_openat
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_orig.seq_write.seq_put_decimal_ull_width.task_state.proc_pid_status
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmalloc_trace_noprof.single_open.do_dentry_open
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.seq_put_decimal_ull_width.task_state.proc_pid_status.proc_single_show.seq_read_iter
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.seq_write.seq_put_decimal_ull_width.task_state.proc_pid_status.proc_single_show
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_is_huge.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.strnlen_user.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xas_store.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.29 ±142%      -0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exec_mmap
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__init_rwsem.inode_init_always.alloc_inode.new_inode.proc_pid_make_inode
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_find_any_alias.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.apparmor_mmap_file.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.copy_fs_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.d_find_any_alias.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.inode_init_always.alloc_inode.new_inode.proc_pid_make_inode.proc_pident_instantiate
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kernfs_find_ns.kernfs_iop_lookup.lookup_open.open_last_lookups.path_openat
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kfree.single_release.__fput.__x64_sys_close.do_syscall_64
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kmalloc_trace_noprof.proc_cgroup_show.proc_single_show.seq_read_iter.seq_read
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone.__do_sys_clone
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.link_path_walk.path_lookupat
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_orig.__output_copy.perf_output_copy.perf_event_mmap_output.perf_iterate_sb
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.mntput_no_expire.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_event_fork.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_event_task_output.perf_iterate_sb.perf_event_fork.copy_process.kernel_clone
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_fork.copy_process.kernel_clone.__do_sys_clone
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_output_begin.perf_event_task_output.perf_iterate_sb.perf_event_fork.copy_process
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.proc_cgroup_show.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.readdir64
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sched_balance_domains._nohz_idle_balance.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs.irq_exit_rcu
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.single_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains._nohz_idle_balance
      0.30 ±141%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.note_gp_changes.rcu_core.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.30 ±141%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.43 ±100%      -0.1        0.31 ±143%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.43 ±100%      -0.1        0.31 ±143%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.43 ±100%      -0.1        0.31 ±143%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.30 ±142%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.30 ±142%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.97 ± 42%      -0.1        1.85 ± 96%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ± 42%      -0.1        1.85 ± 96%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      0.28 ±142%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.28 ±142%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.copy_mc_fragile.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.28 ±141%      -0.1        0.18 ±223%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.38 ± 58%      -0.1        2.30 ± 61%  perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      1.16 ± 79%      -0.1        1.08 ±118%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.76 ± 80%      -0.1        1.68 ± 46%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.76 ± 80%      -0.1        1.68 ± 46%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.46 ±100%      -0.1        0.40 ±100%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.89 ± 79%      -0.1        0.83 ± 81%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.94 ± 82%      -0.1        0.89 ± 87%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.33 ± 30%      -0.0        1.29 ± 63%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.59 ±113%      -0.0        0.54 ±141%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.31 ±141%      -0.0        0.26 ±141%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      0.32 ±141%      -0.0        0.28 ±141%  perf-profile.calltrace.cycles-pp.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.32 ±141%      -0.0        0.28 ±141%  perf-profile.calltrace.cycles-pp.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      0.45 ±151%      -0.0        0.41 ±152%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.31 ±141%      -0.0        0.27 ±141%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.vfs_statx
      0.31 ±141%      -0.0        0.27 ±141%  perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.32 ±141%      -0.0        0.28 ±223%  perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.16 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.16 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.16 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.16 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.31 ±141%      -0.0        0.28 ±141%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.87 ± 78%      -0.0        0.84 ± 93%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.48 ±155%      -0.0        0.44 ±146%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.30 ±141%      -0.0        0.28 ±141%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.30 ±141%      -0.0        0.28 ±141%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.45 ±100%      -0.0        0.42 ±100%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.31 ±223%      -0.0        0.28 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.write.writen
      7.35 ±  9%      -0.0        7.32 ± 15%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.getdents64
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.do_exit
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__send_signal_locked.do_notify_parent.exit_notify.do_exit.do_group_exit
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_notify_parent.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_wp_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.pcpu_alloc_noprof.mm_init.dup_mm.copy_process.kernel_clone
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.pid_revalidate.lookup_fast.walk_component.path_lookupat.filename_lookup
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.28 ±142%      -0.0        0.26 ±141%  perf-profile.calltrace.cycles-pp.get_jiffies_update.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.28 ±142%      -0.0        0.26 ±141%  perf-profile.calltrace.cycles-pp.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__open64_nocancel.setlocale
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_remove_from_owner.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__sysconf
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__sysconf
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sysconf
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__sysconf
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.proc_alloc_inode.alloc_inode.new_inode.proc_pid_make_inode
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.number.vsnprintf.seq_printf.show_interrupts.seq_read_iter
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.proc_alloc_inode.alloc_inode.new_inode.proc_pid_make_inode.proc_pident_instantiate
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      0.46 ±152%      -0.0        0.44 ±146%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.iget_locked.kernfs_get_inode.kernfs_iop_lookup.lookup_open.open_last_lookups
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.kernfs_get_inode.kernfs_iop_lookup.lookup_open.open_last_lookups.path_openat
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings.do_execveat_common
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__schedule.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_user_pages_remote.get_arg_page.copy_strings.do_execveat_common.__x64_sys_execve
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.do_task_dead.do_exit.do_group_exit
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.do_task_dead.do_exit
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.do_task_dead
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.write.writen
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.writen
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.apparmor_ptrace_access_check.security_ptrace_access_check.ptrace_may_access.do_task_stat.proc_single_show
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.security_ptrace_access_check.ptrace_may_access.do_task_stat.proc_single_show.seq_read_iter
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp._IO_link_in
      0.28 ±141%      -0.0        0.27 ±223%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.kcpustat_cpu_fetch.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.single_open.do_dentry_open.do_open.path_openat.do_filp_open
      0.31 ±141%      -0.0        0.30 ±143%  perf-profile.calltrace.cycles-pp.format_decode.vsnprintf.seq_printf.show_interrupts.seq_read_iter
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.31 ±141%      +0.0        0.31 ±143%  perf-profile.calltrace.cycles-pp.task_state.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      1.62 ± 70%      +0.0        1.62 ± 63%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ± 71%      +0.0        0.59 ± 72%  perf-profile.calltrace.cycles-pp.__close
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.mtree_load.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      0.28 ±141%      +0.0        0.29 ±223%  perf-profile.calltrace.cycles-pp.ktime_get.get_cpu_sleep_time_us.get_idle_time.uptime_proc_show.seq_read_iter
      0.16 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_idle.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.18 ± 71%      +0.0        1.19 ± 74%  perf-profile.calltrace.cycles-pp.get_cpu_sleep_time_us.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait.do_wait
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_waitid.__do_sys_waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.calltrace.cycles-pp.waitid
      0.16 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.down_read_trylock.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.16 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.__percpu_counter_init_many.mm_init.dup_mm.copy_process.kernel_clone
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.__percpu_counter_init_many.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.rb_next.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.28 ±142%      +0.0        0.31 ±143%  perf-profile.calltrace.cycles-pp.proc_pident_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.58 ±113%      +0.0        0.63 ±120%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.13 ±223%      +0.0        0.18 ±223%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains
      1.90 ± 63%      +0.0        1.94 ± 41%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.13 ± 55%      +0.1        2.18 ± 40%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.13 ± 55%      +0.1        2.18 ± 40%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.04 ± 61%      +0.1        1.11 ± 72%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.04 ± 61%      +0.1        1.11 ± 72%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.91 ± 82%      +0.1        0.99 ± 86%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter
      1.81 ± 41%      +0.1        1.90 ± 39%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.46 ±100%      +0.1        0.56 ±110%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ±100%      +0.1        0.56 ±110%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.31 ±141%      +0.1        0.41 ±152%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.31 ±141%      +0.1        0.41 ±100%  perf-profile.calltrace.cycles-pp.show_softirqs.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.30 ±142%      +0.1        0.40 ±151%  perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.30 ±141%      +0.1        0.41 ±100%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.16 ±223%      +0.1        0.26 ±223%  perf-profile.calltrace.cycles-pp.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir
      0.16 ±223%      +0.1        0.26 ±223%  perf-profile.calltrace.cycles-pp.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      2.34 ± 67%      +0.1        2.44 ± 46%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.43 ±156%      +0.1        0.54 ±141%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.43 ±156%      +0.1        0.54 ±141%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.43 ±156%      +0.1        0.54 ±141%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.30 ±223%      +0.1        0.41 ±155%  perf-profile.calltrace.cycles-pp.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.15 ±223%      +0.1        0.26 ±223%  perf-profile.calltrace.cycles-pp.down_read_trylock.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.16 ±223%      +0.1        0.27 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.16 ±223%      +0.1        0.27 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.schedule_idle
      0.16 ±223%      +0.1        0.27 ±141%  perf-profile.calltrace.cycles-pp.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.16 ±223%      +0.1        0.27 ±141%  perf-profile.calltrace.cycles-pp.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.16 ±223%      +0.1        0.27 ±141%  perf-profile.calltrace.cycles-pp.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist
      0.16 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread
      0.16 ±223%      +0.1        0.28 ±223%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.15 ±223%      +0.1        0.27 ±223%  perf-profile.calltrace.cycles-pp.ptrace_may_access.do_task_stat.proc_single_show.seq_read_iter.seq_read
      0.16 ±223%      +0.1        0.29 ±141%  perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.15 ±223%      +0.1        0.27 ±223%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.15 ±223%      +0.1        0.27 ±141%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      +0.1        0.27 ±141%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.exit_mmap.__mmput
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.exit_mmap.__mmput.exit_mm
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.exit_mmap
      0.31 ±223%      +0.1        0.44 ±223%  perf-profile.calltrace.cycles-pp.next_tgid.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__init_rwsem.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__mutex_lock.perf_event_ctx_lock_nested.perf_event_release_kernel.perf_release.__fput
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__pud_alloc.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__schedule.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__sigsetjmp
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.number.vsnprintf
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.__pud_alloc.copy_p4d_range.copy_page_range.dup_mmap
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.number.vsnprintf.snprintf.proc_pid_readdir
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.cfree.setlocale
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.move_queued_task.migration_cpu_stop
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.format_decode.vsnprintf.seq_printf.uptime_proc_show.seq_read_iter
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.number
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.inode_add_bytes.__dquot_alloc_space.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.perf_event_ctx_lock_nested.perf_event_release_kernel.perf_release
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.number.vsnprintf.snprintf.proc_pid_readdir.iterate_dir
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.alloc_empty_file.path_openat
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.pagecache_get_page.page_get_link.pick_link.step_into.open_last_lookups
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.perf_event_ctx_lock_nested.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock.ep_poll
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.snprintf.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.number.vsnprintf.snprintf
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.task_rq_lock.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.move_queued_task
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.__schedule.__cond_resched.mutex_lock.swevent_hlist_put_cpu
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.vma_prepare.vma_expand.mmap_region.do_mmap
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.vsnprintf.snprintf.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close
      7.19 ± 13%      +0.1        7.32 ± 15%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.31 ±141%      +0.1        0.44 ±146%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.13 ±223%      +0.1        0.26 ±141%  perf-profile.calltrace.cycles-pp.fput.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__ptrace_may_access.ptrace_may_access.do_task_stat.proc_single_show.seq_read_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_mem_cgroup_from_mm.__mem_cgroup_charge
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.ksys_read.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._atomic_dec_and_lock.iput.__dentry_kill.dput.__fput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._copy_to_user.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.iget_locked.kernfs_get_inode.kernfs_iop_lookup
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.rep_stos_alternative.elf_load.load_elf_interp.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.get_mem_cgroup_from_mm.__mem_cgroup_charge.wp_page_copy.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.open64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_stos_alternative.elf_load
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.rep_stos_alternative.elf_load.load_elf_interp
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exclusive_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.fault_dirty_shared_page.do_wp_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_unlock.fault_dirty_shared_page.do_wp_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_vma_policy.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_stos_alternative
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_mem_cgroup_from_mm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.ksys_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.inode_sb_list_add.iget_locked.kernfs_get_inode.kernfs_iop_lookup.lookup_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.iput.__dentry_kill.dput.__fput.task_work_run
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sysconf
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mem_cgroup_from_task.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_event_comm.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_event_comm_event.perf_event_comm.begin_new_exec.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_event_comm_output.perf_iterate_sb.perf_event_comm_event.perf_event_comm.begin_new_exec
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_comm_event.perf_event_comm.begin_new_exec.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_output_begin.perf_event_comm_output.perf_iterate_sb.perf_event_comm_event.perf_event_comm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.prepare_signal.__send_signal_locked.do_notify_parent.exit_notify.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.rb_next.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.rep_stos_alternative.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.should_we_balance.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_mem_cgroup_from_mm.__mem_cgroup_charge.wp_page_copy
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.up_write.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule_idle
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_sd_pick_busiest.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.path_lookupat.filename_lookup
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__get_user_8.futex_cleanup.futex_exit_release.exit_mm_release.exit_mm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__install_special_mapping.map_vdso.load_elf_binary.search_binary_handler.exec_binprm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.__vm_area_free.exit_mmap.__mmput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.__install_special_mapping.map_vdso
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rep_movs_alternative.copy_page_from_iter_atomic
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__vm_munmap.elf_load.load_elf_binary.search_binary_handler.exec_binprm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._find_next_zero_bit.bitmap_list_string.vsnprintf.seq_printf.proc_pid_status
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.anon_vma_ctor.setup_object.shuffle_freelist.allocate_slab.___slab_alloc
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_mmap.security_mmap_file.vm_mmap_pgoff
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.bitmap_list_string.vsnprintf.seq_printf.proc_pid_status.proc_single_show
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.call_cpuidle.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.change_protection_range.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.fstatat64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.elf_load.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close_nocancel
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exit_mm_release.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.futex_cleanup.futex_exit_release.exit_mm_release.exit_mm.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.futex_exit_release.exit_mm_release.exit_mm.do_exit.do_group_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rep_movs_alternative
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.idle_cpu.should_we_balance.sched_balance_rq.sched_balance_domains.handle_softirqs
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ima_file_mmap.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.inode_permission.may_open.do_open.path_openat.do_filp_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.vma_modify
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.__install_special_mapping.map_vdso.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__vm_area_free.exit_mmap.__mmput.exec_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.local_touch_nmi.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.map_vdso.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.vma_modify.mprotect_fixup
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mast_fill_bnode.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.may_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.shmem_write_end.generic_perform_write.shmem_file_write_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.__x64_sys_close.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.__install_special_mapping
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_trigger.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_mmap.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.setup_object.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.should_we_balance.sched_balance_rq.sched_balance_domains.handle_softirqs.irq_exit_rcu
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.anon_vma_fork
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.task_numa_group_id.task_state.proc_pid_status.proc_single_show.seq_read_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.unaccount_event._free_event.perf_event_release_kernel.perf_release.__fput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.up_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vm_area_alloc.__install_special_mapping.map_vdso.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.zero_user_segments.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      0.45 ±100%      +0.1        0.59 ±106%  perf-profile.calltrace.cycles-pp.do_task_stat.proc_single_show.seq_read_iter.seq_read.vfs_read
      1.63 ± 34%      +0.1        1.77 ± 79%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__check_object_size.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__isoc99_fscanf
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.seq_open.single_open.do_dentry_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__rb_insert_augmented.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__schedule.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__strtod_internal.__isoc99_fscanf
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.seq_read_iter.proc_reg_read_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__vm_munmap.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._find_next_zero_bit.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.percpu_counter_add_batch.finish_fault.do_read_fault.do_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.seq_read_iter.proc_reg_read_iter.vfs_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strncpy_from_user.getname_flags
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load.load_elf_interp
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.elf_load.load_elf_interp.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strncpy_from_user.getname_flags.do_sys_openat2
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.filldir64.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.__cond_resched.__wait_for_common.affine_move_task
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.ptep_clear_flush.wp_page_copy.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.ptep_clear_flush.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap.__mmput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.seq_open.single_open.do_dentry_open.do_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify.mprotect_fixup
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lock_for_kill.dput.step_into.link_path_walk.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strncpy_from_user
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.link_path_walk.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_drain.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.exit_mmap.__mmput.exit_mm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mem_cgroup_update_lru_size.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.seq_open.single_open
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.ptep_clear_flush.wp_page_copy
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap_to_page.perf_mmap_fault.__do_fault.do_read_fault.do_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ptep_clear_flush.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_rq.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.seq_open.single_open.do_dentry_open.do_open.path_openat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.seq_printf.show_softirqs.seq_read_iter.vfs_read.ksys_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.up_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.___pmd_free_tlb.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.reweight_entity.enqueue_task_fair.activate_task
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__enqueue_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.exit_mmap.__mmput.exit_mm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__percpu_counter_limited_add.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__put_user_8.create_elf_tables.load_elf_binary.search_binary_handler.exec_binprm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__fput.task_work_run.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exec_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.balance_rt.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.create_elf_tables.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ct_idle_exit.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.ct_kernel_enter.ct_idle_exit.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.d_walk.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.do_read_cache_folio.read_cache_page.page_get_link.pick_link.step_into
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.down_write.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__open64_nocancel.setlocale
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.finish_fault.do_read_fault.do_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.do_read_cache_folio.read_cache_page.page_get_link.pick_link
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.get_task_mm.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__fput.task_work_run.do_exit.do_group_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_find.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.exit_mmap.__mmput.exit_mm
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.memset_orig.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.exit_mmap.__mmput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.module_put._free_event.perf_event_release_kernel.perf_release.__fput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.mutex_unlock.perf_remove_from_owner.perf_event_release_kernel.perf_release.__fput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.num_to_str.seq_put_decimal_ull_width.do_task_stat.proc_single_show.seq_read_iter
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.put_dec.num_to_str.seq_put_decimal_ull_width.do_task_stat.proc_single_show
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.put_dec_full8.put_dec.num_to_str.seq_put_decimal_ull_width.do_task_stat
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.read_cache_page.page_get_link.pick_link.step_into.open_last_lookups
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.move_queued_task.migration_cpu_stop
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.seq_put_decimal_ull_width.do_task_stat.proc_single_show.seq_read_iter.seq_read
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.timekeeping_advance.update_wall_time.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.timekeeping_update.timekeeping_advance.update_wall_time.tick_nohz_handler.__hrtimer_run_queues
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.move_queued_task
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_vsyscall.timekeeping_update.timekeeping_advance.update_wall_time.tick_nohz_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.update_wall_time.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.13 ±223%      +0.1        0.28 ±141%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      0.13 ±223%      +0.2        0.28 ±223%  perf-profile.calltrace.cycles-pp._find_next_bit.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      0.16 ±223%      +0.2        0.31 ±143%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.do_exit.do_group_exit
      0.16 ±223%      +0.2        0.31 ±143%  perf-profile.calltrace.cycles-pp.filp_flush.filp_close.put_files_struct.do_exit.do_group_exit
      0.99 ±119%      +0.2        1.15 ± 69%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.13 ±223%      +0.2        0.29 ±223%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.get_cpu_sleep_time_us.get_idle_time.uptime_proc_show
      0.15 ±223%      +0.2        0.30 ±143%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      0.15 ±223%      +0.2        0.30 ±143%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±142%      +0.2        0.46 ±101%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.28 ±142%      +0.2        0.46 ±101%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.task_state.proc_pid_status.proc_single_show.seq_read_iter
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.__update_load_avg_se.update_load_avg.dequeue_entity.dequeue_task_fair.sched_move_task
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp._compound_head.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.wake_up_q.cpu_stop_queue_work
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.try_to_wake_up.wake_up_q.cpu_stop_queue_work.affine_move_task
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.sched_move_task.do_exit.do_group_exit
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.sched_move_task.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.enqueue_task_stop.activate_task.ttwu_do_activate.try_to_wake_up.wake_up_q
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.sched_setaffinity.__evlist__disable.__cmd_record.cmd_record
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.getrandom
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.fput.filp_close.put_files_struct.do_exit.do_group_exit
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.getrandom
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.fault_in_readable
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.try_to_wake_up
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.fault_in_readable.fault_in_iov_iter_readable
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.try_to_wake_up.wake_up_q
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.task_work_run.do_exit
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.proc_task_name.do_task_stat.proc_single_show.seq_read_iter.seq_read
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.render_sigset_t.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs.irq_exit_rcu
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.sched_move_task.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.seq_putc.render_sigset_t.proc_pid_status.proc_single_show.seq_read_iter
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.try_to_wake_up.wake_up_q.cpu_stop_queue_work
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.task_seccomp.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_up_q.cpu_stop_queue_work.affine_move_task
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.sched_move_task.do_exit
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert_after.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.wq_worker_comm.proc_task_name.do_task_stat.proc_single_show.seq_read_iter
      2.13 ± 55%      +0.2        2.32 ± 36%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.98 ± 58%      +0.2        2.18 ± 40%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.74 ± 85%      +0.2        0.96 ±113%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.calltrace.cycles-pp.__mmap.setlocale
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.46 ±100%      +0.2        0.67 ±106%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.31 ±141%      +0.2        0.53 ±141%  perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.32 ±141%      +0.2        0.54 ±111%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.32 ±141%      +0.2        0.54 ±111%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.32 ±141%      +0.2        0.56 ±110%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±223%      +0.2        0.40 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.3        0.26 ±223%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pud_alloc.copy_p4d_range
      0.00            +0.3        0.26 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm.copy_process
      0.00            +0.3        0.26 ±223%  perf-profile.calltrace.cycles-pp.tick_nohz_tick_stopped.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.3        0.26 ±223%  perf-profile.calltrace.cycles-pp.try_module_get.do_dentry_open.do_open.path_openat.do_filp_open
      0.00            +0.3        0.26 ±223%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.15 ±223%      +0.3        0.41 ±155%  perf-profile.calltrace.cycles-pp.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event.perf_event_release_kernel
      0.15 ±223%      +0.3        0.41 ±100%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.00            +0.3        0.26 ±141%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.task_work_run.do_exit.do_group_exit
      0.00            +0.3        0.26 ±141%  perf-profile.calltrace.cycles-pp.kmem_cache_free.task_work_run.do_exit.do_group_exit.get_signal
      0.00            +0.3        0.26 ±141%  perf-profile.calltrace.cycles-pp.nohz_balancer_kick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.15 ±223%      +0.3        0.42 ±100%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.15 ±223%      +0.3        0.42 ±100%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.00            +0.3        0.27 ±223%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.3        0.27 ±223%  perf-profile.calltrace.cycles-pp._find_next_bit.pcpu_alloc_noprof.mm_init.dup_mm.copy_process
      0.00            +0.3        0.27 ±223%  perf-profile.calltrace.cycles-pp.memcpy_orig.vsnprintf.seq_printf.arch_show_interrupts.seq_read_iter
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.find_next_iomem_res.walk_system_ram_range.pat_pagerange_is_ram.lookup_memtype.track_pfn_insert
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.lookup_memtype.track_pfn_insert.vmf_insert_pfn_prot.__do_fault.do_read_fault
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.pat_pagerange_is_ram.lookup_memtype.track_pfn_insert.vmf_insert_pfn_prot.__do_fault
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.seq_printf.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.track_pfn_insert.vmf_insert_pfn_prot.__do_fault.do_read_fault.do_fault
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.vmf_insert_pfn_prot.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.uptime_proc_show.seq_read_iter.vfs_read
      0.00            +0.3        0.27 ±141%  perf-profile.calltrace.cycles-pp.walk_system_ram_range.pat_pagerange_is_ram.lookup_memtype.track_pfn_insert.vmf_insert_pfn_prot
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.activate_task.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.move_queued_task.migration_cpu_stop.cpu_stopper_thread
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.page_get_link.pick_link.step_into.open_last_lookups.path_openat
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.pick_link.step_into.open_last_lookups.path_openat.do_filp_open
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.sched_tick.update_process_times.tick_nohz_handler
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.strlen.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.30 ±223%      +0.3        0.58 ±106%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.16 ±223%      +0.3        0.44 ±223%  perf-profile.calltrace.cycles-pp.pid_nr_ns.next_tgid.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region
      0.00            +0.3        0.28 ±141%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.proc_pid_status.proc_single_show.seq_read_iter
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.ct_kernel_exit_state.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.find_vma.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.mt_find.find_vma.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault
      0.00            +0.3        0.28 ±223%  perf-profile.calltrace.cycles-pp.path_init.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.31 ±223%      +0.3        0.60 ± 71%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.3        0.29 ±141%  perf-profile.calltrace.cycles-pp.clear_bhb_loop
      0.00            +0.3        0.29 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.rep_stos_alternative.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame
      0.13 ±223%      +0.3        0.42 ±100%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      0.13 ±223%      +0.3        0.42 ±100%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.43 ±156%      +0.3        0.73 ±103%  perf-profile.calltrace.cycles-pp.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      +0.3        0.45 ±101%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.15 ±223%      +0.3        0.45 ±101%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.get_pfnblock_flags_mask.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.3        0.31 ±143%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.16 ±223%      +0.3        0.49 ±161%  perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.get_signal
      0.16 ±223%      +0.3        0.49 ±161%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.93 ± 60%      +0.3        1.26 ±120%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      1.52 ± 31%      +0.3        1.85 ± 96%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.15 ±223%      +0.3        0.49 ±159%  perf-profile.calltrace.cycles-pp.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp.__isoc99_sscanf
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp._find_next_bit.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.alloc_bprm
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp._find_next_bit.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.dup_mm
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr
      0.00            +0.4        0.35 ±223%  perf-profile.calltrace.cycles-pp.wake_up_q.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00            +0.4        0.40 ±153%  perf-profile.calltrace.cycles-pp.__dquot_alloc_space.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00            +0.4        0.40 ±153%  perf-profile.calltrace.cycles-pp.epoll_wait
      0.32 ±141%      +0.4        0.75 ±124%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      0.72 ±179%      +0.4        1.16 ± 80%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      4.88 ± 55%      +0.4        5.32 ± 24%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      4.88 ± 55%      +0.4        5.32 ± 24%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      0.00            +0.4        0.45 ±101%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.00            +0.5        0.46 ±101%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.5        0.46 ±101%  perf-profile.calltrace.cycles-pp.seq_printf.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.16 ±223%      +0.5        0.62 ±122%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record
      0.00            +0.5        0.46 ±100%  perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.62 ±166%      +0.5        1.10 ±103%  perf-profile.calltrace.cycles-pp.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ± 92%      +0.5        3.20 ± 50%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write
      3.00 ±104%      +0.5        3.50 ± 48%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      2.23 ±136%      +0.5        2.73 ± 51%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      1.76 ± 63%      +0.5        2.27 ± 41%  perf-profile.calltrace.cycles-pp.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      1.34 ± 63%      +0.5        1.86 ± 46%  perf-profile.calltrace.cycles-pp.mutex_unlock.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.16 ±223%      +0.5        0.68 ±108%  perf-profile.calltrace.cycles-pp.get_cpu_idle_time_us.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read
      0.16 ±223%      +0.5        0.68 ±108%  perf-profile.calltrace.cycles-pp.nr_iowait_cpu.get_cpu_idle_time_us.get_idle_time.uptime_proc_show.seq_read_iter
      1.02 ±127%      +0.5        1.57 ± 64%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable
      1.02 ±127%      +0.5        1.57 ± 64%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      0.00            +0.5        0.55 ±163%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +0.5        0.55 ±163%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule
      0.00            +0.5        0.55 ±163%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__schedule.schedule.smpboot_thread_fn
      0.00            +0.5        0.55 ±163%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule.schedule
      0.00            +0.5        0.55 ±163%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair
      0.29 ±142%      +0.6        0.86 ±133%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.29 ±142%      +0.6        0.86 ±133%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.13 ±223%      +0.6        0.72 ± 80%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      0.13 ±223%      +0.6        0.72 ± 80%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      0.13 ±223%      +0.6        0.72 ± 80%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.00            +0.6        0.62 ±122%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable
      0.00            +0.6        0.62 ±122%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable.__cmd_record
      0.00            +0.6        0.62 ±122%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.63 ± 33%      +0.7        2.29 ± 34%  perf-profile.calltrace.cycles-pp.uptime_proc_show.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      1.18 ± 31%      +0.7        1.87 ± 32%  perf-profile.calltrace.cycles-pp.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      0.00            +0.7        0.69 ±144%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +0.7        0.69 ±144%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.7        0.70 ±147%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      0.00            +0.7        0.70 ±147%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.13 ±223%      +0.7        0.86 ± 55%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      3.02 ± 30%      +0.8        3.78 ± 44%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.20 ± 95%      +0.8        1.95 ± 59%  perf-profile.calltrace.cycles-pp.getdents64
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.81 ± 41%      +0.8        2.60 ± 29%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.60 ±114%      +0.8        1.39 ± 38%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.73 ±107%      +0.8        1.54 ± 31%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.49 ± 45%      +0.8        2.31 ± 66%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      2.10 ± 61%      +0.8        2.93 ± 60%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ± 61%      +0.8        2.93 ± 60%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.06 ± 41%      +0.9        8.92 ± 51%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.06 ± 41%      +0.9        8.92 ± 51%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      8.06 ± 41%      +0.9        8.92 ± 51%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      8.06 ± 41%      +0.9        8.92 ± 51%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.06 ± 41%      +0.9        8.92 ± 51%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.94 ± 29%      +0.9        2.83 ± 31%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.49 ± 45%      +1.0        2.44 ± 58%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.87 ± 81%      +1.0        1.83 ± 46%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87 ± 81%      +1.0        1.83 ± 46%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ± 61%      +1.0        3.07 ± 53%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ± 58%      +1.0        2.82 ± 29%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
      1.49 ± 45%      +1.5        3.01 ± 63%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      7.13 ± 38%      +1.6        8.69 ± 20%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      7.91 ± 42%      +1.6        9.55 ± 19%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      7.13 ± 38%      +1.7        8.83 ± 19%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      7.58 ± 40%      +1.7        9.28 ± 17%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +1.8        1.82 ±223%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     13.32 ± 27%      +2.0       15.36 ± 33%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.32 ± 27%      +2.0       15.36 ± 33%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     39.82 ± 17%      +4.1       43.92 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     40.00 ± 17%      +4.2       44.18 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     39.56 ± 17%      +4.2       43.79 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     41.32 ± 17%      +4.4       45.72 ±  5%  perf-profile.calltrace.cycles-pp.common_startup_64
     34.34 ± 15%      +4.5       38.83 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     40.90 ± 17%      +4.7       45.59 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     40.90 ± 17%      +4.7       45.59 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     40.90 ± 17%      +4.7       45.59 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     12.65 ±108%      -5.4        7.28 ± 18%  perf-profile.children.cycles-pp.vfs_write
     48.99 ± 18%      -5.2       43.74 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.80 ±107%      -5.2        7.56 ± 14%  perf-profile.children.cycles-pp.write
     12.65 ±108%      -5.2        7.42 ± 16%  perf-profile.children.cycles-pp.ksys_write
     48.84 ± 18%      -5.1       43.74 ± 12%  perf-profile.children.cycles-pp.do_syscall_64
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.children.cycles-pp.__cmd_record
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.children.cycles-pp.cmd_record
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.children.cycles-pp.main
     13.82 ± 48%      -4.1        9.74 ± 23%  perf-profile.children.cycles-pp.run_builtin
      5.12 ±144%      -3.3        1.84 ± 81%  perf-profile.children.cycles-pp.perf_c2c__record
      2.95 ±223%      -3.0        0.00        perf-profile.children.cycles-pp.console_flush_all
      2.95 ±223%      -3.0        0.00        perf-profile.children.cycles-pp.console_unlock
      2.95 ±223%      -3.0        0.00        perf-profile.children.cycles-pp.devkmsg_emit
      2.95 ±223%      -3.0        0.00        perf-profile.children.cycles-pp.devkmsg_write
      2.95 ±223%      -3.0        0.00        perf-profile.children.cycles-pp.vprintk_emit
     10.74 ± 65%      -2.9        7.86 ± 17%  perf-profile.children.cycles-pp.record__mmap_read_evlist
     10.59 ± 67%      -2.7        7.86 ± 17%  perf-profile.children.cycles-pp.perf_mmap__push
      9.70 ± 74%      -2.6        7.14 ± 15%  perf-profile.children.cycles-pp.generic_perform_write
      9.70 ± 74%      -2.6        7.14 ± 15%  perf-profile.children.cycles-pp.shmem_file_write_iter
      2.51 ±223%      -2.5        0.00        perf-profile.children.cycles-pp.serial8250_console_write
      2.51 ±223%      -2.5        0.00        perf-profile.children.cycles-pp.wait_for_lsr
      9.85 ± 72%      -2.4        7.43 ± 11%  perf-profile.children.cycles-pp.writen
      9.70 ± 74%      -2.4        7.28 ± 14%  perf-profile.children.cycles-pp.record__pushfn
      2.21 ±223%      -2.2        0.00        perf-profile.children.cycles-pp.io_serial_in
      3.88 ± 50%      -1.6        2.24 ± 56%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      3.75 ± 53%      -1.4        2.38 ± 62%  perf-profile.children.cycles-pp.rep_movs_alternative
      2.01 ± 77%      -1.2        0.81 ± 99%  perf-profile.children.cycles-pp.perf_evsel__run_ioctl
      3.14 ± 44%      -1.1        2.02 ± 58%  perf-profile.children.cycles-pp.open64
      2.08 ± 40%      -1.1        0.98 ±125%  perf-profile.children.cycles-pp.link_path_walk
      1.07 ± 83%      -1.1        0.00        perf-profile.children.cycles-pp.perf_event_mmap
      1.07 ± 83%      -1.1        0.00        perf-profile.children.cycles-pp.perf_event_mmap_event
      1.20 ± 36%      -1.1        0.14 ±223%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      1.85 ± 68%      -1.0        0.81 ± 99%  perf-profile.children.cycles-pp.ioctl
      1.92 ±103%      -1.0        0.96 ± 77%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      1.92 ±103%      -1.0        0.96 ± 77%  perf-profile.children.cycles-pp.shmem_write_begin
      1.78 ± 94%      -1.0        0.82 ±100%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      2.36 ± 21%      -0.9        1.43 ± 43%  perf-profile.children.cycles-pp._Fork
      1.33 ± 82%      -0.9        0.40 ±100%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      1.22 ± 58%      -0.9        0.31 ±143%  perf-profile.children.cycles-pp.__irqentry_text_end
      1.32 ± 59%      -0.9        0.42 ±150%  perf-profile.children.cycles-pp.d_alloc
      1.32 ± 59%      -0.9        0.42 ±150%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.90 ± 82%      -0.9        0.00        perf-profile.children.cycles-pp.__d_alloc
      2.10 ± 43%      -0.9        1.21 ±105%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.56 ± 91%      -0.9        0.68 ± 81%  perf-profile.children.cycles-pp.perf_evsel__enable_cpu
      1.02 ±125%      -0.9        0.14 ±223%  perf-profile.children.cycles-pp.perf_rotate_context
      1.95 ± 48%      -0.9        1.08 ± 91%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.26 ± 68%      -0.9        1.40 ± 63%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.02 ± 90%      -0.8        1.21 ± 90%  perf-profile.children.cycles-pp.intel_idle_irq
      2.42 ± 44%      -0.8        1.62 ± 62%  perf-profile.children.cycles-pp.do_mmap
      2.42 ± 44%      -0.8        1.62 ± 62%  perf-profile.children.cycles-pp.mmap_region
      2.55 ± 39%      -0.8        1.76 ± 65%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.21 ± 74%      -0.8        0.42 ±154%  perf-profile.children.cycles-pp.exec_mmap
      1.36 ± 83%      -0.8        0.58 ±107%  perf-profile.children.cycles-pp.__evlist__disable
      3.76 ± 38%      -0.8        3.00 ± 50%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.90 ±103%      -0.8        0.14 ±223%  perf-profile.children.cycles-pp.__lookup_slow
      0.76 ± 87%      -0.8        0.00        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.89 ± 82%      -0.8        0.14 ±223%  perf-profile.children.cycles-pp.perf_iterate_sb
      1.02 ±125%      -0.8        0.26 ±141%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.74 ±223%      -0.7        0.00        perf-profile.children.cycles-pp.wait_for_xmitr
      0.72 ±179%      -0.7        0.00        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      4.83 ± 39%      -0.7        4.14 ± 54%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.65 ± 75%      -0.7        0.97 ± 90%  perf-profile.children.cycles-pp.walk_component
      1.80 ± 51%      -0.7        1.11 ± 72%  perf-profile.children.cycles-pp.unmap_vmas
      1.21 ± 74%      -0.7        0.56 ±114%  perf-profile.children.cycles-pp.begin_new_exec
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.children.cycles-pp.__do_sys_clone
      2.06 ± 34%      -0.6        1.43 ± 43%  perf-profile.children.cycles-pp.kernel_clone
      0.61 ±166%      -0.6        0.00        perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.60 ± 71%      -0.6        0.00        perf-profile.children.cycles-pp.__output_copy
      0.60 ± 71%      -0.6        0.00        perf-profile.children.cycles-pp.perf_output_copy
      0.89 ± 59%      -0.6        0.30 ±143%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.58 ±113%      -0.6        0.00        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.24 ± 83%      -0.6        0.68 ± 81%  perf-profile.children.cycles-pp.perf_ioctl
      1.37 ± 66%      -0.6        0.81 ± 99%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      1.07 ± 83%      -0.5        0.55 ± 70%  perf-profile.children.cycles-pp.arch_show_interrupts
      1.63 ± 68%      -0.5        1.11 ± 72%  perf-profile.children.cycles-pp.unmap_page_range
      1.63 ± 68%      -0.5        1.11 ± 72%  perf-profile.children.cycles-pp.zap_pmd_range
      1.80 ± 58%      -0.5        1.29 ± 81%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.88 ±100%      -0.5        0.41 ±155%  perf-profile.children.cycles-pp.__do_fault
      8.42 ± 30%      -0.5        7.96 ± 30%  perf-profile.children.cycles-pp.vfs_read
      0.46 ±100%      -0.5        0.00        perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.46 ±100%      -0.5        0.00        perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.46 ±100%      -0.5        0.00        perf-profile.children.cycles-pp.select_task_rq_fair
      0.46 ±100%      -0.5        0.00        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.46 ±100%      -0.5        0.00        perf-profile.children.cycles-pp.wake_up_new_task
      0.87 ± 79%      -0.5        0.42 ±100%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.87 ± 79%      -0.5        0.42 ±100%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.75 ± 84%      -0.5        0.29 ±223%  perf-profile.children.cycles-pp.__count_memcg_events
      0.90 ± 57%      -0.4        0.44 ±101%  perf-profile.children.cycles-pp.shmem_write_end
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.bit_putcs
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.con_scroll
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.drm_fbdev_generic_defio_imageblit
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.fast_imageblit
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.fbcon_putcs
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.fbcon_redraw
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.fbcon_scroll
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.lf
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.sys_imageblit
      0.44 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.vt_console_print
      0.44 ±100%      -0.4        0.00        perf-profile.children.cycles-pp.shmem_alloc_folio
      0.74 ± 45%      -0.4        0.30 ±143%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.43 ±156%      -0.4        0.00        perf-profile.children.cycles-pp.pte_alloc_one
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.children.cycles-pp.__x64_sys_execve
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.children.cycles-pp.do_execveat_common
      2.40 ± 31%      -0.4        1.98 ± 61%  perf-profile.children.cycles-pp.execve
      1.72 ± 92%      -0.4        1.30 ± 52%  perf-profile.children.cycles-pp.__evlist__enable
      1.10 ± 94%      -0.4        0.69 ± 85%  perf-profile.children.cycles-pp.generic_exec_single
      1.08 ± 77%      -0.4        0.68 ± 81%  perf-profile.children.cycles-pp._perf_ioctl
      1.35 ± 64%      -0.4        0.98 ±116%  perf-profile.children.cycles-pp.vfs_statx
      1.48 ± 58%      -0.4        1.11 ± 72%  perf-profile.children.cycles-pp.zap_pte_range
      8.72 ± 28%      -0.3        8.37 ± 27%  perf-profile.children.cycles-pp.read
      0.75 ± 45%      -0.3        0.40 ±100%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.50 ± 56%      -0.3        1.16 ± 91%  perf-profile.children.cycles-pp.vfs_fstatat
      0.60 ± 70%      -0.3        0.26 ±141%  perf-profile.children.cycles-pp.event_function
      0.60 ± 70%      -0.3        0.26 ±141%  perf-profile.children.cycles-pp.remote_function
      1.17 ± 55%      -0.3        0.84 ± 83%  perf-profile.children.cycles-pp.zap_present_ptes
      1.03 ± 77%      -0.3        0.69 ±130%  perf-profile.children.cycles-pp.filename_lookup
      1.03 ± 77%      -0.3        0.69 ±130%  perf-profile.children.cycles-pp.path_lookupat
      0.48 ±154%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      8.42 ± 30%      -0.3        8.09 ± 27%  perf-profile.children.cycles-pp.ksys_read
      0.46 ±100%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.copy_strings
      0.46 ±153%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.affinity__set
      0.60 ± 71%      -0.3        0.28 ±141%  perf-profile.children.cycles-pp.pipe_read
      0.32 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.bitmap_string
      0.32 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.cpuset_task_status_allowed
      0.31 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.__mmdrop
      0.45 ±100%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.perf_evsel__disable_cpu
      0.31 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.__rb_erase_color
      0.31 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.path_put
      0.74 ± 82%      -0.3        0.44 ±101%  perf-profile.children.cycles-pp.__x64_sys_close
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.idle_cpu
      0.43 ±156%      -0.3        0.13 ±223%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.children.cycles-pp.alloc_inode
      0.30 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.30 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.mas_wr_walk
      0.30 ±142%      -0.3        0.00        perf-profile.children.cycles-pp.kfree
      0.30 ±223%      -0.3        0.00        perf-profile.children.cycles-pp.delay_tsc
      0.28 ±142%      -0.3        0.00        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.28 ±142%      -0.3        0.00        perf-profile.children.cycles-pp.rmqueue
      0.28 ±142%      -0.3        0.00        perf-profile.children.cycles-pp.rmqueue_bulk
      0.56 ±141%      -0.3        0.28 ±141%  perf-profile.children.cycles-pp.anon_vma_fork
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.children.cycles-pp.rest_init
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.children.cycles-pp.start_kernel
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.41 ±149%      -0.3        0.13 ±223%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.28 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.anon_vma_clone
      0.28 ±141%      -0.3        0.00        perf-profile.children.cycles-pp.kmalloc_trace_noprof
      1.14 ± 84%      -0.2        0.90 ± 86%  perf-profile.children.cycles-pp.lookup_open
      0.80 ±130%      -0.2        0.56 ±114%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.80 ±130%      -0.2        0.56 ±114%  perf-profile.children.cycles-pp.llist_add_batch
      2.53 ± 54%      -0.2        2.30 ± 61%  perf-profile.children.cycles-pp.show_interrupts
      1.50 ± 56%      -0.2        1.28 ± 61%  perf-profile.children.cycles-pp.fstatat64
      4.86 ± 31%      -0.2        4.66 ± 33%  perf-profile.children.cycles-pp.__x64_sys_openat
      4.86 ± 31%      -0.2        4.66 ± 33%  perf-profile.children.cycles-pp.do_sys_openat2
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.children.cycles-pp.perf_ctx_enable
      0.46 ±100%      -0.2        0.26 ±141%  perf-profile.children.cycles-pp.perf_event_for_each_child
      0.32 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.get_arg_page
      0.44 ±100%      -0.2        0.26 ±141%  perf-profile.children.cycles-pp.__close_nocancel
      0.45 ±100%      -0.2        0.28 ±141%  perf-profile.children.cycles-pp.wait4
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.children.cycles-pp.kernel_wait4
      4.42 ± 26%      -0.2        4.25 ± 36%  perf-profile.children.cycles-pp.do_filp_open
      4.42 ± 26%      -0.2        4.25 ± 36%  perf-profile.children.cycles-pp.path_openat
      1.30 ± 60%      -0.2        1.13 ± 52%  perf-profile.children.cycles-pp._raw_spin_lock
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.__dentry_kill
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.72 ±107%      -0.2        0.55 ± 70%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.43 ±100%      -0.2        0.26 ±223%  perf-profile.children.cycles-pp.menu_select
      0.31 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.31 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.61 ± 70%      -0.2        0.45 ±146%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.folio_add_lru
      1.60 ± 50%      -0.2        1.43 ± 43%  perf-profile.children.cycles-pp.copy_process
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.___pud_free_tlb
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__dup2
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__lookup_mnt
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__perf_event__output_id_sample
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.atomic_dec_and_mutex_lock
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.complete_all
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.expand_downwards
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.free_percpu
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.from_kuid_munged
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.hw_perf_event_destroy
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.intel_bts_enable_local
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.map_id_up
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.memcg_check_events
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.percpu_counter_destroy_many
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.perf_evsel__ioctl
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.set_pte_vaddr
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.x86_release_hardware
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.44 ±100%      -0.2        0.28 ±141%  perf-profile.children.cycles-pp.__do_wait
      0.44 ±100%      -0.2        0.28 ±141%  perf-profile.children.cycles-pp.do_wait
      0.44 ±100%      -0.2        0.28 ±141%  perf-profile.children.cycles-pp.wait_task_zombie
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__d_add
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__put_anon_vma
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.complete_signal
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.d_lru_add
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.follow_page_mask
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.follow_page_pte
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.generic_file_mmap
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.list_lru_add
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.lockref_get
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.mas_walk
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.mnt_get_write_access
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.simple_lookup
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.task_tick_fair
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.touch_atime
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.wakeup_preempt
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.workingset_activation
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.workingset_age_nonresident
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.xa_load
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.xas_load
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__legitimize_mnt
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.alloc_slab_obj_exts
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.complete_walk
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.deactivate_slab
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.exit_fs
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.file_close_fd
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.pgd_alloc
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.pgd_ctor
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.procps_pids_get
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.task_cputime
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.thread_group_cputime
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.vdso_fault
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.vfs_fstat
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.44 ±100%      -0.2        0.29 ±141%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.30 ±223%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.perf_mmap_fault
      0.29 ±142%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.inode_permission
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__cleanup_sighand
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__exit_signal
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__free_pages
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__libc_fork
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__note_gp_changes
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__pte_alloc
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__seq_puts
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.copy_pte_range
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.irqentry_enter
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.kernfs_dir_pos
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.kernfs_put
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.page_counter_try_charge
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.pcpu_alloc_area
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.putname
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.rcu_accelerate_cbs
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.rcu_segcblist_accelerate
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.render_cap_t
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.rw_verify_area
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.schedule_tail
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.security_file_permission
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.switch_task_namespaces
      0.15 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.try_charge_memcg
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.new_inode
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.28 ±142%      -0.2        0.14 ±223%  perf-profile.children.cycles-pp.proc_pident_instantiate
      0.28 ±141%      -0.1        0.13 ±223%  perf-profile.children.cycles-pp.__init_rwsem
      0.28 ±141%      -0.1        0.14 ±223%  perf-profile.children.cycles-pp.kernfs_iop_lookup
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.__check_heap_object
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.__fput_sync
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.__vm_enough_memory
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.error_entry
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.exc_nmi
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.seq_write
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.shmem_is_huge
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.strnlen_user
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.xas_store
      0.32 ±141%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.28 ±142%      -0.1        0.14 ±223%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.28 ±141%      -0.1        0.14 ±223%  perf-profile.children.cycles-pp.memcpy_orig
      0.29 ±142%      -0.1        0.14 ±223%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.28 ±141%      -0.1        0.14 ±223%  perf-profile.children.cycles-pp.release_task
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp._IO_file_finish
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp._nohz_idle_balance
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.apparmor_mmap_file
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.copy_fs_struct
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.d_find_any_alias
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.fclose
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.inode_init_always
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.kernfs_find_ns
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.mntput_no_expire
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.nd_jump_root
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_event_fork
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_event_task_output
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.proc_cgroup_show
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.readdir64
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.set_root
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.single_release
      0.30 ±141%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.note_gp_changes
      0.30 ±141%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.rcu_core
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.children.cycles-pp.bprm_execve
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.children.cycles-pp.exec_binprm
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.children.cycles-pp.load_elf_binary
      1.79 ± 40%      -0.1        1.67 ± 86%  perf-profile.children.cycles-pp.search_binary_handler
      0.30 ±142%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.30 ±142%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.tick_irq_enter
      1.97 ± 42%      -0.1        1.85 ± 96%  perf-profile.children.cycles-pp.seq_read
      2.33 ± 67%      -0.1        2.22 ± 42%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.33 ± 67%      -0.1        2.22 ± 42%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28 ±142%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.28 ±142%      -0.1        0.18 ±223%  perf-profile.children.cycles-pp.copy_mc_fragile
      1.47 ± 52%      -0.1        1.37 ± 87%  perf-profile.children.cycles-pp.__open64_nocancel
      1.23 ± 56%      -0.1        1.14 ± 88%  perf-profile.children.cycles-pp.lookup_fast
      0.48 ±154%      -0.1        0.42 ±100%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.46 ±152%      -0.0        0.41 ±100%  perf-profile.children.cycles-pp.ring_buffer_write_tail
      0.94 ± 82%      -0.0        0.89 ± 87%  perf-profile.children.cycles-pp.filemap_map_pages
      0.47 ±100%      -0.0        0.42 ±223%  perf-profile.children.cycles-pp.do_anonymous_page
      1.33 ± 30%      -0.0        1.29 ± 63%  perf-profile.children.cycles-pp.dup_mm
      0.32 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.32 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.30 ±223%      -0.0        0.26 ±141%  perf-profile.children.cycles-pp.number
      0.31 ±141%      -0.0        0.27 ±141%  perf-profile.children.cycles-pp.perf_mmap__consume
      0.45 ±153%      -0.0        0.41 ±155%  perf-profile.children.cycles-pp.swevent_hlist_put_cpu
      0.32 ±141%      -0.0        0.28 ±223%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.30 ±141%      -0.0        0.26 ±141%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.31 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.87 ± 78%      -0.0        0.84 ± 93%  perf-profile.children.cycles-pp.dup_mmap
      0.30 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.30 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.set_pte_range
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.mas_preallocate
      0.30 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.30 ±223%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.__legitimize_path
      0.30 ±223%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.try_to_unlazy
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.children.cycles-pp.copy_p4d_range
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.children.cycles-pp.copy_page_range
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.__send_signal_locked
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.do_notify_parent
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.do_wp_page
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.exit_notify
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.pid_revalidate
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.28 ±142%      -0.0        0.26 ±141%  perf-profile.children.cycles-pp.get_jiffies_update
      0.28 ±142%      -0.0        0.26 ±141%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.common_perm_cond
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.perf_remove_from_owner
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.__get_user_8
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.__sysconf
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.allocate_slab
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.91 ±114%      -0.0        0.89 ± 69%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.15 ±223%      -0.0        0.13 ±223%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.cp_new_stat
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.iget_locked
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.kernfs_get_inode
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.__get_user_pages
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.do_task_dead
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.acpi_os_read_memory
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.filldir64
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.apparmor_ptrace_access_check
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.unlink_file_vma
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp._IO_link_in
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.finish_task_switch
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.__check_object_size
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.single_open
      0.44 ±100%      -0.0        0.44 ±145%  perf-profile.children.cycles-pp.format_decode
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.28 ±141%      -0.0        0.28 ±141%  perf-profile.children.cycles-pp.___perf_sw_event
      0.31 ±141%      +0.0        0.31 ±143%  perf-profile.children.cycles-pp.task_state
      0.31 ±223%      +0.0        0.31 ±143%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.__fdget
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.perf_output_begin
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.security_mmap_file
      1.62 ± 70%      +0.0        1.62 ± 63%  perf-profile.children.cycles-pp.open_last_lookups
      0.58 ± 71%      +0.0        0.59 ± 72%  perf-profile.children.cycles-pp.__close
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.mtree_load
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.path_init
      0.61 ±111%      +0.0        0.62 ±143%  perf-profile.children.cycles-pp.mm_init
      7.67 ± 27%      +0.0        7.68 ± 31%  perf-profile.children.cycles-pp.seq_read_iter
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.__do_sys_waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.down_write
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.kernel_waitid
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.prepare_task_switch
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.children.cycles-pp.waitid
      1.97 ± 44%      +0.0        1.99 ± 60%  perf-profile.children.cycles-pp.seq_printf
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.children.cycles-pp.alloc_bprm
      0.28 ±142%      +0.0        0.31 ±143%  perf-profile.children.cycles-pp.proc_pident_lookup
      1.90 ± 63%      +0.0        1.94 ± 41%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.58 ±113%      +0.0        0.63 ±120%  perf-profile.children.cycles-pp.wp_page_copy
      0.30 ±141%      +0.0        0.35 ±223%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.74 ± 84%      +0.1        0.82 ±115%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.30 ±141%      +0.1        0.40 ±151%  perf-profile.children.cycles-pp.__d_lookup
      0.32 ±141%      +0.1        0.41 ±100%  perf-profile.children.cycles-pp.___slab_alloc
      1.81 ± 41%      +0.1        1.91 ± 39%  perf-profile.children.cycles-pp.do_read_fault
      0.46 ±100%      +0.1        0.56 ±110%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.46 ±100%      +0.1        0.56 ±110%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.31 ±141%      +0.1        0.41 ±152%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.31 ±141%      +0.1        0.41 ±100%  perf-profile.children.cycles-pp.show_softirqs
      0.16 ±223%      +0.1        0.26 ±223%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.30 ±223%      +0.1        0.41 ±155%  perf-profile.children.cycles-pp.mutex_lock
      0.44 ±100%      +0.1        0.56 ±112%  perf-profile.children.cycles-pp.step_into
      0.30 ±141%      +0.1        0.42 ±150%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.16 ±223%      +0.1        0.27 ±141%  perf-profile.children.cycles-pp.perf_mmap__write_tail
      0.89 ± 60%      +0.1        1.00 ± 89%  perf-profile.children.cycles-pp.dput
      3.22 ± 47%      +0.1        3.33 ± 41%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.15 ±223%      +0.1        0.27 ±141%  perf-profile.children.cycles-pp.vma_prepare
      0.88 ± 80%      +0.1        1.00 ± 72%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.16 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.move_queued_task
      0.15 ±223%      +0.1        0.27 ±141%  perf-profile.children.cycles-pp.__perf_sw_event
      0.16 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.up_read
      0.15 ±223%      +0.1        0.27 ±223%  perf-profile.children.cycles-pp.ptrace_may_access
      0.16 ±223%      +0.1        0.29 ±141%  perf-profile.children.cycles-pp.security_inode_getattr
      0.33 ±223%      +0.1        0.45 ±101%  perf-profile.children.cycles-pp.up_write
      0.15 ±223%      +0.1        0.27 ±141%  perf-profile.children.cycles-pp.strncpy_from_user
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.children.cycles-pp.free_p4d_range
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.children.cycles-pp.free_pgd_range
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.children.cycles-pp.free_pud_range
      0.31 ±223%      +0.1        0.44 ±223%  perf-profile.children.cycles-pp.next_tgid
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.strlen
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.30 ±141%      +0.1        0.44 ±223%  perf-profile.children.cycles-pp.pid_nr_ns
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.__sigsetjmp
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.cfree
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.do_epoll_wait
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.ep_poll
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.inode_add_bytes
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.perf_event_ctx_lock_nested
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.snprintf
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.task_rq_lock
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.try_module_get
      0.00            +0.1        0.13 ±223%  perf-profile.children.cycles-pp.vma_expand
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.memset_orig
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.children.cycles-pp.clockevents_program_event
      0.30 ±141%      +0.1        0.44 ±145%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ±223%      +0.1        0.29 ±223%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.28 ±141%      +0.1        0.41 ±151%  perf-profile.children.cycles-pp.terminate_walk
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__ptrace_may_access
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.exclusive_event_destroy
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.folio_unlock
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.get_vma_policy
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ghes_notify_nmi
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.handle_pte_fault
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.inode_sb_list_add
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.iput
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.nmi_restore
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.perf_event_comm
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.perf_event_comm_event
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.perf_event_comm_output
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.pipe_write
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.prepare_signal
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.update_sd_pick_busiest
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__install_special_mapping
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__memcpy_chk
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__munmap
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__vm_area_free
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp._copy_to_iter
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp._exit
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.anon_vma_ctor
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.apparmor_file_open
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.bitmap_list_string
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.change_protection_range
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.epoll_wait@plt
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.exit_mm_release
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.futex_cleanup
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.futex_exit_release
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ima_file_mmap
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.local_touch_nmi
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.map_vdso
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mas_push_data
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mas_split
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mast_fill_bnode
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.may_open
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.perf_sample_event_took
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.sched_balance_trigger
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.security_file_open
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.setup_object
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.shuffle_freelist
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.task_numa_group_id
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.unaccount_event
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.vma_complete
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.zero_user_segments
      0.45 ±100%      +0.1        0.59 ±106%  perf-profile.children.cycles-pp.do_task_stat
      1.63 ± 34%      +0.1        1.77 ± 79%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__isoc99_fscanf
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__strtod_internal
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__wait_for_common
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.alloc_fd
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.check_heap_object
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.getenv
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.lock_for_kill
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.perf_mmap_to_page
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.sched_balance_find_src_rq
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.seq_open
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.wcschr
      0.41 ±149%      +0.1        0.56 ±114%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.___pmd_free_tlb
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__enqueue_entity
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.__put_user_8
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.balance_rt
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.d_invalidate
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.d_walk
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.do_read_cache_folio
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.dup_task_struct
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.get_sigframe
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.get_task_mm
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.handle_signal
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.intel_bts_disable_local
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mas_find
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.mas_next_slot
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.module_put
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.num_to_str
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.put_dec
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.put_dec_full8
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.read_cache_page
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.timekeeping_update
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.update_vsyscall
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.1        0.14 ±223%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      1.66 ± 59%      +0.1        1.80 ± 77%  perf-profile.children.cycles-pp.vsnprintf
      0.16 ±223%      +0.2        0.31 ±143%  perf-profile.children.cycles-pp.filp_flush
      0.99 ±119%      +0.2        1.15 ± 69%  perf-profile.children.cycles-pp.poll_idle
      0.16 ±223%      +0.2        0.32 ±142%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.13 ±223%      +0.2        0.29 ±223%  perf-profile.children.cycles-pp.read_tsc
      0.15 ±223%      +0.2        0.30 ±143%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.15 ±223%      +0.2        0.30 ±143%  perf-profile.children.cycles-pp.security_file_free
      0.15 ±223%      +0.2        0.31 ±143%  perf-profile.children.cycles-pp.rb_next
      0.43 ±100%      +0.2        0.59 ±109%  perf-profile.children.cycles-pp.lockref_put_return
      0.46 ±100%      +0.2        0.62 ±143%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      1.02 ± 57%      +0.2        1.19 ± 74%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.15 ±223%      +0.2        0.32 ±142%  perf-profile.children.cycles-pp._compound_head
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.__ctype_init
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.__isoc99_sscanf
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.__strtoll_internal
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.enqueue_task_stop
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.getrandom
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.proc_task_name
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.render_sigset_t
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.sched_move_task
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.seq_putc
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.task_seccomp
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.2        0.18 ±223%  perf-profile.children.cycles-pp.wq_worker_comm
      0.77 ± 82%      +0.2        0.97 ± 91%  perf-profile.children.cycles-pp.mod_objcg_state
      0.60 ± 71%      +0.2        0.81 ±100%  perf-profile.children.cycles-pp.__mmap
      0.46 ±100%      +0.2        0.67 ±106%  perf-profile.children.cycles-pp.do_open
      0.31 ±141%      +0.2        0.53 ±141%  perf-profile.children.cycles-pp.proc_fill_cache
      0.74 ±110%      +0.2        0.97 ± 94%  perf-profile.children.cycles-pp.kmem_cache_free
      0.31 ±141%      +0.2        0.54 ± 70%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.30 ±141%      +0.2        0.54 ±109%  perf-profile.children.cycles-pp.do_dentry_open
      0.32 ±141%      +0.2        0.56 ±110%  perf-profile.children.cycles-pp.mprotect_fixup
      0.16 ±223%      +0.2        0.41 ±100%  perf-profile.children.cycles-pp.enqueue_entity
      0.16 ±223%      +0.2        0.41 ±151%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.58 ±113%      +0.2        0.83 ± 80%  perf-profile.children.cycles-pp.elf_load
      0.15 ±223%      +0.2        0.40 ±152%  perf-profile.children.cycles-pp.unmap_region
      5.33 ± 51%      +0.3        5.58 ± 27%  perf-profile.children.cycles-pp.event_function_call
      5.33 ± 51%      +0.3        5.58 ± 27%  perf-profile.children.cycles-pp.smp_call_function_single
      0.88 ± 80%      +0.3        1.13 ± 88%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.88 ± 80%      +0.3        1.13 ± 88%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.32 ±141%      +0.3        0.58 ± 72%  perf-profile.children.cycles-pp.update_load_avg
      0.15 ±223%      +0.3        0.41 ±100%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.00            +0.3        0.26 ±141%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.3        0.26 ±141%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.3        0.26 ±141%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.00            +0.3        0.26 ±141%  perf-profile.children.cycles-pp.epoll_wait
      0.77 ±111%      +0.3        1.03 ±113%  perf-profile.children.cycles-pp.free_pgtables
      0.15 ±223%      +0.3        0.42 ±100%  perf-profile.children.cycles-pp.vma_modify
      0.00            +0.3        0.27 ±223%  perf-profile.children.cycles-pp.copy_page
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.clock_gettime
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.find_next_iomem_res
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.lookup_memtype
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.pat_pagerange_is_ram
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.track_pfn_insert
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.vmf_insert_pfn_prot
      0.00            +0.3        0.27 ±141%  perf-profile.children.cycles-pp.walk_system_ram_range
      0.15 ±223%      +0.3        0.42 ±100%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.page_get_link
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.pick_link
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.__page_cache_release
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.flush_tlb_func
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.x64_sys_call
      0.30 ±223%      +0.3        0.58 ±106%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.folio_prealloc
      0.00            +0.3        0.28 ±141%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.30 ±141%      +0.3        0.59 ±110%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.3        0.28 ±223%  perf-profile.children.cycles-pp.find_vma
      0.00            +0.3        0.28 ±223%  perf-profile.children.cycles-pp.mt_find
      0.31 ±223%      +0.3        0.60 ± 71%  perf-profile.children.cycles-pp.sched_tick
      0.13 ±223%      +0.3        0.42 ±100%  perf-profile.children.cycles-pp.load_elf_interp
      0.43 ±156%      +0.3        0.73 ±103%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      0.15 ±223%      +0.3        0.45 ±101%  perf-profile.children.cycles-pp.init_file
      0.15 ±223%      +0.3        0.45 ±101%  perf-profile.children.cycles-pp.security_file_alloc
      0.15 ±223%      +0.3        0.45 ±101%  perf-profile.children.cycles-pp.getname_flags
      0.13 ±223%      +0.3        0.44 ±101%  perf-profile.children.cycles-pp.fput
      0.00            +0.3        0.31 ±143%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.00            +0.3        0.31 ±143%  perf-profile.children.cycles-pp.free_unref_folios
      0.00            +0.3        0.31 ±143%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.13 ±223%      +0.3        0.46 ±101%  perf-profile.children.cycles-pp.sched_balance_domains
      0.16 ±223%      +0.3        0.49 ±161%  perf-profile.children.cycles-pp.filp_close
      0.16 ±223%      +0.3        0.49 ±161%  perf-profile.children.cycles-pp.put_files_struct
      0.16 ±223%      +0.3        0.49 ±161%  perf-profile.children.cycles-pp.try_to_wake_up
      0.93 ± 60%      +0.3        1.26 ±120%  perf-profile.children.cycles-pp.proc_pid_status
      1.52 ± 31%      +0.3        1.85 ± 96%  perf-profile.children.cycles-pp.proc_single_show
      0.15 ±223%      +0.3        0.49 ±159%  perf-profile.children.cycles-pp.affine_move_task
      0.28 ±141%      +0.3        0.63 ±120%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.4        0.35 ±223%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.00            +0.4        0.35 ±223%  perf-profile.children.cycles-pp.wake_up_q
      0.45 ±100%      +0.4        0.81 ±114%  perf-profile.children.cycles-pp.vm_area_alloc
      0.46 ±100%      +0.4        0.83 ± 81%  perf-profile.children.cycles-pp.__split_vma
      0.32 ±141%      +0.4        0.68 ±108%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.44 ±100%      +0.4        0.81 ±138%  perf-profile.children.cycles-pp.handle_softirqs
      0.44 ±100%      +0.4        0.81 ±138%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.15 ±223%      +0.4        0.53 ±162%  perf-profile.children.cycles-pp.vm_area_dup
      0.16 ±223%      +0.4        0.56 ±114%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.16 ±223%      +0.4        0.56 ± 70%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.15 ±223%      +0.4        0.54 ±141%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.16 ±223%      +0.4        0.56 ±114%  perf-profile.children.cycles-pp.__slab_free
      0.29 ±142%      +0.4        0.72 ± 79%  perf-profile.children.cycles-pp.folios_put_refs
      0.16 ±223%      +0.4        0.60 ±110%  perf-profile.children.cycles-pp.activate_task
      2.26 ± 52%      +0.4        2.69 ± 31%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.4        0.45 ±101%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      3.74 ± 22%      +0.5        4.20 ± 46%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.5        0.46 ±100%  perf-profile.children.cycles-pp.finish_fault
      0.62 ±166%      +0.5        1.10 ±103%  perf-profile.children.cycles-pp.proc_pid_readdir
      0.74 ± 84%      +0.5        1.23 ±112%  perf-profile.children.cycles-pp.sched_balance_newidle
      3.00 ±104%      +0.5        3.50 ± 48%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      3.00 ±104%      +0.5        3.50 ± 48%  perf-profile.children.cycles-pp.fault_in_readable
      0.47 ±100%      +0.5        0.97 ±116%  perf-profile.children.cycles-pp.ret_from_fork
      0.47 ±100%      +0.5        0.97 ±116%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.16 ±223%      +0.5        0.68 ±108%  perf-profile.children.cycles-pp.get_cpu_idle_time_us
      0.46 ±100%      +0.5        0.99 ± 56%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.46 ±100%      +0.5        0.99 ± 56%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.44 ±100%      +0.5        0.96 ± 91%  perf-profile.children.cycles-pp.schedule
      0.00            +0.5        0.55 ±163%  perf-profile.children.cycles-pp.balance_fair
      0.29 ±142%      +0.6        0.86 ±133%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.6        0.59 ± 72%  perf-profile.children.cycles-pp.__vm_munmap
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.15 ±223%      +0.6        0.76 ± 93%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      1.63 ± 66%      +0.6        2.27 ± 41%  perf-profile.children.cycles-pp.sw_perf_event_destroy
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.children.cycles-pp.kthread
      0.32 ±141%      +0.6        0.97 ±116%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.88 ± 80%      +0.7        1.54 ± 75%  perf-profile.children.cycles-pp.sched_balance_rq
      4.65 ± 27%      +0.7        5.32 ± 40%  perf-profile.children.cycles-pp.exc_page_fault
      1.18 ± 31%      +0.7        1.87 ± 32%  perf-profile.children.cycles-pp.get_idle_time
      0.13 ±223%      +0.7        0.86 ± 55%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.13 ±223%      +0.7        0.86 ± 55%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.20 ± 95%      +0.8        1.95 ± 59%  perf-profile.children.cycles-pp.getdents64
      5.56 ± 26%      +0.8        6.32 ± 37%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      1.05 ± 94%      +0.8        1.82 ± 58%  perf-profile.children.cycles-pp.iterate_dir
      1.81 ± 41%      +0.8        2.60 ± 29%  perf-profile.children.cycles-pp.do_fault
      0.59 ±114%      +0.8        1.39 ± 38%  perf-profile.children.cycles-pp.update_process_times
      1.63 ± 33%      +0.8        2.43 ± 36%  perf-profile.children.cycles-pp.uptime_proc_show
      0.73 ±107%      +0.8        1.54 ± 31%  perf-profile.children.cycles-pp.tick_nohz_handler
      4.50 ± 24%      +0.8        5.32 ± 40%  perf-profile.children.cycles-pp.do_user_addr_fault
      8.22 ± 41%      +0.8        9.06 ± 52%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.13 ±223%      +0.9        1.00 ± 72%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.21 ± 58%      +0.9        2.07 ± 74%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      3.02 ± 30%      +0.9        3.92 ± 46%  perf-profile.children.cycles-pp.__handle_mm_fault
      2.54 ± 36%      +0.9        3.44 ± 66%  perf-profile.children.cycles-pp.__mmput
      2.54 ± 36%      +0.9        3.44 ± 66%  perf-profile.children.cycles-pp.exit_mmap
      2.10 ± 61%      +1.0        3.07 ± 53%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.80 ± 58%      +1.0        2.82 ± 29%  perf-profile.children.cycles-pp._free_event
      0.61 ±110%      +1.1        1.69 ±103%  perf-profile.children.cycles-pp.sched_setaffinity
      0.88 ± 80%      +1.4        2.24 ± 79%  perf-profile.children.cycles-pp.__schedule
      7.13 ± 38%      +1.6        8.69 ± 20%  perf-profile.children.cycles-pp.perf_event_release_kernel
      7.13 ± 38%      +1.6        8.69 ± 20%  perf-profile.children.cycles-pp.perf_release
      1.49 ± 45%      +1.7        3.15 ± 56%  perf-profile.children.cycles-pp.exit_mm
      8.03 ± 35%      +1.7        9.76 ± 12%  perf-profile.children.cycles-pp.__fput
      7.91 ± 42%      +1.8        9.72 ± 16%  perf-profile.children.cycles-pp.task_work_run
      0.00            +1.8        1.82 ±223%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.00            +1.8        1.82 ±223%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      8.06 ± 41%      +2.7       10.74 ± 21%  perf-profile.children.cycles-pp.get_signal
      8.06 ± 41%      +2.8       10.88 ± 23%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
     10.17 ± 37%      +3.6       13.81 ± 17%  perf-profile.children.cycles-pp.do_exit
     10.17 ± 37%      +3.6       13.81 ± 17%  perf-profile.children.cycles-pp.do_group_exit
     40.41 ± 17%      +3.9       44.32 ±  7%  perf-profile.children.cycles-pp.cpuidle_idle_call
     39.98 ± 17%      +3.9       43.92 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     39.98 ± 17%      +3.9       43.92 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     41.32 ± 17%      +4.4       45.72 ±  5%  perf-profile.children.cycles-pp.common_startup_64
     41.32 ± 17%      +4.4       45.72 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     41.32 ± 17%      +4.4       45.72 ±  5%  perf-profile.children.cycles-pp.do_idle
     34.34 ± 15%      +4.5       38.83 ±  9%  perf-profile.children.cycles-pp.intel_idle
     40.90 ± 17%      +4.7       45.59 ±  4%  perf-profile.children.cycles-pp.start_secondary
      2.21 ±223%      -2.2        0.00        perf-profile.self.cycles-pp.io_serial_in
      3.75 ± 53%      -1.5        2.24 ± 56%  perf-profile.self.cycles-pp.rep_movs_alternative
      1.33 ± 82%      -0.9        0.40 ±100%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      1.22 ± 58%      -0.9        0.31 ±143%  perf-profile.self.cycles-pp.__irqentry_text_end
      1.04 ± 60%      -0.9        0.13 ±223%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.26 ± 68%      -0.9        1.40 ± 63%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.90 ± 57%      -0.6        0.31 ±143%  perf-profile.self.cycles-pp.shmem_write_end
      1.76 ± 85%      -0.5        1.21 ± 90%  perf-profile.self.cycles-pp.intel_idle_irq
      0.46 ±100%      -0.5        0.00        perf-profile.self.cycles-pp.__output_copy
      0.46 ±100%      -0.5        0.00        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.44 ±223%      -0.4        0.00        perf-profile.self.cycles-pp.fast_imageblit
      0.33 ±223%      -0.3        0.00        perf-profile.self.cycles-pp.task_work_run
      1.49 ± 66%      -0.3        1.17 ± 72%  perf-profile.self.cycles-pp.show_interrupts
      0.58 ± 71%      -0.3        0.27 ±141%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.44 ±100%      -0.3        0.14 ±223%  perf-profile.self.cycles-pp.idle_cpu
      0.30 ±141%      -0.3        0.00        perf-profile.self.cycles-pp.mas_wr_walk
      0.30 ±141%      -0.3        0.00        perf-profile.self.cycles-pp.swevent_hlist_put_cpu
      0.30 ±142%      -0.3        0.00        perf-profile.self.cycles-pp.kfree
      0.30 ±223%      -0.3        0.00        perf-profile.self.cycles-pp.delay_tsc
      0.30 ±223%      -0.3        0.00        perf-profile.self.cycles-pp.perf_mmap_fault
      0.29 ±142%      -0.3        0.00        perf-profile.self.cycles-pp.handle_mm_fault
      0.28 ±142%      -0.3        0.00        perf-profile.self.cycles-pp.rmqueue_bulk
      0.28 ±141%      -0.3        0.00        perf-profile.self.cycles-pp._find_next_bit
      0.28 ±141%      -0.3        0.00        perf-profile.self.cycles-pp.kmem_cache_free
      0.28 ±141%      -0.3        0.00        perf-profile.self.cycles-pp.memcpy_orig
      0.80 ±130%      -0.2        0.56 ±114%  perf-profile.self.cycles-pp.llist_add_batch
      1.17 ± 55%      -0.2        1.00 ± 29%  perf-profile.self.cycles-pp._raw_spin_lock
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.affinity__set
      0.30 ±141%      -0.2        0.13 ±223%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.30 ±223%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.number
      0.72 ±107%      -0.2        0.55 ± 70%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.31 ±141%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.61 ± 70%      -0.2        0.45 ±146%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.31 ±141%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.zap_pte_range
      0.30 ±141%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.rcu_all_qs
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.___pud_free_tlb
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__d_alloc
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__lookup_mnt
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.atomic_dec_and_mutex_lock
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.bitmap_string
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.intel_bts_enable_local
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.lookup_fast
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.map_id_up
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.perf_evsel__ioctl
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.perf_remove_from_owner
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.pipe_read
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.set_pte_vaddr
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.unmap_vmas
      0.30 ±223%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.mutex_lock
      0.45 ±100%      -0.2        0.29 ±223%  perf-profile.self.cycles-pp.__count_memcg_events
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__rb_erase_color
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.do_task_stat
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.hrtimer_interrupt
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.lockref_get
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.mas_walk
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.mnt_get_write_access
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.next_tgid
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.perf_ioctl
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.proc_pid_status
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.sched_setaffinity
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.wakeup_preempt
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.workingset_age_nonresident
      0.16 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.xas_load
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__legitimize_mnt
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.deactivate_slab
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.irqtime_account_irq
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.pgd_ctor
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.procps_pids_get
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.ring_buffer_read_head
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.task_cputime
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.vdso_fault
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.zap_pmd_range
      0.28 ±141%      -0.2        0.13 ±223%  perf-profile.self.cycles-pp.menu_select
      0.29 ±142%      -0.2        0.14 ±223%  perf-profile.self.cycles-pp.inode_permission
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__cleanup_sighand
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__evlist__disable
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.__free_pages
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.affine_move_task
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.cp_new_stat
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.event_function
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.exc_page_fault
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.kernfs_put
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.page_counter_try_charge
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.putname
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.rcu_segcblist_accelerate
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.security_file_permission
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.switch_task_namespaces
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.15 ±223%      -0.2        0.00        perf-profile.self.cycles-pp.zap_present_ptes
      0.28 ±141%      -0.1        0.13 ±223%  perf-profile.self.cycles-pp.__init_rwsem
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__check_heap_object
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__do_fault
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__fput_sync
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__vm_enough_memory
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.do_mprotect_pkey
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.error_entry
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.exc_nmi
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.lru_add_fn
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.shmem_is_huge
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.strnlen_user
      0.15 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.xas_store
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.anon_vma_clone
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.anon_vma_fork
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.apparmor_mmap_file
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.elf_load
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.fclose
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.kernfs_find_ns
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.kernfs_fop_readdir
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.kmalloc_trace_noprof
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.mntput_no_expire
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.readdir64
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.set_root
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.tick_nohz_handler
      0.13 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.vm_area_alloc
      0.28 ±142%      -0.1        0.18 ±223%  perf-profile.self.cycles-pp.copy_mc_fragile
      0.88 ± 80%      -0.0        0.83 ± 82%  perf-profile.self.cycles-pp.vsnprintf
      0.31 ±141%      -0.0        0.26 ±141%  perf-profile.self.cycles-pp.show_softirqs
      1.52 ± 92%      -0.0        1.48 ± 64%  perf-profile.self.cycles-pp.fault_in_readable
      0.30 ±141%      -0.0        0.26 ±141%  perf-profile.self.cycles-pp.__d_lookup
      0.30 ±141%      -0.0        0.26 ±141%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.uptime_proc_show
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.pid_revalidate
      0.28 ±142%      -0.0        0.26 ±141%  perf-profile.self.cycles-pp.get_jiffies_update
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.common_perm_cond
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.__get_user_8
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.do_anonymous_page
      0.28 ±141%      -0.0        0.26 ±141%  perf-profile.self.cycles-pp.ktime_get
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.acpi_os_read_memory
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.filldir64
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.apparmor_ptrace_access_check
      0.16 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
      0.13 ±223%      -0.0        0.13 ±223%  perf-profile.self.cycles-pp.folios_put_refs
      0.15 ±223%      -0.0        0.14 ±223%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.28 ±141%      -0.0        0.28 ±141%  perf-profile.self.cycles-pp.___perf_sw_event
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.__fdget
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru_noprof
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.perf_output_begin
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.mtree_load
      0.16 ±223%      +0.0        0.18 ±223%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.13 ±223%      +0.0        0.14 ±223%  perf-profile.self.cycles-pp.down_write
      0.30 ±223%      +0.0        0.32 ±142%  perf-profile.self.cycles-pp.__fput
      0.15 ±223%      +0.0        0.18 ±223%  perf-profile.self.cycles-pp.note_gp_changes
      0.33 ±223%      +0.0        0.35 ±223%  perf-profile.self.cycles-pp.filemap_map_pages
      0.32 ±141%      +0.1        0.40 ±100%  perf-profile.self.cycles-pp.update_load_avg
      0.33 ±223%      +0.1        0.42 ±100%  perf-profile.self.cycles-pp.arch_show_interrupts
      0.31 ±141%      +0.1        0.41 ±152%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.16 ±223%      +0.1        0.27 ±141%  perf-profile.self.cycles-pp.___slab_alloc
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.16 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.ring_buffer_write_tail
      0.16 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.up_read
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.33 ±223%      +0.1        0.45 ±101%  perf-profile.self.cycles-pp.up_write
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.strlen
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.31 ±141%      +0.1        0.44 ±145%  perf-profile.self.cycles-pp.format_decode
      0.30 ±141%      +0.1        0.44 ±223%  perf-profile.self.cycles-pp.pid_nr_ns
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.__sigsetjmp
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.cfree
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.inode_add_bytes
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.pagecache_get_page
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.strncpy_from_user
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.task_rq_lock
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.13 ±223%  perf-profile.self.cycles-pp.wait_task_zombie
      0.15 ±223%      +0.1        0.28 ±141%  perf-profile.self.cycles-pp.memset_orig
      0.30 ±141%      +0.1        0.44 ±145%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__ptrace_may_access
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp._copy_to_user
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.exclusive_event_destroy
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.folio_unlock
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.get_vma_policy
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.ghes_notify_nmi
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.handle_pte_fault
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.nmi_restore
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.prepare_signal
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.should_we_balance
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.update_sd_pick_busiest
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__perf_sw_event
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.anon_vma_ctor
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.apparmor_file_open
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.change_protection_range
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.epoll_wait@plt
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.local_touch_nmi
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.mast_fill_bnode
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.perf_sample_event_took
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.sched_balance_trigger
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.task_numa_group_id
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.unaccount_event
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp._IO_link_in
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__page_cache_release
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__strtod_internal
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp._free_event
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.kernfs_dop_revalidate
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.lock_for_kill
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.path_lookupat
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.perf_mmap_to_page
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.sched_balance_find_src_rq
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.security_inode_getattr
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.walk_component
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.wcschr
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.___pmd_free_tlb
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__enqueue_entity
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.__put_user_8
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.balance_rt
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.d_walk
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.do_fault
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.do_read_fault
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.free_pud_range
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.get_task_mm
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.intel_bts_disable_local
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.mas_next_slot
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.module_put
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.put_dec_full8
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.rep_stos_alternative
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.sched_balance_domains
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.update_vsyscall
      0.16 ±223%      +0.2        0.32 ±142%  perf-profile.self.cycles-pp.seq_printf
      0.16 ±223%      +0.2        0.31 ±143%  perf-profile.self.cycles-pp.filp_flush
      0.99 ±119%      +0.2        1.15 ± 69%  perf-profile.self.cycles-pp.poll_idle
      0.13 ±223%      +0.2        0.29 ±223%  perf-profile.self.cycles-pp.read_tsc
      0.15 ±223%      +0.2        0.30 ±143%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.15 ±223%      +0.2        0.31 ±143%  perf-profile.self.cycles-pp.rb_next
      0.43 ±100%      +0.2        0.59 ±109%  perf-profile.self.cycles-pp.lockref_put_return
      0.15 ±223%      +0.2        0.32 ±142%  perf-profile.self.cycles-pp._compound_head
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.__strtoll_internal
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.enqueue_task_stop
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.handle_softirqs
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.lookup_open
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.proc_pident_lookup
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.seq_putc
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.task_seccomp
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.2        0.18 ±223%  perf-profile.self.cycles-pp.wq_worker_comm
      0.62 ± 70%      +0.2        0.84 ±114%  perf-profile.self.cycles-pp.mod_objcg_state
      0.31 ±141%      +0.2        0.54 ± 70%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.16 ±223%      +0.2        0.41 ±151%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.3        0.26 ±223%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.3        0.26 ±141%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.00            +0.3        0.26 ±141%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.3        0.27 ±223%  perf-profile.self.cycles-pp.copy_page
      0.00            +0.3        0.27 ±141%  perf-profile.self.cycles-pp.find_next_iomem_res
      0.00            +0.3        0.27 ±223%  perf-profile.self.cycles-pp.proc_fill_cache
      0.00            +0.3        0.28 ±141%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.3        0.28 ±141%  perf-profile.self.cycles-pp.free_pgtables
      0.00            +0.3        0.28 ±141%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.3        0.28 ±141%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +0.3        0.28 ±223%  perf-profile.self.cycles-pp.mt_find
      0.00            +0.3        0.29 ±223%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.59 ± 71%      +0.3        0.90 ± 69%  perf-profile.self.cycles-pp.get_cpu_sleep_time_us
      0.13 ±223%      +0.3        0.44 ±101%  perf-profile.self.cycles-pp.fput
      0.00            +0.3        0.31 ±143%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.31 ±141%      +0.3        0.62 ±143%  perf-profile.self.cycles-pp.pcpu_alloc_noprof
      0.32 ±141%      +0.4        0.68 ±108%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.16 ±223%      +0.4        0.56 ±114%  perf-profile.self.cycles-pp.__slab_free
      0.44 ±100%      +0.4        0.86 ± 55%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.15 ±223%      +0.4        0.58 ± 72%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.4        0.45 ±101%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.6        0.56 ± 70%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.63 ± 57%      +0.6        2.27 ± 33%  perf-profile.self.cycles-pp.mutex_unlock
      4.23 ± 58%      +0.7        4.89 ± 25%  perf-profile.self.cycles-pp.smp_call_function_single
     34.34 ± 15%      +4.5       38.83 ±  9%  perf-profile.self.cycles-pp.intel_idle


