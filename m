Return-Path: <cgroups+bounces-1687-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7B859715
	for <lists+cgroups@lfdr.de>; Sun, 18 Feb 2024 14:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76231C20A81
	for <lists+cgroups@lfdr.de>; Sun, 18 Feb 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473356BB5E;
	Sun, 18 Feb 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5LToUTP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4506BB57;
	Sun, 18 Feb 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708262207; cv=fail; b=bI41Xvg95oXGxzZfni68kZGvBCj5o4A0/C3EP64u0x7GNCGAa+uMrUgZJTuWJcrBTBzYSBe2JwXUiB1oryzZ2chHcTpAxNexe1r0CV27plbl1izAY10F1yb5ID4QNP/nOyrl3I6zVhmRRWNBZcG3TCg65M7mBxs9gLLygDFEwp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708262207; c=relaxed/simple;
	bh=+DnGLO5I/DZ21pKgq97mQmCCNKJMvLsYUSwKBu88b2E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=T4CZDbBmM6QChSTMA5COcoy5rinzVvb6seJEpyvlzXGyMjR2fzqsP7JjLvX5icloSONZDOivMOwuus4TJonayg7QCicIuND6g5L5fpd5hZkJ7jTrxiAleSThmQfdrn9Pxvkls4RoeQzAWl51s/WlQVL3gXkRaG5wmg1yyw1ZxtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5LToUTP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708262202; x=1739798202;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=+DnGLO5I/DZ21pKgq97mQmCCNKJMvLsYUSwKBu88b2E=;
  b=O5LToUTPsndXxQvfn0vmu735RbtZu1QJEPVKdVx4ujuhMFYOBHwKfdOu
   AjfI9JS5mTAbhxsKmemfKpwCsEamJ+VJZlJap1H07lG9or/4nkrjDDx1r
   XhdiM/J3lx1tZJYV9yjzGIQh3G5uzNH3DVhwVgkSlalB88aAVRSRH3gWw
   lbFHbIw5HN6JV2SuhbfkdAWLahjeBoF4vG7hnXllSkAn0P2+mp3EFsp+V
   Z/Nzpf2T/F5VgShIr17V2G07Oh4Fox5U1sL/R8xUP5JoLId2WeZpZuJjU
   gR9xaaN/MwlXJ/7wD/Kg17aAQpCENZ2MTd+xTD2sBBoIU1a5DnMA2H/Q6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2209574"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2209574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 05:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="8877666"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 05:16:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:16:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:16:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 05:16:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 05:16:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVDIJVIjVMqeIgpwJygomT/XvrRAtaTLl6IrKylUQmav8We+ke2uxUM0X/nQdRUk9hd6P9gKM9SZPQaeKgI6FttaC7ltrJ3MQjJX4axqWwFGZNdcn8SzyEYnq+RdFxvX63VmlO5VP9+n6JLAN1vOGwQDV8EsgpMp240NVBXKEaeHFqXwv91zixdK3NSsIK7VFg0eLEDJcIIiZjeSdEu0x0PnSSa5YAQmVU3EyJs6D792LKCt63fL96CFwN/Twq0iSrWyHr2bDx7DZzHBH14hTxXgX0o5XjW9iRtvO1Nc9DbNHDboPFy5WJkWAdTDufUA9ui/6SBH3s4oMY+wJhw9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rjojwUpkP9bgSfX682IzBPxapSpIsEZx2CUGqnBsY8=;
 b=bXWqv+W5fmlbsOsJF1z+IUYsdwyytn+SADF1iUA9xlCnuq2NNw6h1529DKzvYna5zKMDiDUIts7cuHJP9yBtnr7c2QJ7W4+uThjTComxy+1KdhUHBTD6RR8lAWKIkj8zTop1qJkEavWkT9io5QcSaxC2RXPu9OrywImB/h8T7zvhfQiEyAzvtFHpmXrOwzmFeG1Spu5l02384WC3fMjLSxCshNUB7no/nuomKj6ywLqkoDTeCHsIdf1Bc4OJgU692a13yl+dfWUp9Dx414jfSZTZSGqcx2zB77WoOj0w8zLfXXbGDHMtnCPMTmtecHSrHB+jPmBZ7bcLgPk4AlTZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 13:16:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 13:16:35 +0000
Date: Sun, 18 Feb 2024 21:16:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel test robot
	<oliver.sang@intel.com>, Shakeel Butt <shakeelb@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, "Greg
 Thelen" <gthelen@google.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>
Subject: [linus:master] [mm]  9cee7e8ef3:  netperf.Throughput_Mbps 4.0%
 improvement
