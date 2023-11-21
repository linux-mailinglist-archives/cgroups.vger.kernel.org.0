Return-Path: <cgroups+bounces-501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743487F27A6
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 09:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BBC1C218B9
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFF4694;
	Tue, 21 Nov 2023 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2Ud0dC8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165EAC;
	Tue, 21 Nov 2023 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700555955; x=1732091955;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=SmubsO2KBmyZAjX96YvXEfWJokNwJrLpJ1Ezov9krYA=;
  b=S2Ud0dC8Anox0x1dPgHLVUeVWqIQWTGZrutA7E7yXuAorkzBBvMKiIP8
   AopXrXbYcZftRUrhJ2uw8M3uImCRBhVbwYVEaz74Ql+Tc0rKdPKub8A1d
   AdH1BY2IGBGMMdLNevPyQGcLtCD7ohb85nfE3GonNXtt2arRaTgYxMky5
   rKk2OT34w3Wh2W8TEDVgAyujX+1lvZwSKoepKzXRPm/N6d5Z9sR/Llxo/
   8pD8RCw81GCQKjPQMfrS+QhoC+khrzutimNlZJPh0D1PxGJ8cyGa+IPA+
   5gP72yMWt4yYOjDddvEvsVilec4UQ6I8U0NUpA4qHdBNBv0qdRtLeFAZF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388940805"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="388940805"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795723631"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795723631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 00:38:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 00:38:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 00:38:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 00:38:52 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 00:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdIREFLOQjfkw93Q4stPjJwxHikY1jYPlnY+eqQPlOcDUmBS3OB8GhpK1qpCx5h/c89E7Q1nJODK4fhz+TJx1DRtk/iq6FBLmTXAQJ9w5z0WyaxrysC436uyXYpRQpJs9CP0ViDnv5fl4o+CMqavnoMl1K+78gdhO6MueK/s5GS5KYalCHQ0A7NV6jz2el8O+gohNjSus//D6NgCVFu+oMmv1LfgyTco3pTSTgMLOMYICwzLfEzu/UC3jhwpMPk9k+i3tREVTGijBDjHCIQKLkKcga0mj8ZO5sKbjamOuKh0tUF+W8DW9gby3D6r+XoEZTxCGvQDUXv8gx9qPN52UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx9IjXymY5jqQYZb41jsqcXiaXDLOjQ5t+p0cDAGd08=;
 b=WtQ6ZMNbzHguYYtCSO7FmaHM6UJymyfkja3ncue4rrBvHCOQKodgfStQv9x/bFjikZhoKEZYy22d13prXdDs3SdVdo3/ERcLPLJrjcTHVC2erYoPsmDFeAoHceviCGgWCKfCF1B10V1JP+ARWEuRKAtVyqYH+RzDv1QNFeVFB/+mGBhJ7/K/m0CQYhEFQoU0322cmYiFdXZID54J3/ZK50WEvOnil5/0JBAmpf5MnQWn3Qgwdm65HxLsjK8LEUNG1XZaCa38kV4bCOVd/qaJJ7wBbplHXyXYYc6/SO6GDzNJgMN0TMoKX7SuKq2Lboi2GXEAEpRUJvaJWN91cn2fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 08:38:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 08:38:47 +0000
Date: Tue, 21 Nov 2023 16:38:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Michal
 =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeelb@google.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm]  7bd5bc3ce9:  aim7.jobs-per-min 4.4% improvement
