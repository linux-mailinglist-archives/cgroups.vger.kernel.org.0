Return-Path: <cgroups+bounces-3038-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF678D456A
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193A02848B0
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 06:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9D155A3C;
	Thu, 30 May 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbyirX+I"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C34155395
	for <cgroups@vger.kernel.org>; Thu, 30 May 2024 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049876; cv=fail; b=LYPMmJgXdjctJrblW9Tgwve8nyM5suaCUZzFo6CjEs0EfmkKlpJk+8U9OjZZ+J2WJZiW/O4Oc3LMWbbIl4eu6jA9FUnPBd25LL/PJ98Z3ZnZjWzNEtQPQn15txieMGLxXzQ05+LFfFIgM7l5IWMaumQBKbS37VBoIZ1MIr8nIOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049876; c=relaxed/simple;
	bh=PG3KA9SozzEVYks4VegaDlp8T+VTa4VMpRASYgvybzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRMWsw3zyBP/KdPuUJQV/TZEtnPLDKIwP8BLWSlJskJurbwAJFZU9NgAYnpvRpIBg6RdcaWAmQeZOVbEeUUPdbd74dx/SLErhbP8bHBpA+ygaXyCMjBQFJqWNm8AJaV014vfpOuAFFI7FrMB6U2uz9TnAFbBO2YRNfcY5sUD8wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbyirX+I; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717049876; x=1748585876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PG3KA9SozzEVYks4VegaDlp8T+VTa4VMpRASYgvybzM=;
  b=bbyirX+I44BdaWW5Oqdhm+E/Jx5qcWLb4LxElP4VttPiEawQvAapkMf+
   ZCna4V72xUQEGIfFDwlOhrvZv3yOeAhHiaQoeDBtoXEKbdO8dX5OKvfE7
   CHpU933Jzn1R/hLSa6CM45AjbGD4it4XxOiT99w+4iyGFtjSQVtYV+Nc6
   Abb9ADGZ3UovhABZO78uvtVgn94o8b8qgDyoYiDxWiFEZcdOx7aJ9ciUo
   kmbj4FTob2TseluVd+tk6itgTPB0rOrEJ/C9B2p13kzvHPmxZWy9Os8ud
   ZgxceUZnwf+x5iWD9AUUwUDjQZNanSNO6j+HhYlhdM99yXFPEbfNesI0b
   Q==;
X-CSE-ConnectionGUID: Mh+dwV7NQomapcBe1YO1Gg==
X-CSE-MsgGUID: GFEdfLF/R9KQUIFtPLdhfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="38894905"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="38894905"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 23:17:54 -0700
X-CSE-ConnectionGUID: ZTo7og16T4qehHYSZyYOZQ==
X-CSE-MsgGUID: Gjko6t8yR3+vt3H3uvCsaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35689543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 23:17:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 23:17:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 23:17:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 23:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkTPUHpNx1qlKoLhBebgGTvo0ETr5/i56bLzQ1d76sSXa6grx8eg+7Oq8cuJqdw+X3c8jsd+8P57X+xZ3sBamLUaSoH2WLtkaysq2M5MtKilg507ajCwCuBwFmRcHP2jS8xjQh6oyi6Xi0KpitdRB1ZEKfHYjE2lOIL3Tal8vwL8iWmXUB9E0mSynRMKfBUE+oiPaSLhKIPH+9tBMXEPHtigbSTUJkqwS4xg381dt393FhoepXdl1cWnejON3vCwd1wxZPLxiTY+ZZXbEykRoatbQU076vqPH+nb8lhYRY96xJluKHAbu+BJQZW8a8UCkiHynHEkATteU+eMo/YpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoWC75wlKvnWs+mjO6FO28fKRnEBnUBbUzjSovbfxbA=;
 b=V/IXIi7JvOfnZ2zHFXUYeltgtMoJbks9Js9q2lJ5kvcCdcxRWBU/YeUZccvCTsQuaeTugITaC0Q06+AnP1vhOkVsKHsghYhK3qEtTB+PN27fSPwraQqESGayzSFG8uZc4DO60IL/o8AuCUgfukW5sL1g+DlS/iLgjSQ4dCFYZnweR8Unv13gwc9aZZo8pOuYgmerJdn1TafLGCFnGcBXfX27qcAyqcMS23vWvE391pluYQGV9lxS4/hZoxA1Z836zf5lvq1blsDvdy1ukaOB7GHtwFCZsxopS0ggGKDqJgjFHmDzXOVncL5TXcPROtYEZQkuo4BsuShRIA+o4NISTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 06:17:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 06:17:50 +0000
