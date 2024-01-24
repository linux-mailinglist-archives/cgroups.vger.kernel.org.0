Return-Path: <cgroups+bounces-1227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA283A41D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0292281E47
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32641756A;
	Wed, 24 Jan 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+d7RCuz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07817575;
	Wed, 24 Jan 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084813; cv=fail; b=Pms0LA9Xa2v9KzOEB8QazVpMnOX9c4PrfhlX85wGN1b0eBpkBAybYDDXh4bHoAf+5OHun8p9sEOKfaNxgarZEXLFKnp19mgJXObIOPHm4/qS07qlMp1KuxS+Oq9/eotCKMJS6svO5Ti77NR7Ua9CNGea5RWSowhFvrtNx5g/81E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084813; c=relaxed/simple;
	bh=pCQzPIGWKA9i2nb2KPXT8gx1gMXrFYlmZF4F+MmWErw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5YtN6MqEf+6EtzvsS6Z8wzIIeavFYNqIu0Q43x728PUq9K8K0BxBb7CZoTpXei/J2q/99BV6ctJiwGmp3xpB/F1pHb5jxCUfD/L34r+pQ25MHd9vAX1cQxjv0iQtVm+F0vPGDdnW0KmmGNc/3px+pPeqG1zpSHdffjCGwVQvHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+d7RCuz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706084807; x=1737620807;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pCQzPIGWKA9i2nb2KPXT8gx1gMXrFYlmZF4F+MmWErw=;
  b=l+d7RCuz+d9X2gDg0SjuvT8gKRfouII1FR97uYGdPFYFvj7qvJ81lmUO
   HnXbsSTdfr3sXDUDPJxVvqELUWX0zpROXAGdfKXWiPi7Zi3L3ICruCpBh
   WRYWP3HtSYAoCHIpNOXQRuxLKzi4nqGiLOu/Jronau6LOBcAMA8QqGTCO
   p5APNUpppBTYIEKlfU48GgR1JP9HMD5eO0QziHhrmctVWCisqumhEW8xT
   +ngxICLCNYkWf7InNzixT7JQ9pKcfXDZH6d4BzANHqXVAY9dTQFX8y8vq
   MVwNvohp5kH53bK5i88SEEymZG1I3d77M8Ss+tlGyyOGcuW+0y+joUt1d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1654880"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208,209";a="1654880"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208,209";a="1898124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 00:26:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 00:26:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 00:26:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 00:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TghKwJjMAYmjHdQEgHt9DrFStVMyIeOiVVsNQxzXla7SzFOplWcdAmzHsFwGZ9S4FO0VClg63/Ciyf+vdVD04loM5c10by+ZtGFFlonpS3nwRM491XjImmJoKBvEDADcdph/Uboq9ynrNcJBEenLOF0K18RFp3aZBMVhv9KQQPm4JIzi9SF3L74go6aco/Wka+UxJgqtQGEUHoAlDtlb7tRbJ27OP5VeWwaiNOc6ZCmnfvQIuoQpvQyOrwnRI6kFac6vQMuYsp2DZgJGmBhATyT4pLYki+gbgWvlrOq2xmPoekbS+Ibl6S+YBR3ZX5uIxKYgKU3HKON+DUwpJdKurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4Bjs1fgeDI1ZngFMHO2x/tIsPXrUUn2vuFrig2Ye/E=;
 b=jiZuZlIekjbvHrEpif6Gb3s4kmyxot9aoyuQPoQkexwU8ihd5Jm9cj67Qq2EEgdIoJSpfU7Cchii89oHjQwjSlnLDDztYh0YApMpHuek4qOmvGxxEdlxdR7H8sxZNTMl800GHksQiDS2KnAbo6akK2PwSb+nPtRJjMMEDeKwfz+ACm8m/cQHJrlFoqCUXqwAOCUgO3HDsZUg3plyrbLBeQuKwPTmD35Txb2meNl1llKizLNEV0RKzW62H8vuZHJ70Q3A2kagJv4Oh3gEobXrlb4MvoQk4vC4+F5jCGRpyRhVrfz2Jv/KqNrcUSo5A6huoFe3P6guO+jZrRJ3gTBoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 08:26:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 08:26:39 +0000
Date: Wed, 24 Jan 2024 16:26:25 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Shakeel Butt <shakeelb@google.com>, Chris Li <chrisl@kernel.org>, Greg Thelen
	<gthelen@google.com>, Ivan Babrou <ivan@cloudflare.com>, Michal Hocko
	<mhocko@kernel.org>, Michal Koutny <mkoutny@suse.com>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo
	<tj@kernel.org>, Waiman Long <longman@redhat.com>, Wei Xu
	<weixugc@google.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [mm] 8d59d2214c: vm-scalability.throughput -36.6%
 regression