Message-ID: <202311211612.33647109-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fadf0c-14f5-479e-ed37-08dbea6d4673
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P5Cdv55TsZM2SSQM6gAmYjhee/kmPEIUxySEIMKy6hXa2jNn/YKXYlfnRt5Y7zfuphfOGKL8k0jQgKY/SPHGHM/YgbEAdi/6/qedv7ABLrBzJYhzJttd6BLEzo4/ntT1+66AMZgM7p3Pnyt6JZs3qofV6nXK1sMSe0nCgmzkczXqcQETcO8TPHdeUiPPop9XrJtVNfaFURePHHqZ79PemPqSDrjebrk3s8cHgB9t9N+VeCIgGBeHT4yK6mdJIbuPpihP5p2y2ENUzYT6anVtRYjcC5yR8vE1GFQfqT52nBRvvFQXK+9FvzDcW/EJ5j/M862gDd7XA02Fmo8Yl9iD8vE5xO+OW5bjWY61HzEmQUw/rjze9fvEl0yzNkKkkxwGVCgu2tBG1rlZRKa5bgpCTR0uwQFnps9e4dGV0bHK4YuOAXWqKwEtUtb7Oz1ay1SrPcbQXyeDcf3ESzD9dad1ZvNiUPh4FhZiTOYCjsOqX+rT++rbGWX5xX87aoOgyfnliSA09xiBGMbsWMax3wB5juLDryQ+gt8EnsHzJ6oT2MLC9nh801B+L4RNFxXUTqWUFMiXrr9ELSNs0jBhebA3CcL7RiDQtLePJ5G2p/dTro+vOHDijh2v8E9KytVM5mrZAmaWaipXT6rtXLURSO8MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230373577357003)(230922051799003)(230473577357003)(64100799003)(186009)(1800799012)(451199024)(2616005)(82960400001)(86362001)(966005)(6486002)(6666004)(6506007)(66476007)(6916009)(66556008)(19627235002)(316002)(54906003)(66946007)(36756003)(107886003)(6512007)(26005)(83380400001)(1076003)(2906002)(7416002)(30864003)(5660300002)(478600001)(38100700002)(8936002)(4326008)(41300700001)(8676002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ccZ1AXpo/V72Z1SMVwYcOSTHHQXJP/By4pQZgTkAd0/umwXiUjluTuAMmq?=
 =?iso-8859-1?Q?/H1ACRY8j4BUNJ8fMuB7Lom6gF9VyCS9eaHI/o4hChHMktKtCr2khf9ZE9?=
 =?iso-8859-1?Q?cxOVzf3RZUXuccui6j7rCH7cAhEy1tkyvBr54A8rWkD8J1xjiDY4rdezhm?=
 =?iso-8859-1?Q?cazySC/8PGdew2wQT2pWE1xU8Yu03HxHeFo2bQWsQ2UWOc6jGO/+x58DX/?=
 =?iso-8859-1?Q?dFXN0p0vtipuOYBiMDDHCPo9Q7k5/OQJlRNAydlvgUuuYidGVdiRE+28Px?=
 =?iso-8859-1?Q?7oI8kgenl0KrA/xub4xE0Jp0v9OTl/aP+qvCLD+1E/Z0tyM3/OmBKiCIKL?=
 =?iso-8859-1?Q?VbBy90d8cr58iIKva5zIKLEV4fUcHEq+rSYTi46HAxaXqxi/9Cm033di9C?=
 =?iso-8859-1?Q?hpIzuF1nWm01sn158bSEPO0HUtCOLAZkCgVWFZb/YpH5YyCx66kTR24W0+?=
 =?iso-8859-1?Q?k1v7dihFzZkGnWSC2XqS3NPZxs63pw1I6B74pM/CWcQQpInwBsjKf9o2wf?=
 =?iso-8859-1?Q?Bm03WxQTxlrF0gPZ+s03FoM58S06kMZu8BY2uwamGk3hOOp5mLcmFcGLYr?=
 =?iso-8859-1?Q?laAS2g4HRWlsTH7vpBu7AltouccuJWC46JVxfWqPq4AOGTw5R5Qz0aWKzd?=
 =?iso-8859-1?Q?WUDkX/73cbTZJPTJcMWd9AygqTsakpUhTavphKbM4Na87F2zHL7niUtxfX?=
 =?iso-8859-1?Q?4ZYFlJife9xwWg2HH/oWx15Dy9udgVkFgM4U96mGYbNF0gg5Nf1q25rbok?=
 =?iso-8859-1?Q?4Klrmj+rRpfIVf9egDff3rYMowA3SbgZthWbp4RFVmbtMe+lhMkoHEuhyW?=
 =?iso-8859-1?Q?sR+/AZsMNlvJNOaTJ1RTNvfPBKbVqmgMrNKnLAC+oRm4o2i8EEhTP9Oi+F?=
 =?iso-8859-1?Q?laQOPCxZvpfDLVUXPP3duZE3FGa3MzL/hJ4sHAFKKOtz56kGqXKapVZkxy?=
 =?iso-8859-1?Q?el0CSOeiBGCSKwULRM2YEp1eG9lHG9iJSYE3mVn7tb/gdCLiU/TBRUtn2x?=
 =?iso-8859-1?Q?Rdkt27n7XSTNW1vircjD7BdxagYo/iGzTdSkSwmoisejg0AlWtf8BPszsu?=
 =?iso-8859-1?Q?jlI8cea6GbDtabEm3yq17oaO7BtVfD9sUpqK6b3QgrvbMMmE5bwke21JDf?=
 =?iso-8859-1?Q?4bU5PBOdeO/3c/QW22i7yOYxV0+d7Z14z/O3XL4Z7ITCUtt0ycyA9Ogmtq?=
 =?iso-8859-1?Q?GVt2uqKXQT87XpRUahZdBvqlUxPEnsfSbPznrl8IRy4ULLdL+/00lI5OYH?=
 =?iso-8859-1?Q?Us18v+Oh/SKkcsbTtR9uC05q4Wn78H7Xh9OTPqZZCLeESsqtCoMySiErUa?=
 =?iso-8859-1?Q?Kc+SN6y3nTTFP6JnwttNhq0tyRNmxD7Dqd6VcjigNB9jnvTWMHPT64naG3?=
 =?iso-8859-1?Q?4Tp4OMw2qUwO834arsaEghvNJ0ZBXkCidQrZ6IknWm9z6teokQsQFkNl6J?=
 =?iso-8859-1?Q?NaDNY1ioekIQtiVGTdOVAmDLh9VOMVnXrqWaCEoWMFqQYQCG94vXrYlmIA?=
 =?iso-8859-1?Q?I2UzswNZuSF6WvonaZlyrdkUFS1kwJa1jVzRKQAg29BwjvrcP6HUyMJZsp?=
 =?iso-8859-1?Q?H0NDDsXWeMgiWAcawoDL/HtyunEIxljeAq2ccHqtAbnuaHhPbig4neKo3l?=
 =?iso-8859-1?Q?FXS/2g1nGfzD3yYrDcWGXkIgl+qllEGOIkzcv7ANx41GExfMUe830++w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fadf0c-14f5-479e-ed37-08dbea6d4673
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 08:38:46.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIYB8GnuPX8N2QU2JnUmbSnW6L07y+hr9a8Rtyrhp2eAR45v2G/QsMlF0+YlBfPeW3r0TGwIwUUxFKDg4A5Vlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.4% improvement of aim7.jobs-per-min on:


commit: 7bd5bc3ce9632aefd0eed33a19212a2e55c0f873 ("mm: memcg: normalize the value passed into memcg_rstat_updated()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim7
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: ext4
	test: disk_rr
	load: 3000
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 2.2% improvement                                                   |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | disk=1BRD_48G                                                                              |
|                  | fs=ext4                                                                                    |
|                  | load=3000                                                                                  |
|                  | test=disk_cp                                                                               |
+------------------+--------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231121/202311211612.33647109-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_rr/aim7

commit: 
  ff841a06c8 ("mm: memcg: refactor page state unit helpers")
  7bd5bc3ce9 ("mm: memcg: normalize the value passed into memcg_rstat_updated()")

ff841a06c844b055 7bd5bc3ce9632aefd0eed33a192 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    838.50 ± 27%     -47.7%     438.67 ± 50%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     21.24 ± 22%     +36.9%      29.06 ± 20%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    620370            +4.4%     647378        aim7.jobs-per-min
    153681 ±  6%      -8.1%     141236 ±  4%  aim7.time.involuntary_context_switches
      2286            -6.8%       2132        aim7.time.system_time
      2.79            -4.6%       2.66        perf-stat.overall.cpi
      0.01 ± 19%      -0.0        0.01 ± 13%  perf-stat.overall.dTLB-load-miss-rate%
      0.36            +4.9%       0.38        perf-stat.overall.ipc
     21.96            -0.8       21.14        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
     22.01            -0.8       21.19        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     21.40            -0.8       20.58        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     21.42            -0.8       20.61        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
     21.41            -0.8       20.60        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
     23.15            -0.8       22.37        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     24.45            -0.7       23.76        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     24.40            -0.7       23.75        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
     24.38            -0.7       23.72        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
     24.40            -0.7       23.74        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
     27.97            -0.6       27.32        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     25.20            -0.6       24.56        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
     30.21            -0.5       29.69        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dentry_kill
     30.32            -0.5       29.81        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
     30.31            -0.5       29.80        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dentry_kill.dput
     30.36            -0.5       29.85        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     30.34            -0.5       29.83        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     30.38            -0.5       29.87        perf-profile.calltrace.cycles-pp.__close
     30.35            -0.5       29.84        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.37            -0.5       29.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     30.37            -0.5       29.87        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     30.36            -0.5       29.86        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     30.33            -0.5       29.83        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.__x64_sys_close
     27.52            -0.5       27.03        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     32.56            -0.5       32.09        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     33.62            -0.4       33.22        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.80            -0.3       34.52        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.76            -0.2        0.54        perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.76            -0.2        0.54        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.78            -0.2        0.56        perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.80            -0.2        0.59        perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.75            -0.2        0.54        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      1.16            -0.2        0.98        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.56 ±  2%      +0.0        0.58        perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.filemap_read.vfs_read
      0.74 ±  2%      +0.0        0.77        perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
      1.10            +0.0        1.14        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.64            +0.0        0.68        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.54            +0.0        0.58        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.98            +0.0        1.03        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.58            +0.0        0.63        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.95            +0.1        1.00        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.84            +0.1        0.89        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.75            +0.1        0.81        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      0.71            +0.1        0.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.90            +0.1        0.97        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.91            +0.1        0.98 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.93            +0.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2.17            +0.1        2.25        perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.63            +0.1        1.72        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1.58            +0.1        1.69        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
      1.42            +0.1        1.53        perf-profile.calltrace.cycles-pp.llseek
      1.71            +0.1        1.83        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      1.81            +0.1        1.93        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      2.74            +0.2        2.90        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     29.25            +0.3       29.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     29.38            +0.3       29.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     30.13            +0.4       30.51        perf-profile.calltrace.cycles-pp.read
     70.96            -1.7       69.29        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     70.80            -1.7       69.14        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     70.75            -1.6       69.12        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     47.66            -1.0       46.66        perf-profile.children.cycles-pp.folio_batch_move_lru
     22.05            -0.8       21.23        perf-profile.children.cycles-pp.folio_add_lru
     23.15            -0.8       22.38        perf-profile.children.cycles-pp.filemap_add_folio
     24.49            -0.7       23.80        perf-profile.children.cycles-pp.__filemap_get_folio
     27.97            -0.6       27.32        perf-profile.children.cycles-pp.__folio_batch_release
     25.44            -0.6       24.83        perf-profile.children.cycles-pp.release_pages
     30.21            -0.5       29.70        perf-profile.children.cycles-pp.truncate_inode_pages_range
     30.32            -0.5       29.81        perf-profile.children.cycles-pp.evict
     30.34            -0.5       29.83        perf-profile.children.cycles-pp.__dentry_kill
     30.31            -0.5       29.80        perf-profile.children.cycles-pp.ext4_evict_inode
     30.35            -0.5       29.84        perf-profile.children.cycles-pp.dput
     30.36            -0.5       29.85        perf-profile.children.cycles-pp.__fput
     30.34            -0.5       29.83        perf-profile.children.cycles-pp.dentry_kill
     30.36            -0.5       29.86        perf-profile.children.cycles-pp.__x64_sys_close
     30.38            -0.5       29.87        perf-profile.children.cycles-pp.__close
     27.56            -0.5       27.07        perf-profile.children.cycles-pp.ext4_da_write_begin
     32.68            -0.5       32.20        perf-profile.children.cycles-pp.generic_perform_write
     33.67            -0.4       33.28        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     34.90            -0.3       34.61        perf-profile.children.cycles-pp.vfs_write
      0.95 ±  4%      -0.2        0.72 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.76            -0.2        0.54        perf-profile.children.cycles-pp.do_flush_stats
     97.02            -0.2       96.80        perf-profile.children.cycles-pp.do_syscall_64
      0.76            -0.2        0.54        perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.78            -0.2        0.56        perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.75            -0.2        0.54        perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.80            -0.2        0.59        perf-profile.children.cycles-pp.balance_dirty_pages
     97.31            -0.2       97.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.19            -0.2        1.02        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.56            -0.2        0.40        perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      1.00 ±  2%      -0.1        0.87 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.20            -0.1        1.14 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.29 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.33 ±  3%      -0.0        0.30        perf-profile.children.cycles-pp.charge_memcg
      0.40            -0.0        0.37        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.08 ±  9%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.cgroup_base_stat_flush
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.generic_file_read_iter
      0.12            +0.0        0.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.timestamp_truncate
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.try_charge_memcg
      0.14 ±  2%      +0.0        0.15        perf-profile.children.cycles-pp.up_write
      0.11            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.ext4_dirty_inode
      0.21 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.19            +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.19 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.26            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.25            +0.0        0.27        perf-profile.children.cycles-pp.inode_needs_update_time
      0.23 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.24            +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.56 ±  2%      +0.0        0.58        perf-profile.children.cycles-pp.workingset_age_nonresident
      0.12 ±  6%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.generic_update_time
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.filemap_get_entry
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__mmput
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      0.30            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.disk_rr
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.exit_mm
      0.38 ±  2%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38            +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.fault_in_readable
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.do_group_exit
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.do_exit
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.atime_needs_update
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.40            +0.0        0.42        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.41 ±  2%      +0.0        0.44        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.28            +0.0        0.32        perf-profile.children.cycles-pp.xas_store
      0.37 ±  2%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.ksys_lseek
      0.46            +0.0        0.50        perf-profile.children.cycles-pp.__alloc_pages
      0.42            +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.touch_atime
      0.20 ±  3%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.54            +0.0        0.58        perf-profile.children.cycles-pp.folio_alloc
      0.20 ±  2%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.ext4_file_write_iter
      1.12            +0.0        1.16        perf-profile.children.cycles-pp.__filemap_add_folio
      0.69            +0.0        0.73        perf-profile.children.cycles-pp.copyin
      0.42 ±  3%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.40 ±  2%      +0.0        0.44        perf-profile.children.cycles-pp.apparmor_file_permission
      0.46            +0.0        0.50        perf-profile.children.cycles-pp.file_modified
      0.62            +0.0        0.66        perf-profile.children.cycles-pp.xas_load
      0.32 ±  2%      +0.0        0.36 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.52            +0.0        0.56        perf-profile.children.cycles-pp.security_file_permission
      0.98            +0.0        1.03        perf-profile.children.cycles-pp.memset_orig
      0.98            +0.0        1.03        perf-profile.children.cycles-pp.zero_user_segments
      0.90            +0.1        0.95        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.59 ±  2%      +0.1        0.64 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.80            +0.1        0.85        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.77            +0.1        0.83        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.92            +0.1        0.99 ±  2%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.91            +0.1        0.98        perf-profile.children.cycles-pp.filemap_get_pages
      0.94            +0.1        1.01 ±  2%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.01            +0.1        1.08        perf-profile.children.cycles-pp.__entry_text_start
      1.64            +0.1        1.72        perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.63            +0.1        1.74        perf-profile.children.cycles-pp.copyout
      1.73            +0.1        1.84        perf-profile.children.cycles-pp._copy_to_iter
      1.82            +0.1        1.95        perf-profile.children.cycles-pp.copy_page_to_iter
      1.68            +0.1        1.81        perf-profile.children.cycles-pp.llseek
      2.75            +0.2        2.92        perf-profile.children.cycles-pp.ext4_block_write_begin
     30.38            +0.4       30.79        perf-profile.children.cycles-pp.read
     70.80            -1.7       69.14        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.81 ±  5%      -0.2        0.61 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.54            -0.2        0.39        perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.08 ±  9%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.cgroup_base_stat_flush
      0.19 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.19 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.18            +0.0        0.19        perf-profile.self.cycles-pp.__mod_node_page_state
      0.20            +0.0        0.21        perf-profile.self.cycles-pp.block_invalidate_folio
      0.23            +0.0        0.24        perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.17            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__fdget_pos
      0.26            +0.0        0.27        perf-profile.self.cycles-pp.generic_perform_write
      0.21 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.xas_load
      0.21            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.28            +0.0        0.30        perf-profile.self.cycles-pp.__filemap_get_folio
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.fault_in_readable
      0.24            +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.29            +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.read
      0.21            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.56 ±  2%      +0.0        0.58        perf-profile.self.cycles-pp.workingset_age_nonresident
      0.27            +0.0        0.29        perf-profile.self.cycles-pp.llseek
      0.27            +0.0        0.29        perf-profile.self.cycles-pp.__entry_text_start
      0.22 ±  2%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.31            +0.0        0.33        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.28 ±  2%      +0.0        0.31        perf-profile.self.cycles-pp.apparmor_file_permission
      0.46            +0.0        0.49        perf-profile.self.cycles-pp.vfs_read
      0.27 ±  3%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.40 ±  3%      +0.0        0.43 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.19 ±  3%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.19 ±  2%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.67            +0.0        0.72        perf-profile.self.cycles-pp.__block_commit_write
      0.55            +0.0        0.59        perf-profile.self.cycles-pp.vfs_write
      0.28 ±  2%      +0.0        0.32 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.68            +0.0        0.72        perf-profile.self.cycles-pp.copyin
      0.50            +0.0        0.54        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.98            +0.0        1.02        perf-profile.self.cycles-pp.memset_orig
      0.78            +0.0        0.82        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.64            +0.0        0.68        perf-profile.self.cycles-pp.filemap_read
      0.29 ±  5%      +0.0        0.34 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.try_charge_memcg
      1.61            +0.1        1.72        perf-profile.self.cycles-pp.copyout


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_cp/aim7

commit: 
  ff841a06c8 ("mm: memcg: refactor page state unit helpers")
  7bd5bc3ce9 ("mm: memcg: normalize the value passed into memcg_rstat_updated()")

ff841a06c844b055 7bd5bc3ce9632aefd0eed33a192 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.19 ±  5%      +9.1%       1.30 ±  3%  iostat.cpu.user
      1.25 ±  5%      +0.1        1.38 ±  4%  mpstat.cpu.all.usr%
     11.57 ± 62%     -65.1%       4.04 ± 65%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     39.78 ±  4%     +12.9       52.64 ±  9%  turbostat.PKG_%
    895233            +2.2%     915336        aim7.jobs-per-min
     48750 ±  7%     -21.3%      38348 ±  9%  aim7.time.involuntary_context_switches
      1176            -5.7%       1109        aim7.time.system_time
      8891 ± 32%     -78.2%       1936 ± 16%  sched_debug.cfs_rq:/.load.avg
    886484 ± 42%     -96.6%      30376 ± 20%  sched_debug.cfs_rq:/.load.max
     78636 ± 40%     -92.5%       5891 ± 12%  sched_debug.cfs_rq:/.load.stddev
      2.18 ±  2%      -4.5%       2.09        perf-stat.i.cpi
      0.54 ±  4%      +8.8%       0.59        perf-stat.i.ipc
      1.90            -4.3%       1.82 ±  2%  perf-stat.overall.MPKI
      1.75            -5.1%       1.66        perf-stat.overall.cpi
      0.57            +5.4%       0.60        perf-stat.overall.ipc
     62989 ± 18%     -38.7%      38627 ± 33%  numa-vmstat.node0.nr_anon_pages
     63952 ± 18%     -38.0%      39673 ± 32%  numa-vmstat.node0.nr_inactive_anon
     63952 ± 18%     -38.0%      39673 ± 32%  numa-vmstat.node0.nr_zone_inactive_anon
     64470 ± 18%     +39.2%      89730 ± 14%  numa-vmstat.node1.nr_anon_pages
     66787 ± 17%     +36.8%      91333 ± 14%  numa-vmstat.node1.nr_inactive_anon
     11264 ±  5%    +216.1%      35608 ± 48%  numa-vmstat.node1.nr_kernel_stack
    834.42 ± 17%   +2010.2%      17608 ± 67%  numa-vmstat.node1.nr_page_table_pages
     66787 ± 17%     +36.8%      91333 ± 14%  numa-vmstat.node1.nr_zone_inactive_anon
    251945 ± 18%     -38.7%     154531 ± 33%  numa-meminfo.node0.AnonPages
    305057 ± 15%     -28.9%     216862 ± 22%  numa-meminfo.node0.AnonPages.max
     14698 ±  9%     -13.9%      12660 ±  7%  numa-meminfo.node0.Dirty
    271685 ± 17%     -36.2%     173249 ± 29%  numa-meminfo.node0.Inactive
    255806 ± 18%     -38.0%     158709 ± 32%  numa-meminfo.node0.Inactive(anon)
    291694 ± 10%     -25.8%     216523 ± 19%  numa-meminfo.node0.Slab
    257857 ± 18%     +39.2%     358935 ± 14%  numa-meminfo.node1.AnonPages
    282059 ± 16%     +34.8%     380109 ± 13%  numa-meminfo.node1.Inactive
    267122 ± 17%     +36.8%     365352 ± 14%  numa-meminfo.node1.Inactive(anon)
     11264 ±  5%    +216.2%      35619 ± 48%  numa-meminfo.node1.KernelStack
      3337 ± 17%   +2011.4%      70463 ± 67%  numa-meminfo.node1.PageTables
     24.42            -2.3       22.14 ±  2%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     21.77            -2.2       19.59 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
     21.80            -2.2       19.62 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
     21.81            -2.2       19.64 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
     23.12            -2.2       20.96        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
     28.82            -2.0       26.78        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dentry_kill
     29.06            -2.0       27.04        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
     29.03            -2.0       27.01        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dentry_kill.dput
     29.08            -2.0       27.06        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.__x64_sys_close
     29.08            -2.0       27.06        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     29.09            -2.0       27.07        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.14            -2.0       27.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     29.14            -2.0       27.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     29.14            -2.0       27.12        perf-profile.calltrace.cycles-pp.__close
     29.12            -2.0       27.11        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     29.11            -2.0       27.09        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     20.28            -1.3       18.93        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
     23.94            -1.3       22.60        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     20.23            -1.3       18.89        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     20.26            -1.3       18.92        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
     21.38            -1.3       20.05        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     21.29            -1.3       19.96        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
     26.64            -1.2       25.46        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     33.56            -0.7       32.84        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.80            -0.2        0.61        perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.79            -0.2        0.61        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.83            -0.2        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.78            -0.2        0.61 ±  2%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      0.88            -0.2        0.71 ±  2%  perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      1.24 ±  2%      -0.1        1.12 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.24 ±  2%      -0.1        1.12 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      1.24 ±  2%      -0.1        1.12 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      1.26            -0.1        1.15 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      1.26 ±  2%      -0.1        1.14 ±  2%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      1.88            -0.1        1.80        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.74 ±  3%      -0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.92            -0.1        0.87        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.84 ±  2%      -0.1        0.79        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write
      0.72 ±  2%      -0.0        0.68        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_cleaned.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio
      1.40            +0.0        1.44        perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      0.52 ±  2%      +0.0        0.55        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.15            +0.0        1.19        perf-profile.calltrace.cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.80            +0.0        0.85        perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.86            +0.0        0.91 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      0.83            +0.1        0.88        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.80            +0.1        0.86        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.73            +0.1        1.79        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end
      0.73 ±  3%      +0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_read
      1.04            +0.1        1.10        perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.82 ±  3%      +0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.78 ±  3%      +0.1        0.84 ±  2%  perf-profile.calltrace.cycles-pp.ext4_file_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.21            +0.1        1.28        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.40            +0.1        1.48        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.25            +0.1        2.34        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      2.21            +0.1        2.30        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      1.74 ±  2%      +0.1        1.84        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
      1.13 ±  3%      +0.1        1.24 ±  2%  perf-profile.calltrace.cycles-pp.file_modified.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      1.82            +0.1        1.93        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.01 ±  2%      +0.1        2.13        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      2.38            +0.1        2.52        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      2.44            +0.1        2.58        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2.22 ±  2%      +0.1        2.36        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.98 ±  3%      +0.1        2.13 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      2.03 ±  3%      +0.2        2.18 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3.12            +0.2        3.28        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      3.92            +0.2        4.10        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      4.12            +0.2        4.32        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.34 ± 70%      +0.2        0.55 ±  2%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_modified.ext4_buffered_write_iter.vfs_write.ksys_write
      4.84            +0.2        5.08        perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      6.05            +0.4        6.40        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.68            +0.4        1.09 ± 22%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.08 ±223%      +0.4        0.53 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_reserve_space.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.68            +0.6        1.23 ±  2%  perf-profile.calltrace.cycles-pp.__entry_text_start.read
      8.05 ±  4%      +0.8        8.84 ±  4%  perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.85 ±  3%      +1.0       11.87 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     11.49 ±  3%      +1.1       12.55 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     12.03 ±  2%      +1.1       13.12 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     12.29 ±  2%      +1.1       13.40 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     13.83 ±  2%      +1.2       15.02 ±  2%  perf-profile.calltrace.cycles-pp.read
     43.88            -3.7       40.20        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     43.63            -3.7       39.96 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     43.54            -3.6       39.91 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     24.42            -2.3       22.14 ±  2%  perf-profile.children.cycles-pp.__folio_batch_release
     23.44            -2.2       21.28        perf-profile.children.cycles-pp.release_pages
     28.83            -2.0       26.79        perf-profile.children.cycles-pp.truncate_inode_pages_range
     29.06            -2.0       27.04        perf-profile.children.cycles-pp.evict
     29.03            -2.0       27.01        perf-profile.children.cycles-pp.ext4_evict_inode
     29.08            -2.0       27.06        perf-profile.children.cycles-pp.__dentry_kill
     29.08            -2.0       27.06        perf-profile.children.cycles-pp.dentry_kill
     29.10            -2.0       27.08        perf-profile.children.cycles-pp.dput
     29.14            -2.0       27.12        perf-profile.children.cycles-pp.__close
     29.12            -2.0       27.11        perf-profile.children.cycles-pp.__x64_sys_close
     29.11            -2.0       27.09        perf-profile.children.cycles-pp.__fput
     22.60            -1.5       21.15        perf-profile.children.cycles-pp.folio_batch_move_lru
     23.95            -1.3       22.61        perf-profile.children.cycles-pp.filemap_add_folio
     21.41            -1.3       20.07        perf-profile.children.cycles-pp.folio_add_lru
     26.72            -1.2       25.56        perf-profile.children.cycles-pp.__filemap_get_folio
     33.65            -0.7       32.94        perf-profile.children.cycles-pp.ext4_da_write_begin
      1.79 ±  3%      -0.4        1.42 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      1.78 ±  2%      -0.2        1.58        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.80            -0.2        0.61 ±  2%  perf-profile.children.cycles-pp.do_flush_stats
      0.79            -0.2        0.61        perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.78            -0.2        0.61        perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.83            -0.2        0.66 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.88            -0.2        0.71 ±  2%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.59            -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      1.29 ±  2%      -0.1        1.17 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      2.65            -0.1        2.56        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.58 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      1.96            -0.1        1.88        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.76 ±  3%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.charge_memcg
      0.94 ±  2%      -0.1        0.88        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.bdev_getblk
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.29 ±  2%      +0.0        0.31        perf-profile.children.cycles-pp.up_write
      0.09 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.generic_write_checks
      0.19 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.11 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.aa_file_perm
      0.29            +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.47 ±  2%      +0.0        0.49        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.28 ±  3%      +0.0        0.30        perf-profile.children.cycles-pp.__slab_free
      0.21 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.38 ±  2%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.30 ±  2%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.disk_cp
      0.58            +0.0        0.61 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.42            +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      0.55 ±  2%      +0.0        0.59 ±  3%  perf-profile.children.cycles-pp.xas_descend
      0.26 ±  7%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.ext4_dirty_inode
      1.42            +0.0        1.46        perf-profile.children.cycles-pp.folio_account_dirtied
      1.16            +0.0        1.20        perf-profile.children.cycles-pp.folio_create_empty_buffers
      0.58            +0.0        0.62 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.75            +0.0        0.79 ±  2%  perf-profile.children.cycles-pp.fault_in_readable
      0.51 ±  3%      +0.0        0.55 ±  2%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.82            +0.0        0.86        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.88            +0.0        0.92 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.56 ±  2%      +0.0        0.61 ±  2%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.29 ±  3%      +0.0        0.34 ±  7%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.86            +0.1        0.92 ±  2%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      1.04            +0.1        1.10        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.72            +0.1        0.77 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      1.75            +0.1        1.80        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.32 ±  7%      +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.generic_update_time
      0.84            +0.1        0.90        perf-profile.children.cycles-pp.filemap_get_entry
      0.78 ±  3%      +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.atime_needs_update
      0.43 ±  6%      +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.__mark_inode_dirty
      1.06            +0.1        1.12        perf-profile.children.cycles-pp.__alloc_pages
      0.79 ±  3%      +0.1        0.86        perf-profile.children.cycles-pp.ext4_file_read_iter
      1.22            +0.1        1.29        perf-profile.children.cycles-pp.folio_alloc
      0.84 ±  3%      +0.1        0.91 ±  2%  perf-profile.children.cycles-pp.touch_atime
      0.89 ±  2%      +0.1        0.96 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      1.24            +0.1        1.32        perf-profile.children.cycles-pp.xas_load
      2.28            +0.1        2.37        perf-profile.children.cycles-pp.mark_buffer_dirty
      1.49            +0.1        1.58        perf-profile.children.cycles-pp.copyin
      1.13 ±  2%      +0.1        1.22 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      2.23            +0.1        2.32        perf-profile.children.cycles-pp.try_to_free_buffers
      1.84 ±  2%      +0.1        1.94        perf-profile.children.cycles-pp.copyout
      1.37            +0.1        1.47        perf-profile.children.cycles-pp.__entry_text_start
      1.17 ±  3%      +0.1        1.28 ±  2%  perf-profile.children.cycles-pp.file_modified
      1.92            +0.1        2.04        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      2.04 ±  2%      +0.1        2.16        perf-profile.children.cycles-pp._copy_to_iter
      2.45            +0.1        2.58        perf-profile.children.cycles-pp.memset_orig
      2.45            +0.1        2.58        perf-profile.children.cycles-pp.zero_user_segments
      2.25 ±  2%      +0.1        2.39        perf-profile.children.cycles-pp.copy_page_to_iter
      2.04 ±  3%      +0.2        2.19 ±  2%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.86 ±  3%      +0.2        1.01 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      2.00 ±  3%      +0.2        2.16 ±  2%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      3.13            +0.2        3.28        perf-profile.children.cycles-pp.truncate_cleanup_folio
      3.95            +0.2        4.14        perf-profile.children.cycles-pp.__block_commit_write
      4.17            +0.2        4.37        perf-profile.children.cycles-pp.block_write_end
      4.89            +0.2        5.14        perf-profile.children.cycles-pp.ext4_da_do_write_end
      6.08            +0.3        6.43        perf-profile.children.cycles-pp.ext4_block_write_begin
      8.12 ±  4%      +0.8        8.92 ±  4%  perf-profile.children.cycles-pp.filemap_read
     10.92 ±  3%      +1.0       11.96 ±  3%  perf-profile.children.cycles-pp.vfs_read
     11.55 ±  3%      +1.1       12.61 ±  3%  perf-profile.children.cycles-pp.ksys_read
     14.32 ±  2%      +1.2       15.55 ±  2%  perf-profile.children.cycles-pp.read
     43.63            -3.7       39.96 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.56 ±  4%      -0.3        1.24 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.57            -0.1        0.44 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.10            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.22 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.drop_buffers
      0.20            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.folio_create_empty_buffers
      0.34 ±  2%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.block_invalidate_folio
      0.23 ±  2%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__fdget_pos
      0.28            +0.0        0.29        perf-profile.self.cycles-pp.folio_unlock
      0.09 ±  5%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.try_charge_memcg
      0.20 ±  5%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.28 ±  3%      +0.0        0.30        perf-profile.self.cycles-pp.__slab_free
      0.31 ±  2%      +0.0        0.33 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.37 ±  2%      +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.44            +0.0        0.47 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.29 ±  2%      +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.36            +0.0        0.39 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.42            +0.0        0.46 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.42            +0.0        0.45 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.54            +0.0        0.57 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      0.42 ±  2%      +0.0        0.46 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.47 ±  2%      +0.0        0.51        perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.47 ±  2%      +0.0        0.51 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.72            +0.0        0.77 ±  2%  perf-profile.self.cycles-pp.fault_in_readable
      0.56            +0.0        0.60 ±  2%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.28 ±  2%      +0.0        0.32 ±  7%  perf-profile.self.cycles-pp.ext4_nonda_switch
      1.01            +0.0        1.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.40            +0.0        0.44 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.40 ±  4%      +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.atime_needs_update
      0.63 ±  3%      +0.1        0.68 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.56 ±  2%      +0.1        0.62 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.50 ±  6%      +0.1        0.56 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.77 ±  3%      +0.1        0.83 ±  2%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.92            +0.1        0.99 ±  2%  perf-profile.self.cycles-pp.vfs_read
      1.46            +0.1        1.54        perf-profile.self.cycles-pp.copyin
      1.53            +0.1        1.62        perf-profile.self.cycles-pp.__block_commit_write
      1.81 ±  2%      +0.1        1.90        perf-profile.self.cycles-pp.copyout
      2.42            +0.1        2.56        perf-profile.self.cycles-pp.memset_orig
      0.78 ±  2%      +0.1        0.91 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      1.31 ±  2%      +0.1        1.45        perf-profile.self.cycles-pp.vfs_write
      1.73 ±  4%      +0.2        1.90 ±  5%  perf-profile.self.cycles-pp.filemap_read





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