Date: Thu, 30 May 2024 14:17:39 +0800
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
Message-ID: <ZlgaA/g070SWWa2b@xsang-OptiPlex-9020>
References: <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
 <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
 <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
 <ZlBFskeX3Wj3UGYJ@xsang-OptiPlex-9020>
 <uzqh6xvoe6xgef3i6743m7gld5tlqp6h2krcqgjre3nzfcogwz@gsllvs77r57a>
 <6gtp47pv4h27txb7lxvxjavrsamxvzamsclrsbpsl62i3nn2bp@yhamzxapsmsf>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6gtp47pv4h27txb7lxvxjavrsamxvzamsclrsbpsl62i3nn2bp@yhamzxapsmsf>
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ff6d88-170b-4d4a-e3d8-08dc80703b64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5KF9E0DU98osjZtDDLZocia52+e5Y5GJQ2jzrllO2EFjua7RDHJf5T/iDZHU?=
 =?us-ascii?Q?9I6HqV86ERHXbU4ekRPTHlJ8gehAB+7tm4WbfkF307hvNM+rw7S8r1C4o98C?=
 =?us-ascii?Q?pZluJCe50vvWoALkvsg4XiTS5DHkSM0n0NGiLMxSol5MNYxwVi6O7EKF0rcG?=
 =?us-ascii?Q?diA8uxjW7QO1VJ8agWtIo89owL7n5pvKsWvk9f67xEJoQYxlWAw8M7t1E2o/?=
 =?us-ascii?Q?ex2w0DeV1GFCKTOwjlc7jNkb9J1C4EpDjIHFqrWbe9eCas9nBc9rFuzb8RvZ?=
 =?us-ascii?Q?FP6bqCPLqziEPlcoGgF4wplwXI28PpvTvnwF2FaOxt7AV5J+JPs/8YBVa7R+?=
 =?us-ascii?Q?xQT7GruR+xe+DoFftVO8AqH669TTy01BuqsWZIJY91cR8B9aCcWlKF8RwKZF?=
 =?us-ascii?Q?NvqJCYmOh6a1AJexI3ejVmXeqRkb/mCInInzHSVYYffjkAbj3qyNPB/2JZep?=
 =?us-ascii?Q?+8xXk5sr7JWXORE4wo/ua4sT6AVvWQqakQI6L4nwn2O1ZunKzv1n+M7uzCJf?=
 =?us-ascii?Q?GcTwSCk9sVomgt0Ijlb8HM4X6G0k0IVXyplyYudNlJdRQOSGnGVfXJRbP5/x?=
 =?us-ascii?Q?S6GTde1IrIYiNQz+5a3E/hcTxCAezohtv9RIobBSHLA4++KyHcsObHxymO1E?=
 =?us-ascii?Q?GPW1F+FILhbAtK22/lP4h4CpCFSUcTK0WwyZeWdmQvFoT68Xv6ydg/6pM6Sy?=
 =?us-ascii?Q?P7pvTBTkdFRwiJc8Ol0xsMHLbXjbywyV+jJG7lsXndrM43hDI4w82CU5U86N?=
 =?us-ascii?Q?U09wiT+2UB53whviAj28YgezGiPQ/T1kF5hCqBWZ20C0M71tvgnxw1r94K9b?=
 =?us-ascii?Q?AHQGSkb9svnVSscPte67U/NFBdUBKi32qwKUa/XdU1AFRWiujL2SXzxF04gD?=
 =?us-ascii?Q?kKdQosP2qCBiHYXTHQlT4VELbv/zb5qFZugrkiIT2qriGSmWOdfC5hLbTLTk?=
 =?us-ascii?Q?ypx+htrrrCPnXW5DRuvXFOnLQF7UUKo1OV8vmohqhdwQ8dEPpBmJuE4Xs5cT?=
 =?us-ascii?Q?EX1NltTHXhJGZ6Haj6e+GKE4FsWjosG9oQm05jNr6Icglf/+NkaPo1gz0mmL?=
 =?us-ascii?Q?sfcuYe//DDZmGCRMVbdtuDJXvr15u9c7RVF50jCIe+lhXSkNy1PRjqb3jM47?=
 =?us-ascii?Q?L9fUJUVKmSj+2+79F7K2aVEty5v22faCAH7j9pijHC0HE4cjXT1P3UQUIjpX?=
 =?us-ascii?Q?TWRo179Ov1gkLlPmU2i2lyUImAVH8piRT2yxH9e7JVqDO7NRu1TAjeqeTSvp?=
 =?us-ascii?Q?r6ruD9g1dvTmLyMf5mOibrdM6YRDBRk0n7egttyeJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKMfPcKAdMdZ/WI2T6D0qiOrGudcG6LrouU09Jv/pfL2QftdoRg+ta8N5ffb?=
 =?us-ascii?Q?EACkHZcfarkt9iL11pXOZZ/vmwf9PLKcCo23gQ+rp56HANAIKnh38w4dY7Vv?=
 =?us-ascii?Q?rpepAPSS5pMCsfWGmha1TzfNyVFJOtrVq31w12lWYxjYnwQTjWHP+bCCl2u4?=
 =?us-ascii?Q?ELPqhNmKpALBCASc8uHHU4sspNHNuNAJnCAXoos2ulOSflyNAcIEU0mLtySX?=
 =?us-ascii?Q?oMATGGOEwuv2HniXaa7TUg8ZkyY0WDhDvEr8HF7ayI3k6pCRNaRd/KYSckbw?=
 =?us-ascii?Q?jv7ZWGa+t/X4CV+HZI6WQACqXiOeGMTky/TbpK3BMvLETPgqQXZseJ0C1RRM?=
 =?us-ascii?Q?JFoBy4tueWzV2mQ0UhfIbsOuuMAvyUPnainxo363Mkg6peXAjSezdFqzWOJC?=
 =?us-ascii?Q?54Qa9GS6H0JQoK4CJI5C6XQPf/0zDpGN/f6+h8NQ+7qVNLVKwFbCZq6O+lq9?=
 =?us-ascii?Q?H8FQjjKx9AoauXYomf1WSAeJ6UpYrYqNwnjvzXCzzL7HwVc4y4XzWDUin6kB?=
 =?us-ascii?Q?AmzkA511qctjsQH+cpOjithLGocX9JELR4RRkP6bVN6w/q4NOjeXrMGRUO4f?=
 =?us-ascii?Q?zS8/LsYjSwIMWZ2UGak+SiNePm12GGT1fNwFbQ8FGC6vQQikKB/Jhrs39Zf/?=
 =?us-ascii?Q?DCPie8tP+u9Zmh63dx7qw3DGeNjw89uO19mTIM3Lcb3MOcVrFpT/C+19EHrE?=
 =?us-ascii?Q?2XzCZv40VmQbr9UdBTBw93JLDEOIMuypLVkXjZrB2eLovAF9DT4qfu+vW0iS?=
 =?us-ascii?Q?091I61ACGOswejns8dAv4VrGVfj7efEfJtOax78wZE9X+f7uifGmbGgNHObO?=
 =?us-ascii?Q?U7chXMmgUu7kL2gLptRBLLaWQTbizWIZaf0ek4l+bOFSRIzxUtwZ6+kmiRQ6?=
 =?us-ascii?Q?srjLnpmVso+S/Xgc0MBwy0z09Aeua4Vno7Q7QSjIfj+kPfYN2M9nq9IVTo+E?=
 =?us-ascii?Q?rSJS5/6lSf+CNenmb+oHAW2Vltc9yjsTTYf3zjAZ6QXnknfvh2LLRy9EERDM?=
 =?us-ascii?Q?b7kUjGsThTXgJH31pPRpprubN6FwjtiEviNFJgj4+vQeuo1CZ1jSwApz/qKz?=
 =?us-ascii?Q?iphf6bHJqIFda5P6NRMYHBbswI8C/4Kw24wr3o1zPx+jaqffQz24IgpUQku+?=
 =?us-ascii?Q?3nL1inFX6dg7pdQE6WXERE+Qrslqxj3+Tgn3uEWni8VZOSHBCvbWkkv+Q7oi?=
 =?us-ascii?Q?uWWei1uK9HDiVihZuvA1XEVoHZaj/yMDQjXkrGVa1+8SAaAWezSQa7yxoQVS?=
 =?us-ascii?Q?8AjGdVMrVv5fB6xWnATP65VCQAOhkn84Sv+YjezU7KAJbCJ4pzhI/geMmS6F?=
 =?us-ascii?Q?4RtPW12u83mnVUCKicM9AZvQmK4YpgYOlp3xJwuR9gY6RkmY0J436kZOrflM?=
 =?us-ascii?Q?BXwUuYFvD29U8bzSPtQ4cf05wDSFxF81qdAe/I1BEUNktf813B/I9bUDEdok?=
 =?us-ascii?Q?5V1WhrL1oPLWNqsZgHETMTEsns5X7TAABfS2sGduRVPV9qIfNCjXmrwqSKcw?=
 =?us-ascii?Q?x5g9SHWUXo++BoWShXXriahr+EQgCHFo1j8mRjn2FQapP4+uoEYarTxWPaXr?=
 =?us-ascii?Q?WLj2S/CD2OPNC+1RndwCtFTuYp5BD+Jz3NRiw6ykSljNTvE0RYIEa/hNecKI?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ff6d88-170b-4d4a-e3d8-08dc80703b64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 06:17:50.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GU5rlVT2IypXYoFR8lABTPIS9o1u4Mc9R8gNRKbRZFPiRBfa7J1CLftNI7+VxE4rAtyTidJgqna1uVzCDlgCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com