Message-ID: <ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020>
References: <202401221624.cb53a8ca-oliver.sang@intel.com>
 <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
 <Za9pB928KjSORPw+@xsang-OptiPlex-9020>
 <CAJD7tkYtKdLccKbFVoVo9DH8VtHHAXNMEz5D-Ww5jHhDy-QxbA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="X8r+u45eQ9hjNWOe"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYtKdLccKbFVoVo9DH8VtHHAXNMEz5D-Ww5jHhDy-QxbA@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d37ca6c-627b-4c3c-a15b-08dc1cb62fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfeLBpR2y1UylmxPZaiALYfDOFv7pFLDVS8eyf/gWhBhHcTmhyBkAkFtM7YUcQTmdsQ59poGp2D+8J1NuTI5Pu4a6cPxLtIrAzFByvCfUTG77+mqjdBSPbm0YbfPUQIxmdCGEFFqya96u7Sz/vlKOJZdSLsYXtHR8WaMxZpymrR3F3sx8MBJpN5571BUb2mTGHi94ySxij/9k9cZ5dEV3Hzu2yUX5EFZEAmZjlQqnH33tpiIz4E1a2fHcdVM4XZjgQC8YtTKFJs8xx3PpbZgGTXbnHkn9eWBm1RGeVZtA3Fo2rJEIPs1I8PeWl33X9Zdtc3DyDBQxO2nMH6MbLYIk5FeXnK2jXUQ7m2F5FdDrN+IL8bt5z4acSXDxVvVo9qz9H5oqU7XIXQQMswGIQ8sE2+L1OzRSTH2oAgpy84TdgGETBSdBBXelFx+9UmelBTDT49RRzUKMikYuL+a3HPMnXl73/e029oIfMoT7TUnb9Q8rSgiVEouiPCH4ngnjAbI3BeZVtQ6j8e4cLh5oGmLe6NGtcYBThGhxMypcH27oyd8qwr5FbNs2SXQFv5VdM2g3J0UJ4GnEVEp34W1/H/YqjTj4zuQvxHYTDzfFEokZHWRBRusotzHlqMcW/+lfQuc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(33716001)(5660300002)(66946007)(26005)(107886003)(54906003)(66556008)(66476007)(235185007)(41300700001)(2906002)(7416002)(44144004)(6506007)(6666004)(478600001)(6512007)(38100700002)(9686003)(82960400001)(6486002)(6916009)(4326008)(83380400001)(44832011)(8936002)(8676002)(316002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3r9po0hvM2luJwoTwtii1X7xybtQWW1Foy7L09XiAD9hI+02juf/bPfaqs0?=
 =?us-ascii?Q?124tlou2BO+cQLhL09UQzk/VrLBJ7E/Ac7HdzJcDctzVXpFJE5k7aGQNSZ7I?=
 =?us-ascii?Q?Hj2G3mm1FmohYt6NG0wHs/MUKdZa8P95ywVk+/z+dbc18egLlO3wxoqAeC0T?=
 =?us-ascii?Q?/3DKJ/6A3tPu2X2Majp2v0ufCwZJlkSehYb8WFB+RttU0Yi6RXruMJmZc/q/?=
 =?us-ascii?Q?L3idRzyhMxm7ApjWM2cvGxbGDcz6maL2H5Pa5DaSzxoiTxjFCLwffJiUvtDP?=
 =?us-ascii?Q?tfyGdU4o+Z/2EtYgwVV0FU8T0mb0YofBay+GBr+8S3K0rx39/El6/MxyN1Dn?=
 =?us-ascii?Q?exLkqq20UtkHgepZcKtrhXb2vpy7cf3oVMPLjCiaEbXRc/HXAn0UMEmXM4pd?=
 =?us-ascii?Q?G8rut1YfJ7vfIR6bsbqfGLF8gNJMRYkLshlnscCB9aa5Iq1x7QcXZCmXEcvW?=
 =?us-ascii?Q?2oa/HRSf1zkXD6u3AXe2Yt2ozHvqBcZMAsap8leJnV1rOkfcbu3iRoHi+Eyv?=
 =?us-ascii?Q?tKCGDSpStD+ghKGDmiZybWi7SyJ0MbE6SmXL7a+idiqYUFsxYb2dTVfI5zKx?=
 =?us-ascii?Q?OgsyfmhxOoq4FdMGruzc4EPP3to25NVOd7Ayv+RViciYtyRq3WaQZsJFsm/V?=
 =?us-ascii?Q?KLJ0nm4bdUL7Qq8tllljUyAzB/Srrn1t1c9mXzknjzRS3RXrIe4hIihXXPAq?=
 =?us-ascii?Q?/CJYqxkVHe0rywcLr7oEOhAIGxtx3B38R4iZ/QApYvEsXOR5kCBcgQjjGMog?=
 =?us-ascii?Q?fibcWPr0aeiC45Dbk+FJ0et+TawXsuMJNIGlOXPEvTu55DhlioPDb7qErfKu?=
 =?us-ascii?Q?1AjkI34bZdIpRySivKmfxaS7eAmy/WjUbA1w/y80xZuH+Tvnqudzq+LEunUi?=
 =?us-ascii?Q?INNImILa5yXMB/rvfJAeB5u+KVaNJkvI6ea9JQq460c29P0K6duWz63NfcJm?=
 =?us-ascii?Q?P0DF5ZlgOtGW5U/n5l985sU25U6BMonjrTWptwiWEkQvWDLhNQdgaqNNgXYq?=
 =?us-ascii?Q?3S3c0QD2i0GjTvr5olGWhsipgCh4rwPMi0VFTz+x1QbCGOy1pVCsANq3Dn+W?=
 =?us-ascii?Q?LlRCBma56wxkzztb4J9WBo2dcDFaQW6/oSpHJyH0KQlAObpY6wdgV+wk2akN?=
 =?us-ascii?Q?zdIi44CeYTEpBHUF9FrakByo4gXaQGSXICuv28KEZI2j9WGeEHDzztKkIep8?=
 =?us-ascii?Q?y2z3sXe+TA9svNBVRhvudNfc9ZkEZ6yYKxcr15mMBOQ7rKK2JOlEAj3rniAX?=
 =?us-ascii?Q?xjHGgCEgAOxZ8MQb+Fh9oy5eRCsy3l3ghe5UvamFJD8Z7oyLPlu16mtA5p05?=
 =?us-ascii?Q?Dq61rHigxRiFFMN1Wo6g32ElC6bOojcpgpbymPWR1fT7nL6r2ilTuBw+YQ3G?=
 =?us-ascii?Q?zefQuTSf7w2I47pTnpLFwduyB6P2HypNMOmD6AT8ecGotHZfGvBlAkDwOVxE?=
 =?us-ascii?Q?Q5dLnA/LRFUpszAPzwJRAC+2b+32/2VkZMdqn43WRrV+d229UAZScjxX+tPn?=
 =?us-ascii?Q?PGEhpnhjkoWxLlyGBUExJFPR1FBeK+KXf+UG+GbNbnTGF3jpAlotAR9P2wQT?=
 =?us-ascii?Q?K29bMUWrfNwjvrLtFMrOHgtx+/REycFsQ/zWNcqxlHfci1g8I7N4T/HCw8kd?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d37ca6c-627b-4c3c-a15b-08dc1cb62fb2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:26:39.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwQ3xtoLBenaUyWhpwjh7UB2omom8jRh/7rd04yWDUMV6YJuGQBMEKhTATEb0VxPh22oxXcbEDxq1oOR+roiKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com

--X8r+u45eQ9hjNWOe
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Yosry Ahmed,

On Mon, Jan 22, 2024 at 11:42:04PM -0800, Yosry Ahmed wrote:
> > > Oliver, would you be able to test if the attached patch helps? It's
> > > based on 8d59d2214c236.
> >
> > the patch failed to compile:
> >
> > build_errors:
> >   - "mm/memcontrol.c:731:38: error: 'x' undeclared (first use in this function)"
> 
> Apologizes, apparently I sent the patch with some pending diff in my
> tree that I hadn't committed. Please find a fixed patch attached.

the regression disappears after applying the patch.

Tested-by: kernel test robot <oliver.sang@intel.com>

for 1st regression we reported (details is attached as vm-scalability):

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/1T/lkp-cpl-4sp2/lru-shm/vm-scalability

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    946447           -37.8%     588327            -1.1%     936279        vm-scalability.median
 2.131e+08           -36.6%  1.351e+08            -1.4%  2.102e+08        vm-scalability.throughput



for 2nd regression (details is attached as will-it-scale-tlb_flush2):

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   2132437           -32.3%    1444430            +0.9%    2151460        will-it-scale.52.processes
     41008           -32.3%      27776            +0.9%      41373        will-it-scale.per_process_ops



interesting thing is, it also helps on will-it-scale:fallocate tests which we
ignored in original report (details is attached as will-it-scale-fallocate1):

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/fallocate1/will-it-scale

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   5426049           -33.8%    3590953            +3.3%    5605429        will-it-scale.224.processes
     24222           -33.8%      16030            +3.3%      25023        will-it-scale.per_process_ops

> 
> Thanks.



--X8r+u45eQ9hjNWOe
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="vm-scalability"
Content-Transfer-Encoding: 8bit

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/1T/lkp-cpl-4sp2/lru-shm/vm-scalability

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      0.01           +86.7%       0.02            +3.7%       0.01        vm-scalability.free_time
    946447           -37.8%     588327            -1.1%     936279        vm-scalability.median
 2.131e+08           -36.6%  1.351e+08            -1.4%  2.102e+08        vm-scalability.throughput
    284.74            +6.3%     302.62            +1.5%     288.98        vm-scalability.time.elapsed_time
    284.74            +6.3%     302.62            +1.5%     288.98        vm-scalability.time.elapsed_time.max
     30485           +14.8%      34987            +0.1%      30514        vm-scalability.time.involuntary_context_switches
      1893           +43.6%       2718            -0.1%       1891        vm-scalability.time.percent_of_cpu_this_job_got
      3855           +67.7%       6467            +1.7%       3922        vm-scalability.time.system_time
      1537           +14.5%       1760            +0.5%       1545        vm-scalability.time.user_time
    120009            -5.6%     113290            -0.4%     119542        vm-scalability.time.voluntary_context_switches
      6.46            +3.5        9.95            +0.0        6.48        mpstat.cpu.all.sys%
     21.22           +38.8%      29.46            -0.3%      21.14        vmstat.procs.r
      9376            +0.5%       9422            +2.6%       9621        vmstat.system.cs
    233326            -0.6%     231877            -1.2%     230635        vmstat.system.in
    113624 ±  5%     +14.0%     129566 ±  3%     -11.8%     100234 ±  3%  meminfo.Active
    113476 ±  5%     +14.0%     129417 ±  3%     -11.8%     100070 ±  3%  meminfo.Active(anon)
   3987746           +46.0%    5821636            -0.8%    3954895        meminfo.Mapped
     16345           +14.6%      18729            -2.4%      15952 ±  2%  meminfo.PageTables
    474.17 ±  3%     -88.9%      52.50 ±125%     -98.2%       8.67 ± 31%  perf-c2c.DRAM.local
    483.17 ±  5%     -79.3%      99.83 ± 70%     -87.3%      61.17 ± 21%  perf-c2c.DRAM.remote
      1045 ±  5%     -71.9%     294.00 ± 63%     -80.7%     202.17 ±  6%  perf-c2c.HITM.local
    119.50 ± 10%     -78.8%      25.33 ± 20%     -79.8%      24.17 ± 28%  perf-c2c.HITM.remote
    392.33           +35.4%     531.17            -0.1%     392.00        turbostat.Avg_MHz
     10.35            +3.7       14.00            -0.0       10.34        turbostat.Busy%
     90.56            -3.7       86.86            +0.0       90.57        turbostat.C1%
      0.28 ±  5%     -31.5%       0.19            +0.0%       0.28 ±  2%  turbostat.IPC
    481.33            +2.5%     493.38            -0.3%     480.09        turbostat.PkgWatt
    999019 ±  3%     +44.4%    1442651 ±  2%      -1.4%     984731 ±  4%  numa-meminfo.node0.Mapped
   1005687 ±  4%     +44.1%    1449402 ±  3%      +2.3%    1029138        numa-meminfo.node1.Mapped
      3689 ±  3%     +21.7%       4490 ±  7%      +5.7%       3899 ±  7%  numa-meminfo.node1.PageTables
    980589 ±  2%     +42.3%    1395777 ±  2%      +1.6%     996328 ±  3%  numa-meminfo.node2.Mapped
     96484 ±  5%     +22.0%     117715 ±  4%      -9.0%      87779 ±  4%  numa-meminfo.node3.Active
     96430 ±  5%     +22.1%     117694 ±  4%      -9.0%      87737 ±  4%  numa-meminfo.node3.Active(anon)
    991367 ±  3%     +42.7%    1414337 ±  4%      -0.7%     984261 ±  2%  numa-meminfo.node3.Mapped
    251219 ±  3%     +44.8%     363745 ±  2%      -2.9%     244018 ±  5%  numa-vmstat.node0.nr_mapped
    253252 ±  2%     +44.6%     366087 ±  3%      +0.8%     255216        numa-vmstat.node1.nr_mapped
    927.67 ±  3%     +21.9%       1130 ±  7%      +4.4%     968.41 ±  7%  numa-vmstat.node1.nr_page_table_pages
    248171 ±  2%     +42.5%     353541 ±  4%      -0.7%     246429 ±  3%  numa-vmstat.node2.nr_mapped
     24188 ±  5%     +21.6%      29410 ±  4%      -9.2%      21963 ±  4%  numa-vmstat.node3.nr_active_anon
    245825 ±  2%     +45.5%     357622 ±  3%      -0.2%     245258 ±  3%  numa-vmstat.node3.nr_mapped
      1038 ± 11%     +17.8%       1224 ±  6%      -4.5%     992.13 ±  2%  numa-vmstat.node3.nr_page_table_pages
     24188 ±  5%     +21.6%      29410 ±  4%      -9.2%      21963 ±  4%  numa-vmstat.node3.nr_zone_active_anon
    284.74            +6.3%     302.62            +1.5%     288.98        time.elapsed_time
    284.74            +6.3%     302.62            +1.5%     288.98        time.elapsed_time.max
     30485           +14.8%      34987            +0.1%      30514        time.involuntary_context_switches
    448.67 ±  3%     -18.4%     366.00 ±  4%      -2.5%     437.67 ±  2%  time.major_page_faults
      1893           +43.6%       2718            -0.1%       1891        time.percent_of_cpu_this_job_got
      3855           +67.7%       6467            +1.7%       3922        time.system_time
      1537           +14.5%       1760            +0.5%       1545        time.user_time
    120009            -5.6%     113290            -0.4%     119542        time.voluntary_context_switches
     28376 ±  5%     +14.0%      32338 ±  3%     -11.8%      25021 ±  3%  proc-vmstat.nr_active_anon
    993504           +46.6%    1456136            -0.8%     985427        proc-vmstat.nr_mapped
      4060           +15.5%       4691            -2.1%       3977        proc-vmstat.nr_page_table_pages
     28376 ±  5%     +14.0%      32338 ±  3%     -11.8%      25021 ±  3%  proc-vmstat.nr_zone_active_anon
 1.066e+09            -2.0%  1.045e+09            -0.0%  1.066e+09        proc-vmstat.numa_hit
 1.065e+09            -2.0%  1.044e+09            +0.0%  1.065e+09        proc-vmstat.numa_local
     69848 ±  2%      -1.5%      68819 ±  2%     -13.1%      60717 ±  2%  proc-vmstat.pgactivate
      5659            +5.6%       5978            +1.0%       5713        proc-vmstat.unevictable_pgs_culled
  34604288            +3.7%   35898496            +1.1%   35001600        proc-vmstat.unevictable_pgs_scanned
      0.08 ±111%     +14.5%       0.09 ± 85%    +351.6%       0.36 ± 46%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 35%     +20.5%       0.01 ± 30%     -49.3%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ± 20%   +1887.0%       0.18 ±203%     +61.1%       0.01 ± 51%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.73 ±221%     +10.1%       7.41 ±102%   +1086.8%      79.86 ±111%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     20.95 ±118%     +66.6%      34.90 ± 45%    +372.6%      99.03 ± 24%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
     10.50 ±172%     -78.5%       2.26 ±205%    +824.8%      97.06 ± 88%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ± 28%     +63.3%       0.01 ± 29%     +30.0%       0.01 ± 24%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      4539 ±  6%      -0.0%       4538 ±  3%     -12.0%       3994 ±  2%  perf-sched.total_wait_and_delay.max.ms
      4539 ±  6%      -0.0%       4538 ±  3%     -12.0%       3994 ±  2%  perf-sched.total_wait_time.max.ms
    524.54 ± 91%      +0.1%     525.21 ± 91%     -91.3%      45.89 ±  2%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    524.53 ± 91%      +0.1%     524.88 ± 91%     -91.3%      45.88 ±  2%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
   1223376 ± 14%    +119.1%    2680582 ±  9%      +1.4%    1239953 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1673909 ± 14%     +97.6%    3308254 ±  8%      -0.6%    1663719 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.max
    810795 ± 15%    +145.8%    1993289 ±  9%      +0.1%     811327 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.min
    156233 ±  8%     +55.1%     242331 ±  6%      +6.4%     166243 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.17 ± 36%     +10.4%       0.19 ± 25%     -76.3%       0.04 ± 10%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.28 ± 17%      -2.6%       0.27 ±  8%     -29.5%       0.20 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
   1223376 ± 14%    +119.1%    2680582 ±  9%      +1.4%    1239953 ± 14%  sched_debug.cfs_rq:/.min_vruntime.avg
   1673909 ± 14%     +97.6%    3308254 ±  8%      -0.6%    1663719 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
    810795 ± 15%    +145.8%    1993289 ±  9%      +0.1%     811327 ± 18%  sched_debug.cfs_rq:/.min_vruntime.min
    156233 ±  8%     +55.1%     242331 ±  6%      +6.4%     166243 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.17 ± 36%     +10.6%       0.19 ± 25%     -76.5%       0.04 ± 10%  sched_debug.cfs_rq:/.nr_running.avg
      0.28 ± 16%      -2.0%       0.27 ±  8%     -29.8%       0.19 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
    247.44 ± 17%      -1.9%     242.83 ±  9%     -34.5%     162.07 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    182.32 ± 33%      +8.6%     197.96 ± 25%     -71.3%      52.23 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
    245.26 ± 17%      -1.9%     240.57 ± 10%     -35.1%     159.09 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     31.39 ± 29%     +19.1%      37.39 ± 23%     -73.0%       8.47 ± 31%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    126445 ±  3%     -11.0%     112493 ±  4%     -12.3%     110951 ±  8%  sched_debug.cpu.avg_idle.stddev
      5970 ± 46%     -24.7%       4497 ± 54%     -95.0%     300.50 ±  6%  sched_debug.cpu.curr->pid.avg
      7221 ± 31%     -15.2%       6125 ± 28%     -62.3%       2719 ±  9%  sched_debug.cpu.curr->pid.stddev
      0.25 ± 21%      +0.1%       0.25 ± 12%     -39.2%       0.15 ±  8%  sched_debug.cpu.nr_running.stddev
      1447 ± 15%     +32.0%       1910 ±  9%      +3.3%       1494 ± 14%  sched_debug.cpu.nr_switches.min
      0.71           +13.4%       0.80            -1.8%       0.69 ±  2%  perf-stat.i.MPKI
 2.343e+10            -7.9%  2.157e+10            -1.2%  2.315e+10        perf-stat.i.branch-instructions
      0.36            -0.0        0.35            -0.0        0.35        perf-stat.i.branch-miss-rate%
  30833194            -7.3%   28584190            -0.8%   30598705        perf-stat.i.branch-misses
     26.04            -1.4       24.66            -0.5       25.53 ±  2%  perf-stat.i.cache-miss-rate%
  51345490 ±  3%     +40.7%   72258633 ±  3%      +1.1%   51925265 ±  5%  perf-stat.i.cache-misses
 1.616e+08 ±  6%     +58.6%  2.562e+08 ±  6%      +4.9%  1.695e+08 ± 10%  perf-stat.i.cache-references
      9297            +0.6%       9355            +2.8%       9558        perf-stat.i.context-switches
      1.29            +9.4%       1.42            -0.9%       1.28        perf-stat.i.cpi
 8.394e+10           +33.7%  1.122e+11            -0.6%  8.344e+10        perf-stat.i.cpu-cycles
    505.77            -2.6%     492.52            -1.2%     499.66        perf-stat.i.cpu-migrations
      0.03            +0.0        0.03 ±  2%      -0.0        0.03 ±  2%  perf-stat.i.dTLB-load-miss-rate%
 2.335e+10            -7.4%  2.162e+10            -0.9%  2.315e+10        perf-stat.i.dTLB-loads
      0.03            +0.0        0.03            -0.0        0.03        perf-stat.i.dTLB-store-miss-rate%
   3948344            -8.0%    3633633            -2.0%    3867670        perf-stat.i.dTLB-store-misses
 6.549e+09            -7.0%   6.09e+09            -0.3%  6.528e+09        perf-stat.i.dTLB-stores
  17546602           -22.8%   13551001           -15.2%   14872025        perf-stat.i.iTLB-load-misses
   2552560            -2.6%    2485876            +0.1%    2555872        perf-stat.i.iTLB-loads
 8.367e+10            -7.5%  7.737e+10            -0.9%  8.288e+10        perf-stat.i.instructions
      4706            +7.7%       5070            +4.6%       4922        perf-stat.i.instructions-per-iTLB-miss
      0.81           -12.0%       0.72            +0.5%       0.82        perf-stat.i.ipc
      1.59 ±  3%     -22.3%       1.23 ±  4%      -4.5%       1.52 ±  3%  perf-stat.i.major-faults
      0.37           +34.2%       0.49            -0.4%       0.37        perf-stat.i.metric.GHz
    233.98            -6.9%     217.90            -0.7%     232.33        perf-stat.i.metric.M/sec
   3619177            -9.5%    3276556            -2.3%    3535780        perf-stat.i.minor-faults
     74.28            +4.8       79.04            +0.5       74.78        perf-stat.i.node-load-miss-rate%
   2898733 ±  4%     +49.0%    4320557            -3.5%    2796977 ±  6%  perf-stat.i.node-load-misses
   1928237 ±  4%     -11.9%    1698426            -0.4%    1920388 ±  6%  perf-stat.i.node-loads
  13383344 ±  2%      +4.7%   14013398 ±  3%      -0.3%   13338644 ±  3%  perf-stat.i.node-stores
   3619179            -9.5%    3276558            -2.3%    3535782        perf-stat.i.page-faults
      0.61 ±  3%     +52.5%       0.94 ±  3%      +2.1%       0.63 ±  5%  perf-stat.overall.MPKI
     31.95 ±  2%      -3.6       28.34 ±  3%      -1.0       30.92 ±  4%  perf-stat.overall.cache-miss-rate%
      1.00           +45.0%       1.45            +0.3%       1.00        perf-stat.overall.cpi
      0.07            +0.0        0.08 ±  4%      +0.0        0.07 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.06            -0.0        0.06            -0.0        0.06        perf-stat.overall.dTLB-store-miss-rate%
     87.62            -2.6       85.05            -1.9       85.75        perf-stat.overall.iTLB-load-miss-rate%
      4778           +20.2%       5745           +17.3%       5604        perf-stat.overall.instructions-per-iTLB-miss
      1.00           -31.0%       0.69            -0.3%       1.00        perf-stat.overall.ipc
     59.75 ±  3%     +11.8       71.59            -0.8       58.91 ±  5%  perf-stat.overall.node-load-miss-rate%
      5145            +1.8%       5239            +1.2%       5208        perf-stat.overall.path-length
 2.405e+10            -6.3%  2.252e+10            -0.3%  2.396e+10        perf-stat.ps.branch-instructions
  31203502            -6.4%   29219514            -0.3%   31124801        perf-stat.ps.branch-misses
  52696784 ±  3%     +43.4%   75547948 ±  3%      +1.9%   53714277 ±  5%  perf-stat.ps.cache-misses
 1.652e+08 ±  6%     +61.7%  2.672e+08 ±  7%      +5.7%  1.746e+08 ± 11%  perf-stat.ps.cache-references
      9279            +0.5%       9326            +2.6%       9525        perf-stat.ps.context-switches
 8.584e+10           +36.3%   1.17e+11            +0.1%  8.594e+10        perf-stat.ps.cpu-cycles
    506.29            -2.0%     496.05            -0.7%     502.50        perf-stat.ps.cpu-migrations
 2.395e+10            -5.9%  2.254e+10            -0.1%  2.393e+10        perf-stat.ps.dTLB-loads
   4059043            -6.2%    3806002            -1.1%    4012385        perf-stat.ps.dTLB-store-misses
 6.688e+09            -5.7%  6.308e+09            +0.4%  6.714e+09        perf-stat.ps.dTLB-stores
  17944396           -21.8%   14028927           -14.9%   15276611        perf-stat.ps.iTLB-load-misses
   2534093            -2.7%    2465233            +0.2%    2538321        perf-stat.ps.iTLB-loads
 8.575e+10            -6.0%  8.059e+10            -0.2%  8.561e+10        perf-stat.ps.instructions
      1.60 ±  3%     -23.2%       1.23 ±  4%      -3.9%       1.54 ±  2%  perf-stat.ps.major-faults
   3726053            -7.7%    3439511            -1.4%    3674617        perf-stat.ps.minor-faults
   2942507 ±  4%     +52.0%    4472428            -2.9%    2857607 ±  6%  perf-stat.ps.node-load-misses
   1980077 ±  4%     -10.4%    1774633            +0.5%    1989918 ±  6%  perf-stat.ps.node-loads
  13780660 ±  2%      +6.8%   14716100 ±  3%      +0.6%   13865246 ±  3%  perf-stat.ps.node-stores
   3726055            -7.7%    3439513            -1.4%    3674618        perf-stat.ps.page-faults
 2.447e+13            -0.2%  2.443e+13            +1.2%  2.477e+13        perf-stat.total.instructions
     37.11            -6.7       30.40 ±  6%      +3.0       40.09        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     21.14            -3.8       17.36 ±  7%      +3.1       24.20 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%      +3.0       24.08 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%      +3.0       24.09 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%      +3.0       24.09 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     21.00            -3.8       17.25 ±  7%      +3.0       24.02 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     20.70            -3.7       17.00 ±  7%      +2.9       23.59        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.69            -3.7       16.99 ±  7%      +2.9       23.57        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     20.64            -3.7       16.95 ±  7%      +2.8       23.48        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.51 ±  3%      -1.9        7.57 ±  2%      -1.1        8.44        perf-profile.calltrace.cycles-pp.do_rw_once
      4.54            -1.4        3.19            -0.5        4.08 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.83            -0.9        1.96            -0.3        2.55 ±  2%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.75 ±  2%      -0.6        0.17 ±141%      -0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio
      3.90            -0.6        3.34 ±  5%      -0.5        3.37 ±  2%  perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      4.44 ±  6%      -0.5        3.98 ±  3%      -0.8        3.68 ±  2%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      2.96 ±  4%      -0.4        2.52 ± 26%      +2.4        5.40 ±  4%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.17 ±  3%      -0.4        0.73 ±  6%      -0.2        1.01 ±  4%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      1.42 ±  2%      -0.4        0.99 ±  2%      -0.1        1.28 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      1.32 ±  2%      -0.4        0.91            -0.1        1.19 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.61 ±  6%      -0.4        0.23 ±141%      +0.5        1.09 ±  3%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      1.19 ±  2%      -0.4        0.82            -0.1        1.07 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.24 ±  6%      -0.3        1.91 ± 24%      +1.8        4.08 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.92 ± 12%      -0.3        0.60 ± 74%      +0.8        1.69 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.96 ±  2%      -0.3        0.65 ±  2%      -0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.98 ±  2%      -0.3        0.68 ±  4%      -0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.do_access
      0.76 ±  7%      -0.3        0.49 ± 75%      +0.6        1.37 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.77 ±  7%      -0.3        0.49 ± 75%      +0.6        1.38 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.80 ± 17%      -0.2        0.57 ± 74%      +0.8        1.63 ± 12%  perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.shmem_undo_range.shmem_evict_inode.evict
      1.99 ±  6%      -0.2        1.77 ± 21%      +1.5        3.44 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.99 ±  6%      -0.2        1.77 ± 21%      +1.5        3.44 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.99 ±  6%      -0.2        1.77 ± 21%      +1.5        3.44 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.95 ±  6%      -0.2        1.74 ± 21%      +1.4        3.37 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.60 ±  7%      -0.2        1.38 ± 25%      +1.4        3.00 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.60 ±  7%      -0.2        1.38 ± 25%      +1.4        2.99 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.96 ±  6%      -0.2        1.74 ± 21%      +1.4        3.39 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.92 ±  6%      -0.2        1.71 ± 21%      +1.4        3.32 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.92 ±  6%      -0.2        1.71 ± 21%      +1.4        3.32 ±  4%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      2.17 ± 17%      -0.2        1.97 ± 30%      +2.2        4.38 ± 12%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat.__x64_sys_unlinkat
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      1.76 ±  6%      -0.2        1.57 ± 22%      +1.3        3.10 ±  4%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      1.80 ±  6%      -0.2        1.60 ± 22%      +1.4        3.16 ±  4%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      1.80 ±  6%      -0.2        1.60 ± 22%      +1.4        3.16 ±  4%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      1.36 ± 10%      -0.2        1.18 ± 28%      +1.2        2.56 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.83 ± 17%      -0.2        0.67 ± 53%      +0.8        1.66 ± 12%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict
      0.81 ± 17%      -0.1        0.66 ± 53%      +0.8        1.65 ± 12%  perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
      1.99 ±  5%      -0.1        1.84 ± 22%      +1.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp.write
      1.98 ±  5%      -0.1        1.84 ± 22%      +1.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.98 ±  5%      -0.1        1.84 ± 22%      +1.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      1.98 ±  5%      -0.1        1.84 ± 22%      +1.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.98 ±  5%      -0.1        1.84 ± 22%      +1.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±  5%      -0.1        1.69 ± 22%      +1.3        3.13 ±  5%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      0.55 ± 47%      -0.1        0.45 ± 74%      +0.7        1.27 ± 12%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_evict_inode
      0.98 ± 17%      -0.1        0.89 ± 30%      +1.0        1.95 ± 12%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
      1.38 ±  5%      -0.1        1.31 ± 20%      +1.0        2.38 ±  6%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      1.18 ±  5%      -0.1        1.12 ± 20%      +0.9        2.04 ±  6%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +0.0        0.00            +0.6        0.59 ± 13%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.6        0.61 ± 11%  perf-profile.calltrace.cycles-pp.find_lock_entries.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
      0.00            +0.0        0.00            +0.7        0.66 ±  8%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.0        0.00            +0.7        0.66 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.0        0.00            +0.7        0.66 ±  8%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +0.0        0.00            +0.8        0.76 ± 12%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_evict_inode
      0.00            +0.1        0.09 ±223%      +0.8        0.80 ± 12%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.09 ±223%      +0.8        0.82 ±  7%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.__munmap
      1.20            +0.5        1.68 ±  5%      -0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.20            +0.5        1.68 ±  5%      -0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.20            +0.5        1.68 ±  5%      -0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.20            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.18            +0.5        1.67 ±  6%      -0.2        1.01 ±  6%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.84 ±  2%      +0.6        1.43 ±  5%      -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.58 ±  3%      +0.6        1.18 ±  5%      -0.2        0.36 ± 71%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.8        0.79 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range
      0.00            +1.0        1.02 ±  5%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +1.1        1.08 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +1.5        1.46 ±  5%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.29 ±  3%      +1.9        5.19            -0.3        3.00 ±  2%  perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.02 ±  4%      +2.0        5.00            -0.3        2.77 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      2.84 ±  4%      +2.0        4.86            -0.2        2.60 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.finish_fault.do_read_fault.do_fault
      2.73 ±  4%      +2.0        4.77            -0.2        2.50 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault.do_read_fault
      1.48 ±  4%      +2.1        3.56 ±  2%      -0.1        1.36 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault
      0.57 ±  4%      +2.8        3.35 ±  2%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.96 ±  5%      +2.9        4.86 ±  2%      -0.3        1.65 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      3.65 ±  2%      +3.1        6.77 ±  2%      -0.4        3.29 ±  3%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.80 ±  4%      +3.1        3.92 ±  3%      -0.0        0.77 ±  4%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.68 ±  3%      +3.4        6.08 ±  2%      -0.2        2.48 ±  5%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      7.71 ±  6%      +3.9       11.66 ±  2%      -1.3        6.46 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
     67.18            +6.3       73.46 ±  3%      -8.0       59.16        perf-profile.calltrace.cycles-pp.do_access
      1.46 ±  9%      +7.1        8.57 ± 16%      -0.0        1.44 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      1.50 ±  9%      +7.1        8.61 ± 16%      -0.0        1.48 ± 10%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.38 ± 10%      +7.1        8.51 ± 16%      -0.0        1.38 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     51.46            +7.6       59.08 ±  3%      -5.7       45.73        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      2.98 ±  5%      +7.7       10.66 ± 14%      -0.1        2.84 ±  5%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      2.84 ±  6%      +7.7       10.56 ± 14%      -0.1        2.72 ±  5%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     34.18            +8.5       42.68 ±  4%      -4.1       30.12        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     34.14            +8.5       42.64 ±  4%      -4.1       30.09        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     33.95            +8.6       42.51 ±  4%      -4.0       29.91        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
     42.88            +8.8       51.70 ±  4%      -4.9       38.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     42.34            +9.0       51.30 ±  4%      -4.8       37.50        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     42.29            +9.0       51.28 ±  4%      -4.8       37.46        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     45.07            +9.6       54.62 ±  4%      -5.1       39.97        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     44.95            +9.6       54.53 ±  4%      -5.1       39.85        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     43.72            +9.9       53.64 ±  4%      -5.0       38.76        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.28 ±  2%     +13.8       31.05 ±  6%      -2.1       15.20 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
     21.14            -3.8       17.36 ±  7%      +3.1       24.20 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     21.14            -3.8       17.36 ±  7%      +3.1       24.20 ±  2%  perf-profile.children.cycles-pp.do_idle
     21.14            -3.8       17.36 ±  7%      +3.1       24.20 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     21.09            -3.8       17.33 ±  7%      +3.0       24.13 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     21.05            -3.8       17.29 ±  7%      +3.0       24.09 ±  2%  perf-profile.children.cycles-pp.start_secondary
     20.79            -3.7       17.07 ±  7%      +2.9       23.69        perf-profile.children.cycles-pp.cpuidle_enter
     20.78            -3.7       17.07 ±  7%      +2.9       23.67        perf-profile.children.cycles-pp.cpuidle_enter_state
     20.71            -3.7       17.01 ±  7%      +2.9       23.57        perf-profile.children.cycles-pp.acpi_safe_halt
     20.72            -3.7       17.02 ±  7%      +2.9       23.59        perf-profile.children.cycles-pp.acpi_idle_enter
     20.79            -3.6       17.19 ±  6%      +2.6       23.34        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     11.52            -3.1        8.42            -1.2       10.31 ±  2%  perf-profile.children.cycles-pp.do_rw_once
      4.62            -1.4        3.24            -0.5        4.16 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
      2.89            -0.9        2.00            -0.3        2.61 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      3.98            -0.6        3.39 ±  5%      -0.5        3.43 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      4.46 ±  6%      -0.5        3.99 ±  3%      -0.8        3.70 ±  2%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.18 ±  4%      -0.4        0.74 ±  6%      -0.2        1.02 ±  4%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      1.44 ±  2%      -0.4        1.00 ±  2%      -0.1        1.29 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      1.40            -0.4        0.99            -0.1        1.26 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      6.86            -0.4        6.47 ±  5%      -0.8        6.07 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.27            -0.4        0.90            -0.1        1.14 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      3.06 ±  4%      -0.4        2.68 ± 17%      +1.9        4.91 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.01 ±  2%      -0.3        0.68            -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.02 ±  2%      -0.3        0.70 ±  4%      -0.1        0.93 ±  2%  perf-profile.children.cycles-pp.sync_regs
      2.34 ±  5%      -0.3        2.09 ± 15%      +1.3        3.69 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.77 ±  2%      -0.3        0.51            -0.1        0.70 ±  3%  perf-profile.children.cycles-pp.rmqueue
      2.34 ±  5%      -0.3        2.08 ± 15%      +1.3        3.68 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.00 ±  6%      -0.2        1.78 ± 21%      +1.5        3.45 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      2.00 ±  6%      -0.2        1.78 ± 21%      +1.5        3.45 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.99 ±  6%      -0.2        1.77 ± 21%      +1.5        3.44 ±  4%  perf-profile.children.cycles-pp.kthread
      1.95 ±  6%      -0.2        1.74 ± 21%      +1.4        3.37 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.81 ±  2%      -0.2        0.60            -0.1        0.72 ±  4%  perf-profile.children.cycles-pp.__perf_sw_event
      2.04 ±  7%      -0.2        1.83 ± 17%      +1.2        3.21 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.96 ±  6%      -0.2        1.74 ± 21%      +1.4        3.39 ±  4%  perf-profile.children.cycles-pp.worker_thread
      1.92 ±  6%      -0.2        1.71 ± 21%      +1.4        3.32 ±  4%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      1.92 ±  6%      -0.2        1.71 ± 21%      +1.4        3.32 ±  4%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.do_unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.evict
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.unlinkat
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.shmem_evict_inode
      2.18 ± 17%      -0.2        1.97 ± 30%      +2.2        4.39 ± 12%  perf-profile.children.cycles-pp.shmem_undo_range
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.children.cycles-pp.drm_atomic_commit
      1.81 ±  6%      -0.2        1.61 ± 22%      +1.4        3.18 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.53 ±  3%      -0.2        0.34 ±  2%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.children.cycles-pp.drm_fb_memcpy
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.children.cycles-pp.memcpy_toio
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      1.79 ±  6%      -0.2        1.60 ± 22%      +1.4        3.15 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      1.80 ±  6%      -0.2        1.60 ± 22%      +1.4        3.16 ±  4%  perf-profile.children.cycles-pp.commit_tail
      1.80 ±  6%      -0.2        1.60 ± 22%      +1.4        3.16 ±  4%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      1.50 ±  9%      -0.2        1.31 ± 18%      +0.7        2.23 ±  6%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.68 ±  2%      -0.2        0.50 ±  5%      +0.0        0.69 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.65 ±  6%      -0.2        0.47 ±  2%      +0.0        0.69 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.47 ±  3%      -0.2        0.29 ±  2%      -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.32 ±  5%      -0.2        1.16 ± 15%      +0.6        1.88 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.65 ±  2%      -0.2        0.49            -0.1        0.58 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      1.32 ±  5%      -0.2        1.16 ± 15%      +0.6        1.89 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.64 ±  4%      -0.1        0.49 ±  5%      +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.54            -0.1        0.39 ±  4%      -0.0        0.53 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      2.00 ±  4%      -0.1        1.86 ± 21%      +1.4        3.40 ±  5%  perf-profile.children.cycles-pp.vprintk_emit
      1.99 ±  5%      -0.1        1.85 ± 21%      +1.4        3.40 ±  5%  perf-profile.children.cycles-pp.write
      0.49 ±  2%      -0.1        0.35 ±  3%      -0.0        0.46 ±  4%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.54 ±  5%      -0.1        0.40 ±  2%      +0.0        0.56 ±  2%  perf-profile.children.cycles-pp.xas_find
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.children.cycles-pp.devkmsg_emit
      1.96 ±  5%      -0.1        1.83 ± 22%      +1.4        3.37 ±  5%  perf-profile.children.cycles-pp.devkmsg_write
      1.98 ±  4%      -0.1        1.85 ± 21%      +1.4        3.40 ±  5%  perf-profile.children.cycles-pp.console_flush_all
      1.98 ±  4%      -0.1        1.85 ± 21%      +1.4        3.40 ±  5%  perf-profile.children.cycles-pp.console_unlock
      2.00 ±  4%      -0.1        1.88 ± 22%      +1.4        3.42 ±  5%  perf-profile.children.cycles-pp.ksys_write
      2.00 ±  4%      -0.1        1.88 ± 22%      +1.4        3.42 ±  5%  perf-profile.children.cycles-pp.vfs_write
      0.39 ±  4%      -0.1        0.28 ±  3%      -0.0        0.34 ±  6%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.07 ±  5%      -0.1        0.96 ± 14%      +0.4        1.51 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      1.82 ±  5%      -0.1        1.71 ± 21%      +1.3        3.16 ±  6%  perf-profile.children.cycles-pp.serial8250_console_write
      0.39 ±  3%      -0.1        0.29 ±  3%      +0.0        0.42 ±  4%  perf-profile.children.cycles-pp.xas_descend
      0.32 ±  4%      -0.1        0.22 ±  8%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.56 ±  8%      -0.1        0.47 ± 15%      +0.3        0.82 ±  7%  perf-profile.children.cycles-pp.xas_store
      1.64 ±  4%      -0.1        1.55 ± 21%      +1.2        2.85 ±  6%  perf-profile.children.cycles-pp.wait_for_lsr
      0.98 ± 17%      -0.1        0.89 ± 30%      +1.0        1.95 ± 12%  perf-profile.children.cycles-pp.truncate_inode_folio
      0.52 ±  7%      -0.1        0.43 ± 29%      +0.4        0.95 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      1.39 ±  5%      -0.1        1.31 ± 22%      +1.0        2.42 ±  6%  perf-profile.children.cycles-pp.io_serial_in
      0.30 ±  3%      -0.1        0.22 ±  3%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.mas_walk
      1.06 ± 13%      -0.1        0.98 ± 22%      +0.8        1.87 ± 10%  perf-profile.children.cycles-pp.release_pages
      0.84 ± 17%      -0.1        0.76 ± 29%      +0.8        1.68 ± 12%  perf-profile.children.cycles-pp.filemap_remove_folio
      0.20 ± 13%      -0.1        0.13 ±  5%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.44 ±  4%      -0.1        0.36 ± 28%      +0.4        0.79 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      0.81 ± 17%      -0.1        0.74 ± 30%      +0.8        1.65 ± 12%  perf-profile.children.cycles-pp.__folio_batch_release
      0.26 ±  2%      -0.1        0.19 ±  3%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.18 ±  5%      -0.1        0.12 ±  5%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.xas_find_conflict
      0.55 ±  4%      -0.1        0.49 ± 14%      +0.3        0.82 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.55 ±  4%      -0.1        0.49 ± 14%      +0.3        0.82 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.28 ±  4%      -0.1        0.22 ±  8%      +0.0        0.28 ± 12%  perf-profile.children.cycles-pp.execve
      0.28 ±  4%      -0.1        0.22 ±  8%      +0.0        0.28 ± 12%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.28 ±  4%      -0.1        0.22 ±  8%      +0.0        0.28 ± 12%  perf-profile.children.cycles-pp.do_execveat_common
      0.29 ±  3%      -0.1        0.24 ±  8%      -0.0        0.26 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.63 ± 17%      -0.1        0.58 ± 30%      +0.6        1.27 ± 12%  perf-profile.children.cycles-pp.__filemap_remove_folio
      0.16 ±  5%      -0.1        0.11 ±  8%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.error_entry
      0.25 ±  7%      -0.0        0.20 ± 22%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.15 ±  5%      -0.0        0.10 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.inode_add_bytes
      0.14 ±  5%      -0.0        0.09 ±  8%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.07 ±  6%      -0.0        0.02 ± 99%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.40 ±  4%      -0.0        0.36 ± 13%      +0.2        0.60 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.06 ±  7%      -0.0        0.02 ±142%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.read
      0.39 ± 17%      -0.0        0.34 ± 30%      +0.4        0.77 ± 12%  perf-profile.children.cycles-pp.free_unref_page_list
      0.10            -0.0        0.06 ± 13%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.18 ±  7%      -0.0        0.14 ± 13%      +0.1        0.24 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.16 ±  5%      -0.0        0.12            -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
      0.17 ±  7%      -0.0        0.12 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.14 ±  6%      -0.0        0.10 ±  3%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__pte_offset_map
      0.26 ±  8%      -0.0        0.22 ± 33%      +0.2        0.48 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.31 ± 16%      -0.0        0.27 ± 28%      +0.3        0.62 ± 11%  perf-profile.children.cycles-pp.find_lock_entries
      0.07 ±  5%      -0.0        0.03 ± 70%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.policy_nodemask
      0.06 ±  9%      -0.0        0.02 ±141%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.16 ±  4%      -0.0        0.13 ± 12%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.19 ±  4%      -0.0        0.16 ±  8%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.bprm_execve
      0.11 ±  9%      -0.0        0.08 ±  6%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ±  6%      -0.0        0.13 ±  5%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.11 ±  6%      -0.0        0.08 ±  6%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.up_read
      0.15 ±  7%      -0.0        0.12 ± 13%      +0.0        0.20 ±  8%  perf-profile.children.cycles-pp.folio_unlock
      0.10 ±  4%      -0.0        0.07 ±  6%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.__libc_fork
      0.07 ±  6%      -0.0        0.04 ± 45%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.ksys_read
      0.10 ±  3%      -0.0        0.07 ± 11%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.kernel_clone
      0.09 ±  5%      -0.0        0.06 ±  7%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.07 ± 15%      -0.0        0.05 ± 72%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.rcu_pending
      0.14 ± 17%      -0.0        0.11 ± 32%      +0.1        0.26 ± 11%  perf-profile.children.cycles-pp.xas_clear_mark
      0.25 ± 17%      -0.0        0.22 ± 30%      +0.2        0.50 ± 12%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.17 ±  3%      -0.0        0.14 ± 23%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.08 ±  8%      -0.0        0.06 ± 11%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.path_openat
      0.09 ±  5%      -0.0        0.06 ± 11%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.08 ±  8%      -0.0        0.06 ± 11%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.do_filp_open
      0.07            -0.0        0.04 ± 45%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.vfs_read
      0.10 ±  6%      -0.0        0.08 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.09 ±  4%      -0.0        0.06 ±  7%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__do_sys_clone
      0.14 ± 10%      -0.0        0.11 ± 15%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.perf_rotate_context
      0.13 ± 18%      -0.0        0.10 ± 33%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.08 ±  8%      -0.0        0.06 ± 11%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.do_sys_openat2
      0.07 ±  5%      -0.0        0.04 ± 45%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.copy_process
      0.07 ± 17%      -0.0        0.04 ± 75%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.filemap_free_folio
      0.10 ± 20%      -0.0        0.08 ± 29%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.xas_init_marks
      0.13 ±  5%      -0.0        0.11 ± 23%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.16 ±  5%      -0.0        0.14 ±  6%      +0.0        0.16 ± 10%  perf-profile.children.cycles-pp.exec_binprm
      0.16 ±  4%      -0.0        0.13 ± 21%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.fbcon_redraw
      0.16 ±  4%      -0.0        0.13 ± 21%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.con_scroll
      0.16 ±  4%      -0.0        0.13 ± 21%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.fbcon_scroll
      0.16 ±  4%      -0.0        0.13 ± 21%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.lf
      0.10 ±  6%      -0.0        0.08 ±  7%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.16 ±  4%      -0.0        0.14 ±  6%      +0.0        0.16 ± 10%  perf-profile.children.cycles-pp.search_binary_handler
      0.09 ±  5%      -0.0        0.07 ±  7%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp._compound_head
      0.08            -0.0        0.06 ±  9%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.09 ±  4%      -0.0        0.07 ± 14%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__schedule
      0.15 ±  5%      -0.0        0.13 ±  7%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.xas_create
      0.06 ± 11%      -0.0        0.04 ± 75%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.trigger_load_balance
      0.15 ±  5%      -0.0        0.13 ± 20%      +0.1        0.21 ±  8%  perf-profile.children.cycles-pp.bit_putcs
      0.16 ±  3%      -0.0        0.14 ± 20%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.vt_console_print
      0.24 ±  6%      -0.0        0.22 ± 34%      +0.2        0.44 ±  5%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.14 ±  3%      -0.0        0.12 ± 24%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      0.15 ±  4%      -0.0        0.14 ±  8%      +0.0        0.16 ±  9%  perf-profile.children.cycles-pp.load_elf_binary
      0.09 ± 11%      -0.0        0.07 ± 26%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.15 ±  4%      -0.0        0.13 ± 21%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.fbcon_putcs
      0.06 ±  8%      -0.0        0.04 ± 72%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.12 ±  4%      -0.0        0.10 ± 22%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.18 ± 19%      -0.0        0.17 ± 29%      +0.2        0.36 ± 11%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.21 ±  7%      -0.0        0.19 ±  5%      +0.0        0.25 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.18 ±  9%      -0.0        0.16 ± 19%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.io_serial_out
      0.58 ± 36%      -0.0        0.56 ± 22%      +0.4        1.00 ± 20%  perf-profile.children.cycles-pp.ktime_get
      0.12 ±  5%      -0.0        0.10 ± 20%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.fast_imageblit
      0.12 ±  5%      -0.0        0.10 ± 20%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.sys_imageblit
      0.06 ± 17%      -0.0        0.05 ± 74%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.08 ± 20%      -0.0        0.06 ± 50%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.07 ±  5%      -0.0        0.06 ± 11%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.schedule
      0.08 ± 16%      -0.0        0.07 ± 16%      +0.1        0.13 ± 23%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.12 ±  5%      -0.0        0.10 ± 23%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.drm_fbdev_generic_defio_imageblit
      0.16 ± 19%      -0.0        0.14 ± 30%      +0.1        0.30 ± 11%  perf-profile.children.cycles-pp.__free_one_page
      0.12 ±  4%      -0.0        0.10 ±  3%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.48 ± 12%      -0.0        0.46 ± 15%      +0.4        0.88 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      6.18 ±  6%      -0.0        6.17 ± 17%      +3.5        9.70 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
      0.08 ±  5%      -0.0        0.07 ± 21%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.11 ± 11%      -0.0        0.10 ± 15%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.memcpy_orig
      0.25 ±  6%      -0.0        0.24 ± 22%      +0.2        0.43 ± 13%  perf-profile.children.cycles-pp.delay_tsc
      0.06 ±  7%      -0.0        0.06 ±  9%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__mod_zone_page_state
      6.18 ±  6%      -0.0        6.18 ± 17%      +3.5        9.70 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.02 ± 99%      -0.0        0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.02 ± 99%      -0.0        0.02 ±142%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.02 ± 99%      -0.0        0.02 ±142%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.update_blocked_averages
      0.03 ±100%      -0.0        0.02 ±141%      +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.07 ± 11%      -0.0        0.06 ± 19%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.rcu_do_batch
      0.03 ± 70%      -0.0        0.03 ±100%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.uncharge_folio
      0.08 ± 17%      -0.0        0.08 ± 27%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.01 ±223%      +0.0        0.01 ±223%      +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.0        0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.20 ± 18%      +0.0        0.21 ± 30%      +0.2        0.44 ± 13%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.01 ±223%      +0.0        0.02 ±141%      +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.kmem_cache_free
      0.05 ±  8%      +0.0        0.08 ±  8%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.54 ±  2%      +0.0        0.57 ±  4%      -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.try_charge_memcg
      0.25 ±  2%      +0.0        0.30 ±  4%      -0.0        0.22 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.02 ±141%      +0.0        0.06 ±  7%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.1        0.07 ± 14%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.25            +0.5        1.72 ±  5%      -0.2        1.09 ±  5%  perf-profile.children.cycles-pp.unmap_vmas
      1.24            +0.5        1.71 ±  5%      -0.2        1.08 ±  5%  perf-profile.children.cycles-pp.zap_pte_range
      1.24            +0.5        1.71 ±  5%      -0.2        1.08 ±  5%  perf-profile.children.cycles-pp.unmap_page_range
      1.24            +0.5        1.71 ±  5%      -0.2        1.08 ±  5%  perf-profile.children.cycles-pp.zap_pmd_range
      1.21            +0.5        1.69 ±  5%      -0.2        1.04 ±  5%  perf-profile.children.cycles-pp.__munmap
      1.22            +0.5        1.71 ±  5%      -0.2        1.06 ±  5%  perf-profile.children.cycles-pp.__vm_munmap
      1.21            +0.5        1.70 ±  5%      -0.2        1.05 ±  5%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.25            +0.5        1.74 ±  5%      -0.2        1.08 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.25            +0.5        1.74 ±  5%      -0.2        1.09 ±  5%  perf-profile.children.cycles-pp.do_vmi_munmap
      1.22            +0.5        1.72 ±  5%      -0.2        1.06 ±  6%  perf-profile.children.cycles-pp.unmap_region
      0.85 ±  2%      +0.6        1.44 ±  5%      -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      0.60 ±  3%      +0.6        1.20 ±  4%      -0.1        0.54 ±  7%  perf-profile.children.cycles-pp.page_remove_rmap
      3.30 ±  3%      +1.9        5.20            -0.3        3.02        perf-profile.children.cycles-pp.finish_fault
      3.04 ±  4%      +2.0        5.01            -0.2        2.79 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      2.85 ±  4%      +2.0        4.87            -0.2        2.61 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      1.97 ±  5%      +2.9        4.88 ±  2%      -0.3        1.66 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      3.69 ±  2%      +3.1        6.80 ±  2%      -0.4        3.32 ±  3%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      7.74 ±  6%      +3.9       11.69 ±  2%      -1.3        6.48 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.80 ±  4%      +4.0        4.85 ±  3%      -0.1        0.74 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      6.12 ±  3%      +6.1       12.18            -0.3        5.85 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.99 ±  3%      +6.6        9.56 ±  2%      +0.0        3.03 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     61.44            +6.7       68.11 ±  3%      -7.1       54.29        perf-profile.children.cycles-pp.do_access
      1.58 ±  9%      +7.1        8.72 ± 16%      +0.0        1.59 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.45 ±  9%      +7.2        8.63 ± 16%      -0.0        1.45 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.53 ±  9%      +7.2        8.72 ± 16%      -0.0        1.51 ± 10%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      2.98 ±  5%      +7.7       10.67 ± 14%      -0.1        2.84 ±  5%  perf-profile.children.cycles-pp.folio_add_lru
      2.86 ±  6%      +7.8       10.63 ± 14%      -0.1        2.74 ±  5%  perf-profile.children.cycles-pp.folio_batch_move_lru
     49.12            +8.3       57.47 ±  3%      -5.5       43.65        perf-profile.children.cycles-pp.asm_exc_page_fault
     34.19            +8.5       42.68 ±  4%      -4.1       30.13        perf-profile.children.cycles-pp.__do_fault
     34.15            +8.5       42.65 ±  4%      -4.1       30.09        perf-profile.children.cycles-pp.shmem_fault
     33.99            +8.6       42.54 ±  4%      -4.0       29.95        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     43.06            +8.8       51.84 ±  4%      -4.9       38.17        perf-profile.children.cycles-pp.__handle_mm_fault
     42.43            +8.9       51.37 ±  4%      -4.8       37.59        perf-profile.children.cycles-pp.do_fault
     42.38            +9.0       51.34 ±  4%      -4.8       37.55        perf-profile.children.cycles-pp.do_read_fault
     45.26            +9.5       54.78 ±  4%      -5.1       40.16        perf-profile.children.cycles-pp.exc_page_fault
     45.15            +9.5       54.69 ±  4%      -5.1       40.05        perf-profile.children.cycles-pp.do_user_addr_fault
     43.91            +9.9       53.80 ±  4%      -5.0       38.95        perf-profile.children.cycles-pp.handle_mm_fault
     17.31 ±  2%     +13.8       31.07 ±  5%      -2.1       15.22 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     12.24            -4.5        7.76 ±  3%      -1.4       10.87 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
     17.96            -3.3       14.66 ±  4%      +0.6       18.55        perf-profile.self.cycles-pp.acpi_safe_halt
     10.95            -3.2        7.74            -1.1        9.82 ±  2%  perf-profile.self.cycles-pp.do_rw_once
      5.96            -1.4        4.58 ±  2%      -0.7        5.29        perf-profile.self.cycles-pp.do_access
      2.40            -0.8        1.64            -0.2        2.16 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      3.92            -0.6        3.36 ±  5%      -0.5        3.39 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      4.40 ±  6%      -0.5        3.95 ±  3%      -0.8        3.65 ±  2%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.52 ±  2%      -0.4        1.10 ±  2%      -0.2        1.36 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      6.86            -0.4        6.47 ±  5%      -0.8        6.07 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.02 ±  2%      -0.3        0.70 ±  4%      -0.1        0.92 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.50 ±  7%      -0.2        0.27 ±  5%      -0.1        0.41 ±  9%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      1.78 ±  6%      -0.2        1.58 ± 22%      +1.4        3.14 ±  4%  perf-profile.self.cycles-pp.memcpy_toio
      0.63 ±  5%      -0.2        0.46 ±  3%      +0.0        0.67 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.42 ±  2%      -0.1        0.27 ±  2%      -0.0        0.37 ±  4%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.52            -0.1        0.38 ±  4%      -0.0        0.50 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.56 ±  2%      -0.1        0.42            -0.1        0.50 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.31 ±  3%      -0.1        0.20 ±  2%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.38 ±  4%      -0.1        0.28            -0.0        0.35 ±  4%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.36 ±  4%      -0.1        0.26 ±  2%      +0.0        0.39 ±  4%  perf-profile.self.cycles-pp.xas_descend
      0.30 ±  2%      -0.1        0.22 ±  2%      -0.0        0.27 ±  4%  perf-profile.self.cycles-pp.mas_walk
      1.39 ±  5%      -0.1        1.31 ± 22%      +1.0        2.42 ±  6%  perf-profile.self.cycles-pp.io_serial_in
      0.33 ±  3%      -0.1        0.26 ± 10%      -0.0        0.29 ±  5%  perf-profile.self.cycles-pp.lru_add_fn
      0.44 ±  9%      -0.1        0.38 ± 17%      +0.2        0.65 ±  6%  perf-profile.self.cycles-pp.release_pages
      0.20 ±  3%      -0.1        0.14 ±  5%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.21 ±  5%      -0.1        0.15 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.26 ±  9%      -0.1        0.20 ± 15%      +0.1        0.34 ±  8%  perf-profile.self.cycles-pp.xas_store
      0.16 ±  7%      -0.1        0.11 ±  6%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__perf_sw_event
      0.18 ±  2%      -0.1        0.13 ±  5%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.__alloc_pages
      0.22 ±  4%      -0.1        0.17 ±  4%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.20 ±  8%      -0.1        0.14 ±  5%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.xas_find
      0.15 ±  6%      -0.0        0.10 ±  7%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.error_entry
      0.25 ±  8%      -0.0        0.20 ± 24%      +0.1        0.37 ± 10%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.40 ±  4%      -0.0        0.36 ± 13%      +0.2        0.60 ±  8%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.17 ±  2%      -0.0        0.12 ±  6%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.17 ±  6%      -0.0        0.13 ± 10%      +0.0        0.22 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.22 ±  4%      -0.0        0.18 ±  9%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.23 ±  4%      -0.0        0.19 ± 10%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.12 ±  7%      -0.0        0.08 ± 10%      -0.0        0.11 ± 15%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.14 ±  3%      -0.0        0.09 ±  7%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp.rmqueue
      0.15 ±  2%      -0.0        0.11 ±  6%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.12 ±  7%      -0.0        0.08 ±  5%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.folio_add_lru
      0.15 ±  6%      -0.0        0.10 ±  9%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.16 ±  7%      -0.0        0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.30 ± 10%      -0.0        0.26 ± 29%      +0.2        0.52 ± 10%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.06 ±  7%      -0.0        0.02 ± 99%      -0.0        0.06        perf-profile.self.cycles-pp.finish_fault
      0.16 ±  4%      -0.0        0.12 ± 12%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.11 ±  8%      -0.0        0.08 ±  6%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.13 ±  6%      -0.0        0.09 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.06 ±  9%      -0.0        0.02 ±141%      +0.0        0.09 ± 13%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.11 ±  9%      -0.0        0.08 ±  6%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.down_read_trylock
      0.12 ±  3%      -0.0        0.09 ±  5%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.do_read_fault
      0.14 ±  8%      -0.0        0.12 ± 14%      +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.folio_unlock
      0.16 ±  4%      -0.0        0.12 ±  4%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.09 ±  5%      -0.0        0.06 ±  7%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.11 ±  6%      -0.0        0.08 ±  5%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.06 ± 14%      -0.0        0.03 ±101%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.08 ±  8%      -0.0        0.05            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.xas_find_conflict
      0.10 ±  6%      -0.0        0.07 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.up_read
      0.12 ±  4%      -0.0        0.09 ±  7%      -0.0        0.11 ±  8%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.25 ± 15%      -0.0        0.22 ± 29%      +0.2        0.49 ± 12%  perf-profile.self.cycles-pp.find_lock_entries
      0.12 ±  4%      -0.0        0.10 ±  6%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  6%      -0.0        0.10 ±  9%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.page_remove_rmap
      0.09 ±  4%      -0.0        0.07 ±  7%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.exc_page_fault
      0.22 ±  6%      -0.0        0.19 ± 17%      +0.1        0.34 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.08            -0.0        0.06 ±  8%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.13 ± 18%      -0.0        0.10 ± 31%      +0.1        0.24 ± 12%  perf-profile.self.cycles-pp.xas_clear_mark
      0.19 ±  5%      -0.0        0.17 ±  5%      +0.0        0.21 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ±  6%      -0.0        0.07 ±  5%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.set_pte_range
      0.05 ± 46%      -0.0        0.03 ±102%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.free_unref_page_list
      0.07 ±  5%      -0.0        0.05 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._compound_head
      0.08            -0.0        0.06 ±  9%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.06 ± 17%      -0.0        0.04 ± 75%      +0.1        0.13 ± 13%  perf-profile.self.cycles-pp.filemap_free_folio
      0.06 ±  9%      -0.0        0.04 ± 73%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.trigger_load_balance
      0.10 ± 23%      -0.0        0.09 ± 35%      +0.1        0.20 ± 16%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.06 ±  9%      -0.0        0.04 ± 45%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.08 ± 22%      -0.0        0.06 ± 51%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.55 ± 38%      -0.0        0.53 ± 24%      +0.4        0.95 ± 21%  perf-profile.self.cycles-pp.ktime_get
      0.28            -0.0        0.27 ±  6%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.18 ±  9%      -0.0        0.16 ± 19%      +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.io_serial_out
      0.12 ±  5%      -0.0        0.10 ± 20%      +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.fast_imageblit
      0.09 ±  5%      -0.0        0.07 ± 21%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.06 ± 16%      -0.0        0.05 ± 74%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.14 ± 19%      -0.0        0.13 ± 32%      +0.1        0.28 ± 11%  perf-profile.self.cycles-pp.__free_one_page
      0.25 ±  6%      -0.0        0.24 ± 22%      +0.2        0.43 ± 13%  perf-profile.self.cycles-pp.delay_tsc
      0.07 ± 16%      -0.0        0.06 ± 17%      +0.0        0.12 ± 25%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.03 ±102%      -0.0        0.02 ±142%      +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.02 ± 99%      -0.0        0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.02 ± 99%      -0.0        0.02 ±141%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.02 ±142%      -0.0        0.02 ±141%      +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.00            +0.0        0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.0        0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.0        0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.02 ±141%      +0.0        0.02 ±142%      +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.uncharge_folio
      0.05 ±  8%      +0.0        0.08 ±  8%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.propagate_protected_usage
      1.31 ±  6%      +0.1        1.43 ±  2%      -0.2        1.07 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      2.93 ±  4%      +0.4        3.35 ±  3%      -0.2        2.71 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.77 ±  7%      +1.5        2.23 ±  3%      -0.1        0.67 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.75 ±  4%      +4.0        4.80 ±  3%      -0.1        0.70 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      2.83 ±  3%      +6.6        9.40 ±  2%      +0.0        2.84 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.45 ±  9%      +7.2        8.63 ± 16%      -0.0        1.45 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





--X8r+u45eQ9hjNWOe
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="will-it-scale-tlb_flush2"
Content-Transfer-Encoding: 8bit


=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4.05            -1.2        2.81            +0.0        4.06        mpstat.cpu.all.usr%
    118438 ± 14%     -27.8%      85543 ± 57%     -47.1%      62659 ± 72%  numa-meminfo.node0.AnonHugePages
    193.83 ±  6%     +69.3%     328.17 ±  8%      +0.5%     194.83 ±  7%  perf-c2c.DRAM.local
      1216 ±  8%     +27.1%       1546 ±  6%      +8.2%       1316 ±  8%  perf-c2c.DRAM.remote
    150.33 ± 13%     -40.0%      90.17 ± 13%     +10.9%     166.67 ±  8%  perf-c2c.HITM.remote
      0.04           -25.0%       0.03            +0.0%       0.04        turbostat.IPC
    316.16            -1.5%     311.47            -0.3%     315.25        turbostat.PkgWatt
     30.54            +4.9%      32.04            -0.5%      30.38        turbostat.RAMWatt
   2132437           -32.3%    1444430            +0.9%    2151460        will-it-scale.52.processes
     41008           -32.3%      27776            +0.9%      41373        will-it-scale.per_process_ops
   2132437           -32.3%    1444430            +0.9%    2151460        will-it-scale.workload
 3.113e+08 ±  3%     -31.7%  2.125e+08 ±  4%      +2.1%   3.18e+08 ±  2%  numa-numastat.node0.local_node
 3.114e+08 ±  3%     -31.7%  2.126e+08 ±  4%      +2.1%   3.18e+08 ±  2%  numa-numastat.node0.numa_hit
 3.322e+08 ±  2%     -32.5%  2.243e+08 ±  3%      -0.3%  3.312e+08 ±  3%  numa-numastat.node1.local_node
 3.323e+08 ±  2%     -32.5%  2.243e+08 ±  3%      -0.3%  3.312e+08 ±  3%  numa-numastat.node1.numa_hit
 3.114e+08 ±  3%     -31.7%  2.126e+08 ±  4%      +2.1%   3.18e+08 ±  2%  numa-vmstat.node0.numa_hit
 3.113e+08 ±  3%     -31.7%  2.125e+08 ±  4%      +2.1%   3.18e+08 ±  2%  numa-vmstat.node0.numa_local
 3.323e+08 ±  2%     -32.5%  2.243e+08 ±  3%      -0.3%  3.312e+08 ±  3%  numa-vmstat.node1.numa_hit
 3.322e+08 ±  2%     -32.5%  2.243e+08 ±  3%      -0.3%  3.312e+08 ±  3%  numa-vmstat.node1.numa_local
      0.00 ± 19%     -61.1%       0.00 ± 31%     +16.7%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    217.07 ± 11%     -46.4%     116.39 ± 23%      -1.8%     213.18 ±  8%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    218.50 ±  6%     +19.1%     260.33 ±  4%      +7.2%     234.17 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
    217.06 ± 11%     -46.4%     116.38 ± 23%      -1.8%     213.18 ±  8%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7758 ± 24%     +15.6%       8968 ± 43%    +113.6%      16574 ± 24%  proc-vmstat.numa_hint_faults_local
 6.436e+08           -32.1%  4.369e+08            +0.9%  6.493e+08        proc-vmstat.numa_hit
 6.435e+08           -32.1%  4.368e+08            +0.9%  6.492e+08        proc-vmstat.numa_local
 6.432e+08           -32.1%  4.368e+08            +0.9%  6.489e+08        proc-vmstat.pgalloc_normal
 1.286e+09           -32.1%  8.726e+08            +0.9%  1.297e+09        proc-vmstat.pgfault
 6.432e+08           -32.1%  4.367e+08            +0.9%  6.488e+08        proc-vmstat.pgfree
    170696 ±  8%      +3.4%     176515 ±  8%      +3.2%     176206 ±  8%  sched_debug.cpu.clock.avg
    170703 ±  8%      +3.4%     176522 ±  8%      +3.2%     176212 ±  8%  sched_debug.cpu.clock.max
    170689 ±  8%      +3.4%     176508 ±  8%      +3.2%     176198 ±  8%  sched_debug.cpu.clock.min
    169431 ±  8%      +3.4%     175248 ±  8%      +3.2%     174916 ±  8%  sched_debug.cpu.clock_task.avg
    169630 ±  8%      +3.4%     175429 ±  8%      +3.2%     175098 ±  8%  sched_debug.cpu.clock_task.max
    162542 ±  8%      +3.5%     168260 ±  8%      +3.4%     168099 ±  9%  sched_debug.cpu.clock_task.min
    170690 ±  8%      +3.4%     176508 ±  8%      +3.2%     176199 ±  8%  sched_debug.cpu_clk
    170117 ±  8%      +3.4%     175938 ±  8%      +3.2%     175626 ±  8%  sched_debug.ktime
    171259 ±  8%      +3.4%     177078 ±  8%      +3.2%     176768 ±  8%  sched_debug.sched_clk
      4.06           +80.8%       7.34            -4.8%       3.86        perf-stat.i.MPKI
 4.066e+09           -23.3%   3.12e+09            +3.5%  4.207e+09        perf-stat.i.branch-instructions
      0.57            -0.0        0.55            -0.0        0.57        perf-stat.i.branch-miss-rate%
  23478297           -25.0%   17605102            +3.3%   24242314        perf-stat.i.branch-misses
     17.25            +7.0       24.27            +0.7       17.95        perf-stat.i.cache-miss-rate%
  82715093 ±  2%     +35.9%  1.124e+08            -1.8%   81201463        perf-stat.i.cache-misses
 4.795e+08 ±  2%      -3.4%   4.63e+08            -5.6%  4.525e+08        perf-stat.i.cache-references
      7.14           +32.9%       9.49            -3.0%       6.92        perf-stat.i.cpi
    134.85            -1.2%     133.29            -0.2%     134.53        perf-stat.i.cpu-migrations
      1760 ±  2%     -26.5%       1294            +1.8%       1792        perf-stat.i.cycles-between-cache-misses
      0.26            -0.0        0.24            -0.0        0.25        perf-stat.i.dTLB-load-miss-rate%
  13461491           -31.7%    9190211            +0.9%   13582086        perf-stat.i.dTLB-load-misses
 5.141e+09           -24.1%  3.902e+09            +3.6%  5.327e+09        perf-stat.i.dTLB-loads
      0.45            -0.0        0.44            -0.0        0.45        perf-stat.i.dTLB-store-miss-rate%
  12934403           -32.2%    8773143            +0.9%   13056838        perf-stat.i.dTLB-store-misses
 2.841e+09           -29.9%  1.992e+09            +2.7%  2.917e+09        perf-stat.i.dTLB-stores
     14.76            +1.4       16.18 ±  4%      +2.2       16.92        perf-stat.i.iTLB-load-miss-rate%
   7454399 ±  2%     -22.7%    5760387 ±  4%     +16.4%    8674584        perf-stat.i.iTLB-load-misses
  43026423           -30.6%   29840650            -1.0%   42585377        perf-stat.i.iTLB-loads
 2.042e+10           -24.7%  1.538e+10            +3.1%  2.104e+10        perf-stat.i.instructions
      2745            -2.5%       2677 ±  4%     -11.4%       2432        perf-stat.i.instructions-per-iTLB-miss
      0.14           -24.6%       0.11            +3.1%       0.14        perf-stat.i.ipc
    815.65           -20.2%     651.03            -1.1%     807.03        perf-stat.i.metric.K/sec
    120.43           -24.3%      91.11            +3.0%     124.05        perf-stat.i.metric.M/sec
   4264808           -32.2%    2892980            +0.9%    4302236        perf-stat.i.minor-faults
  11007315 ±  2%     +39.7%   15375516            -2.9%   10691798 ±  2%  perf-stat.i.node-load-misses
   1459152 ±  6%     +45.1%    2116827 ±  5%      -5.0%    1386160 ±  5%  perf-stat.i.node-loads
   7872989 ±  2%     -26.2%    5812458            -3.4%    7608281 ±  2%  perf-stat.i.node-store-misses
   4264808           -32.2%    2892980            +0.9%    4302236        perf-stat.i.page-faults
      4.05           +80.4%       7.31            -4.8%       3.86        perf-stat.overall.MPKI
      0.58            -0.0        0.57            -0.0        0.58        perf-stat.overall.branch-miss-rate%
     17.25            +7.0       24.27            +0.7       17.95        perf-stat.overall.cache-miss-rate%
      7.13           +32.7%       9.46            -3.0%       6.91        perf-stat.overall.cpi
      1759 ±  2%     -26.5%       1294            +1.8%       1792        perf-stat.overall.cycles-between-cache-misses
      0.26            -0.0        0.23            -0.0        0.25        perf-stat.overall.dTLB-load-miss-rate%
      0.45            -0.0        0.44            -0.0        0.45        perf-stat.overall.dTLB-store-miss-rate%
     14.77            +1.4       16.18 ±  4%      +2.2       16.92        perf-stat.overall.iTLB-load-miss-rate%
      2739            -2.4%       2674 ±  4%     -11.4%       2426        perf-stat.overall.instructions-per-iTLB-miss
      0.14           -24.7%       0.11            +3.1%       0.14        perf-stat.overall.ipc
   2882666           +11.2%    3206246            +2.1%    2944234        perf-stat.overall.path-length
 4.052e+09           -23.3%   3.11e+09            +3.5%  4.193e+09        perf-stat.ps.branch-instructions
  23421504           -25.0%   17574476            +3.2%   24179002        perf-stat.ps.branch-misses
  82419384 ±  2%     +35.9%   1.12e+08            -1.8%   80913267        perf-stat.ps.cache-misses
 4.778e+08 ±  2%      -3.4%  4.614e+08            -5.6%  4.509e+08        perf-stat.ps.cache-references
    134.44            -1.1%     132.98            -0.2%     134.17        perf-stat.ps.cpu-migrations
  13415064           -31.7%    9160067            +0.9%   13535797        perf-stat.ps.dTLB-load-misses
 5.124e+09           -24.1%   3.89e+09            +3.6%   5.31e+09        perf-stat.ps.dTLB-loads
  12889609           -32.2%    8744145            +1.0%   13012111        perf-stat.ps.dTLB-store-misses
 2.831e+09           -29.9%  1.986e+09            +2.7%  2.907e+09        perf-stat.ps.dTLB-stores
   7428050 ±  2%     -22.7%    5741276 ±  4%     +16.4%    8644862        perf-stat.ps.iTLB-load-misses
  42877049           -30.6%   29741122            -1.0%   42438686        perf-stat.ps.iTLB-loads
 2.035e+10           -24.7%  1.533e+10            +3.1%  2.097e+10        perf-stat.ps.instructions
   4250034           -32.2%    2883410            +0.9%    4287486        perf-stat.ps.minor-faults
  10968228 ±  2%     +39.7%   15322266            -2.9%   10654062 ±  2%  perf-stat.ps.node-load-misses
   1454274 ±  6%     +45.1%    2109746 ±  5%      -5.0%    1381519 ±  5%  perf-stat.ps.node-loads
   7845298 ±  2%     -26.2%    5792864            -3.4%    7581789 ±  2%  perf-stat.ps.node-store-misses
   4250034           -32.2%    2883410            +0.9%    4287486        perf-stat.ps.page-faults
 6.147e+12           -24.7%  4.631e+12            +3.0%  6.334e+12        perf-stat.total.instructions
     26.77            -1.8       24.93 ±  3%      +0.5       27.32 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     26.75            -1.8       24.92 ±  2%      +0.4       27.17 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     26.75            -1.8       24.92 ±  2%      +0.4       27.18 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.84            -1.8       25.00 ±  3%      +0.6       27.39 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     26.75            -1.8       24.92 ±  2%      +0.4       27.18 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.75            -1.8       24.92 ±  2%      +0.4       27.18 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.75            -1.8       24.92 ±  2%      +0.4       27.18 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     13.02 ±  2%      -1.4       11.60 ±  4%      -0.4       12.62 ±  2%  perf-profile.calltrace.cycles-pp.testcase
      5.54 ±  5%      -1.0        4.52 ±  3%      -0.5        5.06 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
      1.37 ±  2%      -0.9        0.51 ± 58%      +0.0        1.38 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__madvise
     10.38 ±  3%      -0.8        9.54 ±  2%      -0.4        9.97 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      2.38 ±  2%      -0.8        1.63 ±  3%      -0.1        2.29 ±  4%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush
      4.02 ±  3%      -0.7        3.32 ±  3%      -0.3        3.76 ±  2%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.92 ±  4%      -0.4        1.49 ±  2%      -0.0        1.88 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      1.36 ±  2%      -0.4        0.99            -0.0        1.36 ±  3%  perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      1.30 ± 10%      -0.4        0.94 ±  6%      -0.1        1.16 ±  5%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.50 ± 11%      -0.3        1.19 ±  5%      -0.2        1.29 ±  8%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.13 ±  3%      -0.3        0.83            -0.0        1.13 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      0.71 ±  3%      -0.3        0.43 ± 44%      +0.0        0.71 ±  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__madvise
      1.02 ±  3%      -0.3        0.75            -0.0        1.01 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      0.97 ±  3%      -0.3        0.72            -0.0        0.96 ±  2%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
      0.77 ±  2%      -0.2        0.58 ±  2%      -0.0        0.75 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.71 ±  2%      -0.1        0.60 ±  3%      -0.0        0.69 ±  4%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages
      1.20            +0.1        1.34            -0.1        1.12        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      1.10 ±  2%      +0.2        1.28            -0.1        1.03        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise
      1.04 ±  2%      +0.2        1.24            -0.1        0.98        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
      0.83            +0.2        1.07 ±  2%      -0.0        0.82        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      0.81 ±  2%      +0.3        1.08            -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.88 ± 10%      +0.3        1.16 ±  4%      -0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.71 ±  2%      +0.3        1.00            -0.0        0.68        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range
      0.76 ±  3%      +0.3        1.09 ±  2%      -0.0        0.75 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.73 ±  3%      +0.3        1.07 ±  2%      -0.0        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.55 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault
      6.60 ±  4%      +0.6        7.18 ±  3%      -0.4        6.22 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      6.54 ±  4%      +0.6        7.13 ±  3%      -0.4        6.17 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.7        0.74 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
      0.00            +0.8        0.79 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range
      0.00            +0.8        0.79 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      0.00            +0.8        0.80 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault
      5.80 ±  5%      +0.8        6.60 ±  3%      -0.4        5.41 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.8        0.82            +0.0        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush
      0.69 ±  4%      +0.9        1.59 ±  2%      -0.0        0.66 ±  3%  perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     30.43            +1.1       31.57            -0.3       30.08        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     29.22            +1.5       30.69            -0.3       28.88        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
     29.05            +1.5       30.56            -0.4       28.69        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
     22.56 ±  2%      +2.3       24.87            +0.1       22.70 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
     22.36 ±  2%      +2.3       24.70            +0.1       22.51 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
     22.11 ±  2%      +2.4       24.55            +0.2       22.27 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush
     22.70            +2.6       25.35            +0.4       23.12 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
     22.38            +2.7       25.08            +0.4       22.80 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
     24.10            +2.7       26.82            +0.4       24.51 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     24.09            +2.7       26.82            +0.4       24.51 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise
     24.07            +2.7       26.79            +0.4       24.48 ±  2%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior
     22.14            +2.8       24.93            +0.4       22.56 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
     59.76            +2.9       62.64            -0.0       59.73 ±  2%  perf-profile.calltrace.cycles-pp.__madvise
     57.63            +3.5       61.10            -0.0       57.59 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     57.27            +3.6       60.85            -0.0       57.24 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     56.41            +3.8       60.20            -0.0       56.39 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     56.37            +3.8       60.17            -0.0       56.34 ±  2%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     55.94            +3.9       59.88            -0.0       55.92 ±  2%  perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.85            +4.0       59.82            -0.0       55.83 ±  2%  perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     26.75            -1.8       24.92 ±  2%      +0.4       27.18 ±  5%  perf-profile.children.cycles-pp.start_secondary
     26.98            -1.8       25.22 ±  3%      +0.4       27.40 ±  5%  perf-profile.children.cycles-pp.intel_idle_ibrs
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.do_idle
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
     27.05            -1.8       25.29 ±  3%      +0.4       27.48 ±  5%  perf-profile.children.cycles-pp.cpuidle_idle_call
     13.66 ±  2%      -1.3       12.38            -0.4       13.26 ±  2%  perf-profile.children.cycles-pp.testcase
      5.55 ±  5%      -1.0        4.52 ±  3%      -0.5        5.06 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      2.39 ±  2%      -0.8        1.63 ±  3%      -0.1        2.29 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      4.03 ±  3%      -0.7        3.32 ±  3%      -0.3        3.76 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      1.96 ±  4%      -0.4        1.52 ±  2%      -0.0        1.91 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.30            -0.4        0.94 ±  2%      +0.0        1.32 ±  2%  perf-profile.children.cycles-pp.error_entry
      1.36 ±  2%      -0.4        0.99            -0.0        1.36 ±  3%  perf-profile.children.cycles-pp.__irqentry_text_end
      1.30 ± 10%      -0.4        0.94 ±  6%      -0.1        1.16 ±  5%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.51 ± 11%      -0.3        1.19 ±  5%      -0.2        1.29 ±  8%  perf-profile.children.cycles-pp.uncharge_folio
      1.14 ±  3%      -0.3        0.84            -0.0        1.14 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.02 ±  3%      -0.3        0.75            -0.0        1.02 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      0.98 ±  3%      -0.3        0.72            -0.0        0.96 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.73 ±  2%      -0.2        0.52 ±  2%      -0.0        0.72 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.69 ±  2%      -0.2        0.50 ±  2%      +0.0        0.70 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.79 ±  2%      -0.2        0.60 ±  2%      -0.0        0.77 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.51 ±  2%      -0.1        0.38 ±  2%      +0.0        0.52 ±  4%  perf-profile.children.cycles-pp.sync_regs
      0.41 ±  3%      -0.1        0.29 ±  3%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.44 ±  2%      -0.1        0.32 ±  2%      +0.0        0.44 ±  4%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.72 ±  2%      -0.1        0.61 ±  3%      -0.0        0.71 ±  3%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.39            -0.1        0.28 ±  2%      -0.0        0.39 ±  4%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.35 ±  3%      -0.1        0.25 ±  3%      -0.0        0.35 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.34 ±  2%      -0.1        0.24 ±  4%      +0.0        0.34 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.30 ±  3%      -0.1        0.21 ±  5%      -0.0        0.30        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.32 ±  2%      -0.1        0.24            -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.12 ±  4%      -0.1        0.03 ± 70%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.down_read
      0.25 ±  3%      -0.1        0.18 ±  4%      +0.0        0.26        perf-profile.children.cycles-pp.mas_walk
      0.25 ±  3%      -0.1        0.18 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.17 ±  4%      -0.1        0.11 ±  3%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.14 ±  3%      -0.0        0.10 ±  3%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.clear_page_erms
      0.17 ±  2%      -0.0        0.12 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.find_vma_prev
      0.13 ±  2%      -0.0        0.09            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.11 ±  4%      -0.0        0.07 ± 10%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  2%      -0.0        0.10 ±  7%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.06 ±  7%      -0.0        0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.unmap_vmas
      0.11 ±  3%      -0.0        0.08 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      0.06            -0.0        0.03 ± 70%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.09 ±  7%      -0.0        0.06 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.free_swap_cache
      0.09 ±  7%      -0.0        0.07 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__munmap
      0.09 ±  8%      -0.0        0.06 ±  6%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
      0.09 ±  5%      -0.0        0.06 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.handle_pte_fault
      0.08 ±  8%      -0.0        0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.07 ±  6%      -0.0        0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.08 ±  4%      -0.0        0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07 ±  9%      -0.0        0.05 ±  7%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.unmap_region
      0.08 ±  8%      -0.0        0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.08 ±  8%      -0.0        0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__vm_munmap
      0.08 ±  8%      -0.0        0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.08 ±  5%      -0.0        0.07 ±  7%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.try_charge_memcg
      1.27            +0.1        1.40            -0.1        1.19        perf-profile.children.cycles-pp.unmap_page_range
      1.17            +0.2        1.32            -0.1        1.10        perf-profile.children.cycles-pp.zap_pmd_range
      1.12            +0.2        1.29            -0.1        1.05        perf-profile.children.cycles-pp.zap_pte_range
      0.84            +0.2        1.07 ±  2%      -0.0        0.82        perf-profile.children.cycles-pp.lru_add_fn
      0.81 ±  2%      +0.3        1.08            -0.0        0.76 ±  2%  perf-profile.children.cycles-pp.page_remove_rmap
      0.89 ± 10%      +0.3        1.16 ±  4%      -0.1        0.78 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.77 ±  3%      +0.3        1.09 ±  2%      -0.0        0.75        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      6.62 ±  4%      +0.6        7.19 ±  3%      -0.4        6.24 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      6.56 ±  4%      +0.6        7.14 ±  3%      -0.4        6.18 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.44 ±  2%      +0.6        2.08 ±  2%      -0.0        1.40        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      5.80 ±  5%      +0.8        6.61 ±  3%      -0.4        5.43 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     30.44            +1.1       31.58            -0.3       30.09        perf-profile.children.cycles-pp.tlb_finish_mmu
     29.23            +1.5       30.69            -0.3       28.88        perf-profile.children.cycles-pp.tlb_batch_pages_flush
     29.19            +1.5       30.66            -0.4       28.84        perf-profile.children.cycles-pp.release_pages
      1.63 ±  5%      +1.5        3.13 ±  2%      -0.1        1.56 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.32 ±  4%      +1.6        2.97 ±  2%      -0.1        1.26 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
     24.12            +2.7       26.84            +0.4       24.54 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
     24.12            +2.7       26.84            +0.4       24.53 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
     24.09            +2.7       26.81            +0.4       24.50 ±  2%  perf-profile.children.cycles-pp.folio_batch_move_lru
     59.80            +2.9       62.68            -0.0       59.78 ±  2%  perf-profile.children.cycles-pp.__madvise
     57.82            +3.4       61.26            -0.0       57.78 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.44            +3.5       60.99            -0.0       57.40 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     56.41            +3.8       60.20            -0.0       56.39 ±  2%  perf-profile.children.cycles-pp.__x64_sys_madvise
     56.37            +3.8       60.17            -0.0       56.35 ±  2%  perf-profile.children.cycles-pp.do_madvise
     55.94            +3.9       59.88            -0.0       55.92 ±  2%  perf-profile.children.cycles-pp.madvise_vma_behavior
     55.85            +4.0       59.82            -0.0       55.84 ±  2%  perf-profile.children.cycles-pp.zap_page_range_single
     45.26            +5.0       50.23            +0.6       45.82 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     44.75            +5.0       49.80            +0.6       45.32 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     44.26            +5.2       49.50            +0.6       44.84 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     26.98            -1.8       25.22 ±  3%      +0.4       27.40 ±  5%  perf-profile.self.cycles-pp.intel_idle_ibrs
      1.67 ±  3%      -0.6        1.02 ±  3%      -0.1        1.59 ±  5%  perf-profile.self.cycles-pp.page_counter_uncharge
      1.92 ±  5%      -0.4        1.49 ±  2%      -0.1        1.87 ±  2%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      1.47 ±  2%      -0.4        1.06 ±  2%      +0.0        1.48 ±  4%  perf-profile.self.cycles-pp.testcase
      1.36 ±  2%      -0.4        0.99            -0.0        1.36 ±  3%  perf-profile.self.cycles-pp.__irqentry_text_end
      1.30            -0.4        0.94            +0.0        1.32 ±  2%  perf-profile.self.cycles-pp.error_entry
      1.30 ± 10%      -0.4        0.94 ±  6%      -0.1        1.16 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.18 ±  8%      -0.3        0.86 ±  6%      -0.2        1.02 ±  6%  perf-profile.self.cycles-pp.uncharge_batch
      1.50 ± 11%      -0.3        1.19 ±  5%      -0.2        1.28 ±  8%  perf-profile.self.cycles-pp.uncharge_folio
      0.98 ±  3%      -0.3        0.72            -0.0        0.96 ±  2%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.71 ±  2%      -0.2        0.51 ±  2%      -0.0        0.70 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.69 ±  2%      -0.2        0.50 ±  2%      +0.0        0.70 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.50 ±  4%      -0.2        0.30 ±  5%      -0.0        0.49 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.75 ±  2%      -0.2        0.56 ±  2%      -0.0        0.73 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.51 ±  2%      -0.1        0.38 ±  2%      +0.0        0.52 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.35 ±  3%      -0.1        0.23 ±  2%      -0.0        0.35 ±  5%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.36 ±  5%      -0.1        0.24 ±  2%      +0.0        0.36 ±  3%  perf-profile.self.cycles-pp.lru_add_fn
      0.39 ±  2%      -0.1        0.27 ±  2%      -0.0        0.39 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ±  2%      -0.1        0.61 ±  3%      -0.0        0.70 ±  3%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.45            -0.1        0.34 ±  2%      -0.0        0.44 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.54 ±  4%      -0.1        0.45 ±  4%      -0.0        0.53 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.30 ±  2%      -0.1        0.21 ±  3%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.52 ±  5%      -0.1        0.43 ±  5%      -0.0        0.50 ±  4%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.28 ±  3%      -0.1        0.21            -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.25 ±  3%      -0.1        0.18 ±  4%      +0.0        0.25        perf-profile.self.cycles-pp.mas_walk
      0.24 ±  2%      -0.1        0.17 ±  4%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.16 ±  4%      -0.1        0.10 ±  9%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.14 ±  4%      -0.0        0.10 ±  4%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.clear_page_erms
      0.08 ±  6%      -0.0        0.03 ± 70%      -0.0        0.07        perf-profile.self.cycles-pp.__cond_resched
      0.13            -0.0        0.09            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.14 ±  5%      -0.0        0.11 ±  3%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.handle_mm_fault
      0.11 ±  3%      -0.0        0.08 ±  6%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.08 ±  6%      -0.0        0.04 ± 44%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__perf_sw_event
      0.07 ± 10%      -0.0        0.04 ± 44%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.08 ±  7%      -0.0        0.05 ±  8%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.09 ±  7%      -0.0        0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.free_swap_cache
      0.09 ±  8%      -0.0        0.06 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      0.07 ±  7%      -0.0        0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.10 ±  3%      -0.0        0.08 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.08 ±  6%      -0.0        0.05 ±  8%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.08 ±  7%      -0.0        0.06 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.unmap_page_range
      0.08 ±  6%      -0.0        0.06 ±  9%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.do_anonymous_page
      0.08 ±  5%      -0.0        0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__alloc_pages
      0.08 ±  6%      -0.0        0.06 ±  8%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.do_madvise
      0.07 ± 10%      -0.0        0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.up_read
      1.58 ±  6%      +1.5        3.09 ±  2%      -0.1        1.51 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.27 ±  5%      +1.7        2.93 ±  2%      -0.0        1.22 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
     44.25            +5.2       49.50            +0.6       44.84 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


--X8r+u45eQ9hjNWOe
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="will-it-scale-fallocate1"
Content-Transfer-Encoding: 8bit

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/fallocate1/will-it-scale

commit:
  e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
  8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
  0cba55e237ba6 mm: memcg: optimize parent iteration in memcg_rstat_updated()

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 0cba55e237ba61489c0a29f7d27
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    763.24            -1.2%     754.22            -2.0%     748.22        turbostat.PkgWatt
      4560 ±  2%     -19.4%       3673            +7.1%       4882 ±  2%  vmstat.system.cs
      0.03 ±  3%      -0.0        0.02            -0.0        0.03 ±  2%  mpstat.cpu.all.soft%
      0.13 ±  2%      -0.0        0.10 ±  2%      -0.0        0.13        mpstat.cpu.all.usr%
    293.00 ± 10%     +54.7%     453.17 ± 12%      +7.6%     315.33 ±  3%  perf-c2c.DRAM.local
      3720 ±  3%     +41.1%       5251 ±  3%      +0.8%       3752 ±  3%  perf-c2c.DRAM.remote
    325.67 ±  5%     -21.5%     255.50 ±  7%      +2.5%     333.83 ±  3%  perf-c2c.HITM.remote
   5426049           -33.8%    3590953            +3.3%    5605429        will-it-scale.224.processes
     24222           -33.8%      16030            +3.3%      25023        will-it-scale.per_process_ops
   5426049           -33.8%    3590953            +3.3%    5605429        will-it-scale.workload
    148965 ±  9%      +4.5%     155664 ± 20%     -14.2%     127883 ± 10%  numa-meminfo.node0.Slab
     41751 ± 62%     -31.7%      28502 ±122%     -66.6%      13962 ±108%  numa-meminfo.node1.Active
     41727 ± 62%     -31.7%      28502 ±122%     -66.6%      13948 ±108%  numa-meminfo.node1.Active(anon)
     69062 ± 38%     -19.5%      55596 ± 63%     -39.1%      42090 ± 35%  numa-meminfo.node1.Shmem
    355193 ±  3%     +16.1%     412516 ±  4%      -3.3%     343648 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    355191 ±  3%     +16.1%     412513 ±  4%      -3.2%     343648 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
     89.04 ±  9%     +15.9%     103.22 ±  9%      +3.2%      91.93 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
      4289           -13.9%       3693            +4.9%       4498        sched_debug.cpu.nr_switches.avg
      2259 ±  3%     -25.1%       1693 ±  2%      +5.7%       2388 ±  5%  sched_debug.cpu.nr_switches.min
     44536            -5.9%      41918            +1.5%      45191        proc-vmstat.nr_slab_reclaimable
 3.257e+09           -33.9%  2.153e+09            +3.3%  3.366e+09        proc-vmstat.numa_hit
 3.256e+09           -33.9%  2.152e+09            +3.3%  3.365e+09        proc-vmstat.numa_local
     10269 ± 45%     +87.3%      19237 ± 14%     +83.8%      18876 ± 39%  proc-vmstat.numa_pages_migrated
 3.257e+09           -33.9%  2.153e+09            +3.3%  3.365e+09        proc-vmstat.pgalloc_normal
 3.257e+09           -33.9%  2.153e+09            +3.3%  3.365e+09        proc-vmstat.pgfree
     10269 ± 45%     +87.3%      19237 ± 14%     +83.8%      18876 ± 39%  proc-vmstat.pgmigrate_success
 7.906e+08 ±  4%     -32.9%  5.303e+08 ±  2%      +3.5%  8.181e+08 ±  4%  numa-numastat.node0.local_node
 7.909e+08 ±  4%     -32.9%  5.305e+08 ±  2%      +3.5%  8.184e+08 ±  4%  numa-numastat.node0.numa_hit
 8.069e+08 ±  3%     -33.6%  5.361e+08 ±  2%      +6.0%  8.552e+08 ±  2%  numa-numastat.node1.local_node
 8.072e+08 ±  3%     -33.6%  5.363e+08 ±  2%      +6.0%  8.556e+08 ±  2%  numa-numastat.node1.numa_hit
    101456           -21.4%      79695 ± 38%     -33.4%      67613 ± 38%  numa-numastat.node1.other_node
 8.276e+08           -34.1%  5.457e+08 ±  2%      +2.8%  8.508e+08        numa-numastat.node2.local_node
 8.278e+08           -34.1%  5.459e+08 ±  2%      +2.8%  8.511e+08        numa-numastat.node2.numa_hit
  8.31e+08           -35.0%  5.403e+08            +1.1%  8.406e+08 ±  3%  numa-numastat.node3.local_node
 8.314e+08           -35.0%  5.404e+08            +1.2%  8.409e+08 ±  3%  numa-numastat.node3.numa_hit
 7.909e+08 ±  4%     -32.9%  5.305e+08 ±  2%      +3.5%  8.184e+08 ±  4%  numa-vmstat.node0.numa_hit
 7.906e+08 ±  4%     -32.9%  5.303e+08 ±  2%      +3.5%  8.181e+08 ±  4%  numa-vmstat.node0.numa_local
     10428 ± 62%     -31.6%       7130 ±122%     -66.6%       3486 ±108%  numa-vmstat.node1.nr_active_anon
     17331 ± 38%     -19.0%      14042 ± 63%     -37.6%      10816 ± 33%  numa-vmstat.node1.nr_shmem
     10428 ± 62%     -31.6%       7130 ±122%     -66.6%       3486 ±108%  numa-vmstat.node1.nr_zone_active_anon
 8.072e+08 ±  3%     -33.6%  5.363e+08 ±  2%      +6.0%  8.556e+08 ±  2%  numa-vmstat.node1.numa_hit
 8.069e+08 ±  3%     -33.6%  5.361e+08 ±  2%      +6.0%  8.552e+08 ±  2%  numa-vmstat.node1.numa_local
    101455           -21.4%      79693 ± 38%     -33.4%      67613 ± 38%  numa-vmstat.node1.numa_other
 8.278e+08           -34.1%  5.459e+08 ±  2%      +2.8%  8.511e+08        numa-vmstat.node2.numa_hit
 8.276e+08           -34.1%  5.457e+08 ±  2%      +2.8%  8.508e+08        numa-vmstat.node2.numa_local
 8.314e+08           -35.0%  5.404e+08            +1.2%  8.409e+08 ±  3%  numa-vmstat.node3.numa_hit
  8.31e+08           -35.0%  5.403e+08            +1.1%  8.406e+08 ±  3%  numa-vmstat.node3.numa_local
      0.10 ±  8%    +135.1%       0.24 ± 10%     +32.0%       0.13 ± 23%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 11%     +42.4%       0.06 ± 16%     +13.6%       0.04 ± 20%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 33%    +112.1%       0.14 ± 25%     -32.0%       0.04 ± 47%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.06 ± 46%    +447.4%       0.31 ± 92%      +8.2%       0.06 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ± 33%     +82.8%       0.16 ± 25%     -21.4%       0.07 ± 53%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.03 ±  6%     +32.9%       0.04 ±  7%      -6.1%       0.03 ± 11%  perf-sched.total_sch_delay.average.ms
    139.63 ±  4%     +21.7%     169.99 ±  3%      -9.8%     125.97 ±  3%  perf-sched.total_wait_and_delay.average.ms
     31780 ±  8%     -19.0%      25751 ± 14%      -5.8%      29937 ± 14%  perf-sched.total_wait_and_delay.count.ms
    139.60 ±  4%     +21.7%     169.95 ±  3%      -9.8%     125.94 ±  3%  perf-sched.total_wait_time.average.ms
      0.18 ±  6%     +19.2%       0.22 ± 21%     -14.5%       0.16 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      3.52 ±  5%     +13.4%       3.99 ±  2%      -0.3%       3.51 ±  4%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.45 ±223%    +821.8%       4.15 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    305.95 ±  7%     +44.4%     441.73 ±  4%     -14.7%     260.96 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6913 ±  6%     -16.5%       5771 ± 13%      -0.4%       6884 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1974 ± 11%     -42.6%       1132 ± 16%     -16.3%       1651 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1602 ±  7%      +2.7%       1646 ± 13%     -14.3%       1373 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9474 ± 11%     -33.5%       6303 ± 13%      +0.5%       9524 ± 15%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.19 ±223%    +770.9%      19.04 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1233 ± 30%    +163.1%       3245 ± 26%      +0.9%       1243 ± 30%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.18 ±  6%     +19.2%       0.22 ± 21%     -14.5%       0.16 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
    104.96 ± 11%     +50.8%     158.31 ± 14%     -22.0%      81.88 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±186%    +985.0%       0.18 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      3.41 ±  5%      +9.8%       3.75 ±  3%      -1.2%       3.37 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.38 ±  6%     +65.7%       3.95 ±  9%      +1.4%       2.42 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    305.93 ±  7%     +44.4%     441.71 ±  4%     -14.7%     260.94 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ± 12%     +59.5%       0.11 ± 27%     +28.5%       0.09 ± 44%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    361.49 ± 10%    +163.6%     952.71 ± 24%     -10.2%     324.59 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±186%   +1370.0%       0.24 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      1233 ± 30%    +163.1%       3245 ± 26%      +0.9%       1243 ± 30%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.51           +70.8%       2.58            -5.4%       1.43 ±  2%  perf-stat.i.MPKI
 1.364e+10           -19.8%  1.094e+10            +6.4%  1.451e+10        perf-stat.i.branch-instructions
      0.29            -0.0        0.25            -0.0        0.27        perf-stat.i.branch-miss-rate%
  39037567           -29.6%   27478165            +1.8%   39751409        perf-stat.i.branch-misses
     26.72            +7.0       33.67            +0.7       27.42        perf-stat.i.cache-miss-rate%
  97210743           +34.0%  1.302e+08 ±  2%      +0.3%   97544414 ±  2%  perf-stat.i.cache-misses
 3.641e+08            +6.3%  3.868e+08 ±  2%      -2.2%  3.559e+08 ±  2%  perf-stat.i.cache-references
      4452 ±  2%     -20.0%       3561            +7.5%       4784 ±  2%  perf-stat.i.context-switches
     13.13           +27.5%      16.74            -5.7%      12.38        perf-stat.i.cpi
    270.31            -1.6%     265.85            +0.4%     271.43        perf-stat.i.cpu-migrations
      8711           -25.3%       6504            -0.3%       8685 ±  2%  perf-stat.i.cycles-between-cache-misses
  1.66e+10           -21.1%   1.31e+10            +6.8%  1.774e+10        perf-stat.i.dTLB-loads
 7.758e+09           -31.1%  5.343e+09            +6.3%  8.251e+09        perf-stat.i.dTLB-stores
  12549015           -38.5%    7719822            +0.5%   12615766        perf-stat.i.iTLB-load-misses
 6.454e+10           -21.6%   5.06e+10            +6.1%  6.846e+10        perf-stat.i.instructions
      5208           +29.5%       6745            +5.4%       5491        perf-stat.i.instructions-per-iTLB-miss
      0.08           -21.6%       0.06            +6.1%       0.08        perf-stat.i.ipc
      0.36 ±  6%     -24.6%       0.27 ± 25%     -23.7%       0.27 ± 25%  perf-stat.i.major-faults
     86.32 ±  2%     +27.6%     110.14            +2.1%      88.10        perf-stat.i.metric.K/sec
    171.24           -22.4%     132.88            +6.5%     182.34        perf-stat.i.metric.M/sec
  14793159           +36.3%   20167559            +0.9%   14924992        perf-stat.i.node-load-misses
   1101912 ±  7%     +48.5%    1636628 ±  4%      +2.6%    1130608 ±  9%  perf-stat.i.node-loads
   3340101 ±  2%     -19.8%    2679120            +6.9%    3571816        perf-stat.i.node-store-misses
     84773 ±  5%     -20.6%      67339 ±  6%      +2.0%      86484 ±  5%  perf-stat.i.node-stores
      1.51           +70.8%       2.57            -5.4%       1.42 ±  2%  perf-stat.overall.MPKI
      0.29            -0.0        0.25            -0.0        0.27        perf-stat.overall.branch-miss-rate%
     26.69            +6.9       33.63            +0.7       27.39        perf-stat.overall.cache-miss-rate%
     13.12           +27.5%      16.73            -5.7%      12.37        perf-stat.overall.cpi
      8709           -25.3%       6503 ±  2%      -0.3%       8682 ±  2%  perf-stat.overall.cycles-between-cache-misses
      5146           +27.5%       6563            +5.5%       5430        perf-stat.overall.instructions-per-iTLB-miss
      0.08           -21.6%       0.06            +6.1%       0.08        perf-stat.overall.ipc
   3581676           +18.4%    4239733            +2.6%    3673713        perf-stat.overall.path-length
 1.359e+10           -19.8%  1.091e+10            +6.4%  1.446e+10        perf-stat.ps.branch-instructions
  38876130           -29.7%   27341584            +1.8%   39577054        perf-stat.ps.branch-misses
  96879835           +34.0%  1.298e+08 ±  2%      +0.3%   97215764 ±  2%  perf-stat.ps.cache-misses
  3.63e+08            +6.3%  3.859e+08 ±  2%      -2.2%  3.549e+08 ±  2%  perf-stat.ps.cache-references
      4434 ±  2%     -20.0%       3547            +7.4%       4764 ±  2%  perf-stat.ps.context-switches
    268.37            -1.9%     263.37            +0.3%     269.14        perf-stat.ps.cpu-migrations
 1.655e+10           -21.1%  1.305e+10            +6.8%  1.768e+10        perf-stat.ps.dTLB-loads
 7.733e+09           -31.1%  5.325e+09            +6.3%  8.223e+09        perf-stat.ps.dTLB-stores
  12499097           -38.5%    7684522            +0.5%   12563331        perf-stat.ps.iTLB-load-misses
 6.433e+10           -21.6%  5.044e+10            +6.1%  6.823e+10        perf-stat.ps.instructions
      0.34 ±  6%     -25.9%       0.25 ± 25%     -23.8%       0.26 ± 25%  perf-stat.ps.major-faults
  14743590           +36.3%   20098836            +0.9%   14874764        perf-stat.ps.node-load-misses
   1098750 ±  7%     +48.7%    1633532 ±  4%      +2.7%    1128235 ±  9%  perf-stat.ps.node-loads
   3328886 ±  2%     -19.8%    2670192            +6.9%    3559593        perf-stat.ps.node-store-misses
     84559 ±  5%     -20.6%      67163 ±  6%      +1.9%      86147 ±  5%  perf-stat.ps.node-stores
 1.943e+13           -21.7%  1.522e+13            +6.0%  2.059e+13        perf-stat.total.instructions
      9.91 ± 10%      -3.8        6.10 ±  4%      -1.4        8.53 ± 11%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      4.47 ± 10%      -2.3        2.19 ±  4%      -0.6        3.84 ± 11%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     58.11            -2.1       56.01            -1.1       57.01        perf-profile.calltrace.cycles-pp.fallocate64
     58.02            -2.1       55.95            -1.1       56.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     58.00            -2.1       55.94            -1.1       56.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     57.96            -2.1       55.91            -1.1       56.85        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     57.92            -2.0       55.89            -1.1       56.82        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     57.82            -2.0       55.83            -1.1       56.72        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.47            -1.8       55.62            -1.1       56.40        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     57.30            -1.8       55.53            -1.1       56.22        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      2.17 ±  4%      -1.0        1.14 ±  3%      -0.1        2.06 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      3.08 ±  9%      -0.9        2.19 ±  4%      -0.4        2.64 ± 11%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1.29 ±  6%      -0.7        0.54 ±  4%      -0.1        1.16 ±  6%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range
      0.88 ±  2%      -0.3        0.59 ±  2%      +0.0        0.90 ±  2%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range
      1.66            -0.0        1.63 ±  3%      +0.0        1.69        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      1.64            -0.0        1.62 ±  3%      +0.0        1.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.66            -0.0        1.63 ±  3%      +0.0        1.69        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      0.80            +0.1        0.86 ±  2%      -0.0        0.78 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.61 ±  2%      +0.1        0.74 ±  2%      -0.0        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      1.65 ±  2%      +0.2        1.85            +0.0        1.67 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      1.44 ±  3%      +0.4        1.79 ±  3%      -0.1        1.34 ±  4%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.08 ±223%      +0.5        0.60 ±  2%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      0.00            +0.9        0.86 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     41.70            +2.1       43.82 ±  2%      +1.1       42.82 ±  2%  perf-profile.calltrace.cycles-pp.ftruncate64
     41.68            +2.1       43.81 ±  2%      +1.1       42.80 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     41.68            +2.1       43.81 ±  2%      +1.1       42.80 ±  2%  perf-profile.calltrace.cycles-pp.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     41.68            +2.1       43.80 ±  2%      +1.1       42.80 ±  2%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.69            +2.1       43.82 ±  2%      +1.1       42.81 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     41.69            +2.1       43.82 ±  2%      +1.1       42.81 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     41.67            +2.1       43.80 ±  2%      +1.1       42.80 ±  2%  perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64
     41.67            +2.1       43.80 ±  2%      +1.1       42.79 ±  2%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate
     38.67            +2.3       40.97 ±  2%      +1.0       39.68 ±  2%  perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     36.98            +2.3       39.32 ±  2%      +1.0       37.96 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
     44.10            +2.4       46.47 ±  2%      +0.4       44.48        perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     44.04            +2.4       46.42 ±  2%      +0.4       44.42        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     42.89            +2.4       45.32 ±  2%      +0.4       43.29        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     42.87            +2.4       45.31 ±  2%      +0.4       43.27        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
     42.84            +2.4       45.29 ±  2%      +0.4       43.24        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     33.96            +3.4       37.31 ±  2%      +1.1       35.02 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
     33.94            +3.4       37.30 ±  2%      +1.1       35.00 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range
     33.92            +3.4       37.28 ±  2%      +1.1       34.98 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
      9.93 ± 10%      -3.8        6.10 ±  4%      -1.4        8.54 ± 11%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      4.48 ± 10%      -2.3        2.20 ±  4%      -0.6        3.84 ± 11%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
     58.14            -2.1       56.03            -1.1       57.04        perf-profile.children.cycles-pp.fallocate64
     57.96            -2.1       55.91            -1.1       56.85        perf-profile.children.cycles-pp.__x64_sys_fallocate
     57.92            -2.0       55.89            -1.1       56.82        perf-profile.children.cycles-pp.vfs_fallocate
     57.82            -2.0       55.83            -1.1       56.73        perf-profile.children.cycles-pp.shmem_fallocate
     57.53            -1.8       55.69            -1.1       56.44        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     57.36            -1.8       55.60            -1.1       56.27        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      2.18 ±  4%      -1.0        1.14 ±  3%      -0.1        2.07 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      3.09 ±  9%      -0.9        2.19 ±  4%      -0.4        2.64 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      1.29 ±  6%      -0.7        0.54 ±  4%      -0.1        1.16 ±  6%  perf-profile.children.cycles-pp.uncharge_folio
      0.88 ±  2%      -0.3        0.59 ±  2%      +0.0        0.90 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.36            -0.1        0.22 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.shmem_alloc_folio
      0.36 ±  2%      -0.1        0.23 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.xas_store
      0.32 ±  2%      -0.1        0.20 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.27 ±  2%      -0.1        0.16 ±  4%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.27            -0.1        0.17 ±  3%      +0.0        0.28        perf-profile.children.cycles-pp.__alloc_pages
      0.37 ±  4%      -0.1        0.29            +0.0        0.40        perf-profile.children.cycles-pp.page_counter_uncharge
      0.18            -0.1        0.11 ±  4%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.16 ±  3%      -0.1        0.09            +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.18 ±  2%      -0.1        0.12 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.14 ±  2%      -0.1        0.09            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.18 ±  3%      -0.1        0.13 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.09 ± 10%      -0.0        0.04 ± 73%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.12            -0.0        0.07            +0.0        0.12        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.11            -0.0        0.06 ±  6%      +0.0        0.11        perf-profile.children.cycles-pp.filemap_get_entry
      0.13 ±  2%      -0.0        0.09 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.__mod_node_page_state
      0.10 ±  3%      -0.0        0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xas_descend
      0.12            -0.0        0.08            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.11 ±  3%      -0.0        0.07            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.10 ± 35%      -0.0        0.06            -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.10            -0.0        0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.18            -0.0        0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.16 ±  4%      -0.0        0.13 ±  2%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.10            -0.0        0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.08 ±  4%      -0.0        0.05 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.xas_init_marks
      0.09 ±  4%      -0.0        0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.18 ±  2%      -0.0        0.16            -0.0        0.18        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.14 ±  2%      -0.0        0.13 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.14 ±  2%      -0.0        0.13 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.09            -0.0        0.08            +0.0        0.09        perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.0        0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.82            +0.1        0.87            -0.0        0.79 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
     99.81            +0.1       99.89            +0.0       99.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.79            +0.1       99.88            +0.0       99.80        perf-profile.children.cycles-pp.do_syscall_64
      0.51            +0.5        0.98 ±  3%      +0.0        0.53 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      4.21            +0.8        5.01            -0.1        4.12        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     41.68            +2.1       43.81 ±  2%      +1.1       42.80 ±  2%  perf-profile.children.cycles-pp.do_sys_ftruncate
     41.70            +2.1       43.82 ±  2%      +1.1       42.82 ±  2%  perf-profile.children.cycles-pp.ftruncate64
     41.68            +2.1       43.81 ±  2%      +1.1       42.80 ±  2%  perf-profile.children.cycles-pp.do_truncate
     41.68            +2.1       43.80 ±  2%      +1.1       42.80 ±  2%  perf-profile.children.cycles-pp.notify_change
     41.67            +2.1       43.80 ±  2%      +1.1       42.80 ±  2%  perf-profile.children.cycles-pp.shmem_setattr
     41.67            +2.1       43.81 ±  2%      +1.1       42.80 ±  2%  perf-profile.children.cycles-pp.shmem_undo_range
     38.67            +2.3       40.98 ±  2%      +1.0       39.68 ±  2%  perf-profile.children.cycles-pp.__folio_batch_release
     37.07            +2.3       39.39 ±  2%      +1.0       38.05 ±  2%  perf-profile.children.cycles-pp.release_pages
     45.77            +2.4       48.14            +0.4       46.17        perf-profile.children.cycles-pp.folio_batch_move_lru
     44.14            +2.4       46.52 ±  2%      +0.4       44.51        perf-profile.children.cycles-pp.folio_add_lru
     78.55            +5.8       84.34            +1.5       80.04        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     78.52            +5.8       84.31            +1.5       80.00        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     78.48            +5.8       84.29            +1.5       79.96        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.47 ± 10%      -2.3        2.19 ±  4%      -0.6        3.83 ± 11%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      2.67 ± 11%      -1.3        1.32 ±  4%      -0.5        2.22 ± 12%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      1.28 ±  6%      -0.7        0.54 ±  4%      -0.1        1.16 ±  6%  perf-profile.self.cycles-pp.uncharge_folio
      2.18 ± 11%      -0.6        1.58 ±  5%      -0.3        1.86 ± 12%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.16 ±  8%      -0.3        0.84 ± 10%      +0.1        1.24 ± 14%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.38 ±  7%      -0.2        0.18 ±  5%      -0.0        0.35 ±  6%  perf-profile.self.cycles-pp.uncharge_batch
      0.24 ±  4%      -0.1        0.16 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.18 ±  3%      -0.1        0.11 ±  3%      -0.0        0.18        perf-profile.self.cycles-pp.xas_store
      0.19            -0.1        0.12 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.14 ±  5%      -0.1        0.08 ±  5%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.23 ±  5%      -0.1        0.17 ±  2%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.11            -0.1        0.06            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.shmem_fallocate
      0.13            -0.0        0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.14 ±  3%      -0.0        0.09            +0.0        0.14        perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ±  5%      -0.0        0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.xas_descend
      0.10 ±  3%      -0.0        0.06            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.09 ± 37%      -0.0        0.05 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.16 ±  4%      -0.0        0.13 ±  2%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.09            -0.0        0.06            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.xas_clear_mark
      0.09 ±  5%      -0.0        0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.15            -0.0        0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.07 ±  7%      -0.0        0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.0        0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.50 ±  3%      +0.5        0.97 ±  3%      +0.0        0.52 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      4.14 ±  2%      +0.8        4.97            -0.1        4.06        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
     78.48            +5.8       84.29            +1.5       79.96        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


--X8r+u45eQ9hjNWOe--