Message-ID: <202402182000.f21279e1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 362b7cd0-3328-4cf7-d2a6-08dc3083d483
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u05CTDcYMAsHA/HdhR69FFqBO0/1ePxyVCqkbQryKIYSEvqKmykgvsrjIB9R0Zy4ytjw/cVpINKp59j5a7KBZ05QxNUJLkm8KzdK/svaDODCfdq20dotRUtj+7pyAAza/d/ebAPKE79XlvlIZia0+pczXqYBSnXMSUZ1yixzHqYg4upU5URkx6Pg8OpbKePatpFQBbN4OuIn65/vhbLZKpsJBo7Tu9GFj4L7NJQSuUj5ujiHzR1pJAefrS+SWergGnQ3XmtfHBK+wUgxBLgx9cW5/6hJ6UgHA1yk+4htN6LLzGgQ+1S164g/mGEe6lzxRp5fgSPaFUbQnh732+UpQl4BjEcxujwV6WleYAU7id310AbmU21zOe7dNVk3IRcEE6fDtCfJ5qvIK6yiSHLOj4plUNnFAD9NhQ/9hyEPyfqXWmbVtHgvItj38KP/HoDi+NMapz1skmIL0k36UYMK2/pDIf1mmGh/0Lldk1hQ93PiulqjMWRzDaY/SjbHmmUIh711QUz5tkpxuLMA6+7519bj4dpuQx04zyb5mjVhOlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(230473577357003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(83380400001)(82960400001)(66946007)(66476007)(8936002)(8676002)(4326008)(6916009)(66556008)(2906002)(30864003)(7416002)(5660300002)(26005)(107886003)(1076003)(19627235002)(6666004)(2616005)(41300700001)(316002)(54906003)(6512007)(966005)(6506007)(6486002)(478600001)(86362001)(36756003)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zuDEHYcoApfZNYvQz1K8B8N2B5OmIVelQxLB3p0C68if/Y41hmjaeHiC1h?=
 =?iso-8859-1?Q?fdXMTpWl+GYoIg/uGBssbcM4gdj3cs4d6ytptrQdVt46rllpYJ7Rukf+ak?=
 =?iso-8859-1?Q?9dfDsMvECldy5YV9k9wNRrANySfoZtD9LuzdlFgCeul1QHiJuUxLpCeQ8/?=
 =?iso-8859-1?Q?j7cbakw95G1wonUuNjqaUqg2d1cidk3tMbLTevL7ZZ8cHwKjlDBmDSLZ+u?=
 =?iso-8859-1?Q?wCttCNkO2Hq76YMW9d+FbE1mfbQOUb+uAh1PXpySgDQolvWcEav95DHoDc?=
 =?iso-8859-1?Q?Ty14ykZA2ZBWEsj8x0ZDLo/jpkqjmfjU0sIhkmUx9t4EP64kcEHrkwUzik?=
 =?iso-8859-1?Q?6dw8WScR5SYO4Fyhy0zFvUap8pajZmROPgsq+QM3mqKs3kYcqUdllTa6E5?=
 =?iso-8859-1?Q?FDkpBh9NuxPjImxjFq4kbveHj4Tgk1WbEAS1o2ZF3eHLng/Q6OwBgcrQbF?=
 =?iso-8859-1?Q?v4xi+yrBO3wjQ1gtIqevmzvzJFCjpzzg16NAxXdONCG8kYcsMVXjylhmHh?=
 =?iso-8859-1?Q?3ATGLiD4hWXK7yth8x2nrxzDhlHDed0Pw7nRP9+qH4FpFpXBdY0Z5I8MlH?=
 =?iso-8859-1?Q?n1eUu+P6Tm9FsZEefPlKNPpajVff0pQX26189eCcM9FLGkjega4LxW1c2A?=
 =?iso-8859-1?Q?DkDQ9QIacGLZWZYlqKXPk5D5B/PFI5BcKkX8MFMAl+aDFxRWlB34PBpsmK?=
 =?iso-8859-1?Q?mo+BAFNlSj2WlMz638gN8cE8dylB1udp1XuZOuqJaNm9yiwPtoYNEUkBSt?=
 =?iso-8859-1?Q?JL2medLIBSzlYbpzzX4ENumAx3hjm4i93cqD39jVXuT33K0AyAAgOuHZFa?=
 =?iso-8859-1?Q?7R66v1u9ndxodA75y+4+kpwx141oW/5voQZaaeCGsLKj0tJPVfo7KPh09/?=
 =?iso-8859-1?Q?hS9SMlaPrvZyS0mwBFlvmlqzU35444OBDef57zT5NI9kLtGly49X+HIFbi?=
 =?iso-8859-1?Q?OEkX+iQbT+1a7i8ExIvetGutln+aZrMttJFRw9PgTaDU6SL7x3o3+qQ041?=
 =?iso-8859-1?Q?Jciwth/xCIKqrhLl31N/6Vg6sy6f39yshJsOyiauV5385w0tdxXV0WJ2sh?=
 =?iso-8859-1?Q?SyJ26EP11pvZlwWIJZye4zWx8XemzYN+G9cB+wwiMwjb7L1aEzoYRACqUK?=
 =?iso-8859-1?Q?mLxcmL2W1sse4kTggkmAQgc18AznQxBu0yMEy/UBayrNAQLNGoM1+goerL?=
 =?iso-8859-1?Q?I/yxPl4/vP2tmydPGTBbR6TFuQrzHjCFmoF9H+y3buo3KiZWcS+HdQUoo0?=
 =?iso-8859-1?Q?O9+/7DSOkCNSRVPYbJrcmAGkckV5B2nmc2T63QTA21lPQX9opxC+PRc+/1?=
 =?iso-8859-1?Q?oEE0ETx1M07KkGLVXL9FxPyLC1wCR6moSfdZW0Z4o1CNOPsc57rgVpOCMe?=
 =?iso-8859-1?Q?yTGSKiFv3PyTLXsBzUByw/txocGjdeb1O1CAqJGLRmu61NVAsytg0wF8dJ?=
 =?iso-8859-1?Q?q3mqQzDsljePSOcEMSkBHQt8g/a0Ts/fhVSVI7BPTLc81llDe7CIjl2CTc?=
 =?iso-8859-1?Q?iXWmzaUoWBFUjpzB4HIj9/9cGFlVxamGROdT2A2ALa2z047SHFgBGr+HFZ?=
 =?iso-8859-1?Q?eoa06szjZt2PqsChAMWZVw1B9oZp2AxsyJMsMRzdZaQwnWEwo+UjqeyWH9?=
 =?iso-8859-1?Q?HiD4mCnBVDDg8ZUCbBRgsqirEvPGpyVpyhMu7lqKxj2RMMgLUb3ON7+g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 362b7cd0-3328-4cf7-d2a6-08dc3083d483
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 13:16:35.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2HnovTAB6jgKat/VpUoTM2wG20w5XRo52hVGSwcVXoToK5nb7KnScASFXPAK/kej0/hxUrbGGTVd/4zYf4iRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com



hi, Yosry Ahmed,

we shared the performance impact of this commit in
https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/

now we noticed the commit is merged in mainline, and we observed improvements
in other performance tests such like netperf and stress-ng.
the vm-scalability and will-it-scale results are also included FYI.


Hello,

kernel test robot noticed a 4.0% improvement of netperf.Throughput_Mbps on:


commit: 9cee7e8ef3e31ca25b40ca52b8585dc6935deff2 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	send_size: 10K
	test: TCP_SENDFILE
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.metamix.ops_per_sec 4.1% improvement                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs=xfs                                                                                             |
|                  | nr_threads=10%                                                                                     |
|                  | test=metamix                                                                                       |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 42.0% improvement                                        |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | runtime=300s                                                                                       |
|                  | size=128G                                                                                          |
|                  | test=truncate                                                                                      |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 54.9% improvement                                      |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=50%                                                                                        |
|                  | test=fallocate1                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240218/202402182000.f21279e1-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-11.1-x86_64-20220510.cgz/300s/10K/lkp-icl-2sp2/TCP_SENDFILE/netperf

commit: 
  67b8bcbaed ("nilfs2: fix data corruption in dsync block recovery for small block sizes")
  9cee7e8ef3 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")

67b8bcbaed477787 9cee7e8ef3e31ca25b40ca52b85 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    140392 ±  5%      +9.2%     153362 ±  4%  meminfo.DirectMap4k
    772.17 ±  2%     -19.0%     625.33 ±  4%  perf-c2c.DRAM.remote
    894.17 ±  3%     -19.1%     723.17 ±  4%  perf-c2c.HITM.local
    -12.69           +55.8%     -19.78        sched_debug.cpu.nr_uninterruptible.min
      4.96 ±  8%     +16.3%       5.77 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
      0.94 ±  2%      -0.0        0.90        turbostat.C1%
     34.22            -4.4%      32.70 ±  2%  turbostat.RAMWatt
      4939           +17.1%       5785 ±  6%  perf-sched.total_wait_time.max.ms
      1511 ± 32%     -66.8%     502.34 ± 99%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4725 ±  7%     +36.7%       6459 ± 25%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1506 ± 32%     -66.6%     502.68 ± 99%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4725 ±  7%     +22.1%       5771 ±  6%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9040            +4.0%       9402        netperf.ThroughputBoth_Mbps
   2314243            +4.0%    2406983        netperf.ThroughputBoth_total_Mbps
      9040            +4.0%       9402        netperf.Throughput_Mbps
   2314243            +4.0%    2406983        netperf.Throughput_total_Mbps
      1056            +3.9%       1098        netperf.time.user_time
  15571304            +5.9%   16491497        netperf.time.voluntary_context_switches
 8.475e+09            +4.0%  8.815e+09        netperf.workload
      0.65 ±  2%     -33.0%       0.44 ±  7%  perf-stat.i.MPKI
 4.977e+10            +3.2%  5.138e+10        perf-stat.i.branch-instructions
      0.71            -0.0        0.68        perf-stat.i.branch-miss-rate%
     20.77 ±  2%      -3.3       17.49 ±  6%  perf-stat.i.cache-miss-rate%
 1.708e+08 ±  2%     -30.9%  1.181e+08 ±  6%  perf-stat.i.cache-misses
 8.234e+08           -17.7%  6.776e+08        perf-stat.i.cache-references
      1.25            -3.1%       1.21        perf-stat.i.cpi
      1908 ±  2%     +45.7%       2779 ±  7%  perf-stat.i.cycles-between-cache-misses
 7.258e+10            +3.1%  7.482e+10        perf-stat.i.dTLB-loads
 4.018e+10            +3.2%  4.145e+10        perf-stat.i.dTLB-stores
 2.608e+11            +3.2%  2.692e+11        perf-stat.i.instructions
      0.80            +3.2%       0.83        perf-stat.i.ipc
      1276            +3.0%       1315        perf-stat.i.metric.M/sec
  15636176 ±  2%     -19.5%   12582173 ±  5%  perf-stat.i.node-load-misses
    951084 ±  7%     -39.3%     577496 ± 14%  perf-stat.i.node-loads
     48.91 ±  2%      +5.6       54.54 ±  2%  perf-stat.i.node-store-miss-rate%
      0.66 ±  2%     -33.0%       0.44 ±  7%  perf-stat.overall.MPKI
      0.70            -0.0        0.68        perf-stat.overall.branch-miss-rate%
     20.75 ±  2%      -3.3       17.43 ±  6%  perf-stat.overall.cache-miss-rate%
      1.25            -3.1%       1.21        perf-stat.overall.cpi
      1903 ±  2%     +45.3%       2766 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.80            +3.2%       0.83        perf-stat.overall.ipc
     47.72 ±  3%      +5.6       53.30 ±  3%  perf-stat.overall.node-store-miss-rate%
 4.961e+10            +3.2%  5.122e+10        perf-stat.ps.branch-instructions
 1.703e+08 ±  2%     -30.9%  1.177e+08 ±  6%  perf-stat.ps.cache-misses
 8.207e+08           -17.7%  6.754e+08        perf-stat.ps.cache-references
 7.233e+10            +3.1%  7.457e+10        perf-stat.ps.dTLB-loads
 4.005e+10            +3.2%  4.131e+10        perf-stat.ps.dTLB-stores
   2.6e+11            +3.2%  2.683e+11        perf-stat.ps.instructions
  15585093 ±  2%     -19.5%   12543422 ±  5%  perf-stat.ps.node-load-misses
    947879 ±  7%     -39.3%     575590 ± 14%  perf-stat.ps.node-loads
 7.848e+13            +3.1%  8.093e+13        perf-stat.total.instructions
      3.80 ±  3%      -2.1        1.71 ±  5%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule
      6.27            -2.0        4.24 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked
     46.14            -1.5       44.60        perf-profile.calltrace.cycles-pp.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct
     44.24            -1.5       42.75        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor
     11.92            -1.5       10.44        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg
     12.15            -1.5       10.68        perf-profile.calltrace.cycles-pp.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
     12.02            -1.5       10.56        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     50.08            -1.3       48.81        perf-profile.calltrace.cycles-pp.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
     50.52            -1.3       49.26        perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     39.04            -1.2       37.88        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
     60.56            -0.8       59.77        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
     60.81            -0.8       60.02        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84            -0.7        3.14        perf-profile.calltrace.cycles-pp.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      3.72 ±  5%      -0.6        3.11        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
     64.97            -0.6       64.37        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
     11.66            -0.5       11.15        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     11.61            -0.5       11.10        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     10.02            -0.5        9.52        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     11.34            -0.5       10.85        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      9.51            -0.5        9.02        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     12.61            -0.5       12.12        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     13.00            -0.5       12.53        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     13.06            -0.5       12.60        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     14.22            -0.5       13.76        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     14.11            -0.5       13.65        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     13.30            -0.4       12.86        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     13.96            -0.4       13.52        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      1.88            -0.4        1.49        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      3.45 ±  5%      -0.4        3.09        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established
      6.74            -0.3        6.39        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      3.53            -0.3        3.18 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket
      4.11            -0.3        3.78 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      4.51 ±  2%      -0.3        4.21        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      2.43 ±  3%      -0.3        2.15        perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue
     12.72            -0.3       12.46        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      2.28            -0.2        2.04 ±  2%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      2.32            -0.2        2.08 ±  2%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      3.50 ±  2%      -0.2        3.32        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      3.22 ±  2%      -0.2        3.03        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      1.01            -0.2        0.83        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.84            -0.2        0.67        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      4.10            -0.2        3.94        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      1.91 ±  2%      -0.2        1.76 ±  3%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.85            -0.2        1.70 ±  2%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      3.84            -0.2        3.69        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      1.92 ±  2%      -0.2        1.77 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      3.59            -0.2        3.44        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
      3.48            -0.1        3.34        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      1.72 ±  2%      -0.1        1.58 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      1.58 ±  2%      -0.1        1.45 ±  3%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      0.55            -0.1        0.43 ± 44%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_sync_key.sock_def_readable
      1.83            -0.1        1.71        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      0.58            -0.0        0.55        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      0.55            -0.0        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59            -0.0        0.57        perf-profile.calltrace.cycles-pp.lock_sock_nested.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      0.64            +0.0        0.68        perf-profile.calltrace.cycles-pp.tcp_event_new_data_sent.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.78            +0.0        0.81        perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      1.11            +0.0        1.14        perf-profile.calltrace.cycles-pp.tcp_send_mss.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      0.67            +0.0        0.70        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.82            +0.0        0.85        perf-profile.calltrace.cycles-pp.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      0.66            +0.0        0.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.sendfile.sendfile_tcp_stream.main.__libc_start_main
      0.94            +0.0        0.98        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.52            +0.0        0.56        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      1.11            +0.0        1.16        perf-profile.calltrace.cycles-pp.rw_verify_area.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.70            +0.0        0.74        perf-profile.calltrace.cycles-pp.iov_iter_advance.iov_iter_extract_pages.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg
      0.95 ±  2%      +0.0        1.00 ±  2%  perf-profile.calltrace.cycles-pp.page_cache_pipe_buf_release.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct
      0.58            +0.1        0.64        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_splice_read.splice_direct_to_actor.do_splice_direct
      1.21            +0.1        1.28        perf-profile.calltrace.cycles-pp.__fsnotify_parent.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56            +0.1        0.62        perf-profile.calltrace.cycles-pp.netperf_sendfile.sendfile_tcp_stream.main.__libc_start_main
      0.68            +0.1        0.75        perf-profile.calltrace.cycles-pp.touch_atime.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      1.16            +0.1        1.24        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.filemap_splice_read.splice_direct_to_actor.do_splice_direct
      1.62            +0.1        1.70        perf-profile.calltrace.cycles-pp.splice_folio_into_pipe.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      1.57            +0.1        1.66        perf-profile.calltrace.cycles-pp.skb_append_pagefrags.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.46            +0.1        1.54        perf-profile.calltrace.cycles-pp.__folio_batch_release.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      2.42            +0.1        2.53        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_splice_read.splice_direct_to_actor.do_splice_direct
      1.83            +0.1        1.95        perf-profile.calltrace.cycles-pp.iov_iter_extract_pages.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      2.06            +0.1        2.19        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.72 ± 14%      +0.1        0.85        perf-profile.calltrace.cycles-pp.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.62 ± 12%      +0.1        0.75 ±  4%  perf-profile.calltrace.cycles-pp.drain_stock.refill_stock.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg
      2.76            +0.1        2.89        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.76 ± 14%      +0.1        0.90        perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.74 ± 13%      +0.1        0.88 ±  3%  perf-profile.calltrace.cycles-pp.refill_stock.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.66 ± 13%      +0.1        0.80 ±  3%  perf-profile.calltrace.cycles-pp.refill_stock.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
     24.66            +0.2       24.83        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     24.30            +0.2       24.47        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     24.76            +0.2       24.94        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     24.90            +0.2       25.07        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.86            +0.2       26.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.process_requests.spawn_child.accept_connection
      1.60 ± 11%      +0.2        1.78        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
     25.82            +0.2       26.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.process_requests.spawn_child
      1.01 ± 16%      +0.2        1.20        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
     26.12            +0.2       26.30        perf-profile.calltrace.cycles-pp.recv.process_requests.spawn_child.accept_connection.accept_connections
      0.35 ± 70%      +0.2        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter
     25.41            +0.2       25.61        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.process_requests
     25.36            +0.2       25.56        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.52 ± 46%      +0.2        0.73 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_stock.refill_stock.__sk_mem_reduce_allocated.tcp_clean_rtx_queue
      0.52 ± 45%      +0.2        0.74 ±  4%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_stock.refill_stock.__sk_mem_reduce_allocated.tcp_recvmsg_locked
      0.52 ± 46%      +0.2        0.74 ±  4%  perf-profile.calltrace.cycles-pp.drain_stock.refill_stock.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack
      5.10            +0.3        5.40        perf-profile.calltrace.cycles-pp.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
     10.48            +0.4       10.92        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      8.16            +0.4        8.60        perf-profile.calltrace.cycles-pp.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     13.73            +0.6       14.36        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     13.84            +0.7       14.50        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     23.63 ± 16%      +2.9       26.56        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main.__libc_start_main
     23.63 ± 16%      +2.9       26.56        perf-profile.calltrace.cycles-pp.accept_connections.main.__libc_start_main
     23.63 ± 16%      +2.9       26.56        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     23.63 ± 16%      +2.9       26.56        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main.__libc_start_main
      6.60 ±  3%      -3.6        3.00 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      9.75            -2.6        7.11        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
     16.64            -1.8       14.81        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
     16.77            -1.8       14.94        perf-profile.children.cycles-pp.__sk_mem_schedule
     12.25            -1.4       10.82        perf-profile.children.cycles-pp.tcp_wmem_schedule
     46.67            -1.4       45.29        perf-profile.children.cycles-pp.sock_sendmsg
     44.82            -1.3       43.49        perf-profile.children.cycles-pp.tcp_sendmsg
     50.77            -1.2       49.59        perf-profile.children.cycles-pp.splice_to_socket
     51.05            -1.2       49.88        perf-profile.children.cycles-pp.direct_splice_actor
     39.54            -1.0       38.53        perf-profile.children.cycles-pp.tcp_sendmsg_locked
      1.62 ±  3%      -0.8        0.80 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
     12.44            -0.7       11.73        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     11.91            -0.7       11.21        perf-profile.children.cycles-pp.tcp_rcv_established
      3.49            -0.7        2.81        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
     61.00            -0.6       60.40        perf-profile.children.cycles-pp.splice_direct_to_actor
     61.22            -0.6       60.62        perf-profile.children.cycles-pp.do_splice_direct
     11.68            -0.5       11.21        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     11.72            -0.5       11.25        perf-profile.children.cycles-pp.ip_local_deliver_finish
     12.68            -0.5       12.22        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     11.45            -0.5       10.99        perf-profile.children.cycles-pp.tcp_v4_rcv
     13.08            -0.4       12.64        perf-profile.children.cycles-pp.process_backlog
     13.14            -0.4       12.71        perf-profile.children.cycles-pp.__napi_poll
     14.19            -0.4       13.78        perf-profile.children.cycles-pp.do_softirq
     14.53            -0.4       14.12        perf-profile.children.cycles-pp.__local_bh_enable_ip
     13.38            -0.4       12.98        perf-profile.children.cycles-pp.net_rx_action
     14.06            -0.4       13.67        perf-profile.children.cycles-pp.__do_softirq
     65.51            -0.4       65.12        perf-profile.children.cycles-pp.do_sendfile
     16.79            -0.4       16.41        perf-profile.children.cycles-pp.ip_finish_output2
     19.45            -0.4       19.08        perf-profile.children.cycles-pp.__tcp_transmit_skb
     16.36            -0.4       16.00        perf-profile.children.cycles-pp.__dev_queue_xmit
     17.89            -0.4       17.53        perf-profile.children.cycles-pp.__ip_queue_xmit
      4.16            -0.3        3.83        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      3.67            -0.3        3.33 ±  2%  perf-profile.children.cycles-pp.__release_sock
      4.47            -0.3        4.14 ±  2%  perf-profile.children.cycles-pp.release_sock
     67.14            -0.3       66.81        perf-profile.children.cycles-pp.__x64_sys_sendfile64
      6.84            -0.3        6.52        perf-profile.children.cycles-pp.tcp_data_queue
      3.20            -0.3        2.88        perf-profile.children.cycles-pp.tcp_ack
      2.60            -0.3        2.29        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      7.57            -0.3        7.31        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     95.15            -0.1       95.00        perf-profile.children.cycles-pp.do_syscall_64
     95.61            -0.1       95.48        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.94            -0.1        1.84        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      1.10            -0.1        1.04        perf-profile.children.cycles-pp.ttwu_do_activate
      0.15 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.83            -0.1        0.78        perf-profile.children.cycles-pp.enqueue_task_fair
      0.86            -0.1        0.81        perf-profile.children.cycles-pp.activate_task
      0.43            -0.0        0.39        perf-profile.children.cycles-pp.enqueue_entity
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.iov_iter_bvec
      0.27 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.pick_eevdf
      0.35 ±  2%      -0.0        0.33        perf-profile.children.cycles-pp.prepare_task_switch
      0.16 ±  4%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.74            -0.0        0.72        perf-profile.children.cycles-pp.dequeue_task_fair
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.rb_first
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.tcp_event_data_recv
      0.12 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.tcp_rearm_rto
      0.23 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.16 ±  3%      +0.0        0.18        perf-profile.children.cycles-pp.lock_timer_base
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.validate_xmit_skb
      0.23 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.__slab_free
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.nf_hook_slow
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.do_splice_read
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.netif_skb_features
      0.68            +0.0        0.70        perf-profile.children.cycles-pp.sk_reset_timer
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.__netif_rx
      0.40            +0.0        0.42        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.netif_rx_internal
      0.58            +0.0        0.60        perf-profile.children.cycles-pp.xas_load
      0.30 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.56            +0.0        0.58        perf-profile.children.cycles-pp.kmem_cache_free
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.page_cache_pipe_buf_confirm
      0.24            +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.ip_output
      0.18 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.ip_rcv_core
      0.20            +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      1.04            +0.0        1.06        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.50            +0.0        0.52        perf-profile.children.cycles-pp.__put_user_8
      0.95            +0.0        0.98        perf-profile.children.cycles-pp.loopback_xmit
      0.66            +0.0        0.68        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.72            +0.0        0.75        perf-profile.children.cycles-pp.read_tsc
      0.82            +0.0        0.85        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.86            +0.0        0.89        perf-profile.children.cycles-pp._copy_from_user
      0.90            +0.0        0.94        perf-profile.children.cycles-pp.security_file_permission
      0.57            +0.0        0.61        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.71            +0.0        0.75        perf-profile.children.cycles-pp.netperf_sendfile
      0.77            +0.0        0.81        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.15            +0.0        1.19        perf-profile.children.cycles-pp.tcp_send_mss
      0.90            +0.0        0.95        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.89            +0.0        0.94        perf-profile.children.cycles-pp.__fdget
      0.60            +0.0        0.65        perf-profile.children.cycles-pp.aa_sk_perm
      0.57            +0.0        0.62        perf-profile.children.cycles-pp.current_time
      1.22            +0.0        1.27        perf-profile.children.cycles-pp.skb_release_data
      1.25            +0.1        1.30        perf-profile.children.cycles-pp.__alloc_skb
      0.74            +0.1        0.80        perf-profile.children.cycles-pp.iov_iter_advance
      0.86            +0.1        0.91        perf-profile.children.cycles-pp.skb_attempt_defer_free
      1.18            +0.1        1.23        perf-profile.children.cycles-pp.rw_verify_area
      0.99            +0.1        1.05        perf-profile.children.cycles-pp.page_cache_pipe_buf_release
      1.10            +0.1        1.16 ±  2%  perf-profile.children.cycles-pp.ktime_get
      1.25            +0.1        1.32        perf-profile.children.cycles-pp.__fsnotify_parent
      1.24            +0.1        1.31        perf-profile.children.cycles-pp.check_heap_object
      1.21            +0.1        1.29        perf-profile.children.cycles-pp.release_pages
      1.67            +0.1        1.76        perf-profile.children.cycles-pp.splice_folio_into_pipe
      1.63            +0.1        1.72        perf-profile.children.cycles-pp.skb_append_pagefrags
      1.52            +0.1        1.62        perf-profile.children.cycles-pp.__folio_batch_release
      1.37            +0.1        1.47        perf-profile.children.cycles-pp.atime_needs_update
      1.56            +0.1        1.68        perf-profile.children.cycles-pp.touch_atime
      2.48            +0.1        2.60        perf-profile.children.cycles-pp.filemap_get_read_batch
      1.98            +0.1        2.11        perf-profile.children.cycles-pp.__check_object_size
      1.96            +0.1        2.08        perf-profile.children.cycles-pp.iov_iter_extract_pages
      2.13            +0.1        2.26        perf-profile.children.cycles-pp.simple_copy_to_iter
      2.80            +0.1        2.95        perf-profile.children.cycles-pp.filemap_get_pages
     25.18            +0.2       25.35        perf-profile.children.cycles-pp.inet_recvmsg
     24.74            +0.2       24.91        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     25.32            +0.2       25.49        perf-profile.children.cycles-pp.sock_recvmsg
     25.10            +0.2       25.27        perf-profile.children.cycles-pp.tcp_recvmsg
     26.38            +0.2       26.56        perf-profile.children.cycles-pp.accept_connection
     26.38            +0.2       26.56        perf-profile.children.cycles-pp.accept_connections
     26.38            +0.2       26.56        perf-profile.children.cycles-pp.process_requests
     26.38            +0.2       26.56        perf-profile.children.cycles-pp.spawn_child
     27.00            +0.2       27.18        perf-profile.children.cycles-pp.recv
     25.83            +0.2       26.03        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     25.78            +0.2       25.98        perf-profile.children.cycles-pp.__sys_recvfrom
      5.31            +0.3        5.62        perf-profile.children.cycles-pp.skb_splice_from_iter
     10.52            +0.4       10.96        perf-profile.children.cycles-pp._copy_to_iter
      8.40            +0.5        8.89        perf-profile.children.cycles-pp.filemap_splice_read
     13.82            +0.6       14.47        perf-profile.children.cycles-pp.__skb_datagram_iter
     13.85            +0.7       14.50        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      6.34 ±  3%      -3.6        2.71 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.apparmor_socket_sendmsg
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.iov_iter_bvec
      0.80            -0.0        0.78        perf-profile.self.cycles-pp.sock_sendmsg
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.11 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.enqueue_task_fair
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.sk_wait_data
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.release_sock
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.15 ±  5%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.26            -0.0        0.24        perf-profile.self.cycles-pp.refill_stock
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.rb_erase
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.avg_vruntime
      0.61            +0.0        0.63        perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_data_queue
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.22            +0.0        0.24        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.28            +0.0        0.29        perf-profile.self.cycles-pp.direct_splice_actor
      0.21 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.tcp_send_mss
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.do_splice_read
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.net_rx_action
      0.27            +0.0        0.29        perf-profile.self.cycles-pp.rw_verify_area
      0.25            +0.0        0.27        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.20            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.21            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.lock_sock_nested
      0.52            +0.0        0.54        perf-profile.self.cycles-pp.__virt_addr_valid
      0.44            +0.0        0.46        perf-profile.self.cycles-pp.__schedule
      0.48            +0.0        0.50        perf-profile.self.cycles-pp.check_heap_object
      0.33            +0.0        0.35        perf-profile.self.cycles-pp.filemap_get_pages
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.32 ±  2%      +0.0        0.34        perf-profile.self.cycles-pp.page_cache_pipe_buf_confirm
      0.56            +0.0        0.59        perf-profile.self.cycles-pp.sendfile
      0.39            +0.0        0.42        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.47            +0.0        0.50        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.48            +0.0        0.51        perf-profile.self.cycles-pp.__put_user_8
      0.18 ±  4%      +0.0        0.20        perf-profile.self.cycles-pp.ip_rcv_core
      0.24 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.40            +0.0        0.43        perf-profile.self.cycles-pp.current_time
      0.69            +0.0        0.72        perf-profile.self.cycles-pp.sendfile_tcp_stream
      0.68            +0.0        0.72        perf-profile.self.cycles-pp.read_tsc
      0.47            +0.0        0.50        perf-profile.self.cycles-pp.aa_sk_perm
      0.95            +0.0        0.98        perf-profile.self.cycles-pp.skb_release_data
      0.84            +0.0        0.87        perf-profile.self.cycles-pp._copy_from_user
      0.55            +0.0        0.59        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.64            +0.0        0.67        perf-profile.self.cycles-pp.netperf_sendfile
      0.61            +0.0        0.65        perf-profile.self.cycles-pp.__check_object_size
      1.00            +0.0        1.04        perf-profile.self.cycles-pp.tcp_write_xmit
      0.82            +0.0        0.87        perf-profile.self.cycles-pp.__fdget
      0.62            +0.0        0.67        perf-profile.self.cycles-pp.atime_needs_update
      0.68            +0.0        0.73        perf-profile.self.cycles-pp.iov_iter_advance
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_unref_page_list
      0.98            +0.1        1.03        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.95            +0.1        1.00        perf-profile.self.cycles-pp.page_cache_pipe_buf_release
      1.22            +0.1        1.28        perf-profile.self.cycles-pp.__fsnotify_parent
      1.06            +0.1        1.13        perf-profile.self.cycles-pp.release_pages
      1.24            +0.1        1.31        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      1.47            +0.1        1.54        perf-profile.self.cycles-pp.filemap_splice_read
      1.19            +0.1        1.27        perf-profile.self.cycles-pp.iov_iter_extract_pages
      1.58            +0.1        1.67        perf-profile.self.cycles-pp.splice_folio_into_pipe
      1.54            +0.1        1.62        perf-profile.self.cycles-pp.skb_append_pagefrags
      1.85            +0.1        1.95        perf-profile.self.cycles-pp.skb_splice_from_iter
      1.90            +0.1        2.00        perf-profile.self.cycles-pp.filemap_get_read_batch
      2.59            +0.1        2.72        perf-profile.self.cycles-pp.splice_to_socket
      1.17 ±  5%      +0.1        1.32 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
     10.43            +0.4       10.87        perf-profile.self.cycles-pp._copy_to_iter
      7.04            +0.7        7.76 ±  2%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/metamix/stress-ng/60s

commit: 
  67b8bcbaed ("nilfs2: fix data corruption in dsync block recovery for small block sizes")
  9cee7e8ef3 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")

67b8bcbaed477787 9cee7e8ef3e31ca25b40ca52b85 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1356 ±  8%     +21.8%       1652 ± 16%  sched_debug.cfs_rq:/.util_est.max
     20.30 ±  8%      +3.9       24.17 ±  9%  turbostat.PKG_%
   3152098            +4.1%    3281361        stress-ng.metamix.ops
     52508            +4.1%      54686        stress-ng.metamix.ops_per_sec
  15793876            +4.1%   16439912        stress-ng.time.minor_page_faults
    218.90            +1.9%     223.16        stress-ng.time.user_time
 7.965e+08            +4.3%  8.306e+08        proc-vmstat.numa_hit
 7.967e+08            +4.3%  8.307e+08        proc-vmstat.numa_local
 7.935e+08            +4.3%  8.276e+08        proc-vmstat.pgalloc_normal
  16118636            +4.3%   16808308        proc-vmstat.pgfault
 7.933e+08            +4.3%  8.274e+08        proc-vmstat.pgfree
 7.913e+08            +4.3%  8.253e+08        proc-vmstat.unevictable_pgs_culled
      0.04 ± 18%     +69.1%       0.06 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.folio_alloc.__filemap_get_folio
      0.03 ± 86%    +268.9%       0.09 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
      0.03 ±118%    +454.7%       0.18 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.04 ±  9%     +44.9%       0.06 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.07 ± 10%     -51.1%       0.04 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      0.01 ± 63%    +438.3%       0.04 ± 18%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.02 ± 17%     +49.1%       0.03 ± 17%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 13%     +56.5%       0.03 ± 17%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.62 ± 37%     -31.7%       3.84 ± 22%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9.83 ± 52%    +128.3%      22.45 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
     11.49 ± 49%    +144.8%      28.13 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru.alloc_inode.new_inode.ramfs_get_inode
      1.04            -4.9%       0.99        perf-stat.i.MPKI
 2.484e+10            +3.4%  2.569e+10        perf-stat.i.branch-instructions
 1.098e+08            +2.7%  1.127e+08        perf-stat.i.branch-misses
     11.78            -0.5       11.32        perf-stat.i.cache-miss-rate%
 1.123e+09            +2.3%  1.149e+09        perf-stat.i.cache-references
      1.78            -3.4%       1.72        perf-stat.i.cpi
      0.00 ±  4%      -0.0        0.00 ±  7%  perf-stat.i.dTLB-load-miss-rate%
    943921 ±  4%     -10.4%     845743 ±  7%  perf-stat.i.dTLB-load-misses
 3.127e+10            +3.4%  3.232e+10        perf-stat.i.dTLB-loads
 2.362e+10            +4.2%   2.46e+10        perf-stat.i.dTLB-stores
 1.265e+11            +3.5%   1.31e+11        perf-stat.i.instructions
      0.56            +3.5%       0.58        perf-stat.i.ipc
      1262            +3.6%       1308        perf-stat.i.metric.M/sec
     38.08            -1.7       36.37 ±  2%  perf-stat.i.node-load-miss-rate%
   3411848 ±  2%      -6.2%    3199316 ±  2%  perf-stat.i.node-load-misses
   3111347 ±  2%      +3.7%    3226199        perf-stat.i.node-store-misses
      1.05            -4.9%       0.99        perf-stat.overall.MPKI
     11.79            -0.5       11.34        perf-stat.overall.cache-miss-rate%
      1.78            -3.4%       1.72        perf-stat.overall.cpi
      0.00 ±  4%      -0.0        0.00 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.56            +3.5%       0.58        perf-stat.overall.ipc
     37.14 ±  2%      -1.7       35.49 ±  2%  perf-stat.overall.node-load-miss-rate%
 2.442e+10            +3.4%  2.525e+10        perf-stat.ps.branch-instructions
 1.079e+08            +2.7%  1.108e+08        perf-stat.ps.branch-misses
 1.104e+09            +2.3%   1.13e+09        perf-stat.ps.cache-references
    935750 ±  4%     -10.1%     841448 ±  7%  perf-stat.ps.dTLB-load-misses
 3.075e+10            +3.3%  3.178e+10        perf-stat.ps.dTLB-loads
 2.323e+10            +4.1%  2.419e+10        perf-stat.ps.dTLB-stores
 1.244e+11            +3.5%  1.288e+11        perf-stat.ps.instructions
   3354652 ±  2%      -6.2%    3145099 ±  2%  perf-stat.ps.node-load-misses
   3060027 ±  2%      +3.7%    3172859        perf-stat.ps.node-store-misses
 7.565e+12            +3.0%  7.793e+12        perf-stat.total.instructions
     32.38            -0.6       31.75        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
     26.28            -0.6       25.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
     28.78            -0.6       28.18        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.evict.do_unlinkat
     26.40            -0.6       25.80        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.evict
     26.36            -0.6       25.77        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
     28.82            -0.6       28.22        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
     34.84            -0.6       34.30        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write
     32.18            -0.5       31.68        perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.12            -0.5       31.63        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
     32.40            -0.5       31.92        perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     32.41            -0.5       31.93        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     32.41            -0.5       31.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
     32.39            -0.5       31.91        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     32.42            -0.5       31.94        perf-profile.calltrace.cycles-pp.unlink
     40.74            -0.4       40.32        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     24.93            -0.4       24.52        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     25.05            -0.4       24.65        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
     25.02            -0.4       24.62        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
     27.07            -0.4       26.68        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.simple_write_begin
     27.25            -0.4       26.87        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.simple_write_begin.generic_perform_write
     45.36            -0.4       45.01        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.32            -0.3       42.98        perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     47.13            -0.3       46.84        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     47.48            -0.3       47.20        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_metamix
     47.82            -0.3       47.55        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_metamix
     47.95            -0.3       47.68        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.stress_metamix
      4.88            -0.3        4.62        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.simple_write_begin.generic_perform_write
     48.84            -0.2       48.62        perf-profile.calltrace.cycles-pp.write.stress_metamix
      1.62            -0.1        1.49        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.simple_write_begin
      1.46            -0.1        1.34 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.simple_write_begin
      1.52            -0.0        1.50        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.64            -0.0        1.62        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.populate_vma_page_range.__mm_populate
      1.53            -0.0        1.51        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.populate_vma_page_range
      0.68            -0.0        0.65        perf-profile.calltrace.cycles-pp.__file_remove_privs.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      0.57            +0.0        0.59        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.53            +0.0        0.56        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.folio_alloc
      0.78            +0.0        0.81        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.54            +0.0        0.57        perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.__folio_batch_release.truncate_inode_pages_range.evict
      0.73            +0.0        0.76        perf-profile.calltrace.cycles-pp.xas_store.delete_from_page_cache_batch.truncate_inode_pages_range.evict.do_unlinkat
      0.86            +0.0        0.90        perf-profile.calltrace.cycles-pp.find_lock_entries.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      0.84            +0.0        0.88        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.folio_alloc.__filemap_get_folio
      0.80            +0.0        0.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek.stress_metamix
      1.44            +0.0        1.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek.stress_metamix
      1.29            +0.0        1.34        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.folio_alloc.__filemap_get_folio.simple_write_begin
      1.16            +0.1        1.21 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      1.35            +0.1        1.40        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      1.60            +0.1        1.65        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.folio_alloc.__filemap_get_folio.simple_write_begin.generic_perform_write
      0.66 ±  2%      +0.1        0.71        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26            +0.1        1.32 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.54            +0.1        1.60        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.68            +0.1        1.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek.stress_metamix
      1.72            +0.1        1.78        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      3.99            +0.2        4.15        perf-profile.calltrace.cycles-pp.llseek.stress_metamix
      4.40            +0.2        4.58        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.68            +0.3        6.99        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      7.01            +0.3        7.33        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      7.36            +0.3        7.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      7.48            +0.3        7.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      8.40            +0.4        8.80        perf-profile.calltrace.cycles-pp.read.stress_metamix
     62.98            +0.4       63.37        perf-profile.calltrace.cycles-pp.stress_metamix
     53.00            -1.0       51.98        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     52.86            -1.0       51.84        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     52.97            -1.0       51.95        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     32.40            -0.6       31.78        perf-profile.children.cycles-pp.filemap_add_folio
     28.82            -0.6       28.22        perf-profile.children.cycles-pp.__folio_batch_release
     29.09            -0.6       28.51        perf-profile.children.cycles-pp.release_pages
     34.90            -0.5       34.35        perf-profile.children.cycles-pp.__filemap_get_folio
     32.18            -0.5       31.68        perf-profile.children.cycles-pp.evict
     32.14            -0.5       31.65        perf-profile.children.cycles-pp.truncate_inode_pages_range
     32.40            -0.5       31.92        perf-profile.children.cycles-pp.__x64_sys_unlink
     32.42            -0.5       31.94        perf-profile.children.cycles-pp.unlink
     32.39            -0.5       31.91        perf-profile.children.cycles-pp.do_unlinkat
     40.76            -0.4       40.34        perf-profile.children.cycles-pp.simple_write_begin
     28.75            -0.4       28.34        perf-profile.children.cycles-pp.folio_batch_move_lru
     27.27            -0.4       26.89        perf-profile.children.cycles-pp.folio_add_lru
     45.41            -0.4       45.06        perf-profile.children.cycles-pp.generic_file_write_iter
     43.41            -0.3       43.08        perf-profile.children.cycles-pp.generic_perform_write
     93.64            -0.3       93.35        perf-profile.children.cycles-pp.do_syscall_64
     47.22            -0.3       46.93        perf-profile.children.cycles-pp.vfs_write
     47.54            -0.3       47.26        perf-profile.children.cycles-pp.ksys_write
     94.03            -0.3       93.75        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.05            -0.2        4.80        perf-profile.children.cycles-pp.__filemap_add_folio
      1.24 ±  2%      -0.2        1.00 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     49.16            -0.2       48.95        perf-profile.children.cycles-pp.write
      0.49            -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.63            -0.2        0.47 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      2.12            -0.1        1.98 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.68            -0.1        1.54        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.44            -0.0        0.42        perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.23            +0.0        0.24        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.fault_in_readable
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.stress_hash_jenkin
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.39 ±  2%      +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.31            +0.0        0.33        perf-profile.children.cycles-pp.try_charge_memcg
      0.51            +0.0        0.54 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.22 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.atime_needs_update
      0.66            +0.0        0.68        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.58            +0.0        0.60        perf-profile.children.cycles-pp.mmap_region
      0.56            +0.0        0.59        perf-profile.children.cycles-pp.rmqueue
      0.26 ±  4%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.56            +0.0        0.59        perf-profile.children.cycles-pp.free_unref_page_list
      0.49            +0.0        0.52        perf-profile.children.cycles-pp.touch_atime
      0.33 ±  3%      +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.29 ±  5%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.kthread
      0.29 ±  5%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.29 ±  5%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.41            +0.0        0.44        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.42            +0.0        1.45        perf-profile.children.cycles-pp.xas_store
      0.27 ±  3%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.88            +0.0        0.91        perf-profile.children.cycles-pp.get_page_from_freelist
      0.61 ±  2%      +0.0        0.64        perf-profile.children.cycles-pp.stress_metamix_file
      0.37 ±  4%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.87            +0.0        0.91        perf-profile.children.cycles-pp.find_lock_entries
      0.89            +0.0        0.93        perf-profile.children.cycles-pp.simple_write_end
      0.38 ±  4%      +0.0        0.41 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.40 ±  4%      +0.0        0.43 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      1.19            +0.0        1.24        perf-profile.children.cycles-pp.__fsnotify_parent
      1.38            +0.0        1.42        perf-profile.children.cycles-pp.filemap_get_read_batch
      1.17            +0.0        1.22 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      1.34            +0.1        1.39        perf-profile.children.cycles-pp.__alloc_pages
      1.29            +0.1        1.34        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.63            +0.1        1.68        perf-profile.children.cycles-pp.alloc_pages_mpol
      1.28            +0.1        1.34 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.75            +0.1        1.81        perf-profile.children.cycles-pp.folio_alloc
      1.56            +0.1        1.62        perf-profile.children.cycles-pp.filemap_get_pages
      1.65            +0.1        1.72        perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.03            +0.2        4.19        perf-profile.children.cycles-pp.llseek
      4.45            +0.2        4.64        perf-profile.children.cycles-pp.filemap_read
      6.72            +0.3        7.03        perf-profile.children.cycles-pp.vfs_read
      7.05            +0.3        7.37        perf-profile.children.cycles-pp.ksys_read
     62.98            +0.4       63.37        perf-profile.children.cycles-pp.stress_metamix
      8.72            +0.4        9.12        perf-profile.children.cycles-pp.read
     52.86            -1.0       51.84        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.07 ±  2%      -0.3        0.81 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.44            -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.25 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.__filemap_get_folio
      0.20            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.33            +0.0        0.35        perf-profile.self.cycles-pp.stress_hash_jenkin
      0.21            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.49            +0.0        0.51        perf-profile.self.cycles-pp.xas_descend
      0.21 ±  3%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.29 ±  3%      +0.0        0.32        perf-profile.self.cycles-pp.rw_verify_area
      0.65            +0.0        0.68        perf-profile.self.cycles-pp.llseek
      0.51            +0.0        0.54        perf-profile.self.cycles-pp.stress_metamix_file
      0.75            +0.0        0.78        perf-profile.self.cycles-pp.vfs_read
      0.81            +0.0        0.84        perf-profile.self.cycles-pp.filemap_read
      0.71            +0.0        0.74        perf-profile.self.cycles-pp.find_lock_entries
      0.40            +0.0        0.43 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.72            +0.0        0.75        perf-profile.self.cycles-pp.do_syscall_64
      0.77            +0.0        0.80        perf-profile.self.cycles-pp.release_pages
      0.88            +0.0        0.92        perf-profile.self.cycles-pp.lru_add_fn
      0.80            +0.0        0.84        perf-profile.self.cycles-pp.vfs_write
      1.00            +0.0        1.04        perf-profile.self.cycles-pp.filemap_get_read_batch
      1.14            +0.0        1.19        perf-profile.self.cycles-pp.__fsnotify_parent
      1.15            +0.0        1.20 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      1.25            +0.1        1.30        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/128G/lkp-cpl-4sp2/truncate/vm-scalability

commit: 
  67b8bcbaed ("nilfs2: fix data corruption in dsync block recovery for small block sizes")
  9cee7e8ef3 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")

67b8bcbaed477787 9cee7e8ef3e31ca25b40ca52b85 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.129e+08 ±  2%     +42.0%  7.286e+08 ±  2%  vm-scalability.median
 5.129e+08 ±  2%     +42.0%  7.286e+08 ±  2%  vm-scalability.throughput
      3842 ±  9%     -23.4%       2943 ±  2%  vm-scalability.time.involuntary_context_switches
    251.17 ±  3%     -20.2%     200.50 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
    544.92 ±  2%     -20.3%     434.06 ±  4%  vm-scalability.time.system_time
      1.17 ±  2%      -0.2        0.94 ±  4%  mpstat.cpu.all.sys%
     55.67 ± 10%     -21.6%      43.67 ± 11%  perf-c2c.DRAM.remote
      4.50           +10.4%       4.97 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.50           +10.4%       4.97 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     80.83           -10.1%      72.67 ±  2%  turbostat.Avg_MHz
      2.13            -0.2        1.91        turbostat.Busy%
  18971204 ± 24%     +52.8%   28988952 ± 23%  numa-meminfo.node0.MemFree
  16667888 ± 47%     +77.3%   29546741 ± 14%  numa-meminfo.node2.Inactive
  16530544 ± 47%     +77.9%   29415298 ± 15%  numa-meminfo.node2.Inactive(file)
  32514972 ± 26%     -40.4%   19367348 ± 21%  numa-meminfo.node3.FilePages
  31946066 ± 27%     -39.6%   19280221 ± 22%  numa-meminfo.node3.Inactive
  31785044 ± 27%     -39.8%   19134640 ± 22%  numa-meminfo.node3.Inactive(file)
  16347998 ± 52%     +80.4%   29486790 ± 14%  numa-meminfo.node3.MemFree
  33131649 ± 26%     -39.7%   19992857 ± 20%  numa-meminfo.node3.MemUsed
    359118 ± 41%    +115.0%     772100 ± 51%  numa-numastat.node1.local_node
    431596 ± 35%    +101.6%     869942 ± 44%  numa-numastat.node1.numa_hit
    906620 ± 16%     -42.5%     521019 ± 58%  numa-numastat.node1.numa_miss
    977834 ± 15%     -36.7%     619153 ± 50%  numa-numastat.node1.other_node
    836149 ± 40%     -70.2%     248916 ± 56%  numa-numastat.node3.local_node
   1689066 ± 62%     -86.6%     225607 ±118%  numa-numastat.node3.numa_foreign
    942394 ± 36%     -62.7%     351650 ± 40%  numa-numastat.node3.numa_hit
    415036 ± 83%    +113.8%     887345 ± 15%  numa-numastat.node3.numa_miss
    521278 ± 65%     +90.1%     990792 ± 14%  numa-numastat.node3.other_node
      0.69 ± 53%      +0.5        1.15 ± 18%  perf-profile.calltrace.cycles-pp.trigger_load_balance.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.08 ± 16%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.13 ± 13%      +0.1        0.18 ± 17%  perf-profile.children.cycles-pp.get_cpu_device
      0.26 ± 15%      +0.1        0.33 ±  8%  perf-profile.children.cycles-pp.rcu_core
      0.21 ± 11%      +0.1        0.29 ±  7%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.76 ± 35%      +0.4        1.16 ± 17%  perf-profile.children.cycles-pp.trigger_load_balance
      0.08 ± 16%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.13 ± 13%      +0.1        0.18 ± 17%  perf-profile.self.cycles-pp.get_cpu_device
      0.75 ± 35%      +0.4        1.15 ± 18%  perf-profile.self.cycles-pp.trigger_load_balance
 1.512e+10            -8.3%  1.387e+10 ±  3%  perf-stat.i.cpu-cycles
   2609319            -2.8%    2535671        perf-stat.i.iTLB-loads
      0.07            -8.1%       0.06 ±  3%  perf-stat.i.metric.GHz
      4.78            -7.9%       4.40 ±  3%  perf-stat.overall.cpi
    168.84            -8.4%     154.73 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.21            +8.6%       0.23 ±  3%  perf-stat.overall.ipc
 5.544e+08            -1.1%  5.484e+08        perf-stat.ps.branch-instructions
  1.51e+10            -8.6%  1.381e+10 ±  3%  perf-stat.ps.cpu-cycles
   2596703            -2.8%    2523269        perf-stat.ps.iTLB-loads
   4744339 ± 24%     +52.7%    7243893 ± 24%  numa-vmstat.node0.nr_free_pages
    431693 ± 35%    +101.6%     870245 ± 44%  numa-vmstat.node1.numa_hit
    359215 ± 41%    +115.0%     772404 ± 51%  numa-vmstat.node1.numa_local
    906620 ± 16%     -42.5%     521065 ± 58%  numa-vmstat.node1.numa_miss
    977834 ± 15%     -36.7%     619199 ± 50%  numa-vmstat.node1.numa_other
   4134651 ± 47%     +78.1%    7362301 ± 14%  numa-vmstat.node2.nr_inactive_file
   4134668 ± 47%     +78.1%    7362321 ± 14%  numa-vmstat.node2.nr_zone_inactive_file
   8128688 ± 26%     -40.4%    4844440 ± 21%  numa-vmstat.node3.nr_file_pages
   4087062 ± 52%     +80.3%    7369033 ± 13%  numa-vmstat.node3.nr_free_pages
   7946196 ± 27%     -39.8%    4786206 ± 22%  numa-vmstat.node3.nr_inactive_file
   7946213 ± 27%     -39.8%    4786223 ± 22%  numa-vmstat.node3.nr_zone_inactive_file
   1689066 ± 62%     -86.6%     225607 ±118%  numa-vmstat.node3.numa_foreign
    942361 ± 36%     -62.6%     352113 ± 40%  numa-vmstat.node3.numa_hit
    836116 ± 40%     -70.2%     249379 ± 56%  numa-vmstat.node3.numa_local
    415036 ± 83%    +113.9%     887836 ± 15%  numa-vmstat.node3.numa_miss
    521278 ± 65%     +90.2%     991283 ± 14%  numa-vmstat.node3.numa_other
     72.96 ± 68%     -72.8%      19.85 ± 66%  numa-vmstat.node3.workingset_nodes



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/fallocate1/will-it-scale

commit: 
  67b8bcbaed ("nilfs2: fix data corruption in dsync block recovery for small block sizes")
  9cee7e8ef3 ("mm: memcg: optimize parent iteration in memcg_rstat_updated()")

67b8bcbaed477787 9cee7e8ef3e31ca25b40ca52b85 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.07 ±  2%      +0.0        0.09 ±  2%  mpstat.cpu.all.usr%
      2980 ±  8%    +320.7%      12537 ±105%  numa-meminfo.node0.Mapped
      3605           +25.4%       4522        vmstat.system.cs
    276.17 ± 16%     -44.2%     154.00 ± 15%  perf-c2c.DRAM.local
      3338 ±  3%     -31.1%       2300 ±  3%  perf-c2c.DRAM.remote
      0.02           +50.0%       0.03        turbostat.IPC
      9174 ± 22%     -62.1%       3476 ± 26%  turbostat.POLL
     19.05            -2.6%      18.56        turbostat.RAMWatt
   2492160           +54.9%    3861385        will-it-scale.112.threads
     22251           +54.9%      34476        will-it-scale.per_thread_ops
   2492160           +54.9%    3861385        will-it-scale.workload
   5794888 ±  5%     -14.7%    4940830 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   5794888 ±  5%     -14.7%    4940829 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
     14.21 ±  5%     +34.6%      19.12 ± 12%  sched_debug.cpu.clock.stddev
      3677           +14.2%       4198 ±  5%  sched_debug.cpu.nr_switches.avg
     41405            +7.3%      44427        proc-vmstat.nr_slab_reclaimable
 1.499e+09           +55.1%  2.325e+09        proc-vmstat.numa_hit
 1.498e+09           +55.1%  2.324e+09        proc-vmstat.numa_local
    100185            -3.4%      96743 ±  2%  proc-vmstat.pgactivate
 1.499e+09           +55.0%  2.324e+09        proc-vmstat.pgalloc_normal
 1.499e+09           +55.0%  2.324e+09        proc-vmstat.pgfree
 3.466e+08 ±  2%     +40.2%  4.861e+08 ± 14%  numa-numastat.node0.local_node
 3.468e+08 ±  2%     +40.2%  4.863e+08 ± 14%  numa-numastat.node0.numa_hit
 3.825e+08 ±  2%     +60.6%  6.142e+08 ±  2%  numa-numastat.node1.local_node
 3.827e+08 ±  2%     +60.5%  6.144e+08 ±  2%  numa-numastat.node1.numa_hit
 3.831e+08 ±  2%     +62.1%   6.21e+08 ±  2%  numa-numastat.node2.local_node
 3.832e+08 ±  2%     +62.1%  6.212e+08 ±  2%  numa-numastat.node2.numa_hit
 3.858e+08 ±  2%     +56.2%  6.026e+08 ± 11%  numa-numastat.node3.local_node
  3.86e+08 ±  2%     +56.2%  6.027e+08 ± 11%  numa-numastat.node3.numa_hit
 3.468e+08 ±  2%     +40.2%  4.863e+08 ± 14%  numa-vmstat.node0.numa_hit
 3.467e+08 ±  2%     +40.2%   4.86e+08 ± 14%  numa-vmstat.node0.numa_local
 3.828e+08 ±  2%     +60.5%  6.144e+08 ±  2%  numa-vmstat.node1.numa_hit
 3.826e+08 ±  2%     +60.5%  6.142e+08 ±  2%  numa-vmstat.node1.numa_local
 3.833e+08 ±  2%     +62.1%  6.212e+08 ±  2%  numa-vmstat.node2.numa_hit
 3.832e+08 ±  2%     +62.1%   6.21e+08 ±  2%  numa-vmstat.node2.numa_local
 3.861e+08 ±  2%     +56.1%  6.027e+08 ± 11%  numa-vmstat.node3.numa_hit
 3.858e+08 ±  2%     +56.2%  6.026e+08 ± 11%  numa-vmstat.node3.numa_local
      0.02 ± 57%    +149.5%       0.04 ± 58%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±  6%     +29.7%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 17%     +56.2%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01 ± 26%     +91.4%       0.02 ± 28%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 19%     +78.2%       0.03 ± 16%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 25%     +87.9%       0.03 ± 22%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    168.11           -21.1%     132.56 ±  3%  perf-sched.total_wait_and_delay.average.ms
     13857 ±  4%     +29.3%      17912 ±  2%  perf-sched.total_wait_and_delay.count.ms
    167.97           -21.2%     132.44 ±  3%  perf-sched.total_wait_time.average.ms
     65.81 ± 18%     +35.1%      88.88 ± 15%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    423.14           -37.1%     266.13 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1078 ±  7%     +31.1%       1413 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1012 ±  8%    +149.3%       2523 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1361 ±  8%     +23.1%       1675 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      3600 ±  4%     +61.1%       5799 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 13%     +78.4%       0.36 ±  7%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.20 ± 15%    +102.4%       0.41 ± 21%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.23 ± 25%     +58.8%       0.36 ±  7%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     29.38 ±  8%    +562.6%     194.68 ±185%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.95 ±  8%     +17.7%       4.65 ±  6%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.55 ±  5%     +15.4%       1.79 ±  3%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    423.12           -37.1%     266.12 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.57 ±  7%     +16.2%       1.82 ±  4%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.20 ± 13%     +78.4%       0.36 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.20 ± 15%    +102.4%       0.41 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.23 ± 25%     +58.8%       0.36 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      3.11 ±  5%     +15.4%       3.59 ±  3%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     29.38 ±  8%    +562.7%     194.68 ±185%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.14 ±  7%     +16.1%       3.65 ±  4%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      5.05 ±  3%     -47.5%       2.65        perf-stat.i.MPKI
 6.255e+09           +33.9%  8.375e+09        perf-stat.i.branch-instructions
      0.37 ±  2%      +0.0        0.39        perf-stat.i.branch-miss-rate%
  23190779           +41.9%   32908628        perf-stat.i.branch-misses
     32.92            -4.9       28.01        perf-stat.i.cache-miss-rate%
 1.497e+08 ±  2%     -28.1%  1.076e+08        perf-stat.i.cache-misses
 4.548e+08           -15.6%  3.837e+08        perf-stat.i.cache-references
      3482           +26.6%       4408        perf-stat.i.context-switches
     14.39           -27.0%      10.50        perf-stat.i.cpi
    262.60            +0.9%     265.06        perf-stat.i.cpu-migrations
      2854 ±  2%     +39.0%       3968        perf-stat.i.cycles-between-cache-misses
 7.783e+09           +36.5%  1.062e+10        perf-stat.i.dTLB-loads
 3.804e+09           +51.9%  5.779e+09        perf-stat.i.dTLB-stores
     80.49            +4.8       85.30        perf-stat.i.iTLB-load-miss-rate%
  10924802           +41.4%   15443362        perf-stat.i.iTLB-load-misses
 2.972e+10           +36.5%  4.057e+10        perf-stat.i.instructions
      2749 ±  2%      -4.1%       2636        perf-stat.i.instructions-per-iTLB-miss
      0.07           +37.2%       0.10        perf-stat.i.ipc
    120.11           -21.3%      94.54 ±  5%  perf-stat.i.metric.K/sec
     81.63           +37.5%     112.27        perf-stat.i.metric.M/sec
  20471399           -31.0%   14134700 ±  2%  perf-stat.i.node-load-misses
   1500875 ± 19%     -44.9%     827495 ± 10%  perf-stat.i.node-loads
   2312406           +29.6%    2997675        perf-stat.i.node-store-misses
      5.04 ±  3%     -47.3%       2.65        perf-stat.overall.MPKI
      0.37 ±  2%      +0.0        0.39        perf-stat.overall.branch-miss-rate%
     32.90            -4.9       28.04        perf-stat.overall.cache-miss-rate%
     14.37           -26.9%      10.50        perf-stat.overall.cpi
      2854 ±  2%     +38.7%       3958        perf-stat.overall.cycles-between-cache-misses
      0.00 ± 12%      -0.0        0.00 ± 11%  perf-stat.overall.dTLB-store-miss-rate%
     80.63            +4.8       85.46        perf-stat.overall.iTLB-load-miss-rate%
      0.07           +36.8%       0.10        perf-stat.overall.ipc
   3580231           -11.7%    3162678        perf-stat.overall.path-length
 6.232e+09           +33.9%  8.346e+09        perf-stat.ps.branch-instructions
  23162804           +41.7%   32833133        perf-stat.ps.branch-misses
 1.491e+08 ±  2%     -28.1%  1.072e+08        perf-stat.ps.cache-misses
 4.532e+08           -15.6%  3.825e+08        perf-stat.ps.cache-references
      3470           +26.6%       4393        perf-stat.ps.context-switches
 7.754e+09           +36.5%  1.059e+10        perf-stat.ps.dTLB-loads
 3.789e+09           +52.0%  5.758e+09        perf-stat.ps.dTLB-stores
  10884687           +41.4%   15387479        perf-stat.ps.iTLB-load-misses
 2.962e+10           +36.5%  4.043e+10        perf-stat.ps.instructions
  20394582           -30.9%   14085516 ±  2%  perf-stat.ps.node-load-misses
   1497500 ± 19%     -44.8%     827353 ± 10%  perf-stat.ps.node-loads
   2303483           +29.7%    2986868        perf-stat.ps.node-store-misses
 8.923e+12           +36.9%  1.221e+13        perf-stat.total.instructions
     21.45 ±  4%      -7.9       13.52 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
     21.47 ±  4%      -7.9       13.55 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range
     21.49 ±  4%      -7.9       13.58 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
     21.70 ±  8%      -6.8       14.87 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     21.72 ±  8%      -6.8       14.90 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
     21.74 ±  8%      -6.8       14.93 ±  5%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     23.54 ±  7%      -6.7       16.85 ±  4%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     23.59 ±  7%      -6.7       16.90 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     30.62 ±  2%      -5.5       25.14        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate
     30.63 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     30.63 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     30.63 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     30.62 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     30.62 ±  2%      -5.5       25.15        perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64
     30.63 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.ftruncate64
     30.62 ±  2%      -5.5       25.16        perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.52 ±  2%      -5.2       21.36        perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     25.28 ±  2%      -4.8       20.46        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      4.03 ±  4%      -1.0        3.02 ±  5%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.56 ±  5%      -0.7        0.82 ±  9%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      4.99 ±  3%      -0.7        4.32 ±  3%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      3.02            -0.6        2.37 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      5.21 ±  3%      -0.6        4.65 ±  3%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      3.64 ±  2%      -0.5        3.09 ±  5%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      3.64 ±  2%      -0.5        3.10 ±  5%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      3.77 ±  2%      -0.5        3.31 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      3.86            -0.4        3.43 ±  4%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      3.94            -0.4        3.56 ±  4%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      1.19 ±  3%      -0.3        0.86 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      1.19 ±  3%      -0.3        0.86 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      1.19 ±  3%      -0.3        0.86 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.21 ±  3%      -0.3        0.88 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      1.21 ±  3%      -0.3        0.88 ±  2%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      0.93            -0.2        0.68        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.42            -0.2        1.26 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +0.6        0.57 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release
      1.02 ±  6%      +0.8        1.80        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range
      1.62 ± 12%      +2.5        4.07 ±  4%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range
      2.64 ±  9%      +3.2        5.87 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      6.40 ± 10%      +3.4        9.84 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     48.46            +4.9       53.38        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
     48.53            +5.0       53.48        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     48.72            +5.1       53.78        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.77            +5.1       53.84        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     48.81            +5.1       53.91        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     48.83            +5.1       53.94        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     48.84            +5.1       53.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     48.90            +5.1       54.05        perf-profile.calltrace.cycles-pp.fallocate64
      6.97 ± 11%      +6.2       13.17 ±  4%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     19.24 ± 11%     +12.0       31.20 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     44.41 ±  5%     -15.1       29.28 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     44.43 ±  5%     -15.1       29.34 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     44.47 ±  5%     -15.1       29.39 ±  3%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     24.81 ±  7%      -7.1       17.76 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
     23.62 ±  7%      -6.7       16.92 ±  4%  perf-profile.children.cycles-pp.folio_add_lru
     30.63 ±  2%      -5.5       25.16        perf-profile.children.cycles-pp.do_sys_ftruncate
     30.62 ±  2%      -5.5       25.15        perf-profile.children.cycles-pp.shmem_undo_range
     30.62 ±  2%      -5.5       25.16        perf-profile.children.cycles-pp.do_truncate
     30.62 ±  2%      -5.5       25.15        perf-profile.children.cycles-pp.shmem_setattr
     30.62 ±  2%      -5.5       25.16        perf-profile.children.cycles-pp.notify_change
     30.63 ±  2%      -5.5       25.16        perf-profile.children.cycles-pp.ftruncate64
     26.52 ±  2%      -5.2       21.36        perf-profile.children.cycles-pp.__folio_batch_release
     25.35 ±  2%      -4.8       20.54        perf-profile.children.cycles-pp.release_pages
      9.44            -2.1        7.38 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      8.64 ±  2%      -1.2        7.42 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.76 ±  5%      -0.7        1.05 ±  7%  perf-profile.children.cycles-pp.__count_memcg_events
      5.23 ±  3%      -0.6        4.67 ±  3%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      3.65 ±  2%      -0.5        3.10 ±  5%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      3.78 ±  2%      -0.5        3.31 ±  4%  perf-profile.children.cycles-pp.__filemap_remove_folio
      3.86 ±  2%      -0.4        3.44 ±  4%  perf-profile.children.cycles-pp.filemap_remove_folio
      3.94            -0.4        3.56 ±  4%  perf-profile.children.cycles-pp.truncate_inode_folio
      1.22 ±  3%      -0.3        0.88 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.06 ± 13%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_alloc
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.05 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.06 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ± 11%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.xas_create
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__do_softirq
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.07 ±  7%      +0.0        0.10        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.06 ±  7%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_core
      0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      0.03 ±100%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__memcg_slab_pre_alloc_hook
      0.09 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.02 ± 99%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.10 ±  4%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.shmem_recalc_inode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_init_marks
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.memcg_check_events
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.filemap_get_entry
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.xas_descend
      0.13 ±  4%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.10 ±  4%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.folio_unlock
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xas_clear_mark
      0.22 ±  5%      +0.1        0.28 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.14 ±  2%      +0.1        0.22        perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.15 ±  3%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      0.10 ±  5%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.17 ±  2%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.18 ±  7%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.18 ±  2%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.13 ±  3%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.20 ±  2%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.41 ±  4%      +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      1.02 ±  6%      +0.8        1.80        perf-profile.children.cycles-pp.uncharge_batch
      1.62 ± 12%      +2.5        4.07 ±  4%  perf-profile.children.cycles-pp.uncharge_folio
      2.64 ±  9%      +3.2        5.87 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      6.42 ± 10%      +3.4        9.85 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     48.51            +4.9       53.42        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     48.58            +4.9       53.53        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     48.72            +5.1       53.78        perf-profile.children.cycles-pp.shmem_fallocate
     48.77            +5.1       53.85        perf-profile.children.cycles-pp.vfs_fallocate
     48.81            +5.1       53.91        perf-profile.children.cycles-pp.__x64_sys_fallocate
     48.93            +5.2       54.08        perf-profile.children.cycles-pp.fallocate64
      6.98 ± 11%      +6.2       13.18 ±  4%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
     19.26 ± 11%     +12.0       31.22 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_charge
     44.41 ±  5%     -15.1       29.28 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      9.40            -2.1        7.32 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.75 ±  5%      -0.7        1.04 ±  7%  perf-profile.self.cycles-pp.__count_memcg_events
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.shmem_fallocate
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.06 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.xas_store
      0.02 ± 99%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.11 ±  5%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.find_lock_entries
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.10 ±  3%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.fallocate64
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.folio_unlock
      0.08 ±  5%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.xas_clear_mark
      0.01 ±223%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.13            +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.07        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.21 ±  5%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.10 ±  5%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.lru_add_fn
      0.09 ±  4%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.22 ±  4%      +0.1        0.33 ±  5%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.18 ±  2%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.08 ± 36%      +0.1        0.22 ±  9%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.48 ±  4%      +0.4        1.86 ±  9%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.40 ± 11%      +0.6        0.96 ±  3%  perf-profile.self.cycles-pp.uncharge_batch
      5.68 ± 12%      +2.2        7.89 ±  4%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.61 ± 12%      +2.4        4.06 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      4.82 ± 12%      +4.1        8.97 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      6.95 ± 11%      +6.2       13.14 ±  4%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