hi, Shakeel,

On Mon, May 27, 2024 at 11:30:38PM -0700, Shakeel Butt wrote:
> On Fri, May 24, 2024 at 11:06:54AM GMT, Shakeel Butt wrote:
> > On Fri, May 24, 2024 at 03:45:54PM +0800, Oliver Sang wrote:
> [...]
> > I will re-run my experiments on linus tree and report back.
> 
> I am not able to reproduce the regression with the fix I have proposed,
> at least on my 1 node 52 CPUs (Cooper Lake) and 2 node 80 CPUs (Skylake)
> machines. Let me give more details below:
> 
> Setup instructions:
> -------------------
> mount -t tmpfs tmpfs /tmp
> mkdir -p /sys/fs/cgroup/A
> mkdir -p /sys/fs/cgroup/A/B
> mkdir -p /sys/fs/cgroup/A/B/C
> echo +memory > /sys/fs/cgroup/A/cgroup.subtree_control
> echo +memory > /sys/fs/cgroup/A/B/cgroup.subtree_control
> echo $$ > /sys/fs/cgroup/A/B/C/cgroup.procs
> 
> The base case (commit a4c43b8a0980):
> ------------------------------------
> $ python3 ./runtest.py page_fault2 295 process 0 0 52
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 52,2796769,0.03,0,0.00,0
> 
> $ python3 ./runtest.py page_fault2 295 process 0 0 80
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 80,6755010,0.04,0,0.00,0
> 
> 
> The regressing series (last commit a94032b35e5f)
> ------------------------------------------------
> $ python3 ./runtest.py page_fault2 295 process 0 0 52
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 52,2684859,0.03,0,0.00,0
> 
> $ python3 ./runtest.py page_fault2 295 process 0 0 80
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 80,6010438,0.13,0,0.00,0
> 
> The fix on top of regressing series:
> ------------------------------------
> $ python3 ./runtest.py page_fault2 295 process 0 0 52
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 52,3812133,0.02,0,0.00,0
> 
> $ python3 ./runtest.py page_fault2 295 process 0 0 80
> tasks,processes,processes_idle,threads,threads_idle,linear
> 0,0,100,0,100,0
> 80,7979893,0.15,0,0.00,0
> 
> 
> As you can see, the fix is improving the performance over the base, at
> least for me. I can only speculate that either the difference of
> hardware is giving us different results (you have newer CPUs) or there
> is still disparity of experiment setup/environment between us.
> 
> Are you disabling hyperthreading? Is the prefetching heuristics
> different on your systems?

we don't disable hyperthreading.

for prefetching, we don't change bios default setting. for the skl server
in our original report:

MLC Spatial Prefetcher     - enabled
DCU Data Prefetcher        - enabled
DCU Instruction Prefetcher - enabled
LLC Prefetch               - disabled

but we don't uniform these setting for all our servers. such like for that
Ice Lake server mentioned in previous mail, the "LLC Prefetch" is default
to be enabled, so we keep it as enabled.

> 
> Regarding test environment, can you check my setup instructions above
> and see if I am doing something wrong or different?
> 
> At the moment, I am inclined towards asking Andrew to include my fix in
> following 6.10-rc* but keep this report open, so we continue to improve.
> Let me know if you have concerns.

yeah, different setup/environment could cause difference. anyway, when your
fix merged, we could capture it for some performance improvement. or if you
want us a manual check, you could let us know. Thanks!

> 
> thanks,
> Shakeel

